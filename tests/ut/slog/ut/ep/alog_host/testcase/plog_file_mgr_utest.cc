/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @file   plog_file_mgr_utest.cc
 * @brief  Unit tests for plog_file_mgr.c, with focus on the fork() PID naming
 *         bug fix introduced in PlogReinitFileHeadsForChild().
 *
 * Bug summary:
 *   After fork(), the child process inherits g_plogFileList verbatim from the
 *   parent. Because PlogInitHostLogList() and PlogInitDeviceMaxFileNum() bake
 *   the parent's PID into list->pid and list->aucFileHead at init time, the
 *   child wrote logs into files named after the parent PID, causing all child
 *   processes to collide on the same filename in the run/plog/ directory.
 *
 * Fix:
 *   PlogReinitFileHeadsForChild() is called from PlogChildUnlock() (atfork
 *   ATFORK_CHILD path) and PlogForkCallback() (alog.so LOG_FORK path).  It
 *   re-runs ToolGetPid() in the child context and updates every list->pid and
 *   list->aucFileHead in both hostLogList and deviceLogList.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "self_log_stub.h"
#include "plog_file_mgr.h"
#include "log_system_api.h"
#include "securec.h"

#include <sys/wait.h>
#include <unistd.h>
#include <string>
#include <cstring>

/* ── constants mirrored from plog_file_mgr.c ─────────────────────────────── */
static const char HOST_FILE_HEAD_PREFIX[] = "plog-";   /* PROC_HEAD + "-" */
static const char DEV_FILE_HEAD_PREFIX[]  = "device-"; /* DEVICE_HEAD     */

/* ── helper: check that aucFileHead encodes the expected pid ──────────────── */
static ::testing::AssertionResult FileHeadContainsPid(const char *fileHead, uint32_t pid)
{
    char expected[32] = {};
    (void)snprintf_s(expected, sizeof(expected), sizeof(expected) - 1, "%u", pid);
    if (strstr(fileHead, expected) != nullptr) {
        return ::testing::AssertionSuccess();
    }
    return ::testing::AssertionFailure()
           << "aucFileHead \"" << fileHead << "\" does not contain pid " << pid;
}

