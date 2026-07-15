/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <new>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "npu_driver.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "engine.hpp"
#include "raw_device.hpp"
#include "platform/platform_info.h"
#include "soc_info.h"
#include "thread_local_container.hpp"
#include "runtime_exit_test_helper.h"
#include "common/rt_utest_context_reset_helper.hpp"

#undef private

using namespace testing;
using namespace cce::runtime;
#define PROF_AICPU_MODEL_MASK            0x4000000000000000ULL
#define PROF_AICPU_TRACE_MASK            0x00000008ULL
#define PROF_TASK_TIME_MASK              0x00000002ULL
#define PROF_AICORE_METRICS              0x00000004ULL

class RuntimeTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
    }
};

TEST_F(RuntimeTest, binanry_reg_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest, binary_reg_max)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    uint32_t old = Runtime::maxProgramNum_;
    Runtime::maxProgramNum_ = 0U;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_USEOUT);
    Runtime::maxProgramNum_ = old;
}

TEST_F(RuntimeTest, binanry_reg_cube_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_ELF_AICUBE;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);

    bin.magic = RT_DEV_BINARY_MAGIC_ELF_AIVEC;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);
}

using ConstructFunc = Runtime *(*)();
using DesConstructFunc = void (*)(Runtime *);
using PrepareProcessExitFunc = void (*)(Runtime *);
using NothrowNewFunc = void *(*)(size_t, const std::nothrow_t &);

static void *NothrowNewFailStub(size_t size, const std::nothrow_t &tag)
{
    UNUSED(size);
    UNUSED(tag);
    return nullptr;
}

TEST_F(RuntimeTest, BOOT_RUNTIME_TEST_ConstructRuntime)
{
    constexpr const int32_t flags = static_cast<int32_t>(static_cast<uint32_t>(MMPA_RTLD_NOW));
    void *const handlePtr = dlopen(NULL, flags);

    EXPECT_NE(handlePtr, nullptr);
    const ConstructFunc create = reinterpret_cast<ConstructFunc>(dlsym(handlePtr, "ConstructRuntimeImpl"));
    EXPECT_NE(create, nullptr);
    Runtime *rt = create();
    EXPECT_NE(rt, nullptr);

    const DesConstructFunc destruct = reinterpret_cast<DesConstructFunc>(dlsym(handlePtr, "DestructorRuntimeImpl"));
    EXPECT_NE(destruct, nullptr);
    destruct(rt);

    dlclose(handlePtr);
}

TEST_F(RuntimeTest, BOOT_RUNTIME_TEST_PrepareRuntimeProcessExitDoesNotDeleteRuntime)
{
    Runtime * const oldRuntime = Runtime::runtime_;
    Runtime *rt = ConstructRuntimeImpl();
    EXPECT_NE(rt, nullptr);

    rt->threadGuard_ = new(std::nothrow) ThreadGuard();
    ASSERT_NE(rt->threadGuard_, nullptr);
    rt->tsNum_ = 1U;
    Context * const sentinelContext = reinterpret_cast<Context *>(static_cast<uintptr_t>(0xDEADBEEFU));
    rt->priCtxs_[0][0].SetVal(sentinelContext);

    PrepareRuntimeProcessExitImpl(rt);

    EXPECT_TRUE(rt->IsExiting());
    EXPECT_EQ(rt->priCtxs_[0][0].GetVal(false), nullptr);
    EXPECT_NE(Runtime::runtime_, rt);

    // The process-exit entry must not delete Runtime. Clean up manually after proving the contract.
    DELETE_O(rt->threadGuard_);
    rt->isExiting_ = false;
    delete rt;
    Runtime::runtime_ = oldRuntime;
}

TEST_F(RuntimeTest, BootRuntime_CreateRuntimeFailed)
{
    static RuntimeKeeper keeper;
    MOCKER(static_cast<NothrowNewFunc>(&operator new)).expects(once()).will(invoke(NothrowNewFailStub));

    Runtime * const rt = keeper.BootRuntime();
    Runtime * const keeperRuntime = keeper.runtime_;
    const uint32_t bootStage = keeper.bootStage_.Value();
    GlobalMockObject::verify();

    EXPECT_EQ(rt, nullptr);
    EXPECT_EQ(keeperRuntime, nullptr);
    EXPECT_EQ(bootStage, RuntimeKeeper::BOOT_INIT);
}

TEST_F(RuntimeTest, BootRuntime_MsprofRegisterCallbackFailed)
{
    static RuntimeKeeper keeper;
    MOCKER(MsprofRegisterCallback).expects(once()).will(returnValue(RT_ERROR_INVALID_VALUE));

    Runtime * const rt = keeper.BootRuntime();
    Runtime * const keeperRuntime = keeper.runtime_;
    const uint32_t bootStage = keeper.bootStage_.Value();
    GlobalMockObject::verify();

    EXPECT_EQ(rt, nullptr);
    EXPECT_EQ(keeperRuntime, nullptr);
    EXPECT_EQ(bootStage, RuntimeKeeper::BOOT_INIT);
}

