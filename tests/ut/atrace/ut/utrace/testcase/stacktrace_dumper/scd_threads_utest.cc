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

#include <sys/ptrace.h>
#include "adiag_utils.h"

#include "scd_threads.h"
#include "scd_thread.h"
#include "scd_frames.h"
#include "scd_frame.h"
#include "scd_maps.h"
#include "scd_ptrace.h"
#include "scd_regs.h"

class ScdThreadsUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

extern "C" TraStatus ScdFramesFpStep(ScdFrames *frames, ScdRegs *regs);


TEST_F(ScdThreadsUtest, TestScdThreadLoadFrames)
{
    ScdThread thd;
    ScdMaps maps = {0};
    TraStatus ret = TRACE_FAILURE;

    ret = ScdThreadLoadFrames(&thd, &maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(ScdThreadsUtest, TestScdThreadCreate)
{
    pid_t pid = 0;
    pid_t tid = 0;
    ScdThread *ret = 0;

    ret = ScdThreadCreate(pid, tid);
    EXPECT_NE((ScdThread *)0, ret);
    ScdThreadDestroy(&ret);

    MOCKER(ScdFramesInit).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdThreadCreate(pid, tid);
    EXPECT_EQ((ScdThread *)0, ret);
    ScdThreadDestroy(&ret);
}


pid_t waitpid_stub_stopped(pid_t pid, int *wstatus, int options)
{
    printf("waitpid_stub_stopped\n");
    *wstatus = 0x137F;
    // wait for thread stopped;
    usleep(1000);
    return 0;
}
pid_t waitpid_stub_other_signal(pid_t pid, int *wstatus, int options)
{
    printf("waitpid_stub_other_signal\n");
    *wstatus = 0x27F;
    return 0;
}
pid_t waitpid_stub_failed(pid_t pid, int *wstatus, int options)
{
    errno = 0;
    return -1;
}

pid_t waitpid_stub_not_stopped(pid_t pid, int *wstatus, int options)
{
    *wstatus = 0xFF;
    // wait for thread stopped;
    usleep(1000);
    return 0;
}

TEST_F(ScdThreadsUtest, TestScdThreadSuspend)
{
    ScdThread thread;
    thread.tid = 0;
    TraStatus ret = TRACE_FAILURE;

    MOCKER(ScdPtraceAttach).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdThreadSuspend(&thread);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(ScdPtraceAttach).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(waitpid).stubs().will(invoke(waitpid_stub_failed));
    ret = ScdThreadSuspend(&thread);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(ScdPtraceAttach).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(waitpid).stubs().will(invoke(waitpid_stub_not_stopped));
    ret = ScdThreadSuspend(&thread);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(ScdPtraceAttach).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(waitpid).stubs()
        .will(invoke(waitpid_stub_other_signal))
        .then(invoke(waitpid_stub_other_signal))
        .then(invoke(waitpid_stub_stopped));
    ret = ScdThreadSuspend(&thread);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdThreadsUtest, TestScdThreadLoadInfo)
{
    ScdThread thread;
    TraStatus ret = TRACE_FAILURE;

    thread.tid = 0; // ptrace failed
    ret = ScdThreadLoadInfo(&thread);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ(SCD_THREAD_STATUS_REGS, thread.status);
}

TEST_F(ScdThreadsUtest, TestScdThreadLoadInfoForCrash)
{
    ScdThread thread;
    ScdRegs regs = {0};
    TraStatus ret = TRACE_FAILURE;

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = ScdThreadLoadInfoForCrash(&thread, &regs);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

static bool g_exit = false;
void *SleepThread(void *arg)
{
    while (!g_exit) {
        sleep(1);
    }
    return NULL;
}

TEST_F(ScdThreadsUtest, TestScdThreadsInit)
{
    pid_t pid = getpid();
    pid_t tid = gettid();
    ScdThreads threadsInfo = {0};
    ScdMaps maps = {0};
    ucontext_t uc = {0};
    TraStatus ret = TRACE_FAILURE;

    g_exit = false;
    int32_t threadNum = 2;
    pthread_t theadId[threadNum] = { 0 };
    int32_t retThread = 0;

    for (int i = 0; i < threadNum; i++) {
        retThread = pthread_create(&theadId[i], NULL, SleepThread, NULL);
        EXPECT_EQ(0, retThread);
    }
    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        ret = ScdThreadsInit(&threadsInfo, pid, tid, &uc);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ScdThreadsSuspend(&threadsInfo);

        ret = ScdThreadsRecord(1, &threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ret = ScdThreadsLoadFrames(&threadsInfo, &maps);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ret = ScdThreadsLoadInfo(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ScdThreadsResume(&threadsInfo);

        ScdThreadsUninit(&threadsInfo);
        ScdThreadsUninit(NULL);
        exit(0);
    } else {
        int32_t err = prctl(PR_SET_PTRACER, status, 0, 0, 0);
        EXPECT_EQ(0, err);

        int ret = 0;
        (void)wait(&ret);
        g_exit = true;
        for (int i = 0; i < threadNum; i++) {
            pthread_join(theadId[i], NULL);
        }
    }
}

TEST_F(ScdThreadsUtest, TestScdThreadsLoad)
{
    pid_t pid = getpid();
    pid_t tid = gettid();
    ScdThreads threadsInfo = {0};
    ScdMaps maps = {0};
    ucontext_t uc = {0};
    TraStatus ret = TRACE_FAILURE;

    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        MOCKER(AdiagListInit).stubs().will(returnValue(ADIAG_FAILURE));
        ret = ScdThreadsInit(&threadsInfo, pid, tid, &uc);
        EXPECT_EQ(TRACE_FAILURE, ret);
        GlobalMockObject::verify();

        ret = ScdThreadsInit(&threadsInfo, pid, tid, &uc);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        MOCKER(vsnprintf_s).stubs().will(returnValue(-1)); // snprintf_s failed
        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        EXPECT_EQ(0, threadsInfo.thdList.cnt);
        GlobalMockObject::verify();

        MOCKER(AdiagStrToInt).stubs().will(returnValue(ADIAG_FAILURE));
        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        EXPECT_EQ(0, threadsInfo.thdList.cnt);
        GlobalMockObject::verify();

        MOCKER(ScdThreadCreate).stubs().will(returnValue((ScdThread *)0));
        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        EXPECT_EQ(0, threadsInfo.thdList.cnt);
        GlobalMockObject::verify();

        MOCKER(AdiagListInsert).stubs().will(returnValue(ADIAG_FAILURE));
        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        EXPECT_EQ(0, threadsInfo.thdList.cnt);
        GlobalMockObject::verify();

        MOCKER(ScdThreadLoadFrames).stubs().will(returnValue(TRACE_FAILURE));
        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        GlobalMockObject::verify();

        ScdThreadsUninit(&threadsInfo);
        exit(0);
    } else {
        int32_t err = prctl(PR_SET_PTRACER, status, 0, 0, 0);
        EXPECT_EQ(0, err);

        int ret = 0;
        (void)wait(&ret);
    }
}

TEST_F(ScdThreadsUtest, TestScdFramesInit)
{
    ScdMaps maps = {0};
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFrames framesInfo = {0};
    pid_t tid = pid;
    ret = ScdFramesInit(&framesInfo, pid, tid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    framesInfo.maps = &maps;
    ScdRegs regs;
    ptrace(PTRACE_GETREGS, pid, NULL, &regs);
    framesInfo.regs = &regs;
    MOCKER(ScdRegsGetPc).stubs().will(returnValue((uintptr_t)&open));

    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFramesUninit(&framesInfo);
    ScdMapsUninit(&maps);
}

TEST_F(ScdThreadsUtest, TestScdFrameCreate)
{
    ScdMap mapInfo = {0};
    ScdFrame frameInfo = {0};
    uintptr_t pc = 0;
    uintptr_t sp = 0;
    uintptr_t fp = 0;
    ScdFrame *ret = 0;

    ret = ScdFrameCreate(&mapInfo, pc, sp, fp);
    EXPECT_NE((ScdFrame *)0, ret);

    ScdFrameDestroy(&ret);
    EXPECT_EQ((ScdFrame *)0, ret);
}

TEST_F(ScdThreadsUtest, TestScdFramesInitFailed)
{
    ScdFrames framesInfo = {0};
    pid_t pid = getpid();
    pid_t tid = pid;
    MOCKER(mmMutexInit).stubs().will(returnValue(ADIAG_FAILURE));
    TraStatus ret = ScdFramesInit(&framesInfo, pid, tid);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdFramesUninit(&framesInfo);
}

TEST_F(ScdThreadsUtest, TestScdFramesCreateFailed)
{
    ScdMaps maps;
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFrames framesInfo = {0};
    pid_t tid = pid;
    ret = ScdFramesInit(&framesInfo, pid, tid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    framesInfo.maps = &maps;
    ScdRegs regs;
    ptrace(PTRACE_GETREGS, pid, NULL, &regs);
    framesInfo.regs = &regs;
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(ScdRegsGetPc).stubs().will(returnValue((uintptr_t)&open));
    MOCKER(ScdElfStep).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(ScdFramesFpStep).stubs().will(returnValue(TRACE_SUCCESS)).then(returnValue(TRACE_FAILURE));
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdFrame *frame = (ScdFrame *)AdiagMalloc(sizeof(ScdFrame));
    MOCKER(AdiagMalloc).stubs()
        .will(returnValue((void *)0))
        .then(returnValue((void *)frame))
        .then(returnValue((void *)0));
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(mmap).stubs().will(returnValue(MAP_FAILED));
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdFramesUninit(&framesInfo);
    ScdMapsUninit(&maps);
}

TEST_F(ScdThreadsUtest, TestScdFramesMmapFailed)
{
    ScdMaps maps;
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFrames framesInfo = {0};
    pid_t tid = pid;
    ret = ScdFramesInit(&framesInfo, pid, tid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    framesInfo.maps = &maps;
    ScdRegs regs;
    ptrace(PTRACE_GETREGS, pid, NULL, &regs);
    framesInfo.regs = &regs;
    MOCKER(ScdRegsGetPc).stubs().will(returnValue((uintptr_t)&open));
    MOCKER(mmap).stubs().will(returnValue(MAP_FAILED));
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdFramesUninit(&framesInfo);
    ScdMapsUninit(&maps);
}

TEST_F(ScdThreadsUtest, TestScdFramesMemcpyFailed)
{
    ScdMaps maps;
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFrames framesInfo = {0};
    pid_t tid = pid;
    ret = ScdFramesInit(&framesInfo, pid, tid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    framesInfo.maps = &maps;
    ScdRegs regs;
    ptrace(PTRACE_GETREGS, pid, NULL, &regs);
    framesInfo.regs = &regs;
    MOCKER(ScdRegsGetPc).stubs().will(returnValue((uintptr_t)&open));
    MOCKER(memcpy_s).stubs().will(returnValue(-1)).then(returnValue(0));
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    ret = ScdFramesLoad(&framesInfo, framesInfo.maps, framesInfo.regs);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFramesUninit(&framesInfo);
    ScdMapsUninit(&maps);
}

TEST_F(ScdThreadsUtest, TestScdThreadsRecord_Failed)
{
    pid_t pid = getpid();
    pid_t tid = gettid();
    ScdThreads threadsInfo = {0};
    ScdMaps maps = {0};
    ucontext_t uc = {0};
    TraStatus ret = TRACE_FAILURE;

    g_exit = false;
    int32_t threadNum = 2;
    pthread_t theadId[threadNum] = { 0 };
    int32_t retThread = 0;

    for (int i = 0; i < threadNum; i++) {
        retThread = pthread_create(&theadId[i], NULL, SleepThread, NULL);
        EXPECT_EQ(0, retThread);
    }
    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        ret = ScdThreadsInit(&threadsInfo, pid, tid, &uc);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ret = ScdThreadsLoad(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ScdThreadsSuspend(&threadsInfo);

        MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
        ret = ScdThreadsRecord(1, &threadsInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        GlobalMockObject::verify();

        ret = ScdThreadsLoadFrames(&threadsInfo, &maps);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ret = ScdThreadsLoadInfo(&threadsInfo);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ScdThreadsResume(&threadsInfo);

        ScdThreadsUninit(&threadsInfo);
        ScdThreadsUninit(NULL);
        exit(0);
    } else {
        int32_t err = prctl(PR_SET_PTRACER, status, 0, 0, 0);
        EXPECT_EQ(0, err);

        int ret = 0;
        (void)wait(&ret);
        g_exit = true;
        for (int i = 0; i < threadNum; i++) {
            pthread_join(theadId[i], NULL);
        }
    }
}

TEST_F(ScdThreadsUtest, TestScdThreadsRecord)
{
    int32_t fd = 1;
    ScdThreads thds = {0};
    ScdMap map = {0};
    ucontext_t uc = {0};
    pid_t pid = getpid();
    pid_t tid = gettid();
    TraStatus ret = TRACE_FAILURE;

    EXPECT_EQ(TRACE_INVALID_PARAM, ScdThreadsRecord(fd, NULL));

    ScdThreadsInit(&thds, pid, tid, &uc);
    ScdThread *thd = ScdThreadCreate(thds.pid, tid);
    EXPECT_NE((ScdThread *)0, thd);
    ret = AdiagListInsert(&thds.thdList, (void *)thd);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    uint32_t frameIdx = 0;
    ScdFrame *frame1 = ScdFrameCreate(&map, 1, 2, 3);
    EXPECT_NE((ScdFrame *)0, frame1);
    frame1->num = frameIdx++;
    strcpy_s(frame1->funcName, SCD_FUNC_NAME_LENGTH, "test_func");
    ret = AdiagListInsert(&thd->frames.frameList, (void *)frame1);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdFrame *frame2 = ScdFrameCreate(&map, 1, 2, 3);
    EXPECT_NE((ScdFrame *)0, frame1);
    frame2->num = frameIdx++;
    memset(frame2->funcName, 0, SCD_FUNC_NAME_LENGTH);
    ret = AdiagListInsert(&thd->frames.frameList, (void *)frame2);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(TRACE_SUCCESS, ScdThreadsRecord(fd, &thds));

    ScdThreadsUninit(&thds);
}
