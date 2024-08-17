#!/usr/bin/env python3
from i3ipc import Connection, Event
from time import sleep
import subprocess, pathlib

i3 = Connection()


def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    print(focused.workspace().nodes)

    root = focused.workspace()
    count = 0
    for con in root:
        if con.name is not None:
            count += 1

    ws = focused.workspace().num

    # if ws == 5:
    #     if count > 1:
    #         subprocess.Popen(['.config/i3/gaps.sh', 'default'], cwd=pathlib.Path.home())
    #     else:
    #         subprocess.Popen(['.config/i3/gaps.sh', 'sided'], cwd=pathlib.Path.home())

    # ws_name = "%s:%s" % (focused.workspace().num, focused.window_class)
    # i3.command('rename workspace to "%s"' % ws_name)


i3.on(Event.WINDOW_FOCUS, on_window_focus)

while True:
    i3.main()
    sleep(2)
    print("i3 died, restarting...")
