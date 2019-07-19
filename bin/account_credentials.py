#! /usr/bin/env python2
# Author: Lorenzo Gaggini
# Version: 0.1
#
# Retrieve accounts info from pass (passwordstore.org)
# to be used in dotfiles instead of clear passwords:
# pass is on the first line, username on the second one.

from subprocess import check_output
import sys
import os


def usage():
    print "Usage: %s get_user|get_pass, account" \
        % (os.path.basename(sys.argv[0]))
    sys.exit(0)


def get_pass(account):
    return check_output("pass mail/" + account, shell=True).splitlines()[0]


def get_user(account):
    return check_output("pass mail/" + account, shell=True).splitlines()[1]


if __name__ == "__main__":
    if len(sys.argv) < 3:
        usage()

    method = sys.argv[1]

    if method == "get_user":
        print get_user(sys.argv[2])
    elif method == "get_pass":
        print get_pass(sys.argv[2])
    else:
        usage()
