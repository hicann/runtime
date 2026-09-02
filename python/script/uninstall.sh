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

# 此处定义各种变量
readonly PACKAGE_SHORT_NAME="pyACL"
upgrade_flag=n

# 路径
install_path="$(dirname $(
    cd "$(dirname "$0")"
    pwd
))"
python_path="$(
    cd "$(dirname "$0")/../../../../python"
    pwd
)"
PACKAGE_ARCH=$(arch)
lib_path="$(
    cd "$(dirname "$0")/../../../../${PACKAGE_ARCH}-linux/lib64"
    pwd
)"

config_file_path="${install_path}/ascend-${PACKAGE_SHORT_NAME}_install.info"
version_file_path="${install_path}/version.info"
scene_file_path="${install_path}/scene.info"

function print() {
    # 将关键信息打印到屏幕上
    echo "[pyACL] [$(date +"%Y-%m-%d %H:%M:%S")] [$1]: $2"
}

#安全删除文件
function rm_file_safe() {
    local file_path=$1
    # 判断变量是否为空
    if [ -n "${file_path}" ]; then
        # 判断是否是文件
        if [ -f "${file_path}" ] || [ -h "${file_path}" ]; then
            rm -f "${file_path}"
            print "INFO" "delete file ${file_path} successfully"
        else
            print "WARNING" "the file ${file_path} is not exist"
        fi
    else
        print "WARNING" "the file ${file_path} path is NULL"
    fi
}

#安全删除文件夹
function rm_dir_safe() {
    local dir_path=$1
    # 判断变量不为空且不是系统根盘
    if [ -n "${dir_path}" ] && [[ ! "${dir_path}" =~ ^/+$ ]]; then
        # 判断是否是目录
        if [ -d "${dir_path}" ]; then
            rm -rf "${dir_path}"
            print "INFO" "delete directory ${dir_path} successfully"
        else
            print "WARNING" "the directory ${dir_path} is not exist"
        fi
    else
        print "WARNING" "the directory ${dir_path} path is NULL"
    fi
}

function delete_empty_folder() {
    if [ -d "${1}" ]; then
        if [ ! "$(ls -A ${1})" ]; then
            rm_dir_safe ${1}
        fi
    fi
}

# 更改目录下文件权限实施修改
chmod_to_modify() {
    chmod 750 -R $install_path 2> /dev/null
    chmod 750 $python_path 2> /dev/null
}

function __remove_uninstall_package() {
    local uninstall_file=$1
    if [ -f "${uninstall_file}" ]; then
        sed -i "/uninstall_package \"share\/info\/pyACL\/script\"/d" "${uninstall_file}"
        if [ $? -ne 0 ]; then
            print "ERROR" "remove ${uninstall_file} uninstall_package command failed!"
            exit 1
        fi
    fi
    num=$(grep "^uninstall_package " ${uninstall_file} | wc -l)
    if [ ${num} -eq 0 ]; then
        rm -f "${uninstall_file}" > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            print "ERROR" "delete file: ${uninstall_file}failed, please delete it by yourself."
        fi
    fi
}

function unregist_uninstall() {
    if [ -f "${totals_version_path}/cann_uninstall.sh" ]; then
        chmod u+w ${totals_version_path}/cann_uninstall.sh
        __remove_uninstall_package "${totals_version_path}/cann_uninstall.sh"
        if [ -f "${totals_version_path}/cann_uninstall.sh" ]; then
            chmod u-w ${totals_version_path}/cann_uninstall.sh
        fi
    fi
}

function deal_python_dir() {
    delete_empty_folder "$python_path/site-packages/acl/"
    delete_empty_folder "$python_path/site-packages"
    delete_empty_folder "$python_path"
}

function deal_install_dir() {
    rm_file_safe ${install_path}/script/uninstall.sh
    delete_empty_folder "${install_path}/script/"
    delete_empty_folder "${install_path}"
    delete_empty_folder "${install_path%/*}"        #删除父目录share/info
    delete_empty_folder "${install_path%/*/*}"      #删除父目录share
}

function deal_uninstall() {
    rm_file_safe ${config_file_path}
    rm_file_safe ${version_file_path}
    rm_file_safe ${scene_file_path}
    rm_file_safe "$python_path/site-packages/acl/acl.so"
    rm_file_safe "$python_path/site-packages/acl.so"
    deal_python_dir
    deal_install_dir
    totals_version_path=${install_path%/*/*/*}
    unregist_uninstall
    delete_empty_folder "${totals_version_path}"
}

function deal_jemalloc_uninstall() {
    local change_flag=n
    # 删除libjemalloc.so
    if [ -f "${lib_path}/libjemalloc.so" ]; then
        if [ ! -w "$lib_path" ];then
            chmod u+w $lib_path
            change_flag=y
        fi
        rm_file_safe "${lib_path}/libjemalloc.so"
        if [ "$change_flag" = "y" ];then
            chmod u-w $lib_path
        fi
    fi
}

# 程序开始
function main() {
    upgrade_flag=$1
    chmod_to_modify
    deal_jemalloc_uninstall
    deal_uninstall
}

main $*
