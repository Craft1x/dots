#!/usr/bin/env python3
import socket,os,threading,sys,datetime
from threading import Thread
from time import sleep
from datetime import datetime, timedelta
import subprocess
import dateparser

timer = 0 
TIMEOUT_MESSAGE="Time's up!"
TIMER_SAVEFILE=os.path.expanduser('~')+"/.config/saved_timer"
TIMEOUT_COMMAND="dunstify -r 94123 -i ~/.config/sxhkd/icons/timer.svg -u critical".split()+ ["Time's up!","middle click to snooze"] + ["--action=snooze,Snooze"]


def unix_from(datetimeFrom):
    unix_timestamp = datetime.timestamp(datetimeFrom) * 1000
    return unix_timestamp

def unix():
    presentDate = datetime.now()
    return unix_from(presentDate)


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

  def __init__(self):
    Thread.__init__(self)
    self.s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    self.s.bind("/tmp/timersocket")
    self.s.listen(1)

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
                timer = unix() + val

                f = open(TIMER_SAVEFILE, "w")
                f.write(str(timer))
                f.close()

                conn.send(b'ok')
            if got[0] == 'reset':
                print('reset')
                timer = 0

                try:
                    os.remove(TIMER_SAVEFILE)
                except OSError:
                    pass
                conn.send(b'ok')
            if got[0] == 'get':
                if timer == 0:
                    conn.send(b'off')
                elif timer - unix() < 0:
                    conn.send(TIMEOUT_MESSAGE.encode())
                else:
                    conn.send(str(timer - unix()).encode())
        conn.close()



def main(argv):
    global timer

    if (len(argv) == 1 and argv[0] == 'get'):
        result = send('get')
        print(result)
        return
    if (len(argv) == 1 and argv[0] == 'getpretty'):
        result = send('get')
        if result.replace('.','',1).isdigit():
            result=timedelta(milliseconds=(int(float(result)/1000)*1000 + 1000))
            result=str(result).lstrip("00:").lstrip("0:").lstrip("0")
            if len(result) ==0:
                result="0"
        print(result)
        return
    if (len(argv) == 2 and argv[0] == 'set'):
        timeSet = int(argv[1]) * 1000
        print("setting to",timeSet)
        send('set '+ str(timeSet))
        return
    if (len(argv) == 2 and argv[0] == 'sethuman'):
        input = argv[1].lstrip("in")

        if input.lower() == "reset":
            send('reset')
            return

        parsed = dateparser.parse("in "+input)
        if parsed != None:
            timeSet = int(unix_from(parsed) - unix())
            print("setting to", timeSet)
            send('set '+ str(timeSet))
        return
    if (len(argv) == 1 and argv[0] == 'reset'):
        print("resetting")
        send('reset')
        return


    try:
        os.remove("/tmp/timersocket")
    except OSError:
        pass

    if os.path.isfile(TIMER_SAVEFILE):
        f = open(TIMER_SAVEFILE, 'r')
        input = float(f.read())
        timer = input
        print('read saved',input)
        f.close()
        

    clientThread = ThreadedServer()
    clientThread.start()
    
    while 1:
        if timer > 0 and timer - unix() <=0:
            process = subprocess.Popen(TIMEOUT_COMMAND, stdout=subprocess.PIPE)
            output, error = process.communicate()
            result = output.decode("utf-8")
            print(result)
            if (result=="2\n"):
                main(["reset"])
            if (result=="snooze\n"):
                main(["set","60"])
        sleep(1)

if __name__ == "__main__":
   main(sys.argv[1:])
