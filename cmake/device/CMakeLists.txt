# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.14)
include(../fetch_cann_cmake.cmake)
project (device_rts)

init_cann_project()

set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../" CACHE PATH "Project top directory")
set(PRODUCT_SIDE device)

include(${RUNTIME_DIR}/cmake/func.cmake)
set_runtime_params("${RUNTIME_DIR}")

# third_party
include(${RUNTIME_DIR}/cmake/third_party/protobuf.cmake)
include(${RUNTIME_DIR}/cmake/third_party/acl_compat.cmake)
add_cann_third_party(json)
add_cann_third_party(csec)

add_cann_subdirectories_relative(${RUNTIME_DIR}
    ${RUNTIME_DIR}/src/mmpa
    ${RUNTIME_DIR}/src/dfx/log/liblog
    ${RUNTIME_DIR}/src/platform
    ${RUNTIME_DIR}/src/aicpu_sched/aicpu_kernel
    ${RUNTIME_DIR}/src/queue_schedule
    ${RUNTIME_DIR}/src/aicpu_sched
    ${RUNTIME_DIR}/cmake/stub
)

include(${RUNTIME_DIR}/src/dfx/error_manager/error_manager_headers.cmake)

add_dependencies(mmpa c_sec)
add_dependencies(static_mmpa c_sec)
add_dependencies(platform c_sec)

sign_file(
  OUTPUT_TARGET sign_tsch_fw
  INPUT "${CMAKE_BINARY_DIR}/lib_acl/libtsch_fw_plugin_910b.o"
  CONFIG "${RUNTIME_DIR}/scripts/package/sign.xml" 
  RESULT_VAR "tsch_fw_sign_file"
  DEPENDS copy_acl_headers_and_libs
)

pack_targets_and_files(
  OUTPUT_TARGET "pack_cann_tsch_compat"
  OUTPUT "cann-tsch-compat.tar.gz"
  FILES "${tsch_fw_sign_file}"
  TARGETS queue_schedule_so aicpu_sharder aicpu_prof aicpu_processer aicpu_scheduler_so aicpu_custom_scheduler_so queue_schedule aicpu_scheduler sign_tsch_fw
  MANIFEST "aicpu_compat_bin_hash.cfg"
)

sign_file(
  INPUT "cann-tsch-compat.tar.gz"
  CONFIG "${RUNTIME_DIR}/scripts/package/sign.xml"
  RESULT_VAR "tsch_compat_sign_file"
  DEPENDS pack_cann_tsch_compat
)

install(FILES
  ${tsch_compat_sign_file}
  DESTINATION compat
  COMPONENT npu-runtime
)

if(TOPLEVEL_PROJECT)
  set_cann_subprj_package()
endif()
