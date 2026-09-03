/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <atomic>
#include <chrono>
#include <cstdlib>
#include <dirent.h>
#include <thread>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aprof_pub.h"
#include "data_manager.h"
#include "errno/error_code.h"
#include "device_simulator_manager.h"
#include "acl_api_stub.h"
#include "devprof_drv_aicpu.h"
#include "prof_cann_plugin.h"
#include "prof_inner_api.h"
#include "prof_common.h"
#include "securec.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

#ifndef ascend031
extern "C" int32_t acltoolInitialize();

namespace {
constexpr char ACL_API_INJECTION_STUB[] = "libacl_tool_injection_stub.so";
constexpr char COMPUTE_RESULT_DIR_PREFIX[] = "PROF_COMPUTE_";
constexpr uint32_t COMPUTE_AICORE_METRIC = 0x501;
constexpr uint32_t COMPUTE_CALLBACK_MODULE_ID = HSS;

std::atomic<uint32_t> computeInitCount{0};
std::atomic<uint32_t> computeRawDataCount{0};
std::atomic<uint32_t> computeStartCallbackCount{0};
std::atomic<uint32_t> computeStopCallbackCount{0};
std::atomic<bool> computeControlCaptureEnabled{false};
std::atomic<bool> computeInitSawSetHook{false};
std::atomic<bool> computeInitSawGetHook{false};

int32_t RuntimeSetHookStub() { return PROFILING_SUCCESS; }

int32_t RuntimeGetHookStub() { return PROFILING_SUCCESS; }

int32_t ComputeRawDataCallback(MsprofRawData* rawData)
{
    if (rawData != nullptr) {
        computeRawDataCount.fetch_add(1);
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeControlCallback(uint32_t type, void* data, uint32_t len)
{
    if (!computeControlCaptureEnabled.load()) {
        return PROFILING_SUCCESS;
    }
    if (type != PROF_CTRL_SWITCH || data == nullptr || len != sizeof(MsprofCommandHandle)) {
        return PROFILING_SUCCESS;
    }
    const auto* command = static_cast<MsprofCommandHandle*>(data);
    if (command->devNums != 1 || command->devIdList[0] != 0) {
        return PROFILING_SUCCESS;
    }
    if (command->type == PROF_COMMANDHANDLE_TYPE_START) {
        computeStartCallbackCount.fetch_add(1);
    } else if (command->type == PROF_COMMANDHANDLE_TYPE_STOP) {
        computeStopCallbackCount.fetch_add(1);
    }
    return PROFILING_SUCCESS;
}

void ResetComputeInjectionStState()
{
    ProfAPI::ProfCannPlugin::instance()->ProfResetInjectionState();
    computeInitCount.store(0);
    computeRawDataCount.store(0);
    computeInitSawSetHook.store(false);
    computeInitSawGetHook.store(false);
    unsetenv("ACL_API_INJECTION");
}

void ResetComputeControlCallbackState()
{
    computeControlCaptureEnabled.store(false);
    computeStartCallbackCount.store(0);
    computeStopCallbackCount.store(0);
}

bool HasComputeResultDir(const std::string& path)
{
    DIR* dir = opendir(path.c_str());
    if (dir == nullptr) {
        return false;
    }
    struct dirent* entry = nullptr;
    while ((entry = readdir(dir)) != nullptr) {
        std::string name = entry->d_name;
        if (name.find(COMPUTE_RESULT_DIR_PREFIX) == 0) {
            closedir(dir);
            return true;
        }
    }
    closedir(dir);
    return false;
}

int32_t RegisterCallbackFromAcltoolInitialize()
{
    computeInitCount.fetch_add(1);
    computeInitSawSetHook.store(MsprofGetInjectionFunc(PROF_HOOK_SET) != nullptr);
    computeInitSawGetHook.store(MsprofGetInjectionFunc(PROF_HOOK_GET) != nullptr);
    if (!computeInitSawSetHook.load() || !computeInitSawGetHook.load()) {
        return PROFILING_FAILED;
    }
    return MsprofRegisterDataCallback(PROF_DATA_CALLBACK_COMPUTE, reinterpret_cast<void*>(ComputeRawDataCallback));
}

void FillComputeConfig(const std::string& dumpPath, MsprofConfigAttr& metricAttr, MsprofConfig& config)
{
    config = {};
    config.profSwitch = PROF_TASK_TIME_MASK | PROF_AICORE_METRICS_MASK;
    config.devNums = 1;
    config.devIdList[0] = 0;
    metricAttr.id = PROF_CONFIG_ATTR_AICORE_METRICS;
    for (size_t index = 0; index < COMPUTE_AICORE_METRICS_NUM; ++index) {
        metricAttr.value.aicoreMetrics[index] = MSPROF_INVALID_AICORE_METRIC;
    }
    metricAttr.value.aicoreMetrics[0] = COMPUTE_AICORE_METRIC;
    config.configInfo.attrs = &metricAttr;
    config.configInfo.numAttrs = 1;
    (void)strncpy_s(config.dumpPath, MAX_DUMP_PATH_LEN, dumpPath.c_str(), MAX_DUMP_PATH_LEN - 1);
}

void FillComputeBlockConfig(uint32_t blockMode, MsprofConfigAttr attrs[], MsprofConfig& config)
{
    FillComputeConfig("", attrs[0], config);
    attrs[1].id = PROF_CONFIG_ATTR_TASK_BLOCK;
    attrs[1].value.taskBlockMode = blockMode;
    config.configInfo.attrs = attrs;
    config.configInfo.numAttrs = 2;
}

void RegisterComputeSetGetHooks()
{
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_SET, reinterpret_cast<void*>(RuntimeSetHookStub)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_GET, reinterpret_cast<void*>(RuntimeGetHookStub)));
}

void ExpectComputeInjectionInitialized()
{
    EXPECT_EQ(1U, computeInitCount.load());
    EXPECT_TRUE(computeInitSawSetHook.load());
    EXPECT_TRUE(computeInitSawGetHook.load());
}

void RunComputeProfilingStartStop(const std::string& aclProfPath, uint32_t blockMode = 0)
{
    MsprofConfigAttr attrs[2] = {};
    MsprofConfig config = {};
    if (blockMode == 0) {
        FillComputeConfig("", attrs[0], config);
    } else {
        FillComputeBlockConfig(blockMode, attrs, config);
    }
    EXPECT_EQ('\0', config.dumpPath[0]);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofRegisterCallback(COMPUTE_CALLBACK_MODULE_ID, ComputeControlCallback));
    ResetComputeControlCallbackState();
    std::this_thread::sleep_for(std::chrono::milliseconds(20));
    computeControlCaptureEnabled.store(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofStart(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofStop(MSPROF_CTRL_INIT_COMPUTE, &config, sizeof(config)));
    computeControlCaptureEnabled.store(false);
    EXPECT_EQ(1U, computeStartCallbackCount.load());
    EXPECT_EQ(1U, computeStopCallbackCount.load());
    EXPECT_FALSE(HasComputeResultDir(aclProfPath));
}

void RunComputeProfilingWithInitHook(const std::string& aclProfPath, uint32_t blockMode = 0)
{
    ResetComputeInjectionStState();
    RegisterComputeSetGetHooks();
    EXPECT_EQ(PROFILING_SUCCESS, MsprofSetInjectionFunc(PROF_HOOK_INIT, reinterpret_cast<void*>(acltoolInitialize)));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    ExpectComputeInjectionInitialized();
    RunComputeProfilingStartStop(aclProfPath, blockMode);
}
} // namespace

