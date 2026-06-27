/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @file acl_platform.h
 *
 * @brief ACL Platform Query Interface.
 *
 * Provides APIs to query device hardware information and instruction
 * availability based on core type.
 */

#ifndef INC_PKG_PLATFORM_ACL_PLATFORM_H_
#define INC_PKG_PLATFORM_ACL_PLATFORM_H_

#include <stdint.h>
#include "acl_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum aclplatformDevInfo {
    ACL_PLATFORM_AICORE_CNT        = 0,
    ACL_PLATFORM_AICORE_UB_SIZE    = 1,
    ACL_PLATFORM_CUBE_CORE_CNT     = 2,
    ACL_PLATFORM_VECTOR_CORE_CNT   = 3,
    ACL_PLATFORM_L2_SIZE           = 4,
    ACL_PLATFORM_MEMORY_SIZE       = 5,
    ACL_PLATFORM_CUBE_FREQ         = 6,
    ACL_PLATFORM_VEC_FREQ          = 7,
    ACL_PLATFORM_BT_SIZE           = 8,
    ACL_PLATFORM_L0_A_SIZE         = 9,
    ACL_PLATFORM_L0_B_SIZE         = 10,
    ACL_PLATFORM_L0_C_SIZE         = 11,
    ACL_PLATFORM_L1_SIZE           = 12,
    ACL_PLATFORM_SOC_VERSION       = 13,
    ACL_PLATFORM_AIC_VERSION       = 14,
    ACL_PLATFORM_NPU_ARCH          = 15,
    ACL_PLATFORM_MEMORY_TYPE       = 16,
} aclplatformDevInfo;

typedef enum aclplatformCoreType {
    ACL_PLATFORM_CORE_TYPE_AI_CORE     = 0,  /**< AI Core (cube core) */
    ACL_PLATFORM_CORE_TYPE_VECTOR_CORE = 1,  /**< Vector core */
} aclplatformCoreType;

aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen);

aclError aclplatformGetInstructionInfo(aclplatformCoreType type,
                                        const char *instruction,
                                        char *value,
                                        uint32_t maxLen);

typedef enum aclplatformNpuArch {
    DAV_1001 = 1001,
    DAV_2002 = 2002,
    DAV_2102 = 2102,
    DAV_2201 = 2201,
    DAV_3002 = 3002,
    DAV_3003 = 3003,
    DAV_3004 = 3004,
    DAV_3102 = 3102,
    DAV_3113 = 3113,
    DAV_3505 = 3505,
    DAV_3510 = 3510,
    DAV_5102 = 5102,
    DAV_RESV = 0xFFFF
} aclplatformNpuArch;

// --------------------------------------------------------------------------
// Mapping: aclplatformDevInfo enum value → (ini section, ini key)
// Indexed by enum value; order MUST match aclplatformDevInfo definition.
//
//   aclplatformLocalMemType → aclplatformDevInfo 对应关系：
//     L0_A (0) → ACL_PLATFORM_L0_A_SIZE (9)
//     L0_B (1) → ACL_PLATFORM_L0_B_SIZE (10)
//     L0_C (2) → ACL_PLATFORM_L0_C_SIZE (11)
//     L1   (3) → ACL_PLATFORM_L1_SIZE   (12)
//     L2   (4) → ACL_PLATFORM_L2_SIZE   (4)
//     UB   (5) → ACL_PLATFORM_AICORE_UB_SIZE (1)
//     HBM  (6) → ACL_PLATFORM_MEMORY_SIZE    (5)
// --------------------------------------------------------------------------
typedef enum aclplatformLocalMemType {
    L0_A = 0,
    L0_B = 1,
    L0_C = 2,
    L1 = 3,
    L2 = 4,
    UB = 5,
    HBM = 6
} aclplatformLocalMemType;

#ifdef __cplusplus
}
#endif

#endif  // INC_PKG_PLATFORM_ACL_PLATFORM_H_
