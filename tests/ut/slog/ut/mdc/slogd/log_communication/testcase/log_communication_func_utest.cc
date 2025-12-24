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

#include "log_ring_buffer.h"
#include "slogd_communication.h"
#include "slogd_recv_msg.h"
#include "self_log_stub.h"
#include "log_communication_stub.h"
#include "slogd_recv_core.h"

using namespace std;
using namespace testing;

extern "C" {
ssize_t LogIamOpsWrite(struct IAMMgrFile *file, const char *buf, size_t len, loff_t *pos);
}

class MDC_SLOGD_LOG_COMMUNICATION_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
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
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    void SlogdCreateCmdFile(int32_t clockId)
    {
        FILE *fp = fopen(BOOTARGS_FILE_PATH, "w");
        uint32_t length = 1024;
        char msg[length];
        snprintf_s(msg, length, length - 1, "[MDC_SLOGD_FLUSH_FUNC_UTEST][Log] test for dpclk=%d", clockId);
        fwrite(msg, length, 1, fp);
        fclose(fp);
    }

    int SlogdCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/MDC_SLOGD_FLUSH_FUNC_UTEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }

    int32_t SlogdGetPrintNum(const char *path, const char *dir)
    {
        char cmd[200] = {0};
        sprintf(cmd, "ls -lR %s/%s/* | grep \"^-\" | wc -l", path, dir);

        int ret = SlogdCmdGetIntRet(path, cmd);
        if (ret == 1) {
            sprintf(cmd, "wc -l %s/%s/* | awk '{print $1}'", path, dir);
            ret = SlogdCmdGetIntRet(path, cmd);
        } else {
            sprintf(cmd, "wc -l %s/%s/* | grep total | awk '{print $1}'", path, dir);
            ret = SlogdCmdGetIntRet(path, cmd);
        }

        return ret;
    }
};

static void InitHead(LogHead *head, uint16_t msgLen)
{
    head->magic = HEAD_MAGIC;
    head->version = HEAD_VERSION;
    head->aosType = 0;                          // AOS_GEA
    head->processType = SYSTEM;                 // APPLICATION/SYSTEM
    head->logType = 0;                          // debug/run/security
    head->logLevel = 3;                         // debug/info/warning/error/event
    head->hostPid = 100;
    head->devicePid = 11245;
    head->deviceId = 0;
    head->moduleId = SLOG;
    head->allLength = 0;
    head->msgLength = msgLen;
    head->tagSwitch = 0; // 0:without tag; 1:with tag
    head->saveMode = 0;
}

static void WriteMsgToIam(char *mem, int32_t length, char *msg, uint32_t msgLen)
{
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    LogBufInitHead(ctrl, length, 0);
    LogHead head;
    InitHead(&head, msgLen);
    uint64_t coverCount;
    int32_t res = LogBufWrite(ctrl, msg, &head, &coverCount);

    EXPECT_EQ(length, LogIamOpsWrite(NULL, (const char *)ctrl, length, NULL));
}

TEST_F(MDC_SLOGD_LOG_COMMUNICATION_FUNC_UTEST, RecvMsgAndSaveToBuffer)
{
    // 初始化
    EXPECT_EQ(LOG_SUCCESS, SlogdCommunicationInit());

    // 模拟通过iam发送日志给slogd
    int32_t length = 1 * 1024 * 1024;
    char *memory = (char *)malloc(length);
    char msg[100] = "[ERROR] SLOG: test for slogd parse msg.\n";
    WriteMsgToIam(memory, length, msg, strlen(msg));

    // slogd接收消息并处理
    MOCKER(LogGetSigNo).stubs().will(invoke(LogGetSigNo_stub));
    MOCKER(SlogdWriteToBuffer).stubs().will(invoke(SlogdFlushToBuf_stub));
    SlogdMessageRecv(0);


    // 校验buffer内容
    const char *buffer = GetBufferStr();
    EXPECT_STREQ(msg, buffer);

    // 释放
    free(memory);
    memory = NULL;
    SlogdCommunicationExit();
}