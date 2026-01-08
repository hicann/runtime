/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_ENGINE_STRUCT_H
#define AICPU_ENGINE_STRUCT_H

#include "fwk_adpt_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
    The different framwork we adapted for.
*/
typedef enum {
    FMK_KERNEL_TYPE_TF = 0,
    FMK_KERNEL_TYPE_CF = 10,
    FMK_KERNEL_TYPE_PT = 20,
    FMK_KERNEL_TYPE_RESERVED
} FwkkernelType_t;

#pragma pack(push, 1)
typedef struct {
    uint32_t fwkKernelType;  // FwkkernelType_t
    union {
        ::aicpu::FWKAdapter::FWKOperateParam fwk_kernel;
    } fwkKernelBase;
} STR_FWK_OP_KERNEL;
#pragma pack(pop)

#pragma pack(push, 1)
struct SessionInfo {
    uint64_t sessionId;
    uint64_t kernelId;
    bool sessFlag;
};
#pragma pack(pop)

#ifdef __cplusplus
}
#endif
#endif  // AICPU_ENGINE_STRUCT_H
