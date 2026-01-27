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
#include <string.h>
#include <future>
#include <google/protobuf/util/json_util.h>
#include "config_manager.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "msprof_reporter.h"
#include "prof_acl_mgr.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "hash_data.h"
#include "msprofiler_acl_api.h"
#include "prof_acl_intf.h"
#include "op_desc_parser.h"
#include "prof_reporter_mgr.h"
#include "command_handle.h"
#include "prof_manager.h"
#include "platform/platform.h"
#include "report_stub.h"

using namespace Msprof::Engine::Intf;
#ifdef __cplusplus
extern "C" {
#endif
extern int32_t ProfAclGetId(ProfType type, analysis::dvvp::common::utils::CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
#ifdef __cplusplus
}
#endif
using namespace analysis::dvvp::common::error;
using namespace Msprof::Engine;
using namespace Msprofiler ::AclApi;
using namespace Analysis::Dvvp::ProfilerCommon;
using namespace analysis::dvvp::host;
using namespace Analysis::Dvvp::Common::Platform;

class MSPROF_CALLBACK_HANDLER_UTEST : public testing::Test {
public:
    void RegisterTryPop() {
        ProfImplSetApiBufPop(apiTryPop);
        ProfImplSetCompactBufPop(compactTryPop);
        ProfImplSetAdditionalBufPop(additionalTryPop);
        ProfImplIfReportBufEmpty(ifReportBufEmpty);
    }
protected:
    virtual void SetUp() {
        MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
            .stubs()
            .will(returnValue(true));
        RegisterTryPop();
        Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StartReporters();
    }
    virtual void TearDown() {
        Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StopReporters();
        GlobalMockObject::verify();
    }
};

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, DISABLED_MultiThreadTest) {
    // setup
    Msprof::Engine::MsprofReporter::InitReporters();
    size_t threadNum = 10;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk(new analysis::dvvp::ProfileFileChunk());
    std::vector<std::future<int32_t>> rets;
    for (size_t i = 0; i < threadNum; i++) {
        auto ret = std::async(&SendAiCpuData, fileChunk);
        rets.push_back(std::move(ret));
    }
    for (auto &ret : rets) {
        auto status = ret.get();
        EXPECT_EQ(status, PROFILING_SUCCESS);
    }
    GlobalMockObject::verify();
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, DISABLED_HandleMsprofRequestTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("utest");

    MOCKER_CPP(&MsprofReporter::ReportData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_REPORT, nullptr, 0));
    int data = 0;
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_REPORT, (void *)&data, 0));

    MOCKER_CPP(&MsprofReporter::StartReporter)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_INIT, nullptr, 0));

    MOCKER_CPP(&MsprofReporter::StopReporter)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_UNINIT, nullptr, 0));

    MOCKER_CPP(&MsprofReporter::GetDataMaxLen)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_DATA_MAX_LEN, nullptr, 0));

    MOCKER_CPP(&MsprofReporter::GetHashId)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, handler.HandleReportRequest(MSPROF_REPORTER_HASH, nullptr, 0));

    uint32_t invalidType = 9999;
    EXPECT_EQ(PROFILING_FAILED, handler.HandleReportRequest(invalidType, nullptr, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, DISABLED_SendDataTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("utest");

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&MsprofReporter::HandleReportRequest)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk(new analysis::dvvp::ProfileFileChunk());
    EXPECT_EQ(PROFILING_FAILED, handler.SendData(fileChunk));

    handler.StartReporter();
    fileChunk->extraInfo = "null.0";
    EXPECT_EQ(PROFILING_SUCCESS, handler.SendData(fileChunk));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ReportDataTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("Framework");

    EXPECT_EQ(PROFILING_FAILED, handler.ReportData(nullptr, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, GetHashIdTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("utest");
    MsprofHashData hd;
    MsprofHashData data;

    EXPECT_EQ(PROFILING_FAILED, handler.GetHashId(nullptr, 0));
    handler.StartReporter();
    EXPECT_EQ(PROFILING_FAILED, handler.GetHashId(nullptr, 0));
    EXPECT_EQ(PROFILING_FAILED, handler.GetHashId(&hd, 0));
    EXPECT_EQ(PROFILING_FAILED, handler.GetHashId(&hd, sizeof(hd)));
    hd.data = reinterpret_cast<unsigned char *>(&data);
    hd.dataLen = sizeof(MsprofHashData);
    //handler.GetHashId(&hd, sizeof(hd));
    MOCKER_CPP(&analysis::dvvp::transport::HashData::GenHashId,
        uint64_t (analysis::dvvp::transport::HashData::*)(const std::string &module, CONST_CHAR_PTR data, uint32_t dataLen))
        .stubs()
        .will(returnValue(0xff));
    EXPECT_EQ(PROFILING_SUCCESS, handler.GetHashId(&hd, sizeof(hd)));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, FlushDataTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("utest");

    EXPECT_EQ(PROFILING_FAILED, handler.FlushData());

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));
    handler.StartReporter();
    EXPECT_EQ(PROFILING_SUCCESS, handler.FlushData());
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, StartReporterTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("");

    EXPECT_EQ(PROFILING_FAILED, handler.StartReporter());

    handler.module_ = "Framework";
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, handler.StartReporter());
    EXPECT_EQ(PROFILING_SUCCESS, handler.StartReporter());
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, StopReporterTest) {
    GlobalMockObject::verify();
    MsprofReporter handler("utest");

    EXPECT_EQ(PROFILING_SUCCESS, handler.StopReporter());

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, handler.StartReporter());
    EXPECT_EQ(PROFILING_SUCCESS, handler.StopReporter());
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, OtherTest) {
    GlobalMockObject::verify();
    FlushModule();
    EXPECT_EQ(PROFILING_FAILED, SendAiCpuData(nullptr));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, GetDataMaxLenTest) {
    GlobalMockObject::verify();
    uint32_t len = 0;
    MsprofReporter handler("utest");
    EXPECT_EQ(PROFILING_FAILED, handler.GetDataMaxLen(nullptr, 0));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, handler.StartReporter());
    EXPECT_EQ(PROFILING_FAILED, handler.GetDataMaxLen(nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, handler.GetDataMaxLen(&len, 4));
}

