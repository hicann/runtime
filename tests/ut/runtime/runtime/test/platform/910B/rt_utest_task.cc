/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "event.hpp"
#include "scheduler.hpp"
#include "gtest/gtest.h"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "subscribe.hpp"
#include "task_res.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "barrier_task.h"
#include "count_notify.hpp"
#include "ffts_task.h"
#include "kernel.hpp"
#include <thread>
#include <chrono>
#include "ctrl_stream.hpp"
#include "ctrl_stream.hpp"
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "config.hpp"
#include "mockcpp/mockcpp.hpp"
#include "uma_arg_loader.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "profiler.hpp"
#include "profiler_struct.hpp"
#include "toolchain/prof_api.h"
#include "task_submit.hpp"
#include "thread_local_container.hpp"
#include "device/device_error_proc.hpp"
#include "memory_task.h"
#include "davinci_kernel_task.h"
#include "stub_task.hpp"
#include "para_convertor.hpp"

using namespace testing;
using namespace cce::runtime;

class CloudV2TaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::verify();
        (void)rtSetDevice(0);
        rtError_t error1 = rtStreamCreate((rtStream_t *)&stream_, 0);
        rtError_t error2 = rtEventCreate((rtEvent_t *)&event_);
        std::cout << "CloudV2TaskTest start: " << error1 << ", " << error2 << std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        std::cout << "CloudV2TaskTest: " << error1 << ", " << error2 << std::endl;
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    static Stream *stream_;
    static Event *event_;
};

Stream *CloudV2TaskTest::stream_ = NULL;
Event *CloudV2TaskTest::event_ = NULL;

drvError_t drvDeviceGetTransWay_cloud_v2_stub_1(void *src, void *dst, uint8_t *trans_type)
{
    drvError_t error = DRV_ERROR_NONE;
    *trans_type = RT_MEMCPY_CHANNEL_TYPE_PCIe;

    return error;
}

drvError_t drvDeviceGetTransWay_cloud_v2_stub_2(void *src, void *dst, uint8_t *trans_type)
{
    drvError_t error = DRV_ERROR_NONE;
    *trans_type = RT_MEMCPY_CHANNEL_TYPE_HCCs;

    return error;
}

rtError_t MemCopySync_cloud_v2_stub(NpuDriver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size,
                                    rtMemcpyKind_t kind)
{
    memcpy(dst, src, destMax);
    return RT_ERROR_NONE;
}

TEST_F(CloudV2TaskTest, MemWaitModelIsNull)
{
    TaskInfo task = {};
    uint64_t devAddr = 0;
    task.stream = stream_;
    task.typeName = "EVENT_WAIT";
    task.type = TS_TASK_TYPE_CAPTURE_WAIT;
    rtError_t ret = MemWaitValueTaskInit(&task, (void *)(&devAddr), 0U, 0U);
    EXPECT_EQ(ret, RT_ERROR_MODEL_NULL);
}

