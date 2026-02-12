/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <semaphore.h>
#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <exception>
#include <string>
#define private public
#include "aicpu_sharder.h"
#undef private

using namespace aicpu;

namespace {
const uint32_t dataLen_ = 4U;
const uint32_t defaultFillData_ = 3U;
uint32_t data_[dataLen_] = {};
const uint32_t coreNum_ = 2U;
std::queue<aicpu::Closure> taskQueue_;

const RandomKernelScheduler randomKernelScheduler = [] (const aicpu::Closure &task)
{
    task();
    return 0U;
};

const SplitKernelScheduler splitKernelScheduler = [] (const uint32_t parallelId,
                                                                 const int64_t shardNum,
                                                                 const std::queue<Closure> &queue)
{
    taskQueue_ = queue;
    return 0U;
};

const SplitKernelGetProcesser splitKernelGetProcesser = [] ()
{
    const auto work = taskQueue_.front();
    taskQueue_.pop();
    work();
    return true;
};
}

class AiCPUSharderUt : public ::testing::Test {
public:
    virtual void SetUp()
    {
        GlobalMockObject::verify();
        while (!taskQueue_.empty()) {
            taskQueue_.pop();
        }
        memset((void*)(&data_), 0, sizeof(uint32_t)*dataLen_);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AiCPUSharderUt, GetCPUNumSuccess)
{
    SharderNonBlock::GetInstance().Register(coreNum_, nullptr, nullptr, nullptr);
    EXPECT_EQ(GetCPUNum(), coreNum_);
}

TEST_F(AiCPUSharderUt, ParallelForSuccess)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        for (int64_t i = start; i < end; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    ParallelFor(dataLen_, 1, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForShardNum1)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        for (int64_t i = start; i < end; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    ParallelFor(dataLen_, dataLen_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForTaskException)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        throw std::runtime_error("runtime error");
    };
    ParallelFor(dataLen_, 1, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], 0);
    }
}

TEST_F(AiCPUSharderUt, ParallelForSplitSchedulerFail)
{
    const SplitKernelScheduler splitKernelScheduler = [] (const uint32_t parallelId,
                                                                 const int64_t shardNum,
                                                                 const std::queue<Closure> &queue)
    {
        return 1U;
    };
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        throw std::runtime_error("runtime error");
    };
    ParallelFor(dataLen_, 1, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], 0);
    }
}

TEST_F(AiCPUSharderUt, ParallelForSemWaitFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        for (int64_t i = start; i < end; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    ParallelFor(dataLen_, 1, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForSemDestroyFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        for (int64_t i = start; i < end; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_destroy).stubs().will(returnValue(-1));
    ParallelFor(dataLen_, 1, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForGetTaskThousands)
{
    uint32_t count = 0U;
    const auto splitKernelGetProcesserThousands = [&count] ()
    {
        if (count <= 1001) {
            ++count;
            return true;
        }

        const auto work = taskQueue_.front();
        taskQueue_.pop();
        work();
        return true;
    };

    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesserThousands);
    const auto worker = [this] (int64_t start, int64_t end) {
        for (int64_t i = start; i < end; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    ParallelFor(dataLen_, 2, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ScheduleSuccess)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] () {
        for (int64_t i = 0; i < dataLen_; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    SharderNonBlock::GetInstance().Schedule(worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ScheduleNullptrSuccess)
{
    SharderNonBlock::GetInstance().Register(coreNum_, nullptr, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] () {
        for (int64_t i = 0; i < dataLen_; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    SharderNonBlock::GetInstance().Schedule(worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ScheduleFail)
{
    const RandomKernelScheduler randomKernelSchedulerFail = [] (const aicpu::Closure &task)
    {
        return 1U;
    };

    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelSchedulerFail, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] () {
        for (int64_t i = 0; i < dataLen_; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    SharderNonBlock::GetInstance().Schedule(worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSuccess)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSemInitFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_init).stubs().will(returnValue(-1));
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], 0);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSemWaitFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSemDestroyFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_destroy).stubs().will(returnValue(-1));
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSemPostFail)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    MOCKER(sem_post).stubs().will(returnValue(-1));
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], defaultFillData_);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashNullptr)
{
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, nullptr,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t total, int64_t cur) {
        for (int64_t i = cur; i < total; ++i) {
            data_[i] = defaultFillData_;
        }
    };
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], 0);
    }
}

TEST_F(AiCPUSharderUt, ParallelForHashSplitSchedulerFail)
{
    const SplitKernelScheduler splitKernelScheduler = [] (const uint32_t parallelId,
                                                                     const int64_t shardNum,
                                                                     const std::queue<Closure> &queue)
    {
        return 1U;
    };
    SharderNonBlock::GetInstance().Register(coreNum_, randomKernelScheduler, splitKernelScheduler,
                                            splitKernelGetProcesser);
    const auto worker = [this] (int64_t start, int64_t end) {
        throw std::runtime_error("runtime error");
    };
    SharderNonBlock::GetInstance().ParallelForHash(dataLen_, coreNum_, worker);
    for (uint32_t i = 0U; i < dataLen_; ++i) {
        EXPECT_EQ(data_[i], 0);
    }
}
