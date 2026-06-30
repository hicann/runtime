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

_set_soc_shell_options="$(set +o)"
set -euo pipefail

_set_soc_usage() {
    echo "Usage:"
    echo "  source example/set_sample_env.sh"
    echo ""
    echo "Options:"
    echo "  -h, --help    Print this message."
}

_set_soc_finish() {
    local ret="$1"
    local shell_options="${_set_soc_shell_options}"

    unset -f _set_soc_usage _set_soc_finish _set_soc_normalize _set_soc_is_valid _set_soc_get_arch_dir \
        _set_soc_append_layout_candidate _set_soc_resolve_cann_layout _set_soc_select_cann_path \
        _set_soc_need_build_helper _set_soc_build_helper _set_soc_detect_by_acl _set_soc_append_ascendc_candidate \
        _set_soc_detect_ascendc_cmake_dir _set_soc_main
    unset _set_soc_ret _set_soc_acl_error _set_soc_cann_path _set_soc_include_dir _set_soc_lib_dir \
        _set_soc_detected_version _set_soc_layout_candidates _set_soc_ascendc_candidates \
        _set_soc_shell_options

    eval "${shell_options}"
    if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
        return "${ret}"
    fi
    exit "${ret}"
}

_set_soc_normalize() {
    printf "%s" "$1" | tr -d "[:space:]"
}

_set_soc_is_valid() {
    [[ -n "$1" && "$1" =~ ^[A-Za-z0-9_]+$ ]]
}

