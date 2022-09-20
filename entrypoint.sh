#!/bin/sh -l


access_key=$1
secret_key=$2

aws configure set default.region us-east-1; aws configure set aws_access_key_id $access_key ; aws configure set aws_secret_access_key $secret_key;

if [ $? -eq 0 ]; then
   echo OK
else
   echo FAIL
fi

aws ecr create-repository \
        --repository-name $3

if [ $? -eq 0 ]; then
   repo_uri="$4.dkr.ecr.us-east-1.amazonaws.com/$3"
   echo $repo_uri
else
   echo FAIL
fi


repo_name=$3
echo "::set-output name=repo_uri::$repo_uri"