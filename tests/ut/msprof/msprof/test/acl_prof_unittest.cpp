/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <array>
#include <atomic>
#include <limits>
#include <string>
#include <vector>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "acl/acl_prof.h"
#include "acl_prof_test_state.h"
#include "ai_drv_dev_api.h"
#include "data_struct.h"
#include "errno/error_code.h"
#include "msprof_tx_manager.h"
#include "msproftx_adaptor.h"
#include "osal.h"

namespace {
using Analysis::Dvvp::Analyze::ProfOpDesc;
using analysis::dvvp::common::error::PROFILING_FAILED;
using analysis::dvvp::common::error::PROFILING_SUCCESS;
using Msprof::MsprofTx::MsprofTxManager;

class ACL_PROF_OP_API_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        savedAttribute_ = Analysis::Dvvp::Analyze::g_aclprofSubscribeOpAttriValue;
        MOCKER(analysis::dvvp::driver::DrvCheckIfHelperHost).stubs().will(returnValue(false));
    }

    void TearDown() override
    {
        Analysis::Dvvp::Analyze::g_aclprofSubscribeOpAttriValue = savedAttribute_;
        GlobalMockObject::verify();
    }

private:
    std::string savedAttribute_;
};

TEST_F(ACL_PROF_OP_API_UTEST, GetOpFlagReadsRequestedRecord)
{
    ProfOpDesc records[3] = {};
    records[0].flag = ACL_SUBSCRIBE_OP;
    records[1].flag = ACL_SUBSCRIBE_SUBGRAPH;
    records[2].flag = ACL_SUBSCRIBE_OP_THREAD;

    EXPECT_EQ(ACL_SUBSCRIBE_OP, aclprofGetOpFlag(records, sizeof(records), 0));
    EXPECT_EQ(ACL_SUBSCRIBE_SUBGRAPH, aclprofGetOpFlag(records, sizeof(records), 1));
    EXPECT_EQ(ACL_SUBSCRIBE_OP_THREAD, aclprofGetOpFlag(records, sizeof(records), 2));
}

TEST_F(ACL_PROF_OP_API_UTEST, GetOpFlagRejectsNullData)
{
    EXPECT_EQ(ACL_SUBSCRIBE_NONE, aclprofGetOpFlag(nullptr, sizeof(ProfOpDesc), 0));
}

