/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <memory>
#include <thread>
#include "mockcpp/mockcpp.hpp"

#include "acl_op.h"
#include "acl/acl_dump.h"
#include "adump_api.h"
#include "adx_dump_record.h"
#include "adump_cc_mode.h"
#include "dfx_info_parser.h"
#include "dump_core.h"
#include "dump_file.h"
#include "kernel_dfx_dumper.h"
#include "dump_manager.h"
#include "dump_printf.h"
#include "runtime/dev.h"
#include "runtime_stub.h"
#include "case_workspace.h"
#include "path.h"

using namespace Adx;

namespace {
constexpr int32_t NON_CC_MODE = 0;
constexpr int32_t NORMAL_CC_MODE = static_cast<int32_t>(HAL_CC_MODE_NORMAL);
constexpr int32_t ADDITIONAL_CC_MODE = static_cast<int32_t>(HAL_CC_MODE_ADDITIONAL);
constexpr int32_t UNKNOWN_CC_MODE = 99;
constexpr rtError_t TRANSIENT_QUERY_FAILED = 1;
} // namespace

class CcModeUtest : public testing::Test {
protected:
    void SetUp() override
    {
        ResetCcModeCacheForUt();
        SetStubCcMode(NON_CC_MODE, RT_ERROR_NONE);
    }

    void TearDown() override
    {
        ResetCcModeCacheForUt();
        SetStubCcMode(NON_CC_MODE, RT_ERROR_NONE);
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(CcModeUtest, IsCcModeReturnsTrueOnlyWhenQuerySucceedsWithNormalCcMode)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_TRUE(IsCcDumpRestricted(0));

    ResetCcModeCacheForUt();
    SetStubCcMode(ADDITIONAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    ResetCcModeCacheForUt();
    SetStubCcMode(NON_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    ResetCcModeCacheForUt();
    SetStubCcMode(NORMAL_CC_MODE, TRANSIENT_QUERY_FAILED);
    EXPECT_FALSE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeAdditionalIsKnownAndCachedAsNonRestrictedMode)
{
    SetStubCcMode(ADDITIONAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    const auto iter = GetCcModeCache().entries.find(0);
    ASSERT_NE(iter, GetCcModeCache().entries.end());
    EXPECT_EQ(iter->second.mode, ADDITIONAL_CC_MODE);
    EXPECT_FALSE(iter->second.failureLogReported);
}

TEST_F(CcModeUtest, CcModeQueryResultIsCachedPerDevice)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_TRUE(IsCcDumpRestricted(0));

    SetStubCcMode(NON_CC_MODE, RT_ERROR_NONE);
    EXPECT_TRUE(IsCcDumpRestricted(0));

    ResetCcModeCacheForUt();
    EXPECT_FALSE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeFeatureNotSupportFailureIsCachedAsNonCcMode)
{
    SetStubCcMode(NORMAL_CC_MODE, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeInvalidDeviceIdFailureIsCachedAsNonCcMode)
{
    SetStubCcMode(NORMAL_CC_MODE, ACL_ERROR_RT_INVALID_DEVICEID);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeTransientQueryFailureIsNotCached)
{
    SetStubCcMode(NORMAL_CC_MODE, TRANSIENT_QUERY_FAILED);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_TRUE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeUnknownQueryResultIsCachedAsNonCcMode)
{
    SetStubCcMode(UNKNOWN_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));

    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));
}

TEST_F(CcModeUtest, CcModeConcurrentQueriesUseSingleCacheEntry)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    bool firstResult = false;
    bool secondResult = false;
    std::thread firstThread([&firstResult]() { firstResult = IsCcDumpRestricted(0); });
    std::thread secondThread([&secondResult]() { secondResult = IsCcDumpRestricted(0); });
    firstThread.join();
    secondThread.join();

    EXPECT_TRUE(firstResult);
    EXPECT_TRUE(secondResult);
    EXPECT_EQ(GetCcModeCache().entries.size(), 1U);
}

TEST_F(CcModeUtest, CcModeSilentlySkipsDataOutputEntryPoints)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).expects(never());

    DumpCfg dumpCfg{};
    EXPECT_EQ(DumpManager::Instance().DumpOperatorV2("", "", {}, nullptr), ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().DumpOperatorWithCfg("", "", {}, nullptr, dumpCfg), ADUMP_SUCCESS);
    EXPECT_EQ(acldumpSaveExceptionInfo(nullptr, nullptr, nullptr, 0U), ACL_SUCCESS);
    EXPECT_EQ(AdumpSaveToFile(nullptr, 0U, nullptr, SaveType::OVERWRITE), ADUMP_SUCCESS);

    OperatorInfo operatorInfo{};
    OperatorInfoV2 operatorInfoV2{};
    DumpManager::Instance().AddExceptionOp(operatorInfo);
    DumpManager::Instance().AddExceptionOpV2(operatorInfoV2);
}

TEST_F(CcModeUtest, CcModeSkipsKernelDfxCallback)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    const uint8_t buffer[] = "kernel dfx";
    MOCKER(memcpy_s).expects(never());

    DumpKernelDfxInfoCallback(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0U, 0U, buffer, sizeof(buffer));
}

TEST_F(CcModeUtest, CcModeKernelDfxCallbackDoesNotDependOnCurrentDevice)
{
    SetStubCcModeForDevice(0, NORMAL_CC_MODE, RT_ERROR_NONE);
    const uint8_t buffer[] = "kernel dfx";
    MOCKER(rtGetDevice).expects(never());
    MOCKER(memcpy_s).expects(never());

    DumpKernelDfxInfoCallback(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0U, 0U, buffer, sizeof(buffer));
    EXPECT_EQ(GetStubCcModeQueryCount(), 1U);
}

