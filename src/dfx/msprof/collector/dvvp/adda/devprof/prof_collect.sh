#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

OPTIONS="${1}"
SUCCESS=0
ERROR=1
RESULT=${ERROR}

function perf_version()
{
    /usr/bin/perf --version
    return $?
}

function kill_perf()
{
    if [[ -e /usr/sbin/pkill ]]; then
        /usr/sbin/pkill -2 perf
    elif [[ -e /usr/bin/pkill ]]; then
        /usr/bin/pkill -2 perf
    fi
    return $?
}

function check_realpath()
{
    local real_file=$(realpath "${1}")
    if [ "${real_file}" == "${1}" ]; then
        return ${SUCCESS}
    elif [ "${real_file}" == "/home${1}" ]; then # mdc data path
        return ${SUCCESS}
    fi

    return ${ERROR}
}

function check_script_info()
{
    local script_data_template="^/var/log/npu/profiling/[[0-9]|[[1-5][0-9]]|[6[0-4]]]/ai_ctrl_cpu.data.[[0-9]|[[1-5][0-9]]|[6[0-4]]].[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$"
    local ret=$(echo ${1} | grep -E ${script_data_template})
    if [[ ${ret} != ${1} ]]; then
        return ${ERROR}
    fi

    return ${SUCCESS}
}

function perf_script()
{
    check_realpath "${1}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi

    check_script_info "${1}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi
    /usr/bin/perf script -F comm,pid,tid,cpu,time,period,event,ip,sym,dso,symoff -i ${1} --show-kernel-path -f
    return ${SUCCESS}
}

function check_spacial_symbol()
{
    local space_count=$(echo ${1} | grep -o [[:space:]] | wc -l)
    local line_count=$(echo ${1} | grep -o "-" | wc -l)
    if [[ line_count -ne 0 ]] || [[ space_count -ne 0 ]]; then
        return ${ERROR}
    fi

    return ${SUCCESS}
}

function check_record_info()
{
    local record_data_template="^/var/log/npu/profiling/[[0-9]|[[1-5][0-9]]|[6[0-4]]]/ai_ctrl_cpu.data.[[0-9]|[[1-5][0-9]]|[6[0-4]]]$"
    local ret=$(echo ${1} | grep -E ${record_data_template})
    if [[ ${ret} != ${1} ]]; then
        return ${ERROR}
    fi

    check_spacial_symbol "${2}"
    if [[ $? -ne 0 ]]; then
        return ${ERROR}
    fi

    check_spacial_symbol "${3}"
    if [[ $? -ne 0 ]]; then
        return ${ERROR}
    fi

    return ${SUCCESS}
}

function perf_record()
{
    if [ -L "${1}" ]; then
        return ${ERROR}
    fi

    check_realpath "${1}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi

    check_record_info "${1}" "${2}" "${3}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi
    cd "/var/log/" || { echo "Failed to enter /var/log/"; return ${ERROR}; }
    local current_pid=$$
    local current_dir="/var/log/perf_$current_pid"
    # generate perf data every 10 seconds
    /usr/bin/perf record -o ${current_dir} -F ${2} -N -B -T -g -e\'${3}\' -a --switch-output=10s &
    local perf_pid=$!
    local perf_count=0
    local perf_user=$(stat -c "%U" /var/log/npu)
    echo "Perf record user: $perf_user"
    chown -RPf ${perf_user}:${perf_user} "/var/log/npu/profiling"
    # loop check to deliver tmp data to /var/log/npu/profiling
    while true; do
        for file in $current_dir.*; do
            if [ -f "$file" ]; then
                chown -RPf ${perf_user}:${perf_user} "$file"
                su - ${perf_user} -c "cp ${file} ${1}.${perf_count}"
                rm -rf "$file"
                perf_count=$((perf_count + 1))
            fi
        done
        sleep 1
        # if perf record process is killed, break loop
        if ! kill -0 $perf_pid 2>/dev/null; then
            break
        fi
    done
    # deliver all tmp data to /var/log/npu/profiling at last
    for file in $current_dir.*; do
        if [ -f "$file" ]; then
            chown -RPf ${perf_user}:${perf_user} "$file"
            su - ${perf_user} -c "cp ${file} ${1}.${perf_count}"
            rm -rf "$file"
            perf_count=$((perf_count + 1))
        fi
    done
    return ${SUCCESS}
}

function check_stat_info()
{
    local stat_data_template="^/var/log/npu/profiling/[[0-9]|[[1-5][0-9]]|[6[0-4]]]/hscb.data.[[0-9]|[[1-5][0-9]]|[6[0-4]]]$"
    local ret=$(echo ${1} | grep -E ${stat_data_template})
    if [[ ${ret} != ${1} ]]; then
        return ${ERROR}
    fi
 
    check_spacial_symbol "${2}"
    if [[ $? -ne 0 ]]; then
        return ${ERROR}
    fi
 
    check_spacial_symbol "${3}"
    if [[ $? -ne 0 ]]; then
        return ${ERROR}
    fi

    return ${SUCCESS}
}

function perf_stat()
{
    if [ -L "${1}" ]; then
        return ${ERROR}
    fi
 
    check_realpath "${1}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi
 
    check_stat_info "${1}" "${2}" "${3}"
    if [ $? -ne 0 ]; then
        return ${ERROR}
    fi

    cd "/var/log/" || { echo "Failed to enter /var/log/"; return ${ERROR}; }
    local current_pid=$$
    local current_dir="/var/log/perf_stat_$current_pid"
    /usr/bin/perf stat -o ${current_dir} -a -e ${2} -I ${3} &
    local perf_pid=$!
    local perf_user=$(stat -c "%U" /var/log/npu)
    echo "Perf stat user: $perf_user"
    chown -RPf ${perf_user}:${perf_user} "/var/log/npu/profiling"
    # loop check to wait stat process is killed
    while true; do
        sleep 1
        # if perf stat process is killed, break loop
        if ! kill -0 $perf_pid 2>/dev/null; then
            break
        fi
    done
    # deliver hscb.data to /var/log/npu/profiling at last
    if [ -f "$current_dir" ]; then
        chown -RPf ${perf_user}:${perf_user} "$current_dir"
        su - ${perf_user} -c "cp ${current_dir} ${1}"
        rm -rf "$current_dir"
    fi

    return ${SUCCESS}
}

case ${OPTIONS} in
"--version")
    if [ $# -eq 1 ] || [ $# -eq 2 ]; then
        perf_version
        RESULT=$?
    fi
    ;;
"--kill")
    if [ $# -eq 1 ] || [ $# -eq 2 ]; then
        kill_perf
        RESULT=$?
    fi
    ;;
"--script")
    if [ $# -eq 2 ] || [ $# -eq 3 ]; then
        perf_script "${2}"
        RESULT=$?
    fi
    ;;
"--record")
    if [ $# -eq 4 ] || [ $# -eq 5 ]; then
        perf_record "${2}" "${3}" "${4}"
        RESULT=$?
    fi
    ;;
"--stat")
    if [ $# -eq 4 ] || [ $# -eq 5 ]; then
        perf_stat "${2}" "${3}" "${4}"
        RESULT=$?
    fi
    ;;
*)
    RESULT=${ERROR}
    ;;
esac

exit $RESULT
