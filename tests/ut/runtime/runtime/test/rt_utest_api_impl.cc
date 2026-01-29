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
#include "driver/ascend_hal.h"
#define private public
#include "runtime/rt.h"
#include "securec.h"
#include "context.hpp"
#include "raw_device.hpp"
#include "event.hpp"
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "module.hpp"
#include "program.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "stream.hpp"
#include "task_res.hpp"
#include "task_submit.hpp"
#include "api.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "logger.hpp"
#include "dqs/task_dqs.hpp"
#include "stub_task.hpp"
#include "device_error_proc.hpp"
#undef private
#include <string>
#include "driver/ascend_hal.h"
#include "device_msg_handler.hpp"
#include "ttlv.hpp"
#include "model.hpp"
#include "task_info.hpp"
#include "platform/platform_info.h"
#include "soc_info.h"
#include "config_define.hpp"
#include "api_impl_david.hpp"
#include "thread_local_container.hpp"
#include "stream_c.hpp"
#include "fast_recover.hpp"
#include "rts.h"
#include "rts_snapshot.h"
#include "ipc_event.hpp"
using namespace testing;
using namespace cce::runtime;

extern bool g_init_platform_info_flag;
extern bool g_get_platform_info_flag;
class ApiImplTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"ApiImplTest test start start. "<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiImplTest test start end. "<<std::endl;

    }

    virtual void SetUp()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetDevice(0);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
private:
    bool isErrorNone_ = true;
};

static void ApiImplTest_Stream_Cb(void *arg)
{
}

TEST_F(ApiImplTest, dev_binary_register_test)
{
    ApiImpl apiImpl;
    rtError_t error;
    rtDevBinary_t *bin = (rtDevBinary_t *)malloc(sizeof(rtDevBinary_t));
    Program *program_ = (Program *)malloc(sizeof(Program));

    bin->magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin->version = 1;

    MOCKER_CPP(&Runtime::ProgramRegister).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = apiImpl.DevBinaryRegister(bin, &program_);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiImpl.BinaryRegisterToFastMemory(program_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(bin);
    free(program_);
}


TEST_F(ApiImplTest, KERNEL_CONFIG_DUMP_TEST_2)
{
	ApiImpl apiImpl;
    rtError_t error;
    uint32_t kind = 1;
	uint32_t dumpSizePerBlock = 1;
	uint32_t blockDim = 1;
	char * devMem = (char *)malloc(sizeof(char));
	void * dumpBaseAddr_ = devMem;
	void **dumpBaseAddr = &dumpBaseAddr_;
    NpuDriver drv;

	MOCKER_CPP_VIRTUAL(drv,&NpuDriver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = drv.DevMemAlloc((void **)NULL, 100, (rtMemType_t)0, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
	free(devMem);
}

TEST_F(ApiImplTest, KERNEL_CONFIG_DUMP_TEST_3)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t devId = 0;
    rtContext_t ctx;
    uint32_t flag = 0;
    uint32_t kind = 0;
    uint32_t dumpSizePerBlock = 1;
    uint32_t blockDim = 1;
    char * devMem = (char *)malloc(sizeof(char));
    void * dumpBaseAddr_ = devMem;
    void **dumpBaseAddr = &dumpBaseAddr_;
    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(devMem);
}

TEST_F(ApiImplTest, KERNEL_CONFIG_DUMP_TEST_4)
{
	ApiImpl apiImpl;
    rtError_t error;
    uint32_t kind = 1;
	uint32_t dumpSizePerBlock = 1;
	uint32_t blockDim = 1;
	char * devMem = (char *)malloc(sizeof(char));
	void * dumpBaseAddr_ = devMem;
	void **dumpBaseAddr = &dumpBaseAddr_;
    NpuDriver drv;

	MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemAddressTranslate).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = drv.MemAddressTranslate(0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
	free(devMem);
}

TEST_F(ApiImplTest, stream_create_1)
{
	ApiImpl apiImpl;
    rtError_t error;

	int32_t temp = 1;
	rtStream_t stream_ = &temp;
	rtStream_t *result = &stream_;
	int32_t priority = 1;

	MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));

	error = apiImpl.StreamCreate((Stream**)result, priority, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_CONTEXT_NULL);
}

