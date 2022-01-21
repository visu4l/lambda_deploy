#!/bin/bash -e

arg=$1

if [ "$#" != "7" ];then
    echo "usage #0 build path function_name file_list common_file_list region"
    exit 1
fi

path=$2
function_name=$3
include_file=$(echo $4 |tr "," "\n")
common_file=$(echo $5 |tr "," "\n")
python_version=$6
region=$7
echo "$path $function_name"

cd $function_name

# package 가 없는 경우가 있어서 zip 순서 변경
zip -9q function.zip lambda_function.py

for file in $include_file;do
    if [ -d "${path}/${file}" ];then
        # 디렉토리인 경우 -r 옵션 필요
        zip -rg function.zip $file
    else
        zip -g function.zip $file
    fi
done

for file in $common_file;do
    # -j : remove junk-path 
    zip -gj ./function.zip ../common/${file}
done

# python package 설치 및 라이브러리 zip에 추가
pip install -r requirements.txt -t ./package
cd package/
zip -rg ../function.zip .
cd ..

aws lambda update-function-code --region ${region} --function-name ${function_name} --zip-file fileb://function.zip

# Clear
rm -rf ./package
rm -rf ./function.zip

echo "[+] Done"
