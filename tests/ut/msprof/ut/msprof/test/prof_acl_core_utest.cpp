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
#include <cstdlib>
#include <string.h>
#include <google/protobuf/util/json_util.h>
#include "config/config_manager.h"
#include "config/feature_manager.h"
#include "data_struct.h"
#include "errno/error_code.h"
#include "ge/ge_prof.h"
#include "message/codec.h"
#include "msprofiler_impl.h"
#include "msprof_reporter.h"
#include "op_desc_parser.h"
#include "prof_api_common.h"
#include "prof_api.h"
#include "prof_acl_mgr.h"
#include "proto/profiler.pb.h"
#include "uploader_dumper.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "prof_acl_core.h"
#include "prof_ge_core.h"
#include "analyzer_ge.h"
#include "uploader.h"
#include "uploader_mgr.h"
#include "analyzer_rt.h"
#include "analyzer_ts.h"
#include "analyzer.h"
#include "analyzer_hwts.h"
#include "analyzer_ffts.h"
#include "data_struct.h"
#include "transport/parser_transport.h"
#include "transport/transport.h"
#include "transport/hdc/hdc_transport.h"
#include "prof_manager.h"
#include "prof_params_adapter.h"
#include "msprof_tx_manager.h"
#include "msprof_tx_reporter.h"
#include "platform/platform.h"
#include "command_handle.h"
#include "acl_prof.h"
#include "data_struct.h"
#include "prof_acl_api.h"
#include "command_handle.h"
#include "msprofiler_acl_api.h"
#include "prof_acl_intf.h"
#include "param_validation.h"
#include "dyn_prof_server.h"
#include "dyn_prof_mgr.h"
#include "prof_stamp_pool.h"
#include "hash_data.h"
#include "prof_hal_plugin.h"
#include "prof_api_runtime.h"
#include "adx_prof_api.h"
#include "transport/hdc/helper_transport.h"
#include "report_stub.h"
#include "prof_reporter_mgr.h"
#include "receive_data.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Analyze;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::ProfilerCommon;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Msprof::Engine::Intf;
using namespace Msprof::MsprofTx;
using namespace Collector::Dvvp::DynProf;
using namespace Analysis::Dvvp::Adx;
using namespace ge;
using namespace ProfRtAPI;
const int RECEIVE_CHUNK_SIZE = 320; // chunk size:320
extern bool IsProfConfigValid(CONST_UINT32_T_PTR deviceidList, uint32_t deviceNums);
extern "C" {
extern int ProfAclDrvGetDevNum();
}
class MSPROF_ACL_CORE_UTEST: public testing::Test {
public:
    void RegisterTryPop() {
        ProfImplSetApiBufPop(apiTryPop);
        ProfImplSetCompactBufPop(compactTryPop);
        ProfImplSetAdditionalBufPop(additionalTryPop);
        ProfImplIfReportBufEmpty(ifReportBufEmpty);
    }
protected:
    virtual void SetUp()
    {
        RegisterTryPop();
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int aclApiSubscribeCount = 0;

int mmWriteStub(int fd, void *buf, unsigned int bufLen) {
    using namespace Analysis::Dvvp::Analyze;
    MSPROF_LOGI("mmWriteStub, bufLen: %u", bufLen);
    aclApiSubscribeCount++;
    EXPECT_EQ(sizeof(ProfOpDesc), bufLen);
    EXPECT_EQ(sizeof(ProfOpDesc), OpDescParser::GetOpDescSize());
    uint32_t opNum = 0;

    EXPECT_EQ(ACL_SUCCESS, OpDescParser::GetOpNum(buf, bufLen, &opNum));
    EXPECT_EQ(1, opNum);

    uint32_t modelId = 0;
    OpDescParser::GetModelId(buf, bufLen, 0, &modelId);
    EXPECT_EQ(1, modelId);
    size_t opTypeLen = 0;
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpTypeLen(buf, bufLen, &opTypeLen, 0));
    char opType[opTypeLen];
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpType(buf, bufLen, opType, opTypeLen, 0));
    EXPECT_EQ("OpType", std::string(opType));
    size_t opNameLen = 0;
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpNameLen(buf, bufLen, &opNameLen, 0));
    char opName[opNameLen];
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpName(buf, bufLen, opName, opNameLen, 0));
    EXPECT_EQ("OpName", std::string(opName));
    EXPECT_EQ(true, OpDescParser::GetOpStart(buf, bufLen, 0) > 0);
    EXPECT_EQ(true, OpDescParser::GetOpEnd(buf, bufLen, 0) > 0);
    EXPECT_EQ(true, OpDescParser::GetOpDuration(buf, bufLen, 0) > 0);
    //EXPECT_EQ(true, Msprofiler::Api::ProfGetOpExecutionTime(buf, bufLen, 0) >= 0);
    EXPECT_EQ(true, ProfGetOpExecutionTime(buf, bufLen, 0) >= 0);
    EXPECT_EQ(true, OpDescParser::GetOpCubeFops(buf, bufLen, 0) >= 0);
    EXPECT_EQ(true, OpDescParser::GetOpVectorFops(buf, bufLen, 0) >= 0);
    EXPECT_EQ(0, OpDescParser::GetOpFlag(buf, bufLen, 0));
    EXPECT_NE(nullptr, OpDescParser::GetOpAttriValue(buf, bufLen, 0, ACL_SUBSCRIBE_ATTRI_THREADID));   //
    EXPECT_EQ(nullptr, OpDescParser::GetOpAttriValue(buf, bufLen, 0, ACL_SUBSCRIBE_ATTRI_NONE));

    // for aclapi
    size_t opSize = 0;
    aclprofGetOpDescSize(&opSize);
    aclprofGetOpNum(buf, bufLen, &opNum);
    aclprofGetOpTypeLen(buf, bufLen, 0, &opTypeLen);
    aclprofGetOpType(buf, bufLen, 0, opType, opTypeLen);
    aclprofGetOpNameLen(buf, bufLen, 0, &opNameLen);
    aclprofGetOpName(buf, bufLen, 0, opName, opNameLen);
    aclprofGetOpStart(buf, bufLen, 0);
    aclprofGetOpEnd(buf, bufLen, 0);
    aclprofGetOpDuration(buf, bufLen, 0);
    aclprofGetModelId(buf, bufLen, 0);
    //aclprofGetGraphId(buf, bufLen, 0);
    aclprofGetModelId(nullptr, 0, 0);
    aclprofGetModelId(nullptr, 0, 0);
    return bufLen;
}

int32_t runtimeSuccessFunction(int32_t logicId, int32_t* devIdId) {
    int32_t dev = 1;
    devIdId = &dev;
    return 0;
}

int32_t runtimeFailedFunction(int32_t logicId, int32_t* devIdId) {
    int32_t dev = 1;
    devIdId = &dev;
    return -1;
}

void * dlsymSuccessStub(void *handle, const char *symbol) {
    return (void *)runtimeSuccessFunction;
}

void * dlsymFailedStub(void *handle, const char *symbol) {
    return (void *)runtimeFailedFunction;
}

TEST_F(MSPROF_ACL_CORE_UTEST, get_op_xxx) {
    ProfOpDesc data;
    data.modelId = 0;
    data.flag = ACL_SUBSCRIBE_OP_THREAD;
    data.threadId = 0;
    data.modelId = 0;
    data.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
        reinterpret_cast<uint8_t *>(&data) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
    EXPECT_EQ(ACL_SUBSCRIBE_OP_THREAD, OpDescParser::GetOpFlag(&data, sizeof(data), 0));
    EXPECT_NE(nullptr, OpDescParser::GetOpAttriValue(&data, sizeof(data), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
    EXPECT_EQ(nullptr, OpDescParser::GetOpAttriValue(&data, sizeof(data), 0, ACL_SUBSCRIBE_ATTRI_NONE));
    uint32_t thraedId;
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::GetThreadId(&data, sizeof(data), 0, &thraedId));
    uint32_t devId;
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::GetDeviceId(&data, sizeof(data), 0, &devId));
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_ge_api) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));

    std::string result = "/tmp/acl_api_utest_new";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    Msprof::Engine::MsprofReporter::reporters_.clear();
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfInit(result.c_str(), result.size()));
    std::string empty = "";
    EXPECT_EQ(ge::FAILED, ge::aclgrphProfInit(empty.c_str(), empty.size()));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f000f;
    ge::aclgrphProfConfig *aclConfig = ge::aclgrphProfCreateConfig(
        config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    ge::aclgrphProfConfig *zeroConfig = ge::aclgrphProfCreateConfig(
        config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    ge::aclgrphProfConfig *invalidConfig = ge::aclgrphProfCreateConfig(
        config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff);
    memset(zeroConfig, 0, sizeof(ProfConfig));

    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::FAILED, ge::aclgrphProfStart(zeroConfig));
    EXPECT_EQ(ge::FAILED, ge::aclgrphProfStart(invalidConfig));
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfStart(aclConfig));

    ProfConfig largeConfig;
    largeConfig.devNums = MSVP_MAX_DEV_NUM + 1;
    largeConfig.devIdList[0] = 0;
    largeConfig.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    largeConfig.dataTypeConfig = 0x7d7f001f;
    ge::aclgrphProfConfig *largeAclConfig = ge::aclgrphProfCreateConfig(
        largeConfig.devIdList, largeConfig.devNums, (ge::ProfilingAicoreMetrics)largeConfig.aicoreMetrics, nullptr, largeConfig.dataTypeConfig);

    EXPECT_EQ(nullptr, largeAclConfig);

    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_INIT, nullptr, 0);
    MsprofHashData hData = {0};
    std::string hashData = "profiling_ut_data";
    hData.dataLen = hashData.size();
    hData.data = reinterpret_cast<unsigned char *>(const_cast<char *>(hashData.c_str()));
    hData.hashId = 0;
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_HASH, (void *)&hData, sizeof(hData));
    EXPECT_NE(0, hData.hashId);

    ReporterData data = {0};
    data.tag[0] = 't';
    data.deviceId = 0;
    std::string reportData = "profiling_st_data";
    data.dataLen = reportData.size();
    data.data = const_cast<unsigned char *>((const unsigned char *)reportData.c_str());
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_REPORT, (void *)&data, sizeof(data));
    uint32_t dataMaxLen = 0;
    int ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 16);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(RECEIVE_CHUNK_SIZE, dataMaxLen);
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_UNINIT, nullptr, 0);
    Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].ForceFlush();
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_INIT, nullptr, 0);
    hData = {0};
    hashData = "profiling_ut_data";
    hData.dataLen = hashData.size();
    hData.data = reinterpret_cast<unsigned char *>(const_cast<char *>(hashData.c_str()));
    hData.hashId = 0;
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_HASH, (void *)&hData, sizeof(hData));
    EXPECT_NE(0, hData.hashId);

    data = {0};
    data.tag[0] = 't';
    data.deviceId = 0;
    reportData = "profiling_st_data";
    data.dataLen = reportData.size();
    data.data = const_cast<unsigned char *>((const unsigned char *)reportData.c_str());
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_REPORT, (void *)&data, sizeof(data));
    dataMaxLen = 0;
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].GetDataMaxLen(&dataMaxLen, 16);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(RECEIVE_CHUNK_SIZE, dataMaxLen);
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_UNINIT, nullptr, 0);
    Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].ForceFlush();
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    // EXPECT_EQ(ge::FAILED, ge::aclgrphProfStop(nullptr));
    EXPECT_EQ(ge::FAILED, ge::aclgrphProfStop(zeroConfig));
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfStop(aclConfig));

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfFinalize());

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(zeroConfig));
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(invalidConfig));
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));

    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, aclgrphProfInit_failed) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfInitPrecheck)
        .stubs()
        .will(returnValue(ACL_SUCCESS))
        .then(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfAclInit)
        .stubs()
        .will(returnValue(ACL_ERROR_PROFILING_FAILURE))
        .then(returnValue(ACL_SUCCESS));

    std::string result = "/tmp/aclgrphProfInit_failed";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ge::FAILED, ge::aclgrphProfInit(result.c_str(), result.size()));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

int RelativePathToAbsolutePath_stub_cnt = 0;
std::string RelativePathToAbsolutePath_stub(const std::string &path)
{
    RelativePathToAbsolutePath_stub_cnt++;
    if (RelativePathToAbsolutePath_stub_cnt == 1) {
        return "";
    } else {
        return "/tmp/MSPROF_ACL_CORE_UTEST_ProfAclInit_failed";
    }
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclInit_failed) {
    GlobalMockObject::verify();
    Msprofiler::Api::ProfAclMgr::instance()->Init();
    std::string result = "/tmp/MSPROF_ACL_CORE_UTEST_ProfAclInit_failed";

    MOCKER(analysis::dvvp::common::utils::Utils::RelativePathToAbsolutePath)
        .stubs()
        .will(invoke(RelativePathToAbsolutePath_stub));

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    Msprofiler::Api::ProfAclMgr::instance()->isReady_ = true;
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;

    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ACL_ERROR_INVALID_FILE, Msprofiler::Api::ProfAclMgr::instance()->ProfAclInit(result.c_str()));
    EXPECT_EQ(ACL_ERROR_INVALID_FILE, Msprofiler::Api::ProfAclMgr::instance()->ProfAclInit(result.c_str()));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(5));
    Platform::instance()->Uninit();
    Platform::instance()->Init();

    std::string result = "/tmp/acl_prof_api_stest_new";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ACL_SUCCESS, aclprofInit(result.c_str(), result.size()));
    EXPECT_EQ(true, Msprofiler::Api::ProfAclMgr::instance()->IsAclApiMode());
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofInit(nullptr, result.size()));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofInit(result.c_str(), 0));
    std::string empty = "";
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofInit(empty.c_str(), 0));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f000f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    aclprofConfig *zeroConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    aclprofConfig *invalidConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff);
    memset(zeroConfig, 0, sizeof(ProfConfig));

    aclprofConfigType configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
    std::string setConfig("50");
    aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());

    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStart(nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStart(zeroConfig));
    EXPECT_EQ(200007, aclprofStart(invalidConfig));
    EXPECT_EQ(0, aclprofStart(aclConfig));
    EXPECT_TRUE(Msprofiler::Api::ProfAclMgr::instance()->IsAclApiReady());

    ProfConfig largeConfig;
    largeConfig.devNums = MSVP_MAX_DEV_NUM + 1;
    largeConfig.devIdList[0] = 0;
    largeConfig.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    largeConfig.dataTypeConfig = 0x7d7f001f;
    aclprofConfig *largeAclConfig = aclprofCreateConfig(
        largeConfig.devIdList, largeConfig.devNums, (aclprofAicoreMetrics)largeConfig.aicoreMetrics, nullptr, largeConfig.dataTypeConfig);
    EXPECT_EQ(nullptr, largeAclConfig);

    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_INIT, nullptr, 0);
    ReporterData data = {0};
    data.tag[0] = 't';
    data.deviceId = 0;
    std::string reportData = "profiling_st_data";
    data.dataLen = reportData.size();
    data.data = const_cast<unsigned char *>((const unsigned char *)reportData.c_str());
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_REPORT, (void *)&data, sizeof(data));
    uint32_t dataMaxLen = 0;
    int ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 16);
    EXPECT_EQ(0, ret);
    EXPECT_EQ(RECEIVE_CHUNK_SIZE, dataMaxLen);
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_UNINIT, nullptr, 0);
    Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].ForceFlush();
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].GetDataMaxLen(&dataMaxLen, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStop(nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStop(zeroConfig));
    EXPECT_EQ( 0, aclprofStop(aclConfig));

    EXPECT_EQ(MSPROF_ERROR_NONE, aclprofFinalize());

    EXPECT_EQ(ge::SUCCESS, aclprofDestroyConfig(zeroConfig));
    EXPECT_EQ(ge::SUCCESS, aclprofDestroyConfig(invalidConfig));
    EXPECT_EQ(ge::SUCCESS, aclprofDestroyConfig(aclConfig));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofDestroyConfig(nullptr));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    Platform::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_UTEST, prof_acl_api_helper) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    const char *path = "/home/user/workSpace";
    size_t len = strlen(path);
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofInit(path, len));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofFinalize());
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_prof_init_failed) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfInitPrecheck)
        .stubs()
        .will(returnValue(ACL_SUCCESS))
        .then(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfAclInit)
        .stubs()
        .will(returnValue(ACL_ERROR_PROFILING_FAILURE))
        .then(returnValue(ACL_SUCCESS));

    std::string result = "/tmp/acl_prof_init_failed";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, aclprofInit(result.c_str(), result.size()));
    setenv("PROFILING_MODE", "dynamic", 1);
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofInit(result.c_str(), result.size()));
    unsetenv("PROFILING_MODE");
}

