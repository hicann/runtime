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
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <string.h>
#include <google/protobuf/util/json_util.h>
#include "config_manager.h"
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
#include "utils/llc_event_utils.h"
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
#include "transport/stats_transport.h"
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
#include "prof_inner_api.h"
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
#include "prof_l2cache_job.h"
#include "json_parser.h"
#include "stats_analyzer.h"

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

namespace {
std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> MakeNtsCollectionJobCfg(
    const std::shared_ptr<analysis::dvvp::message::ProfileParams> &params)
{
    auto collectionJobCfg = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
    auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
    comParams->params = params;
    comParams->jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();
    comParams->jobCtx->job_id = "acl_nts_ut";
    comParams->devId = 0;
    collectionJobCfg->comParams = comParams;
    return collectionJobCfg;
}

MsprofApi MakeStatsApiData(uint32_t hashName, uint64_t beginTime, uint64_t endTime)
{
    MsprofApi api = {};
    api.level = MSPROF_REPORT_ACL_LEVEL;
    api.type = hashName;
    api.threadId = 100;
    api.beginTime = beginTime;
    api.endTime = endTime;
    return api;
}

SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> MakeStatsChunk(const std::string &fileName,
    const std::string &data, int32_t chunkModule)
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->isLastChunk = true;
    chunk->chunkModule = chunkModule;
    chunk->chunkSize = data.size();
    chunk->offset = 0;
    chunk->chunk = data;
    chunk->fileName = fileName;
    return chunk;
}
}
struct aclprofConfig {
    ProfConfig config;
};

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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_ge_api) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetDevicesNotify)
        .stubs()
        .will(returnValue(true));

    std::string result = "/tmp/acl_api_utest_new";
    analysis::dvvp::common::utils::Utils::RemoveDir(result);
    analysis::dvvp::common::utils::Utils::CreateDir(result);
    Msprof::Engine::MsprofReporter::reporters_.clear();
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfInit(result.c_str(), result.size()));
    std::string empty = "";
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfInit(empty.c_str(), empty.size()));

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

    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStart(zeroConfig));
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStart(invalidConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfStart(aclConfig));

    ProfConfig largeConfig;
    largeConfig.devNums = MSVP_MAX_DEV_NUM + 1;
    largeConfig.devIdList[0] = 0;
    largeConfig.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    largeConfig.dataTypeConfig = 0x7d7f001f;
    ge::aclgrphProfConfig *largeAclConfig = ge::aclgrphProfCreateConfig(
        largeConfig.devIdList, largeConfig.devNums, (ge::ProfilingAicoreMetrics)largeConfig.aicoreMetrics, nullptr, largeConfig.dataTypeConfig);

    EXPECT_EQ(nullptr, largeAclConfig);
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_ge_api_part2) {
    GlobalMockObject::verify();
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_ge_api_part3) {
    GlobalMockObject::verify();
    MsprofHashData hData = {0};
    std::string hashData;
    ReporterData data = {0};
    std::string reportData;
    uint32_t dataMaxLen = 0;
    int ret = 0;
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_ge_api_part4) {
    GlobalMockObject::verify();
    std::string result = "/tmp/acl_api_utest_new";
    ge::aclgrphProfConfig *aclConfig = nullptr;
    ge::aclgrphProfConfig *zeroConfig = nullptr;
    ge::aclgrphProfConfig *invalidConfig = nullptr;
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStop(nullptr));
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfStop(zeroConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfStop(aclConfig));

    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfFinalize());

    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(zeroConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(invalidConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));

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
    EXPECT_EQ(ge::GE_PROF_FAILED, ge::aclgrphProfInit(result.c_str(), result.size()));
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

// GetResultPath: before init (resultPath_ empty) falls back to the configured ACL_PROF_PATH.
TEST_F(MSPROF_ACL_CORE_UTEST, GetResultPath_BeforeInit_FallbackToConfig) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->resultPath_.clear();
    ProfAclMgr::instance()->InitParams();
    ProfAclMgr::instance()->params_->resultPath = "/tmp/lww_cfg_path";

    EXPECT_EQ("/tmp/lww_cfg_path", ProfAclMgr::instance()->GetResultPath());

    ProfAclMgr::instance()->params_->resultPath.clear();
}

// GetResultPath: after init (resultPath_ set) returns the real landed absolute path.
TEST_F(MSPROF_ACL_CORE_UTEST, GetResultPath_AfterInit_ReturnsResultPath) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->InitParams();
    ProfAclMgr::instance()->params_->resultPath = "/tmp/lww_cfg_path";
    ProfAclMgr::instance()->resultPath_ = "/tmp/lww_real_abs_path";

    // resultPath_ (already canonicalized at init) takes precedence over the raw config value.
    EXPECT_EQ("/tmp/lww_real_abs_path", ProfAclMgr::instance()->GetResultPath());

    ProfAclMgr::instance()->params_->resultPath.clear();
    ProfAclMgr::instance()->resultPath_.clear();
}

static std::string PathIdentity_stub(const std::string &path)
{
    return path;
}

// last-write-wins, sequence B: Init(pathB) then SetConfig(ACL_PROF_PATH, pathA) -> pathA wins.
TEST_F(MSPROF_ACL_CORE_UTEST, AclProfPath_SetConfigAfterInit_Wins) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER(analysis::dvvp::common::utils::Utils::RelativePathToAbsolutePath)
        .stubs().will(invoke(PathIdentity_stub));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath)
        .stubs().will(invoke(PathIdentity_stub));
    MOCKER(analysis::dvvp::common::utils::Utils::CheckPathWithInvalidChar)
        .stubs().will(returnValue(true));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible)
        .stubs().will(returnValue(true));

    ProfAclMgr::instance()->InitParams();
    // simulate "already inited at /tmp/lww_init_b"
    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    ProfAclMgr::instance()->resultPath_ = "/tmp/lww_init_b";

    EXPECT_EQ(PROFILING_SUCCESS,
        ProfAclMgr::instance()->MsprofSetConfig(ACL_PROF_PATH, "/tmp/lww_setcfg_a"));
    // the later ACL_PROF_PATH overrides the path given at init time.
    EXPECT_EQ("/tmp/lww_setcfg_a", ProfAclMgr::instance()->resultPath_);
    EXPECT_EQ("/tmp/lww_setcfg_a", ProfAclMgr::instance()->GetResultPath());

    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    ProfAclMgr::instance()->resultPath_.clear();
    ProfAclMgr::instance()->params_->resultPath.clear();
}

// last-write-wins, sequence A: SetConfig(pathA) before init, then Init(pathB) -> pathB wins.
TEST_F(MSPROF_ACL_CORE_UTEST, AclProfPath_InitAfterSetConfig_Wins) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER(analysis::dvvp::common::utils::Utils::RelativePathToAbsolutePath)
        .stubs().will(invoke(PathIdentity_stub));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath)
        .stubs().will(invoke(PathIdentity_stub));
    MOCKER(analysis::dvvp::common::utils::Utils::CheckPathWithInvalidChar)
        .stubs().will(returnValue(true));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible)
        .stubs().will(returnValue(true));

    ProfAclMgr::instance()->Init();
    ProfAclMgr::instance()->isReady_ = true;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    ProfAclMgr::instance()->resultPath_.clear();
    // ACL_PROF_PATH set before init
    ProfAclMgr::instance()->InitParams();
    ProfAclMgr::instance()->params_->resultPath = "/tmp/lww_setcfg_a";

    // explicit init path should win over the earlier ACL_PROF_PATH
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfAclInit("/tmp/lww_init_b"));
    EXPECT_EQ("/tmp/lww_init_b", ProfAclMgr::instance()->resultPath_);

    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    ProfAclMgr::instance()->resultPath_.clear();
    ProfAclMgr::instance()->params_->resultPath.clear();
}

// ACL_PROF_PATH set after init with an invalid path must fail and not corrupt resultPath_.
TEST_F(MSPROF_ACL_CORE_UTEST, AclProfPath_SetConfigAfterInit_InvalidPath_Fails) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    MOCKER(analysis::dvvp::common::utils::Utils::RelativePathToAbsolutePath)
        .stubs().will(invoke(PathIdentity_stub));
    MOCKER(analysis::dvvp::common::utils::Utils::CheckPathWithInvalidChar)
        .stubs().will(returnValue(true));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_FAILED)));

    ProfAclMgr::instance()->InitParams();
    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    ProfAclMgr::instance()->resultPath_ = "/tmp/lww_init_keep";

    EXPECT_EQ(PROFILING_FAILED,
        ProfAclMgr::instance()->MsprofSetConfig(ACL_PROF_PATH, "/tmp/lww_bad_path"));
    // resultPath_ unchanged on failure.
    EXPECT_EQ("/tmp/lww_init_keep", ProfAclMgr::instance()->resultPath_);

    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    ProfAclMgr::instance()->resultPath_.clear();
    ProfAclMgr::instance()->params_->resultPath.clear();
}