TEST_F(RuntimeTest, BootRuntimeReturnsNullWhenRuntimeKeeperExiting)
{
    static RuntimeKeeper keeper;
    MOCKER(IsRuntimeKeeperExiting).expects(once()).will(returnValue(true));

    Runtime * const rt = keeper.BootRuntime();
    const uint32_t bootStage = keeper.bootStage_.Value();
    GlobalMockObject::verify();

    EXPECT_EQ(rt, nullptr);
    EXPECT_EQ(bootStage, RuntimeKeeper::BOOT_INIT);
}

TEST_F(RuntimeTest, AicpuCntInitTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = rtInstance->GetSocVersion();
    rtInstance->SetSocVersion("AS31XM1X");
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetSocVersion("");
    error  = rtInstance->InitAiCpuCnt();

    rtInstance->SetSocVersion(socVersion);
}

TEST_F(RuntimeTest, CheckHaveDevice)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, true);

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));
    ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, false);
    rtInstance->InitChipTypeAndSocVersion();

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ret = rtInstance->CheckHaveDevice();
}

TEST_F(RuntimeTest, CheckHaveDeviceNotSupport)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, true);

    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, false);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ret = rtInstance->CheckHaveDevice();
}

TEST_F(RuntimeTest, ut_AllKernelRegister_GetKernelsCount_2)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[10];
    strcpy_s(name, 10, "a_200");
    RtKernel kernel = {name, 10, 10, {}};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest, ut_AllKernelRegister_GetKernelsCount_invalid01)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[10];
    strcpy_s(name, 10, "a200");
    RtKernel kernel = {name, 10, 10, {}};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest, ut_AllKernelRegister_GetKernelsCount_invalid02)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[100];
    strcpy_s(name, 100, "a_4444444444444444444444444444444444444444444444444444444444");
    RtKernel kernel = {name, 10, 10, {}};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest, ut_AllKernelRegister_GetKernelsCount_invalid03)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[3];
    strcpy_s(name, 3, "a_");
    RtKernel kernel = {name, 10, 10, {}};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest, ut_AllKernelRegister)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;
    void *code[] = {NULL, NULL, NULL, NULL};
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.version = 1;
    bin.data = code;
    bin.length = sizeof(code);

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInstance->AllKernelRegister(program);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest, ut_GetTilingKeyFromKernel)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string kernelName = "abc_mix_aic";
    uint8_t mixType = 0U;
    std::string ret;
    ret = rtInstance->GetTilingKeyFromKernel(kernelName, mixType);
    EXPECT_EQ(ret, "abc");
    std::string kernelName2 = "abc_mix_aiv";
    ret = rtInstance->GetTilingKeyFromKernel(kernelName2, mixType);
    EXPECT_EQ(ret, "abc");
    std::string kernelName3 = "abc_mix_aic_mix_aiv";
    ret = rtInstance->GetTilingKeyFromKernel(kernelName3, mixType);
    EXPECT_EQ(ret, "abc");
}

TEST_F(RuntimeTest, ut_GetTilingValue)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string kernelName = "@111";
    uint64_t tilingValue = 0U;
    rtError_t error = rtInstance->GetTilingValue(kernelName, tilingValue);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    std::string kernelName2 = "11111111111111111111111111111111111111111111111111";
    error = rtInstance->GetTilingValue(kernelName2, tilingValue);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    std::string kernelName3 = "200";
    error = rtInstance->GetTilingValue(kernelName3, tilingValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest, ut_GetProfDeviceNum)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    int32_t ret = rtInstance->GetProfDeviceNum(0xFFFFFFFFFFFFFFFFULL);
    bool result = (ret >= 0);
    EXPECT_EQ(result, true);
}