#if 0
TEST_F(ApiImplTest, notify_record_ctx_null)
{

    rtNotify_t notify;
    ApiImpl apiImpl;
    rtError_t error;
    int32_t device_id = 0;
    rtStream_t stream;
    Stream * stream_ = NULL;

    error = apiImpl.NotifyCreate(device_id, (Notify **)&notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    stream_ = (Stream *)stream;

    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));

    error = apiImpl.NotifyRecord((Notify *)notify, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.NotifyWait((Notify *)notify, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.NotifyDestroy((Notify *)notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
#endif

TEST_F(ApiImplTest, kernel_transarg_set_test_online)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint64_t size = 1;
    uint32_t flag = 1;
    const void *ptr = &size;
    void *arg_ = nullptr;
    void **arg = &arg_;
    NpuDriver drv;

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    error = apiImpl.KernelTransArgSet(ptr, size, flag, arg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*arg, ptr);
}

TEST_F(ApiImplTest, kernel_transarg_set_test_offline)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint64_t size = 1;
    uint32_t flag = 1;
    const void *ptr = &size;
    void *arg_ = nullptr;
    void **arg = &arg_;
    NpuDriver drv;

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));
    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_NONE));

    error = apiImpl.KernelTransArgSet(ptr, size, flag, arg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*arg, ptr);
}

TEST_F(ApiImplTest, kernel_transarg_set_test_offline_flush_failed)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint64_t size = 1;
    uint32_t flag = 1;
    const void *ptr = &size;
    void *arg_ = nullptr;
    void **arg = &arg_;
    NpuDriver drv;

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));
    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = apiImpl.KernelTransArgSet(ptr, size, flag, arg);
    EXPECT_NE(error, RT_ERROR_NONE);
}

