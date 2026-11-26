/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// server_mgr ownership-model cases kept in a dedicated translation unit: the reference-count
// scenarios need real session monitor threads, and adding them to the shared testcase file
// shifts the linked layout, which breaks the mockcpp ApiHook patches of the other cases.
#include <thread>
#include <unistd.h>

#include <chrono>
#include <future>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "adcore_api.h"
#include "ascend_hal.h"
#include "log_common.h"
#include "server_mgr.h"

extern ServerMgr g_serverMgr[NR_COMPONENTS];
extern "C" {
// ServerProcess is internal to log_daemon (STATIC, expanded empty in UT builds)
extern int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len);
}

namespace {
bool g_utSessionValid = true;
int32_t g_utDestroyCount = 0;
bool g_utRecvEntered = false;
bool g_utStopEntered = false;
OptHandle g_utInvalidSession = 0;

int32_t UtSessionAttrStateful(AdxCommConHandle handle, int32_t attr, int32_t* value)
{
    (void)handle;
    if (attr == (int32_t)HDC_SESSION_ATTR_RUN_ENV) {
        *value = RUN_ENV_PHYSICAL;
        return 0;
    }
    *value = g_utSessionValid ? 1 : (int32_t)HDC_SESSION_STATUS_CLOSE; // 1: connect status
    return 0;
}

// validity keyed by the session pointer: only the marked session breaks, concurrent
// sessions of a multi-slot component stay alive
int32_t UtSessionAttrPerSession(AdxCommConHandle handle, int32_t attr, int32_t* value)
{
    if (attr == (int32_t)HDC_SESSION_ATTR_RUN_ENV) {
        *value = RUN_ENV_PHYSICAL;
        return 0;
    }
    *value = (handle->session == g_utInvalidSession) ? (int32_t)HDC_SESSION_STATUS_CLOSE : 1;
    return 0;
}

// parks the FIRST LogFree call after arming: that is the session monitor's thread-entry
// ctx release, which sits right before the node acquire. Parking there simulates a thread
// that has not run its first instruction yet while a new session gets published
int32_t g_utLogFreeParkArmed = 0;
bool g_utLogFreeRelease = false;

void UtParkingLogFree(void* buffer)
{
    if (g_utLogFreeParkArmed != 0) {
        g_utLogFreeParkArmed = 0; // park exactly once, the monitor entry ctx
        for (int32_t i = 0; (i < 10000) && !g_utLogFreeRelease; i++) {
            usleep(1000);         // 10s cap, the test releases the park well before
        }
    }
    free(buffer);
}

void UtCountDestroy(AdxCommHandle handle)
{
    (void)handle;
    g_utDestroyCount++;
}

int32_t UtBlockingRecv(AdxCommHandle handle, char** data, uint32_t* len, uint32_t timeout)
{
    (void)handle;
    (void)data;
    (void)len;
    (void)timeout;
    g_utRecvEntered = true;
    usleep(300 * 1000); // hold the reference while the session monitor exits
    return 0;
}

int32_t TestServerStartNoop(ServerHandle handle)
{
    (void)handle;
    return 0;
}

void TestServerStopNoop(void) {}

// parks the session monitor inside its exit tail (stop runs after the stateLock section),
// so the next ServerProcess joins a thread that is alive but already detached
void UtParkedStop(void)
{
    g_utStopEntered = true;
    usleep(500 * 1000);
}
} // namespace

