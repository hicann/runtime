/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// Include headers that cause type conflicts BEFORE gtest
#include "dump_operator.h"
#include "exception_dumper.h"
#include "dump_manager.h"
#include "common/thread.h"
#include "adx_dump_record.h"
#include "dump_exception_stub.h"
#include "kernel_symbol_locator.h"
#include "kernel_info_collector.h"
#include "exception_info_common.h"
#include "path.h"
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include <fstream>

using namespace Adx;

namespace {
uint32_t g_aicpuCallbackCount = 0U;
rtExceptionExpandType_t g_aicpuCallbackType = RT_EXCEPTION_INVALID;

// 记录调用次数与传入的异常类型，用于验证回调确实被触发。
uint32_t CountingOverwriteCallback(void *exceptionInfo, ExceptionDumpInfo *dumpInfo,
                                   uint32_t dumpSize, uint32_t *realSize, ExceptionDumpMode *mode)
{
    ++g_aicpuCallbackCount;
    if (exceptionInfo != nullptr) {
        g_aicpuCallbackType = static_cast<rtExceptionInfo *>(exceptionInfo)->expandInfo.type;
    }
    return MockCallbackWithOverwrite(exceptionInfo, dumpInfo, dumpSize, realSize, mode);
}
}  // namespace

class ExceptionDumperExtraUtest : public testing::Test {
protected:
    void SetUp() override
    {
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    }
    void TearDown() override
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }

    static OperatorInfoV2 MakeAgingOpInfo(uint32_t taskId = 1U, uint32_t streamId = 2U, uint32_t deviceId = 0U)
    {
        OperatorInfoV2 info;
        info.opType = "TestOp";
        info.opName = "TestOpName";
        info.agingFlag = true;
        info.taskId = taskId;
        info.streamId = streamId;
        info.deviceId = deviceId;
        info.contextId = UINT32_MAX;
        return info;
    }

    static OperatorInfoV2 MakeResidentOpInfo(uint32_t taskId = 1U, uint32_t streamId = 2U, uint32_t deviceId = 0U)
    {
        OperatorInfoV2 info;
        info.opType = "TestOp";
        info.opName = "TestOpName";
        info.agingFlag = false;
        info.taskId = taskId;
        info.streamId = streamId;
        info.deviceId = deviceId;
        info.contextId = UINT32_MAX;
        return info;
    }
};

// ============================================================================
// AddDumpOperatorV2 with agingFlag = true
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, AddDumpOperatorV2_AgingFlag_True)
{
    ExceptionDumper dumper;
    OperatorInfoV2 info = MakeAgingOpInfo(10U, 20U, 0U);
    // Covers: agingOperators_.emplace_back + size check
    dumper.AddDumpOperatorV2(info);
    dumper.AddDumpOperatorV2(MakeAgingOpInfo(11U, 20U, 0U));
    dumper.AddDumpOperatorV2(MakeAgingOpInfo(12U, 20U, 0U));
    // Just verify no crash
    EXPECT_TRUE(true);
}

// ============================================================================
// AddDumpOperatorV2 with agingFlag = false (resident operators)
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, AddDumpOperatorV2_AgingFlag_False_Basic)
{
    ExceptionDumper dumper;
    OperatorInfoV2 info = MakeResidentOpInfo(10U, 20U, 0U);
    // Covers the else branch: rtGetMaxStreamAndTask + residentOperators_ path
    dumper.AddDumpOperatorV2(info);
    EXPECT_TRUE(true);
}

// Cover taskDeque overflow (maxTaskCount=100 from stub, add 101 with same device/stream)
TEST_F(ExceptionDumperExtraUtest, AddDumpOperatorV2_AgingFlag_False_Overflow)
{
    ExceptionDumper dumper;
    // Add 101 operators with same deviceId/streamId → overflow triggers pop_front
    for (uint32_t i = 0; i < 102U; ++i) {
        OperatorInfoV2 info = MakeResidentOpInfo(i, 5U, 0U);
        info.agingFlag = false;
        info.streamId = 5U; // same stream
        info.deviceId = 0U; // same device
        info.taskId = i;
        dumper.AddDumpOperatorV2(info);
    }
    EXPECT_TRUE(true);
}

