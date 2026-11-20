/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "prof_manager.h"
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
using Msprofiler::Api::ProfAclMgr;
namespace {
constexpr uint32_t COMPUTE_TEST_METRIC_BASE = 0x500;
constexpr uint32_t COMPUTE_TEST_METRIC_ZERO = 0x0;
constexpr uint32_t COMPUTE_TEST_METRIC_301 = 0x301;
constexpr uint32_t COMPUTE_TEST_METRIC_501 = 0x501;
constexpr uint32_t COMPUTE_ZERO_METRIC_CASE_NUM = 3;
int32_t ComputeRawDataCallback(MsprofRawData* rawData)
{
    (void)rawData;
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
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
    ASSERT_NE(nullptr, params);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlock);
    EXPECT_EQ(expectedBlockShink, params->taskBlockShink);
}

} // namespace

class MsprofilerAdapterUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(MsprofilerAdapterUtest, PROF_OP_SUBSCRIBE)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::ProfStartAclSubscribe).stubs().will(returnValue(ACL_SUCCESS));

    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfOpSubscribe(0, nullptr));
    aclprofSubscribeConfig config;
    config.config.timeInfo = true;
    config.config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
    EXPECT_EQ(ACL_SUCCESS, ProfOpSubscribe(0, &config));
}

TEST_F(MsprofilerAdapterUtest, PROF_OP_UNSUBSCRIBE)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::IsModelSubscribed).stubs().will(returnValue(false)).then(returnValue(true));

    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, ProfOpUnSubscribe(0));
    EXPECT_EQ(ACL_SUCCESS, ProfOpUnSubscribe(0));
}

TEST_F(MsprofilerAdapterUtest, PROF_ACL_SUBSCRIBE)
{
    ProfRegisterTransport(ProfCreateParsertransport());
    EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, ProfAclSubscribe(0, 0, nullptr));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_TYPE_NOT_ZERO)
{
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, nullptr, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, "MatMul", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(2, "Add", 3));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(UINT32_MAX, "Relu", 4));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_NULLPTR_OP)
{
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 6));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_ZERO_LEN)
{
    const char* op = "MatMul";
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 0));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 0));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_EMPTY_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("")));

    const char* op = "MatMul";
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_OP_IN_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul,Add,Relu")));

    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_OP_NOT_IN_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul,Add")));

    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Conv2D", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Softmax", 7));
}

TEST_F(MsprofilerAdapterUtest, PROF_CHECKOPSWITCH_SINGLE_OP_CONFIG)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig).stubs().will(returnValue(std::string("MatMul")));

    EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
    EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MsprofilerAdapterUtest, PROF_IS_INITED)
{
    // ProfIsInited passes through ProfAclMgr::IsInited().
    MOCKER(&Msprofiler::Api::ProfAclMgr::IsInited).stubs().will(returnValue(true)).then(returnValue(false));

    EXPECT_EQ(true, ProfIsInited());
    EXPECT_EQ(false, ProfIsInited());
}

TEST_F(MsprofilerAdapterUtest, PROF_GET_RESULT_PATH_NORMAL)
{
    // Normal: result path fits into the buffer, copied out and returns success.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath).stubs().will(returnValue(std::string("/tmp/prof_result")));

    char buf[64] = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
    EXPECT_STREQ("/tmp/prof_result", buf);
}

TEST_F(MsprofilerAdapterUtest, PROF_GET_RESULT_PATH_EMPTY)
{
    // Empty result path: returns success with an empty C-string.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath).stubs().will(returnValue(std::string("")));

    char buf[64] = {'x', 'y', 'z', '\0'};
    EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
    EXPECT_EQ('\0', buf[0]);
}

