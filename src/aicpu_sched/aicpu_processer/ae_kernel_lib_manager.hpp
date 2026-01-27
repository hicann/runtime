/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_KERNEL_LIB_MANAGER_H_
#define __AE_KERNEL_LIB_MANAGER_H_

#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "ae_kernel_lib_base.hpp"
#include "aicpu_event_struct.h"

namespace cce {

/*
    The manager all kernel lib in process, provide a unify interface to get a AIKernelLIb
*/
class AIKernelsLibManger {
public:
    ~AIKernelsLibManger() = default;
    // Get a special AIKernelLIb
    static aeStatus_t GetKernelLib(const aicpu::KernelType kernelType, AIKernelsLibBase *&kernelLib);
    static void ClearKernelLib(const aicpu::KernelType kernelType); //Clear a special AIKernelLIb in manager.
    static aeStatus_t BatchLoadKernelSo(const aicpu::KernelType kernelType, const uint32_t loadSoNum, const char_t * const * const soNames
);
    static aeStatus_t AddSoInWhiteList(const char_t * const soName);
    static void DelteSoInWhiteList(const char_t * const soName);

private:
    AIKernelsLibManger() = default;
};

}
#endif
