#!/usr/bin/env python3
import os, sys, subprocess, time

ROOT = os.path.dirname(os.path.abspath(__file__))

def verify():
    p = subprocess.call([sys.executable, os.path.join(ROOT,'tools','integrity_check.py'), '--verify'])
    return p==0

def restore_from_zip(paths):
    for p in paths:
        print('Restoring from', p)
        subprocess.call(['unzip', '-o', p, '-d', ROOT])

def cli_menu():
    while True:
        print('\nServerForge - CLI')
        print('1) Start server (modules/server_manager.sh start)')
        print('2) Stop server (modules/server_manager.sh stop)')
        print('3) Verify integrity')
        print('4) Exit')
        c = input('Choice: ').strip()
        if c=='1':
            subprocess.call(['bash', os.path.join(ROOT,'modules','server_manager.sh'), 'start'])
        elif c=='2':
            subprocess.call(['bash', os.path.join(ROOT,'modules','server_manager.sh'), 'stop'])
        elif c=='3':
            ok = verify()
            print('Verify OK' if ok else 'Verify FAILED')
        else:
            print('bye')
            break

if __name__=='__main__':
    if '--cli' in sys.argv:
        cli_menu()
    else:
        # try webui
        try:
            subprocess.Popen([sys.executable, os.path.join(ROOT,'ui','webapp.py')])
            time.sleep(0.5)
            import webbrowser
            webbrowser.open('http://127.0.0.1:8080')
        except Exception:
            cli_menu()
