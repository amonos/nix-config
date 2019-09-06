#!/bin/python
import os
import subprocess
from optparse import OptionParser


class Command:
    PULL = "pull"
    MERGE = "merge"


class Colour:
    LIGHT_BLUE = "\033[1;94m"
    DEFAULT = "\033[0m"


def execute_command(path):
    if os.path.exists(os.path.join(path, ".git")):
        print("%s>>>>>>>>>>>>>> %s%s" % (Colour.LIGHT_BLUE, path, Colour.DEFAULT))
        os.chdir(path)

        # Use the current branch if not specified
        if branch is None:
            p = subprocess.Popen(["git", "rev-parse", "--abbrev-ref", "HEAD"], stdout=subprocess.PIPE)
            p.wait()
            (out, _) = p.communicate()
            _branch = out.decode("utf-8").strip()
        else:
            _branch = branch

        # Only check if remote branch exists when the branch name explicitly set
        branch_exists = True
        if branch is not None:
            p = subprocess.Popen(["git", "ls-remote", "--heads", "origin", _branch], stdout=subprocess.PIPE)
            p.wait()
            (out, _) = p.communicate()
            branch_exists = True if out.decode("utf-8") else False

        if branch_exists:
            if options.command == Command.PULL:
                p = subprocess.Popen(["git", "checkout", _branch])
                p.wait()
                if p.returncode == 0:
                    p = subprocess.Popen(["git", Command.PULL])
                    p.wait()
            elif options.command == Command.MERGE:
                p = subprocess.Popen(["git", "fetch", "origin", _branch])
                p.wait()
                if p.returncode == 0:
                    p = subprocess.Popen(["git", Command.MERGE, "origin/%s" % _branch])
                    p.wait()
        else:
            print("Remote branch '%s' doesn't exist" % _branch)


parser = OptionParser(usage="usage: %prog [options] [branch]", version="1.0.0")
parser.add_option("-c", "--command", type="choice", choices=(Command.PULL, Command.MERGE), default=Command.PULL,
                  dest="command")
parser.add_option("-w", "--workdir", default=os.getcwd(), dest="workdir")
(options, args) = parser.parse_args()

branch = None
if len(args) > 0:
    branch = args[0]

if os.path.exists(os.path.join(options.workdir, ".git")):
    execute_command(options.workdir)
else:
    for root, directories, files in os.walk(options.workdir):
        for directory in sorted(directories):
            execute_command(os.path.join(root, directory))