TEST_F(CloudV2TaskTest, stream_IsReclaimAsync)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;
    TaskInfo tsk = {};
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    tsk.type = TS_TASK_TYPE_FFTS_PLUS;
    stream_var->IsReclaimAsync(&tsk);
    tsk.type = TS_TASK_TYPE_NOTIFY_WAIT;
    stream_var->IsReclaimAsync(&tsk);
    tsk.type = TS_TASK_TYPE_NOTIFY_RECORD;
    stream_var->IsReclaimAsync(&tsk);
    tsk.type = TS_TASK_TYPE_MEMCPY;
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    stream_var->IsReclaimAsync(&tsk);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2H;
    stream_var->IsReclaimAsync(&tsk);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_PCIe;
    stream_var->IsReclaimAsync(&tsk);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;
    stream_var->IsReclaimAsync(&tsk);
    error = rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_timeout_sqe)
{
    TaskInfo task = {};
    TaskInfo task1 = {};
    rtError_t error;
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe1, sqe2;
    InitByStream(&task, stream_);
    TimeoutSetTaskInit(&task, RT_TIMEOUT_TYPE_OP_EXECUTE, 10);
    ToConstructSqe(&task, &sqe1);
    Complete(&task, 0);

    InitByStream(&task1, stream_);
    AicTaskInit(&task1, Program::MACH_AI_VECTOR, 1, 1, nullptr);
    ToConstructSqe(&task1, &sqe2);

    TaskCfg taskcfg = {};
    taskcfg.isBaseValid = 1U;
    taskcfg.base.dumpflag = RT_KERNEL_DUMPFLAG;
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, &taskcfg);
    EXPECT_EQ(task.u.aicTaskInfo.comm.kernelFlag, RT_KERNEL_DUMPFLAG);

    LaunchTaskCfgInfo_t launchTaskCfg = {};
    launchTaskCfg.dumpflag = RT_KERNEL_DUMPFLAG;
    AicTaskInitV2(&task, Program::MACH_AI_CORE, 1, 1, &launchTaskCfg);
    EXPECT_EQ(task.u.aicTaskInfo.comm.kernelFlag, RT_KERNEL_DUMPFLAG);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_1)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe;

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_2)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe;

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_3)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe;

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_4)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe;

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_biu)
{
    TaskInfo task = {};
    rtError_t error;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtInstance->SetBiuperfProfFlag(true);
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;

    InitByStream(&task, stream_);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_OUT_MEMORY));
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);
}

TEST_F(CloudV2TaskTest, stars_mix_sqe_l2_cache)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtInstance->SetL2CacheProfFlag(true);
    error = rtSetOpExecuteTimeOut(10);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe;

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_eventreset_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    Event evt;
    evt.device_ = stream_->Device_();
    uint32_t event_id = 0;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    EventResetTaskInit(&task, &evt, false, event_id);
    evt.EventIdCountAdd((task.u.eventResetTaskInfo).eventid);
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

//Memcpy Async D2D and H2D
TEST_F(CloudV2TaskTest, stars_memcpy_async_sqe_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    task.u.memcpyAsyncTaskInfo.copyDataType = RT_DATA_TYPE_BFP16;
    (void)ReduceOpcodeHigh(&task);
}

//Memcpy Async Addr D2D
TEST_F(CloudV2TaskTest, stars_memcpy_async_sqe_addr_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_ADDR_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV1(&task, src, count);
    ToConstructSqe(&task, &sqe);

    Complete(&task, 0);
    TaskUnInitProc(&task);

    rtStreamDestroy(stream);
}

//Memcpy Async Addr D2h dsa update
TEST_F(CloudV2TaskTest, stars_memcpy_async_dsa_sqe_d2h)
{
    void *src = nullptr;
    uint64_t cnt = 40U;
    uint32_t dsaStreamId = 2U;
    uint32_t dsaTaskId = 2U;

    TaskInfo task = {};
    rtError_t error;

    rtStarsSqe_t command;
    InitByStream(&task, (Stream *)stream_);
    MemcpyAsyncD2HTaskInit(&task, src, cnt, dsaStreamId, dsaTaskId);
    EXPECT_EQ(task.type, TS_TASK_TYPE_MEMCPY);
    ToConstructSqe(&task, &command);
    RtStarsMemcpyAsyncSqe *sqe = &(command.memcpyAsyncSqe);

    Complete(&task, 0);
    EXPECT_EQ(sqe->header.type, RT_STARS_SQE_TYPE_PCIE_DMA);
    TaskUnInitProc(&task);
}

TEST_F(CloudV2TaskTest, stars_memcpy2d_async_sqe_addr_h2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    uint64_t size = 1000;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV2(&task, dst, size, src, size, size, 1, kind, size);
    ToConstructSqe(&task, &sqe);

    Complete(&task, 0);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, memcpy2d_async_sqe_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    uint64_t size = 1000;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV2(&task, dst, size, src, size, size, 1, kind, size);
    ToConstructSqe(&task, &sqe);

    Complete(&task, 0);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_memcpy2d_async_sqe_addr_d2h)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_HOST;
    uint64_t size = 1000;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV2(&task, dst, size, src, size, size, 1, kind, size);
    ToConstructSqe(&task, &sqe);

    Complete(&task, 0);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

