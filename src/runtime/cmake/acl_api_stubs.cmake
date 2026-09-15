# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(ACL_API_STUB_GENERATOR
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/generate_acl_api_stubs.py
)
set(ACL_API_STUB_PARSER
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/gen_dynamic_stub.py
)
set(ACL_API_STUB_WRAPPER
    ${RUNTIME_DIR}/src/acl/aclrt_impl/acl_rt_wrapper.h
)

function(check_acl_api_stub_product product)
    if(NOT "${product}" STREQUAL "arch5162")
        message(FATAL_ERROR "ACL API generated stubs are restricted to arch5162 libruntime.so")
    endif()
endfunction()

function(generate_acl_api_stubs product product_def output_var)
    check_acl_api_stub_product(${product})
    set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/generated/acl_api_stubs/${product})
    set(output_source ${output_dir}/acl_rt_impl_generated_stub.cc)
    set(output_report ${output_dir}/acl_provider_report.csv)

    add_custom_command(
        OUTPUT ${output_source}
        BYPRODUCTS ${output_report}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${output_dir}
        COMMAND python3 ${ACL_API_STUB_GENERATOR}
            --wrapper ${ACL_API_STUB_WRAPPER}
            --product-def ${product_def}
            --product ${product}
            --output ${output_source}
            --report ${output_report}
        COMMAND ${CMAKE_COMMAND} -E touch ${output_source}
        DEPENDS
            ${ACL_API_STUB_GENERATOR}
            ${ACL_API_STUB_PARSER}
            ${ACL_API_STUB_WRAPPER}
            ${product_def}
        VERBATIM
    )
    set_source_files_properties(${output_source} PROPERTIES GENERATED TRUE)
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(SOURCE ${output_source} APPEND PROPERTY
            COMPILE_OPTIONS -ffunction-sections -fdata-sections
        )
    endif()
    set_property(SOURCE ${output_source} APPEND PROPERTY
        COMPILE_DEFINITIONS OS_TYPE=0 FUNC_VISIBILITY
    )
    set(${output_var} ${output_source} PARENT_SCOPE)
endfunction()

function(configure_acl_impl_weak_real_sources product)
    check_acl_api_stub_product(${product})
    if("${ARGN}" STREQUAL "")
        message(FATAL_ERROR "ACL Impl weak real source list must not be empty")
    endif()
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(SOURCE ${ARGN} APPEND PROPERTY
            COMPILE_OPTIONS -ffunction-sections -fdata-sections
        )
        set_property(SOURCE ${ARGN} APPEND PROPERTY
            COMPILE_DEFINITIONS
            $<$<BOOL:$<TARGET_PROPERTY:ACL_IMPL_WEAK_PROVIDER>>:ACL_IMPL_WEAK_PROVIDER>
        )
    endif()
endfunction()

function(enable_acl_impl_weak_override target_name)
    get_target_property(acl_api_target_type ${target_name} TYPE)
    if(NOT "${acl_api_target_type}" STREQUAL "SHARED_LIBRARY")
        message(FATAL_ERROR "ACL Impl weak override requires a standalone shared libruntime target")
    endif()
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(TARGET ${target_name} PROPERTY ACL_IMPL_WEAK_PROVIDER TRUE)
        target_link_options(${target_name} PRIVATE -Wl,--gc-sections)
    endif()
endfunction()
