/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <cstdlib>
#include <string>
#include <vector>
#include "aprof_pub.h"
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_plugin.h"
#include "prof_api.h"
#include "prof_inner_api.h"
#include "prof_tx_plugin.h"
#include "prof_cann_plugin.h"
#include "errno/error_code.h"
#include "prof_plugin_manager.h"
#include "platform/platform.h"
#include "mmpa_api.h"
#include "acl/acl_prof.h"
#include "msprofiler_acl_api.h"
#include "prof_acl_mgr.h"
#include "msprofiler_impl.h"
#include "common/singleton/singleton.h"
#include "message/prof_params.h"
#include "file_transport.h"
#include "job_adapter.h"
#include "transport/injection_transport.h"
#include "uploader_mgr.h"
#include "command_handle.h"
#define private public
#include "compute_profiling_manager.h"
#undef private

extern "C" {
extern Msprofiler::AclApi::ProfCreateTransportFunc ProfCreateParsertransport();
extern void ProfRegisterTransport(Msprofiler::AclApi::ProfCreateTransportFunc callback);
// ProfIsInited / ProfGetResultPath are declared in msprofiler_adaptor.h, but that header cannot be
// included here because it declares ProfAclInit/Start/... as extern "C" with ProfType params, which
// conflicts with the uint32_t-param declarations already pulled in via prof_inner_api.h. Declare
// them locally, matching the existing pattern above for transport functions.
extern bool ProfIsInited();
extern int32_t ProfGetResultPath(char* path, uint32_t len);
}

using namespace analysis::dvvp::common::error;
namespace {
constexpr uint32_t COMPUTE_TEST_METRIC_BASE = 0x500;
constexpr uint32_t COMPUTE_TEST_METRIC_ZERO = 0x0;
constexpr uint32_t COMPUTE_TEST_METRIC_301 = 0x301;
constexpr uint32_t COMPUTE_TEST_METRIC_501 = 0x501;
constexpr uint32_t COMPUTE_ZERO_METRIC_CASE_NUM = 3;
constexpr uint32_t COMPUTE_CALLBACK_TEST_DEV_ID = 5;
constexpr uint64_t COMPUTE_CALLBACK_TEST_SWITCH = PROF_TASK_TIME_MASK | PROF_AICORE_METRICS_MASK;

int32_t ComputeRawDataCallback(MsprofRawData* rawData)
{
    (void)rawData;
    return PROFILING_SUCCESS;
}

int32_t HookInitSuccess() { return PROFILING_SUCCESS; }

int32_t HookInitFailed() { return PROFILING_FAILED; }

bool initHookCalled = false;
bool initHookSawSetHook = false;
bool initHookSawGetHook = false;
int32_t g_computeTestStartRet = PROFILING_SUCCESS;
int32_t g_computeTestStopRet = PROFILING_SUCCESS;
uint32_t g_computeTestStartCount = 0;
uint32_t g_computeTestStopCount = 0;
uint32_t g_computeComponentStartCount = 0;
uint32_t g_computeComponentStopCount = 0;
uint32_t g_computeComponentDevId = 0;
uint64_t g_computeComponentProfSwitch = 0;

class ComputeTestJobAdapter : public Analysis::Dvvp::JobWrapper::JobAdapter {
public:
    int32_t StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) override
    {
        (void)params;
        ++g_computeTestStartCount;
        return g_computeTestStartRet;
    }

    int32_t StopProf(void) override
    {
        ++g_computeTestStopCount;
        return g_computeTestStopRet;
    }
};

void ResetInjectionContext()
{
    initHookCalled = false;
    initHookSawSetHook = false;
    initHookSawGetHook = false;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearInjectionContext();
}

void ExpectRegisterInjectionFunc(uint32_t type, void* func)
{
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(type, func));
}

void PrepareInjectionContextWithSetGetHooks()
{
    ResetInjectionContext();
    unsetenv("ACL_API_INJECTION");
    ExpectRegisterInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(ComputeRawDataCallback));
    ExpectRegisterInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(ComputeRawDataCallback));
}

int32_t HookInitGetRegisteredHooks()
{
    initHookCalled = true;
    initHookSawSetHook = Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_SET) != nullptr;
    initHookSawGetHook = Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_GET) != nullptr;
    return (initHookSawSetHook && initHookSawGetHook) ? PROFILING_SUCCESS : PROFILING_FAILED;
}