//StreamLabelSwitchByIndexTask task ConstructSqe
TEST_F(CloudV2TaskTest, label_switch_by_index_sqe)
{
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task = {};
    uint64_t ptr = 0;
    uint32_t max = 1;
    uint32_t labelInfoPtr[16] = {};
    rtStarsSqe_t sqe[2];

    InitByStream(&task, (Stream *)stream);
    error = StreamLabelSwitchByIndexTaskInit(&task, (void *)&ptr, max, (void *)labelInfoPtr);
    ToConstructSqe(&task, (rtStarsSqe_t *)sqe);
    Complete(&task, 0);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, stars_ipc_notify_record_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    SingleBitNotifyRecordInfo single_bit_notify_info = {false, false, false, false, 0, 0, false};
    NotifyRecordTaskInit(&task, 0, 0, 0, &single_bit_notify_info, nullptr, nullptr, false);

    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

TEST_F(CloudV2TaskTest, cmoAddrTaskInfo_ConstructSqe)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    Device *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    rtError_t error = device->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo cmoAddrTask = {};
    InitByStream(&cmoAddrTask, stream);
    EXPECT_NE(cmoAddrTask.stream, nullptr);
    rtCmoAddrInfo *cmoAddrInfo;
    cmoAddrTask.u.cmoAddrTaskInfo.cmoAddrInfo = reinterpret_cast<void *>(cmoAddrInfo);
    rtCmoOpCode_t cmoOpCode = RT_CMO_PREFETCH;
    error = CmoAddrTaskInit(&cmoAddrTask, reinterpret_cast<void *>(cmoAddrInfo), cmoOpCode);
    EXPECT_EQ(error, RT_ERROR_MODEL_NULL);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&cmoAddrTask, &sqe);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    ToConstructSqe(&cmoAddrTask, &sqe);
    TaskUnInitProc(&cmoAddrTask);
    delete stream;
    delete device;
}

TEST_F(CloudV2TaskTest, CmoTask_test_ex)
{
    rtError_t error;
    TaskInfo task = {};
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    InitByStream(&task, stream);
    EXPECT_NE(task.stream, nullptr);
    rtCmoTaskInfo_t cmoTask = {};
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    error = CmoTaskInit(&task, &cmoTask, stream, 0);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);
    EXPECT_EQ(task.type, TS_TASK_TYPE_CMO);
    TaskUnInitProc(&task);
    delete stream;
    delete device;
}

TEST_F(CloudV2TaskTest, CmoTask_for_prefetch_test)
{
    rtError_t error;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtModel_t model;
    rtError_t ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream_->SetModel(static_cast<Model *>(model));
    stream_->SetLatestModlId(static_cast<Model *>(model)->Id_());
    TaskInfo task = {};
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    rtCmoTaskInfo_t cmoTask = {};
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);
    Model *tmpModel = stream_->Model_();
    stream_->models_.clear();
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetModel(tmpModel);
    stream_->SetLatestModlId(tmpModel->Id_());
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    TaskUnInitProc(&task);
}

TEST_F(CloudV2TaskTest, CmoAddrTask_for_prefetch_test)
{
    rtError_t error;
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    TaskInfo task = {};
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    // 1971 model stream
    rtCmoAddrInfo cmoAddrInfo;
    rtCmoOpCode_t cmoOpCode;
    error = memset_s(&cmoAddrInfo, sizeof(rtCmoAddrInfo), 0U, sizeof(rtCmoAddrInfo));
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *tmpModel = stream_->Model_();
    stream_->models_.clear();
    // single stream cmoAddrTask init
    error = CmoAddrTaskInit(&task, reinterpret_cast<void *>(&cmoAddrInfo), cmoOpCode);
    EXPECT_EQ(error, RT_ERROR_MODEL_NULL);

    // model stream cmoAddrTask init
    stream_->SetModel(tmpModel);
    stream_->SetLatestModlId(tmpModel->Id_());
    error = CmoAddrTaskInit(&task, reinterpret_cast<void *>(&cmoAddrInfo), cmoOpCode);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // ConstructCmoAddrSqe
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    // printErrorInfo
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    PrintErrorInfo(&task, 0);
    TaskUnInitProc(&task);
}