static void CustomerSigHandler(int signum) {
    MSPROF_LOGI("CustomerSigHandler");
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_RegisterSignalHandlerTwice) {
    signal(SIGINT, CustomerSigHandler);
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api) {
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
    EXPECT_EQ(0, aclprofStart(aclConfig));
    config.dataTypeConfig = 0x7d7f001f;
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, aclprofStart(aclConfig));
    EXPECT_TRUE(Msprofiler::Api::ProfAclMgr::instance()->IsAclApiReady());
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_part2) {
    GlobalMockObject::verify();
    std::string result = "/tmp/acl_prof_api_stest_new";
    aclprofConfig *aclConfig = nullptr;
    aclprofConfig *zeroConfig = nullptr;
    aclprofConfig *invalidConfig = nullptr;
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

    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(zeroConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(invalidConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(aclConfig));
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe) {
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part2) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    int fd = 1;
    void *fdPtr = static_cast<void *>(&fd);
    uint32_t devId = 0;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = devId;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 1;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg.fd = reinterpret_cast<uintptr_t>(fdPtr);
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
    cfg2.fd = reinterpret_cast<uintptr_t>(fdPtr);
    cfg2.cacheFlag = true;
    EXPECT_EQ(ACL_SUCCESS, MsprofStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg2),
        sizeof(cfg2)));
    SHARED_PTR_ALIA<Msprofiler::Api::ProfSubscribeKey> subscribePtr =
        ProfAclMgr::instance()->GenerateSubscribeKey(&cfg);
    EXPECT_EQ(2, ProfAclMgr::instance()->GetDeviceSubscribeCount(subscribePtr, devId));
    EXPECT_TRUE(devId == 0);
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part3) {
    GlobalMockObject::verify();
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part4) {
    GlobalMockObject::verify();
    std::string data;
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part5) {
    GlobalMockObject::verify();
    std::string data;
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part6) {
    GlobalMockObject::verify();
    std::string data;
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part7) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    int fd = 1;
    void *fdPtr = static_cast<void *>(&fd);
    uint32_t devId = 0;
    MsprofGeProfTaskData geTaskDescChunk1{};
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part8) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    int fd = 1;
    void *fdPtr = static_cast<void *>(&fd);
    uint32_t devId = 0;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = devId;
    cfg.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg.modelId = 1;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg.fd = reinterpret_cast<uintptr_t>(fdPtr);
    cfg.cacheFlag = true;
    struct MsprofConfig cfg2 = cfg;
    cfg2.modelId = 2;
    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = ProfAclMgr::instance()->GenerateSubscribeKey(&cfg);
    aclprofSubscribeConfig *profSubconfig = aclprofCreateSubscribeConfig(1, ACL_AICORE_NONE, fdPtr);

    ProfSubscribeInfo subscribeInfo = {true, 1, &fd};

    struct MsprofConfig cfg3;
    cfg3.devNums = 1;
    cfg3.devIdList[0] = devId;
    cfg3.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg3.modelId = 3;
    cfg3.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg3.fd = reinterpret_cast<uintptr_t>(fdPtr);
    cfg3.cacheFlag = true;

    struct MsprofConfig cfg4;
    cfg4.devNums = 1;
    cfg4.devIdList[0] = devId;
    cfg4.type = static_cast<uint32_t>(ACL_API_TYPE);
    cfg4.modelId = 4;
    cfg4.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    cfg4.fd = reinterpret_cast<uintptr_t>(fdPtr);
    cfg4.cacheFlag = true;

    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr3 = ProfAclMgr::instance()->GenerateSubscribeKey(&cfg3);
    ProfAclMgr::instance()->subscribeInfos_.insert(std::make_pair(subscribePtr->key, subscribeInfo));
    ProfAclMgr::instance()->CloseSubscribeFd(1, subscribePtr3);
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_part9) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    int fd = 1;
    void *fdPtr = static_cast<void *>(&fd);
    uint32_t devId = 0;
    struct MsprofConfig cfg{};
    cfg.devNums = 1;
    cfg.modelId = 1;
    cfg.fd = reinterpret_cast<uintptr_t>(fdPtr);
    struct MsprofConfig cfg2 = cfg;
    cfg2.modelId = 2;
    struct MsprofConfig cfg4 = cfg;
    cfg4.modelId = 4;
    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = ProfAclMgr::instance()->GenerateSubscribeKey(&cfg);
    aclprofSubscribeConfig *profSubconfig = aclprofCreateSubscribeConfig(1, ACL_AICORE_NONE, fdPtr);

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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ge_api_subscribe) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_json) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ge_option) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_PureCpu) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_init_env) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_InitApiCtrlUploaderHelper) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_EnableRpcHelperMode) {
    GlobalMockObject::verify();

    std::string env = "{}";
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);
    setenv("ASCEND_HOSTPID", "12345", 1);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());

    using namespace Msprofiler::Api;

    EXPECT_EQ(true, ProfAclMgr::instance()->EnableRpcHelperMode("11"));
    unsetenv("ASCEND_HOSTPID");
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofInitAclJson) {
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

#ifndef BUILD_OPEN_PROJECT
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
#endif

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
    message["output"] = "";
    message["aicpu"] = "on";
    message["training_trace"] = "on";
    message["task_trace"] = "on";
    message["task_tsfw"] = "on";
    std::string jobInfo = "123";
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::MsprofResultPathAdapter)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    ProfAclMgr::instance()->MsprofGeOptionsParamConstruct("hello", message);

    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(nullptr, jobInfo, message);
    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(params, jobInfo, message);
    EXPECT_EQ("on", params->aicpuTrace);
    EXPECT_EQ("on", params->ts_fw_training);
    EXPECT_EQ("level1", params->prof_level);
    EXPECT_EQ("on", params->taskTsfw);
    EXPECT_EQ(analysis::dvvp::common::utils::Utils::GetPid(), params->host_sys_pid);

    message["task_block"] = "on";
    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(params, jobInfo, message);
    EXPECT_EQ("on", params->taskBlock);
    EXPECT_EQ("on", params->taskBlockShink);

    message["task_block"] = "all";
    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(params, jobInfo, message);
    EXPECT_EQ("on", params->taskBlock);
    EXPECT_EQ("off", params->taskBlockShink);

    message["task_block"] = "off";
    ProfAclMgr::instance()->MsprofInitGeOptionsParamAdaper(params, jobInfo, message);
    EXPECT_EQ("off", params->taskBlock);
    EXPECT_EQ("off", params->taskBlockShink);
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
    inputCfgPb["task_time"] = "on";
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

    inputCfgPb["task_block"] = "on";
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    EXPECT_EQ("on", profAclMgr.params_->taskBlock);
    EXPECT_EQ("on", profAclMgr.params_->taskBlockShink);

    inputCfgPb["task_block"] = "all";
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    EXPECT_EQ("on", profAclMgr.params_->taskBlock);
    EXPECT_EQ("off", profAclMgr.params_->taskBlockShink);

    inputCfgPb["task_block"] = "off";
    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));
    EXPECT_EQ("off", profAclMgr.params_->taskBlock);
    EXPECT_EQ("off", profAclMgr.params_->taskBlockShink);
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofInitHelper) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofInitPureCpu) {
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofInitPureCpu_part2) {
    GlobalMockObject::verify();
    struct MsprofCommandHandleParams commandHandleParams;
    memset(&commandHandleParams, 0, sizeof(MsprofCommandHandleParams));
    std::string result = "/tmp/MsprofInitPureCpu";
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
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    MOCKER_CPP(&ProfAclMgr::DoHostHandle)
        .expects(once())
        .will(returnValue(PROFILING_SUCCESS));
    ProfAclMgr::instance()->MsprofHostHandle();
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ReporterData) {
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
    recData.Init();
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
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.head.bufSize = sizeof(TsProfileKeypoint);
    data.taskId = 1;
    data.streamId = 1;
    data.timestamp = 1000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    data.modelId = 4;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

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
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    data.taskId = 2;
    data.streamId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

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
    analyzer->analyzerTs_->ParseTsKeypointData(&data);
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

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
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.timestamp = 4000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 2;
    data.timestamp = 5000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

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
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 0;
    data.timestamp = 2000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 1;
    data.timestamp = 3000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 1;
    data.timestamp = 4000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 2;
    data.timestamp = 5000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 1;
    data.timestamp = 6000000;
    data.tagId = TS_KEYPOINT_START_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

    data.indexId = 1;
    data.timestamp = 7000000;
    data.tagId = TS_KEYPOINT_END_TASK_STATE;
    analyzer->analyzerTs_->ParseTsKeypointData(&data);

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

#ifndef BUILD_OPEN_PROJECT
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MDC_TYPE));
    metrics = "";
    Msprofiler::Api::ProfAclMgr::instance()->AicoreMetricsEnumToName(PROF_AICORE_L2_CACHE, metrics);
    EXPECT_EQ("", metrics);
#endif
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_acl_api_subscribe_fail) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ProfStartAscendProfHalTask) {
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ProfStartAscendProfHalTask_Helper) {
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ProfAclStartMultiDevice) {
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ProfAclStartMultiDevice_part2) {
    GlobalMockObject::verify();
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

    EXPECT_EQ(ge::GE_PROF_SUCCESS, ge::aclgrphProfDestroyConfig(aclConfig));
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

    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(aclConfig));
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_stats_create_config)
{
    GlobalMockObject::verify();
    MOCKER(ProfAclDrvGetDevNum).stubs().will(returnValue(2));
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_NOTSUPPORT));

    uint32_t devIdList[1] = {0};
    aclprofConfig *apiStatsConfig = aclprofCreateConfig(devIdList, 1, ACL_AICORE_NONE, nullptr, ACL_PROF_API_STATS);
    ASSERT_NE(nullptr, apiStatsConfig);
    EXPECT_EQ(ACL_PROF_API_STATS, PROF_API_STATS);
    EXPECT_EQ(0ULL, ACL_PROF_API_STATS & PROF_OP_MASK);
    EXPECT_EQ(0ULL, PROF_API_STATS & PROF_OP_MASK);
    EXPECT_EQ(PROF_ACL_API | PROF_API_STATS, apiStatsConfig->config.dataTypeConfig);
    EXPECT_EQ(2, apiStatsConfig->config.devNums);
    EXPECT_EQ(PROF_DEFAULT_HOST_ID, apiStatsConfig->config.devIdList[1]);

    aclprofConfig *apiStatsMixedConfig = aclprofCreateConfig(devIdList, 1, ACL_AICORE_NONE, nullptr,
        ACL_PROF_API_STATS | ACL_PROF_AICPU | ACL_PROF_TASK_TIME);
    ASSERT_NE(nullptr, apiStatsMixedConfig);
    EXPECT_EQ(PROF_ACL_API | PROF_API_STATS, apiStatsMixedConfig->config.dataTypeConfig);

    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(apiStatsConfig));
    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(apiStatsMixedConfig));
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_init_uploader)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    EXPECT_TRUE(ProfAclMgr::instance()->IsAclApiStatsMode());
    MOCKER_CPP(&ProfAclMgr::InitStatsUploader)
        .expects(once())
        .will(returnValue(ACL_SUCCESS));
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->InitUploader("64"));
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_skip_device_task)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    uint32_t devIdList[1] = {0};
    std::vector<uint32_t> notifyList = {0};
    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();

    MOCKER_CPP(&ProfAclMgr::GetDevicesNotify)
        .stubs()
        .with(any(), any(), outBound(notifyList))
        .will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::MsprofHostHandle)
        .stubs();
    MOCKER_CPP(&ProfAclMgr::IsAclApiStatsMode)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfAclMgr::MsprofDeviceHandle)
        .expects(never());
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));

    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->ProfStartCommon(devIdList, 1));
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.size());
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.count(0));
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
}

std::vector<std::vector<uint32_t>> g_apiStatsStopDevLists;

int32_t ApiStatsCommandHandleProfStopStub(const uint32_t devIdList[], uint32_t devNums, uint64_t, uint64_t)
{
    std::vector<uint32_t> devIds;
    if (devIdList != nullptr) {
        for (uint32_t i = 0; i < devNums; ++i) {
            devIds.emplace_back(devIdList[i]);
        }
    }
    g_apiStatsStopDevLists.emplace_back(devIds);
    return ACL_SUCCESS;
}

int32_t ApiStatsCommandHandleProfStopFailStub(const uint32_t devIdList[], uint32_t devNums, uint64_t, uint64_t)
{
    if (devIdList != nullptr && devNums == 1 && devIdList[0] == 0) {
        return ACL_ERROR;
    }
    return ACL_SUCCESS;
}

int32_t ApiStatsCommandHandleProfStopAlwaysFailStub(const uint32_t devIdList[], uint32_t devNums, uint64_t,
    uint64_t)
{
    std::vector<uint32_t> devIds;
    if (devIdList != nullptr) {
        for (uint32_t i = 0; i < devNums; ++i) {
            devIds.emplace_back(devIdList[i]);
        }
    }
    g_apiStatsStopDevLists.emplace_back(devIds);
    return ACL_ERROR;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_stop_callback_with_real_device)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    g_apiStatsStopDevLists.clear();
    MsprofConfig config = {};
    config.devNums = 2;
    config.devIdList[0] = 0;
    config.devIdList[1] = DEFAULT_HOST_ID;
    config.profSwitch = PROF_API_STATS;
    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->statsDevSet_.insert(0);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, PROF_API_STATS, params};
    ProfAclMgr::instance()->devTasks_[DEFAULT_HOST_ID] = taskInfo;

    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(invoke(ApiStatsCommandHandleProfStopStub));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->ProfStopCommon(&config));
    ASSERT_EQ(2U, g_apiStatsStopDevLists.size());
    ASSERT_EQ(1U, g_apiStatsStopDevLists[0].size());
    EXPECT_EQ(DEFAULT_HOST_ID, g_apiStatsStopDevLists[0][0]);
    ASSERT_EQ(1U, g_apiStatsStopDevLists[1].size());
    EXPECT_EQ(0U, g_apiStatsStopDevLists[1][0]);
    EXPECT_TRUE(ProfAclMgr::instance()->statsDevSet_.empty());
    EXPECT_TRUE(ProfAclMgr::instance()->devTasks_.empty());
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_stop_common_callback_failure_skip_stats_callback)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    g_apiStatsStopDevLists.clear();
    MsprofConfig config = {};
    config.profSwitch = PROF_API_STATS;
    ProfAclMgr::instance()->mode_ = WORK_MODE_API_CTRL;
    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->statsDevSet_.insert(0);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, PROF_API_STATS, params};
    ProfAclMgr::instance()->devTasks_[DEFAULT_HOST_ID] = taskInfo;

    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(invoke(ApiStatsCommandHandleProfStopAlwaysFailStub));

    EXPECT_EQ(ACL_ERROR, ProfAclMgr::instance()->ProfStopCommon(&config));
    ASSERT_EQ(1U, g_apiStatsStopDevLists.size());
    ASSERT_EQ(1U, g_apiStatsStopDevLists[0].size());
    EXPECT_EQ(DEFAULT_HOST_ID, g_apiStatsStopDevLists[0][0]);
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.size());
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.count(0));
    EXPECT_EQ(1U, ProfAclMgr::instance()->devTasks_.size());
    ProfAclMgr::instance()->devTasks_.clear();
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_finalize_stop_stats_callback)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    g_apiStatsStopDevLists.clear();
    ProfAclMgr::instance()->mode_ = WORK_MODE_CMD;
    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->statsDevSet_.insert(0);
    ProfAclMgr::instance()->devTasks_.clear();

    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(invoke(ApiStatsCommandHandleProfStopStub));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfFinalize)
        .stubs()
        .will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Msprof::Engine::FlushAllModule)
        .stubs();

    EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofFinalizeHandle());
    ASSERT_EQ(1U, g_apiStatsStopDevLists.size());
    ASSERT_EQ(1U, g_apiStatsStopDevLists[0].size());
    EXPECT_EQ(0U, g_apiStatsStopDevLists[0][0]);
    EXPECT_TRUE(ProfAclMgr::instance()->statsDevSet_.empty());
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_stop_callback_failure_keep_device)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->statsDevSet_.insert(0);
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .stubs()
        .will(invoke(ApiStatsCommandHandleProfStopFailStub));

    EXPECT_EQ(ACL_ERROR, ProfAclMgr::instance()->ProfStopStatsCallback());
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.size());
    EXPECT_EQ(1U, ProfAclMgr::instance()->statsDevSet_.count(0));
    ProfAclMgr::instance()->statsDevSet_.clear();
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_mode_stop_callback_empty_success)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    ProfAclMgr::instance()->dataTypeConfig_ = PROF_API_STATS;
    ProfAclMgr::instance()->statsDevSet_.clear();

    EXPECT_EQ(PROFILING_SUCCESS, ProfAclMgr::instance()->ProfStopStatsCallback());
    EXPECT_TRUE(ProfAclMgr::instance()->statsDevSet_.empty());
    ProfAclMgr::instance()->dataTypeConfig_ = 0;
}

