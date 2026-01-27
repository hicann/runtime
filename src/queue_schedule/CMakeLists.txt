# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_subdirectory(dgwclient)

set(proto_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/easycom_message.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dynamic_sched_message.proto
)
if (AOSCORE_LLVM_MUSL)
    add_definitions(-D_AOSCORE_)
endif()

set(PRODUCT_TYPE "DEFAULT")
set(lhisi_product false)

protobuf_generate(aicpu PROTO_SRCS PROTO_HDRS ${proto_src_files})
###for queue_schedule so
set (queue_schedule_server_files
    common/bqs_so_manager.cpp
    common/bqs_log.cpp
    common/feature_ctrl_open.cpp
    server/bind_relation.cpp
    server/queue_schedule.cpp
    server/bind_cpu_utils.cpp
    server/statistic_manager.cpp
    server/subscribe_manager.cpp
    server/queue_manager.cpp
    server/router_server.cpp
    server/profile_manager.cpp
    server/qs_interface_process.cpp
    server/queue_schedule_interface.cpp
    server/queue_schedule_sub_module_interface.cpp
    server/entity_manager/entity.cpp
    server/entity_manager/simple_entity.cpp
    server/entity_manager/group_entity.cpp
    server/entity_manager/channel_entity.cpp
    server/entity_manager/client_entity.cpp
    server/entity_manager/entity_manager.cpp
    server/data_obj_manager.cpp
    server/state_manager.cpp
    server/hccl_process.cpp
    server/fsm/base_state.cpp
    server/fsm/error_state.cpp
    server/fsm/full_state.cpp
    server/fsm/idle_state.cpp
    server/fsm/peek_state.cpp
    server/fsm/push_state.cpp
    server/fsm/try_push_state.cpp
    server/fsm/wait_push_state.cpp
    server/dynamic_sched/dynamic_sched_mgr.cpp
    server/hccl/hccl_so_manager.cpp
    server/hccl/comm_channel_manager.cpp
    server/strategy/hash_strategy.cpp
    server/strategy/broadcast_strategy.cpp
    server/strategy/strategy_manager.cpp
    server/config/config_info_operator.cpp
    server/msprof_manager.cpp
    server/msprof_api_adapter.cpp
    server/schedule_config.cpp
    stub/hccl/hccl_stub.cpp
    server/qs_proc_mem_statistic.cpp
    server/qs_args_parser.cpp
    ${PROTO_SRCS}
    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/driver/ascend_inpackage_hal.cpp>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:${CMAKE_CURRENT_SOURCE_DIR}/common/bqs_util.cpp>
    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/common/bqs_util.cpp>
    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/tsd/tsd.cpp>

    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/bqs_server.cpp
)

##for so inc path
set (queue_schedule_inc_path
    ${CMAKE_CURRENT_SOURCE_DIR}/server
    ${CMAKE_CURRENT_SOURCE_DIR}/server/entity_manager
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${CMAKE_CURRENT_SOURCE_DIR}/server/dynamic_sched
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/include
    ${CMAKE_BINARY_DIR}/proto/aicpu
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto
    ${CMAKE_CURRENT_SOURCE_DIR}/stub

    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/tsd>
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/proc_mgr
)

#---------------------------给tsd_eventclient打桩-----------------------------
add_library(tsd_eventclient_stub_in_qs SHARED 
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_tsd_event_client.cpp
)
target_include_directories(tsd_eventclient_stub_in_qs PRIVATE
    ${RUNTIME_DIR}/pkg_inc/tsd/
)
set_target_properties(tsd_eventclient_stub_in_qs
    PROPERTIES
    OUTPUT_NAME tsd_eventclient
)

# queue_schedule_exe
set(queue_schedule_exe
    server/main.cpp
    common/bqs_log.cpp
    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/tsd/tsd.cpp>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:${CMAKE_CURRENT_SOURCE_DIR}/common/bqs_util.cpp>
    $<$<STREQUAL:${PRODUCT_SIDE},host>:${CMAKE_CURRENT_SOURCE_DIR}/stub/common/bqs_util.cpp>
    server/qs_args_parser.cpp
)

set(queue_schedule_exe_path
    ${CMAKE_CURRENT_SOURCE_DIR}/server
    ${CMAKE_CURRENT_SOURCE_DIR}/server/entity_manager
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${RUNTIME_DIR}/include 
    ${RUNTIME_DIR}/pkg_inc/tsd/
    ${RUNTIME_DIR}/pkg_inc
)

add_library(queue_schedule_so SHARED
    ${queue_schedule_server_files}
)

target_include_directories(queue_schedule_so PRIVATE
    ${queue_schedule_inc_path}
)

target_compile_options(queue_schedule_so PRIVATE
    -ftrapv
    -O2
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -fdata-sections
    -ffunction-sections
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_link_options(queue_schedule_so PRIVATE
    -Wl,--gc-sections
    -Wl,-Bsymbolic
)

if (${PRODUCT_SIDE} STREQUAL "host")
    set(TARGET_SYSTEM_PROCESSOR ${CMAKE_HOST_SYSTEM_PROCESSOR})
endif()
target_compile_definitions(queue_schedule_so PRIVATE
    _FORTIFY_SOURCE=2
    google=ascend_private
    RUN_ON_AICPU
    $<$<STREQUAL:${TARGET_SYSTEM_PROCESSOR},x86_64>:RUN_ON_X86>
)

SET(AICPU_USE_ASCEND_HAL_STUB true)
set(LINK_TSD_EVENT_CLIENT false)
if (${PRODUCT_SIDE} STREQUAL "device")
    set(LINK_TSD_EVENT_CLIENT true)
endif()

target_link_libraries(queue_schedule_so PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    $<BUILD_INTERFACE:slog_headers>
    -lrt
    ascend_protobuf_static
    PUBLIC c_sec
    $<$<STREQUAL:${AICPU_USE_ASCEND_HAL_STUB},true>:ascend_hal_stub>
    $<$<STREQUAL:${LINK_TSD_EVENT_CLIENT},true>:tsd_eventclient_stub_in_qs>
    -ldl
    $<BUILD_INTERFACE:c_sec_headers>
)

add_executable(queue_schedule
    ${queue_schedule_exe}
)

target_include_directories(queue_schedule PRIVATE
    ${queue_schedule_exe_path}
)

target_link_libraries(queue_schedule PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    $<BUILD_INTERFACE:slog_headers>
    queue_schedule_so
    $<$<STREQUAL:${PRODUCT_SIDE},device>:tsd_eventclient_stub_in_qs>
    unified_dlog
    -ldl
    $<BUILD_INTERFACE:c_sec_headers>
)

target_compile_options(queue_schedule PRIVATE
    -ftrapv
    -O2
    -Werror
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
    -fPIE
)

target_link_options(queue_schedule PRIVATE
    -pie
)

target_compile_definitions(queue_schedule PRIVATE
    _FORTIFY_SOURCE=2
    RUN_ON_AICPU
)


if (${PRODUCT_SIDE} STREQUAL "host")
    set_target_properties(queue_schedule_so
        PROPERTIES
        OUTPUT_NAME host_queue_schedule
    )
    set_target_properties(queue_schedule
        PROPERTIES
        OUTPUT_NAME host_queue_schedule
    )
else()
    set_target_properties(queue_schedule_so
        PROPERTIES
        OUTPUT_NAME queue_schedule
    )
endif()