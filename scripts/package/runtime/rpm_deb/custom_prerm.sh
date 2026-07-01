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

remove_runtime_prereq_file() {
    local prereq_file="$1"
    [ -f "${prereq_file}" ] || return 0
    grep -q "share/info/runtime" "${prereq_file}" || return 0

    local file_mod="$(stat -c %a "${prereq_file}" 2> /dev/null)"
    local tmp_file="${prereq_file}.tmp.$$"
    grep -v "share/info/runtime" "${prereq_file}" > "${tmp_file}" || true
    if grep -v -E '^[[:space:]]*$|^#!' "${tmp_file}" | grep -q .; then
        chmod u+w "${prereq_file}" > /dev/null 2>&1
        cat "${tmp_file}" > "${prereq_file}"
        [ -n "${file_mod}" ] && chmod "${file_mod}" "${prereq_file}" > /dev/null 2>&1
    else
        rm -f "${prereq_file}"
    fi
    rm -f "${tmp_file}"
}

remove_prereq_script_file() {
    local install_path="${sourcedir}"
    if [ ! -d "$install_path" ]; then
        return
    fi
    local bindir="${install_path}/${pkg_arch_name}-linux/bin"
    if [ -d "${bindir}" ]; then
        for prereq_file in prereq_check.bash prereq_check.csh prereq_check.fish; do
            remove_runtime_prereq_file "${bindir}/${prereq_file}"
        done
    fi
}

remove_stub_softlink() {
    local install_path="${sourcedir}"
    if [ ! -d "$install_path" ]; then
        return
    fi
    local devlibdir="${install_path}/${pkg_arch_name}-linux/devlib"
    if [ -d "${devlibdir}" ]; then
        (cd "${devlibdir}" && {
            chmod u+w . && echo "${stub_libs}" | xargs --no-run-if-empty rm -rf
            chmod u-w .
        })
    fi
}

remove_acl_empty_headers() {
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
        for header in acl_base_mdl.h acl_mdl.h acl_op.h; do
            rm -rf "${acl_headers_dir}/${header}" > /dev/null 2>&1
        done
    )
}

process_acl_empty_headers() {
    local install_path="${sourcedir}"
    if [ ! -e "$install_path/share/info/ge-executor/version.info" ] && \
       [ ! -e "$install_path/share/info/ge-executor/ascend_install.info" ]; then
        remove_acl_empty_headers
    fi
}

remove_prereq_script_file
remove_stub_softlink
process_acl_empty_headers
