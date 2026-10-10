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

set -euo pipefail

WORK_DIR="./third_party"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --3rd_party)
            if [[ $# -lt 2 || -z "$2" || "$2" == --* ]]; then
                echo "Error: --3rd_party requires a directory." >&2
                exit 1
            fi
            WORK_DIR="$2"
            shift 2
            ;;
        --3rd_party=*)
            WORK_DIR="${1#*=}"
            if [[ -z "${WORK_DIR}" ]]; then
                echo "Error: --3rd_party requires a directory." >&2
                exit 1
            fi
            shift
            ;;
        -h|--help)
            echo "Usage: bash download_3rd_party.sh [--3rd_party <directory>]"
            echo "Default: ./third_party; all patches are saved in <directory>/patch."
            exit 0
            ;;
        *)
            echo "Error: unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

OBS_URL="https://cann-3rd.obs.cn-north-4.myhuaweicloud.com"
# Source: https://gitcode.com/cann/cmake/tree/master-059/third_party
# Tag commit: 3c4a9da4a0e81faa47dcc1c8e11db63ec7ff6231
# Format: "URL SHA256 Path relative to third_party"
DOWNLOAD_LIST=(
    "${OBS_URL}/abseil-cpp/abseil-cpp-20230802.1.tar.gz 987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed abseil-cpp-20230802.1.tar.gz"
    "https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1-h0/backport-CVE-2025-0838.patch a4e4ef6fc4f4c1ed871a3472c5e650068aaadaad2adfef2c8ccb00918bb36d8c patch/backport-CVE-2025-0838.patch"
    # ACL digests were computed from the HTTPS archives; acl_compat.cmake has no hash.
    "${OBS_URL}/cann/acl-compat/acl-compat_9.2.0_linux-x86_64.tar.gz 7802c66742349bec5801898788dae10889a7d20712cac943f9e650ded10473cd acl-compat_9.2.0_linux-x86_64.tar.gz"
    "${OBS_URL}/cann/acl-compat/acl-compat_9.2.0_linux-aarch64.tar.gz 5ac43f06c205a8bca534dcf9b96875d6d27fdb213d1066fab40efa46040945b1 acl-compat_9.2.0_linux-aarch64.tar.gz"
    "${OBS_URL}/boost/boost_1_87_0.tar.gz f55c340aa49763b1925ccf02b2e83f35fdcf634c9d5164a2acb87540173c741d boost_1_87_0.tar.gz"
    "${OBS_URL}/eigen/eigen-5.0.0.tar.gz 93f7f0462988b934e632a9fba58af55192ffceae38e8f46233f4f62cb1e79370 eigen-5.0.0.tar.gz"
    "${OBS_URL}/googletest/googletest-1.14.0.tar.gz 8ad598c73ad796e0d8280b082cebd82a630d73e73cd3c70057938a6501bba5d7 googletest-1.14.0.tar.gz"
    "${OBS_URL}/json/json-3.12.0.tar.gz 4b92eb0c06d10683f7447ce9406cb97cd4b453be18d7279320f7b2f025c10187 json-3.12.0.tar.gz"
    "${OBS_URL}/libboundscheck/libboundscheck-v1.1.16.tar.gz aee8368ef04a42a499edd5bfebce529e7f32dd138bfed383d316e48af4e45d2c libboundscheck-v1.1.16.tar.gz"
    "${OBS_URL}/libseccomp/libseccomp-2.5.4.tar.gz 96bbadb4384716272a6d2be82801dc564f7aab345febfe9b698b70fc606e3f75 libseccomp-2.5.4.tar.gz"
    "${OBS_URL}/mockcpp/mockcpp-2.7.tar.gz 73ab0a8b6d1052361c2cebd85e022c0396f928d2e077bf132790ae3be766f603 mockcpp-2.7.tar.gz"
    "https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h5/mockcpp-2.7-h5.patch 65a2aac5e8ffe1a0eb983e4455972ef70b9850d4283ea7d4cc83e3cb97e98c5e patch/mockcpp-2.7-h5.patch"
    "${OBS_URL}/protobuf/protobuf-25.1.tar.gz 9bd87b8280ef720d3240514f884e56a712f2218f0d693b48050c836028940a42 protobuf-25.1.tar.gz"
    "${OBS_URL}/makeself/makeself-release-2.5.0.tar.gz 705d0376db9109a8ef1d4f3876c9997ee6bed454a23619e1dbc03d25033e46ea makeself-release-2.5.0.tar.gz"
    "${OBS_URL}/makeself/fix/makeself-2.5.0.patch 0ecac3fe200221353322626900d5257a59d98347f83653b98456e08475994486 patch/makeself-2.5.0.patch"
    # Version and SHA256 match cmake/fetch_cann_cmake.cmake.
    "https://raw.gitcode.com/cann/cmake/archive/refs/heads/master-059.tar.gz 9e59939b5c97c9498293969df22ab2dd40e450700c51f84f117d065880f40d25 cmake-master-059.tar.gz"
)

TEMP_FILE=""
trap 'if [[ -n "${TEMP_FILE}" ]]; then rm -f -- "${TEMP_FILE}"; fi' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

for TOOL in wget sha256sum; do
    if ! command -v "${TOOL}" >/dev/null 2>&1; then
        echo "Error: ${TOOL} is required." >&2
        exit 1
    fi
done

check_sha256() {
    printf '%s  %s\n' "$1" "$2" | sha256sum --check --status
}

for ITEM in "${DOWNLOAD_LIST[@]}"; do
    read -r URL SHA256 FILE_NAME <<< "${ITEM}"
    FILE_PATH="${WORK_DIR}/${FILE_NAME}"

    if [[ -f "${FILE_PATH}" ]]; then
        if check_sha256 "${SHA256}" "${FILE_PATH}"; then
            echo "Verified cache, skipping: ${FILE_NAME}"
            continue
        fi
        echo "Cached SHA256 mismatch, downloading again: ${FILE_NAME}"
        rm -f -- "${FILE_PATH}"
    fi

    mkdir -p -- "$(dirname "${FILE_PATH}")"
    TEMP_FILE=$(mktemp -- "${FILE_PATH}.part.XXXXXX")
    echo "Download from ${URL} to ${FILE_PATH}"
    if ! wget -q --show-progress --timeout=60 --tries=3 -O "${TEMP_FILE}" "${URL}"; then
        echo "Error: download failed: ${FILE_NAME}" >&2
        exit 1
    fi
    if ! check_sha256 "${SHA256}" "${TEMP_FILE}"; then
        echo "Error: SHA256 mismatch: ${FILE_NAME}" >&2
        exit 1
    fi
    mv -f -- "${TEMP_FILE}" "${FILE_PATH}"
    TEMP_FILE=""
    echo "Downloaded and verified: ${FILE_NAME}"
done

# master-059 reads the Abseil patch from separate Host and Device directories.
mkdir -p -- "${WORK_DIR}/patch/device"
cp -f -- "${WORK_DIR}/patch/backport-CVE-2025-0838.patch" "${WORK_DIR}/patch/device/backport-CVE-2025-0838.patch"

echo "All downloads verified. Files are saved in '${WORK_DIR}'."
