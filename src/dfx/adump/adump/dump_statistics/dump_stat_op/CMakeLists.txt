# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# kfc dump stat 算子由 ccec 编译，不走 CMake 内置 C/C++ 编译规则，统一通过 custom command 生成
set(DUMP_STAT_OP_SRC ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_stat.cpp)
set(DUMP_STAT_OP_HEADERS
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_base.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_inf.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_l2norm.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_max_or_min.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_mean.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_multi_core.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_nan.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_op_base.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_param.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_server.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_single_core.h
    ${CMAKE_CURRENT_LIST_DIR}/kfc_dump_stat_all.h
)

set(tiling_script ${TOP_DIR}/asc/asc-devkit/impl/adv_api/cmake/scripts/gen_kernel_tiling_data_def.py)
set(TILING_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR})
set(tiling_gen_file ${TILING_GEN_DIR}/kernel_tiling/kernel_tiling.h)
set(tiling_data_def_path ${TOP_DIR}/asc/asc-devkit/include/adv_api)

add_custom_command(OUTPUT ${tiling_gen_file}
    COMMAND python3 ${tiling_script} ${tiling_data_def_path} ${tiling_gen_file}
    DEPENDS ${tiling_script} ${tiling_data_def_path})

####### dump_stat_op_ascend910B.o ########
set(LINK_OBJ_ASCEND910B "${CMAKE_CURRENT_BINARY_DIR}/dump_stat_op_ascend910B.o")

add_custom_command(OUTPUT ${LINK_OBJ_ASCEND910B}
    COMMAND ${CCEC_PATH}/ccec -x cce -O2 --cce-aicore-arch=dav-c220-vec
            --cce-aicore-input-parameter-size=3072 --cce-aicore-only
            -mllvm -cce-aicore-function-stack-size=16000
            -mllvm -cce-aicore-record-overflow=false
            -mllvm -cce-aicore-addr-transform
            -mllvm --cce-aicore-jump-expand=true
            -std=c++17 -fstack-protector-all
            -I${CMAKE_CURRENT_BINARY_DIR}
            -I${TOP_DIR}/asc/asc-devkit/
            -I${TOP_DIR}/asc/asc-devkit/include/
            -I${TOP_DIR}/asc/asc-devkit/include/basic_api/
            -I${TOP_DIR}/asc/asc-devkit/include/micro_api/
            -I${TOP_DIR}/asc/asc-devkit/include/simt_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/
            -I${TOP_DIR}/asc/asc-devkit/impl/basic_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/micro_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/simt_api/
            -I${TILING_GEN_DIR}
            -o ${LINK_OBJ_ASCEND910B}
            ${DUMP_STAT_OP_SRC}
    DEPENDS ${DUMP_STAT_OP_SRC} ${DUMP_STAT_OP_HEADERS} ${tiling_gen_file}
    COMMENT "CompileStage dump_stat_op_ascend910B"
    VERBATIM
)

add_custom_target(dump_stat_op_ascend910B ALL
    DEPENDS ${LINK_OBJ_ASCEND910B}
)

install(FILES ${LINK_OBJ_ASCEND910B}
    DESTINATION ${INSTALL_LIBRARY_DIR} RENAME dump_stat_op_ascend910B.o OPTIONAL
)

####### dump_stat_op_ascend950.o ########
set(OBJ_ASCEND950_O "${CMAKE_CURRENT_BINARY_DIR}/dump_stat_op_ascend950_o.o")
set(LINK_OBJ_FATBIN_ASCEND950 "${CMAKE_CURRENT_BINARY_DIR}/dump_stat_op_ascend950_fatbin.o")
set(LINK_OBJ_ASCEND950 "${CMAKE_CURRENT_BINARY_DIR}/dump_stat_op_ascend950.o")

add_custom_command(OUTPUT ${OBJ_ASCEND950_O}
    COMMAND ${CCEC_PATH}/ccec -x cce -O2
            --cce-aicore-arch=dav-c310-vec
            --cce-aicore-input-parameter-size=3072
            --cce-aicore-only
            -Xclang -fcce-vf-vl=256
            --cce-auto-sync=off
            -ferror-limit=0
            -w
            --cce-simd-vf-fusion=false
            -std=c++17 -fstack-protector-all
            -DENABLE_MOVVP
            -DPERF_API_NORM
            -mllvm -cce-aicore-function-stack-size=0x8000
            -mllvm -cce-aicore-addr-transform
            -mllvm -cce-aicore-or-combine=false
            -mllvm -instcombine-code-sinking=false
            -mllvm -cce-aicore-mask-opt=false
            -mllvm --cce-aicore-jump-expand=true
            -mllvm -cce-aicore-dcci-before-kernel-end=false
            -mllvm -cce-aicore-dcci-insert-for-scalar=false
            -mllvm -api-deps-filter
            -mllvm -cce-aicore-stack-size=0x8000
            -mllvm -cce-aicore-record-overflow=false
            -mllvm -cce-aicore-long-call
            -I${CMAKE_CURRENT_SOURCE_DIR}
            -I${TOP_DIR}/asc/asc-devkit/
            -I${TOP_DIR}/asc/asc-devkit/include/
            -I${TOP_DIR}/asc/asc-devkit/include/basic_api/
            -I${TOP_DIR}/asc/asc-devkit/include/micro_api/
            -I${TOP_DIR}/asc/asc-devkit/include/simt_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/
            -I${TOP_DIR}/asc/asc-devkit/impl/basic_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/micro_api/
            -I${TOP_DIR}/asc/asc-devkit/impl/simt_api/
            -I${TILING_GEN_DIR}
            -o ${OBJ_ASCEND950_O}
            ${DUMP_STAT_OP_SRC}
    DEPENDS ${DUMP_STAT_OP_SRC} ${DUMP_STAT_OP_HEADERS} ${tiling_gen_file}
    COMMENT "CompileStage dump_stat_op_ascend950_o"
    VERBATIM
)

add_custom_command(OUTPUT ${LINK_OBJ_FATBIN_ASCEND950}
    COMMAND ${CCEC_PATH}/ld.lld
            -m aicorelinux
            -r
            -Ttext=0
            -q
            ${OBJ_ASCEND950_O}
            -static
            -o ${LINK_OBJ_FATBIN_ASCEND950}
    DEPENDS ${OBJ_ASCEND950_O}
    COMMENT "CompileStage FATBIN"
    VERBATIM
)

add_custom_command(OUTPUT ${LINK_OBJ_ASCEND950}
    COMMAND ${CCEC_PATH}/ld.lld
            -m aicorelinux
            -Ttext=0
            ${LINK_OBJ_FATBIN_ASCEND950}
            -static
            -o ${LINK_OBJ_ASCEND950}
            -q
    DEPENDS ${LINK_OBJ_FATBIN_ASCEND950}
    COMMENT "CompileStage LINKRELOCATE"
    VERBATIM
)

add_custom_target(dump_stat_op_ascend950 ALL
    DEPENDS ${LINK_OBJ_ASCEND950}
)

install(FILES ${LINK_OBJ_ASCEND950}
    DESTINATION ${INSTALL_LIBRARY_DIR} RENAME dump_stat_op_ascend950.o OPTIONAL
)
