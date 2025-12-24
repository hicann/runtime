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

#include "adiag_utils.h"
#include "trace_system_api.h"

#include "scd_layout.h"
#include "scd_process.h"
#include "scd_threads.h"
#include "scd_thread.h"
#include "scd_frames.h"
#include "scd_frame.h"

extern "C" {
    TraStatus ScdProcessInit(ScdProcess **process, ScdProcessArgs *args);
    TraStatus ScdProcessRecordInfo(int32_t fd, const ScdProcess *pro);
    TraStatus ScdProcessRecordProcInfo(int32_t fd, pid_t pid, const char *name);
}

class ScdProcessUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

TEST_F(ScdProcessUtest, TestScdProcessInit)
{
    ScdProcessArgs arg = {0};
    TraStatus ret = TRACE_FAILURE;

    // malloc failed
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // memcpy_s failed
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // maps init failed
    MOCKER(ScdMapsInit).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // threads init failed
    MOCKER(ScdThreadsInit).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessLoad)
{
    ScdProcessArgs arg = {0};
    TraStatus ret = TRACE_FAILURE;

    // load maps failed
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // load process info failed
    MOCKER(ScdThreadsLoadInfo).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // load frames failed
    MOCKER(ScdThreadsLoadFrames).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessDump)
{
    ScdProcessArgs arg = {0};
    TraStatus ret = TRACE_FAILURE;

    // load threads failed
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // load process failed
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessParseCore)
{
    ScdProcess *tmpProcess = (ScdProcess *)AdiagMalloc(sizeof(ScdProcess));
    EXPECT_NE((ScdProcess *)0, tmpProcess);
    tmpProcess->shdrUsed = true;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(tmpProcess->args.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(tmpProcess->args.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));

    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_CREAT | O_RDWR | O_TRUNC, 0640);
    EXPECT_EQ(sizeof(ScdProcess), ScdUtilWrite(fd, tmpProcess, sizeof(ScdProcess)));
    EXPECT_GE(fd, 0);
    close(fd);
    uint32_t len = strlen(binPath);
    TraStatus ret = TRACE_FAILURE;

    ret = ScdProcessParseCore(binPath, TRACE_MAX_PATH);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ret = ScdProcessParseCore(binPath, 0);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(access).stubs().will(returnValue(-1));
    ret = ScdProcessParseCore(binPath, len);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(access).stubs().will(returnValue(0));
    ret = ScdProcessParseCore(LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.txt", len);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // realpath failed
    MOCKER(TraceRealPath).stubs().will(returnValue(-1));
    ret = ScdProcessParseCore(binPath, len);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // read core file failed
    MOCKER(ScdLayoutRead).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessParseCore(binPath, len);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // record to txt failed
    MOCKER(access).stubs().will(returnValue(0))
        .then(returnValue(-1));
    MOCKER(ScdSectionRecord).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessParseCore(binPath, len);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // remove txt file failed
    MOCKER(remove).stubs().will(returnValue(-1));
    ret = ScdProcessParseCore(binPath, len);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    free(tmpProcess);
}

