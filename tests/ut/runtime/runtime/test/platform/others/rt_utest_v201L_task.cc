/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "rts_dqs.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "engine.hpp"
#include "cond_c.hpp"
#include "task_res.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "event_david.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "context.hpp"
#include "stream_david.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "event_c.hpp"
#include "notify_c.hpp"
#include "stream_c.hpp"
#include "cond_c.hpp"
#include "memcpy_c.hpp"
#include "model_c.hpp"
#include "task_recycle.hpp"
#include "securec.h"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "thread_local_container.hpp"
#include "../../rt_utest_config_define.hpp"
#include "task_res_da.hpp"
#include "stars_model_execute_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_dqs_cond_isa_helper.hpp"
#include "stream_creator_c.hpp"
#include "stream_with_dqs.hpp"
#include "dqs_c.hpp"
#include "task_info.hpp"
#include "dqs_task_info.hpp"
#include "ioctl_utils.hpp"
#include "notify.hpp"
#include "../../rt_utest_api.hpp"
#include "driver/ascend_hal.h"
#include "api_impl_david.hpp"
#include "aicpu_c.hpp"
#include "aix_c.hpp"
#include "para_convertor.hpp"
#include "api_decorator.hpp"

using namespace testing;
using namespace cce::runtime;
static rtChipType_t g_chipType;
static drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_MC32DM11A;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) { // tsnum
            *value = 2;
        } else if (moduleType == MODULE_TYPE_AICORE && infoType == INFO_TYPE_DIE_NUM) {  // P dienum
            *value = 1;
        } else {
        }
    }
    return DRV_ERROR_NONE;
}

class TaskTestV201L : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        char *socVer = "MC32DM11AA";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("MC32DM11AA")))
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halSqTaskSend).stubs().will(returnValue(RT_ERROR_NONE));
        std::cout << "TaskTestV201 SetUP" << std::endl;
        GlobalContainer::SetRtChipType(CHIP_MC32DM11A);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_MC32DM11A);
        rtInstance->UpdateDevProperties(CHIP_MC32DM11A, "MC32DM11AA");
        rtInstance->SetConnectUbFlag(false);
        std::cout << "TaskTestDavid start" << std::endl;
    }

    static void TearDownTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoStub));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "TaskTestV201L end" << std::endl;
        GlobalMockObject::verify();
    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {

    }

public:
    Device *device_ = nullptr;
    Engine *engine_ = nullptr;
};

TEST_F(TaskTestV201L, Test_SetDevice)
{
    rtError_t error;
    Runtime *rtInstance = Runtime::Instance();
    error = rtSetTSDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTestV201L, Test_SetSocTypeByChipType)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetChipType(CHIP_MC32DM11A);
    GlobalContainer::SetRtChipType(CHIP_MC32DM11A);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_M510, CHIP_MC32DM11A, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->GetRawSocVersion(), "");
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}
