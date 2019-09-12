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


def execute_git_command(pipe, command, *params):
    p = subprocess.Popen(["git", command, *params], stdout=subprocess.PIPE if pipe else None)
    p.wait()
    return p


def branch_exists(branch):
    if arg_branch is not None:
        p = execute_git_command(True, "ls-remote", "--heads", "origin", branch)
        (out, _) = p.communicate()
        return True if out.decode("utf-8") else False
    else:
        return True


def get_branch(branch):
    if branch is None:
        p = execute_git_command(True, "rev-parse", "--abbrev-ref", "HEAD")
        (out, _) = p.communicate()
        return out.decode("utf-8").strip()
    else:
        return branch


def fetch(branch):
    return execute_git_command(False, "fetch", "origin", branch).returncode


def checkout(branch):
    return execute_git_command(False, "checkout", branch).returncode


def pull():
    return execute_git_command(False, "pull").returncode


def merge(branch):
    return execute_git_command(False, "merge", branch).returncode


def execute_in_valid_paths(path, branch):
    if os.path.exists(os.path.join(path, ".git")):
        print("%s>>>>>>>>>>>>>> %s%s" % (Colour.LIGHT_BLUE, path, Colour.DEFAULT))
        os.chdir(path)
        branch = get_branch(branch)
        if branch_exists(branch):
            if options.command == Command.PULL:
                pull()
            elif options.command == Command.MERGE:
                if fetch(branch) == 0:
                    merge(branch)
        else:
            print("Remote branch '%s' doesn't exist" % branch)


parser = OptionParser(usage="usage: %prog [options] [branch]", version="1.0.0")
parser.add_option("-c", "--command", type="choice", choices=(Command.PULL, Command.MERGE), default=Command.PULL,
                  dest="command")
parser.add_option("-w", "--workdir", default=os.getcwd(), dest="workdir")
(options, args) = parser.parse_args()

arg_branch = None
if len(args) > 0:
    arg_branch = args[0]

if os.path.exists(os.path.join(options.workdir, ".git")):
    execute_in_valid_paths(options.workdir, arg_branch)
else:
    for root, directories, files in os.walk(options.workdir):
        for directory in sorted(directories):
            execute_in_valid_paths(os.path.join(root, directory), arg_branch)
