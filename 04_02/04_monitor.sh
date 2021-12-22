#!/usr/bin/env python3
import socket
import time


def monitor():
    '''
        Мониторинг изменения IP адреса на доменном имени.
    '''
    services = {"drive.google.com": "0.0.0.0",
                "mail.google.com": "0.0.0.0",
                "google.com": "0.0.0.0"}
    while True:
        for service in services:
            time.sleep(0.5)
            try:
                ip = socket.gethostbyname(service)
            except OSError as e:
                print(f"\033[31m[EXCEPTION] {e}")
                continue

            if services[service] == ip:
                print("\033[0m", service, "-", ip)
            else:
                print(f"\033[31m[ERROR]\033[0m {service} IP mismatch: {services[service]} {ip}")
                services[service] = ip


if __name__ == '__main__':
    monitor()
