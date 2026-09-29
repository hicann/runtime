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
#include <atomic>
#include <mutex>
#include <thread>
#include <vector>
#include "command_handle.h"
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "aprof_pub.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::ProfilerCommon;

/* host-side only: these cases exercise an api that the ascend031 build excludes */
#ifndef ascend031
namespace {
std::atomic<int32_t> g_commandHandleACount{0};
std::atomic<int32_t> g_commandHandleBCount{0};

int32_t StubCommandHandleA(uint32_t type, void* data, uint32_t len)
{
    g_commandHandleACount++;
    return 0;
}

int32_t StubCommandHandleB(uint32_t type, void* data, uint32_t len)
{
    g_commandHandleBCount++;
    return 0;
}
} // namespace

class COMMAND_HANDLE_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        g_commandHandleACount = 0;
        g_commandHandleBCount = 0;
    }
};

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterRemovesOnlyMatchingCallback)
{
    ASSERT_EQ(ACL_SUCCESS, ProfRegisterCallback(GE, StubCommandHandleA));
    ASSERT_EQ(ACL_SUCCESS, ProfRegisterCallback(GE, StubCommandHandleB));

    // remove one of two registered handles: the other one stays
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));
    {
        auto& mgr = ProfModuleReprotMgr::GetInstance();
        std::unique_lock<std::mutex> lock(mgr.regCallback_);
        auto it = mgr.moduleCallbacks_.find(GE);
        ASSERT_NE(mgr.moduleCallbacks_.cend(), it);
        EXPECT_EQ(1U, it->second.size());
        EXPECT_EQ(1U, it->second.count(StubCommandHandleB));
    }

    // remove the last one: the module entry is erased as well
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleB));
    {
        auto& mgr = ProfModuleReprotMgr::GetInstance();
        std::unique_lock<std::mutex> lock(mgr.regCallback_);
        EXPECT_EQ(mgr.moduleCallbacks_.cend(), mgr.moduleCallbacks_.find(GE));
    }
}

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterNotRegisteredReturnsSuccess)
{
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));
}

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterSameHandleTwiceIsIdempotent)
{
    ASSERT_EQ(ACL_SUCCESS, ProfRegisterCallback(GE, StubCommandHandleA));
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));
    // unregistering the same handle again stays success and keeps the table clean
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));
    {
        auto& mgr = ProfModuleReprotMgr::GetInstance();
        std::unique_lock<std::mutex> lock(mgr.regCallback_);
        EXPECT_EQ(mgr.moduleCallbacks_.cend(), mgr.moduleCallbacks_.find(GE));
    }
}

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterInvalidHandle)
{
    EXPECT_EQ(PROFILING_FAILED, ProfUnRegisterCallback(GE, nullptr));
}

TEST_F(COMMAND_HANDLE_UTEST, AdaptorAicpuUnRegisterNotSupported)
{
    // the host side cannot reach the adprof device-side registry: explicit failure, not silent success
    EXPECT_EQ(PROFILING_FAILED, MsprofUnRegisterCallback(AICPU, StubCommandHandleA));
    // the nullptr check runs before the module branch, so AICPU never bypasses it
    EXPECT_EQ(PROFILING_FAILED, MsprofUnRegisterCallback(AICPU, nullptr));
}

TEST_F(COMMAND_HANDLE_UTEST, AdaptorHostUnRegister)
{
    ASSERT_EQ(ACL_SUCCESS, MsprofRegisterCallback(GE, StubCommandHandleA));
    EXPECT_EQ(ACL_SUCCESS, MsprofUnRegisterCallback(GE, StubCommandHandleA));
    {
        auto& mgr = ProfModuleReprotMgr::GetInstance();
        std::unique_lock<std::mutex> lock(mgr.regCallback_);
        EXPECT_EQ(mgr.moduleCallbacks_.cend(), mgr.moduleCallbacks_.find(GE));
    }
}

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterStopsCallbackOnLaterCommand)
{
    ASSERT_EQ(ACL_SUCCESS, ProfRegisterCallback(GE, StubCommandHandleA));
    ASSERT_EQ(ACL_SUCCESS, ProfRegisterCallback(GE, StubCommandHandleB));
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));

    // a later command only fires the remaining callback
    ProfCommand command = {};
    command.type = PROF_COMMANDHANDLE_TYPE_INIT;
    EXPECT_EQ(ACL_SUCCESS, ProfSetProfCommand(command));
    EXPECT_EQ(0, g_commandHandleACount);
    EXPECT_EQ(1, g_commandHandleBCount);

    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleB));
}

TEST_F(COMMAND_HANDLE_UTEST, UnRegisterConcurrentWithRegisterAndDispatch)
{
    // interleave register/unregister with command dispatch from several threads; the registry must stay
    // consistent and the calls must not crash (in-flight snapshots may still fire the callback)
    constexpr int32_t threadNum = 4;
    constexpr int32_t loops = 50;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([]() {
            for (int32_t j = 0; j < loops; j++) {
                (void)ProfRegisterCallback(GE, StubCommandHandleA);
                ProfCommand command = {};
                command.type = PROF_COMMANDHANDLE_TYPE_INIT;
                (void)ProfSetProfCommand(command);
                (void)ProfUnRegisterCallback(GE, StubCommandHandleA);
            }
        });
    }
    for (auto& thread : threads) {
        thread.join();
    }
    EXPECT_EQ(ACL_SUCCESS, ProfUnRegisterCallback(GE, StubCommandHandleA));
    {
        auto& mgr = ProfModuleReprotMgr::GetInstance();
        std::unique_lock<std::mutex> lock(mgr.regCallback_);
        EXPECT_EQ(mgr.moduleCallbacks_.cend(), mgr.moduleCallbacks_.find(GE));
    }
}
#endif // ascend031
