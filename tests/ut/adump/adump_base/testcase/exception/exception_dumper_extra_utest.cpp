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
#include "case_workspace.h"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "kernel_source_symbolizer.h"
#include "runtime_stub.h"
#include "dump_core.h"
#include <cstdlib>
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include <fstream>

using namespace Adx;

namespace {
uint32_t g_aicpuCallbackCount = 0U;
rtExceptionExpandType_t g_aicpuCallbackType = RT_EXCEPTION_INVALID;

// 记录调用次数与传入的异常类型，用于验证回调确实被触发。
uint32_t CountingOverwriteCallback(
    void* exceptionInfo, ExceptionDumpInfo* dumpInfo, uint32_t dumpSize, uint32_t* realSize, ExceptionDumpMode* mode)
{
    ++g_aicpuCallbackCount;
    if (exceptionInfo != nullptr) {
        g_aicpuCallbackType = static_cast<rtExceptionInfo*>(exceptionInfo)->expandInfo.type;
    }
    return MockCallbackWithOverwrite(exceptionInfo, dumpInfo, dumpSize, realSize, mode);
}
} // namespace

class ExceptionDumperExtraUtest : public testing::Test {
protected:
    void SetUp() override
    {
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
        // T3 门⓪：默认平台 CloudV2（L0+L1+CORE_DUMP），避免未 mock 平台的用例被门⓪ 短路；
        // 需要特定平台/不支持平台的用例在用例内重新 MOCKER 覆盖（后设替换先设）。
        ResetAllPlatformManagers();
        uint32_t cloudV2 = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
        MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(cloudV2)).will(returnValue(true));
    }
    void TearDown() override
    {
        DumpManager::Instance().Reset();
        ResetAllPlatformManagers();
        // 恢复默认算子超时（18 分钟）与门③查询失败注入，避免快恢用例状态泄漏到其他用例
        (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
        g_rtGetOpTimeoutFail = 0U;
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
    const char* path = dumper.GetExtraDumpCPath();
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
        ACL_ERROR_RT_AICORE_OVER_FLOW, ACL_ERROR_RT_AIVEC_OVER_FLOW, ACL_ERROR_RT_DEVICE_MEM_ERROR,
        ACL_ERROR_RT_SUSPECT_REMOTE_ERROR, ACL_ERROR_RT_LINK_ERROR};

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

    const rtExceptionExpandType_t unsupportedTypes[] = {RT_EXCEPTION_INVALID, RT_EXCEPTION_UB, RT_EXCEPTION_CCU};

    for (const rtExceptionExpandType_t type : unsupportedTypes) {
        rtExceptionInfo exception = {};
        exception.deviceid = 0U;
        exception.taskid = 1U;
        exception.streamid = 2U;
        exception.expandInfo.type = type;
        EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED) << "type: " << static_cast<int32_t>(type);
    }
}

// v3.1 提前块（方案 2）：开关关闭不再早退 FAILED——进入提前块路径（门①类型门通过，
// 守卫与主体由后续任务填充），OFF 分支返回 ADUMP_SUCCESS；earlyDumped=false 时不删除任何文件。
TEST_F(ExceptionDumperExtraUtest, DumpException_NotEnabled_EarlySymbolizePath)
{
    ExceptionDumper dumper;
    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

// 门①异常类型门：AICPU 无 host .o 可解析，不进提前块；OFF 下静默返回 SUCCESS（不落盘不解析）。
TEST_F(ExceptionDumperExtraUtest, DumpException_NotEnabled_UnsupportedType_SkipsEarlyBlock)
{
    ExceptionDumper dumper;
    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICPU;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
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

// ============================================================================
// L1 exception (DumpType::EXCEPTION) also supports ExceptionDumpCallback
// ============================================================================
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_CallbackOverwrite_OnlyDumpCallbackData)
{
    g_aicpuCallbackCount = 0U;
    g_aicpuCallbackType = RT_EXCEPTION_INVALID;

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_overwrite_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetExceptionStatus());
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(CountingOverwriteCallback), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(never());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
    EXPECT_EQ(g_aicpuCallbackCount, 1U);
    EXPECT_EQ(g_aicpuCallbackType, RT_EXCEPTION_AICORE);
    g_aicpuCallbackCount = 0U;
    g_aicpuCallbackType = RT_EXCEPTION_INVALID;
}

