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

MIN_PIP_VERSION=19
PYTHON_VERSION=3.7.5
CMAKE_VERSION=3.5.1
GPP_VERSION=7.4.0
GPP_VERSION_EULEROS=7.3.0

IS_QUIET=y
if [ "x$1" = "x--no-quiet" ]; then
    IS_QUIET=n
fi

log() {
    local cur_date="$(date +'%Y-%m-%d %H:%M:%S')"
    local log_type="$1"
    shift
    if [ "$(echo -e)" = "-e" ]; then
        echo_cmd="echo"
    else
        echo_cmd="echo -e"
    fi
    if [ "$log_type" = "INFO" ]; then
        $echo_cmd "[Runtime] [$cur_date] [$log_type]: \033[32m$*\033[0m"
    elif [ "$log_type" = "WARNING" ]; then
        $echo_cmd "[Runtime] [$cur_date] [$log_type]: \033[33m$*\033[0m"
    elif [ "$log_type" = "ERROR" ]; then
        $echo_cmd "[Runtime] [$cur_date] [$log_type]: \033[31m$*\033[0m"
    else
        $echo_cmd "[Runtime] [$cur_date] [$log_type]: $*"
    fi
}

input_check() {
    [ "${IS_QUIET}" = y ] && return
    log "INFO" "Do you want to continue? [y/n]"
    while true; do
        read yn
        if [ "$yn" = n ]; then
            exit 1
        elif [ "$yn" = y ]; then
            break
        else
            log "ERROR" "ERR_NO:0x0002;ERR_DES:input error, please input again!"
        fi
    done
}

version_lt() {
    test $(echo "$@" | tr " " "\n" | sort -rV | head -n 1) != "$1"
}

is_euleros() {
    test "$(uname -a 2>&1 | grep -ci euleros)" != "0"
}

which pip3 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    pip3_version="$(pip3 --version 2>/dev/null | head -n 1)"
    pip3_version=$(expr "$pip3_version" : 'pip \([0-9]\+\(\.[0-9]\+\)\+\)')
    if [ "x$pip3_version" = "x" ]; then
        log "WARNING" "cannot get pip3 version"
        input_check
    elif version_lt "$pip3_version" "$MIN_PIP_VERSION"; then
        log "WARNING" "pip3 version ${pip3_version} is lower than ${MIN_PIP_VERSION}.x.x"
        input_check
    fi
else
    log "WARNING" "pip3 is not found."
fi

which python3 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    python_version="$(python3 --version 2>&1 | head -n 1)"
    python_version=$(expr "$python_version" : '.*\([0-9]\+\.[0-9]\+\.[0-9]\+\)')
    if version_lt "$python_version" "$PYTHON_VERSION"; then
        log "WARNING" "python version ${python_version} is lower than ${PYTHON_VERSION}."
        input_check
    fi
else
    log "WARNING" "python3 is not found."
fi

which cmake > /dev/null 2>&1
if [ $? -eq 0 ]; then
    cmake_version="$(cmake --version | head -n 1)"
    cmake_version=$(expr "$cmake_version" : '.*\([0-9]\+\.[0-9]\+\.[0-9]\+\)')
    if version_lt "$cmake_version" "$CMAKE_VERSION"; then
        log "WARNING" "cmake version ${cmake_version} is lower than ${CMAKE_VERSION}."
        input_check
    fi
else
    log "WARNING" "cmake is not found."
fi

which g++ > /dev/null 2>&1
if [ $? -eq 0 ]; then
    gpp_version="$(g++ --version | head -n 1)"
    gpp_version=$(expr "$gpp_version" : '.*\<\([0-9]\+\.[0-9]\+\.[0-9]\+\)')
    if is_euleros; then
        GPP_VERSION="$GPP_VERSION_EULEROS"
    fi
    if version_lt "$gpp_version" "$GPP_VERSION"; then
        log "WARNING" "g++ version ${gpp_version} is lower than ${GPP_VERSION}."
        input_check
    fi
else
    log "WARNING" "g++ is not found."
fi