TEST_F(MSPROF_ACL_CORE_UTEST, aclprofCreateSubscribeConfig) {
    GlobalMockObject::verify();

    using namespace Msprofiler::Api;

    int fd = 1;
    ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);

    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);
    EXPECT_NE(nullptr, profSubconfig);

    aclprofDestroySubscribeConfig(profSubconfig);
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_subscribe) {
    GlobalMockObject::verify();

    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();

    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));

    using namespace Msprofiler::Api;

    int fd = 1;
    ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);

    EXPECT_EQ(nullptr, aclprofCreateSubscribeConfig(0, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr));
    EXPECT_EQ(nullptr, aclprofCreateSubscribeConfig(0, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr));
    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);

    EXPECT_NE(nullptr, profSubconfig);

    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, aclprofModelSubscribe(1, nullptr));
    MsprofSetDeviceIdByGeModelIdx(3, 0);
    Msprofiler::AclApi::ProfRegisterTransport(Msprofiler::AclApi::CreateParserTransport);
    EXPECT_EQ(ACL_SUCCESS, aclprofModelSubscribe(3, profSubconfig));

    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    uint32_t devId = 0;

    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = devId;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 1;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);

    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = ProfAclMgr::instance()->GenerateSubscribeKey(&cfg);
    EXPECT_EQ(0, ProfAclMgr::instance()->GetDeviceSubscribeCount(subscribePtr, devId));
    EXPECT_TRUE(devId == 0);

    cfg.cacheFlag = false;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    cfg.cacheFlag = true;
    EXPECT_EQ(ACL_SUCCESS, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    struct MsprofConfig cfg2;
    cfg2.devNums = 1;
    cfg2.devIdList[0] = 0;
    cfg2.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg2.modelId = 2;
    cfg2.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg2.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg2.cacheFlag = true;
    EXPECT_EQ(ACL_SUCCESS, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg2),
        sizeof(cfg2)));
    EXPECT_EQ(2, ProfAclMgr::instance()->GetDeviceSubscribeCount(subscribePtr, devId));
    EXPECT_TRUE(devId == 0);

    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> geIdMap(new analysis::dvvp::proto::FileChunkReq());
    MsprofGeProfIdMapData idMapData;
    geIdMap->set_filename("Framework");
    geIdMap->set_tag("id_map_info");
    std::string geOriData0((char *)&idMapData, sizeof(idMapData));
    geIdMap->set_chunk(geOriData0);
    geIdMap->set_chunksizeinbytes(sizeof(idMapData));
    std::string data0 = analysis::dvvp::message::EncodeMessage(geIdMap);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data0.c_str()), data0.size());

    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> geTaskDesc(new analysis::dvvp::proto::FileChunkReq());
    struct MsprofGeProfTaskData geTaskDescChunk1;
    struct MsprofGeProfTaskData geTaskDescChunk2;
    geTaskDescChunk1.opName.type = 1;
    geTaskDescChunk2.opName.type = 1;
    geTaskDescChunk1.opType.type = 0;
    geTaskDescChunk2.opType.type = 0;
    geTaskDesc->set_filename("Framework");
    geTaskDesc->set_tag("task_desc_info");
    std::string geOriData1((char *)&geTaskDescChunk1, sizeof(geTaskDescChunk1));
    geTaskDesc->set_chunk(geOriData1);
    geTaskDesc->set_chunksizeinbytes(sizeof(geTaskDescChunk1));
    std::string data = analysis::dvvp::message::EncodeMessage(geTaskDesc);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());
    std::string geOriData2((char *)&geTaskDescChunk2, sizeof(geTaskDescChunk2));
    geTaskDesc->set_chunk(geOriData2);
    geTaskDesc->set_chunksizeinbytes(sizeof(geTaskDescChunk2));
    data = analysis::dvvp::message::EncodeMessage(geTaskDesc);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    using namespace Analysis::Dvvp::Analyze;
    TsProfileTimeline tsChunk;
    tsChunk.head.rptType = TS_TIMELINE_RPT_TYPE;
    tsChunk.head.bufSize = sizeof(TsProfileTimeline);
    tsChunk.taskId = 30;
    tsChunk.streamId = 100;
    tsChunk.taskState = TS_TIMELINE_START_TASK_STATE;
    tsChunk.timestamp = 10000;
    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> tsTimeline(new analysis::dvvp::proto::FileChunkReq());
    tsTimeline->set_filename("ts_track.data");
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize);
    tsTimeline->set_chunksizeinbytes(tsChunk.head.bufSize);
    data = analysis::dvvp::message::EncodeMessage(tsTimeline);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    tsChunk.taskState = TS_TIMELINE_AICORE_START_TASK_STATE;
    tsChunk.timestamp = 20000;
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize);
    tsTimeline->set_chunksizeinbytes(tsChunk.head.bufSize);
    data = analysis::dvvp::message::EncodeMessage(tsTimeline);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    tsChunk.taskState = TS_TIMELINE_AICORE_END_TASK_STATE;
    tsChunk.timestamp = 30000;
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize);
    tsTimeline->set_chunksizeinbytes(tsChunk.head.bufSize);
    data = analysis::dvvp::message::EncodeMessage(tsTimeline);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    tsChunk.taskState = TS_TIMELINE_END_TASK_STATE;
    tsChunk.timestamp = 40000;
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize - 10);
    tsTimeline->set_chunksizeinbytes(tsChunk.head.bufSize - 10);
    data = analysis::dvvp::message::EncodeMessage(tsTimeline);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk) + tsChunk.head.bufSize - 10, 10);
    tsTimeline->set_chunksizeinbytes(10);
    data = analysis::dvvp::message::EncodeMessage(tsTimeline);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 30;
    hwtsChunk.streamId = 100;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 1000000;
    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> hwts(new analysis::dvvp::proto::FileChunkReq());
    hwts->set_filename("hwts.data");
    hwts->set_chunk(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->set_chunksizeinbytes(sizeof(HwtsProfileType01));
    data = analysis::dvvp::message::EncodeMessage(hwts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    hwtsChunk.cntRes0Type = HWTS_TASK_END_TYPE;
    hwtsChunk.syscnt = 2000000;
    hwts->set_chunk(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01) - 10);
    hwts->set_chunksizeinbytes(sizeof(HwtsProfileType01) - 10);
    data = analysis::dvvp::message::EncodeMessage(hwts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());
    hwts->set_chunk(reinterpret_cast<char *>(&hwtsChunk) + sizeof(HwtsProfileType01) - 10, 10);
    hwts->set_chunksizeinbytes(10);
    data = analysis::dvvp::message::EncodeMessage(hwts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data.c_str()), data.size());

    // ffts
    StarsCxtLog fftsCxtLog;
    fftsCxtLog.head.logType = FFTS_SUBTASK_THREAD_START_FUNC_TYPE;
    fftsCxtLog.streamId = 100;
    fftsCxtLog.taskId = 200;
    fftsCxtLog.sysCountLow = 1000;
    fftsCxtLog.sysCountHigh = 0;
    fftsCxtLog.cxtId = 300;
    fftsCxtLog.threadId = 400;
    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> ffts(new analysis::dvvp::proto::FileChunkReq());
    ffts->set_filename("stars_soc.data");
    ffts->set_chunk(reinterpret_cast<char *>(&fftsCxtLog), sizeof(fftsCxtLog));
    ffts->set_chunksizeinbytes(sizeof(fftsCxtLog));
    data = analysis::dvvp::message::EncodeMessage(ffts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", static_cast<const void *>(data.c_str()), data.size());
    fftsCxtLog.head.logType = FFTS_SUBTASK_THREAD_END_FUNC_TYPE;
    fftsCxtLog.sysCountLow = 2000;
    fftsCxtLog.sysCountHigh = 0;
    ffts->set_chunk(reinterpret_cast<char *>(&fftsCxtLog), sizeof(fftsCxtLog));
    data = analysis::dvvp::message::EncodeMessage(ffts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", static_cast<const void *>(data.c_str()), data.size());

    StarsAcsqLog fftsAcsqLog;
    fftsAcsqLog.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    fftsAcsqLog.streamId = 1;
    fftsAcsqLog.taskId = 2;
    fftsAcsqLog.sysCountLow = 10000;
    ffts->set_chunk(reinterpret_cast<char *>(&fftsAcsqLog), sizeof(fftsAcsqLog));
    data = analysis::dvvp::message::EncodeMessage(ffts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", static_cast<const void *>(data.c_str()), data.size());
    fftsAcsqLog.head.logType = ACSQ_TASK_END_FUNC_TYPE;
    fftsAcsqLog.sysCountLow = 20000;
    ffts->set_chunk(reinterpret_cast<char *>(&fftsAcsqLog), sizeof(fftsAcsqLog));
    data = analysis::dvvp::message::EncodeMessage(ffts);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", static_cast<const void *>(data.c_str()), data.size());
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::transport::UploaderMgr::instance()->UploadData("20",
        static_cast<const void *>(data.c_str()), data.size()));

    ReporterData reportData = {0};
    strcpy(reportData.tag, "task_desc_info");
    reportData.deviceId = 0;
    reportData.dataLen = sizeof(geTaskDescChunk1);
    reportData.data = (unsigned char *)(&geTaskDescChunk1);
    using namespace Analysis::Dvvp::ProfilerCommon;
    using namespace Msprof::Engine;

    EXPECT_EQ(MSPROF_ERROR_NONE, ProfReportData(MSPROF_MODULE_FRAMEWORK, MSPROF_REPORTER_INIT, nullptr, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfReportData(MSPROF_MODULE_FRAMEWORK, MSPROF_REPORTER_REPORT, (void *)&reportData, sizeof(reportData)));
    FlushAllModule();
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfReportData(MSPROF_MODULE_FRAMEWORK, MSPROF_REPORTER_UNINIT, nullptr, 0));

    ProfSubscribeInfo subscribeInfo = {true, 1, &fd};

    struct MsprofConfig cfg3;
    cfg3.devNums = 1;
    cfg3.devIdList[0] = devId;
    cfg3.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg3.modelId = 3;
    cfg3.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg3.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg3.cacheFlag = true;

    struct MsprofConfig cfg4;
    cfg4.devNums = 1;
    cfg4.devIdList[0] = devId;
    cfg4.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg4.modelId = 4;
    cfg4.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg4.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg4.cacheFlag = true;

    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr3 = ProfAclMgr::instance()->GenerateSubscribeKey(&cfg3);
    ProfAclMgr::instance()->subscribeInfos_.insert(std::make_pair(subscribePtr->key, subscribeInfo));
    ProfAclMgr::instance()->CloseSubscribeFd(1, subscribePtr3);

    EXPECT_EQ(ACL_SUCCESS, MsprofStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg2),
        sizeof(cfg2)));
    EXPECT_EQ(ACL_SUCCESS, aclprofModelUnSubscribe(3));

    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, MsprofStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg4),
        sizeof(cfg4)));
    EXPECT_EQ(0, ProfAclMgr::instance()->GetDeviceSubscribeCount(subscribePtr, devId));
    EXPECT_TRUE(devId == 0);
    ProfAclMgr::instance()->FlushAllData("0");
    ProfAclMgr::instance()->CloseSubscribeFd(devId, subscribePtr);
    ProfAclMgr::instance()->CloseSubscribeFd(64, subscribePtr);
    EXPECT_EQ(0, aclApiSubscribeCount);
    MsprofUnsetDeviceIdByGeModelIdx(3, 0);
    aclprofDestroySubscribeConfig(profSubconfig);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ge_api_subscribe) {
    GlobalMockObject::verify();

    Msprofiler::AclApi::ProfRegisterTransport(Msprofiler::AclApi::CreateParserTransport);
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();
    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));
    using namespace Msprofiler::Api;

    int fd = 1;
    ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);

    EXPECT_EQ(nullptr, aclprofCreateSubscribeConfig(0, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr));
    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);

    EXPECT_NE(nullptr, profSubconfig);

    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, aclgrphProfGraphSubscribe(1, nullptr));
    MsprofSetDeviceIdByGeModelIdx(1, 0);
    EXPECT_EQ(ACL_SUCCESS, aclgrphProfGraphSubscribe(1, profSubconfig));

    EXPECT_EQ(ACL_SUCCESS, aclgrphProfGraphUnSubscribe(1));

    aclprofDestroySubscribeConfig(profSubconfig);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AclProfGETSetpInfoApiTest) {
    struct aclprofStepInfo *pStepInfo = aclprofCreateStepInfo();
    aclprofStepTag stepTag = ACL_STEP_START;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetStepTimestamp(nullptr, stepTag, nullptr));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetStepTimestamp(pStepInfo, stepTag, nullptr));
    aclprofDestroyStepInfo(nullptr);
    aclprofDestroyStepInfo(pStepInfo);
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_app) {
    GlobalMockObject::verify();
    std::string envsV("{\"result_dir\":\"\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::string selfPath = "/home";
    MOCKER(&analysis::dvvp::common::utils::Utils::GetSelfPath)
        .stubs()
        .will(returnValue(selfPath));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckStorageLimit)
        .stubs()
        .will(returnValue(false));

    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, Msprofiler::Api::ProfAclMgr::instance()->MsprofInitAclEnv(envsV));
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_json) {
    GlobalMockObject::verify();
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Uninit();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::MINI_TYPE));
    Platform::instance()->Init();
    std::string aclJson("{\"switch\": \"on\"}");
    auto data = (void *)(const_cast<char *>(aclJson.c_str()));

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_ACL_JSON, data, aclJson.size()));

    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfFinalize());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ge_option) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Uninit();
    Platform::instance()->Init();

    std::string result = "/tmp/profiler_st_ge_option";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);

    NanoJson::Json message;
    message["output"] = result;
    message["aic_metrics"] = "ArithmeticUtilization";
    message["training_trace"] = "on";
    message["task_trace"] = "on";
    message["aicpu"] = "on";
    message["task_block"] = "on";
    message["sys_hardware_mem_freq"] = 50;
    message["sys_io_sampling_freq"] = 50;
    message["dvpp_freq"] = 50;
    message["host_sys"] = "cpu,mem,disk,network,osrt";
    message["host_sys_usage"] = "cpu,mem";
    message["host_sys_usage_freq"] = 50;

    std::string geOption = message.ToString();
    MsprofGeOptions options = {0};
    strcpy(options.jobId, "jobId");
    for (size_t i = 0; i < geOption.size(); i++) {
        options.options[i] = geOption.at(i);
    }
    auto jsonData = (void *)&options;

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_GE_OPTIONS, jsonData, sizeof(options)));

    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfFinalize());

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_GE_OPTIONS, jsonData, sizeof(options)));

    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofFinalize());

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_DYNA, jsonData, sizeof(options)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofFinalize());
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, PureCpu) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofResultPathAdapter)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::string result = "/tmp/profiler_ut_pure_cpu";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);

    NanoJson::Json message;
    message["output"] = result;
    message["aic_metrics"] = "ArithmeticUtilization";
    message["task_trace"] = "on";

    std::string geOption = message.ToString();
    MsprofGeOptions options = {0};
    strcpy(options.jobId, "jobId");
    for (size_t i = 0; i < geOption.size(); i++) {
        options.options[i] = geOption.at(i);
    }
    auto jsonData = (void *)&options;
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, jsonData, sizeof(struct MsprofCommandHandleParams)));
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofFinalize());
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, init_env) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::string result = "/tmp/profiler_st_init_env";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::common::utils::Utils::CreateDir(result));
    std::string env = "{\"acl\":\"on\",\"aiCtrlCpuProfiling\":\"off\",\"ai_core_metrics\":\"PipeUtilization\", \
                       \"ai_core_profiling\":\"\",\"ai_core_profiling_events\":\"0x8,0xa,0x9,0xb,0xc,0xd,0x55\", \
                       \"ai_core_profiling_metrics\":\"\",\"ai_core_profiling_mode\":\"\",\"ai_core_status\":\"\", \
                       \"ai_ctrl_cpu_profiling_events\":\"\",\"ai_vector_status\":\"\",\"aicore_sampling_interval\":10, \
                       \"aicpuTrace\":\"\",\"aiv_metrics\":\"\",\"aiv_profiling\":\"\",\"aiv_profiling_events\":\"\", \
                       \"aiv_profiling_metrics\":\"\",\"aiv_profiling_mode\":\"\",\"aiv_sampling_interval\":10,\"app\":\"test\", \
                       \"app_dir\":\".\",\"app_env\":\"\",\"app_location\":\"\",\"app_parameters\":\"\", \
                       \"cpu_profiling\":\"off\",\"cpu_sampling_interval\":10,\"ctrl_mode\":3, \
                       \"dataSaveToLocal\":false,\"ddr_interval\":100,\"ddr_master_id\":0,\"ddr_profiling\":\"\",\"ddr_profiling_events\":\"\", \
                       \"devices\":\"\",\"dvpp_profiling\":\"off\",\"dvpp_sampling_interval\":100,\"hardware_mem\":\"off\", \
                       \"hardware_mem_sampling_interval\":100,\"hbmInterval\":100,\"hbmProfiling\":\"\",\"hbm_profiling_events\":\"\", \
                       \"hcclTrace\":\"\",\"hccsInterval\":100,\"hccsProfiling\":\"off\",\"hwts_log\":\"on\",\"hwts_log1\":\"on\", \
                       \"interconnection_profiling\":\"off\",\"interconnection_sampling_interval\":100,\"io_profiling\":\"off\", \
                       \"io_sampling_interval\":100,\"is_cancel\":false,\"jobInfo\":\"\",\"job_id\":\"\",\"l2CacheTaskProfiling\":\"\", \
                       \"l2CacheTaskProfilingEvents\":\"\",\"llc_interval\":100,\"llc_profiling\":\"capacity\", \
                       \"llc_profiling_events\":\"hisi_l3c0_1/dsid0/,hisi_l3c0_1/dsid1/,hisi_l3c0_1/dsid2/,hisi_l3c0_1/dsid3/,\
                       hisi_l3c0_1/dsid4/,hisi_l3c0_1/dsid5/,hisi_l3c0_1/dsid6/,hisi_l3c0_1/dsid7/\", \
                       \"msprof\":\"off\",\"nicInterval\":100,\"nicProfiling\":\"off\",\"pcieInterval\":100, \
                       \"pcieProfiling\":\"\",\"pid_profiling\":\"off\",\"pid_sampling_interval\":100,\"profiling_mode\":\"def_mode\", \
                       \"profiling_options\":\"\",\"profiling_period\":-1,\"result_dir\":\"/tmp/profiler_st_init_env\", \
                       \"roceInterval\":100,\"roceProfiling\":\"off\", \
                       \"runtimeApi\":\"off\",\"runtimeTrace\":\"\",\"sys_profiling\":\"off\", \
                       \"sys_sampling_interval\":100,\"traceId\":\"\",\"tsCpuProfiling\":\"off\",\"ts_cpu_hot_function\":\"\", \
                       \"ts_cpu_profiling_events\":\"\",\"ts_cpu_usage\":\"\",\"ts_fw_training\":\"\",\"ts_task_track\":\"\", \
                       \"ts_timeline\":\"on\",\"ts_track1\":\"\"}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_ACL_ENV, nullptr, 0));

    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);

    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfFinalize());
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, mode_protect) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->CallbackInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackFinalizePrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStartPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStopPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfFinalizePrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfSubscribePrecheck());
    EXPECT_EQ(true, ProfAclMgr::instance()->IsModeOff());

    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackInitPrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->CallbackFinalizePrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStartPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStopPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfFinalizePrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfSubscribePrecheck());
    EXPECT_EQ(false, ProfAclMgr::instance()->IsModeOff());

    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackFinalizePrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfInitPrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfStartPrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfStopPrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfFinalizePrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfSubscribePrecheck());
    EXPECT_EQ(false, ProfAclMgr::instance()->IsModeOff());

    ProfAclMgr::instance()->mode_ = WORK_MODE_SUBSCRIBE;
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->CallbackFinalizePrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfInitPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStartPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfStopPrecheck());
    EXPECT_NE(ACL_SUCCESS, ProfAclMgr::instance()->ProfFinalizePrecheck());
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfSubscribePrecheck());
    EXPECT_EQ(false, ProfAclMgr::instance()->IsModeOff());
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofTxSwitchPrecheck) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;

    int32_t ret = ProfAclMgr::instance()->MsprofTxSwitchPrecheck();
    EXPECT_EQ(PROFILING_FAILED, ret);
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;

    ret = ProfAclMgr::instance()->MsprofFinalizeHandle();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofTxApiHandle) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&ProfAclMgr::MsprofTxSwitchPrecheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&ProfAclMgr::DoHostHandle)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::instance()->params_ = params;

    int ret = ProfAclMgr::instance()->MsprofTxApiHandle(PROF_MSPROFTX);
    EXPECT_EQ(MSPROF_ERROR_NONE, ret);
    ret = ProfAclMgr::instance()->MsprofTxApiHandle(PROF_MSPROFTX);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = ProfAclMgr::instance()->MsprofTxApiHandle(PROF_MSPROFTX);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofTxHandle) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::Init)
        .stubs()
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    params->msproftx = "on";
    ProfAclMgr::instance()->params_ = params;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    ProfAclMgr::instance()->MsprofTxHandle();
    EXPECT_EQ(nullptr, aclprofCreateStamp());
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    ProfAclMgr::instance()->MsprofTxHandle();
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofHostSysHandle) {
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->UnInit();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    params->host_osrt_profiling = "on";
    ProfAclMgr::instance()->params_ = params;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    ProfAclMgr::instance()->MsprofTxHandle();
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofFinalizeHandle());
}