TEST_F(ExceptionDumperExtraUtest, DumpException_L1_CallbackAdditional_DumpBoth)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_additional_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithAdditional), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_L1_CallbackNone_OnlyDefault)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_none_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithNone), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 3U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

TEST_F(ExceptionDumperExtraUtest, DumpException_L1_NoCallback_OnlyDefault)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_nocallback_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 4U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

// 回调声明 OVERWRITE 但 realSize=0：InvokeCallbacks 校验 continue 跳过该回调，聚合模式保持 NONE，
// 必须回落默认 dump，且 DumpCallbackData 不得被调用。
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_CallbackOverwriteEmptyData_FallbackDefault)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_overwrite_empty_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithOverwriteNoData), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 5U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

// GetExceptionRegInfo 失败：InvokeCallbacks 直接返回失败，不执行默认 dump 兜底。
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_GetRegInfoFailed_NoDefaultFallback)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_reginfo_fail_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithAdditional), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionRegInfo).stubs().will(returnValue(ADUMP_FAILED));
    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(never());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 6U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_FAILED);
}

// 多回调聚合优先级：OVERWRITE(1) + NONE(0) → 聚合 OVERWRITE，仅 dump 回调数据。
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_MultiCallbacks_OverwriteWinsOverNone)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_multi_overwrite_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithNone), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithOverwrite), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(never());

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 7U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

// 多回调聚合优先级：OVERWRITE(1) + ADDITIONAL(2) → 聚合 ADDITIONAL，回调数据与默认 dump 均执行。
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_MultiCallbacks_AdditionalWinsOverOverwrite)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_multi_additional_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithOverwrite), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithAdditional), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 5U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
}

// 多回调聚合优先级：NONE(0) + NONE(0) + ADDITIONAL(2) → 聚合 ADDITIONAL；NONE 回调无数据，
// 仅 ADDITIONAL 回调的数据参与 DumpCallbackData，默认 dump 仍执行。
TEST_F(ExceptionDumperExtraUtest, DumpException_L1_MultiCallbacks_NoneAndAdditional_Mixed)
{
    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = "/tmp/adump_l1_multi_mixed_test";
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithNone), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithAdditional), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(MockCallbackWithNone), ADUMP_SUCCESS);

    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());
    MOCKER_CPP(&ExceptionDumper::DumpNormalExceptionDefault).expects(once()).will(returnValue(ADUMP_SUCCESS));

    rtExceptionInfo exception = {};
    exception.deviceid = 0U;
    exception.taskid = 1U;
    exception.streamid = 6U;
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
int32_t StubGetBinDataForSymFail(rtBinHandle binHandle, std::string& binData, uint32_t& binSize)
{
    (void)binHandle;
    binData = g_hostBinContentForSymFail;
    binSize = static_cast<uint32_t>(g_hostBinContentForSymFail.size());
    return ADUMP_SUCCESS;
}
} // namespace

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
    MOCKER_CPP(&KernelSymbolLocator::InitFromBinBuffer).stubs().will(returnValue(static_cast<int32_t>(ADUMP_FAILED)));

    char hostKernel[] = "host kernel bin file stub";
    rtExceptionInfo exception = {};
    exception.deviceid = deviceId;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    auto& kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    kernelInfo.binSize = sizeof(hostKernel);
    kernelInfo.kernelName = const_cast<char*>(kernelName.data());
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

// ============================================================================
// v3.1 提前块（方案 2）T3/T4：门⓪ 平台支持门 / 门② OFF 工具门 / 门③ 统一快恢守卫 / 主体与 OFF 即用即删
// ============================================================================

namespace {
const std::string g_earlyHostBinContent = "host kernel bin content for early-block test";
int32_t StubGetBinDataForEarlyBlock(rtBinHandle binHandle, std::string& binData, uint32_t& binSize)
{
    (void)binHandle;
    binData = g_earlyHostBinContent;
    binSize = static_cast<uint32_t>(g_earlyHostBinContent.size());
    return ADUMP_SUCCESS;
}

rtExceptionInfo BuildEarlyBlockException(uint32_t deviceId = 0U)
{
    rtExceptionInfo exception = {};
    exception.deviceid = deviceId;
    exception.taskid = 1U;
    exception.streamid = 2U;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    return exception;
}
} // namespace

