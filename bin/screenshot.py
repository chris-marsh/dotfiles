#!/usr/bin/env python2
# -*- coding: utf-8 -*-

""" Use in i3wm with:
bindsym --release Print exec --no-startup-id screenshot.py
"""


import os
import optparse
from subprocess import Popen, PIPE
from tempfile import NamedTemporaryFile

SCREENSHOT_UTILITY = '/usr/bin/scrot -s'  # /usr/bin/import
SCREENSHOT_UTILITY_FS = '/usr/bin/scrot'  # /usr/bin/import


def feed_xclipboard(s):
    pipe = Popen("xclip -sel clip", shell=True, stdin=PIPE).stdin
    pipe.write(s)
    pipe.close()


def import_screenshot(options):
    filename = NamedTemporaryFile(
        suffix='.png',
        prefix='screenshot_',
        dir=os.path.expanduser('~/tmp/screenshots'),
        delete=False).name
    if options.full_screen:
        prog = SCREENSHOT_UTILITY_FS
    else:
        prog = SCREENSHOT_UTILITY
    process = Popen(prog + " " + filename, shell=True)
    os.waitpid(process.pid, 0)
    return filename


def post_process(program, screenshot_filename):
    """ Post process via user defined utility. Tried: `pinta` (misses arrows),
    nathive (misses everything, but nice), stopped on app-office/dia """

    process = Popen(program + " " + screenshot_filename, shell=True)
    os.waitpid(process.pid, 0)


if __name__ == '__main__':
    p = optparse.OptionParser()
    p.add_option("--post-process", '-p')
    p.add_option("--full-screen", '-f', action="store_true")
    options, arguments = p.parse_args()

    screenshot = import_screenshot(options)
    feed_xclipboard(screenshot)

    if options.post_process:
        post_process(options.post_process, screenshot)