TEST_F(MSPROF_ACL_CORE_UTEST, DoHostHandle) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&ProfAclMgr::MsprofSetDeviceImpl)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    params->msproftx = "on";
    ProfAclMgr::instance()->params_ = params;

    int ret = ProfAclMgr::instance()->DoHostHandle();
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = ProfAclMgr::instance()->DoHostHandle();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    params->host_osrt_profiling = "on";
    ret = ProfAclMgr::instance()->DoHostHandle();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

static int _drv_get_dev_ids(int num_devices, std::vector<int> & dev_ids) {
    static int phase = 0;
    if (phase == 0) {
        phase++;
        return PROFILING_FAILED;
    }

    if (phase >= 1) {
        dev_ids.push_back(0);
        return PROFILING_SUCCESS;
    }
}

TEST_F(MSPROF_ACL_CORE_UTEST, HandleProfilingParams) {

    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, ""));
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, "abc"));
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));
    Platform::instance()->Init();
    EXPECT_NE(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));
    EXPECT_NE(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    EXPECT_NE(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfRpcHelper)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadCtrlFileData)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Init();
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
    EXPECT_NE(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, OpDescParserNullptr) {
    GlobalMockObject::verify();

    using namespace Analysis::Dvvp::Analyze;
    EXPECT_NE(ACL_SUCCESS, OpDescParser::GetOpNum(nullptr, 0, 0));
    uint32_t modelId = 0;
    OpDescParser::GetModelId(nullptr, 0, 0, &modelId);
    EXPECT_EQ(0, modelId);

    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpTypeLen(nullptr, 0, nullptr, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpType(nullptr, 0, nullptr, 0, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpNameLen(nullptr, 0, nullptr, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpName(nullptr, 0, nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpStart(nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpEnd(nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpDuration(nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpExecutionTime(nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpVectorFops(nullptr, 0, 0));
    EXPECT_EQ(0, OpDescParser::GetOpCubeFops(nullptr, 0, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::CheckData(nullptr, 100));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::GetOpFlag(nullptr, 100, 0));
    EXPECT_EQ(nullptr, OpDescParser::GetOpAttriValue(nullptr, 100, 0, ACL_SUBSCRIBE_ATTRI_THREADID));

    ProfOpDesc data;
    char buffer;
    data.opIndex = 100;
    data.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
        (uint8_t *)(&data) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpName((void *)&data, sizeof(ProfOpDesc), &buffer, 4, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpNameLen((void *)&data, sizeof(ProfOpDesc), (size_t *)&buffer, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpType((void *)&data, sizeof(ProfOpDesc), &buffer, 4, 0));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpTypeLen((void *)&data, sizeof(ProfOpDesc), (size_t *)&buffer, 0));

    OpDescParser::instance()->opNames_[data.opIndex] = "Conv2D";
    data.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
        (uint8_t *)(&data) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));
    EXPECT_NE(ACL_SUCCESS, OpDescParser::instance()->GetOpName((void *)&data, sizeof(ProfOpDesc), &buffer, 4, 0));
    OpDescParser::instance()->opNames_.clear();
    uint32_t threadId;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, OpDescParser::GetThreadId(nullptr, 0, 0, &threadId));
    uint32_t devId;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, OpDescParser::GetDeviceId(nullptr, 0, 0, &devId));
}

TEST_F(MSPROF_ACL_CORE_UTEST, RecordOutPut) {
    GlobalMockObject::verify();

    std::string env;
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);

    using namespace Msprofiler::Api;
    std::string data;
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->RecordOutPut(data));
    env = "{\"acl\":\"on\",\"aiCtrlCpuProfiling\":\"off\",\"ai_core_metrics\":\"PipeUtilization\", \
                       \"ai_core_profiling\":\"\",\"ai_core_profiling_events\":\"0x8,0xa,0x9,0xb,0xc,0xd,0x55\", \
                       \"ai_core_profiling_metrics\":\"\",\"ai_core_profiling_mode\":\"\",\"ai_core_status\":\"\", \
                       \"ai_ctrl_cpu_profiling_events\":\"\",\"ai_vector_status\":\"\",\"aicore_sampling_interval\":10, \
                       \"aicpuTrace\":\"\",\"aiv_metrics\":\"\",\"aiv_profiling\":\"\",\"aiv_profiling_events\":\"\", \
                       \"aiv_profiling_metrics\":\"\",\"aiv_profiling_mode\":\"\",\"aiv_sampling_interval\":10,\"app\":\"test\", \
                       \"app_dir\":\".\",\"app_env\":\"\",\"app_location\":\"\",\"app_parameters\":\"\", \
                       \"cpu_profiling\":\"off\",\"cpu_sampling_interval\":10,\"ctrl_mode\":3, \
                       \"dataSaveToLocal\":false,\"ddr_interval\":100,\"ddr_master_id\":0,\"ddr_profiling\":\"\",\"ddr_profiling_events\":\"\", \
                       \"devices\":\"\",\"dvpp_profiling\":\"off\",\"dvpp_sampling_interval\":100,\"hardware_mem\":\"off\", \
                       \"hardware_mem_sampling_interval\":100,\"hbmInterval\":100,\"hbmProfiling\":\"\",\"hbm_profiling_events\":\"\", \
                       \"hcclTrace\":\"\",\"hccsInterval\":100,\"hccsProfiling\":\"off\",\"hwts_log\":\"on\",\"hwts_log1\":\"on\", \
                       \"interconnection_profiling\":\"off\",\"interconnection_sampling_interval\":100,\"io_profiling\":\"off\", \
                       \"io_sampling_interval\":100,\"is_cancel\":false,\"jobInfo\":\"\",\"job_id\":\"\",\"l2CacheTaskProfiling\":\"\", \
                       \"l2CacheTaskProfilingEvents\":\"\",\"llc_interval\":100,\"llc_profiling\":\"capacity\", \
                       \"llc_profiling_events\":\"hisi_l3c0_1/dsid0/,hisi_l3c0_1/dsid1/,hisi_l3c0_1/dsid2/,hisi_l3c0_1/dsid3/,\
                       hisi_l3c0_1/dsid4/,hisi_l3c0_1/dsid5/,hisi_l3c0_1/dsid6/,hisi_l3c0_1/dsid7/\", \
                       \"msprof\":\"off\",\"nicInterval\":100,\"nicProfiling\":\"off\",\"pcieInterval\":100, \
                       \"pcieProfiling\":\"\",\"pid_profiling\":\"off\",\"pid_sampling_interval\":100,\"profiling_mode\":\"def_mode\", \
                       \"profiling_options\":\"\",\"profiling_period\":-1,\"result_dir\":\"/tmp/profiler_st_init_env\", \
                       \"roceInterval\":100,\"roceProfiling\":\"off\", \
                       \"runtimeApi\":\"off\",\"runtimeTrace\":\"\",\"sys_profiling\":\"off\", \
                       \"sys_sampling_interval\":100,\"traceId\":\"\",\"tsCpuProfiling\":\"off\",\"ts_cpu_hot_function\":\"\", \
                       \"ts_cpu_profiling_events\":\"\",\"ts_cpu_usage\":\"\",\"ts_fw_training\":\"\",\"ts_task_track\":\"\", \
                       \"ts_timeline\":\"on\",\"ts_track1\":\"\"}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->RecordOutPut(data));

    MOCKER(&analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&ProfAclMgr::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    ProfAclMgr::instance()->InitApiCtrlUploader("13");
}

TEST_F(MSPROF_ACL_CORE_UTEST, InitApiCtrlUploaderHelper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    setenv("ASCEND_HOSTPID", "2023", 1);
    std::string deviceId = "64";
    ProfAclMgr::instance()->curDevId_ = 0;
    ProfAclMgr::instance()->masterPid_ = "2023";
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HelperTransport>(
        new HelperTransport(session));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfRpcHelper)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Adx::AdxHdcClientCreate)
        .stubs()
        .will(returnValue((HDC_CLIENT)nullptr))
        .then(returnValue((HDC_CLIENT)0x12345678));
    MOCKER_CPP(&Analysis::Dvvp::Adx::AdxHalHdcSessionConnect)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HelperTransport::SendBuffer,
        int32_t(analysis::dvvp::transport::HelperTransport::*)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>))
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, ProfAclMgr::instance()->InitApiCtrlUploader(deviceId));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, ProfAclMgr::instance()->InitApiCtrlUploader(deviceId));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->InitApiCtrlUploader(deviceId));
    ProfAclMgr::instance()->MsprofFinalizeHandle();
}