TEST_F(RuntimeTest, ut_OtherProfilerApiStartStopTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    uint64_t profConfig = 0xFFFFFFFFFFFFFFFFULL;
    uint32_t deviceList[2] = {0U, 1U};
    int32_t numsDev = 1;
    rtError_t ret = rtInstance->RuntimeApiProfilerStart(profConfig, numsDev, deviceList);
    ret = rtInstance->RuntimeApiProfilerStop(profConfig, numsDev, deviceList);

    // open all device
    uint32_t devNum = 2;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    ret = rtInstance->RuntimeApiProfilerStart(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtInstance->RuntimeApiProfilerStop(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtInstance->RuntimeProfileLogStart(profConfig, numsDev, deviceList);
    ret = rtInstance->RuntimeProfileLogStop(profConfig, numsDev, deviceList);

    uint64_t type = 0ULL;
    RawDevice *dev = new RawDevice(0);

    rtInstance->TsTimelineStart(profConfig, type, dev);
    rtInstance->TsTimelineStop(profConfig, type, dev);

    bool needOpenTimeline = true;
    rtInstance->TsTimelineStart(profConfig, needOpenTimeline, dev);
    rtInstance->TsTimelineStop(profConfig, needOpenTimeline, dev);

    rtInstance->AivMetricStart(profConfig, type, dev);
    rtInstance->AivMetricStop(profConfig, type, dev);

    rtInstance->AicMetricStart(profConfig, type, dev);
    rtInstance->AicMetricStop(profConfig, type, dev);

    rtInstance->AiCpuTraceStart(profConfig, type, dev);
    rtInstance->AiCpuTraceStop(profConfig, type, dev);

    rtInstance->HwtsLogStart(profConfig, type, dev);
    rtInstance->HwtsLogStop(profConfig, type, dev);

    type |= PROF_AICPU_MODEL_MASK | PROF_AICPU_TRACE_MASK;
    dev->SetDevProfStatus(type, true);
    rtInstance->AiCpuModelTraceStart(profConfig, type, dev);
    rtInstance->AiCpuModelTraceStop(profConfig, type, dev);
    Runtime::Instance()->isHaveDevice_ = false;
    ret = Runtime::Instance()->HandleAiCpuProfiling(profConfig, 0U, true);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Runtime::Instance()->isHaveDevice_ = true;
    ret = Runtime::Instance()->HandleAiCpuProfiling(profConfig, 0U, true);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    int32_t streamId = 1;
    uint32_t devId = 0U;
    uint32_t sqId = 0U;
    rtInstance->GetSqIdByStreamId(devId, streamId, &sqId);

    delete dev;
}

TEST_F(RuntimeTest, ut_AicMetricStart_MdcTs1Scenario)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(0);
    uint64_t profConfig = PROF_AICORE_METRICS;
    uint64_t type = 0ULL;
    uint32_t originalTsNum = rtInstance->tsNum_;

    rtInstance->tsNum_ = TS_NUM_ADC;
    (void)dev->DevSetTsId(1U);
    rtInstance->AicMetricStart(profConfig, type, dev);
    EXPECT_EQ(type, 0ULL);

    rtInstance->tsNum_ = originalTsNum;
    delete dev;
}

TEST_F(RuntimeTest, ut_AicMetricStop_MdcTs1Scenario)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(0);
    uint64_t profConfig = PROF_AICORE_METRICS;
    uint64_t type = 0ULL;
    uint32_t originalTsNum = rtInstance->tsNum_;

    rtInstance->tsNum_ = TS_NUM_ADC;
    (void)dev->DevSetTsId(1U);
    rtInstance->AicMetricStop(profConfig, type, dev);
    EXPECT_EQ(type, 0ULL);

    rtInstance->tsNum_ = originalTsNum;
    delete dev;
}

TEST_F(RuntimeTest, ut_LoadFunction)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtChipType_t chipType = rtInstance->chipType_;
    rtInstance->chipType_ = CHIP_DC;
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtInstance->chipType_ = CHIP_ADC;
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtInstance->GetSocVersionByHardwareVer(0x0502, 0, 0);
    rtInstance->chipType_ = CHIP_ADC;
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    rtInstance->chipType_ = CHIP_AS31XM1;
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    rtInstance->chipType_ = CHIP_610LITE;
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    rtInstance->chipType_ = CHIP_DAVID;
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    rtInstance->chipType_ = CHIP_DC;
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtInstance->chipType_ = CHIP_X90;
    GlobalContainer::SetRtChipType(CHIP_X90);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    rtInstance->chipType_ = CHIP_9030;
    GlobalContainer::SetRtChipType(CHIP_9030);
    rtInstance->GetSocVersionByHardwareVer(0x0506, 0, 0);
    uint32_t devId = rtInstance->workingDev_;
    rtInstance->workingDev_ = 10;
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtInstance->workingDev_ = 12;
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtInstance->workingDev_ = 329;
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtInstance->workingDev_ = 5525;
    rtInstance->GetSocVersionByHardwareVer(0x0500, 0, 0);
    rtInstance->workingDev_ = devId;
    rtInstance->chipType_ = chipType;
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(RuntimeTest, SocTypeByChipType)
{
    Runtime rt; // no init
    rt.SetChipType(static_cast<rtChipType_t>(PLAT_GET_CHIP(static_cast<uint64_t>(0x0800))));
    rt.GetSocVersionByHardwareVer(0x0800, 0, 0);
    EXPECT_NE(rt.GetSocVersion(), "");
}

