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
readonly RUN_DIR_NAME="run_package"
readonly PACKAGE_ARCH=$(arch)
PACKAGE_NAME="Ascend-pyACL"
INSTALL_DIRECTORY="pyACL"
CANN_TYPE=""
BASE_PACKAGE_VERSION=""
PACKAGE_VERSION=""
if [ "$CANN_TYPE" = "patch" ]; then
    PACKAGE_NAME="Ascend-spc_pyACL"
    INSTALL_DIRECTORY="spc/backup/pyACL/pyACL"
    spc_path="spc"
    cur_ver=""
    spc_install_path=""
    rollback_flag=n
fi
DEFAULT_INSTALL_PATH=""
username=$(id -nu)
usergroup=$(id -ng)
python_path="python"
share_info_dir="share/info"
lib_path="${PACKAGE_ARCH}-linux/lib64"

# 由输入命令行决定的参数
install_path=""
install_flag=n
uninstall_flag=n
upgrade_flag=n
input_path_flag=n
devel_flag=n
quiet_flag=n
install_for_all_flag=n
install_path_cmd="--install-path"
install_cmd=""
uninstall_path_cmd="--uninstall"
upgrade_path_cmd="--upgrade"
spc_python_per=""
spc_site_package_per=""
spc_install_per=""
acl_per=""
ver_per=""

# 设置安装默认目录
if [ "$UID" = "0" ]; then
    # root用户安装时，默认选择install_for_all
    install_for_all_flag=y
    DEFAULT_INSTALL_PATH="/usr/local/Ascend"
else
    DEFAULT_INSTALL_PATH="${HOME}/Ascend"
fi

#日志文件的位置
if [ $(id -u) -ne 0 ]; then
    log_dir="${HOME}/var/log/ascend_seclog"
else
    log_dir="/var/log/ascend_seclog"
fi
log_file="${log_dir}/ascend_install.log"

###  公用函数
function print_usage() {
    echo "Please use this option for more help: --help / -h"
    exit 1
}

function print_error(){
    print "ERROR" "Unsupported parameters : $1"
    print_usage
}

# 创建文件夹
create_folder() {
    if [ ! -d "$log_dir" ]; then
        mkdir -p $log_dir
    fi
}

# 将日志打印
function log() {
    local cur_date_=$(date +"%Y-%m-%d %H:%M:%S")
    local log_type_=$1
    local msg_=$2
    local log_format_="[pyACL] [$cur_date_] [$log_type_]: ${msg_}"
    if [ ! -f "$log_file" -a "$quiet_flag" = n ]; then
        echo $log_format_
    elif [ -f "$log_file" ]; then
        echo $log_format_ >>$log_file
    fi
}

function print() {
    if [ "$quiet_flag" = y -a "$1" = "INFO" ]; then
        log "$1" "$2"
        return
    fi
    # 将关键信息打印到屏幕上
    if [ ! -f "$log_file" ]; then
        echo "[pyACL] [$(date +"%Y-%m-%d %H:%M:%S")] [$1] $2"
    else
        echo "[pyACL] [$(date +"%Y-%m-%d %H:%M:%S")] [$1] $2" | tee -a $log_file
    fi
}

function file_check() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