TEST_F(MSPROF_ACL_CORE_UTEST, RecordOutPut2) {
    GlobalMockObject::verify();

    std::string env = "{}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);
    std::string data = "PROFXXX";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());

    using namespace Msprofiler::Api;

    ProfAclMgr::instance()->params_ = params;
    ProfAclMgr::instance()->params_->msprofBinPid = 2;

    MOCKER_CPP(WriteFile)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->RecordOutPut(data));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->RecordOutPut(data));
}

TEST_F(MSPROF_ACL_CORE_UTEST, EnableRpcHelperMode) {
    GlobalMockObject::verify();

    std::string env = "{}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());

    using namespace Msprofiler::Api;

    EXPECT_EQ(true, ProfAclMgr::instance()->EnableRpcHelperMode("11"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitAclJson) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::string aclJson = "";
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    std::string result = "/tmp/MsprofInitAclJson";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"on\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"xx\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"off\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"on\",\"ge_api\": \"l1\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"on\",\"ge_api\": \"L1\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"L1\",\"ge_api\": \"off\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"l0\",\"ge_api\": \"l1\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"off\",\"ge_api\": \"off\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_trace\": \"task\",\"ge_api\": \"fwk\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));

    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_memory\": \"on\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_memory\": \"off\"}";
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"task_memory\": \"tasktask\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitAclJsonNano) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_NANO_V1));
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::string result = "/tmp/MsprofInitAclJson";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    std::string aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"ge_api\": \"l0\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));

    aclJson = "{\"switch\": \"on\", \"output\": \"output\",\"l2\": \"on\"}";
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitAclJson((void *)aclJson.c_str(), aclJson.size()));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    // reset Platform
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofCheckAndGetChar) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    std::string test = "test";
    std::string test1;
    EXPECT_EQ(test1, ProfAclMgr::instance()->MsprofCheckAndGetChar(const_cast<char *>(test.c_str()), test.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitGeOptionsParamAdaper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());

    NanoJson::Json message;
    message["aicpu"] = "on";
    message["training_trace"] = "on";
    message["task_trace"] = "on";
    message["task_tsfw"] = "on";
    std::string jobInfo = "123";

    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(nullptr, jobInfo, message);
    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(params, jobInfo, message);
    EXPECT_EQ("on", params->aicpuTrace);
    EXPECT_EQ("on", params->ts_fw_training);
    EXPECT_EQ("level1", params->prof_level);
    EXPECT_EQ("on", params->taskTsfw);
    EXPECT_EQ(analysis::dvvp::common::utils::Utils::GetPid(), params->host_sys_pid);
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofGeOptionsResultPathAdapter) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    using namespace Msprofiler::Api;
    std::string path;
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->MsprofResultPathAdapter("", path));
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->MsprofResultPathAdapter("./", path));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofResultPathAdapter("./", path));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir).stubs().will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofResultPathAdapter("./", path));

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    ProfAclMgr::instance()->MsprofResultPathAdapter("./", path);

    std::string work_path = "/tmp/ascend_work_path/";
    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString).stubs().will(returnValue(work_path));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath).stubs().will(returnValue(work_path));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofResultPathAdapter("", path));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitGeOptions) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitGeOptions(nullptr, 2));
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    struct MsprofGeOptions options = {0};
    std::string result = "/tmp/MsprofInitGeOptions";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    std::string ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"off\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"xx\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"ArithmeticUtilization\",\"aicpu\": \"on\",\"l2\": \"on\",\"aiv_metrics\": \"ArithmeticUtilization\",\"aiv-mode\": \"sampling-based\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0xd\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0xpp\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0x10,0x20\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,100,0x123,200\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"on\",\"ge_api\": \"off\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"off\",\"ge_api\": \"off\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"L1\",\"ge_api\": \"off\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"off\",\"ge_api\": \"L1\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"L0\",\"ge_api\": \"l1\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_trace\": \"task\",\"ge_api\": \"fwk\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));

    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_memory\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_memory\": \"off\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"task_memory\": \"tasktask\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitGeOptionsWithErrJsonStr) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    struct MsprofGeOptions options = {0};
    strcpy(options.jobId, "0");
    strcpy(options.options, "123");
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofAclJsonParamConstruct) {
    GlobalMockObject::verify();
    NanoJson::Json inputCfgPb;
    Msprofiler::Api::ProfAclMgr profAclMgr;
    inputCfgPb["output"] = "";
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    configManger->configMap_["type"] = "5";
    configManger->isInit_ = true;
    inputCfgPb["l2"] = "on";
    inputCfgPb["instr_profiling"] = "on";
    inputCfgPb["instr_profiling_freq"] = 300;
    inputCfgPb["task_trace"] = "on";
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0))
        .then(returnValue(PlatformType::MINI_V3_TYPE));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    configManger->Uninit();
    MOCKER(readlink)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofResultDirAdapter) {
    GlobalMockObject::verify();
    Msprofiler::Api::ProfAclMgr profAclMgr;
    std::string dir = "";
    std::string work_path = "/tmp/ascend_work_path/";
    std::string profiling_path = "profiling_data";
    std::string result_path = work_path + profiling_path;

    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString).stubs().will(returnValue(work_path));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath).stubs().will(returnValue(result_path));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible).stubs().will(returnValue(true));

    EXPECT_EQ(result_path, profAclMgr.MsprofResultDirAdapter(dir));
    EXPECT_EQ(result_path, profAclMgr.MsprofResultDirAdapter(dir));
    dir = "/tmp";
    EXPECT_EQ(result_path, profAclMgr.MsprofResultDirAdapter(dir));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofGeOptionsParamConstruct) {
    GlobalMockObject::verify();
    Msprofiler::Api::ProfAclMgr profAclMgr;
    NanoJson::Json inputCfgPbo;
    inputCfgPbo["output"] = "";
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofResultPathAdapter)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    inputCfgPbo["aic_metrics"] = "Pipe";
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    inputCfgPbo["aic_metrics"] = "PipeUtilization";
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    configManger->configMap_["type"] = "5";
    configManger->isInit_ = true;
    inputCfgPbo["l2"] = "on";
    inputCfgPbo["instr_profiling"] = "on";
    inputCfgPbo["instr_profiling_freq"] = 300;
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    configManger->Uninit();
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckStorageLimit,
        bool(ParamValidation::*)(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitHelper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitHelper(nullptr, 0));
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    struct MsprofCommandHandleParams commandHandleParams;
    memset(&commandHandleParams, 0, sizeof(MsprofCommandHandleParams));
    std::string result = "/tmp/MsprofInitHelper";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitHelper((void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    commandHandleParams.pathLen = result.size();
    strncpy(commandHandleParams.path, result.c_str(), 1024);
    commandHandleParams.storageLimit = 250;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::string jsonParams = params->ToString();
    commandHandleParams.profDataLen = jsonParams.size();
    strncpy(commandHandleParams.profData, jsonParams.c_str(), 4096);
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitHelper((void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_HELPER, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    MsprofFinalize();
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofInitPureCpu) {
    GlobalMockObject::verify();

    using namespace Msprofiler::Api;
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitPureCpu(nullptr, 0));
    MOCKER(getenv)
        .stubs()
        .will(returnValue((char *)nullptr));
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue((char *)nullptr));
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    struct MsprofCommandHandleParams commandHandleParams;
    memset(&commandHandleParams, 0, sizeof(MsprofCommandHandleParams));
    std::string result = "/tmp/MsprofInitPureCpu";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitPureCpu((void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    commandHandleParams.pathLen = result.size();
    strncpy(commandHandleParams.path, result.c_str(), 1024);
    commandHandleParams.storageLimit = 250;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/MsprofInitPureCpu/PROF_0001_XXX\", \"devices\":\"1\", \"job_id\":\"1\", \"taskTime\":\"on\"}");
    std::string jsonParams = params->ToString();
    commandHandleParams.profDataLen = jsonParams.size();
    strncpy(commandHandleParams.profData, jsonParams.c_str(), 4096);
    EXPECT_EQ(0, ProfAclMgr::instance()->MsprofInitPureCpu((void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckStorageLimit)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofResultPathAdapter)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    MOCKER(Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    MOCKER(Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandHandleParams, sizeof(MsprofCommandHandleParams)));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    MsprofFinalize();
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofHostHandle) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
     ProfAclMgr::instance()->MsprofHostHandle();
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReporterApiData) {
    GlobalMockObject::verify();
    using namespace Msprof::Engine;
    ReceiveData rData;
    uint32_t age = 1;
    MsprofApi data;
    data.level = 10000;
    MOCKER(apiTryPop)
        .stubs()
        .with(outBound(age), outBound(data))
        .will(returnValue(true))
        .then(returnValue(false));
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk> > fileChunksVec = {};
    rData.ApiRun(fileChunksVec);
    EXPECT_EQ(1, fileChunksVec.size());
    GlobalMockObject::verify();

    MsprofApi zero;
    zero.level = 0;
    MOCKER(apiTryPop)
        .stubs()
        .with(outBound(age), outBound(zero))
        .will(returnValue(true))
        .then(returnValue(false));
    rData.ApiRun(fileChunksVec);
    EXPECT_EQ(1, fileChunksVec.size());
    GlobalMockObject::verify();
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReporterCompactData) {
    GlobalMockObject::verify();
    using namespace Msprof::Engine;
    ReceiveData rData;
    uint32_t age = 1;
    MsprofCompactInfo data;
    data.level = 10000;
    MOCKER(compactTryPop)
        .stubs()
        .with(outBound(age), outBound(data))
        .will(returnValue(true))
        .then(returnValue(false));
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk> > fileChunksVec = {};
    rData.CompactRun(fileChunksVec);
    EXPECT_EQ(1, fileChunksVec.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReporterAdditionalData) {
    GlobalMockObject::verify();
    using namespace Msprof::Engine;
    ReceiveData rData;
    uint32_t age = 1;
    MsprofAdditionalInfo data;
    data.level = 10000;
    MOCKER(additionalTryPop)
        .stubs()
        .with(outBound(age), outBound(data))
        .will(returnValue(true))
        .then(returnValue(false));
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk> > fileChunksVec = {};
    rData.AdditionalRun(fileChunksVec);
    EXPECT_EQ(1, fileChunksVec.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReporterData) {
    GlobalMockObject::verify();

    using namespace analysis::dvvp::common::config;

    ReporterData reporterData;
    reporterData.tag[0] = 't';
    reporterData.tag[1] = 'e';
    reporterData.tag[2] = 's';
    reporterData.tag[3] = 't';
    reporterData.tag[4] = 0;
    reporterData.deviceId = 0;
    reporterData.dataLen = 1;
    unsigned char data[100] = {"test"};
    reporterData.data = data;

    Msprof::Engine::ReceiveData recData;
    recData.Init(RING_BUFF_CAPACITY);
    recData.started_ = false;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));

    recData.started_ = true;
    int ret = PROFILING_SUCCESS;
    for (int i = 0; i < RING_BUFF_CAPACITY; i++) {
        ret = recData.DoReport(&reporterData);
    }
    EXPECT_EQ(PROFILING_FAILED, ret);

    reporterData.data = nullptr;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));

    reporterData.data = data;
    reporterData.dataLen = 1025;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(-1));
    reporterData.dataLen = 1;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
}

