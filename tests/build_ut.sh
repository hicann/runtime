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
BASEPATH=$(cd "$(dirname $0)/.."; pwd)
OUTPUT_PATH="${BASEPATH}/output"
BUILD_PATH="${BASEPATH}/build"

declare -A ut_path_map
declare -A ut_name_map

ut_path_map["full"]="tests/ut"
ut_path_map["acl"]="tests/ut/acl"
ut_path_map["runtime"]="tests/ut/runtime/runtime"
ut_path_map["runtime_c"]="tests/ut/runtime/runtime_c/testcase"
ut_path_map["platform"]="tests/ut/platform/ut"
ut_path_map["qs"]="tests/ut/queue_schedule"
ut_path_map["queue_schedule"]="tests/ut/queue_schedule"
ut_path_map["aicpusd"]="tests/ut/aicpu_sched"
ut_path_map["aicpu_sched"]="tests/ut/aicpu_sched"
ut_path_map["slog"]="tests/ut/slog"
ut_path_map["atrace"]="tests/ut/atrace"
ut_path_map["msprof"]="tests/ut/msprof"
ut_path_map["adump"]="tests/ut/adump"
ut_path_map["tsd"]="tests/ut/tsd"
ut_path_map["error_manager"]="tests/ut/error_manager"
ut_path_map["mmpa"]="tests/ut/mmpa"

# print usage message
usage() {
  echo "Usage:"
  echo "  sh build_ut.sh --pkg [-h | --help] [-v | --verbose] [-j<N>]"
  echo "                 [-t | --target <target1> <target2> ...] [--asan]"
  echo "                 [-u | --ut] [-c | --cov] [--cann_3rd_lib_path=<PATH>]"
  echo ""
  echo "Options:"
  echo "    -h, --help     Print usage"
  echo "    -v, --verbose  Display build command"
  echo "    -j<N>          Set the number of threads used for building, default is 8"
  echo "    -u, --ut [specific_ut]"
  echo "                   Build and execute ut, if specific_ut is provided, run only the specified unit test"
  echo "    -c, --cov      Build ut with coverage tag"
  echo "    --asan         Enable AddressSanitizer (requires libasan.so, libubsan.so, libtsan.so)"
  echo "                   Asan libraries are usually integrated with gcc. If not found, install them:"
  echo "                   Ubuntu/Debian: sudo apt install libasan6 libubsan1 libtsan2"
  echo "                   Ensure the version matches your gcc (e.g., gcc 9.5.0 -> libasan6)"
  echo "    -t, --target   Build only the selected target and run"
  echo "    --cann_3rd_lib_path=<PATH>"
  echo "                   Set ascend third_party package install path, default ./output/third_party"
  echo ""
}