TEST_F(MsprofilerAdapterUtest, PROF_GET_RESULT_PATH_BUFFER_TOO_SMALL)
{
    // Buffer too small: path length >= len must fail without writing out of bounds.
    MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath)
        .stubs()
        .will(returnValue(std::string("/tmp/a_long_result_path")));

    char buf[8] = {0};
    EXPECT_EQ(PROFILING_FAILED, ProfGetResultPath(buf, sizeof(buf)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STOP_NOT_STARTED_SUCCESS)
{
    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofStop(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STOP_INVALID_PARAM_DOES_NOT_CLEAR_RUNNING_CONTEXT)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->statuses_[0] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();

    EXPECT_EQ(PROFILING_FAILED, MsprofStop(MSPROF_CTRL_INIT_COMPUTE, nullptr, 0));
    EXPECT_EQ(1U, manager->statuses_.size());

    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_DEV_NUM)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    config.devNums = 2;
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_EMPTY_AICORE_METRICS)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_ALL_INVALID_AICORE_METRICS)
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

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_EMPTY_INSTR_MODE)
{
    EXPECT_EQ(
        PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfRegisterDataCallback(
                               PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback)));
    MsprofConfig config = MakeComputeConfig(PROF_INSTR_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_UNKNOWN_INSTR_MODE)
{
    MsprofConfigAttr attr = {};
    attr.id = PROF_CONFIG_ATTR_INSTR;
    attr.value.instrMode = 0x80U;
    MsprofConfig config = MakeComputeConfig(PROF_INSTR_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_CHECK_HOST_DEVICE)
{
    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    config.devIdList[0] = analysis::dvvp::common::utils::DEFAULT_HOST_ID;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_REJECTS_WHEN_OTHER_PROFILING_MODE_RUNNING)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::HasRunningDeviceTasks).stubs().will(returnValue(true));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsModeOff).stubs().will(returnValue(false));

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
    EXPECT_TRUE(manager->statuses_.empty());
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_REJECTS_WHEN_OTHER_WORK_MODE_RUNNING)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    auto aclManager = Msprofiler::Api::ProfAclMgr::instance();
    aclManager->SetModeToCmd();

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_FAILED, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
    EXPECT_TRUE(manager->statuses_.empty());

    aclManager->SetModeToOff();
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_MODE_NOTIFY_SET_DEVICE_DOES_NOT_START_NORMAL_PROFILING)
{
    auto aclManager = Msprofiler::Api::ProfAclMgr::instance();
    aclManager->SetModeToCompute();
    MOCKER_CPP(&Analysis::Dvvp::ProfilerCommon::ProfConfigStart).expects(never());

    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(0, 3, true));
    EXPECT_FALSE(aclManager->IsCmdMode());
    EXPECT_TRUE(aclManager->IsComputeMode());

    aclManager->SetModeToOff();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_MODE_ENSURE_UPLOADER_DOES_NOT_CREATE_FILE_TRANSPORT)
{
    auto aclManager = Msprofiler::Api::ProfAclMgr::instance();
    aclManager->SetModeToCompute();
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport).expects(never());
    EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, aclManager->EnsureComputeUploader("3"));

    aclManager->SetModeToOff();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_TEN_AICORE_METRICS)
{
    MsprofConfigAttr attr = {};
    FillComputeMetrics(attr);
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
    ASSERT_NE(nullptr, params);
    EXPECT_EQ("0", params->job_id);
    EXPECT_TRUE(params->result_dir.empty());
    EXPECT_TRUE(params->resultPath.empty());
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_COMPUTE_MODE, params->profMode);
    EXPECT_EQ(analysis::dvvp::message::PROFILING_MODE_DEF, params->profiling_mode);
    EXPECT_EQ(0, params->ai_core_metrics.find("Custom:"));
    EXPECT_NE(std::string::npos, params->ai_core_metrics.find("0x509"));
    EXPECT_EQ(std::string::npos, params->ai_core_profiling_events.find("Custom:"));
    EXPECT_NE(std::string::npos, params->ai_core_profiling_events.find("0x509"));
    EXPECT_EQ(params->ai_core_profiling_events, params->aiv_profiling_events);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_KEEP_ZERO_AICORE_METRIC)
{
    MsprofConfigAttr attr = {};
    FillInvalidComputeMetrics(attr);
    attr.value.aicoreMetrics[0] = COMPUTE_TEST_METRIC_ZERO;
    attr.value.aicoreMetrics[1] = COMPUTE_TEST_METRIC_501;
    attr.value.aicoreMetrics[2] = COMPUTE_TEST_METRIC_301;
    MsprofConfig config = MakeComputeConfig(PROF_AICORE_METRICS_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
    ASSERT_NE(nullptr, params);
    EXPECT_EQ("Custom:0x0,0x501,0x301", params->ai_core_metrics);
    EXPECT_EQ("0x0,0x501,0x301", params->ai_core_profiling_events);
    EXPECT_EQ(params->ai_core_metrics, params->aiv_metrics);
    EXPECT_EQ(params->ai_core_profiling_events, params->aiv_profiling_events);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_ALL_BLOCK_MODE)
{
    ExpectComputeBlockParams(PROF_COMPUTE_ALL_BLOCK, analysis::dvvp::common::config::MSVP_PROF_OFF);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_BLOCK_SHRINK_MODE)
{
    ExpectComputeBlockParams(PROF_COMPUTE_BLOCK_SHRINK, analysis::dvvp::common::config::MSVP_PROF_ON);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_INVALID_BLOCK_MODE)
{
    constexpr uint32_t invalidBlockMode = 0;
    MsprofConfigAttr attr = {};
    MsprofConfig config = MakeComputeBlockConfig(attr, invalidBlockMode);
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_BLOCK_AND_INSTR_MODE)
{
    MsprofConfigAttr attrs[2] = {};
    attrs[0].id = PROF_CONFIG_ATTR_INSTR;
    attrs[0].value.instrMode = PROF_COMPUTE_BIU_PERF;
    attrs[1].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[1].value.taskBlockMode = PROF_COMPUTE_BLOCK_SHRINK;
    MsprofConfig config = MakeComputeBlockConfig(attrs, 2, PROF_INSTR_MASK);

    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
    ASSERT_NE(nullptr, params);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->instrProfiling);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlock);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlockShink);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_PARSE_REPEAT_TASK_BLOCK_ATTR_LAST_WINS)
{
    MsprofConfigAttr attrs[2] = {};
    attrs[0].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[0].value.taskBlockMode = PROF_COMPUTE_ALL_BLOCK;
    attrs[1].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[1].value.taskBlockMode = PROF_COMPUTE_BLOCK_SHRINK;
    MsprofConfig config = MakeComputeBlockConfig(attrs, 2, 0);

    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::ProfilerCommon::ComputeConfigAdapter::ToProfileParams(config, params));
    ASSERT_NE(nullptr, params);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlock);
    EXPECT_EQ(analysis::dvvp::common::config::MSVP_PROF_ON, params->taskBlockShink);
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_START_JOB_REJECTS_EMPTY_BASELINE_PARAMS)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();

    EXPECT_EQ(PROFILING_FAILED, manager->CloneBaselineParams(manager->baselineParams_));
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_CONFIG_DIFFERENCE_ONLY_PRINTS_WARNING)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    MsprofConfig firstConfig = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_TRUE(manager->CheckConfigConsistency(firstConfig));

    MsprofConfig secondConfig = MakeComputeConfig(PROF_AICPU_TRACE_MASK);
    EXPECT_TRUE(manager->CheckConfigConsistency(secondConfig));
    EXPECT_NE(PROF_TASK_TIME_MASK, manager->baselineConfig_.profSwitch);
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_BASELINE_CONFIG_COPIES_ATTRS)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();

    MsprofConfigAttr attr = {};
    attr.id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attr.value.taskBlockMode = PROF_COMPUTE_ALL_BLOCK;
    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    config.configInfo.attrs = &attr;
    config.configInfo.numAttrs = 1;
    EXPECT_TRUE(manager->CheckConfigConsistency(config));

    MsprofConfig sameConfig = MakeComputeConfig(PROF_TASK_TIME_MASK);
    sameConfig.configInfo.attrs = &attr;
    sameConfig.configInfo.numAttrs = 1;
    EXPECT_TRUE(manager->IsSameComputeConfig(sameConfig));
    EXPECT_EQ(1U, manager->baselineConfig_.configInfo.numAttrs);
    EXPECT_NE(&attr, manager->baselineConfig_.configInfo.attrs);

    MsprofConfigAttr changedAttr = {};
    changedAttr.id = PROF_CONFIG_ATTR_TASK_BLOCK;
    changedAttr.value.taskBlockMode = PROF_COMPUTE_BLOCK_SHRINK;
    MsprofConfig changedConfig = MakeComputeConfig(PROF_TASK_TIME_MASK);
    changedConfig.configInfo.attrs = &changedAttr;
    changedConfig.configInfo.numAttrs = 1;
    EXPECT_FALSE(manager->IsSameComputeConfig(changedConfig));
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STATUS_STOP_RELEASES_HOST_WHEN_LAST_DEVICE_STOPPED)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    manager->statuses_[0] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice).expects(once()).will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ReleaseComputeHostContext)
        .expects(once())
        .will(returnValue(PROFILING_SUCCESS));

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_SUCCESS, manager->Stop(&config, sizeof(config)));
    EXPECT_TRUE(manager->statuses_.empty());
    EXPECT_EQ(nullptr, manager->hostTransport_);
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STATUS_STOP_KEEP_HOST_WHEN_OTHER_DEVICE_RUNNING)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    manager->statuses_[0] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();
    manager->statuses_[1] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice).expects(once()).will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ReleaseComputeHostContext).expects(never());

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    config.devIdList[0] = 0;
    EXPECT_EQ(PROFILING_SUCCESS, manager->Stop(&config, sizeof(config)));
    EXPECT_EQ(1U, manager->statuses_.size());
    EXPECT_NE(manager->statuses_.end(), manager->statuses_.find(1));
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STATUS_STOP_KEEP_STATUS_WHEN_HOST_RELEASE_FAILED)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    manager->statuses_[0] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice)
        .expects(exactly(2))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ReleaseComputeHostContext)
        .expects(exactly(2))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_FAILED, manager->Stop(&config, sizeof(config)));
    EXPECT_EQ(1U, manager->statuses_.size());
    EXPECT_EQ(PROFILING_SUCCESS, manager->Stop(&config, sizeof(config)));
    EXPECT_TRUE(manager->statuses_.empty());
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_RELEASE_HOST_CONTEXT_STOPS_TASK_BEFORE_CLEANUP)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();

    SHARED_PTR_ALIA<analysis::dvvp::transport::InjectionTransport> injectionTransport = nullptr;
    MSVP_MAKE_SHARED1(
        injectionTransport, analysis::dvvp::transport::InjectionTransport, ComputeRawDataCallback, return);
    manager->hostTransport_ = injectionTransport;
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> uploader =
        std::make_shared<analysis::dvvp::transport::Uploader>(injectionTransport);
    ASSERT_EQ(PROFILING_SUCCESS, uploader->Init());
    ASSERT_EQ(PROFILING_SUCCESS, uploader->Start());
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader(
        std::to_string(analysis::dvvp::common::utils::DEFAULT_HOST_ID), uploader);

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    ProfAclMgr::ProfAclTaskInfo taskInfo = {1, PROF_TASK_TIME_MASK, params};
    ProfAclMgr::instance()->devTasks_[analysis::dvvp::common::utils::DEFAULT_HOST_ID] = taskInfo;
    ProfAclMgr::instance()->mode_ = Msprofiler::Api::WORK_MODE_CMD;
    // IdeCloudProfileProcess generates end_info and uploads it through the host uploader.
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IdeCloudProfileProcess)
        .expects(once())
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, manager->ReleaseComputeHostContext());
    EXPECT_EQ(nullptr, manager->hostTransport_);
    uploader = nullptr;
    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(
        std::to_string(analysis::dvvp::common::utils::DEFAULT_HOST_ID), uploader);
    EXPECT_EQ(nullptr, uploader);

    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STOP_JOB_SYNCHRONOUSLY)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice).expects(once()).will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, manager->StopComputeJob(0));
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STOP_JOB_FAILED)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice).expects(once()).will(returnValue(PROFILING_FAILED));

    EXPECT_EQ(PROFILING_FAILED, manager->StopComputeJob(0));
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_STOP_FAILURE_KEEPS_STATUS_FOR_RETRY)
{
    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    manager->baselineConfig_.profSwitch = PROF_TASK_TIME_MASK;
    manager->statuses_[0] = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus();
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::ProfStopCommonDevice)
        .expects(exactly(2))
        .will(returnValue(PROFILING_FAILED));

    MsprofConfig config = MakeComputeConfig(PROF_TASK_TIME_MASK);
    EXPECT_EQ(PROFILING_FAILED, manager->Stop(&config, sizeof(config)));
    EXPECT_EQ(1U, manager->statuses_.size());
    EXPECT_EQ(PROFILING_FAILED, manager->Stop(&config, sizeof(config)));
    EXPECT_EQ(1U, manager->statuses_.size());
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_CREATE_UPLOADER_USES_INJECTION_TRANSPORT_ONLY)
{
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport).expects(never());
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::CreateUploader)
        .expects(once())
        .will(returnValue(PROFILING_SUCCESS));

    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus status;
    EXPECT_EQ(PROFILING_SUCCESS, manager->CreateComputeUploader(0, status));
    EXPECT_NE(nullptr, status.transport);
    manager->RollbackComputeStatus(0);
    manager->ClearContext();
}

TEST_F(MsprofilerAdapterUtest, COMPUTE_CREATE_UPLOADER_ROLLBACK_WHEN_CREATE_UPLOADER_FAILED)
{
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport).expects(never());
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::CreateUploader)
        .expects(once())
        .will(returnValue(PROFILING_FAILED));

    auto manager = Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::instance();
    manager->ClearContext();
    Analysis::Dvvp::ProfilerCommon::ComputeProfilingManager::ComputeStatus status;
    EXPECT_EQ(PROFILING_FAILED, manager->CreateComputeUploader(0, status));
    EXPECT_EQ(nullptr, status.transport);
    manager->ClearContext();
}