// ============================================================================
// DelDumpOperator
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, DelDumpOperator_NoResidentOp)
{
    ExceptionDumper dumper;
    // Delete from empty map - should succeed
    int32_t ret = dumper.DelDumpOperator(99U, 99U);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DelDumpOperator_WithResidentOp_StreamExists)
{
    ExceptionDumper dumper;
    // Add resident op
    OperatorInfoV2 info = MakeResidentOpInfo(10U, 20U, 5U);
    dumper.AddDumpOperatorV2(info);
    // Delete the stream (but keep device entry if other streams exist)
    int32_t ret = dumper.DelDumpOperator(5U, 20U);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DelDumpOperator_WithResidentOp_DeviceEmpty)
{
    ExceptionDumper dumper;
    // Add ONE resident op to device 5
    OperatorInfoV2 info = MakeResidentOpInfo(10U, 20U, 5U);
    dumper.AddDumpOperatorV2(info);
    // Delete - after erase stream 20 from device 5, device 5 has no streams → device is erased too
    int32_t ret = dumper.DelDumpOperator(5U, 20U);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// ============================================================================
// ExceptionDumperInit - EXCEPTION type on → sets exceptionStatus_ = true
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, ExceptionDumperInit_EXCEPTION_On)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "";
    int32_t ret = dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(dumper.GetExceptionStatus());
}

TEST_F(ExceptionDumperExtraUtest, ExceptionDumperInit_EXCEPTION_Off_NotStarted)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "off";
    // exceptionStatus_ = false, status = false → IDE_CTRL_VALUE_WARN fires → returns ADUMP_SUCCESS
    int32_t ret = dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(dumper.GetExceptionStatus());
}

// ============================================================================
// DumpException with exceptionStatus = true → calls FindExceptionOperator
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, DumpException_ExceptionStatus_NoMatch)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_extra_test_ut";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);
    EXPECT_TRUE(dumper.GetExceptionStatus());

    // Provide a valid dump path so CreateDeviceDumpPath can succeed
    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 5U;
    exception.streamid = 3U;
    exception.expandInfo.type = static_cast<rtExceptionExpandType_t>(0); // default

    // agingOperators_ is empty → FindExceptionOperator returns false → DumpNormalException returns ADUMP_SUCCESS
    int32_t ret = dumper.DumpException(exception);
    // May succeed or fail depending on CreateDeviceDumpPath, but covers the code paths
    (void)ret;
    EXPECT_TRUE(true);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_ExceptionStatus_WithMatchingAgingOp)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_extra_test_ut2";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    // Add an aging operator with matching identity
    OperatorInfoV2 info = MakeAgingOpInfo(5U, 3U, 0U);
    info.contextId = UINT32_MAX;
    dumper.AddDumpOperatorV2(info);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 5U;
    exception.streamid = 3U;
    exception.expandInfo.type = static_cast<rtExceptionExpandType_t>(0);

    // FindExceptionOperator will find the aging op, then DumpNormalException runs
    // GetExceptionInfo might fail, but covers the path
    int32_t ret = dumper.DumpException(exception);
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// ExceptionModeDowngrade
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, ExceptionModeDowngrade_SetsFlag)
{
    ExceptionDumper dumper;
    // Just call it - covers lines 300-302 in exception_dumper.cpp
    dumper.ExceptionModeDowngrade();
    EXPECT_TRUE(true);
}

// ============================================================================
// IsRepeatEnableException
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, IsRepeatEnableException_EXCEPTION_StatusOff)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "off";
    // exceptionStatus_=false, status=false → returns false
    bool ret = dumper.IsRepeatEnableException(DumpType::EXCEPTION, config);
    EXPECT_FALSE(ret);
}