/* ── test fixture ─────────────────────────────────────────────────────────── */
class PlogFileMgrUtest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        /* Point the log root to PATH_ROOT so PlogFileMgrInit() succeeds. */
        setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST] Start PlogFileMgr test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        unsetenv("ASCEND_PROCESS_LOG_PATH");
        system("echo [DBG][TEST] End PlogFileMgr test suite");
    }

    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        ResetErrLog();
    }

    virtual void TearDown()
    {
        /* Always exit file manager so g_plogFileList is freed between tests. */
        PlogFileMgrExit();
        GlobalMockObject::verify();
    }
};

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-01: PlogReinitFileHeadsForChild() is safe when called before init,     *
 *        i.e., when g_plogFileList is NULL. Must not crash.                 *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ReinitForChild_NullListSafe)
{
    /* g_plogFileList is NULL before PlogFileMgrInit() is called. */
    ASSERT_EQ(nullptr, PlogGetFileMgrInfo());
    /* Should return without crashing. */
    PlogReinitFileHeadsForChild();
    EXPECT_EQ(nullptr, PlogGetFileMgrInfo());
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-02: After reinit, all hostLogList entries carry the child's PID in     *
 *        the pid field and in aucFileHead.                                   *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ReinitForChild_UpdatesAllHostLogPidAndFileHead)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fileList = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fileList);

    const uint32_t parentPid = (uint32_t)getpid();
    /* Verify that after init the host log file heads contain the parent PID. */
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        EXPECT_EQ(parentPid, fileList->hostLogList[i].pid)
            << "hostLogList[" << i << "].pid should be parent pid after init";
        EXPECT_TRUE(FileHeadContainsPid(fileList->hostLogList[i].aucFileHead, parentPid))
            << "hostLogList[" << i << "].aucFileHead should contain parent pid after init";
    }

    /* Simulate the child's ToolGetPid() returning a different PID. */
    const uint32_t fakePid = parentPid + 12345U;
    MOCKER(ToolGetPid).stubs().will(returnValue((INT32)fakePid));

    PlogReinitFileHeadsForChild();
    fileList = PlogGetFileMgrInfo();

    /* All host log entries must now carry the child PID. */
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        EXPECT_EQ(fakePid, fileList->hostLogList[i].pid)
            << "hostLogList[" << i << "].pid not updated after reinit";

        const char *head = fileList->hostLogList[i].aucFileHead;
        /* Must start with "plog-" and contain the new PID. */
        EXPECT_EQ(0, strncmp(head, HOST_FILE_HEAD_PREFIX, strlen(HOST_FILE_HEAD_PREFIX)))
            << "hostLogList[" << i << "].aucFileHead prefix wrong: " << head;
        EXPECT_TRUE(FileHeadContainsPid(head, fakePid))
            << "hostLogList[" << i << "].aucFileHead should contain child pid";
        /* Must NOT contain the old parent PID. */
        EXPECT_FALSE(FileHeadContainsPid(head, parentPid))
            << "hostLogList[" << i << "].aucFileHead still contains parent pid";
    }

    GlobalMockObject::verify();
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-03: After reinit, all deviceLogList entries carry the child's PID in   *
 *        the pid field and in aucFileHead.                                   *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ReinitForChild_UpdatesAllDeviceLogPidAndFileHead)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fileList = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fileList);

    const uint32_t parentPid = (uint32_t)getpid();
    const uint32_t fakePid   = parentPid + 9999U;

    MOCKER(ToolGetPid).stubs().will(returnValue((INT32)fakePid));

    PlogReinitFileHeadsForChild();
    fileList = PlogGetFileMgrInfo();

    for (uint32_t type = 0; type < (uint32_t)LOG_TYPE_NUM; type++) {
        ASSERT_NE(nullptr, fileList->deviceLogList[type]);
        for (uint32_t idx = 0; idx < fileList->deviceNum; idx++) {
            PlogFileList *list = &fileList->deviceLogList[type][idx];
            EXPECT_EQ(fakePid, list->pid)
                << "deviceLogList[" << type << "][" << idx << "].pid not updated";

            const char *head = list->aucFileHead;
            EXPECT_EQ(0, strncmp(head, DEV_FILE_HEAD_PREFIX, strlen(DEV_FILE_HEAD_PREFIX)))
                << "deviceLogList[" << type << "][" << idx << "].aucFileHead prefix wrong";
            EXPECT_TRUE(FileHeadContainsPid(head, fakePid))
                << "deviceLogList[" << type << "][" << idx << "] should contain child pid";
            EXPECT_FALSE(FileHeadContainsPid(head, parentPid))
                << "deviceLogList[" << type << "][" << idx << "] still contains parent pid";
        }
    }

    GlobalMockObject::verify();
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-04: After reinit, the current filename slot is cleared so the child's  *
 *        next write opens a fresh file rather than sharing the parent's.    *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ReinitForChild_ClearsCurrentFileNameSlot)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrInfo *fileList = PlogGetFileMgrInfo();
    ASSERT_NE(nullptr, fileList);

    /* Artificially set a non-empty filename so we can verify it gets cleared. */
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        PlogFileList *list = &fileList->hostLogList[i];
        if ((list->aucFileName != nullptr) && (list->currIndex < list->maxFileNum)) {
            (void)strcpy_s(list->aucFileName[list->currIndex], MAX_FILENAME_LEN + 1U,
                           "stale_parent_pid_name.log");
        }
    }

    const uint32_t fakePid = (uint32_t)getpid() + 7777U;
    MOCKER(ToolGetPid).stubs().will(returnValue((INT32)fakePid));

    PlogReinitFileHeadsForChild();
    fileList = PlogGetFileMgrInfo();

    /* The current slot must be zeroed out so the child starts a new file. */
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        PlogFileList *list = &fileList->hostLogList[i];
        if ((list->aucFileName != nullptr) && (list->currIndex < list->maxFileNum)) {
            EXPECT_EQ('\0', list->aucFileName[list->currIndex][0])
                << "hostLogList[" << i << "] current filename slot not cleared after reinit";
        }
    }

    GlobalMockObject::verify();
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-05: Multiple calls to PlogReinitFileHeadsForChild() are idempotent:    *
 *        the second call with the same (mocked) pid yields the same result. *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ReinitForChild_IdempotentMultipleCalls)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());

    const uint32_t fakePid = (uint32_t)getpid() + 5555U;
    MOCKER(ToolGetPid).stubs().will(returnValue((INT32)fakePid));

    PlogReinitFileHeadsForChild();
    PlogReinitFileHeadsForChild(); /* second call must not corrupt state */

    PlogFileMgrInfo *fileList = PlogGetFileMgrInfo();
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        EXPECT_EQ(fakePid, fileList->hostLogList[i].pid);
        EXPECT_TRUE(FileHeadContainsPid(fileList->hostLogList[i].aucFileHead, fakePid));
    }

    GlobalMockObject::verify();
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-06: fork()-based integration test.                                      *
 *        Verifies that after a real fork() + PlogReinitFileHeadsForChild(), *
 *        the child's g_plogFileList carries the child's own PID — not the  *
 *        parent's — in every host log list entry.                           *
 *                                                                           *
 *  exit(0)  → g_plogFileList correctly updated with child PID (fix works)  *
 *  exit(1)  → still contains parent PID (bug present)                      *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ForkChild_ReinitGivesChildOwnPidInFileHead)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    ASSERT_NE(nullptr, PlogGetFileMgrInfo());

    const pid_t parentPid = getpid();

    pid_t child = fork();
    ASSERT_GE(child, 0) << "fork() failed: " << strerror(errno);

    if (child == 0) {
        /* ── child process ─────────────────────────────────────────────── */
        const pid_t myPid = getpid();

        /* Simulate what the real ATFORK_CHILD handler does. */
        PlogReinitFileHeadsForChild();

        PlogFileMgrInfo *childList = PlogGetFileMgrInfo();
        bool ok = true;
        for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
            uint32_t storedPid = childList->hostLogList[i].pid;
            if (storedPid != (uint32_t)myPid) {
                ok = false;
                break;
            }
            const char *head = childList->hostLogList[i].aucFileHead;
            char expected[32] = {};
            (void)snprintf_s(expected, sizeof(expected), sizeof(expected) - 1, "%u", (uint32_t)myPid);
            if (strstr(head, expected) == nullptr) {
                ok = false;
                break;
            }
        }
        /* exit(0) = fix works, exit(1) = bug still present */
        _exit(ok ? 0 : 1);
    }

    /* ── parent: wait for child and check exit code ────────────────────── */
    int wstatus = 0;
    waitpid(child, &wstatus, 0);
    ASSERT_TRUE(WIFEXITED(wstatus)) << "child did not exit normally";
    EXPECT_EQ(0, WEXITSTATUS(wstatus))
        << "Child process: PlogReinitFileHeadsForChild() did not update "
           "hostLogList with child PID — fork PID naming bug is still present";

    /* Sanity-check: parent's list must still hold the parent's PID. */
    PlogFileMgrInfo *parentList = PlogGetFileMgrInfo();
    for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
        EXPECT_EQ((uint32_t)parentPid, parentList->hostLogList[i].pid)
            << "Parent's hostLogList[" << i << "].pid was modified by child "
               "(fork isolation violated?)";
    }
}

