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

curpath="$(dirname ${BASH_SOURCE:-$0})"
curfile="$(realpath ${BASH_SOURCE:-$0})"
DEP_HAL_NAME="libascend_hal.so"
DEP_INFO_FILE="/etc/ascend_install.info"
IS_INSTALL_DRIVER="n"
param_mult_ver=$1

append_env() {
    local name="$1"
    local value="$2"
    local env_value="$(eval echo "\${${name}}" | tr ':' '\n' | grep -v "^${value}$" | tr '\n' ':' | sed 's/:$/\n/')"
    if [ "$env_value" = "" ]; then  
        read $name <<EOF
$value
EOF
    else    
        read $name <<EOF
$env_value:$value
EOF
    fi
    export $name
}

prepend_env() {
    local name="$1"
    local value="$2"
    local env_value="$(eval echo "\${${name}}" | tr ':' '\n' | grep -v "^${value}$" | tr '\n' ':' | sed 's/:$/\n/')"
    if [ "$env_value" = "" ]; then
        read $name <<EOF
$value
EOF
    else
        read $name <<EOF
$value:$env_value
EOF
    fi
    export $name
}


remove_env() {
    local name="$1"
    local value="$2"
    read $name <<EOF
$(eval echo "\${${name}}" | tr ':' '\n' | grep -v "^${value}$" | tr '\n' ':' | sed 's/:$/\n/')
EOF
    export $name
}

get_install_param() {
    local _key="$1"
    local _file="$2"
    local _param=""

    if [ ! -f "${_file}" ]; then
        exit 1
    fi
    local install_info_key_array="Runtime_Install_Type Runtime_Feature_Type Runtime_UserName Runtime_UserGroup Runtime_Install_Path_Param Runtime_Arch_Linux_Path Runtime_Hetero_Arch_Flag"
    for key_param in ${install_info_key_array}; do
        if [ "${key_param}" = "${_key}" ]; then
            _param=$(grep -i "${_key}=" "${_file}" | cut --only-delimited -d"=" -f2-)
            break
        fi
    done
    echo "${_param}"
}

get_install_dir() {
    local install_info="$curpath/../ascend_install.info"
    get_install_param "Runtime_Install_Path_Param" "${install_info}"
}

ld_library_path="$LD_LIBRARY_PATH"
if [ ! -z "$ld_library_path" ]; then
    ld_library_path="$(echo "$ld_library_path" | tr ':' ' ')"
    for var in ${ld_library_path}; do
        if [ -d "$var" ]; then
            if echo "$var" | grep -q "driver"; then
                num=$(find "$var" -name ${DEP_HAL_NAME} 2> /dev/null | wc -l)
                if [ "$num" -gt "0" ]; then
                    IS_INSTALL_DRIVER="y"
                fi
            fi
        fi
    done
fi

# 第一种方案判断驱动包是否存在
if [ -f "$DEP_INFO_FILE" ]; then
    driver_install_path_param="$(grep -iw driver_install_path_param $DEP_INFO_FILE | cut --only-delimited -d"=" -f2-)"
    if [ ! -z "${driver_install_path_param}" ]; then
        DEP_PKG_VER_FILE="${driver_install_path_param}/driver"
        if [ -d "${DEP_PKG_VER_FILE}" ]; then
            DEP_HAL_PATH=$(find "${DEP_PKG_VER_FILE}" -name "${DEP_HAL_NAME}" 2> /dev/null)
            if [ ! -z "${DEP_HAL_PATH}" ]; then
                IS_INSTALL_DRIVER="y"
            fi
        fi
    fi
fi

# 第二种方案判断驱动包是否存在
case ":$PATH:" in
    *:/sbin:*) ;;
    *) export PATH="$PATH:/sbin" ;;
esac

# 检查 ldconfig 是否存在，并查找指定库
if command -v ldconfig > /dev/null; then
    if ldconfig -p | grep -q -- "${DEP_HAL_NAME}"; then
        IS_INSTALL_DRIVER="y"
    fi
fi

if command -v arch > /dev/null; then
    architecture="$(arch)"
else
    architecture="$(uname -m)"
fi
INSTALL_DIR="$(get_install_dir)/cann"
prepend_env PATH "$INSTALL_DIR/bin:$INSTALL_DIR/tools/ccec_compiler/bin:$INSTALL_DIR/tools/profiler/bin:$INSTALL_DIR/tools/ascend_system_advisor/asys:$INSTALL_DIR/tools/show_kernel_debug_data:$INSTALL_DIR/tools/msobjdump"
prepend_env LD_LIBRARY_PATH "$INSTALL_DIR/lib64:$INSTALL_DIR/lib64/plugin/opskernel:$INSTALL_DIR/lib64/plugin/nnengine:$INSTALL_DIR/opp/built-in/op_impl/ai_core/tbe/op_tiling/lib/linux/$architecture:$INSTALL_DIR/tools/aml/lib64:$INSTALL_DIR/tools/aml/lib64/plugin"
export PYTHONPATH="$INSTALL_DIR/python/site-packages:$INSTALL_DIR/opp/built-in/op_impl/ai_core/tbe:$PYTHONPATH"
export ASCEND_OPP_PATH="$INSTALL_DIR/opp"

if [ "${IS_INSTALL_DRIVER}" = "n" ]; then
    append_env LD_LIBRARY_PATH "$INSTALL_DIR/devlib"
fi

export ASCEND_AICPU_PATH="$INSTALL_DIR"
export TOOLCHAIN_HOME="$INSTALL_DIR/toolkit"
export ASCEND_HOME_PATH="$INSTALL_DIR"
export ASCEND_TOOLKIT_HOME="$INSTALL_DIR"

lib_path="${INSTALL_DIR}/pyACL/python/site-packages/acl"
if [ -d "${lib_path}" ]; then
    prepend_env PYTHONPATH "$lib_path"
fi

custom_path_file="$INSTALL_DIR/conf/path.cfg"
common_interface="$curpath/../script/common_interface.bash"
owner=$(stat -c %U "$curfile")
if [ $(id -u) -ne 0 ] && [ "$owner" != "$(whoami)" ] && [ -f "$custom_path_file" ] && [ -f "$common_interface" ]; then
    . "$common_interface"
    mk_custom_path "$custom_path_file"
fi
prepend_env "CMAKE_PREFIX_PATH" "$INSTALL_DIR/lib64/cmake"
prepend_env "CMAKE_PREFIX_PATH" "$INSTALL_DIR/toolkit/tools/tikicpulib/lib/cmake"
