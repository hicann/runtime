/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_operator.h"

extern "C" {
__gm__ uint32_t g_binary_metadata_value[1];
}

extern "C" __global__ __vector__ void binary_introspection_kernel(GM_ADDR input, GM_ADDR output, uint32_t elementCount)
{
    if ((AscendC::GetBlockIdx() == 0U) && (elementCount > 0U)) {
        auto* inputData = reinterpret_cast<__gm__ uint32_t*>(input);
        auto* outputData = reinterpret_cast<__gm__ uint32_t*>(output);
        outputData[0] = inputData[0] + g_binary_metadata_value[0];
    }
}
