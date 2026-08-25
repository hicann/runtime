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

#include <string>
#include <vector>

extern "C" {
#include "acl_log.h"
#include "log_common.h"
#include "plog_callback.h"
}

namespace {
constexpr int32_t ACLLOG_SUCCESS = 0;
constexpr int32_t ACLLOG_FAILURE = -1;

struct CallbackRecord {
    uint32_t outputLogType;
    std::string content;
};

struct CallbackContext {
    int32_t id;
    std::vector<int32_t>* order;
    std::vector<CallbackRecord>* records;
};

int32_t RecordCallback(void* userData, uint32_t outputLogType, const char* logContent, size_t length)
{
    auto* ctx = static_cast<CallbackContext*>(userData);
    ctx->order->push_back(ctx->id);
    ctx->records->push_back({outputLogType, std::string(logContent, length)});
    return ACLLOG_SUCCESS;
}

int32_t FailedCallback(void* userData, uint32_t outputLogType, const char* logContent, size_t length)
{
    (void)userData;
    (void)outputLogType;
    (void)logContent;
    (void)length;
    return ACLLOG_FAILURE;
}
} // namespace

class PlogCallbackUtest : public testing::Test {};

TEST_F(PlogCallbackUtest, RegisterParamInvalid)
{
    acllogCallbackHandle handle = 0U;
    EXPECT_EQ(
        ACLLOG_FAILURE, PlogRegisterCallbackInner(nullptr, nullptr, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle));
    EXPECT_EQ(
        ACLLOG_FAILURE,
        PlogRegisterCallbackInner(RecordCallback, nullptr, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), nullptr));
    EXPECT_EQ(
        ACLLOG_FAILURE,
        PlogRegisterCallbackInner(RecordCallback, nullptr, static_cast<uint32_t>(OUTPUT_TYPE_MAX), &handle));
}

TEST_F(PlogCallbackUtest, MultiCallbacksDispatchByRegisterOrder)
{
    std::vector<int32_t> order;
    std::vector<CallbackRecord> records;
    CallbackContext ctx1 = {1, &order, &records};
    CallbackContext ctx2 = {2, &order, &records};
    acllogCallbackHandle handle1 = 0U;
    acllogCallbackHandle handle2 = 0U;

    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &ctx1, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle1));
    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &ctx2, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle2));

    const char log[] = "debug log";
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(DEBUG_LOG), log, sizeof(log) - 1U);

    EXPECT_EQ((std::vector<int32_t>{1, 2}), order);
    ASSERT_EQ(2U, records.size());
    EXPECT_EQ(static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), records[0].outputLogType);
    EXPECT_EQ("debug log", records[0].content);

    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(handle1));
    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(handle2));
}

TEST_F(PlogCallbackUtest, RegisterMoreThanSixteenFailed)
{
    std::vector<int32_t> order;
    std::vector<CallbackRecord> records;
    CallbackContext ctx = {1, &order, &records};
    std::vector<acllogCallbackHandle> handles;
    constexpr size_t maxCallbackNum = 16U;

    for (size_t i = 0U; i < maxCallbackNum; ++i) {
        acllogCallbackHandle handle = 0U;
        EXPECT_EQ(
            ACLLOG_SUCCESS,
            PlogRegisterCallbackInner(RecordCallback, &ctx, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle));
        EXPECT_NE(0U, handle);
        handles.push_back(handle);
    }

    acllogCallbackHandle overflowHandle = 0U;
    EXPECT_EQ(
        ACLLOG_FAILURE,
        PlogRegisterCallbackInner(RecordCallback, &ctx, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &overflowHandle));
    EXPECT_EQ(0U, overflowHandle);

    for (const auto handle : handles) {
        EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(handle));
    }
}

TEST_F(PlogCallbackUtest, DispatchFiltersOutputType)
{
    std::vector<int32_t> order;
    std::vector<CallbackRecord> records;
    CallbackContext debugCtx = {1, &order, &records};
    CallbackContext runCtx = {2, &order, &records};
    CallbackContext bothCtx = {3, &order, &records};
    acllogCallbackHandle debugHandle = 0U;
    acllogCallbackHandle runHandle = 0U;
    acllogCallbackHandle bothHandle = 0U;

    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &debugCtx, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &debugHandle));
    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &runCtx, static_cast<uint32_t>(OUTPUT_TYPE_RUN), &runHandle));
    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &bothCtx, static_cast<uint32_t>(OUTPUT_TYPE_BOTH), &bothHandle));

    const char debugLog[] = "debug";
    const char runLog[] = "run";
    const char securityLog[] = "security";
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(DEBUG_LOG), debugLog, sizeof(debugLog) - 1U);
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(RUN_LOG), runLog, sizeof(runLog) - 1U);
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(SECURITY_LOG), securityLog, sizeof(securityLog) - 1U);

    EXPECT_EQ((std::vector<int32_t>{1, 3, 2, 3}), order);
    ASSERT_EQ(4U, records.size());
    EXPECT_EQ(static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), records[0].outputLogType);
    EXPECT_EQ(static_cast<uint32_t>(OUTPUT_TYPE_RUN), records[2].outputLogType);

    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(debugHandle));
    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(runHandle));
    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(bothHandle));
}

TEST_F(PlogCallbackUtest, UnregisterRemovesOnlyTargetHandle)
{
    std::vector<int32_t> order;
    std::vector<CallbackRecord> records;
    CallbackContext ctx1 = {1, &order, &records};
    CallbackContext ctx2 = {2, &order, &records};
    acllogCallbackHandle handle1 = 0U;
    acllogCallbackHandle handle2 = 0U;

    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &ctx1, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle1));
    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &ctx2, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &handle2));
    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(handle1));
    EXPECT_EQ(ACLLOG_FAILURE, PlogUnregisterCallbackInner(handle1));

    const char log[] = "debug log";
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(DEBUG_LOG), log, sizeof(log) - 1U);
    EXPECT_EQ((std::vector<int32_t>{2}), order);

    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(handle2));
}

TEST_F(PlogCallbackUtest, FailedCallbackDoesNotStopDispatch)
{
    std::vector<int32_t> order;
    std::vector<CallbackRecord> records;
    CallbackContext ctx = {1, &order, &records};
    acllogCallbackHandle failedHandle = 0U;
    acllogCallbackHandle recordHandle = 0U;

    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(FailedCallback, nullptr, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &failedHandle));
    EXPECT_EQ(
        ACLLOG_SUCCESS,
        PlogRegisterCallbackInner(RecordCallback, &ctx, static_cast<uint32_t>(OUTPUT_TYPE_DEBUG), &recordHandle));

    const char log[] = "debug log";
    PlogDispatchDeviceLogCallback(static_cast<int32_t>(DEBUG_LOG), log, sizeof(log) - 1U);

    EXPECT_EQ((std::vector<int32_t>{1}), order);
    ASSERT_EQ(1U, records.size());
    EXPECT_EQ("debug log", records[0].content);

    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(failedHandle));
    EXPECT_EQ(ACLLOG_SUCCESS, PlogUnregisterCallbackInner(recordHandle));
}
