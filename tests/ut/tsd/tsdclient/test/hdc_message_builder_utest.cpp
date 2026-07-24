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
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#include "driver/ascend_hal.h"
#include "env_internal_api.h"
#include "tsd_util_func.h"

#define private public
#define protected public
#include "hdc_message_builder.h"
#include "capability_manager.h"
#include "inc/client_manager.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
constexpr uint32_t DEV_ID = 10U;
constexpr uint32_t RANK_SIZE = 4U;
constexpr uint32_t PROC_PID = 1234U;
const char* PROC_SIGN_STR = "sign-abcd";

const char* g_mockAscendAicpuPath = nullptr;

char* MmSysGetEnvAscendAicpuPathStub(mmEnvId id)
{
    if (id == MM_ENV_ASCEND_AICPU_PATH && g_mockAscendAicpuPath != nullptr) {
        return const_cast<char*>(g_mockAscendAicpuPath);
    }
    return nullptr;
}

// 构造一个所有字段都非默认值的 MessageContext，便于各 Build 用例按需覆写。
MessageContext MakeSeededContext()
{
    MessageContext ctx{};
    ctx.logicDeviceId = DEV_ID;
    ctx.rankSize = RANK_SIZE;
    ctx.profilingMode = static_cast<uint32_t>(ProfilingMode::PROFILING_OPEN);
    ctx.logLevel = "002";
    ctx.ccecpuLogLevel = "001";
    ctx.aicpuLogLevel = "003";
    ctx.aicpuDeviceMode = 7U;
    ctx.procSign.tgid = static_cast<pid_t>(PROC_PID);
    (void)strncpy_s(ctx.procSign.sign, sizeof(ctx.procSign.sign), "sign-abcd", sizeof("sign-abcd"));
    ctx.aicpuKernelCheckCode = 0xAAU;
    ctx.aicpuExtendKernelCheckCode = 0xBBU;
    ctx.ascendcppCheckCode = 0xCCU;
    ctx.aicpuSchedMode = ClientManager::aicpuSchedMode_;
    return ctx;
}
} // namespace

class HdcMessageBuilderTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before HdcMessageBuilderTest" << endl;
        g_mockAscendAicpuPath = nullptr;
    }
    virtual void TearDown()
    {
        cout << "After HdcMessageBuilderTest" << endl;
        g_mockAscendAicpuPath = nullptr;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

// ===== BuildOpen =====

TEST_F(HdcMessageBuilderTest, BuildOpen_AllFieldsPopulated)
{
    g_mockAscendAicpuPath = "/home/test/aicpu";
    MOCKER(mmSysGetEnv).stubs().will(invoke(MmSysGetEnvAscendAicpuPathStub));

    MessageContext ctx = MakeSeededContext();
    ctx.startHccp = true;
    ctx.startCp = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOpen(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.rank_size(), RANK_SIZE);
    EXPECT_TRUE(msg.start_hccp());
    EXPECT_FALSE(msg.start_cp());
    EXPECT_EQ(msg.profiling_mode(), static_cast<uint32_t>(ProfilingMode::PROFILING_OPEN));
    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.log_level().log_level(), "002");
    EXPECT_EQ(msg.ccecpu_log_level().ccecpu_log_level(), "001");
    EXPECT_EQ(msg.aicpu_log_level().aicpu_log_level(), "003");
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    EXPECT_EQ(msg.proc_sign_pid().proc_sign(), PROC_SIGN_STR);
    EXPECT_EQ(msg.check_code(), 0xAAU);
    EXPECT_EQ(msg.extendpkg_check_code(), 0xBBU);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0xCCU);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_START_PROC_MSG);
    EXPECT_EQ(msg.device_mode(), 7U);
    EXPECT_EQ(msg.aicpu_sched_mode(), static_cast<uint32_t>(ClientManager::aicpuSchedMode_));
    uint32_t expectCap = 0U;
    TSD_BITMAP_SET(expectCap, TSDCLIENT_SUPPORT_NEW_ERRORCODE);
    EXPECT_EQ(msg.tsdclient_capability_level(), expectCap);
    EXPECT_EQ(msg.ascend_aicpu_path().ascend_aicpu_path(), "/home/test/aicpu");
}