TEST_F(ACL_PROF_OP_API_UTEST, GetOpAttributeConvertsThreadIdFromRequestedRecord)
{
    ProfOpDesc records[3] = {};
    records[0].flag = ACL_SUBSCRIBE_OP_THREAD;
    records[1].flag = ACL_SUBSCRIBE_OP_THREAD;
    records[2].flag = ACL_SUBSCRIBE_OP_THREAD;
    records[1].threadId = 42;
    records[2].threadId = std::numeric_limits<uint32_t>::max();

    EXPECT_STREQ("0", aclprofGetOpAttriValue(records, sizeof(records), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
    EXPECT_STREQ("42", aclprofGetOpAttriValue(records, sizeof(records), 1, ACL_SUBSCRIBE_ATTRI_THREADID));
    EXPECT_STREQ("4294967295", aclprofGetOpAttriValue(records, sizeof(records), 2, ACL_SUBSCRIBE_ATTRI_THREADID));
}

TEST_F(ACL_PROF_OP_API_UTEST, GetOpAttributeRejectsNullData)
{
    EXPECT_EQ(nullptr, aclprofGetOpAttriValue(nullptr, sizeof(ProfOpDesc), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
}

struct InvalidOpBuffer {
    size_t length;
    uint32_t index;
};

class ACL_PROF_FLAG_BUFFER_UTEST : public ACL_PROF_OP_API_UTEST, public testing::WithParamInterface<InvalidOpBuffer> {};

TEST_P(ACL_PROF_FLAG_BUFFER_UTEST, ReturnsNoneForIncompleteOrOutOfRangeRecord)
{
    ProfOpDesc records[2] = {};
    records[0].flag = ACL_SUBSCRIBE_OP_THREAD;
    records[1].flag = ACL_SUBSCRIBE_OP_THREAD;

    // The public API specifies ACL_SUBSCRIBE_NONE on failure, including an invalid record range.
    EXPECT_EQ(ACL_SUBSCRIBE_NONE, aclprofGetOpFlag(records, GetParam().length, GetParam().index));
}

INSTANTIATE_TEST_SUITE_P(
    InvalidBuffers, ACL_PROF_FLAG_BUFFER_UTEST,
    testing::Values(
        InvalidOpBuffer{0, 0}, InvalidOpBuffer{sizeof(ProfOpDesc) - 1, 0},
        InvalidOpBuffer{sizeof(ProfOpDesc) * 2 - 1, 1}, InvalidOpBuffer{sizeof(ProfOpDesc) * 2, 2},
        InvalidOpBuffer{sizeof(ProfOpDesc) * 2, std::numeric_limits<uint32_t>::max()}));

class ACL_PROF_ATTR_BUFFER_UTEST : public ACL_PROF_OP_API_UTEST, public testing::WithParamInterface<InvalidOpBuffer> {};

TEST_P(ACL_PROF_ATTR_BUFFER_UTEST, RejectsIncompleteOrOutOfRangeRecord)
{
    ProfOpDesc records[2] = {};
    records[0].flag = ACL_SUBSCRIBE_OP_THREAD;
    records[1].flag = ACL_SUBSCRIBE_OP_THREAD;

    EXPECT_EQ(
        nullptr, aclprofGetOpAttriValue(records, GetParam().length, GetParam().index, ACL_SUBSCRIBE_ATTRI_THREADID));
}

INSTANTIATE_TEST_SUITE_P(
    InvalidBuffers, ACL_PROF_ATTR_BUFFER_UTEST,
    testing::Values(
        InvalidOpBuffer{0, 0}, InvalidOpBuffer{sizeof(ProfOpDesc) - 1, 0},
        InvalidOpBuffer{sizeof(ProfOpDesc) * 2 - 1, 1}, InvalidOpBuffer{sizeof(ProfOpDesc) * 2, 2},
        InvalidOpBuffer{sizeof(ProfOpDesc) * 2, std::numeric_limits<uint32_t>::max()}));

class ACL_PROF_ATTR_FLAG_UTEST : public ACL_PROF_OP_API_UTEST,
                                 public testing::WithParamInterface<aclprofSubscribeOpFlag> {};

TEST_P(ACL_PROF_ATTR_FLAG_UTEST, RejectsThreadAttributeForOtherRecordTypes)
{
    ProfOpDesc record = {};
    record.flag = GetParam();
    record.threadId = 42;

    EXPECT_EQ(nullptr, aclprofGetOpAttriValue(&record, sizeof(record), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
}

INSTANTIATE_TEST_SUITE_P(
    OtherFlags, ACL_PROF_ATTR_FLAG_UTEST,
    testing::Values(ACL_SUBSCRIBE_OP, ACL_SUBSCRIBE_SUBGRAPH, ACL_SUBSCRIBE_NONE));

TEST_F(ACL_PROF_OP_API_UTEST, GetOpAttributeRejectsUnsupportedAttribute)
{
    ProfOpDesc record = {};
    record.flag = ACL_SUBSCRIBE_OP_THREAD;

    EXPECT_EQ(nullptr, aclprofGetOpAttriValue(&record, sizeof(record), 0, ACL_SUBSCRIBE_ATTRI_NONE));
}

struct RuntimeMark {
    uint64_t markId;
    uint64_t modelId;
    uint16_t tagId;
    void* stream;
};

struct MarkExCapture {
    std::vector<RuntimeMark> runtimeMarks;
    std::vector<MsprofTxInfo> reports;
    int32_t runtimeResult = PROFILING_SUCCESS;
    int32_t reportResult = PROFILING_SUCCESS;
};

MarkExCapture* g_markExCapture = nullptr;

int32_t CaptureRuntimeMark(uint64_t markId, uint64_t modelId, uint16_t tagId, void* stream)
{
    g_markExCapture->runtimeMarks.push_back({markId, modelId, tagId, stream});
    return g_markExCapture->runtimeResult;
}

int32_t CaptureMarkExReport(uint32_t aging, void* data, uint32_t length)
{
    EXPECT_EQ(1U, aging);
    EXPECT_EQ(sizeof(MsprofAdditionalInfo), length);
    EXPECT_NE(nullptr, data);
    if (data == nullptr || length != sizeof(MsprofAdditionalInfo)) {
        return PROFILING_FAILED;
    }
    const auto* report = static_cast<const MsprofAdditionalInfo*>(data);
    EXPECT_EQ(MSPROF_REPORT_TX_LEVEL, report->level);
    EXPECT_EQ(MSPROF_REPORT_TX_BASE_TYPE, report->type);
    EXPECT_EQ(sizeof(MsprofTxInfo), report->dataLen);
    MsprofTxInfo txInfo = {};
    const errno_t ret = memcpy_s(&txInfo, sizeof(txInfo), report->data, sizeof(txInfo));
    EXPECT_EQ(EOK, ret);
    if (ret != EOK) {
        return PROFILING_FAILED;
    }
    g_markExCapture->reports.push_back(txInfo);
    return g_markExCapture->reportResult;
}

class ACL_PROF_MARK_EX_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        // Only redirect singleton lookup: the manager and its lifecycle, validation and reporting remain real.
        // The production singleton is zero initialized; a fixture object needs explicit atomic initialization.
        std::atomic_init(&manager_.txEventId_, uint64_t{0});
        MOCKER(MsprofTxManager::instance).stubs().will(returnValue(&manager_));
        MOCKER(analysis::dvvp::driver::DrvCheckIfHelperHost).stubs().will(returnValue(false));
        previousCapture_ = g_markExCapture;
        g_markExCapture = &capture_;
        // The stamp pool has no global reset API. Preserve the prior pool while Init creates this fixture's pool.
        savedStampPool_ = Msprof::MsprofTx::g_stampPoolHandle;
        std::copy_n(Msprof::MsprofTx::g_stampInstanceAddr, savedStampInstances_.size(), savedStampInstances_.begin());
        Msprof::MsprofTx::g_stampPoolHandle = nullptr;
        std::fill_n(Msprof::MsprofTx::g_stampInstanceAddr, savedStampInstances_.size(), nullptr);
        ProfImplSetAdditionalBufPush(CaptureMarkExReport);
        ProfImplSetMarkEx(CaptureRuntimeMark);
    }

    void TearDown() override
    {
        manager_.UnInit();
        EXPECT_EQ(nullptr, Msprof::MsprofTx::g_stampPoolHandle);
        Msprof::MsprofTx::g_stampPoolHandle = savedStampPool_;
        std::copy(savedStampInstances_.begin(), savedStampInstances_.end(), Msprof::MsprofTx::g_stampInstanceAddr);
        g_markExCapture = previousCapture_;
        GlobalMockObject::verify();
    }

    void ExpectMark(const std::string& message, size_t index = 0)
    {
        ASSERT_GT(capture_.runtimeMarks.size(), index);
        ASSERT_GT(capture_.reports.size(), index);
        const RuntimeMark& runtimeMark = capture_.runtimeMarks[index];
        const MsprofTxInfo& report = capture_.reports[index];
        EXPECT_EQ(&streamToken_, runtimeMark.stream);
        EXPECT_EQ(std::numeric_limits<uint32_t>::max(), runtimeMark.modelId);
        EXPECT_EQ(11U, runtimeMark.tagId);
        EXPECT_EQ(1U, report.infoType);
        EXPECT_EQ(static_cast<uint32_t>(Msprof::MsprofTx::EventType::MARK_EX), report.value.stampInfo.eventType);
        EXPECT_EQ(static_cast<uint32_t>(OsalGetPid()), report.value.stampInfo.processId);
        EXPECT_EQ(static_cast<uint32_t>(OsalGetTid()), report.value.stampInfo.threadId);
        EXPECT_EQ(runtimeMark.markId, report.value.stampInfo.markId);
        EXPECT_EQ(report.value.stampInfo.startTime, report.value.stampInfo.endTime);
        EXPECT_GT(report.value.stampInfo.startTime, 0U);
        EXPECT_STREQ(message.c_str(), report.value.stampInfo.message);
    }

    MsprofTxManager manager_;
    MarkExCapture capture_;
    uint32_t streamToken_ = 0;

private:
    MarkExCapture* previousCapture_ = nullptr;
    Msprof::MsprofTx::MsprofStampCtrlHandle* savedStampPool_ = nullptr;
    std::array<Msprof::MsprofTx::MsprofStampInstance*, Msprof::MsprofTx::CURRENT_STAMP_SIZE> savedStampInstances_{};
};

TEST_F(ACL_PROF_MARK_EX_UTEST, RejectsBeforeInitializationWithoutCallingDependencies)
{
    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx("mark", 4, &streamToken_));
    EXPECT_TRUE(capture_.runtimeMarks.empty());
    EXPECT_TRUE(capture_.reports.empty());
}

enum class InvalidMarkInput { NULL_MESSAGE, NULL_STREAM, MISMATCHED_LENGTH, EMPTY_MESSAGE, OVERSIZED_MESSAGE };

class ACL_PROF_MARK_EX_INPUT_UTEST : public ACL_PROF_MARK_EX_UTEST,
                                     public testing::WithParamInterface<InvalidMarkInput> {};

TEST_P(ACL_PROF_MARK_EX_INPUT_UTEST, RejectsInvalidInputWithoutCallingDependencies)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    std::string message = "mark";
    if (GetParam() == InvalidMarkInput::EMPTY_MESSAGE) {
        message.clear();
    } else if (GetParam() == InvalidMarkInput::OVERSIZED_MESSAGE) {
        message.assign(MAX_MESSAGE_LEN, 'm');
    }
    const char* data = GetParam() == InvalidMarkInput::NULL_MESSAGE ? nullptr : message.c_str();
    void* stream = GetParam() == InvalidMarkInput::NULL_STREAM ? nullptr : &streamToken_;
    const size_t length = GetParam() == InvalidMarkInput::MISMATCHED_LENGTH ? message.size() - 1 : message.size();

    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx(data, length, stream));
    EXPECT_TRUE(capture_.runtimeMarks.empty());
    EXPECT_TRUE(capture_.reports.empty());
}

INSTANTIATE_TEST_SUITE_P(
    InvalidInputs, ACL_PROF_MARK_EX_INPUT_UTEST,
    testing::Values(
        InvalidMarkInput::NULL_MESSAGE, InvalidMarkInput::NULL_STREAM, InvalidMarkInput::MISMATCHED_LENGTH,
        InvalidMarkInput::EMPTY_MESSAGE, InvalidMarkInput::OVERSIZED_MESSAGE));

class ACL_PROF_MARK_EX_LENGTH_UTEST : public ACL_PROF_MARK_EX_UTEST, public testing::WithParamInterface<size_t> {};

TEST_P(ACL_PROF_MARK_EX_LENGTH_UTEST, ReportsCompleteMessageAtSupportedLengths)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    const std::string message(GetParam(), 'm');

    EXPECT_EQ(ACL_SUCCESS, aclprofMarkEx(message.c_str(), message.size(), &streamToken_));
    EXPECT_EQ(1U, capture_.runtimeMarks.size());
    EXPECT_EQ(1U, capture_.reports.size());
    ExpectMark(message);
}

