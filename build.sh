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

set -e
BASEPATH=$(cd "$(dirname $0)"; pwd)
OUTPUT_PATH="${BASEPATH}/build_out"
BUILD_PATH="${BASEPATH}/build"

# print usage message
usage() {
  echo "Usage:"
  echo "  sh build.sh --pkg [-h | --help] [-v | --verbose] [-j<N>]"
  echo "              [--ascend_install_path=<PATH>] [--cann_3rd_lib_path=<PATH>]"
  echo "              [--asan] [--build_host_only] [--cov]"
  echo "              [--sign-script <PATH>] [--enable-sign] [--version <VERSION>]"
  echo ""
  echo "Options:"
  echo "    -h, --help     Print usage"
  echo "    --asan         Enable AddressSanitizer"
  echo "    --cov          Enable Coverage"
  echo "    --build_host_only
                           Only build host target"
  echo "    -build-type=<TYPE>"
  echo "                   Specify build type (TYPE options: Release/Debug), Default: Release"
  echo "    -v, --verbose  Display build command"
  echo "    -j<N>          Set the number of threads used for building, default is 8"
  echo "    --ascend_install_path=<PATH>"
  echo "                   Set ascend package install path, default /usr/local/Ascend/cann"
  echo "    --cann_3rd_lib_path=<PATH>"
  echo "                   Set ascend third_party package install path, default ./output/third_party"
  echo "    --sign-script <PATH>"
  echo "                   Set sign-script's path to <PATH>"
  echo "    --enable-sign"
  echo "                   Enable to sign"
  echo "    --version <VERSION>"
  echo "                   Set sign version to <VERSION>"
  echo ""
}

# parse and set options
checkopts() {
  VERBOSE=""
  THREAD_NUM=$(grep -c ^processor /proc/cpuinfo)
  ENABLE_UT="off"
  ENABLE_COV="off"
  ENABLE_GCOV="off"
  ASCEND_3RD_LIB_PATH="$BASEPATH/output/third_party"
  BUILD_TYPE="Release"
  CUSTOM_SIGN_SCRIPT="${BASEPATH}/scripts/sign/community_sign_build.py"
  ENABLE_SIGN="OFF"
  BUILD_HOST_ONLY="OFF"
  VERSION_INFO="8.5.0"

  if [ -z "$ASCEND_INSTALL_PATH" ]; then
    ASCEND_INSTALL_PATH="/usr/local/Ascend/cann"
  fi


  if [[ -n "${ASCEND_HOME_PATH}" ]] && [[ -d "${ASCEND_HOME_PATH}/toolkit/toolchain/hcc" ]]; then
    echo "env exists ASCEND_HOME_PATH : ${ASCEND_HOME_PATH}"
    export TOOLCHAIN_DIR=${ASCEND_HOME_PATH}/toolkit/toolchain/hcc
  else
    echo "env ASCEND_HOME_PATH not exists: ${ASCEND_HOME_PATH}"
  fi

  # Process the options
  parsed_args=$(getopt -a -o j:hvf: -l help,pkg,verbose,cov,build_host_only,ascend_install_path:,build-type:,cann_3rd_lib_path:,ascend_3rd_lib_path:,asan,sign-script:,enable-sign,version: -- "$@") || {
    usage
    exit 1
  }
  eval set -- "$parsed_args"

  while true; do
    case "$1" in
      -h | --help)
        usage
        exit 0
        ;;
      -j)
        THREAD_NUM="$2"
        shift 2
        ;;
      -v | --verbose)
        VERBOSE="VERBOSE=1"
        shift
        ;;
      --pkg)
        shift
        ;;
      --asan)
        ENABLE_ASAN="on"
        shift
        ;;
      --cov)
        ENABLE_GCOV="on"
        shift
        ;;
      --build_host_only)
        BUILD_HOST_ONLY="on"
        shift
        ;;
      --build-type)
        BUILD_TYPE=$2
        shift 2
        ;;
      --ascend_install_path)
        ASCEND_INSTALL_PATH="$(realpath $2)"
        shift 2
        ;;
      --cann_3rd_lib_path)
        ASCEND_3RD_LIB_PATH="$(realpath $2)"
        shift 2
        ;;
      --ascend_3rd_lib_path)
        ASCEND_3RD_LIB_PATH="$(realpath $2)"
        shift 2
        ;;
      --sign-script)
        CUSTOM_SIGN_SCRIPT=$2
        shift 2
        ;;
      --enable-sign)
        ENABLE_SIGN="ON"
        shift
        ;;
      --version)
        VERSION_INFO=$2
        shift 2
        ;;
      -f)
        CHANGED_FILES_FILE="$2"
        if [ ! -f "$CHANGED_FILES_FILE" ]; then
          echo "Error: File $CHANGED_FILES_FILE not found"
          exit 1
        fi
        CHANGED_FILES=$(cat "$CHANGED_FILES_FILE")
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
}