void ResetComputeTestJob(int32_t startRet, int32_t stopRet)
{
    g_computeTestStartRet = startRet;
    g_computeTestStopRet = stopRet;
    g_computeTestStartCount = 0;
    g_computeTestStopCount = 0;
}

void ResetComputeComponentCommand()
{
    g_computeComponentStartCount = 0;
    g_computeComponentStopCount = 0;
    g_computeComponentDevId = 0;
    g_computeComponentProfSwitch = 0;
}

int32_t CaptureComputeStartCommand(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch, uint64_t)
{
    ++g_computeComponentStartCount;
    if (devIdList != nullptr && devNums == 1) {
        g_computeComponentDevId = devIdList[0];
    }
    g_computeComponentProfSwitch = profSwitch;
    return PROFILING_SUCCESS;
}

int32_t CaptureComputeStopCommand(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch, uint64_t)
{
    ++g_computeComponentStopCount;
    if (devIdList != nullptr && devNums == 1) {
        g_computeComponentDevId = devIdList[0];
    }
    g_computeComponentProfSwitch = profSwitch;
    return PROFILING_SUCCESS;
}

MsprofConfig MakeComputeConfig(uint64_t profSwitch)
{
    MsprofConfig config = {};
    config.profSwitch = profSwitch;
    config.devNums = 1;
    config.devIdList[0] = 0;
    return config;
}

void FillComputeMetrics(MsprofConfigAttr& attr)
{
    attr.id = PROF_CONFIG_ATTR_AICORE_METRICS;
    for (size_t index = 0; index < COMPUTE_AICORE_METRICS_NUM; ++index) {
        attr.value.aicoreMetrics[index] = COMPUTE_TEST_METRIC_BASE + static_cast<uint32_t>(index);
    }
}

void FillInvalidComputeMetrics(MsprofConfigAttr& attr)
{
    attr.id = PROF_CONFIG_ATTR_AICORE_METRICS;
    for (size_t index = 0; index < COMPUTE_AICORE_METRICS_NUM; ++index) {
        attr.value.aicoreMetrics[index] = MSPROF_INVALID_AICORE_METRIC;
    }
}

MsprofConfig MakeComputeBlockConfig(MsprofConfigAttr& attr, uint32_t blockMode)
{
    MsprofConfig config = MakeComputeConfig(0);
    attr.id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attr.value.taskBlockMode = blockMode;
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    return config;
}

MsprofConfig MakeComputeBlockConfig(MsprofConfigAttr attrs[], size_t numAttrs, uint64_t profSwitch)
{
    MsprofConfig config = MakeComputeConfig(profSwitch);
    config.configInfo.attrs = attrs;
    config.configInfo.numAttrs = numAttrs;
    return config;
}

void ExpectComputeBlockParams(uint32_t blockMode, const std::string& expectedBlockShink)
{
    MsprofConfigAttr attr = {};
    MsprofConfig config = MakeComputeBlockConfig(attr, blockMode);
    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, manager->ParseConfig(config, computeConfig));
    EXPECT_TRUE(computeConfig.enableBlock);
    EXPECT_EQ(blockMode, computeConfig.blockMode);
    auto params = manager->BuildProfileParams(computeConfig, "0");
    ASSERT_NE(nullptr, params);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlock);
    EXPECT_EQ(expectedBlockShink, params->taskBlockShink);
}
} // namespace

