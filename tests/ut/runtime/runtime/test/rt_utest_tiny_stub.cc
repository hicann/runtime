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
#define protected public
#define private public
#include "runtime/rt.h"
#include "rts/rts.h"
#include "rts_dqs.h"
#include "context.hpp"
#include "stream.hpp"
#include "raw_device.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "api_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "profiler.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "logger.hpp"
#include "rdma_task.h"
#include "task_info_v100.h"
#include "ffts_task.h"
#include "rt_unwrap.h"
#include "dqs/task_dqs.hpp"
#include "printf.hpp"
#include "engine_factory.hpp"
#include "stars_engine.hpp"
#include "binary_loader.hpp"
#include "ipc_event.hpp"
#include "event_expanding.hpp"
#include "event_pool.hpp"
#include "stub_task.hpp"
#include "rt_inner_model.h"
#include "inner_kernel.h"
#include "xpu_aicpu_c.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "capture_adapt.hpp"
#include "capture_model_utils.hpp"
#include "jetty_manager.h"
#include "jetty_pool.h"
#include "stream_jetty_handler.h"
#include "device_snapshot.hpp"
#include "snapshot_process_helper.hpp"
#include "snapshot_callback_manager.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "xpu_task_fail_callback_data_manager.h"
#undef protected
#undef private

using namespace cce::runtime;

class TinyStubTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TinyStubTest test start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TinyStubTest test start end" << std::endl;
    }

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TinyStubTest, api_c_stub)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCntNotifyCreate(0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCntNotifyCreateWithFlag(0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCntNotifyDestroy(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetCntNotifyId(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtWriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCCULaunch(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtUbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetDevResAddress(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtReleaseDevResAddress(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtWriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtUbDbSend(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtUbDirectSend(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtFusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtStreamTaskClean(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetBinaryDeviceBaseAddr(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtFftsPlusTaskLaunch(0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtFftsPlusTaskLaunchWithFlag(0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtRDMASend(0, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtRDMADBSend(0, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtLaunchSqeUpdateTask(0, 0, nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtRegKernelLaunchFillFunc(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtUnRegKernelLaunchFillFunc(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    // ipc
    ret = rtIpcSetMemoryName(nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcSetMemoryAttr(nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcDestroyMemoryName(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcOpenMemory(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcCloseMemory(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcSetNotifyName(nullptr, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcOpenNotify(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcOpenNotifyWithFlag(nullptr, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsSetCmoDesc(nullptr, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsGetCmoDescSize(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsLaunchReduceAsyncTask(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsLaunchUpdateTask(nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsLaunchCmoAddrTask(nullptr, nullptr, RT_CMO_PREFETCH, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtModelTaskUpdate(nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCmoAddrTaskLaunch(nullptr, 0, RT_CMO_PREFETCH, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtReduceAsyncV2(nullptr, 0, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtStreamCreateWithFlagsExternal(nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtsDeviceGetInfo(0, RT_DEV_ATTR_AICORE_CORE_NUM, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtGetXpuDevCount(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtEventWorkModeSet(0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtEventWorkModeGet(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtIpcEventHandle_t handle;
    rtEvent_t event;
    ret = rtIpcOpenEventHandle(handle, &event);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtIpcGetEventHandle(&event, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCacheLastTaskOpInfo(nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtFunctionGetAttribute(nullptr, RT_FUNCTION_ATTR_MAX, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtFuncGetSize(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtLaunchDqsTask(nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtMemManagedLocation location;
    ret = rtMemManagedAdvise(nullptr, 0, 0, location);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtMemManagedGetAttr(rtMemRangeAttributeReadMostly, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtMemManagedGetAttrs(nullptr, 0, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtCacheLastTaskExtendInfo(nullptr, 0U);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtMemsetD32(nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtMemsetD32Async(nullptr, 0, 0, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_error_stub)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t ret = RT_ERROR_NONE;
    ret = api.WriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyCreate(0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyDestroy(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetCntNotifyId(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.WriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CCULaunch(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.UbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetDevResAddress(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.ReleaseDevResAddress(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.UbDbSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.StreamTaskAbort(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.StreamRecover(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.StreamTaskClean(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.DeviceResourceClean(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetBinaryDeviceBaseAddr(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.LaunchDqsTask(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.MemGetInfoByDeviceId(0, false, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetDeviceInfoFromPlatformInfo(0, "", "", nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetDeviceInfoByAttr(0, RT_DEV_ATTR_AICORE_CORE_NUM, nullptr);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    ret = api.SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetXpuDevCount(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.EventWorkModeSet(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.EventWorkModeGet(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.IpcGetEventHandle(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.IpcOpenEventHandle(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.XpuSetTaskFailCallback(RT_DEV_TYPE_DPU, "", nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    rtMemManagedLocation location;
    ret = api.MemManagedAdvise(nullptr, 0, 0, location);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.MemManagedGetAttr(rtMemRangeAttributeReadMostly, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.MemManagedGetAttrs(nullptr, 0, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_impl_stub)
{
    ApiImpl impl;
    rtError_t ret = RT_ERROR_NONE;
    ret = impl.WriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CntNotifyCreate(0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CntNotifyDestroy(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetCntNotifyId(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.WriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.CCULaunch(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.UbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetDevResAddress(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.ReleaseDevResAddress(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.UbDbSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.StreamTaskAbort(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.StreamRecover(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.StreamTaskClean(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.DeviceResourceClean(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetBinaryDeviceBaseAddr(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.RDMASend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.RdmaDbSend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.LaunchDqsTask(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.MemGetInfoByDeviceId(0, false, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetDeviceInfoFromPlatformInfo(0, "", "", nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.GetXpuDevCount(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.EventWorkModeSet(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.EventWorkModeGet(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.IpcGetEventHandle(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.IpcOpenEventHandle(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    rtMemManagedLocation location;
    ret = impl.MemManagedAdvise(nullptr, 0, 0, location);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.MemManagedGetAttr(rtMemRangeAttributeReadMostly, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.MemManagedGetAttrs(nullptr, 0, nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.MemsetD32(nullptr, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = impl.MemsetD32Async(nullptr, 0, 0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_profile_stub)
{
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    rtError_t ret = RT_ERROR_NONE;
    ret = api.UbDbSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyCreate(0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyDestroy(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetCntNotifyId(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.WriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CCULaunch(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.RDMASend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.RdmaDbSend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetXpuDevCount(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.XpuSetTaskFailCallback(RT_DEV_TYPE_DPU, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.XpuProfilingCommandHandle(0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_profile_log_stub)
{
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileLogDecorator api(&impl, &profiler);
    rtError_t ret = RT_ERROR_NONE;
    ret = api.UbDbSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyCreate(0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyDestroy(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.WriteValue(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.CCULaunch(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.RDMASend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = api.RdmaDbSend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, context_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    rtError_t ret = RT_ERROR_NONE;
    ctx.TryRecycleCaptureModelResource(1, 1, nullptr);
    ret = ctx.FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ctx.RDMASend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ctx.RdmaDbSendToDev(0, 0, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ctx.RdmaDbSend(0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, npu_driver_stub)
{
    rtError_t ret = RT_ERROR_NONE;
    NpuDriver driver;
    uint32_t result = 0U;
    uint64_t addr = 0ULL;
    bool flag = false;
    AsyncDmaWqeInputInfo input = {};
    ret = driver.CreateAsyncDmaWqe(0, input, nullptr, true, false);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.DestroyAsyncDmaWqe(0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetStarsInfo(0, 0, addr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetTsfwVersion(0, 0, result);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.UnmapSqRegVirtualAddrBySqid(0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.WriteNotifyRecord(0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.QueryUbInfo(0, QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetDevResAddress(0, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.ReleaseDevResAddress(0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetSqAddrInfo(0, 0, 0, addr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.SqArgsCopyWithUb(0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.SetSqTail(0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.StopSqSend(0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.ResumeSqSend(0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.StreamTaskFill(0, 0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = driver.ResetSqCq(0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.ResetLogicCq(0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetSqRegVirtualAddrBySqidForDavid(0, 0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.GetTsegInfoByVa(0, 0, 0, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = driver.PutTsegInfo(0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, rdma_task_stub)
{
    PrintDfxInfoForRdmaPiValueModifyTask(nullptr, 0);
    ConstructSqeRdmaPiValueModifyTask(nullptr, nullptr);
    PrintErrorInfoForRDMAPiValueModifyTask(nullptr, 0);
    RdmaPiValueModifyTaskUnInit(nullptr);
    auto ret = SubmitRdmaPiValueModifyTask(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t num = GetSendSqeNumForRdmaDbSendTask(nullptr);
    EXPECT_EQ(num, 1);
    ToCommandBodyForRdmaSendTask(nullptr, nullptr);
    ToCommandBodyForRdmaDbSendTask(nullptr, nullptr);
    ConstructSqeForRdmaDbSendTask(nullptr, nullptr);
}

TEST_F(TinyStubTest, ffts_task_stub)
{
    uint32_t num = GetSendSqeNumForFftsPlusTask(nullptr);
    EXPECT_EQ(num, 1);
    PushBackErrInfoForFftsPlusTask(nullptr, nullptr, 0);
    FftsPlusTaskUnInit(nullptr);
    PrintErrorInfoForFftsPlusTask(nullptr, 0);
    rtLogicCqReport_t logicCq;
    SetStarsResultForFftsPlusTask(nullptr, logicCq);
    ConstructSqeForFftsPlusTask(nullptr, nullptr);
    ConstructSqeForRdmaDbSendTask(nullptr, nullptr);
    DoCompleteSuccForFftsPlusTask(nullptr, 0);
    SqeTaskUpdateForFftsPlus(nullptr, nullptr);
}

TEST_F(TinyStubTest, task_stub)
{
    rtError_t ret = ConstructSqeByTaskInput(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = TaskReclaimByStream(nullptr, true, true);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = SetTimeoutConfigTaskSubmitDavid(nullptr, RT_TIMEOUT_TYPE_OP_WAIT, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = AicpuMdlDestroy(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ModelSubmitExecuteTask(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ModelLoadCompleteByStream(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = MdlBindTaskSubmit(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = ProcRingBufferTaskDavid(nullptr, nullptr, false, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    RtTimeoutConfig timeoutConfig;
    ret = UpdateTimeoutConfigTaskSubmitDavid(nullptr, timeoutConfig);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, easy_model_stub)
{
    rtError_t ret = RT_ERROR_NONE;
    rtModel_t model;
    uint32_t num = 0;
    ret = rtModelGetNodes(model, &num);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    ret = rtModelDebugDotPrint(model);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStream_t stream;
    ret = rtStreamAddToModel(stream, model);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStreamCaptureMode mode;
    ret = rtStreamBeginCapture(stream, mode);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStreamCaptureStatus status;
    ret = rtStreamGetCaptureInfo(stream, &status, &model);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtTaskBuffType_t type;
    uint32_t bufferLen;
    ret = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtTaskInput_t taskInput;
    uint32_t taskLen;
    ret = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    void *elfData = nullptr;
    uint32_t elfLen;
    uint32_t offset;
    ret = rtGetElfOffset(elfData, elfLen, &offset);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    char_t *binFileName = nullptr;
    char_t *buffer = nullptr;
    uint32_t length = 0;
    ret = rtGetKernelBin(binFileName, &buffer, &length);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    ret = rtFreeKernelBin(buffer);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    void *srcAddrPtr = nullptr;
    size_t srcLen = 0;
    rtCmoOpCode_t cmoType;
    ret = rtCmoAsync(srcAddrPtr, srcLen, cmoType, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtCmoTaskInfo_t *taskInfo = nullptr;
    uint32_t flag;
    ret = rtCmoTaskLaunch(taskInfo, stream, flag);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    void *dst = nullptr;
    uint64_t destMax;
    void *src = nullptr;
    uint64_t cnt;
    rtRecudeKind_t kind;
    rtDataType_t dataType;
    ret = rtReduceAsync(dst, destMax, src, cnt, kind, dataType, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    uint32_t qosCfg;
    ret = rtReduceAsyncWithCfg(dst, destMax, src, cnt, kind, dataType, stream, qosCfg);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtTaskCfgInfo_t *cfgInfo = nullptr;
    ret = rtReduceAsyncWithCfgV2(dst, destMax, src, cnt, kind, dataType, stream, cfgInfo);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtModelCreate(&model, 0);

    rtCallback_t stub_func = (rtCallback_t)0x12345;
    ret = rtModelDestroyRegisterCallback(model, stub_func, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    ret = rtModelDestroyUnregisterCallback(model, stub_func);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, npu_snapshot_stub)
{
    auto ret = rtSnapShotProcessLock();
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtSnapShotProcessUnlock();
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtSnapShotProcessBackup();
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtSnapShotProcessRestore();
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtProcessState state;
    ret = rtSnapShotProcessGetState(&state);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtSnapShotCallbackRegister(RT_SNAPSHOT_LOCK_PRE, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ret = rtSnapShotCallbackUnregister(RT_SNAPSHOT_LOCK_PRE, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, printf_stub)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = ParsePrintf(nullptr, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = InitPrintf(nullptr, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, simt_printf_stub)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = ParseSimtPrintf(nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = InitSimtPrintf(nullptr, 0, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, engine_stub)
{
    RawDevice *device = new RawDevice(0);
    StarsEngine *engine = nullptr;
    engine = static_cast<cce::runtime::StarsEngine*>(EngineFactory::CreateEngine(CHIP_ASCEND_031, device));
    EXPECT_NE(engine, nullptr);
    delete engine;
    delete device;
}

TEST_F(TinyStubTest, binary_stub)
{
    BinaryLoader binaryLoader(nullptr, nullptr);
    rtError_t ret = binaryLoader.Load(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    BinaryLoader binaryLoader1(nullptr, 0, nullptr);
    ret = binaryLoader1.Load(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, ipc_event_stub)
{
    IpcEvent ipcEvent(nullptr, 0U, nullptr);
    rtError_t ret = ipcEvent.Setup();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ipcEvent.IpcEventRecord(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ipcEvent.IpcEventWait(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ipcEvent.IpcEventQuery(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ipcEvent.IpcEventSync(MAX_INT32_NUM);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = ipcEvent.TryFreeEventIdAndCheckCanBeDelete(MAX_INT32_NUM, true);
    EXPECT_EQ(ret, true);
    ret = ipcEvent.ReleaseDrvResource();
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(TinyStubTest, event_pool_stub)
{
    EventPool eventPool(nullptr, 0U);
    rtError_t ret = eventPool.AllocEventIdFromDrv(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = eventPool.FreeEventId(0U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = eventPool.FreeAllEvent();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = eventPool.AllocEventIdFromPool(nullptr);
    EXPECT_EQ(ret, false);
    ret = eventPool.EventIdReAlloc();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = eventPool.AllocEventId(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(TinyStubTest, event_expanding_stub)
{
    EventExpandingPool eventExpandingPool(nullptr);
    rtError_t ret = eventExpandingPool.AllocAndInsertEvent(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = eventExpandingPool.ResetBufferForEvent();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    eventExpandingPool.FreeEventId(MAX_INT32_NUM);
}

TEST_F(TinyStubTest, xpu_launch_kernel_stub)
{
    rtError_t ret = XpuLaunchKernel(nullptr, 0, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_adapt_stub)
{
    bool ret = StreamFlagIsSupportCapture(0);
    EXPECT_EQ(ret, true);

    uint32_t flag = GetCaptureStreamFlag();
    EXPECT_EQ(flag, RT_STREAM_DEFAULT);

    Event *event = nullptr;
    CaptureCntNotify cntInfo;
    rtError_t err = GetCaptureEventFromTask(nullptr, 0, 0, event, cntInfo);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    err = ResetCaptureEventsProc(nullptr, nullptr);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    err = SendNopTask(nullptr, nullptr);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = TaskTypeIsSupportTaskGroup(nullptr);
    EXPECT_EQ(ret, false);

    TaskInfo *task = GetStreamTaskInfo(nullptr, 0, 0);
    EXPECT_EQ(task, nullptr);
}

TEST_F(TinyStubTest, capture_model_utils_stub)
{
    bool ret = IsEventCapturing(nullptr, nullptr);
    EXPECT_EQ(ret, false);

    TerminateCapture(nullptr, nullptr);

    ret = IsCrossCaptureModel(nullptr, nullptr);
    EXPECT_EQ(ret, false);

    ret = IsCapturedTask(nullptr, nullptr);
    EXPECT_EQ(ret, false);

    Stream *captureStm = nullptr;
    rtError_t err = GetCaptureStream(nullptr, nullptr, nullptr, &captureStm);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    err = CheckCaptureStreamThreadIsMatch(nullptr);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    err = CheckCaptureModelSupportSoftwareSq(nullptr);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    err = CheckCaptureModelForUpdate(nullptr);
    EXPECT_EQ(err, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = IsSoftwareSqCaptureModel(nullptr);
    EXPECT_EQ(ret, false);

    ret = CheckCaptureModeSupport(nullptr, nullptr);
    EXPECT_EQ(ret, true);

    ret = NeedReBuildSqe(nullptr);
    EXPECT_EQ(ret, false);

    ret = IsUseHardwareEvent(nullptr);
    EXPECT_EQ(ret, false);
}

TEST_F(TinyStubTest, snapshot_process_helper_stub)
{
    ContextDataManage ctxMan;
    rtError_t ret = SnapShotPreProcessBackup(ctxMan);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SnapShotDeviceRestore();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SnapShotResourceRestore(ctxMan);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SnapShotAclGraphRestore(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SnapShotProcessBackup();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SnapShotProcessRestore();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = ModelBackup(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = ModelRestore(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SinkTaskMemoryBackup(0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_model_execute_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.Execute(nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.ExecuteAsync(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.TearDown(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.AddStreamToCaptureModel(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_model_notify_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.SetNotifyBeforeExecute(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.SetNotifyAfterExecute(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_FALSE(captureModel.IsAddStream(nullptr));
    captureModel.EnterCaptureNotify(0, 0);
    captureModel.ExitCaptureNotify();
    EXPECT_EQ(captureModel.ResetCaptureEvents(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_model_info_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    captureModel.DebugDotPrintTaskGroups(0);
    captureModel.ReportedStreamInfoForProfiling();
    captureModel.EraseStreamInfoForProfiling();
    EXPECT_EQ(captureModel.SetShapeInfo(nullptr, 0, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.ClearShapeInfo(0, 0);
    size_t infoSize = 0;
    EXPECT_EQ(captureModel.GetShapeInfo(0, 0, infoSize), nullptr);
    EXPECT_EQ(captureModel.CacheLastTaskOpInfo(nullptr, 0, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.ReportShapeInfoForProfiling();
    captureModel.SetModelCacheOpInfoSwitch(0);
}

TEST_F(TinyStubTest, capture_model_task_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.GetTaskGroup(0, 0), nullptr);
    captureModel.BackupArgHandle(0, 0);
    EXPECT_EQ(captureModel.Update(), RT_ERROR_FEATURE_NOT_SUPPORT);
    uint32_t notifyCount = 0;
    EXPECT_EQ(captureModel.ReleaseNotifyId(notifyCount), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.UpdateNotifyId(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_model_sqcq_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.BuildSqCq(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.DeconstructSqCq();
    uint32_t releaseNum = 0;
    EXPECT_EQ(captureModel.ReleaseSqCq(releaseNum), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.CaptureModelExecuteFinish(RT_ERROR_NONE);
    EXPECT_EQ(captureModel.MarkStreamActiveTask(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.RestoreForSoftwareSq(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.RestoreJettyForSnapshot();
}

TEST_F(TinyStubTest, capture_model_sqcq_bind_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.BindSqCqAndSendSqe(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.BindSqCq(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.BindStreamToModel(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.UnBindSqCq(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.AllocSqAddr(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.AllocSqCqProc(0), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, capture_model_execute_common_stub)
{
    CaptureModel captureModel(RT_MODEL_NORMAL);
    EXPECT_EQ(captureModel.UpdateStreamActiveTaskFuncCallMem(), RT_ERROR_FEATURE_NOT_SUPPORT);
    captureModel.ClearStreamActiveTask();
    EXPECT_EQ(captureModel.ExecuteCommon(nullptr, 0, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel.GetOriginalCaptureStream(), nullptr);
    captureModel.ReportCacheTrackData();
}

TEST_F(TinyStubTest, stream_capture_stub)
{
    Stream stream(static_cast<Device*>(nullptr), 0, 0);
    stream.SingleStreamTerminateCapture();
    EXPECT_EQ(stream.GetCaptureStatus(), RT_STREAM_CAPTURE_STATUS_INVALIDATED);

    Stream *newStream = nullptr;
    rtError_t ret = stream.AllocCascadeCaptureStream(newStream, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    stream.UpdateCascadeCaptureStreamInfo(nullptr, nullptr);

    TaskInfo *task = nullptr;
    ret = stream.AllocCaptureTaskWithLock(TS_TASK_TYPE_KERNEL_AICORE, 0, &task);
    EXPECT_EQ(ret, RT_ERROR_STREAM_CAPTURE_EXIT);

    ret = stream.AllocCaptureTaskWithoutLock(TS_TASK_TYPE_KERNEL_AICORE, 0, &task);
    EXPECT_EQ(ret, RT_ERROR_STREAM_CAPTURE_EXIT);

    ret = stream.AllocCaptureTask(TS_TASK_TYPE_KERNEL_AICORE, 0, &task, true);
    EXPECT_EQ(ret, RT_ERROR_STREAM_CAPTURE_EXIT);

    stream.EnterCapture(nullptr);
    EXPECT_EQ(stream.GetCaptureStatus(), RT_STREAM_CAPTURE_STATUS_ACTIVE);

    stream.ResetCaptureInfo();
    EXPECT_EQ(stream.GetCaptureStatus(), RT_STREAM_CAPTURE_STATUS_NONE);

    stream.ExitCapture();
    EXPECT_EQ(stream.GetCaptureStatus(), RT_STREAM_CAPTURE_STATUS_NONE);
}

TEST_F(TinyStubTest, event_capture_stub)
{
    Event event(0, 0, nullptr);
    rtError_t ret = event.RecordSoftwareEvent(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = event.CaptureWaitProcess(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = event.ResetSoftwareEvent(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, device_snapshot_stub)
{
    DeviceSnapshot snapshot(nullptr);
    snapshot.RecordOpAddrAndSize(nullptr);
    snapshot.GetOpTotalMemoryInfo(nullptr);
    snapshot.RecordFuncCallAddrAndSize(nullptr);
    snapshot.RecordArgsAddrAndSize(nullptr);

    rtError_t ret = snapshot.OpMemoryBackup();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = snapshot.OpMemoryRestore();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = snapshot.ArgsPoolRestore();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = snapshot.UbArgsPoolRestore();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = snapshot.ArgsPoolConvertAddr(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    snapshot.OpMemoryInfoInit();

    const auto &handlerMap = snapshot.GetHandlerMap();
    EXPECT_EQ(handlerMap.size(), 0);

    TaskHandlers::HandleStreamSwitch(nullptr, nullptr);
    TaskHandlers::HandleStreamLabelSwitchByIndex(nullptr, nullptr);
    TaskHandlers::HandleMemWaitValue(nullptr, nullptr);
    TaskHandlers::HandleRdmaPiValueModify(nullptr, nullptr);
    TaskHandlers::HandleStreamActive(nullptr, nullptr);
    TaskHandlers::HandleModelTaskUpdate(nullptr, nullptr);
}

TEST_F(TinyStubTest, snapshot_callback_manager_stub)
{
    SnapshotCallbackManager &manager = SnapshotCallbackManager::GetInstance();
    EXPECT_NE(&manager, nullptr);

    rtError_t ret = manager.RegisterCallback(RT_SNAPSHOT_LOCK_PRE, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = manager.UnregisterCallback(RT_SNAPSHOT_LOCK_PRE, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = manager.InvokeCallbacks(RT_SNAPSHOT_LOCK_PRE);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, model_aclgraph_stub)
{
    Model model(RT_MODEL_NORMAL);
    uint32_t nodes = model.ModelGetNodes();
    EXPECT_EQ(nodes, 0);

    rtError_t ret = model.ModelDebugDotPrint();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = model.ModelDebugJsonPrint(nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_decorator_capture_stub)
{
    ApiImpl impl;
    ApiDecorator api(&impl);
    rtError_t ret = api.StreamBeginCapture(nullptr, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    Model *model = nullptr;
    ret = api.StreamEndCapture(nullptr, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureStatus status;
    ret = api.StreamGetCaptureInfo(nullptr, &status, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    TaskGroup *taskGrp = nullptr;
    ret = api.StreamBeginTaskUpdate(nullptr, taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamEndTaskUpdate(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    uint32_t num = 0;
    ret = api.ModelGetNodes(nullptr, &num);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.ModelDebugDotPrint(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.ModelDebugJsonPrint(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamAddToModel(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureMode mode;
    ret = api.ThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamBeginTaskGrp(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamEndTaskGrp(nullptr, &taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_impl_capture_stub)
{
    ApiImpl impl;
    rtError_t ret = impl.GetCaptureEvent(nullptr, nullptr, nullptr, false);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.CaptureEventRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.CaptureEventWait(nullptr, nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.CaptureEventReset(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.StreamBeginCapture(nullptr, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    Model *model = nullptr;
    ret = impl.StreamEndCapture(nullptr, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureStatus status;
    ret = impl.StreamGetCaptureInfo(nullptr, &status, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureMode mode;
    ret = impl.ThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    TaskGroup *taskGrp = nullptr;
    ret = impl.StreamBeginTaskGrp(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.StreamEndTaskGrp(nullptr, &taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.StreamBeginTaskUpdate(nullptr, taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.StreamEndTaskUpdate(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    uint32_t num = 0;
    ret = impl.ModelGetNodes(nullptr, &num);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.ModelDebugDotPrint(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.ModelDebugJsonPrint(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = impl.StreamAddToModel(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, api_error_capture_stub)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t ret = api.StreamBeginCapture(nullptr, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    Model *model = nullptr;
    ret = api.StreamEndCapture(nullptr, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureStatus status;
    ret = api.StreamGetCaptureInfo(nullptr, &status, &model);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    TaskGroup *taskGrp = nullptr;
    ret = api.StreamBeginTaskUpdate(nullptr, taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamEndTaskUpdate(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    uint32_t num = 0;
    ret = api.ModelGetNodes(nullptr, &num);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.ModelDebugDotPrint(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.ModelDebugJsonPrint(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamAddToModel(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtStreamCaptureMode mode;
    ret = api.ThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamBeginTaskGrp(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = api.StreamEndTaskGrp(nullptr, &taskGrp);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TinyStubTest, context_capture_basic_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    EXPECT_EQ(ctx.StreamBeginCapture(nullptr, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_FEATURE_NOT_SUPPORT);
    Model *model = nullptr;
    EXPECT_EQ(ctx.StreamEndCapture(nullptr, &model), RT_ERROR_FEATURE_NOT_SUPPORT);
    Stream *newStream = nullptr;
    EXPECT_EQ(ctx.AllocCascadeCaptureStream(nullptr, nullptr, &newStream), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.UpdateEndGraphTask(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, context_capture_model_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    uint32_t num = 0;
    EXPECT_EQ(ctx.ModelGetNodes(nullptr, &num), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.ModelDebugDotPrint(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.ModelDebugJsonPrint(nullptr, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.StreamAddToModel(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, context_capture_task_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    rtStreamCaptureMode mode;
    EXPECT_EQ(ctx.ThreadExchangeCaptureMode(&mode), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.StreamBeginTaskGrp(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    TaskGroup *taskGrp = nullptr;
    EXPECT_EQ(ctx.StreamEndTaskGrp(nullptr, &taskGrp), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.StreamBeginTaskUpdate(nullptr, taskGrp), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.StreamEndTaskUpdate(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, context_capture_notify_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    EXPECT_EQ(ctx.StreamAddToCaptureModelProc(nullptr, nullptr, false), RT_ERROR_FEATURE_NOT_SUPPORT);
    ctx.FreeCascadeCaptureStream(nullptr);
    Notify *notify = nullptr;
    EXPECT_EQ(ctx.CreateNotify(&notify, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.AddNotifyToAddedCaptureStream(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctx.SetNotifyForExeModel(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, context_capture_info_stub)
{
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    Context ctx(dev, 0);
    ctx.Init();
    rtStreamCaptureStatus status;
    Model *model = nullptr;
    EXPECT_EQ(ctx.StreamGetCaptureInfo(nullptr, &status, &model), RT_ERROR_FEATURE_NOT_SUPPORT);
    ctx.CaptureModeEnter(nullptr, RT_STREAM_CAPTURE_MODE_GLOBAL);
    ctx.CaptureModeExit(nullptr);
    EXPECT_EQ(ctx.CheckCaptureModelValidity(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_FALSE(ctx.IsCaptureModeSupport());
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(TinyStubTest, jetty_stub)
{
    JettyManager mgr(0);
    mgr.Clear();
    EXPECT_EQ(mgr.ResetJettyForSnapshotRestore(), RT_ERROR_NONE);

    JettyPool *pool = new JettyPool(0);
    delete pool;

    EXPECT_EQ(StreamJettyHandler::FillNopWqeOnCaptureEnd(nullptr, JettyType::JETTY_TYPE_H2D), RT_ERROR_NONE);
    EXPECT_EQ(StreamJettyHandler::GetJettyTypeFromTask(nullptr), JettyType::JETTY_TYPE_MAX);
    EXPECT_EQ(StreamJettyHandler::HandleUbDmaTask(nullptr, nullptr, JettyType::JETTY_TYPE_H2D, nullptr, nullptr),
        RT_ERROR_NONE);
}

TEST_F(TinyStubTest, xpu_task_fail_callback_manager_stub)
{
    auto &instance1 = XpuTaskFailCallBackManager::Instance();
    EXPECT_NE(&instance1, nullptr);
    auto &instance2 = XpuTaskFailCallBackManager::Instance();
    EXPECT_EQ(&instance1, &instance2);

    rtExceptionInfo_t exceptionInfo = {};
    instance1.XpuNotify(&exceptionInfo);

    rtError_t ret = instance1.RegXpuTaskFailCallback("regName", nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
    ret = instance1.RegXpuTaskFailCallback("regName", reinterpret_cast<void *>(0x1));
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}
