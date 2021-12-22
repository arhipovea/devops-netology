#!/usr/bin/env python3
import socket
import time
import json
import yaml


services = {"drive.google.com": "0.0.0.0",
            "mail.google.com": "0.0.0.0",
            "google.com": "0.0.0.0"}
services_list = []
for s in services.items():
    services_list.append({s[0]: s[1]})
with open("ip.json", "w") as js:
    json.dump(services, js)
with open("ip.yml", "w") as yml:
    yaml.dump(services_list, yml)

try:
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
                services_list.remove({service: services[service]})
                
                services[service] = ip
                
                with open("ip.json", "w") as js:
                    json.dump(services, js) 
                
                services_list.append({service: ip})
                with open("ip.yml", "w") as yml:
                    yaml.dump(services_list, yml, default_flow_style=False)    
except KeyboardInterrupt:
    print("Keyboard Interrupt Extension")
