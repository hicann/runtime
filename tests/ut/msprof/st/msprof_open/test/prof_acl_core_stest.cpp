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
#include <google/protobuf/util/json_util.h>
#include "config/open/config_manager.h"
#include "config/feature_manager.h"
#include "errno/error_code.h"
#include "ge/ge_prof.h"
#include "message/codec.h"
#include "msprof_reporter.h"
#include "msprofiler_impl.h"
#include "op_desc_parser.h"
#include "prof_api_common.h"
#include "prof_acl_mgr.h"
#include "proto/profiler.pb.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "prof_acl_core.h"
#include "prof_ge_core.h"
#include "uploader_dumper.h"
#include "prof_common.h"
#include "analyzer.h"
#include "analyzer_ge.h"
#include "analyzer_ts.h"
#include "analyzer_rt.h"
#include "analyzer_hwts.h"
#include "platform/platform.h"
#include "command_handle.h"
#include "data_struct.h"
#include "prof_api.h"
#include "prof_inner_api.h"

#include "msprof_tx_manager.h"
#include "msprofiler_acl_api.h"
#include "param_validation.h"
#include "prof_acl_intf.h"
#include "transport/hdc/hdc_transport.h"
#include "transport/file_transport.h"
#include "transport/parser_transport.h"
#include "dyn_prof_server.h"
#include "dyn_prof_mgr.h"
#include "prof_reporter_mgr.h"
#include "prof_stamp_pool.h"
#include "msprof_tx_reporter.h"
#include "prof_manager.h"
#include "config/config.h"
#include "prof_params_adapter.h"
#include "hash_data.h"
#include "msprofiler_acl_api.h"
#include "prof_api_runtime.h"
#include "prof_hal_plugin.h"
#include "report_stub.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::ProfilerCommon;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Analyze;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Msprof::Engine::Intf;
using namespace Msprof::MsprofTx;
using namespace Collector::Dvvp::DynProf;
using namespace ge;
using namespace ProfRtAPI;
using namespace Msprofiler::Api;

const int RECEIVE_CHUNK_SIZE = 320; // chunk size:320
extern bool IsProfConfigValid(CONST_UINT32_T_PTR deviceidList, uint32_t deviceNums);
extern "C" {
extern int ProfAclDrvGetDevNum();
}

class MSPROF_ACL_CORE_OPEN_STEST: public testing::Test {
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
    }
    virtual void TearDown() {}
};

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_app) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofAclJsonParamConstruct) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_ge_api) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));

    RegisterTryPop();
    std::string result = "/tmp/acl_api_stest_new";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfInit(result.c_str(), result.size()));

    ProfConfig config;
    config.devNums = 0;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_PIPE_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    ge::aclgrphProfConfig *aclConfig = ge::aclgrphProfCreateConfig(
        config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_EQ(nullptr, aclConfig);

    config.devNums = 1;
    aclConfig = ge::aclgrphProfCreateConfig(config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics,
        nullptr, config.dataTypeConfig);

    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfStart(aclConfig));

    MsprofReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_INIT, nullptr, 0);
    MsprofHashData hData = {0};
    std::string hashData = "profiling_st_data";
    hData.dataLen = hashData.size();
    hData.data = const_cast<unsigned char *>((const unsigned char *)hashData.c_str());
    hData.hashId = 0;
    MsprofReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_HASH, (void *)&hData, sizeof(hData));
    EXPECT_NE(0, hData.hashId);
    hData.hashId = 0;
    MsprofReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_HASH, (void *)&hData, 0);
    EXPECT_EQ(0, hData.hashId);
    hData.dataLen = 0;
    MsprofReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_HASH, (void *)&hData, sizeof(hData));

    ReporterData data = {0};
    data.tag[0] = 't';
    data.deviceId = 0;
    std::string reportData = "profiling_st_data";
    data.dataLen = reportData.size();
    data.data = const_cast<unsigned char *>((const unsigned char *)reportData.c_str());
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_REPORT, (void *)&data, sizeof(data));
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_UNINIT, nullptr, 0);
    Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_DATA_PREPROCESS].ForceFlush();

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfStop(aclConfig));

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfFinalize());

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));
    EXPECT_EQ(ge::FAILED, ge::aclgrphProfDestroyConfig(nullptr));

    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, aclgrphProfInit_failed) {
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
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, AddToUploaderGetUploaderFailed) {
    GlobalMockObject::verify();
    std::shared_ptr<Msprof::Engine::UploaderDumper> dumper(new Msprof::Engine::UploaderDumper("Framework"));
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<ITransport> trans(new HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(trans);
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data.null";
    hwts->extraInfo = "0.0";

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData,
        int(analysis::dvvp::transport::UploaderMgr::*)(const std::string &, const void *, uint32_t))
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    dumper->AddToUploader(hwts);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));
    dumper->AddToUploader(hwts);
    EXPECT_EQ(hwts->chunkModule, 1);
}

int32_t runtimeSuccessFunction(int32_t logicId, int32_t devIdId) {
    return 0;
}

