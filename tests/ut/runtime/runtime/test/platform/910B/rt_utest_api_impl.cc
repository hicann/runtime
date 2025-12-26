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
#include "thread_local_container.hpp"
#include "rts.h"

using namespace testing;
using namespace cce::runtime;

extern bool g_init_platform_info_flag;
extern bool g_get_platform_info_flag;
class CloudV2ApiImplTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"CloudV2ApiImplTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"CloudV2ApiImplTest test start end. "<<std::endl;
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

TEST_F(CloudV2ApiImplTest, capture_api_01)
{
    rtError_t error;
    rtModel_t  model;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * stream = new Stream(static_cast<Context *>(current), 0);
    stream->SetContext(static_cast<Context *>(current));

    error = rtCtxSetCurrent(static_cast<Context *>(current));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->StreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->StreamEndCapture(stream, reinterpret_cast<Model **>(&model));
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
    delete apiDecorator_;
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, capture_api_02)
{
    rtError_t error;
    rtModel_t  model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * stream = new Stream(static_cast<Context *>(current), 0);
    stream->SetContext(static_cast<Context *>(current));

    error = rtCtxSetCurrent(static_cast<Context *>(current));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->StreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->StreamGetCaptureInfo(stream, &status, reinterpret_cast<Model **>(&model));
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    error = apiDecorator_->StreamEndCapture(stream, reinterpret_cast<Model **>(&model));
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete stream;
    delete apiDecorator_;
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, capture_api_03)
{
    rtError_t error;
    rtModel_t model;
    uint32_t num;

    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->ModelGetNodes(static_cast<Model *>(model), &num);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->ModelDebugDotPrint(static_cast<Model *>(model));
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, capture_api_04)
{
    rtError_t error;
    rtModel_t  model;

    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * addStream = new Stream(device, 0);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Context * ctx = static_cast<Context *>(current);
    addStream->SetContext(ctx);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->StreamAddToModel(addStream, static_cast<Model *>(model));
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete addStream;
    delete device;
    delete apiDecorator_;
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, capture_api_05)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    rtStreamCaptureMode mode = RT_STREAM_CAPTURE_MODE_GLOBAL;

    error = apiDecorator_->ThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, IPC_ADAPT)
{
    ApiImpl apiImpl;
    void *ptr = nullptr;
    void **ptrNull = nullptr;
    char* name = nullptr;
    rtNotify_t notify;
    int32_t pid[]={1};
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    Device* device = rtInstance->DeviceRetain(0, 0);
    Context context(device, false);
    context.Init();

    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    g_isAddrFlatDevice = true;
    error = apiImpl.IpcSetMemoryAttr(name, RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, notify_record_error)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;
    uint32_t notify_id;
    Api *api = Api::Instance();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyCreate).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::NotifyRecord).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::NotifyWait).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::GetNotifyID).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtGetNotifyID(notify, &notify_id);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::GetNotifyID).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtGetNotifyID(notify, &notify_id);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::IpcSetNotifyName).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtIpcSetNotifyName(notify,  "test_ipc", 8);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtIpcOpenNotify(&notify, "test_ipc");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiImplTest, LaunchRandomNumTask_Test_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);

    RawDevice * device = new RawDevice(0);
    device->Init();

    rtContext_t current = NULL;
    rtError_t error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream * stm = new Stream(device, 0);
    Context * ctx = static_cast<Context *>(current);
    stm->SetContext(ctx);
    rtRandomNumTaskInfo_t taskInfo = {};
    error = apiDecorator_->LaunchRandomNumTask(&taskInfo, stm, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = profileApi.LaunchRandomNumTask(&taskInfo, stm, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete stm;
    delete device;
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, GetCmoDescSize_Test_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);
    size_t size = 0U;
    rtError_t error = apiDecorator_->GetCmoDescSize(&size);
    EXPECT_NE(size, 0U);

    size = 0U;
    error = profileApi.GetCmoDescSize(&size);
    EXPECT_NE(size, 0U);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, SetCmoDesc_Test_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);

    rtCmoAddrInfo cmoAddrInfo = {};
    uint32_t testData = 0U;
    void *srcAddr = &testData;
    rtError_t error = apiDecorator_->SetCmoDesc(&cmoAddrInfo, srcAddr, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = profileApi.SetCmoDesc(&cmoAddrInfo, srcAddr, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, GetFreeStreamNum_decorator_test)
{
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    uint32_t avaliStrCount;
    rtError_t error = apiDecorator_->GetFreeStreamNum(&avaliStrCount);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, ModelExecuteAsync_decorator_test)
{
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    rtModel_t  model;
    error = rtsModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsModelBindStream(model, stream, 0x0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtsEndGraph(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsModelLoadComplete(model, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model_ = (Model *)model;
    error = apiDecorator_->ModelExecuteAsync(model_, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Profiler profiler(nullptr);
    ApiProfileDecorator profileApi(&impl, &profiler);
    error = profileApi.ModelExecuteAsync(model_, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiProfileLogDecorator profileLogDecorator(&impl, &profiler);
    error = profileLogDecorator.ModelExecuteAsync(model_, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = impl.ModelDestroy(model_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, GetExceptionRegInfo_test_01)
{
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);

    rtExceptionInfo_t exceptionInfo = {};
    rtExceptionErrRegInfo_t *exceptionErrRegInfo = nullptr;
    uint32_t num = 0;

    rtError_t error = rtGetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtGetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, &num);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = apiDecorator_->GetExceptionRegInfo(nullptr, &exceptionErrRegInfo, &num);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->GetExceptionRegInfo(&exceptionInfo, nullptr, &num);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = apiDecorator_->GetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, GetExceptionRegInfo_test_02)
{
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    Device* device = rtInstance->GetDevice(0, 0);
    auto& exceptionRegMap = device->GetExceptionRegMap();

    // 入参初始化，使用到的key以及deviceId都为0
    rtExceptionInfo_t exceptionInfo = {};
    rtExceptionErrRegInfo_t *exceptionErrRegInfo = nullptr;
    uint32_t num = 0;

    // taskId和streamId作为key值不匹配，从Map中未获取到数据
    std::pair<uint32_t, uint32_t> invalidKey = {0, 1};
    exceptionRegMap[invalidKey] = {};
    rtError_t error = apiDecorator_->GetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, &num);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(num, 0);
    EXPECT_EQ(exceptionErrRegInfo, nullptr);

    // 存储一个核的信息
    std::pair<uint32_t, uint32_t> key = {0, 0};
    rtExceptionErrRegInfo_t regInfo = {0};
    regInfo.coreId = 0;
    exceptionRegMap[key].push_back(regInfo);
    error = apiDecorator_->GetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, &num);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(num, 1);
    EXPECT_NE(exceptionErrRegInfo, nullptr);
    EXPECT_EQ(exceptionErrRegInfo->coreId, 0);

    // 存储两个核的信息
    rtExceptionErrRegInfo_t regInfo1 = {0};
    regInfo1.coreId = 1;
    exceptionRegMap[key].push_back(regInfo1);
    error = apiDecorator_->GetExceptionRegInfo(&exceptionInfo, &exceptionErrRegInfo, &num);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(num, 2);
    EXPECT_NE(exceptionErrRegInfo, nullptr);
    EXPECT_EQ(exceptionErrRegInfo->coreId, 0);
    EXPECT_EQ((exceptionErrRegInfo[1]).coreId, 1);
    exceptionRegMap.clear();

    delete apiDecorator_;
}

extern int32_t deviceCloseFlag;
extern int32_t halResourceIdFlag;
extern int32_t processResBackupFlag;
extern int32_t processResRestoreFlag;
TEST_F(CloudV2ApiImplTest, rtsSnapShotProcess02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&DeviceSnapshot::OpMemoryRestore).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&DeviceSnapshot::OpMemoryBackup).stubs().will(returnValue(RT_ERROR_NONE));
    deviceCloseFlag = 1;
    rtError_t error = rtSnapShotProcessBackup();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_BACKUP_FAILED);
    error = rtSnapShotProcessRestore();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_RESTORE_FAILED);
    deviceCloseFlag = 0;

    halResourceIdFlag = 1;

    error = rtSnapShotProcessBackup();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_BACKUP_FAILED);
    error = rtSnapShotProcessRestore();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_RESTORE_FAILED);
    halResourceIdFlag = 0;

    processResBackupFlag = 1;
    error = rtSnapShotProcessBackup();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_BACKUP_FAILED);
    processResBackupFlag = 0;

    processResRestoreFlag = 1;
    error = rtSnapShotProcessBackup();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_BACKUP_FAILED);
    error = rtSnapShotProcessRestore();
    EXPECT_EQ(error, ACL_ERROR_SNAPSHOT_RESTORE_FAILED);
    processResRestoreFlag = 0;
}