TEST_F(MSPROF_ACL_CORE_UTEST, AddToUploaderGetUploaderFailed) {
    GlobalMockObject::verify();
    std::shared_ptr<Msprof::Engine::UploaderDumper> dumper(new Msprof::Engine::UploaderDumper("Framework"));

    HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 30;
    hwtsChunk.streamId = 100;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 1000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data.null";
    hwts->chunk = reinterpret_cast<char *>(&hwtsChunk);
    hwts->chunkSize = sizeof(HwtsProfileType01);
    hwts->extraInfo = "0.0";

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .will(returnValue(nullptr));

    dumper->AddToUploader(hwts);
    EXPECT_EQ(hwts->chunkModule, 1);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_TsDataPostProc) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();

    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    TsProfileKeypoint data;
    data.head.bufSize = 0;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.taskId = 1;
    data.streamId = 1;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.modelId = 4;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    analyzer->profileMode_ = PROFILE_MODE_INVALID;
    analyzer->TsDataPostProc();
    EXPECT_EQ(PROFILE_MODE_STEP_TRACE, analyzer->profileMode_);

    analyzer->profileMode_ = PROFILE_MODE_INVALID;
    analyzer->TsDataPostProc();
    EXPECT_EQ(PROFILE_MODE_STEP_TRACE, analyzer->profileMode_);

    analyzer->profileMode_ = PROFILE_MODE_INVALID;
    analyzer->graphTypeFlag_ = true;
    analyzer->TsDataPostProc();
    EXPECT_EQ(PROFILE_MODE_STEP_TRACE, analyzer->profileMode_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_Ffts_PrintStats) {
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->analyzerFfts_->PrintStats();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadTsOp) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();

    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::IsOpInfoCompleted)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    TsProfileTimeline data;
    data.taskId = 0;
    data.streamId = 0;
    data.timestamp = 1000000;
    data.taskState = TS_TIMELINE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.taskId = 1;
    data.taskState = TS_TIMELINE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.taskId = 2;
    data.taskState = TS_TIMELINE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_AICORE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskState = TS_TIMELINE_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsTimelineData((CONST_CHAR_PTR)(&data), sizeof(data));

    auto &tsOpTimes = analyzer->analyzerTs_->opTimes_;
    int ind = 0;
    for (auto iter = tsOpTimes.begin(); iter != tsOpTimes.end(); iter++) {
        iter->second.indexId = ind++;
    }

    analyzer->profileMode_ = PROFILE_MODE_STEP_TRACE;
    analyzer->UploadAppOp(tsOpTimes);
    EXPECT_EQ(1, analyzer->analyzerTs_->opTimes_.size());

    analyzer->profileMode_ = PROFILE_MODE_SINGLE_OP;
    analyzer->UploadAppOp(tsOpTimes);
    EXPECT_EQ(0, analyzer->analyzerTs_->opTimes_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, InitFrequency) {
    Analysis::Dvvp::Analyze::AnalyzerBase frequency;
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    configManger->configMap_["frq"] = "0";
    configManger->isInit_ = true;
    EXPECT_EQ(PROFILING_FAILED, frequency.InitFrequency());
    configManger->configMap_["frq"] = "1000";
    EXPECT_EQ(PROFILING_SUCCESS, frequency.InitFrequency());
    configManger->Uninit();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Buffer_RemainingData) {
    Analysis::Dvvp::Analyze::AnalyzerBase Buffer;
    uint32_t offset = 20;
    Buffer.dataLen_ = 20;
    Buffer.buffer_ = "test";
    Buffer.BufferRemainingData(offset);
    EXPECT_EQ(true, Buffer.buffer_.empty());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerRt_Parse) {
    SHARED_PTR_ALIA<AnalyzerRt> analyzerRt(new AnalyzerRt());
    analyzerRt->RtCompactParse(nullptr);

    MsprofCompactInfo rtDataChunk;
    rtDataChunk.level = MSPROF_REPORT_RUNTIME_LEVEL;
    std::string rtData((char *)&rtDataChunk, sizeof(rtDataChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtTaskDesc(new analysis::dvvp::ProfileFileChunk());
    rtTaskDesc->fileName = "unaging.compact";
    rtTaskDesc->chunk = rtData;
    rtTaskDesc->chunkSize = sizeof(rtDataChunk);
    analyzerRt->totalBytes_ = 0;
    analyzerRt->RtCompactParse(rtTaskDesc);
    EXPECT_EQ(sizeof(rtDataChunk), analyzerRt->totalBytes_);

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtTaskDesc2(new analysis::dvvp::ProfileFileChunk());
    rtTaskDesc2->fileName = "aging.compact";
    rtTaskDesc2->chunk = rtData;
    rtTaskDesc2->chunkSize = sizeof(rtDataChunk);
    analyzerRt->totalBytes_ = 0;
    analyzerRt->RtCompactParse(rtTaskDesc2);
    EXPECT_EQ(sizeof(rtDataChunk), analyzerRt->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerRt_HandleUnAgingRuntimeTrackData) {
    GlobalMockObject::verify();
    std::shared_ptr<AnalyzerRt> analyzerRt(new AnalyzerRt());
    analyzerRt->rtOpInfo_ = {};
    MsprofCompactInfo rtData;
    rtData.timeStamp = 1000;
    rtData.threadId = 1;
    rtData.data.runtimeTrack.taskId = 1;
    rtData.data.runtimeTrack.streamId = 1;
    RtOpInfo rtInfo;
    analyzerRt->rtOpInfo_["1-1"] = rtInfo;
    analyzerRt->HandleRuntimeTrackData((CONST_CHAR_PTR)(&rtData), false);
    EXPECT_EQ(1, analyzerRt->rtOpInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerRt_MatchDeviceOpInfo) {
    GlobalMockObject::verify();
    std::shared_ptr<AnalyzerRt> analyzerRt(new AnalyzerRt());
    analyzerRt->rtOpInfo_ = {};
    analyzerRt->tsTmpOpInfo_ = {};
    analyzerRt->devTmpOpInfo_ = {};
    analyzerRt->geOpInfo_ = {};
    analyzerRt->opDescInfos_ = {};

    RtOpInfo devTmpData;
    devTmpData.threadId = 1;
    devTmpData.ageFlag = false;
    analyzerRt->tsTmpOpInfo_.insert(std::pair<std::string, RtOpInfo>("1-1", devTmpData));

    analyzerRt->MatchDeviceOpInfo(analyzerRt->rtOpInfo_, analyzerRt->tsTmpOpInfo_, analyzerRt->geOpInfo_);
    EXPECT_EQ(0, analyzerRt->opDescInfos_.size());
    EXPECT_EQ(1, analyzerRt->tsTmpOpInfo_.size());

    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 1000;
    rtInfo.threadId = 1;
    rtInfo.ageFlag = false;
    analyzerRt->rtOpInfo_["1-1"] = rtInfo;

    analyzerRt->MatchDeviceOpInfo(analyzerRt->rtOpInfo_, analyzerRt->tsTmpOpInfo_, analyzerRt->geOpInfo_);
    EXPECT_EQ(0, analyzerRt->opDescInfos_.size());
    EXPECT_EQ(1, analyzerRt->devTmpOpInfo_.size());
    EXPECT_EQ(0, analyzerRt->tsTmpOpInfo_.size());

    GeOpFlagInfo geOpData;
    geOpData.start = 100;
    geOpData.end = 2000;
    geOpData.ageFlag = false;
    analyzerRt->geOpInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geOpData));
    analyzerRt->tsTmpOpInfo_.insert(std::pair<std::string, RtOpInfo>("1-1", devTmpData));

    analyzerRt->MatchDeviceOpInfo(analyzerRt->rtOpInfo_, analyzerRt->tsTmpOpInfo_, analyzerRt->geOpInfo_);
    EXPECT_EQ(1, analyzerRt->opDescInfos_.size());
    EXPECT_EQ(0, analyzerRt->tsTmpOpInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerRt_MatchDeviceOpInfoNotMatch) {
    GlobalMockObject::verify();
    std::shared_ptr<AnalyzerRt> analyzerRt(new AnalyzerRt());
    analyzerRt->rtOpInfo_ = {};
    analyzerRt->tsTmpOpInfo_ = {};
    analyzerRt->devTmpOpInfo_ = {};
    analyzerRt->geOpInfo_ = {};
    analyzerRt->opDescInfos_ = {};
    RtOpInfo devTmpData;
    GeOpFlagInfo geOpData;
    RtOpInfo rtInfo;
    rtInfo.ageFlag = false;
    devTmpData.tsTrackTimeStamp = 3;
    devTmpData.ageFlag = false;
    geOpData.start = 1;
    geOpData.end = 2;
    geOpData.ageFlag = false;
    analyzerRt->tsTmpOpInfo_.insert(std::pair<std::string, RtOpInfo>("1-1", devTmpData));
    analyzerRt->geOpInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geOpData));
    analyzerRt->rtOpInfo_["1-1"] = rtInfo;
    analyzerRt->MatchDeviceOpInfo(analyzerRt->rtOpInfo_, analyzerRt->tsTmpOpInfo_, analyzerRt->geOpInfo_);
    EXPECT_EQ(0, analyzerRt->opDescInfos_.size());
    EXPECT_EQ(1, analyzerRt->devTmpOpInfo_.size());
    EXPECT_EQ(0, analyzerRt->tsTmpOpInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerHwts_HandleOptimizeStartEndData) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerHwts> analyzerHwts(new AnalyzerHwts());

    analyzerHwts->rtOpInfo_ = {};
    analyzerHwts->geOpInfo_ = {};
    analyzerHwts->opDescInfos_ = {};
    analyzerHwts->tsOpInfo_ = {};
    analyzerHwts->devTmpOpInfo_ = {};
    analyzerHwts->frequency_ = 1000;

    HwtsProfileType01 hwtsDataStart;
    hwtsDataStart.syscnt = 1000;
    hwtsDataStart.taskId = 1;
    hwtsDataStart.streamId = 1;
    HwtsProfileType01 hwtsDataEnd;
    hwtsDataEnd.syscnt = 3000;
    hwtsDataEnd.taskId = 1;
    hwtsDataEnd.streamId = 1;

    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 3;
    rtInfo.threadId = 1;
    rtInfo.ageFlag = false;

    analyzerHwts->rtOpInfo_["1-1"] = rtInfo;
    analyzerHwts->HandleOptimizeStartEndData((CONST_CHAR_PTR)(&hwtsDataStart), HWTS_TASK_START_TYPE);
    analyzerHwts->HandleOptimizeStartEndData((CONST_CHAR_PTR)(&hwtsDataEnd), HWTS_TASK_END_TYPE);
    EXPECT_EQ(1, analyzerHwts->rtOpInfo_.size());
    EXPECT_EQ(1, analyzerHwts->devTmpOpInfo_.size());
    EXPECT_EQ(0, analyzerHwts->opDescInfos_.size());

    GeOpFlagInfo geOpData;
    geOpData.start = 1;
    geOpData.end = 10;
    analyzerHwts->geOpInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geOpData));

    analyzerHwts->HandleOptimizeStartEndData((CONST_CHAR_PTR)(&hwtsDataStart), HWTS_TASK_START_TYPE);
    analyzerHwts->HandleOptimizeStartEndData((CONST_CHAR_PTR)(&hwtsDataEnd), HWTS_TASK_END_TYPE);
    EXPECT_EQ(1, analyzerHwts->devTmpOpInfo_.size());
    EXPECT_EQ(1, analyzerHwts->opDescInfos_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerFfts_OptimizeParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerFfts> analyzerFfts(new Analysis::Dvvp::Analyze::AnalyzerFfts());
    struct StarsAcsqLog fftsTaskDescChunk;
    std::string fftsOriData((char *)&fftsTaskDescChunk, sizeof(fftsTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fftsTaskDesc(new analysis::dvvp::ProfileFileChunk());
    fftsTaskDesc->fileName = "stars_soc.data";
    fftsTaskDesc->chunk = fftsOriData;
    fftsTaskDesc->chunkSize = sizeof(fftsTaskDescChunk);
    analyzerFfts->totalBytes_ = 0;
    analyzerFfts->FftsParse(nullptr);
    analyzerFfts->FftsParse(fftsTaskDesc);
    EXPECT_EQ(sizeof(fftsTaskDescChunk), analyzerFfts->totalBytes_);

    struct StarsLogHead fftsTaskHead;
    fftsTaskHead.logType = ACSQ_TASK_START_FUNC_TYPE;
    analyzerFfts->ParseOptimizeFftsData((char *)&fftsTaskDescChunk, sizeof(fftsTaskDescChunk));
    EXPECT_EQ(2 * STARS_DATA_SIZE, analyzerFfts->analyzedBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerFfts_HandleOptimizeStartEndData) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerFfts> analyzerFfts(new AnalyzerFfts());

    analyzerFfts->rtOpInfo_ = {};
    analyzerFfts->opDescInfos_ = {};
    analyzerFfts->tsOpInfo_ = {};
    analyzerFfts->frequency_ = 1000;

    StarsAcsqLog FftsDataStart;
    FftsDataStart.sysCountLow = 1;
    FftsDataStart.sysCountHigh = 1;
    FftsDataStart.taskId = 1;
    FftsDataStart.streamId = 4097; // 2^12 + 1
    FftsDataStart.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    StarsAcsqLog FftsDataEnd;
    FftsDataEnd.sysCountLow = 1;
    FftsDataEnd.sysCountHigh = 1;
    FftsDataEnd.taskId = 1;
    FftsDataEnd.streamId = 1;
    FftsDataEnd.head.logType = ACSQ_TASK_END_FUNC_TYPE;

    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 3;
    rtInfo.threadId = 1;
    rtInfo.ageFlag = false;

    analyzerFfts->rtOpInfo_["1-1"] = rtInfo;
    analyzerFfts->HandleOptimizeAcsqTaskData(&FftsDataStart, ACSQ_TASK_START_FUNC_TYPE);
    analyzerFfts->HandleOptimizeAcsqTaskData(&FftsDataEnd, ACSQ_TASK_END_FUNC_TYPE);
    EXPECT_EQ(1, analyzerFfts->rtOpInfo_.size());
    EXPECT_EQ(0, analyzerFfts->opDescInfos_.size());

    analyzerFfts->rtOpInfo_.clear();
    analyzerFfts->ParseOptimizeFftsData((char *)(&FftsDataStart), sizeof(FftsDataStart));
    analyzerFfts->ParseOptimizeFftsData((char *)(&FftsDataEnd), sizeof(FftsDataEnd));
    EXPECT_EQ(0, analyzerFfts->rtOpInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerFfts_HandleOptimizeStartEndData_david) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Platform::Platform::GetMaxMonitorNumber)
        .stubs()
        .will(returnValue(static_cast<uint16_t>(10)));
    std::shared_ptr<AnalyzerFfts> analyzerFfts(new AnalyzerFfts());

    analyzerFfts->rtOpInfo_ = {};
    analyzerFfts->opDescInfos_ = {};
    analyzerFfts->tsOpInfo_ = {};
    analyzerFfts->frequency_ = 1000;

    DavidAcsqLog FftsDataStart;
    FftsDataStart.sysCountLow = 1;
    FftsDataStart.sysCountHigh = 1;
    FftsDataStart.taskId = 1;
    FftsDataStart.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    DavidAcsqLog FftsDataEnd;
    FftsDataEnd.sysCountLow = 1;
    FftsDataEnd.sysCountHigh = 1;
    FftsDataEnd.taskId = 1;
    FftsDataEnd.head.logType = ACSQ_TASK_END_FUNC_TYPE;

    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 3;
    rtInfo.threadId = 1;
    rtInfo.ageFlag = false;

    analyzerFfts->rtOpInfo_["1"] = rtInfo;
    analyzerFfts->HandleOptimizeAcsqTaskData((const DavidAcsqLog *)(&FftsDataStart), ACSQ_TASK_START_FUNC_TYPE);
    analyzerFfts->HandleOptimizeAcsqTaskData((const DavidAcsqLog *)(&FftsDataEnd), ACSQ_TASK_END_FUNC_TYPE);
    EXPECT_EQ(1, analyzerFfts->rtOpInfo_.size());
    EXPECT_EQ(0, analyzerFfts->opDescInfos_.size());

    analyzerFfts->rtOpInfo_.clear();
    analyzerFfts->ParseOptimizeFftsData((char *)(&FftsDataStart), sizeof(FftsDataStart));
    analyzerFfts->ParseOptimizeFftsData((char *)(&FftsDataEnd), sizeof(FftsDataEnd));
    EXPECT_EQ(0, analyzerFfts->rtOpInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerFfts_HandleOptimizeSubTaskThreadData) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerFfts> analyzerFfts(new AnalyzerFfts());

    analyzerFfts->rtOpInfo_ = {};
    analyzerFfts->opDescInfos_ = {};
    analyzerFfts->tsOpInfo_ = {};
    analyzerFfts->frequency_ = 1000;

    StarsCxtLog FftsDataStart;
    FftsDataStart.sysCountLow = 1;
    FftsDataStart.sysCountHigh = 1;
    FftsDataStart.taskId = 1;
    FftsDataStart.streamId = 8193; // 2^13 + 1
    StarsCxtLog FftsDataEnd;
    FftsDataEnd.sysCountLow = 1;
    FftsDataEnd.sysCountHigh = 1;
    FftsDataEnd.taskId = 1;
    FftsDataEnd.streamId = 1;

    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 3;
    rtInfo.threadId = 1;
    rtInfo.ageFlag = false;

    analyzerFfts->rtOpInfo_["1-1"] = rtInfo;
    analyzerFfts->HandleOptimizeSubTaskThreadData(&FftsDataStart, FFTS_SUBTASK_THREAD_START_FUNC_TYPE);
    analyzerFfts->HandleOptimizeSubTaskThreadData(&FftsDataEnd, FFTS_SUBTASK_THREAD_END_FUNC_TYPE);
    EXPECT_EQ(1, analyzerFfts->rtOpInfo_.size());
    EXPECT_EQ(0, analyzerFfts->opDescInfos_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_CompactParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofCompactInfo geTaskDescChunk;
    geTaskDescChunk.level = MSPROF_REPORT_NODE_LEVEL;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "unaging.compact.node_basic_info";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeCompactParse(geTaskDesc);
    EXPECT_EQ(sizeof(geTaskDescChunk), analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_CcontextParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofAdditionalInfo geTaskDescChunk;
    geTaskDescChunk.level = MSPROF_REPORT_NODE_LEVEL;
    geTaskDescChunk.type = MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "unaging.compact.context_id_info";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeContextParse(geTaskDesc);
    EXPECT_EQ(sizeof(geTaskDescChunk), analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_UnAgingEventParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofEvent geUnAgingTaskDescChunk;
    geUnAgingTaskDescChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    geUnAgingTaskDescChunk.type = MSPROF_REPORT_MODEL_LOAD_TYPE;
    std::string geUnAgingOriData((char *)&geUnAgingTaskDescChunk, sizeof(geUnAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geUnAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geUnAgingTaskDesc->fileName = "unaging.api_event";
    geUnAgingTaskDesc->chunk = geUnAgingOriData;
    geUnAgingTaskDesc->chunkSize = sizeof(geUnAgingTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeApiAndEventParse(geUnAgingTaskDesc);
    EXPECT_EQ(sizeof(geUnAgingTaskDescChunk), analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_AgingEventParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofEvent geAgingTaskDescChunk;
    geAgingTaskDescChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    geAgingTaskDescChunk.type = MSPROF_REPORT_MODEL_LOAD_TYPE;
    std::string geAgingOriData((char *)&geAgingTaskDescChunk, sizeof(geAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geAgingTaskDesc->fileName = "aging.api_event";
    geAgingTaskDesc->chunk = geAgingOriData;
    geAgingTaskDesc->chunkSize = sizeof(geAgingTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeApiAndEventParse(geAgingTaskDesc);
    EXPECT_EQ(0, analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_UnAgingApiParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofApi geUnAgingTaskDescChunk;
    geUnAgingTaskDescChunk.level = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    std::string geUnAgingOriData((char *)&geUnAgingTaskDescChunk, sizeof(geUnAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geUnAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geUnAgingTaskDesc->fileName = "unaging.api_event";
    geUnAgingTaskDesc->chunk = geUnAgingOriData;
    geUnAgingTaskDesc->chunkSize = sizeof(geUnAgingTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeApiAndEventParse(geUnAgingTaskDesc);
    EXPECT_EQ(sizeof(geUnAgingTaskDescChunk), analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_AgingApiParse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());

    struct MsprofApi geAgingTaskDescChunk;
    geAgingTaskDescChunk.level = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    std::string geAgingOriData((char *)&geAgingTaskDescChunk, sizeof(geAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geAgingTaskDesc->fileName = "aging.api_event";
    geAgingTaskDesc->chunk = geAgingOriData;
    geAgingTaskDesc->chunkSize = sizeof(geAgingTaskDescChunk);
    analyzerGe->totalBytes_ = 0;
    analyzerGe->GeApiAndEventParse(geAgingTaskDesc);
    EXPECT_EQ(0, analyzerGe->totalBytes_);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_HandleNodeBasicInfo) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());
    analyzerGe->geNodeInfo_ = {};
    analyzerGe->isFftsPlus_ = false;

    MsprofCompactInfo GeData;
    GeData.threadId = 1;
    GeData.timeStamp = 1000;

    analyzerGe->HandleNodeBasicInfo((CONST_CHAR_PTR)(&GeData), false);
    std::string FFTSTYPE = "FFTS_PLUS";
    MOCKER_CPP(&HashData::GetHashInfo)
        .stubs()
        .will(returnValue(FFTSTYPE));
    analyzerGe->HandleNodeBasicInfo((CONST_CHAR_PTR)(&GeData), false);
    EXPECT_EQ(1, analyzerGe->geNodeInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_HandleApiInfo) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());
    analyzerGe->geApiInfo_ = {};

    MsprofApi GeData;
    GeData.threadId = 1;
    GeData.beginTime = 10;
    GeData.endTime = 1000;

    analyzerGe->HandleApiInfo((CONST_CHAR_PTR)(&GeData), false);
    EXPECT_EQ(1, analyzerGe->geApiInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_HandleModelInfo) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());

    analyzerGe->geModelInfo_ = {};

    MsprofEvent geOpData;
    geOpData.threadId = 1;
    geOpData.itemId = 1;
    geOpData.timeStamp = 1;
    analyzerGe->HandleModelInfo((CONST_CHAR_PTR)(&geOpData), false);
    EXPECT_EQ(1, analyzerGe->geModelInfo_.size());

    MsprofEvent geOpData2;
    geOpData2.threadId = 1;
    geOpData2.itemId = 2;
    geOpData2.timeStamp = 2;
    analyzerGe->HandleModelInfo((CONST_CHAR_PTR)(&geOpData2), false);
    EXPECT_EQ(2, analyzerGe->geModelInfo_.size());

    MsprofEvent geOpData3;
    geOpData3.threadId = 1;
    geOpData3.itemId = 1;
    geOpData3.timeStamp = 3;
    analyzerGe->HandleModelInfo((CONST_CHAR_PTR)(&geOpData3), false);
    EXPECT_EQ(2, analyzerGe->geModelInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_MatchDeviceInfo) {
    GlobalMockObject::verify();
    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());

    analyzerGe->geOpInfo_ = {};
    analyzerGe->devTmpOpInfo_ = {};
    analyzerGe->opDescInfos_ = {};

    RtOpInfo devTmpData;
    devTmpData.tsTrackTimeStamp = 10;
    devTmpData.threadId = 1;
    analyzerGe->devTmpOpInfo_.emplace_back(std::move(devTmpData));
    RtOpInfo devTmpData2;
    devTmpData2.tsTrackTimeStamp = 100;
    devTmpData2.threadId = 1;
    analyzerGe->devTmpOpInfo_.emplace_back(std::move(devTmpData2));

    GeOpFlagInfo opInfo;
    opInfo.start = 1;
    opInfo.end = 50;
    analyzerGe->geOpInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, opInfo));

    analyzerGe->MatchDeviceOpInfo(analyzerGe->devTmpOpInfo_, analyzerGe->geOpInfo_);
    EXPECT_EQ(1, analyzerGe->devTmpOpInfo_.size());
    EXPECT_EQ(1, analyzerGe->opDescInfos_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_MatchApiInfo) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());

    analyzerGe->geContextInfo_ = {};
    analyzerGe->geApiInfo_ = {};
    analyzerGe->geModelInfo_ = {};
    analyzerGe->geNodeInfo_ = {};
    analyzerGe->geOpInfo_ = {};
    analyzerGe->devTmpOpInfo_ = {};
    analyzerGe->isFftsPlus_ = false;

    GeOpFlagInfo geModelData;
    geModelData.start = 1;
    geModelData.end = 10;
    geModelData.modelId = 1;
    geModelData.ageFlag = false;
    analyzerGe->geModelInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geModelData));

    GeOpFlagInfo geApiData;
    geApiData.start = 2;
    geApiData.end = 3;
    geApiData.ageFlag = false;
    geApiData.modelFlag = false;
    geApiData.nodeFlag = false;
    GeOpFlagInfo geApiData2;
    geApiData2.start = 4;
    geApiData2.end = 5;
    geApiData2.ageFlag = false;
    geApiData2.modelFlag = false;
    geApiData2.nodeFlag = false;
    analyzerGe->geApiInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geApiData));
    analyzerGe->geApiInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geApiData2));

    RtOpInfo devTmpData;
    devTmpData.tsTrackTimeStamp = 5;
    devTmpData.threadId = 1;
    analyzerGe->devTmpOpInfo_.emplace_back(std::move(devTmpData));

    GeOpFlagInfo geNodeData;
    geNodeData.start = 3;
    analyzerGe->geNodeInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geNodeData));
    analyzerGe->MatchApiInfo(analyzerGe->geApiInfo_, analyzerGe->geModelInfo_, analyzerGe->geNodeInfo_, analyzerGe->geContextInfo_);
    EXPECT_EQ(0, analyzerGe->geNodeInfo_.size());
    EXPECT_EQ(1, analyzerGe->geOpInfo_.size());

    GeOpFlagInfo geNodeData2;
    geNodeData2.start = 6;
    geNodeData2.opNameHash = 1;
    analyzerGe->geNodeInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geNodeData2));
    analyzerGe->MatchApiInfo(analyzerGe->geApiInfo_, analyzerGe->geModelInfo_, analyzerGe->geNodeInfo_, analyzerGe->geContextInfo_);
    EXPECT_EQ(1, analyzerGe->geNodeInfo_.size());

    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    analyzerGe->isFftsPlus_ = true;
    GeOpFlagInfo geContextData;
    geContextData.start = 6;
    geContextData.opNameHash = 1;
    geContextData.contextId = 0;
    analyzerGe->geContextInfo_.insert(std::pair<uint32_t, GeOpFlagInfo>(1, geContextData));
    analyzerGe->MatchApiInfo(analyzerGe->geApiInfo_, analyzerGe->geModelInfo_, analyzerGe->geNodeInfo_, analyzerGe->geContextInfo_);
    EXPECT_EQ(1, analyzerGe->geNodeInfo_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_GetOpIndexId) {
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    TsProfileKeypoint data;
    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.indexId = 1234;
    data.taskId = 1;
    data.streamId = 1;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.taskId = 2;
    data.streamId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    uint64_t ret;
    ret = analyzer->GetOpIndexId(1000000 / analyzer->analyzerTs_->frequency_ - 1);
    EXPECT_EQ(0, ret);

    ret = analyzer->GetOpIndexId(2000000 / analyzer->analyzerTs_->frequency_ + 1);
    EXPECT_EQ(0, ret);

    ret = analyzer->GetOpIndexId(1000000 / analyzer->analyzerTs_->frequency_ + 1);
    EXPECT_EQ(1234, ret);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UpdateTsOpIndexId) {
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    TsProfileKeypoint data;
    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.taskId = 1;
    data.streamId = 1;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    auto &tsOpTimes = analyzer->analyzerTs_->opTimes_;
    for (auto iter = tsOpTimes.begin(); iter != tsOpTimes.end(); iter++) {
        iter->second.indexId = 1;
    }
    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    analyzer->UpdateOpIndexId(tsOpTimes);
    analyzer->profileMode_ = PROFILE_MODE_STEP_TRACE;
    analyzer->UpdateOpIndexId(tsOpTimes);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_DispatchOptimizeData) {
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chose(new analysis::dvvp::ProfileFileChunk());
    analyzer->opDescInfos_ = {};
    chose->fileName = "unaging.event";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "unaging.compact.node_basic_info";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "unaging.additional.context_id_info";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "unaging.additional.graph_id_map";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "unaging.api";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "unaging.compact.task_track";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "hwts.data";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "stars_soc.data";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "ts_track.data";
    analyzer->DispatchOptimizeData(chose);
    chose->fileName = "drop.data";
    analyzer->DispatchOptimizeData(chose);
    EXPECT_EQ(0, analyzer->opDescInfos_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadProfOpDescProc) {
    std::shared_ptr<PipeTransport> pipeTransport = std::make_shared<PipeTransport>();
    std::shared_ptr<Uploader> pipeUploader = std::make_shared<Uploader>(pipeTransport);
    pipeUploader->Init(100000);
    std::shared_ptr<Analyzer> analyzer(new Analyzer(pipeUploader));
    analyzer->opDescInfos_ = {};
    analyzer->graphIdMap_ = {};
    analyzer->graphTypeFlag_ = true;
    ProfOpDesc opDesc;
    opDesc.modelId = 0;
    analyzer->opDescInfos_.emplace_back(std::move(opDesc));
    analyzer->UploadProfOpDescProc();
    EXPECT_EQ(0, analyzer->resultCount_);
    EXPECT_EQ(1, analyzer->opDescInfos_.size());

    analyzer->graphIdMap_.insert(std::pair<uint32_t, uint32_t>(0, 220000003));
    analyzer->UploadProfOpDescProc();
    EXPECT_EQ(1, analyzer->resultCount_);
    EXPECT_EQ(0, analyzer->opDescInfos_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadOptimizeData) {
    GlobalMockObject::verify();
    GeOpFlagInfo geInfo;
    RtOpInfo rtInfo;
    rtInfo.tsTrackTimeStamp = 2;
    rtInfo.start = 1;
    rtInfo.end = 3;
    HashData::instance()->Init();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->ConstructAndUploadOptimizeData(geInfo, rtInfo);
    EXPECT_EQ(0, analyzer->resultCount_);
    HashData::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerTs_UploadKeypointOp) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();

    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->profileMode_ = PROFILE_MODE_STEP_TRACE;
    TsProfileKeypoint data;
    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.taskId = 1;
    data.streamId = 1;
    data.modelId = 0;

    data.indexId = 0;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.timestamp = 4000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 2;
    data.timestamp = 5000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    auto &keypointOpInfo = analyzer->analyzerTs_->keypointOpInfo_;
    analyzer->graphTypeFlag_ = true;
    analyzer->graphIdMap_.clear();
    analyzer->UploadKeypointOp();
    EXPECT_EQ(3, keypointOpInfo.size());
    analyzer->graphIdMap_.insert(std::pair<uint32_t, uint32_t>(0, 1000000));
    analyzer->UploadKeypointOp();
    int uploadNum = 0;
    for (auto iter = keypointOpInfo.begin(); iter != keypointOpInfo.end(); ++iter) {
        if (iter->second.uploaded == true) {
            uploadNum++;
        }
    }
    EXPECT_EQ(2, uploadNum);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerTs_UploadKeypointOp2) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();

    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    TsProfileKeypoint data;
    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.taskId = 1;
    data.streamId = 1;
    data.modelId = 0;

    data.indexId = 0;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 0;
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 1;
    data.timestamp = 4000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 2;
    data.timestamp = 5000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 1;
    data.timestamp = 6000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    data.indexId = 1;
    data.timestamp = 7000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData((CONST_CHAR_PTR)(&data), sizeof(data));

    auto &keypointOpInfo = analyzer->analyzerTs_->keypointOpInfo_;
    analyzer->graphTypeFlag_ = true;
    analyzer->graphIdMap_.clear();
    analyzer->UploadKeypointOp();
    EXPECT_EQ(3, keypointOpInfo.size());

    analyzer->graphIdMap_.insert(std::pair<uint32_t, uint32_t>(0, 1000000));
    analyzer->UploadKeypointOp();
    EXPECT_EQ(1, keypointOpInfo.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_GetStreamType) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();

    std::shared_ptr<AnalyzerGe> analyzerge(new AnalyzerGe());

    StreamInfo stream1 = {0, 0, KNOWN_SHAPE_STREAM};
    StreamInfo stream2 = {0, 0, UNKNOWN_SHAPE_STREAM};
    StreamInfo stream3 = {0, 0, UNKNOWN_SHAPE_STREAM};
    analyzerge->steamState_[1] = stream1;
    analyzerge->steamState_[2] = stream2;
    analyzerge->steamState_[3] = stream3;

    int streamType;
    bool res = analyzerge->GetStreamType(4, streamType);
    EXPECT_EQ(false, res);

    res = analyzerge->GetStreamType(1, streamType);
    EXPECT_EQ(true, res);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_ParsOpData) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerBase::GetGraphModelId)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::ParseOpName)
        .stubs();

    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::ParseOpType)
        .stubs();

    std::shared_ptr<AnalyzerGe> analyzerge(new AnalyzerGe());
    int res;
    MsprofGeProfTaskData taskData;
    taskData.magicNumber = 0;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_FAILED, res);

    taskData.magicNumber = MSPROF_DATA_HEAD_MAGIC_NUM;
    taskData.opName.type = MSPROF_MIX_DATA_STRING;
    taskData.opType.type = MSPROF_MIX_DATA_STRING;

    taskData.curIterNum = 0;
    taskData.streamId = 0;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_SUCCESS, res);

    taskData.streamId = 1;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_SUCCESS, res);

    taskData.curIterNum = 1;
    taskData.streamId = 2;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_SUCCESS, res);

    taskData.streamId = 3;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_SUCCESS, res);

    taskData.curIterNum = 2;
    taskData.streamId = 2;
    res = analyzerge->ParseOpData(reinterpret_cast<char *>(&taskData));
    EXPECT_EQ(PROFILING_SUCCESS, res);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AicoreMetricsEnumToName) {
    std::string metrics;

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_ARITHMETIC_UTILIZATION, metrics);
    EXPECT_EQ("ArithmeticUtilization", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_PIPE_UTILIZATION, metrics);
    EXPECT_EQ("PipeUtilization", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_MEMORY_BANDWIDTH, metrics);
    EXPECT_EQ("Memory", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_L0B_AND_WIDTH, metrics);
    EXPECT_EQ("MemoryL0", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_RESOURCE_CONFLICT_RATIO, metrics);
    EXPECT_EQ("ResourceConflictRatio", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_MEMORY_UB, metrics);
    EXPECT_EQ("MemoryUB", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_NONE, metrics);
    EXPECT_EQ("MemoryUB", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_METRICS_COUNT, metrics);
    EXPECT_EQ("MemoryUB", metrics);

    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_L2_CACHE, metrics);
    EXPECT_EQ("L2Cache", metrics);

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MDC_TYPE));
    metrics = "";
    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_L2_CACHE, metrics);
    EXPECT_EQ("", metrics);
}

