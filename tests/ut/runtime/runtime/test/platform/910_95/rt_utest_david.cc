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
#include "securec.h"
#define protected public
#define private public
#include "task.hpp"
#include "uma_arg_loader.hpp"
#include "task_res.hpp"
#include "task_submit.hpp"
#include "rdma_task.h"
#include "base.hpp"
#include "stars_david.hpp"
#include "task_res_da.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "event_david.hpp"
#include "context.hpp"
#include "profiler.hpp"
#include "runtime.hpp"
#include "uma_arg_loader.hpp"
#include "stars_cond_isa_define.hpp"
#include "thread_local_container.hpp"
#include "api_impl.hpp"
#include "raw_device.hpp"
#include "device/device_error_proc.hpp"
#include "stars_engine.hpp"
#include "config_define.hpp"
#include "api_impl_david.hpp"
#include "task_recycle.hpp"
#include "stream_david.hpp"
#include "subscribe.hpp"
#include "task_david.hpp"
#include "model_c.hpp"
#include "device_error_proc_c.hpp"
#include "arg_manage_david.hpp"
#include "stream_c.hpp"
#include "driver.hpp"
#include "kernel.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
}  // namespace

static bool g_disableThread;
static rtChipType_t g_chipType;
extern int64_t g_device_driver_version_stub;
#define PLATFORMCONFIG_NO_DEVICE                                                              \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_NO_DEVICE)), \
                 (static_cast<uint32_t>(RT_VER_NA)))

rtLogicCqReport_t g_cqReport1;
static rtError_t Sub_LogicCqReportV2(NpuDriver *drv, const LogicCqWaitInfo &waitInfo, uint8_t *report,
                                     uint32_t reportCnt, uint32_t &realCnt)
{
    realCnt = 1;
    rtLogicCqReport_t *reportPtr = reinterpret_cast<rtLogicCqReport_t *>(report);
    g_cqReport1.taskId = 1U;
    *reportPtr = g_cqReport1;

    return RT_ERROR_NONE;
}

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_910_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

static rtError_t stubGetHardVerBySocVerFail(const uint32_t deviceId, int64_t &hardwareVersion)
{
    return RT_ERROR_DRV_INPUT;
}

rtError_t stubGetHardVerBySocVerNoDevice(const uint32_t deviceId, int64_t &hardwareVersion)
{
    hardwareVersion = PLATFORMCONFIG_NO_DEVICE;
    return DRV_ERROR_NONE;
}

static drvError_t stubDavidGetConnectUbFlagFail(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_910_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_HD_CONNECT_TYPE) {
            *value = 2;
            return DRV_ERROR_INVALID_VALUE;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

static drvError_t stubSolomonGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_ASCEND_910_5591;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

class DavidTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_DAVID_910_9599);
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(Sub_LogicCqReportV2));
        rtStreamCreate(&streamHandle_, 0);
        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        stream_->Context_()->DefaultStream_()->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;

        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    Stream *stream_ = nullptr;
    Device *dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
};

class DavidTaskTest1 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_DAVID_910_9599);
        rtStreamCreate(&streamHandle_, 0);
        stream_ = (Stream *)streamHandle_;
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    Stream *stream_ = nullptr;
    Device *dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
};

class DavidTaskTest2 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_DAVID_910_9599);
        rtStreamCreate(&streamHandle_, 0);
        stream_ = (Stream *)streamHandle_;
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtStreamDestroy(streamHandle_);
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(g_disableThread);
        GlobalMockObject::verify();
    }

protected:
    Stream *stream_ = nullptr;
    Device *dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
};

class DavidTaskErrTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetConnectUbFlagFail));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_DAVID_910_9599);
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(Sub_LogicCqReportV2));
        rtStreamCreate(&streamHandle_, 0);
        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        stream_->Context_()->DefaultStream_()->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;

        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    Stream *stream_ = nullptr;
    Device *dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
};

class SolomonTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "SolomonTaskTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "SolomonTaskTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubSolomonGetDeviceInfo));
        char *socVer = "Ascend910_5591";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_5591")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_CLOUD_V5);
        GlobalContainer::SetRtChipType(CHIP_CLOUD_V5);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910SOLMON");
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_SOLOMON);
        rtStreamCreate(&streamHandle_, 0);
        stream_ = (DavidStream *)streamHandle_;
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    DavidStream *stream_ = nullptr;
    Device *dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
};

class DavidTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidTest end" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        dev_->SetPlatformType(PLATFORM_DAVID_910_9599);
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::GetRunMode)
            .stubs()
            .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
        MOCKER_CPP_VIRTUAL((NpuDriver *)(driver_), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(Sub_LogicCqReportV2));
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        GlobalMockObject::verify();
    }

protected:
    Device *dev_ = nullptr;
};

TEST_F(DavidTest, GetPrefetchCnt_program_kernel)
{
    rtError_t ret = RT_ERROR_NONE;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "GetPrefetchCnt_program_kernel", tilingKey, program, 2048, 1024, 0, 0, 0);
    kernel.SetKernelLength1(10240); // 10k < 16k
    kernel.SetKernelLength2(18432); // 16k < 18k < 32k
    // MACH_AI_CPU
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 0);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_MIX_KERNEL + MIX_AIC_AIV_MAIN_AIC
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC));
    program->SetMachine(Program::MACH_AI_MIX_KERNEL);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 5);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 8);

    // MACH_AI_CVMIX + MIX_AIC
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC));
    program->SetMachine(Program::MACH_AI_CVMIX);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 5);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_CVMIX + MIX_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIV));
    program->SetMachine(Program::MACH_AI_CVMIX);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 5);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_CVMIX + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    program->SetMachine(Program::MACH_AI_CVMIX);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 5);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_VECTOR + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    program->SetMachine(Program::MACH_AI_VECTOR);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 5);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_INVALID_CPU + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    program->SetMachine(Program::MACH_INVALID_CPU);
    ret = GetPrefetchCnt(program, &kernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 0);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);
}

TEST_F(SolomonTaskTest, macroinit_for_chip_cloud_v5)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    rt->MacroInit(CHIP_CLOUD_V5);
    rt->SetSocTypeByChipType(0, 1, 1);
    EXPECT_EQ(Runtime::macroValue_.maxSinkTaskNum, 500000U);
}

TEST_F(DavidTaskTest, macroinit_for_chip_david)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    rt->MacroInit(CHIP_DAVID);
    rt->SetSocTypeByChipType(0, 1, 1);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 2049U);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_model_maintaince)
{
    rtError_t ret;
    Model *model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    rtDavidSqe_t sqe = {};
    task->id = 0;
    InitByStream(&maintainceTask, stream);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_ADD, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    EXPECT_EQ(stream->GetBindFlag(), true);
    EXPECT_EQ(sqe.phSqe.header.preP, 1U);

    model->SetModelExecutorType(EXECUTOR_AICPU);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_MODEL_PRE_PROC, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_LOAD_COMPLETE, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_MODEL_LOAD_COMPLETE, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);

    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_MODEL_ABORT, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);

    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_DEL, model, stream, RT_MODEL_HEAD_STREAM, 0U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    EXPECT_EQ(stream->GetBindFlag(), false);
    EXPECT_EQ(sqe.phSqe.header.preP, 1U);
    uint64_t addr;
    stream->SetModel(model);
    stream->SetLatestModlId(model->Id_());
    (void)CmoAddrTaskInit(&maintainceTask, (void *)&addr, RT_CMO_INVALID);
    stream->DelModel(model);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_profiling_enable_Task)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo task = {};
    task.stream = stream_;
    task.type = TS_TASK_TYPE_PROFILING_ENABLE;
    task.id = 0;
    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    RtDavidPlaceHolderSqe &placeHolderSqe = sqe.phSqe;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    // head taskType
    EXPECT_EQ(placeHolderSqe.taskType, 27);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_profiling_disable_task)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo task = {};
    task.stream = stream_;
    task.type = TS_TASK_TYPE_PROFILING_DISABLE;
    task.id = 0;
    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    RtDavidPlaceHolderSqe &placeHolderSqe = sqe.phSqe;

    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    // head taskType
    EXPECT_EQ(placeHolderSqe.taskType, 28);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stream_switch_ex)
{
    Stream *trueStreams = new Stream(dev_, 0);
    std::unique_ptr<Stream> streamGuard(trueStreams);
    uint32_t trueStreamSqId = trueStreams->GetSqId();
    uint32_t currentStreamId = (uint32_t)stream_->Id_();
    uint32_t currentStreamSqId = stream_->GetSqId();

    std::vector<rtCondition_t> conds = {RT_EQUAL, RT_NOT_EQUAL,    RT_GREATER, RT_GREATER_OR_EQUAL,
                                        RT_LESS,  RT_LESS_OR_EQUAL};

    // stars cond op is not same as runtime.
    // when condition is true, it jump to end adn do nothing, but runtime is need jump to true stream.
    std::vector<rtStarsCondIsaBranchFunc3_t> expectStarsConds = {
        RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, RT_STARS_COND_ISA_BRANCH_FUNC3_BGE,
        RT_STARS_COND_ISA_BRANCH_FUNC3_BLT, RT_STARS_COND_ISA_BRANCH_FUNC3_BGE, RT_STARS_COND_ISA_BRANCH_FUNC3_BLT};

    ASSERT_EQ(conds.size(), expectStarsConds.size());

    int64_t varData = 0;
    int64_t value = 0;

    std::vector<rtSwitchDataType_t> dataTypes = {RT_SWITCH_INT32, RT_SWITCH_INT64};

    for (auto dataType : dataTypes) {
        rtStarsCondIsaLoadImmFunc3_t expectLdFunc3 =
            (dataType == RT_SWITCH_INT64) ? RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD : RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LW;
        for (int i = 0; i < conds.size(); ++i) {
            TaskInfo task = {};
            task.id = 0;
            InitByStream(&task, stream_);
            rtError_t ret = StreamSwitchTaskInitV2(&task, &varData, conds[i], trueStreams, &value, dataType);
            EXPECT_EQ(ret, RT_ERROR_NONE);
            rtDavidSqe_t sqe = {};
            uint64_t sqBaseAddr = 0U;
            auto &streamSwitchExSqe = sqe.fuctionCallSqe;
            ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
            EXPECT_EQ(streamSwitchExSqe.header.type, RT_DAVID_SQE_TYPE_COND);
            TaskUnInitProc(&task);
        }
    }
}