TEST_F(CloudV2ApiImplTest, dev_binary_register_test)
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

TEST_F(CloudV2ApiImplTest, KERNEL_CONFIG_DUMP_TEST_2)
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

TEST_F(CloudV2ApiImplTest, KERNEL_CONFIG_DUMP_TEST_3)
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

TEST_F(CloudV2ApiImplTest, KERNEL_CONFIG_DUMP_TEST_4)
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

TEST_F(CloudV2ApiImplTest, stream_create_1)
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

TEST_F(CloudV2ApiImplTest, kernel_transarg_set_test_online)
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

TEST_F(CloudV2ApiImplTest, kernel_transarg_set_test_offline)
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

TEST_F(CloudV2ApiImplTest, kernel_transarg_set_test_offline_flush_failed)
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

TEST_F(CloudV2ApiImplTest, ReduceAsync_error_01)
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

TEST_F(CloudV2ApiImplTest, context_create_test_fail)
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

TEST_F(CloudV2ApiImplTest, context_create_test_fail2)
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

TEST_F(CloudV2ApiImplTest, DEVICE_SET_TS_ID)
{
    ApiImpl apiImpl;
    rtError_t error;

    uint32_t tsId = 0;
    error = apiImpl.DeviceSetTsId(tsId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, NAME_EVENT_TEST_3)
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

TEST_F(CloudV2ApiImplTest, CPU_KERNEL_LAUNCH_DUMP)
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

TEST_F(CloudV2ApiImplTest, rtSetDeviceEx)
{
    rtError_t error;
    error = rtSetDeviceEx(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2ApiImplTest, rtDeviceResetEx)
{
    rtError_t error;
    error = rtDeviceResetEx(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2ApiImplTest, rtCtxCreateEx)
{
    rtError_t error;
    error = rtCtxCreateEx(NULL, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiImplTest, rtSetDeviceWithoutTsd)
{
    rtError_t error;
    error = rtSetDeviceWithoutTsd(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2ApiImplTest, rtDeviceResetWithoutTsd)
{
    rtError_t error;
    error = rtDeviceResetWithoutTsd(100);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
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


TEST_F(CloudV2ApiImplTest, rtGetDevMsgForRas)
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

TEST_F(CloudV2ApiImplTest, GetDevErrMsg)
{
    ApiImpl apiImpl;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL((RawDevice *)device, &RawDevice::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));

    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
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

TEST_F(CloudV2ApiImplTest, GetDevRunningStreamSnapshotMsg)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStub));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStub1));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetDevRunningStreamSnapshotMsg(GetMsgCallbackStub);
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
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

TEST_F(CloudV2ApiImplTest, GetDevRunningStreamSnapshotMsg_failed)
{
    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);

    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStub));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
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

