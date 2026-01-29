# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(DCACHE_LOCK_AIC_SOURCE ${CMAKE_CURRENT_LIST_DIR}/dcache_lock_aic.cce)
set(DCACHE_LOCK_AIC_OBJ    ${CMAKE_CURRENT_BINARY_DIR}/dcache_lock_aic.o)
set(DCACHE_LOCK_AIV_SOURCE ${CMAKE_CURRENT_LIST_DIR}/dcache_lock_aiv.cce)
set(DCACHE_LOCK_AIV_OBJ    ${CMAKE_CURRENT_BINARY_DIR}/dcache_lock_aiv.o)
set(DCACHE_LOCK_MIX_OBJ    ${CMAKE_CURRENT_BINARY_DIR}/dcache_lock_mix.o)

add_custom_target(dcache_lock_op_950
        DEPENDS ${DCACHE_LOCK_MIX_OBJ}
)

add_custom_command(OUTPUT ${DCACHE_LOCK_MIX_OBJ}
        COMMAND ${CCEC_PATH}/ccec -O2 ${DCACHE_LOCK_AIC_SOURCE} -mllvm -cce-aicore-dcci-before-kernel-end=false -mllvm -cce-aicore-dcpreload-args=false --cce-aicore-arch=dav-c310-cube --cce-aicore-only -o ${DCACHE_LOCK_AIC_OBJ}
        COMMAND ${CCEC_PATH}/ccec -O2 ${DCACHE_LOCK_AIV_SOURCE} -mllvm -cce-aicore-dcci-before-kernel-end=false -mllvm -cce-aicore-dcpreload-args=false --cce-aicore-arch=dav-c310-vec --cce-aicore-only -o ${DCACHE_LOCK_AIV_OBJ}
        COMMAND ${CCEC_PATH}/ld.lld -m aicorelinux -Ttext=0 -r -x ${DCACHE_LOCK_AIV_OBJ} -static -o ${DCACHE_LOCK_AIV_OBJ}
        COMMAND ${CCEC_PATH}/ld.lld -m aicorelinux -Ttext=0 -r -x ${DCACHE_LOCK_AIC_OBJ} -static -o ${DCACHE_LOCK_AIC_OBJ}
        COMMAND ${CCEC_PATH}/ld.lld -m aicorelinux -Ttext=0 ${DCACHE_LOCK_AIC_OBJ} ${DCACHE_LOCK_AIV_OBJ} -static -o ${DCACHE_LOCK_MIX_OBJ}
)

install(FILES ${DCACHE_LOCK_MIX_OBJ}
    DESTINATION lib/ascend950
    OPTIONAL
)
message("${DCACHE_LOCK_AIC_SOURCE}")
message("${DCACHE_LOCK_AIC_OBJ}")