# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
# 支持独立构建和主工程引入；独立构建缺依赖报错，主工程缺依赖则跳过。
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    cmake_minimum_required(VERSION 3.16)
    project(cc_aiv_kernels NONE)
    set(CC_AIV_KERNELS_STANDALONE ON)
else()
    set(CC_AIV_KERNELS_STANDALONE OFF)
endif()

set(_CC_KERNEL_NEEDS "需要 bisheng + ld.lld + AscendC 头")

macro(cc_kernel_abort reason hint)
    if(CC_AIV_KERNELS_STANDALONE)
        message(FATAL_ERROR "${_CC_KERNEL_NEEDS}\n  ${reason}\n  修复：${hint}")
    else()
        message(WARNING "CC AIV kernels SKIPPED: ${reason}\n  修复：${hint}")
        return()
    endif()
endmacro()

function(cc_find_dir out_var rel_list marker)
    foreach(_root IN LISTS ARGN)
        if(_root STREQUAL "")
            continue()
        endif()
        foreach(_rel IN LISTS ${rel_list})
            file(GLOB _dirs "${_root}/${_rel}")
            foreach(_dir IN LISTS _dirs)
                if(marker STREQUAL "" OR EXISTS "${_dir}/${marker}")
                    set(${out_var} "${_dir}" PARENT_SCOPE)
                    return()
                endif()
            endforeach()
        endforeach()
    endforeach()
endfunction()
function(cc_find_glob out_var rel_list marker)
    foreach(_root IN LISTS ARGN)
        if(_root STREQUAL "")
            continue()
        endif()
        set(_pats "")
        foreach(_rel IN LISTS ${rel_list})
            list(APPEND _pats "${_root}/${_rel}")
        endforeach()
        file(GLOB _dirs ${_pats})
        foreach(_dir IN LISTS _dirs)
            if(EXISTS "${_dir}/${marker}")
                set(${out_var} "${_dir}" PARENT_SCOPE)
                return()
            endif()
        endforeach()
    endforeach()
endfunction()

if(RUNTIME_DIR)
    get_filename_component(CC_REPO_ROOT "${RUNTIME_DIR}" ABSOLUTE)
