/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_KERNEL_LIB_BASE_H_
#define __AE_KERNEL_LIB_BASE_H_

#include <vector>
#include <string>
#include <mutex>
#include "aicpu_engine.h"
#include "aicpu_event_struct.h"
#include "ae_so_manager.hpp"

namespace cce {
    // max kernel name len
    constexpr uint32_t AE_MAX_KERNEL_NAME = 200U;
    // max so name len
    constexpr uint32_t AE_MAX_SO_NAME = 100U;

/*
* Abstract Class
* To define All AI Kernel lib Abstract interface
*/
class AIKernelsLibBase {
public:
    AIKernelsLibBase() = default;
    virtual ~AIKernelsLibBase() = default;
    virtual aeStatus_t Init();
    virtual int32_t CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase) = 0;
    virtual aeStatus_t CloseSo(const char_t * const soName) = 0;
    virtual aeStatus_t BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                         std::vector<std::string> &soVec) = 0;

protected:
    cce::MultiSoManager soMngr_;            // So manager to manage all cce so in process.
    aicpu::AicpuRunMode runMode_;            // aicpu run mode
};
}
#endif