TEST_F(MSPROF_ACL_CORE_UTEST, api_stats_init_uploader_create_dir_failed)
{
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;

    ProfAclMgr::instance()->resultPath_ = "/tmp";
    ProfAclMgr::instance()->baseDir_ = "api_stats_init_uploader_failed";
    MOCKER_CPP(&Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    EXPECT_EQ(ACL_ERROR_INVALID_FILE, ProfAclMgr::instance()->InitStatsUploader());
    ProfAclMgr::instance()->resultPath_.clear();
    ProfAclMgr::instance()->baseDir_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, StatsAnalyzerFlushesApiStatsOnEndInfo)
{
    GlobalMockObject::verify();
    const std::string dir = "/tmp/stats_analyzer_core_utest/";
    const std::string totalFile = dir + "acl_api_total_time.csv";
    const std::string statFile = dir + "acl_api_statistics.csv";
    std::remove(totalFile.c_str());
    std::remove(statFile.c_str());
    ASSERT_EQ(PROFILING_SUCCESS, Utils::CreateDir(dir));

    constexpr uint32_t hashName = (ACL_RTS << 16) + 101;
    ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().RegReportTypeInfo(
        MSPROF_REPORT_ACL_LEVEL, hashName, "aclUtNoShieldApi");
    MsprofApi api = MakeStatsApiData(hashName, 10, 40);
    std::string apiData(reinterpret_cast<const char *>(&api), sizeof(MsprofApi));

    StatsAnalyzer analyzer(dir);
    analyzer.OnApiData(MakeStatsChunk("host.api_event.data", apiData,
        analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST));
    analyzer.OnApiData(MakeStatsChunk("host.unrelated.data", "drop",
        analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST));
    analyzer.OnApiData(MakeStatsChunk("end_info", "",
        analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA));

    std::ifstream total(totalFile);
    std::string line;
    ASSERT_TRUE(std::getline(total, line));
    EXPECT_EQ("thread,acl_api_total_time(ns)", line);
    ASSERT_TRUE(std::getline(total, line));
    EXPECT_EQ("100,30", line);
    total.close();

    std::ifstream stat(statFile);
    ASSERT_TRUE(std::getline(stat, line));
    EXPECT_EQ("thread,api_name,api_type,api_average_time(ns),api_max_time(ns),api_min_time(ns),api_count", line);
    ASSERT_TRUE(std::getline(stat, line));
    EXPECT_EQ("100,aclUtNoShieldApi,ACL_RTS,30,30,30,1", line);
    stat.close();

    std::remove(totalFile.c_str());
    std::remove(statFile.c_str());
}

TEST_F(MSPROF_ACL_CORE_UTEST, StatsTransportBasicBranches)
{
    GlobalMockObject::verify();
    SHARED_PTR_ALIA<ITransport> transport =
        StatsTransportFactory().CreateStatsTransport("/tmp/stats_transport_core_utest/");
    ASSERT_NE(nullptr, transport);

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> nullChunk = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, transport->SendBuffer(nullChunk));
    const char buffer[] = "stats";
    EXPECT_EQ(PROFILING_SUCCESS, transport->SendBuffer(buffer, sizeof(buffer)));
    EXPECT_EQ(PROFILING_SUCCESS, transport->CloseSession());
    transport->WriteDone();
}

TEST_F(MSPROF_ACL_CORE_UTEST, acl_api_notsupport) {
    GlobalMockObject::verify();
    MOCKER_CPP(&ProfRtAPI::ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId)
        .stubs()
        .will(returnValue(PROFILING_NOTSUPPORT));

    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x7d7f001f;

    aclprofConfig *aclConfig = aclprofCreateConfig(
        config.devIdList, config.devNums, (aclprofAicoreMetrics)config.aicoreMetrics, nullptr, config.dataTypeConfig);
    EXPECT_NE(nullptr, aclConfig);

    EXPECT_EQ(ge::GE_PROF_SUCCESS, aclprofDestroyConfig(aclConfig));
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

TEST_F(MSPROF_ACL_CORE_UTEST, aclprofSetConfigAllowsEmptyStorageLimit)
{
    const std::string config;
    MOCKER(ProfAclSetConfig)
        .expects(once())
        .with(eq(static_cast<uint32_t>(ACL_PROF_STORAGE_LIMIT)), eq(config.c_str()), eq(config.size()))
        .will(returnValue(ACL_SUCCESS));

    EXPECT_EQ(ACL_SUCCESS, aclprofSetConfig(ACL_PROF_STORAGE_LIMIT, config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, aclprofSetConfigNtsMetricsBasicValidation)
{
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_OPTYPE) + 1, static_cast<int32_t>(ACL_PROF_NTS_METRICS));
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_NTS_METRICS) + 1, static_cast<int32_t>(ACL_PROF_PATH));
    EXPECT_EQ(static_cast<int32_t>(ACL_PROF_PATH) + 1, static_cast<int32_t>(ACL_PROF_ARGS_MAX));

    std::string config("TaskTime");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));

    config = "PipeUtilization";
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(static_cast<aclprofConfigType>(ACL_PROF_ARGS_MAX),
        config.c_str(), config.size()));
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
    // ProfStop short-circuits to success when !IsInited(); force IsInited() true so the
    // config-consistency validation under test is reached.
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited).stubs().will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopPrecheck).stubs().will(returnValue(0));
    MOCKER((int (Msprofiler::Api::ProfAclMgr::*)(const uint32_t devId, uint64_t &dataTypeConfig))&Msprofiler::Api::ProfAclMgr::ProfAclGetDataTypeConfig).stubs().will(returnValue(0));
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, Msprofiler::AclApi::ProfStop(ACL_API_TYPE, &config));
}

// AutoInitForStartIfNeeded (via ProfStart): cover all auto-init failure branches in one body,
// resetting mocks between sub-cases with GlobalMockObject::verify().
TEST_F(MSPROF_ACL_CORE_UTEST, ProfStart_AutoInit_FailureBranches) {
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = ACL_PROF_TASK_TIME;

    // not inited + helper host side -> feature unsupported.
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, Msprofiler::AclApi::ProfStart(ACL_API_TYPE, &config));

    // not inited + manager Init fails.
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_FAILED)));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, Msprofiler::AclApi::ProfStart(ACL_API_TYPE, &config));

    // not inited + ProfAclInit fails -> propagate error.
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetResultPath)
        .stubs().will(returnValue(std::string("/tmp/auto_init")));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfAclInit)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_ERROR_INVALID_FILE)));
    EXPECT_EQ(ACL_ERROR_INVALID_FILE, Msprofiler::AclApi::ProfStart(ACL_API_TYPE, &config));

    // not inited + StartUploaderDumper fails.
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_ERROR_PROF_NOT_RUN)));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::GetResultPath)
        .stubs().will(returnValue(std::string("/tmp/auto_init")));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfAclInit)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::StartUploaderDumper)
        .stubs().will(returnValue(static_cast<int32_t>(PROFILING_FAILED)));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, Msprofiler::AclApi::ProfStart(ACL_API_TYPE, &config));
}

// AutoInitForStartIfNeeded (via ProfStart): already inited -> skip auto-init and start normally.
TEST_F(MSPROF_ACL_CORE_UTEST, ProfStart_AutoInit_AlreadyInitedSkips) {
    GlobalMockObject::verify();
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = ACL_PROF_TASK_TIME;
    // precheck returns SUCCESS -> AutoInitForStartIfNeeded returns early without auto-init.
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::CheckConfigConsistency)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsProfWarmup)
        .stubs().will(returnValue(false));
    MOCKER(&Analysis::Dvvp::ProfilerCommon::ProfConfigStart)
        .stubs().will(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfStart(ACL_API_TYPE, &config));
}

// aclprofStop on an uninitialized state (e.g. after finalize) returns success directly (no error).
TEST_F(MSPROF_ACL_CORE_UTEST, ProfStop_NotInited_ReturnsSuccess) {
    GlobalMockObject::verify();
    ProfConfig config;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    config.dataTypeConfig = 0x0080;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfStop(ACL_API_TYPE, &config));
}

// aclprofFinalize on an uninitialized state (e.g. after finalize) returns success directly.
TEST_F(MSPROF_ACL_CORE_UTEST, ProfFinalize_NotInited_ReturnsSuccess) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfFinalize(ACL_API_TYPE));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfigWillReturnUnintializeWhenInitParmasFail)
{
    std::string config("50");
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::InitParams)
        .stubs()
        .will(returnValue(ACL_ERROR_PROFILING_FAILURE));
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_DVPP_FREQ,
        config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfigWillReturnUnintializeWhenPlatformInitFail)
{
    std::string config("50");
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::InitParams)
        .stubs()
        .will(returnValue(ACL_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_DVPP_FREQ,
        config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfigWillReturnUnsupportedWhenPlatformIsHelperHostSide)
{
    std::string config("50");
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_OFF;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .then(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_DVPP_FREQ,
        config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfigWillCheckConfigWhenPlatformSupported)
{
    std::string config("50");
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .then(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .then(returnValue(true));
    aclprofConfigType configType = ACL_PROF_DVPP_FREQ;
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
    int expectRet = ACL_ERROR_INVALID_PROFILING_CONFIG;
#ifndef BUILD_OPEN_PROJECT
    MOCKER_CPP(&Platform::GetPlatformType)
        .stubs()
        .will(repeat(PlatformTypeEnum::CHIP_MINI, 3))
        .then(returnValue(PlatformTypeEnum::CHIP_CLOUD));
#else
    MOCKER_CPP(&Platform::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformTypeEnum::CHIP_CLOUD));
#endif
    configType = ACL_PROF_LLC_MODE;
    config = "read";
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "capacity";
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "bandwidth";
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "read";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "write";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    configType = ACL_PROF_HOST_SYS;
    config = "cpu,mem,disk,network,osrt";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    configType = ACL_PROF_STORAGE_LIMIT;
    config = "100MB";
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
    config = "100";
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfSetConfig(ACL_PROF_LOW_POWER_FREQ, config.c_str(), config.size()));
    configType = static_cast<aclprofConfigType>(2);
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapterWillAcceptNtsMetricsConsistently)
{
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));

    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigSupport(ACL_PROF_NTS_METRICS));
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "PipeUtilization"));
    EXPECT_EQ("PipeUtilization", params->ntsMetrics);
    EXPECT_TRUE(params->ntsPmuEvents.empty());

    params->ntsMetrics.clear();
    params->ntsPmuEvents.clear();
    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "Custom:0x301"));
    EXPECT_EQ("Custom:0x301", params->ntsMetrics);
    EXPECT_EQ("0x301", params->ntsPmuEvents);

    params->ntsMetrics.clear();
    EXPECT_EQ(PROFILING_FAILED,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_NTS_METRICS, "TaskTime"));
    EXPECT_TRUE(params->ntsMetrics.empty());
}