else()
    get_filename_component(CC_REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../.." ABSOLUTE)
endif()

set(CC_HOST_ARCH "${CMAKE_HOST_SYSTEM_PROCESSOR}")
if(NOT CC_HOST_ARCH)
    set(CC_HOST_ARCH "${CMAKE_SYSTEM_PROCESSOR}")
endif()

set(_cc_cann_roots "")
foreach(_env_name ASCEND_HOME_PATH ASCEND_TOOLKIT_HOME ASCEND_HOME)
    if(DEFINED ENV{${_env_name}} AND NOT "$ENV{${_env_name}}" STREQUAL "")
        list(APPEND _cc_cann_roots "$ENV{${_env_name}}")
    endif()
endforeach()
file(GLOB _cc_cann_glob
    "/usr/local/Ascend/ascend-toolkit/latest"
    "/usr/local/Ascend/ascend-toolkit/*"
    "/usr/local/Ascend/driver"
    "/usr/local/Ascend/*"
    "/opt/Ascend/ascend-toolkit/latest"
    "/opt/Ascend/*"
    "$ENV{HOME}/Ascend/cann-*"
    "$ENV{HOME}/Ascend/ascend-toolkit/latest"
    "$ENV{HOME}/Ascend/ascend-toolkit/*")
foreach(_cc_cand ${_cc_cann_glob})
    if(IS_DIRECTORY "${_cc_cand}")
        list(APPEND _cc_cann_roots "${_cc_cand}")
    endif()
endforeach()
list(APPEND _cc_cann_roots "${CC_REPO_ROOT}/../Ascend/cann" "${CMAKE_SOURCE_DIR}/../Ascend/cann")
list(REMOVE_DUPLICATES _cc_cann_roots)

set(_cc_tool_rels
    bin
    tools/bisheng_compiler/bin
    tools/ccec_compiler/bin
    ${CC_HOST_ARCH}-linux/ccec_compiler/bin
    ${CC_HOST_ARCH}-linux/bin
    compiler/ccec_compiler/bin
    aarch64-linux/ccec_compiler/bin)
function(cc_tool_hints out_var)
    set(_hints "")
    foreach(_root IN LISTS ARGN)
        if(_root STREQUAL "")
            continue()
        endif()
        foreach(_rel IN LISTS _cc_tool_rels)
            list(APPEND _hints "${_root}/${_rel}")
        endforeach()
    endforeach()
    list(REMOVE_DUPLICATES _hints)
    set(${out_var} "${_hints}" PARENT_SCOPE)
endfunction()

cc_tool_hints(_cc_bisheng_hints ${_cc_cann_roots})
find_program(BISHENG NAMES bisheng HINTS ${_cc_bisheng_hints})

if(BISHENG)
    get_filename_component(_cc_probe "${BISHENG}" DIRECTORY)
    foreach(_i RANGE 1 5)
        get_filename_component(_cc_probe "${_cc_probe}" DIRECTORY)
        if(EXISTS "${_cc_probe}/include" AND EXISTS "${_cc_probe}/lib64")
            set(CC_BISHENG_ROOT "${_cc_probe}")
            break()
        endif()
    endforeach()
    if(NOT CC_BISHENG_ROOT)
        get_filename_component(_bisheng_bin "${BISHENG}" DIRECTORY)
        get_filename_component(CC_BISHENG_ROOT "${_bisheng_bin}" DIRECTORY)
    endif()
endif()
if(NOT CANN_ROOT)
    if(CC_BISHENG_ROOT)
        set(CANN_ROOT "${CC_BISHENG_ROOT}")
    else()
        foreach(_root IN LISTS _cc_cann_roots)
            if(EXISTS "${_root}/bin/bisheng" OR EXISTS "${_root}/asc/include/kernel_operator.h")
                set(CANN_ROOT "${_root}")
                break()
            endif()
        endforeach()
    endif()
endif()
if(NOT CANN_ROOT)
    cc_kernel_abort("bisheng 未找到（CANN 候选根与 PATH 都没有）"
        "export ASCEND_HOME_PATH=<CANN 根>，或 -DBISHENG=<path>")
endif()

cc_tool_hints(_cc_lld_hints ${_cc_cann_roots} "${CANN_ROOT}" "${CC_BISHENG_ROOT}")
find_program(CC_AICORE_LD_LLD NAMES ld.lld HINTS ${_cc_lld_hints})

set(_cc_missing_tools)
foreach(_tool BISHENG CC_AICORE_LD_LLD)
    if(NOT ${_tool})
        list(APPEND _cc_missing_tools "${_tool}")
    endif()
endforeach()
if(_cc_missing_tools)
    string(REPLACE ";" ", " _cc_missing_pretty "${_cc_missing_tools}")
    cc_kernel_abort("缺少必需工具: ${_cc_missing_pretty}"
        "加载完整 CANN toolkit（PATH 里带上 <root>/<arch>-linux/ccec_compiler/bin）")
endif()
message(STATUS "CC AIV kernels: CANN root=${CANN_ROOT}, bisheng=${BISHENG}, ld.lld=${CC_AICORE_LD_LLD}")

set(CC_AIV_ARCH "dav-3510")

set(CC_ASCENDC_INCLUDE_DIR "$ENV{CC_ASCENDC_INCLUDE_DIR}" CACHE PATH
    "AscendC include dir containing kernel_operator.h; probed when empty")
set(CC_ASCEND_HOME "${CANN_ROOT}")

if(NOT (CC_ASCENDC_INCLUDE_DIR AND EXISTS "${CC_ASCENDC_INCLUDE_DIR}/kernel_operator.h"))
    set(_cc_ascendc_rels
        asc/include
        ${CC_HOST_ARCH}-linux/asc/include
        aarch64-linux/asc/include
        x86_64-linux/asc/include
        tools/asc/include
        compiler/asc/include
        ascendc_devkit/asc/include
        ${CC_HOST_ARCH}-linux/ascendc/include
        compiler/ascendc/include
        tools/ascendc/include
        ascendc_devkit/ascendc/include
        ../asc/asc-devkit/include
        ../asc-devkit/include
        ../../asc-devkit/include)
    cc_find_dir(CC_ASCENDC_INCLUDE_DIR _cc_ascendc_rels kernel_operator.h
        ${_cc_cann_roots} "${CANN_ROOT}" "${CC_BISHENG_ROOT}" "${CC_REPO_ROOT}" "${CMAKE_SOURCE_DIR}")
endif()

if(NOT (CC_ASCENDC_INCLUDE_DIR AND EXISTS "${CC_ASCENDC_INCLUDE_DIR}/kernel_operator.h"))
    cc_kernel_abort("未找到 AscendC 头 kernel_operator.h（CANN 安装布局与 asc-devkit 源码树布局都探测过）"
        "-DCC_ASCENDC_INCLUDE_DIR=<含 kernel_operator.h 的目录>")
endif()

get_filename_component(CC_ASCENDC_ROOT "${CC_ASCENDC_INCLUDE_DIR}" DIRECTORY)
get_filename_component(CC_ASCENDC_PARENT "${CC_ASCENDC_ROOT}" DIRECTORY)
set(CC_ASCENDC_INCLUDE_FLAGS)
if(NOT CC_ASCENDC_INCLUDE_DIR STREQUAL "${CANN_ROOT}/asc/include")
foreach(_dir
    "${CC_ASCENDC_INCLUDE_DIR}"
    "${CC_ASCENDC_INCLUDE_DIR}/basic_api"
    "${CC_ASCENDC_INCLUDE_DIR}/simt_api"
    "${CC_ASCENDC_ROOT}"
    "${CC_ASCENDC_ROOT}/impl"
    "${CC_ASCENDC_ROOT}/impl/basic_api"
    "${CC_ASCENDC_ROOT}/impl/simt_api"
    "${CC_ASCENDC_INCLUDE_DIR}/adv_api"
    "${CC_ASCENDC_INCLUDE_DIR}/aicpu_api"
    "${CC_ASCENDC_INCLUDE_DIR}/c_api"
    "${CC_ASCENDC_INCLUDE_DIR}/utils"
    "${CC_ASCENDC_INCLUDE_DIR}/basic_api/reg_compute"
    "${CC_ASCENDC_ROOT}/impl/adv_api"
    "${CC_ASCENDC_ROOT}/impl/c_api"
    "${CC_ASCENDC_ROOT}/impl/basic_api/reg_compute"
    "${CC_ASCENDC_ROOT}/impl/utils"
    "${CC_ASCENDC_PARENT}/tikcpp/tikcfw"
    "${CC_ASCENDC_PARENT}/tikcpp/tikcfw/interface"
    "${CC_ASCENDC_PARENT}/tikcpp/tikcfw/impl"
    "${CC_ASCENDC_ROOT}/tikcpp/tikcfw"
    "${CC_ASCENDC_ROOT}/tikcpp/tikcfw/interface"
    "${CC_ASCENDC_ROOT}/tikcpp/tikcfw/impl")
    if(EXISTS "${_dir}")
        list(APPEND CC_ASCENDC_INCLUDE_FLAGS "-I${_dir}")
    endif()
endforeach()
else()
    message(STATUS "  AscendC -I: 标准 toolkit 布局，走 bisheng 内置搜索根，无需显式 -I")
endif()

set(CC_ASCENDC_HIGHLEVEL_DIR "$ENV{CC_ASCENDC_HIGHLEVEL_DIR}" CACHE PATH
    "AscendC highlevel_api dir (contains kernel_tiling/kernel_tiling.h); probed when empty")
set(CC_ASCENDC_KERNEL_TILING_DEP)
set(_hl_dir "${CC_ASCENDC_HIGHLEVEL_DIR}")
if(NOT (_hl_dir AND EXISTS "${_hl_dir}/kernel_tiling/kernel_tiling.h"))
    set(_hl_dir "")
    set(_hl_roots "${CANN_ROOT}" "${CC_BISHENG_ROOT}" "${CC_ASCENDC_ROOT}/.." ${_cc_cann_roots})
    set(_asc_walk "${CC_BISHENG_ROOT}")
    foreach(_i RANGE 1 4)
        get_filename_component(_asc_walk "${_asc_walk}" DIRECTORY)
        if(_asc_walk STREQUAL "/" OR _asc_walk STREQUAL "")
            break()
        endif()
        list(APPEND _hl_roots "${_asc_walk}")
    endforeach()
    list(REMOVE_DUPLICATES _hl_roots)
    set(_hl_rels
        include/ascendc/highlevel_api
        ascendc/include/highlevel_api
        *-linux/ascendc/include/highlevel_api
        *-linux/include/ascendc/highlevel_api
        *-linux/tikcpp/tikcfw
        tikcpp/tikcfw
        compiler/*/ascendc/include/highlevel_api
        compiler/ascendc/include/highlevel_api
        tools/ascendc/include/highlevel_api
        ascendc_devkit/ascendc/include/highlevel_api
        tools/compiler/ascendc/include/highlevel_api)
    cc_find_glob(_hl_dir _hl_rels kernel_tiling/kernel_tiling.h ${_hl_roots})
endif()
if(_hl_dir)
    list(APPEND CC_ASCENDC_INCLUDE_FLAGS "-I${_hl_dir}")
    message(STATUS "  AscendC kernel_tiling: ${_hl_dir}/kernel_tiling/kernel_tiling.h (toolkit)")
else()
    set(_kt_gen_script "${CC_ASCENDC_ROOT}/impl/adv_api/cmake/scripts/gen_kernel_tiling_data_def.py")
    set(_kt_src_dir "${CC_ASCENDC_INCLUDE_DIR}/adv_api")
    if(EXISTS "${_kt_gen_script}" AND EXISTS "${_kt_src_dir}")
        find_program(CC_PYTHON3_EXECUTABLE NAMES python3 python)
        if(CC_PYTHON3_EXECUTABLE)
            set(_kt_out_dir "${CMAKE_CURRENT_BINARY_DIR}/gen_kernel_tiling")
            set(CC_ASCENDC_KERNEL_TILING_DEP "${_kt_out_dir}/kernel_tiling/kernel_tiling.h")
            add_custom_command(OUTPUT "${CC_ASCENDC_KERNEL_TILING_DEP}"
                COMMAND "${CC_PYTHON3_EXECUTABLE}" "${_kt_gen_script}" "${_kt_src_dir}"
                    "${CC_ASCENDC_KERNEL_TILING_DEP}"
                DEPENDS "${_kt_gen_script}"
                COMMENT "Generating kernel_tiling/kernel_tiling.h from ${_kt_src_dir}"
                VERBATIM)
            list(APPEND CC_ASCENDC_INCLUDE_FLAGS "-I${_kt_out_dir}")
            message(STATUS "  AscendC kernel_tiling: generated from ${_kt_src_dir} into ${_kt_out_dir}")
        else()
            cc_kernel_abort("缺 python3，无法从 ${_kt_src_dir} 生成 kernel_tiling.h"
                "安装 python3，或 -DCC_ASCENDC_HIGHLEVEL_DIR=<含 kernel_tiling/kernel_tiling.h 的目录>")
        endif()
    else()
        cc_kernel_abort("kernel_tiling.h 缺失且无法生成（工具链里没有、adv_api 下也没有生成脚本）"
            "-DCC_ASCENDC_HIGHLEVEL_DIR=<含 kernel_tiling/kernel_tiling.h 的目录>")
    endif()
endif()
message(STATUS "  AscendC include: ${CC_ASCENDC_INCLUDE_DIR}")

if(_hl_dir)
    set(_cc_kt_resolved "${_hl_dir}/kernel_tiling/kernel_tiling.h")
else()
    set(_cc_kt_resolved "${CC_ASCENDC_KERNEL_TILING_DEP}（构建期由脚本生成）")
endif()
message(STATUS "CC AIV kernel deps:")
message(STATUS "  [bin] bisheng      : ${BISHENG}")
message(STATUS "  [bin] ld.lld       : ${CC_AICORE_LD_LLD}")
if(CC_PYTHON3_EXECUTABLE)
    message(STATUS "  [bin] python3      : ${CC_PYTHON3_EXECUTABLE}")
else()
    message(STATUS "  [bin] python3      : （未用到：kernel_tiling.h 直接取自工具链）")
endif()
message(STATUS "  [root] CANN        : ${CANN_ROOT}")
message(STATUS "  [root] bisheng     : ${CC_BISHENG_ROOT}")
message(STATUS "  [hdr]  AscendC     : ${CC_ASCENDC_INCLUDE_DIR}")
message(STATUS "  [hdr]  AscendC root: ${CC_ASCENDC_ROOT}")
message(STATUS "  [hdr]  kernel_tiling: ${_cc_kt_resolved}")
message(STATUS "  [flags] AscendC -I（逐个列出，便于去掉冗余目录）:")
foreach(_cc_flag IN LISTS CC_ASCENDC_INCLUDE_FLAGS)
    message(STATUS "    ${_cc_flag}")
endforeach()

set(aiv_fatbin_name "cc_aiv_ks_xor")
set(aiv_compiled "${CMAKE_CURRENT_BINARY_DIR}/${aiv_fatbin_name}_raw.o")
set(aiv_fatbin_file "${CMAKE_CURRENT_BINARY_DIR}/${aiv_fatbin_name}.o")
add_custom_command(OUTPUT "${aiv_compiled}"
    COMMAND "${CMAKE_COMMAND}" -E env "ASCEND_HOME_PATH=${CC_ASCEND_HOME}"
        "${BISHENG}" -std=c++17 -O3 -DNDEBUG -fPIC --aicore-only
        "--npu-arch=${CC_AIV_ARCH}" -c --asc-aicore-lang ${CC_ASCENDC_INCLUDE_FLAGS}
        "${CMAKE_CURRENT_SOURCE_DIR}/kernel_ks_xor_aiv.cpp" -o "${aiv_compiled}"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/kernel_ks_xor_aiv.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/cc_kernel_abi.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/../../task_queue/task_queue_abi.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/../../task_queue/aivec_task_queue.h"
        ${CC_ASCENDC_KERNEL_TILING_DEP} VERBATIM)
add_custom_command(OUTPUT "${aiv_fatbin_file}"
    COMMAND "${CC_AICORE_LD_LLD}" -m aicorelinux -Ttext=0 "${aiv_compiled}" -static
        -o "${aiv_fatbin_file}"
    DEPENDS "${aiv_compiled}" VERBATIM)
set(CC_AIV_FATBIN_FILES "${aiv_fatbin_file}")
message(STATUS "AIV fatbin enabled: arch=${CC_AIV_ARCH} (${aiv_fatbin_name}.o)")

add_custom_target(cc_aiv_kernels ALL DEPENDS ${CC_AIV_FATBIN_FILES})

if(NOT CC_AIV_KERNELS_STANDALONE)
    if(ENABLE_OPEN_SRC)
        set(CC_AIV_INSTALL_DIR "${CMAKE_SYSTEM_PROCESSOR}-linux/lib64/ops")
    else()
        set(CC_AIV_INSTALL_DIR "lib/ops")
    endif()

    install(FILES ${CC_AIV_FATBIN_FILES} OPTIONAL
        DESTINATION ${CC_AIV_INSTALL_DIR}
        COMPONENT npu-runtime
        PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ)
    message(STATUS "CC AIV kernels will be installed to ${CC_AIV_INSTALL_DIR}/")
endif()

message(STATUS "CC AIV kernels summary: arch=${CC_AIV_ARCH}")
