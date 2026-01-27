/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ascend_hal.h"
#include "ascend_inpackage_hal.h"
#include "tsd.h"
#include "ts_api.h"
#include "tdt_server.h"
#define private public
#include "task_queue.h"
#include "aicpusd_so_manager.h"
#undef private
#include "gtest/gtest.h"

class HostCpuDriverStubSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(HostCpuDriverStubSt, HostCpuDriverStubStSuccess)
{
    Mbuf *mbuf = nullptr;
    uint64_t len = 0;
    poolHandle pHandle;
    halMbufChainGetMbuf(mbuf, 0, &mbuf);
    unsigned int num;
    halMbufChainGetMbufNum(mbuf, &num);
    halMbufChainAppend(mbuf, mbuf);
    halMbufGetDataLen(mbuf, &len);
    halMbufSetDataLen(mbuf, 0);
    halMbufAllocByPool(pHandle, &mbuf);
    halMbufAllocEx(0, 0, 0, 0, &mbuf);

    mpAttr attr;
    struct mempool_t *mp = nullptr;;
    halBuffCreatePool(&attr, &mp);
    halBuffDeletePool(mp);

    halTsDevRecord(0, 0, 0, 0);
    tsDevSendMsgAsync(0, 0, nullptr, 0, 0);
    auto ret = CreateOrFindCustPid(0, 0, nullptr, 0, 0, nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(ret, 0);
}

TEST_F(HostCpuDriverStubSt, SetDeviceIdToDvpp) {
    uint32_t deviceId = 0;
    AicpuSchedule::AicpuSoManager::GetInstance().SetDeviceIdToDvpp(deviceId);
    EXPECT_EQ(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}


TEST_F(HostCpuDriverStubSt, OnPreprocessEvent)
{
    uint32_t eventId = 2;
    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(eventId);
    EXPECT_EQ(DataPreprocess::TaskQueueMgr::GetInstance().cancelLastword_, nullptr);
}

TEST_F(HostCpuDriverStubSt, TDTServerInit) {
    const std::list<uint32_t> bindCoreList;
    int32_t ret = tdt::TDTServerInit(0, bindCoreList);
    EXPECT_EQ(ret, 0);
}

TEST_F(HostCpuDriverStubSt, TDTServerStop) {
    int32_t ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);
}

TEST_F(HostCpuDriverStubSt, GetErrDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrDesc(0);
    EXPECT_EQ(ret, "");
    ret = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0);
    EXPECT_EQ(ret, "");
}

extern int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                                      const uint32_t hostPid, const uint32_t vfId,
                                      const struct SubProcScheduleModeInfo *scheInfo);
TEST_F(HostCpuDriverStubSt, SetSubProcScheduleMode)
{
  int ret = SetSubProcScheduleMode(0U, 0U, 0U, 0U, nullptr);
  EXPECT_EQ(ret, 0);
}