#if 0
TEST_F(ApiImplTest, ReduceAsync_error_01)
{
    rtError_t error;
    rtStream_t streamA;
    uint64_t buff_size = 100;

    error = rtStreamCreate(&streamA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t *devMemSrc = NULL;
    uint32_t *devMem = NULL;

    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    error = rtReduceAsync(devMem,
                          0,
                          (const void *)devMemSrc,
                          buff_size,
                          RT_MEMCPY_SDMA_AUTOMATIC_ADD,
                          RT_DATA_TYPE_FP32,
                          streamA);
    EXPECT_NE(error, RT_ERROR_NONE);

     error = rtStreamDestroy(streamA);
     EXPECT_NE(error, RT_ERROR_NONE);
}
#endif

TEST_F(ApiImplTest, context_create_test_fail)
{
    ApiImpl apiImpl;
    rtError_t error;
    rtContext_t ctx = NULL;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);

    MOCKER_CPP_VIRTUAL(&apiImpl, &ApiImpl::ContextSetCurrent).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    dev->WaitCompletion();

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(ApiImplTest, context_create_test_fail2)
{
    ApiImpl apiImpl;
    rtError_t error;
    rtContext_t ctx = NULL;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP(&Context::OnlineStreamInit).stubs().will(returnValue(RT_ERROR_STREAM_NEW));
    error = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);

    dev->WaitCompletion();

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

namespace cce {
namespace runtime {
extern bool g_isAddrFlatDevice;
} // runtime
} // cce

TEST_F(ApiImplTest, DEVICE_SET_TS_ID)
{
    ApiImpl apiImpl;
    rtError_t error;

    uint32_t tsId = 0;
    error = apiImpl.DeviceSetTsId(tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, NAME_EVENT_TEST_3)
{
    rtError_t error;
    int32_t device = 0;
    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime::Instance()->SetDefaultDeviceId(0xFFFFFFFF);
    error = rtGetDevice(&device);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);
    error = rtSetDevice(0);
}


TEST_F(ApiImplTest, HOST_MALLOC_TEST)
{
    rtError_t error;
    Api *Api_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(Api_);
    void * hostPtr;
    rtMallocConfig_t *malloCfg = (rtMallocConfig_t *)malloc(sizeof(rtMallocConfig_t));
    rtMallocAttribute_t* mallocAttrs = new rtMallocAttribute_t[1];
    malloCfg->numAttrs = 1;
    malloCfg->attrs = mallocAttrs;
    mallocAttrs[0].attr = RT_MEM_MALLOC_ATTR_MODULE_ID;
    mallocAttrs[0].value.moduleId = 1;
    error = apiDecorator_->HostMallocWithCfg(&hostPtr, 60, malloCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete[] mallocAttrs;
    free(malloCfg);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, CPU_KERNEL_LAUNCH_DUMP)
{
    rtError_t error;
    rtStream_t stream;

    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    error = rtCpuKernelLaunchWithFlag(NULL, NULL, 1, NULL, NULL, NULL,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    std::string soName = "libDvpp.so";
    std::string kernelName = "DvppResize";
    error = rtCpuKernelLaunchWithFlag(reinterpret_cast<const void *>(soName.c_str()),
                              reinterpret_cast<const void *>(kernelName.c_str()),
                              1, NULL, NULL, NULL,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream0 = (Stream *)stream;
    Context *context0 = (Context *)stream0->Context_();
    stream0->SetContext((Context *)NULL);

    error = rtCpuKernelLaunchWithFlag(reinterpret_cast<const void *>(soName.c_str()),
                              reinterpret_cast<const void *>(kernelName.c_str()),
                              1, &argsInfo, NULL, stream,2);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCpuKernelLaunchWithFlag(reinterpret_cast<const void *>(soName.c_str()),
                              reinterpret_cast<const void *>(kernelName.c_str()),
                              1, &argsInfo, NULL, stream, 0xff);
    EXPECT_NE(error, RT_ERROR_NONE);

    stream0->SetContext(context0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, rtSetDeviceEx)
{
    rtError_t error;
    error = rtSetDeviceEx(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiImplTest, rtDeviceResetEx)
{
    rtError_t error;
    error = rtDeviceResetEx(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiImplTest, rtCtxCreateEx)
{
    rtError_t error;
    error = rtCtxCreateEx(NULL, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiImplTest, rtSetDeviceWithoutTsd)
{
    rtError_t error;
    error = rtSetDeviceWithoutTsd(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiImplTest, rtDeviceResetWithoutTsd)
{
    rtError_t error;
    error = rtDeviceResetWithoutTsd(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

static bool g_disableThread;
static rtChipType_t g_chipType;
extern int64_t g_device_driver_version_stub;

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_950PR_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

rtError_t GetRunModeStub(cce::runtime::ApiImpl *api, rtRunMode *mode)
{
    *mode = RT_RUN_MODE_ONLINE;
    return RT_ERROR_NONE;
}

rtError_t MemCopySyncStub(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy_s(dst, destMax, src, size);
    return DRV_ERROR_NONE;
}

void GetMsgCallbackStub(const char *msg, uint32_t len) {}

rtError_t GetDevMsgTaskInitStub(TaskInfo *task, const void *devMemAddr, uint32_t devMemSize,
                                rtGetDevMsgType_t msgType)
{
    task->type = TS_TASK_TYPE_GET_DEVICE_MSG;
    if (devMemAddr != nullptr && devMemSize > sizeof(rtGetDevMsgCtrlInfo_t)) {
        rtGetDevMsgCtrlInfo_t *ctrlInfo = (rtGetDevMsgCtrlInfo_t *)devMemAddr;
        ctrlInfo->magic = DeviceMsgHandler::DEVICE_GET_MSG_MAGIC;
        ctrlInfo->pid = 0;
        ctrlInfo->bufferLen = sizeof(rtGetDevMsgCtrlInfo_t) + sizeof(rtStreamSnapshot_t);
    }
    return RT_ERROR_NONE;
}

rtError_t GetDevMsgSubmitTaskStub(RawDevice *dev, TaskInfo *task, rtTaskGenCallback callback)
{
    (void)dev->GetTaskFactory()->Recycle(task);
    return RT_ERROR_NONE;
}


TEST_F(ApiImplTest, rtGetDevMsgForRas)
{
    ApiImpl apiImpl;
    rtError_t error;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Context context(device, false);
    context.Init();
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));

    rtError_t ret = apiImpl.ProcError(RT_ERROR_MEM_RAS_ERROR);
    EXPECT_EQ(ret, RT_ERROR_CONTEXT_NULL);
}

TEST_F(ApiImplTest, GetDevErrMsg)
{
    ApiImpl apiImpl;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL((RawDevice *)device, &RawDevice::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));

    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP(&TTLV::Decode).stubs().will(returnValue(RT_ERROR_NONE));
    Context context(device, false);
    context.Init();
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

    rtError_t ret = apiImpl.GetDevErrMsg(GetMsgCallbackStub);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    ret = apiImpl.GetDevErrMsg(GetMsgCallbackStub);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL((RawDevice *)device, &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    ret = apiImpl.GetDevErrMsg(GetMsgCallbackStub);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete stream;
}

rtError_t GetDevMsgSubmitTaskStub1(Device *dev, TaskInfo *task, rtTaskGenCallback callback)
{
    (void)dev->GetTaskFactory()->Recycle(task);
    return RT_ERROR_NONE;
}

TEST_F(ApiImplTest, GetDevRunningStreamSnapshotMsg)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_AS31XM1);
    Stream *stream = new Stream((Device *)device, 0);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub1));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetDevMsg(RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, GetMsgCallbackStub);
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    delete stream;
}

rtError_t GetDevMsgTaskInitStubErr(TaskInfo* taskInfo, const void *const devMemAddr,
                            const uint32_t devMemSize,
                            const rtGetDevMsgType_t messageType)
{

    taskInfo->type = TS_TASK_TYPE_GET_DEVICE_MSG;
    taskInfo->typeName = "GET_DEVICE_MSG";
    taskInfo->u.getDevMsgTask.devMem = const_cast<void *>(devMemAddr);
    taskInfo->u.getDevMsgTask.msgBufferLen = devMemSize;
    taskInfo->u.getDevMsgTask.msgType = messageType;

    return RT_ERROR_INVALID_VALUE;
}

TEST_F(ApiImplTest, GetDevRunningStreamSnapshotMsg_failed)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);

    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStubErr));
        rtError_t ret = apiImpl.GetDevMsg(RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, GetMsgCallbackStub);
        EXPECT_NE(ret, RT_ERROR_NONE);
    }
    delete stream;
}
TEST_F(ApiImplTest, MemcpyKindAutoCorrect_01)
{
    rtError_t error;

    Api *oldApi = Runtime::runtime_->api_;
    ApiErrorDecorator *apiDecorator = new ApiErrorDecorator(oldApi);
    // H2D
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    rtMemLocationType srcLocationType = RT_MEMORY_LOC_HOST;
    rtMemLocationType dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //D2H
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    //H2H
    kind = RT_MEMCPY_HOST_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //D2D
    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    //X2D TEST
    //H2D-accuracy
    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2D-accuracy
    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //default
    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //H2Herror
    kind = RT_MEMCPY_HOST_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
  
    //D2X TEST
    //D2D
    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2H
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //default
    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //H2D-error
    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    //H2X TEST
    //H2H
    kind = RT_MEMCPY_HOST_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //H2D
    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //default
    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2H
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    //X2H TEST
    //H2H
    kind = RT_MEMCPY_HOST_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2H
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //default
    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2D-error
    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    //X2X TEST
    //H2H-accurancy
    kind = RT_MEMCPY_HOST_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //H2D-accurancy
    kind = RT_MEMCPY_HOST_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2H-accurancy
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2D-accurancy
    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    //D2D-accurancy
    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_UNREGISTERED;
    dstLocationType = RT_MEMORY_LOC_UNREGISTERED;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //other
    kind = RT_MEMCPY_ADDR_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    delete apiDecorator;
}

