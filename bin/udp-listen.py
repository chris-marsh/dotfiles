#!/usr/bin/python2

import socket
from subprocess import call

UDP_IP = ""
UDP_PORT = 5005

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024)
    # print("received message:", data)
    call(['notify-send', 'weechat', data])
    call(['play', '-q', '~/bin/bing.ogg'])