TEST_F(ScdProcessUtest, TestScdProcessRecordTxt)
{
    ScdProcessArgs arg = {0};
    arg.pid = getpid();
    arg.crashTid = gettid();
    arg.handleType = SCD_DUMP_THREADS_TXT;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(arg.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(arg.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));
    TraStatus ret = TRACE_FAILURE;

    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessRecordProcInfo)
{
    int32_t fd = 1;
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;

    ret = ScdProcessRecordProcInfo(fd, pid, "test");
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(ScdProcessUtest, TestScdProcessCreateFile_Failed)
{
    ScdProcessArgs arg = {0};
    arg.pid = getpid();
    arg.crashTid = gettid();
    arg.handleType = SCD_DUMP_THREADS_TXT;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(arg.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(arg.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));
    TraStatus ret = TRACE_FAILURE;

    // access failed
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // snprintf failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // open failed
    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // realpath failed
    MOCKER(TraceRealPath).stubs().will(returnValue(1));
    MOCKER(AdiagGetErrorCode).stubs().will(returnValue(0));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessRecordInfo_Failed)
{
    ScdProcess pro = {0};
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = open("/dev/null", O_RDWR);
    EXPECT_GE(fd, 0);

    MOCKER(popen).stubs().will(returnValue((FILE *)NULL));
    ret = ScdProcessRecordInfo(fd, &pro);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = ScdProcessRecordInfo(fd, &pro);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(ScdUtilWrite).stubs().will(returnValue((size_t)0));
    ret = ScdProcessRecordInfo(fd, &pro);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    // release
    close(fd);
}

TEST_F(ScdProcessUtest, TestScdProcessRecordInfo_snprintf_Failed)
{
    ScdProcess pro = {0};
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = open("/dev/null", O_RDWR);
    EXPECT_GE(fd, 0);

    int32_t callNum = 10;
    for (int32_t i = 0 ; i < callNum; i++) {
        MOCKER(vsnprintf_s).stubs().will(repeat(0, i))
            .then(returnValue(-1));
        ret = ScdProcessRecordInfo(fd, &pro);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        GlobalMockObject::verify();
    }

    // release
    close(fd);
}

TEST_F(ScdProcessUtest, TestScdProcessRecordStack_Failed)
{
    ScdProcessArgs arg = {0};
    arg.pid = getpid();
    arg.crashTid = gettid();
    arg.handleType = SCD_DUMP_THREADS_TXT;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(arg.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(arg.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));
    TraStatus ret = TRACE_FAILURE;

    MOCKER(ScdThreadsRecord).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdProcessUtest, TestScdProcessRecordCore)
{
    ScdProcessArgs arg = {0};
    arg.pid = getpid();
    arg.crashTid = gettid();
    arg.handleType = SCD_DUMP_THREADS_BIN;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(arg.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(arg.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));
    TraStatus ret = TRACE_FAILURE;

    // create bin file failed
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // write bin file failed
    MOCKER(ScdLayoutWrite).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(ScdMapsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(ScdThreadsLoad).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessDump(&arg);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TraStatus ScdFramesLoad_stub(ScdFrames *frames, ScdMaps *maps, ScdRegs *regs)
{
    (void)regs;
    (void)maps;
    // 1. create new frame
    ScdMap map = {.nameLength = strlen("libtest.so"), .name = "libtest.so"};
    uintptr_t pc = 0;
    uintptr_t sp = 1;
    uintptr_t fp = 2;
    ScdFrame *frame = ScdFrameCreate(&map, pc, sp, fp);
    EXPECT_NE((ScdFrame *)NULL, frame);
    frame->num = frames->framesNum;
    frame->tid = frames->tid;

    TraStatus ret = AdiagListInsert(&frames->frameList, frame);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    return TRACE_SUCCESS;
}

static int32_t g_errIdx = 0;
static bool g_errFlag = false;
size_t ScdUtilWrite_stub(int32_t fd, const void *data, size_t len)
{
    g_errFlag = false;
    static int32_t count = 0;
    if (count == g_errIdx) {
        count = 0;
        g_errFlag = true;
        return (size_t)-1;
    }
    count++;
    return len;
}

TEST_F(ScdProcessUtest, TestScdSectionStackRecord)
{
    int32_t pid = getpid();
    int32_t crashTid = gettid();
    ucontext_t uc = {0};
    TraStatus ret = TRACE_FAILURE;
    ScdProcess *tmpProcess = (ScdProcess *)AdiagMalloc(sizeof(ScdProcess));
    EXPECT_NE((ScdProcess *)0, tmpProcess);
    tmpProcess->shdrUsed = true;
    tmpProcess->args.pid = pid;
    tmpProcess->args.crashTid = crashTid;
    char fileName[256] = { "stackcore_tracer_11_49324_python3.8_20241107094559638058" };
    strncpy_s(tmpProcess->args.filePath, SCD_MAX_FILEPATH_LEN + 1U, LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    strncpy_s(tmpProcess->args.fileName, SCD_MAX_FILENAME_LEN + 1U, fileName, strlen(fileName));

    ret = ScdThreadsInit(&tmpProcess->thds, pid, crashTid, &uc);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdThreadsLoad(&tmpProcess->thds);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    MOCKER(ScdFramesLoad).stubs().will(invoke(ScdFramesLoad_stub));
    ScdMaps maps = {0};
    ret = ScdThreadsLoadFrames(&tmpProcess->thds, &maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);
    // write bin success
    ret = ScdLayoutWrite(fd, tmpProcess);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    close(fd);

    // read bin success
    ScdProcess *readPoint = NULL;
    ret = ScdLayoutRead(&readPoint, binPath);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_NE((ScdProcess *)NULL, readPoint);

    char txtPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.txt" };
    fd = open(txtPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    // write txt success
    ret = ScdSectionRecord(fd, readPoint, SCD_SECTION_STACK);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    // write txt failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = ScdSectionRecord(fd, readPoint, SCD_SECTION_STACK);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs().will(returnValue(0))
        .then(returnValue(-1));
    ret = ScdSectionRecord(fd, readPoint, SCD_SECTION_STACK);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    int32_t testNum = 10;
    for (int32_t i = 0 ; i < testNum; i++) {
        g_errIdx = i;
        MOCKER(ScdUtilWrite).stubs().will(invoke(ScdUtilWrite_stub));
        MOCKER(ScdUtilWriteNewLine).stubs();
        ret = ScdSectionRecord(fd, readPoint, SCD_SECTION_STACK);
        if (g_errFlag) {
            EXPECT_EQ(TRACE_FAILURE, ret);
        } else {
            EXPECT_EQ(TRACE_SUCCESS, ret);
        }
        GlobalMockObject::verify();
    }

    // release resource
    free(readPoint);
    ScdThreadsUninit(&tmpProcess->thds);
    free(tmpProcess);
}