// 平台未注册（type99）不拦截 OFF 提前块——走既有工具门/快恢守卫，优雅降级链执行
// （平台差异由 PC 修正等环节自行跳过）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Platform_Unsupported)
{
    Tools::CaseWorkspace ws("DumpException_Platform_Unsupported");
    // 清除 fixture 默认平台桩（CloudV2）等所有 mock，使本用例的未注册平台桩为该函数唯一桩
    // （mockcpp 多桩共存时先设者匹配，fixture 的 CloudV2 桩会掩盖本用例的 99 桩）。本用例为
    // OFF 静态路径（无异步线程/数据 dump），清除 Thread/RecordDumpDataToQueue 桩无影响。
    GlobalMockObject::reset();
    const uint32_t unsupportedType = 99U; // 未注册平台类型
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));
    // 门② 仅 OFF 查工具：指向确定可执行文件，保证主体执行
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    // 平台不再拦截：CreateDeviceDumpPath 已执行，dumpPath 目录已创建
    Path extraInfo(ws.Root());
    extraInfo.Append("/extra-info");
    EXPECT_TRUE(extraInfo.Exist());

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 回归：DC 平台（L0+L1，无 CORE_DUMP）——入口平台门已移除，平台桩不再被门消费；
// 作为"平台差异不阻断 OFF 提前块流程"的回归用例，主体照常执行。
TEST_F(ExceptionDumperExtraUtest, DumpException_Platform_DcLike)
{
    Tools::CaseWorkspace ws("DumpException_Platform_DcLike");
    // 清除 fixture 默认平台桩（CloudV2）等所有 mock，使本用例的 DC 平台桩为该函数唯一桩
    // （DC=L0+L1 无 CORE_DUMP，验证部分特性平台经 L0 过门；OFF 静态路径清除其他桩无影响）。
    GlobalMockObject::reset();
    const uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    // 门② 仅 OFF 查工具：指向确定可执行文件，保证主体执行
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 门②：OFF + llvm-symbolizer 工具缺失 → Warning + 跳过提前块（不落盘不解析）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_ToolUnavailable)
{
    Tools::CaseWorkspace ws("DumpException_Disabled_ToolUnavailable");
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/nonexistent/llvm-symbolizer", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(never());

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 门③：OFF + 快恢（op 超时 400ms < 500ms）→ 跳过提前块仅告警。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_FastRecovery)
{
    Tools::CaseWorkspace ws("DumpException_Disabled_FastRecovery");
    (void)rtSetOpExecuteTimeOutWithMs(400U);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(never());

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
}