TEST_F(CloudV2ApiImplTest, GetTaskIdAndStreamID)
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

TEST_F(CloudV2ApiImplTest, MemcpyAsyncCheckKindAndLocation_auto)
{
    rtError_t error;

    Api *oldApi = Runtime::runtime_->api_;
    ApiErrorDecorator *apiDecorator = new ApiErrorDecorator(oldApi);

    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    rtMemLocationType srcLocationType = RT_MEMORY_LOC_HOST;
    rtMemLocationType dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEVICE_TO_HOST;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_DEVICE;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_DEVICE;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyAsyncCheckKindAndLocation(&kind, srcLocationType, dstLocationType);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kind = RT_MEMCPY_DEFAULT;
    srcLocationType = RT_MEMORY_LOC_HOST;
    dstLocationType = RT_MEMORY_LOC_HOST;
    error = apiDecorator->MemcpyKindAutoUpdate(srcLocationType, dstLocationType, &kind);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator;
}

TEST_F(CloudV2ApiImplTest, GetDeviceCount_test)
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

TEST_F(CloudV2ApiImplTest, GetStreamTimeoutSnapshotMsg_test0)
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
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
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

TEST_F(CloudV2ApiImplTest, GetStreamTimeoutSnapshotMsg_test1)
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
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
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

