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

export SLOG_PRINT_TO_STDOUT=1
export ASCEND_SLOG_PRINT_TO_STDOUT=1
export ASCEND_GLOBAL_LOG_LEVEL=2

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARAM_FILE="${SCRIPT_DIR}/../pre-smoking-testcase"
RTS_PACKAGE_URL_910B="https://ascend-ci.obs.cn-north-4.myhuaweicloud.com/package/master/latest/aarch64/910b-testcase-9.3.0-aarch64.tar.gz"
RTS_PACKAGE_URL_950="https://ascend-ci.obs.cn-north-4.myhuaweicloud.com/package/master/20261116010020/aarch64/A5-testcase-9.3.0-aarch64.tar.gz"
RTS_PACKAGE_URL=""
EXTRACT_DIR=""
RTS_LIB_ROOT=""

cleanup() {
  :
}

resolve_rts_package_url() {
  local npu_info=""
  local chip_name=""

  if ! command -v npu-smi >/dev/null 2>&1; then
    echo "npu-smi is required to detect the NPU chip type" >&2
    return 1
  fi
  if ! npu_info="$(npu-smi info)"; then
    echo "Failed to query NPU chip type with npu-smi info" >&2
    return 1
  fi

  # Older output combines NPU ID and Name; newer output separates them with '|'.
  chip_name="$(awk -F '|' '
    $2 ~ /^[[:space:]]*[0-9]+[[:space:]]/ {
      name = $2
      sub(/^[[:space:]]*[0-9]+[[:space:]]*/, "", name)
      if (name == "") name = $3
      gsub(/[[:space:]]/, "", name)
      print name
      exit
    }
  ' <<< "${npu_info}")"

  case "${chip_name}" in
    910B*|Ascend910B*)
      RTS_PACKAGE_URL="${RTS_PACKAGE_URL_910B}"
      ;;
    950*|Ascend950*)
      RTS_PACKAGE_URL="${RTS_PACKAGE_URL_950}"
      ;;
    *)
      echo "Unsupported or undetected NPU chip type: ${chip_name:-unknown}" >&2
      return 1
      ;;
  esac
  echo "Detected NPU chip type: ${chip_name}" >&2
}

download_file() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${url}" -o "${output}"
    return $?
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "${output}" "${url}"
    return $?
  fi

  echo "Neither curl nor wget is available for downloading ${url}" >&2
  return 1
}

resolve_rts_bin() {
  local archive_path=""
  local rtstest_path=""

  EXTRACT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
  RTS_LIB_ROOT="${EXTRACT_DIR}"
  archive_path="${EXTRACT_DIR}/package.tar.gz"

  echo "Downloading rtstest package from ${RTS_PACKAGE_URL}" >&2
  download_file "${RTS_PACKAGE_URL}" "${archive_path}" || return 1

  echo "Extracting ${archive_path}" >&2
  tar -xzf "${archive_path}" -C "${EXTRACT_DIR}" || return 1

  rtstest_path="${EXTRACT_DIR}/rtstest_host"
  if [[ ! -x "${rtstest_path}" ]]; then
    rtstest_path="$(find "${EXTRACT_DIR}" -type f -name rtstest_host -perm -u+x | head -n 1)"
  fi
  if [[ -z "${rtstest_path}" ]]; then
    echo "rtstest_host not found in extracted package" >&2
    return 1
  fi

  echo "${rtstest_path}"
}

run_once() {
  local rts_bin="$1"
  local rts_dir
  shift
  local args=("$@")
  local extra_ld_library_path=""

  rts_dir="$(cd "$(dirname "${rts_bin}")" && pwd)"
  extra_ld_library_path="$(find "${RTS_LIB_ROOT:-${rts_dir}}" -type f -name '*.so*' -printf '%h\n' 2>/dev/null | sort -u | paste -sd ':' -)"

  if [[ -n "${extra_ld_library_path}" ]]; then
    extra_ld_library_path="${extra_ld_library_path}:"
  fi

  echo "execute: ${rts_bin} ${args[*]}"
  LD_LIBRARY_PATH="${rts_dir}:${extra_ld_library_path}${SCRIPT_DIR}:${SCRIPT_DIR}/lib:${LD_LIBRARY_PATH:-}" \
    "${rts_bin}" "${args[@]}"
  local rc=$?

  if [[ ${rc} -ne 0 ]]; then
    echo "Failed: args [${args[*]}], exit code ${rc}" >&2
  fi

  return ${rc}
}

main() {
  local fail_count=0
  local total_count=0
  local param_file="${PARAM_FILE}"
  local rts_bin_path=""

  resolve_rts_package_url || exit 1
  rts_bin_path="$(resolve_rts_bin)" || exit 1

  if [[ ! -x "${rts_bin_path}" ]]; then
    echo "Executable not found or not executable: ${rts_bin_path}" >&2
    exit 1
  fi

  if [[ ! -f "${param_file}" ]]; then
    echo "Parameter file not found: ${param_file}" >&2
    exit 1
  fi

  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ -z "${line//[[:space:]]/}" ]]; then
      continue
    fi

    if [[ "${line}" == \#* ]]; then
      continue
    fi

    total_count=$((total_count + 1))
    run_once "${rts_bin_path}" "${line}"
    if [[ $? -ne 0 ]]; then
      fail_count=$((fail_count + 1))
    fi
  done < "${param_file}"
  echo "Execution complete: total=${total_count}, failed=${fail_count}"
  if [[ ${fail_count} -ne 0 ]]; then
    exit 1
  fi

  echo "Run all examples success"
  exit 0
}

trap cleanup EXIT

main "$@"