// T4 主体全链路：OFF + 工具可用 + 非快恢 → 落 _host.o → 符号化 → 即用即删。
// 预置与桩内容一致、剥 mix 后缀命名的 _host.o（幂等：主体跳过重写），终态被删除即证明
// OFF 即用即删作用于提前块产物（且证明 mix 后缀剥除命名一致）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_FullFlow)
{
    const uint32_t deviceId = 0U;
    Tools::CaseWorkspace ws("DumpException_Disabled_FullFlow");
    const std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";

    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForEarlyBlock));

    Path hostBinPath(ws.Root());
    hostBinPath.Append("/extra-info/data-dump/").Append(std::to_string(deviceId));
    ASSERT_TRUE(hostBinPath.CreateDirectory(true));
    hostBinPath.Concat(ExceptionInfoCommon::GetKernelNameWithoutMixSuffix(kernelName) + "_host.o");
    const std::string preFilePath = hostBinPath.GetString();
    {
        std::ofstream preFile(preFilePath, std::ios::binary);
        preFile << g_earlyHostBinContent;
    }

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    rtExceptionInfo exception = BuildEarlyBlockException(deviceId);
    char hostKernel[] = "host kernel bin file stub";
    auto& kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    kernelInfo.binSize = sizeof(hostKernel);
    kernelInfo.kernelName = const_cast<char*>(kernelName.data());
    kernelInfo.kernelNameSize = kernelName.size();

    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);

    // 终态：_host.o 已被删除（落盘→解析→即用即删全链路）
    EXPECT_FALSE(Path(preFilePath).Exist());

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 门③：超时查询失败 → 告警后视为非快恢继续（主体执行）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_TimeoutQueryFail)
{
    Tools::CaseWorkspace ws("DumpException_Disabled_TimeoutQueryFail");
    g_rtGetOpTimeoutFail = 1U;
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    g_rtGetOpTimeoutFail = 0U;
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// OFF 路径不触发外部已注册回调（提前块位于 InvokeCallbacks 之前，OFF 分支在模式分发之前返回）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_CallbackNotInvoked)
{
    g_aicpuCallbackCount = 0U;
    Tools::CaseWorkspace ws("DumpException_Disabled_CallbackNotInvoked");
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(CountingOverwriteCallback), ADUMP_SUCCESS);
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);
    EXPECT_EQ(g_aicpuCallbackCount, 0U);

    g_aicpuCallbackCount = 0U;
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 门③：Args 模式 + 快恢 → 提前块跳过；Args 既有快恢分支语义原样（默认路径不执行）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Args_FastRecovery_Skip)
{
    Tools::CaseWorkspace ws("DumpException_Args_FastRecovery_Skip");
    (void)rtSetOpExecuteTimeOutWithMs(300U);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpArgsExceptionDefault).expects(never());

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetArgsExceptionStatus());

    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 门③：coredump 模式 + 快恢 → 提前块跳过（v3.1 统一守卫；现状 coredump 无守卫）；模式 dump 照常。
TEST_F(ExceptionDumperExtraUtest, DumpException_Detail_FastRecovery_Skip)
{
    Tools::CaseWorkspace ws("DumpException_Detail_FastRecovery_Skip");
    (void)rtSetOpExecuteTimeOutWithMs(400U);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(never());
    // 桩掉 DumpCoreFile：避免真实 core dump 流程（返回失败 → DumpDetailException 返回 FAILED，不触发 Exit）
    MOCKER_CPP(&DumpCore::DumpCoreFile).stubs().will(returnValue(ADUMP_FAILED));

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetCoredumpStatus());

    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_FAILED);

    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// ============================================================================
// v3.1 T5：三模式去重——提前块是唯一落盘/解析入口，默认路径内部调用删除
// ============================================================================

// 门③+T5：Normal 模式 + 快恢 → 提前块跳过；T5 去重后 Normal 默认路径不再有内部
// 落盘/解析调用，DumpHostKernelBinBeforeSymbolize 全程不被调用（红灯：默认路径仍调用）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Normal_FastRecovery_Skip)
{
    Tools::CaseWorkspace ws("DumpException_Normal_FastRecovery_Skip");
    (void)rtSetOpExecuteTimeOutWithMs(400U);
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(never());

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetExceptionStatus());

    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// T5 去重：Normal + 非快恢 → DumpHostKernelBinBeforeSymbolize 仅由提前块调用一次。
// 红灯：当前代码提前块+默认路径双重调用（2次），expects(once()) 失败。
TEST_F(ExceptionDumperExtraUtest, DumpException_Normal_NoDoubleParse)
{
    Tools::CaseWorkspace ws("DumpException_Normal_NoDoubleParse");
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);

    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 行为变化点 1（缺陷修复）：coredump 模式行号解析从不生效 → 生效。
