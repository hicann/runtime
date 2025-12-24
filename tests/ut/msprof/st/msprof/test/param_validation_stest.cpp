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
#include <string>
#include <memory>
#include "message/prof_params.h"
#include "proto/profiler.pb.h"
#include "message/codec.h"
#include "param_validation.h"
#include "platform/platform.h"
#include "devdrv_runtime_api_stub.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "config/config_manager.h"
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;

class COMMON_VALIDATION_PARAM_VALIDATION_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }

};

static int _drv_get_dev_ids(int num_devices, std::vector<int> & dev_ids) {
    static int phase = 0;
    if (phase == 0) {
        phase++;
        return -1;
    }

    if (phase >= 1) {
        dev_ids.push_back(0);
        return 0;
    }
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckProfilingParams) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    params->devices = "all";
    //jobStartReq == nullptr
    EXPECT_EQ(false, entry->CheckProfilingParams(nullptr));
    //job_id is empty
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    params->host_sys = "cpu";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    //job_id is illegal
    params->job_id = "0aA-$";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    params->job_id = "0aA-";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    //profiling_mode is empty
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    params->profiling_mode = "def_mode";
    params->devices = "0,1";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    params->devices = "0,1,a";
    EXPECT_EQ(false, entry->CheckProfilingParams(params));
    params->devices = "0,88";
    EXPECT_EQ(false, entry->CheckProfilingParams(params));
    params->devices = "7";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
    params->devices = "0,1";
    params->l2CacheTaskProfilingEvents = "0x5b,0x5b,0x5b,0x5b";
    params->llc_profiling_events = "asdff_$";
    EXPECT_EQ(false, entry->CheckProfilingParams(params));
    params->llc_profiling_events = "asdff_01";
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckProfilingIntervalIsValid) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(nullptr));
    params->cpu_sampling_interval = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->cpu_sampling_interval = 10;
    params->sys_sampling_interval = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->sys_sampling_interval = 10;
    params->aicore_sampling_interval = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->aiv_sampling_interval = 0;
    params->aicore_sampling_interval = 10;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->aiv_sampling_interval = 10;
    params->hccsInterval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->hccsInterval = 10;
    params->pcieInterval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->pcieInterval = 10;
    params->roceInterval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->roceInterval = 10;
    params->llc_interval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->llc_interval = 10;
    params->ddr_interval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->ddr_interval = 10;
    params->hbmInterval  = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->hbmInterval = 10;
    params->hardware_mem_sampling_interval   = 0;
    EXPECT_EQ(false, entry->CheckProfilingIntervalIsValid(params));
    params->hardware_mem_sampling_interval = 10;
    params->profiling_period    = 0;
    EXPECT_EQ(true, entry->CheckProfilingIntervalIsValid(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckSystemTraceSwitchProfiling) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(nullptr));
    params->cpu_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->cpu_profiling = "on";
    params->tsCpuProfiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->tsCpuProfiling = "on";
    params->aiCtrlCpuProfiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->aiCtrlCpuProfiling = "on";
    params->sys_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->sys_profiling = "on";
    params->pid_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->pid_profiling = "on";
    params->hardware_mem = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->hardware_mem = "on";
    params->io_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->io_profiling = "on";
    params->interconnection_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->interconnection_profiling = "on";
    params->dvpp_profiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->dvpp_profiling = "on";
    params->nicProfiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->nicProfiling = "on";
    params->roceProfiling = "asd";
    EXPECT_EQ(false, entry->CheckSystemTraceSwitchProfiling(params));
    params->roceProfiling = "on";
    EXPECT_EQ(true, entry->CheckSystemTraceSwitchProfiling(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckControlSwitchProfiling) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    params->taskTsfw = "asd";
    EXPECT_EQ(true, entry->CheckControlSwitchProfiling(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckTsSwitchProfiling) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    params->ts_task_track = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ts_cpu_usage = "asd";
    params->ts_task_track = "on";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ai_core_status = "asd";
    params->ts_cpu_usage = "on";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ai_core_status = "on";
    params->ts_timeline = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ts_timeline = "on";
    params->ts_fw_training = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ts_fw_training = "on";
    params->hwts_log = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->hwts_log = "on";
    params->hwts_log1 = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->hwts_log1 = "on";
    params->ai_vector_status = "ada";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ai_vector_status = "on";
    params->ts_memcpy = "asd";
    EXPECT_EQ(false, entry->CheckTsSwitchProfiling(params));
    params->ts_memcpy = "on";
    EXPECT_EQ(true, entry->CheckTsSwitchProfiling(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckPmuSwitchProfiling) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    params->ai_core_profiling = "asd";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->ai_core_profiling = "on";
    params->aiv_profiling = "asd";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->aiv_profiling = "on";
    params->llc_profiling = "on";
    params->ddr_profiling="asd";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->ddr_profiling="on";
    params->hccsProfiling = "asd";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->pcieProfiling = "asd";
    params->hccsProfiling = "on";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->hbmProfiling = "asd";
    params->pcieProfiling = "on";
    EXPECT_EQ(false, entry->CheckPmuSwitchProfiling(params));
    params->hbmProfiling = "on";
    EXPECT_EQ(true, entry->CheckPmuSwitchProfiling(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckAivEventCoresIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    const std::vector<int> coreId = {0,1,2,3,4,5,6,7,8};
    EXPECT_EQ(true, entry->CheckAivEventCoresIsValid(coreId));
    const std::vector<int> coreId1 = {0,1,2,3,-4};
    EXPECT_EQ(false, entry->CheckAivEventCoresIsValid(coreId1));
    const std::vector<int> coreId2 = {0,1,2,3,4};
    EXPECT_EQ(true, entry->CheckAivEventCoresIsValid(coreId2));
    const std::vector<int> coreId3(81);
    EXPECT_EQ(false, entry->CheckAivEventCoresIsValid(coreId3));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckTsCpuEventIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    std::vector<std::string> events = {"read","write","read","write","read", "asd","write","read","write"};
    EXPECT_EQ(false, entry->CheckTsCpuEventIsValid(events));
    std::vector<std::string> events1 = {"read","write","read","write"};
    EXPECT_EQ(false, entry->CheckTsCpuEventIsValid(events1));
    std::vector<std::string> events2 = {"0xa"};
    EXPECT_EQ(true, entry->CheckTsCpuEventIsValid(events2));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckDdrEventsIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    std::vector<std::string> events = {"read","write","read","write","read","write","read","write","read","write"};
    EXPECT_EQ(false, entry->CheckDdrEventsIsValid(events));
    events = {"read","write1"};
    EXPECT_EQ(false, entry->CheckDdrEventsIsValid(events));
    events = {"read","write"};
    EXPECT_EQ(true, entry->CheckDdrEventsIsValid(events));
    events = {"master_id"};
    EXPECT_EQ(true, entry->CheckDdrEventsIsValid(events));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckHbmEventsIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    std::vector<std::string> events = {"read","write","read","write","read","write","read","write","read","write"};
    EXPECT_EQ(false, entry->CheckHbmEventsIsValid(events));
    events = {"read","write1"};
    EXPECT_EQ(false, entry->CheckHbmEventsIsValid(events));
    events = {"read","write"};
    EXPECT_EQ(true, entry->CheckHbmEventsIsValid(events));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckAivEventsIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    const std::vector<std::string> aiv;
    EXPECT_EQ(true, entry->CheckAivEventsIsValid(aiv));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckAppNameIsValid) {
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(false, entry->CheckAppNameIsValid(""));

    const std::string appName = "asd0";
    EXPECT_EQ(true, entry->CheckAppNameIsValid(appName));

    const std::string invalidAppName = "$SD";
    EXPECT_EQ(false, entry->CheckAppNameIsValid(invalidAppName));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckProfilingParams1) {
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::proto::JobStartReq> start(new analysis::dvvp::proto::JobStartReq);
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    //profiling_mode is illegal
    std::string sampleConfig = "{\"result_dir\":\"/tmp/\", \"job_id\":\"aaaZZZZ000-\", \"profiling_mode\":\"system-wide\", \"devices\":\"1\"}";
    params->FromString(sampleConfig);
    EXPECT_EQ(true, entry->CheckProfilingParams(params));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, Init) {
    GlobalMockObject::verify();
    EXPECT_EQ(0, analysis::dvvp::common::validation::ParamValidation::instance()->Init());
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, UnInit) {
    GlobalMockObject::verify();
    EXPECT_EQ(0, analysis::dvvp::common::validation::ParamValidation::instance()->Uninit());
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckLlcEventsIsValid) {
    GlobalMockObject::verify();

    std::string llcEvents;
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(true, entry->CheckLlcEventsIsValid(llcEvents));
    llcEvents = "/$$}";
    EXPECT_EQ(false, entry->CheckLlcEventsIsValid(llcEvents));
    llcEvents = "read";
    EXPECT_EQ(true, entry->CheckLlcEventsIsValid(llcEvents));
    llcEvents = "/llc/0/abc";
    EXPECT_EQ(true, entry->CheckLlcEventsIsValid(llcEvents));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckEventsSize)
{
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(PROFILING_SUCCESS, entry->CheckEventsSize(""));
    EXPECT_EQ(PROFILING_FAILED, entry->CheckEventsSize("0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9"));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckAicoreMetricsIsValid) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::MINI_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::string aicoreMetrics;
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(true, entry->CheckAicoreMetricsIsValid(aicoreMetrics));
    aicoreMetrics = "/$$}";
    EXPECT_EQ(false, entry->CheckAicoreMetricsIsValid(aicoreMetrics));
    aicoreMetrics = "PipeUtilization";
    EXPECT_EQ(true, entry->CheckAicoreMetricsIsValid(aicoreMetrics));
    aicoreMetrics = "aicoreMetricsAll";
    EXPECT_EQ(false, entry->CheckAicoreMetricsIsValid(aicoreMetrics));
    aicoreMetrics = "PipelineExecuteUtilization";
    EXPECT_EQ(false, entry->CheckAicoreMetricsIsValid(aicoreMetrics));
    Platform::instance()->Uninit();
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckSocPmuEventsValid) {
    using namespace analysis::dvvp::common::validation;
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V3));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    std::vector<std::string> events = {"0x00","0x01","0x02","0x03","0x04","0x05","0x06","0x07","0x08"};
    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x90","0x01","0x02","0x03","0x04","0x05","0x06","0x07"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {" 0x00","0x01 "," 0x02 ","  0x03 "," 0x04   ","0x05    ","     0x06"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x 00","0x01","0x02","0x03","0x04","0x05","0x06"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0x62"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0x100"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0xFF"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0x809"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_SMMU, events));
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0x808"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_SMMU, events));
    events = {"0x01", "0x02", "0x03", "0x3f"};
    EXPECT_EQ(true, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_NOC, events));
    events = {"0x01", "0x02", "0x03", "0x40"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_NOC, events));
    Platform::instance()->Uninit();
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Init();
    // noc not support on CHIP_V4_1_0
    events = {"0x01", "0x02", "0x03", "0x3f"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_NOC, events));
    Platform::instance()->Uninit();
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::MINI_TYPE));
    Platform::instance()->Init();
    events = {"0x78", "0x79", "0x77", "0x71", "0x6a", "0x6c", "0x74", "0x255"};
    EXPECT_EQ(false, entry->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_HA, events));
    Platform::instance()->Uninit();
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, IsValidSleepPeriod) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    EXPECT_EQ(0, entry->IsValidSleepPeriod(-1));
    EXPECT_EQ(1, entry->IsValidSleepPeriod(1));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckHostSysOptionsIsValid) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    std::string hostSysOptions;
    EXPECT_EQ(false, entry->CheckHostSysOptionsIsValid(hostSysOptions));
    hostSysOptions = "COMMON_VALIDATION_PARAM_VALIDATION_STEST/CheckHostSysOptionsIsValid";
    EXPECT_EQ(false, entry->CheckHostSysOptionsIsValid(hostSysOptions));
    hostSysOptions = "cpu";
    EXPECT_EQ(true, entry->CheckHostSysOptionsIsValid(hostSysOptions));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckHostSysPidIsValid) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::common::validation::ParamValidation::instance();
    int hostSysPid = -1;
    EXPECT_EQ(0, entry->CheckHostSysPidIsValid(hostSysPid));
    hostSysPid = 100000000;
    EXPECT_EQ(0, entry->CheckHostSysPidIsValid(hostSysPid));
    hostSysPid = 1;
    EXPECT_EQ(1, entry->CheckHostSysPidIsValid(hostSysPid));
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckStorageLimit) {
    using namespace analysis::dvvp::common::validation;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);

    params->storageLimit = "MB";
    bool ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "10MB0";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "A12345MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "123456789100MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "100MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "8294967296MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "4294967295MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);

    params->storageLimit = "1000MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);

    params->storageLimit = "";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);
}

TEST_F(COMMON_VALIDATION_PARAM_VALIDATION_STEST, CheckInstrProfilingFreqValid) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Init();
    using namespace analysis::dvvp::common::validation;
    bool ret = ParamValidation::instance()->CheckInstrProfilingFreqValid(0);
    EXPECT_EQ(false, ret);
    ret = ParamValidation::instance()->CheckInstrProfilingFreqValid(1000);
    EXPECT_EQ(true, ret);
    ret = ParamValidation::instance()->CheckInstrProfilingFreqValid(1000000);
    EXPECT_EQ(false, ret);
    Platform::instance()->Uninit();
}