TEST_F(DavidTaskTest, construct_davidsqe_for_model_execute)
{
    rtError_t ret;
    rtModel_t model;
    TaskInfo mdlExecTask = {};
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(PrepareSqeInfoForModelExecuteTask).stubs().will(returnValue(0));

    InitByStream(&mdlExecTask, stream_);
    ret = ModelExecuteTaskInit(&mdlExecTask, (Model *)model, ((Model *)model)->Id_(), 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t sqeNum = GetSendDavidSqeNum(&mdlExecTask);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task = &mdlExecTask;
    rtDavidSqe_t command = {};
    RtDavidStarsFunctionCallSqe &sqe = command.fuctionCallSqe;
    ToConstructDavidSqe(task, &command, true);
    EXPECT_EQ(sqe.header.type, RT_DAVID_SQE_TYPE_COND);
    TaskUnInitProc(task);
    rtModelDestroy(model);
    stream_->models_.clear();
}

TEST_F(DavidTaskTest, construct_davidsqe_for_maintaince_task_force_recycle)
{
    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    rtDavidSqe_t sqe = {};
    task->id = 0;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&maintainceTask, stream_);
    (void)MaintenanceTaskInit(&maintainceTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.preP, 1U);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_ringbuffer_maintain)
{
    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    RingBufferMaintainTaskInfo *const ringBufMtTsk = &(task->u.ringBufMtTask);
    rtDavidSqe_t sqe = {};
    task->id = 0;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&maintainceTask, stream_);
    rtError_t ret = RingBufferMaintainTaskInit(task, (void *)0x100, 0, 10);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.preP, 1U);

    ringBufMtTsk->deleteFlag = true;
    ToConstructDavidSqe(task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.u.ringBufferControlInfo.ringbufferDelFlag, RINGBUFFER_NEED_DEL);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_overflow_switch_set_task)
{
    rtError_t ret;
    rtModel_t model;

    TaskInfo tsk = {};
    InitByStream(&tsk, stream_);
    ret = OverflowSwitchSetTaskInit(&tsk, stream_, 1U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    tsk.id = 0;
    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&tsk, &command, sqBaseAddr);
    EXPECT_EQ(command.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_write_value_task)
{
    rtError_t ret;
    TaskInfo tsk = {};
    TaskInfo *writeValueTask = &tsk;
    InitByStream(&tsk, stream_);
    uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {};
    rtDavidSqe_t cmd;
    uint64_t sqBaseAddr = 0U;
    uint64_t addr = 100U;
    ret = WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, value, TASK_WR_CQE_NEVER);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructDavidSqe(writeValueTask, &cmd, sqBaseAddr);

    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructDavidSqe(writeValueTask, &cmd, sqBaseAddr);

    ret = WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, value, TASK_WR_CQE_ALWAYS);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ToConstructDavidSqe(writeValueTask, &cmd, sqBaseAddr);
    EXPECT_EQ(cmd.writeValueSqe.header.type, RT_DAVID_SQE_TYPE_WRITE_VALUE);
    ;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stars_label_switch_by_index)
{
    TaskInfo task = {};
    uint64_t ptr = 0U;
    uint32_t max = 1U;
    uint64_t labelInfoPtr = 100U;
    rtDavidSqe_t sqe;
    InitByStream(&task, stream_);
    uint64_t sqBaseAddr = 0U;
    (void)StreamLabelSwitchByIndexTaskInit(&task, (void *)&ptr, max, (void *)labelInfoPtr);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    TaskUnInitProc(&task);
    EXPECT_EQ(sqe.fuctionCallSqe.header.type, RT_DAVID_SQE_TYPE_COND);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_add_end_graph_task)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    AddEndGraphTaskInit(&task, 0, 0, 0, 0, 0);
    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.aicpuSqe.header.type, RT_DAVID_SQE_TYPE_AICPU_D);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stars_timeout_sqe)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    TimeoutSetTaskInit(&task, RT_TIMEOUT_TYPE_OP_EXECUTE, 10);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.aicpuControlSqe.header.type, RT_DAVID_SQE_TYPE_AICPU_D);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stars_memcpy_async_sqe_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    task.u.memcpyAsyncTaskInfo.copyDataType = RT_DATA_TYPE_BFP16;
    (void)ReduceOpcodeHigh(&task);

    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.memcpyAsyncSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);
    task.id = 0;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    TaskUnInitProc(&task);
}

TEST_F(DavidTaskTest, memcpy_async_task_init_d2h_ex)
{
    TaskInfo memcpyTask = {};
    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->streamId_ = 1;
    NpuDriver drv;
    rtError_t error;

    void *src = malloc(100);
    void *dst = malloc(100);
    uint64_t size = sizeof(void *);

    uint32_t backupcopyType_ = memcpyTask.u.memcpyAsyncTaskInfo.copyType;
    memcpyTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DEVICE_TO_HOST_EX;

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));
    InitByStream(&memcpyTask, stream);
    rtError_t ret = MemcpyAsyncTaskInitV3(&memcpyTask, RT_MEMCPY_DEVICE_TO_HOST_EX, src, dst, size, 0, NULL);
    EXPECT_EQ(ret, RT_ERROR_DRV_ERR);
    memcpyTask.u.memcpyAsyncTaskInfo.copyType = backupcopyType_;
    TaskUnInitProc(&memcpyTask);
    free(src);
    free(dst);
    delete stream;
    delete device;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stars_memcpy_async_sqe_pciedma)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    task.u.memcpyAsyncTaskInfo.copyDataType = RT_DATA_TYPE_BFP16;
    (void)ReduceOpcodeHigh(&task);
    MOCKER(IsDavidUbDma).stubs().will(returnValue(false));
    MOCKER(IsPcieDma).stubs().will(returnValue(true));

    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    rtError_t ret = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(ret, RT_ERROR_DRV_ERR);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    task.id = 0;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    TaskUnInitProc(&task);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_data_dump_load_info)
{
    TaskInfo task = {};

    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    DataDumpLoadInfoTaskInit(&task, 0, 0, RT_KERNEL_DEFAULT);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
    TaskUnInitProc(&task);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_david_sqe_base)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    RdmaDbSendTaskInit(&task, 0, 1, 0);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_debug_register_for_stream)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtError_t error;
    uint64_t addr = 0x1000;
    error = DebugRegisterForStreamTaskInit(&task, 0, &addr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM);
    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    cqe.errorCode = 0x808U;
    SetStarsResult(&task, cqe);
    cqe.errorType = 1U;
    cqe.errorCode = 0U;
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_debug_register)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtError_t error;
    uint64_t addr = 0x1000;
    error = DebugRegisterTaskInit(&task, 0, &addr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_DEBUG_REGISTER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_debug_unregister)
{
    rtError_t error;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    error = DebugUnRegisterTaskInit(&task, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    sqe.phSqe = {};
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_DEBUG_UNREGISTER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_debug_unregister_for_stream)
{
    rtError_t error;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    error = DebugUnRegisterForStreamTaskInit(&task, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDavidSqe_t sqe = {};
    sqe.phSqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_get_device_msg)
{
    TaskInfo task = {};
    uint32_t devMemSize = 4U;
    const void *devMemAddr = &devMemSize;
    InitByStream(&task, stream_);
    GetDevMsgTaskInit(&task, devMemAddr, devMemSize, RT_GET_DEV_ERROR_MSG);
    rtDavidSqe_t sqe = {};
    sqe.phSqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_GET_DEVICE_MSG);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_profiler_trace_ex)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    ProfilerTraceExTaskInit(&task, 1, 1, 1);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_PROFILER_TRACE_EX);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_label_set)
{
    TaskInfo task = {};
    uint32_t devDestSize = 4U;
    void *const devDestAddr = &devDestSize;

    InitByStream(&task, stream_);
    LabelSetTaskInit(&task, 1, devDestAddr);
    rtModel_t model;
    rtError_t ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream_->SetModel(static_cast<Model *>(model));
    stream_->SetLatestModlId(static_cast<Model *>(model)->Id_());
    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.taskType, TS_TASK_TYPE_LABEL_SET);
    stream_->models_.clear();
    rtModelDestroy(model);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_cmotask)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe1 = {};
    rtDavidSqe_t sqe2 = {};
    rtDavidSqe_t sqe3 = {};
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);

    rtCmoTaskInfo_t cmoTask = {};
    CmoTaskInit(&task, &cmoTask, stream_, 0);

    Model *tmpModel = stream_->Model_();

    stream_->models_.clear();
    cmoTask.opCode = RT_CMO_PREFETCH;
    CmoTaskInit(&task, &cmoTask, stream_, 0);
    ToConstructDavidSqe(&task, &sqe1, sqBaseAddr);
    EXPECT_EQ(sqe1.cmoSqe.header.type, RT_DAVID_SQE_TYPE_CMO);
    cmoTask.opCode = RT_CMO_WRITEBACK;
    CmoTaskInit(&task, &cmoTask, stream_, 0);
    ToConstructDavidSqe(&task, &sqe1, sqBaseAddr);
    EXPECT_EQ(sqe1.cmoSqe.header.type, RT_DAVID_SQE_TYPE_CMO);
    cmoTask.opCode = RT_CMO_INVALID;
    CmoTaskInit(&task, &cmoTask, stream_, 0);
    ToConstructDavidSqe(&task, &sqe2, sqBaseAddr);
    EXPECT_EQ(sqe2.cmoSqe.header.type, RT_STARS_SQE_TYPE_SDMA);
    cmoTask.opCode = RT_CMO_FLUSH;
    CmoTaskInit(&task, &cmoTask, stream_, 0);
    ToConstructDavidSqe(&task, &sqe2, sqBaseAddr);
    EXPECT_EQ(sqe2.cmoSqe.header.type, RT_STARS_SQE_TYPE_SDMA);
    stream_->SetModel(tmpModel);

    rtModel_t model;
    rtError_t ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream_->SetModel(static_cast<Model *>(model));
    stream_->SetLatestModlId(static_cast<Model *>(model)->Id_());
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    CmoTaskInit(&task, &cmoTask, stream_, 0);
    ToConstructDavidSqe(&task, &sqe3, sqBaseAddr);
    EXPECT_EQ(sqe3.memcpyAsyncPtrSqe.header.type, RT_STARS_SQE_TYPE_SDMA);
    rtModelDestroy(model);
    stream_->models_.clear();
}

