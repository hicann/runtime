# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(SRC_PATH
    ${AICPU_SCHED_PATH}/aicpu_sharder
)

set(LOCAL_SRC_FILES
    ${SRC_PATH}/aicpu_sharder.cc
    ${SRC_PATH}/aicpu_pulse.cc
    ${SRC_PATH}/aicpu_context.cc
    ${SRC_PATH}/aicpu_async_event.cc
    ${SRC_PATH}/aicpu_timer.cpp
    ${SRC_PATH}/aicpu_error_log.cpp
    testcase/aicpu_sharder_st.cc
    testcase/aicpu_pulse_st.cc
    testcase/aicpu_context_st.cc
    testcase/aicpu_async_event_st.cc
    testcase/aicpu_timer_st.cc
    testcase/aicpu_error_log_st.cc
    main_st.cc
)
set(LOCAL_C_INCLUDES
    ${SRC_PATH}
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
)

add_executable(aicpu_sharder_st
    ${LOCAL_SRC_FILES}
)
target_include_directories(aicpu_sharder_st PRIVATE
    ${LOCAL_C_INCLUDES}
)
target_link_libraries(aicpu_sharder_st PRIVATE
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    c_sec
    pthread
    c_sec_headers
)

target_compile_definitions(aicpu_sharder_st PRIVATE
    AICPU_SHARDER_UTST
)