// covers the lib_load upgrade pattern: ServerRelease runs while an in-flight request still
// holds a reference (release first, drain afterwards). The dying node must survive the
// ServerMgrNodeReset inside ServerRelease, so the last releaser destroys the comm handle.
TEST(ServerMgrDyingListUtest, DyingHandleSurvivesReleaseAndIsDestroyedByLastReleaser)
{
    g_utSessionValid = true;
    g_utDestroyCount = 0;
    g_utRecvEntered = false;
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, TestServerStopNoop, &attr));

    // register before any mock is active (mockcpp ApiHooks are layout sensitive), the
    // AdxGetAttrByCommHandle mock is installed afterwards for the monitor session checks
    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(UtSessionAttrStateful));
    MOCKER(AdxRecvMsg).stubs().will(invoke(UtBlockingRecv));
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(UtCountDestroy));

    CommHandle handle;
    handle.type = (OptType)COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.timeout = 0;
    handle.client = nullptr;
    handle.comp = COMPONENT_GETD_FILE;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0)); // real session monitor thread runs

    std::thread recvThread([] {
        char* msg = nullptr;
        uint32_t len = 0;
        (void)ServerRecvMsg(&g_serverMgr[ComponentType::COMPONENT_GETD_FILE], &msg, &len, 1000);
    });
    bool recvEntered = false;
    for (int32_t i = 0; (i < 3000) && !recvEntered; i++) {
        recvEntered = g_utRecvEntered;
        if (!recvEntered) {
            usleep(1000); // wait until the in-flight reference is really held (3s cap)
        }
    }
    g_utSessionValid = false;                          // the monitor exits on its next poll

    ServerRelease(ComponentType::COMPONENT_GETD_FILE); // release first (lib_load upgrade order)
    EXPECT_TRUE(recvEntered);
    // the pending node survives the reset with exactly the in-flight reference: the recv
    // reference is counted on its own node and waits for its own last releaser
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current);
    ASSERT_NE(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].commList);
    EXPECT_EQ(1U, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].commList->refs);

    recvThread.join(); // drain: the last releaser destroys the detached handle
    EXPECT_EQ(1, g_utDestroyCount);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].commList);

    GlobalMockObject::reset();
}

// after a full release the manager must be reusable: no link slot residue, no dangling
// handle, no pending dying node, and a new session of the same component is accepted again
TEST(ServerMgrDyingListUtest, ReleaseLeavesNoSlotOrHandleResidue)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, TestServerStopNoop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(UtSessionAttrStateful));
    g_utSessionValid = true;

    CommHandle handle;
    handle.type = (OptType)COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.timeout = 0;
    handle.client = nullptr;
    handle.comp = COMPONENT_GETD_FILE;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0)); // real monitor thread runs

    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].linkedNum);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].commList);

    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, TestServerStopNoop, &attr));
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0)); // slot accounting intact, session accepted
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);

    GlobalMockObject::reset();
}

// concurrent session turnover (the scenario the review flagged for the join-under-lock
// deadlock): the old monitor is parked alive in its exit tail while a new connection runs
// ServerProcess, whose SessionMonitorCreate joins that old thread. With the stateLock split
// the new connection must complete within the timeout and the old thread must exit cleanly.
TEST(ServerMgrDyingListUtest, NewSessionCompletesWhileOldMonitorIsInExitTail)
{
    g_utSessionValid = true;
    g_utStopEntered = false;
    ServerAttr attr = {0};
    attr.num = 2; // multiple slots: the turnover path stays reachable while the old slot exists
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, UtParkedStop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(UtSessionAttrStateful));

    CommHandle handleA;
    handleA.type = (OptType)COMM_HDC;
    handleA.session = (OptHandle)0x11111;
    handleA.timeout = 0;
    handleA.client = nullptr;
    handleA.comp = COMPONENT_GETD_FILE;
    EXPECT_EQ(0, ServerProcess(&handleA, nullptr, 0)); // first session, real monitor thread

    g_utSessionValid = false;                          // the old monitor exits on its next poll and parks in stop()
    bool stopEntered = false;
    for (int32_t i = 0; (i < 3000) && !stopEntered; i++) {
        stopEntered = g_utStopEntered;
        if (!stopEntered) {
            usleep(1000); // 3s cap
        }
    }
    ASSERT_TRUE(stopEntered);

    // the old monitor is alive in its exit tail: this call joins it inside SessionMonitorCreate.
    // std::thread + completion flag on purpose: a std::async future destructor would block
    // on the unfinished task after an ASSERT failure, turning a deadlock regression into a
    // full test-binary hang instead of a clean failure
    CommHandle handleB;
    handleB.type = (OptType)COMM_HDC;
    handleB.session = (OptHandle)0x22222;
    handleB.timeout = 0;
    handleB.client = nullptr;
    handleB.comp = COMPONENT_GETD_FILE;
    int32_t turnRet = -1;
    bool turnDone = false;
    std::thread turnThread([&] {
        turnRet = ServerProcess(&handleB, nullptr, 0);
        turnDone = true;
    });
    bool finished = false;
    for (int32_t i = 0; (i < 5000) && !finished; i++) {
        finished = turnDone;
        if (!finished) {
            usleep(1000); // 5s deadline for the turnover to complete
        }
    }
    if (!finished) {
        ADD_FAILURE() << "ServerProcess did not complete while the old monitor was in its exit tail";
        turnThread.detach(); // never join a deadlocked task: keep the failure observable
        return;
    }
    turnThread.join();
    EXPECT_EQ(0, turnRet);

    ServerRelease(ComponentType::COMPONENT_GETD_FILE); // joins the new monitor, no residue
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].linkedNum);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].commList);

    GlobalMockObject::reset();
}

