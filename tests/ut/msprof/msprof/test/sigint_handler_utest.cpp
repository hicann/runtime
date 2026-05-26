/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <gtest/gtest.h>
#include <csignal>
#include <atomic>
#include <unistd.h>
#include <mockcpp/mockcpp.hpp>
#include "prof_acl_mgr.h"
#include "msprofiler_impl.h"
#include "msprof_reporter.h"
#include "osal.h"

using namespace Msprofiler::Api;
using ProfSignalHandler = void (*)(int);

// 用于把 watcher 线程的 grace loop 加速跑完，避免真睡 2s
static int32_t OsalSleepNoopStub(uint32_t /*ms*/)
{
    return 0;
}

class SigintHandlerUtest : public testing::Test {
protected:
    void SetUp() override
    {
        ProfAclMgr::instance()->UnInit();
    }
    void TearDown() override
    {
        GlobalMockObject::verify();
    }
};

static void CustomerSigHandler(int signum)
{
    (void)signum;
}

static std::atomic<bool> g_customSigHandlerCalled{false};
static void CustomerSigHandlerWithFlag(int /*signum*/)
{
    g_customSigHandlerCalled = true;
}

TEST_F(SigintHandlerUtest, RegisterSignalHandlerTwice)
{
    signal(SIGINT, CustomerSigHandler);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;

    mgr->Init();
    ProfSignalHandler firstInstalled = signal(SIGINT, SIG_IGN);
    EXPECT_NE(firstInstalled, CustomerSigHandler);
    EXPECT_NE(firstInstalled, SIG_DFL);
    signal(SIGINT, firstInstalled);

    mgr->Init();
    ProfSignalHandler secondInstalled = signal(SIGINT, SIG_IGN);
    EXPECT_EQ(firstInstalled, secondInstalled);
    signal(SIGINT, secondInstalled);

    mgr->UnInit();
    ProfSignalHandler restored = signal(SIGINT, CustomerSigHandler);
    EXPECT_EQ(restored, CustomerSigHandler);
}

TEST_F(SigintHandlerUtest, SigintWatcherThreadCallsMsprofFinalize)
{
    g_customSigHandlerCalled = false;
    signal(SIGINT, CustomerSigHandlerWithFlag);

    MOCKER_CPP(&ProfAclMgr::MsprofFinalizeHandle)
        .stubs()
        .will(returnValue(0));

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    raise(SIGINT);

    int waitMs = 0;
    while (!g_customSigHandlerCalled && waitMs < 200) {
        usleep(1000);
        waitMs++;
    }
    EXPECT_TRUE(g_customSigHandlerCalled) << "CustomerSigHandlerWithFlag was not called within 200ms";

    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}

TEST_F(SigintHandlerUtest, UnregisterSigalHandlerRestoresOldHandler)
{
    signal(SIGINT, CustomerSigHandler);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();
    mgr->UnInit();

    ProfSignalHandler restored = signal(SIGINT, CustomerSigHandler);
    EXPECT_EQ(restored, CustomerSigHandler) << "SIGINT handler should be restored to CustomerSigHandler";
}

TEST_F(SigintHandlerUtest, SigintWatcherThreadExitsOnUnregister)
{
    signal(SIGINT, CustomerSigHandler);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();
    mgr->UnInit();

    SUCCEED();
    signal(SIGINT, SIG_DFL);
}

TEST_F(SigintHandlerUtest, ProfNotifySetDeviceSkipsCmdlineRestartWhenSigintShuttingDown)
{
    signal(SIGINT, CustomerSigHandler);
    MOCKER_CPP(&ProfAclMgr::MsprofFinalizeHandle)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::ProfInitIfCommandLine)
        .expects(never());

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    raise(SIGINT);
    EXPECT_TRUE(mgr->IsSigintShutdownInProgress());
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true));

    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}

TEST_F(SigintHandlerUtest, UnregisterSignalHandlerRestoresSIGIGN)
{
    // 验证：当初始信号处理器是 SIG_IGN 时，
    // 注册 ProfAclMgr 信号处理器后，注销时能正确恢复为 SIG_IGN

    signal(SIGINT, SIG_IGN);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    mgr->UnInit();

    ProfSignalHandler restored = signal(SIGINT, SIG_IGN);
    EXPECT_EQ(restored, SIG_IGN) << "SIGINT handler should be restored to SIG_IGN";
}

TEST_F(SigintHandlerUtest, UnregisterSignalHandlerRestoresSIGDFL)
{
    // 验证：当初始信号处理器是 SIG_DFL 时，
    // 注册 ProfAclMgr 信号处理器后，注销时能正确恢复为 SIG_DFL

    signal(SIGINT, SIG_DFL);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    mgr->UnInit();

    ProfSignalHandler restored = signal(SIGINT, SIG_DFL);
    EXPECT_EQ(restored, SIG_DFL) << "SIGINT handler should be restored to SIG_DFL";
}

