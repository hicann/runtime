# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

append_env() {
    local name="$1"
    local value="$2"
    local env_value="$(eval echo "\${${name}}")"

    if [ "$env_value" = "" ]; then
        read -r $name <<EOF
$value
EOF
    else
        read -r $name <<EOF
$env_value:$value
EOF
    fi
    export $name
}

prepend_env() {
    local name="$1"
    local value="$2"
    local env_value="$(eval echo "\${${name}}")"

    if [ "$env_value" = "" ]; then
        read -r $name <<EOF
$value
EOF
    else
        read -r $name <<EOF
$value:$env_value
EOF
    fi
    export $name
}

remove_env() {
    local name="$1"
    local regex="$2"
    local env_value="$(eval echo "\${${name}}")"

    read -r $name <<EOF
$(echo "${env_value}" | tr ':' '\n' | grep -v -E "${regex}" | tr '\n' ':' | sed 's/:$//')
EOF
    export $name
}

setenv_main() {
    local version_dirpath install_dirpath ld_library_path path driver_install_path_param dep_hal_path
    local dep_hal_name="libascend_hal.so"
    local dep_info_file="/etc/ascend_install.info"
    local is_install_driver="n"
    local architecture remove_regex
    if [ "$BASH_SOURCE" = "" ]; then
        echo "error: BASH_SOURCE is empty, Please confirm that the current shell is bash."
        return 1
    fi

    version_dirpath="$(dirname "$(readlink -f "$BASH_SOURCE")")"
    install_dirpath="$(dirname "$version_dirpath")"

    remove_regex="^${install_dirpath}/cann[/_-]"
    remove_env "PATH" "$remove_regex"
    remove_env "LD_LIBRARY_PATH" "$remove_regex"
    remove_env "PYTHONPATH" "$remove_regex"

    # 判断driver包是否存在
    ld_library_path="$LD_LIBRARY_PATH"
    if [ ! -z "$ld_library_path" ]; then
        ld_library_path="$(echo "$ld_library_path" | tr ':' ' ')"
        for path in ${ld_library_path}; do
            if echo "$path" | grep -q "driver"; then
                if [ -d "$path" ]; then
                    dep_hal_path="$(find "$path" -name "$dep_hal_name" 2> /dev/null)"
                    if [ ! -z "${dep_hal_path}" ]; then
                        is_install_driver="y"
                    fi
                fi
            fi
        done
    fi

    if [ -f "$dep_info_file" ]; then
        driver_install_path_param="$(grep -iw driver_install_path_param $dep_info_file | cut --only-delimited -d"=" -f2-)"
        if [ ! -z "${driver_install_path_param}" ]; then
            path="${driver_install_path_param}/driver"
            if [ -d "$path" ]; then
                dep_hal_path="$(find "$path" -name "$dep_hal_name" 2> /dev/null)"
                if [ ! -z "${dep_hal_path}" ]; then
                    is_install_driver="y"
                fi
            fi
        fi
    fi

    case ":$PATH:" in
        *:/sbin:*) ;;
        *) export PATH="$PATH:/sbin" ;;
    esac

    # 检查 ldconfig 是否存在，并查找指定库
    if command -v ldconfig > /dev/null; then
        if ldconfig -p | grep -q -- "$dep_hal_name"; then
            is_install_driver="y"
        fi
    fi

    if command -v arch > /dev/null; then
        architecture="$(arch)"
    else
        architecture="$(uname -m)"
    fi

    prepend_env "PATH" "$version_dirpath/bin:$version_dirpath/tools/ccec_compiler/bin:$version_dirpath/tools/profiler/bin:$version_dirpath/tools/ascend_system_advisor/asys:$version_dirpath/tools/show_kernel_debug_data:$version_dirpath/tools/msobjdump"
    prepend_env "LD_LIBRARY_PATH" "$version_dirpath/lib64:$version_dirpath/lib64/plugin/opskernel:$version_dirpath/lib64/plugin/nnengine:$version_dirpath/opp/built-in/op_impl/ai_core/tbe/op_tiling/lib/linux/$architecture:$version_dirpath/tools/aml/lib64:$version_dirpath/tools/aml/lib64/plugin:/usr/local/Ascend/driver/lib64:/usr/local/Ascend/driver/lib64/common:/usr/local/Ascend/driver/lib64/driver"
    # make compatibility with older versions of behavior
    export PYTHONPATH="$version_dirpath/python/site-packages:$version_dirpath/opp/built-in/op_impl/ai_core/tbe:$PYTHONPATH"

    if [ "$is_install_driver" = "n" ]; then
        append_env "LD_LIBRARY_PATH" "$version_dirpath/devlib"
    fi

    export ASCEND_OPP_PATH="$version_dirpath/opp"
    export ASCEND_AICPU_PATH="$version_dirpath"
    export TOOLCHAIN_HOME="$version_dirpath/toolkit"
    export ASCEND_HOME_PATH="$version_dirpath"
    export ASCEND_TOOLKIT_HOME="$version_dirpath"
    prepend_env "CMAKE_PREFIX_PATH" "$version_dirpath/lib64/cmake"
    prepend_env "CMAKE_PREFIX_PATH" "$version_dirpath/toolkit/tools/tikicpulib/lib/cmake"
}

setenv_main "$@"