TEST_F(HdcMessageBuilderTest, BuildOpen_EmptyAicpuPathWhenEnvUnset)
{
    g_mockAscendAicpuPath = nullptr;
    MOCKER(mmSysGetEnv).stubs().will(invoke(MmSysGetEnvAscendAicpuPathStub));

    MessageContext ctx = MakeSeededContext();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOpen(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.ascend_aicpu_path().ascend_aicpu_path(), "");
}

TEST_F(HdcMessageBuilderTest, BuildOpen_StartFlagsBothTrue)
{
    MessageContext ctx = MakeSeededContext();
    ctx.startHccp = true;
    ctx.startCp = true;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOpen(msg, ctx), TSD_OK);
    EXPECT_TRUE(msg.start_hccp());
    EXPECT_TRUE(msg.start_cp());
}

TEST_F(HdcMessageBuilderTest, BuildOpen_StartFlagsBothFalse)
{
    MessageContext ctx = MakeSeededContext();
    ctx.startHccp = false;
    ctx.startCp = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOpen(msg, ctx), TSD_OK);
    EXPECT_FALSE(msg.start_hccp());
    EXPECT_FALSE(msg.start_cp());
}

TEST_F(HdcMessageBuilderTest, BuildOpen_DeviceIdModulo)
{
    MessageContext ctx = MakeSeededContext();
    ctx.logicDeviceId = PER_OS_CHIP_NUM * 3U + 2U; // 任意满足取模关系的值
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOpen(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.device_id(), (PER_OS_CHIP_NUM * 3U + 2U) % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), PER_OS_CHIP_NUM * 3U + 2U);
}

// ===== BuildClose =====

TEST_F(HdcMessageBuilderTest, BuildClose_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildClose(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CLOSE_PROC_MSG);
    EXPECT_EQ(msg.rank_size(), RANK_SIZE);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    // close 不带 sign
    EXPECT_EQ(msg.proc_sign_pid().proc_sign(), "");
}

// ===== BuildUpdateProfiling =====

TEST_F(HdcMessageBuilderTest, BuildUpdateProfiling_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.profilingMode = 5U;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildUpdateProfiling(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_UPDATE_PROIFILING_MSG);
    EXPECT_EQ(msg.profiling_mode(), 5U);
    EXPECT_EQ(msg.rank_size(), RANK_SIZE);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
}

// ===== BuildOmFileDecompress =====

TEST_F(HdcMessageBuilderTest, BuildOmFileDecompress_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.omfileName = "1234_test.om";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOmFileDecompress(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS);
    EXPECT_EQ(msg.omfile_name(), "1234_test.om");
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
}

TEST_F(HdcMessageBuilderTest, BuildOmFileDecompress_EmptyOmfileName)
{
    MessageContext ctx = MakeSeededContext();
    ctx.omfileName.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildOmFileDecompress(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.omfile_name(), "");
}

// ===== BuildPackageCheckCode =====

TEST_F(HdcMessageBuilderTest, BuildPackageCheckCode_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.msgType = static_cast<uint32_t>(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    ctx.checkCode = 0x55U;
    ctx.beforeSendPkg = true;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildPackageCheckCode(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    EXPECT_EQ(msg.check_code(), 0x55U);
    EXPECT_TRUE(msg.before_send_pkg());
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    EXPECT_EQ(msg.proc_sign_pid().proc_sign(), PROC_SIGN_STR);
}

TEST_F(HdcMessageBuilderTest, BuildPackageCheckCode_BeforeSendPkgFalse)
{
    MessageContext ctx = MakeSeededContext();
    ctx.msgType = static_cast<uint32_t>(HDCMessage::TSD_CHECK_PACKAGE);
    ctx.beforeSendPkg = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildPackageCheckCode(msg, ctx), TSD_OK);
    EXPECT_FALSE(msg.before_send_pkg());
}

// ===== BuildCapability =====

TEST_F(HdcMessageBuilderTest, BuildCapability_PidQos)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_PIDQOS;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_PID_QOS);
    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
}

