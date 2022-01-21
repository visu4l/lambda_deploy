#!/bin/bash -e

BASEDIR=$(PWD)

function_name="lambda_function_name" # 함수 이름 변경하여 사용하세요
function_region="us-east-1"
include_file="requirements.txt,lambda_function.py" #함수 파일에서 포함될 파일
common_file="db.py,slack.py" # common 디렉토리에서 포함될 파일
python_version="3.8"


read -p "배포 하려는 Function 이름 : [${function_name}] ? " -r
echo    # (optional) move to a new line
if [[ $REPLY = $function_name ]]
then

    cd ..
    /bin/bash deploy.sh build ${BASEDIR} ${function_name} ${include_file} ${common_file} ${python_version} ${function_region}

else
    echo "[+] Cancel."
fi