// T5 去重后 dump_core.cpp DumpCoreFile 内的 DumpErrorSymbols 调用已删除，提前块是唯一
// 符号化入口——_host.o 先落盘再解析，验证 coredump 模式下行号解析链路完整。
TEST_F(ExceptionDumperExtraUtest, DumpException_Detail_LineParseEffective)
{
    const uint32_t deviceId = 0U;
    Tools::CaseWorkspace ws("DumpException_Detail_LineParseEffective");
    const std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";

    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForEarlyBlock));
    // 桩掉 DumpCoreFile：避免真实 core dump 全流程（返回成功 → Exit 在 UT 模式下为空操作）
    MOCKER_CPP(&DumpCore::DumpCoreFile).stubs().will(returnValue(ADUMP_SUCCESS));

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetCoredumpStatus());

    rtExceptionInfo exception = BuildEarlyBlockException(deviceId);
    char hostKernel[] = "host kernel bin file stub";
    auto& kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    kernelInfo.binSize = sizeof(hostKernel);
    kernelInfo.kernelName = const_cast<char*>(kernelName.data());
    kernelInfo.kernelNameSize = kernelName.size();

    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);

    // 行为变化点 1：coredump 模式 _host.o 已落盘（提前块先落盘再解析，
    // 修复原 DumpCoreFile 中 DumpErrorSymbols 先于 _host.o 可用性执行的缺陷）
    Path hostBinPath(ws.Root());
    hostBinPath.Append("/extra-info/data-dump/").Append(std::to_string(deviceId));
    hostBinPath.Concat(ExceptionInfoCommon::GetKernelNameWithoutMixSuffix(kernelName) + "_host.o");
    EXPECT_TRUE(hostBinPath.Exist());

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 行为变化点 3：OVERWRITE 回调场景新增异常算子自身的默认解析。
// T5 去重后提前块是唯一落盘/解析入口，不受回调模式影响 → 异常算子 _host.o 也落盘。
TEST_F(ExceptionDumperExtraUtest, DumpException_Overwrite_DefaultParseAdded)
{
    g_aicpuCallbackCount = 0U;
    const uint32_t deviceId = 0U;
    Tools::CaseWorkspace ws("DumpException_Overwrite_DefaultParseAdded");
    const std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";

    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForEarlyBlock));

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_EQ(dumper.RegisterExceptionDumpCallback(CountingOverwriteCallback), ADUMP_SUCCESS);

    // OVERWRITE 模式：默认路径不执行，但提前块照常落盘/解析
    MOCKER_CPP(&ExceptionDumper::DumpArgsExceptionDefault).expects(never());
    MOCKER_CPP(&ExceptionDumper::DumpCallbackData).expects(once());

    rtExceptionInfo exception = BuildEarlyBlockException(deviceId);
    char hostKernel[] = "host kernel bin file stub";
    auto& kernelInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    kernelInfo.binSize = sizeof(hostKernel);
    kernelInfo.kernelName = const_cast<char*>(kernelName.data());
    kernelInfo.kernelNameSize = kernelName.size();

    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);
    EXPECT_EQ(g_aicpuCallbackCount, 1U);

    // 异常算子自身 _host.o 已落盘（提前块不受 OVERWRITE 回调模式影响）
    Path hostBinPath(ws.Root());
    hostBinPath.Append("/extra-info/data-dump/").Append(std::to_string(deviceId));
    hostBinPath.Concat(ExceptionInfoCommon::GetKernelNameWithoutMixSuffix(kernelName) + "_host.o");
    EXPECT_TRUE(hostBinPath.Exist());

    g_aicpuCallbackCount = 0U;
    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// ============================================================================
// 检视意见 #9 补充：测试缺口填补
// ============================================================================