# check if changed files only include docs/, example/ or README.md
# usage: check_changed_files "file1 file2 file3"
check_changed_files() {
  local changed_files="$1"
  local skip_build=true

  # if no changed files provided, return false (don't skip build)
  if [ -z "$changed_files" ]; then
    return 1
  fi

  # check each changed file
  for file in $changed_files; do
    # remove leading/trailing spaces and quotes
    file=$(echo "$file" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/^"//;s/"$//')

    # check if file is README.md (case insensitive)
    if echo "$file" | grep -qi "^README\.md$"; then
      continue
    fi

    # check if file is CONTRIBUTING.md (case insensitive)
    if echo "$file" | grep -qi "^CONTRIBUTING\.md$"; then
      continue
    fi

    # check if file is in docs/ directory
    if echo "$file" | grep -q "^docs/"; then
      continue
    fi

    # check if file is in example/ directory
    if echo "$file" | grep -q "^example/"; then
      continue
    fi

    # if any file doesn't match the above patterns, don't skip build
    skip_build=false
    break
  done

  if [ "$skip_build" = true ]; then
    echo "[INFO] Changed files only contain docs/, example/, README.md or CONTRIBUTING.md, skipping build."
    echo "[INFO] Changed files: $changed_files"
    return 0
  fi

  return 1
}

mk_dir() {
  local create_dir="$1"  # the target to make
  mkdir -pv "${create_dir}"
  echo "created ${create_dir}"
}

extra_libascendcl_to_build() {
  # find and extract tar.gz file
  local targz_file=$(ls acl-compat*.tar.gz 2>/dev/null | head -n1)
  if [ -z "$targz_file" ]; then
    echo "acl-compat*.tar.gz not found in outer tar" >&2
    return 0
  fi

  local tmpdir=".extract_tmp"
  rm -rf "$tmpdir" && mkdir -p "$tmpdir" && tar -zxf "$targz_file" -C "$tmpdir" && {
    rm -rf lib_acl/ && cp -rp "$tmpdir/lib64" lib_acl/
    rm -rf include_acl/ && cp -rp "$tmpdir/include" include_acl/
  }
}

# create build path
build_rts() {
  echo "create build directory and build";
  mk_dir "${BUILD_PATH}"
  mk_dir "${OUTPUT_PATH}"
  cd "${BUILD_PATH}"
  extra_libascendcl_to_build
  CMAKE_ARGS="-DENABLE_OPEN_SRC=True \
              -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
              -DVERSION=${VERSION} \
              -DCMAKE_INSTALL_PREFIX=${OUTPUT_PATH} \
              -DASCEND_INSTALL_PATH=${ASCEND_INSTALL_PATH} \
              -DOPEN_SOURCE_DIR=${ASCEND_3RD_LIB_PATH} \
              -DENABLE_COV=${ENABLE_COV} \
              -DENABLE_GCOV=${ENABLE_GCOV} \
              -DENABLE_ASAN=${ENABLE_ASAN} \
              -DENABLE_UT=${ENABLE_UT} \
              -DENABLE_SIGN=${ENABLE_SIGN} \
              -DBUILD_HOST_ONLY=${BUILD_HOST_ONLY} \
              -DCUSTOM_SIGN_SCRIPT=${CUSTOM_SIGN_SCRIPT} \
              -DVERSION_INFO=${VERSION_INFO}"

  echo "CMAKE_ARGS=${CMAKE_ARGS}"
  cmake -S ../ -B . ${CMAKE_ARGS}
  if [ $? -ne 0 ]; then
    echo "execute command: cmake ${CMAKE_ARGS} .. failed."
    return 1
  fi

  cmake --build . --target npu_runtime -j${THREAD_NUM}
  if [ $? -ne 0 ]; then
    echo "execute command: cmake --build build --target=npu_runtime -j${THREAD_NUM} failed."
    return 1
  fi

  make package -j${THREAD_NUM}
  if [ $? -ne 0 ]; then
    echo "execute command: make package failed."
    return 1
  fi
  echo "build success!"
}

main() {
  checkopts "$@"

  # check if changed files only contain docs/, example/ or README.md
  if [ -n "$CHANGED_FILES" ]; then
    if check_changed_files "$CHANGED_FILES"; then
      exit 200
    fi
  fi

  # build start
  echo "---------------- build start ----------------"
  g++ -v

  build_rts
  if [[ "$?" -ne 0 ]]; then
    echo "build failed.";
    exit 1;
  fi
  echo "---------------- build finished ----------------"
}

main "$@"
