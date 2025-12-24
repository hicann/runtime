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
#include "scd_ptrace.h"
#include "scd_memory.h"
#include "scd_layout.h"
#include "scd_thread.h"

extern "C" {
    ScdSection *ScdLayoutGetEmptShdr(ScdProcess *pro);
}

class ScdUtilUtest: public testing::Test {
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

TEST_F(ScdUtilUtest, TestScdLayoutWrite)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    procInfo.args.pid = getpid();
    procInfo.args.crashTid = gettid();
    ScdProcess *proc = NULL;
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdLayoutRead(&proc, binPath);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_NE((ScdProcess *)0, proc);

    free(proc);
}

TEST_F(ScdUtilUtest, TestScdLayoutWrite_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    // realpath failed
    errno=0;
    MOCKER(TraceRealPath).stubs().will(returnValue(-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // snprintf failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // open failed
    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutWrite_GetEmptShdr_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    int32_t callNum = 5;
    for (int32_t i = 0 ; i < callNum; i++) {
        ScdProcess procInfo = { 0 };
        procInfo.args.pid = getpid();
        procInfo.args.crashTid = gettid();
        ScdSection *section = (ScdSection *)&procInfo.shdr[0];
        MOCKER(ScdLayoutGetEmptShdr).stubs().will(repeat(section, i))
            .then(returnValue((ScdSection *)0));
        ret = ScdLayoutWrite(fd, &procInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        GlobalMockObject::verify();
    }

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutWrite_memcpy_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    int32_t callNum = 5;
    for (int32_t i = 0 ; i < callNum; i++) {
        ScdProcess procInfo = { 0 };
        procInfo.args.pid = getpid();
        procInfo.args.crashTid = gettid();
        MOCKER(memcpy_s).stubs().will(repeat(EOK, i))
            .then(returnValue(-1));
        ret = ScdLayoutWrite(fd, &procInfo);
        EXPECT_EQ(TRACE_FAILURE, ret);
        GlobalMockObject::verify();
    }

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutWritePhdr_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    MOCKER(ScdUtilWrite).stubs().will(returnValue((size_t)-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutWrite_lseek_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    procInfo.args.pid = getpid();
    procInfo.args.crashTid = gettid();
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    procInfo.shdr[0].use = true;
    procInfo.shdr[0].type = SCD_SHDR_TYPE_FD;
    MOCKER(lseek).stubs().will(returnValue((off_t)-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    memset(&procInfo, 0, sizeof(procInfo));
    procInfo.args.pid = getpid();
    procInfo.args.crashTid = gettid();
    procInfo.shdr[0].use = true;
    procInfo.shdr[0].type = SCD_SHDR_TYPE_LIST;
    MOCKER(lseek).stubs().will(returnValue((off_t)-1));
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutWrite_invalid_org)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    procInfo.args.pid = getpid();
    procInfo.args.crashTid = gettid();
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    procInfo.shdr[0].use = true;
    procInfo.shdr[0].type = SCD_SHDR_TYPE_FD;
    procInfo.shdr[0].org = SCD_SHDR_INVALID_FD;
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // release
    close(fd);
}

TEST_F(ScdUtilUtest, TestScdLayoutRead)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    procInfo.args.pid = getpid();
    procInfo.args.crashTid = gettid();
    ScdProcess *proc = NULL;
    char binPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin" };
    int32_t fd = open(binPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);
    ret = ScdLayoutWrite(fd, &procInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    // open file failed
    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = ScdLayoutRead(&proc, binPath);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ((ScdProcess *)0, proc);
    GlobalMockObject::verify();

    // lseek failed
    MOCKER(lseek).stubs().will(returnValue((off_t)-1));
    ret = ScdLayoutRead(&proc, binPath);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ((ScdProcess *)0, proc);
    GlobalMockObject::verify();

    // malloc failed
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)0));
    ret = ScdLayoutRead(&proc, binPath);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ((ScdProcess *)0, proc);
    GlobalMockObject::verify();

    // read failed
    MOCKER(read).stubs().will(returnValue((ssize_t)0));
    ret = ScdLayoutRead(&proc, binPath);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ((ScdProcess *)0, proc);
    GlobalMockObject::verify();

    if (proc != NULL) {
        free(proc);
    }
}

TEST_F(ScdUtilUtest, TestScdSectionRecord)
{
    TraStatus ret = TRACE_FAILURE;
    ScdProcess procInfo = { 0 };
    // set stack section
    procInfo.shdr[0].use = true;
    memcpy_s(procInfo.shdr[0].name, SCD_SECTION_NAME_LEN, SCD_SECTION_STACK, strlen(SCD_SECTION_STACK));

    procInfo.shdr[1].use = true;
    memcpy_s(procInfo.shdr[1].name, SCD_SECTION_NAME_LEN, "test", strlen("test"));

    char txtPath[256] = { LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.txt" };
    int32_t fd = open(txtPath, O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);

    ret = ScdSectionRecord(fd, &procInfo, "test");
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdSectionRecord(fd, &procInfo, SCD_SECTION_STACK);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    MOCKER(ScdUtilWrite).stubs().will(returnValue((size_t)-1));
    ret = ScdSectionRecord(fd, &procInfo, SCD_SECTION_STACK);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(ScdUtilUtest, TestScdPtraceAttach)
{
    int32_t tid = gettid();
    TraStatus ret = TRACE_FAILURE;

    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        sleep(1); // wait for parent to set ptracer
        ret = ScdPtraceAttach(tid);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        ScdPtraceDetach(tid);

        exit(0);
    } else {
        int32_t err = prctl(PR_SET_PTRACER, status, 0, 0, 0);
        EXPECT_EQ(0, err);
        int ret = 0;
        (void)wait(&ret);
    }
}

TEST_F(ScdUtilUtest, TestScdUtilTrim)
{
    const char *data = NULL;
    TraStatus ret = TRACE_FAILURE;

    ret = ScdUtilTrim(NULL, 0, &data);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ(NULL, data);

    char tmp1[100] = "\0";
    ret = ScdUtilTrim(tmp1, 100, &data);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(tmp1, data);

    char tmp2[100] = "   \0";
    ret = ScdUtilTrim(tmp2, 100, &data);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(&tmp2[3], data);

    char tmp3[100] = "   test   ";
    ret = ScdUtilTrim(tmp3, 100, &data);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(&tmp3[3], data);
}

TEST_F(ScdUtilUtest, TestScdUtilReadStdin)
{
    char buf[10] = {0};
    TraStatus ret = TRACE_FAILURE;

    ret = ScdUtilReadStdin(NULL, 0);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(read).stubs().will(returnValue((ssize_t)-1));
    ret = ScdUtilReadStdin((void *)buf, 10);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(read).stubs().will(returnValue((ssize_t)10));
    ret = ScdUtilReadStdin((void *)buf, 10);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdUtilUtest, TestScdUtilOpen)
{
    int32_t ret = -1;
    char path[256] = { "/proc/self/maps" };

    ret = ScdUtilOpen(path);
    EXPECT_NE(-1, ret);
    close(ret);

    MOCKER(TraceRealPath).stubs().will(returnValue(-1));
    ret = ScdUtilOpen(path);
    EXPECT_EQ(-1, ret);
    GlobalMockObject::verify();

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = ScdUtilOpen(path);
    EXPECT_EQ(-1, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdUtilUtest, TestScdUtilWrite)
{
    char buf[10] = {0};
    int32_t fd = 1;
    size_t ret = -1;

    ret = ScdUtilWrite(-1, buf, 10);
    EXPECT_EQ(0, ret);

    MOCKER(write).stubs().will(returnValue((ssize_t)-1));
    ret = ScdUtilWrite(fd, buf, 10);
    EXPECT_EQ(0, ret);
}

static ssize_t read_stub(int fd, void *buf, size_t count)
{
    static int32_t cnt = 0;
    cnt++;
    if (cnt <= 1) {
        errno = EINTR;
        return -1;
    } else if (cnt == 2) {
        errno = 0;
        return -1;
    }

    errno = 0;
    return 0;
}

TEST_F(ScdUtilUtest, TestScdUtilReadLine)
{
    int32_t fd = 1;
    char msg[512] = {0};
    uint32_t len = 512;
    ssize_t ret = 0;

    ret = ScdUtilReadLine(fd, NULL, 0);
    EXPECT_EQ(-1, ret);

    MOCKER(read).stubs().will(invoke(read_stub));
    ret = ScdUtilReadLine(fd, msg, len);
    EXPECT_EQ(-1, ret);

    ret = ScdUtilReadLine(fd, msg, len);
    EXPECT_EQ(0, ret);
    GlobalMockObject::verify();
}

TEST_F(ScdUtilUtest, TestScdUtilGetProcessName)
{
    int32_t pid = 0;
    char buf[512] = {0};
    uint32_t len = 512;

    // snprintf failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();

    // open failed
    pid = 0;
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();

    // get success
    pid = getpid();
    ScdUtilGetProcessName(pid, buf, len);
    printf("read from cmdline : [%s]\n", buf);
    EXPECT_STRNE("unknown", buf);
}

TEST_F(ScdUtilUtest, TestScdUtilSetUnknown)
{
    int32_t pid = 0;
    char buf[512] = {0};
    uint32_t len = 512;

    // strncpy_s failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STRNE("unknown", buf);
    GlobalMockObject::verify();
}

TEST_F(ScdUtilUtest, TestScdUtilGetTaskName)
{
    int32_t pid = getpid();
    char buf[512] = {0};
    uint32_t len = 512;

    // read line failed
    MOCKER(ScdUtilReadLine).stubs().will(returnValue(0));
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();

    // read line failed
    MOCKER(ScdUtilTrim).stubs().will(returnValue(TRACE_FAILURE));
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();

    // strncpy_s failed
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ScdUtilGetProcessName(pid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();
}


TEST_F(ScdUtilUtest, TestScdUtilGetThreadName)
{
    int32_t pid = getpid();
    int32_t tid = gettid();
    char buf[SCD_THREAD_NAME_LEN] = {0};
    uint32_t len = SCD_THREAD_NAME_LEN;

    std::string strA;
    std::string strB;
    // thread name is less than SCD_THREAD_NAME_LEN(16)
    strA.assign(SCD_THREAD_NAME_LEN , 'A');
    strB.assign(SCD_THREAD_NAME_LEN -1U , 'A');

    prctl(PR_SET_NAME, strA.c_str());
    ScdUtilGetThreadName(pid, tid, buf, len);
    EXPECT_STREQ(strB.c_str(), buf); // threadName不能超过16个字节,会被截断

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ScdUtilGetThreadName(pid, tid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();

    MOCKER(ScdUtilReadLine).stubs().will(returnValue(0));
    ScdUtilGetThreadName(pid, tid, buf, len);
    EXPECT_STREQ("unknown", buf);
    GlobalMockObject::verify();
}

TEST_F(ScdUtilUtest, TestScdUtilWriteProcInfo)
{
    int32_t pid = getpid();
    int32_t fd = open(LLT_TEST_DIR "/test_scd_utils", O_RDWR | O_CREAT, 0640);
    EXPECT_GE(fd, 0);
    TraStatus ret = TRACE_FAILURE;

    // open proc file failed
    ret = ScdUtilWriteProcInfo(fd, pid, "test");
    EXPECT_EQ(TRACE_FAILURE, ret);

    // snprintf failed
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = ScdUtilWriteProcInfo(fd, pid, "test");
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // write failed
    MOCKER(ScdUtilWrite).stubs().will(returnValue((size_t)0));
    ret = ScdUtilWriteProcInfo(fd, pid, "maps");
    EXPECT_EQ(TRACE_FAILURE, ret);
}