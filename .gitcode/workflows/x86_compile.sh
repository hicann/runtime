#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cd "${WORKSPACE}"
echo $(grep -E "^VERSION_ID=" /etc/os-release | cut -d'"' -f2)
if [[ "${task_name}" == *ubuntu24* ]]; then
    sudo update-alternatives --set gcc /usr/bin/gcc-14
    package_name="cann-runtime_linux-x86_64_ubuntu24.run"
else
    rm -rf /home/jenkins/opensource/lib_cache
    ln -s /home/jenkins/opensource/ubuntu20/lib_cache /home/jenkins/opensource/lib_cache
    if [[ -f "/opt/rh/devtoolset-7/enable" ]]; then
        echo "source devtoolset"
        source /opt/rh/devtoolset-7/enable
    fi
    package_name="cann-runtime_linux-x86_64.run"
fi
echo "package_name=${package_name}" >> "$ATOMGIT_OUTPUT"
gcc --version
source /home/jenkins/Ascend/cann/bin/setenv.bash
set +e
bash build.sh --cann_3rd_lib_path="/home/jenkins/opensource" -f "pr_filelist.txt"
ret=$?

# 200 表示跳过编译，属于正常情况
if [ "$ret" -eq 200 ]; then
    echo "not need compile"
    mkdir build_out
    touch build_out/${package_name}
    exit 0
fi
if [ "$ret" -eq 0 ]; then
    compile_package_name=$(ls "${WORKSPACE}/build_out"/*.run 2>/dev/null | head -n1)
    mv "${compile_package_name}" "${WORKSPACE}/build_out/${package_name}"
fi
echo "ret=$ret" >> "$ATOMGIT_OUTPUT"
exit "$ret"