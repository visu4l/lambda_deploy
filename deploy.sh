#!/bin/bash -e

arg=$1

if [ "$arg" = "make" ];then
    # docker container에서 실행 되는 코드
    apt-get update
    apt-get install zip -y

    # package 가 없는 경우가 있어서 zip 순서 변경
    zip -9q function.zip lambda_function.py

    # zip 파일에 코드 및 데이터 파일 추가
    for entry in *;do
        if [ "$entry" != "requirements.txt" ] && [ "$entry" != "deploy.sh" ] && [ "$entry" != "function.zip" ] && [ "$entry" != "lambda_function.py" ] ;then
            if [ -d "$entry" ];then
                zip -rg function.zip $entry
            else
                zip -g function.zip $entry
            fi
        fi
    done

    # python package 설치
    pip install -r requirements.txt -t ./package
    cd package/

    # 라이브러리만 zip으로 압축
    zip -rg ../function.zip .
    cd ..
    echo "[+] remove package"
    rm -rf package/
    
elif [ "$arg" = "build" ];then
    
    if [ "$#" != "7" ];then
        echo "usage #0 build path function_name file_list common_file_list python_version"
        exit 1
    fi

    path=$2
    function_name=$3
    include_file=$(echo $4 |tr "," "\n")
    common_file=$(echo $5 |tr "," "\n")
    python_version=$6
    region=$7

    if [ -e "tmp/" ];then
        rm -rf tmp/
    fi

    mkdir tmp/

    cp deploy.sh ./tmp/

    for file in $include_file;do
        if [ -d "${path}/${file}" ];then
            # 디렉토리인 경우 -r 옵션 필요
            cp -r ${path}/${file} ./tmp/
        else
            cp ${path}/${file} ./tmp/
        fi
    done

    for file in $common_file;do
        cp ./common/${file} ./tmp/
    done

    cd tmp/
    
    docker run -it --rm --name build_lambda -v $(pwd):/code -w /code python:${python_version} ./deploy.sh make

    aws lambda update-function-code --region ${region} --function-name ${function_name} --zip-file fileb://function.zip

    cd ..

    echo "[+] Done"

fi