TEST_F(DavidTaskTest, construct_davidsqe_for_stream_tag_set)
{
    TaskInfo tagTask = {};
    InitByStream(&tagTask, stream_);
    StreamTagSetTaskInit(&tagTask, stream_, 0);
    rtDavidSqe_t sqe;
    sqe.phSqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&tagTask, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_npuclrfloatsta)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t checkmode = 0U;
    NpuClrFloatStaTaskInit(&task, checkmode);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.phSqe.header.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_npugetfloatsta)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuGetFloatStaTaskInit(&task, nullptr, 32, checkmode);

    rtDavidSqe_t sqe = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.getFloatStatusSqe.header.type, RT_DAVID_SQE_TYPE_COND);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_common_task)
{
    TaskInfo dvppTask = {};
    InitByStream(&dvppTask, stream_);

    rtDavidSqe_t sqe = {};
    auto vpcSqe = sqe.commonSqe;
    vpcSqe.sqeHeader.type = RT_DAVID_SQE_TYPE_VPC;
    StarsCommonTaskInit(&dvppTask, vpcSqe, 0);

    rtDavidSqe_t sqe1 = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&dvppTask, &sqe1, sqBaseAddr);
    EXPECT_EQ(sqe1.commonSqe.sqeHeader.type, RT_DAVID_SQE_TYPE_VPC);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_model_to_aicpu)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe;
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    ModelToAicpuTaskInit(&task, 0, 1, RT_KERNEL_DEFAULT, 1);
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    EXPECT_EQ(sqe.aicpuControlSqe.header.type, RT_DAVID_SQE_TYPE_AICPU_D);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_davinci)
{
    TaskInfo task = {};
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    InitByStream(&task, stream_);

    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);
    uint64_t sqBaseAddr = 0U;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));

    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->aicpuControlSqe.header.type, RT_DAVID_SQE_TYPE_AIC);
    AicTaskInit(&task, Program::MACH_AI_VECTOR, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->aicpuControlSqe.header.type, RT_DAVID_SQE_TYPE_AIV);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    TaskUnInitProc(&task);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, check_prefetch_cnt_on_construct_davidsqe_for_aic_mix_task)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe;
    InitByStream(&task, stream_);

    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);

    kernel->SetPrefetchCnt1_(0x2);
    kernel->SetPrefetchCnt2_(0x4);

    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    kernel->SetMixType(MIX_AIC);
    stubProg.SetIsDcacheLockOp(true);
    ToConstructDavidSqe(&task, &sqe, 0U);
    EXPECT_EQ(sqe.aicAivSqe.header.type, RT_DAVID_SQE_TYPE_AIC);
    EXPECT_EQ(sqe.aicAivSqe.aicIcachePrefetchCnt, 0x2);

    AicTaskInit(&task, Program::MACH_AI_VECTOR, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    kernel->SetMixType(MIX_AIV);
    ToConstructDavidSqe(&task, &sqe, 0U);
    EXPECT_EQ(sqe.aicAivSqe.header.type, RT_DAVID_SQE_TYPE_AIV);
    EXPECT_EQ(sqe.aicAivSqe.aivIcachePrefetchCnt, 0x2);

    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIC);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    ToConstructDavidSqe(&task, &sqe, 0U);
    EXPECT_EQ(sqe.aicAivSqe.aicIcachePrefetchCnt, 0x2);
    EXPECT_EQ(sqe.aicAivSqe.aivIcachePrefetchCnt, 0x4);
    TaskUnInitProc(&task);
    delete kernel;
}

TEST_F(DavidTaskTest, check_prefetch_cnt_on_construct_davidsqe_for_aicaiv_nomix_task)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe;
    InitByStream(&task, stream_);

    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);

    kernel->SetPrefetchCnt1_(0x2);
    kernel->SetPrefetchCnt2_(0x4);

    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    ToConstructDavidSqe(&task, &sqe, 0U);
    EXPECT_EQ(sqe.aicAivSqe.header.type, RT_DAVID_SQE_TYPE_AIC);
    EXPECT_EQ(sqe.aicAivSqe.aicIcachePrefetchCnt, 0x2);

    AicTaskInit(&task, Program::MACH_AI_VECTOR, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    ToConstructDavidSqe(&task, &sqe, 0U);
    EXPECT_EQ(sqe.aicAivSqe.header.type, RT_DAVID_SQE_TYPE_AIV);
    EXPECT_EQ(sqe.aicAivSqe.aivIcachePrefetchCnt, 0x2);
    ((Runtime *)Runtime::Instance())->SetBiuperfProfFlag(true);
    ((Runtime *)Runtime::Instance())->SetL2CacheProfFlag(true);
    AicTaskInit(&task, Program::MACH_AI_VECTOR, 1, 2, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    ToConstructDavidSqe(&task, &sqe, 0U);
    TaskUnInitProc(&task);
    delete kernel;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_memcpy_async)
{
    void *src = nullptr;
    uint64_t count = 40U;
    TaskInfo task = {};
    task.id = 0;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    InitByStream(&task, stream_);
    MemcpyAsyncD2HTaskInit(&task, src, count, 2U, 3U);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->memcpyAsyncSqe.header.type, RT_DAVID_SQE_TYPE_ASYNCDMA);

    MemcpyAsyncTaskInfo *const memcpyAsyncTaskInfo = &(task.u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTaskInfo->d2dOffsetFlag = true;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    TaskUnInitProc(&task);
    EXPECT_EQ(sqe->memcpyAsyncSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_build_multiple_task)
{
    UmaArgLoader *loader = new UmaArgLoader(dev_);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(loader, &UmaArgLoader::LoadCpuKernelArgs).stubs().will(returnValue(0));
    rtError_t errorRet;
    void *args[] = {&errorRet, NULL};
    rtTaskDesc_t taskDesc[2];
    rtMultipleTaskInfo_t multipleTaskInfo = {};
    multipleTaskInfo.taskNum = sizeof(taskDesc) / sizeof(taskDesc[0]);
    multipleTaskInfo.taskDesc = taskDesc;

    taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_AICPU;
    taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.soName = "librts_aicpulaunch.so";
    taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.kernelName = "cpu4_add_multiblock_device";
    taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.opName = "cpu4_add_multiblock_device";
    taskDesc[0].u.aicpuTaskDesc.blockDim = 2;
    taskDesc[0].u.aicpuTaskDesc.argsInfo.args = args;
    taskDesc[0].u.aicpuTaskDesc.argsInfo.argsSize = sizeof(args);

    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    taskDesc[1].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    taskDesc[1].u.dvppTaskDesc.sqe.sqeHeader.type = 14;
    taskDesc[1].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // for dvpp rr, add 3 write value
    taskDesc[1].u.dvppTaskDesc.sqe.commandCustom[12] = 0;
    taskDesc[1].u.dvppTaskDesc.sqe.commandCustom[13] = 0;

    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    EXPECT_NE(task, nullptr);
    taskInfo.id = 0;

    Runtime *rt = (Runtime *)Runtime::Instance();

    rtDavidSqe_t sqe[2];
    uint64_t sqBaseAddr = 0U;
    InitByStream(task, stream_);
    DavinciMultipleTaskInit(task, &multipleTaskInfo, 0U);

    MOCKER_CPP(&DavidArgManage::UpdateAddrField).stubs();
    ToConstructDavidSqe(task, sqe, sqBaseAddr);
    auto taskNum = GetSendDavidSqeNum(task);
    EXPECT_EQ(taskNum, 2);
    TaskUnInitProc(task);

    rtFree(devPtr);
    dev_->GetTaskFactory()->Recycle(task);
    delete loader;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_memcpy_async_pciedma)
{
    void *src = nullptr;
    uint64_t count = 40U;
    TaskInfo task = {};
    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    MemcpyAsyncD2HTaskInit(&task, src, count, 2U, 3U);
    MemcpyAsyncTaskInfo *const memcpyAsyncTaskInfo = &(task.u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_H2D;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);

    memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->pcieDmaSqe.header.type, RT_DAVID_SQE_TYPE_ASYNCDMA);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    TaskUnInitProc(&task);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, CCU_SET_RESULT)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCcuTaskInfo_t info = {0};
    info.argSize = RT_CCU_SQE_ARGS_LEN;
    (void)CcuLaunchTaskInit(&task, &info);

    rtLogicCqReport_t cqe = {0};
    cqe.errorType = 1U;
    SetStarsResult(&task, cqe);
    cqe.errorCode = 0x101U;
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_EXCEPTION);
}

TEST_F(DavidTaskTest, docomplete_ccu_launch)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCcuTaskInfo_t info = {0};
    info.argSize = RT_CCU_SQE_ARGS_LEN;
    (void)CcuLaunchTaskInit(&task, &info);

    task.errorCode = 0x1;
    task.u.ccuLaunchTask.errInfo.err = 0x101;
    Complete(&task, 0);
    EXPECT_EQ(task.u.ccuLaunchTask.errInfo.err, 0);
}

TEST_F(DavidTaskTest, construct_ccu_launch_0)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCcuTaskInfo_t info = {0};
    info.argSize = RT_CCU_SQE_ARGS_LEN;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    (void)CcuLaunchTaskInit(&task, &info);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->ccuSqe.header.type, RT_DAVID_SQE_TYPE_CCU);
    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    free(sqe);
}

TEST_F(DavidTaskTest, construct_davidsqe_notify_subtype)
{
    const char_t *res1 = GetNotifySubType(10);
    EXPECT_EQ(strcmp(res1, "unknown"), 0);

    const char_t *res2 = GetNotifySubType(0);
    EXPECT_EQ(strcmp(res2, "single notify record"), 0);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_notify)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    CountNotifyWaitInfo cntNtfyInfo = {};
    NotifyWaitTaskInit(&task, 0, 1, &cntNtfyInfo, nullptr, false);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->notifySqe.header.type, RT_DAVID_SQE_TYPE_NOTIFY_WAIT);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, construct_ccu_launch)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCcuTaskInfo_t info = {0};
    info.argSize = RT_CCU_SQE_ARGS_LEN;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    (void)CcuLaunchTaskInit(&task, &info);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->ccuSqe.header.type, RT_DAVID_SQE_TYPE_CCU);
    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    free(sqe);
}

TEST_F(DavidTaskTest, construct_davidsqe_for_memcpy_async_ptr)
{
    void *src = nullptr;
    uint64_t count = 40U;
    TaskInfo task = {};

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    MemcpyAsyncD2HTaskInit(&task, src, count, 2U, 3U);
    MemcpyAsyncTaskInfo *const memcpyAsyncTaskInfo = &(task.u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTaskInfo->copyKind = RT_MEMCPY_RESERVED;

    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->memcpyAsyncPtrSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    TaskUnInitProc(&task);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_write_value_ptr)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    (void)WriteValuePtrTaskInit(&task, addr, TASK_WR_CQE_DEFAULT);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    (void)WriteValuePtrTaskInit(&task, addr, TASK_WR_CQE_NEVER);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    (void)WriteValuePtrTaskInit(&task, addr, TASK_WR_CQE_ALWAYS);
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);

    EXPECT_EQ(sqe->writeValueSqe.header.type, RT_DAVID_SQE_TYPE_WRITE_VALUE);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    TaskUnInitProc(&task);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_notify_1)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    CountNotifyWaitInfo cntNtfyInfo = {};
    NotifyWaitTaskInit(&task, 0, 1, &cntNtfyInfo, nullptr, false);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->notifySqe.header.type, RT_DAVID_SQE_TYPE_NOTIFY_WAIT);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, construct_davidsqe_for_event)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    DavidEvent *evt = new (std::nothrow) DavidEvent(dev_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    uint64_t sqBaseAddr = 0U;
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);

    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->notifySqe.header.type, RT_DAVID_SQE_TYPE_NOTIFY_RECORD);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->notifySqe.header.type, RT_DAVID_SQE_TYPE_NOTIFY_RECORD);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->notifySqe.header.type, RT_DAVID_SQE_TYPE_NOTIFY_RECORD);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
    delete evt;
}

class DavidApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
    }
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DavidApiTest, test_some_invalid_input_for_device_api_in_david)
{
    rtError_t error;
    rtStream_t stream;
    int32_t num = 0;
    EXPECT_EQ(rtStreamCreateWithFlags(&stream, 0, RT_STREAM_ACSQ_LOCK), ACL_RT_SUCCESS);

    error = rtGetDevice(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetVisibleDeviceIdByLogicDeviceId(0U, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetPriCtxByDeviceId(0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxGetDevice(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetIsHeterogenous(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetSocVersion(NULL, 32);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    char_t version[50U] = {};
    error = rtGetSocVersion(version, 0U);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtSetSocVersion(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetDeviceSatStatus(NULL, 64, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtGetDeviceSatStatus(NULL, 8, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtDeviceStatusQuery(0U, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetDevMsg(RT_GET_DEV_ERROR_MSG, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetRuntimeVersion(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetDeviceCapability(0, 0, 0, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    void *devArgsAddr = nullptr;
    void *argsHandle = nullptr;
    error = rtGetDevArgsAddr(nullptr, &argsInfo, &devArgsAddr, &argsHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    EXPECT_EQ(rtStreamDestroy(stream), ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_some_invalid_input_for_context_api_in_david)
{
    rtError_t error;
    rtStream_t stream;
    int32_t num = 0;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);

    error = rtCtxCreate(NULL, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxDestroy(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxSetCurrent(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxGetCurrent(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int64_t val;
    error = rtCtxGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCtxGetOverflowAddr(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(DavidTaskTest, base_task_ubdma_doorbell)
{
    TaskInfo task = {};

    rtStream_t stream = NULL;
    rtError_t error;
    rtUbDbInfo_t dbInfo;
    dbInfo.dbNum = 2;
    dbInfo.info[0].dieId = 0;
    dbInfo.info[0].functionId = 1;
    dbInfo.info[0].jettyId = 10;
    dbInfo.info[0].piValue = 20;
    dbInfo.info[1].dieId = 1;
    dbInfo.info[1].functionId = 2;
    dbInfo.info[1].jettyId = 12;
    dbInfo.info[1].piValue = 30;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    task.id = 0;
    UbDbSendTaskInit(&task, &dbInfo);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(newSqAddr + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    ToConstructDavidSqe(&task, sqeAddr, newSqAddr);
    Complete(&task, 0);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(sqe);
    sqe = nullptr;
}

void TaskFailCallBackForDoorBell(rtExceptionInfo_t *exceptionInfo)
{
    // TS_ERROR_TASK_EXCEPTION -> RT_ERROR_TSFW_TASK_EXCEPTION -> ACL_ERROR_RT_TS_ERROR
    EXPECT_EQ(exceptionInfo->retcode, ACL_ERROR_RT_TS_ERROR);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_UB);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubType, RT_UB_TYPE_DOORBELL);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubNum, 2);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].dieId, 0);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].functionId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].jettyId, 10);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].piValue, 20);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].dieId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].functionId, 2);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].jettyId, 12);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].piValue, 30);
}

TEST_F(DavidTaskTest, base_task_ubdma_doorbell_DoCompleteSuccess)
{
    rtError_t error;
    Stream *stream;

    error = rtRegTaskFailCallbackByModule("taskFailCallBackForDoorBell", TaskFailCallBackForDoorBell);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task = {};
    rtUbDbInfo_t dbInfo;
    dbInfo.dbNum = 2;
    dbInfo.info[0].dieId = 0;
    dbInfo.info[0].functionId = 1;
    dbInfo.info[0].jettyId = 10;
    dbInfo.info[0].piValue = 20;
    dbInfo.info[1].dieId = 1;
    dbInfo.info[1].functionId = 2;
    dbInfo.info[1].jettyId = 12;
    dbInfo.info[1].piValue = 30;
    InitByStream(&task, stream);
    UbDbSendTaskInit(&task, &dbInfo);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    SetStarsResult(&task, cqe);
    Complete(&task, 0);

    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRegTaskFailCallbackByModule("taskFailCallBackForDoorBell", nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

void TaskFailCallBackForFusionKernelTask32B(rtExceptionInfo_t *exceptionInfo)
{
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.ccuTaskNum, 8U);
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.panicLogNum, 4U);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_FUSION);
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.type, RT_FUSION_AICORE_CCU);
    for (uint32_t idx = 0U; idx < exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.ccuTaskNum;
         idx++) {
        rtFusionAICoreCCUExDetailInfo_t info = exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo;
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].dieId, (idx % 2U));
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].instrId, idx + 2U);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].missionId, idx + 4U);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].args[0], 0xFFFFFFFFFFFFFFFF);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].args[1], 0U);
    }
}

TEST_F(DavidTaskTest, aic_aiv_aicpu_subtask_dev_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicpuError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivError = 1U;
    errorInfo.u.fusionKernelErrorInfo.u.aicpuInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.info[0].suError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.info[0].vecError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.info[0].mteError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivInfo.comm.coreNum = 1U;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    task.errorCode = 0x1U;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(nullptr, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ccu_task_dev_error_proc_for_fusion_32B)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.ccuError = 1U;
    errorInfo.u.fusionKernelErrorInfo.u.ccuInfo.comm.coreNum = 4U;
    rtError_t ret =
        rtRegTaskFailCallbackByModule("TaskFailCallBackForFusionKernelTask32B", TaskFailCallBackForFusionKernelTask32B);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    task.errorCode = 0x1U;
    task.u.fusionKernelTask.ccuSqeNum = 8U;
    task.u.fusionKernelTask.ccuArgSize = 1U;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    rtDavidSqe_t *sqe = const_cast<rtDavidSqe_t *>(errorInfo.u.fusionKernelErrorInfo.u.ccuInfo.davidSqe);
    RtDavidStarsCcuSqe32B *ccuSqe = reinterpret_cast<RtDavidStarsCcuSqe32B *>(sqe);
    for (uint8_t idx = 0U; idx < task.u.fusionKernelTask.ccuSqeNum; idx++) {
        ccuSqe[idx].resv.ccuResvDesc1.dieId = (idx % 2U);
        ccuSqe[idx].instStartId = idx + 2U;
        ccuSqe[idx].resv.ccuResvDesc1.missionId = idx + 4U;
        ccuSqe[idx].usrData[0U] = 0xFFFFFFFF;
        ccuSqe[idx].usrData[1U] = 0xFFFFFFFF;
    }

    ret = ProcessDavidStarsFusionKernelErrorInfo(nullptr, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtRegTaskFailCallbackByModule("TaskFailCallBackForFusionKernelTask32B", nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

void TaskFailCallBackForFusionKernelTask128B(rtExceptionInfo_t *exceptionInfo)
{
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.ccuTaskNum, 2U);
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.panicLogNum, 2U);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_FUSION);
    EXPECT_EQ(exceptionInfo->expandInfo.u.fusionInfo.type, RT_FUSION_AICORE_CCU);
    for (uint32_t idx = 0U; idx < exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg.ccuTaskNum;
         idx++) {
        rtFusionAICoreCCUExDetailInfo_t info = exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo;
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].dieId, (idx % 2U));
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].instrId, idx + 2U);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].missionId, idx + 4U);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].args[0], 0xFFFFFFFFFFFFFFFF);
        EXPECT_EQ(info.ccuDetailMsg.sqeInfo[idx].args[1], 0U);
    }
}

TEST_F(DavidTaskTest, ccu_task_dev_error_proc_for_fusion_128B)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.ccuError = 1U;
    errorInfo.u.fusionKernelErrorInfo.u.ccuInfo.comm.coreNum = 2U;
    rtError_t ret = rtRegTaskFailCallbackByModule("TaskFailCallBackForFusionKernelTask128B",
                                                  TaskFailCallBackForFusionKernelTask128B);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    task.errorCode = 0x1U;
    task.u.fusionKernelTask.ccuSqeNum = 2U;
    task.u.fusionKernelTask.ccuArgSize = 13U;
    task.u.fusionKernelTask.aicPart.inputArgsSize.infoAddr = &val;
    task.u.fusionKernelTask.args = &val;
    task.u.fusionKernelTask.argsSize = 0x100U;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    rtDavidSqe_t *sqe = const_cast<rtDavidSqe_t *>(errorInfo.u.fusionKernelErrorInfo.u.ccuInfo.davidSqe);
    RtDavidStarsCcuSqe *ccuSqe = reinterpret_cast<RtDavidStarsCcuSqe *>(sqe);
    for (uint8_t idx = 0U, num = 0U; num < task.u.fusionKernelTask.ccuSqeNum; num++, idx += 2U) {
        ccuSqe[idx].resv.ccuResvDesc1.dieId = (num % 2U);
        ccuSqe[idx].instStartId = num + 2U;
        ccuSqe[idx].resv.ccuResvDesc1.missionId = num + 4U;
        ccuSqe[idx].usrData[0U] = 0xFFFFFFFF;
        ccuSqe[idx].usrData[1U] = 0xFFFFFFFF;
    }

    ret = ProcessDavidStarsFusionKernelErrorInfo(nullptr, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtRegTaskFailCallbackByModule("TaskFailCallBackForFusionKernelTask128B", nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_dev_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_ERROR_NA);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_hw_r_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}


extern int32_t faultEventFlag;
TEST_F(DavidTaskTest, aic_task_hw_l_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_HW_L_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 1;
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_HW_L_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_sw_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_S_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 1;
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    faultEventFlag = 0;
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_SW_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_link_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_LINK_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // get faultEvent fail
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 2;
    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 6;
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist but not hit rasCode
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 1;
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType3 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType3, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist and hit rasCode
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 8;
    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType4 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType4, DeviceFaultType::LINK_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_sw_error_proc1_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_S_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x800U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_sw_rror_proc1_for_fusion_search_kernel)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);

    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aicError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aicInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_S_ERROR);
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x800U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    task.u.aicTaskInfo.kernel = nullptr;
    task.u.aicTaskInfo.progHandle = program;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&task));
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
    delete kernel;
}