# parse and set options
checkopts() {
  VERBOSE=""
  THREAD_NUM=8
  ENABLE_UT="off"
  ENABLE_ASAN="off"
  ENABLE_COV="off"
  MAKE_PKG="off"
  ASCEND_3RD_LIB_PATH="$BASEPATH/output/third_party"
  CMAKE_BUILD_TYPE="Debug"
  UT_TARGET="full"
  TARGETS=()

  # Process the options
  parsed_args=$(getopt -o j:hvu::ct:f: -l help,cann_3rd_lib_path:,ut::,verbose,asan,target:, -- "$@") || {
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
      --cann_3rd_lib_path)
        ASCEND_3RD_LIB_PATH="$2"
        shift 2
        ;;
      -u | --ut)
        ENABLE_UT="on"
        if [[ -n $2 && $2 != -* ]]; then
          if [[ -n "${ut_path_map[$2]}" ]]; then
            UT_TARGET=$2
            echo "specified --ut name $2"
          else
            echo "ERROR: undefined --ut name $2"
            exit 1
          fi
        fi
        shift 2
        ;;
      -c | --cov)
        ENABLE_UT="on"
        ENABLE_COV="on"
        shift
        ;;
      --asan)
        ENABLE_ASAN="on"
        shift
        ;;
      -t | --target)
        shift
        while [[ $# -gt 0 && $1 != -* ]]; do
            TARGETS+=("$1")
            shift
        done
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

# check if changed files only include docs/, example/, .claude/, .opencode/ or markdown files
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

    # check if file is AGENTS.md (case insensitive)
    if echo "$file" | grep -qi "^AGENTS\.md$"; then
      continue
    fi

    # check if file is a markdown file at root level (case insensitive)
    if echo "$file" | grep -qi "^[A-Z_]*\.md$"; then
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

    # check if file is in .claude/ directory
    if echo "$file" | grep -q "^\.claude/"; then
      continue
    fi

    # check if file is in .opencode/ directory
    if echo "$file" | grep -q "^\.opencode/"; then
      continue
    fi

    # if any file doesn't match above patterns, don't skip build
    skip_build=false
    break
  done

  if [ "$skip_build" = true ]; then
    echo "[INFO] Changed files only contain docs/, example/, .claude/, .opencode/ or markdown files, skipping build."
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

# validate sanitizer libraries
validate_sanitizer_libs() {
  if [[ "X$ENABLE_ASAN" = "Xon" ]]; then
    echo "Validating sanitizer libraries..."
    
    local libs=("libasan.so" "libubsan.so" "libtsan.so")
    local preload_libs=""
    local missing_libs=()
    
    for lib in "${libs[@]}"; do
      local lib_path=$(gcc -print-file-name=$lib)
      if [ -f "$lib_path" ]; then
        preload_libs="$preload_libs:$lib_path"
        echo "  ✓ $lib found at: $lib_path"
      else
        echo "  ✗ $lib not found"
        missing_libs+=("$lib")
      fi
    done
    
    if [ ${#missing_libs[@]} -ne 0 ]; then
      echo ""
      echo "ERROR: Missing sanitizer libraries: ${missing_libs[*]}"
      echo ""
      echo "Please install the missing sanitizer libraries:"
      echo "  Ubuntu/Debian: sudo apt install libasan6 libubsan1 libtsan2"
      echo "  CentOS/EulerOS: sudo yum install libasan libubsan libtsan"
      echo ""
      echo "Note: Ensure the library version matches your gcc version."
      echo "  For example: gcc 9.5.0 requires libasan6"
      echo "  Check your gcc version with: gcc --version"
      exit 1
    fi

    export LD_PRELOAD="$ORIGINAL_LD_PRELOAD:$preload_libs"
  fi
}

# create build path
build_rts() {
  echo "create build directory and build";
  mk_dir "${BUILD_PATH}"
  cd "${BUILD_PATH}"

  CMAKE_ARGS="-DENABLE_OPEN_SRC=True \
              -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
              -DCMAKE_INSTALL_PREFIX=${OUTPUT_PATH} \
              -DCANN_3RD_LIB_PATH=${ASCEND_3RD_LIB_PATH} \
              -DENABLE_ASAN=${ENABLE_ASAN} \
              -DENABLE_COV=${ENABLE_COV} \
              -DENABLE_UT=${ENABLE_UT}"

  echo "CMAKE_ARGS=${CMAKE_ARGS}"
  cmake ${CMAKE_ARGS} ..
  if [ $? -ne 0 ]; then
    echo "execute command: cmake ${CMAKE_ARGS} .. failed."
    return 1
  fi
  if [ ${#TARGETS[@]} -ne 0 ]; then
    for TARGET in "${TARGETS[@]}"; do
      echo "Building target: ${TARGET}"
      cmake --build . --target "${TARGET}" -j${THREAD_NUM}
      if [ $? -ne 0 ]; then
        echo "execute command: cmake --build build --target=${TARGET} -j${THREAD_NUM} failed."
        return 1
      fi
    done
  else
    # make all
    cmake --build . -j${THREAD_NUM}
  fi

  if [[ "X$MAKE_PKG" = "Xon" ]]; then
    make package -j${THREAD_NUM}
    if [ $? -ne 0 ]; then
      echo "execute command: make package failed."
      return 1
    fi
  fi
  echo "build success!"
}

run_ut() {
  if [[ "X$ENABLE_UT" = "Xon" ]]; then
    if [[ "X$ENABLE_COV" != "Xon" ]]; then
      echo "Coverage statistics is not enabled, sh build.sh with parameter -c or --cov to enable it"
    fi

    ORIGINAL_LD_PRELOAD="$LD_PRELOAD"
    # validate sanitizer libraries if ASAN is enabled
    validate_sanitizer_libs

    local report_dir="${OUTPUT_PATH}/report/ut" && mk_dir "${report_dir}"
    echo "${UT_TARGET}"
    local ut_dir="${BUILD_PATH}/${ut_path_map["${UT_TARGET}"]}"
    echo "ut_dir = ${ut_dir}"
    exec_file_cnt=0
    while read -r ut_exec; do
        filename=$(basename "$ut_exec")
        RUN_TEST_CASE="$ut_exec --gtest_output=xml:${report_dir}/${filename}.xml" && ${RUN_TEST_CASE}
        echo "Executing: $filename"
        exec_file_cnt=${exec_file_cnt+1}
    done < <(find "$ut_dir" -type f -executable -not -name "*.so")

    if [[ $exec_file_cnt -eq 0 ]]; then
      echo "ERROR: No executable UT file found! Please check if the parameters for --ut / --target are correct"
      exit 1
    fi
    if [ -n "$ORIGINAL_LD_PRELOAD" ]; then
      export LD_PRLOAD="$ORIGINAL_LD_PRELOAD"
    else
      unset LD_PRELOAD
    fi

    if [[ "X$ENABLE_COV" = "Xon" ]]; then
      echo "Generated coverage statistics, please wait..."
      cd ${BASEPATH}
      rm -rf ${BASEPATH}/cov
      mkdir -p ${BASEPATH}/cov
      echo "WARNING: If an error occurs due to the version of the lcov tool, please select the appropriate parameters according to the prompts for adaptation."
      local os_version=""
      if [ -f /etc/os-release ]; then
        os_version="$(grep '^VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')"
      fi
      if [[ "${os_version}" == "24.04" ]]; then
        lcov -c -d ${ut_dir} -o cov/tmp.info --ignore-errors mismatch,gcov,source,negative
        lcov -r cov/tmp.info '/usr/*' "${OUTPUT_PATH}/*" "${BASEPATH}/tests/*" \
          "${ASCEND_3RD_LIB_PATH}/*" "${BASEPATH}/build/*" -o cov/coverage.info --ignore-errors mismatch,unused
      else
        lcov -c -d ${ut_dir} -o cov/tmp.info
        lcov -r cov/tmp.info '/usr/*' "${OUTPUT_PATH}/*" "${BASEPATH}/tests/*" \
          "${ASCEND_3RD_LIB_PATH}/*" "${BASEPATH}/build/*" -o cov/coverage.info
      fi
      cd ${BASEPATH}/cov
      genhtml coverage.info
    fi
  else
    echo "Unit tests is not enabled, sh build.sh with parameter -u or --ut to enable it"
  fi
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
  mk_dir ${OUTPUT_PATH}
  build_rts
  if [[ "$?" -ne 0 ]]; then
    echo "build failed.";
    exit 1;
  fi
  echo "---------------- build finished ----------------"
  echo "---------------- ut start ----------------------"
  run_ut
  echo "---------------- ut finished -------------------"
}

main "$@"