// ACL_PROF_PATH is platform-agnostic (always supported) and stores the value into resultPath.
TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_AclProfPath_SupportAndStore)
{
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();

    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigSupport(ACL_PROF_PATH));

    EXPECT_EQ(PROFILING_SUCCESS,
        Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::instance()->CheckApiConfigIsValid(params,
            ACL_PROF_PATH, "/tmp/acl_prof_path_store"));
    EXPECT_EQ("/tmp/acl_prof_path_store", params->resultPath);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AclSetConfigNtsMetricsWillEnablePmuAndTaskCollection)
{
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    Msprofiler::Api::ProfAclMgr::instance()->params_ = params;

    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Platform::GetNtsEvents)
        .stubs()
        .will(returnValue(std::string("0x301,0x312")));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));

    std::string config("PipeUtilization");
    EXPECT_EQ(ACL_SUCCESS, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
    EXPECT_EQ("PipeUtilization", params->ntsMetrics);

    EXPECT_TRUE(ParamValidation::instance()->CheckNtsMetricsIsValid(params));
    EXPECT_EQ("0x301,0x312", params->ntsPmuEvents);

    auto pmuCfg = MakeNtsCollectionJobCfg(params);
    pmuCfg->jobParams.dataPath = "data/nts_pmu.data";
    auto taskCfg = MakeNtsCollectionJobCfg(params);
    taskCfg->jobParams.dataPath = "data/nts_task.data";

    auto profNtsPmuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNtsPmuJob>();
    auto profNtsTaskJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNtsTaskJob>();
    EXPECT_EQ(PROFILING_SUCCESS, profNtsPmuJob->Init(pmuCfg));
    EXPECT_EQ(PROFILING_SUCCESS, profNtsTaskJob->Init(taskCfg));
    EXPECT_EQ(PROFILING_SUCCESS, profNtsPmuJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profNtsTaskJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profNtsPmuJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, profNtsTaskJob->Uninit());

    params->ntsMetrics.clear();
    params->ntsPmuEvents.clear();
    config = "Custom:0x301,0x312";
    EXPECT_EQ(ACL_SUCCESS, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
    EXPECT_EQ("Custom:0x301,0x312", params->ntsMetrics);
    EXPECT_EQ("0x301,0x312", params->ntsPmuEvents);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AclSetConfigNtsMetricsWillInterceptInvalidOrUnsupportedCollection)
{
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    Msprofiler::Api::ProfAclMgr::instance()->params_ = params;

    std::string config("TaskTime");
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
    EXPECT_TRUE(params->ntsMetrics.empty());

    config = "PipeUtilization";
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, aclprofSetConfig(ACL_PROF_NTS_METRICS, config.c_str(), config.size()));
    EXPECT_TRUE(params->ntsMetrics.empty());

    auto collectionJobCfg = MakeNtsCollectionJobCfg(params);
    auto profNtsPmuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNtsPmuJob>();
    auto profNtsTaskJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNtsTaskJob>();
    EXPECT_EQ(PROFILING_FAILED, profNtsPmuJob->Init(collectionJobCfg));
    EXPECT_EQ(PROFILING_FAILED, profNtsTaskJob->Init(collectionJobCfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfSetConfigWillReturnInvalidConfigWhenPlatformNotSupported)
{
    std::string config("50");
    Msprofiler::Api::ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_API_CTRL;
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .then(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .then(returnValue(false));
    aclprofConfigType configType = ACL_PROF_DVPP_FREQ;
    int expectRet = ACL_ERROR_INVALID_PROFILING_CONFIG;
    EXPECT_EQ(expectRet, Msprofiler::AclApi::ProfSetConfig(configType, config.c_str(), config.size()));
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

void GetRunningDevicesStub(Msprofiler::Api::ProfAclMgr *This, std::vector<uint32_t> &devIds)
{
    devIds.push_back(0);
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_ProcessHelperHostConfig)
{
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

static uint32_t g_tagId = 0;

int32_t RtProfilerTraceExFuncStub(uint64_t indexId, uint64_t modelId, uint16_t tagId, VOID_PTR stm)
{
    g_tagId = tagId;
    return 0;
}

class MSPROF_API_MSPROFTX_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
};

TEST_F(MSPROF_API_MSPROFTX_UTEST, LaunchDeviceTxTask) {
    GlobalMockObject::verify();

    uint64_t indexId = 0;
    uint32_t mark_tag_id = 11;
    uint32_t range_tag_id = 12;

    // rtProfilerTraceExFunc_ is nullptr
    int32_t ret = Msprof::MsprofTx::MsprofTxManager::instance()->LaunchDeviceTxTask(indexId, nullptr, false);
    EXPECT_EQ(PROFILING_FAILED, ret);

    // rtProfilerTraceExFunc_ is not nullptr
    Msprof::MsprofTx::MsprofTxManager::instance()->rtProfilerTraceExFunc_ = RtProfilerTraceExFuncStub;
    ret = Msprof::MsprofTx::MsprofTxManager::instance()->LaunchDeviceTxTask(indexId, nullptr, false);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(mark_tag_id, g_tagId);

    ret = Msprof::MsprofTx::MsprofTxManager::instance()->LaunchDeviceTxTask(indexId, nullptr, true);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(range_tag_id, g_tagId);

    Msprof::MsprofTx::MsprofTxManager::instance()->rtProfilerTraceExFunc_ = nullptr;
}

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

    MOCKER_CPP(&ProfAclMgr::ProfStartPureCpu)
        .stubs()
        .will(returnValue(static_cast<int32_t>(MSPROF_ERROR)))
        .then(returnValue(static_cast<int32_t>(MSPROF_ERROR_NONE)));
    EXPECT_EQ(MSPROF_ERROR, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));

    GlobalMockObject::verify();

    // invalid input
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, 1));
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), nullptr, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_DYNAMIC), &cfg, sizeof(cfg)));

    MOCKER_CPP(&ProfAclMgr::ProfStopPureCpu)
        .stubs()
        .will(returnValue(static_cast<int32_t>(MSPROF_ERROR)))
        .then(returnValue(static_cast<int32_t>(MSPROF_ERROR_NONE)));
    EXPECT_EQ(MSPROF_ERROR, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_PURE_CPU), &cfg, sizeof(cfg)));
    ProfAclMgr::instance()->UnInit();
    EXPECT_EQ(0, ProfAclMgr::instance()->devTasks_.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofStart_Common) {
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofStart_Common_part2) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofStart_AclApi) {
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
    MOCKER_CPP(&ProfAclMgr::MsprofTxApiHandle).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfAclMgr::StartUploaderDumper).stubs()
        .will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit).stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR))).then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart).stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR))).then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::StartDeviceTask).stubs()
        .will(returnValue(static_cast<int32_t>(ACL_ERROR_PROFILING_FAILURE)))
        .then(returnValue(static_cast<int32_t>(ACL_SUCCESS)));
    MOCKER_CPP(&ProfAclMgr::WaitDeviceResponse).stubs();
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofStart_AclApi_part2) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
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
}

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_MsprofStart_AclApi_part3) {
    GlobalMockObject::verify();
    using namespace Msprofiler::Api;
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = 0;
    cfg.metrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.profSwitch = 0x7d7f001f;
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
    // ProfStopPrecheck returns NOT_RUN: not initialized -> aclprofStop is a no-op and succeeds.
    EXPECT_EQ(ACL_SUCCESS, MsprofStop(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), &cfg, sizeof(cfg)));
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

TEST_F(MSPROF_ACL_CORE_UTEST, DISABLED_Msprof_aclprofGetSupportedFeatures) {
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

TEST_F(MSPROF_ACL_CORE_UTEST, GetOutputPath) {
    GlobalMockObject::verify();

    using namespace Msprofiler::Api;
    Msprofiler::Api::ProfAclMgr profAclMgr;

    EXPECT_EQ("", profAclMgr.GetOutputPath());

    NanoJson::Json inputCfgPb;
    inputCfgPb["output"] = "/tmp/test_prof_output";

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible)
        .stubs()
        .will(returnValue(true));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath)
        .stubs()
        .will(returnValue(std::string("/tmp/test_prof_output")));

    EXPECT_EQ(MSPROF_ERROR_NONE, profAclMgr.MsprofAclJsonParamConstruct(inputCfgPb));

    std::string outputPath = profAclMgr.GetOutputPath();
    EXPECT_NE("", outputPath);
    EXPECT_TRUE(outputPath.find("/tmp/test_prof_output") != std::string::npos);
    EXPECT_TRUE(outputPath.find("PROF_") != std::string::npos);
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofResetDeviceHandle_SetUploaderStopped)
{
  using namespace Msprofiler::Api;
  const uint32_t devId = 0;
  HDC_SESSION session = (HDC_SESSION)0x12345678;
  auto transport = std::shared_ptr<analysis::dvvp::transport::ITransport>(
      new analysis::dvvp::transport::HDCTransport(session));
  auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);

  MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
      .stubs()
      .with(any(), outBound(uploader));
  MOCKER(&analysis::dvvp::transport::Uploader::SetTransportStopped).stubs();
  MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
      .stubs()
      .will(returnValue(PROFILING_SUCCESS));

  std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
  ProfAclMgr::ProfAclTaskInfo taskInfo = {1, 0, params};
  ProfAclMgr::instance()->devTasks_[devId] = taskInfo;

  EXPECT_EQ(MSPROF_ERROR_NONE, ProfAclMgr::instance()->MsprofResetDeviceHandle(devId));
  EXPECT_EQ(true, ProfAclMgr::instance()->devTasks_[devId].params->isCancel);

  ProfAclMgr::instance()->devTasks_.clear();
  GlobalMockObject::verify();
}

TEST_F(MSPROF_ACL_CORE_UTEST, GetOpTypeConfig) {
    using namespace Msprofiler::Api;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->opType = "MatMul,Index";
    ProfAclMgr::instance()->params_ = params;

    std::string opTypeConfig = ProfAclMgr::instance()->GetOpTypeConfig();
    EXPECT_EQ("MatMul,Index", opTypeConfig);

    params->opType = "";
    opTypeConfig = ProfAclMgr::instance()->GetOpTypeConfig();
    EXPECT_EQ("", opTypeConfig);

    ProfAclMgr::instance()->params_ = nullptr;
    opTypeConfig = ProfAclMgr::instance()->GetOpTypeConfig();
    EXPECT_EQ("", opTypeConfig);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfDataTypeConfigHandle_OpTypeMask) {
    using namespace Msprofiler::Api;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->ai_core_profiling = "on";
    params->opType = "MatMul,Index";

    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    ProfAclMgr::instance()->params_ = params;
    ProfAclMgr::instance()->ProfDataTypeConfigHandle(params);

    uint64_t dataTypeConfig = ProfAclMgr::instance()->GetCmdModeDataTypeConfig();
    EXPECT_TRUE((dataTypeConfig & PROF_OP_MASK) != 0);

    params->opType = "";
    ProfAclMgr::instance()->ProfDataTypeConfigHandle(params);
    dataTypeConfig = ProfAclMgr::instance()->GetCmdModeDataTypeConfig();
    EXPECT_TRUE((dataTypeConfig & PROF_OP_MASK) == 0);

    GlobalMockObject::verify();
}

namespace {
ProfConfig MakeProfConfig(uint32_t devNums = 1)
{
    ProfConfig cfg{};
    cfg.devNums = devNums;
    cfg.devIdList[0] = 0;
    cfg.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    cfg.dataTypeConfig = 0x80;
    return cfg;
}
}  // namespace

TEST_F(MSPROF_ACL_CORE_UTEST, ProfWarmup_PrecheckFail)
{
    ProfConfig cfg = MakeProfConfig();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck)
        .stubs().will(returnValue((int32_t)ACL_ERROR_PROF_NOT_RUN));
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfWarmup_AlreadyStarted)
{
    ProfConfig cfg = MakeProfConfig();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck).stubs().will(returnValue((int32_t)ACL_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsAclApiReady).stubs().will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_PROF_API_CONFLICT, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfWarmup_ConfigStartFail)
{
    ProfConfig cfg = MakeProfConfig();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck).stubs().will(returnValue((int32_t)ACL_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsAclApiReady).stubs().will(returnValue(false));
    MOCKER(&Analysis::Dvvp::ProfilerCommon::ProfConfigStart)
        .stubs().will(returnValue((int32_t)PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfWarmup_Success)
{
    ProfConfig cfg = MakeProfConfig();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStartPrecheck).stubs().will(returnValue((int32_t)ACL_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsAclApiReady).stubs().will(returnValue(false));
    MOCKER(&Analysis::Dvvp::ProfilerCommon::ProfConfigStart).stubs().will(returnValue((int32_t)ACL_SUCCESS));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfModelUnSubscribe_NotLoaded)
{
    EXPECT_NE(ACL_SUCCESS, Msprofiler::AclApi::ProfModelUnSubscribe(ACL_API_TYPE, 0xFFFF));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclGetCompatibleFeatures_InitFail)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::FeatureManager::Init)
        .stubs().will(returnValue((int32_t)PROFILING_FAILED));
    size_t sz = 0;
    void *data = nullptr;
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfAclGetCompatibleFeatures(&sz, &data));
    EXPECT_EQ(ACL_ERROR_UNINITIALIZE, Msprofiler::AclApi::ProfAclGetCompatibleFeaturesV2(&sz, &data));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclGetCompatibleFeatures_Success)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::FeatureManager::Init)
        .stubs().will(returnValue((int32_t)PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::FeatureManager::GetIncompatibleFeatures)
        .stubs().will(returnValue((Analysis::Dvvp::Common::Config::FeatureRecord *)nullptr));
    size_t sz = 0;
    void *data = nullptr;
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfAclGetCompatibleFeatures(&sz, &data));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfAclGetCompatibleFeaturesV2(&sz, &data));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclRegisterDeviceCallback_Branches)
{
    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::CheckSetDeviceEnableIsValid)
        .stubs().will(returnValue(true));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfAclRegisterDeviceCallback());
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Host::Adapter::ProfParamsAdapter::CheckSetDeviceEnableIsValid)
        .stubs().will(returnValue(false));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, Msprofiler::AclApi::ProfAclRegisterDeviceCallback());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclGetOpAttriVal_BadType)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    EXPECT_EQ(nullptr, Msprofiler::AclApi::ProfAclGetOpAttriVal(0xFFFF, nullptr, 0, 0, 0));
}

