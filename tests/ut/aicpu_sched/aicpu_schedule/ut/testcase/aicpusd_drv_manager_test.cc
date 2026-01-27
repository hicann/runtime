/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <vector>
#include <map>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_context.h"
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "tdt_server.h"
#include "ascend_hal.h"
#define private public
#include "core/aicpusd_resource_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "aicpusd_interface_process.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AICPUDrvManagerTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUDrvManagerTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUDrvManagerTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUDrvManagerTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUDrvManagerTEST TearDown" << std::endl;
    }
};

namespace {
    constexpr uint64_t CHIP_ADC = 2U;
    constexpr uint64_t CHIP_ASCEND_910B = 5U;
    const std::map<EVENT_ID, SCHEDULE_PRIORITY> eventPriority = {
        {EVENT_ID::EVENT_RANDOM_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_SPLIT_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_DVPP_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_DVPP_MPI_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_FR_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TS_HWTS_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_AICPU_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TS_CTRL_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_QUEUE_EMPTY_TO_NOT_EMPTY, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_QUEUE_FULL_TO_NOT_FULL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TDT_ENQUEUE, SCHEDULE_PRIORITY::PRIORITY_LEVEL2},
        {EVENT_ID::EVENT_ACPU_MSG_TYPE1, SCHEDULE_PRIORITY::PRIORITY_LEVEL1}
    };

    drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if (moduleType == 1 && infoType == 20) {
            *value = 14;
        }
        if (moduleType == 1 && infoType == 21) {
            *value = 65532;
        }