void * dlsymSuccessStub(void *handle, const char *symbol) {
    return (void *)runtimeSuccessFunction;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_prof_api) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));

    std::string result = "/tmp/acl_prof_api_stest_new";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(ACL_SUCCESS, aclprofInit(result.c_str(), result.size()));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    aclprofConfig *zeroConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    aclprofConfig *invalidConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff);
    memset(zeroConfig, 0, sizeof(ProfConfig));

    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStart(nullptr));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofStart(zeroConfig));
    EXPECT_EQ(200007, aclprofStart(invalidConfig));
    EXPECT_EQ(0, aclprofStart(aclConfig));

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

    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_INIT, nullptr, 0);
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
    EXPECT_EQ(0, ret);
    EXPECT_EQ(RECEIVE_CHUNK_SIZE, dataMaxLen);
    Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_MSPROF, MSPROF_REPORTER_UNINIT, nullptr, 0);
    Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].ForceFlush();
    ret = Msprof::Engine::MsprofReporter::reporters_[MSPROF_MODULE_MSPROF].GetDataMaxLen(&dataMaxLen, 1);
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

    GlobalMockObject::verify();
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    ProfConfig configStub;
    configStub.devNums = 1;
    configStub.devIdList[0] = 0;
    configStub.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    configStub.dataTypeConfig = 0x0000001f;
    aclprofConfig *aclConfigStub = aclprofCreateConfig(configStub.devIdList, configStub.devNums,
        (aclprofAicoreMetrics)configStub.aicoreMetrics, nullptr, configStub.dataTypeConfig);
    EXPECT_EQ(nullptr, aclConfigStub);

    GlobalMockObject::verify();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_ge_api_success) {
    GlobalMockObject::verify();
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    ge::aclgrphProfConfig *aclConfig = ge::aclgrphProfCreateConfig(config.devIdList, config.devNums,
        (ge::ProfilingAicoreMetrics)config.aicoreMetrics,nullptr, config.dataTypeConfig);
    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_api_success) {
    GlobalMockObject::verify();
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

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

int32_t g_doHostHandle = 0;
int32_t DoHostHandleStub()
{
    g_doHostHandle++;
    return PROFILING_SUCCESS;
}
TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofHostHandle) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::IsCmdMode)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::DoHostHandle)
        .stubs()
        .will(invoke(DoHostHandleStub));
    ProfAclMgr::instance()->MsprofHostHandle();
    EXPECT_EQ(g_doHostHandle, 1);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_prof_init_failed) {
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
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofResultPathAdapter) {
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

    analysis::dvvp::common::utils::Utils::IsDirAccessible("/etc/passwd");

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::string work_path = "/tmp/ascend_work_path/";
    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString).stubs().will(returnValue(work_path));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath).stubs().will(returnValue(work_path));
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofResultPathAdapter("", path));
}

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
    EXPECT_EQ("", std::string(opType));
    size_t opNameLen = 0;
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpNameLen(buf, bufLen, &opNameLen, 0));
    char opName[opNameLen];
    EXPECT_EQ(ACL_SUCCESS, OpDescParser::instance()->GetOpName(buf, bufLen, opName, opNameLen, 0));
    EXPECT_EQ("", std::string(opName));
    EXPECT_EQ(true, OpDescParser::GetOpStart(buf, bufLen, 0) > 0);
    EXPECT_EQ(true, OpDescParser::GetOpEnd(buf, bufLen, 0) > 0);
    EXPECT_EQ(true, OpDescParser::GetOpDuration(buf, bufLen, 0) > 0);
    EXPECT_EQ(true, OpDescParser::GetOpExecutionTime(buf, bufLen, 0) >= 0);
    EXPECT_EQ(true, OpDescParser::GetOpCubeFops(buf, bufLen, 0) >= 0);
    EXPECT_EQ(true, OpDescParser::GetOpVectorFops(buf, bufLen, 0) >= 0);
    EXPECT_EQ(false, OpDescParser::GetOpFlag(buf, bufLen, 0));
    EXPECT_NE(nullptr, OpDescParser::GetOpAttriValue(buf, bufLen, 0, ACL_SUBSCRIBE_ATTRI_THREADID));
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
    return bufLen;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, get_op_xxx) {
    ProfOpDesc data;
    data.modelId = 0;
    data.flag = ACL_SUBSCRIBE_OP_THREAD;
    data.threadId = 0;
    data.modelId = 0;
    EXPECT_EQ(ACL_SUBSCRIBE_OP_THREAD, OpDescParser::GetOpFlag(&data, sizeof(data), 0));
    EXPECT_NE(nullptr, OpDescParser::GetOpAttriValue(&data, sizeof(data), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
    EXPECT_EQ(nullptr, OpDescParser::GetOpAttriValue(&data, sizeof(data), 0, ACL_SUBSCRIBE_ATTRI_NONE));

    EXPECT_EQ(ACL_SUBSCRIBE_NONE, OpDescParser::GetOpFlag(nullptr, sizeof(data), 0));
    EXPECT_EQ(nullptr, OpDescParser::GetOpAttriValue(nullptr, sizeof(data), 0, ACL_SUBSCRIBE_ATTRI_THREADID));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_api_subscribe) {
    GlobalMockObject::verify();

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

    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, aclprofModelSubscribe(1, nullptr));


    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    Msprofiler::AclApi::ProfRegisterTransport(Msprofiler::AclApi::CreateParserTransport);

    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 0;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> geIdMap(new analysis::dvvp::proto::FileChunkReq());
    struct MsprofGeProfIdMapData idMapData;
    geIdMap->set_filename("Framework");
    geIdMap->set_tag("id_map_info");
    std::string geOriData0((char *)&idMapData, sizeof(idMapData));
    geIdMap->set_chunk(geOriData0);
    geIdMap->set_chunksizeinbytes(sizeof(idMapData));
    std::string data0 = analysis::dvvp::message::EncodeMessage(geIdMap);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData(
        "0", static_cast<const void *>(data0.c_str()), data0.size());

    std::string data;

    std::string geTaskDescChunk = "{\"block_dims\": 1,   \"cur_iter_num\": 0,   \"input\": [     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 0,       \"shape\": []     },     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 1,       \"shape\": []     }   ],   \"model_id\": 1,   \"model_name\": \"ge_default_20210220001434_1\",   \"op_name\": \"OpName\",   \"op_type\": \"OpType\",   \"output\": [     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 0,       \"shape\": []     }   ],   \"shape_type\": \"static\",   \"stream_id\": 100,   \"task_id\": 30,   \"task_type\": \"AI_CORE\" },";
    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> geTaskDesc(new analysis::dvvp::proto::FileChunkReq());
    geTaskDesc->set_filename("Framework");
    geTaskDesc->set_chunk(geTaskDescChunk);
    geTaskDesc->set_chunksizeinbytes(geTaskDescChunk.size());
    geTaskDesc->set_tag("task_desc_info");
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
    tsTimeline->set_chunk(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize);
    tsTimeline->set_chunksizeinbytes(tsChunk.head.bufSize);
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
    hwts->set_chunk(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->set_chunksizeinbytes(sizeof(HwtsProfileType01));
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

    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UnInit());
    aclprofDestroySubscribeConfig(profSubconfig);
    ConfigManager::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_api_subscribe_step_parse) {
    GlobalMockObject::verify();

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

    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, aclprofModelSubscribe(1, nullptr));


    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 0;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    std::string data;

    std::string geTaskDescChunk = "{\"block_dims\": 1,   \"cur_iter_num\": 0,   \"input\": [     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 0,       \"shape\": []     },     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 1,       \"shape\": []     }   ],   \"model_id\": 1,   \"model_name\": \"ge_default_20210220001434_1\",   \"op_name\": \"OpName\",   \"op_type\": \"OpType\",   \"output\": [     {       \"data_type\": \"int32\",       \"format\": \"ND\",       \"idx\": 0,       \"shape\": []     }   ],   \"shape_type\": \"static\",   \"stream_id\": 100,   \"task_id\": 30,   \"task_type\": \"AI_CORE\" },";
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "Framework.task_desc_info";
    geTaskDesc->chunk = geTaskDescChunk;
    geTaskDesc->chunkSize = geTaskDescChunk.size();
    geTaskDesc->extraInfo = "0:0";
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", geTaskDesc);

    using namespace Analysis::Dvvp::Analyze;
    HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 30;
    hwtsChunk.streamId = 100;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 1000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data";
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", hwts);

    hwtsChunk.cntRes0Type = HWTS_TASK_END_TYPE;
    hwtsChunk.syscnt = 2000000;
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01) - 10;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", hwts);
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk) + sizeof(HwtsProfileType01) - 10, 10);
    hwts->chunkSize = 10;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", hwts);

    using namespace Analysis::Dvvp::Analyze;
    TsProfileKeypoint tsKpChunk;
    tsKpChunk.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsKpChunk.head.bufSize = sizeof(TsProfileKeypoint);
    tsKpChunk.taskId = 30;
    tsKpChunk.streamId = 100;
    tsKpChunk.tagId = TS_KEYPOINT_START_TASK_STATE;
    tsKpChunk.timestamp = 1000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKpTimeline(new analysis::dvvp::ProfileFileChunk());
    tsKpTimeline->fileName = "ts_track.data";
    tsKpTimeline->chunk.append(reinterpret_cast<char *>(&tsKpChunk), tsKpChunk.head.bufSize);
    tsKpTimeline->chunkSize = tsKpChunk.head.bufSize;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsKpTimeline);

    using namespace Analysis::Dvvp::Analyze;
    TsProfileTimeline tsChunk;
    tsChunk.head.rptType = TS_TIMELINE_RPT_TYPE;
    tsChunk.head.bufSize = sizeof(TsProfileTimeline);
    tsChunk.taskId = 30;
    tsChunk.streamId = 100;
    tsChunk.taskState = TS_TIMELINE_START_TASK_STATE;
    tsChunk.timestamp = 1000001;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsTimeline(new analysis::dvvp::ProfileFileChunk());
    tsTimeline->fileName = "ts_track.data";
    tsTimeline->chunk.append(reinterpret_cast<char *>(&tsChunk));
    tsTimeline->chunkSize = tsChunk.head.bufSize;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsTimeline);

    tsChunk.taskState = TS_TIMELINE_AICORE_START_TASK_STATE;
    tsChunk.timestamp = 1000002;
    tsTimeline->chunk.clear();
    tsTimeline->chunk.append(reinterpret_cast<char *>(&tsChunk));
    tsTimeline->chunkSize = tsChunk.head.bufSize;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsTimeline);

    tsChunk.taskState = TS_TIMELINE_AICORE_END_TASK_STATE;
    tsChunk.timestamp = 1000003;
    tsTimeline->chunk.clear();
    tsTimeline->chunk.append(reinterpret_cast<char *>(&tsChunk));
    tsTimeline->chunkSize = tsChunk.head.bufSize;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsTimeline);

    tsChunk.taskState = TS_TIMELINE_END_TASK_STATE;
    tsChunk.timestamp = 1000004;
    tsTimeline->chunk.clear();
    tsTimeline->chunk.append(reinterpret_cast<char *>(&tsChunk), tsChunk.head.bufSize - 10);
    tsTimeline->chunkSize = tsChunk.head.bufSize - 10;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsTimeline);
    tsTimeline->chunk.clear();
    tsTimeline->chunk.append(reinterpret_cast<char *>(&tsChunk) + tsChunk.head.bufSize - 10, 10);
    tsTimeline->chunkSize = 10;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsTimeline);

    tsKpChunk.tagId = TS_KEYPOINT_END_TASK_STATE;
    tsKpChunk.timestamp = 5000000;
    tsKpTimeline->chunk.clear();
    tsKpTimeline->chunk.append(reinterpret_cast<char *>(&tsKpChunk), tsKpChunk.head.bufSize);
    tsKpTimeline->chunkSize = tsKpChunk.head.bufSize;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsKpTimeline);

    tsKpTimeline->chunk.clear();
    tsKpTimeline->chunk.append(reinterpret_cast<char *>(&tsKpChunk) + tsKpChunk.head.bufSize - 10, 10);
    tsKpTimeline->chunkSize = 10;
    analysis::dvvp::transport::UploaderMgr::instance()->UploadData("0", tsKpTimeline);

    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UnInit());
    aclprofDestroySubscribeConfig(profSubconfig);
    ConfigManager::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, new_struct_subscribe) {
    using namespace Msprofiler::Api;
    using namespace Analysis::Dvvp::Analyze;
    GlobalMockObject::verify();
    ConfigManager::instance()->Init();
    ConfigManager::instance()->configMap_["frq"] = std::to_string(100000);
    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));

    // Subscribe
    int fd = 1;
    struct ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);
    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 1;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    struct MsprofConfig cfg2;
    cfg2.devNums = 1;
    cfg2.devIdList[0] = 0;
    cfg2.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg2.modelId = 2;
    cfg2.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg2.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg2.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg2),
        sizeof(cfg2)));

    std::string data;
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->geApiInfo_ = {};
    analyzer->geModelInfo_ = {};
    analyzer->geNodeInfo_ = {};
    analyzer->rtOpInfo_ = {};
    analyzer->tsOpInfo_ = {};
    analyzer->opDescInfos_ = {};
    analyzer->geOpInfo_ = {};

    // ge api unaging
    struct MsprofApi geUnAgingTaskDescChunk;
    geUnAgingTaskDescChunk.type = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    geUnAgingTaskDescChunk.beginTime = 40;
    geUnAgingTaskDescChunk.endTime = 60;
    geUnAgingTaskDescChunk.threadId = 1;
    std::string geUnAgingOriData((char *)&geUnAgingTaskDescChunk, sizeof(geUnAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geUnAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geUnAgingTaskDesc->fileName = "unaging.api_event";
    geUnAgingTaskDesc->chunk = geUnAgingOriData;
    geUnAgingTaskDesc->chunkSize = sizeof(geUnAgingTaskDescChunk);
    analyzer->OnOptimizeData(geUnAgingTaskDesc);

    // ge api aging
    struct MsprofApi geAgingTaskDescChunk;
    geAgingTaskDescChunk.type = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    std::string geAgingOriData((char *)&geAgingTaskDescChunk, sizeof(geAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geAgingTaskDesc->fileName = "aging.api_event";
    geAgingTaskDesc->chunk = geAgingOriData;
    geAgingTaskDesc->chunkSize = sizeof(geAgingTaskDescChunk);
    analyzer->OnOptimizeData(geAgingTaskDesc);

    // ge node
    struct MsprofNodeBasicInfo nodeData;
    struct MsprofCompactInfo geTaskDescChunk;
    nodeData.opName = 123456;
    nodeData.opType = 654321;
    geTaskDescChunk.level = MSPROF_REPORT_NODE_LEVEL;
    geTaskDescChunk.data.nodeBasicInfo = nodeData;
    geTaskDescChunk.threadId = 1;
    geTaskDescChunk.timeStamp = 60;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "unaging.compact.node_basic_info";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzer->OnOptimizeData(geTaskDesc);

    struct MsprofGraphIdInfo graphData;
    struct MsprofAdditionalInfo geAddChunk;
    geAddChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    std::string geAddData((char *)&geAddChunk, sizeof(geAddChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geAddDesc(new analysis::dvvp::ProfileFileChunk());
    geAddDesc->fileName = "Additional.graph_id_map";
    geAddDesc->extraInfo = "0.0";
    geAddDesc->chunk = geAddData;
    geAddDesc->chunkSize = sizeof(geAddChunk);
    analyzer->OnOptimizeData(geAddDesc);

    struct MsprofContextIdInfo contextData;
    struct MsprofAdditionalInfo geAddContextChunk;
    geAddContextChunk.level = MSPROF_REPORT_NODE_LEVEL;
    geAddContextChunk.type = MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE;
    std::string geAddContextData((char *)&geAddContextChunk, sizeof(geAddContextChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geContextDesc(new analysis::dvvp::ProfileFileChunk());
    geContextDesc->fileName = "Additional.context_id_info";
    geContextDesc->extraInfo = "0.0";
    geContextDesc->chunk = geAddContextData;
    geContextDesc->chunkSize = sizeof(geAddContextChunk);
    analyzer->OnOptimizeData(geContextDesc);

    // ge model load
    struct MsprofEvent geUnAgingEventChunk;
    geUnAgingEventChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    geUnAgingEventChunk.type = MSPROF_REPORT_MODEL_LOAD_TYPE;
    geUnAgingEventChunk.threadId = 1;
    geUnAgingEventChunk.itemId = 1;
    geUnAgingEventChunk.timeStamp = 10;
    std::string geUnAgingStartOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geModelLoad(new analysis::dvvp::ProfileFileChunk());
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingStartOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    geUnAgingEventChunk.timeStamp = 100;
    std::string geUnAgingEndOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingEndOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    // rt unaging
    struct MsprofCompactInfo rtDataChunk;
    struct MsprofRuntimeTrack rtInnerData;
    rtInnerData.taskId = 1;
    rtInnerData.streamId = 1;
    rtDataChunk.data.runtimeTrack = rtInnerData;
    rtDataChunk.level = MSPROF_REPORT_RUNTIME_LEVEL;
    rtDataChunk.timeStamp = 50;
    rtDataChunk.threadId = 1;
    std::string rtData((char *)&rtDataChunk, sizeof(rtDataChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtTaskDesc(new analysis::dvvp::ProfileFileChunk());
    rtTaskDesc->fileName = "unaging.compact.task_track";
    rtTaskDesc->extraInfo = "0.0";
    rtTaskDesc->chunk = rtData;
    rtTaskDesc->chunkSize = sizeof(rtDataChunk);
    analyzer->OnOptimizeData(rtTaskDesc);

    // rt aging
    struct MsprofCompactInfo rtDataAgingChunk;
    struct MsprofRuntimeTrack rtInnerAgingData;
    rtInnerAgingData.taskId = 1;
    rtInnerAgingData.streamId = 1;
    rtDataAgingChunk.data.runtimeTrack = rtInnerAgingData;
    rtDataAgingChunk.level = MSPROF_REPORT_RUNTIME_LEVEL;
    rtDataAgingChunk.timeStamp = 60;
    rtDataAgingChunk.threadId = 1;
    std::string rtAgingData((char *)&rtDataAgingChunk, sizeof(rtDataChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    rtAgingTaskDesc->fileName = "aging.compact.task_track";
    rtAgingTaskDesc->extraInfo = "0.0";
    rtAgingTaskDesc->chunk = rtAgingData;
    rtAgingTaskDesc->chunkSize = sizeof(rtDataAgingChunk);
    analyzer->OnOptimizeData(rtAgingTaskDesc);

    // Hwts
    struct HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 1;
    hwtsChunk.streamId = 1;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 10000; // 100start
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data.null";
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    hwtsChunk.cntRes0Type = HWTS_TASK_END_TYPE;
    hwtsChunk.syscnt = 20000; // 200end
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    // ffts
    StarsCxtLog fftsCxtLog;
    fftsCxtLog.head.logType = FFTS_SUBTASK_THREAD_START_FUNC_TYPE;
    fftsCxtLog.streamId = 8292; // 2^13 + 100
    fftsCxtLog.taskId = 200;
    fftsCxtLog.sysCountLow = 1000;
    fftsCxtLog.sysCountHigh = 0;
    fftsCxtLog.cxtId = 300;
    fftsCxtLog.threadId = 400;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> ffts(new analysis::dvvp::ProfileFileChunk());
    ffts->fileName = "stars_soc.data.null";
    ffts->chunk.append(reinterpret_cast<char *>(&fftsCxtLog), sizeof(fftsCxtLog));
    ffts->chunkSize = sizeof(fftsCxtLog);
    analyzer->OnOptimizeData(ffts);
    fftsCxtLog.head.logType = FFTS_SUBTASK_THREAD_END_FUNC_TYPE;
    fftsCxtLog.sysCountLow = 2000;
    fftsCxtLog.sysCountHigh = 0;
    ffts->chunk.clear();
    ffts->chunk.append(reinterpret_cast<char *>(&fftsCxtLog), sizeof(fftsCxtLog));
    analyzer->OnOptimizeData(ffts);

    StarsAcsqLog fftsAcsqLog;
    fftsAcsqLog.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    fftsAcsqLog.streamId = 4097; // 2^12 + 1
    fftsAcsqLog.taskId = 1;
    fftsAcsqLog.sysCountLow = 10000;
    ffts->chunk.clear();
    ffts->chunk.append(reinterpret_cast<char *>(&fftsAcsqLog), sizeof(fftsAcsqLog));
    analyzer->OnOptimizeData(ffts);
    fftsAcsqLog.head.logType = ACSQ_TASK_END_FUNC_TYPE;
    fftsAcsqLog.sysCountLow = 20000;
    ffts->chunk.clear();
    ffts->chunk.append(reinterpret_cast<char *>(&fftsAcsqLog), sizeof(fftsAcsqLog));
    analyzer->OnOptimizeData(ffts);

    // check
    EXPECT_EQ(0, analyzer->geApiInfo_.size());
    EXPECT_EQ(1, analyzer->geModelInfo_.size());
    EXPECT_EQ(0, analyzer->geNodeInfo_.size());
    EXPECT_EQ(1, analyzer->rtOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsOpInfo_.size());
    EXPECT_EQ(2, analyzer->opDescInfos_.size());
    EXPECT_EQ(1, analyzer->geOpInfo_.size());

    // end_info
    std::string endInfoData("collectionDateEnd");
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> endInfoDesc(new analysis::dvvp::ProfileFileChunk());
    endInfoDesc->fileName = "end_info";
    endInfoDesc->extraInfo = "0.0";
    endInfoDesc->chunk = endInfoData;
    endInfoDesc->chunkSize = endInfoData.size();
    endInfoDesc->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA;
    analyzer->OnOptimizeData(endInfoDesc);

    // check all data clear
    EXPECT_EQ(0, analyzer->geApiInfo_.size());
    EXPECT_EQ(0, analyzer->geModelInfo_.size());
    EXPECT_EQ(0, analyzer->geNodeInfo_.size());
    EXPECT_EQ(0, analyzer->rtOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsOpInfo_.size());
    EXPECT_EQ(0, analyzer->opDescInfos_.size());
    EXPECT_EQ(0, analyzer->geOpInfo_.size());

    // UnSubscribe
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg2),
        sizeof(cfg2)));
    EXPECT_EQ(ACL_SUCCESS, aclprofDestroySubscribeConfig(profSubconfig));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UnInit());
    ConfigManager::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, new_struct_subscribe_hostlate_rt) {
    using namespace Msprofiler::Api;
    using namespace Analysis::Dvvp::Analyze;
    GlobalMockObject::verify();
    ConfigManager::instance()->Init();
    ConfigManager::instance()->configMap_["frq"] = std::to_string(100000);
    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));

    // Subscribe
    int fd = 1;
    struct ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);
    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 2;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    std::string data;
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->geApiInfo_ = {};
    analyzer->geModelInfo_ = {};
    analyzer->geNodeInfo_ = {};
    analyzer->rtOpInfo_ = {};
    analyzer->tsOpInfo_ = {};
    analyzer->opDescInfos_ = {};
    analyzer->geOpInfo_ = {};
    analyzer->devTmpOpInfo_ = {};
    analyzer->tsTmpOpInfo_ = {};

    RtOpInfo rtInfo;
    analyzer->rtOpInfo_["2-2"] = rtInfo;
    // Hwts
    struct HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 1;
    hwtsChunk.streamId = 1;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 10000; // 100start
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data.null";
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    hwtsChunk.cntRes0Type = HWTS_TASK_END_TYPE;
    hwtsChunk.syscnt = 20000; // 200end
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    // ge api unaging
    struct MsprofApi geUnAgingTaskDescChunk;
    geUnAgingTaskDescChunk.type = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    geUnAgingTaskDescChunk.beginTime = 40;
    geUnAgingTaskDescChunk.endTime = 60;
    geUnAgingTaskDescChunk.threadId = 1;
    std::string geUnAgingOriData((char *)&geUnAgingTaskDescChunk, sizeof(geUnAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geUnAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geUnAgingTaskDesc->fileName = "unaging.api_event.null";
    geUnAgingTaskDesc->chunk =  geUnAgingOriData;
    geUnAgingTaskDesc->chunkSize = sizeof(geUnAgingTaskDescChunk);
    analyzer->OnOptimizeData(geUnAgingTaskDesc);

    // ge node
    struct MsprofNodeBasicInfo nodeData;
    struct MsprofCompactInfo geTaskDescChunk;
    nodeData.opName = 123456;
    nodeData.opType = 654321;
    geTaskDescChunk.level = MSPROF_REPORT_NODE_LEVEL;
    geTaskDescChunk.data.nodeBasicInfo = nodeData;
    geTaskDescChunk.threadId = 1;
    geTaskDescChunk.timeStamp = 60;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "unaging.compact.node_basic_info";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzer->OnOptimizeData(geTaskDesc);

    // ge model load
    struct MsprofEvent geUnAgingEventChunk;
    geUnAgingEventChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    geUnAgingEventChunk.type = MSPROF_REPORT_MODEL_LOAD_TYPE;
    geUnAgingEventChunk.threadId = 1;
    geUnAgingEventChunk.itemId = 1;
    geUnAgingEventChunk.timeStamp = 10;
    std::string geUnAgingStartOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geModelLoad(new analysis::dvvp::ProfileFileChunk());
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingStartOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    geUnAgingEventChunk.timeStamp = 100;
    std::string geUnAgingEndOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingEndOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    // rt unaging
    struct MsprofCompactInfo rtDataChunk;
    struct MsprofRuntimeTrack rtInnerData;
    rtInnerData.taskId = 1;
    rtInnerData.streamId = 1;
    rtDataChunk.data.runtimeTrack = rtInnerData;
    rtDataChunk.level = MSPROF_REPORT_RUNTIME_LEVEL;
    rtDataChunk.timeStamp = 50;
    rtDataChunk.threadId = 1;
    std::string rtData((char *)&rtDataChunk, sizeof(rtDataChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtTaskDesc(new analysis::dvvp::ProfileFileChunk());
    rtTaskDesc->fileName = "unaging.compact.task_track";
    rtTaskDesc->extraInfo = "0.0";
    rtTaskDesc->chunk = rtData;
    rtTaskDesc->chunkSize = sizeof(rtDataChunk);
    analyzer->OnOptimizeData(rtTaskDesc);

    // check
    EXPECT_EQ(0, analyzer->geApiInfo_.size());
    EXPECT_EQ(1, analyzer->geModelInfo_.size());
    EXPECT_EQ(0, analyzer->geNodeInfo_.size());
    EXPECT_EQ(2, analyzer->rtOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsOpInfo_.size());
    EXPECT_EQ(1, analyzer->opDescInfos_.size());
    EXPECT_EQ(1, analyzer->geOpInfo_.size());
    EXPECT_EQ(0, analyzer->devTmpOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsTmpOpInfo_.size());

    // UnSubscribe
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, aclprofDestroySubscribeConfig(profSubconfig));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UnInit());
    ConfigManager::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, new_struct_subscribe_hostlate_ge) {
    using namespace Msprofiler::Api;
    using namespace Analysis::Dvvp::Analyze;
    GlobalMockObject::verify();
    ConfigManager::instance()->Init();
    ConfigManager::instance()->configMap_["frq"] = std::to_string(100000);
    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));

    // Subscribe
    int fd = 1;
    struct ProfSubscribeConfig config;
    config.timeInfo = true;
    config.aicoreMetrics = PROF_AICORE_NONE;
    config.fd = static_cast<void *>(&fd);
    auto profSubconfig = aclprofCreateSubscribeConfig(1, (aclprofAicoreMetrics)config.aicoreMetrics, config.fd);
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 2;
    cfg.metrics = static_cast<uint32_t>(config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(config.fd);
    cfg.cacheFlag = config.timeInfo;
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));

    std::string data;
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->geApiInfo_ = {};
    analyzer->geModelInfo_ = {};
    analyzer->geNodeInfo_ = {};
    analyzer->rtOpInfo_ = {};
    analyzer->tsOpInfo_ = {};
    analyzer->opDescInfos_ = {};
    analyzer->geOpInfo_ = {};
    analyzer->devTmpOpInfo_ = {};
    analyzer->tsTmpOpInfo_ = {};

    // Hwts
    struct HwtsProfileType01 hwtsChunk;
    hwtsChunk.taskId = 1;
    hwtsChunk.streamId = 1;
    hwtsChunk.cntRes0Type = HWTS_TASK_START_TYPE;
    hwtsChunk.syscnt = 10000; // 100start
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> hwts(new analysis::dvvp::ProfileFileChunk());
    hwts->fileName = "hwts.data.null";
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    hwtsChunk.cntRes0Type = HWTS_TASK_END_TYPE;
    hwtsChunk.syscnt = 20000; // 200end
    hwts->chunk.clear();
    hwts->chunk.append(reinterpret_cast<char *>(&hwtsChunk), sizeof(HwtsProfileType01));
    hwts->chunkSize = sizeof(HwtsProfileType01);
    analyzer->OnOptimizeData(hwts);

    // rt unaging
    struct MsprofCompactInfo rtDataChunk;
    struct MsprofRuntimeTrack rtInnerData;
    rtInnerData.taskId = 1;
    rtInnerData.streamId = 1;
    rtDataChunk.data.runtimeTrack = rtInnerData;
    rtDataChunk.level = MSPROF_REPORT_RUNTIME_LEVEL;
    rtDataChunk.timeStamp = 50;
    rtDataChunk.threadId = 1;
    std::string rtData((char *)&rtDataChunk, sizeof(rtDataChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> rtTaskDesc(new analysis::dvvp::ProfileFileChunk());
    rtTaskDesc->fileName = "unaging.compact.task_track";
    rtTaskDesc->extraInfo = "0.0";
    rtTaskDesc->chunk = rtData;
    rtTaskDesc->chunkSize = sizeof(rtDataChunk);
    analyzer->OnOptimizeData(rtTaskDesc);

    // device info not match
    RtOpInfo devTmpData;
    devTmpData.tsTrackTimeStamp = 100;
    devTmpData.threadId = 1;
    analyzer->devTmpOpInfo_.emplace_back(std::move(devTmpData));

    // ge api unaging
    struct MsprofApi geUnAgingTaskDescChunk;
    geUnAgingTaskDescChunk.type = MSPROF_REPORT_NODE_LAUNCH_TYPE;
    geUnAgingTaskDescChunk.beginTime = 40;
    geUnAgingTaskDescChunk.endTime = 60;
    geUnAgingTaskDescChunk.threadId = 1;
    std::string geUnAgingOriData((char *)&geUnAgingTaskDescChunk, sizeof(geUnAgingTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geUnAgingTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geUnAgingTaskDesc->fileName = "unaging.api_event.null";
    geUnAgingTaskDesc->chunk = geUnAgingOriData;
    geUnAgingTaskDesc->chunkSize = sizeof(geUnAgingTaskDescChunk);
    analyzer->OnOptimizeData(geUnAgingTaskDesc);

    // ge node
    struct MsprofNodeBasicInfo nodeData;
    struct MsprofCompactInfo geTaskDescChunk;
    nodeData.opName = 123456;
    nodeData.opType = 654321;
    geTaskDescChunk.level = MSPROF_REPORT_NODE_LEVEL;
    geTaskDescChunk.data.nodeBasicInfo = nodeData;
    geTaskDescChunk.threadId = 1;
    geTaskDescChunk.timeStamp = 60;
    std::string geOriData((char *)&geTaskDescChunk, sizeof(geTaskDescChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geTaskDesc(new analysis::dvvp::ProfileFileChunk());
    geTaskDesc->fileName = "unaging.compact.node_basic_info";
    geTaskDesc->extraInfo = "0.0";
    geTaskDesc->chunk = geOriData;
    geTaskDesc->chunkSize = sizeof(geTaskDescChunk);
    analyzer->OnOptimizeData(geTaskDesc);

    // ge model load
    struct MsprofEvent geUnAgingEventChunk;
    geUnAgingEventChunk.level = MSPROF_REPORT_MODEL_LEVEL;
    geUnAgingEventChunk.type = MSPROF_REPORT_MODEL_LOAD_TYPE;
    geUnAgingEventChunk.threadId = 1;
    geUnAgingEventChunk.itemId = 1;
    geUnAgingEventChunk.timeStamp = 10;
    std::string geUnAgingStartOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> geModelLoad(new analysis::dvvp::ProfileFileChunk());
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingStartOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    geUnAgingEventChunk.timeStamp = 100;
    std::string geUnAgingEndOriData((char *)&geUnAgingEventChunk, sizeof(geUnAgingEventChunk));
    geModelLoad->fileName = "unaging.api_event.null";
    geModelLoad->chunk = geUnAgingEndOriData;
    geModelLoad->chunkSize = sizeof(geUnAgingEventChunk);
    analyzer->OnOptimizeData(geModelLoad);

    // check
    EXPECT_EQ(0, analyzer->geApiInfo_.size());
    EXPECT_EQ(1, analyzer->geModelInfo_.size());
    EXPECT_EQ(0, analyzer->geNodeInfo_.size());
    EXPECT_EQ(1, analyzer->rtOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsOpInfo_.size());
    EXPECT_EQ(1, analyzer->opDescInfos_.size());
    EXPECT_EQ(1, analyzer->geOpInfo_.size());
    EXPECT_EQ(1, analyzer->devTmpOpInfo_.size());
    EXPECT_EQ(0, analyzer->tsTmpOpInfo_.size());

    // UnSubscribe
    EXPECT_EQ(ACL_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg)));
    EXPECT_EQ(ACL_SUCCESS, aclprofDestroySubscribeConfig(profSubconfig));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UnInit());
    ConfigManager::instance()->Uninit();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ge_api_subscribe) {
    GlobalMockObject::verify();

    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();

    MOCKER(mmWrite)
        .stubs()
        .will(invoke(mmWriteStub));
    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::ProfGetDeviceIdByGeModelIdx)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

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

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclgrphProfGraphSubscribe(1, nullptr));

    EXPECT_EQ(ge::SUCCESS, aclgrphProfGraphSubscribe(1, profSubconfig));

    EXPECT_EQ(ge::SUCCESS, aclgrphProfGraphUnSubscribe(1));

    aclprofDestroySubscribeConfig(profSubconfig);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, acl_json) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::WriteCtrlDataToFile)
            .stubs()
            .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(100000000)); // 100MB
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::string aclJson("{\"switch\": \"on\", \"storage_limit\": \"500MB\"}");
    auto data = (void *)(const_cast<char *>(aclJson.c_str()));
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_ACL_JSON, data, aclJson.size()));

    aclJson = "{\"switch\": \"on\", \"l2\": \"on\"}";
    data = (void *)(const_cast<char *>(aclJson.c_str()));
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_ACL_JSON, data, aclJson.size()));
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, true);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);
    Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 0, false);
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfFinalize());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ge_option) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::WriteCtrlDataToFile)
            .stubs()
            .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::string result = "/tmp/profiler_st_ge_option_normal";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);

    NanoJson::Json message;
    message["output"] = result;
    message["aic_metrics"] = "ArithmeticUtilization";
    message["training_trace"] = "on";
    message["task_trace"] = "on";
    message["aicpu"] = "on";
    message["l2"] = "on";
    message["storage_limit"] = "500MB";

    std::string geOption = message.ToString();
    MsprofGeOptions options = {0};
    strcpy(options.jobId, "jobId");
    for (size_t i = 0; i < geOption.size(); i++) {
        options.options[i] = geOption.at(i);
    }
    auto jsonData = (void *)&options;

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_GE_OPTIONS, jsonData, sizeof(options)));
    MsprofNotifySetDevice(0, 0, true);
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofFinalize());
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ge_option_profInit) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(100000000));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));

    std::string ge_json = "{\"aicpu\": \"on\",\"l2\": \"on\",\"aiv_metrics\": \"ArithmeticUtilization\",\"aiv-mode\": \"sampling-based\"}";
    struct MsprofGeOptions options;
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_GE_OPTIONS, (void *)&options, sizeof(options)));
    ge_json = "{\"aicpu\": \"abc\",\"l2\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_GE_OPTIONS, (void *)&options, sizeof(options)));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, dynamic_profInit)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER(&DynProfMgr::IsDynStarted)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER(&DynProfMgr::StartDynProf)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDynProfMode)
        .stubs()
        .will(returnValue(true));
    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("")));
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_DYNA, nullptr, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, Analysis::Dvvp::ProfilerCommon::ProfInit(MSPROF_CTRL_INIT_DYNA, nullptr, 0));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ge_option_ParamAdaper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitGeOptions(nullptr, 2));
    MOCKER_CPP(&ProfAclMgr::CallbackInitPrecheck)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    struct MsprofGeOptions options;
    std::string result = "/tmp/profiler_st_ge_option";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    std::string ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0xd\",\"aicpu\": \"on\",\"l2\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom:0x500,0x502,0x504,0x506,0x508,0x50a,0xc,0xss\",\"aicpu\": \"on\",\"l2\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    ge_json = "{\"output\": \"/tmp/MsprofInitGeOptions\",\"aic_metrics\": \"Custom;0x5\",\"aicpu\": \"on\",\"l2\": \"on\"}";
    strcpy(options.jobId, "123");
    strcpy(options.options, ge_json.c_str());
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, ProfAclMgr::instance()->MsprofInitGeOptions((void *)&options, sizeof(options)));
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofInitHelper) {
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
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofInitPureCpu) {
    GlobalMockObject::verify();

    using namespace Msprofiler::Api;
    EXPECT_EQ(3, ProfAclMgr::instance()->MsprofInitPureCpu(nullptr, 0));
    MOCKER(mmGetEnv)
        .stubs()
        .will(returnValue(EN_ERR));
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
    ProfAclMgr::instance()->MsprofFinalizeHandle();

    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("")))
        .then(returnValue(std::string("")))
        .then(returnValue(std::string("")))
        .then(returnValue(std::string("2023")));
    std::string deviceId = "0";
    struct MsprofCommandHandleParams commandParams;
    memset_s(&commandParams, sizeof(MsprofCommandHandleParams), 0, sizeof(MsprofCommandHandleParams));
    commandParams.pathLen = deviceId.size();
    strncpy_s(commandParams.path, PATH_LEN_MAX + 1, deviceId.c_str(), PATH_LEN_MAX);
    commandParams.storageLimit = 250;
    commandParams.profDataLen = jsonParams.size();
    strncpy_s(commandParams.profData, PARAM_LEN_MAX + 1, jsonParams.c_str(), PARAM_LEN_MAX);
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_PURE_CPU, (void *)&commandParams, sizeof(commandParams)));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, init_env) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(100000000)); // 100MB
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDynProfMode)
        .stubs()
        .will(returnValue(false));

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
                       \"ts_timeline\":\"on\",\"ts_track1\":\"\",\"storage_limit\": \"1000MB\"}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_ACL_ENV, nullptr, 0));
    MsprofNotifySetDevice(0, 0, true);
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofFinalize());
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, mode_protect) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofHostSysHandle) {
    using namespace Msprofiler::Api;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    params->host_osrt_profiling = "on";
    ProfAclMgr::instance()->params_ = params;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    ProfAclMgr::instance()->MsprofTxHandle();
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->MsprofFinalizeHandle());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, DoHostHandle) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, FinalizeHandle_CheckFalseMode) {
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;

    int32_t ret = ProfAclMgr::instance()->MsprofFinalizeHandle();
    EXPECT_EQ(MSPROF_ERROR_NONE, ret);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, FinalizeHandle_CheckTrueMode) {
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;

    int32_t ret = ProfAclMgr::instance()->MsprofFinalizeHandle();
    EXPECT_EQ(MSPROF_ERROR_NONE, ret);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, GEFinalizeHandle_CheckRet) {
    using namespace Msprofiler::Api;
    MOCKER_CPP(&ProfAclMgr::GetRunningDevices)
        .stubs();

    MOCKER_CPP(&Msprof::Engine::FlushAllModule)
        .stubs();
    Analysis::Dvvp::ProfilerCommon::ProfFinalize();
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, SetHelperDirToTransport)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->Init();
    ProfAclMgr::instance()->resultPath_ = "./tmp";
    ProfAclMgr::instance()->devUuid_["64"] = "host";
    MOCKER(&Utils::GetPid)
        .stubs()
        .will(returnValue(12345));
    EXPECT_EQ(PROFILING_FAILED, SetHelperDirToTransport(""));

    MOCKER_CPP(&Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, SetHelperDirToTransport("64.15151"));

    std::shared_ptr<FILETransport> transport(new FILETransport("./tmp", "200MB"));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    std::shared_ptr<FileSlice> fileslice(new FileSlice(2048, "./tmp", "200MB"));
    fileslice->Init(false);
    transport->Init();
    transport->perfCount_ = perfCount;
    transport->SetAbility(false);
    transport->fileSlice_ = fileslice;

    auto uploader = std::make_shared<Uploader>(transport);
    MOCKER_CPP(&UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));

    SetHelperDirToTransport("64.15151"); // Set helper map
    EXPECT_EQ(1, transport->helperStorageMap_.size());
    ProfAclMgr::instance()->UnInit();

    std::shared_ptr<analysis::dvvp::ProfileFileChunk> message(
        new analysis::dvvp::ProfileFileChunk());
    std::string chunkData = "test data test data";
    message->fileName = "aging.compact.node_basic_info";
    message->extraInfo = "null.64";
    message->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    message->chunkSize = chunkData.size();
    message->chunk = chunkData;
    message->id = "64.15151";

    MOCKER_CPP(&FileSlice::WriteToLocalFiles)
            .stubs()
            .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, transport->SendBuffer(message));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, SendHelperDataWithValidUploader)
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, SendHelperDataWithInvalidUploader)
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