extern "C" int32_t acltoolInitialize() { return RegisterCallbackFromAcltoolInitialize(); }
#endif

void ExpectSetConfigSuccess(aclprofConfigType configType, const std::string& setConfig)
{
    auto ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
}

void SetAclApiSuccessConfigs()
{
    ExpectSetConfigSuccess(ACL_PROF_STORAGE_LIMIT, "250MB");
    ExpectSetConfigSuccess(ACL_PROF_SYS_HARDWARE_MEM_FREQ, "10000");
    ExpectSetConfigSuccess(ACL_PROF_SYS_MEM_SERVICEFLOW, "aaa,bbb");
    ExpectSetConfigSuccess(ACL_PROF_LLC_MODE, "read");
    ExpectSetConfigSuccess(ACL_PROF_LLC_MODE, "write");
    ExpectSetConfigSuccess(ACL_PROF_SYS_IO_FREQ, "50");
    ExpectSetConfigSuccess(ACL_PROF_SYS_INTERCONNECTION_FREQ, "50");
    ExpectSetConfigSuccess(ACL_PROF_DVPP_FREQ, "50");
    ExpectSetConfigSuccess(ACL_PROF_HOST_SYS, "cpu,mem,network");
}

std::vector<std::string> GetAclApiSetConfigDeviceDataList()
{
    return {
        "npu_mem.data",
        "npu_module_mem.data",
        "hbm.data",
        "llc.data",
        "nic.data",
        "roce.data",
        "pcie.data",
        "hccs.data",
        "ub.data",
        "dvpp.data",
        "stars_soc_profile.data"};
}

std::vector<std::string> GetAclApiSetConfigHostDataList()
{
    return {
        "host_cpu.data", "host_mem.data", "host_network.data",
        /*, "host_disk.data", "host_pthreadcall.data", "host_syscall.data"*/};
}

