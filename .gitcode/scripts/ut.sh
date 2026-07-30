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

echo ${ge_st_rt2}
echo ${TARGET_BRANCH}
echo ${obs_path}

function LOG_DO() {
   local cmd="$*"
   date_time=$(date +%Y%m%d-%H%M%S)
   echo -e "[Command] ${date_time} ${cmd}"
   ${cmd}
}

echo $(grep -E "^VERSION_ID=" /etc/os-release | cut -d'"' -f2)
sudo update-alternatives --set gcc /usr/bin/gcc-14
set +e
gcc --version
source /home/jenkins/Ascend/cann/bin/setenv.bash
if [ "${TARGET_BRANCH}" = "master" ];then
    case "${ge_st_rt2}" in
        acl)
            LOG_DO bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        rts_v201)
            LOG_DO bash tests/build_ut.sh --ut=runtime --target=runtime_ut_v201 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_david)
            LOG_DO bash tests/build_ut.sh --ut=runtime --target=runtime_ut_david -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_910b)
            LOG_DO bash tests/build_ut.sh --ut=runtime --target=runtime_ut_910b -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_common)
            LOG_DO bash tests/build_ut.sh --ut=runtime --target=runtime_ut_common -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource" --ut_timeout=900
            ret=$?
            coverage_save="true"
            ;;
        rts_c)
            LOG_DO bash tests/build_ut.sh --ut=runtime_c --target=runtime_c_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        platform)
            LOG_DO bash tests/build_ut.sh --ut=platform --target=platform_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        qs)
            LOG_DO bash tests/build_ut.sh --ut=qs --target=queue_schedule_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        aicpusd)
            LOG_DO bash tests/build_ut.sh --ut=aicpusd --target=aicpu_sched_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        tsd)
            LOG_DO bash tests/build_ut.sh --ut=tsd --target=tsd_client_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        mmpa)
            LOG_DO bash tests/build_ut.sh --ut=mmpa --target=mmpa_utest -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            exit 0
            ;;
        dfx_error_manager)
            LOG_DO bash tests/build_ut.sh --ut=error_manager --target=ut_error_manager -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_log)
            LOG_DO bash tests/build_ut.sh --ut=slog --target=slog_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_trace)
            LOG_DO bash tests/build_ut.sh --ut=atrace --target=atrace_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        dfx_msprof_part1)
            LOG_DO bash tests/build_ut.sh --ut=msprof --target=msprof_ut_part1 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            coverage_save="true"
            ;;
        dfx_msprof_part2)
            LOG_DO bash tests/build_ut.sh --ut=msprof --target=msprof_ut_part2 -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            coverage_save="true"
            ;;
        dfx_adump)
            LOG_DO bash tests/build_ut.sh --ut=adump --target=adump_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        camodel)
            x86_package=cann-runtime_linux-x86_64.run
            wget -nv https://ascend-ci.obs.cn-north-4.myhuaweicloud.com/${obs_path}/${x86_package}
            chmod u+x ./${x86_package}
            sudo chmod 777 /home/jenkins/Ascend
            yes "y" | sudo bash ${x86_package} --full --install-path=/home/jenkins/Ascend
            LOG_DO bash tests/cmodel_test/check_runtime_cmodel_undefined_symbols.sh --product_type=ascend910B1
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            LOG_DO bash tests/cmodel_test/check_runtime_cmodel_undefined_symbols.sh --product_type=ascend950pr_9599
            ret=$?
            if [ "$ret" -ne 200 ] && [ "$ret" -ne 0 ]; then
                echo "run ut fail"
                exit 1
            fi
            exit 0
            ;;
    esac
else
    case "${ge_st_rt2}" in
        acl)
            LOG_DO bash tests/build_ut.sh --ut=acl --target=ascendcl_utest -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        rts)
            LOG_DO bash tests/build_ut.sh --ut=runtime --target=runtime_ut -c -f "pr_filelist.txt" --cann_3rd_lib_path="/home/jenkins/opensource"
            ret=$?
            ;;
        *)
            LOG_DO echo "Skip UT test execution for ${ge_st_rt2} on non-master branch"
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
