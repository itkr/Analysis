# -*- coding:utf-8 -*-

"""
 指定したディレクトリ直下の.sqlを実行してcsvに保存
 usaga: 
    $ python getdata_dir.py "Daily"
"""

import os
import sys
import datetime 
import subprocess

BASE_SQL_PATH = os.curdir + "/../SQL"
BASE_OUTPUT_PATH = os.curdir + "/../Test"
USER = "webapp"
HOST = "rise-manage.gu3.jp"
SWITCH_COMMAND = ". switch-manage.sh"

extend_path = sys.argv[1]
today = datetime.datetime.now().strftime('%Y%m%d')
output_path = "/".join([BASE_OUTPUT_PATH, today, extend_path])


def get_file_names():
    file_names = []
    for f in os.listdir("/".join([BASE_SQL_PATH, extend_path])):
        if ".sql" in f: # and os.path.isfile(f):
            file_names.append(f.replace(".sql", ""))
    return file_names


def dump_data(file_name):
    sql_path = "/".join([BASE_SQL_PATH, extend_path, file_name + ".sql"])

#    with open(sql_path) as f:
#        sql = "".join(f)
#    sql = subprocess.Popen('cat "%s"' % sql_path)
#    os.system('cat "%s"' % sql_path)

#    command = "ssh {user}@{host} {switch_command}; ./manage.py sql_for_default --sql='{sql}' > {output_path}/{today}_{file_name}.csv"\
#        .format(user=USER, host=HOST, switch_command=SWITCH_COMMAND, sql=sql, output_path=output_path, today=today, file_name=file_name)

#    os.system(command)


def main():
#    os.system('ssh-add')
#    os.system('mkdir -p {}'.format(output_path))
    print "------------------------------------------"
    for file_name in get_file_names():
        print file_name
        dump_data(file_name)
        print "------------------------------------------"
    print "done"


if __name__ == "__main__":
    main()
