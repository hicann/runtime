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

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
PRODUCT_TYPE=""
HOST_ARCH=$(uname -m)
case "${HOST_ARCH}" in
  aarch64|arm64)
    TARGET_ARCH_DIR="aarch64-linux"
    ;;
  x86_64|amd64)
    TARGET_ARCH_DIR="x86_64-linux"
    ;;
  *)
    echo "[FAIL] Unsupported host architecture: ${HOST_ARCH}"
    exit 1
    ;;
esac

SIMULATOR_ROOT_DIR="/home/jenkins/Ascend/cann/${TARGET_ARCH_DIR}/simulator"
TOOLKIT_LIB_DIR="/home/jenkins/Ascend/cann/${TARGET_ARCH_DIR}/lib64"
SIMULATOR_PRODUCT_DIR=""
ASCEND_INSTALL_PATH="${ASCEND_INSTALL_PATH:-${ASCEND_HOME_PATH:-/usr/local/Ascend/cann}}"

usage() {
  echo "Usage:"
  echo "  bash tests/cmodel_test/check_runtime_cmodel_undefined_symbols.sh --product_type=<PRODUCT_TYPE>"
}

fail() {
  echo "[FAIL] $*"
  exit 1
}

parsed_args=$(getopt -a -o h -l help,product_type: -- "$@") || {
  usage
  exit 1
}
eval set -- "$parsed_args"

while true; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --product_type)
      PRODUCT_TYPE="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Undefined option: $1"
      usage
      exit 1
      ;;
  esac
done

if [ -z "${PRODUCT_TYPE}" ]; then
  usage
  fail "--product_type is required"
fi

case "${PRODUCT_TYPE}" in
  ascend910B1)
    SIMULATOR_PRODUCT_DIR="${SIMULATOR_ROOT_DIR}/Ascend910B1"
    ;;
  ascend950pr_9599)
    SIMULATOR_PRODUCT_DIR="${SIMULATOR_ROOT_DIR}/Ascend950PR_9599"
    ;;
  *)
    fail "Unsupported product_type for simulator directory mapping: ${PRODUCT_TYPE}"
    ;;
esac

bash "${SCRIPT_DIR}/build_runtime_cmodel_product.sh" --product_type="${PRODUCT_TYPE}"

BUILD_LIB_DIR="${ROOT_DIR}/build_runtime_cmodel_product/src/runtime/${PRODUCT_TYPE}"
CMODEL_SO="${BUILD_LIB_DIR}/libruntime_cmodel.so"
CAMODEL_SO="${BUILD_LIB_DIR}/libruntime_camodel.so"
DRIVER_LIB_DIR="${ROOT_DIR}/build_runtime_cmodel_product/src/cmodel_driver/${PRODUCT_TYPE}"
PVDRIVER_SO="${DRIVER_LIB_DIR}/libnpu_drv_pvmodel.so"
CADRIVER_SO="${DRIVER_LIB_DIR}/libnpu_drv_camodel.so"
ERROR_MANAGER_SO="${ROOT_DIR}/build_runtime_cmodel_product/src/dfx/error_manager/liberror_manager.so"

if [ ! -f "${CMODEL_SO}" ] || [ ! -f "${CAMODEL_SO}" ] || [ ! -f "${PVDRIVER_SO}" ] || [ ! -f "${CADRIVER_SO}" ] || [ ! -f "${ERROR_MANAGER_SO}" ]; then
  fail "Built runtime cmodel libraries not found under: ${BUILD_LIB_DIR}"
fi

mkdir -p "${SIMULATOR_PRODUCT_DIR}/lib"
cp -f "${CMODEL_SO}" "${SIMULATOR_PRODUCT_DIR}/lib/"
cp -f "${CAMODEL_SO}" "${SIMULATOR_PRODUCT_DIR}/lib/"
cp -f "${PVDRIVER_SO}" "${SIMULATOR_PRODUCT_DIR}/lib/"
cp -f "${CADRIVER_SO}" "${SIMULATOR_PRODUCT_DIR}/lib/"
cp -f "${ERROR_MANAGER_SO}" "${SIMULATOR_PRODUCT_DIR}/lib/"

