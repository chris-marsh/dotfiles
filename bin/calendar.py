#!/usr/bin/python3

import os
import sys
import fcntl
import signal

from PyQt5.QtCore import Qt, QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView

"""
Only allow a single instance of the calendar. If calendar.py is launched but another instance is
already running. The existing instance is killed and this process also ends. This is useful when
launching the app from a key binding. The same key, eg Meta-C, will launch and close calendar.py
"""

if __name__ == '__main__':
    # Create (if it doesn't exist) and open a PID file in the application directory
    app_path = os.path.split(os.path.realpath(__file__))[0]
    pid_filename = app_path + '/calendar.pid'
    pid_file = open(pid_filename, 'a+')

    try:
        # Attempt an exclusive lock on the PID file
        fcntl.lockf(pid_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except IOError:
        # The lock failed, another instance exists. Read its process PID and close it.
        pid_file.seek(0)
        other_pid = int(pid_file.readline())
        os.kill(other_pid, signal.SIGTERM)
    else:
        # Successfully locked the file, write our process PID and continue.
        pid_file.write(str(os.getpid())+'\n')
        pid_file.flush()

        # Start the GUI ...
        app = QApplication(sys.argv)
        calendar_view = QQuickView(QUrl(app_path + '//calendar.qml'))
        root = calendar_view.rootObject()
        root.closeCalendar.connect(QApplication.quit)   # Connect the Qml signal to close the app
        calendar_view.setFlags(Qt.Dialog)               # Set as dialog - helps i3wm to float it
        calendar_view.show()
        sys.exit(app.exec_())
    finally:
        # Clean up the pid file
        if pid_file:
            pid_file.close()
        if os.path.exists(pid_filename):
            os.remove(pid_filename)