TEST_F(CloudV2TaskTest, BuildMultipleTaskSqe)
{
    RawDevice *device = new RawDevice(0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(loader, &UmaArgLoader::LoadCpuKernelArgs).stubs().will(returnValue(0));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->Setup();
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

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_MULTIPLE_TASK, errCode);
    EXPECT_NE(task, nullptr);

    rtStarsSqe_t sqe[2];
    InitByStream(task, (Stream *)stream);
    DavinciMultipleTaskInit(task, &multipleTaskInfo, 0U);

    ToConstructSqe(task, sqe);
    auto taskNum = GetSendSqeNum(task);
    EXPECT_EQ(taskNum, 2);

    DecMultipleTaskCqeNum(task);
    DecMultipleTaskCqeNum(task);
    DecMultipleTaskCqeNum(task);
    auto multipleTaskCqeNum = GetMultipleTaskCqeNum(task);
    for (int i = 0; i <= 0xFF; i++) {
        IncMultipleTaskCqeNum(task);
    }
    DecMultipleTaskCqeNum(task);
    multipleTaskCqeNum = GetMultipleTaskCqeNum(task);
    EXPECT_EQ(multipleTaskCqeNum, 0xfe);
    uint8_t sqeType = 1;
    uint8_t errorType = 2;
    uint32_t errorCode = 3;
    SetMultipleTaskCqeErrorInfo(task, sqeType, errorType, errorCode);
    SetMultipleTaskCqeErrorInfo(task, sqeType, errorType + 1, errorCode + 1);
    volatile uint8_t sqeType_ = 0;
    volatile uint8_t errorType_ = 0;
    volatile uint32_t errorCode_ = 0;
    GetMultipleTaskCqeErrorInfo(task, sqeType_, errorType_, errorCode_);
    EXPECT_EQ(sqeType_, 1);
    EXPECT_EQ(errorType_, 3);
    EXPECT_EQ(errorCode_, 7);

    errorType_ = task->u.davinciMultiTaskInfo.errorType;
    EXPECT_EQ(errorType_, 3);
    SetMultipleTaskCqeErrorInfo(task, 12, errorType + 1, errorCode + 1);
    task->u.davinciMultiTaskInfo.hasUnderstudyTask = false;
    auto hasUnderstudyTask = task->u.davinciMultiTaskInfo.hasUnderstudyTask;
    EXPECT_EQ(hasUnderstudyTask, false);
    task->u.davinciMultiTaskInfo.hasUnderstudyTask = true;
    hasUnderstudyTask = task->u.davinciMultiTaskInfo.hasUnderstudyTask;
    EXPECT_EQ(hasUnderstudyTask, true);

    rtFree(devPtr);
    device->GetTaskFactory()->Recycle(task);
    delete loader;
    delete stream;
    delete device;
}

TEST_F(CloudV2TaskTest, BuildMultipleTaskSqeDvpp_RuntimeNotFree)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    rtError_t errorRet;
    rtTaskDesc_t taskDesc[1];
    rtMultipleTaskInfo_t multipleTaskInfo = {};
    multipleTaskInfo.taskNum = sizeof(taskDesc) / sizeof(taskDesc[0]);
    multipleTaskInfo.taskDesc = taskDesc;
    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14;
    taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // for dvpp rr, add 3 write value
    taskDesc[0].u.dvppTaskDesc.sqe.commandCustom[12] = 0;
    taskDesc[0].u.dvppTaskDesc.sqe.commandCustom[13] = 0;

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_MULTIPLE_TASK, errCode);
    EXPECT_NE(task, nullptr);
    rtStarsSqe_t sqe;

    InitByStream(task, (Stream *)stream);
    DavinciMultipleTaskInit(task, &multipleTaskInfo, 0x40U);

    ToConstructSqe(task, &sqe);
    auto taskNum = GetSendSqeNum(task);
    EXPECT_EQ(taskNum, 1);
    WaitAsyncCopyComplete(task);

    rtFree(devPtr);
    void *cmdList;
    rtMalloc(&cmdList, 20, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    task->u.davinciMultiTaskInfo.cmdListVec->push_back(cmdList);
    device->GetTaskFactory()->Recycle(task);
    rtFree(cmdList);
    delete stream;
    delete device;
}