// ===== Coverage for ProfParamsAdapter =====
namespace {
using AdapterT = Analysis::Dvvp::Host::Adapter::ProfParamsAdapter;
using StartReqT = Analysis::Dvvp::Host::Adapter::ProfApiStartReq;
using SysConfT = Analysis::Dvvp::Host::Adapter::ProfApiSysConf;
using ProfileParamsT = analysis::dvvp::message::ProfileParams;

std::shared_ptr<AdapterT> NewAdapter() { return std::make_shared<AdapterT>(); }
std::shared_ptr<ProfileParamsT> NewParams() { return std::make_shared<ProfileParamsT>(); }
std::shared_ptr<StartReqT> NewStartReq() { return std::make_shared<StartReqT>(); }
std::shared_ptr<SysConfT> NewSysConf() { return std::make_shared<SysConfT>(); }
}  // namespace

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_Init_Always_OK)
{
    EXPECT_EQ(PROFILING_SUCCESS, NewAdapter()->Init());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_StartReqTrf_NullArgs)
{
    auto a = NewAdapter();
    auto p = NewParams();
    EXPECT_EQ(PROFILING_FAILED, a->StartReqTrfToInnerParam(nullptr, p));
    EXPECT_EQ(PROFILING_FAILED, a->StartReqTrfToInnerParam(NewStartReq(), nullptr));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_StartReqTrf_AllFields)
{
    auto a = NewAdapter();
    auto req = NewStartReq();
    auto p = NewParams();
    p->taskTsfw = "on";
    req->jobId = "j1";
    req->tsFwTraining = "fw";
    req->hwtsLog = "hwts";
    req->tsTimeline = "tl";
    req->tsTaskTrack = "tt";
    req->systemTraceConf = "";
    req->taskTraceConf = "";
    req->featureName = "system_trace";
    EXPECT_EQ(PROFILING_SUCCESS, a->StartReqTrfToInnerParam(req, p));
    EXPECT_EQ("j1", p->job_id);
    EXPECT_EQ("fw", p->ts_fw_training);
    EXPECT_EQ("off", p->hwts_log1);

    req->featureName = "op_trace";
    auto p2 = NewParams();
    EXPECT_EQ(PROFILING_SUCCESS, a->StartReqTrfToInnerParam(req, p2));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_StartCfgTrf_AllMasks)
{
    auto a = NewAdapter();
    auto p = NewParams();
    a->StartCfgTrfToInnerParam(PROF_TASK_TSFW_MASK, p);
    EXPECT_EQ("on", p->taskTsfw);
    auto p2 = NewParams();
    a->StartCfgTrfToInnerParam(PROF_TASK_TIME_MASK, p2);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, p2->ts_memcpy);
    auto p3 = NewParams();
    a->StartCfgTrfToInnerParam(PROF_AICPU_TRACE_MASK, p3);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, p3->aicpuTrace);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_HostSysValid)
{
    auto a = NewAdapter();
    EXPECT_TRUE(a->CheckHostSysValid("cpu"));
    EXPECT_TRUE(a->CheckHostSysValid("cpu,mem"));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysOptionsIsValid)
        .stubs().will(returnValue(false));
    EXPECT_FALSE(a->CheckHostSysValid("zzz"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_HostSysUsageValid)
{
    auto a = NewAdapter();
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysUsageOptionsIsValid)
        .stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckHostSysUsageValid("cpu"));
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysUsageOptionsIsValid)
        .stubs().will(returnValue(false));
    EXPECT_FALSE(a->CheckHostSysUsageValid("xyz"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_SetHostSysParam_AllSwitches)
{
    auto a = NewAdapter();
    auto p = NewParams();
    a->SetHostSysParam("cpu,mem,network,disk,osrt,platform,unknown", p);
    EXPECT_EQ("on", p->host_cpu_profiling);
    EXPECT_EQ("on", p->host_mem_profiling);
    EXPECT_EQ("on", p->host_network_profiling);
    EXPECT_EQ("on", p->host_disk_profiling);
    EXPECT_EQ("on", p->host_osrt_profiling);
    EXPECT_EQ("on", p->host_platform_profiling);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_SetHostSysUsageParam_AllSwitches)
{
    auto a = NewAdapter();
    auto p = NewParams();
    a->SetHostSysUsageParam("cpu,mem,unknown", p);
    EXPECT_EQ("on", p->hostAllPidCpuProfiling);
    EXPECT_EQ("on", p->hostAllPidMemProfiling);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckSetDeviceEnable)
{
    auto a = NewAdapter();
    EXPECT_TRUE(a->CheckSetDeviceEnableIsValid(analysis::dvvp::common::config::MSVP_PROF_ON));
    EXPECT_TRUE(a->CheckAclApiSetDeviceEnable());
    EXPECT_TRUE(a->CheckSetDeviceEnableIsValid(analysis::dvvp::common::config::MSVP_PROF_OFF));
    EXPECT_FALSE(a->CheckAclApiSetDeviceEnable());
    EXPECT_FALSE(a->CheckSetDeviceEnableIsValid("garbage"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_GenerateCapacityBandwidthEvents)
{
    auto a = NewAdapter();
    EXPECT_FALSE(LlcEventUtils::GenerateCapacityEvents().empty());
    EXPECT_FALSE(LlcEventUtils::GenerateBandwidthEvents().empty());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_EncodeDecodeSysConfJson)
{
    auto a = NewAdapter();
    EXPECT_TRUE(a->EncodeSysConfJson(nullptr).empty());
    auto sysConf = NewSysConf();
    sysConf->aicoreSamplingInterval = 10;
    sysConf->cpuSamplingInterval = 20;
    sysConf->sysSamplingInterval = 30;
    sysConf->appSamplingInterval = 40;
    sysConf->hardwareMemSamplingInterval = 50;
    sysConf->ioSamplingInterval = 60;
    sysConf->interconnectionSamplingInterval = 70;
    sysConf->dvppSamplingInterval = 80;
    sysConf->aivSamplingInterval = 90;
    sysConf->aicoreMetrics = "PipeUtilization";
    sysConf->aivMetrics = "VecRatio";
    sysConf->l2 = "on";
    std::string s = a->EncodeSysConfJson(sysConf);
    EXPECT_FALSE(s.empty());
    auto decoded = a->DecodeSysConfJson(s);
    ASSERT_NE(nullptr, decoded);
    EXPECT_EQ(10u, decoded->aicoreSamplingInterval);
    EXPECT_EQ("PipeUtilization", decoded->aicoreMetrics);
    EXPECT_EQ(nullptr, a->DecodeSysConfJson(""));
    EXPECT_EQ(nullptr, a->DecodeSysConfJson("not-json"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_HandleTaskTraceConf_TooLarge)
{
    auto a = NewAdapter();
    auto p = NewParams();
    std::string big(2 * 1024 * 1024, 'a');
    EXPECT_EQ(PROFILING_FAILED, a->HandleTaskTraceConf(big, p));
    EXPECT_EQ(PROFILING_FAILED, a->HandleTaskTraceConf("{}", nullptr));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_HandleSystemTraceConf_NullAndOversize)
{
    auto a = NewAdapter();
    std::string big(2 * 1024 * 1024, 'a');
    EXPECT_EQ(PROFILING_FAILED, a->HandleSystemTraceConf(big, NewParams()));
    EXPECT_EQ(PROFILING_FAILED, a->HandleSystemTraceConf("{}", nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, a->HandleSystemTraceConf("", NewParams()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_UpdateSysConf_NullSafe)
{
    auto a = NewAdapter();
    a->UpdateSysConf(nullptr, NewParams());
    a->UpdateSysConf(NewSysConf(), nullptr);
    auto sysConf = NewSysConf();
    sysConf->cpuSamplingInterval = 5;
    sysConf->sysSamplingInterval = 5;
    sysConf->appSamplingInterval = 5;
    sysConf->hardwareMemSamplingInterval = 5;
    sysConf->ioSamplingInterval = 5;
    sysConf->interconnectionSamplingInterval = 5;
    sysConf->dvppSamplingInterval = 5;
    sysConf->aicoreSamplingInterval = 5;
    sysConf->aicoreMetrics = "PipeUtilization";
    auto p = NewParams();
    a->UpdateSysConf(sysConf, p);
    EXPECT_EQ("on", p->cpu_profiling);
    EXPECT_EQ("on", p->sys_profiling);
    EXPECT_EQ("on", p->ai_core_profiling);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_SetSystemTraceParams_NullSafeAndBranches)
{
    auto a = NewAdapter();
    a->SetSystemTraceParams(nullptr, NewParams());
    a->SetSystemTraceParams(NewParams(), nullptr);
    auto dst = NewParams();
    auto src = NewParams();
    dst->cpu_profiling = "on";
    dst->io_profiling = "on";
    dst->interconnection_profiling = "on";
    dst->isCancel = false;
    dst->job_id = "regular_job";
    src->ts_cpu_profiling_events = "0x11";
    src->ai_ctrl_cpu_profiling_events = "0x8";
    a->SetSystemTraceParams(dst, src);
    EXPECT_EQ("on", dst->nicProfiling);
    EXPECT_EQ("on", dst->pcieProfiling);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckApiConfigIsValid_StorageLimit)
{
    auto a = NewAdapter();
    auto p = NewParams();
    EXPECT_EQ(PROFILING_FAILED, a->CheckApiConfigIsValid(nullptr, ACL_PROF_STORAGE_LIMIT, ""));
    MOCKER_CPP(&ParamValidation::CheckStorageLimit).stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_STORAGE_LIMIT, "100"));
    GlobalMockObject::verify();
    MOCKER_CPP(&ParamValidation::CheckStorageLimit).stubs().will(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, a->CheckApiConfigIsValid(p, ACL_PROF_STORAGE_LIMIT, "100"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckApiConfigIsValid_LlcAndIo)
{
    auto a = NewAdapter();
    auto p = NewParams();
    MOCKER_CPP(&ParamValidation::CheckLlcConfigValid).stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_LLC_MODE, "Bandwidth"));
    GlobalMockObject::verify();
    MOCKER_CPP(&ParamValidation::CheckArgRange).stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_SYS_IO_FREQ, "10"));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_SYS_INTERCONNECTION_FREQ, "10"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckApiConfigIsValidTwo_DvppHostSysLp)
{
    auto a = NewAdapter();
    auto p = NewParams();
    MOCKER_CPP(&ParamValidation::CheckArgRange).stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_DVPP_FREQ, "10"));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_HOST_SYS_USAGE_FREQ, "10"));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_LOW_POWER_FREQ, "10"));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysOptionsIsValid)
        .stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_HOST_SYS, "cpu"));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysUsageOptionsIsValid)
        .stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_HOST_SYS_USAGE, "cpu"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckApiConfigIsValidThree_HwMemAndCpu)
{
    auto a = NewAdapter();
    auto p = NewParams();
    MOCKER_CPP(&ParamValidation::CheckArgRange).stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS,
              a->CheckApiConfigIsValid(p, ACL_PROF_SYS_HARDWARE_MEM_FREQ, "10"));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigIsValid(p, ACL_PROF_SYS_CPU_FREQ, "10"));
    EXPECT_EQ(PROFILING_FAILED, a->CheckApiConfigIsValid(p, (aclprofConfigType)0xFFFF, "x"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckApiConfigSupport_Branches)
{
    auto a = NewAdapter();
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigSupport(ACL_PROF_STORAGE_LIMIT));
    MOCKER(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs().will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, a->CheckApiConfigSupport(ACL_PROF_LLC_MODE));
    GlobalMockObject::verify();
    MOCKER(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs().will(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, a->CheckApiConfigSupport(ACL_PROF_LLC_MODE));
    EXPECT_EQ(PROFILING_FAILED, a->CheckApiConfigSupport((aclprofConfigType)0xFFFF));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfParamsAdapter_CheckJsonConfig_AllSwitchNames)
{
    auto a = NewAdapter();
    NanoJson::JsonValue v;
    v = std::string("PipeUtilization");
    MOCKER_CPP(&ParamValidation::CheckAicoreMetricsIsValid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("aic_metrics", v));
    GlobalMockObject::verify();
    v = std::string("on");
    MOCKER_CPP(&ParamValidation::CheckParamL0L1Invalid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("ge_api", v));
    GlobalMockObject::verify();
    NanoJson::JsonValue freq;
    freq = (uint32_t)10;
    MOCKER_CPP(&ParamValidation::CheckFreqIsValid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("sys_cpu_freq", freq));
    GlobalMockObject::verify();
    v = std::string("Bandwidth");
    MOCKER_CPP(&ParamValidation::CheckLlcConfigValid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("llc_profiling", v));
    GlobalMockObject::verify();
    v = std::string("cpu");
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysOptionsIsValid)
        .stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("host_sys", v));
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysUsageOptionsIsValid)
        .stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("host_sys_usage", v));
    GlobalMockObject::verify();
    MOCKER_CPP(&ParamValidation::CheckMemServiceflowValid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("sys_mem_serviceflow", v));
    GlobalMockObject::verify();
