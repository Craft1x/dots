#!/usr/bin/env python3

from pynput.keyboard import Key, Listener
import os

def press(key):
    if key == Key.shift:
        f = open("/tmp/shift", "w")
        f.write("")
        f.close()

def release(key):
    if str(key) == "<65034>":
        try:
            os.remove("/tmp/shift")
        except OSError:
            pass

with Listener(on_press = press, on_release = release) as listener:
    listener.join()