TEST_F(ApiImplTest, GetTaskIdAndStreamID)
{
    ApiImpl apiImpl;
    rtError_t error;

    uint32_t taskId = 0;
    uint32_t streamId = 0;

    error = apiImpl.GetTaskIdAndStreamID(&taskId, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Api *oldApi;
    oldApi = Runtime::runtime_->api_;
    ApiErrorDecorator *apiDecorator = new ApiErrorDecorator(oldApi);
    uint32_t taskIdLog = 0;
    uint32_t streamIdLog = 0;
    error = apiDecorator->GetTaskIdAndStreamID(&taskIdLog, &streamIdLog);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator;
}


TEST_F(ApiImplTest, GetDeviceCount_test)
{
    ApiImpl apiImpl;
    rtError_t error;

    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    bool isSetVisibleDev = rtInstance->isSetVisibleDev;
    uint32_t userDeviceCnt = rtInstance->userDeviceCnt;
    RtSetVisDevicesErrorType retType = RT_ALL_DATA_OK;
    int32_t  count = 0;

    rtInstance->isSetVisibleDev = true;
    rtInstance->userDeviceCnt = 0;
    rtInstance->retType = RT_GET_DRIVER_ERROR;
    error = apiImpl.GetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_DRV_NO_DEVICE);
    EXPECT_EQ(count, 0);

    rtInstance->retType = RT_ALL_DUPLICATED_ERROR;
    error = apiImpl.GetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_DRV_NO_DEVICE);
    EXPECT_EQ(count, 0);

    rtInstance->retType = RT_ALL_DATA_ERROR;
    error = apiImpl.GetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_DRV_NO_DEVICE);
    EXPECT_EQ(count, 0);

    rtInstance->userDeviceCnt = 1;
    rtInstance->retType = RT_ALL_DATA_OK;
    error = apiImpl.GetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(count, 1);
    rtInstance->isSetVisibleDev = isSetVisibleDev;
    rtInstance->userDeviceCnt = userDeviceCnt;
    rtInstance->retType = retType;
}

TEST_F(ApiImplTest, GetStreamTimeoutSnapshotMsg_test0)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    rtGetDevMsgCtrlInfo_t addr;
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub1));
    MOCKER_CPP_VIRTUAL(device, &Device::IsPrintStreamTimeoutSnapshot).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotAddr).stubs().will(returnValue(reinterpret_cast<void *>(&addr)));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotLen).stubs().will(returnValue(sizeof(rtGetDevMsgCtrlInfo_t)));
    MOCKER_CPP_VIRTUAL(device, &Device::PrintStreamTimeoutSnapshotInfo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetStreamTimeoutSnapshotMsg();
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
    delete stream;
}