#ifndef BUILD_OPEN_PROJECT
    MOCKER_CPP(&ParamValidation::CheckTaskBlockValid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("task_block", v));
    GlobalMockObject::verify();
#endif
    MOCKER_CPP(&ParamValidation::CheckParamEmptyInvalid).stubs().will(returnValue(true));
    EXPECT_TRUE(a->CheckJsonConfig("unknown", v));
}

// ===== msprofiler_acl_api preCheck/ProfInit/ProfFinalize coverage =====
TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfInit_HelperHostSide)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, Msprofiler::AclApi::ProfInit(ACL_API_TYPE, "/tmp", 4));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfInit_NullPath)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, Msprofiler::AclApi::ProfInit(ACL_API_TYPE, nullptr, 0));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfInit_PathTooLong)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    std::string longPath(5000, 'a');
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM,
              Msprofiler::AclApi::ProfInit(ACL_API_TYPE, longPath.c_str(), longPath.size()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfInit_LengthMismatch)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, Msprofiler::AclApi::ProfInit(ACL_API_TYPE, "/tmp", 100));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfInit_PrecheckFail)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfInitPrecheck)
        .stubs().will(returnValue((int32_t)ACL_ERROR_PROF_NOT_RUN));
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN, Msprofiler::AclApi::ProfInit(ACL_API_TYPE, "/tmp", 4));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfFinalize_HelperHostSide)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FEATURE_UNSUPPORTED, Msprofiler::AclApi::ProfFinalize(ACL_API_TYPE));
}

// Not initialized (precheck returns ACL_ERROR_PROF_NOT_RUN): finalize is a no-op, returns success.
TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfFinalize_NotInitedReturnsSuccess)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    // Explicitly drive the not-inited path; avoids dependence on residual mode_ state left by
    // earlier tests, which would otherwise let IsInited() return true and reach the precheck.
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs().will(returnValue(false));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfFinalizePrecheck)
        .stubs().will(returnValue((int32_t)ACL_ERROR_PROF_NOT_RUN));
    EXPECT_EQ(ACL_SUCCESS, Msprofiler::AclApi::ProfFinalize(ACL_API_TYPE));
}

// Other precheck failures (not the uninitialized case) are still propagated as errors.
TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfFinalize_OtherPrecheckFailPropagates)
{
    MOCKER(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs().will(returnValue(false));
    // Inited (IsInited true) so it passes the no-op short-circuit and reaches the precheck.
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsInited)
        .stubs().will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfFinalizePrecheck)
        .stubs().will(returnValue((int32_t)ACL_ERROR_PROF_API_CONFLICT));
    EXPECT_EQ(ACL_ERROR_PROF_API_CONFLICT, Msprofiler::AclApi::ProfFinalize(ACL_API_TYPE));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfWarmup_NullConfig)
{
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, nullptr));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfWarmup_ZeroDataType)
{
    ProfConfig cfg{};
    cfg.devNums = 1;
    cfg.dataTypeConfig = 0;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfWarmup_BadDataType)
{
    ProfConfig cfg{};
    cfg.devNums = 1;
    cfg.dataTypeConfig = ~0ULL;
    EXPECT_EQ(ACL_ERROR_PROF_MODULES_UNSUPPORTED, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerAclApi_ProfWarmup_TooManyDevs)
{
    ProfConfig cfg{};
    cfg.devNums = MSVP_MAX_DEV_NUM + 5;
    cfg.dataTypeConfig = 0x80;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, Msprofiler::AclApi::ProfWarmup(ACL_API_TYPE, &cfg));
}

// ===== msprofiler_impl ProfAdprofGetFeatureIsOn / ProfAdprofInit / Mspti / ProfSetConfig =====
TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfAdprofGetFeatureIsOn_OffWhenZero)
{
    EXPECT_EQ(0, Analysis::Dvvp::ProfilerCommon::ProfAdprofGetFeatureIsOn(0xFFFFFFFFULL));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfAdprofInit_BadLen)
{
    char buf[16] = {0};
    EXPECT_EQ(MSPROF_ERROR, Analysis::Dvvp::ProfilerCommon::ProfAdprofInit(buf, 1));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_MsptiSubAndUnSubRawData)
{
    EXPECT_EQ(0, Analysis::Dvvp::ProfilerCommon::MsptiSubscribeRawData(nullptr));
    EXPECT_EQ(0, Analysis::Dvvp::ProfilerCommon::MsptiUnSubscribeRawData());
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfSetConfig)
{
    EXPECT_EQ(PROFILING_SUCCESS,
              Analysis::Dvvp::ProfilerCommon::ProfSetConfig(MSPROF_CONFIG_HELPER_HOST, "x", 1));
    EXPECT_EQ(MSPROF_ERROR_NONE,
              Analysis::Dvvp::ProfilerCommon::ProfSetConfig(0xFFFF, nullptr, 0));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfUnsetDeviceIdByGeModelIdx)
{
    EXPECT_EQ(MSPROF_ERROR_NONE,
              Analysis::Dvvp::ProfilerCommon::ProfSetDeviceIdByGeModelIdx(1u, 2u));
    EXPECT_EQ(MSPROF_ERROR_NONE,
              Analysis::Dvvp::ProfilerCommon::ProfUnsetDeviceIdByGeModelIdx(1u, 2u));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfCheckOpSwitch_EarlyExit)
{
    char buf[8] = "Add";
    EXPECT_FALSE(Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, buf, 3));
    EXPECT_FALSE(Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 3));
    EXPECT_FALSE(Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, buf, 0));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfReportData_DeprecatedModules)
{
    EXPECT_EQ(PROFILING_SUCCESS,
              Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_FRAMEWORK, 0, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS,
              Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_ACL, 0, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS,
              Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_RUNTIME, 0, nullptr, 0));
    EXPECT_EQ(PROFILING_SUCCESS,
              Analysis::Dvvp::ProfilerCommon::ProfReportData(MSPROF_MODULE_HCCL, 0, nullptr, 0));
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE,
              Analysis::Dvvp::ProfilerCommon::ProfReportData(0xFFFF, 0, nullptr, 0));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfConfigStart_NullData)
{
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStart(0, nullptr, sizeof(MsprofConfig)));
    MsprofConfig cfg{};
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStart(0, &cfg, 1));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfConfigStart_BadType)
{
    MsprofConfig cfg{};
    cfg.devNums = 1;
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStart(0xFFFF, &cfg, sizeof(MsprofConfig)));
}

TEST_F(MSPROF_ACL_CORE_UTEST, MsprofilerImpl_ProfConfigStop_NullData)
{
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStop(0, nullptr, sizeof(MsprofConfig)));
    MsprofConfig cfg{};
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStop(0, &cfg, 1));
    EXPECT_EQ(MSPROF_ERROR,
              Analysis::Dvvp::ProfilerCommon::ProfConfigStop(0xFFFF, &cfg, sizeof(MsprofConfig)));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ProfWarmup_SetResetIsWarmup)
{
    using namespace Msprofiler::Api;
    ProfAclMgr::instance()->ResetProfWarmup();
    EXPECT_FALSE(ProfAclMgr::instance()->IsProfWarmup());
    ProfAclMgr::instance()->SetProfWarmup();
    EXPECT_TRUE(ProfAclMgr::instance()->IsProfWarmup());
    ProfAclMgr::instance()->ResetProfWarmup();
    EXPECT_FALSE(ProfAclMgr::instance()->IsProfWarmup());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ChangeProfWarmupToStart_VariousDevs)
{
    using namespace Msprofiler::Api;
    std::vector<uint32_t> devs;
    ProfAclMgr::instance()->ChangeProfWarmupToStart(devs);
    devs.emplace_back(0);
    devs.emplace_back(1);
    devs.emplace_back(64);
    ProfAclMgr::instance()->ChangeProfWarmupToStart(devs);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_GetAllActiveDevices_EmptyAndFilled)
{
    using namespace Msprofiler::Api;
    std::vector<uint32_t> active;
    int32_t ret = ProfAclMgr::instance()->GetAllActiveDevices(active);
    // result depends on prior tests; just exercise the path safely.
    (void)ret;
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_IsModelSubscribed_NotPresent)
{
    using namespace Msprofiler::Api;
    EXPECT_FALSE(ProfAclMgr::instance()->IsModelSubscribed("non-existent-key-zzz"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_CloseSubscribeFdIfHostId_HostThenDev)
{
    using namespace Msprofiler::Api;
    // dev != DEFAULT_HOST_ID just appends; should be a no-throw call.
    ProfAclMgr::instance()->CloseSubscribeFdIfHostId(2);
    ProfAclMgr::instance()->CloseSubscribeFdIfHostId(3);
    // host id triggers iteration of fdCloseInfos_ and close (no real fds → safe).
    ProfAclMgr::instance()->CloseSubscribeFdIfHostId(64);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_FlushAllData_NoUploaderRegistered)
{
    using namespace Msprofiler::Api;
    // FlushAllData looks up uploader by devId; a missing uploader simply skips.
    ProfAclMgr::instance()->FlushAllData("9999");
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_StartAdprofDumper_OK)
{
    using namespace Msprofiler::Api;
    int32_t ret = ProfAclMgr::instance()->StartAdprofDumper();
    (void)ret;  // Either PROFILING_SUCCESS or PROFILING_FAILED depending on registry state.
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_GetOutputPath_BaseDir)
{
    using namespace Msprofiler::Api;
    auto p = ProfAclMgr::instance()->GetOutputPath();
    (void)p;  // baseDir_ may or may not be empty depending on prior init state.
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_GetDevicesNotify_AllPaths)
{
    using namespace Msprofiler::Api;
    uint32_t deviceId[3] = {64, 0, 1};
    std::vector<uint32_t> notify;
    bool ok = ProfAclMgr::instance()->GetDevicesNotify(deviceId, 3, notify);
    (void)ok;
    notify.clear();
    ok = ProfAclMgr::instance()->GetDevicesNotify(deviceId, 0, notify);
    EXPECT_FALSE(ok);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_GetRunningDevices_NoThrow)
{
    using namespace Msprofiler::Api;
    std::vector<uint32_t> ids;
    ProfAclMgr::instance()->GetRunningDevices(ids);
    // No assertion: just exercise path.
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_DumpStartInfoFile_NotSubscribeMode)
{
    using namespace Msprofiler::Api;
    // exercises both subscribe-mode early-return and the regular dump path.
    ProfAclMgr::instance()->DumpStartInfoFile(0);
    ProfAclMgr::instance()->DumpStartInfoFile(64);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_PackDataTrunk_Default)
{
    using namespace Msprofiler::Api;
    auto chunk = ProfAclMgr::instance()->PackDataTrunk();
    (void)chunk;  // call exercises the body; chunk may be nullptr.
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_MsprofInitHelper_NullArgs)
{
    using namespace Msprofiler::Api;
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
              ProfAclMgr::instance()->MsprofInitHelper(nullptr, 0));
    char buf[16] = {0};
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID,
              ProfAclMgr::instance()->MsprofInitHelper(buf, 1));
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_SettersAndPrintNull)
{
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->SetDevId("0");
    analyzer->SetDevId("");
    analyzer->SetGraphType(true);
    analyzer->SetGraphType(false);
    analyzer->SetOpType(true);
    analyzer->SetOpType(false);
    // Flush with null uploader is a no-op safe path.
    analyzer->Flush();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_OnOptimizeData_GuardBranches)
{
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    // not inited
    auto chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    analyzer->OnOptimizeData(chunk);
    // null
    analyzer->inited_ = true;
    analyzer->OnOptimizeData(nullptr);
    // empty filename
    chunk->fileName = "";
    analyzer->OnOptimizeData(chunk);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_PrintDeviceAndHostStats)
{
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->PrintDeviceStats();
    analyzer->PrintHostStats();
}