TEST_F(CloudV2TaskTest, BuildMultipleTaskSqeDvpp_RuntimeFree)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    rtError_t errorRet;
    rtTaskDesc_t taskDesc[1];
    rtMultipleTaskInfo_t multipleTaskInfo = {};
    multipleTaskInfo.taskNum = sizeof(taskDesc) / sizeof(taskDesc[0]);
    multipleTaskInfo.taskDesc = taskDesc;
    void *devPtr;
    rtMalloc(&devPtr, 16, RT_MEMORY_HBM, DEFAULT_MODULEID);
    taskDesc[0].type = RT_MULTIPLE_TASK_TYPE_DVPP;
    taskDesc[0].u.dvppTaskDesc.sqe.sqeHeader.type = 14;
    taskDesc[0].u.dvppTaskDesc.aicpuTaskPos = 1 + 3;  // // for dvpp rr, add 3 write value
    taskDesc[0].u.dvppTaskDesc.sqe.commandCustom[12] = 0;
    taskDesc[0].u.dvppTaskDesc.sqe.commandCustom[13] = 0;

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_MULTIPLE_TASK, errCode);
    EXPECT_NE(task, nullptr);
    rtStarsSqe_t sqe;

    InitByStream(task, (Stream *)stream);
    DavinciMultipleTaskInit(task, &multipleTaskInfo, 0x0U);

    ToConstructSqe(task, &sqe);
    auto taskNum = GetSendSqeNum(task);
    EXPECT_EQ(taskNum, 1);
    WaitAsyncCopyComplete(task);

    rtFree(devPtr);
    void *cmdList;
    rtMalloc(&cmdList, 20, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    task->u.davinciMultiTaskInfo.cmdListVec->push_back(cmdList);
    device->GetTaskFactory()->Recycle(task);
    delete stream;
    delete device;
}