class MSPROFILER_ADAPTER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_OP_SUBSCRIBE)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::ProfStartAclSubscribe).stubs().will(returnValue(ACL_SUCCESS));

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfOpSubscribe(0, nullptr));
    aclprofSubscribeConfig config;
    config.config.timeInfo = true;
    config.config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    EXPECT_EQ(ACL_ERROR_NONE, ProfOpSubscribe(0, &config));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_OP_UNSUBSCRIBE)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::IsModelSubscribed).stubs().will(returnValue(false)).then(returnValue(true));

    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, ProfOpUnSubscribe(0));
    EXPECT_EQ(ACL_ERROR_NONE, ProfOpUnSubscribe(0));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_ACL_SUBSCRIBE)
{
    ProfRegisterTransport(ProfCreateParsertransport());
    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, ProfAclSubscribe(0, 0, nullptr));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_TYPE_NOT_ZERO)
{
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, nullptr, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, "MatMul", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(2, "Add", 3));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(UINT32_MAX, "Relu", 4));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_NULLPTR_OP)
{
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 6));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_ZERO_LEN)
{
    const char* op = "MatMul";
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 0));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_EMPTY_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("")));

    const char* op = "MatMul";
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_OP_IN_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul,Add,Relu")));

    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_OP_NOT_IN_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul,Add")));

    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Conv2D", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Softmax", 7));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_SINGLE_OP_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul")));

    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_IS_INITED)
{
    // ProfIsInited passes through ProfAclMgr::IsInited().
    MOCKER(&Msprofiler::Api::ProfAclMgr::IsInited).stubs().will(returnValue(true)).then(returnValue(false));

    EXPECT_EQ(true, ProfIsInited());
    EXPECT_EQ(false, ProfIsInited());
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_NORMAL)
{
    // Normal: result path fits into the buffer, copied out and returns success.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath).stubs().will(returnValue(std::string("/tmp/prof_result")));

    char buf[64] = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
    EXPECT_STREQ("/tmp/prof_result", buf);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_EMPTY)
{
    // Empty result path: returns success with an empty C-string.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath).stubs().will(returnValue(std::string("")));

    char buf[64] = {'x', 'y', 'z', '\0'};
    EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
    EXPECT_EQ('\0', buf[0]);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_BUFFER_TOO_SMALL)
{
    // Buffer too small: path length >= len must fail without writing out of bounds.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath)
        .stubs()
        .will(returnValue(std::string("/tmp/a_long_result_path")));

    char buf[8] = {0};
    EXPECT_EQ(PROFILING_FAILED, ProfGetResultPath(buf, sizeof(buf)));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_STOP_NOT_STARTED_SUCCESS)
{
    EXPECT_EQ(PROFILING_SUCCESS, MsprofStop(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_STOP_INVALID_PARAM_DOES_NOT_CLEAR_RUNNING_CONTEXT)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->running_ = true;
    manager->runningDevId_ = "0";

    EXPECT_EQ(PROFILING_FAILED, MsprofStop(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
    EXPECT_TRUE(manager->running_);
    EXPECT_EQ("0", manager->runningDevId_);

    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_START_CHECK_DEV_NUM)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    config.devNums = 2;
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_START_CHECK_EMPTY_AICORE_METRICS)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_START_CHECK_ALL_INVALID_AICORE_METRICS)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfigAttr attr = {};
    FillInvalidComputeMetrics(attr);
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_START_CHECK_EMPTY_INSTR_MODE)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_INSTR_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_TEN_AICORE_METRICS)
{
    MsprofConfigAttr attr = {};
    FillComputeMetrics(attr);
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, manager->ParseConfig(config, computeConfig));
    EXPECT_EQ(COMPUTE_AICORE_METRICS_NUM, computeConfig.aicoreMetrics.size());
    auto params = manager->BuildProfileParams(computeConfig, "0");
    ASSERT_NE(nullptr, params);
    EXPECT_EQ("0", params->job_id);
    EXPECT_TRUE(params->result_dir.empty());
    EXPECT_TRUE(params->resultPath.empty());
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_COMPUTE_MODE, params->profMode);
    EXPECT_EQ(analysis::dvvp::message::PROFILING_MODE_DEF, params->profiling_mode);
    EXPECT_EQ(0, params->ai_core_metrics.find("Custom:"));
    EXPECT_NE(std::string::npos, params->ai_core_metrics.find("0x509"));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_KEEP_ZERO_AICORE_METRIC)
{
    MsprofConfigAttr attr = {};
    FillInvalidComputeMetrics(attr);
    attr.value.aicoreMetrics[0] = COMPUTE_TEST_METRIC_ZERO;
    attr.value.aicoreMetrics[1] = COMPUTE_TEST_METRIC_501;
    attr.value.aicoreMetrics[2] = COMPUTE_TEST_METRIC_301;
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, manager->ParseConfig(config, computeConfig));
    EXPECT_EQ(COMPUTE_ZERO_METRIC_CASE_NUM, computeConfig.aicoreMetrics.size());
    auto params = manager->BuildProfileParams(computeConfig, "0");
    ASSERT_NE(nullptr, params);
    EXPECT_EQ("Custom:0x0,0x501,0x301", params->ai_core_metrics);
    EXPECT_EQ(params->ai_core_metrics, params->aiv_metrics);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_ALL_BLOCK_MODE)
{
    ExpectComputeBlockParams(PROF_COMPUTE_ALL_BLOCK, analysis::dvvp::common::config::MSVP_PROF_OFF);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_BLOCK_SHRINK_MODE)
{
    ExpectComputeBlockParams(PROF_COMPUTE_BLOCK_SHRINK, analysis::dvvp::common::config::MSVP_PROF_ON);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_INVALID_BLOCK_MODE)
{
    constexpr uint32_t invalidBlockMode = 0;
    MsprofConfigAttr attr = {};
    MsprofConfig config = MakeComputeBlockConfig(attr, invalidBlockMode);
    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_FAILED, manager->ParseConfig(config, computeConfig));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_BLOCK_AND_INSTR_MODE)
{
    MsprofConfigAttr attrs[2] = {};
    attrs[0].id = PROF_CONFIG_ATTR_INSTR;
    attrs[0].value.instrMode = PROF_COMPUTE_BIU_PERF;
    attrs[1].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[1].value.taskBlockMode = PROF_COMPUTE_BLOCK_SHRINK;
    MsprofConfig config = MakeComputeBlockConfig(attrs, 2, PROF_INSTR_MASK);

    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, manager->ParseConfig(config, computeConfig));
    EXPECT_TRUE(computeConfig.enableInstr);
    EXPECT_TRUE(computeConfig.enableBiuPerf);
    EXPECT_TRUE(computeConfig.enableBlock);
    EXPECT_EQ(PROF_COMPUTE_BLOCK_SHRINK, computeConfig.blockMode);

    auto params = manager->BuildProfileParams(computeConfig, "0");
    ASSERT_NE(nullptr, params);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->instrProfiling);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlock);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlockShink);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_PARSE_REPEAT_TASK_BLOCK_ATTR_LAST_WINS)
{
    MsprofConfigAttr attrs[2] = {};
    attrs[0].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[0].value.taskBlockMode = PROF_COMPUTE_ALL_BLOCK;
    attrs[1].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[1].value.taskBlockMode = PROF_COMPUTE_BLOCK_SHRINK;
    MsprofConfig config = MakeComputeBlockConfig(attrs, 2, 0);

    Analysis::Dvvp::ProfilerCommon::ComputeProfileConfig computeConfig;
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, manager->ParseConfig(config, computeConfig));
    EXPECT_TRUE(computeConfig.enableBlock);
    EXPECT_EQ(PROF_COMPUTE_BLOCK_SHRINK, computeConfig.blockMode);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_START_JOB_REJECTS_NULL_PARAMS)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    ResetComputeTestJob(PROFILING_SUCCESS, PROFILING_SUCCESS);

    EXPECT_EQ(PROFILING_FAILED, manager->StartComputeJob(nullptr, 0));
    EXPECT_EQ(0U, g_computeTestStartCount);
    EXPECT_EQ(0U, g_computeTestStopCount);
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_STOP_JOB_SYNCHRONOUSLY)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    ResetComputeTestJob(PROFILING_SUCCESS, PROFILING_SUCCESS);
    manager->jobAdapter_ = std::make_shared<ComputeTestJobAdapter>();
    manager->runningDevId_ = "0";

    EXPECT_EQ(PROFILING_SUCCESS, manager->StopComputeJob());
    EXPECT_EQ(0U, g_computeTestStartCount);
    EXPECT_EQ(1U, g_computeTestStopCount);
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_STOP_JOB_FAILED)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    ResetComputeTestJob(PROFILING_SUCCESS, PROFILING_FAILED);
    manager->jobAdapter_ = std::make_shared<ComputeTestJobAdapter>();
    manager->runningDevId_ = "0";

    EXPECT_EQ(PROFILING_FAILED, manager->StopComputeJob());
    EXPECT_EQ(0U, g_computeTestStartCount);
    EXPECT_EQ(1U, g_computeTestStopCount);
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_COMPONENT_CALLBACK_START_AND_STOP)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    ResetComputeComponentCommand();
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart)
        .expects(once())
        .will(invoke(CaptureComputeStartCommand));
    EXPECT_EQ(
        PROFILING_SUCCESS, manager->StartComponentCallback(COMPUTE_CALLBACK_TEST_DEV_ID, COMPUTE_CALLBACK_TEST_SWITCH));
    EXPECT_EQ(1U, g_computeComponentStartCount);
    EXPECT_EQ(COMPUTE_CALLBACK_TEST_DEV_ID, g_computeComponentDevId);
    EXPECT_EQ(COMPUTE_CALLBACK_TEST_SWITCH, g_computeComponentProfSwitch);

    ResetComputeComponentCommand();
    manager->runningDevId_ = std::to_string(COMPUTE_CALLBACK_TEST_DEV_ID);
    manager->runningProfSwitch_ = COMPUTE_CALLBACK_TEST_SWITCH;
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::CommandHandleProfStop)
        .expects(once())
        .will(invoke(CaptureComputeStopCommand));
    EXPECT_EQ(PROFILING_SUCCESS, manager->StopComponentCallback());
    EXPECT_EQ(1U, g_computeComponentStopCount);
    EXPECT_EQ(COMPUTE_CALLBACK_TEST_DEV_ID, g_computeComponentDevId);
    EXPECT_EQ(COMPUTE_CALLBACK_TEST_SWITCH, g_computeComponentProfSwitch);
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_COMPONENT_CALLBACK_STOP_INVALID_DEVICE_ID)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->runningDevId_ = "invalid";
    manager->runningProfSwitch_ = COMPUTE_CALLBACK_TEST_SWITCH;
    EXPECT_EQ(PROFILING_FAILED, manager->StopComponentCallback());
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_CREATE_UPLOADER_USES_INJECTION_TRANSPORT_ONLY)
{
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport).expects(never());
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::CreateUploader)
        .expects(once())
        .will(returnValue(PROFILING_SUCCESS));

    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    EXPECT_EQ(PROFILING_SUCCESS, manager->CreateComputeUploader("0"));
    EXPECT_NE(nullptr, manager->injectionTransport_);
    manager->ClearContext();
}

