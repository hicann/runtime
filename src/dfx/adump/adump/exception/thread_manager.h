/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DUMP_THREAD_MANAGER_H
#define DUMP_THREAD_MANAGER_H
#include <set>
#include <mutex>
#include <condition_variable>
#include "common/singleton.h"

namespace Adx{
class ThreadManager: public Adx::Common::Singleton::Singleton<ThreadManager> {
public:
    ThreadManager(){};
    ~ThreadManager() override;
    void TaskAdd(int32_t tid);
    void TaskDone(int32_t tid);
    void WaitAll();
private:
    std::mutex mtx_;
    std::set<int32_t> threads_;
    std::condition_variable cv_;
};
}
#endif