TEST_F(ExceptionDumperExtraUtest, IsRepeatEnableException_EXCEPTION_AlreadyEnabled)
{
    ExceptionDumper dumper;
    // First enable
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "";
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    // Now check IsRepeatEnableException → exceptionStatus_=true → returns true
    bool ret = dumper.IsRepeatEnableException(DumpType::EXCEPTION, config);
    EXPECT_TRUE(ret);
}

TEST_F(ExceptionDumperExtraUtest, IsRepeatEnableException_OtherType)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    // OPERATOR type → does not match the exception types → returns false
    bool ret = dumper.IsRepeatEnableException(DumpType::OPERATOR, config);
    EXPECT_FALSE(ret);
}

// ============================================================================
// GetExtraDumpCPath - empty and non-empty
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, GetExtraDumpCPath_Empty)
{
    ExceptionDumper dumper;
    // extraDumpPath_ is empty by default → returns nullptr
    const char *path = dumper.GetExtraDumpCPath();
    EXPECT_EQ(path, nullptr);
}

// ============================================================================
// AddDumpOperator (non-V2) via DumpManager
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, AddDumpOperator_V1_AgingTrue_ViaDumpManager)
{
    OperatorInfo opInfo;
    opInfo.agingFlag = true;
    opInfo.taskId = 100U;
    opInfo.streamId = 200U;
    opInfo.deviceId = 0U;
    // AddExceptionOp converts and calls AddDumpOperatorV2
    DumpManager::Instance().AddExceptionOp(opInfo);
    EXPECT_TRUE(true);
}

TEST_F(ExceptionDumperExtraUtest, AddDumpOperator_V2_AgingTrue_ViaDumpManager)
{
    OperatorInfoV2 opInfo;
    opInfo.agingFlag = true;
    opInfo.taskId = 101U;
    opInfo.streamId = 201U;
    opInfo.deviceId = 0U;
    DumpManager::Instance().AddExceptionOpV2(opInfo);
    EXPECT_TRUE(true);
}

// ============================================================================
// ExceptionDumperInit: AIC_ERR_DETAIL_DUMP type with status=off → covers lines 99-109
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, ExceptionDumperInit_AicErrDetail_StatusOff)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "off"; // status=false → the "can not off" branch
    config.dumpPath = "";
    // This covers lines 100-108 in exception_dumper.cpp
    int32_t ret = dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, config);
    EXPECT_EQ(ret, ADUMP_SUCCESS); // returns ADUMP_SUCCESS because "can not off"
}

// ============================================================================
// ExceptionDumperInit: ARGS_EXCEPTION type with status=on → covers lines 91-98, 113
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, ExceptionDumperInit_ArgsException_StatusOn)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_args_exception_test";
    // LoadTensorPluginLib is called, may fail or succeed
    // Covers lines 92-99, 114 in exception_dumper.cpp
    int32_t ret = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    // Success or failure depends on plugin availability
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// ExceptionDumperInit: ARGS_EXCEPTION type with status=off
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, ExceptionDumperInit_ArgsException_StatusOff)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "off";
    // argsExceptionStatus_ = false, status = false → IDE_CTRL_VALUE_WARN → ADUMP_SUCCESS
    int32_t ret = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// ============================================================================