// cross-generation reference isolation (the scenario the review flagged for the shared
// counter): session B is published (its ServerProcess parks inside the join of monitor A)
// and an in-flight request acquires B while monitor A is still running. A's exit must not
// count B's reference on A's node: A is destroyed by its own monitor, B's node keeps only
// its own holders. With a shared counter A's node would absorb B's reference, never reach
// zero and leak, and later generations would under-count into a premature destroy.
TEST(ServerMgrDyingListUtest, CrossGenerationReferencesAreCountedPerSession)
{
    g_utInvalidSession = 0;
    g_utRecvEntered = false;
    ServerAttr attr = {0};
    attr.num = 2; // two slots: B is published while A still occupies its slot
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, TestServerStopNoop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(UtSessionAttrPerSession));
    MOCKER(AdxRecvMsg).stubs().will(invoke(UtBlockingRecv));

    CommHandle handleA;
    handleA.type = (OptType)COMM_HDC;
    handleA.session = (OptHandle)0x11111;
    handleA.timeout = 0;
    handleA.client = nullptr;
    handleA.comp = COMPONENT_GETD_FILE;
    EXPECT_EQ(0, ServerProcess(&handleA, nullptr, 0)); // session A, monitor A runs

    // session B is published first, its ServerProcess then parks inside the join of A
    CommHandle handleB;
    handleB.type = (OptType)COMM_HDC;
    handleB.session = (OptHandle)0x22222;
    handleB.timeout = 0;
    handleB.client = nullptr;
    handleB.comp = COMPONENT_GETD_FILE;
    int32_t turnRet = -1;
    bool turnDone = false;
    std::thread turnThread([&] {
        turnRet = ServerProcess(&handleB, nullptr, 0);
        turnDone = true;
    });
    bool published = false;
    for (int32_t i = 0; (i < 3000) && !published; i++) {
        published = (g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current != nullptr) &&
                    (g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current->comm->session == (OptHandle)0x22222);
        if (!published) {
            usleep(1000); // 3s cap until B is published
        }
    }
    ASSERT_TRUE(published);

    // an in-flight request acquires the newly published B while monitor A is still running
    std::thread recvThread([] {
        char* msg = nullptr;
        uint32_t len = 0;
        (void)ServerRecvMsg(&g_serverMgr[ComponentType::COMPONENT_GETD_FILE], &msg, &len, 1000);
    });
    bool recvEntered = false;
    for (int32_t i = 0; (i < 3000) && !recvEntered; i++) {
        recvEntered = g_utRecvEntered;
        if (!recvEntered) {
            usleep(1000);
        }
    }
    ASSERT_TRUE(recvEntered);

    g_utInvalidSession = (OptHandle)0x11111; // session A breaks, monitor A exits and detaches

    bool finished = false;
    for (int32_t i = 0; (i < 5000) && !finished; i++) {
        finished = turnDone;
        if (!finished) {
            usleep(1000); // 5s deadline: join of A + creation of monitor B
        }
    }
    if (!finished) {
        ADD_FAILURE() << "ServerProcess of session B did not complete after session A broke";
        turnThread.detach(); // never join a deadlocked task: keep the failure observable
        recvThread.join();
        return;
    }
    turnThread.join();
    EXPECT_EQ(0, turnRet);
    recvThread.join(); // the in-flight request on B releases its own reference

    // A's node is fully destroyed by its own monitor (it never counted B's reference);
    // B's node keeps exactly its own holders: the monitor B lifetime reference
    const ServerMgr* mgr = &g_serverMgr[ComponentType::COMPONENT_GETD_FILE];
    ASSERT_NE(nullptr, mgr->commList);
    EXPECT_EQ(nullptr, mgr->commList->next); // exactly one generation left: B
    EXPECT_EQ((OptHandle)0x22222, mgr->commList->comm->session);
    EXPECT_EQ(1U, mgr->commList->refs);      // monitor B lifetime only, the recv reference was returned
    EXPECT_FALSE(mgr->commList->dying);
    EXPECT_EQ(mgr->commList, mgr->current);

    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
    EXPECT_EQ(0U, mgr->linkedNum);
    EXPECT_EQ(nullptr, mgr->current);
    EXPECT_EQ(nullptr, mgr->commList);

    GlobalMockObject::reset();
}

