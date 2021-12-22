#!/usr/bin/env python3
import os
import sys


def find_git_modified_files():
    '''
        Поиск всех изменённых файлов в локальном git репозитории по указанному пути.
    '''
    if len(sys.argv) < 2:
        path = "./"
    else:
        path = sys.argv[1]
        if not path.endswith("/"):
            path += "/"
    
    bash_command = ["cd " + path, "git status -s"]
    result_os = os.popen(' && '.join(bash_command))
    
    for result in result_os:
        if "M" in result[:2]:
            print(f"{path}{result[3:-1]}")



if __name__ == '__main__':
    find_git_modified_files()
