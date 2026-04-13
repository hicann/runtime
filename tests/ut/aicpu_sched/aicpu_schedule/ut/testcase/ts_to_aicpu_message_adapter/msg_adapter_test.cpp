/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "message_adapter_common_stub.h"
#include "ts_msg_adapter.h"

using namespace AicpuSchedule;
using namespace aicpu;

class TestAdapter : public TsMsgAdapter {
public:
    TestAdapter(uint32_t pid, uint8_t cmdType, uint8_t vfId, uint8_t tid, uint8_t tsId)
        : TsMsgAdapter(pid, cmdType, vfId, tid, tsId) {}
    TestAdapter() : TsMsgAdapter() {}
    bool IsAdapterInvaildParameter() const override { return false; }
    void GetAicpuDataDumpInfo(AicpuDataDumpInfo& info) override {}
    bool IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo& info) const override { return true; }
    void GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo& opmappingInfo, AicpuDumpTaskInfo& dumpTaskInfo) override {}
    void GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad& info) override {}
    int32_t AicpuDumpResponseToTs(const int32_t ret) override { return 0; }
    int32_t AicpuDataDumpLoadResponseToTs(const int32_t ret) override { return 0; }
    void GetAicpuModelOperateInfo(AicpuModelOperateInfo& info) override {}
    int32_t AicpuModelOperateResponseToTs(const int32_t ret, const uint32_t subEvent) override { return 0; }
    void AicpuActiveStreamSetMsg(ActiveStreamInfo& info) override {}
    void GetAicpuMsgVersionInfo(AicpuMsgVersionInfo& info) override {}
    int32_t AicpuMsgVersionResponseToTs(const int32_t ret) override { return 0; }
    void GetAicpuTaskReportInfo(AicpuTaskReportInfo& info) override {}
    int32_t ErrorMsgResponseToTs(ErrMsgRspInfo& rspInfo) override { return 0; }
    int32_t AicpuNoticeTsPidResponse(const uint32_t deviceId) const override { return 0; }
    void GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo& info) override {}
    int32_t AicpuTimeOutConfigResponseToTs(const int32_t ret) override { return 0; }
    void GetAicpuInfoLoad(AicpuInfoLoad& info) override {}
    int32_t AicpuInfoLoadResponseToTs(const int32_t ret) override { return 0; }
    void GetAicErrReportInfo(AicErrReportInfo& info) override {}
    int32_t AicpuRecordResponseToTs(AicpuRecordInfo& info) override { return 0; }
};

class TsMsgAdapterTEST : public ::testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TsMsgAdapterTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TsMsgAdapterTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "TsMsgAdapterTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "TsMsgAdapterTEST TearDown" << std::endl;
    }
};

TEST_F(TsMsgAdapterTEST, ConstructorWithParams)
{
    uint32_t pid = 100;
    uint8_t cmdType = 1;
    uint8_t vfId = 2;
    uint8_t tid = 3;
    uint8_t tsId = 4;
    
    TestAdapter adapter(pid, cmdType, vfId, tid, tsId);
    EXPECT_EQ(adapter.pid_, pid);
    EXPECT_EQ(adapter.cmdType_, cmdType);
    EXPECT_EQ(adapter.vfId_, vfId);
    EXPECT_EQ(adapter.tid_, tid);
    EXPECT_EQ(adapter.tsId_, tsId);
}

TEST_F(TsMsgAdapterTEST, DefaultConstructor)
{
    TestAdapter adapter;
    EXPECT_EQ(adapter.pid_, 0U);
    EXPECT_EQ(adapter.cmdType_, 0U);
    EXPECT_EQ(adapter.vfId_, 0U);
    EXPECT_EQ(adapter.tid_, 0U);
    EXPECT_EQ(adapter.tsId_, 0U);
}

TEST_F(TsMsgAdapterTEST, ResponseToTsSqe)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TestAdapter adapter;
    TsAicpuSqe aicpuSqe = {};
    int32_t ret = adapter.ResponseToTs(aicpuSqe, 0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsMsgAdapterTEST, ResponseToTsMsgInfo)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TestAdapter adapter;
    TsAicpuMsgInfo aicpuMsgInfo = {};
    int32_t ret = adapter.ResponseToTs(aicpuMsgInfo, 0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsMsgAdapterTEST, ResponseToTsHwts)
{
    MOCKER(halEschedAckEvent).stubs().will(returnValue(DRV_ERROR_NONE));
    
    TestAdapter adapter;
    hwts_response_t hwtsResp = {};
    int32_t ret = adapter.ResponseToTs(hwtsResp, 0, EVENT_TS_CTRL_MSG, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
