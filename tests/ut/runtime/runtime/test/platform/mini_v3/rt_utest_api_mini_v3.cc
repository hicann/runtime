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
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "async_hwts_engine.hpp"
#include "task_res.hpp"
#include "rdma_task.h"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include "thread_local_container.hpp"
#include "heterogenous.h"
#include "task_execute_time.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"
#include "api_c.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiMINIV3Test : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend310B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_MINI_V3);
        GlobalContainer::SetRtChipType(CHIP_MINI_V3);
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetSocVersion("");
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};


TEST_F(ApiMINIV3Test, notify_test)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtIpcSetNotifyName(notify, "test_ipc", 8);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtIpcOpenNotifyWithFlag(&notify, "test_ipc", 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiMINIV3Test, IPC_ADAPT)
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
    
    error = apiImpl.IpcSetMemoryName(ptr, 0, name, 0, 0UL);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.IpcOpenMemory(ptrNull, name, 0UL);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.IpcCloseMemory(ptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.IpcDestroyMemoryName(name);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.SetIpcNotifyPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.SetIpcMemPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    
    error = apiImpl.IpcSetMemoryAttr(name, RT_ATTR_TYPE_MEM_MAP, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiMINIV3Test, rtCacheLastTaskOpInfo_test) 
{
    rtError_t error;
    
    char rawInfo[] = "test_op_info_data";
    size_t infoSize = sizeof(rawInfo);

    error = rtCacheLastTaskOpInfo(rawInfo, infoSize);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}