# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include(${RUNTIME_DIR}/version.cmake)

add_library(rt_aicpu_kernels SHARED
    rt_kernel_dsa_update.cpp
    rt_aicpu_kernel.cpp
)

target_include_directories(rt_aicpu_kernels PRIVATE
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_kernel/utils
)

target_link_libraries(rt_aicpu_kernels PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(rt_aicpu_kernels PRIVATE
    -fvisibility=hidden
    -fvisibility-inlines-hidden
)


cann_pack_targets_and_files(
  OUTPUT_TARGET "pack_cann_rt_compat"
  OUTPUT "cann-rt-compat.tar.gz"
  TAR_ROOT_DIR "aicpu_kernels_device"
  TARGETS rt_aicpu_kernels
  MANIFEST "rt_compat_bin_hash.cfg"
  GEN_INI
)

add_cann_sign_file(
  INPUT "cann-rt-compat.tar.gz"
  CONFIG "${RUNTIME_DIR}/scripts/package/sign.xml"
  RESULT_VAR "rt_compat_sign_file"
  VERSION "${CANN_UNIFIED_VERSION}"
  OUTPUT_TARGET "sign_cann_rt_compat"
  DEPENDS pack_cann_rt_compat
)

install(FILES
  ${rt_compat_sign_file}
  ${CMAKE_CURRENT_BINARY_DIR}/cann-rt-compat.ini
  DESTINATION lib
  OPTIONAL
)