        if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
            *value = CHIP_ADC << 8;
        }
        return DRV_ERROR_NONE;
    }

    StatusCode GetAicpuDeployContextOnHost(DeployContext &deployCtx)
    {
        deployCtx = DeployContext::HOST;
        return AICPU_SCHEDULE_OK;
    }

    drvError_t halGetDeviceInfoFake1OnHost(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if (moduleType == 1 && infoType == 20) {
            *value = 64;
        }
        if (moduleType == 1 && infoType == 21) {
            *value = 0;
        }
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if (moduleType == 1 && infoType == 3) {
            *value = 8;
        }
        if (moduleType == 1 && infoType == 8) {
            *value = 1020;
        }
        return DRV_ERROR_NONE;
    }

    drvError_t drvQueryProcessHostPidFake1(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        *host_pid = 1;
        *cp_type = DEVDRV_PROCESS_CP1;
        return DRV_ERROR_NONE;
    }

    drvError_t drvQueryProcessHostPidFake2(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        static uint32_t cnt = 0U;
        if (cnt == 0U) {
            ++cnt;
            return DRV_ERROR_NO_PROCESS;
        }

        return DRV_ERROR_UNINIT;
    }

    drvError_t drvQueryProcessHostPidFake3(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        return DRV_ERROR_INNER_ERR;
    }

    drvError_t drvQueryProcessHostPidFake4(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        static uint32_t cnt = 0U;
        if (cnt == 0) {
            ++cnt;
            *host_pid = 1;
            *cp_type = DEVDRV_PROCESS_CP1;
            return DRV_ERROR_NONE;
        }
        *host_pid = 2;
        *cp_type = DEVDRV_PROCESS_CP1;
        return DRV_ERROR_NONE;
    }

    drvError_t drvQueryProcessHostPidFake5(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        return DRV_ERROR_NO_PROCESS;
    }
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgr) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgr_fail) {
    std::vector<uint32_t> deviceVec;
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgr_fail2) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    deviceVec.push_back(64);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvZone) {
    int32_t ret = AicpuDrvManager::GetInstance().InitDrvZone();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, InitDrvSchedModule) {
    const uint32_t groupId = CP_DEFAULT_GROUP_ID;
    AicpuDrvManager drvMgr;
    int32_t ret = drvMgr.InitDrvSchedModule(groupId, eventPriority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}


TEST_F(AICPUDrvManagerTEST, InitDrvSchedModule_fail2) {
    const uint32_t groupId = CP_DEFAULT_GROUP_ID;
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(200));

    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);

    int32_t ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupId, eventPriority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvSchedModule_fail3) {
    const uint32_t groupId = CP_DEFAULT_GROUP_ID;
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(200));

    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);

    int32_t ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupId, eventPriority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvSchedModule_fail4) {
    const uint32_t groupId = CP_DEFAULT_GROUP_ID;
    MOCKER(halEschedSetEventPriority)
        .stubs()
        .will(returnValue(200));

    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);

    int32_t ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupId, eventPriority);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, SubscribeQueueNotEmptyEvent) {
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().SubscribeQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, SubscribeQueueNotEmptyEvent_failed2) {
    MOCKER(halQueueSubscribe)
        .stubs()
        .will(returnValue(200));
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().SubscribeQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUDrvManagerTEST, UnSubscribeQueueNotEmptyEvent) {
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().UnSubscribeQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, UnSubscribeQueueNotEmptyEvent_failed) {
    MOCKER(halQueueUnsubscribe)
        .stubs()
        .will(returnValue(200));
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().UnSubscribeQueueNotEmptyEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUDrvManagerTEST, SubscribeQueueNotFullEvent) {
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().SubscribeQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, SubscribeQueueNotFullEvent_failed) {
    MOCKER(halQueueSubF2NFEvent)
        .stubs()
        .will(returnValue(200));
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().SubscribeQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUDrvManagerTEST, UnSubscribeQueueNotFullEvent) {
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().UnSubscribeQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, UnSubscribeQueueNotFullEvent_failed) {
    MOCKER(halQueueUnsubF2NFEvent)
        .stubs()
        .will(returnValue(200));
    uint32_t queueId = 1;
    int ret = AicpuDrvManager::GetInstance().UnSubscribeQueueNotFullEvent(queueId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUDrvManagerTEST, BindHostPid) {
    AicpuPlat mode = AicpuPlat::AICPU_ONLINE_PLAT;
    uint32_t vfId = 0;
    char pidSign[] = "12345A";
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    int32_t bindPidRet = drvMgr.BindHostPid(pidSign, static_cast<int32_t>(mode), vfId, DEVDRV_PROCESS_CP2);
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, BindHostPid_fail) {
    AicpuPlat mode = AicpuPlat::AICPU_MAX_PLAT;
    uint32_t vfId = 0;
    char pidSign[] = "12345A";
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    int32_t bindPidRet = drvMgr.BindHostPid(pidSign, static_cast<int32_t>(mode), vfId, DEVDRV_PROCESS_CP2);
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUDrvManagerTEST, BindHostPid_fail2) {
    AicpuPlat mode = AicpuPlat::AICPU_ONLINE_PLAT;
    uint32_t vfId = 0;
    char pidSign[] = "12345A";
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    int32_t bindPidRet = drvMgr.BindHostPid(pidSign, static_cast<int32_t>(mode), vfId, DEVDRV_PROCESS_CPTYPE_MAX);
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUDrvManagerTEST, BindHostPid_fail3) {
    MOCKER(drvBindHostPid)
        .stubs()
        .will(returnValue(200));
    AicpuPlat mode = AicpuPlat::AICPU_ONLINE_PLAT;
    uint32_t vfId = 0;
    char pidSign[] = "12345A";
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();

    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);

    int32_t bindPidRet = drvMgr.BindHostPid(pidSign, static_cast<int32_t>(mode), vfId, DEVDRV_PROCESS_CP2);
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUDrvManagerTEST, CheckBindHostPid001) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    drvMgr.hostPid_ = 1;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, CheckBindHostPid002) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid).stubs().will(invoke(drvQueryProcessHostPidFake2));
    drvMgr.hostPid_ = 1;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUDrvManagerTEST, CheckBindHostPid003) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake3));
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUDrvManagerTEST, CheckBindHostPid004) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUDrvManagerTEST, CheckBindHostPid005) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake5));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUDrvManagerTEST, GetThreadVfAicpuDCpuInfo) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetThreadVfAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoInVf) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoSuccess1) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(32U);
    int64_t expect_aicpuNum = 14;
    int64_t expect_aicpu_index[] = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), expect_aicpu_index[i]);
    }
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoSuccess1OnHost) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(32U);
    int64_t expect_aicpuNum = 64;
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1OnHost));
    MOCKER(GetAicpuDeployContext).stubs().will(invoke(GetAicpuDeployContextOnHost));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), i);
    }
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoSuccess2) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(31U);
    int64_t expect_aicpuNum = 8;
    int64_t expect_aicpu_index[] = {2, 3, 4, 5, 6, 7, 8, 9};
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake2));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), expect_aicpu_index[i]);
    }
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoSuccess3) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    int64_t expect_aicpuNum = 8;
    int64_t expect_aicpu_index[] = {2, 3, 4, 5, 6, 7, 8, 9};
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake2));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), expect_aicpu_index[i]);
    }
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoSuccess4) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    int64_t expect_aicpuNum = 8;
    int64_t expect_aicpu_index[] = {0, 1, 2, 3, 4, 5, 6, 7};
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake2));
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    EXPECT_EQ(expect_aicpuNum, AicpuDrvManager::GetInstance().GetAicpuNumPerDevice());
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    for (uint32_t i = 0; i < expect_aicpuNum; i++) {
        EXPECT_EQ(AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U), expect_aicpu_index[i]);
    }
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuInfoInVfFail) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgrVf32) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgrDevice1Vf1) {
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 1, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgrVf32GetVfFail) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgr_001) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(32);
    MOCKER_CPP(&AicpuDrvManager::GetNormalAicpuInfo).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuDrvManager::GetCcpuInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));
    int ret = AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, InitSocType_CHIP_ASCEND_910B) {
    AicpuDrvManager inst;
    int64_t deviceInfo = CHIP_ASCEND_910B << 8;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&deviceInfo))
        .will(returnValue(DRV_ERROR_NONE));
    char socVersion[] = "Ascend910_93";
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVersion, strlen(socVersion)), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    inst.InitSocType(0);

    EXPECT_TRUE(FeatureCtrl::IsBindPidByHal());
    EXPECT_TRUE(FeatureCtrl::IfCheckEventSender());
    EXPECT_TRUE(FeatureCtrl::IsDoubleDieProduct());

    FeatureCtrl::aicpuFeatureBindPidByHal_ = false;
    FeatureCtrl::aicpuFeatureDoubleDieProduct_ = false;
    FeatureCtrl::aicpuFeatureCheckEventSender_ = false;
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuDCpuInfo_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuDCpuInfo_002) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(48);
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUDrvManagerTEST, GetNormalAicpuDCpuInfo_003) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(48);
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetNormalAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUDrvManagerTEST, GetThreadVfAicpuDCpuInfo_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = inst.GetThreadVfAicpuDCpuInfo(deviceVec);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUDrvManagerTEST, InitDrvMgrCaluniqueVfId_001) {
    AicpuDrvManager inst;
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    inst.InitDrvMgrCaluniqueVfId(deviceVec, 1);
    EXPECT_EQ(inst.uniqueVfId_, 1);
}
TEST_F(AICPUDrvManagerTEST, GetAicpuPhysIndexSuccess) {
    AicpuDrvManager inst;
    inst.aicpuIdVec_ = {1, 2};
    inst.coreNumPerDev_ = 3;
    inst.aicpuNumPerDev_ = 2;
    inst.deviceNum_ = 1;
    const auto ids = inst.GetAicpuPhysIndexs(0);
    EXPECT_EQ(ids[0], 1);
    ids = inst.GetAicpuPhysIndexs(0);
    EXPECT_EQ(ids[0], 1);
}
