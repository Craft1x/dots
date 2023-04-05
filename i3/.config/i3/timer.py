#!/usr/bin/env python3

from threading import Thread
import sys, socket
from time import sleep

timer = 0
TIMEOUT_MESSAGE = "Time's up!"


def unix_from(datetime, datetimeFrom):
    unix_timestamp = datetime.timestamp(datetimeFrom) * 1000
    return unix_timestamp


def unix(datetime):
    presentDate = datetime.now()
    return unix_from(datetime, presentDate)


def send(dataStr):
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.connect("/tmp/timersocket")
        s.send(dataStr.encode())
        data = s.recv(1024)
        s.close()
        return data.decode('utf-8')
    except ConnectionRefusedError:
        pass
    return 'no socket'


class ThreadedServer(Thread):
    import os
    from datetime import datetime, timedelta

    def __init__(self):
        global timer
        Thread.__init__(self)

        self.savefile = self.os.environ['HOME'] + "/.config/saved_timer"
        self.s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.s.bind("/tmp/timersocket")
        self.s.listen(1)

        if self.os.path.isfile(self.savefile):
            f = open(self.savefile, 'r')
            input = float(f.read())
            timer = input
            print('read saved', input)
            f.close()

    def run(self):
        global timer

        while True:
            conn, addr = self.s.accept()
            data = conn.recv(1024)
            if data:
                got = data.decode('utf-8')
                got = got.split(' ')
                if got[0] == 'set':
                    val = int(got[1])
                    print('set timer to', val)
                    timer = unix(self.datetime) + val

                    f = open(self.savefile, "w")
                    f.write(str(timer))
                    f.close()

                    conn.send(b'ok')
                if got[0] == 'reset':
                    print('reset')
                    timer = 0

                    try:
                        self.os.remove(self.savefile)
                    except OSError:
                        pass
                    conn.send(b'ok')
                if got[0] == 'get':
                    if timer == 0:
                        conn.send(b'off')
                    elif timer - unix(self.datetime) < 0:
                        conn.send(TIMEOUT_MESSAGE.encode())
                    else:
                        conn.send(str(timer - unix(self.datetime)).encode())
                if got[0] == 'getpretty':
                    if timer == 0:
                        conn.send(b'off')
                    elif timer - unix(self.datetime) < 0:
                        conn.send(TIMEOUT_MESSAGE.encode())
                    else:
                        result = str(timer - unix(self.datetime))
                        if result.replace('.', '', 1).isdigit():
                            result = self.timedelta(milliseconds=(int(float(result) / 1000) * 1000 + 1000))
                            result = str(result).lstrip("00:").lstrip("0:").lstrip("0")
                            if len(result) == 0:
                                result = "0"
                        result = conn.send(result.encode())
            conn.close()


def main(argv):
    global timer

    if len(argv) == 1 and argv[0] == 'get':
        result = send('get')
        print(result)
        return
    if len(argv) == 1 and argv[0] == 'getpretty':
        result = send('getpretty')
        print(result)
        return
    if len(argv) == 2 and argv[0] == 'set':
        timeSet = int(argv[1]) * 1000
        print("setting to", timeSet)
        send('set ' + str(timeSet))
        return
    if len(argv) == 2 and argv[0] == 'sethuman':
        input = argv[1].lstrip("in")

        from datetime import datetime

        if input.lower() == "reset":
            send('reset')
            return

        import dateparser

        parsed = dateparser.parse("in " + input)
        if parsed is not None:
            timeSet = int(unix_from(datetime, parsed) - unix(datetime))
            print("setting to", timeSet)
            send('set ' + str(timeSet))
        return
    if len(argv) == 1 and argv[0] == 'reset':
        print("resetting")
        send('reset')
        return

    from datetime import datetime
    import subprocess
    import os

    try:
        os.remove("/tmp/timersocket")
    except OSError:
        pass

    clientThread = ThreadedServer()
    clientThread.start()

    while 1:
        if timer > 0 and timer - unix(datetime) <= 0:
            timeoutCommand = "dunstify -r 94123 -i ~/.config/sxhkd/icons/timer.svg -u critical".split() \
                             + ["Time's up!",
                                "middle click to snooze"] \
                             + [
                                 "--action=snooze,Snooze"]
            process = subprocess.Popen(timeoutCommand, stdout=subprocess.PIPE)
            output, error = process.communicate()
            result = output.decode("utf-8")
            print(result)
            if result == "2\n":
                main(["reset"])
            if result == "snooze\n":
                main(["set", "60"])
        sleep(1)


if __name__ == "__main__":
    main(sys.argv[1:])
