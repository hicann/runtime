/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_sharder.h"
#include <atomic>
#include <semaphore.h>
#include <unistd.h>
#include <error.h>
#include <cstring>
#include <algorithm>
#include <cerrno>

namespace aicpu {
SharderNonBlock::SharderNonBlock() : cpuCoreNum_(0U),
                                     randomKernelScheduler_(nullptr),
                                     splitKernelScheduler_(nullptr),
                                     splitKernelGetProcesser_(nullptr),
                                     parallelId_(0U)
{
}

void SharderNonBlock::Register(const uint32_t cpuCoreNum, const RandomKernelScheduler &randomKernelScheduler,
                               const SplitKernelScheduler &splitKernelScheduler,
                               const SplitKernelGetProcesser &splitKernelGetProcesser)
{
    (void)cpuCoreNum;
    (void)randomKernelScheduler;
    (void)splitKernelScheduler;
    (void)splitKernelGetProcesser;
}

SharderNonBlock &SharderNonBlock::GetInstance()
{
    static SharderNonBlock sharderNonBlock;
    return sharderNonBlock;
}
}
