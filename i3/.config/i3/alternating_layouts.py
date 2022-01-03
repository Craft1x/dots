#!/usr/bin/env python3

import getopt
import sys
import os
from i3ipc import Connection, Event
from pynput.mouse import Button, Controller
from pynput.mouse import Listener
from pynput import mouse

blocked = False

def on_click(x, y, button, pressed):
    global last
    global blocked
    if button == Button.right: 
        if pressed == True:
            blocked = True;
        else:
            blocked = False;



def find_parent(i3, window_id):
    """
        Find the parent of a given window id
    """

    def finder(con, parent):
        if con.id == window_id:
            return parent
        for node in con.nodes:
            res = finder(node, con)
            if res:
                return res
        return None

    return finder(i3.get_tree(), None)

def set_layout(i3, e):
    """
        Set the layout/split for the currently
        focused window to either vertical or
        horizontal, depending on its width/height
    """
    global blocked

    if blocked:
        return

    win = i3.get_tree().find_focused()
    parent = find_parent(i3, win.id)

    if (parent and parent.layout != 'tabbed'
           and parent.layout != 'stacked'):

       if win.rect.height > win.rect.width:
           if parent.orientation == 'horizontal':
               i3.command('split v')
       else:
           if parent.orientation == 'vertical':
               i3.command('split h')


def print_help():
    print("Usage: " + sys.argv[0] + " [-p path/to/pid.file]")
    print("")
    print("Options:")
    print("    -p path/to/pid.file   Saves the PID for this program in the filename specified")
    print("")


def main():
    """
    Main function - listen for window focus
        changes and call set_layout when focus
        changes
    """
    opt_list, _ = getopt.getopt(sys.argv[1:], 'hp:')
    pid_file = None
    for opt in opt_list:
        if opt[0] == "-h":
            print_help()
            sys.exit()
        if opt[0] == "-p":
            pid_file = opt[1]

    if pid_file:
        with open(pid_file, 'w') as f:
            f.write(str(os.getpid()))

    global mouse
    listener = mouse.Listener(on_click=on_click)
    listener.start()

    i3 = Connection()
    i3.on(Event.WINDOW_FOCUS, set_layout)
    i3.main()


if __name__ == "__main__":
    main()