TEST_F(HdcMessageBuilderTest, BuildCapability_Level)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_LEVEL;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
}

TEST_F(HdcMessageBuilderTest, BuildCapability_OmInnerDec)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_OM_INNER_DEC;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_SUPPORT_OM_INNER_DEC);
}

TEST_F(HdcMessageBuilderTest, BuildCapability_Adprof)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_ADPROF;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUPPORT_ADPROF);
}

TEST_F(HdcMessageBuilderTest, BuildCapability_InvalidType_SpecIsNull)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_BUT; // 越界，FindCapabilitySpec 返回 nullptr
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    // spec == nullptr 分支：不调用 set_type，type 保持默认 INIT
    EXPECT_EQ(msg.type(), HDCMessage::INIT);
    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
}

TEST_F(HdcMessageBuilderTest, BuildCapability_ProcSignPid)
{
    MessageContext ctx = MakeSeededContext();
    ctx.capabilityType = TSD_CAPABILITY_LEVEL;
    ctx.procSign.tgid = static_cast<pid_t>(4321U);
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCapability(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), 4321U);
}

// ===== BuildCloseSubProc =====

TEST_F(HdcMessageBuilderTest, BuildCloseSubProc_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.closeSubProcPid = 4321U;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCloseSubProc(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CLOSE_SUB_PROC);
    EXPECT_EQ(msg.close_sub_proc_pid(), 4321U);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
}

// ===== BuildRemoveFile =====

TEST_F(HdcMessageBuilderTest, BuildRemoveFile_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.removeFilePath = "/home/test/remove.txt";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildRemoveFile(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_REMOVE_FILE);
    EXPECT_EQ(msg.remove_file_path(), "/home/test/remove.txt");
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
}

TEST_F(HdcMessageBuilderTest, BuildRemoveFile_EmptyPath)
{
    MessageContext ctx = MakeSeededContext();
    ctx.removeFilePath.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildRemoveFile(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.remove_file_path(), "");
}

// ===== BuildCannHsCheckCode =====

TEST_F(HdcMessageBuilderTest, BuildCannHsCheckCode_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageMaxProcessTime = 30U;
    ctx.packageWorkerType = static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK);
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK);
    ctx.packageName = "cann-hcomm-compat.tar.gz";
    ctx.hashCode = "hash-1234";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCannHsCheckCode(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE);
    EXPECT_EQ(msg.package_max_process_time(), 30U);
    EXPECT_EQ(msg.package_worker_type(), static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
    EXPECT_EQ(msg.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "cann-hcomm-compat.tar.gz");
    EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "hash-1234");
}

TEST_F(HdcMessageBuilderTest, BuildCannHsCheckCode_EmptyNameAndHash)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName.clear();
    ctx.hashCode.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCannHsCheckCode(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "");
    EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "");
}

// ===== BuildGetSubProcStatus =====

TEST_F(HdcMessageBuilderTest, BuildGetSubProcStatus_PidOnly)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList = {11U, 22U, 33U};
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUB_PROC_STATUS);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    ASSERT_EQ(msg.sub_proc_status_list_size(), 3);
    EXPECT_EQ(msg.sub_proc_status_list(0).sub_proc_pid(), 11U);
    EXPECT_EQ(msg.sub_proc_status_list(1).sub_proc_pid(), 22U);
    EXPECT_EQ(msg.sub_proc_status_list(2).sub_proc_pid(), 33U);
    EXPECT_EQ(msg.sub_proc_type_list_size(), 0);
}