class CloudV2TaskTest1 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend950PR_9599");
        (void)rtSetDevice(0);
        std::cout << "task test start: " << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "task test1 end" << std::endl;
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(CloudV2TaskTest1, load_args_is_pcie_bar)
{
    rtError_t error;
    uint32_t taskId = 0U;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId).stubs().will(returnValue((TaskInfo *)&kernTask1));
    rtArgsEx_t argsInfo = {};
    kernTask.u.aicTaskInfo.argsInfo = &argsInfo;


    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);

    kernTask.type = TS_TASK_TYPE_KERNEL_AICPU;
    kernTask.u.aicpuTaskInfo.argsInfo = nullptr;
    rtAicpuArgsEx_t aicpuArgsInfo = {};
    kernTask.u.aicpuTaskInfo.aicpuArgsInfo = &aicpuArgsInfo;
    kernTask.u.aicpuTaskInfo.kernel = nullptr;
    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);


    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test1)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    kernTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    kernTask1.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId).stubs().will(returnValue((TaskInfo *)&kernTask1));

    rtArgsEx_t argsInfo = {};
    kernTask.u.aicTaskInfo.argsInfo = &argsInfo;


    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);

    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test2)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId).stubs().will(returnValue((TaskInfo *)&kernTask1));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_STREAM_FULL));
    MOCKER_CPP(&TaskFactory::Recycle).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev_, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));


    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);

    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test3)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId).stubs().will(returnValue((TaskInfo *)&kernTask1));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_STREAM_FULL));


    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);

    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test4)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId).stubs().will(returnValue((TaskInfo *)&kernTask1));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));


    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);
    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test5)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId)
        .stubs()
        .will(returnValue((TaskInfo *)NULL))
        .then(returnValue((TaskInfo *)&kernTask1));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    MOCKER_CPP_VIRTUAL(dev_, &Device::GetDevRunningState).stubs().will(returnValue((uint32_t)DEV_RUNNING_NORMAL));

    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_NE(error, RT_ERROR_NONE);
    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, AllocTaskAndSendStars_test6)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId)
        .stubs()
        .will(returnValue((TaskInfo *)NULL))
        .then(returnValue((TaskInfo *)&kernTask1));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    stream_->isHasPcieBar_ = true;
    MOCKER_CPP_VIRTUAL(dev_, &Device::GetDevRunningState).stubs().will(returnValue((uint32_t)DEV_RUNNING_NORMAL));

    stream_->abortStatus_ = RT_ERROR_STREAM_ABORT;
    error = AllocTaskAndSendStars(&kernTask, stream_, &taskId);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT);
    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, SubmitTaskStars_test2)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    uint32_t taskId = 0U;
    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    MOCKER(AllocTaskAndSendStars).stubs().will(returnValue(RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL));
    MOCKER(AllocAndSendFlipTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(10U)));
    MOCKER_CPP(&Engine::ProcessTask).stubs().will(returnValue(false));

    kernTask.isNeedStreamSync = true;
    stream_->SetBindFlag(true);

    error = SubmitTaskStars(&kernTask, stream_, &taskId, 0U);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    TaskUnInitProc(&kernTask);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, SubmitTaskDc_test)
{
    rtError_t error;
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    TaskInfo kernTask1 = {};
    uint32_t taskId = 0U;

    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);
    InitByStream(&kernTask1, stream_);
    (void)MaintenanceTaskInit(&kernTask, MT_STREAM_RECYCLE_TASK, 100U, 1U);
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    MOCKER(TaskCommonInfoInit).stubs();
    MOCKER(SetTaskTag).stubs();
    MOCKER(GetSendSqeNum).stubs().will(returnValue(static_cast<uint32_t>(1U)));
    stream_->SetLimitFlag(0U);
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId)
        .stubs()
        .will(returnValue(static_cast<TaskInfo *>(nullptr)))
        .then(returnValue(static_cast<TaskInfo *>(&kernTask1)));
    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    stream_->isHasPcieBar_ = true;
    MOCKER_CPP_VIRTUAL(dev_, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(DEV_RUNNING_NORMAL)));
    MOCKER(AllocTaskAndSendDc).stubs().will(returnValue(RT_ERROR_NONE));
    kernTask.id = 255U;
    kernTask.isNeedStreamSync = false;
    error = SubmitTaskDc(&kernTask, stream_, &taskId, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskUnInitProc(&kernTask);
    TaskUnInitProc(&kernTask1);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, constructSqeBarrierTask)
{
    NpuDriver drv;
    Device *dev_ = new RawDevice(0);
    dev_->Init();
    Stream *stream_ = new Stream(dev_, 0);
    stream_->Setup();
    ((RawDevice *)dev_)->driver_ = &drv;
    TaskInfo kernTask = {};
    uint32_t taskId = 0U;

    stream_->device_ = dev_;
    InitByStream(&kernTask, stream_);

    kernTask.u.barrierTask.barrierMsg.cmoIdNum = 1;
    rtStarsSqe_t command;
    (void)ConstructSqeForBarrierTask(&kernTask, &command);
    EXPECT_NE(&kernTask, nullptr);
    delete stream_;
    delete dev_;
}

