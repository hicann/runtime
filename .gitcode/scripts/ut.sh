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
set -e

echo ${ut_type}
echo ${TARGET_BRANCH}
echo ${obs_path}

export USE_CCACHE=1
export PATH=/usr/local/ccache/bin:$PATH
export CCACHE_SECONDARY_STORAGE=redis://10.0.0.135:6379
export CCACHE_COMPILERCHECK=content
export CCACHE_SLOPPINESS=include_file_mtime,time_macros,include_file_ctime
export CCACHE_UMASK=002
export CMAKE_CXX_COMPILER_LAUNCHER=/usr/local/ccache/bin/ccache
# export CCACHE_DEBUG=1
# export CCACHE_DEBUG=true
sudo apt update
sudo apt install -y redis-tools
sudo apt install -y libhiredis-dev
sudo apt install libhiredis0.14
redis-cli -h 10.0.0.135 -p 6379 ping && echo "Redis connection OK" || echo "Redis connection FAILED"
/usr/local/ccache/bin/ccache -V
/usr/local/ccache/bin/ccache -z
echo $(grep -E "^VERSION_ID=" /etc/os-release | cut -d'"' -f2)
sudo update-alternatives --set gcc /usr/bin/gcc-14
set +e
gcc --version
source /home/jenkins/Ascend/cann/bin/setenv.bash
if [ "${TARGET_BRANCH}" = "master" ];then
    case "${ut_type}" in
        acl)
            bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        rts_v201)
            bash tests/build_ut.sh --ut=runtime --target=runtime_ut_v201 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_david)
            bash tests/build_ut.sh --ut=runtime --target=runtime_ut_david -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_910b)
            bash tests/build_ut.sh --ut=runtime --target=runtime_ut_910b -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_common)
            bash tests/build_ut.sh --ut=runtime --target=runtime_ut_common -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_c)
            bash tests/build_ut.sh --ut=runtime_c --target=runtime_c_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        platform)
            bash tests/build_ut.sh --ut=platform --target=platform_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        qs)
            bash tests/build_ut.sh --ut=qs --target=queue_schedule_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        aicpusd)
            bash tests/build_ut.sh --ut=aicpusd --target=aicpu_sched_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        tsd)
            bash tests/build_ut.sh --ut=tsd --target=tsd_client_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        mmpa)
            bash tests/build_ut.sh --ut=mmpa --target=mmpa_utest -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            exit 0
            ;;
        dfx_error_manager)
            bash tests/build_ut.sh --ut=error_manager --target=ut_error_manager -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_log)
            bash tests/build_ut.sh --ut=slog --target=slog_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_trace)
            bash tests/build_ut.sh --ut=atrace --target=atrace_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_msprof_part1)
            bash tests/build_ut.sh --ut=msprof --target=msprof_ut_part1 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            coverage_save="true"
            ;;
        dfx_msprof_part2)
            bash tests/build_ut.sh --ut=msprof --target=msprof_ut_part2 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            coverage_save="true"
            ;;
        dfx_adump)
            bash tests/build_ut.sh --ut=adump --target=adump_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        camodel)
            x86_package=cann-runtime_linux-x86_64.run
            wget -nv https://ascend-ci.obs.cn-north-4.myhuaweicloud.com/${obs_path}/${x86_package}
            chmod u+x ./${x86_package}
            sudo chmod 777 /home/jenkins/Ascend
            yes "y" | sudo bash ${x86_package} --full --install-path=/home/jenkins/Ascend
            bash tests/cmodel_test/check_runtime_cmodel_undefined_symbols.sh --product_type=ascend910B1
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            bash tests/cmodel_test/check_runtime_cmodel_undefined_symbols.sh --product_type=ascend950pr_9599
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            exit 0
            ;;
    esac
else
    case "${ut_type}" in
        acl)
            bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        rts)
            bash tests/build_ut.sh --ut=runtime --target=runtime_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        *)
            echo "Skip UT test execution for ${ut_type} on non-master branch"
            exit 0
            ;;
    esac
fi

if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
    echo "run ut fail"
    exit 1
fi
if [ "$ret" -eq 0 ]; then
    if [ "$coverage_save" = "true" ];then
    echo "ut_process=coverage" >> $ATOMGIT_OUTPUT
    else
    echo "ut_process=ut_cov" >> $ATOMGIT_OUTPUT
    fi
fi
exit 0
