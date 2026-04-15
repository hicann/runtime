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
#include "tsd/tsd_client.h"
#include "inc/client_manager.h"
#include "tsd/status.h"
#include "inc/hdc_client.h"
#define private public
#define protected public
#include "inc/process_mode_manager.h"
#undef private
#undef protected
#include "stub_log.h"
#include "stub_server_reply.h"
#include "stub_server_msg_proc_def.h"
#include "common_util_func.h"
#include "stub_common_sys_call.h"

using namespace tsd;
using namespace std;

class TsdClientTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before TsdClientTest." << endl;
        setenv("RUN_MODE", "PROCESS", 1);
    }

    virtual void TearDown()
    {
        cout << "After TsdClientTest." << endl;
        GlobalMockObject::reset();
        StubServerReply::GetInstance()->ResetServerReply();
    }
};

TEST_F(TsdClientTest, TsdOpen_TsdClose_RankSize_0_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpen_TsdClose_RankSize_2_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenEx_TsdClose_RankSize_0_DieMode_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 0U, static_cast<uint32_t>(tsd::DeviceRunMode::DIE_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenEx_TsdClose_RankSize_2_DieMode_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 2U, static_cast<uint32_t>(tsd::DeviceRunMode::DIE_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenEx_TsdClose_RankSize_0_ChipMode_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // TsdOpenEx使用CHIP_MODE的接口已经不建议使用，在日落计划中。
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 0U, static_cast<uint32_t>(tsd::DeviceRunMode::CHIP_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenEx_TsdClose_RankSize_2_ChipMode_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // TsdOpenEx使用CHIP_MODE的接口已经不建议使用，在日落计划中。
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 2U, static_cast<uint32_t>(tsd::DeviceRunMode::CHIP_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenAicpuSd_TsdClose_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenAicpuSd(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, UpdateProfilingMode_TsdClose_Success)
{
    StubServerMsgProcDef::RegisterUpdateProfilingModeMsgDefaultCallBack();
    // 使用updateprofilingmode 接口需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = UpdateProfilingMode(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetMsprofReporterCallback_Success)
{
    tsd::TSD_StatusT ret = TsdSetMsprofReporterCallback(nullptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
    TsdSetMsprofReporterCallback(&StubServerMsgImpl::StubMsProfReportCallBack);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitQs_Success)
{
    StubServerMsgProcDef::RegisterTsdInitQsMsgDefaultCallBack();
    const std::string dfGrp = "default_group";
    tsd::TSD_StatusT ret = TsdInitQs(0U, dfGrp.c_str());
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitFlowGw_Success)
{
    StubServerMsgProcDef::RegisterTsdInitQsMsgDefaultCallBack();
    const std::string argGrp = "args_group";
    InitFlowGwInfo startArgs;
    startArgs.groupName = argGrp.c_str();
    startArgs.schedPolicy = 0UL;
    startArgs.reschedInterval = 0UL;
    tsd::TSD_StatusT ret = TsdInitFlowGw(0U, &startArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, GetHdcConctStatus_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // GetHdcConctStatus 接口需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    int32_t curStat = 0;
    ret = GetHdcConctStatus(0U, &curStat);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAttr_Success)
{
    // TsdSetAttr 接口已经在日落计划中，已经不建议外部使用
    tsd::TSD_StatusT ret = TsdSetAttr("SetTest", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdSetAttr("test", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, SetAicpuSchedMode_Success)
{
    // SetAicpuSchedMode 接口已经在日落计划中，已经不建议外部使用
    const tsd::TSD_StatusT ret = SetAicpuSchedMode(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_PidQos_Success)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetPidQosMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取PidQos需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint8_t pidQos = 0;
    uint64_t pidQosPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&pidQos));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_PIDQOS, pidQosPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(pidQos, 1);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_Support_OM_Inner_Dec_Success)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetOmInnerDecMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support OM inner先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportOmInner = 0UL;
    uint64_t omInnerPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportOmInner));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_OM_INNER_DEC, omInnerPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportOmInner, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_Support_BuiltIn_Udf_Success)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetCapabilityLevelMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support built in udf先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportBuiltInUdf = 0UL;
    uint64_t builtinUdfPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportBuiltInUdf));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_BUILTIN_UDF, builtinUdfPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportBuiltInUdf, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_Support_Mutiple_Hccp_Success)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetCapabilityLevelMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support mutiple hccp先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportMulHccp = 0UL;
    uint64_t mulHccpPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportMulHccp));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_MUTIPLE_HCCP, mulHccpPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportMulHccp, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdFileLoad_TsdFileUnLoad_Runtime_Pkg_Success) {
    // TsdFileLoad 及 TsdFileUnLoad 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();
    const std::string runtimePkgName = "Ascend-runtime_device-minios.tar.gz";
    std::string filepath = "/tmp";
    std::string pathPreFix = std::to_string(getpid());
    if (WriteTmpFile(pathPreFix, runtimePkgName)) {
        tsd::TSD_StatusT ret = TsdFileLoad(0U, filepath.c_str(), filepath.size(), runtimePkgName.c_str(),
            runtimePkgName.size());
        const std::string dstFile = filepath + "/" + runtimePkgName;
        remove(dstFile.c_str());
        const std::string fileDir = filepath + "/" + pathPreFix;
        remove(fileDir.c_str());
        EXPECT_EQ(ret, tsd::TSD_OK);
        ret = TsdFileUnLoad(0U, filepath.c_str(), filepath.size());
        EXPECT_EQ(ret, tsd::TSD_OK);
    }
}