TEST_F(MSPROFILER_ADAPTER_UTEST, COMPUTE_CREATE_UPLOADER_ROLLBACK_WHEN_CREATE_UPLOADER_FAILED)
{
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport).expects(never());
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::CreateUploader)
        .expects(once())
        .will(returnValue(PROFILING_FAILED));

    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    EXPECT_EQ(PROFILING_FAILED, manager->CreateComputeUploader("0"));
    EXPECT_EQ(nullptr, manager->injectionTransport_);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, INJECTION_FUNC_CHECK_PARAM_AND_ENV_OFF)
{
    unsetenv("ACL_API_INJECTION");
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(PROF_HOOK_SET, nullptr));
    EXPECT_EQ(
        PROFILING_FAILED,
        Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(3, reinterpret_cast<void*>(ComputeRawDataCallback)));
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(
                               PROF_HOOK_SET, reinterpret_cast<void*>(ComputeRawDataCallback)));
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(
                               PROF_HOOK_GET, reinterpret_cast<void*>(ComputeRawDataCallback)));
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfInjectionInitialize());
    EXPECT_EQ(nullptr, Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_SET));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, INJECTION_FUNC_INIT_HOOK_SUCCESS)
{
    PrepareInjectionContextWithSetGetHooks();
    EXPECT_EQ(
        PROFILING_SUCCESS,
        Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(HookInitSuccess)));
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfInjectionInitialize());
    EXPECT_NE(nullptr, Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_SET));
    EXPECT_NE(nullptr, Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_GET));
    EXPECT_EQ(nullptr, Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_INIT));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, INJECTION_FUNC_INIT_HOOK_GETS_REGISTERED_HOOKS)
{
    PrepareInjectionContextWithSetGetHooks();
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(
                               PROF_HOOK_INIT, reinterpret_cast<void*>(HookInitGetRegisteredHooks)));
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfInjectionInitialize());
    EXPECT_TRUE(initHookCalled);
    EXPECT_TRUE(initHookSawSetHook);
    EXPECT_TRUE(initHookSawGetHook);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, INJECTION_FUNC_INIT_HOOK_REQUIRES_SET_GET_HOOKS)
{
    ResetInjectionContext();
    unsetenv("ACL_API_INJECTION");
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(
                               PROF_HOOK_INIT, reinterpret_cast<void*>(HookInitGetRegisteredHooks)));
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ProfInjectionInitialize());
    EXPECT_FALSE(initHookCalled);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, INJECTION_FUNC_INIT_HOOK_FAILED)
{
    PrepareInjectionContextWithSetGetHooks();
    EXPECT_EQ(
        PROFILING_SUCCESS,
        Analysis::Dvvp::ProfilerCommon::ProfSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(HookInitFailed)));
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ProfInjectionInitialize());
    EXPECT_EQ(nullptr, Analysis::Dvvp::ProfilerCommon::ProfGetInjectionFunc(PROF_HOOK_SET));
}
