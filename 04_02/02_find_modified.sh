#!/usr/bin/env python3
import os


def main():
    '''
        Поиск всех изменённых файлов в локальном git репозитории в текущей папке.
    '''
    path = "~/devops/test_script/"
    bash_command = ["cd " + path, "git status -s"]
    result_os = os.popen(' && '.join(bash_command))
    for result in result_os:
        if "M" in result[:2]:
            print(path + result[3:-1])


if __name__ == '__main__':
    main()