TEST_F(CcModeUtest, CcModeAdditionalAllowsKernelDfxCallback)
{
    SetStubCcMode(ADDITIONAL_CC_MODE, RT_ERROR_NONE);
    const uint8_t buffer[] = "kernel dfx";
    MOCKER(&KernelDfxDumper::DumpKernelDfxInfo).expects(once()).will(returnValue(ADUMP_SUCCESS));

    DumpKernelDfxInfoCallback(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0U, 0U, buffer, sizeof(buffer));
}

TEST_F(CcModeUtest, CcModeExceptionEntrySkipsDumpAndFailOpenKeepsValidation)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    rtExceptionInfo exception{};
    exception.deviceid = 0U;
    EXPECT_EQ(DumpManager::Instance().DumpExceptionInfo(exception), ADUMP_SUCCESS);

    ResetCcModeCacheForUt();
    SetStubCcMode(NORMAL_CC_MODE, TRANSIENT_QUERY_FAILED);
    EXPECT_EQ(DumpManager::Instance().DumpExceptionInfo(exception), ADUMP_FAILED);
}

TEST_F(CcModeUtest, CcModeConsumesKernelDfxDataWithoutParsingOrPrinting)
{
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    MOCKER(rtMemcpy).expects(never());

    rtDfxParseParam param{};
    param.coreType = 2U; // SIMT
    param.readIdx = 3U;
    param.writeIdx = 13U;
    param.deviceId = 0U;
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 10U);

    AdxPrintWorkSpace(nullptr, 1U, nullptr, nullptr, true);
    rtExceptionInfo exception{};
    AdxAssertCallBack(&exception);

    param.coreType = 0U; // AIC
    consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 1U);
}

TEST_F(CcModeUtest, CcModeAssertCallbackKeepsTimeoutControlFlowAndSkipsDataRead)
{
    ResetCcModeCacheForUt();
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    MOCKER(rtMemcpy).expects(never());

    rtExceptionInfo exception{};
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = Adx::g_chunk;
    Adx::g_chunk[0] = 0U;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = 0U;

    MOCKER(rtGetOpExecuteTimeoutV2).expects(exactly(1)).will(returnValue(RT_ERROR_NONE));
    AdxAssertCallBack(&exception);
    GlobalMockObject::verify();
}

TEST_F(CcModeUtest, CcModeAssertCallbackChecksCcBeforeFastRecovery)
{
    ResetCcModeCacheForUt();
    SetStubCcMode(NORMAL_CC_MODE, RT_ERROR_NONE);
    rtExceptionInfo exception{};
    exception.deviceid = 0U;
    EXPECT_EQ(rtSetOpExecuteTimeOutWithMs(100U), RT_ERROR_NONE);
    AdxAssertCallBack(&exception);
    EXPECT_EQ(GetStubCcModeQueryCount(), 1U);
    EXPECT_EQ(rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U), RT_ERROR_NONE);
}

TEST_F(CcModeUtest, CcModeAssertCallbackFastRecoveryStillSkipsDataRead)
{
    SetStubCcMode(NON_CC_MODE, RT_ERROR_NONE);
    MOCKER(rtMemcpy).expects(never());

    rtExceptionInfo exception{};
    exception.deviceid = 0U;
    EXPECT_EQ(rtSetOpExecuteTimeOutWithMs(100U), RT_ERROR_NONE);
    AdxAssertCallBack(&exception);
    EXPECT_EQ(rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U), RT_ERROR_NONE);
}

TEST_F(CcModeUtest, CcModeSkipsKernelDfxDataCopyInMultiDeviceScenario)
{
    constexpr int32_t ccDeviceId = 1;
    ResetCcModeCacheForUt();
    SetStubCcModeForDevice(ccDeviceId, NORMAL_CC_MODE, RT_ERROR_NONE);
    MOCKER(memcpy_s).expects(never());

    rtDfxParseParam param{};
    param.coreType = 0U;
    param.coreId = 0U;
    param.deviceId = static_cast<uint32_t>(ccDeviceId);
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 1U);
}

TEST_F(CcModeUtest, QueryFailureKeepsOriginalValidationBehavior)
{
    ResetCcModeCacheForUt();
    SetStubCcMode(NORMAL_CC_MODE, TRANSIENT_QUERY_FAILED);

    EXPECT_FALSE(IsCurrentDeviceCcDumpRestricted());
}

TEST_F(CcModeUtest, CcModeQuerySupportsExplicitDeviceId)
{
    constexpr int32_t ccDeviceId = 1;
    ResetCcModeCacheForUt();
    SetStubCcModeForDevice(ccDeviceId, NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_FALSE(IsCcDumpRestricted(0));
    EXPECT_TRUE(IsCcDumpRestricted(ccDeviceId));
}

TEST_F(CcModeUtest, CcModeQuerySupportsDeviceIdWithoutFixedUpperLimit)
{
    constexpr int32_t deviceId = 128;
    ResetCcModeCacheForUt();
    SetStubCcModeForDevice(deviceId, NORMAL_CC_MODE, RT_ERROR_NONE);
    EXPECT_TRUE(IsCcDumpRestricted(deviceId));
    EXPECT_FALSE(IsCcDumpRestricted(-1));
}
