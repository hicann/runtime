# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# This helper is only for standalone device-side libruntime.so builds whose
# unsupported APIs must override weak real providers. Currently only tiny and
# arch5162 use this model. Host runtime, cmodel, and other product forms must
# keep their existing source selection and strong API providers. Product UTs
# may reuse stub generation to verify the same capability definition.
set(RUNTIME_API_STUB_CATALOG
    ${RUNTIME_DIR}/src/runtime/api/runtime_api_stub_catalog.def
)
set(RUNTIME_API_STUB_GENERATOR
    ${RUNTIME_DIR}/src/runtime/cmake/generate_runtime_api_stubs.py
)

function(check_runtime_api_stub_product product)
    if(NOT "${product}" STREQUAL "tiny" AND NOT "${product}" STREQUAL "arch5162")
        message(FATAL_ERROR
            "Runtime API generated stubs are restricted to standalone device-side tiny/arch5162 libruntime.so")
    endif()
endfunction()

function(configure_runtime_api_weak_real_sources product)
    check_runtime_api_stub_product(${product})
    if("${ARGN}" STREQUAL "")
        message(FATAL_ERROR "Runtime API weak real source list must not be empty")
    endif()
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(SOURCE ${ARGN} APPEND PROPERTY
            COMPILE_OPTIONS -ffunction-sections -fdata-sections
        )
        set_property(SOURCE ${ARGN} APPEND PROPERTY
            COMPILE_DEFINITIONS
            $<$<BOOL:$<TARGET_PROPERTY:RUNTIME_API_WEAK_PROVIDER>>:RUNTIME_API_WEAK_PROVIDER>
        )
    endif()
endfunction()

function(generate_runtime_api_stubs product product_def output_var)
    check_runtime_api_stub_product(${product})
    set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/generated/runtime_api_stubs/${product})
    set(output_source ${output_dir}/api_c_generated_stub.cc)
    set(output_report ${output_dir}/api_provider_report.csv)
    set(generated_outputs ${output_source})
    set(generator_test_args)
    if(ARGC GREATER 3)
        set(output_test_source ${output_dir}/api_c_generated_stub_test.cc)
        list(APPEND generated_outputs ${output_test_source})
        list(APPEND generator_test_args --test-output ${output_test_source})
    endif()

    add_custom_command(
        OUTPUT ${generated_outputs}
        BYPRODUCTS ${output_report}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${output_dir}
        COMMAND python3 ${RUNTIME_API_STUB_GENERATOR}
            --catalog ${RUNTIME_API_STUB_CATALOG}
            --product-def ${product_def}
            --product ${product}
            --output ${output_source}
            --report ${output_report}
            ${generator_test_args}
        COMMAND ${CMAKE_COMMAND} -E touch ${generated_outputs}
        DEPENDS
            ${RUNTIME_API_STUB_GENERATOR}
            ${RUNTIME_API_STUB_CATALOG}
            ${product_def}
        VERBATIM
    )
    set_source_files_properties(${generated_outputs} PROPERTIES GENERATED TRUE)
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(SOURCE ${output_source} APPEND PROPERTY
            COMPILE_OPTIONS -ffunction-sections -fdata-sections
        )
    endif()
    set(${output_var} ${output_source} PARENT_SCOPE)
    if(ARGC GREATER 3)
        set(${ARGV3} ${output_test_source} PARENT_SCOPE)
    endif()
endfunction()

function(enable_runtime_api_weak_override target_name)
    get_target_property(runtime_api_target_type ${target_name} TYPE)
    if(NOT "${runtime_api_target_type}" STREQUAL "SHARED_LIBRARY")
        message(FATAL_ERROR "Runtime API weak override requires a standalone shared libruntime target")
    endif()
    if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
        set_property(TARGET ${target_name} PROPERTY RUNTIME_API_WEAK_PROVIDER TRUE)
        target_link_options(${target_name} PRIVATE
            -Wl,--gc-sections
        )
    endif()
endfunction()
