#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set -e
set -o pipefail

echo "smoke_run_file_url=${smoke_run_file_url}"

mkdir -p /home/taskspace && cd /home/taskspace
echo "start run test case, please wait ..."

export ASCEND_GLOBAL_LOG_LEVEL=2
export ASCEND_SLOG_PRINT_TO_STDOUT=0

source /usr/local/Ascend/cann/set_env.sh
echo "1. downaload rttest_data.zip"
wget -nv https://opencann-obs.obs.cn-north-4.myhuaweicloud.com/ci/rttest_data.zip && unzip -q rttest_data.zip
echo "2. download businesscode"

# 安装 runtime 包到 /usr/local/Ascend
wget -nv ${smoke_run_file_url}
filename=$(basename "${smoke_run_file_url}")
set +e
yes "y" | bash ${filename} --full --install-path=/usr/local/Ascend --quiet
path=$(pwd)
source /usr/local/Ascend/cann/set_env.sh
bash scripts/pre-smoking.sh ${path}/rtstest_host 2>&1 | tee -a ./run_test.log
echo "Run all examples success" >> ./run_test.log

# 打包plog
mkdir -p /root/ascend
slog_name="slog.tar.gz"
tar -zcf slog.tar.gz -C /root/ascend log

# upload plog
if python3 /home/upload.py --bucket-name "ascend-ci" --action upload  --local-file "slog.tar.gz" --obs-object-key "${repo_name}/package/${pr_id}/${slog_name}"; then
  echo "::set-output var=plog_url:https://ascend-ci.obs.cn-north-4.myhuaweicloud.com/${repo_name}/package/${pr_id}/slog.tar.gz"
fi

npu-smi info
echo "4. checking test results ..."
date_time=`date +%Y%m%d`"."`date +%H%M%S`
if grep -w -e "Run all examples success" "./run_test.log"; then
    echo "$date_time : run test case success"
else
    echo "$date_time : run test case failed"
    exit 1
fi
