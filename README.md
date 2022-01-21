# lambda_deploy

AWS lambda for python deploy script
파이썬 Lambda 자동배포 스크립트


## 테스트환경(Test Environment)
 - MacOS 11, 12 
 - zsh

## 전제조건(Precondition)
 - install AWS CLI 
 - AWS CLI [credentials Setup](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/cli-configure-files.html)
 - Credentails 의 사용된 iam에 lambda 권한을 가지고 있어야 합니다.
 - You must have lambda permission on the used iam of Credentails.
 - docker 


## 사용 방법
1. lambda_function_name 디렉토리는 다른이름으로 복사합니다.
    - 예 : send_mail

2. deploy.sh 파일을 열어서 `function_name` 항목을 자신의 function 이름으로 변경합니다.
    - function_name: lambda function 이름 (send_mail)
    - function_region: lambda function 리전
    - include_file : 현재 프로젝트 디렉토리에서 포함될 파일.
    - common_file: common 디렉토리에서 포함될 파일

3. requirements.txt 파일에 현재 함수에서 사용되는 library 작성 (pip install 시 사용되는 이름)

4. lambda_function.py 파일 작성

5. 해당 함수 디렉토리에서 `./deploy.sh` 실행 (쉘 이용)

## How to use

1. Copy lambda_function_name directory to other name
    - ex : send_mail
    

2. Open the deploy.sh file and change the fields to suit your project
    - function_name : Lambda function name
    - function_region : AWS Lambda function region
    - include_file: Files to be included in the current function directory 
    - common_file: Files to be included in the common directory 

3. The library input used by the current function in the requirements.txt file. (name used when pip install)

4. write a lambda_function.py 

5. Run `./deploy.sh` in the function directory (used shell)
