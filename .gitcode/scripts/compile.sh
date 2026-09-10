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

function LOG_DO() {
   local cmd="$*"
   date_time=$(date +%Y%m%d-%H%M%S)
   echo -e "[Command] ${date_time} ${cmd}"
   ${cmd}
}

function DP_ASSERT_CHECK_SKIP() {
    local actual_value=${1}
    local assert_msg=${2}
    if [ "${actual_value}" != "0" ] && [ "${actual_value}" != "200" ]; then
        echo "${assert_msg} is failed."
        exit 1
    else
        echo "${assert_msg} is success."
    fi
}

if [[ "${task_name}" =~ Compile_Ascend_X86_ubuntu24 ]]; then
    echo "api-check=compile" >> "${ATOMGIT_OUTPUT}"
else
    echo "api-check=continue" >> "${ATOMGIT_OUTPUT}"
fi

echo $(grep -E "^VERSION_ID=" /etc/os-release | cut -d'"' -f2)
if [[ "${task_name}" == *ubuntu24* ]]; then
    if sudo update-alternatives --set gcc /usr/bin/gcc-16 2>/dev/null; then
        echo "Switched to gcc-16"
    elif sudo update-alternatives --set gcc /usr/bin/gcc-15 2>/dev/null; then
        echo "Switched to gcc-15"
    elif sudo update-alternatives --set gcc /usr/bin/gcc-14 2>/dev/null; then
        echo "gcc-16/15 not available, fell back to gcc-14"
    fi
    sed -i "1i set(CMAKE_EXPORT_COMPILE_COMMANDS ON)" "CMakeLists.txt"
else
    if [[ -f "/opt/rh/devtoolset-7/enable" ]]; then
        echo "source devtoolset"
        source /opt/rh/devtoolset-7/enable
    fi
fi

if gcc --version | head -n1 | grep -q "15\."; then
    gcc --version
    rm -rf /home/jenkins/opensource/lib_cache
    if [ -d  /home/jenkins/opensource/gcc15 ];then
        rm -rf /home/jenkins/opensource/gcc15/lib_cache/abseil-cpp
        rm -rf /home/jenkins/opensource/gcc15/lib_cache/device/abseil-cpp
        ln -s /home/jenkins/opensource/gcc15/lib_cache /home/jenkins/opensource/lib_cache
    elif [ -d  /home/jenkins/opensource/gcc15x86 ];then
        rm -rf /home/jenkins/opensource/gcc15x86/lib_cache/abseil-cpp
        rm -rf /home/jenkins/opensource/gcc15x86/lib_cache/device/abseil-cpp
        ln -s /home/jenkins/opensource/gcc15x86/lib_cache /home/jenkins/opensource/lib_cache
    fi
elif gcc --version | head -n1 | grep -q "14\."; then
    gcc --version
else
    gcc --version
    rm -rf /home/jenkins/opensource/lib_cache
    ln -s /home/jenkins/opensource/ubuntu20/lib_cache /home/jenkins/opensource/lib_cache
fi

set +e
rm -rf /home/jenkins/opensource/json
source /home/jenkins/Ascend/cann/bin/setenv.bash
LOG_DO bash build.sh --cann_3rd_lib_path="/home/jenkins/opensource" -f "pr_filelist.txt"
BUILD_EXIT_CODE=$?
DP_ASSERT_CHECK_SKIP "${BUILD_EXIT_CODE}" "Build"

# 200 表示跳过编译，属于正常情况
if [ "${BUILD_EXIT_CODE}" -eq 200 ] && ! ls build_out/*.run 1>/dev/null 2>&1; then
    echo "not need compile"
    mkdir build_out
    touch build_out/${package_name}
    echo "api-check=continue" >> "${ATOMGIT_OUTPUT}"
fi
