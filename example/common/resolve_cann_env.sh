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

resolve_cann_arch_dir() {
    local machine

    machine="$(uname -m 2>/dev/null)"
    case "${machine}" in
        x86_64|amd64)
            printf "%s" "x86_64-linux"
            ;;
        aarch64|arm64)
            printf "%s" "aarch64-linux"
            ;;
        *)
            printf "%s" ""
            ;;
    esac
}

resolve_cann_has_acl_layout() {
    local cann_path="$1"
    local arch_dir
    local machine
    local include_dir
    local lib_dir
    local candidates=()
    local candidate

    candidates+=("${cann_path}/include|${cann_path}/lib64")
    arch_dir="$(resolve_cann_arch_dir)"
    machine="$(uname -m 2>/dev/null)"
    if [ -n "${arch_dir}" ]; then
        candidates+=("${cann_path}/${arch_dir}/include|${cann_path}/${arch_dir}/lib64")
        candidates+=("${cann_path}/${arch_dir}/include|${cann_path}/${arch_dir}/devlib")
        if [ -n "${machine}" ]; then
            candidates+=("${cann_path}/${arch_dir}/include|${cann_path}/${arch_dir}/devlib/linux/${machine}")
        fi
    fi

    for candidate in "${candidates[@]}"; do
        include_dir="${candidate%%|*}"
        lib_dir="${candidate#*|}"
        if [ -f "${include_dir}/acl/acl.h" ] && [ -f "${lib_dir}/libacl_rt.so" ]; then
            return 0
        fi
    done
    return 1
}

resolve_cann_env() {
    local path
    local set_env_file
    local candidates=()
    local checked_paths=""

    [ -n "${ASCEND_INSTALL_PATH:-}" ] && candidates+=("${ASCEND_INSTALL_PATH}")
    [ -n "${ASCEND_HOME_PATH:-}" ] && candidates+=("${ASCEND_HOME_PATH}")
    [ -n "${HOME:-}" ] && candidates+=("${HOME}/Ascend/cann")
    [ -n "${HOME:-}" ] && candidates+=("${HOME}/Ascend/ascend-toolkit/latest")
    candidates+=("/usr/local/Ascend/cann")
    candidates+=("/usr/local/Ascend/ascend-toolkit/latest")
    candidates+=("/opt/Ascend/cann")

    for path in "${candidates[@]}"; do
        [ -z "${path}" ] && continue
        checked_paths="${checked_paths} ${path}"
        if [ -f "${path}/set_env.sh" ]; then
            set_env_file="${path}/set_env.sh"
        elif [ -f "${path}/bin/setenv.bash" ]; then
            set_env_file="${path}/bin/setenv.bash"
        else
            continue
        fi

        if resolve_cann_has_acl_layout "${path}"; then
            export ASCEND_INSTALL_PATH="${path}"
            export ASCEND_HOME_PATH="${path}"
            # shellcheck source=/dev/null
            source "${set_env_file}" || { echo "[ERROR]: Failed to source ${set_env_file}."; return 1; }
            return 0
        fi
    done

    echo "[ERROR]: Cannot find a usable CANN environment."
    echo "[ERROR]: Checked paths:${checked_paths}"
    echo "[ERROR]: Please run: source <cann_path>/set_env.sh"
    echo "[ERROR]: Or export ASCEND_INSTALL_PATH=<cann_path> before running this sample."
    return 1
}