void GetRunningDeviceStub(Msprofiler::Api::ProfAclMgr *This, std::vector<uint32_t> &devIds)
{
    devIds.push_back(0);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProcessHelperHostConfig)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetRunningDevices)
        .stubs()
        .will(invoke(GetRunningDeviceStub));

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

class MSPROF_API_SUBSCRIBE_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
};

TEST_F(MSPROF_API_SUBSCRIBE_STEST, AnalyzerTs_Parse_Repeat_Keypoint) {
    using namespace Analysis::Dvvp::Analyze;
    std::shared_ptr<AnalyzerTs> analyzerTs(new AnalyzerTs());
    analyzerTs->Parse(nullptr);
    // keypoint start
    TsProfileKeypoint tsChunk1;
    tsChunk1.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsChunk1.head.bufSize = sizeof(TsProfileKeypoint);
    tsChunk1.modelId = 1;
    tsChunk1.indexId = 1;
    tsChunk1.taskId = 1;
    tsChunk1.streamId = 1;
    tsChunk1.tagId = TS_KEYPOINT_START_TASK_STATE;
    tsChunk1.timestamp = 1000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKeypoint1(new analysis::dvvp::ProfileFileChunk());
    tsKeypoint1->fileName = "ts_track.data.null";
    tsKeypoint1->chunk.append(reinterpret_cast<char *>(&tsChunk1), tsChunk1.head.bufSize);
    tsKeypoint1->chunkSize = tsChunk1.head.bufSize;
    analyzerTs->Parse(tsKeypoint1);
    // keypoint end
    TsProfileKeypoint tsChunk2;
    tsChunk2.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsChunk2.head.bufSize = sizeof(TsProfileKeypoint);
    tsChunk2.modelId = 1;
    tsChunk2.indexId = 1;
    tsChunk2.taskId = 1;
    tsChunk2.streamId = 1;
    tsChunk2.tagId = TS_KEYPOINT_END_TASK_STATE;
    tsChunk2.timestamp = 2000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKeypoint2(new analysis::dvvp::ProfileFileChunk());
    tsKeypoint2->fileName = "ts_track.data.null";
    tsKeypoint2->chunk.append(reinterpret_cast<char *>(&tsChunk2), tsChunk2.head.bufSize);
    tsKeypoint2->chunkSize = tsChunk2.head.bufSize;
    analyzerTs->Parse(tsKeypoint2);
    // keypoint start error
    TsProfileKeypoint tsChunk3;
    tsChunk3.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsChunk3.head.bufSize = sizeof(TsProfileKeypoint);
    tsChunk3.modelId = 1;
    tsChunk3.indexId = 1;
    tsChunk3.taskId = 2;
    tsChunk3.streamId = 2;
    tsChunk3.tagId = TS_KEYPOINT_START_TASK_STATE;
    tsChunk3.timestamp = 3000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKeypoint3(new analysis::dvvp::ProfileFileChunk());
    tsKeypoint3->fileName = "ts_track.data.null";
    tsKeypoint3->chunk.append(reinterpret_cast<char *>(&tsChunk3), tsChunk3.head.bufSize);
    tsKeypoint3->chunkSize = tsChunk3.head.bufSize;
    analyzerTs->Parse(tsKeypoint3);
    // keypoint end error
    TsProfileKeypoint tsChunk4;
    tsChunk4.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsChunk4.head.bufSize = sizeof(TsProfileKeypoint);
    tsChunk4.modelId = 1;
    tsChunk4.indexId = 1;
    tsChunk4.taskId = 2;
    tsChunk4.streamId = 2;
    tsChunk4.tagId = TS_KEYPOINT_END_TASK_STATE;
    tsChunk4.timestamp = 4000000;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKeypoint4(new analysis::dvvp::ProfileFileChunk());
    tsKeypoint4->fileName = "ts_track.data.null";
    tsKeypoint4->chunk.append(reinterpret_cast<char *>(&tsChunk4), tsChunk4.head.bufSize);
    tsKeypoint4->chunkSize = tsChunk4.head.bufSize;
    analyzerTs->Parse(tsKeypoint4);
    // keypoint timestamp zero error
    TsProfileKeypoint tsChunk5;
    tsChunk5.head.rptType = TS_KEYPOINT_RPT_TYPE;
    tsChunk5.head.bufSize = sizeof(TsProfileKeypoint);
    tsChunk5.modelId = 1;
    tsChunk5.indexId = 2;
    tsChunk5.taskId = 3;
    tsChunk5.streamId = 3;
    tsChunk5.tagId = TS_KEYPOINT_START_TASK_STATE;
    tsChunk5.timestamp = 0;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> tsKeypoint5(new analysis::dvvp::ProfileFileChunk());
    tsKeypoint5->fileName = "ts_track.data.null";
    tsKeypoint5->chunk.append(reinterpret_cast<char *>(&tsChunk5), tsChunk5.head.bufSize);
    tsKeypoint5->chunkSize = tsChunk5.head.bufSize;
    analyzerTs->Parse(tsKeypoint5);
    // check
    EXPECT_EQ(1, analyzerTs->keypointOpInfo_.size());

    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->profileMode_ = PROFILE_MODE_STEP_TRACE;
    analyzer->analyzerTs_ = analyzerTs;
    analyzer->graphTypeFlag_ = true;
    analyzer->graphIdMap_.clear();
    analyzer->UploadKeypointOp();
    EXPECT_EQ(1, analyzer->analyzerTs_->keypointOpInfo_.size());

    analyzer->graphIdMap_.insert(std::pair<uint32_t, uint32_t>(1, 1000000));
    analyzer->UploadKeypointOp();
    EXPECT_EQ(1, analyzer->analyzerTs_->keypointOpInfo_.size());

    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    analyzer->graphIdMap_.clear();
    analyzer->UploadKeypointOp();
    EXPECT_EQ(1, analyzer->analyzerTs_->keypointOpInfo_.size());

    analyzer->graphIdMap_.insert(std::pair<uint32_t, uint32_t>(1, 1000000));
    analyzer->UploadKeypointOp();
    EXPECT_EQ(0, analyzer->analyzerTs_->keypointOpInfo_.size());
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, AnalyzerGe_MultiFftsNode) {
    GlobalMockObject::verify();

    std::shared_ptr<AnalyzerGe> analyzerGe(new AnalyzerGe());
    analyzerGe->geNodeInfo_ = {};
    analyzerGe->isFftsPlus_ = false;

    MsprofCompactInfo GeData;
    std::string FFTSTYPE = "FFTS_PLUS";
    MOCKER_CPP(&HashData::GetHashInfo)
        .stubs()
        .will(returnValue(FFTSTYPE));
    analyzerGe->HandleNodeBasicInfo((CONST_CHAR_PTR)(&GeData), false);
    analyzerGe->HandleNodeBasicInfo((CONST_CHAR_PTR)(&GeData), false); // second time
    EXPECT_EQ(0, analyzerGe->geNodeInfo_.size());
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, AnalyzerGe_Parse) {
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

TEST_F(MSPROF_API_SUBSCRIBE_STEST, AnalyzerGe_ParseOpName) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());
    struct MsprofGeProfTaskData geProfTaskData;
    memset(&geProfTaskData, 0, sizeof(MsprofGeProfTaskData));
    geProfTaskData.opName.type = MSPROF_MIX_DATA_STRING;
    struct Analysis::Dvvp::Analyze::AnalyzerGe::GeOpInfo opInfo;
    analyzerGe->ParseOpName(geProfTaskData, opInfo);
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, AnalyzerGe_ParseOpType) {
    std::shared_ptr<Analysis::Dvvp::Analyze::AnalyzerGe> analyzerGe(new Analysis::Dvvp::Analyze::AnalyzerGe());
    struct MsprofGeProfTaskData geProfTaskData;
    memset(&geProfTaskData, 0, sizeof(MsprofGeProfTaskData));
    geProfTaskData.opType.type = MSPROF_MIX_DATA_STRING;
    struct Analysis::Dvvp::Analyze::AnalyzerGe::GeOpInfo opInfo;
    analyzerGe->ParseOpType(geProfTaskData, opInfo);
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, Analyzer_UploadAppOpStepTrace) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<PipeTransport> pipeTransport = std::make_shared<PipeTransport>();
    SHARED_PTR_ALIA<Uploader> pipeUploader = std::make_shared<Uploader>(pipeTransport);
    pipeUploader->Init(100000);
    Analysis::Dvvp::Analyze::Analyzer analyzer(pipeUploader);
    analyzer.profileMode_ = PROFILE_MODE_STEP_TRACE;
    analyzer.analyzerGe_->opInfos_ =
        {{ "0-0", AnalyzerGe::GeOpInfo() }, { "0-100", AnalyzerGe::GeOpInfo() }, { "1-100", AnalyzerGe::GeOpInfo() }};

    std::multimap<std::string, OpTime> opTimes;                                // key0Res, key1Res
    opTimes.insert({ "0", OpTime{0,   1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});
    opTimes.insert({ "0", OpTime{100, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});  // true,    true
    opTimes.insert({ "0", OpTime{200, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});  // true,    false
    opTimes.insert({ "1", OpTime{100, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});  // false,   true
    analyzer.UploadAppOp(opTimes);
    EXPECT_EQ(1, opTimes.size());
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, Analyzer_UploadAppOpStaticShape) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<PipeTransport> pipeTransport = std::make_shared<PipeTransport>();
    SHARED_PTR_ALIA<Uploader> pipeUploader = std::make_shared<Uploader>(pipeTransport);
    pipeUploader->Init(100000);
    Analysis::Dvvp::Analyze::Analyzer analyzer(pipeUploader);
    analyzer.profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    analyzer.analyzerGe_->isAllStaticShape_ = false;
    analyzer.analyzerGe_->opInfos_ = {{ "0-0", AnalyzerGe::GeOpInfo() }};
    analyzer.analyzerGe_->steamState_ =
        {{ 100 , StreamInfo{ 0, 0, KNOWN_SHAPE_STREAM }}, { 200 , StreamInfo{ 0, 0, UNKNOWN_SHAPE_STREAM }}};

    std::multimap<std::string, OpTime> opTimes;
    opTimes.insert({ "0", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});
    opTimes.insert({ "0", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 200 }});
    opTimes.insert({ "0", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 100 }});
    opTimes.insert({ "1", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 100 }});

    analyzer.UploadAppOp(opTimes);
    EXPECT_EQ(2, opTimes.size());
}