extern "C" {
int TsdOpenExStub(uint32_t a, uint32_t b, uint32_t c)
{
    return 0;
}
int TsdOpenStub(uint32_t a, uint32_t b)
{
    return 0;
}
int TsdCloseStub(uint32_t a)
{
    return 0;
}
int UpdateProfilingModeStub(uint32_t a, uint32_t b)
{
    return 0;
}
int TsdSetMsprofReporterCallbackStub(void *ptr)
{
    return 0;
}
int TsdInitQsStub(uint32_t a, char* s)
{
    return 0;
}
int TsdSetAttrStub(char* s1, char* s2)
{
    return 0;
}
int TsdInitFlowGwStub(uint32_t a, void *info)
{
    return 0;
}
}

TEST_F(RuntimeTest, ut_GetHdcConctStatus01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->tsdGetHdcConctStatus_ = [](const uint32_t logicDeviceId, int32_t *hdcSessStat) -> TDT_StatusType {
        return 0;
    };
    int32_t hdcSessStat;
    rtError_t ret = rtInstance->GetHdcConctStatus(0, hdcSessStat);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeTest, ut_GetHdcConctStatus02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->tsdGetHdcConctStatus_ = [](const uint32_t logicDeviceId, int32_t *hdcSessStat) -> TDT_StatusType {
        return 10;
    };
    int32_t hdcSessStat;
    rtError_t ret = rtInstance->GetHdcConctStatus(0, hdcSessStat);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

void InitVisibleDevices()
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->userDeviceCnt = 0U;
    rtInstance->isSetVisibleDev = false;
    if (rtInstance->deviceInfo == nullptr) {
        rtInstance->deviceInfo = new (std::nothrow) uint32_t[RT_SET_DEVICE_STR_MAX_LEN];
    }
    (void)memset_s(rtInstance->deviceInfo, size_t(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN), MAX_UINT32_NUM,
        size_t(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN));
    (void)memset_s(rtInstance->inputDeviceStr, size_t(RT_SET_DEVICE_STR_MAX_LEN + 1U), 0U,
        size_t(RT_SET_DEVICE_STR_MAX_LEN + 1U));
    return;
}


TEST_F(RuntimeTest, ut_SetAndGetWatchDogDevStatus_01)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 65U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    RawDevice *dev = new RawDevice(devId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    delete dev;
}

TEST_F(RuntimeTest, ut_SetAndGetWatchDogDevStatus_02)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    uint32_t tsId = 3U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    RawDevice *dev = new RawDevice(devId);
    dev->DevSetTsId(tsId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(RuntimeTest, ut_SetAndGetWatchDogDevStatus_03)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_ABNORMAL;
    RawDevice *dev = new RawDevice(devId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceStatus, RT_DEVICE_STATUS_ABNORMAL);
    delete dev;
}

TEST_F(RuntimeTest, ut_SetAndGetWatchDogDevStatus_04)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    uint32_t tsId = 1U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_ABNORMAL;
    RawDevice *dev = new RawDevice(devId);
    dev->DevSetTsId(tsId);
    for (uint32_t i = 0; i < 2; i++) {
        ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        usleep(100000);
    }
    delete dev;
}

TEST_F(RuntimeTest, ExitDetachPrimaryContextsDoesNotDereferenceContext)
{
    Runtime * const runtimeInstance = static_cast<Runtime *>(Runtime::Instance());
    RuntimeExitStateGuard guard(runtimeInstance, false);
    ut::ForceResetPrimaryDeviceIfActive();

    Runtime runtime;
    runtime.tsNum_ = 1U;
    Context * const sentinelContext = reinterpret_cast<Context *>(static_cast<uintptr_t>(0xDEADBEEFU));
    runtime.priCtxs_[0][0].SetVal(sentinelContext);

    runtime.PrepareProcessExitNoThrow();

    EXPECT_EQ(runtime.priCtxs_[0][0].GetVal(false), nullptr);
}

TEST_F(RuntimeTest, RuntimeDestructorDoesNotTeardownOrDeleteContextOnExit)
{
    {
        Runtime runtime;
        runtime.tsNum_ = 1U;
        runtime.threadGuard_ = new(std::nothrow) ThreadGuard();
        ASSERT_NE(runtime.threadGuard_, nullptr);
        Context * const sentinelContext = reinterpret_cast<Context *>(static_cast<uintptr_t>(0xDEADBEEFU));
        runtime.priCtxs_[0][0].SetVal(sentinelContext);
    }

    SUCCEED();
}

TEST_F(RuntimeTest, UninitializedRuntimeDestructorDoesNotMarkGlobalRuntimeExiting)
{
    Runtime * const runtimeInstance = static_cast<Runtime *>(Runtime::Instance());
    RuntimeExitStateGuard guard(runtimeInstance, false);

    {
        Runtime runtime;
    }

    EXPECT_FALSE(runtimeInstance->IsExiting());
}

