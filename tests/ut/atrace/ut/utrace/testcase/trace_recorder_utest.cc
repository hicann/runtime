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
#include "trace_recorder.h"
#include "trace_attr.h"
#include "adiag_utils.h"
#include <pwd.h>
#include "mmpa_api.h"
#include "trace_types.h"
#include "trace_system_api.h"

#define TIMESTAMP_MAX_LENGTH 29U

class TraceRecorderUtest: public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    virtual void SetUp()
    {
        system("mkdir -p " LLT_TEST_DIR "/ascend");
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));
        EXPECT_EQ(TRACE_SUCCESS, TraceAttrInit());
        EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    }

    virtual void TearDown()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        TraceRecorderExit();
        TraceAttrExit();
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        system("rm -rf " LLT_TEST_DIR );
    }
};

void TestRecorderWrite(uint32_t dirNum, uint32_t fileNum, uint32_t msgNum, const char *suffix)
{
    for (uint32_t i = 0; i < dirNum; i++) {
        char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
        TraStatus ret = TimestampToFileStr(GetRealTime() + i * 100, timeStr, TIMESTAMP_MAX_LENGTH);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, TraceGetPid(), timeStr };
        printf("dir[%u] time = [%s]\n", i, timeStr);
        for (uint32_t j = 0; j < fileNum; j++) {
            std::string objName = "HCCL_" + std::to_string(i) + "_" + std::to_string(j);
            TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName.c_str(), suffix };
            int32_t fd = -1;
            ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
            EXPECT_EQ(TRACE_SUCCESS, ret);
            for (uint32_t k = 0; k < msgNum; k++) {
                std::string msg = "msg_" + std::to_string(k) + "\n";
                ret = TraceRecorderWrite(fd, msg.c_str(), msg.size() + 1);
                EXPECT_EQ(TRACE_SUCCESS, ret);
            }
            close(fd);
        }
    }
}

void *RecordTrace(void *arg)
{
    (void)arg;
    sleep(1);
    TestRecorderWrite(10, 1, 2, TRACE_FILE_TXT_SUFFIX);
    return NULL;
}

TEST_F(TraceRecorderUtest, TestRecord_Concurrent)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    int32_t threadNum = 10;
    pthread_t theadId[threadNum] = { 0 };

    for (int i = 0; i < threadNum; i++) {
        int32_t ret = pthread_create(&theadId[i], NULL, RecordTrace, NULL);
        EXPECT_EQ(0, ret);
    }

    for (int i = 0; i < threadNum; i++) {
        pthread_join(theadId[i], NULL);
    }
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordEnvPath)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    TestRecorderWrite(1, 1, 2, TRACE_FILE_TXT_SUFFIX);

    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordEnvInvalidPath)
{
    printf("path doesn't exist, then create it successfully.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    printf("path doesn't exist, then create it failed.\n");
    TraceRecorderExit();
    system("rm -rf " LLT_TEST_DIR "/env");
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("path doesn't have permission to write.\n");
    TraceRecorderExit();
    MOCKER(TraceAccess).stubs().will(returnValue(-1));
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    unsetenv("ASCEND_WORK_PATH");
}


TEST_F(TraceRecorderUtest, TestRecordEnv_MkdirRecurFailed)
{
    printf("path doesn't exist, then create it.\n");
    printf("strdup failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(strdup).stubs().will(returnValue((char *)0));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("snprintf_s failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("strncat_s failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(strncat_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("mkdir failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordRealPathFailed)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    MOCKER(mmRealPath).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    TraceRecorderExit();
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordHomePath)
{
    TestRecorderWrite(1, 1, 2, TRACE_FILE_TXT_SUFFIX);
}

TEST_F(TraceRecorderUtest, TestGetDirMkdirFailed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    int testNum = 4;
    for (int i = 0 ; i < testNum; i++) {
        MOCKER(mkdir)
            .stubs()
            .will(repeat(0, i))
            .then(returnValue(-1));
        MOCKER(access).stubs().will(returnValue(-1));
        MOCKER(chown).stubs().will(returnValue(0));
        MOCKER(chmod).stubs().will(returnValue(0));
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr };
        const TraceDirNode *dir = TraceRecorderGetDirPath(&dirInfo);
        EXPECT_EQ((const TraceDirNode *)0, dir);
        GlobalMockObject::verify();
    }
}

TEST_F(TraceRecorderUtest, TestSafeGetFdMkdirFailed)
{
    MOCKER(mkdir)
        .stubs()
        .will(returnValue(-1));
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceRecorderUtest, TestSafeGetFd)
{
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(TraceRecorderUtest, TestSafeGetBinFd)
{
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(TraceRecorderUtest, TestGetEventFd)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    for (int32_t i = 0; i < 15; i++) {
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr };
        TraceFileInfo info = { TRACER_SCHEDULE_NAME,  "ts_0", ".txt" };
        int32_t fd = -1;
        ret = TraceRecorderGetFd(&dirInfo, &info, &fd);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        close(fd);
    }
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr };
    TraceFileInfo info = { TRACER_SCHEDULE_NAME,  "ts_0", ".txt" };
    int32_t fd = -1;
    MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)0));
    ret = TraceRecorderGetFd(&dirInfo, &info, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeGetFd_Failed)
{
    auto ret = TraceRecorderSafeGetFd(NULL, NULL, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", ".txt" };
    int32_t fd = -1;
    TraStatus status = TRACE_FAILURE;

    MOCKER(TraceMkdir).stubs().will(returnValue(status));
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(status, ret);
    GlobalMockObject::verify();

    MOCKER(strncat_s).stubs().will(returnValue(-1));
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceOpen).stubs().will(returnValue(-1));
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeMkdirPath_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(-1));
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeGetDirPath_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };
    char path[1024] = {0};

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(NULL, path, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(&dirInfo, NULL, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(&dirInfo, path, 0));

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceRecorderSafeGetDirPath(&dirInfo, path, 1024));
}