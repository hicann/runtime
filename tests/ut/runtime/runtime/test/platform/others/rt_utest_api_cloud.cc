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

class ApiTest2 : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
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
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};


TEST_F(ApiTest2, notify_record_error)
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

    rtChipType_t chipType = rtInstance->GetChipType();
    rtChipType_t rtChipType = GlobalContainer::GetRtChipType();

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    MOCKER_CPP_VIRTUAL(apiImpl,&ApiImpl::GetNotifyID).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtGetNotifyID(notify, &notify_id);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(rtChipType);

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

TEST_F(ApiTest2, ipc_open_with_flag_chip_type_unsupport)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = rtIpcOpenNotifyWithFlag(&notify, "abc", 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

rtError_t GetNotifyPhyInfo_stub_succ(cce::runtime::ApiImpl *api,
    Notify *const inNotify, rtNotifyPhyInfo* notifyInfo)
{
    notifyInfo->phyId = 1;
    notifyInfo->tsId = 2;
    return RT_ERROR_NONE;
}

TEST_F(ApiTest2, ipc_open_with_flag_succ)
{
    ApiImpl apiImpl;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    rtNotifyPhyInfo notifyInfo;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs()
        .will(invoke(GetNotifyPhyInfo_stub_succ));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));

    rtNotify_t notify2 = new (std::nothrow) Notify(0, 0);
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = rtIpcOpenNotifyWithFlag(&notify2, "abc", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtNotifyGetPhyInfo(notify2, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(phyDevId, 1);
    EXPECT_EQ(tsId, 2);
    error = rtNotifyGetPhyInfoExt(notify2, &notifyInfo);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    error = rtNotifyDestroy(notify2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete notify2;
}

TEST_F(ApiTest2, notify_get_phyinfo_invalid_1)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtNotifyGetPhyInfo(notify, &phyDevId, &tsId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest2, ipc_open_with_flag_chiptype_mini)
{
    ApiImpl apiImpl;
    rtNotify_t notify;
    rtError_t error;
    uint32_t phyDevId;
    uint32_t tsId;
    uint32_t notifyId;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetNotifyPhyInfo).stubs()
        .then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtIpcOpenNotifyWithFlag(&notify, "abc", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

// not surport ADC
TEST_F(ApiTest2, set_device_not_support_adc_01)
{
    rtError_t error = rtDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtStream_t stream;
    EXPECT_NE(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest2, set_device_not_support_adc_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
     rtStream_t stream;
    EXPECT_NE(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
}

TEST_F(ApiTest2, set_device_not_support_adc_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
     rtStream_t stream;
    EXPECT_NE(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
}

TEST_F(ApiTest2, Get_default_device_id)
{
    rtSetDefaultDeviceId(0xFFFFFFFF);
    rtError_t error = RT_ERROR_NONE;
    int32_t deviceId = 0;
    error = rtGetDevice(&deviceId);
    EXPECT_NE(error, RT_ERROR_NONE);
    error = rtSetDefaultDeviceId(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtGetDevice(&deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(deviceId, 1);
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest2, set_default_device_heterogenous_scene)
{
    // 设置为异构场景
    MOCKER(&RtIsHeterogenous).stubs().will(returnValue(true));
    rtDeviceResetForce(0);
    rtError_t error = rtMemQueueDestroy(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *value = nullptr;
    error = rtMemQueueDeQueue(0, 0, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueBuff_t buff = {nullptr};
     error = rtMemQueueDeQueueBuff(0, 0, &buff, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t device = 0;
    char name[] = "buffer_group";
    uint32_t qid = 0;
    error = rtMemQueueGetQidByName(device, name, &qid);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemQueueAttach(0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueQueryCmd_t cmd = RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC;
    rtMemQueueShareAttr_t attr = {0};
    uint32_t pid = 0;
    uint32_t outLen = sizeof(attr);
    error = rtMemQueueQuery(0, cmd, &pid, sizeof(pid), &attr, &outLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueInfo_t queInfo = {0};
    error = rtMemQueueQueryInfo(0, 0, &queInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueBuff_t buff2 = {nullptr};
    error = rtMemQueueEnQueueBuff(0, 0, &buff2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t value1 = 0;
    error = rtMemQueuePeek(0, 0, &value1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t value3 = 0;
    error = rtMemQueueEnQueue(0, 0, &value3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueSetInputPara para = {};
    error = rtMemQueueSet(0, RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE, &para);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMemQueueAttr_t attr1;
    memset_s(&attr1, sizeof(attr1), 0, sizeof(attr1));
    attr1.depth = RT_MQ_DEPTH_MIN;
    uint32_t qid2 = 0;
    error = rtMemQueueCreate(0, &attr1, &qid2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}