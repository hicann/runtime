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

run_once() {
  local rts_bin="$1"
  shift
  local args=("$@")

  echo "execute: ${rts_bin} ${args[*]}"
  LD_LIBRARY_PATH="${SCRIPT_DIR}:${SCRIPT_DIR}/lib:${LD_LIBRARY_PATH:-}" \
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
  local rts_bin=""

  if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <rtstest_host_path>" >&2
    exit 1
  fi

  rts_bin="$1"
  shift

  if [[ ! -x "${rts_bin}" ]]; then
    echo "Executable not found or not executable: ${rts_bin}" >&2
    exit 1
  fi

  if [[ $# -ge 2 && "$1" == "--param-file" ]]; then
    param_file="$2"
    shift 2
  fi

  if [[ $# -gt 0 ]]; then
    total_count=1
    run_once "${rts_bin}" "$@"
    fail_count=$(( $? != 0 ? 1 : 0 ))
  else
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
      run_once "${rts_bin}" "${line}"
      if [[ $? -ne 0 ]]; then
        fail_count=$((fail_count + 1))
      fi
    done < "${param_file}"
  fi

  echo "Execution complete: total=${total_count}, failed=${fail_count}"
  if [[ ${fail_count} -ne 0 ]]; then
    exit 1
  fi

  echo "Run all examples success"
  exit 0
}

main "$@"