LIB_DIR="${SIMULATOR_PRODUCT_DIR}/lib"
DRIVER_COMMON_LIB_DIR="/usr/local/Ascend/driver/lib64/common"

if [ -f "${ASCEND_INSTALL_PATH}/bin/setenv.bash" ]; then
  # shellcheck disable=SC1090
  source "${ASCEND_INSTALL_PATH}/bin/setenv.bash"
fi

append_ld_library_path() {
  local path_to_add="$1"
  if [ -n "${path_to_add}" ] && [ -d "${path_to_add}" ]; then
    if [ -n "${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}" ]; then
      RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH="${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}:${path_to_add}"
    else
      RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH="${path_to_add}"
    fi
  fi
}

RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH=""
append_ld_library_path "${LIB_DIR}"
append_ld_library_path "${TOOLKIT_LIB_DIR}"
append_ld_library_path "${ASCEND_INSTALL_PATH}/lib64"
append_ld_library_path "${DRIVER_COMMON_LIB_DIR}"
if [ -n "${LD_LIBRARY_PATH:-}" ]; then
  RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH="${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
fi

check_with_ldd() {
  local so_path="$1"
  local ldd_output
  echo "[CHECK] ldd -r ${so_path}"
  ldd_output=$(LD_LIBRARY_PATH="${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}" ldd -r "${so_path}" 2>&1)
  echo "${ldd_output}"
  if echo "${ldd_output}" | grep -E "undefined symbol|not found" >/dev/null 2>&1; then
    fail "unresolved symbol or dependency detected in ${so_path}"
  fi
}

check_with_dlopen() {
  local so_path="$1"
  echo "[CHECK] dlopen RTLD_NOW ${so_path}"
  LD_LIBRARY_PATH="${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}" python3 - "$so_path" <<'PY'
import ctypes
import os
import sys

so_path = sys.argv[1]

try:
    ctypes.CDLL(so_path, mode=os.RTLD_NOW | os.RTLD_LOCAL)
    print(f"OK: {so_path}")
except OSError as err:
    print(f"[FAIL] {so_path}: {err}")
    sys.exit(1)
PY
}

check_one_so() {
  local so_path="$1"
  [ -f "${so_path}" ] || fail "shared library not found: ${so_path}"
  check_with_ldd "${so_path}" || fail "ldd check failed for ${so_path}"
  LD_LIBRARY_PATH="${RUNTIME_CMODEL_CHECK_LD_LIBRARY_PATH}" check_with_dlopen "${so_path}" || fail "dlopen check failed for ${so_path}"
}

SIMULATOR_SO_LIST=(
  "${LIB_DIR}/libruntime_cmodel.so"
  "${LIB_DIR}/libruntime_camodel.so"
)

TOOLKIT_SO_LIST=(
  "${TOOLKIT_LIB_DIR}/libacl_rt.so"
  "${TOOLKIT_LIB_DIR}/libacl_rt_impl.so"
  "${TOOLKIT_LIB_DIR}/libruntime.so"
  "${TOOLKIT_LIB_DIR}/libruntime_common.so"
  "${TOOLKIT_LIB_DIR}/libruntime_v100.so"
  "${TOOLKIT_LIB_DIR}/libruntime_v200.so"
  "${TOOLKIT_LIB_DIR}/libruntime_v201.so"
)

for so_path in "${SIMULATOR_SO_LIST[@]}"; do
  check_one_so "${so_path}"
done

for so_path in "${TOOLKIT_SO_LIST[@]}"; do
  check_one_so "${so_path}"
done

echo "[PASS] undefined symbol check success!"
exit 0