TEST_F(HdcMessageBuilderTest, BuildGetSubProcStatus_PidAndType)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList = {11U, 22U};
    ctx.subProcTypeList = {
        static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP),
        static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_COMPUTE)};
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUB_PROC_STATUS);
    ASSERT_EQ(msg.sub_proc_status_list_size(), 2);
    EXPECT_EQ(msg.sub_proc_status_list(0).sub_proc_pid(), 11U);
    EXPECT_EQ(msg.sub_proc_status_list(1).sub_proc_pid(), 22U);
    ASSERT_EQ(msg.sub_proc_type_list_size(), 2);
    EXPECT_EQ(msg.sub_proc_type_list(0), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
    EXPECT_EQ(msg.sub_proc_type_list(1), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_COMPUTE));
}

TEST_F(HdcMessageBuilderTest, BuildGetSubProcStatus_EmptyPidList)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList.clear();
    ctx.subProcTypeList.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_SUB_PROC_STATUS);
    EXPECT_EQ(msg.sub_proc_status_list_size(), 0);
    EXPECT_EQ(msg.sub_proc_type_list_size(), 0);
}

// 覆盖 FillSubProcList 中 index >= subProcTypeList.size() 的分支：
// pid 数 > type 数，多出的 pid 不再追加 type。
TEST_F(HdcMessageBuilderTest, BuildGetSubProcStatus_PidMoreThanType)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList = {11U, 22U, 33U};
    ctx.subProcTypeList = {static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP)}; // 仅 1 个 type
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx), TSD_OK);

    ASSERT_EQ(msg.sub_proc_status_list_size(), 3);
    ASSERT_EQ(msg.sub_proc_type_list_size(), 1); // 只追加 1 个 type
    EXPECT_EQ(msg.sub_proc_type_list(0), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
}

// ===== BuildCloseSubProcList =====

TEST_F(HdcMessageBuilderTest, BuildCloseSubProcList_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList = {101U, 102U};
    ctx.subProcTypeList = {
        static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP),
        static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_COMPUTE)};
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCloseSubProcList(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CLOSE_SUB_PROC_LIST);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    ASSERT_EQ(msg.close_sub_list_size(), 2);
    EXPECT_EQ(msg.close_sub_list(0).sub_proc_pid(), 101U);
    EXPECT_EQ(msg.close_sub_list(1).sub_proc_pid(), 102U);
    ASSERT_EQ(msg.sub_proc_type_list_size(), 2);
    EXPECT_EQ(msg.sub_proc_type_list(0), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
    EXPECT_EQ(msg.sub_proc_type_list(1), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_COMPUTE));
}

TEST_F(HdcMessageBuilderTest, BuildCloseSubProcList_EmptyLists)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList.clear();
    ctx.subProcTypeList.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCloseSubProcList(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.type(), HDCMessage::TSD_CLOSE_SUB_PROC_LIST);
    EXPECT_EQ(msg.close_sub_list_size(), 0);
    EXPECT_EQ(msg.sub_proc_type_list_size(), 0);
}

TEST_F(HdcMessageBuilderTest, BuildCloseSubProcList_PidMoreThanType)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcPidList = {101U, 102U, 103U};
    ctx.subProcTypeList = {static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP)};
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCloseSubProcList(msg, ctx), TSD_OK);

    ASSERT_EQ(msg.close_sub_list_size(), 3);
    ASSERT_EQ(msg.sub_proc_type_list_size(), 1);
}