namespace {
static char g_recv_dummy_buf[1024] = {0};
static void *RecvBatchAddPopStub(size_t &popSize, bool /*popForce*/)
{
    popSize = 64;
    return reinterpret_cast<void *>(g_recv_dummy_buf);
}
static void *RecvBatchAddPopNullStub(size_t &/*popSize*/, bool /*popForce*/)
{
    return nullptr;
}
static void RecvBatchAddIndexShiftStub(void * /*popPtr*/, const size_t /*popSize*/) {}
static void *RecvVarAddPopStub(size_t &popSize)
{
    popSize = 64;
    return reinterpret_cast<void *>(g_recv_dummy_buf);
}
static void *RecvVarAddPopNullStub(size_t &/*popSize*/)
{
    return nullptr;
}
static void RecvVarAddIndexShiftStub(void * /*popPtr*/, const size_t /*popSize*/) {}
static bool RecvBufEmptyTrueStub() { return true; }
static bool RecvBufEmptyFalseStub() { return false; }
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_AdprofRun_NullAndNonNull) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk>> fileChunks;

    // null pop -> early return, no chunk pushed
    ReceiveData::batchAdditionalTryPop_ = RecvBatchAddPopNullStub;
    ReceiveData::batchAdditionalBufferIndexShift_ = RecvBatchAddIndexShiftStub;
    rData.AdprofRun(fileChunks);
    EXPECT_EQ(0u, fileChunks.size());

    // non-null pop -> DumpAdprofData called, chunk pushed
    ReceiveData::batchAdditionalTryPop_ = RecvBatchAddPopStub;
    rData.AdprofRun(fileChunks);
    EXPECT_EQ(1u, fileChunks.size());
    EXPECT_EQ(std::string("aicpu.data"), fileChunks[0]->fileName);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_VariableAdditionalRun_NullAndNonNull) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    rData.moduleName_ = "variable";
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk>> fileChunks;

    // null pop -> early return
    ReceiveData::varAdditionalTryPop_ = RecvVarAddPopNullStub;
    ReceiveData::varAdditionalBufferIndexShift_ = RecvVarAddIndexShiftStub;
    rData.VariableAdditionalRun(fileChunks);
    EXPECT_EQ(0u, fileChunks.size());

    // non-null pop -> DumpVariableData called, chunk pushed
    ReceiveData::varAdditionalTryPop_ = RecvVarAddPopStub;
    rData.VariableAdditionalRun(fileChunks);
    EXPECT_EQ(1u, fileChunks.size());
    EXPECT_NE(std::string::npos, fileChunks[0]->fileName.find("capture_op_info"));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_DumpAdprofData_Null) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    char buf[16] = {0};
    // null fileChunk -> hit the early-return branch (lines 420-421)
    rData.DumpAdprofData(buf, sizeof(buf), nullptr);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_DumpVariableData_Null) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    char buf[16] = {0};
    // null fileChunk -> early return
    rData.DumpVariableData(buf, sizeof(buf), nullptr);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_RunProfileData_AllBranches) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    rData.moduleName_ = "variable";
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk>> fileChunks;
    ReceiveData::batchAdditionalTryPop_ = RecvBatchAddPopNullStub;
    ReceiveData::varAdditionalTryPop_ = RecvVarAddPopNullStub;

    rData.profileDataType_ = ProfileDataType::ADPROF_ADDITIONAL_PROFILE_DATA_TYPE;
    rData.RunProfileData(fileChunks);
    rData.profileDataType_ = ProfileDataType::MSPROF_VARIABLE_ADDITIONAL_PROFILE_DATA_TYPE;
    rData.RunProfileData(fileChunks);
    // default branch
    rData.profileDataType_ = static_cast<ProfileDataType>(99);
    rData.RunProfileData(fileChunks);
    EXPECT_EQ(0u, fileChunks.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_Init_AllBranches) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    rData.moduleName_ = "api_event";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
    EXPECT_EQ(ProfileDataType::MSPROF_API_PROFILE_DATA_TYPE, rData.profileDataType_);

    rData.moduleName_ = "compact";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
    EXPECT_EQ(ProfileDataType::MSPROF_COMPACT_PROFILE_DATA_TYPE, rData.profileDataType_);

    rData.moduleName_ = "additional";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
    EXPECT_EQ(ProfileDataType::MSPROF_ADDITIONAL_PROFILE_DATA_TYPE, rData.profileDataType_);

    rData.moduleName_ = "adprof";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
    EXPECT_EQ(ProfileDataType::ADPROF_ADDITIONAL_PROFILE_DATA_TYPE, rData.profileDataType_);

    rData.moduleName_ = "variable";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
    EXPECT_EQ(ProfileDataType::MSPROF_VARIABLE_ADDITIONAL_PROFILE_DATA_TYPE, rData.profileDataType_);

    rData.moduleName_ = "unknown_module";
    EXPECT_EQ(PROFILING_SUCCESS, rData.Init());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_NoOpAndSendData) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    // Hit FNDA=0 functions
    rData.WriteDone();
    rData.TimedTask();
    EXPECT_EQ(PROFILING_SUCCESS, rData.SendData(nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, rData.Flush());
    rData.PrintTotalSize();
    EXPECT_EQ(PROFILING_SUCCESS, rData.Dump(*new std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk>>()));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_WaitAllBufferEmptyEvent_TimeoutAndOk) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    rData.moduleName_ = "wait_test";
    // First: buffer empty -> exits after first wait (status true)
    ReceiveData::reportBufEmpty_ = RecvBufEmptyTrueStub;
    rData.WaitAllBufferEmptyEvent(1);  // 1 us
    // Second: buffer not empty -> loops until cnt reaches maxWaitTimes (covers loop body)
    ReceiveData::reportBufEmpty_ = RecvBufEmptyFalseStub;
    rData.WaitAllBufferEmptyEvent(1);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ReceiveData_DumpProfileData_ReporterSwitchOff) {
    using namespace Msprof::Engine;
    ReceiveData rData;
    rData.moduleId_ = 0xdeadbeef;
    MOCKER_CPP(&Msprofiler::Parser::JsonParser::GetJsonModuleReporterSwitch)
        .stubs()
        .will(returnValue(false));
    std::vector<MsprofApi> message(1);
    std::vector<std::shared_ptr<analysis::dvvp::ProfileFileChunk>> fileChunks;
    rData.DumpProfileData<MsprofApi>(message, fileChunks, 1);
    EXPECT_EQ(0u, fileChunks.size());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_AddProfLevelConf_AllBranches)
{
    using namespace analysis::dvvp::common::config;
    using namespace Msprofiler::Api;
    using analysis::dvvp::message::ProfileParams;
    auto params = std::make_shared<ProfileParams>();

    // No bits -> no level set
    ProfAclMgr::instance()->AddProfLevelConf(params, 0);

    // PROF_TASK_TIME bit -> L0
    ProfAclMgr::instance()->AddProfLevelConf(params, PROF_TASK_TIME_MASK);
    EXPECT_EQ(MSVP_LEVEL_L0, params->prof_level);

    // PROF_TASK_TIME | L1 -> L1
    ProfAclMgr::instance()->AddProfLevelConf(params, PROF_TASK_TIME_MASK | PROF_TASK_TIME_L1_MASK);
    EXPECT_EQ(MSVP_LEVEL_L1, params->prof_level);

    // | L2 -> L2
    ProfAclMgr::instance()->AddProfLevelConf(params,
        PROF_TASK_TIME_MASK | PROF_TASK_TIME_L1_MASK | PROF_TASK_TIME_L2_MASK);
    EXPECT_EQ(MSVP_LEVEL_L2, params->prof_level);

    // | L3 -> L3
    ProfAclMgr::instance()->AddProfLevelConf(params,
        PROF_TASK_TIME_MASK | PROF_TASK_TIME_L1_MASK | PROF_TASK_TIME_L2_MASK | PROF_TASK_TIME_L3_MASK);
    EXPECT_EQ(MSVP_LEVEL_L3, params->prof_level);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ChangeLevelConf_AllBranches)
{
    using namespace analysis::dvvp::common::config;
    using namespace Msprofiler::Api;
    using analysis::dvvp::message::ProfileParams;
    auto params = std::make_shared<ProfileParams>();

    params->prof_level = MSVP_PROF_L3;
    ProfAclMgr::instance()->ChangeLevelConf(params);
    EXPECT_EQ(MSVP_LEVEL_L3, params->prof_level);

    params->prof_level = MSVP_PROF_L2;
    ProfAclMgr::instance()->ChangeLevelConf(params);
    EXPECT_EQ(MSVP_LEVEL_L2, params->prof_level);

    params->prof_level = MSVP_PROF_ON;
    ProfAclMgr::instance()->ChangeLevelConf(params);
    EXPECT_EQ(MSVP_LEVEL_L1, params->prof_level);

    params->prof_level = MSVP_PROF_L1;
    ProfAclMgr::instance()->ChangeLevelConf(params);
    EXPECT_EQ(MSVP_LEVEL_L1, params->prof_level);

    params->prof_level = MSVP_PROF_L0;
    ProfAclMgr::instance()->ChangeLevelConf(params);
    EXPECT_EQ(MSVP_LEVEL_L0, params->prof_level);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_AddRuntimeAndModelConf)
{
    using namespace Msprofiler::Api;
    uint64_t cfg = 0;
    // AddRuntimeTraceConf with task_time bit set -> RUNTIME_TRACE added
    cfg = PROF_TASK_TIME_MASK;
    ProfAclMgr::instance()->AddRuntimeTraceConf(cfg);
    EXPECT_NE(0u, cfg & PROF_RUNTIME_TRACE);

    // Without task_time bit -> nothing added
    uint64_t cfg2 = 0;
    ProfAclMgr::instance()->AddRuntimeTraceConf(cfg2);
    EXPECT_EQ(0u, cfg2);

    // AddModelLoadConf
    uint64_t cfg3 = 0;
    ProfAclMgr::instance()->AddModelLoadConf(cfg3);
    EXPECT_NE(0u, cfg3 & PROF_MODEL_LOAD);

    // AddAiCpuModelConf
    uint64_t cfg4 = 0;
    ProfAclMgr::instance()->AddAiCpuModelConf(cfg4);
    EXPECT_NE(0u, cfg4 & PROF_AICPU_MODEL);

    // AddOpDetailConf
    uint64_t cfg5 = 0;
    ProfAclMgr::instance()->AddOpDetailConf(cfg5);
    EXPECT_NE(0u, cfg5 & PROF_OP_DETAIL_MASK);

    // AddSubscribeConf - aggregates the above
    uint64_t cfg6 = 0;
    ProfAclMgr::instance()->AddSubscribeConf(cfg6);
    EXPECT_NE(0u, cfg6);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ProfAclGetDataTypeConfig_NullAndValues)
{
    using namespace Msprofiler::Api;
    // null config -> 0
    EXPECT_EQ(0u, ProfAclMgr::instance()->ProfAclGetDataTypeConfig(nullptr));

    MsprofConfig cfg{};
    cfg.cacheFlag = 0;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    EXPECT_EQ(0u, ProfAclMgr::instance()->ProfAclGetDataTypeConfig(&cfg));

    cfg.cacheFlag = 1;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    uint64_t v = ProfAclMgr::instance()->ProfAclGetDataTypeConfig(&cfg);
    EXPECT_NE(0u, v & PROF_TASK_TIME);

    cfg.cacheFlag = 0;
    cfg.metrics = 1;  // anything other than NONE
    v = ProfAclMgr::instance()->ProfAclGetDataTypeConfig(&cfg);
    EXPECT_NE(0u, v & PROF_AICORE_METRICS);
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_CheckSubscribeConfig_Branches)
{
    using namespace Msprofiler::Api;
    MsprofConfig cfg{};
    cfg.fd = 0;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclMgr::instance()->CheckSubscribeConfig(&cfg));

    cfg.fd = 5;
    cfg.cacheFlag = 0;
    cfg.metrics = static_cast<uint32_t>(PROF_AICORE_NONE);
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclMgr::instance()->CheckSubscribeConfig(&cfg));

    cfg.cacheFlag = 1;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->CheckSubscribeConfig(&cfg));

    cfg.cacheFlag = 0;
    cfg.metrics = 1;
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->CheckSubscribeConfig(&cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ProfAclFinalize_NotInited)
{
    using namespace Msprofiler::Api;
    // ProfAclMgr is a singleton; reset state so prior tests' mode_ leaks don't affect us.
    ProfAclMgr::instance()->mode_ = WORK_MODE_OFF;
    // mode_ != WORK_MODE_API_CTRL -> returns ACL_ERROR_PROF_NOT_RUN
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN, ProfAclMgr::instance()->ProfAclFinalize());
}

