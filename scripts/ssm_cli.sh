#!/bin/bash

region=$1
inst_list=$2
role=$3
PARAMETER='{"ExtraVariables":["SSM=True"],"Check":["False"],"PlaybookFile":["'"${role}"'"],"SourceType":["S3"],"SourceInfo":["{\"path\":\"https://s3.amazonaws.com/ansible-code/\"}"]}'

aws ssm send-command \
 --document-name "AWS-ApplyAnsiblePlaybooks" \
 --document-version "1" \
 --parameters ${PARAMETER} \
 --timeout-seconds 600 \
 --max-concurrency "50" \
 --max-errors "0" \
 --region ${region} \
 --targets "Key=instanceids,Values=${inst_list}"