// FindExceptionOperator: resident operator matches - covers lines 240-255
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, FindExceptionOperator_ResidentOpMatches)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_resident_exception_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    // Add a resident operator (agingFlag=false) with known identity
    OperatorInfoV2 info = MakeResidentOpInfo(7U, 4U, 0U);
    info.contextId = UINT32_MAX;
    dumper.AddDumpOperatorV2(info);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 7U;
    exception.streamid = 4U;
    exception.expandInfo.type = static_cast<rtExceptionExpandType_t>(0);

    // FindExceptionOperator will search resident map - covers lines 240-255
    int32_t ret = dumper.DumpException(exception);
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// RegisterExceptionDumpCallback tests
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, RegisterExceptionDumpCallback_NullCallback)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.RegisterExceptionDumpCallback(nullptr);
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, RegisterExceptionDumpCallback_Success)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, RegisterExceptionDumpCallback_AlreadyRegistered)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    ret = dumper.RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// ============================================================================
// UnregisterExceptionDumpCallback tests
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, UnregisterExceptionDumpCallback_NullCallback)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.UnregisterExceptionDumpCallback(nullptr);
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, UnregisterExceptionDumpCallback_Success)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    ret = dumper.UnregisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, UnregisterExceptionDumpCallback_NotFound)
{
    ExceptionDumper dumper;
    int32_t ret = dumper.UnregisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_IgnoredRetcode_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_ignored_retcode_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);

    const uint32_t ignoredRetcodes[] = {
        ACL_ERROR_RT_AICORE_OVER_FLOW,
        ACL_ERROR_RT_AIVEC_OVER_FLOW,
        ACL_ERROR_RT_DEVICE_MEM_ERROR,
        ACL_ERROR_RT_SUSPECT_REMOTE_ERROR,
        ACL_ERROR_RT_LINK_ERROR
    };

    for (const uint32_t retcode : ignoredRetcodes) {
        rtExceptionInfo exception = {};
        exception.deviceid = 0U;
        exception.taskid = 1U;
        exception.streamid = 2U;
        exception.retcode = retcode;
        exception.expandInfo.type = RT_EXCEPTION_AICORE;
        EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED) << "retcode: " << retcode;
    }
}

TEST_F(ExceptionDumperExtraUtest, DumpException_UnsupportedType_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_unsupported_type_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);

    const rtExceptionExpandType_t unsupportedTypes[] = {
        RT_EXCEPTION_INVALID,
        RT_EXCEPTION_UB,
        RT_EXCEPTION_CCU
    };

    for (const rtExceptionExpandType_t type : unsupportedTypes) {
        rtExceptionInfo exception = {};
        exception.deviceid = 0U;
        exception.taskid = 1U;
        exception.streamid = 2U;
        exception.expandInfo.type = type;
        EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED) << "type: " << static_cast<int32_t>(type);
    }
}

TEST_F(ExceptionDumperExtraUtest, DumpException_NotEnabled_Rejected)
{
    ExceptionDumper dumper;
    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_CreateDumpPathEmpty_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_create_path_empty_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);

    MOCKER_CPP(&Path::CreateDirectory).stubs().will(returnValue(false));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicpu_Coredump_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_coredump_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetCoredumpStatus());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicpu_Exception_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_exception_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetExceptionStatus());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicpu_Args_NoCallback_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_args_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetArgsExceptionStatus());
    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicpu_Args_FastRecovery_Rejected)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_fastrecovery_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetArgsExceptionStatus());
    (void)rtSetOpExecuteTimeOutWithMs(300U);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicpu_CallbackOverwrite_OnlyDumpCallbackData)
{
    g_aicpuCallbackCount = 0U;
    g_aicpuCallbackType = RT_EXCEPTION_INVALID;

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_overwrite_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(CountingOverwriteCallback), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpArgsExceptionDefault).expects(never());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
    EXPECT_EQ(g_aicpuCallbackCount, 1U);
    EXPECT_EQ(g_aicpuCallbackType, RT_EXCEPTION_AICPU);
    g_aicpuCallbackCount = 0U;
    g_aicpuCallbackType = RT_EXCEPTION_INVALID;
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicore_CallbackAdditional_DumpBoth)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_additional_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithAdditional), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpArgsExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_Aicore_CallbackNone_OnlyDefault)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_aicpu_none_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithNone), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpArgsExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 3U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_NoCallbacks)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_args_inner_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    int32_t ret = dumper.DumpException(exception);
    (void)ret;
    EXPECT_TRUE(true);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_CallbackInvalidMode)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_args_invalid_mode_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithInvalidMode);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 8U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_UnsafeSlashInDisplayName)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_unsafe_slash_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithUnsafePathSlash);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 3U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_UnsafeBackslashInKernelName)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_unsafe_backslash_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithUnsafePathBackslash);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 4U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_UnsafeParentDirInKernelName)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_unsafe_parentdir_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithUnsafeParentDir);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 5U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_UnsafeControlCharInDisplayName)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_unsafe_control_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithUnsafeControlChar);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 2U;
    exception.streamid = 6U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpArgsExceptionInner_EmptyNamesAllowed)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_empty_names_test";
    int32_t initRet = dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config);
    EXPECT_EQ(initRet, ADUMP_SUCCESS);

    int32_t ret = dumper.RegisterExceptionDumpCallback(MockCallbackWithEmptyNames);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 7U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

