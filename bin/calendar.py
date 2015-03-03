#!/usr/bin/python

import os
import sys
import fcntl
import signal
import subprocess

from PyQt5.QtCore import Qt, QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView

"""
Only allow a single instance of the calendar. If calendar.py is launched but another instance is
already running. The existing instance is killed and this process also ends. This is useful when
launching the app from a key binding. The same key, eg Meta-C, will launch and close calendar.py
"""


def close_existing_instance():
    p = subprocess.Popen(['pgrep', '-l' , app_file], stdout=subprocess.PIPE)
    out, err = p.communicate()

    for line in out.splitlines():
        line = bytes.decode(line)
        pid = int(line.split(None, 1)[0])
        os.kill(pid, signal.SIGTERM)


if __name__ == '__main__':
    app_path, app_file=os.path.split(os.path.realpath(__file__))
    pid_file_handle = open(app_path+'/calendar.pid', 'w')
    try:
        fcntl.lockf(pid_file_handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except IOError:
        # Failed to exclusively lock the pid file, another instance is running
        close_existing_instance()
    else:
        app = QApplication(sys.argv)
        calendar_view = QQuickView(QUrl(app_path + '//calendar.qml'))
        root = calendar_view.rootObject()
        root.closeCalendar.connect(QApplication.quit)
        calendar_view.setFlags(Qt.Dialog)
        calendar_view.show()

        sys.exit(app.exec_())
