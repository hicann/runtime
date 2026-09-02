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

readonly PACKAGE_NAME="Ascend-spc_pyACL"
readonly PYACL_PACKAGE_SHORT_NAME="pyACL"
# 路径
spc_path="$(
    cd "$(dirname "$0")/../.."
    pwd
)"

if [ ! -d "$spc_path/backup/pyACL" ]; then
    echo "ERROR" "The backup directory $spc_path/backup/pyACL/ does not exist. Rollback Precheck failed"
    exit 1
fi

spc_install_path="$(
    cd "$(dirname "$0")/../../backup/pyACL/pyACL/"
    pwd
)"
install_path="$(
    cd "$(dirname "$0")/../../../"
    pwd
)"

#日志文件的位置
if [ $(id -u) -ne 0 ]; then
    log_dir="${HOME}/var/log/ascend_seclog"
else
    log_dir="/var/log/ascend_seclog"
fi
log_file="${log_dir}/ascend_install.log"

function print() {
    # 将关键信息打印到屏幕上
    echo "[pyACL] [$(date +"%Y-%m-%d %H:%M:%S")] [$1]: $2" | tee -a $log_file
}

function log_init() {
    if [ ! -f "$log_file" ]; then
        touch $log_file
        if [ $? -ne 0 ]; then
            print "ERROR" "touch $log_file permission denied"
            exit 1
        fi
    fi
    chmod 640 $log_file
}

function dir_check() {
    if [ ! -d "$1" ]; then
        print "ERROR" "dir $2 is not installed, rollback failed"
        exit 1
    fi
}

function file_check() {
    if [ ! -f "$1" ]; then
        print "ERROR" "the source file $2 does not exist, rollback failed"
        exit 1
    fi
}

function deal_precheck() {

    spc_python_path=$spc_path/backup/pyACL/python/site-packages/acl.so
    acl_path=$install_path/python/site-packages

    dir_check "${install_path}/spc" "spc"
    dir_check "$install_path/pyACL" "pyACL"
    dir_check "$acl_path" "python"

    file_check "$spc_python_path" "acl.so"

    spc_pyacl_path=$spc_install_path/version.info
    file_check "$spc_pyacl_path" "version.info"
    exit 0
}

log_init
deal_precheck
