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
PACKAGE_VERSION=""
# 路径
spc_path="$(
    cd "$(dirname "$0")/../.."
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

function del_file() {
    file_path=$1
    # 判断是否是文件
    if [ -f "${file_path}" ]; then
        rm -f "${file_path}"
        if [ $? = 0 ]; then
            print "INFO" "delete file ${file_path} successfully"
        else
            print "ERROR" "delete file ${file_path} fail"
            exit 1
        fi
    else
        print "WARNING" "the file ${file_path} is not exist"
    fi
}

#安全删除文件夹
function del_dir() {
    local dir_path=$1

    # 判断变量不为空且不是系统根盘
    if [ -n "${dir_path}" ] && [[ ! "${dir_path}" =~ ^/+$ ]]; then
        # 判断是否是目录
        if [ -d "${dir_path}" ]; then
            chmod 750 -R ${dir_path}
            rm -rf "${dir_path}"
            if [ $? = 0 ]; then
                print "INFO" "delete directory ${dir_path} successfully"
            else
                print "ERROR" "delete directory ${dir_path} fail"
                exit 1
            fi
        else
            print "WARNING" "the directory ${dir_path} is not exist"
        fi
    else
        print "WARNING" "the directory ${dir_path} path is NULL"
    fi
}

function remove_empty_dir() {
    [ ! -d "$1" ] && return 1
    if [ -z "$(ls -A $1 2>&1)" ]; then
        rm -rf "$1"
        if [ $? = 0 ]; then
            print "INFO" "delete directory $1 successfully"
        else
            print "ERROR" "delete directory $1 fail"
            exit 1
        fi
    fi
}

function deal_uninstall() {
    version_file_path="${spc_path}/backup/pyACL/pyACL/version.info"
    spc_python_path=$spc_path/backup/pyACL/python/site-packages/acl.so

    if [ -d "$spc_path/backup/pyACL" ]; then
        chmod 750 -R $spc_path/backup/pyACL
    fi

    if [ -d  "$spc_path/backup/pyACL" ]; then
        del_dir "$spc_path/backup/pyACL"
    fi

    del_dir "$spc_path/script/pyACL"
    remove_empty_dir "$spc_path/backup"
    remove_empty_dir "$spc_path/script"
    print "INFO" "${PACKAGE_NAME}-${PACKAGE_VERSION} uninstalled successfully, the directory spc/backup/pyACL has been deleted"
}

log_init
deal_uninstall