TEST_F(RuntimeTest, RuntimeDestructorDoesNotDlcloseTsdClientOnExit)
{
    MOCKER(mmDlclose).expects(never());
    {
        Runtime runtime;
        uintptr_t tsdClientHandle = 0x1234U;
        runtime.tsdClientHandle_ = reinterpret_cast<void *>(tsdClientHandle);
    }
}

TEST_F(RuntimeTest, PrepareProcessExitNoThrowDetachesReferencesWithoutDeletingRuntimeRegistries)
{
    Runtime * const runtimeInstance = static_cast<Runtime *>(Runtime::Instance());
    RuntimeExitStateGuard guard(runtimeInstance, false);

    Runtime * const runtime = new Runtime();
    runtime->threadGuard_ = new(std::nothrow) ThreadGuard();
    ASSERT_NE(runtime->threadGuard_, nullptr);
    ASSERT_EQ(runtime->InitProgramAllocator(), RT_ERROR_NONE);
    ObjAllocator<RefObject<Program *>> * const programAllocator = runtime->programAllocator_;
    ASSERT_NE(programAllocator, nullptr);

    Context * const sentinelContext = reinterpret_cast<Context *>(static_cast<uintptr_t>(0xDEADBEEFU));
    Program * const sentinelProgram = reinterpret_cast<Program *>(static_cast<uintptr_t>(0xBADC0DEU));
    runtime->tsNum_ = 1U;
    runtime->priCtxs_[0][0].SetVal(sentinelContext);
    RefObject<Program *> * const programItem = programAllocator->GetDataToItem(0U);
    ASSERT_NE(programItem, nullptr);
    ASSERT_TRUE(programItem->TryIncAndSet(sentinelProgram));

    RawDevice * const dev = new RawDevice(0U);
    dev->DevSetTsId(0U);
    ExitMockEngine * const engine = new ExitMockEngine(dev);
    dev->engine_ = engine;
    runtime->devices_[0U][0U].SetVal(dev);

    runtime->PrepareProcessExitNoThrow();

    EXPECT_TRUE(runtime->IsExiting());
    EXPECT_EQ(runtime->priCtxs_[0][0].GetVal(false), nullptr);
    EXPECT_EQ(programItem->GetVal(false), nullptr);
    EXPECT_EQ(runtime->programAllocator_, programAllocator);
    EXPECT_TRUE(dev->IsDeviceRelease());
    EXPECT_EQ(engine->stopCalled_, 1U);
    EXPECT_EQ(runtime->devices_[0U][0U].GetVal(false), nullptr);

    DELETE_O(runtime->threadGuard_);
    runtime->programAllocator_ = nullptr;
    DELETE_O(dev->engine_);
    delete dev;
    delete runtime;
}

TEST_F(RuntimeTest, StopDeviceHostThreadsOnExitStopsHostThreadsAndDetachesDevice)
{
    Runtime * const runtimeInstance = static_cast<Runtime *>(Runtime::Instance());
    // This test targets the process-exit prepare path, not Runtime::~Runtime(). Keep the temporary Runtime isolated
    // from the process-global Runtime and intentionally do not delete it; destructor behavior is covered separately.
    Runtime * const runtime = new Runtime();
    RawDevice * const dev = new RawDevice(0U);
    dev->DevSetTsId(0U);
    ExitMockEngine * const engine = new ExitMockEngine(dev);
    dev->engine_ = engine;
    runtime->devices_[0U][0U].SetVal(dev);

    RuntimeExitStateGuard guard(runtimeInstance, true);
    runtime->PrepareProcessExitNoThrow();

    EXPECT_TRUE(dev->IsDeviceRelease());
    EXPECT_EQ(engine->stopCalled_, 1U);
    EXPECT_EQ(engine->checkSendCalled_, 0U);
    EXPECT_EQ(engine->checkReceiveCalled_, 0U);
    EXPECT_EQ(engine->checkMonitorCalled_, 0U);
    EXPECT_EQ(runtime->devices_[0U][0U].GetVal(false), nullptr);
    DELETE_O(dev->engine_);
    delete dev;
}

