#!/usr/bin/env python2
import pynotify
from pygame import mixer
from time import sleep
def sendmessage(title, message):
    pynotify.init("Test")
    notice = pynotify.Notification(title, message)
    notice.show()
    return
while True:
    mixer.init() #you must initialize the mixer
    alert=mixer.Sound('/usr/lib/libreoffice/share/gallery/sounds/apert2.wav') #name of the sound file is beep.wav
    alert.play()
    sendmessage("ALARM!!", "1 hour up!")
    sleep(3600)
