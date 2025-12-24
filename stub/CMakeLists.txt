# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

##################################################################################################################
add_custom_target(
    stub_src ALL
    DEPENDS  ${CMAKE_CURRENT_BINARY_DIR}/acl_stub.cpp
             ${CMAKE_CURRENT_BINARY_DIR}/tdt_channel_stub.cpp
             ${CMAKE_CURRENT_BINARY_DIR}/tdt_queue_stub.cpp
             ${CMAKE_CURRENT_BINARY_DIR}/prof_stub.cpp
)
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/acl_stub.cpp
           ${CMAKE_CURRENT_BINARY_DIR}/tdt_channel_stub.cpp
           ${CMAKE_CURRENT_BINARY_DIR}/tdt_queue_stub.cpp
           ${CMAKE_CURRENT_BINARY_DIR}/prof_stub.cpp
    COMMAND echo "Generating stub files:acl_stub.cpp, tdt_channel_stub.cpp, tdt_queue_stub.cpp, prof_stub.cpp."
            && ${RUNTIME_PYTHON} ${CMAKE_CURRENT_LIST_DIR}/gen_stubapi.py ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
            ${CMAKE_CURRENT_BINARY_DIR}/acl_stub.cpp
            ${CMAKE_CURRENT_BINARY_DIR}/tdt_channel_stub.cpp
            ${CMAKE_CURRENT_BINARY_DIR}/tdt_queue_stub.cpp
            ${CMAKE_CURRENT_BINARY_DIR}/prof_stub.cpp
            && echo "Generating stub files end."
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS gen_stubapi.py ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
)
#----------------------------------------------------------------------------------------------------------------#

############ stub/libacl_rt.so ############
add_library(stub_acl_rt SHARED
    ${CMAKE_CURRENT_BINARY_DIR}/acl_stub.cpp
)

target_compile_definitions(stub_acl_rt PRIVATE
    _FORTIFY_SOURCE=2
)

set_target_properties(stub_acl_rt
    PROPERTIES
    OUTPUT_NAME acl_rt
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/stub
)

target_include_directories(stub_acl_rt PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/../include/external
    ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
)

target_link_libraries(stub_acl_rt
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
)

#----------------------------------------------------------------------------------------------------------------#

############ stub/libacl_tdt_channel.so ############
add_library(stub_acl_tdt_channel SHARED
    ${CMAKE_CURRENT_BINARY_DIR}/tdt_channel_stub.cpp
)
target_include_directories(stub_acl_tdt_channel PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/../include/external
    ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
)
target_compile_definitions(stub_acl_tdt_channel PRIVATE
    _FORTIFY_SOURCE=2
)
set_target_properties(stub_acl_tdt_channel
    PROPERTIES
    OUTPUT_NAME acl_tdt_channel
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/stub
)

target_link_libraries(stub_acl_tdt_channel PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:-lrt>
    -ldl
)
##################################################################################################################

############ stub/libacl_tdt_queue.so ############
add_library(stub_acl_tdt_queue SHARED
    ${CMAKE_CURRENT_BINARY_DIR}/tdt_queue_stub.cpp
)
target_include_directories(stub_acl_tdt_queue PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/../include/external
    ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
)
target_compile_definitions(stub_acl_tdt_queue PRIVATE
    _FORTIFY_SOURCE=2
)
set_target_properties(stub_acl_tdt_queue
    PROPERTIES
    OUTPUT_NAME acl_tdt_queue
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/stub
)

target_link_libraries(stub_acl_tdt_queue PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:-lrt>
    -ldl
)
##################################################################################################################

############ stub/libacl_prof.so ############
add_library(stub_acl_prof SHARED
    ${CMAKE_CURRENT_BINARY_DIR}/prof_stub.cpp
)
target_include_directories(stub_acl_prof PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/../include/external
    ${CMAKE_CURRENT_LIST_DIR}/../include/external/acl
)
target_compile_definitions(stub_acl_prof PRIVATE
    _FORTIFY_SOURCE=2
)
set_target_properties(stub_acl_prof
    PROPERTIES
    OUTPUT_NAME acl_prof
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/stub
)

target_link_libraries(stub_acl_prof PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:-lrt>
    -ldl
)
##################################################################################################################