TEST_F(DavidTaskTest, aiv_task_dev_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aivError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivInfo.comm.flag = 1U;
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, wait_timeout_for_notify)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.timeoutErrorInfo.waitType = 7U;
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_NOTIFY_WAIT;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    rtError_t ret = ProcessDavidStarsWaitTimeoutErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, wait_timeout_for_null)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.timeoutErrorInfo.waitType = 7U;

    rtError_t ret = ProcessDavidStarsWaitTimeoutErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, null_task_dev_error_proc_for_fusion)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.fusionKernelErrorInfo.aivError = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivInfo.comm.coreNum = 1U;
    errorInfo.u.fusionKernelErrorInfo.aivInfo.comm.flag = 1U;
    errorInfo.u.fusionKernelErrorInfo.cqeStatus = 0x400U;

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_dev_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_ERROR_NA);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_sw_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_S_ERROR);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // not hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);

    // not hit blklist
    faultEventFlag = 1;
    ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_SW_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_l_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_HW_L_ERROR);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 1;
    ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_HW_L_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aic_task_link_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_LINK_ERROR);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    // get faultEvent fail
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 2;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);

    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType1 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType1, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // hit blklist
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 6;
    ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType2 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType2, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist but not hit rasCode
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 1;
    ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType3 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType3, DeviceFaultType::AICORE_UNKNOWN_ERROR);

    // not hit blklist and hit rasCode
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    faultEventFlag = 8;
    ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType4 = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType4, DeviceFaultType::LINK_ERROR);

    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_in_black_list_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(true);
    faultEventFlag = 5;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::AICORE_UNKNOWN_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_hbm_uce_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(true);
    faultEventFlag = 4;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::HBM_UCE_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_not_support_get_fault_event)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(true);
    faultEventFlag = 2;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_l2_buffer_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(true);
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::L2_BUFFER_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_mte_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    uint32_t val = 0x100U;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(true);
    faultEventFlag = 1;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::AICORE_UNKNOWN_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, aicore_task_hw_r_error_mte_error_proc_not_support_ras)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.coreErrorInfo.comm.flag = static_cast<uint8_t>(AixErrClass::AIX_MTE_POISON_ERROR);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_NOT_SUPPORT;
    dev_->SetDeviceRas(true);
    faultEventFlag = 1;
    rtError_t ret = ProcessDavidStarsCoreErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::AICORE_UNKNOWN_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoNotSupportRas)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_NOT_SUPPORT;
    RawDevice device(0);
    dev_->SetDeviceRas(true);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 1;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoSupportRasAndHbmUceError)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    RawDevice device(0);
    dev_->SetDeviceRas(true);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 4;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::HBM_UCE_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoSupportRasAndHbmUceBlacklistError)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    RawDevice device(0);
    dev_->SetDeviceRas(true);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 5;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR); // if hit the blacklist， do nothing.
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoSupportRasAndNotSupportGetFaultEvent)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    RawDevice device(0);
    dev_->SetDeviceRas(true);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 2;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoSupportRasAndL2BufferError)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    RawDevice device(0);
    dev_->SetDeviceRas(true);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::L2_BUFFER_ERROR);
    dev_->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfoSupportRasAndNoRas)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    RawDevice device(0);
    dev_->SetDeviceRas(false);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 5;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const DeviceFaultType faultType = dev_->GetDeviceFaultType();
    EXPECT_EQ(faultType, DeviceFaultType::NO_ERROR);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, IsFaultEventOccurAndIsHitBlacklistIsNull)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    rtDmsFaultEvent* faultEventInfo = nullptr;
    const std::map<uint32_t, std::string> eventIdBlkList;
    uint32_t hbmUceEventId = 0x80e01801U;
    bool res = IsFaultEventOccur(hbmUceEventId ,faultEventInfo, 0);
    EXPECT_EQ(res, false);
    res = IsHitBlacklist(faultEventInfo, 0, eventIdBlkList);
    EXPECT_EQ(res, false);
    delete errorProc;
}

TEST_F(DavidTaskTest, ProcessStarsSdmaErrorInfo03)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    dev_->SetDeviceRas(false);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    faultEventFlag = 1;
    rtError_t ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    faultEventFlag = 2;
    ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    faultEventFlag = 3;
    ret = ProcessStarsSdmaErrorInfo(&errorInfo, 0, dev_, nullptr);
    faultEventFlag = 0;
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete errorProc;
}

void TaskFailCallBackForCcuTaskStub(rtExceptionInfo_t *exceptionInfo)
{
    EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.panicLogNum, 1U);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.ccuTaskNum, 1U);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_CCU);
    for (uint32_t idx = 0U; idx < exceptionInfo->expandInfo.u.ccuInfo.ccuTaskNum; idx++) {
        EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.sqeInfo[idx].dieId, 1U);
        EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.sqeInfo[idx].instrId, 2U);
        EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.sqeInfo[idx].missionId, 4U);
    }
    for (uint8_t idx = 0U; idx < 5; idx++) {
        EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.sqeInfo[0U].args[idx], 0xFFFFFFFFFFFFFFFF);
    }
    for (uint8_t idx = 5U; idx < 13U; idx++) {
        EXPECT_EQ(exceptionInfo->expandInfo.u.ccuInfo.sqeInfo[0U].args[idx], 0U);
    }
}

TEST_F(DavidTaskTest, ccu_task_dev_error_proc)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.ccuErrorInfo.comm.coreNum = 1U;
    rtError_t ret = rtRegTaskFailCallbackByModule("TaskFailCallBackForCcuTask", TaskFailCallBackForCcuTaskStub);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo task = {};
    task.errorCode = 0x1U;
    task.type = TS_TASK_TYPE_CCU_LAUNCH;
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));

    ret = ProcessDavidStarsCcuErrorInfo(nullptr, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtDavidSqe_t *sqe = const_cast<rtDavidSqe_t *>(errorInfo.u.ccuErrorInfo.davidSqe);
    RtDavidStarsCcuSqe *ccuSqe = reinterpret_cast<RtDavidStarsCcuSqe *>(sqe);
    ccuSqe[0].resv.ccuResvDesc1.dieId = 1U;
    ccuSqe[0].instStartId = 2U;
    ccuSqe[0].resv.ccuResvDesc1.missionId = 4U;
    for (uint8_t idx = 0U; idx < 10; idx++) {
        ccuSqe[0].usrData[idx] = 0xFFFFFFFF;
    }
    ret = ProcessDavidStarsCcuErrorInfo(&errorInfo, 0, dev_, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtRegTaskFailCallbackByModule("TaskFailCallBackForCcuTask", nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(DavidTaskTest, base_task_ubdma_direct)
{
    TaskInfo task = {};

    rtStream_t stream = NULL;
    rtError_t error;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    TaskCommonInfoInit(&task);
    DirectSendTaskInfo *directSend = &(task.u.directSendTask);
    task.type = TS_TASK_TYPE_DIRECT_SEND;
    task.typeName = const_cast<char_t *>("UB_DIRECT_SEND");
    directSend->wrCqe = 1;
    directSend->wqeSize = 0;
    directSend->dieId = 0;
    directSend->jettyId = 10;
    directSend->funcId = 1;
    directSend->wqe = (uint8_t *)malloc(2 * 64 * sizeof(uint8_t));
    directSend->wqePtrLen = 128;

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    Complete(&task, 0);
    free(directSend->wqe);
    directSend->wqe = nullptr;
    free(sqe);
    sqe = nullptr;
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest, toConstructDavidSqeForModelUpdateTask)
{
    TaskInfo task = {};

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    uint16_t desStreamId = 0;
    uint16_t destaskId = 0;
    uint16_t exeStreamId = 0;
    void *devCopyMem = nullptr;
    uint32_t tilingTabLen = 1;
    rtMdlTaskUpdateInfo_t para;
    para.tilingKeyAddr = nullptr;
    para.hdl = nullptr;
    rtError_t ret = ModelTaskUpdateInit(&task, desStreamId, destaskId, exeStreamId, devCopyMem, tilingTabLen, &para);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(newSqAddr + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, newSqAddr);
    EXPECT_EQ(sqe->phSqe.taskType, TS_TASK_TYPE_MODEL_TASK_UPDATE);
    Complete(&task, 0);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, toConstructDavidSqeForAicpuInfoLoadTask)
{
    TaskInfo task = {};

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    const void *const aicpuInfo = nullptr;
    uint32_t length = 0;
    rtError_t ret = AicpuInfoLoadTaskInit(&task, aicpuInfo, length);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->phSqe.taskType, TS_TASK_TYPE_AICPU_INFO_LOAD);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(newSqAddr + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, newSqAddr);
    Complete(&task, 0);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, toConstructDavidSqeForNopTask)
{
    TaskInfo task = {};

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    rtError_t ret = NopTaskInit(&task);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->phSqe.taskType, TS_TASK_TYPE_NOP);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);

    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(newSqAddr + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, newSqAddr);
    Complete(&task, 0);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(sqe);
    sqe = nullptr;
}

TEST_F(DavidTaskTest, AixKernelTaskInitForFusion_test)
{
    TaskInfo task = {};
    rtAicAivFusionInfo_t info = {};
    LaunchTaskCfgInfo_t cfg = {};
    info.launchTaskCfg = &cfg;
    info.mixType = MIX_AIC;
    AixKernelTaskInitForFusion(&task, &info, &cfg);
    EXPECT_EQ(task.u.fusionKernelTask.aicAivType, 0U);

    info.mixType = MIX_AIV;
    AixKernelTaskInitForFusion(&task, &info, &cfg);
    EXPECT_EQ(task.u.fusionKernelTask.aicAivType, 1U);

    info.mixType = NO_MIX;
    info.mach = Program::MACH_AI_VECTOR;
    AixKernelTaskInitForFusion(&task, &info, &cfg);
    EXPECT_EQ(task.u.fusionKernelTask.aicAivType, 1U);
}

TEST_F(DavidTaskTest, mutiple_task_construct_sqe_test_error)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MULTIPLE_TASK;
    InitByStream(&task, stream_);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;

    MOCKER_CPP_VIRTUAL(stream_->Device_()->ArgLoader_(), &ArgLoader::GetKernelInfoDevAddr).stubs().will(returnValue(1));

    DavinciMultiTaskInfo *const davinciMultiTaskInfo = &(task.u.davinciMultiTaskInfo);
    rtMultipleTaskInfo_t multipleTask = {};
    rtTaskDesc_t taskDesc[1];
    multipleTask.taskDesc = taskDesc;
    davinciMultiTaskInfo->multipleTaskInfo = &multipleTask;
    rtMultipleTaskInfo_t *const multipleTaskInfo =
        static_cast<rtMultipleTaskInfo_t *>(const_cast<void *>(davinciMultiTaskInfo->multipleTaskInfo));
    multipleTaskInfo->taskNum = 1;
    multipleTaskInfo->taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_AICPU;
    multipleTaskInfo->taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.soName = nullptr;
    multipleTaskInfo->taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.kernelName = "test";
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->commonSqe.sqeHeader.type, RT_STARS_SQE_TYPE_INVALID);
    multipleTaskInfo->taskDesc[0].u.aicpuTaskDesc.kernelLaunchNames.soName = "test";
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    EXPECT_EQ(sqe->commonSqe.sqeHeader.type, RT_STARS_SQE_TYPE_INVALID);
    free(sqe);
}

void TaskFailCallBackForDirectWqe(rtExceptionInfo_t *exceptionInfo)
{
    // TS_ERROR_TASK_BUS_ERROR -> RT_ERROR_TSFW_TASK_BUS_ERROR -> ACL_ERROR_RT_TS_ERROR
    EXPECT_EQ(exceptionInfo->retcode, ACL_ERROR_RT_TS_ERROR);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_UB);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubNum, 1U);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubType, RT_UB_TYPE_DIRECT_WQE);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].dieId, 0);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].functionId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].jettyId, 10);
}