TEST_F(CloudV2TaskTest1, TryToGetCallbackSqCqId)
{
    GlobalMockObject::verify();

    CbSubscribe *cbSubscribe = new (std::nothrow) CbSubscribe(static_cast<uint32_t>(RT_THREAD_GROUP_ID_MAX));
    ASSERT_NE(cbSubscribe, nullptr);

    NpuDriver drv;
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    dev->driver_ = &drv;
    Stream *stm = new (std::nothrow) Stream(dev, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_SYNC, nullptr);
    ASSERT_NE(stm, nullptr);

    const uint64_t threadId = 0x1234;
    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    const int32_t streamId = stm->Id_();
    const uint32_t key = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId);

    cbSubscribeInfo info;
    info.threadId = threadId;
    info.stream = stm;
    info.sqId = 10U;
    info.cqId = 20U;
    info.groupId = 1;
    info.u.event = nullptr;

    cbSubscribe->subscribeMapByThreadId_[threadId][key][streamId] = info;

    uint32_t outSq = 0;
    uint32_t outCq = 0;
    bool ok = cbSubscribe->TryToGetCallbackSqCqId(threadId, stm, &outSq, &outCq);
    EXPECT_EQ(ok, true);
    EXPECT_EQ(outSq, 10U);
    EXPECT_EQ(outCq, 20U);

    // missing threadId
    ok = cbSubscribe->TryToGetCallbackSqCqId(threadId + 1, stm, &outSq, &outCq);
    EXPECT_EQ(ok, false);

    // missing entry for this thread
    cbSubscribe->subscribeMapByThreadId_.clear();
    ok = cbSubscribe->TryToGetCallbackSqCqId(threadId, stm, &outSq, &outCq);
    EXPECT_EQ(ok, false);

    // missing devId/tsId key
    cbSubscribe->subscribeMapByThreadId_[threadId][key][streamId] = info;
    RawDevice *dev2 = new RawDevice(2);
    dev2->Init();
    dev2->driver_ = &drv;
    Stream *stm2 = new (std::nothrow) Stream(dev2, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_SYNC, nullptr);
    ASSERT_NE(stm2, nullptr);
    ok = cbSubscribe->TryToGetCallbackSqCqId(threadId, stm2, &outSq, &outCq);
    EXPECT_EQ(ok, false);

    // valid key but empty inner map
    const uint32_t devId2 = stm2->Device_()->Id_();
    const uint32_t tsId2 = stm2->Device_()->DevGetTsId();
    const uint32_t key2 = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId2, devId2);
    // Explicitly create empty map for key2
    (void)cbSubscribe->subscribeMapByThreadId_[threadId][key2];
    ok = cbSubscribe->TryToGetCallbackSqCqId(threadId, stm2, &outSq, &outCq);
    EXPECT_EQ(ok, false);

    delete stm2;
    delete dev2;

    delete cbSubscribe;
    delete stm;
    delete dev;
}

TEST_F(CloudV2TaskTest1, AicpuKernelArgsRelease)
{
    TaskInfo task = {};
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    Stream *stm = new (std::nothrow) Stream(dev, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_DEFAULT, nullptr);
    task.stream = stm;
    AicpuTaskInit(&task, 1U, 0U);

    AicpuTaskInfo *aicpuTaskInfo = &(task.u.aicpuTaskInfo);
    aicpuTaskInfo->kernel = nullptr;
    aicpuTaskInfo->comm.argHandle = reinterpret_cast<void*>(0x1U);

    MOCKER_CPP_VIRTUAL(stm, &Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(true));
    DavinciTaskUnInit(&task);
    stm->SetArgHandle(reinterpret_cast<void*>(0x0U));

    delete stm;
    delete dev;
}

TEST_F(CloudV2TaskTest1, AicpuKernelArgsRelease2)
{
    TaskInfo task = {};
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    Stream *stm = new (std::nothrow) Stream(dev, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_DEFAULT, nullptr);
    task.stream = stm;
    AicpuTaskInit(&task, 1U, 0U);

    AicpuTaskInfo *aicpuTaskInfo = &(task.u.aicpuTaskInfo);
    aicpuTaskInfo->kernel = nullptr;
    aicpuTaskInfo->comm.argHandle = reinterpret_cast<void*>(0x1U);

    MOCKER_CPP_VIRTUAL(stm, &Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(dev->ArgLoader_(), &ArgLoader::Release).stubs().will(returnValue(RT_ERROR_NONE));
    DavinciTaskUnInit(&task);

    delete stm;
    delete dev;
}
