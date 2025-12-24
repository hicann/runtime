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

#include "slogd_collect_log.h"
#include "log_file_info.h"
#include "slogd_config_mgr.h"
#include "log_config_group.h"
#include "slogd_group_log.h"
#include "slogd_buffer.h"
#include "slogd_flush.h"
#include "log_pm_sig.h"
#include "slogd_syslog.h"
#include "slogd_applog_flush.h"
#include "slogd_eventlog.h"
#include "self_log_stub.h"
#include "zlib.h"
#include "iam.h"
#include "log_pm_sr.h"

using namespace std;
using namespace testing;

extern GeneralGroupInfo g_groupInfo;
extern enum IAMResourceStatus g_slogdCompressResStatus;
extern enum SystemState g_systemState;

class MDC_SLOGD_COLLECT_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " BOOTARGS_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        g_slogdCompressResStatus = IAM_RESOURCE_READY;
        g_systemState = WORKING;
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("mkdir -p " FILE_DIR);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
    }

    static void DlogDestructor()
    {
        (void)memset_s(&g_groupInfo, sizeof(GeneralGroupInfo), 0, sizeof(GeneralGroupInfo));
    }
};

TEST_F(MDC_SLOGD_COLLECT_FUNC_UTEST, SlogdGetLogPatterns)
{
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();

    LogConfigInfo info;
    EXPECT_EQ(LOG_SUCCESS, SlogdGetLogPatterns(&info));
    LogStrTrimEnd(info.rootPath, PATH_MAX);
    LogStrTrimEnd(info.groupPath, PATH_MAX);
    EXPECT_STREQ(FILE_DIR, info.rootPath);
    EXPECT_STREQ(FILE_DIR, info.groupPath);
    const GeneralGroupInfo *groupInfo = LogConfGroupGetInfo();
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        if (groupInfo->map[groupId].isInit == 0) {
            break;
        }
        EXPECT_STREQ(groupInfo->map[groupId].name, info.groupName[groupId]);
    }

    // 释放
    SlogdConfigMgrExit();
    DlogDestructor();
    EXPECT_EQ(0, GetErrLogNum());
}

static int32_t CheckCollectResult(const char *file, const char *msg)
{
    char cmd[1024] = { 0 };
    char resultFile[1024] = { 0 };
    snprintf_s(resultFile, 1024, 1023, "%s/collectResult.txt", PATH_ROOT);
    snprintf_s(cmd, 1024, 1023, "cat %s | grep -a \"%s\" | wc -l > %s", file, msg, resultFile);
    SELF_LOG_INFO("%s", cmd);
    system(cmd);

    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == NULL) {
        return 0;
    }
    int size = fread(buf, 1, MSG_LENGTH, fp);
    fclose(fp);
    if (size == 0) {
        return 0;
    } else {
        return atoi(buf);
    }
}
#define BLOCK_SIZE          (1024 * 1024) // 1MB
static unsigned char g_deflateIn[BLOCK_SIZE] = { 0 };
static unsigned char g_deflateOut[BLOCK_SIZE] = { 0 };
static uint32_t LogGetFileSize(const char *fileName)
{
    struct stat statbuff;
    if (stat(fileName, &statbuff) == 0) {
        return (uint32_t)statbuff.st_size;
    }
    return 0U;
}

static void LogUnCompressFile(const char *fileName)
{
    char gzFileName[1024] = { 0 };
    char ungzFileName[1024] = { 0 };
    char cmd[1024] = { 0 };
    snprintf_s(ungzFileName, 1024, 1023, "%s", fileName);
    if (strstr(fileName, ".gz") != NULL) {
        snprintf_s(gzFileName, 1024, 1023, "%s", fileName);
        ungzFileName[strlen(fileName) - 3] = '\0';
    } else {
        snprintf_s(gzFileName, 1024, 1023, "%s.gz", fileName);
        snprintf_s(cmd, 1024, 1023, "mv %s %s", fileName, gzFileName);
        system(cmd);
    }
    FILE *in = fopen(gzFileName, "r");
    FILE *out = fopen(ungzFileName, "w");
    if ((in == NULL) || (out == NULL)) {
        printf("fopen failed.\n");
        return;
    }
    uint64_t decompressed_len = BLOCK_SIZE;
    while (feof(in) == 0) {
        memset_s(g_deflateIn, BLOCK_SIZE, 0, BLOCK_SIZE);
        memset_s(g_deflateOut, BLOCK_SIZE, 0, BLOCK_SIZE);
        decompressed_len = BLOCK_SIZE;
        fread(g_deflateIn, 1, 5000, in);
        int ret = uncompress(g_deflateOut, &decompressed_len, g_deflateIn, 5000);
        if (ret != 0) {
            printf("uncompress failed, ret = %d.\n", ret);
            break;
        }
        fwrite(g_deflateOut, decompressed_len, 1, out);
    }
    fclose(in);
    fclose(out);
}

TEST_F(MDC_SLOGD_COLLECT_FUNC_UTEST, SlogdStartCollectThread)
{
    LogRecordSigNo(0);
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdGroupLogInit());
    LogConfGroupInit(SLOG_CONF_FILE_PATH);

    // 生成buffer
    uint32_t bufSize = 256 * 1024 * 1024;
    uint32_t length = 1024;
    const char *msg = "[]slogd start collect thread test.\n";
    for (uint32_t i = 0; i < LOG_TYPE_MAX_NUM; i++) {
        SlogdBufferInit(i, bufSize, 0, NULL);
        void *handle = SlogdBufferHandleOpen(i, 0, LOG_BUFFER_WRITE_MODE, 0);
        SlogdBufferWrite(handle, msg, strlen(msg));
        SlogdBufferHandleClose(&handle);
    }

    // test collect thread
    char path[256] = { 0 };
    snprintf_s(path, 256, 255, "%s/ascendmerge.log.gz", PATH_ROOT);
    SlogdStartCollectThread();
    SlogdCollectNotify(path, 256);
    sleep(2);
    LogUnCompressFile(path);
    path[strlen(path) - 3] = '\0';
    EXPECT_EQ(18, CheckCollectResult(path, "slogd start collect thread test."));

    // recycle resource
    LogRecordSigNo(15);
    SlogdCollectThreadExit();
    for (uint32_t i = 0; i < LOG_TYPE_MAX_NUM; i++) {
        SlogdBufferExit(i, 0);
    }
    SlogdFlushExit();
}