function mkdir_dir() {
    #创建目录
    if [ ! -d "$1" ]; then
        mkdir -p $1
        if [ $? -ne 0 ]; then
            print "ERROR" "mkdir install path $1 permission denied"
            exit 1
        fi
        print "INFO" "mkdir install path $1 successfully"
    fi

    if [ "$install_for_all_flag" = n ]; then
        chmod 750 $1 2>/dev/null
    else
        chmod 755 $1 2>/dev/null
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

function cp_file() {
    #拷贝文件
    cp -f $1 $2
    if [ $? = 0 ]; then
        print "INFO" "copy $3 to $2 successfully"
    else
        print "ERROR" "copy $3 to $2 fail"
        exit 1
    fi
}

function get_sub_ver() {
    num=`echo $1 | awk -F"." '{print NF-1}'`
    local sub_ver=""
    if [ $num -eq 3 ];then
        sub_ver=${1##*.}
    fi
    echo $sub_ver
}

function sub_ver_comp() {
    local py_ver=$1
    local spc_ver=$2
    if [ "$py_ver" = "$spc_ver" ];then
        print "ERROR" "The version of the spc package is the same as the pyacl, install spc fail"
        exit 1
    fi
    if ([ -n "$py_ver" ] && [ -n "$spc_ver" ] && [ "$py_ver" \> "$spc_ver" ]) || ([ -n "$py_ver" ] && [ -z "$spc_ver" ]); then
        print "ERROR" "The spc sub version is inconsistent with the pyacl sub version, install spc fail"
        exit 1
    fi
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
            print "WARNING" "the file is not exist"
        fi
    else
        print "WARNING" "the file path is NULL"
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
            print "WARNING" "the directory is not exist"
        fi
    else
        print "WARNING" "the directory path is NULL"
    fi
}

# 递归授权
chmod_recur() {
    if [ "$3" = "dir" ]; then
        find $1 -type d -exec chmod $2 {} \; 2> /dev/null
    elif [ "$3" = "file" ]; then
        find $1 -type f -exec chmod $2 {} \; 2> /dev/null
    fi
}

# 安装目录权限设置
function mod_dir_permis() {
    chmod 500 -R ${spc_path}/script/pyACL/rollback.sh
    chmod 500 -R ${spc_path}/script/pyACL/uninstall.sh
    chmod 500 -R ${spc_path}/script/pyACL/rollback_precheck.sh
    chmod 550 ${spc_path}/script/pyACL
    chmod 550 -R ${spc_path}/backup/pyACL
    chmod $ver_per ${spc_path}/backup/pyACL/pyACL/version.info
    chmod 500 ${spc_path}/script/uninstall.sh
    chmod 500 ${spc_path}/script/rollback.sh
    chown -R $username:$usergroup ${spc_path}/script/pyACL
    chown -R $username:$usergroup ${spc_path}/backup/pyACL
    chmod $spc_python_per "${spc_path}/backup/pyACL/python"
    chmod $spc_site_package_per "${spc_path}/backup/pyACL/python/site-packages"
    chmod $spc_install_per  "${spc_path}/backup/pyACL/pyACL"
    chmod $spc_install_per  "${install_path}/pyACL"
    chmod $acl_per "${spc_path}/backup/pyACL/python/site-packages/acl.so"
}

# 安装结束之后更改权限
chmod_after_install() {
    if [ "$install_for_all_flag" = n ]; then
        chmod 750 $install_path/python 2> /dev/null
        chmod 750 $install_path/python/site-packages 2> /dev/null
        chmod 750 $install_path/python/site-packages/acl 2> /dev/null
        chmod 750 -R $acl_path
        chmod 550 $install_path/${share_info_dir}/pyACL/script
        chmod 500 $install_path/${share_info_dir}/pyACL/script/uninstall.sh
        chmod 440 $install_path/python/site-packages/acl.so
        chmod 440 $config_file_path 2> /dev/null
        chmod 440 $version_file_path 2> /dev/null
        chmod 440 $scene_file_path 2> /dev/null
        chown -R $username:$usergroup $install_path/${share_info_dir}/pyACL
        chown $username:$usergroup $install_path/python/site-packages/acl.so
        chmod 550 $install_path/${share_info_dir}/pyACL 2> /dev/null
        chmod 440 $install_path/${PACKAGE_ARCH}-linux/lib64/libjemalloc.so
    else
        chmod 755 $install_path/python 2> /dev/null
        chmod 755 $install_path/python/site-packages 2> /dev/null
        chmod 755 $install_path/python/site-packages/acl 2> /dev/null
        chmod 755 -R $acl_path
        chmod 555 $install_path/${share_info_dir}/pyACL 2> /dev/null
        chmod 555 $install_path/${share_info_dir}/pyACL/script
        chmod 500 $install_path/${share_info_dir}/pyACL/script/uninstall.sh
        chmod 444 $install_path/python/site-packages/acl.so
        chmod 444 $config_file_path 2> /dev/null
        chmod 444 $version_file_path 2> /dev/null
        chmod 444 $scene_file_path 2> /dev/null
        chown -R $username:$usergroup $install_path/${share_info_dir}/pyACL
        chown $username:$usergroup $install_path/python/site-packages/acl.so
        chmod 444 $install_path/${PACKAGE_ARCH}-linux/lib64/libjemalloc.so
    fi
    if [ "$UID" = "0" ]; then
        # root用户安装时，将外层的目录和脚本路径改为root权限，防止普通用户越权操作
        chmod 755 $install_path
    fi
}

# 解析脚本自身的参数
function parse_script_args() {
    while true; do
        case "$3" in
        --check)
            exit 0
            ;;
        --help | -h)
            print_usage
            ;;
        --version)
            echo "${PACKAGE_SHORT_NAME} ${PACKAGE_VERSION}"
            exit 0
            ;;
        --install)
            if [ "$CANN_TYPE" = "patch" ]; then
                print_error "$3"
            fi
            install_flag=y
            shift
            ;;
        --install-path=*)
            # 去除指定安装目录后所有的 "/"
            local temp_path=$(echo $3 | cut -d"=" -f2 | sed "s/\/*$//g")
            # path只支持绝对路径
            if [[ "${temp_path}" =~ ^/.* ]]; then
                install_path=${temp_path}
            else
                print "ERROR" "parameter error $3, must absolute path"
                exit 1
            fi
            input_path_flag=y
            shift
            ;;
        --uninstall)
            uninstall_flag=y
            shift
            ;;
        --devel)
            if [ "$CANN_TYPE" = "patch" ]; then
                print_error "$3"
            fi
            devel_flag=y
            shift
            ;;
        --upgrade)
            if [ "$CANN_TYPE" = "patch" ]; then
                print_error "$3"
            fi
            upgrade_flag=y
            shift
            ;;
        --quiet)
            quiet_flag=y
            shift
            ;;
        --rollback)
            if [ "$CANN_TYPE" != "patch" ]; then
                print_error "$3"
            fi
            rollback_flag=y
            shift
            ;;
        --run)
            if [ "$CANN_TYPE" = "patch" ]; then
                print_error "$3"
            fi
            install_flag=y
            shift
            ;;
        --full)
            install_flag=y
            shift
            ;;
        --install-for-all)
            if [ "$CANN_TYPE" = "patch" ]; then
                print_error "$3"
            fi
            install_for_all_flag=y
            shift
            ;;
        -*)
            print_error "$3"
            ;;
        *)
            break
            ;;
        esac
    done
}

