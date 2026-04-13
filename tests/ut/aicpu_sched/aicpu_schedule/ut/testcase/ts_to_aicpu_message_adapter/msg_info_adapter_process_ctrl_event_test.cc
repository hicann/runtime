/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
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
using namespace AicpuSchedule;
using namespace aicpu;
class MsgInfoMessageAdapterTEST : public ::testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "MsgInfoMessageAdapterTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "MsgInfoMessageAdapterTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "MsgInfoMessageAdapterTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "MsgInfoMessageAdapterTEST TearDown" << std::endl;
    }
};

static void MOCK() 
{
    uint16_t version = 1;
    uint16_t pid = 1;
    uint16_t vfId = 2;
    AicpuDrvManager::GetInstance().isInit_ = true;
    AicpuDrvManager::GetInstance().hostPid_  = pid;
    AicpuDrvManager::GetInstance().vfId_  = vfId;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER(halEschedAckEvent)
        .stubs()
        .will(invoke(MsgInfohalEschedAckEventStub));
    MOCKER(tsDevSendMsgAsync)
        .stubs()
        .will(invoke(MsgInfotsDevSendMsgAsyncStub));
    
}

static void MOCK_DUMP() 
{
    
}


TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlEventModelOperate) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;

    info->cmd_type = TS_AICPU_MODEL_OPERATE;
    expMsg_.cmd_type = TS_AICPU_MODEL_OPERATE;


    info->u.aicpu_model_operate.arg_ptr = 0x5A5A;
    info->u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    info->u.aicpu_model_operate.model_id = 63;
    info->u.aicpu_model_operate.stream_id = 0;

    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess)
        .stubs()
        .will(returnValue(0));
    
    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.stream_id = UINT16_MAX;
    expMsg_.u.aicpu_resp.task_id = UINT32_MAX;
    expMsg_.u.aicpu_resp.reserved = 0;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlTaskReport) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_TASK_REPORT;
    info->u.ts_to_aicpu_task_report.task_id = 8;
    info->u.ts_to_aicpu_task_report.model_id = 8;
    info->u.ts_to_aicpu_task_report.result_code = 8;
    info->u.ts_to_aicpu_task_report.stream_id = 8;
    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 0;
    expMsg_.ts_id = 1;
    expMsg_.cmd_type = TS_AICPU_TASK_REPORT;
    expMsg_.u.aicpu_resp.result_code = 8;
    expMsg_.u.aicpu_resp.stream_id = 8;
    expMsg_.u.aicpu_resp.task_id = 8;
    AicpuModel retModel;
    MOCKER_CPP(static_cast<uint32_t(AicpuModelErrProc:: *)(const AicoreErrMsgInfo&, uint32_t, uint32_t&)>(&AicpuModelErrProc::AddErrLog))
        .stubs()
        .will(returnValue((uint32_t)0));
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(static_cast<AicpuSchedule::AicpuModel *>(nullptr)))
        .then(returnValue(&retModel));
    MOCKER_CPP(&AicpuModel::GetModelTsId)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(static_cast<uint32_t(AicpuModelErrProc:: *)(const AicoreErrMsgInfo&, uint32_t, uint32_t&)>(&AicpuModelErrProc::AddErrLog))
        .stubs()
        .will(returnValue((uint32_t)0));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlDataDumpReport) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;

    info->u.ts_to_aicpu_normal_datadump.dump_type = 0;
    info->u.ts_to_aicpu_normal_datadump.dump_task_id = 8;
    info->u.ts_to_aicpu_normal_datadump.dump_stream_id = UINT16_MAX;
    info->u.ts_to_aicpu_normal_datadump.is_model = 0;

    MOCKER_CPP(static_cast<int32_t(OpDumpTaskManager::*)(TaskInfoExt &, const DumpFileName &)>(&OpDumpTaskManager::DumpOpInfo))
        .stubs()
        .will(returnValue(0));
    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;

    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.stream_id = UINT16_MAX;
    expMsg_.u.aicpu_resp.task_id = 8;
    expMsg_.u.aicpu_resp.reserved = 0;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlDebugDataDumpReport) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;

    info->u.ts_to_aicpu_debug_datadump.dump_type = 0;
    info->u.ts_to_aicpu_debug_datadump.dump_task_id = 8;
    info->u.ts_to_aicpu_debug_datadump.debug_dump_task_id = 9;
    info->u.ts_to_aicpu_debug_datadump.dump_stream_id = 8;
    info->u.ts_to_aicpu_debug_datadump.is_model = 1;

    MOCKER_CPP(static_cast<int32_t(OpDumpTaskManager::*)(TaskInfoExt &, const DumpFileName &)>(&OpDumpTaskManager::DumpOpInfo))
        .stubs()
        .will(returnValue(0));
    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;

    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.stream_id = 8;
    expMsg_.u.aicpu_resp.task_id = 9;
    expMsg_.u.aicpu_resp.reserved = 0;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlDataDumpLoadInfoReport) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_DATADUMP_INFO_LOAD;

    info->u.ts_to_aicpu_datadump_info_load.dumpinfoPtr = 8;
    info->u.ts_to_aicpu_datadump_info_load.length = 8;
    info->u.ts_to_aicpu_datadump_info_load.task_id = 8;
    info->u.ts_to_aicpu_datadump_info_load.stream_id = 8;

    MOCKER_CPP(static_cast<int32_t(OpDumpTaskManager::*)(const char_t * const, const uint32_t, AicpuSqeAdapter &)>(&OpDumpTaskManager::LoadOpMappingInfo))
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(GetAicpuRunMode)
        .stubs()
        .will(returnValue(0));
    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = TS_AICPU_DATADUMP_INFO_LOAD;

    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.task_id = 8;
    expMsg_.u.aicpu_resp.stream_id = 8;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlTimeoutConfig) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_TIMEOUT_CONFIG;

    info->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    info->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 500;
    info->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    info->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = TS_AICPU_TIMEOUT_CONFIG;

    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.stream_id = UINT16_MAX;
    expMsg_.u.aicpu_resp.task_id = UINT32_MAX;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(MsgInfoMessageAdapterTEST, ProcessHWTSControlInfoLoad) 
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuMsgInfo);
    TsAicpuMsgInfo *info = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = TS_AICPU_INFO_LOAD;

    info->u.ts_to_aicpu_info_load.aicpu_info_ptr = 1;
    info->u.ts_to_aicpu_info_load.length = 1;
    info->u.ts_to_aicpu_info_load.stream_id = 8;
    info->u.ts_to_aicpu_info_load.task_id = 8;

    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = TS_AICPU_INFO_LOAD;
    expMsg_.u.aicpu_resp.result_code = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    expMsg_.u.aicpu_resp.stream_id = 8;
    expMsg_.u.aicpu_resp.task_id = 8;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ClearMsgAndSqe();
}