TEST_F(MSPROF_ACL_CORE_UTEST, TaskBasedCfgTrfToReq) {
    std::string metrics;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));

    SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature = nullptr;
    feature = std::make_shared<Analysis::Dvvp::Host::Adapter::ProfApiStartReq>();

    Msprofiler::Api::ProfAclMgr::instance()->TaskBasedCfgTrfToReq(
        PROF_AICORE_METRICS_MASK, PROF_AICORE_ARITHMETIC_UTILIZATION, feature);
    EXPECT_EQ("", feature->hwtsLog);

    Msprofiler::Api::ProfAclMgr::instance()->TaskBasedCfgTrfToReq(
        PROF_TASK_TIME_MASK, PROF_AICORE_ARITHMETIC_UTILIZATION, feature);
    EXPECT_EQ("on", feature->hwtsLog);
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_subscribe_fail) {
    GlobalMockObject::verify();

    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();

    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));
    using namespace Msprofiler::Api;

    MOCKER(&Msprofiler::Api::ProfAclMgr::StartDeviceSubscribeTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(true));
    int fd = 1;
    ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);

    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    ProfAclMgr::instance()->devTasks_.clear();
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 0;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    MOCKER(&Msprofiler::Api::ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
}

TEST_F(MSPROF_ACL_CORE_UTEST, StartUploaderDumper_fail) {
    GlobalMockObject::verify();
    MOCKER(&Dvvp::Collect::Report::ProfReporterMgr::StartReporters)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::ProfAclMgr::instance()->StartUploaderDumper());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfStartAscendProfHalTask) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));

    MOCKER_CPP(&ProfAPI::ProfHalPlugin::ProfHalInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));

    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfStartAscendProfHalTask_Helper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsNeedHelperServer)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAPI::ProfHalPlugin::ProfHalInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->ProfStartAscendProfHalTask(config.dataTypeConfig, config.devNums, config.devIdList));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclStartMultiDevice) {
    GlobalMockObject::verify();

    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::DoHostHandle)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartAscendProfHalTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::TaskBasedCfgTrfToReq)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::SampleBasedCfgTrfToReq)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::StartReqTrfToInnerParam)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::StartDeviceTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::WaitAllDeviceResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    using namespace Msprofiler::Api;

    struct MsprofConfig config;
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    config.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.profSwitch = 0x7d7f001f;
    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    EXPECT_EQ(ACL_SUCCESS, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, config.profSwitch, params};
    ProfAclMgr::instance()->devTasks_[0] = taskInfo;
    ProfAclMgr::instance()->devTasks_[64] = taskInfo;
    ProfAclMgr::instance()->devTasks_[64].params->isCancel = false;
    EXPECT_EQ(ACL_ERROR_PROF_ALREADY_RUN, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    config.devNums = 2;
    config.devIdList[0] = 1;
    config.devIdList[1] = DEFAULT_HOST_ID;
    EXPECT_EQ(ACL_SUCCESS, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    ProfAclMgr::instance()->devTasks_[1] = taskInfo;
    taskInfo.count = 2;
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    EXPECT_EQ(true, ProfAclMgr::instance()->devTasks_.empty());
    Platform::instance()->Uninit();
    Platform::instance()->Init();
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_ge_api_success) {
    GlobalMockObject::verify();
    MOCKER(dlopen).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlsym).stubs().will(invoke(dlsymSuccessStub));
    ProfRtAPI::ExtendPlugin::instance()->LoadProfApi();

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    ge::aclgrphProfConfig *aclConfig = ge::aclgrphProfCreateConfig(config.devIdList, config.devNums,
        (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_success) {
    GlobalMockObject::verify();
    MOCKER(dlopen).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlsym).stubs().will(invoke(dlsymSuccessStub));
    ProfRtAPI::ExtendPlugin::instance()->LoadProfApi();

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::SUCCESS, aclprofDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_notsupport) {
    GlobalMockObject::verify();
    MOCKER(dlopen).stubs().will(returnValue((void *)nullptr));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(returnValue(nullptr));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::SUCCESS, aclprofDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_failed) {
    GlobalMockObject::verify();
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_EQ(nullptr, aclConfig);

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, FinalizeHandle_CheckFalseMode) {
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;

    int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofFinalizeHandle();
    EXPECT_EQ(MSPROF_ERROR_NONE, ret);
}

TEST_F(MSPROF_ACL_CORE_UTEST, FinalizeHandle_CheckTrueMode) {
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;

    int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofFinalizeHandle();
    EXPECT_EQ(MSPROF_ERROR_NONE, ret);
}

TEST_F(MSPROF_ACL_CORE_UTEST, aclprofSetConfig_not_support) {
    aclprofConfigType configType = ACL_PROF_ARGS_MIN;
    std::string config("50");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_ARGS_MAX;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_STORAGE_LIMIT;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(configType, config.c_str(), config.size() + 1));

    configType = ACL_PROF_STORAGE_LIMIT;
    std::string config2(257, 't');
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(configType, config2.c_str(), config2.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, IsValidProfConfig) {
    uint32_t deviceIdList[2]={0, 0};
    uint32_t deviceNums = 2;
    aclprofAicoreMetrics aicoreMetrics;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig;
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdList, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));

    uint32_t *deviceIdListNull = nullptr;
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdListNull, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));

    deviceNums = 0;
    dataTypeConfig = 0;
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdListNull, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));
}