TEST_F(CloudV2ApiImplTest, GetStreamTimeoutSnapshotMsg_test2)
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
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
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

TEST_F(CloudV2ApiImplTest, ModelExecutorSet_test)
{
    ApiImpl apiImpl;
    rtModel_t model;
    rtModelCreate(&model, 0);
    rtError_t ret = apiImpl.ModelExecutorSet(static_cast<Model *>(model), 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, rtGetSocVersionFromDrvApi)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtArchType_t archType = rtInstance->GetArchType();

    char *socVer = "Ascend910B1";
    // get socversion from halGetSocVersion
    MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910B1")), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));

    char res[128] = {0};
    rtError_t error = rtGetSocVersion(res, 128);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetArchType(archType);
}

TEST_F(CloudV2ApiImplTest, rtSetSocVersionFeInitFailed)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtArchType_t archType = rtInstance->GetArchType();

    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0xF));
    rtError_t error = rtSetSocVersion("Ascend910B");
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetArchType(archType);
}

TEST_F(CloudV2ApiImplTest, rtSetSocVersionFeGetPlatformInfoFailed)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtArchType_t archType = rtInstance->GetArchType();
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().will(returnValue(0xF));
    rtError_t error = rtSetSocVersion("Ascend910B");
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetArchType(archType);
}

TEST_F(CloudV2ApiImplTest, rtSetSocVersionFeGetPlatInfoInvalidArch)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtArchType_t archType = rtInstance->GetArchType();
    fe::PlatformInfo platInfo;
    platInfo.soc_info.arch_type = ARCH_V100;
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo).stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo).stubs().with(mockcpp::any(), outBound(platInfo), mockcpp::any())
        .will(returnValue(0U));
    rtError_t error = rtSetSocVersion("BS9SX1AA");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->SetArchType(archType);
}

TEST_F(CloudV2ApiImplTest, ut_GetSocVersionStrEx_null)
{
    rtError_t error = -1;
    rtSocType_t socType = SOC_END;
    const std::string ret = GetSocVersionStrByType(socType);
    EXPECT_EQ(ret == std::string(), true);
}

TEST_F(CloudV2ApiImplTest, SetIpcMemPid_01)
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