TEST_F(MSPROF_API_SUBSCRIBE_STEST, Analyzer_UploadAppOpSingleOp) {
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<PipeTransport> pipeTransport = std::make_shared<PipeTransport>();
    SHARED_PTR_ALIA<Uploader> pipeUploader = std::make_shared<Uploader>(pipeTransport);
    pipeUploader->Init(100000);
    Analysis::Dvvp::Analyze::Analyzer analyzer(pipeUploader);
    analyzer.profileMode_ = PROFILE_MODE_SINGLE_OP;
    analyzer.analyzerGe_->opInfos_ = {{ "0-0", AnalyzerGe::GeOpInfo() }};

    std::multimap<std::string, OpTime> opTimes;
    opTimes.insert({ "0", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});
    opTimes.insert({ "1", OpTime{0, 1, 1, 0, 0, 0, ACL_SUBSCRIBE_OP, 0 }});

    analyzer.UploadAppOp(opTimes);
    EXPECT_EQ(1, opTimes.size());
}

class COMMANDHANDLE_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(COMMANDHANDLE_STEST, commandHandle_api) {
    GlobalMockObject::verify();

    std::string retStr(4099,'a');
    std::string zeroStr = "{}";
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetParamJsonStr)
        .stubs()
        .will(returnValue(retStr))
        .then(returnValue(zeroStr));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    uint32_t devList[] = {0, 1};
    uint32_t devNums = 2;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, AclProf_API_TEST) {
    using namespace Analysis::Dvvp::Analyze;

    MOCKER_CPP(&OpDescParser::GetModelId)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpDescSize)
        .stubs();

    MOCKER_CPP(&OpDescParser::GetOpNum)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpTypeLen)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpType)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpNameLen)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpName)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpStart)
        .stubs()
        .will(returnValue(0u));

    MOCKER_CPP(&OpDescParser::GetOpEnd)
        .stubs()
        .will(returnValue(0u));

    MOCKER_CPP(&OpDescParser::GetOpDuration)
        .stubs()
        .will(returnValue(0u));

    MOCKER_CPP(&OpDescParser::GetModelId)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

    MOCKER_CPP(&OpDescParser::GetOpFlag)
        .stubs()
        .will(returnValue(0u));

    size_t opDescSize = 0;
    aclprofGetModelId(nullptr, 0, 0);
    aclprofGetOpDescSize(nullptr);
    aclprofGetOpDescSize(&opDescSize);
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpNum(nullptr, 0, nullptr));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpTypeLen(nullptr, 0, 0, nullptr));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpType(nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpNameLen(nullptr, 0, 0, nullptr));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetOpName(nullptr, 0, 0, nullptr, 0));
    EXPECT_EQ(0u, aclprofGetOpFlag(nullptr, 0, 0));
    aclprofGetOpAttriValue(nullptr, 0, 0, (aclprofSubscribeOpAttri)0);
    aclprofGetOpStart(nullptr, 0, 0);
    aclprofGetOpEnd(nullptr, 0, 0);
    aclprofGetOpDuration(nullptr, 0, 0);
    aclprofGetOpStart(nullptr, 0, 0);
    aclprofGetOpEnd(nullptr, 0, 0);
    aclprofGetOpDuration(nullptr, 0, 0);
}


TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofTx_API_TEST) {
    using namespace Msprof::MsprofTx;
    Msprof::MsprofTx::MsprofStampInstance pstamp;

    MOCKER_CPP(&MsprofTxManager::CreateStamp)
        .stubs()
        .will(returnValue(static_cast<Msprof::MsprofTx::ACL_PROF_STAMP_PTR>(nullptr)));

    MOCKER_CPP(&MsprofTxManager::DestroyStamp)
        .stubs();

    MOCKER_CPP(&MsprofTxManager::SetCategoryName)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::SetStampCategory)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::SetStampPayload)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::SetStampTraceMessage)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::Mark)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::Push)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::Pop)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::RangeStart)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&MsprofTxManager::RangeStop)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(nullptr, aclprofCreateStamp());
    aclprofDestroyStamp(nullptr);
    aclprofDestroyStamp(&pstamp);
    EXPECT_EQ(PROFILING_SUCCESS, aclprofSetCategoryName(0, "Category01"));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofSetStampCategory(&pstamp, 0));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofSetStampPayload(&pstamp, 0, nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofSetStampTraceMessage(&pstamp, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofMark(&pstamp));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofPush(&pstamp));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofPop());
    EXPECT_EQ(PROFILING_SUCCESS, aclprofRangeStart(nullptr, nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, aclprofRangeStop(0));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(nullptr, aclprofCreateStamp());
    aclprofDestroyStamp(nullptr);
    aclprofDestroyStamp(&pstamp);
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetCategoryName(0, "Category01"));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampCategory(&pstamp, 0));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampPayload(&pstamp, 0, nullptr));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofSetStampTraceMessage(&pstamp, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofMark(&pstamp));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofPush(&pstamp));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofPop());
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofRangeStart(nullptr, nullptr));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, aclprofRangeStop(0));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, AclProfSetpInfo_API_TEST) {
    struct aclprofStepInfo *pStepInfo = aclprofCreateStepInfo();
    aclprofStepTag stepTag = ACL_STEP_START;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofGetStepTimestamp(nullptr, stepTag, nullptr));
    EXPECT_EQ(ACL_SUCCESS, aclprofGetStepTimestamp(pStepInfo, stepTag, nullptr));
    aclprofDestroyStepInfo(nullptr);
    aclprofDestroyStepInfo(pStepInfo);
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, RangeStop) {
    GlobalMockObject::verify();
    Msprof::MsprofTx::MsprofTxManager::instance()->isInit_ = true;
    Msprof::MsprofTx::MsprofTxManager::instance()->stampPool_ = std::make_shared<ProfStampPool>();
    MsprofStampInstance *ptr = nullptr;
    MOCKER_CPP(&ProfStampPool::GetStampById).stubs().will(returnValue(ptr));
    EXPECT_EQ(PROFILING_FAILED, Msprof::MsprofTx::MsprofTxManager::instance()->RangeStop(1));
    Msprof::MsprofTx::MsprofTxManager::instance()->isInit_ = false;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, SetStampTraceMessage) {
    GlobalMockObject::verify();
    Msprof::MsprofTx::MsprofStampInstance *ptr = (Msprof::MsprofTx::MsprofStampInstance *)0x1;
    EXPECT_EQ(PROFILING_FAILED, Msprof::MsprofTx::MsprofTxManager::instance()->SetStampTraceMessage(ptr, nullptr, 256));
}