TEST_F(RuntimeTest, DeviceReleaseOnExitUsesHostOnlyFinalize)
{
    Runtime * const runtimeInstance = static_cast<Runtime *>(Runtime::Instance());
    // Keep the temporary Runtime alive until process exit to avoid exercising Runtime::~Runtime() in this helper test.
    Runtime * const runtime = new Runtime();
    RawDevice * const dev = new RawDevice(0U);
    dev->DevSetTsId(0U);
    dev->devProfStatus_ = PROF_AICPU_MODEL_MASK;
    ExitMockEngine * const engine = new ExitMockEngine(dev);
    dev->engine_ = engine;
    ASSERT_TRUE(runtime->devices_[0U][0U].TryIncAndSet(dev));
    // This case targets DeviceRelease() under exit state; destructor entry is covered by dedicated Runtime tests.
    runtime->isExiting_ = true;

    RuntimeExitStateGuard guard(runtimeInstance, true);
    runtime->DeviceRelease(dev);

    EXPECT_TRUE(dev->IsDeviceRelease());
    EXPECT_EQ(dev->GetDevProfStatus(), 0ULL);
    EXPECT_EQ(engine->stopCalled_, 1U);
    EXPECT_EQ(engine->checkSendCalled_, 0U);
    EXPECT_EQ(engine->checkReceiveCalled_, 0U);
    EXPECT_EQ(engine->checkMonitorCalled_, 0U);
    EXPECT_EQ(runtime->devices_[0U][0U].GetVal(false), nullptr);
    EXPECT_EQ(runtime->devices_[0U][0U].GetRef(), 0ULL);
    DELETE_O(dev->engine_);
    delete dev;
}

TEST_F(RuntimeTest, SetTimeoutConfig_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string oldSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetSocVersion("AS31XM1X");
    bool oldflag1 = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
    bool oldflag2 = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
    rtError_t ret = rtInstance->SetTimeoutConfig(RT_TIMEOUT_TYPE_OP_WAIT, 60, RT_TIME_UNIT_TYPE_S);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtInstance->SetSocVersion(oldSocVersion);
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = oldflag1;
    rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = oldflag2;
}

TEST_F(RuntimeTest, RuntimeGetEnvPath_test1)
{
    std::string binaryPath;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t * const getPath = "/usr/local/Ascend/CANN-7.0/fwkacllib/lib64/";
    MOCKER(getenv).stubs().will(returnValue(getPath));
    rtError_t ret = rtInstance->GetEnvPath(binaryPath);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest, RuntimeGetEnvPath_test2)
{
    std::string binaryPath;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t * const getPath1 = "/usr/local/HiAI/latest/runtime/lib64:/usr/local/Ascend/CANN-7.0/fwkacllib/lib64:";
    MOCKER(getenv).stubs().will(returnValue(getPath1));
    rtError_t ret = rtInstance->GetEnvPath(binaryPath);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest, RuntimeGetKernelBinTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t *envValue = ":fwkacllib/lib64:";
    MOCKER(getenv).stubs().will(returnValue(envValue));
    char_t *buffer = nullptr;
    uint32_t length;
    char_t *soName = "name";
    rtError_t ret = rtInstance->GetKernelBin(soName, &buffer, &length);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest, GetKernelBin_Success)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    static char envPath[] = "/usr/lib:/tmp/rt_fwkacllib/lib64:/usr/local/lib";
    system("mkdir -p /tmp/rt_fwkacllib/lib64");
    std::ofstream ofs("/tmp/rt_fwkacllib/lib64/test.bin", std::ios::binary);
    ofs << "test";
    ofs.close();
    MOCKER(getenv).stubs().will(returnValue(static_cast<char*>(envPath)));
    char_t *buffer = nullptr;
    uint32_t length = 0;
    rtError_t ret = rtInstance->GetKernelBin("test.bin", &buffer, &length);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(buffer, nullptr);
    if (buffer != nullptr) {
        rtInstance->FreeKernelBin(buffer);
    }
    unlink("/tmp/rt_fwkacllib/lib64/test.bin");
    unlink("/tmp/rt_fwkacllib/lib64");
    unlink("/tmp/rt_fwkacllib");
}

TEST_F(RuntimeTest, GetKernelBinByFileName_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t *binFileName = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    char_t *buffer = nullptr;
    uint64_t length;
    rtError_t ret = rtInstance->GetKernelBinByFileName(binFileName, &buffer, &length);
    ret = rtInstance->FreeKernelBin(buffer);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest, feature_version_1)
{
    FeatureToTsVersionInit();
    bool result = CheckFeatureIsSupportOld(16, static_cast<rtFeature>(10));
    EXPECT_EQ(result, false);

    uint32_t tschVersion = ((uint32_t)TS_BRANCH_V1R1C13 << 16) | 18;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C30 << 16) | 17;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C15 << 16) | 22;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_TRUNK << 16) | 22;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_TRUNK << 16) | 18;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, false);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C17 << 16) | 26;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC));
    EXPECT_EQ(result, true);
}

TEST_F(RuntimeTest, GetElfOffset_NullElfData)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t offset = 0;
    EXPECT_EQ(rtInstance->GetElfOffset(nullptr, 0, &offset), RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest, GetElfOffset_NullOffset)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t elfData = 0;
    EXPECT_EQ(rtInstance->GetElfOffset(&elfData, 4, nullptr), RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest, SetWatchDogDevStatus_NullDevice)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->SetWatchDogDevStatus(nullptr, RT_DEVICE_STATUS_ABNORMAL), RT_ERROR_DEVICE_NULL);
}

