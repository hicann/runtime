/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"

#include "api_impl.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_decorator.hpp"

#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2IpcApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        GlobalMockObject::verify();
        rtInstance->deviceCustomerStackSize_ = 0;
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CloudV2IpcApiTest, IpcNotifyExportAndImport)
{

    rtNotify_t notify;
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyCreate(devId, &notify);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    uint32_t len = 65;
    char name[65] = {0};
    error = rtsNotifyGetExportKey(notify, name, len, RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtNotify_t importNotify;
    error = rtsNotifyImportByKey(&importNotify, name, RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyDestroy(importNotify);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, IpcMemExportAndImport)
{
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    void *devPtr = nullptr;
    uint64_t size = 32;
    error = rtMalloc(&devPtr, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint32_t len = 65;
    char name[65] = {0};
    error = rtsIpcMemGetExportKey(devPtr, size, name, 65, RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    void *importDevPtr = nullptr;
    error = rtsIpcMemImportByKey(&importDevPtr, name, RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtFree(devPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, VmmMemExportAndImport)
{
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.mem_type = RT_MEMORY_DEFAULT;  // HBM 内存，当前只支持申请HBM内存
    prop.pg_type = 1;
    prop.side = 1;
    prop.devid = devId;
    prop.module_id = 0;
    size_t size = 32;
    error = rtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    uint64_t shareableHandle = 0ULL;
    error = rtsMemExportToShareableHandle(
        handle, RT_MEM_HANDLE_TYPE_NONE, RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, &shareableHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    rtDrvMemHandle importHandle;
    MOCKER(halMemShareHandleInfoGet)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT));
    error = rtsMemImportFromShareableHandle(shareableHandle, devId, &importHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    error = rtFreePhysical(handle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, VmmMemExportAndImportv2)
{
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.mem_type = RT_MEMORY_DEFAULT;  // HBM 内存，当前只支持申请HBM内存
    prop.pg_type = 1;
    prop.side = 1;
    prop.devid = devId;
    prop.module_id = 0;
    size_t size = 32;
    error = rtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    uint64_t shareableHandle = 0ULL;
    error = rtMemExportToShareableHandleV2(
        handle, RT_MEM_SHARE_HANDLE_TYPE_DEFAULT, RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, &shareableHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    uint32_t hostid = 1U;
    MOCKER(halGetHostID).stubs().with(outBoundP(&hostid, sizeof(hostid))).will(returnValue(DRV_ERROR_NONE));

    rtDrvMemHandle importHandle;
    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_DEFAULT, 0, devId, &importHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    MOCKER(halMemShareHandleInfoGet)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_SUPPORT));
    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_DEFAULT, 0, devId, &importHandle);

    error = rtFreePhysical(handle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, VmmMemExportAndImportv2Fabric)
{
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    prop.mem_type = RT_MEMORY_DEFAULT;  // HBM 内存，当前只支持申请HBM内存
    prop.pg_type = 1;
    prop.side = 1;
    prop.devid = devId;
    prop.module_id = 0;
    size_t size = 32;
    error = rtMallocPhysical(&handle, size, &prop, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    rtDrvMemFabricHandle shareableHandle = {};
    error = rtMemExportToShareableHandleV2(
        handle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, &shareableHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    rtDrvMemHandle importHandle;
    uint32_t hostid = 1U;
    int64_t serverId = 0x3FF;
    MOCKER(halGetHostID).stubs().with(outBoundP(&hostid, sizeof(hostid))).will(returnValue(DRV_ERROR_NONE));
    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, devId, &importHandle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, devId, &importHandle);

    error = rtFreePhysical(handle);
    EXPECT_EQ(ACL_RT_SUCCESS, error);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, rtMemAddressFabric)
{
    int32_t devId = 0;
    rtError_t error = rtSetDevice(devId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtReserveMemAddress(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtReleaseMemAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDrvMemHandle handVal;
    rtDrvMemProp_t prop = {};
    prop.mem_type = 1;
    prop.pg_type = 1;
    rtDrvMemHandle* handle = &handVal;
    error = rtMallocPhysical(handle, 0, &prop, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtFreePhysical(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtMapMem(nullptr, 0, 0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtUnmapMem(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    rtMemLocation location;
    location.type = RT_MEMORY_LOC_HOST;
    location.id = 0;
 
    size_t size = 1024*1024;//1mb
    rtMemAccessDesc desc = {};
    desc.location = location;
    desc.flags = RT_MEM_ACCESS_FLAGS_READWRITE;

    void *virPtr = nullptr;
    error = rtMalloc(&virPtr, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint64_t flags = 0U;
    error = rtMemGetAccess(virPtr, &location, &flags);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtFree(virPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtMemGetAccess(virPtr, nullptr, &flags);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemGetAccess(nullptr, nullptr, &flags);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemSetAccess(nullptr, size, nullptr, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtDrvMemFabricHandle shareableHandle = {};
    error = rtMemExportToShareableHandleV2(
        handle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, &shareableHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtMemExportToShareableHandleV2(
        handle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 30, &shareableHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, 0, handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtMemImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 10, 0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int pid[1024];
    error = rtMemSetPidToShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, pid, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtMemSetPidToShareableHandleV2(nullptr, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, pid, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    size_t granularity;
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(halMemGetAllocationGranularity)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2IpcApiTest, VmmMemExportAndImportv2_decorator_test)
{
    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    int32_t devId = 0;
    error = rtSetDevice(devId);

    rtMemLocation location;
    location.type = RT_MEMORY_LOC_HOST;
    location.id = 0;

    uint64_t flags = 0UL;
    error = apiDecorator_->MemGetAccess(nullptr, &location, &flags);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtDrvMemHandle handleVal;
    rtDrvMemHandle* handle = &handleVal;

    rtDrvMemFabricHandle shareableHandle = {};
    error = apiDecorator_->ExportToShareableHandleV2(handle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, &shareableHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->ImportFromShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0, 0, handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int pid[1024];
    error = apiDecorator_->SetPidToShareableHandleV2(&shareableHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, pid, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiDecorator_;
}

TEST_F(CloudV2IpcApiTest, enableP2p)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    auto error = device->EnableP2PWithOtherDevice(1U);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2IpcApiTest, failedSetMemShareHandle)
{
    MOCKER(halMemShareHandleSetAttribute).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    auto error = NpuDriver::SetMemShareHandleDisablePidVerify(0UL);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
}

TEST_F(CloudV2IpcApiTest, GetIpcNotifyPeerPhyDevIdFailed)
{
    MOCKER(halShrIdInfoGet).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    char name[65] = {0};
    uint32_t peerPhyDevId = 0U;
    auto error = NpuDriver::GetIpcNotifyPeerPhyDevId(name, &peerPhyDevId);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
}

TEST_F(CloudV2IpcApiTest, MemRetainAllocationHandle01)
{
    size_t size = 1024*1024;//1mb
    void *virPtr = nullptr;
    auto error = rtMalloc(&virPtr, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    void *handle = nullptr;
    MOCKER(halMemRetainAllocationHandle).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemRetainAllocationHandle(virPtr, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(virPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, MemRetainAllocationHandle02)
{
    size_t size = 1024*1024;//1mb
    void *virPtr = nullptr;
    auto error = rtMalloc(&virPtr, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    void *handle = nullptr;
    MOCKER(halMemRetainAllocationHandle).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rtMemRetainAllocationHandle(virPtr, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(virPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2IpcApiTest, MemGetAddressRange)
{
    void *ptr = (void*)0xff;;
    void *pbase = (void*)0x01U;
    size_t psize = 0;
    MOCKER(halMemGetAddressRange).stubs().will(returnValue(DRV_ERROR_NONE));
    rtError_t error = rtMemGetAddressRange(ptr, &pbase, &psize);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2IpcApiTest, MemGetAllocationPropertiesFromHandle01)
{
    size_t size = 1024*1024;//1mb
    void *handle = nullptr;
    auto error = rtMalloc(&handle, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtDrvMemProp_t prop1 = {};
    MOCKER(halMemGetAllocationPropertiesFromHandle).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2IpcApiTest, MemGetAllocationPropertiesFromHandle02)
{
    size_t size = 1024*1024;//1mb
    void *handle = nullptr;
    auto error = rtMalloc(&handle, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtDrvMemProp_t prop1 = {};
    MOCKER(halMemGetAllocationPropertiesFromHandle).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemGetAllocationPropertiesFromHandle(handle, &prop1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2IpcApiTest, MemGetAllocationPropertiesFromHandle_Prop_decorator)
{
    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);

    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    rtError_t error;

    int32_t devId = 0;
    error = rtSetDevice(devId);

    void* virPtr = nullptr;
    rtDrvMemHandle* handle = nullptr;
    error = apiDecorator_->MemRetainAllocationHandle(virPtr, handle);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtDrvMemHandle hdl = nullptr;
    rtDrvMemProp_t* prop = {};
    error = apiDecorator_->MemGetAllocationPropertiesFromHandle(hdl, prop);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
   
    delete apiDecorator_;
}

 TEST_F(CloudV2IpcApiTest, ipc_memory_close_normal)
{
    rtError_t error;

    error = rtsIpcMemClose("aaa");
    EXPECT_EQ(error, RT_ERROR_NONE);
}