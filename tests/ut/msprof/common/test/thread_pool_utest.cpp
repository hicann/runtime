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
#include <iostream>
#include "errno/error_code.h"
#include "thread/thread_pool.h"

using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::MsprofErrMgr;

class COMMON_THREAD_POOL_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

class TaskClass : public Task {
public:
    virtual int Execute() {
        std::cout << "Execute task" << std::endl;
        return 0;
    }
    virtual size_t HashId() {
        return 12;
    }
};

TEST_F(COMMON_THREAD_POOL_TEST, start) {
    GlobalMockObject::verify();

    std::shared_ptr<ThreadPool> pool(new ThreadPool());

    pool->threadNum_ = 0;
    EXPECT_EQ(PROFILING_FAILED, pool->Start());

    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Start)
    //    .stubs()
    //    .will(returnValue(PROFILING_FAILED))
    //    .then(returnValue(PROFILING_SUCCESS));
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_ERROR))
	    .then(returnValue(EN_OK));
		
    pool->threadNum_ = 2;
    EXPECT_EQ(PROFILING_SUCCESS, pool->Start());

    pool.reset();
}

TEST_F(COMMON_THREAD_POOL_TEST, stop) {
    GlobalMockObject::verify();

    std::shared_ptr<ThreadPool> pool(new ThreadPool());

    EXPECT_EQ(PROFILING_SUCCESS, pool->Stop());

    pool->Start();
    EXPECT_EQ(PROFILING_SUCCESS, pool->Stop());

    pool.reset();
}

TEST_F(COMMON_THREAD_POOL_TEST, InnnerThread_run) {
    GlobalMockObject::verify();

    std::shared_ptr<ThreadPool::InnnerThread> thread(new ThreadPool::InnnerThread(64));
    EXPECT_NE(nullptr, thread);

    MOCKER_CPP(&Thread::IsQuit)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    static const size_t s_queue_size = 64;
    thread->queue_ = std::make_shared<TaskQueue>(s_queue_size);

    thread->queue_->Quit();
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    thread->Run(errorContext);
    thread.reset();
}

TEST_F(COMMON_THREAD_POOL_TEST, Dispatch) {
    GlobalMockObject::verify();

    std::shared_ptr<ThreadPool> pool(new ThreadPool());
    std::shared_ptr<TaskClass> task(new TaskClass());

    EXPECT_EQ(PROFILING_FAILED, pool->Dispatch(task));

    pool->Start();
    EXPECT_EQ(PROFILING_SUCCESS, pool->Dispatch(task));

    pool->balancerMethod_ = LOAD_BALANCE_METHOD::ROUND_ROBIN;
    EXPECT_EQ(PROFILING_SUCCESS, pool->Dispatch(task));

    pool.reset();
}