TEST_F(RuntimeTest, LookupAddrByFun_KernelNotFound)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int dummyStub = 0;
    void *addr = nullptr;
    EXPECT_EQ(rtInstance->LookupAddrByFun(&dummyStub, nullptr, &addr), RT_ERROR_KERNEL_LOOKUP);
}

TEST_F(RuntimeTest, LookupAddrAndPrefCntWithHandle_KernelNotFound)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    void *addr = nullptr;
    uint32_t prefetchCnt = 0;
    EXPECT_EQ(rtInstance->LookupAddrAndPrefCntWithHandle(nullptr, "nonexistent_kernel", nullptr, &addr, &prefetchCnt),
              RT_ERROR_KERNEL_LOOKUP);
}

TEST_F(RuntimeTest, GetPriCtxByDeviceId_InvalidDevId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->GetPriCtxByDeviceId(RT_MAX_DEV_NUM + 1, 0), nullptr);
}

TEST_F(RuntimeTest, GetPriCtxByDeviceId_InvalidTsId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->GetPriCtxByDeviceId(0, RT_MAX_TS_ID + 1), nullptr);
}

TEST_F(RuntimeTest, GetRefPriCtx_InvalidDevId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->GetRefPriCtx(RT_MAX_DEV_NUM + 1, 0), nullptr);
}

TEST_F(RuntimeTest, GetRefPriCtx_InvalidTsId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->GetRefPriCtx(0, RT_MAX_TS_ID + 1), nullptr);
}

TEST_F(RuntimeTest, PrimaryContextRetain_InvalidDevId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->PrimaryContextRetain(RT_MAX_DEV_NUM + 1), nullptr);
}

// 等价性验证：PrimaryContextRelease 入参校验早退分支（devId 越界 -> RT_ERROR_DEVICE_ID）。
TEST_F(RuntimeTest, PrimaryContextRelease_InvalidDevId)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->PrimaryContextRelease(RT_MAX_DEV_NUM + 1), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(rtInstance->PrimaryContextRelease(RT_MAX_DEV_NUM + 1, true), RT_ERROR_DEVICE_ID);
}

// 等价性验证：多次 retain 后单次 non-force release，引用计数未归零，
// 决策返回 kSkip 但 ret=true，PrimaryContextRelease 应返回 RT_ERROR_NONE 且 primary context 不被 teardown。
// 本用例对 fixture 引用计数保持平衡（额外 retain 1 次、release 1 次）。
TEST_F(RuntimeTest, PrimaryContextRelease_MultiRetainKeepsPrimaryAlive)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t devId = 0;
    EXPECT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);

    RefObject<Context *> *refObject = rtInstance->PrimaryContextRetain(static_cast<uint32_t>(devId));
    ASSERT_NE(refObject, nullptr);
    Context *ctxBefore = refObject->GetVal();
    EXPECT_NE(ctxBefore, nullptr);

    // 引用计数仍 > 0，不触发 teardown，返回 RT_ERROR_NONE。
    EXPECT_EQ(rtInstance->PrimaryContextRelease(static_cast<uint32_t>(devId)), RT_ERROR_NONE);

    // primary context 仍存活，未被释放，指针保持不变。
    Context *ctxAfter = refObject->GetVal();
    EXPECT_EQ(ctxAfter, ctxBefore);
}

TEST_F(RuntimeTest, FreeAiCpuStreamId_Invalid)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int64_t oldCnt = rtInstance->GetAicpuCnt();
    rtInstance->SetAicpuCnt(16);
    rtInstance->FreeAiCpuStreamId(0);
    rtInstance->SetAicpuCnt(oldCnt);
}

TEST_F(RuntimeTest, GetKernelBinByFileName_EmptyFile)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string emptyFile = "/tmp/rt_utest_empty_bin.o";
    std::ofstream ofs(emptyFile, std::ios::binary);
    ofs.close();

    char_t *buffer = nullptr;
    uint64_t length = 0;
    EXPECT_EQ(rtInstance->GetKernelBinByFileName(emptyFile.c_str(), &buffer, &length), RT_ERROR_INVALID_VALUE);
    std::remove(emptyFile.c_str());
}

TEST_F(RuntimeTest, LookupAddrAndPrefCnt_NoProgram)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    PlainProgram prog(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel kernel("test", 0ULL, &prog, RT_KERNEL_ATTR_TYPE_AICPU, 0);
    kernel.program_ = nullptr;
    rtKernelDetailInfo_t info = {};
    EXPECT_EQ(rtInstance->LookupAddrAndPrefCnt(&kernel, nullptr, &info), RT_ERROR_KERNEL_LOOKUP);
}

