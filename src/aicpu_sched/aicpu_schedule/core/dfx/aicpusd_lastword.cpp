/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <new>
#include <mutex>
#include <string>
#include <unistd.h>
#include "aicpusd_lastword.h"
#include "aicpusd_status.h"

namespace AicpuSchedule {
void AicpusdLastword::RegLastwordCallback(const std::string mark,
    std::function<void ()> callback, std::function<void ()> &cancelReg)
{
    if (callback == nullptr) {
        aicpusd_run_info("Reg lastword mark[%s], callback is null.", mark.c_str());
        return;
    }

    uint64_t lastwordKey;
    {
        std::lock_guard<std::mutex> lk(lastwordMux_);
        lastwordKey = lastwordKey_;
        lastwords_.emplace(lastwordKey, std::make_pair(mark, callback));
        lastwordKey_++;
    }

    cancelReg = [lastwordKey, mark, this]() {
        std::lock_guard<std::mutex> lk(lastwordMux_);
        lastwords_.erase(lastwordKey);
    };
}

void AicpusdLastword::LastwordCallback()
{
    std::lock_guard<std::mutex> lk(lastwordMux_);
    aicpusd_run_info("Call lastword callback, count[%u].", lastwords_.size());
    for (auto it : lastwords_) {
        aicpusd_run_info("callback[%u][%s].", it.first, it.second.first.c_str());
        it.second.second();
    }
}
}

__attribute__ ((constructor)) static void InitLastwordInstance()
{
    AicpuSchedule::AicpusdLastword::GetInstance();
}