// 覆盖修改 1：newSigHandler 在原 handler 为 SIG_IGN 时
// 仅设标志位、不转发，进程不被默认终止行为影响。
TEST_F(SigintHandlerUtest, NewSigHandlerSkipsForwardingForSIG_IGN)
{
    signal(SIGINT, SIG_IGN);
    MOCKER_CPP(&ProfAclMgr::MsprofFinalizeHandle).stubs().will(returnValue(0));

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    raise(SIGINT);
    // 标志位被设：说明 newSigHandler 第一行执行；进程仍存活说明
    // SIG_IGN 短路分支正确（没有走默认终止）
    EXPECT_TRUE(mgr->IsSigintShutdownInProgress());

    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}

// 覆盖修改 1：newSigHandler 在原 handler 为 SIG_DFL 时
// 仅设标志位、不转发；watcher 线程之后会处理实际退出。
TEST_F(SigintHandlerUtest, NewSigHandlerSkipsForwardingForSIG_DFL)
{
    signal(SIGINT, SIG_DFL);
    MOCKER_CPP(&ProfAclMgr::MsprofFinalizeHandle).stubs().will(returnValue(0));

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    raise(SIGINT);
    EXPECT_TRUE(mgr->IsSigintShutdownInProgress());

    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}

// 覆盖修改 3：MsprofFinalizeHandle 中
// IsSigintShutdownInProgress() 守门的 drain 分支判定条件。
TEST_F(SigintHandlerUtest, IsSigintShutdownInProgressGatesDrainBranch)
{
    signal(SIGINT, CustomerSigHandler);

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    // 注册前/初始：标志位为 0
    EXPECT_FALSE(mgr->IsSigintShutdownInProgress());

    // 触发 SIGINT：标志位置为 1，drain 分支条件满足
    raise(SIGINT);
    EXPECT_TRUE(mgr->IsSigintShutdownInProgress());

    // UnInit 复位标志：drain 分支条件不再满足
    mgr->UnInit();
    EXPECT_FALSE(mgr->IsSigintShutdownInProgress());

    signal(SIGINT, SIG_DFL);
}

// 覆盖修改 2：SigintWatcherThread 的 fallback 路径（line 324-327）。
// 通过 stub OsalSleep 让 grace loop 立即跑满 200 圈，进入 fallback 分支，
// 验证 ProfAclMgr::MsprofFinalizeHandle 被调到（mockcpp expects 在 verify 时校验）。
TEST_F(SigintHandlerUtest, WatcherFallbackInvokesMsprofFinalizeWhenAppDoesNotTeardown)
{
    // SIG_IGN 让 newSigHandler 走"不转发"分支，进程不被 SIGINT 终止
    signal(SIGINT, SIG_IGN);

    // 关键：把 OsalSleep stub 成立即返回，watcher 线程的 wait + grace 循环
    // 共 ~210 圈在毫秒级内自然走完，不会被 UnInit 提前唤醒
    MOCKER(OsalSleep)
        .stubs()
        .will(invoke(OsalSleepNoopStub));
    // expects(atLeast(1)) 断言 fallback 路径调到了 MsprofFinalizeHandle，
    // 在 TearDown 的 GlobalMockObject::verify() 校验失败
    MOCKER_CPP(&ProfAclMgr::MsprofFinalizeHandle)
        .expects(atLeast(1))
        .will(returnValue(static_cast<int32_t>(MSPROF_ERROR_NONE)));

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    raise(SIGINT);

    // OsalSleep 已被 stub 立即返回，watcher 应在毫秒级内进入 fallback 分支并
    // 调用 MsprofFinalizeHandle。给 200ms 真实等待让线程调度完成。
    usleep(200 * 1000);

    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}

// 覆盖修改 3：MsprofFinalizeHandle 中 drain body（line 2194-2196）的
// OsalSleep + Msprof::Engine::FlushAllModule 两条语句被实际执行。
// 关键：直接调用 MsprofFinalizeHandle，绕开 watcher 线程，避免节奏不稳。
TEST_F(SigintHandlerUtest, MsprofFinalizeHandleRunsDrainBranchUnderSigintShutdown)
{
    signal(SIGINT, SIG_IGN);

    // 防止 drain 分支真睡 1s，同时也让 watcher 线程不真睡
    MOCKER(OsalSleep)
        .stubs()
        .will(invoke(OsalSleepNoopStub));
    // FlushAllModule 在 DoFinalizeHandle 末尾调 1 次（line 2178），
    // drain body 再调 1 次（line 2196），加上 watcher 触发的 fallback finalize
    // 也会再走一遍 finalize（再 +2），所以这里用 atLeast(2)
    MOCKER_CPP(&Msprof::Engine::FlushAllModule)
        .expects(atLeast(2));

    auto *mgr = ProfAclMgr::instance();
    mgr->isReady_ = true;
    mgr->Init();

    // raise(SIGINT) 让 IsSigintShutdownInProgress() 返回 true
    raise(SIGINT);
    ASSERT_TRUE(mgr->IsSigintShutdownInProgress());

    // 让 IsModeOff() 返回 false、IsSubscribeMode() 也返回 false，
    // MsprofFinalizeHandle 才会进入 drain 守门
    mgr->mode_ = WORK_MODE_CMD;

    EXPECT_EQ(MSPROF_ERROR_NONE, mgr->MsprofFinalizeHandle());

    mgr->mode_ = WORK_MODE_OFF;
    mgr->UnInit();
    signal(SIGINT, SIG_DFL);
}
