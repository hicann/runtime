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
source /etc/profile
CUR_DIR=$(dirname $(readlink -f $0))
TOP_DIR=$(readlink -f $CUR_DIR/../)
INSTALL_DIR=$TOP_DIR/platform/Tuscany/build_pyacl

SO_DIR=$TOP_DIR/temp/python/site-packages/
SCRIPT_DIR=$TOP_DIR/temp/script
GCC_VERSION=$(gcc --version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
OS_NAME=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')

BASE_PACKAGE_VERSION=$(echo ${1} | cut -d "=" -f 2)
CANN_TYPE=$(echo ${2} | cut -d "=" -f 2)
PACKAGE_VERSION=$(echo ${3} | cut -d "=" -f 2)
JEMALLOC_SOURCE_DIR=$TOP_DIR/opensource

if [ x"${BASE_PACKAGE_VERSION}" = "x" ]; then
    exit 1
fi
# 非补丁包基线版本和包版本需一致
if [ "$CANN_TYPE" != Patch ] && [ "$BASE_PACKAGE_VERSION" != "$PACKAGE_VERSION" ]; then
    echo "BASE_PACKAGE_VERSION and PACKAGE_VERSION are not equal"
    exit 1
fi

function bep_env_init() {
    # bep消除二进制
    local bep_env_config=$CUR_DIR/bep/bep_env.conf
    # 检查BepKit预置环境
    local bep_sh=$(which bep_env.sh)
    echo "has bep sh :${bep_sh}"
    # 执行bep脚本
    if [ ! -d "${SECBEPKIT_HOME}" ] && [ ! -f "$bep_sh" ]; then
        echo "BepKit is uninstalled, Please install the tool and configure the env var \$SECBEPKIT_HOME"
    else
        source  ${SECBEPKIT_HOME}/bep_env.sh -s $bep_env_config
        if [ $? -ne 0 ]; then
            echo "build bep failed!"
            exit 1
        else
            echo "build bep success."
        fi
    fi
}

function get_os_name() {
    awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"'
}

function get_os_version() {
    local os_name=$(get_os_name)
    declare -A os_version=(["ubuntu"]="$(awk -F= '/^VERSION_ID=/{print $2}' /etc/os-release | tr -d '"')" ["centos"]="7.6" ["euleros"]="2.8" ["debian"]="9.9" ["uos"]="20")
    for key in "${!os_version[@]}"; do
        if [ "$key" == "$os_name" ]; then
            echo "${os_version[$key]}"
            return 0
        fi
    done
    exit 1
}

function clean() {
    [ -n "${path_build}" ] && rm -rf $path_build
}

function build_jemalloc() {
    local jemalloc_build_path=$path_build/jemalloc_build
    if [ ! -d "$jemalloc_build_path" ]; then
        mkdir -p "$jemalloc_build_path"
    fi

    mv "$JEMALLOC_SOURCE_DIR/jemalloc" "$jemalloc_build_path/"
    pushd "$jemalloc_build_path/jemalloc"
    LDFLAGS="-Wl,-z,relro,-z,now,-s" CFLAGS="-fstack-protector-all" ./autogen.sh
    make
    if [ $? -ne 0 ]; then
        exit 1
    fi
    cp "./lib/libjemalloc.so.2" "./libjemalloc.so"
    mv "./libjemalloc.so" "$SO_DIR"
    popd
}

bep_env_init

OS_NAME=$(get_os_name)
OS_VERSION=$(get_os_version)

x86_flag=n
export ARCH=$(arch)

chmod 750 $TOP_DIR/script/*.sh

chmod 750 $TOP_DIR/platform/Tuscany/*.run

if [ $( uname -a | grep -c -i "x86_64" ) -ne 0 ]; then
    x86_flag=y
    echo "it is system of x86_64"
elif [ $( uname -a | grep -c -i "aarch64" ) -ne 0 ]; then
    echo "it is system of aarch64"
else
    echo "it is system of sw_64"
fi

$TOP_DIR/platform/Tuscany/cann-npu-runtime_*-$ARCH.run --full --install-path=$INSTALL_DIR -q
$TOP_DIR/platform/Tuscany/cann-acl-extend_*-$ARCH.run --full --install-path=$INSTALL_DIR -q
$TOP_DIR/platform/Tuscany/cann-dvpp_*-$ARCH.run --full --install-path=$INSTALL_DIR -q
$TOP_DIR/platform/Tuscany/cann-ge-executor_*-$ARCH.run --full --install-path=$INSTALL_DIR -q

mkdir -p $TOP_DIR/dependency/lib64
cp -af $INSTALL_DIR/cann/*-linux/lib64/*.so $TOP_DIR/dependency/lib64
cp -af $INSTALL_DIR/cann/*-linux/include $TOP_DIR/dependency

chmod +w $TOP_DIR/dependency/include/acl
chmod +w $TOP_DIR/dependency/include/acl/acl_base_rt.h
sed -i 's/#define ACL_DEPRECATED __attribute__((deprecated))/#define ACL_DEPRECATED/g' $TOP_DIR/dependency/include/acl/acl_base_rt.h
sed -i "s/#define ACL_DEPRECATED_MESSAGE(message) __attribute__((deprecated(message)))/#define ACL_DEPRECATED_MESSAGE(message)/g" $TOP_DIR/dependency/include/acl/acl_base_rt.h
path_build=$CUR_DIR/temp
mkdir -p $path_build
cd $path_build
cmake ../..
make
if [ $? -ne 0 ]; then
    exit 1
fi
mkdir -p $SO_DIR
mkdir -p $SCRIPT_DIR
chmod 444 *.so
mv *.so $SO_DIR

# 将jemalloc打包功能借助pyacl子包实现
build_jemalloc

chmod 750 $TOP_DIR/opensource/makeself/*.sh
sed -i "s/^BASE_PACKAGE_VERSION=.*/BASE_PACKAGE_VERSION=\"$BASE_PACKAGE_VERSION\"/" $TOP_DIR/script/install.sh
sed -i "s/^PACKAGE_VERSION=.*/PACKAGE_VERSION=\"${PACKAGE_VERSION}\"/" $TOP_DIR/script/install.sh
if [ "$CANN_TYPE" = Patch ]; then
    sed -i "s/^CANN_TYPE=.*/CANN_TYPE=\"patch\"/" $TOP_DIR/script/install.sh
    sed -i "s/^BASE_PACKAGE_VERSION=.*/BASE_PACKAGE_VERSION=\"$BASE_PACKAGE_VERSION\"/" $TOP_DIR/script/spc_rollback.sh
    sed -i "s/^BASE_PACKAGE_VERSION=.*/BASE_PACKAGE_VERSION=\"$BASE_PACKAGE_VERSION\"/" $TOP_DIR/script/spc_uninstall.sh
    mkdir -p $SCRIPT_DIR/pyACL
    cp -af $TOP_DIR/script/install.sh $SCRIPT_DIR/
    cp -af $TOP_DIR/script/spc_rollback.sh $SCRIPT_DIR/pyACL/rollback.sh
    cp -af $TOP_DIR/script/spc_uninstall.sh $SCRIPT_DIR/pyACL/uninstall.sh
    cp -af $TOP_DIR/script/spc_rollback_precheck.sh $SCRIPT_DIR/pyACL/rollback_precheck.sh
    cp -af $TOP_DIR/script/total_rollback.sh $SCRIPT_DIR/rollback.sh
    cp -af $TOP_DIR/script/total_uninstall.sh $SCRIPT_DIR/uninstall.sh
    cp -af $TOP_DIR/script/spc_help.info $SCRIPT_DIR/help.info
    $TOP_DIR/opensource/makeself/makeself.sh --header $TOP_DIR/opensource/makeself/makeself-header.sh --help-header $SCRIPT_DIR/help.info --pigz --complevel 4 --nomd5 --sha256 --chown $TOP_DIR/temp pyACL_${PACKAGE_VERSION}_linux-$ARCH.run pyACL_spc ./script/install.sh
else
    cp -af $TOP_DIR/script/install.sh $SCRIPT_DIR
    cp -af $TOP_DIR/script/uninstall.sh $SCRIPT_DIR
    cp -af $TOP_DIR/script/cann_uninstall.sh $SCRIPT_DIR
    cp -af $TOP_DIR/script/help.info $SCRIPT_DIR
    $TOP_DIR/opensource/makeself/makeself.sh --header $TOP_DIR/opensource/makeself/makeself-header.sh --help-header $SCRIPT_DIR/help.info --pigz --complevel 4 --nomd5 --sha256 --chown $TOP_DIR/temp pyACL_${PACKAGE_VERSION}_linux-$ARCH.run pyACL ./script/install.sh
fi

rm -f $TOP_DIR/output/.gitkeep

mkdir -p $TOP_DIR/output/$ARCH-$OS_NAME$OS_VERSION
mv *.run $TOP_DIR/output/$ARCH-$OS_NAME$OS_VERSION

clean