TEST_F(ApiImplTest, GetStreamTimeoutSnapshotMsg_test1)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    rtGetDevMsgCtrlInfo_t addr;
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub1));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotAddr).stubs().will(returnValue(reinterpret_cast<void *>(&addr)));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotLen).stubs().will(returnValue(sizeof(rtGetDevMsgCtrlInfo_t)));
    MOCKER_CPP_VIRTUAL(device, &Device::PrintStreamTimeoutSnapshotInfo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetStreamTimeoutSnapshotMsg();
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
    delete stream;
}

TEST_F(ApiImplTest, GetStreamTimeoutSnapshotMsg_test2)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    rtGetDevMsgCtrlInfo_t addr;
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub1));
    MOCKER_CPP_VIRTUAL(device, &Device::IsPrintStreamTimeoutSnapshot).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotAddr).stubs().will(returnValue(reinterpret_cast<void *>(&addr)));
    MOCKER_CPP_VIRTUAL(device, &Device::GetSnapshotLen).stubs().will(returnValue(0U));
    MOCKER_CPP_VIRTUAL(device, &Device::PrintStreamTimeoutSnapshotInfo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetStreamTimeoutSnapshotMsg();
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
    delete stream;
}

TEST_F(ApiImplTest, ModelExecutorSet_test)
{
    ApiImpl apiImpl;
    rtModel_t model;
    rtModelCreate(&model, 0);
    rtError_t ret = apiImpl.ModelExecutorSet(static_cast<Model *>(model), 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, rtGetSocVersionFromDrvApi)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();

    char *socVer = "Ascend610Lite";
    // get socversion from halGetSocVersion
    MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), outBoundP(socVer, strlen("Ascend610Lite")), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));

    char res[128] = {0};
    rtError_t error = rtGetSocVersion(res, 128);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, rtSetSocVersionFeInitFailed)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();

    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0xF));
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtError_t error = rtSetSocVersion("Ascend610Lite");
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, rtSetSocVersionFeGetPlatformInfoFailed)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().will(returnValue(0xF));
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtError_t error = rtSetSocVersion("Ascend610Lite");
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, rtSetSocVersionFeGetPlatformInfoSuccess)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();
    fe::PlatformInfo platInfo;
    platInfo.soc_info.arch_type = ARCH_C100;
    platInfo.soc_info.chip_type = CHIP_CLOUD;
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().with(mockcpp::any(), outBound(platInfo), mockcpp::any())
        .will(returnValue(0U));
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtError_t error = rtSetSocVersion("Ascend910");
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, rtSetSocVersionFeGetPlatInfoInvalidChip)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();
    fe::PlatformInfo platInfo;
    platInfo.soc_info.arch_type = -1;
    platInfo.soc_info.chip_type = -1;
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().with(mockcpp::any(), outBound(platInfo), mockcpp::any())
        .will(returnValue(0U));
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtError_t error = rtSetSocVersion("Ascend910");
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, rtSetSocVersionFeGetPlatInfoInvalidArch)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtArchType_t archType = rtInstance->GetArchType();
    fe::PlatformInfo platInfo;
    platInfo.soc_info.arch_type = ARCH_V100;
    platInfo.soc_info.chip_type = CHIP_CLOUD;
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().with(mockcpp::any(), outBound(platInfo), mockcpp::any())
        .will(returnValue(0U));
    rtError_t error = rtSetSocVersion("BS9SX1AA");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetArchType(archType);
}

TEST_F(ApiImplTest, ut_GetSocVersionStrEx_null)
{
    rtError_t error = -1;
    rtSocType_t socType = SOC_END;
    const std::string ret = GetSocVersionStrByType(socType);
    EXPECT_EQ(ret == std::string(), true);
}

