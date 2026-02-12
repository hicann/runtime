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
    ${TOP_DIR}/src/queue_schedule
)

set(proto_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/easycom_message.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dynamic_sched_message.proto
)

protobuf_generate(aicpu PROTO_SRCS PROTO_HDRS ${proto_src_files})

set(common_compile_options
    -rdynamic
    -fpermissive
)

list(APPEND common_compile_options
    -fsanitize=undefined
    -static-libubsan
    -fno-sanitize=alignment
    -Wall
)

set(LOCAL_SRC_FILES
    main_st.cpp
    ${SRC_PATH}/client/bqs_client.cpp
    ${SRC_PATH}/client/ezcom_client.cpp
    ${SRC_PATH}/server/bqs_server.cpp
    ${SRC_PATH}/server/queue_manager.cpp
    ${SRC_PATH}/server/subscribe_manager.cpp
    ${SRC_PATH}/server/statistic_manager.cpp
    ${SRC_PATH}/server/bind_relation.cpp
    ${SRC_PATH}/server/bind_cpu_utils.cpp
    ${SRC_PATH}/server/queue_schedule.cpp
    ${SRC_PATH}/server/profile_manager.cpp
    ${SRC_PATH}/server/entity_manager/entity.cpp
    ${SRC_PATH}/server/entity_manager/simple_entity.cpp
    ${SRC_PATH}/server/entity_manager/group_entity.cpp
    ${SRC_PATH}/server/entity_manager/channel_entity.cpp
    ${SRC_PATH}/server/entity_manager/client_entity.cpp
    ${SRC_PATH}/server/entity_manager/entity_manager.cpp
    ${SRC_PATH}/server/data_obj_manager.cpp
    ${SRC_PATH}/server/state_manager.cpp
    ${SRC_PATH}/server/hccl_process.cpp
    ${SRC_PATH}/server/fsm/base_state.cpp
    ${SRC_PATH}/server/fsm/error_state.cpp
    ${SRC_PATH}/server/fsm/full_state.cpp
    ${SRC_PATH}/server/fsm/idle_state.cpp
    ${SRC_PATH}/server/fsm/peek_state.cpp
    ${SRC_PATH}/server/fsm/push_state.cpp
    ${SRC_PATH}/server/fsm/try_push_state.cpp
    ${SRC_PATH}/server/fsm/wait_push_state.cpp
    ${SRC_PATH}/server/router_server.cpp
    ${SRC_PATH}/server/qs_interface_process.cpp
    ${SRC_PATH}/server/queue_schedule_interface.cpp
    ${SRC_PATH}/server/msprof_manager.cpp
    ${SRC_PATH}/server/msprof_api_adapter.cpp
    ${SRC_PATH}/server/queue_schedule_sub_module_interface.cpp
    ${SRC_PATH}/server/main.cpp
    ${SRC_PATH}/server/dynamic_sched/dynamic_sched_mgr.cpp
    ${SRC_PATH}/stub/common/bqs_util.cpp
    ${SRC_PATH}/stub/hccl/hccl_stub.cpp
    ${SRC_PATH}/dgwclient/dgw_client.cpp
    ${SRC_PATH}/server/hccl/hccl_so_manager.cpp
    ${SRC_PATH}/server/hccl/comm_channel_manager.cpp
    ${SRC_PATH}/server/strategy/hash_strategy.cpp
    ${SRC_PATH}/server/strategy/broadcast_strategy.cpp
    ${SRC_PATH}/server/strategy/strategy_manager.cpp
    ${SRC_PATH}/server/config/config_info_operator.cpp
    ${SRC_PATH}/server/schedule_config.cpp
    ${SRC_PATH}/common/bqs_so_manager.cpp
    ${SRC_PATH}/common/bqs_log.cpp
    ${SRC_PATH}/common/feature_ctrl_open.cpp
    ${SRC_PATH}/server/qs_proc_mem_statistic.cpp
    ${SRC_PATH}/server/qs_args_parser.cpp
    ${SRC_PATH}/stub/proc_mgr/proc_mgr_sys_operator_agent.cpp
    testcase/bqs_queue_schedule_stest.cpp
    testcase/bqs_queue_manager_stest.cpp
    testcase/statistic_manager_stest.cpp
    testcase/profile_manager_stest.cpp
    testcase/router_server_stest.cpp
    testcase/qs_interface_stest.cpp
    testcase/qs_args_parser_stest.cpp
    testcase/subscribe_manager_stest.cpp
    testcase/bqs_bind_utils_stest.cpp
    testcase/dgw_client_config_stest.cpp
    testcase/dgw_client_stest.cpp
    testcase/bind_relation_stest.cpp
    testcase/queue_schedule_sub_module_interface_stest.cpp
    testcase/bqs_server_stest.cpp
    testcase/msprof_manager_stest.cpp
    testcase/bqs_so_msnager_stest.cpp
    testcase/queue_schedule_stest.cpp
    testcase/dynamic_sched_mgr_stest.cpp
    testcase/qs_proc_mem_statistic_stest.cpp
    testcase/entity_stest.cpp
    testcase/bqs_log_stest.cpp
    ../stub/dlopen_stub.cpp
    ../stub/easy_comm_stub.cpp
    ../stub/queue_api.cpp
    ../stub/drv_buf_api.cpp
    ../stub/event_sched_api.cpp
    ../stub/driver_stub.cpp
    ../stub/marker_stub.cpp
    ../stub/profile_common_stub.cpp
    ../stub/msprof_stub.cpp
    ../stub/slog_stub.cpp
    ../stub/queue_schedule_stub.cpp
    ${PROTO_SRCS}
)

set(LOCAL_C_INCLUDES
    ${SRC_PATH}/server/dynamic_sched
    ${SRC_PATH}/server/entity_manager
    ${SRC_PATH}/server/fsm
    ${SRC_PATH}/server
    ${SRC_PATH}/common
    ${SRC_PATH}/client/inc
    ${SRC_PATH}/stub/proc_mgr
    ${SRC_PATH}
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/tsd
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/include
    ${CMAKE_BINARY_DIR}/proto/aicpu
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub
    ${OPEN_SOURCE_DIR}/mockcpp_src/include
)

add_executable(queue_schedule_st
     ${LOCAL_SRC_FILES}
)

target_include_directories(queue_schedule_st PRIVATE
    ${LOCAL_C_INCLUDES}
)

target_link_libraries(queue_schedule_st PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    $<BUILD_INTERFACE:slog_headers>
    ascend_protobuf
    c_sec
    -rdynamic
    -lpthread
    -lrt
    -ldl
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    -fsanitize=undefined
    c_sec_headers
)

target_compile_options(queue_schedule_st PRIVATE
    ${common_compile_options}
)

target_compile_definitions(queue_schedule_st PRIVATE
    STATISTIC
    google=ascend_private
    aicpusd_UT
    RUN_ON_X86
)