INSTANTIATE_TEST_SUITE_P(
    MessageLengths, ACL_PROF_MARK_EX_LENGTH_UTEST,
    testing::Values(size_t{1}, size_t{128}, size_t{MAX_MESSAGE_LEN - 1}));

TEST_F(ACL_PROF_MARK_EX_UTEST, RejectsMissingRuntimeCallbackWithoutReporting)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    ProfImplSetMarkEx(nullptr);

    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx("mark", 4, &streamToken_));
    EXPECT_TRUE(capture_.runtimeMarks.empty());
    EXPECT_TRUE(capture_.reports.empty());
}

TEST_F(ACL_PROF_MARK_EX_UTEST, StopsReportingWhenRuntimeTraceFails)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    capture_.runtimeResult = PROFILING_FAILED;

    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx("mark", 4, &streamToken_));
    ASSERT_EQ(1U, capture_.runtimeMarks.size());
    EXPECT_EQ(&streamToken_, capture_.runtimeMarks[0].stream);
    EXPECT_EQ(std::numeric_limits<uint32_t>::max(), capture_.runtimeMarks[0].modelId);
    EXPECT_EQ(11U, capture_.runtimeMarks[0].tagId);
    EXPECT_TRUE(capture_.reports.empty());
}

TEST_F(ACL_PROF_MARK_EX_UTEST, PropagatesReporterFailureAfterTracing)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    capture_.reportResult = PROFILING_FAILED;

    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx("mark", 4, &streamToken_));
    EXPECT_EQ(1U, capture_.runtimeMarks.size());
    EXPECT_EQ(1U, capture_.reports.size());
    ExpectMark("mark");
}

TEST_F(ACL_PROF_MARK_EX_UTEST, ReportsDistinctIdsAndMessagesForRepeatedMarks)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());

    EXPECT_EQ(ACL_SUCCESS, aclprofMarkEx("first", 5, &streamToken_));
    EXPECT_EQ(ACL_SUCCESS, aclprofMarkEx("second", 6, &streamToken_));
    ASSERT_EQ(2U, capture_.runtimeMarks.size());
    EXPECT_EQ(2U, capture_.reports.size());
    ExpectMark("first", 0);
    ExpectMark("second", 1);
    EXPECT_NE(capture_.runtimeMarks[0].markId, capture_.runtimeMarks[1].markId);
}

TEST_F(ACL_PROF_MARK_EX_UTEST, RejectsAfterUninitializationWithoutCallingDependencies)
{
    ASSERT_EQ(PROFILING_SUCCESS, manager_.Init());
    manager_.UnInit();

    EXPECT_EQ(PROFILING_FAILED, aclprofMarkEx("mark", 4, &streamToken_));
    EXPECT_TRUE(capture_.runtimeMarks.empty());
    EXPECT_TRUE(capture_.reports.empty());
}
} // namespace