int32_t MsprofAdditionalBufPushCallbackStub(uint32_t aging, const VOID_PTR data, uint32_t len)
{
    return 0;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ReportStampData) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, aclprofSetConfig_not_support) {
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_ARGS_MIN, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_ARGS_MAX, nullptr, 0));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, aclprofSetConfig_not_init) {
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    Msprofiler::Api::ProfAclMgr::instance()->UnInit();
    std::string config("50");
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_DVPP_FREQ, config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, IsValidProfConfig) {
    uint32_t deviceIdList[2]={0, 0};
    uint32_t deviceNums = 2;
    aclprofAicoreMetrics aicoreMetrics;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig;
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdList, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, IsValidProfConfig1) {
    uint32_t deviceIdList[2]={5, 0};
    uint32_t deviceNums = 2;
    aclprofAicoreMetrics aicoreMetrics;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, aclprofCreateConfig(deviceIdList, deviceNums, aicoreMetrics, aicoreEvents, dataTypeConfig));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, IsProfConfigValid) {
    ProfConfig config;
    config.devNums = 5;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, ge::aclgrphProfCreateConfig(config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, IsProfConfigValid1) {
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 5;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    EXPECT_EQ(nullptr, ge::aclgrphProfCreateConfig(config.devIdList, config.devNums, (ge::ProfilingAicoreMetrics)config.aicoreMetrics, nullptr, 0xffffffff));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfStop) {
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x0080;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopPrecheck).stubs().will(returnValue(0));
    MOCKER((int (Msprofiler::Api::ProfAclMgr::*)(const uint32_t devId, uint64_t &dataTypeConfig))&Msprofiler::Api::ProfAclMgr::ProfAclGetDataTypeConfig).stubs().will(returnValue(0));
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfStop(ACL_API_TYPE, &config));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfNotifySetDeviceForDynProf)
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


TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofResultDirAdapter) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofGeOptionsParamConstruct) {
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
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
    inputCfgPbo["aic_metrics"] = "PipeUtilization";
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofGeOptionsParamConstruct("hello", inputCfgPbo));
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, SendBuffer) {
    GlobalMockObject::verify();
    std::shared_ptr<FILETransport> trans(new FILETransport("/tmp", "200MB"));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    trans->perfCount_ = perfCount;
    trans->Init();

    std::string buff = "test SendBuffer";
    EXPECT_EQ(0, trans->SendBuffer(buff.c_str(), buff.size()));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfAclGetId) {
    GlobalMockObject::verify();
    void* data = (void*)0x12345678;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclGetId(ACL_API_TYPE, data, 0, 0));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfAclGetOpTime) {
    GlobalMockObject::verify();
    void* data = (void*)0x12345678;
    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_START, data, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_END, data, 0, 0));
    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclGetOpTime(ACL_OP_DURATION, data, 0, 0));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, PROFAPICOMMON) {
    GlobalMockObject::verify();
    void* data = (void*)0x12345678;
    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));

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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfGetOpExecutionTime) {
    GlobalMockObject::verify();
    void* data = (void*)0x12345678;
    MOCKER_CPP(&Analysis::Dvvp::Analyze::OpDescParser::CheckData)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::Api::ProfGetOpExecutionTime(data, 0, 0));
}