/* ══════════════════════════════════════════════════════════════════════════ *
 * TC-07: Regression — without reinit, child would inherit the parent PID.  *
 *        This test documents the bug by showing what happens when reinit is  *
 *        NOT called, confirming the test environment is sound.              *
 * ══════════════════════════════════════════════════════════════════════════ */
TEST_F(PlogFileMgrUtest, ForkChild_WithoutReinitInheritsParentPid_Regression)
{
    ASSERT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    ASSERT_NE(nullptr, PlogGetFileMgrInfo());

    const pid_t parentPid = getpid();

    pid_t child = fork();
    ASSERT_GE(child, 0) << "fork() failed: " << strerror(errno);

    if (child == 0) {
        /* ── child process: intentionally does NOT call reinit ─────────── */
        const pid_t myPid = getpid();
        PlogFileMgrInfo *childList = PlogGetFileMgrInfo();
        bool inherited = false;
        for (int i = (int)DEBUG_LOG; i < (int)LOG_TYPE_NUM; i++) {
            if (childList->hostLogList[i].pid == (uint32_t)parentPid &&
                (uint32_t)myPid != (uint32_t)parentPid) {
                inherited = true;
                break;
            }
        }
        /* exit(0) = bug present (expected for regression doc),
         * exit(1) = somehow not inherited (unexpected) */
        _exit(inherited ? 0 : 1);
    }

    int wstatus = 0;
    waitpid(child, &wstatus, 0);
    ASSERT_TRUE(WIFEXITED(wstatus));
    /* The child exits 0 to signal the bug is present (no reinit → parent PID
     * inherited).  If this expectation ever fails it means the OS or compiler
     * has somehow prevented the inheritance, which would be surprising. */
    EXPECT_EQ(0, WEXITSTATUS(wstatus))
        << "Regression: child should have inherited parent PID in g_plogFileList "
           "when PlogReinitFileHeadsForChild() is NOT called";
}
