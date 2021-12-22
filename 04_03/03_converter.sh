#!/usr/bin/env python3
import json
import yaml
import sys
import pathlib


def load_config(config_file):
    with open(config_file, "r") as f:
        config = f.read()

    config_dict = dict()
    valid_json = True
    valid_yaml = True

    try:
        config_dict = json.loads(config)
    except:
        valid_json = False
    
    try:
        config_dict = yaml.safe_load(config)
    except:
        valid_yaml = False
    
    if valid_json:
        return "json", config_dict
    elif valid_yaml:
        return "yaml", config_dict
    raise SystemError("Its not JSON or YAML.")
        

def get_path():
    if len(sys.argv) < 2:
        raise FileNotFoundError("You need to provide filename.")
    else:
        return sys.argv[1]

def get_filename(path):
    p = pathlib.Path(path)
    return p.stem

path = get_path()
filename = get_filename(path)

file_type, config_dict = load_config(path)

if file_type == "json":
    with open(f"{filename}.yaml", "w") as f:
        yaml.dump(config_dict, f)
else:
    with open(f"{filename}.json", "w") as f:
        json.dump(config_dict, f)