extern "C" int32_t ProfImplReportRegTypeInfo(uint16_t level, uint32_t type, const std::string &typeName);
extern "C" uint64_t ProfImplReportGetHashId(const std::string &info);
extern "C" bool ProfImplHostFreqIsEnable();

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfImplReportRegTypeInfo)
{
    std::string typeName = "ReportRegTypeInfo";
    EXPECT_EQ(0, ProfImplReportRegTypeInfo(0, 0, typeName));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfImplReportGetHashId)
{
    std::string hashInfo = "ReportRegTypeInfo";
    EXPECT_NE(0, ProfImplReportGetHashId(hashInfo));
    std::string empty;
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), ProfImplReportGetHashId(empty));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfImplHostFreqIsEnable)
{
    EXPECT_EQ(false, ProfImplHostFreqIsEnable());
    int64_t outFreq = 1000;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(any(), any(), any(), outBoundP(&outFreq))
        .will(returnValue(DRV_ERROR_NONE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    EXPECT_EQ(true, ProfImplHostFreqIsEnable());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, GetReportTypeInfo)
{
    std::string typeName = "memcpy_info";
    EXPECT_EQ(0, ProfImplReportRegTypeInfo(5000, 801, typeName));
    std::string name;
    Dvvp::Collect::Report::ProfReporterMgr::GetInstance().GetReportTypeInfo(5000, 801, name);
    EXPECT_EQ(0, name.compare("memcpy_info"));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, StartReporters)
{
    EXPECT_EQ(0, Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StartReporters());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, StopReporters)
{
    EXPECT_EQ(0, Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StopReporters());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfAclStartMultiDevice) {
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

    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::StartReqTrfToInnerParam)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::StartDeviceTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::WaitAllDeviceResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    using namespace Msprofiler::Api;

    struct MsprofConfig config;
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    config.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.profSwitch = 0x7d7f001f;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    std::string profResultPath("tmp");
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfAclInit(profResultPath));
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, config.profSwitch, params};
    ProfAclMgr::instance()->devTasks_[0] = taskInfo;
    ProfAclMgr::instance()->devTasks_[64] = taskInfo;
    ProfAclMgr::instance()->devTasks_[64].params->isCancel = false;
    EXPECT_EQ(ACL_ERROR_PROF_ALREADY_RUN, ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    config.devNums = 2;
    config.devIdList[0] = 1;
    config.devIdList[1] = DEFAULT_HOST_ID;
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    ProfAclMgr::instance()->devTasks_[1] = taskInfo;
    taskInfo.count = 2;
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    EXPECT_EQ(true, ProfAclMgr::instance()->devTasks_.empty());

    // milan
    GlobalMockObject::verify();
    Analysis::Dvvp::Common::Config::ConfigManager::instance()->Init();
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartAscendProfHalTask)
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
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    config.metrics = PROF_AICORE_NONE;
    config.profSwitch = 0x40000000000008ffULL;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    std::shared_ptr<analysis::dvvp::message::ProfileParams> paramMilan(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfoMilan = {1, config.profSwitch, paramMilan};
    ProfAclMgr::instance()->devTasks_[0] = taskInfoMilan;
    taskInfoMilan.count = 1;
    ProfAclMgr::instance()->devTasks_[64] = taskInfoMilan;
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    EXPECT_EQ(true, ProfAclMgr::instance()->devTasks_.empty());

    ProfAicoreMetrics nullType;
    nullType = ProfAicoreMetrics(255);
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    config.metrics = nullType;
    config.profSwitch = 0x40000000000008ffULL;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->Init());
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    taskInfoMilan = {1, config.profSwitch, paramMilan};
    ProfAclMgr::instance()->devTasks_[0] = taskInfoMilan;
    taskInfoMilan.count = 1;
    ProfAclMgr::instance()->devTasks_[64] = taskInfoMilan;
    EXPECT_EQ(ACL_SUCCESS, ProfConfigStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &config, sizeof(config)));
    EXPECT_EQ(true, ProfAclMgr::instance()->devTasks_.empty());
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, OtherTest) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::Engine::MsprofReporter::SendData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Msprof::Engine::MsprofReporter::InitReporters();
    Msprof::Engine::FlushModule();
    EXPECT_EQ(PROFILING_SUCCESS,  Msprof::Engine::SendAiCpuData(nullptr));
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, ProfStartAscendProfHalTask_Helper) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, CommandHandleFinalizeGuard_Base) {
    Analysis::Dvvp::ProfilerCommon::CommandHandleFinalizeGuard();
    EXPECT_EQ(true, ProfModuleReprotMgr::GetInstance().finalizeGuard_);
    ProfModuleReprotMgr::GetInstance().finalizeGuard_= false;
}

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofStart_PureCpu) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofStart_Common) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofStart_AclApi) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, MsprofStart_AclSubscribe) {
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

TEST_F(MSPROF_ACL_CORE_OPEN_STEST, Msprof_aclprofGetSupportedFeatures) {
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