### 脚本入参的相关处理函数
function check_script_args() {
    ######################  check params confilct ###################
    if [ $# -lt 3 ]; then
        print_usage
    fi
    local args_num=0
    if [ "$uninstall_flag" = y ]; then
        let 'args_num+=1'
    fi
    if [ "$upgrade_flag" = y ]; then
        let 'args_num+=1'
    fi
    if [ "$devel_flag" = y ]; then
        let 'args_num+=1'
    fi
    if [ "$install_flag" = y ]; then
        let 'args_num+=1'
    fi
    if [ "$rollback_flag" = y ]; then
        let 'args_num+=1'
    fi
    # 检测脚本参数的组合关系
    if [ $args_num -lt 1 ] || [ $args_num -gt 1 ]; then
        print "ERROR" "Unsupported parameters, operation failed."
        exit 1
    fi
    # 卸载参数只支持--cert参数一起使用
    if [ "$input_path_flag" = y ]; then
        if [ "${rollback_flag}" = "n" ] && [ "${uninstall_flag}" = "n" ] && [ "$install_flag" = "n" ] && [ "$upgrade_flag" = "n" ] && [ "${devel_flag}" = "n" ]; then
            print "ERROR" "Unsupported separate 'install-path' used independently"
            exit 1
        fi
    fi
}

function complete_params() {
    # 补齐具体执行安装，升级，卸载等流程需要的参数，比如升级时版本好的确认
    local tmp_install_path=${DEFAULT_INSTALL_PATH}
    if [ "$input_path_flag" = "y" ]; then
        tmp_install_path=${install_path}
    fi

    python_path=${tmp_install_path}/${python_path}
    lib_path=${tmp_install_path}/${lib_path}
    install_path="${tmp_install_path}"
    config_file_path="${install_path}/${share_info_dir}/pyACL/ascend-${PACKAGE_SHORT_NAME}_install.info"
    version_file_path="${install_path}/${share_info_dir}/pyACL/version.info"
    scene_file_path="${install_path}/${share_info_dir}/pyACL/scene.info"
}

function log_init() {
    # 日志模块初始化
    # 判断输入的安装路径路径是否存在，不存在则创建
    if [ ! -f "$log_file" ]; then
        touch $log_file
        if [ $? -ne 0 ]; then
            print "ERROR" "touch $log_file permission denied"
            exit 1
        fi
    fi
    chmod 640 $log_file
    if [ "${install_flag}" = y ]; then
        print "INFO" "install start"
    elif [ "${uninstall_flag}" = y ]; then
        print "INFO" "uninstall start"
    elif [ "${upgrade_flag}" = y ]; then
        print "INFO" "upgrade start"
    elif [ "${rollback_flag}" = y ]; then
        print "INFO" "rollback start"
    fi
}

### 一堆检测函数
function check_version() {
    # 检测依赖版本情况
    # 检查版本是否满足最低版本号的要求，最低为1.0.0
    local tmp_str=$(echo "${BASE_PACKAGE_VERSION} 1.0.0" | tr " " "\n" | sort -V | head -n 1)
    if [ x"${tmp_str}" != x1.0.0 ]; then
        print "ERROR" "package version too low"
        print "ERROR" "check the environment failed"
        exit 2
    fi
    return 0
}

# 执行安装run包
function deal_install() {
    if [ "${install_flag}" = y ] || [ "${devel_flag}" = y ] || [ "${upgrade_flag}" = y ]; then
        mkdir_dir "$install_path"
    fi
    mkdir_dir "${install_path}/${share_info_dir}/pyACL"
    chmod 750 -R "${install_path}/${share_info_dir}/pyACL"
    mkdir_dir "${install_path}/${share_info_dir}/pyACL/script"
    mkdir_dir "${python_path}"
    mkdir_dir "${python_path}/site-packages"
    acl_path=$python_path/site-packages/acl
    mkdir_dir "${acl_path}"

    cp -af "python/site-packages/acl.so" "${python_path}/site-packages/"
    cp -af "script/uninstall.sh" "${install_path}/${share_info_dir}/pyACL/script"
    if [ "${acl_path}/acl.so" ]; then
            rm -f ${acl_path}/acl.so
    fi
    ln -sf ../acl.so ${acl_path}/acl.so
    CURRENT_VERSION=$BASE_PACKAGE_VERSION
}

# 执行删除run包
function deal_uninstall() {
    ${install_path}/${share_info_dir}/pyACL/script/uninstall.sh
}

#移除卸载脚本uninstall_package
function remove_cann_uninstall() {
    if [ -f "${install_path}/cann_uninstall.sh" ]; then
        sed -i "/uninstall_package \"share\/info\/pyACL\/script\"/d" "${install_path}/cann_uninstall.sh"
        if [ $? -ne 0 ]; then
            print "ERROR" "remove ${install_path}/cann_uninstall.sh uninstall_package command failed"
            exit 2
        fi
    fi
}

#往卸载脚本中写入子包卸载命令,重复安装场景需要删除原来的命令,写入到最后
function write_cann_uninstall() {
    chmod 500 "${install_path}/cann_uninstall.sh"
    chmod u+w "${install_path}/cann_uninstall.sh"
    (grep  "${share_info_dir}/pyACL/script" "${install_path}/cann_uninstall.sh") &> /dev/null
    if [ $? -eq 0 ]; then
        remove_cann_uninstall
    fi
    sed -i "/^exit /i uninstall_package \"share/info/pyACL/script\"" "${install_path}/cann_uninstall.sh"
    chmod 500 "${install_path}/cann_uninstall.sh"
}

function regist_uninstall() {
    if [ -f "${install_path}/cann_uninstall.sh" ]; then
        write_cann_uninstall
    else
        cp -af script/cann_uninstall.sh ${install_path}
        write_cann_uninstall
    fi
}

function upgrade_uninstall() {
    if [ -L "${install_path}/${share_info_dir}/pyACL" ]; then
        pyACL_path=$(readlink -f ${install_path}/${share_info_dir}/pyACL)
        ${pyACL_path}/script/uninstall.sh ${upgrade_flag}
    fi
}

function deal_jemalloc_install() {
    local change_flag=n
    if [ ! -w "$lib_path" ];then
        chmod u+w $lib_path
        change_flag=y
    fi
    cp_file "python/site-packages/libjemalloc.so" "$lib_path" "libjemalloc.so"
    if [ "$change_flag" = "y" ];then
        chmod u-w $lib_path
    fi
}

function deal_with_packages() {
    # 安装、卸载、升级
    if [ "$1" == "install" ]; then
        deal_install
        deal_jemalloc_install
        echo "Please make sure that
                - PYTHONPATH includes ${python_path}/site-packages"
        upgrade_config_file "install"
        chmod_after_install
        regist_uninstall
    elif [ "$1" == "uninstall" ]; then
        deal_uninstall
    elif [ "$1" == "upgrade" ]; then
        upgrade_uninstall
        deal_install
        deal_jemalloc_install
        upgrade_config_file "upgrade"
        chmod_after_install
        regist_uninstall
    fi
    print "INFO" "${PACKAGE_NAME}-${BASE_PACKAGE_VERSION} ${1} success"
    exit 0
}

function upgrade_config_file_spc() {
    # 安装、升级、卸载
    if [ "$1" == "install" ]; then
        log "INFO" "version=${PACKAGE_VERSION}"
        log "INFO" "arch=${PACKAGE_ARCH}"
    fi
}

function upgrade_config_file() {
    # 安装、升级、卸载
    if [ "$1" == "install" ] || [ "$1" == "upgrade" ]; then
        echo "Version=${BASE_PACKAGE_VERSION}" >${version_file_path}
        log "INFO" "version=${BASE_PACKAGE_VERSION}"

        echo "path=${install_path}" >${config_file_path}
        log "INFO" "path=${install_path}"
        echo "arch=${PACKAGE_ARCH}" >>${config_file_path}
        log "INFO" "arch=${PACKAGE_ARCH}"
        echo "pyacl_username=${username}" >>${config_file_path}
        echo "pyacl_usergroup=${usergroup}" >>${config_file_path}

        echo "os=linux" >${scene_file_path}
        echo "arch=${PACKAGE_ARCH}" >>${scene_file_path}
        log "INFO" "arch=${PACKAGE_ARCH}"
    fi
}

### 安装，卸载，升级 流程
function install_process() {
    # 检查版本号
    check_version
    # 安装
    deal_with_packages "install"
}

function reinstall_check() {
    if [ -L "${install_path}/${share_info_dir}/pyACL" ]; then
        return 0
    else
        return 1
    fi
}

function upgrade_process() {
    # 升级过程除了路径不需要输入理论上与安装一样
    # 各种检测
    reinstall_check
    if [ $? -eq 1 ]; then
        print "ERROR" "run package is not installed, upgrade failed"
        print "ERROR" "check the environment failed"
        exit 2
    fi

    # 检查版本号
    check_version

    # 安装
    deal_with_packages "upgrade"
}

function uninstall_check() {
    if [ -d "${install_path}/${share_info_dir}/pyACL" ]; then
        return 0
    else
        return 1
    fi
}

function uninstall_process() {
    # 各种检测
    uninstall_check
    if [ $? -eq 1 ]; then
        print "ERROR" "run package is not installed, uninstall failed"
        print "ERROR" "check the environment failed"
        exit 2
    fi
    # 卸载
    deal_with_packages "uninstall"
}

# 执行安装run包
function deal_install_spc() {
    #检查pyACL是否安装
    spc_install_per=`stat -c %a "${install_path}/pyACL"`
    chmod 750 ${install_path}/pyACL
    file_check "${install_path}/pyACL/ascend-${PACKAGE_SHORT_NAME}_install.info"
    if [ $? -eq 1 ]; then
        print "ERROR" "pyACL package is not installed, spc install failed"
        print "ERROR" "check the environment failed"
        exit 2
    fi
    if [ ! -d "$install_path/pyACL" ]; then
        print "ERROR" "pyACL path not exist, spc install failed"
        exit 1
    fi
    mkdir_dir "$spc_path"
    sub_script=$spc_path/script/
    sub_backup=$spc_path/backup
    mkdir_dir "$sub_script"
    mkdir_dir "$sub_backup"
    if [ -f "${install_path}/pyACL/version.info" ]; then
        ver_per==`stat -c %a "${install_path}/pyACL/version.info"`
        pyacl_sub_ver=`grep Version "${install_path}/pyACL/version.info" | cut -d '=' -f 2`
        pyacl_sub_ver=`get_sub_ver "$pyacl_sub_ver"`
        spc_sub_ver=`get_sub_ver "$PACKAGE_VERSION"`
        pyacl_ver=`echo $cur_ver | cut -d '.' -f 1,2,3`
        pkg_ver=`echo $PACKAGE_VERSION | cut -d '.' -f 1,2,3`
        if [ "$pyacl_ver" != ${pkg_ver} ];
        then
            print "ERROR" "The spc version is inconsistent with the pyacl version, install spc fail"
            exit 1
        fi
        sub_ver_comp "$pyacl_sub_ver" "$spc_sub_ver"
        mkdir_dir "$spc_install_path"
        if [ -f "$spc_install_path/version.info" ]; then
            chmod 750 $spc_install_path/version.info
        fi
        cp_file "${install_path}/pyACL/version.info" "$spc_install_path/" "version.info"
        sed -i '/^Version=/c'Version=$PACKAGE_VERSION''  ${install_path}/pyACL/version.info
        if [ $? = 0 ]; then
            print "INFO" "Update the version successfully"
        else
            print "ERROR" "Update the version fail"
            exit 1
        fi
    else
        print "WARNING" "the file ${install_path}/pyACL/version.info is not exist"
        exit 0
    fi
    python_path=${install_path}/python
    acl_path=$python_path/site-packages
    spc_python_path=$spc_path/backup/pyACL/python/site-packages
    spc_python_per=`stat -c %a "${python_path}"`
    spc_site_package_per=`stat -c %a "${acl_path}"`
    mkdir_dir "$spc_python_path"
    if [ -f "$spc_python_path/acl.so" ]; then
        chmod 750 $spc_python_path/acl.so
    fi
    if [ -f "${acl_path}/acl.so" ]; then
        cp_file "$acl_path/acl.so" "$spc_python_path" "acl.so"
    else
        print "ERROR" "the file ${acl_path}/acl.so is not exist, backup acl.so fail"
        exit 2
    fi
    acl_per=`stat -c %a "${acl_path}/acl.so"`
    cp_file "python/site-packages/acl.so" "$acl_path/" "acl.so"
    chmod $acl_per "${acl_path}/acl.so"
    mkdir_dir "${spc_path}/script/pyACL"
    file_check "${spc_path}/script/uninstall.sh"
    if [ $? -eq 1 ]; then
        cp_file "script/uninstall.sh" "${spc_path}/script/" "uninstall.sh"
    fi
    file_check "${spc_path}/script/rollback.sh"
    if [ $? -eq 1 ]; then
        cp_file "script/rollback.sh" "${spc_path}/script/" "rollback.sh"
    fi
    chmod 750 "${spc_path}/script/pyACL"
    cp_file "script/pyACL/uninstall.sh" "${spc_path}/script/pyACL" "uninstall.sh"
    cp_file "script/pyACL/rollback.sh" "${spc_path}/script/pyACL" "rollback.sh"
    cp_file "script/pyACL/rollback_precheck.sh" "${spc_path}/script/pyACL" "rollback_precheck.sh"
    print "INFO" "${PACKAGE_NAME}-${PACKAGE_VERSION} install success"
}

# 执行删除run包
function deal_uninstall_spc() {
    file_check "${spc_path}/script/uninstall.sh"
    if [ $? -eq 1 ]; then
        print "ERROR" "The file uninstall.sh does not exist"
        exit 2
    fi
    ${spc_path}/script/uninstall.sh
}

# 执行版本回退
function deal_rollback() {
    file_check "${spc_path}/script/pyACL/rollback.sh"
    if [ $? -eq 1 ]; then
        print "ERROR" "The file rollback.sh does not exist"
        exit 2
    fi
    ${spc_path}/script/pyACL/rollback.sh
}

function get_current_version() {
    if [ -d "${install_path}/pyACL" ]; then
        if [ -f "${install_path}/pyACL/version.info" ]; then
            cur_ver=`get_ver "${install_path}/pyACL/version.info"`
        else
            print "WARNING" "the file ${install_path}/pyACL/version.info is not exist"
            exit 0
        fi
    else
        print "WARNING" "the dir ${install_path}/pyACL is not exist"
        exit 0
    fi
}

function set_spc_path() {
    local tmp_install_path=${DEFAULT_INSTALL_PATH}
    if [ "$input_path_flag" = "y" ]; then
        tmp_install_path=${install_path}
    fi
    spc_path=${tmp_install_path}/${BASE_PACKAGE_VERSION}/${spc_path}	##/usr/local/Ascend/5.0.1/spc
    spc_install_path=${tmp_install_path}/${BASE_PACKAGE_VERSION}/${INSTALL_DIRECTORY} ##/usr/local/Ascend/5.0.1/spc/backup/pyACL/pyACL
    install_path=${tmp_install_path}/${BASE_PACKAGE_VERSION}
}

### 安装
function process_spc() {
    set_spc_path
    if [ "$uninstall_flag" = "y" ]; then
        deal_uninstall_spc
    fi
    get_current_version
    if [ "$install_flag" = "y" ]; then
        deal_install_spc
        echo "Please make sure that
        - PYTHONPATH includes ${python_path}/site-packages"
        upgrade_config_file_spc "install"
        mod_dir_permis
    elif [ "$rollback_flag" = "y" ]; then
        deal_rollback
    fi
    exit 0
}

function process() {
    if [ "$install_flag" = "y" ] || [ "${devel_flag}" = "y" ]; then
        install_process
    elif [ "$upgrade_flag" = "y" ]; then
        upgrade_process
    elif [ "$uninstall_flag" = "y" ]; then
        uninstall_process
    fi
}

function create_install_dir() {
    local install_path="$1"
    if [ -d "${install_path}" ]; then
        return
    fi
    local tmp_install_path="$1"
    while [ ! -d $(dirname ${tmp_install_path}) ]; do
        tmp_install_path=$(dirname ${tmp_install_path})
    done
    mkdir -p ${install_path}
    if [ $? -ne 0 ]; then
        print "ERROR" "mkdir insatll path ${install_path} permission denied"
        exit 1
    fi
    if [ "$UID" != "0" ] && [ "$install_for_all_flag" = n ]; then
        chmod -R 750 ${tmp_install_path}
    else
        chmod -R 755 ${tmp_install_path}
    fi
}



# 程序开始
function main() {
    umask 0022
    create_folder
    parse_script_args $*
    check_script_args $*
    if [ "$input_path_flag" = n ]; then
        create_install_dir "${DEFAULT_INSTALL_PATH}"
    else
        create_install_dir "${install_path}"
    fi
    log_init
    if [ "$CANN_TYPE" = "patch" ]; then
        process_spc
    else
        complete_params
        process
    fi
}

main $*
