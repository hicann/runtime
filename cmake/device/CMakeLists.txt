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

set(PRODUCT_SIDE device)
init_cann_project()
add_cann_target_options()

set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../" CACHE PATH "Project top directory")


include(${RUNTIME_DIR}/cmake/func.cmake)
set_runtime_params("${RUNTIME_DIR}")

# third_party
include(${RUNTIME_DIR}/cmake/third_party/acl_compat.cmake)
add_cann_third_party(protobuf)
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

include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)
include(${RUNTIME_DIR}/src/dfx/error_manager/error_manager_headers.cmake)
include(${RUNTIME_DIR}/src/acl/aclrt/acl_rt_headers.cmake)
include(${RUNTIME_DIR}/src/dfx/trace/atrace_headers.cmake)
include(${RUNTIME_DIR}/src/dfx/msprof/msprof_headers.cmake)

add_dependencies(mmpa c_sec)
add_dependencies(static_mmpa c_sec)
add_dependencies(platform c_sec)

install(FILES
    $<TARGET_FILE:ascend_protobuf_static>
    DESTINATION ${DEVICE_LIBRARY_PATH} COMPONENT npu-runtime
)

add_cann_sign_file(
  OUTPUT_TARGET sign_tsch_fw
  INPUT "${CMAKE_BINARY_DIR}/lib_acl/libtsch_fw_plugin_910b.o"
  CONFIG "${RUNTIME_DIR}/scripts/package/sign.xml" 
  RESULT_VAR "tsch_fw_sign_file"
  DEPENDS copy_acl_headers_and_libs
)

include(${RUNTIME_DIR}/version.cmake)
cann_pack_targets_and_files(
  OUTPUT_TARGET "pack_cann_tsch_compat"
  OUTPUT "cann-tsch-compat.tar.gz"
  FILES "${tsch_fw_sign_file}"
  TARGETS queue_schedule_so aicpu_sharder aicpu_prof aicpu_processer aicpu_scheduler_so aicpu_custom_scheduler_so queue_schedule aicpu_scheduler sign_tsch_fw
  SIZE_LIMIT 5364
  MANIFEST "aicpu_compat_bin_hash.cfg"
  GEN_INI
)

add_cann_sign_file(
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

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/cann-tsch-compat.ini
  DESTINATION compat
  COMPONENT npu-runtime
)

set_cann_subprj_package()