TEST_F(TsdClientTest, TsdFileLoad_TsdFileUnLoad_Dshape_Pkg_Success) {
    // TsdFileLoad 及 TsdFileUnLoad 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();
    const std::string dShapePkgName = "Ascend-opp_rt-minios.aarch64.tar.gz";
    std::string filepath = "/tmp";
    std::string pathPreFix = std::to_string(getpid());
    if (WriteTmpFile(pathPreFix, dShapePkgName)) {
        tsd::TSD_StatusT ret = TsdFileLoad(0U, filepath.c_str(), filepath.size(), dShapePkgName.c_str(),
            dShapePkgName.size());
        const std::string dstFile = filepath + "/" + dShapePkgName;
        remove(dstFile.c_str());
        const std::string fileDir = filepath + "/" + pathPreFix;
        remove(fileDir.c_str());
        EXPECT_EQ(ret, tsd::TSD_OK);
        ret = TsdFileUnLoad(0U, filepath.c_str(), filepath.size());
        EXPECT_EQ(ret, tsd::TSD_OK);
    }
}

TEST_F(TsdClientTest, TsdProcessOpen_GetStatus_Close_Success) {
    // TsdProcessOpen TsdGetProcStatus TsdProcessClose接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgs;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1UL;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusInfo curStat;
    ret = TsdGetProcStatus(0U, &curStat, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessClose(0U, subpid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessOpen_GetProcListStatus_CloseProcList_Success) {
    // TsdProcessOpen TsdGetProcListsStatus ProcessCloseSubProcList 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgsUdf;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgsUdf.envParaList = &envParam;
    openArgsUdf.envCnt = 1UL;
    std::string extPamUdf("levevl=Udf");
    ProcExtParam extmmUdf;
    extmmUdf.paramInfo = extPamUdf.c_str();
    extmmUdf.paramLen = extPamUdf.size();
    openArgsUdf.extParamList = &extmmUdf;
    openArgsUdf.extParamCnt = 1;
    pid_t subPidUdf = 0;
    openArgsUdf.subPid = &subPidUdf;
    openArgsUdf.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix= "/home";
    openArgsUdf.filePath = filepathprefix.c_str();
    openArgsUdf.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgsUdf);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcOpenArgs openArgsNpu;
    openArgsNpu.envParaList = &envParam;
    openArgsNpu.envCnt = 1UL;
    std::string extPamNpu("levevl=Npu");
    ProcExtParam extmmNpu;
    extmmNpu.paramInfo = extPamNpu.c_str();
    extmmNpu.paramLen = extPamNpu.size();
    openArgsNpu.extParamList = &extmmNpu;
    openArgsNpu.extParamCnt = 1;
    pid_t subPidNpu = 0;
    openArgsNpu.subPid = &subPidNpu;
    openArgsNpu.procType = TSD_SUB_PROC_NPU;
    openArgsNpu.filePath = filepathprefix.c_str();
    openArgsNpu.pathLen = filepathprefix.length();
    ret = TsdProcessOpen(0U, &openArgsNpu);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcStatusParam curStatArray[2U];
    curStatArray[0U].pid = subPidUdf;
    curStatArray[1U].pid = subPidNpu;
    ret = TsdGetProcListStatus(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = ProcessCloseSubProcList(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpen_Close_NetService_Success) {
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    const tsd::TSD_StatusT result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
}

TEST_F(TsdClientTest, NotifyPmToStartTsdaemon_Success) {
    // NotifyPmToStartTsdaemon 接口已经在日落计划中，已经不建议外部使用
    // 直接返回ERROR
    auto result = NotifyPmToStartTsdaemon(0U);
    EXPECT_EQ(result, TSD_PARAMETER_INVALID);
}

TEST_F(TsdClientTest, TsdCloseEx_Success)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdCloseEx(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitFlowGw_Nullptr_Failed)
{
    tsd::TSD_StatusT ret = TsdInitFlowGw(0U, nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, GetHdcConctStatus_Nullptr_Success)
{
    tsd::TSD_StatusT ret = GetHdcConctStatus(0U, nullptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAttr_Nullptr_Failed)
{
    tsd::TSD_StatusT ret = TsdSetAttr(nullptr, "test");
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = TsdSetAttr("test", nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdCapabilityGet_InvalidType_Failed)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t value = 0UL;
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_BUT, value);
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessOpen_Nullptr_Failed)
{
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdProcessClose_Success)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgs;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1UL;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessClose(0U, subpid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdFileUnLoad_Success)
{
    StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();
    const std::string runtimePkgName = "Ascend-runtime_device-minios.tar.gz";
    std::string filepath = "/tmp";
    std::string pathPreFix = std::to_string(getpid());
    if (WriteTmpFile(pathPreFix, runtimePkgName)) {
        tsd::TSD_StatusT ret = TsdFileLoad(0U, filepath.c_str(), filepath.size(), runtimePkgName.c_str(),
            runtimePkgName.size());
        const std::string dstFile = filepath + "/" + runtimePkgName;
        remove(dstFile.c_str());
        const std::string fileDir = filepath + "/" + pathPreFix;
        remove(fileDir.c_str());
        EXPECT_EQ(ret, tsd::TSD_OK);
        ret = TsdFileUnLoad(0U, filepath.c_str(), filepath.size());
        EXPECT_EQ(ret, tsd::TSD_OK);
    }
}

TEST_F(TsdClientTest, TsdGetProcStatus_Success)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgs;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1UL;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusInfo curStat;
    ret = TsdGetProcStatus(0U, &curStat, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessClose(0U, subpid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, ProcessCloseSubProcList_Success)
{
    StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgsUdf;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgsUdf.envParaList = &envParam;
    openArgsUdf.envCnt = 1UL;
    std::string extPamUdf("levevl=Udf");
    ProcExtParam extmmUdf;
    extmmUdf.paramInfo = extPamUdf.c_str();
    extmmUdf.paramLen = extPamUdf.size();
    openArgsUdf.extParamList = &extmmUdf;
    openArgsUdf.extParamCnt = 1;
    pid_t subPidUdf = 0;
    openArgsUdf.subPid = &subPidUdf;
    openArgsUdf.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgsUdf.filePath = filepathprefix.c_str();
    openArgsUdf.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgsUdf);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcOpenArgs openArgsNpu;
    openArgsNpu.envParaList = &envParam;
    openArgsNpu.envCnt = 1UL;
    std::string extPamNpu("levevl=Npu");
    ProcExtParam extmmNpu;
    extmmNpu.paramInfo = extPamNpu.c_str();
    extmmNpu.paramLen = extPamNpu.size();
    openArgsNpu.extParamList = &extmmNpu;
    openArgsNpu.extParamCnt = 1;
    pid_t subPidNpu = 0;
    openArgsNpu.subPid = &subPidNpu;
    openArgsNpu.procType = TSD_SUB_PROC_NPU;
    openArgsNpu.filePath = filepathprefix.c_str();
    openArgsNpu.pathLen = filepathprefix.length();
    ret = TsdProcessOpen(0U, &openArgsNpu);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcStatusParam curStatArray[2U];
    curStatArray[0U].pid = subPidUdf;
    curStatArray[1U].pid = subPidNpu;
    ret = ProcessCloseSubProcList(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdGetProcListStatus_Success)
{
    StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgsUdf;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgsUdf.envParaList = &envParam;
    openArgsUdf.envCnt = 1UL;
    std::string extPamUdf("levevl=Udf");
    ProcExtParam extmmUdf;
    extmmUdf.paramInfo = extPamUdf.c_str();
    extmmUdf.paramLen = extPamUdf.size();
    openArgsUdf.extParamList = &extmmUdf;
    openArgsUdf.extParamCnt = 1;
    pid_t subPidUdf = 0;
    openArgsUdf.subPid = &subPidUdf;
    openArgsUdf.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgsUdf.filePath = filepathprefix.c_str();
    openArgsUdf.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgsUdf);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcOpenArgs openArgsNpu;
    openArgsNpu.envParaList = &envParam;
    openArgsNpu.envCnt = 1UL;
    std::string extPamNpu("levevl=Npu");
    ProcExtParam extmmNpu;
    extmmNpu.paramInfo = extPamNpu.c_str();
    extmmNpu.paramLen = extPamNpu.size();
    openArgsNpu.extParamList = &extmmNpu;
    openArgsNpu.extParamCnt = 1;
    pid_t subPidNpu = 0;
    openArgsNpu.subPid = &subPidNpu;
    openArgsNpu.procType = TSD_SUB_PROC_NPU;
    openArgsNpu.filePath = filepathprefix.c_str();
    openArgsNpu.pathLen = filepathprefix.length();
    ret = TsdProcessOpen(0U, &openArgsNpu);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcStatusParam curStatArray[2U];
    curStatArray[0U].pid = subPidUdf;
    curStatArray[1U].pid = subPidNpu;
    ret = TsdGetProcListStatus(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = ProcessCloseSubProcList(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCloseNetService_Success)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    const tsd::TSD_StatusT result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
    const tsd::TSD_StatusT closeResult = TsdCloseNetService(0U);
    EXPECT_NE(closeResult, tsd::TSD_OK);
}
