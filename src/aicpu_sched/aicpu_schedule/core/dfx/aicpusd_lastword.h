/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CORE_AICPUSD_LASTWORD_H
#define CORE_AICPUSD_LASTWORD_H
#include <map>
#include <atomic>
#include <mutex>
#include <functional>
#include <string>
#include <memory>
#include <thread>
namespace AicpuSchedule {
class AicpusdLastword {
public:
    static AicpusdLastword &GetInstance()
    {
        static AicpusdLastword instance;
        return instance;
    }
    void RegLastwordCallback(const std::string mark, std::function<void ()> callback,
        std::function<void ()> &cancelReg);
    void LastwordCallback();

private:
    std::mutex lastwordMux_;
    uint64_t lastwordKey_ = 0;
    std::map<uint64_t, std::pair<std::string, std::function<void()>>> lastwords_;
};
}
#endif // CORE_AICPUSD_LASTWORD_H