// ===== BuildCommonOpen =====

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_AllOptionalFieldsPresent)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcOpenType = static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_UDF);
    ctx.hasSubProcFilePath = true;
    ctx.subProcFilePath = "/home/test/udf.so";
    ctx.subProcEnvList = {{"ENV_A", "VAL_A"}, {"ENV_B", "VAL_B"}};
    ctx.subProcExtParamList = {"ext0", "ext1"};
    ctx.ascendInstallPath = "/usr/local/Ascend";
    ctx.withSubProcLogLevel = true;
    ctx.logLevel = "002";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.type(), HDCMessage::TSD_OPEN_SUB_PROC);
    EXPECT_EQ(msg.device_id(), DEV_ID % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    EXPECT_EQ(msg.proc_sign_pid().proc_sign(), PROC_SIGN_STR);
    EXPECT_EQ(msg.ascend_install_path(), "/usr/local/Ascend");
    EXPECT_EQ(msg.log_level().log_level(), "002");
    const HelperSubProcess& subProc = msg.helper_sub_proc();
    EXPECT_EQ(subProc.process_type(), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_UDF));
    EXPECT_EQ(subProc.file_path(), "/home/test/udf.so");
    ASSERT_EQ(subProc.env_list_size(), 2);
    EXPECT_EQ(subProc.env_list(0).env_name(), "ENV_A");
    EXPECT_EQ(subProc.env_list(0).env_value(), "VAL_A");
    EXPECT_EQ(subProc.env_list(1).env_name(), "ENV_B");
    EXPECT_EQ(subProc.env_list(1).env_value(), "VAL_B");
    ASSERT_EQ(subProc.ext_param_list_size(), 2);
    EXPECT_EQ(subProc.ext_param_list(0), "ext0");
    EXPECT_EQ(subProc.ext_param_list(1), "ext1");
}

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_NoOptionalFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.subProcOpenType = static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP);
    ctx.hasSubProcFilePath = false;
    ctx.withSubProcLogLevel = false;
    ctx.ascendInstallPath.clear();
    ctx.subProcEnvList.clear();
    ctx.subProcExtParamList.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.type(), HDCMessage::TSD_OPEN_SUB_PROC);
    EXPECT_FALSE(msg.has_log_level());
    EXPECT_EQ(msg.ascend_install_path(), "");
    const HelperSubProcess& subProc = msg.helper_sub_proc();
    EXPECT_EQ(subProc.process_type(), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
    EXPECT_EQ(subProc.file_path(), "");
    EXPECT_EQ(subProc.env_list_size(), 0);
    EXPECT_EQ(subProc.ext_param_list_size(), 0);
}

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_HasFilePathButNoLogLevel)
{
    MessageContext ctx = MakeSeededContext();
    ctx.hasSubProcFilePath = true;
    ctx.subProcFilePath = "/path/to/bin";
    ctx.withSubProcLogLevel = false;
    ctx.ascendInstallPath.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.helper_sub_proc().file_path(), "/path/to/bin");
    EXPECT_FALSE(msg.has_log_level());
}

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_WithLogLevelButNoFilePath)
{
    MessageContext ctx = MakeSeededContext();
    ctx.hasSubProcFilePath = false;
    ctx.withSubProcLogLevel = true;
    ctx.logLevel = "debug";
    ctx.ascendInstallPath.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.helper_sub_proc().file_path(), "");
    EXPECT_EQ(msg.log_level().log_level(), "debug");
}

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_WithExtParamListOnly)
{
    MessageContext ctx = MakeSeededContext();
    ctx.hasSubProcFilePath = false;
    ctx.withSubProcLogLevel = false;
    ctx.ascendInstallPath.clear();
    ctx.subProcEnvList.clear();
    ctx.subProcExtParamList = {"only-ext"};
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.helper_sub_proc().ext_param_list_size(), 1);
    EXPECT_EQ(msg.helper_sub_proc().ext_param_list(0), "only-ext");
    EXPECT_EQ(msg.helper_sub_proc().env_list_size(), 0);
}

TEST_F(HdcMessageBuilderTest, BuildCommonOpen_WithEnvListOnly)
{
    MessageContext ctx = MakeSeededContext();
    ctx.hasSubProcFilePath = false;
    ctx.withSubProcLogLevel = false;
    ctx.ascendInstallPath.clear();
    ctx.subProcEnvList = {{"K", "V"}};
    ctx.subProcExtParamList.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCommonOpen(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.helper_sub_proc().env_list_size(), 1);
    EXPECT_EQ(msg.helper_sub_proc().env_list(0).env_name(), "K");
    EXPECT_EQ(msg.helper_sub_proc().env_list(0).env_value(), "V");
    EXPECT_EQ(msg.helper_sub_proc().ext_param_list_size(), 0);
}

