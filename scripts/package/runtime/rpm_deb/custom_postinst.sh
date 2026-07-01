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

sourcedir="${INSTALL_PATH}"
pkg_arch_name="${PKG_ARCH_NAME}"

stub_libs="
 	 libacl_rt.so
 	 libacl_tdt_channel.so
 	 libacl_tdt_queue.so
 	 libacl_prof.so
 	 libplatform.so
 	 liberror_manager.so
 	 libascend_hal.so
 	 libascendcl.so"

add_prereq_script_file() {
    local install_path="${sourcedir}"
    if [ ! -d "$install_path" ]; then
        return
    fi
    rm -f "${install_path}/device-npu-runtime.tar.gz"
    local src_bindir="${install_path}/share/info/runtime/bin"
    local bindir="${install_path}/${pkg_arch_name}-linux/bin"
    if [ -d "${src_bindir}" ] && [ -d "${bindir}" ]; then
        for prereq_file in prereq_check.bash prereq_check.csh prereq_check.fish; do
            local src_file="${src_bindir}/${prereq_file}"
            local dst_file="${bindir}/${prereq_file}"
            local shell_name="${prereq_file##*.}"
            [ -f "${src_file}" ] || continue
            [ -e "${dst_file}" ] && continue
            printf '#!/usr/bin/env %s\n%s\n' "${shell_name}" "${src_file}" > "${dst_file}"
            chmod 555 "${dst_file}" > /dev/null 2>&1
        done
    fi
}
 	 
create_stub_softlink() {
    local install_path="${sourcedir}"
    if [ ! -d "$install_path" ]; then
        return
    fi
    local devlibdir="${install_path}/${pkg_arch_name}-linux/devlib"
    if [ -d "${devlibdir}" ]; then
        (cd "${devlibdir}" && {
            chmod u+w . && \
            for lib in ${stub_libs}; do
                lib="linux/${pkg_arch_name}/$lib"
                [ -f "$lib" ] && ln -sf "$lib" "$(basename $lib)"
            done
            chmod u-w .
        })
    fi
}

get_dir_mod() {
    local path="$1"
    if [ -e "$path" ]; then
        stat -c %a "$path"
    fi
}

gen_acl_header() {
    local header="$1"
    local mod="$2"
    local bname="$(basename $header)"
    if [ "$bname" = "acl_base_mdl.h" ] || [ "$bname" = "acl_mdl.h" ]; then
        cat - << 'EOF' > "$header" 2> /dev/null
/*!
 * This is an empty file, included for compatibility with old version.
 * If you want to use aclmdl api, please install the corresponding package to overrite this file.
 * */
EOF
    elif [ "$bname" = "acl_op.h" ]; then
        cat - << 'EOF' > "$header" 2> /dev/null
/*!
 * This is an empty file, included for compatibility with old version.
 * If you want to use aclop api, please install the corresponding package to overrite this file.
 * */
EOF
    fi
    if [ -n "$mod" ]; then
        chmod "$mod" "$header" > /dev/null 2>&1
    fi
}

create_acl_empty_headers() {
    local install_path="${sourcedir}"
    local acl_headers_dir="${install_path}/${pkg_arch_name}-linux/include/acl"
    if [ ! -d "$acl_headers_dir" ]; then
        return
    fi

    (
        cleanup_acl_headers_dir() {
            local ret=$?
            chmod u-w "$acl_headers_dir" > /dev/null 2>&1 || ret=1
            exit "$ret"
        }

        trap cleanup_acl_headers_dir EXIT
        chmod u+w "$acl_headers_dir"
        local ref_header="$(find "$acl_headers_dir" -maxdepth 1 -type f -name "*.h" | head -1)"
        local mod="$(get_dir_mod "$ref_header" 2> /dev/null)"
        for header in acl_base_mdl.h acl_mdl.h acl_op.h; do
            gen_acl_header "${acl_headers_dir}/${header}" "$mod"
        done
    )
}

process_acl_empty_headers() {
    local install_path="${sourcedir}"
    if [ ! -e "$install_path/share/info/ge-executor/version.info" ] && \
       [ ! -e "$install_path/share/info/ge-executor/ascend_install.info" ]; then
        create_acl_empty_headers
    fi
}

add_prereq_script_file
create_stub_softlink
process_acl_empty_headers
