#!/usr/bin/env python3
'''
    Поиск всех изменённых файлов в локальном git репозитории в текущей папке.
'''

import os

bash_command = ["cd ~/devops/test_script", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '~/devops/test_script/')
        print(prepare_result)