TEST_F(DavidTaskTest, base_task_ubdma_direct_DoCompleteSuccess)
{
    rtError_t error;
    Stream *stream;

    error = rtRegTaskFailCallbackByModule("taskFailCallBackForDirectWqe", TaskFailCallBackForDirectWqe);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task = {};
    rtUbWqeInfo_t wqeInfo;
    wqeInfo.wrCqe = 1;
    wqeInfo.dieId = 0;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    wqeInfo.wqeSize = 0;
    wqeInfo.wqe = (uint8_t *)malloc(2 * 64 * sizeof(uint8_t));
    wqeInfo.wqePtrLen = 128U;
    InitByStream(&task, stream);
    UbDirectSendTaskInit(&task, &wqeInfo);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 2U;
    SetStarsResult(&task, cqe);
    Complete(&task, 0);

    free(wqeInfo.wqe);
    wqeInfo.wqe = nullptr;
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtRegTaskFailCallbackByModule("taskFailCallBackForDirectWqe", nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

bool IsDavidUbDmaStub(const uint32_t copyTypeFlag)
{
    return true;
}

drvError_t halAsyncDmaCreateStub(uint32_t devId, struct halAsyncDmaInputPara *in, struct halAsyncDmaOutputPara *out)
{
    out->wqe = (uint8_t *)malloc(64);
    out->dieId = 1;
    out->functionId = 10;
    out->jettyId = 12;
    out->size = 64;
    return DRV_ERROR_NONE;
}

drvError_t halAsyncDmaDestoryStub(uint32_t devId, halAsyncDmaDestoryPara *para)
{
    para->size = 64;
    free(para->wqe);

    return DRV_ERROR_NONE;
}

TEST_F(DavidTaskTest1, memcpy_async_to_ConstructDavidAsyncDmaSqe)
{
    rtError_t error;
    Stream *stream;
    TaskInfo memcpyTask = {};
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    ((RawDevice *)(stream->device_))->driver_ = drv;
    memcpyTask.type = TS_TASK_TYPE_MEMCPY;
    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    InitByStream(&memcpyTask, stream);

    MOCKER(IsDavidUbDma).stubs().will(invoke(IsDavidUbDmaStub));
    MOCKER(halAsyncDmaCreate).stubs().will(invoke(halAsyncDmaCreateStub));
    MOCKER(halAsyncDmaDestory).stubs().will(invoke(halAsyncDmaDestoryStub));
    rtDavidSqe_t sqe[2];
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&memcpyTask, sqe, sqBaseAddr);
    TaskUnInitProc(&memcpyTask);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest1, memcpy_async_to_ConstructDavidAsyncUbDbSqe)
{
    rtError_t error;
    Stream *stream;
    TaskInfo memcpyTask = {};
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate((rtStream_t *)&stream, 0);
    stream->SetBindFlag(true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    ((RawDevice *)(stream->device_))->driver_ = drv;
    memcpyTask.type = TS_TASK_TYPE_MEMCPY;
    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    InitByStream(&memcpyTask, stream);

    MOCKER(IsDavidUbDma).stubs().will(invoke(IsDavidUbDmaStub));
    MOCKER(halAsyncDmaCreate).stubs().will(invoke(halAsyncDmaCreateStub));
    MOCKER(halAsyncDmaDestory).stubs().will(invoke(halAsyncDmaDestoryStub));
    rtDavidSqe_t sqe[2];
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&memcpyTask, sqe, sqBaseAddr);
    TaskUnInitProc(&memcpyTask);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest, InitFuncStreamSwitchTaskV1)
{
    TaskInfo switchtask = {};
    rtError_t error;
    RawDevice *stub = new RawDevice(0);
    NpuDriver drv;
    drv.chipType_ = CHIP_DAVID;
    stub->driver_ = &drv;

    stub->platformType_ = PLATFORM_DAVID_910_9599;
    stub->platformConfig_ = (0xE << 8);
    void *buf = malloc(2);

    InitByStream(&switchtask, stream_);
    switchtask.u.streamswitchTask.trueStream = stream_;
    stream_->executedTimesSvm_ = static_cast<uint16_t *>(buf);
    rtStarsStreamSwitchFcPara_t switchfcPara = {};
    stub->starsRegBaseAddr_ = 0x55;
    error = InitFuncCallParaForStreamSwitchTaskV1(&switchtask, switchfcPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    error = InitFuncCallParaForStreamSwitchTaskV1(&switchtask, switchfcPara, CHIP_MINI_V3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsStreamSwitchExFcPara_t switchfcExPara = {};
    error = InitFuncCallParaForStreamSwitchTaskV2(&switchtask, switchfcExPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    error = InitFuncCallParaForStreamSwitchTaskV2(&switchtask, switchfcExPara, CHIP_MINI_V3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsStreamActiveFcPara_t activeExPara = {};
    switchtask.u.streamactiveTask.activeStream = stream_;
    error = InitFuncCallParaForStreamActiveTask(&switchtask, activeExPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    error = InitFuncCallParaForStreamActiveTask(&switchtask, activeExPara, CHIP_MINI_V3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = InitFuncCallParaForStreamActiveTask(&switchtask, activeExPara, CHIP_5612);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stub->starsRegBaseAddr_ = 0;
    error = InitFuncCallParaForStreamSwitchTaskV1(&switchtask, switchfcPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    error = InitFuncCallParaForStreamSwitchTaskV1(&switchtask, switchfcPara, CHIP_5612);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = InitFuncCallParaForStreamSwitchTaskV2(&switchtask, switchfcExPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    error = InitFuncCallParaForStreamActiveTask(&switchtask, activeExPara, CHIP_DAVID);
    EXPECT_EQ(error, RT_ERROR_DEVICE_INVALID);
    free(buf);
    stream_->executedTimesSvm_ = nullptr;

    delete stub;
}

TEST_F(DavidTaskTest1, InitFuncStreamSwitchTaskV2)
{
    TaskInfo switchtask = {};
    rtError_t error;
    RawDevice *stub = new RawDevice(0);
    NpuDriver drv;
    drv.chipType_ = CHIP_DAVID;
    stub->driver_ = &drv;
    stub->platformType_ = PLATFORM_DAVID_910_9599;
    stub->platformConfig_ = (0xE << 8);
    void *buf = malloc(2);

    InitByStream(&switchtask, stream_);
    switchtask.u.streamswitchTask.trueStream = stream_;
    stream_->executedTimesSvm_ = static_cast<uint16_t *>(buf);
    rtStarsStreamSwitchExFcPara_t switchfcExPara = {};
    stub->starsRegBaseAddr_ = 0;
    error = InitFuncCallParaForStreamSwitchTaskV2(&switchtask, switchfcExPara, CHIP_5612);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsStreamActiveFcPara_t activeExPara = {};
    free(buf);
    stream_->executedTimesSvm_ = nullptr;

    delete stub;
}

TEST_F(DavidTaskTest1, model_maintaince_init_david)
{
    rtError_t ret;
    Model *model;
    RawDevice *stub = new RawDevice(0);
    NpuDriver drv;
    drv.chipType_ = CHIP_DAVID;
    stub->driver_ = &drv;
    stub->platformType_ = PLATFORM_DAVID_910_9599;
    stub->platformConfig_ = (0xE << 8);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    TaskInfo maintainceTask = {};
    TaskInfo *task = &maintainceTask;
    InitByStream(&maintainceTask, stream_);
    (void)ModelMaintainceTaskInit(&maintainceTask, MMT_STREAM_ADD, model, stream_, RT_MODEL_HEAD_STREAM, 0U);
    delete stub;
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_aicpu_kernel_mc2_type)
{
    TaskInfo task = {};

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    InitByStream(&task, stream_);
    AicpuTaskInit(&task, 1, (uint32_t)0);
    stream_->SetDebugRegister(true);
    task.u.aicpuTaskInfo.aicpuKernelType = KERNEL_TYPE_AICPU_KFC;
    ToConstructDavidSqe(&task, sqe, sqBaseAddr);
    task.id = 0;
    rtDavidSqe_t *sqeAddr = sqe;
    uint16_t pos = task.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);

    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(&task, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe->aicpuSqe.resv.fusionSubTypeDesc.subType, 0U);
    EXPECT_EQ(sqe->aicpuSqe.header.type, RT_DAVID_SQE_TYPE_AICPU_D);
    TaskUnInitProc(&task);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    sqe = nullptr;
}

void TaskFailCallBackStubfunc(const uint32_t streamId, const uint32_t taskId, const uint32_t threadId,
                              const uint32_t retCode, const Device *const dev)
{
    // stub
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_fusion_kernel_launch_1)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);

    rtError_t error;
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 1;
    argsInfo.aicpuArgs[0].kfcArgsFmtOffset = 0xFFFF;
    argsInfo.aicpuArgs[0].kernelNameAddrOffset = 0;
    argsInfo.aicpuArgs[0].soNameAddrOffset = 0;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_AICPU;
    fusionInfo.subTask[0].task.aicpuInfo.kernelType = 0;
    fusionInfo.subTask[0].task.aicpuInfo.flags = 0;
    fusionInfo.subTask[0].task.aicpuInfo.blockDim = 2U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void *>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 6U;
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void *)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0;  //aic no mix
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicAivType = 1;  //aiv no mix
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_HOST_FIRST;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicPart.kernel = kernel;
    kernTask.u.fusionKernelTask.aicPart.kernel->mixType_ = MIX_AIC_AIV_MAIN_AIC;
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_HOST_ONLY;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicPart.kernel->mixType_ = MIX_AIV;
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_DEVICE_FIRST;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    MOCKER(TaskFailCallBack).stubs().will(invoke(TaskFailCallBackStubfunc));
    MOCKER_CPP(&H2DCopyMgr::H2DMemCopyWaitFinish).stubs().will(returnValue(RT_ERROR_NONE));

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    cqe.errorCode = 1U;

    Handle argHdl = {};
    argHdl.freeArgs = true;
    kernTask.u.fusionKernelTask.argHandle = static_cast<void *>(&argHdl);

    WaitAsyncCopyComplete(&kernTask);
    SetStarsResult(&kernTask, cqe);
    Complete(&kernTask, 0);
    PrintErrorInfo(&kernTask, 0);
    kernTask.u.fusionKernelTask.argHandle = static_cast<void *>(&argHdl);
    TaskUnInitProc(&kernTask);
    ((Runtime *)Runtime::Instance())->SetConnectUbFlag(true);
    TaskUnInitProc(&kernTask);
    delete kernel;
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_fusion_kernel_launch_2)
{
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 0U;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_CCU;
    fusionInfo.subTask[0].task.ccuInfo.taskNum = 4U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].dieId = 0U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].missionId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].dieId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].missionId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].dieId = 0U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].missionId = 2U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].dieId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].missionId = 2U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].instCnt = 1U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void *>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 5U;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0;  //aic no mix
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].ccuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    TaskUnInitProc(&kernTask);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_fusion_kernel_launch_3)
{
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 0U;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_CCU;
    fusionInfo.subTask[0].task.ccuInfo.taskNum = 1U;
    for (int32_t i = 0; i < 13; ++i) {
        fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].args[i] = UINT64_MAX;
    }
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].argSize = 13U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].instCnt = 1U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void *>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 3U;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0;  //aic no mix

    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&kernTask, sqe, sqBaseAddr);
    EXPECT_EQ(sqe[0].ccuSqe.usrData[0], UINT32_MAX);
    EXPECT_EQ(sqe[1].ccuSqe.header.type, 0x3F);

    TaskUnInitProc(&kernTask);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_fusion_kernel_launch_error_type)
{
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    kernTask.type = TS_TASK_TYPE_FUSION_KERNEL;
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 0U;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 1U;
    fusionInfo.subTask[0].type = RT_FUSION_END;

    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void *>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 1U;

    sqe[0].ccuSqe.header.type = 0x3F;
    ToConstructDavidSqe(&kernTask, sqe, true);
    EXPECT_EQ(sqe[0].ccuSqe.header.type, 0x3F);

    TaskUnInitProc(&kernTask);
}