TEST_F(MSPROF_ACL_CORE_UTEST, IsValidProfConfig1) {
    uint32_t deviceIdList[2]={5, 0};
    uint32_t deviceNums = 2;
    aclprofAicoreMetrics aicoreMetrics;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdList, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));
}

TEST_F(MSPROF_ACL_CORE_UTEST, IsProfConfigValid) {
    GlobalMockObject::verify();
    ProfConfig config;
    config.devNums = 5;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, ge::aclgrphProfCreateConfig(config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff));
}

TEST_F(MSPROF_ACL_CORE_UTEST, IsProfConfigValidSecond) {
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 5;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, ge::aclgrphProfCreateConfig(config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfStop) {
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x0080;
    // MOCKER(preCheckProfConfig).stubs().will(returnValue(0));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopPrecheck).stubs().will(returnValue(0));
    MOCKER((int (Msprofiler::Api::ProfAclMgr::*)(const uint32_t devId, uint64_t &dataTypeConfig))&Msprofiler::Api::ProfAclMgr::ProfAclGetDataTypeConfig).stubs().will(returnValue(0));
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfStop(ACL_API_TYPE, &config));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfig)
{
    // Simulate the failure to initialize the MSP.
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    Msprofiler::Api::ProfAclMgr::instance()->UnInit();
    std::string config("50");
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_DVPP_FREQ, config.c_str(), config.size()));

    // aclprofInit
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .then(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(false));
    std::string result = "/tmp/acl_prof_api_utest_new";
    EXPECT_EQ(ACL_SUCCESS, aclprofInit(result.c_str(), result.size()));

    aclprofConfigType configType = ACL_PROF_DVPP_FREQ;
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    configType = ACL_PROF_SYS_IO_FREQ;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    configType = ACL_PROF_SYS_INTERCONNECTION_FREQ;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_SYS_MEM_SERVICEFLOW;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_HOST_SYS_USAGE_FREQ;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    MOCKER_CPP(&Platform::GetPlatformType)
        .stubs()
        .will(repeat(PlatformTypeEnum::CHIP_MINI, 3))
        .then(returnValue(PlatformTypeEnum::CHIP_CLOUD));
    configType = ACL_PROF_LLC_MODE;
    config = "read";
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "capacity";
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "bandwidth";
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "read";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "write";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    configType = ACL_PROF_HOST_SYS;
    config = "cpu,mem,disk,network,osrt";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));

    configType = ACL_PROF_STORAGE_LIMIT;
    config = "100MB";
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "100";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_LOW_POWER_FREQ, config.c_str(), config.size()));
    configType = static_cast<aclprofConfigType>(2);
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    EXPECT_EQ(MSPROF_ERROR_NONE, aclprofFinalize());
}

TEST_F(MSPROF_ACL_CORE_UTEST, CreateParserTransport)
{
    GlobalMockObject::verify();
    MOCKER(&Uploader::Init).stubs().will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(nullptr, Msprofiler::AclApi::CreateParserTransport());
    GlobalMockObject::reset();
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfNotifySetDeviceForDynProf)
{
    MOCKER(&DynProfMgr::SaveDevicesInfo)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER(Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR, Analysis::Dvvp::ProfilerCommon::ProfNotifySetDeviceForDynProf(0, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfNotifySetDeviceForDynProf(0, 0, 0));
}

TEST_F(MSPROF_ACL_CORE_UTEST, SetHelperDirToTransport)
{
    GlobalMockObject::verify();
    MOCKER(&Utils::GetPid)
        .stubs()
        .will(returnValue(15151));
    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::SetHelperDirToTransport(""));

    MOCKER_CPP(&Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::SetHelperDirToTransport("0.15151"));
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::SetHelperDirToTransport("0.15151"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, SendHelperDataWithValidUploader)
{
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq(new analysis::dvvp::ProfileFileChunk());

    fileChunkReq->isLastChunk = false;
    fileChunkReq->chunkModule = 0;
    fileChunkReq->chunk= "It is a test";
    fileChunkReq->chunkSize = fileChunkReq->chunk.size() + 1;
    fileChunkReq->offset = 0;
    fileChunkReq->fileName =  "test.file";
    fileChunkReq->extraInfo = "no extraInfo";
    fileChunkReq->id = "123456789";

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData,
        int(analysis::dvvp::transport::UploaderMgr::*)(const std::string&, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>))
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::SendHelperData(fileChunkReq));
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::SendHelperData(fileChunkReq));
}

TEST_F(MSPROF_ACL_CORE_UTEST, SendHelperDataWithInvalidUploader)
{
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq(new analysis::dvvp::ProfileFileChunk());

    fileChunkReq->isLastChunk = false;
    fileChunkReq->chunkModule = 0;
    fileChunkReq->chunk= "It is a test";
    fileChunkReq->chunkSize = fileChunkReq->chunk.size() + 1;
    fileChunkReq->offset = 0;
    fileChunkReq->fileName =  "test.file";
    fileChunkReq->extraInfo = "no extraInfo";
    fileChunkReq->id = "123456789";

    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::SendHelperData(fileChunkReq));
}

void GetRunningDevicesStub(Msprofiler::Api::ProfAclMgr *This, std::vector<uint32_t> &devIds)
{
    devIds.push_back(0);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProcessHelperHostConfig)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetRunningDevices)
        .stubs()
        .will(invoke(GetRunningDevicesStub));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartAscendProfHalTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofResetDeviceHandle)
        .stubs()
        .will(returnValue(static_cast<int32_t>(MSPROF_ERROR)))
        .then(returnValue(static_cast<int32_t>(MSPROF_ERROR_NONE)));

    MOCKER(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true));
    struct MsprofConfigParam config = {};
    config.deviceId = 0U;
    config.type = 0U;
    // test not prof init
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
    // test param invalid
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig(nullptr, sizeof(config)));
    // MsprofResetDeviceHandle failed
    EXPECT_EQ(MSPROF_ERROR, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
    // ProfStartAscendProfHalTask failed
    EXPECT_EQ(PROFILING_FAILED, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
    // start helper server and reset device
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
    // start helper server
    config.type = 2U;
    config.value = 1U;
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
    // reset device
    config.type = 1U;
    config.value = 1U;
    EXPECT_EQ(PROFILING_SUCCESS, Msprofiler::Api::ProfAclMgr::instance()->ProcessHelperHostConfig((const char *)&config, sizeof(config)));
}

class MSPROF_API_SUBSCRIBE_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(MSPROF_API_SUBSCRIBE_UTEST, AnalyzerGe_Parse) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());
    analyzerGe->Parse(nullptr);

    struct MsprofGeProfTaskData geTaskDescChunk;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "Framework.task_desc_info_xxx";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzerGe->Parse(geTaskDesc);

    analyzerGe->totalBytes_ = 0;
    geTaskDesc->fileName = "Framework.task_desc_info";
    analyzerGe->Parse(geTaskDesc);
    EXPECT_EQ(sizeof(geTaskDescChunk), analyzerGe->totalBytes_);

    struct MsprofGeProfIdMapData geIdMapData;
    std::string geOriData2((char *)&geIdMapData, sizeof(geIdMapData));
    geTaskDesc->fileName = "Framework.id_map_info";
    geTaskDesc->chunk = geOriData2;
    geTaskDesc->chunkSize = sizeof(geIdMapData);
    analyzerGe->Parse(geTaskDesc);

    geTaskDesc->chunkSize = 0;
    analyzerGe->Parse(geTaskDesc);
}

TEST_F(MSPROF_API_SUBSCRIBE_UTEST, AnalyzerGe_ParseOpName) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());
    struct MsprofGeProfTaskData geProfTaskData;
    memset(&geProfTaskData, 0, sizeof(MsprofGeProfTaskData));
    geProfTaskData.opName.type = MSPROF_MIX_DATA_STRING;
    struct Analysis::Dvvp::Analyze::AnalyzerGe::GeOpInfo opInfo;
    analyzerGe->ParseOpName(geProfTaskData, opInfo);
}

TEST_F(MSPROF_API_SUBSCRIBE_UTEST, AnalyzerGe_ParseOpType) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());
    struct MsprofGeProfTaskData geProfTaskData;
    memset(&geProfTaskData, 0, sizeof(MsprofGeProfTaskData));
    geProfTaskData.opType.type = MSPROF_MIX_DATA_STRING;
    struct Analysis::Dvvp::Analyze::AnalyzerGe::GeOpInfo opInfo;
    analyzerGe->ParseOpType(geProfTaskData, opInfo);
}