// ===== BuildCheckPackageRetry =====

TEST_F(HdcMessageBuilderTest, BuildCheckPackageRetry_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0x77U;
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ctx.waitFlag = true;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackageRetry(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    EXPECT_EQ(msg.check_code(), 0x77U);
    EXPECT_EQ(msg.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
    EXPECT_TRUE(msg.wait_flag());
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackageRetry_WaitFlagFalse)
{
    MessageContext ctx = MakeSeededContext();
    ctx.waitFlag = false;
    ctx.checkCode = 0U;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackageRetry(msg, ctx), TSD_OK);
    EXPECT_FALSE(msg.wait_flag());
    EXPECT_EQ(msg.check_code(), 0U);
}

// ===== BuildCheckPackage =====
// 该函数有 3 个独立 `!= 0U` 分支，逐个覆盖。

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_AllCheckCodesZero)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0U;
    ctx.extendpkgCheckCode = 0U;
    ctx.ascendcppCheckCode = 0U;
    ctx.asan = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CHECK_PACKAGE);
    EXPECT_FALSE(msg.asan());
    // 3 个分支均未进入，对应字段保持默认值 0
    EXPECT_EQ(msg.check_code(), 0U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0U);
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_OnlyCheckCodeNonZero)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0x11U;
    ctx.extendpkgCheckCode = 0U;
    ctx.ascendcppCheckCode = 0U;
    ctx.asan = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.check_code(), 0x11U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0U);
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_OnlyExtendpkgCheckCodeNonZero)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0U;
    ctx.extendpkgCheckCode = 0x22U;
    ctx.ascendcppCheckCode = 0U;
    ctx.asan = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.check_code(), 0U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0x22U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0U);
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_OnlyAscendcppCheckCodeNonZero)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0U;
    ctx.extendpkgCheckCode = 0U;
    ctx.ascendcppCheckCode = 0x33U;
    ctx.asan = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.check_code(), 0U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0x33U);
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_AllCheckCodesNonZero)
{
    MessageContext ctx = MakeSeededContext();
    ctx.checkCode = 0x11U;
    ctx.extendpkgCheckCode = 0x22U;
    ctx.ascendcppCheckCode = 0x33U;
    ctx.asan = false;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_EQ(msg.check_code(), 0x11U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0x22U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0x33U);
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_AsanTrue)
{
    MessageContext ctx = MakeSeededContext();
    ctx.asan = true;
    ctx.checkCode = 0U;
    ctx.extendpkgCheckCode = 0U;
    ctx.ascendcppCheckCode = 0U;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_TRUE(msg.asan());
}

TEST_F(HdcMessageBuilderTest, BuildCheckPackage_AsanFalseWithNonZeroCodes)
{
    MessageContext ctx = MakeSeededContext();
    ctx.asan = false;
    ctx.checkCode = 0x11U;
    ctx.extendpkgCheckCode = 0x22U;
    ctx.ascendcppCheckCode = 0x33U;
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildCheckPackage(msg, ctx), TSD_OK);
    EXPECT_FALSE(msg.asan());
    EXPECT_EQ(msg.check_code(), 0x11U);
    EXPECT_EQ(msg.extendpkg_check_code(), 0x22U);
    EXPECT_EQ(msg.ascendcpppkg_check_code(), 0x33U);
}

// ===== BuildUpdatePackageConfig =====

TEST_F(HdcMessageBuilderTest, BuildUpdatePackageConfig_PopulatesFields)
{
    MessageContext ctx = MakeSeededContext();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildUpdatePackageConfig(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), PROC_PID);
    // withSign = false，不写 proc_sign
    EXPECT_EQ(msg.proc_sign_pid().proc_sign(), "");
}