_set_soc_get_arch_dir() {
    local machine

    machine="$(uname -m 2>/dev/null || true)"
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

_set_soc_append_layout_candidate() {
    local include_dir="$1"
    local lib_dir="$2"
    local pair="${include_dir}|${lib_dir}"
    local item

    for item in "${_set_soc_layout_candidates[@]}"; do
        [[ "${item}" == "${pair}" ]] && return 0
    done
    _set_soc_layout_candidates+=("${pair}")
}

_set_soc_resolve_cann_layout() {
    local cann_path="$1"
    local machine
    local arch_dir
    local candidate
    local include_dir
    local lib_dir

    _set_soc_include_dir=""
    _set_soc_lib_dir=""
    _set_soc_layout_candidates=()

    # Prefer the generic toolkit layout first, then host-architecture libraries.
    # CANN packages may expose host dev libraries under a target directory such as
    # aarch64-linux/devlib/linux/x86_64, so check that layout before target lib64.
    _set_soc_append_layout_candidate "${cann_path}/include" "${cann_path}/lib64"
    machine="$(uname -m 2>/dev/null || true)"
    arch_dir="$(_set_soc_get_arch_dir)"
    if [[ -n "${arch_dir}" ]]; then
        _set_soc_append_layout_candidate "${cann_path}/${arch_dir}/include" "${cann_path}/${arch_dir}/lib64"
        _set_soc_append_layout_candidate "${cann_path}/${arch_dir}/include" \
            "${cann_path}/${arch_dir}/devlib/linux/${machine}"
        _set_soc_append_layout_candidate "${cann_path}/${arch_dir}/include" "${cann_path}/${arch_dir}/devlib"
    fi
    if [[ -n "${machine}" ]]; then
        _set_soc_append_layout_candidate "${cann_path}/aarch64-linux/include" \
            "${cann_path}/aarch64-linux/devlib/linux/${machine}"
        _set_soc_append_layout_candidate "${cann_path}/x86_64-linux/include" \
            "${cann_path}/x86_64-linux/devlib/linux/${machine}"
    fi
    _set_soc_append_layout_candidate "${cann_path}/aarch64-linux/include" "${cann_path}/aarch64-linux/lib64"
    _set_soc_append_layout_candidate "${cann_path}/x86_64-linux/include" "${cann_path}/x86_64-linux/lib64"

    for candidate in "${_set_soc_layout_candidates[@]}"; do
        include_dir="${candidate%%|*}"
        lib_dir="${candidate#*|}"
        if [[ -f "${include_dir}/acl/acl.h" && -f "${lib_dir}/libacl_rt.so" ]]; then
            _set_soc_include_dir="${include_dir}"
            _set_soc_lib_dir="${lib_dir}"
            return 0
        fi
    done
    return 1
}

_set_soc_select_cann_path() {
    local path
    local candidates=()

    [[ -n "${ASCEND_INSTALL_PATH:-}" ]] && candidates+=("${ASCEND_INSTALL_PATH}")
    [[ -n "${ASCEND_HOME_PATH:-}" ]] && candidates+=("${ASCEND_HOME_PATH}")
    candidates+=("/usr/local/Ascend/cann")

    for path in "${candidates[@]}"; do
        if [[ -d "${path}" ]] && _set_soc_resolve_cann_layout "${path}"; then
            _set_soc_cann_path="${path}"
            return 0
        fi
    done

    _set_soc_acl_error="Cannot find acl/acl.h and libacl_rt.so under ASCEND_INSTALL_PATH, ASCEND_HOME_PATH or /usr/local/Ascend/cann."
    return 1
}

_set_soc_need_build_helper() {
    local src="$1"
    local bin="$2"

    [[ ! -x "${bin}" || "${src}" -nt "${bin}" ]]
}

_set_soc_build_helper() {
    local script_dir="$1"
    local helper_dir="${script_dir}/tools/get_soc_version"
    local src="${helper_dir}/get_soc_version.cpp"
    local build_dir="${helper_dir}/build"
    local bin="${build_dir}/get_soc_version"
    local tmp_bin="${bin}.$$"
    local build_output
    local -a compile_cmd

    if [[ ! -f "${src}" ]]; then
        _set_soc_acl_error="ACL helper source does not exist: ${src}."
        return 1
    fi

    # Resolve CANN include/lib directories before compiling. The selected layout
    # matches the current host architecture, so x86_64 hosts use x86_64 libs and
    # aarch64 hosts use aarch64 libs when both layouts are present. This is also
    # needed when reusing an existing helper because ASCENDC_CMAKE_DIR is derived
    # from the same CANN root.
    if ! _set_soc_select_cann_path; then
        return 1
    fi

    # Rebuild only when the binary is missing or the helper source changed.
    if ! _set_soc_need_build_helper "${src}" "${bin}"; then
        return 0
    fi

    if ! command -v g++ >/dev/null 2>&1; then
        _set_soc_acl_error="g++ is not found."
        return 1
    fi

    if ! mkdir -p "${build_dir}"; then
        _set_soc_acl_error="Failed to create build directory: ${build_dir}."
        return 1
    fi

    compile_cmd=(
        g++ -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -O2
        -I"${_set_soc_include_dir}"
        "${src}"
        -L"${_set_soc_lib_dir}"
        -lacl_rt
        "-Wl,-rpath,${_set_soc_lib_dir}"
        -o "${tmp_bin}"
    )

    if ! build_output="$("${compile_cmd[@]}" 2>&1)"; then
        rm -f "${tmp_bin}"
        _set_soc_acl_error="Build ACL helper failed: ${build_output}"
        return 1
    fi

    if ! mv "${tmp_bin}" "${bin}"; then
        rm -f "${tmp_bin}"
        _set_soc_acl_error="Failed to update ACL helper binary: ${bin}."
        return 1
    fi
    return 0
}

_set_soc_detect_by_acl() {
    local script_dir="$1"
    local bin="${script_dir}/tools/get_soc_version/build/get_soc_version"
    local output
    local soc_version

    # tiny helper binary bridges the Runtime ACL API for Shell and prints the SOC_VERSION string.
    if ! _set_soc_build_helper "${script_dir}"; then
        return 1
    fi

    if ! output="$("${bin}" 2>&1)"; then
        _set_soc_acl_error="Run ACL helper failed: ${output}"
        return 1
    fi

    soc_version="$(printf "%s\n" "${output}" | awk '/^[A-Za-z0-9_]+$/ { print; exit }')"
    soc_version="$(_set_soc_normalize "${soc_version}")"
    if _set_soc_is_valid "${soc_version}"; then
        _set_soc_detected_version="${soc_version}"
        return 0
    fi

    _set_soc_acl_error="ACL helper returned invalid SOC_VERSION: ${output}"
    return 1
}

_set_soc_append_ascendc_candidate() {
    local cmake_dir="$1"
    local item

    for item in "${_set_soc_ascendc_candidates[@]}"; do
        [[ "${item}" == "${cmake_dir}" ]] && return 0
    done
    _set_soc_ascendc_candidates+=("${cmake_dir}")
}

_set_soc_detect_ascendc_cmake_dir() {
    local cann_path="$1"
    local machine
    local arch_dir
    local cmake_dir

    _set_soc_ascendc_candidates=()
    machine="$(uname -m 2>/dev/null || true)"
    arch_dir="$(_set_soc_get_arch_dir)"

    # ASCENDC_CMAKE_DIR follows the same architecture split as ACL libraries.
    # Check host architecture first, then common CANN package layouts.
    if [[ -n "${arch_dir}" ]]; then
        _set_soc_append_ascendc_candidate "${cann_path}/${arch_dir}/tikcpp/ascendc_kernel_cmake"
    fi
    if [[ -n "${machine}" ]]; then
        _set_soc_append_ascendc_candidate "${cann_path}/aarch64-linux/tikcpp/ascendc_kernel_cmake"
        _set_soc_append_ascendc_candidate "${cann_path}/x86_64-linux/tikcpp/ascendc_kernel_cmake"
    fi
    _set_soc_append_ascendc_candidate "${cann_path}/tikcpp/ascendc_kernel_cmake"

    for cmake_dir in "${_set_soc_ascendc_candidates[@]}"; do
        if [[ -f "${cmake_dir}/ascendc.cmake" ]]; then
            printf "%s" "${cmake_dir}"
            return 0
        fi
    done
    return 1
}

_set_soc_main() {
    local script_dir
    local soc_version=""
    local ascendc_cmake_dir=""
    local sourced=0

    [[ "${BASH_SOURCE[0]}" != "$0" ]] && sourced=1

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                _set_soc_usage
                return 0
                ;;
            *)
                echo "[ERROR]: Unknown option $1."
                _set_soc_usage
                return 1
                ;;
        esac
    done

    if ! script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; then
        echo "[ERROR]: Failed to get script directory."
        return 1
    fi

    _set_soc_detected_version=""
    if _set_soc_detect_by_acl "${script_dir}"; then
        soc_version="${_set_soc_detected_version}"
    fi

    if ! _set_soc_is_valid "${soc_version}"; then
        echo "[ERROR]: Failed to get SOC_VERSION by aclrtGetSocName. ${_set_soc_acl_error}"
        return 1
    fi

    ascendc_cmake_dir="$(_set_soc_detect_ascendc_cmake_dir "${_set_soc_cann_path}")" || true
    if [[ -z "${ascendc_cmake_dir}" ]]; then
        echo "[ERROR]: Failed to find ascendc.cmake under ${_set_soc_cann_path}."
        return 1
    fi

    export ASCEND_INSTALL_PATH="${_set_soc_cann_path}"
    export ASCEND_HOME_PATH="${_set_soc_cann_path}"
    export SOC_VERSION="${soc_version}"
    export ASCENDC_CMAKE_DIR="${ascendc_cmake_dir}"
    if [[ "${sourced}" -eq 1 ]]; then
        echo "[INFO]: ASCEND_INSTALL_PATH is set to ${ASCEND_INSTALL_PATH}"
        echo "[INFO]: ASCEND_HOME_PATH is set to ${ASCEND_HOME_PATH}"
        echo "[INFO]: SOC_VERSION is set to ${SOC_VERSION}"
        echo "[INFO]: ASCENDC_CMAKE_DIR is set to ${ASCENDC_CMAKE_DIR}"
    else
        echo "ASCEND_INSTALL_PATH=${ASCEND_INSTALL_PATH}"
        echo "ASCEND_HOME_PATH=${ASCEND_HOME_PATH}"
        echo "SOC_VERSION=${SOC_VERSION}"
        echo "ASCENDC_CMAKE_DIR=${ASCENDC_CMAKE_DIR}"
        echo "[INFO]: To export variables in current shell, run: source ${BASH_SOURCE[0]}"
    fi
    return 0
}

if _set_soc_main "$@"; then
    _set_soc_ret=0
else
    _set_soc_ret=$?
fi
_set_soc_finish "${_set_soc_ret}"