TEST_F(CloudV2ApiImplTest, SubcribeReport_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->SubscribeReport(123, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, ProcessReport_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->ProcessReport(100);
    EXPECT_EQ(error, RT_ERROR_SUBSCRIBE_THREAD);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, GetAicpuDeploy_01)
{
    rtError_t error;
    rtAicpuDeployType_t dtype = AICPU_DEPLOY_CROSS_OS;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->GetAicpuDeploy(&dtype);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, LabelSwitchByIndex_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->LabelSwitchByIndex(nullptr, 1, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, LabelCreateEx_01)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->LabelCreateEx(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, AllNotCoverPart1_01)
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

TEST_F(CloudV2ApiImplTest, AllNotCoverPart1_02)
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

TEST_F(CloudV2ApiImplTest, get_mem_info_by_type)
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

TEST_F(CloudV2ApiImplTest, get_device_status)
{
    rtError_t error;
    rtDevStatus_t status;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    error = apiDecorator_->GetDeviceStatus(0, &status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, hdc_server_create)
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

TEST_F(CloudV2ApiImplTest, hdc_server_destroy)
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

TEST_F(CloudV2ApiImplTest, hdc_session_connect)
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

TEST_F(CloudV2ApiImplTest, hdc_session_close)
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

TEST_F(CloudV2ApiImplTest, get_hostcpu_device_id)
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

TEST_F(CloudV2ApiImplTest, rts_api_impl_test1)
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

TEST_F(CloudV2ApiImplTest, rts_api_impl_test2)
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

TEST_F(CloudV2ApiImplTest, rts_api_impl_test3)
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

TEST_F(CloudV2ApiImplTest, rts_api_impl_test4)
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
TEST_F(CloudV2ApiImplTest, rts_api_impl_KernelArgsInitByUserMem)
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
TEST_F(CloudV2ApiImplTest, rts_api_impl_test6)
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
TEST_F(CloudV2ApiImplTest, TestDevMalloc_01)
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

TEST_F(CloudV2ApiImplTest, modelGetName_decorator_test)
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

TEST_F(CloudV2ApiImplTest, LaunchDqsTask_Test)
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

TEST_F(CloudV2ApiImplTest, Open_Close_NetService)
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

TEST_F(CloudV2ApiImplTest, rtSetDeviceWithFlags_01)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(1, RT_DEVICE_FLAG_NOT_START_CPU_SCHED);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceResetWithoutTsd(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, rtSetDeviceWithFlags_02)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, RT_DEVICE_FLAG_DEFAULT);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2ApiImplTest, rtSetDeviceWithFlags_03)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, RT_DEVICE_FLAG_NOT_START_CPU_SCHED);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2ApiImplTest, rtSetDeviceWithFlags_04)
{
    rtError_t error;
    error = rtSetDeviceWithFlags(100, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiImplTest, IpcGetEventHandle_Test)
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

TEST_F(CloudV2ApiImplTest, OpenEventHandle_Test)
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

rtError_t GetRunModeStubExt(cce::runtime::ApiImpl *api, rtRunMode *mode)
{
    *mode = RT_RUN_MODE_ONLINE;
    return RT_ERROR_NONE;
}

rtError_t GetRunModeOfflineStub(cce::runtime::ApiImpl *api, rtRunMode *mode)
{
    *mode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

void GetErrorMessage(const char *msg, uint32_t len) {
    if (msg != nullptr && len != 0) {
        RT_LOG(RT_LOG_ERROR, "rtGetDeviceErrorMessage get msg:%s, length=%u.", msg, len);
    } else {
        RT_LOG(RT_LOG_ERROR, "rtGetDeviceErrorMessage get msg failed, length=%u.", msg, len);
    }
}

rtError_t GetDevMsgTaskInitStubStarsV2(TaskInfo *task, const void *devMemAddr, uint32_t devMemSize,
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

rtError_t GetDevMsgSubmitTaskStubStarsV2(Device *dev, TaskInfo *task, rtTaskGenCallback callback)
{
    (void)dev->GetTaskFactory()->Recycle(task);
    return RT_ERROR_NONE;
}

void GetMsgCallbackStubStarsV2(const char *msg, uint32_t len) {}

// test05
TEST_F(CloudV2ApiImplTest, apiImpl_ts_model_abort_as31xm1)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_TS_MODEL_ABORT);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiImplTest, apiImpl_ts_model_abort_old_ver)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiImplTest, rtGetDevMsg)
{
    ApiImpl apiImpl;
    rtError_t error;
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStubExt));

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = apiImpl.GetDevMsg(RT_GET_DEV_ERROR_MSG, GetErrorMessage);
    error = apiImpl.GetDevMsg(RT_GET_DEV_MSG_RESERVE, GetErrorMessage);
    GlobalMockObject::verify();
}

rtError_t MemCopySyncStubStarsV2(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy_s(dst, destMax, src, size);
    return DRV_ERROR_NONE;
}


TEST_F(CloudV2ApiImplTest, rtGetDevMsgOffline)
{
    ApiImpl apiImpl;
    rtError_t error;
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeOfflineStub));

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = apiImpl.GetDevMsg(RT_GET_DEV_ERROR_MSG, GetErrorMessage);
    error = apiImpl.GetDevMsg(RT_GET_DEV_MSG_RESERVE, GetErrorMessage);
    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiImplTest, GetMaxModelNum)
{
    rtError_t error;
    ApiImpl apiImpl;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    Device* device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_EXPEND_MODEL_ID);
    uint32_t maxModelCount;
    Context context(device, false);
    context.Init();
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    error = apiImpl.GetMaxModelNum(&maxModelCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2ApiImplTest, GetDevRunningStreamSnapshotMsg_starsv2)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());

    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStubStarsV2));
    MOCKER(SyncGetDeviceMsg).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStubExt));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStubStarsV2));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStubStarsV2));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetDevRunningStreamSnapshotMsg(GetMsgCallbackStubStarsV2);
    }
    delete stream;

    GlobalMockObject::verify();
}