TEST_F(DavidTaskTest1, load_args_for_aicore_task)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtArgsEx_t argsInfo = {};
    argsInfo.isNoNeedH2DCopy = 1U;
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    AicTaskInit(&kernTask, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(kernTask.type, TS_TASK_TYPE_KERNEL_AICORE);
    kernTask.u.aicTaskInfo.argsInfo = &argsInfo;
    stream_->isHasPcieBar_ = true;
    stream_->taskResMang_->taskRes_[0].copyDev = (void *)1000;

    uint32_t args[128];
    void *kerArgs = static_cast<void *>(args);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    error = LoadArgsInfo(&kernTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskUnInitProc(&kernTask);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_cmo_addr)
{
    rtError_t ret;
    Model *model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo cmoAddrTask = {};
    TaskInfo *task = &cmoAddrTask;
    rtDavidSqe_t sqe = {};
    task->id = 0;
    InitByStream(&cmoAddrTask, stream);

    uint8_t addr[64];
    stream->SetModel(model);
    stream->SetLatestModlId(model->Id_());
    (void)CmoAddrTaskInit(&cmoAddrTask, (void *)addr, RT_CMO_INVALID);
    PrintErrorInfo(&cmoAddrTask, 0);
    stream->DelModel(model);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_cmo_addr_error)
{
    rtError_t ret;
    Model *model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo cmoAddrTask = {};
    TaskInfo *task = &cmoAddrTask;
    rtDavidSqe_t sqe = {};
    task->id = 0;
    InitByStream(&cmoAddrTask, stream);
    uint8_t addr[64];
    (void)CmoAddrTaskInit(&cmoAddrTask, (void *)addr, RT_CMO_INVALID);
    PrintErrorInfo(&cmoAddrTask, 0);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_cmo_addr_error2)
{
    rtError_t ret;
    Model *model;
    Stream *stream;

    ret = rtStreamCreate((rtStream_t *)&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelCreate((rtModel_t *)&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo cmoAddrTask = {};
    TaskInfo *task = &cmoAddrTask;
    rtDavidSqe_t sqe = {};
    task->id = 0;
    InitByStream(&cmoAddrTask, stream);
    stream->SetModel(model);
    stream->SetLatestModlId(model->Id_());
    MOCKER_CPP_VIRTUAL(dev_->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    uint8_t addr[64];
    (void)CmoAddrTaskInit(&cmoAddrTask, (void *)addr, RT_CMO_INVALID);
    PrintErrorInfo(&cmoAddrTask, 0);
    stream->DelModel(model);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest1, load_args_for_aicpu_task)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.isNoNeedH2DCopy = 1U;
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.soNameAddrOffset = 0U;
    argsInfo.kernelNameAddrOffset = 0U;
    AicpuTaskInit(&kernTask, 1, 1);
    kernTask.u.aicpuTaskInfo.aicpuArgsInfo = &argsInfo;
    stream_->isHasPcieBar_ = true;
    stream_->taskResMang_->taskRes_[0].copyDev = (void *)1000;

    uint32_t args[128];
    void *kerArgs = static_cast<void *>(args);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    error = LoadArgsInfo(&kernTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskUnInitProc(&kernTask);
}

#ifdef ASCEND910D
TEST_F(DavidTaskTest1, notify_task_wait_timeout_error_proc)
{
    rtSetDevice(1);
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.timeoutErrorInfo.waitType = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;

    rtError_t ret = ProcessDavidStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = ProcessDavidStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}
#endif

class DavidVnpuApiTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        (void)rtSetSocVersion("Ascend910_9599");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        originType_ = Runtime::Instance()->GetChipType();
        Runtime::Instance()->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);

        int64_t hardwareVersion = CHIP_DAVID << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));

        capability_group_info capGroupInfos;
        (void)memset_s(&capGroupInfos, sizeof(capability_group_info), 0U, sizeof(capability_group_info));

        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetCapabilityGroupInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&capGroupInfos, sizeof(capability_group_info)), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));

        (void)rtSetDevice(0);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);  // Recover.
        GlobalMockObject::verify();
    }

public:
    Stream *stm_ = nullptr;
    Device *dev_ = nullptr;
    static rtChipType_t originType_;
    static Driver *driver_;
};
rtChipType_t DavidVnpuApiTest::originType_ = CHIP_MINI;
Driver *DavidVnpuApiTest::driver_ = NULL;

class DavidVfApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910_9599");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        originType_ = Runtime::Instance()->GetChipType();
        Runtime::Instance()->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);

        int64_t hardwareVersion = CHIP_DAVID << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));

        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);  // Recover.
    }

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

public:
    Stream *stm_ = nullptr;
    Device *dev_ = nullptr;
    static rtChipType_t originType_;
    static Driver *driver_;
};

rtChipType_t DavidVfApiTest::originType_ = CHIP_MINI;
Driver *DavidVfApiTest::driver_ = NULL;

TEST_F(DavidVfApiTest, test_setgroup_for_david)
{
    rtError_t error;
    MOCKER_CPP(&ApiImpl::isInProc).stubs().will(returnValue(false));
    error = rtSetGroup(1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtSetGroup(8);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtSetGroup(0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    int64_t aic_num = 0;
    error = rtGetDeviceInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &aic_num);
    EXPECT_EQ(error, 0);
    EXPECT_NE(aic_num, 0);

    int64_t aiv_num = 0;
    error = rtGetDeviceInfo(0, MODULE_TYPE_VECTOR_CORE, INFO_TYPE_CORE_NUM, &aiv_num);
    EXPECT_EQ(error, 0);
    EXPECT_NE(aiv_num, 0);

    uint32_t aiCoreCnt = 0;
    error = rtGetAiCoreCount(&aiCoreCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device, &Device::SetCurGroupInfo).stubs().will(returnValue(RT_ERROR_STREAM_NEW));
    error = rtSetGroup(1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(DavidVfApiTest, test_setgroup_for_david_2)
{
    rtError_t error;
    MOCKER_CPP(&ApiImpl::isInProc).stubs().will(returnValue(true));
    error = rtSetGroup(1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(DavidVfApiTest, test_rtGetAddrAndPrefCntWithHandle)
{
    uint32_t prefetchCnt = 0;
    rtError_t error = rtGetAddrAndPrefCntWithHandle(NULL, NULL, NULL, &prefetchCnt);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidVfApiTest, test_rtKernelGetAddrAndPrefCnt)
{
    void *addr = NULL;
    uint32_t cnt = 0U;
    rtError_t error = rtKernelGetAddrAndPrefCnt(NULL, 355, NULL, 1, &addr, &cnt);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(DavidVfApiTest, test_rtKernelGetAddrAndPrefCntV2)
{
    void *addr = NULL;
    uint32_t cnt = 0U;
    rtError_t error = rtKernelGetAddrAndPrefCntV2(NULL, 355, NULL, RT_DYNAMIC_SHAPE_KERNEL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest2, fusion_kernel_task_dev_error_proc)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = ProcessDavidStarsFusionKernelErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = ProcessDavidStarsFusionKernelErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(DavidTaskTest2, fusion_kernel_task_wait_timeout_error_proc)
{
    rtSetDevice(1);
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.timeoutErrorInfo.waitType = RT_DAVID_SQE_TYPE_FUSION;

    rtError_t ret = ProcessDavidStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = ProcessDavidStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DavidTaskTest2, ccu_task_wait_timeout_error_proc)
{
    rtSetDevice(1);
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    errorInfo.u.timeoutErrorInfo.waitType = RT_DAVID_SQE_TYPE_CCU;

    rtError_t ret = ProcessDavidStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = ProcessDavidStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(DavidTaskTest2, set_stars_result_for_fusion_kernel_task)
{
    rtError_t error;
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);
    FusionKernelTaskInit(&kernTask);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    cqe.errorCode = 0x404U;
    SetStarsResult(&kernTask, cqe);
    EXPECT_EQ(kernTask.errorCode, TS_ERROR_TASK_EXCEPTION);
    TaskUnInitProc(&kernTask);
    EXPECT_EQ(kernTask.u.fusionKernelTask.args, nullptr);
}

TEST_F(DavidTaskTest1, construct_davidsqe_for_stream_active)
{
    TaskInfo streamActiveTask = {};
    InitByStream(&streamActiveTask, (Stream *)stream_);

    rtError_t ret = RT_ERROR_NONE;
    uint32_t addr = 0x111;
    ((RawDevice *)(stream_->Device_()))->starsRegBaseAddr_ = reinterpret_cast<uint64_t>(&addr);
    ret = StreamActiveTaskInit(&streamActiveTask, stream_);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo *tsk = &streamActiveTask;
    rtDavidSqe_t *command = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t sqBaseAddr = 0U;
    RtDavidStarsFunctionCallSqe sqe = command->fuctionCallSqe;
    ToConstructDavidSqe(tsk, command, sqBaseAddr);
    streamActiveTask.id = 0;
    rtDavidSqe_t *sqeAddr = (rtDavidSqe_t *)(&sqe);
    uint16_t pos = streamActiveTask.id;
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(&sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    sqeAddr = reinterpret_cast<rtDavidSqe_t *>(stream_->GetSqBaseAddr() + (pos << SHIFT_SIX_SIZE));
    ToConstructDavidSqe(tsk, sqeAddr, stream_->GetSqBaseAddr());
    EXPECT_EQ(sqe.header.type, RT_DAVID_SQE_TYPE_COND);
    EXPECT_EQ(sqe.csc, 1U);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(command);
    command = nullptr;
}

static rtError_t MemcpyAsyncTaskInitV1Stub(TaskInfo *const taskInfo, void *memcpyAddrInfo, const uint64_t cpySize)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MEMCPY;
    taskInfo->typeName = const_cast<char_t *>("MEMCPY_ASYNC");
    Stream *const stream = taskInfo->stream;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());

    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->memcpyAddrInfo = memcpyAddrInfo;
    memcpyAsyncTaskInfo->size = cpySize;
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTaskInfo->copyKind = RT_MEMCPY_RESERVED;
    return RT_ERROR_NONE;
}

TEST_F(DavidApiTest, test_memcpy_async_ptr_for_david)
{
    rtError_t error;
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ((Stream *)stream)->SetSqMemAttr(false);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)(malloc(sizeof(rtDavidSqe_t)));
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    MOCKER(MemcpyAsyncTaskInitV1).stubs().will(invoke(MemcpyAsyncTaskInitV1Stub));

    void *addr = (void *)0x100;
    ApiImplDavid apiImpl;
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(RT_ERROR_CONTEXT_ABORT_ON_FAILURE);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    error = apiImpl.MemcpyAsyncPtr(addr, 64, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, (Stream *)stream, 0);
    EXPECT_EQ(error, RT_ERROR_CONTEXT_ABORT_ON_FAILURE);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(DavidApiTest, test_judge_head_tail_pos_for_david0)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);

    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);

    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t head;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0x3;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));
    error = drv.GetSqHead(0U, 0U, 1U, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    taskRes->taskResATail_.Set(2);
    davidStream->JudgeHeadTailPos(&status, 3);
    taskRes->taskResATail_.Set(tail);

    Device *dev = davidStream->Device_();
    davidStream->device_ = nullptr;
    davidStream->JudgeHeadTailPos(&status, 3);
    davidStream->device_ = dev;
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_judge_head_tail_pos_for_david00)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);

    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);

    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t head;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0x1;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));
    error = drv.GetSqHead(0U, 0U, 1U, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    taskRes->taskResATail_.Set(2);
    davidStream->JudgeHeadTailPos(&status, 3);
    taskRes->taskResATail_.Set(tail);

    Device *dev = davidStream->Device_();
    davidStream->device_ = nullptr;
    davidStream->JudgeHeadTailPos(&status, 3);
    davidStream->device_ = dev;
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_judge_head_tail_pos_for_david1)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ((Event *)event)->SetRecord(true);
    ((Event *)event)->Context_()->SetCtxMode(CONTINUE_ON_FAILURE);
    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }

    ((Event *)event)->SetRecord(false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_judge_head_tail_pos_for_david2)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetSqHead).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    davidStream->taskPosTail_.Set(2);
    davidStream->JudgeHeadTailPos(&status, 1);
    davidStream->taskPosTail_.Set(tail);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_judge_head_tail_pos_for_david3)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetSqHead).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    davidStream->taskPosTail_.Set(2);
    davidStream->JudgeHeadTailPos(&status, 3);
    davidStream->taskPosTail_.Set(tail);

    Device *dev = davidStream->Device_();
    davidStream->device_ = nullptr;
    davidStream->JudgeHeadTailPos(&status, 3);
    davidStream->device_ = dev;
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_query_wait_task_for_david0)
{
    rtError_t error;
    rtStream_t stream;
    uint32_t taskId = 0;
    bool isWaitFlag = false;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);

    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);

    error = davidStream->GetLastTaskIdFromRtsq(taskId);
    EXPECT_EQ(taskId, RT_ERROR_NONE);

    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t head;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0x1;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));
    error = drv.GetSqHead(0U, 0U, 1U, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    taskRes->taskResATail_.Set(2);
    davidStream->QueryWaitTask(isWaitFlag, 3);
    taskRes->taskResATail_.Set(tail);

    Device *dev = davidStream->Device_();
    davidStream->device_ = nullptr;
    davidStream->QueryWaitTask(isWaitFlag, 3);
    davidStream->device_ = dev;
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, test_query_wait_task_for_david1)
{
    rtError_t error;
    rtStream_t stream;
    bool isWaitFlag = false;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);

    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0x4;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    davidStream->taskPosTail_.Set(2);
    davidStream->QueryWaitTask(isWaitFlag, 3);
    davidStream->taskPosTail_.Set(tail);
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidApiTest, TestRtsDeviceGetCapabilityTaskIdBitWidthOnDavid)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 32);
}

