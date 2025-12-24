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
#include "data_manager.h"
#include "errno/error_code.h"
#include "device_simulator_manager.h"
#include "acl_api_stub.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

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
        int32_t random_number = std::rand() % 100 + 1;
        aclProfPath = "api_test_david_output" + std::to_string(random_number);;
        mkdir(aclProfPath.c_str(), 0750);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        SimulatorMgr().SetSocSide(SocType::HOST);
        ClearApiSingleton();
        aclInit(nullptr);
        aclrtSetDevice(0);
        EXPECT_EQ(ACL_ERROR_NONE, aclprofInit(aclProfPath.c_str(), aclProfPath.size()));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
    }
    virtual void TearDown()
    {
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
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

TEST_F(AclApiDavidStest, AclApiDefault)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_L2CACHE | ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX |
                              ACL_PROF_RUNTIME_API | ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 |
                              ACL_PROF_TASK_MEMORY | ACL_PROF_GE_API_L1 | ACL_PROF_TASK_TIME_L2;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));

    std::vector<std::string> deviceDataList = {"stars_soc.data", "ffts_profile.data", "ccu0.instr", "ccu1.instr", "socpmu.data"};
    std::vector<std::string> hostDataList = {"aging.additional.msproftx"};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, hostDataList));
}

TEST_F(AclApiDavidStest, AclApiCcuStatUb0)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;
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
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;
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

    configType = ACL_PROF_SCALE;
    setConfig = "opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,aclnnIndex_IndexAiCore_Index";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PROFILING_CONFIG, ret);

    aclprofFinalize();
    aclFinalize();
}

TEST_F(AclApiDavidStest, AclApiSetConfig)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);
 
    aclprofConfigType configType = ACL_PROF_STORAGE_LIMIT;
    std::string setConfig("250MB");
    auto ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
    setConfig = "10000";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_SYS_MEM_SERVICEFLOW;
    setConfig = "aaa,bbb";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_LLC_MODE;
    setConfig = "read";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
    setConfig = "write";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_SYS_IO_FREQ;
    setConfig = "50";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_SYS_INTERCONNECTION_FREQ;
    setConfig = "50";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    configType = ACL_PROF_DVPP_FREQ;
    setConfig = "50";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);

    configType = ACL_PROF_HOST_SYS;
    setConfig = "cpu,mem,network";
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);
 
    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, 0));
 
    std::vector<std::string> deviceDataList = {"npu_mem.data", "npu_module_mem.data", "hbm.data", "llc.data", "nic.data", "roce.data", "pcie.data", "hccs.data", "ub.data", "dvpp.data", "stars_soc_profile.data"};
    std::vector<std::string> hostDataList = {"host_cpu.data", "host_mem.data", "host_network.data",/*, "host_disk.data", "host_pthreadcall.data", "host_syscall.data"*/};
    EXPECT_EQ(0, CheckFiles(aclProfPath, deviceDataList, hostDataList));
}

TEST_F(AclApiDavidStest, AclApiWithSetDeviceBehind)
{
    aclrtResetDevice(0);
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX |
                              ACL_PROF_RUNTIME_API | ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 |
                              ACL_PROF_TASK_MEMORY | ACL_PROF_GE_API_L1 | ACL_PROF_TASK_TIME_L2;
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
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU |
                              ACL_PROF_L2CACHE | ACL_PROF_HCCL_TRACE | ACL_PROF_TRAINING_TRACE | ACL_PROF_MSPROFTX |
                              ACL_PROF_RUNTIME_API | ACL_PROF_GE_API_L0 | ACL_PROF_TASK_TIME_L0 |
                              ACL_PROF_TASK_MEMORY | ACL_PROF_GE_API_L1 | ACL_PROF_TASK_TIME_L2 | ACL_PROF_TASK_TIME_L3;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_NE(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));
    aclprofDestroyConfig(config);
    aclprofFinalize();
    aclFinalize();
}