class AclApiDavidStest : public testing::Test {
protected:
    std::string aclProfPath;
    uint32_t devId;
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        devId = 0;
        static uint32_t randomCount = 1;
        int32_t random_number = std::rand() % 100 + randomCount;
        aclProfPath = "api_test_david_output" + std::to_string(random_number);
        mkdir(aclProfPath.c_str(), 0750);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        SimulatorMgr().SetSocSide(SocType::HOST);
        ClearApiSingleton();
        ProfAPI::ProfCannPlugin::instance()->ProfResetInjectionState();
        aclInit(nullptr);
        aclrtSetDevice(0);
        EXPECT_EQ(ACL_ERROR_NONE, aclprofInit(aclProfPath.c_str(), aclProfPath.size()));
        randomCount++;
    }
    virtual void TearDown()
    {
        unsetenv("ACL_API_INJECTION");
        ProfAPI::ProfCannPlugin::instance()->ProfResetInjectionState();
        aclprofFinalize();
        aclFinalize();
        DevprofDrvAicpu::instance()->isRegister_ = false; // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        aclProfPath.insert(0, "rm -rf ");
        system(aclProfPath.c_str());
        DataMgr().UnInit();
        GlobalMockObject::verify();
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

#ifndef ascend031
TEST_F(AclApiDavidStest, ComputeProfilingApiInitHookEndToEnd) { RunComputeProfilingWithInitHook(aclProfPath); }

TEST_F(AclApiDavidStest, ComputeProfilingAclApiInjectionEndToEnd)
{
    ResetComputeInjectionStState();
    EXPECT_EQ(0, setenv("ACL_API_INJECTION", ACL_API_INJECTION_STUB, 1));
    RegisterComputeSetGetHooks();
    EXPECT_EQ(PROFILING_SUCCESS, MsprofInjectionInitialize());
    ExpectComputeInjectionInitialized();
    RunComputeProfilingStartStop(aclProfPath);
}

TEST_F(AclApiDavidStest, ComputeProfilingAllBlockEndToEnd)
{
    RunComputeProfilingWithInitHook(aclProfPath, PROF_COMPUTE_ALL_BLOCK);
}

TEST_F(AclApiDavidStest, ComputeProfilingBlockShinkEndToEnd)
{
    RunComputeProfilingWithInitHook(aclProfPath, PROF_COMPUTE_BLOCK_SHRINK);
}
#endif

TEST_F(AclApiDavidStest, AclApiDefault)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_L2CACHE | ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX |
                              ACL_PROF_RUNTIME_API | ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 | ACL_PROF_TASK_MEMORY |
                              ACL_PROF_GE_API_L1 | ACL_PROF_TASK_TIME_L2;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));

    std::vector<std::string> deviceDataList = {
        "stars_soc.data", "ffts_profile.data", "ccu0.instr", "ccu1.instr", "socpmu.data"};
    std::vector<std::string> hostDataList = {"aging.additional.msproftx"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, hostDataList));
}

TEST_F(AclApiDavidStest, AclApiCcuStatUb0)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    aclprofConfigType configType = ACL_PROF_SYS_INTERCONNECTION_FREQ;
    std::string setConfig = "1";
    auto ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);

    setConfig = "0.1";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    configType = ACL_PROF_LOW_POWER_FREQ;
    setConfig = "100";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, 0));

    std::vector<std::string> deviceDataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, {}));
}

TEST_F(AclApiDavidStest, AclApiCcuStatUb1)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    aclprofConfigType configType = ACL_PROF_SYS_INTERCONNECTION_FREQ;
    std::string setConfig("50");
    auto ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);

    setConfig = "81";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, 0));

    std::vector<std::string> deviceDataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, {}));
}

TEST_F(AclApiDavidStest, AclApiSetConfigError)
{
    aclprofConfigType configType = ACL_PROF_LOW_POWER_FREQ;
    std::string setConfig = "0";
    int32_t ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    setConfig = "101";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
    setConfig = "10001";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    configType = ACL_PROF_SYS_CPU_FREQ;
    setConfig = "50";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    configType = ACL_PROF_OPTYPE;
    setConfig = "MatMulV3,Index";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    aclprofFinalize();
    aclFinalize();
}

TEST_F(AclApiDavidStest, AclApiSetConfig)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    SetAclApiSuccessConfigs();
    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, 0));
    EXPECT_EQ(0, CheckFiles(aclProfPath, GetAclApiSetConfigDeviceDataList(), GetAclApiSetConfigHostDataList()));
}

TEST_F(AclApiDavidStest, AclApiWithSetDeviceBehind)
{
    aclrtResetDevice(0);
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX | ACL_PROF_RUNTIME_API |
                              ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 | ACL_PROF_TASK_MEMORY | ACL_PROF_GE_API_L1 |
                              ACL_PROF_TASK_TIME_L2;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStartWithSetDeviceBehind(config, dataTypeConfig));

    std::vector<std::string> deviceDataList = {"stars_soc.data", "ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    std::vector<std::string> hostDataList = {"aging.additional.msproftx"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, hostDataList));
}

TEST_F(AclApiDavidStest, AclApiL3)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_L2CACHE | ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX |
                              ACL_PROF_RUNTIME_API | ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 | ACL_PROF_TASK_MEMORY |
                              ACL_PROF_GE_API_L1 | ACL_PROF_TASK_TIME_L2 | ACL_PROF_TASK_TIME_L3;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    // david now supports task-time L3 (PLATFORM_TASK_TRACE_L3), so start succeeds. AclApiStart
    // already destroys the config and finalizes on its success path, so no extra cleanup here.
    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));

    std::vector<std::string> deviceDataList = {"stars_soc.data", "ffts_profile.data"};
    std::vector<std::string> hostDataList = {"aging.additional.msproftx"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, hostDataList));
}
