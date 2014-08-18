#!/bin/sh

# ------------------------------------------
# 指定したディレクトリ直下の.sqlを実行してcsvに保存
# usaga: 
#    $ sh getdata_dir "Daily"
# ------------------------------------------


# Escape
IFS="
"
# Local settings
BASE_SQL_PATH="$(cd $(dirname $BASH_SOURCE); pwd)/../SQL/"
BASE_OUTPUT_PATH="$(cd $(dirname $BASH_SOURCE); pwd)/../Result/"

# Product settings
USER="webapp"
HOST="rise-manage.gu3.jp"
SWITCH_COMMAND=". switch-manage.sh"

# Variables
extend_path=$1
today=`date +%Y%m%d`
output_path=${BASE_OUTPUT_PATH}${today}/${extend_path}
sql_path=""

# 指定されたSQLのデータをダンプ
function dumpData(){
	file_name=$1
	echo ${file_name}
   	sql="`cat ${sql_path}/${file_name}.sql`"
	ssh ${USER}@${HOST} "${SWITCH_COMMAND}; ./manage.py sql_for_default --sql='${sql}'" > ${output_path}/${today}_${file_name}.csv
}

# 対象SQLファイル名の取得
sql_full_path=${BASE_SQL_PATH}${extend_path}
file_names=()
if  [ -d ${sql_full_path} ] ; then
	for file in `ls ${sql_full_path}`
	do
  		case ${file} in
			*.sql)
	  		file_names+=(`echo $file | sed -e "s/\.sql//"`)
  		esac
	done
	sql_path=${BASE_SQL_PATH}${extend_path}
else
	file_name_extension=${sql_full_path##*/}
	file_name=${file_name_extension%.*}
	file_names+=(${file_name})
	sql_path=${sql_full_path%/*}
	output_path=${output_path%/*}
fi

# データ取得処理実行準備
echo "------------------------------------------"
ssh-add
echo "------------------------------------------"
mkdir -p ${output_path}

# データ取得処理実行
for file_name in "${file_names[@]}"
do
	dumpData $file_name
   	echo "------------------------------------------"
done

echo "done"