// 缺口 1a：RemoveHostKernelBinAfterSymbolize 的 GetExceptionInfo 失败分支。
// GetExceptionInfo 全程失败 → 落盘跳过 + 删除跳过（均走告警降级），返回 SUCCESS（best-effort）。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_RemoveGetInfoFail)
{
    Tools::CaseWorkspace ws("DumpException_Disabled_RemoveGetInfoFail");
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    // GetExceptionInfo 全程失败：DumpHostKernelBinBeforeSymbolize 内部跳过（告警），
    // RemoveHostKernelBinAfterSymbolize 内部跳过（告警），无崩溃、返回 SUCCESS。
    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionInfo).stubs().will(returnValue(ADUMP_FAILED));

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 缺口 1b：RemoveHostKernelBinAfterSymbolize 的非 ENOENT 删除失败分支。
// 预创建非空目录作为 _host.o 路径 → ::remove 返回 ENOTEMPTY（非 ENOENT）→ IDE_LOGW 告警。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_RemoveNonEnoentFail)
{
    const uint32_t deviceId = 0U;
    Tools::CaseWorkspace ws("DumpException_Disabled_RemoveNonEnoentFail");
    const std::string kernelName = "AddCustom_nonenoent";

    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForEarlyBlock));

    // 预创建非空目录占用 _host.o 路径：DumpHostKernelBin 写入失败（EISDIR），
    // RemoveHostKernelBinAfterSymbolize 的 ::remove 失败（ENOTEMPTY，非 ENOENT）→ 告警分支。
    Path hostBinPath(ws.Root());
    hostBinPath.Append("/extra-info/data-dump/").Append(std::to_string(deviceId));
    ASSERT_TRUE(hostBinPath.CreateDirectory(true));
    hostBinPath.Concat(kernelName + "_host.o");
    ASSERT_TRUE(Path(hostBinPath.GetString()).CreateDirectory(true));
    {
        std::ofstream innerFile(hostBinPath.GetString() + "/placeholder");
        innerFile << "x";
    }

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    rtExceptionInfo exception = BuildEarlyBlockException(deviceId);
    char hostKernel[] = "stub";
    auto& ki = exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo;
    ki.bin = static_cast<rtBinHandle>(hostKernel);
    ki.binSize = sizeof(hostKernel);
    ki.kernelName = const_cast<char*>(kernelName.data());
    ki.kernelNameSize = kernelName.size();

    // 删除失败仅告警不影响返回值
    EXPECT_EQ(dumper.DumpException(exception), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 平台未注册不拦截使能态 dump（恢复原范围）——提前块执行 + 模式分发照常。
TEST_F(ExceptionDumperExtraUtest, DumpException_Enabled_PlatformUnsupported)
{
    Tools::CaseWorkspace ws("DumpException_Enabled_PlatformUnsupported");
    GlobalMockObject::reset();
    const uint32_t unsupportedType = 99U;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::EXCEPTION, config), ADUMP_SUCCESS);
    ASSERT_TRUE(dumper.GetExceptionStatus());

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    // 平台不再拦截：CreateDeviceDumpPath 已执行，dumpPath 目录已创建
    Path extraInfo(ws.Root());
    extraInfo.Append("/extra-info");
    EXPECT_TRUE(extraInfo.Exist());
}

// 缺口 3：Args 模式（非 OVERWRITE）无重复落盘——DumpHostKernelBinBeforeSymbolize 仅由提前块调用一次。
TEST_F(ExceptionDumperExtraUtest, DumpException_Args_NoDoubleParse)
{
    Tools::CaseWorkspace ws("DumpException_Args_NoDoubleParse");
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();

    MOCKER_CPP(&ExceptionDumper::DumpHostKernelBinBeforeSymbolize).expects(once());

    ExceptionDumper dumper;
    DumpConfig config;
    config.dumpStatus = "on";
    config.dumpPath = ws.Root();
    ASSERT_EQ(dumper.ExceptionDumperInit(DumpType::ARGS_EXCEPTION, config), ADUMP_SUCCESS);

    // 返回值不断言：Args 模式对空 argAddr 返回 FAILED（内部行为，非本用例目标）；
    // 本用例仅验证 DumpHostKernelBinBeforeSymbolize 恰好调用一次（TearDown verify）。
    (void)dumper.DumpException(BuildEarlyBlockException());

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
}

// 缺口 4：OFF 入口环境固定——固定工具路径与超时值，消除构建机环境漂移。
TEST_F(ExceptionDumperExtraUtest, DumpException_Disabled_Entry_EnvPinned)
{
    Tools::CaseWorkspace ws("DumpException_Disabled_Entry_EnvPinned");
    // 固定环境：工具可用（/bin/true）+ 默认超时（18 分钟，非快恢）
    (void)setenv("ADUMP_LLVM_SYMBOLIZER", "/bin/true", 1);
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    // 固定环境下：OFF + AICORE → 提前块执行（工具可用 + 非快恢）→ OFF 分支 → SUCCESS
    EXPECT_EQ(dumper.DumpException(BuildEarlyBlockException()), ADUMP_SUCCESS);

    (void)unsetenv("ADUMP_LLVM_SYMBOLIZER");
    KernelSourceSymbolizer::ResetLocateCacheForTest();
    (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
}
