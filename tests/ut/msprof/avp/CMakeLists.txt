# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(src_file
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux_mem.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_thread.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/info_json.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sample_json.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_parser.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_generator.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sort_vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/utils/utils.c
    ${MSPROF_SOURCE_DIR}/avp/basic/thread/thread_pool.c
    ${MSPROF_SOURCE_DIR}/avp/basic/cstl/cstl_list.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_dsmi.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_prof.c
    ${MSPROF_SOURCE_DIR}/avp/basic/atomic/atomic_linux.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/report_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/report_buffer_mgr.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/hash_dic.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/report/start_time.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_pool.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/task/task_slot.c
    ${MSPROF_SOURCE_DIR}/avp/service/api/prof_api.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_impl.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_task.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_param.c
    ${MSPROF_SOURCE_DIR}/avp/service/impl/service_report.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_table.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_interface.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/chip/chip_nano_v1.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/job_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/collection_job.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/job/nano_stars_job.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/channel_manager.c
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/channel_reader.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/uploader.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/file_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/flash_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/param/profile_param.c
)

set(INCLUDE_DIR
    ${libmsprofHeaderDir}
    ${LIBC_SEC_HEADER}
    ${MSPROF_SOURCE_DIR}/
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${MSPROF_SOURCE_DIR}/avp/basic
    ${MSPROF_SOURCE_DIR}/avp/basic/thread
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/
    ${MSPROF_SOURCE_DIR}/avp/basic/logger
    ${MSPROF_SOURCE_DIR}/avp/domain
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/
    ${MSPROF_SOURCE_DIR}/avp/domain/param/
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/
    ${MSPROF_SOURCE_DIR}/avp/service/
    ${MSPROF_SOURCE_DIR}/avp/inc
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external/
    ${TOP_DIR}/tests/ut/msprof/st/data/
)

set(stub_file
    stub/drv_stub.cpp
    stub/file_interface_stub.cpp
    ../stub/slog_stub.cc
    ../stub/profile_drv_user_stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
)

set(test_file
    testcase/main.cpp
    testcase/vector_utest.cpp
    testcase/sort_vector_utest.cpp
    testcase/json_parser_utest.cpp
    testcase/utils_utest.cpp
    testcase/time_file_utest.cpp
    testcase/profile_param_utest.cpp
    testcase/acljson_nano_utest.cpp
    testcase/service_task_utest.cpp
    testcase/task_manager_utest.cpp
    testcase/thread_pool_utest.cpp
    testcase/hal_prof_utest.cpp
    testcase/job_manager_utest.cpp
    testcase/upload_utest.cpp
    testcase/platform_utest.cpp
    testcase/info_json_utest.cpp
    testcase/hash_dic_utest.cpp
    testcase/report_manager_utest.cpp
)

add_executable(prof_c_utest
    ${src_file}
    ${test_file}
    ${stub_file}
)


target_include_directories(prof_c_utest PRIVATE
    ${TOP_DIR}/tests/ut/msprof/avp/stub
    ${INCLUDE_DIR}
)

target_compile_options(prof_c_utest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(prof_c_utest PRIVATE
    C_SEC
    OSAL
    google=ascend_private
    PROF_LITE
    MSPROF_C
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

target_link_options(prof_c_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(prof_c_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
)

set_target_properties(prof_c_utest
    PROPERTIES
    OUTPUT_NAME prof_c_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### libproftransport.a ###########################
set(proftransportCpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/closed/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics/perf_count.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_ageing.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_slice.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_transport.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/transport/file_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../stub/error_manager_stub.cpp
)

set(proftransportInc
    ${libmsprofHeaderDir}
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/dvvp/common/statistics
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${TOP_DIR}/include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(proftransport_ut_static STATIC
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${proftransportCpp}
    ../stub/slog_stub.cc
)

target_include_directories(proftransport_ut_static PRIVATE
    ${proftransportInc}
    ${TOP_DIR}/graphengine/inc
    ${TOP_DIR}/graphengine/inc/framework
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${MSPROF_SOURCE_DIR}/dvvp/depend/c_base
)

set_target_properties(proftransport_ut_static
    PROPERTIES
    OUTPUT_NAME proftransport
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(proftransport_ut_static PRIVATE
    OSAL
)

target_compile_options(proftransport_ut_static PRIVATE
    -g
    -Wall
    -Werror
)

target_link_options(proftransport_ut_static PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_link_libraries(proftransport_ut_static PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
)

install(TARGETS proftransport_ut_static OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libproftransport.a ###########################


####################### prof_liteos_utest ############################
set(src_file
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_linux.c
    ${MSPROF_SOURCE_DIR}/basic/osal/osal_thread.c
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/flash_transport.c
    ${MSPROF_SOURCE_DIR}/avp/domain/param/profile_param.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_interface.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/platform_table.c
    ${MSPROF_SOURCE_DIR}/avp/basic/utils/utils.c
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/hal_dsmi.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/json_parser.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/sort_vector.c
    ${MSPROF_SOURCE_DIR}/avp/basic/json/vector.c
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/chip/chip_nano_v1.c
)

set(INCLUDE_DIR
    ${libmsprofHeaderDir}
    ${LIBC_SEC_HEADER}
    ${MSPROF_SOURCE_DIR}/
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/basic/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/avp/
    ${MSPROF_SOURCE_DIR}/avp/basic
    ${MSPROF_SOURCE_DIR}/avp/basic/thread
    ${MSPROF_SOURCE_DIR}/avp/basic/hal/
    ${MSPROF_SOURCE_DIR}/avp/basic/logger
    ${MSPROF_SOURCE_DIR}/avp/domain
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/
    ${MSPROF_SOURCE_DIR}/avp/domain/collect/channel/
    ${MSPROF_SOURCE_DIR}/avp/domain/param/
    ${MSPROF_SOURCE_DIR}/avp/domain/platform/
    ${MSPROF_SOURCE_DIR}/avp/domain/transport/
    ${MSPROF_SOURCE_DIR}/avp/service/
    ${MSPROF_SOURCE_DIR}/avp/inc
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/include/external/
    ${TOP_DIR}/tests/ut/msprof/st/data/
    stub/
)

set(stub_file
    stub/drv_stub.cpp
    ../stub/slog_stub.cc
    ../stub/profile_drv_user_stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
)

set(test_file
    testcase/main.cpp
    testcase/acljson_basic_liteos_utest.cpp
)

add_executable(prof_liteos_utest
    ${src_file}
    ${test_file}
    ${stub_file}
)


target_include_directories(prof_liteos_utest PRIVATE
    ${TOP_DIR}/llt/abl/msprof/ut/avp/stub
    ${INCLUDE_DIR}
)

target_compile_options(prof_liteos_utest PRIVATE
    -g
    -Wall
    -Werror
)

target_compile_definitions(prof_liteos_utest PRIVATE
    C_SEC
    OSAL
    google=ascend_private
    PROF_LITE
    MSPROF_C
    LITE_OS
    LLT_DATA_DIR="${LLT_DATA_DIR}"
)

target_link_options(prof_liteos_utest PRIVATE
   -ldl
   -lpthread
)

target_link_libraries(prof_liteos_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
)

set_target_properties(prof_liteos_utest
    PROPERTIES
    OUTPUT_NAME prof_liteos_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