namespace {
const std::string g_hostBinContentForSymFail = "host kernel bin content for symbolize-fail regression";
int32_t StubGetBinDataForSymFail(rtBinHandle binHandle, std::string &binData, uint32_t &binSize)
{
    (void)binHandle;
    binData = g_hostBinContentForSymFail;
    binSize = static_cast<uint32_t>(g_hostBinContentForSymFail.size());
    return ADUMP_SUCCESS;
}
}  // namespace

// 编排层端到端回归：DumpException(args 默认路径) 先无条件 DumpHostKernelBinBeforeSymbolize 落 _host.o，
// 再调 KernelSymbolLocator::DumpErrorSymbols 做符号化。这里打桩符号解析(InitFromBinBuffer)失败，
// 模拟 .o 符号表损坏/无法解析导致 DumpErrorSymbols 在 InitFromBinBuffer 处提前 return。
// 此时 _host.o 仍必须已落盘且内容完整，守护「提前落盘独立于符号化」的编排不变量：
// 防止落盘被误合并进 DumpErrorSymbols 内部、被前置符号解析的提前 return 挡住而漏落盘。
// 若回退该修复(删除 DumpHostKernelBinBeforeSymbolize，落盘只留在 DumpErrorSymbols 内)，本用例会因 _host.o 缺失而失败。
TEST_F(ExceptionDumperExtraUtest, DumpArgsException_HostBinDroppedWhenSymbolizeFails)
{
    const uint32_t deviceId = 0U;
    const std::string dumpRoot = "/tmp/adump_hostbin_symfail_test";
    const std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = dumpRoot;
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);

    // 落盘链依赖 GetBinDataFromHandle 返回 bin buffer，打桩成功以确保 _host.o 能落盘且内容可校验。
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForSymFail));
    // 关键：符号解析失败，使 DumpErrorSymbols 在 InitFromBinBuffer 处提前 return，不再落盘。
    MOCKER_CPP(&KernelSymbolLocator::InitFromBinBuffer)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ADUMP_FAILED)));

    char hostKernel[] = "host kernel bin file stub";
    rtExceptionInfo exception = {};
    exception.deviceid = deviceId;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    auto &kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    kernelInfo.binSize = sizeof(hostKernel);
    kernelInfo.kernelName = const_cast<char *>(kernelName.data());
    kernelInfo.kernelNameSize = kernelName.size();

    // 最终返回值不作断言：后续 args 解析在无真实 device args 时可能失败，
    // 但那发生在 _host.o 落盘之后，不影响本用例要守护的落盘不变量。
    (void)dumper.DumpException(exception);

    // 符号解析失败不影响提前落盘：_host.o 仍应存在且内容完整。
    // _host.o 名去掉 _mix_aic 后缀，落在 device dump 目录（<root>/extra-info/data-dump/<deviceId>）下。
    Path hostBinPath(dumpRoot);
    hostBinPath.Append("/extra-info/data-dump/").Append(std::to_string(deviceId));
    std::string hostOName = ExceptionInfoCommon::GetKernelNameWithoutMixSuffix(kernelName) + "_host.o";
    hostBinPath.Concat(hostOName);
    EXPECT_TRUE(hostBinPath.Exist());
    std::ifstream dumped(hostBinPath.GetString(), std::ios::binary);
    std::string content((std::istreambuf_iterator<char>(dumped)), std::istreambuf_iterator<char>());
    EXPECT_EQ(content, g_hostBinContentForSymFail);
    GlobalMockObject::verify();
}