int32_t fake_callback(uint32_t, void *, uint32_t) {return 0;};
TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, MsprofRegisterCallback) {
    GlobalMockObject::verify();
    ProfCommandHandle handle = fake_callback;
    EXPECT_EQ(PROFILING_FAILED, MsprofRegisterCallback(0, nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofRegisterCallback(0, handle));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofRegisterCallback(0, handle));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsCmdMode)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofHostHandle)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofSetDeviceImpl)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    auto ret = MsprofNotifySetDevice(0, 1, true);
    EXPECT_EQ(PROFILING_SUCCESS, ProfRegisterCallback(1, handle));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, MsprofReportData) {
    GlobalMockObject::verify();
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofReportData(0xff, 0, nullptr, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfAclGetId) {
    GlobalMockObject::verify();
    void* data = (void*)0x12345678;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetId(ACL_API_TYPE, data, 0, 0));
    size_t ret = 0;
    MOCKER_CPP(&Msprofiler::AclApi::ProfGetModelId)
	    .stubs()
	    .will(returnValue(ret));
    EXPECT_EQ(ret, ProfAclGetId(ACL_API_TYPE, nullptr, 0, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, MsprofNotifySetDevice) {
    GlobalMockObject::verify();
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofNotifySetDevice(0, 0, true));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfGetOpExecutionTime) {
    GlobalMockObject::verify();
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfGetOpExecutionTime(nullptr, 0, 0));

    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    void* data = (void*)0x12345678;
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfGetOpExecutionTime(data, 0, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, PROFAclAPI) {
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_FAILED, ProfAclGetOpTime(0, nullptr, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_START, nullptr, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_END, nullptr, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_DURATION, nullptr, 0, 0));
    EXPECT_EQ(PROFILING_FAILED, ProfAclGetOpVal(0xff, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_DESC_SIZE, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_NUM, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_TYPE, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_TYPE_LEN, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_NAME_LEN, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetOpVal(ACL_OP_NAME, nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_SUBSCRIBE_NONE, ProfAclGetOpVal(ACL_OP_GET_FLAG, nullptr, 0, 0, nullptr, 0));

    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    void* data = (void*)0x12345678;
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_START, data, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_END, data, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_DURATION, data, 0, 0));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, PROFAPICOMMON) {
    GlobalMockObject::verify();
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpDescSize(nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpNum(nullptr, 0, nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpTypeLen(nullptr, 0, 0, nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpType(nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpNameLen(nullptr, 0, 0, nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpName(nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, aclprofGetOpStart(nullptr, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, aclprofGetOpEnd(nullptr, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, aclprofGetOpDuration(nullptr, 0, 0));

    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    void* data = (void*)0x12345678;

    uint32_t opNum = 0;
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpNum(data, 0, &opNum));

    size_t opTypeLen = 0;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpTypeLen(data, 0, 0, &opTypeLen));

    char opType = '0';
    opTypeLen = 1;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpType(data, 0, 0, &opType, opTypeLen));

    size_t opNameLen = 0;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpNameLen(data, 0, 0, &opNameLen));

    char opName = '0';
    opNameLen = 1;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetOpName(data, 0, 0, &opName, opNameLen));
}

extern "C" size_t ProfImplGetImplInfo(ProfImplInfo& info);
extern "C" int32_t ProfImplReportRegTypeInfo(uint16_t level, uint32_t type, const std::string &typeName);
extern "C" uint64_t ProfImplReportGetHashId(const std::string &info);
extern "C" bool ProfImplHostFreqIsEnable();

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfImplGetImplInfo)
{
    ProfImplInfo info;
    ProfImplGetImplInfo(info);
    EXPECT_NE(0, info.sysFreeRam);
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfImplReportRegTypeInfo)
{
    std::string typeName = "ReportRegTypeInfo";
    EXPECT_EQ(0, ProfImplReportRegTypeInfo(0, 0, typeName));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfImplReportGetHashId)
{
    std::string typeName = "hash id";
    EXPECT_NE(0, ProfImplReportGetHashId(typeName));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, GetReportTypeInfo)
{
    std::string typeName = "memcpy_info";
    EXPECT_EQ(0, ProfImplReportRegTypeInfo(5000, 801, typeName));
    std::string name;
    Dvvp::Collect::Report::ProfReporterMgr::GetInstance().GetReportTypeInfo(5000, 801, name);
    EXPECT_EQ(0, name.compare("memcpy_info"));
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, StartReporters)
{
    EXPECT_EQ(0, Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StartReporters());
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, StopReporters)
{
    EXPECT_EQ(0, Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StopReporters());
}

drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_SYSTEM) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_DEV_OSC_FREQUE) ||
        infoType == static_cast<int32_t>(INFO_TYPE_HOST_OSC_FREQUE))) {
        *value = 1000;
    } else {
        *value = 0;
    }
    return DRV_ERROR_NONE;
}

TEST_F(MSPROF_CALLBACK_HANDLER_UTEST, ProfImplHostFreqIsEnable)
{
    EXPECT_EQ(false, ProfImplHostFreqIsEnable());
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoStub));
    Platform::instance()->Init();
    EXPECT_EQ(true, ProfImplHostFreqIsEnable());
}
