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


parser = OptionParser(usage="usage: %prog [options] [branch]", version="1.0.0")
parser.add_option("-c", "--command", type="choice", choices=(Command.PULL, Command.MERGE), default=Command.PULL,
                  dest="command")
parser.add_option("-w", "--workdir", default=os.getcwd(), dest="workdir")
(options, args) = parser.parse_args()

branch = "master"
if len(args) > 0:
    branch = args[0]

for root, directories, files in os.walk(options.workdir):
    for directory in sorted(directories):
        if os.path.exists(os.path.join(root, directory, ".git")):
            os.chdir(os.path.join(root, directory))
            print("%s>>>>>>>>>>>>>> %s%s" % (Colour.LIGHT_BLUE, directory, Colour.DEFAULT))
            if options.command == Command.PULL:
                p = subprocess.Popen(["git", "checkout", branch])
                p.wait()
                if p.returncode == 0:
                    p = subprocess.Popen(["git", Command.PULL])
                    p.wait()
            elif options.command == Command.MERGE:
                p = subprocess.Popen(["git", "fetch", "origin", branch])
                p.wait()
                if p.returncode == 0:
                    p = subprocess.Popen(["git", Command.MERGE, branch])
                    p.wait()