TEST_F(DavidApiTest, test_query_wait_task_for_david2)
{
    rtError_t error;
    rtStream_t stream;
    bool isWaitFlag = false;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    DavidStream *davidStream = (DavidStream *)stream;
    davidStream->SetSqMemAttr(false);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetSqHead).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(davidStream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    davidStream->taskPosTail_.Set(2);
    davidStream->QueryWaitTask(isWaitFlag, 3);
    davidStream->taskPosTail_.Set(tail);
    GlobalMockObject::reset();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(DavidTaskTest, test_sdma_mte_error)
{
    DeviceErrorProc *errorProc = new DeviceErrorProc(dev_);
    DevRingBufferCtlInfo *ctlInfo = (DevRingBufferCtlInfo *)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    if (ctlInfo != nullptr) {
        ctlInfo->tail = 1;
        ctlInfo->head = 0;
        ctlInfo->magic = RINGBUFFER_MAGIC;
        ctlInfo->ringBufferLen = RINGBUFFER_LEN;
        uint64_t oneElementLen = sizeof(StarsDeviceErrorInfo) + sizeof(RingBufferElementInfo);
        uintptr_t infoAddr =
            reinterpret_cast<uintptr_t>(ctlInfo) + sizeof(DevRingBufferCtlInfo) + ctlInfo->head * oneElementLen;
        RingBufferElementInfo *info = (RingBufferElementInfo *)infoAddr;
        StarsDeviceErrorInfo *errorInfo = reinterpret_cast<StarsDeviceErrorInfo *>(info + 1);
        info->errorType = SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.type = SDMA_ERROR;
        errorInfo->u.sdmaErrorInfo.comm.coreNum = 1;
        errorInfo->u.sdmaErrorInfo.sdma.starsInfoForDavid[0].cqeStatus = TS_SDMA_STATUS_POISON_ERROR;
        rtError_t error = errorProc->ProcessStarsOneElementInRingBuffer(ctlInfo, 0, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(ctlInfo);
    }
    GlobalMockObject::verify();
    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
}

uint64_t g_simtStackPhySize = 0;
rtError_t NpuDriverDevMemAllocStub(NpuDriver *a, void **dptr, uint64_t size)
{
    if (dptr == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    *dptr = (void *)malloc(size);
    if (*dptr == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    g_simtStackPhySize = size;
    return RT_ERROR_NONE;
}

rtError_t NpuDriverDevMemFreeStub(NpuDriver *a, void *dptr)
{
    if (dptr == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    free(dptr);
    g_simtStackPhySize = 0;
    return RT_ERROR_NONE;
}

TEST_F(DavidTaskTest, Subscribe_David)
{
    TaskInfo taskInfo = {};
    rtExceptionArgsInfo_t argsInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    AicTaskInfo *aicTaskInfo = &(taskInfo.u.aicTaskInfo);
    uint32_t infoAddr = 0U;
    aicTaskInfo->comm.args = &infoAddr;
    aicTaskInfo->inputArgsSize.infoAddr = &infoAddr;
    aicTaskInfo->comm.argsSize = 1U;
    GetExceptionArgs(&taskInfo, &argsInfo);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, aicTaskInfo->inputArgsSize.atomicIndex);
    EXPECT_EQ(argsInfo.argsize, aicTaskInfo->comm.argsSize);

    GlobalMockObject::verify();
}

TEST_F(DavidTaskTest, CheckTaskCanSend_device_down)
{
    rtCmoTaskInfo_t cmoTask = {0};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.qos = 1;
    cmoTask.partId = 1;
    rtStream_t stream;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);

    Engine *engine = ((RawDevice *)(((Stream *)stream)->Device_()))->Engine_();
    engine->GetDevice()->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    rtError_t error = rtCmoTaskLaunch(&cmoTask, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);
    engine->GetDevice()->SetDevStatus(RT_ERROR_NONE);
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskTest, CheckTaskCanSend_abortStatus_abnormal)
{
    rtCmoTaskInfo_t cmoTask = {0};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.qos = 1;
    cmoTask.partId = 1;
    rtStream_t stream;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);

    ((Stream *)stream)->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    rtError_t error = rtCmoTaskLaunch(&cmoTask, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DEVICE_TASK_ABORT);
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskTest, get_connect_ub_flag_success)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    bool connectUbFlag = false;
    rtError_t err = GetConnectUbFlagFromDrv(connectUbFlag);
    EXPECT_EQ(err, RT_ERROR_NONE);
}

TEST_F(DavidTaskErrTest, get_connect_ub_flag_fail)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    bool connectUbFlag = false;
    rtError_t err = GetConnectUbFlagFromDrv(connectUbFlag);
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);
}

TEST_F(DavidTaskErrTest, get_connect_ub_flag_fail2)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtError_t err = rtInstance->InitSocType();
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);
}

TEST_F(DavidTaskTest, get_connect_ub_flag_fail3)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    MOCKER(GetHardVerBySocVer).stubs().will(invoke(stubGetHardVerBySocVerFail));
    rtError_t err = rtInstance->InitSocType();
    EXPECT_EQ(err, RT_ERROR_DRV_INPUT);
}

TEST_F(DavidTaskTest, get_connect_ub_flag_fail4)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    MOCKER(GetHardVerBySocVer).stubs().will(invoke(stubGetHardVerBySocVerNoDevice));
    rtError_t err = rtInstance->InitSocType();
    EXPECT_EQ(err, RT_ERROR_NONE);
}

TEST_F(DavidTaskTest, test_enter_failure0)
{
    rtStream_t stream;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);

    ((DavidStream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((DavidStream *)stream)->EnterFailureAbort();
    EXPECT_EQ(((DavidStream *)stream)->GetFailureMode(), 2);
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskTest, test_enter_failure1)
{
    rtStream_t stream;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);

    ((DavidStream *)stream)->Context_()->SetCtxMode(CONTINUE_ON_FAILURE);
    ((DavidStream *)stream)->SetContext(nullptr);
    ((DavidStream *)stream)->EnterFailureAbort();
    EXPECT_EQ(((DavidStream *)stream)->GetFailureMode(), 0);
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskTest, get_tseg_info_failed)
{
    Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER(halGetTsegInfoByVa).stubs().will(returnValue(1));
    rtError_t err = ((NpuDriver *)(driver_))->GetTsegInfoByVa(0, 0, 0, 0, nullptr);
    EXPECT_NE(err, RT_ERROR_NONE);
    MOCKER(halPutTsegInfo).stubs().will(returnValue(1));
    err = ((NpuDriver *)(driver_))->PutTsegInfo(0, nullptr);
    EXPECT_NE(err, RT_ERROR_NONE);
}