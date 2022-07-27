#!/usr/bin/env python3

import datetime
import time

def get_timestamp() -> dict:
    return {"timestamp": int(time.time())}

def get_avg() -> dict:
    with open("/proc/loadavg", "r") as f:
        avg = f.read().split()
        la1 = float(avg[0])
        la5 = float(avg[1])
        la15 = float(avg[2])
        return {"la1": la1, "la5": la5, "la15": la15}

def get_mem() -> dict:
    with open("/proc/meminfo", "r") as f:
        mem_total = int(f.readline().split(":")[1].strip()[:-2])
        mem_free = int(f.readline().split(":")[1].strip()[:-2])
        mem_available = int(f.readline().split(":")[1].strip()[:-2])
        return {"mem_total": mem_total, "mem_free": mem_free, "mem_available": mem_available}

def get_all() -> dict:
    return {**get_timestamp(), **get_avg(), **get_mem()}

date = datetime.datetime.today().strftime('%y-%m-%d')
filename = f"{date}-awesome-monitoring.log"

with open(filename, "a") as f:
        f.write(f"{get_all()}\n")
