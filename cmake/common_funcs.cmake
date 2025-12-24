# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

function(to_absolute_path input_sources source_dir out_arg)
    set(output_sources)
    FOREACH(source_file ${${input_sources}})
        if(IS_ABSOLUTE ${source_file})
            list(APPEND output_sources ${source_file})
        else()
            if(${source_file} MATCHES ".cc$")
                list(APPEND output_sources ${${source_dir}}/${source_file})
            else()
                list(APPEND output_sources ${source_file})
            endif()
        endif()
    ENDFOREACH()
    set(${out_arg} ${output_sources} PARENT_SCOPE)
endfunction()

function(target_clone_compile_and_link_options original_library target_library)
    get_target_property(linkOpts ${original_library} LINK_OPTIONS)
    get_target_property(compileOptions ${original_library} COMPILE_OPTIONS)

    if (linkOpts)
        target_link_options(${target_library} PRIVATE
                ${linkOpts}
                )
    endif()
    if (compileOptions)
        target_compile_options(${target_library} PRIVATE
                ${compileOptions}
                )
    endif()
endfunction()

function(target_clone original_library target_library libray_type)
    get_target_property(sourceFiles ${original_library} SOURCES)
    get_target_property(sourceDir ${original_library} SOURCE_DIR)
    to_absolute_path(sourceFiles sourceDir absolute_sources_files)
    add_library(${target_library} ${libray_type}
            ${absolute_sources_files}
            )

    get_target_property(linkLibs ${original_library} LINK_LIBRARIES)
    get_target_property(includeDirs ${original_library} INCLUDE_DIRECTORIES)
    target_include_directories(${target_library} PRIVATE
            ${includeDirs}
            )

    target_link_libraries(${target_library} PRIVATE
            ${linkLibs}
            )
    get_target_property(compileDefinitions ${original_library} COMPILE_DEFINITIONS)
    if (compileDefinitions)
        target_compile_definitions(${target_library} PRIVATE
                ${compileDefinitions}
                )
    endif()
    target_clone_compile_and_link_options(${original_library} ${target_library})
endfunction()