// scheduling race regression (the fatal review round): the session monitor must bind to
// the node of its own generation even when its thread starts late. Monitor A is parked
// at its thread entry (ctx release, right before the acquire), session B is published
// while A never ran, then A is released: A must operate on (and destroy) node A, while
// B keeps its own monitor and node. Acquiring from mgr->current instead would make A
// hold B's node and orphan A's.
TEST(ServerMgrDyingListUtest, MonitorBindsToItsOwnGenerationNodeUnderDelayedStart)
{
    g_utInvalidSession = 0;
    g_utDestroyCount = 0;
    g_utLogFreeParkArmed = 1;
    g_utLogFreeRelease = false;
    ServerAttr attr = {0};
    attr.num = 2;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStartNoop, TestServerStopNoop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(UtSessionAttrPerSession));
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(UtCountDestroy));
    MOCKER(LogFree).stubs().will(invoke(UtParkingLogFree));

    CommHandle handleA;
    handleA.type = (OptType)COMM_HDC;
    handleA.session = (OptHandle)0x11111;
    handleA.timeout = 0;
    handleA.client = nullptr;
    handleA.comp = COMPONENT_GETD_FILE;
    EXPECT_EQ(0, ServerProcess(&handleA, nullptr, 0)); // returns, its monitor parks at thread entry

    // session B is published while monitor A has not executed its first instruction:
    // B's ServerProcess parks inside the join of monitor A right after publishing
    CommHandle handleB;
    handleB.type = (OptType)COMM_HDC;
    handleB.session = (OptHandle)0x22222;
    handleB.timeout = 0;
    handleB.client = nullptr;
    handleB.comp = COMPONENT_GETD_FILE;
    int32_t turnRet = -1;
    bool turnDone = false;
    std::thread turnThread([&] {
        turnRet = ServerProcess(&handleB, nullptr, 0);
        turnDone = true;
    });
    bool published = false;
    for (int32_t i = 0; (i < 3000) && !published; i++) {
        published = (g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current != nullptr) &&
                    (g_serverMgr[ComponentType::COMPONENT_GETD_FILE].current->comm->session == (OptHandle)0x22222);
        if (!published) {
            usleep(1000);
        }
    }
    ASSERT_TRUE(published);

    g_utInvalidSession = (OptHandle)0x11111; // session A is broken
    g_utLogFreeRelease = true;               // monitor A finally starts: it must take node A

    bool finished = false;
    for (int32_t i = 0; (i < 5000) && !finished; i++) {
        finished = turnDone;
        if (!finished) {
            usleep(1000); // 5s deadline: join of A + creation and ack of B
        }
    }
    if (!finished) {
        ADD_FAILURE() << "ServerProcess of session B did not complete after monitor A started";
        turnThread.detach(); // never join a deadlocked task: keep the failure observable
        return;
    }
    turnThread.join();
    EXPECT_EQ(0, turnRet);

    // monitor A operated on node A: A's handle destroyed exactly once, A's node is gone;
    // monitor B holds node B with only its own lifetime reference
    const ServerMgr* mgr = &g_serverMgr[ComponentType::COMPONENT_GETD_FILE];
    EXPECT_EQ(1, g_utDestroyCount);
    ASSERT_NE(nullptr, mgr->commList);
    EXPECT_EQ(nullptr, mgr->commList->next); // only B's generation left
    EXPECT_EQ((OptHandle)0x22222, mgr->commList->comm->session);
    EXPECT_EQ(1U, mgr->commList->refs);
    EXPECT_FALSE(mgr->commList->dying);
    EXPECT_EQ(mgr->commList, mgr->current);

    ServerRelease(ComponentType::COMPONENT_GETD_FILE); // B's monitor exits and destroys node B
    EXPECT_EQ(2, g_utDestroyCount);
    EXPECT_EQ(0U, mgr->linkedNum);
    EXPECT_EQ(nullptr, mgr->current);
    EXPECT_EQ(nullptr, mgr->commList);

    GlobalMockObject::reset();
}
