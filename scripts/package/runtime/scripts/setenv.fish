#!/usr/bin/fish
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set -g curpath (realpath (dirname (status --current-filename)))
set -g curfile (realpath (status --current-filename))
set -g DEP_HAL_NAME "libascend_hal.so"
set -g DEP_INFO_FILE "/etc/ascend_install.info"
set -g IS_INSTALL_DRIVER "n"
set -g param_mult_ver $argv[1]

function get_install_param
    set -l _key $argv[1]
    set -l _file $argv[2]
    if not test -f "$_file"
        exit 1
    end
    set -l install_info_key_array Runtime_Install_Type Runtime_Feature_Type Runtime_UserName Runtime_UserGroup Runtime_Install_Path_Param Runtime_Arch_Linux_Path Runtime_Hetero_Arch_Flag
    for key_param in $install_info_key_array
        if test "$key_param" = "$_key"
            grep -i "$_key=" "$_file" | cut --only-delimited -d"=" -f2-
            break
        end
    end
end

function get_install_dir
    set -l install_info "$curpath/../ascend_install.info"
    set -l hetero_arch (get_install_param "Runtime_Hetero_Arch_Flag" "$install_info")
    if test "$param_mult_ver" = "multi_version"
        if test "$hetero_arch" = "y"
            echo (realpath $curpath/../../../../../latest)/runtime
        else
            echo (realpath $curpath/../../../latest)/runtime
        end
    else
        echo (realpath $curpath/..)
    end
end

set -l INSTALL_DIR (get_install_dir)
set -l lib_stub_path "$INSTALL_DIR/lib64/stub"
set -l lib_path "$INSTALL_DIR/lib64"
set -l ld_library_path "$LD_LIBRARY_PATH"
if not test -z "$ld_library_path"
    for var in (echo "$ld_library_path" | tr ":" "\n")
        if test -d "$var"
            if echo "$var" | grep -q "driver"
                set -l num (find "$var" -name $DEP_HAL_NAME 2> /dev/null | wc -l)
                if test "$num" -gt "0"
                    set -g IS_INSTALL_DRIVER "y"
                    break
                end
            end
        end
    end
end

# 第一种方案判断驱动包是否存在
if test -f "$DEP_INFO_FILE"
    set -l driver_install_path_param (grep -iw driver_install_path_param $DEP_INFO_FILE | cut --only-delimited -d= -f2-)
    if not test -z "$driver_install_path_param"
        set -l DEP_PKG_VER_FILE "$driver_install_path_param/driver"
        if test -d "$DEP_PKG_VER_FILE"
            set -l DEP_HAL_PATH (find $DEP_PKG_VER_FILE -name "$DEP_HAL_NAME" 2> /dev/null)
            if not test -z "$DEP_HAL_PATH"
                set -g IS_INSTALL_DRIVER "y"
            end
        end
    end
end

# 第二种方案判断驱动包是否存在
if not echo :$PATH: | grep -q :/sbin:
    set -gx PATH $PATH /sbin
end

if which ldconfig > /dev/null 2>&1
    if ldconfig -p | grep -q "$DEP_HAL_NAME"
        set -g IS_INSTALL_DRIVER "y"
    end
end

if test "$IS_INSTALL_DRIVER" = "n"
    if test -d "$lib_path"
        set -l ld_library_path "$LD_LIBRARY_PATH"
        set -l num (echo ":$ld_library_path:" | grep ":$lib_stub_path:" | wc -l)
        if test "$num" -eq 0
            if test "-$ld_library_path" = "-"
                set -gx LD_LIBRARY_PATH "$lib_stub_path"
            else
                set -gx LD_LIBRARY_PATH "$ld_library_path:$lib_stub_path"
            end
        end
    end
end

if test -d "$lib_path"
    set -l ld_library_path "$LD_LIBRARY_PATH"
    set -l num (echo ":$ld_library_path:" | grep ":$lib_path:" | wc -l)
    if test "$num" -eq 0
        if test "-$ld_library_path" = "-"
            set -gx LD_LIBRARY_PATH "$lib_path"
        else
            set -gx LD_LIBRARY_PATH "$lib_path:$ld_library_path"
        end
    end
end

set -l custom_path_file "$INSTALL_DIR/../conf/path.cfg"
set -l common_interface "$INSTALL_DIR/script/common_interface.fish"
set -l owner (stat -c \%U "$curfile")
if test (id -u) -ne 0 -a (id -un) != "$owner" -a -f "$custom_path_file" -a -f "$common_interface"
    . "$common_interface"
    mk_custom_path "$custom_path_file"
end