// ===== BuildNormalCheckCode =====

TEST_F(HdcMessageBuilderTest, BuildNormalCheckCode_NoHostPluginVersion)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName = "cann-hcomm-compat.tar.gz";
    ctx.hashCode = "hash-5678";
    ctx.packageWorkerType = static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK);
    ctx.packageMaxProcessTime = 60U;
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK);
    // hostPluginVersion 默认空，不进入 add_host_plugin_versions 分支
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildNormalCheckCode(msg, ctx), TSD_OK);

    EXPECT_EQ(msg.real_device_id(), DEV_ID);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL);
    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "cann-hcomm-compat.tar.gz");
    EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "hash-5678");
    EXPECT_EQ(msg.host_plugin_versions_size(), 0); // 未追加 plugin version
    EXPECT_EQ(msg.package_worker_type(), static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
    EXPECT_EQ(msg.package_max_process_time(), 60U);
    EXPECT_EQ(msg.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
}

TEST_F(HdcMessageBuilderTest, BuildNormalCheckCode_WithHostPluginVersion)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName = "cann-hcomm-compat.tar.gz";
    ctx.hashCode = "hash-5678";
    ctx.packageWorkerType = static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK);
    ctx.packageMaxProcessTime = 60U;
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK);
    ctx.hostPluginVersion.version = "8.5.0";
    ctx.hostPluginVersion.timestamp = "20260114_115609804";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildNormalCheckCode(msg, ctx), TSD_OK);

    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    ASSERT_EQ(msg.host_plugin_versions_size(), 1);
    const PluginPackageVersionInfo& info = msg.host_plugin_versions(0);
    EXPECT_EQ(info.package_name(), "cann-hcomm-compat.tar.gz");
    EXPECT_EQ(info.version(), "8.5.0");
    EXPECT_EQ(info.timestamp(), "20260114_115609804");
}

// 覆盖 MessageContext::hostPluginVersion.Empty() 的内部逻辑：
// version 非空 + timestamp 空 => Empty() 返回 false，仍追加 plugin version。
TEST_F(HdcMessageBuilderTest, BuildNormalCheckCode_HostPluginVersionOnly)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName = "pkg";
    ctx.hashCode = "h";
    ctx.hostPluginVersion.version = "9.0.0";
    ctx.hostPluginVersion.timestamp.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildNormalCheckCode(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.host_plugin_versions_size(), 1);
    EXPECT_EQ(msg.host_plugin_versions(0).version(), "9.0.0");
    EXPECT_EQ(msg.host_plugin_versions(0).timestamp(), "");
}

TEST_F(HdcMessageBuilderTest, BuildNormalCheckCode_HostPluginTimestampOnly)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName = "pkg";
    ctx.hashCode = "h";
    ctx.hostPluginVersion.version.clear();
    ctx.hostPluginVersion.timestamp = "20260101";
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildNormalCheckCode(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.host_plugin_versions_size(), 1);
    EXPECT_EQ(msg.host_plugin_versions(0).version(), "");
    EXPECT_EQ(msg.host_plugin_versions(0).timestamp(), "20260101");
}

TEST_F(HdcMessageBuilderTest, BuildNormalCheckCode_EmptyPackageNameAndHash)
{
    MessageContext ctx = MakeSeededContext();
    ctx.packageName.clear();
    ctx.hashCode.clear();
    HDCMessage msg;
    EXPECT_EQ(HdcMessageBuilder::BuildNormalCheckCode(msg, ctx), TSD_OK);
    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "");
    EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "");
    EXPECT_EQ(msg.host_plugin_versions_size(), 0);
}

// ===== SetProcSignPid 间接覆盖：withSign=true / false 两路已在 BuildOpen / BuildClose 中分别命中 =====