TEST_F(RuntimeTest, LookupAddrAndPrefCnt_NoProgram_Overload2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    PlainProgram prog(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel kernel("test", 0ULL, &prog, RT_KERNEL_ATTR_TYPE_AICPU, 0);
    kernel.program_ = nullptr;
    void *addr = nullptr;
    uint32_t prefetchCnt = 0;
    EXPECT_EQ(rtInstance->LookupAddrAndPrefCnt(&kernel, nullptr, &addr, &prefetchCnt), RT_ERROR_KERNEL_LOOKUP);
}

TEST_F(RuntimeTest, InitSocVersionAndChipType_HalGetSocVersionFail)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER(halGetSocVersion).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_NE(rtInstance->InitSocVersionAndChipType(0), RT_ERROR_NONE);
}

TEST_F(RuntimeTest, InitSocVersionAndChipType_HalGetDeviceInfoFail)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER(halGetSocVersion).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_NE(rtInstance->InitSocVersionAndChipType(0), RT_ERROR_NONE);
}

TEST_F(RuntimeTest, LookupAddrAndPrefCnt_NoModule)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Context *ctx = rtInstance->GetPriCtxByDeviceId(0, 0);
    ASSERT_NE(ctx, nullptr);

    PlainProgram *prog = new PlainProgram(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel *kernel = new Kernel("test", 0ULL, prog, RT_KERNEL_ATTR_TYPE_AICPU, 0);

    rtKernelDetailInfo_t info = {};
    rtError_t ret = rtInstance->LookupAddrAndPrefCnt(kernel, ctx, &info);
    EXPECT_EQ(ret, RT_ERROR_KERNEL_LOOKUP);

    delete kernel;
    delete prog;
}

TEST_F(RuntimeTest, InitSocVersionAndChipType_HalGetDeviceInfoFail2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER(halGetSocVersion).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER(halGetDeviceInfo).stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_NE(rtInstance->InitSocVersionAndChipType(0), RT_ERROR_NONE);
}

TEST_F(RuntimeTest, InitAicpuFlowGw_NoDevice)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldHaveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = false;
    EXPECT_EQ(rtInstance->InitAicpuFlowGw(0, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    rtInstance->isHaveDevice_ = oldHaveDevice;
}

TEST_F(RuntimeTest, MallocProgramAndReg_InvalidMagic)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtDevBinary_t bin = {};
    bin.magic = 0xDEADBEEF;
    bin.version = 1;
    bin.data = nullptr;
    bin.length = 0;
    Program *prog = nullptr;
    EXPECT_EQ(rtInstance->MallocProgramAndReg(&bin, &prog), RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest, SetAicpuAttr_TsdError)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto oldFunc = rtInstance->tsdSetAttr_;
    rtInstance->tsdSetAttr_ = [](const char_t *, const char_t *) { return static_cast<TDT_StatusType>(1); };
    EXPECT_EQ(rtInstance->SetAicpuAttr("key", "val"), RT_ERROR_DRV_TSD_ERR);
    rtInstance->tsdSetAttr_ = oldFunc;
}

TEST_F(RuntimeTest, ProfilerStop_ConfigMismatch)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool oldMode = rtInstance->profileLogModeEnable_;
    rtInstance->profileLogModeEnable_ = true;
    EXPECT_EQ(rtInstance->ProfilerStop(0, 0, nullptr, 0), RT_ERROR_PROF_STATUS);
    rtInstance->profileLogModeEnable_ = oldMode;
}

class RuntimeTest2 : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        ut::ForceResetPrimaryDeviceIfActive();
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(RuntimeTest2, reset_device_forece_01)
{
    uint32_t devNum = 8;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    // 设置可用device
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,2,3", 20);
    InitVisibleDevices();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceResetForce(0), RT_ERROR_NONE);
    InitVisibleDevices();
}

TEST_F(RuntimeTest2, set_default_device_id)
{
    uint32_t devNum = 8;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    // 设置可用device
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,2,3", 20);
    InitVisibleDevices();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    EXPECT_EQ(rtSetDefaultDeviceId(0), RT_ERROR_NONE);
    rtStream_t desStm;
    auto error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitVisibleDevices();
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest2, PrimaryXpuContextRelease)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_EQ(rtInstance->PrimaryXpuContextRelease(0), RT_ERROR_NONE);
}

TEST_F(RuntimeTest2, XpuDeviceRelease)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->XpuDeviceRelease(nullptr);
    EXPECT_TRUE(true);
}

TEST_F(RuntimeTest, ut_AllKernelRegister_mix_aiv)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[20];
    strcpy_s(name, 20, "abc_123_mix_aiv");
    RtKernel kernel = {name, 10, 10, {}};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}
