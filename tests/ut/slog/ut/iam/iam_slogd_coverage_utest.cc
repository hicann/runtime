/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"

#include <cstring>
#include <vector>

#include "iam.h"
#include "log_common.h"
#include "log_iam_pub.h"
#include "log_level.h"
#include "log_ring_buffer.h"
#include "log_system_api.h"
#include "slogd_communication.h"
#include "slogd_collect_log.h"
#include "slogd_flush.h"
#include "securec.h"

extern "C" {
ssize_t LogIamOpsRead(struct IAMMgrFile* file, char* buf, size_t len, loff_t* pos);
ssize_t LogIamOpsWrite(struct IAMMgrFile* file, const char* buf, size_t len, loff_t* pos);
int LogIamOpsIoctl(struct IAMMgrFile* file, unsigned cmd, struct IAMIoctlArg* arg);
int LogIamOpsOpen(struct IAMMgrFile* file);
int LogIamOpsClose(struct IAMMgrFile* file);
LogStatus SlogdCheckLogLevel(LogHead msgRes);
void IamSlogdStubReset(void);
void IamSlogdStubSetLevels(int32_t globalLevel, int32_t moduleLevel, int32_t eventLevel);
void IamSlogdStubSetCollectValid(bool valid);
void IamSlogdStubSetStatus(SlogdStatus status);
int32_t IamSlogdStubGetCollectNotifyCount(void);
int32_t IamSlogdStubGetFlushCount(void);
int32_t IamSlogdStubGetFsyncCount(void);
}

class IamSlogdCoverageUtest : public testing::Test {
protected:
    void SetUp() override
    {
        IamSlogdStubReset();
    }
};

TEST_F(IamSlogdCoverageUtest, HandlesRemoteServerLifecycleAndEmptyQueue)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdRmtServerInit());

    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_OK, SlogdRmtServerCreate(0, &fileNum));
    EXPECT_EQ(1U, fileNum);

    char buffer[64] = {};
    int32_t logType = 0;
    EXPECT_EQ(SYS_INVALID_PARAM, SlogdRmtServerRecv(fileNum, buffer, sizeof(buffer), &logType));
    SlogdRmtServerClose(0, fileNum);
    SlogdRmtServerExit();
}

TEST_F(IamSlogdCoverageUtest, TransfersRingBufferMessageThroughIamQueue)
{
    constexpr uint32_t ringBufferSize = 8192U;
    std::vector<char> ringBuffer(ringBufferSize);
    auto* ctrl = reinterpret_cast<RingBufferCtrl*>(ringBuffer.data());
    ASSERT_EQ(LOG_SUCCESS, LogBufInitHead(ctrl, ringBufferSize, 0));

    const char message[] = "iam slog coverage";
    LogHead head = {};
    head.magic = HEAD_MAGIC;
    head.version = HEAD_VERSION;
    head.processType = SYSTEM;
    head.logType = DEBUG_LOG;
    head.logLevel = DLOG_ERROR;
    head.moduleId = SLOG;
    head.msgLength = sizeof(message) - 1U;
    uint64_t coveredCount = 0;
    ASSERT_GT(LogBufWrite(ctrl, message, &head, &coveredCount), 0);
    EXPECT_EQ(0U, coveredCount);

    EXPECT_EQ(ringBufferSize, LogIamOpsWrite(nullptr, ringBuffer.data(), ringBufferSize, nullptr));

    char received[LOGHEAD_LEN + MSG_LENGTH] = {};
    int32_t logType = -1;
    ASSERT_EQ(
        static_cast<int32_t>(LOGHEAD_LEN + head.msgLength),
        SlogdRmtServerRecv(1U, received, sizeof(received), &logType));
    EXPECT_EQ(DEBUG_LOG, logType);
    EXPECT_EQ(0, std::memcmp(received + LOGHEAD_LEN, message, head.msgLength));
}

TEST_F(IamSlogdCoverageUtest, HandlesIamFileOperationsAndLevelQueries)
{
    char buffer[8] = {};
    EXPECT_EQ(SYS_OK, LogIamOpsRead(nullptr, buffer, sizeof(buffer), nullptr));
    EXPECT_EQ(SYS_OK, LogIamOpsOpen(nullptr));
    EXPECT_EQ(SYS_OK, LogIamOpsClose(nullptr));
    EXPECT_EQ(SYS_OK, LogIamOpsWrite(nullptr, nullptr, 0U, nullptr));

    LogLevelConfInfo levelInfo = {};
    ASSERT_EQ(EOK, strcpy_s(levelInfo.configName, sizeof(levelInfo.configName), GLOBALLEVEL_KEY));
    IAMIoctlArg arg = {sizeof(levelInfo), &levelInfo};
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, IAM_CMD_GET_LEVEL, &arg));
    EXPECT_EQ(DLOG_DEBUG, levelInfo.configValue[0]);
    EXPECT_EQ(1, levelInfo.configValue[1]);

    std::memset(&levelInfo, 0, sizeof(levelInfo));
    ASSERT_EQ(EOK, strcpy_s(levelInfo.configName, sizeof(levelInfo.configName), IOCTL_MODULE_NAME));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, IAM_CMD_GET_LEVEL, &arg));
    EXPECT_EQ(DLOG_INFO, levelInfo.configValue[SLOG]);
}

TEST_F(IamSlogdCoverageUtest, FiltersLogsByConfiguredLevels)
{
    LogHead head = {};
    head.logLevel = DLOG_EVENT;
    EXPECT_EQ(LOG_SUCCESS, SlogdCheckLogLevel(head));
    IamSlogdStubSetLevels(DLOG_ERROR, DLOG_ERROR, 0);
    EXPECT_EQ(LOG_FAILURE, SlogdCheckLogLevel(head));

    head.logType = SECURITY_LOG;
    head.logLevel = DLOG_DEBUG;
    EXPECT_EQ(LOG_SUCCESS, SlogdCheckLogLevel(head));

    head.logType = DEBUG_LOG;
    head.moduleId = SLOG;
    head.logLevel = DLOG_WARN;
    EXPECT_EQ(LOG_FAILURE, SlogdCheckLogLevel(head));
    head.logLevel = DLOG_ERROR;
    EXPECT_EQ(LOG_SUCCESS, SlogdCheckLogLevel(head));
}

TEST_F(IamSlogdCoverageUtest, DispatchesFlushCollectAndPatternIoctls)
{
    IamSlogdStubSetStatus(SLOGD_RUNNING);
    FlushInfo flushInfo = {INVALID};
    IAMIoctlArg arg = {sizeof(flushInfo), &flushInfo};
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, IAM_CMD_FLUSH_LOG, &arg));
    EXPECT_EQ(1, IamSlogdStubGetFlushCount());
    EXPECT_EQ(static_cast<int32_t>(LOG_TYPE_NUM), IamSlogdStubGetFsyncCount());

    char path[] = "/tmp/iam-collect";
    arg.size = sizeof(path);
    arg.argData = path;
    EXPECT_EQ(SYS_ERROR, LogIamOpsIoctl(nullptr, IAM_CMD_COLLECT_LOG, &arg));
    IamSlogdStubSetCollectValid(true);
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, IAM_CMD_COLLECT_LOG, &arg));
    EXPECT_EQ(1, IamSlogdStubGetCollectNotifyCount());

    LogConfigInfo configInfo = {};
    arg.size = sizeof(configInfo);
    arg.argData = &configInfo;
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, IAM_CMD_COLLECT_LOG_PATTERN, &arg));
    EXPECT_EQ(SYS_OK, LogIamOpsIoctl(nullptr, 0xFFFFU, &arg));
}