TEST_F(CloudV2ApiImplTest, apiimpl_stream_test)
{
    ApiImpl apiImpl;
    rtError_t error;
    rtStream_t rt_stream;

    rtStreamCreate(&rt_stream, 0);
    Stream *stream = (Stream *)rt_stream;
    Context *context = (Context *)stream->Context_();
    sleep(1);
    error = rtStreamQuery(rt_stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());

    uint32_t maxStrCount;
    uint32_t maxTaskCount;
    error = apiImpl.GetMaxStreamAndTask(0, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiImpl.GetMaxStreamAndTask(0, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiImpl.GetMaxStreamAndTask(1, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, get_priority_range_coverage)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.DeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, get_priority_range_coverage_with_nullptr)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.DeviceGetStreamPriorityRange(NULL, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.DeviceGetStreamPriorityRange(&leastPriority, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.DeviceGetStreamPriorityRange(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, stream_create_with_priority_out_of_range)
{
    ApiImpl impl;
	ApiErrorDecorator api(&impl);
    rtError_t error;
	rtStream_t stream_ = nullptr;
	int32_t priority = -1;

	error = api.StreamCreate((Stream**)&stream_, priority, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_ = nullptr;

    priority = 8;

    error = api.StreamCreate((Stream**)&stream_, priority, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplTest, apiImpl_ts_model_abort)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_TS_MODEL_ABORT);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(version);
    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiImplTest, decorator_starsv2)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->WriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->DeviceGetStreamlist(0, RT_STREAM_TYPE_MAX, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtModelList_t myModelList = {0, {nullptr}};
    error = apiDecorator_->DeviceGetModelList(0, &myModelList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->DeviceGetModelList(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyCreate(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->WriteValue(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CCULaunch(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->GetDevResAddress(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->UbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->ReleaseDevResAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->UbDbSend(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    error = apiDecorator_->UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = apiDecorator_->FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    error = apiDecorator_->DeviceResourceClean(0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete apiDecorator_;
}

TEST_F(CloudV2ApiImplTest, rts_api_LaunchKernel)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = nullptr;
    argsWithType.type = RT_ARGS_MAX;
    rtError_t error = apiError.CheckArgsWithType(&argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel *k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 0;
    k1->systemParaNum_ = 0;
    k1->isSupportOverFlow_ = false;
    k1->isNeedSetFftsAddrInArg_ = false;
    k1->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    k1->mixType_ = MIX_AIV;

    uint64_t data = 1234;
    argsWithType.type = RT_ARGS_NON_CPU_EX;
    rtArgsEx_t nonCpuArgsInfo = {};
    nonCpuArgsInfo.args = &data;
    nonCpuArgsInfo.argsSize = 8;
    nonCpuArgsInfo.isNoNeedH2DCopy = 1;
    argsWithType.args.nonCpuArgsInfo = &nonCpuArgsInfo;

    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[2];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[0].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[1].value.blockDimOffset = 1;
    cfg.attrs = attrs;
    cfg.numAttrs = 2;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Stream *stream = new Stream(device, 0);
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[1].value.timeout = 123;
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US;
    attrs[1].value.timeoutUs.timeoutLow = 123U; // us
    attrs[1].value.timeoutUs.timeoutHigh = 0U; // us
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US;
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    delete k1;
    delete stream;
}

TEST_F(CloudV2ApiImplTest, api_DvppGroupCreate)
{
    rtError_t error;

    Runtime *rtInstance = ((Runtime *)Runtime::Instance());

    error = rtDvppGroupCreate(nullptr, 0U);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiImplTest, api_rtStarsTaskLaunch)
{
    rtError_t error;

    Runtime *rtInstance = ((Runtime *)Runtime::Instance());

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStarsTaskLaunch(nullptr, 0U, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiImplTest, stub_starsv2_test_SendTopicMsgVersionToAicpuStarsV2)
{
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    bool isFinished = false;
    uint32_t taskId = 0U;
    uint32_t streamId = 0U;
    ((Stream *)stream)->JudgeTaskFinish(0, isFinished);

    Runtime *rtInstance = (Runtime *) Runtime::Instance();
    error = rtGetTaskIdAndStreamID(&taskId, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}