TEST_F(MSPROF_ACL_CORE_UTEST, ProfAclMgr_ProfAclGetDataTypeConfig_DevTask)
{
    using namespace Msprofiler::Api;
    uint64_t cfg = 0;
    // unknown device id -> ACL_ERROR_PROF_NOT_RUN
    EXPECT_EQ(ACL_ERROR_PROF_NOT_RUN,
        ProfAclMgr::instance()->ProfAclGetDataTypeConfig(0xfafefe, cfg));
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_IsNeedUpdateIndexId_Branches)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    // Empty keypoint -> false
    EXPECT_FALSE(analyzer->IsNeedUpdateIndexId());
    // endTime=0 -> still false
    KeypointOp kp{};
    kp.endTime = 0;
    kp.uploaded = false;
    analyzer->analyzerTs_->keypointOpInfo_["s1"] = kp;
    EXPECT_FALSE(analyzer->IsNeedUpdateIndexId());
    // endTime!=0 && uploaded -> false
    KeypointOp kp2{};
    kp2.endTime = 100;
    kp2.uploaded = true;
    analyzer->analyzerTs_->keypointOpInfo_["s2"] = kp2;
    EXPECT_FALSE(analyzer->IsNeedUpdateIndexId());
    // endTime!=0 && !uploaded -> true
    KeypointOp kp3{};
    kp3.endTime = 100;
    kp3.uploaded = false;
    analyzer->analyzerTs_->keypointOpInfo_["s3"] = kp3;
    EXPECT_TRUE(analyzer->IsNeedUpdateIndexId());
    analyzer->analyzerTs_->keypointOpInfo_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_GetOpIndexId_Branches)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    // Empty keypoint -> 0
    EXPECT_EQ(0u, analyzer->GetOpIndexId(123));
    // Single endTime=0 -> 0
    KeypointOp kp1{};
    kp1.endTime = 0;
    analyzer->analyzerTs_->keypointOpInfo_["x1"] = kp1;
    EXPECT_EQ(0u, analyzer->GetOpIndexId(123));
    analyzer->analyzerTs_->keypointOpInfo_.clear();
    // Two records: one endTime=0 (skip), one valid match
    KeypointOp kpEmpty{};
    kpEmpty.endTime = 0;
    KeypointOp kpHit{};
    kpHit.startTime = 100;
    kpHit.endTime = 500;
    kpHit.indexId = 42;
    analyzer->analyzerTs_->keypointOpInfo_["empty"] = kpEmpty;
    analyzer->analyzerTs_->keypointOpInfo_["hit"] = kpHit;
    EXPECT_EQ(42u, analyzer->GetOpIndexId(200));
    // Out-of-range timestamp -> 0
    EXPECT_EQ(0u, analyzer->GetOpIndexId(50));
    EXPECT_EQ(0u, analyzer->GetOpIndexId(1000));
    analyzer->analyzerTs_->keypointOpInfo_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UpdateOpIndexId_Branches)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    std::multimap<std::string, OpTime> opTimes;
    // Static shape early-return branch
    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    analyzer->UpdateOpIndexId(opTimes);

    // Step trace branch with mixed indexId values
    analyzer->profileMode_ = PROFILE_MODE_STEP_TRACE;
    OpTime t0{};
    t0.indexId = 5;  // skip
    t0.end = 200;
    OpTime t1{};
    t1.indexId = 0;
    t1.end = 250;
    opTimes.insert({"k0", t0});
    opTimes.insert({"k1", t1});
    KeypointOp kpHit{};
    kpHit.startTime = 100;
    kpHit.endTime = 500;
    kpHit.indexId = 7;
    kpHit.uploaded = true;
    KeypointOp kpKeep{};
    kpKeep.startTime = 100;
    kpKeep.endTime = 500;
    kpKeep.indexId = 9;
    kpKeep.uploaded = false;
    KeypointOp kpDel{};
    kpDel.startTime = 100;
    kpDel.endTime = 500;
    kpDel.indexId = 1;
    kpDel.uploaded = true;
    analyzer->analyzerTs_->keypointOpInfo_["hit"] = kpHit;
    analyzer->analyzerTs_->keypointOpInfo_["keep"] = kpKeep;
    analyzer->analyzerTs_->keypointOpInfo_["del"] = kpDel;
    analyzer->UpdateOpIndexId(opTimes);
    analyzer->analyzerTs_->keypointOpInfo_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadAppOpModeStaticShape_Branches)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));

    // Branch 1: GetIsAllStaticShape=true with completed/incomplete entries
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::GetIsAllStaticShape)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::IsOpInfoCompleted)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    std::multimap<std::string, OpTime> opTimes;
    OpTime ot1{};
    OpTime ot2{};
    opTimes.insert({"a", ot1});
    opTimes.insert({"b", ot2});
    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    analyzer->UploadAppOpModeStaticShape(opTimes);
    GlobalMockObject::verify();

    // Branch 2: !GetIsAllStaticShape with no stream type / unknown shape / completed
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::GetIsAllStaticShape)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::GetStreamType)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Analyze::AnalyzerGe::IsOpInfoCompleted)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();
    std::multimap<std::string, OpTime> opTimes2;
    OpTime ox1{};
    ox1.streamId = 1;
    OpTime ox2{};
    ox2.streamId = 2;
    OpTime ox3{};
    ox3.streamId = 3;
    opTimes2.insert({"x1", ox1});
    opTimes2.insert({"x2", ox2});
    opTimes2.insert({"x3", ox3});
    analyzer->UploadAppOpModeStaticShape(opTimes2);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_OnOptimizeData_NotInitedAndNullCases)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->inited_ = false;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk(new analysis::dvvp::ProfileFileChunk());
    chunk->fileName = "anything";
    analyzer->OnOptimizeData(chunk);

    analyzer->inited_ = true;
    // null fileChunk
    analyzer->OnOptimizeData(nullptr);
    // empty fileName
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> emptyChunk(new analysis::dvvp::ProfileFileChunk());
    emptyChunk->fileName = "";
    analyzer->OnOptimizeData(emptyChunk);

    // PROFILING_IS_CTRL_DATA + end_info -> clears static state
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> endInfo(new analysis::dvvp::ProfileFileChunk());
    endInfo->fileName = "end_info";
    endInfo->chunkModule = static_cast<int32_t>(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    analyzer->OnOptimizeData(endInfo);

    // PROFILING_IS_CTRL_DATA but other name -> just early return
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> ctrl(new analysis::dvvp::ProfileFileChunk());
    ctrl->fileName = "other_ctrl";
    ctrl->chunkModule = static_cast<int32_t>(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    analyzer->OnOptimizeData(ctrl);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_DispatchOptimizeData_Drop)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> drop(new analysis::dvvp::ProfileFileChunk());
    drop->fileName = "no_match_file_name";
    drop->chunkModule = 0;
    analyzer->OnOptimizeData(drop);
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadProfOpDescProc_NullUploader)
{
    GlobalMockObject::verify();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    // Inject one opDesc into static info; uploader_ is nullptr -> early-return branch
    ProfOpDesc desc{};
    desc.modelId = 100;
    AnalyzerBase::opDescInfos_.push_back(desc);
    analyzer->UploadProfOpDescProc();
    AnalyzerBase::opDescInfos_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, Analyzer_UploadKeypointOp_StaticShapeBranches)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Analyze::Analyzer::ConstructAndUploadData)
        .stubs();
    std::shared_ptr<Analyzer> analyzer(new Analyzer(nullptr));
    analyzer->profileMode_ = PROFILE_MODE_STATIC_SHAPE;
    KeypointOp kpEnd0;
    kpEnd0.endTime = 0;
    KeypointOp kpReady{};
    kpReady.startTime = 10;
    kpReady.endTime = 20;
    kpReady.modelId = 1;
    analyzer->analyzerTs_->keypointOpInfo_["a"] = kpEnd0;
    analyzer->analyzerTs_->keypointOpInfo_["b"] = kpReady;
    analyzer->UploadKeypointOp();
    analyzer->analyzerTs_->keypointOpInfo_.clear();
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_FileNameQueryHelpers)
{
    GlobalMockObject::verify();
    using namespace Analysis::Dvvp::Analyze;
    std::shared_ptr<AnalyzerGe> ge(new AnalyzerGe());
    EXPECT_TRUE(ge->IsGeData("Framework_data"));
    EXPECT_FALSE(ge->IsGeData("other_data"));
    EXPECT_TRUE(ge->IsGeApiOrEventData("xx.api_event"));
    EXPECT_FALSE(ge->IsGeApiOrEventData("xx.compact"));
    EXPECT_TRUE(ge->IsGeCompactData("a.node_basic_info"));
    EXPECT_FALSE(ge->IsGeCompactData("a.api_event"));
    EXPECT_TRUE(ge->IsGeContextData("x.context_id_info"));
    EXPECT_FALSE(ge->IsGeContextData("x.api_event"));
    EXPECT_TRUE(ge->IsGeGraphIdMapData("u.graph_id_map.bin"));
    EXPECT_FALSE(ge->IsGeGraphIdMapData("u.api_event"));
    EXPECT_TRUE(ge->GetIsAllStaticShape());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_GetStreamType_AndGetters)
{
    GlobalMockObject::verify();
    using namespace Analysis::Dvvp::Analyze;
    std::shared_ptr<AnalyzerGe> ge(new AnalyzerGe());
    int32_t streamType = -1;
    EXPECT_FALSE(ge->GetStreamType(99, streamType));
    StreamInfo si{};
    si.streamType = 1;
    ge->steamState_[99] = si;
    EXPECT_TRUE(ge->GetStreamType(99, streamType));
    EXPECT_EQ(1, streamType);
    // Empty key returns default values
    EXPECT_FALSE(ge->IsOpInfoCompleted("missing"));
    EXPECT_EQ(0u, ge->GetModelId(std::string("missing")));
    EXPECT_TRUE(ge->GetOpName("missing").empty());
    EXPECT_TRUE(ge->GetOpType("missing").empty());
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_Parse_NullAndDropped)
{
    GlobalMockObject::verify();
    using namespace Analysis::Dvvp::Analyze;
    std::shared_ptr<AnalyzerGe> ge(new AnalyzerGe());
    // null fileChunk
    ge->Parse(nullptr);

    // id_map_info but chunkSize too small -> incomplete branch
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> small(new analysis::dvvp::ProfileFileChunk());
    small->fileName = "id_map_info";
    small->chunk = std::string(1, '\0');
    small->chunkSize = 1;
    ge->totalBytes_ = 0;
    ge->Parse(small);
    EXPECT_EQ(1u, ge->totalBytes_);

    // unknown -> drop
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> drop(new analysis::dvvp::ProfileFileChunk());
    drop->fileName = "unknown_data";
    drop->chunkSize = 4;
    ge->Parse(drop);
}

TEST_F(MSPROF_ACL_CORE_UTEST, AnalyzerGe_AllParse_NullAndDropped)
{
    GlobalMockObject::verify();
    using namespace Analysis::Dvvp::Analyze;
    std::shared_ptr<AnalyzerGe> ge(new AnalyzerGe());
    ge->GeApiAndEventParse(nullptr);
    ge->GeCompactParse(nullptr);
    ge->GeContextParse(nullptr);
    ge->GeGraphIdMapParse(nullptr);

    // GeGraphIdMapParse: drop branch (no "unaging")
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> aging(new analysis::dvvp::ProfileFileChunk());
    aging->fileName = "aging.graph_id_map";
    aging->chunkSize = 0;
    ge->GeGraphIdMapParse(aging);

    // GeApiAndEventParse: filename neither aging nor unaging -> drop
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> other(new analysis::dvvp::ProfileFileChunk());
    other->fileName = "no_match.api_event";
    other->chunkSize = 0;
    ge->GeApiAndEventParse(other);

    // GeCompactParse: filename neither aging nor unaging -> drop
    ge->GeCompactParse(other);

    // aging branch with opTypeFlag_ false -> drop
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> agingApi(new analysis::dvvp::ProfileFileChunk());
    agingApi->fileName = "aging.api_event";
    agingApi->chunkSize = 0;
    AnalyzerBase::opTypeFlag_ = false;
    ge->GeApiAndEventParse(agingApi);
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> agingCompact(new analysis::dvvp::ProfileFileChunk());
    agingCompact->fileName = "aging.compact.node_basic_info";
    agingCompact->chunkSize = 0;
    ge->GeCompactParse(agingCompact);
}