TEST_F(ApiImplTest, SetIpcMemPid_01)
{
    rtError_t error;
    char *name = nullptr;
    int32_t pid[] = {1};
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->SetIpcMemPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, SubcribeReport_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->SubscribeReport(123, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, CallbackLaunch_01)
{
    rtError_t error;
    rtCallback_t stub_func = (rtCallback_t)0x12345;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->CallbackLaunch(stub_func, nullptr, nullptr, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, ProcessReport_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->ProcessReport(100);
    EXPECT_EQ(error, RT_ERROR_SUBSCRIBE_THREAD);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, GetAicpuDeploy_01)
{
    rtError_t error;
    rtAicpuDeployType_t dtype = AICPU_DEPLOY_CROSS_OS;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->GetAicpuDeploy(&dtype);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, LabelSwitchByIndex_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->LabelSwitchByIndex(nullptr, 1, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, LabelCreateEx_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->LabelCreateEx(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, AllNotCoverPart1_01)
{
    rtError_t error;
    rtGroupType_t grpType = RT_GRP_TYPE_BIND_CP_CPU;
    rtEschedEventSummary_t evtSummary;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->EschedAttachDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->EschedDettachDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->EschedCreateGrp(0, 0, grpType);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->EschedSubmitEvent(0, &evtSummary);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtEventIdType_t evtType = RT_EVENT_TEST;
    error = apiDecorator_->EschedAckEvent(0, evtType, 0, "hello", 128);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, AllNotCoverPart1_02)
{
    rtError_t error;
    rtGroupType_t grpType = RT_GRP_TYPE_BIND_CP_CPU;
    rtEschedEventSummary_t evtSummary;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    uint32_t srvId = 0;
    error = apiDecorator_->GetServerIDBySDID(0, &srvId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->ModelNameSet(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->SetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->CtxGetCurrentDefaultStream(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->DeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, get_mem_info_by_type)
{
    rtError_t error;
    rtMemInfo_t memInfo;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    error = apiDecorator_->MemGetInfoByType(0, RT_MEM_INFO_TYPE_DDR_P2P_SIZE, &memInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator_->MemGetInfoByType(0, RT_MEM_INFO_TYPE_DDR_P2P_SIZE, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->MemGetInfoByType(0, RT_MEM_INFO_TYPE_MAX, &memInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, get_device_status)
{
    rtError_t error;
    rtDevStatus_t status;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    error = apiDecorator_->GetDeviceStatus(0, &status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, hdc_server_create)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->HdcServerCreate(0, RT_HDC_SERVICE_TYPE_TEST, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    rtHdcServer_t server = nullptr;
    error = apiDecorator_->HdcServerCreate(0, RT_HDC_SERVICE_TYPE_TEST, &server);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, hdc_server_destroy)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->HdcServerDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    rtHdcServer_t server = nullptr;
    error = apiDecorator_->HdcServerDestroy(&server);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, hdc_session_connect)
{
    rtError_t error;
    rtHdcClient_t client = &error;
    rtHdcSession_t session = nullptr;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->HdcSessionConnect(0, 0, nullptr, &session);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->HdcSessionConnect(0, 0, client, &session);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, hdc_session_close)
{
    rtError_t error;
    rtHdcSession_t session = &error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->HdcSessionClose(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->HdcSessionClose(session);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, get_hostcpu_device_id)
{
    rtError_t error;
    int32_t device_id = 0;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->GetHostCpuDevId(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->GetHostCpuDevId(&device_id);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(device_id, DEFAULT_HOSTCPU_USER_DEVICE_ID);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, rts_api_impl_test1)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    ApiDecorator api(&impl);
    uint32_t taskid;
    rtError_t error = api.GetThreadLastTaskId(&taskid);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream = new Stream(device, 0);
    error = api.LaunchDvppTask(nullptr, 0, stream, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    RtArgsHandle *argsHandle;
    error = api.KernelArgsInit(k1, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t param1 = 1002;
    ParaDetail *paramHandle = nullptr;
    error = api.KernelArgsAppend(argsHandle, (void *)&param1, sizeof(uint32_t), &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.KernelArgsAppendPlaceHolder(argsHandle, &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    void *bufferAddr = nullptr;
    error = api.KernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, 10U, &bufferAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;

    delete k1;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device); 
}

TEST_F(ApiImplTest, rts_api_impl_test2)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    ApiDecorator api(&impl);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;

    size_t argshandleMemSize = 0U;
    rtError_t error = api.KernelArgsGetHandleMemSize(k1, &argshandleMemSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t actualArgsSize = 0U;
    const size_t userArgsSize = 1024U;
    error = api.KernelArgsGetMemSize(k1, userArgsSize, &actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint8_t *argsHandle = new (std::nothrow) uint8_t[argshandleMemSize];
    uint8_t *userHostMem = new (std::nothrow) uint8_t[actualArgsSize];
    error = api.KernelArgsInitByUserMem(k1, (RtArgsHandle *)argsHandle, userHostMem, actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.KernelArgsFinalize((RtArgsHandle *)argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = (RtArgsHandle *)argsHandle;
    argsWithType.type = RT_ARGS_HANDLE;

    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_MAX;
    attrs[0].value.schemMode = 0;
    cfg.attrs = attrs;
    cfg.numAttrs = 1;
    Stream *stream = new Stream(device, 0);
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    argsWithType.type = RT_ARGS_MAX;
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete stream;
    delete [] argsHandle;
    delete [] userHostMem;

    delete k1;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, rts_api_impl_test3)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    k1->cpuKernelSo_ = "lib_aicpu_kernels.so";
    k1->cpuFunctionName_ = "RunCpuKernel";
    k1->kernelRegisterType_ = RT_KERNEL_REG_TYPE_CPU;

    size_t argshandleMemSize = 0U;
    rtError_t error = api.KernelArgsGetHandleMemSize(k1, &argshandleMemSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t actualArgsSize = 0U;
    const size_t userArgsSize = 1024U;
    error = api.KernelArgsGetMemSize(k1, userArgsSize, &actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(userArgsSize, actualArgsSize);

    uint8_t *argsHandle = new (std::nothrow) uint8_t[argshandleMemSize];
    (void)memset_s(argsHandle, argshandleMemSize, 0, argshandleMemSize);
    uint8_t *userHostMem = new (std::nothrow) uint8_t[actualArgsSize];
    error = api.KernelArgsInitByUserMem(k1, (RtArgsHandle *)argsHandle, userHostMem, actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.kernelNameOffset);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.kernelNameSize);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.soNameOffset);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.soNameSize);

    error = api.KernelArgsFinalize((RtArgsHandle *)argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = (RtArgsHandle *)argsHandle;
    argsWithType.type = RT_ARGS_HANDLE;

    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_MAX;
    attrs[0].value.schemMode = 0;
    cfg.attrs = attrs;
    cfg.numAttrs = 1;
    Stream *stream = new Stream(device, 0);
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    argsWithType.type = RT_ARGS_MAX;
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api * const apiInstance = Api::Instance();
    Profiler *tmpProfiler_ = ((Runtime *)Runtime::Instance())->profiler_;
    error = tmpProfiler_->apiProfileLogDecorator_->LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete stream;
    delete [] argsHandle;
    delete [] userHostMem;
    
    delete k1;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, rts_api_impl_test4)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    uint32_t taskid;
    rtError_t error = api.GetThreadLastTaskId(&taskid);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream = new Stream(device, 0);
    error = api.LaunchDvppTask(nullptr, 0, stream, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    RtArgsHandle *argsHandle;
    error = api.KernelArgsInit(k1, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t param1 = 1002;
    ParaDetail *paramHandle = nullptr;
    error = api.KernelArgsAppend(argsHandle, (void *)&param1, sizeof(uint32_t), &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.KernelArgsAppendPlaceHolder(argsHandle, &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    void *bufferAddr = nullptr;
    error = api.KernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, 10U, &bufferAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    delete k1;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

// KernelArgsInitByUserMem not memset CpuKernelSysArgsInfo
TEST_F(ApiImplTest, rts_api_impl_KernelArgsInitByUserMem)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 2;
    k1->systemParaNum_ = 2;
    k1->isSupportOverFlow_ = true;
    k1->isNeedSetFftsAddrInArg_ = true;
    k1->cpuKernelSo_ = "lib_aicpu_kernels.so";
    k1->cpuFunctionName_ = "RunCpuKernel";
    k1->kernelRegisterType_ = RT_KERNEL_REG_TYPE_CPU;

    size_t argshandleMemSize = 0U;
    rtError_t error = api.KernelArgsGetHandleMemSize(k1, &argshandleMemSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    size_t actualArgsSize = 0U;
    const size_t userArgsSize = 1024U;
    error = api.KernelArgsGetMemSize(k1, userArgsSize, &actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(userArgsSize, actualArgsSize);

    uint8_t *argsHandle = new (std::nothrow) uint8_t[argshandleMemSize];
    (void)memset_s(argsHandle, argshandleMemSize, 0, argshandleMemSize);
    uint8_t *userHostMem = new (std::nothrow) uint8_t[actualArgsSize];
    
    RtArgsHandle *rtArgsHandle = reinterpret_cast<RtArgsHandle*>(argsHandle);
    CpuKernelSysArgsInfo &cpuKernelSysArgsInfo = rtArgsHandle->cpuKernelSysArgsInfo;
    cpuKernelSysArgsInfo.kernelNameOffset = 0x5A5A;
    cpuKernelSysArgsInfo.kernelNameSize = 0x5A5A;
    cpuKernelSysArgsInfo.soNameOffset = 0x5A5A;
    cpuKernelSysArgsInfo.soNameSize = 0x5A5A;
    error = api.KernelArgsInitByUserMem(k1, (RtArgsHandle *)argsHandle, userHostMem, actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.kernelNameOffset);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.kernelNameSize);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.soNameOffset);
    EXPECT_EQ(0, ((RtArgsHandle *)argsHandle)->cpuKernelSysArgsInfo.soNameSize);

    error = api.KernelArgsFinalize((RtArgsHandle *)argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = (RtArgsHandle *)argsHandle;
    argsWithType.type = RT_ARGS_HANDLE;

    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_MAX;
    attrs[0].value.schemMode = 0;
    cfg.attrs = attrs;
    cfg.numAttrs = 1;
    Stream *stream = new Stream(device, 0);
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    argsWithType.type = RT_ARGS_MAX;
    error = api.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api * const apiInstance = Api::Instance();
    Profiler *tmpProfiler_ = ((Runtime *)Runtime::Instance())->profiler_;
    error = tmpProfiler_->apiProfileLogDecorator_->LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete stream;
    delete [] argsHandle;
    delete [] userHostMem;
    
    delete k1;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

// Unit test for DevMalloc
TEST_F(ApiImplTest, rts_api_impl_test6)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);
    void *ptr = nullptr;
    rtMallocConfig_t cfg;
    cfg.attrs = nullptr;
    rtMallocConfig_t *cfgPtr = &cfg;
    rtError_t error = apiError.DevMalloc(&ptr, 64, RT_MEM_MALLOC_HUGE_FIRST, RT_MEM_ADVISE_NONE, cfgPtr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

// allocate 1G page policy memory success
TEST_F(ApiImplTest, TestDevMalloc_01)
{
    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    void *ptr = nullptr;
    rtMallocConfig_t *cfgPtr = nullptr;
    rtError_t error = impl.DevMalloc(&ptr, 64, RT_MEM_MALLOC_HUGE1G_ONLY, RT_MEM_ADVISE_NONE, cfgPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = impl.DevMalloc(&ptr, 64, RT_MEM_MALLOC_HUGE1G_ONLY_P2P, RT_MEM_ADVISE_NONE, cfgPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, modelGetName_decorator_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);


    rtModel_t  model;
    rtError_t error = rtsModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsModelSetName(model, "modelA");
    char name[128];
    error = apiDecorator_->ModelGetName(static_cast<Model *>(model), 128, name);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
    error = rtsModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, LaunchDqsTask_Test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    rtError_t error = apiDecorator_->LaunchDqsTask( nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    ApiErrorDecorator *apiErrDecorator_ = new ApiErrorDecorator(oldApi_);
    error = apiErrDecorator_->LaunchDqsTask(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete apiDecorator_;
    delete apiErrDecorator_;
}

uint32_t stub_open_service(const uint32_t device_id, const NetServiceOpenArgs * args)
{
    return RT_ERROR_NONE;
}

uint32_t stub_close_service(const uint32_t device_id)
{   
    return RT_ERROR_NONE;
}

uint32_t stub_open_service_error(const uint32_t device_id, const NetServiceOpenArgs * args)
{   
    return RT_ERROR_DRV_TSD_ERR;
}

uint32_t stub_close_service_error(const uint32_t device_id)
{   
    return RT_ERROR_DRV_TSD_ERR;
}

TEST_F(ApiImplTest, Open_Close_NetService)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    rtNetServiceOpenArgs args{};
    // illegal param
    rtError_t error = rtOpenNetService(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    args.extParamCnt = 128U;
    error = rtOpenNetService(&args);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    rtProcExtParam extParam = {};
    extParam.paramLen = 1;
    extParam.paramInfo = "hccl";
    args.extParamList = &extParam;
    args.extParamCnt = 1U;
    error = rtOpenNetService(&args);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCloseNetService();
    EXPECT_NE(error, RT_ERROR_NONE);
    // stub
    rtInstance->tsdOpenNetService_ = stub_open_service;
    error = rtOpenNetService(&args);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->tsdCloseNetService_ = stub_close_service;
    error = rtCloseNetService();
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::string extPam("--hdcType=" + std::to_string(HDC_SERVICE_TYPE_RDMA_V2));
    extParam.paramInfo = extPam.c_str();
    extParam.paramLen = extPam.size();
    args.extParamList = &extParam;
    args.extParamCnt = 1U;
    rtInstance->tsdOpenNetService_ = stub_open_service_error;
    error = rtOpenNetService(&args);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    rtInstance->tsdCloseNetService_ = stub_close_service_error;
    error = rtCloseNetService();
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    delete apiDecorator_;
}

TEST_F(ApiImplTest, rtSetDeviceWithFlags_01)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(1, RT_DEVICE_FLAG_NOT_START_CPU_SCHED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceResetWithoutTsd(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, rtSetDeviceWithFlags_02)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, RT_DEVICE_FLAG_DEFAULT);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiImplTest, rtSetDeviceWithFlags_03)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, RT_DEVICE_FLAG_NOT_START_CPU_SCHED);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(ApiImplTest, rtSetDeviceWithFlags_04)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}


TEST_F(ApiImplTest, IpcGetEventHandle_Test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);

    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcGetEventHandle).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profileApi.IpcGetEventHandle(static_cast<IpcEvent *>(event), &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator.IpcGetEventHandle(static_cast<IpcEvent *>(event), &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(ApiImplTest, OpenEventHandle_Test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);

    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);
    rtIpcEventHandle_t *eventHandle = &handle;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::IpcOpenEventHandle).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profileApi.IpcOpenEventHandle(eventHandle, static_cast<IpcEvent **>(event));
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator.IpcOpenEventHandle(eventHandle, static_cast<IpcEvent **>(event));
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}
