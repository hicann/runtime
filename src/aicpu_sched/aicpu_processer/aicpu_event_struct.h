/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_EVENT_STRUCT_H
#define AICPU_EVENT_STRUCT_H


#include <cstdint>
#include "ascend_hal.h"

namespace aicpu {

struct HwtsCceKernel {
    uint64_t  kernelName;  // The cce op kernel  function name in kernel so which want to be called
    uint64_t  kernelSo;    // The so file which contains cce op kernel function
    uint64_t  paramBase;   // The param tranmit to cce op kernel
    uint64_t  l2VaddrBase; // The param tranmit to cce op kernel
    uint32_t  blockId;     // The param tranmit to cce op kernel
    uint32_t  blockNum;    // The param tranmit to cce op kernel
    uint32_t  l2Size;      // The page num used in l2 buffer
    uint32_t  l2InMain;    // The param tranmit to cce op kernel
};

struct HwtsFwkKernel {
    uint64_t kernel; // a pointer point to STR_FWK_OP_KERNEL
    uint32_t size;
};

struct HwtsTsKernel {
    uint32_t kernelType;
    union {
        HwtsCceKernel cceKernel;
        HwtsFwkKernel fwkKernel;
#ifndef CFG_SOC_PLATFORM_CLOUD
        struct hwts_ts_kernel hwtsKernel;
#endif
    } kernelBase;
};

enum KernelType {
    KERNEL_TYPE_CCE = 0,
    KERNEL_TYPE_FWK = 1,
    KERNEL_TYPE_AICPU = 2,
    KERNEL_TYPE_AICPU_CUSTOM = 4,
    KERNEL_TYPE_AICPU_KFC = 5,
    KERNEL_TYPE_AICPU_CUSTOM_KFC = 6,
    KERNEL_TYPE_HWTS = 10,
    KERNEL_TYPE_RESERVED
};

}  // namespace

#endif