class MSPROF_API_MSPROFTX_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
};

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofCreateStamp) {
    GlobalMockObject::verify();
    Msprof::MsprofTx::MsprofTxManager::instance()->Init();

    void * ret = nullptr;
    ret = aclprofCreateStamp();
    EXPECT_EQ((void *)nullptr, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ((void *)nullptr, aclprofCreateStamp());
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofDestroyStamp) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::DestroyStamp)
        .stubs()
        .will(ignoreReturnValue());

    void * ret = nullptr;
    aclprofDestroyStamp(nullptr);
    aclprofDestroyStamp((void *)0x12345678);
    EXPECT_EQ((void *)nullptr, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    aclprofDestroyStamp(nullptr);
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofSetCategoryName) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::SetCategoryName)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofSetCategoryName(0, "nullptr");
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetCategoryName(0, "nullptr"));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofSetStampCategory) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::SetStampCategory)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofSetStampCategory(nullptr, 0);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampCategory(nullptr, 0));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofSetStampPayload) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::SetStampPayload)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofSetStampPayload(nullptr, 0, nullptr);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampPayload(nullptr, 0, nullptr));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofSetStampTraceMessage) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::SetStampTraceMessage)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofSetStampTraceMessage(nullptr, "nullptr", 0);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampTraceMessage(nullptr, "nullptr", 0));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofMark) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::Mark)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofMark(nullptr);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofMark(nullptr));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofPush) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::Push)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofPush(nullptr);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofPush(nullptr));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofPop) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::Pop)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofPop();
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofPop());
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofRangeStart) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::RangeStart)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofRangeStart(nullptr, nullptr);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofRangeStart(nullptr, nullptr));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, aclprofRangeStop) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxManager::RangeStop)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    aclError ret = aclprofRangeStop(0);
    EXPECT_EQ(ACL_SUCCESS, ret);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofRangeStop(0));
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, RangeStop) {
    GlobalMockObject::verify();
    Msprof::MsprofTx::MsprofTxManager::instance()->isInit_ = true;
    Msprof::MsprofTx::MsprofTxManager::instance()->stampPool_ = std::make_shared<ProfStampPool>();
    MsprofStampInstance *ptr = nullptr;
    MOCKER_CPP(&ProfStampPool::GetStampById).stubs().will(returnValue(ptr));
    EXPECT_EQ(PROFILING_FAILED, Msprof::MsprofTx::MsprofTxManager::instance()->RangeStop(1));
}

int32_t MsprofAdditionalBufPushCallbackStub(uint32_t aging, const VOID_PTR data, uint32_t len)
{
    return 0;
}

TEST_F(MSPROF_API_MSPROFTX_UTEST, ReportStampData) {
    GlobalMockObject::verify();
    std::shared_ptr<Msprof::MsprofTx::MsprofTxManager> manager;
    MSVP_MAKE_SHARED0(manager, Msprof::MsprofTx::MsprofTxManager, break);
    // init reporter_
    manager->RegisterReporterCallback(MsprofAdditionalBufPushCallbackStub);
    struct MsprofStampInstance instance;
    struct MsprofTxInfo reportData = {0, 0, 0, { 0 }};

    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxReporter::Report)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(mmGetTid)
        .stubs()
        .will(returnValue(10));

    instance.txInfo = reportData;

    int ret = manager->ReportStampData((MsprofStampInstance *)&instance);
    EXPECT_EQ(PROFILING_FAILED, ret);
    // report success
    ret = manager->ReportStampData((MsprofStampInstance *)&instance);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

class COMMANDHANDLE_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

int32_t g_count = 0;
static int32_t handle1(uint32_t type, VOID_PTR data, uint32_t len)
{
    g_count++;
    return 0;
}

static int32_t handle2(uint32_t type, VOID_PTR data, uint32_t len)
{
    g_count++;
    return 0;
}

TEST_F(COMMANDHANDLE_TEST, commandHandle_api) {
    GlobalMockObject::verify();
    ProfRegisterCallback(1, &handle1);
    ProfRegisterCallback(1, &handle2);
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfInit());
    std::string retStr(4099,'a');
    std::string zeroStr = "{}";
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetParamJsonStr)
        .stubs()
        .will(returnValue(retStr))
        .then(returnValue(zeroStr));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(ACL_ERROR, CommandHandleProfInit());
    uint32_t devList[] = {0, 1};
    uint32_t devNums = 2;
    const uint32_t num = 10;
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfStart(devList, devNums, 0, 0));
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfStart(nullptr, 0, 0, 0));
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfStop(devList, devNums, 0, 0));
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfStart(nullptr, 0, 0, 0));
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfFinalize());
    EXPECT_EQ(ACL_SUCCESS, CommandHandleProfUnSubscribe(0));
    EXPECT_EQ(num, g_count);
}

TEST_F(MSPROF_ACL_CORE_UTEST, UpdateOpFeature) {
    GlobalMockObject::verify();
    std::shared_ptr<Analysis::Dvvp::Host::Adapter::ProfParamsAdapter> paramsAdapter(
            new Analysis::Dvvp::Host::Adapter::ProfParamsAdapter);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature(new Analysis::Dvvp::Host::Adapter::ProfApiStartReq);
    feature->l2CacheEvents = "0x0";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(5));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    feature->aiCoreEvents = "PipeUtilization";
    paramsAdapter->UpdateOpFeature(feature, params);
    EXPECT_TRUE(params->aiv_profiling == "on");
}

class TRANSPORT_PIPERANSPORT_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }

    virtual void TearDown() {
    }
private:
};

TEST_F(TRANSPORT_PIPERANSPORT_TEST, SendBuffer) {
    GlobalMockObject::verify();
    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(0));
    SHARED_PTR_ALIA<PipeTransport> pipeTransport = std::make_shared<PipeTransport>();
    SHARED_PTR_ALIA<Uploader> pipeUploader = std::make_shared<Uploader>(pipeTransport);
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;

    fileChunkReq = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    fileChunkReq->chunkSize = 1;
    EXPECT_EQ(pipeTransport->SendBuffer(fileChunkReq), 0);

    ProfOpDesc opDesc;
    // check data failed
    pipeTransport->SendBuffer(&opDesc, sizeof(ProfOpDesc));

    // check not suscribe
    opDesc.modelId = 0;
    opDesc.threadId = 1;
    opDesc.signature = analysis::dvvp::common::utils::Utils::GenerateSignature(
            reinterpret_cast<uint8_t *>(&opDesc) + sizeof(uint32_t), sizeof(ProfOpDesc) - sizeof(uint32_t));
    pipeTransport->SendBuffer(&opDesc, sizeof(ProfOpDesc));
}

TEST_F(MSPROF_ACL_CORE_UTEST, AddCcuInstructionTest) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    params->prof_level = "level0";
 
    Msprofiler::Api::ProfAclMgr::instance()->AddCcuInstruction(params);
    EXPECT_EQ("off", params->ccuInstr);

    Msprofiler::Api::ProfAclMgr::instance()->AddCcuInstruction(params);
    EXPECT_EQ("off", params->ccuInstr);

    params->prof_level = "level1";
    Msprofiler::Api::ProfAclMgr::instance()->AddCcuInstruction(params);
    EXPECT_EQ("on", params->ccuInstr);
}

TEST_F(MSPROF_ACL_CORE_UTEST, CommandHandleFinalizeGuard_Base) {
    Analysis::Dvvp::ProfilerCommon::CommandHandleFinalizeGuard();
    EXPECT_EQ(true, ProfModuleReprotMgr::GetInstance().finalizeGuard_);
    ProfModuleReprotMgr::GetInstance().finalizeGuard_= false;
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofStart_PureCpu) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER_CPP(&ProfAclMgr::IsModeOff)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::MsprofInitPureCpu)
        .stubs()
        .will(returnValue(static_cast<int32_t>(MSPROF_ERROR)))
        .then(returnValue(static_cast<int32_t>(MSPROF_ERROR_NONE)));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::MsprofTxHandle)
        .stubs();
    MOCKER_CPP(&ProfAclMgr::MsprofHostHandle)
        .stubs();

    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;
    (void)strcpy_s(cfg.dumpPath, MAX_DUMP_PATH_LEN, "64");
    (void)strcpy_s(cfg.sampleConfig, MAX_SAMPLE_CONFIG_LEN, "test");
    // invalid input
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, 1));
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), nullptr, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_DYNAMIC), &cfg, sizeof(cfg)));
    // IsModeOff
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // MsprofInitPureCpu
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // StartUploaderDumper
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // CommandHandleProfInit
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // CommandHandleProfStart
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());

    GlobalMockObject::verify();
    MOCKER_CPP(&ProfAclMgr::IsModeOff)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&ProfAclMgr::IsCmdMode)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfFinalize)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::MsprofTxHandle)
        .stubs();
    MOCKER_CPP(&ProfAclMgr::MsprofHostHandle)
        .stubs();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, 0, params};
    ProfAclMgr::instance()->devTasks_[64] = taskInfo;
    EXPECT_EQ(1, ProfAclMgr::instance()->devTasks_.size());

    // invalid input
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, 1));
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), nullptr, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_DYNAMIC), &cfg, sizeof(cfg)));
    // IsModeOff
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // IsCmdMode
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // CommandHandleProfStop
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // CommandHandleProfFinalize
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    // IdeCloudProfileProcess
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    ProfAclMgr::instance()->UnInit();
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofStart_Common) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::MsprofDeviceHandle)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::MsprofTxHandle)
        .stubs();
    MOCKER_CPP(&ProfAclMgr::MsprofHostHandle)
        .stubs();

    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;

    // CheckIfDevicesOnline
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // StartUploaderDumper
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // MsprofDeviceHandle
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // CommandHandleProfInit
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // CommandHandleProfStart
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_JSON), &cfg, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_GE_OPTION), &cfg, sizeof(cfg)));
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());

    GlobalMockObject::verify();
    MOCKER_CPP(&ProfAclMgr::IsModeOff)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::MsprofTxHandle)
        .stubs();
    MOCKER_CPP(&ProfAclMgr::MsprofHostHandle)
        .stubs();

    // IsModeOff
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // CommandHandleProfStop
    EXPECT_EQ(ACL_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    // devTasks_ not find
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, 0, params};
    ProfAclMgr::instance()->devTasks_[0] = taskInfo;
    EXPECT_EQ(1, ProfAclMgr::instance()->devTasks_.size());
    // IdeCloudProfileProcess
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));

    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg, sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_JSON), &cfg, sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_GE_OPTION), &cfg, sizeof(cfg)));
    ProfAclMgr::instance()->UnInit();
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofStart_AclApi) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&ProfAclMgr::ProfStartPrecheck)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::CheckDataTypeSupport)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::MsprofDeviceHandle)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::StartReqTrfToInnerParam)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::MsprofTxApiHandle)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::StartDeviceTask)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROFILING_FAILURE)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::WaitDeviceResponse)
        .stubs();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartAscendProfHalTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::instance()->params_ = params;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;
    // PlatformIsHelperHostSide
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // ProfStartPrecheck
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // CheckDataTypeSupport
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // StartReqTrfToInnerParam
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // StartUploaderDumper
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // StartDeviceTask
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // CommandHandleProfInit
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // CommandHandleProfStart
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params2(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, 0x7d7f001f, params2};
    ProfAclMgr::instance()->devTasks_[0] = taskInfo;
    EXPECT_EQ(1, ProfAclMgr::instance()->devTasks_.size());

    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&ProfAclMgr::ProfStopPrecheck)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::IsModeOff)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    // PlatformIsHelperHostSide
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // ProfStopPrecheck
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // IsModeOff
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // CommandHandleProfStop
    EXPECT_EQ(ACL_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // IdeCloudProfileProcess
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    // dataTypeConfig != config->profSwitch
    cfg.profSwitch = 0x7d7f0000;
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    cfg.profSwitch = 0x7d7f001f;

    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));

    ProfAclMgr::instance()->UnInit();
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofStart_AclSubscribe) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&ProfAclMgr::ProfSubscribePrecheck)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_API_CONFLICT)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::CheckSubscribeConfig)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_INVALID_PARAM)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&HashData::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::StartDeviceSubscribeTask)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROFILING_FAILURE)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));

    uint32_t fdTmp = 1;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 8;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;
    cfg.modelId = 0;
    cfg.type = 0;
    cfg.fd = reinterpret_cast<uintptr_t>(&fdTmp);
    cfg.cacheFlag = 1;
    // PlatformIsHelperHostSide
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // ProfSubscribePrecheck
    EXPECT_EQ(ACL_ERROR_PROF_API_CONFLICT, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // CheckSubscribeConfig
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // HashData::Init
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // StartDeviceSubscribeTask
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // StartUploaderDumper
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // CommandHandleProfStart
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));

    EXPECT_EQ(ACL_SUCCESS, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    EXPECT_EQ(0, ProfAclMgr::instance()->subscribeInfos_.size());
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());

    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&ProfAclMgr::ProfSubscribePrecheck)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_ALREADY_RUN)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::IsModelSubscribed)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false))
        .then(returnValue(true)); 
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROFILING_FAILURE)));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&ProfAclMgr::CloseSubscribeFdIfHostId)
        .stubs();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, printf("Failed to make_shared for params"));
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, 0, params};
    ProfAclMgr::instance()->devTasks_[8] = taskInfo;
    EXPECT_EQ(1, ProfAclMgr::instance()->devTasks_.size());

    // PlatformIsHelperHostSide
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // ProfSubscribePrecheck
    EXPECT_EQ(ACL_ERROR_PROF_ALREADY_RUN, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // IsModelSubscribed
    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    // IsModelSubscribed
    cfg.modelId = std::numeric_limits<uint32_t>::max();
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &cfg, sizeof(cfg)));
    cfg.modelId = 0;
    UploaderMgr::instance()->DelAllUploader();
    ProfAclMgr::instance()->UnInit();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Msprof_aclprofGetSupportedFeatures) {
    int32_t ret = aclprofGetSupportedFeatures(nullptr, nullptr);
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ret);

    size_t size = 0;
    void* dataPtr = nullptr;
    ret = aclprofGetSupportedFeatures(&size, &dataPtr);
    EXPECT_EQ(ACL_SUCCESS, ret);
    EXPECT_EQ(size, 1);
    EXPECT_NE(dataPtr, nullptr);
    if (dataPtr != nullptr) {
        FeatureRecord* features = static_cast<FeatureRecord*>(dataPtr);
        EXPECT_EQ(std::string(features->featureName), "ATTR");
        EXPECT_EQ(std::string(features->info.compatibility), "0");
        EXPECT_EQ(std::string(features->info.featureVersion), "1");
        EXPECT_EQ(std::string(features->info.affectedComponent), "all");
        EXPECT_EQ(std::string(features->info.affectedComponentVersion), "all");
        EXPECT_EQ(std::string(features->info.infoLog), "It not support feature: ATTR!");
    }

    // Exe twice
    ret = aclprofGetSupportedFeatures(&size, &dataPtr);
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ret);
    EXPECT_EQ(size, 1);
    EXPECT_NE(dataPtr, nullptr);

    void* dataPtr2 = nullptr;
    ret = aclprofGetSupportedFeatures(&size, &dataPtr2);
    EXPECT_EQ(ACL_SUCCESS, ret);
    EXPECT_EQ(size, 1);
    EXPECT_NE(dataPtr, nullptr);
}