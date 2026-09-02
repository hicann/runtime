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
PACKAGE_VERSION=""
# 路径
spc_path="$(
    cd "$(dirname "$0")/../../"
    pwd
)"
if [ ! -d "$spc_path/backup/pyACL" ]; then
    echo "ERROR" "The backup directory $spc_path/backup/pyACL/ does not exist. Rollback failed"
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

function del_file() {
    file_path=$1
    # 判断是否是文件
    if [ -f "${file_path}" ]; then
        chmod 750 $1
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

function cp_file() {
    #拷贝文件到指定目录下
    if [ -f "$1" ]; then
        cp -f $1 $2
        if [ $? = 0 ]; then
            print "INFO" "copy $3 to directory $2 successfully"
        else
            print "ERROR" "copy $3 to directory $2 fail"
            exit 1
        fi
    else
        print "ERROR" "the file $1 is not exist"
        exit 1
    fi
}

function get_ver() {
    #获取版本信息
    local ver
    ver=`grep Version $1 | cut -d '=' -f 2`
    if [ $? != 0 ]; then
        print "ERROR" "grep the version.info fail"
        exit 1
    fi
    echo $ver
}

function deal_rollback() {
    spc_python_path=$spc_path/backup/pyACL/python/site-packages/acl.so
    acl_path=$install_path/python/site-packages

    if [ -f "${acl_path}/acl.so" ]; then
        cp_file ${spc_python_path} ${acl_path} "acl.so"
    else
        print "WARNING" "the file ${acl_path}/acl.so is not exist"
    fi

    spc_pyacl_path=$spc_install_path/version.info
    cur_ver=`get_ver "$spc_pyacl_path"`
    ver_per==`stat -c %a "$spc_pyacl_path"`
    if [ -f "${install_path}/pyACL/version.info" ]; then
        chmod 750 "${install_path}/pyACL/version.info"
        cp_file ${spc_pyacl_path} ${install_path}/pyACL "version.info"
        chmod $ver_per "${install_path}/pyACL/version.info"
    else
        print "WARNING" "the file ${install_path}/pyACL/version.info is not exist"
    fi

    if [ -d "$spc_path/backup/pyACL" ]; then
        chmod 750 -R $spc_path/backup/pyACL
    fi
    del_file "$spc_pyacl_path"
    del_file "$spc_python_path"

    del_dir "$spc_path/backup/pyACL/python/site-packages"
    del_dir "$spc_path/backup/pyACL"


    print "INFO" "${PACKAGE_NAME}-${PACKAGE_VERSION} rolled back successfully, The current version is $cur_ver"
}

log_init
deal_rollback
