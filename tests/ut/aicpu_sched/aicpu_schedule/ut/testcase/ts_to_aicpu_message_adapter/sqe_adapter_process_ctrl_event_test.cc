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
class SqeMessageAdapterTEST : public ::testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "SqeMessageAdapterTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "SqeMessageAdapterTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "SqeMessageAdapterTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "SqeMessageAdapterTEST TearDown" << std::endl;
    }
};

static void MOCK()
{
    uint16_t version = 0;
    uint16_t pid = 1;
    uint16_t vfId = 2;
    AicpuDrvManager::GetInstance().isInit_ = true;
    AicpuDrvManager::GetInstance().hostPid_ = pid;
    AicpuDrvManager::GetInstance().vfId_ = vfId;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(version));
    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess).stubs().will(returnValue(0));
    MOCKER(halEschedAckEvent).stubs().will(invoke(SqehalEschedAckEventStub));
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(SqetsDevSendMsgAsyncStub));
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlEventMsgVersion)
{
    uint16_t version = 0;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion).stubs().will(returnValue(version));
    MOCKER_CPP(&AicpuScheduleInterface::LoadProcess).stubs().will(returnValue(0));
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);
    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_MSG_VERSION;
    info->u.aicpu_msg_version.magic_num = 0x5A5A;
    info->u.aicpu_msg_version.version = 1;

    expMsg_.pid = 1;
    expMsg_.vf_id = 2;
    expMsg_.tid = 3;
    expMsg_.ts_id = 4;
    expMsg_.cmd_type = AICPU_MSG_VERSION;
    expMsg_.u.aicpu_resp.result_code = 0;
    expMsg_.u.aicpu_resp.task_id = UINT32_MAX;
    MOCKER(tsDevSendMsgAsync).stubs().will(invoke(MsgInfotsDevSendMsgAsyncStub));
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlEventModelOperate)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;

    info->cmd_type = AICPU_MODEL_OPERATE;
    expSqe_.cmd_type = AICPU_MODEL_OPERATE_RESPONSE;

    info->u.aicpu_model_operate.arg_ptr = 0x5A5A;
    info->u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    info->u.aicpu_model_operate.model_id = 63;
    info->u.aicpu_model_operate.sq_id = 0;
    info->u.aicpu_model_operate.task_id = 0;

    expSqe_.u.aicpu_model_operate_resp.cmd_type = AICPU_MODEL_OPERATE;
    expSqe_.u.aicpu_model_operate_resp.sub_cmd_type = TS_AICPU_MODEL_LOAD;
    expSqe_.u.aicpu_model_operate_resp.model_id = 63;
    expSqe_.u.aicpu_model_operate_resp.result_code = 0;
    expSqe_.u.aicpu_model_operate_resp.task_id = 0;
    expSqe_.u.aicpu_model_operate_resp.sq_id = 0;

    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlTaskReport)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AIC_TASK_REPORT;
    info->u.ts_to_aicpu_task_report.task_id = 8;
    info->u.ts_to_aicpu_task_report.model_id = 8;
    info->u.ts_to_aicpu_task_report.result_code = 8;
    info->u.ts_to_aicpu_task_report.stream_id = 8;
    AicpuModel retModel;

    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(static_cast<AicpuSchedule::AicpuModel*>(nullptr)))
        .then(returnValue(&retModel));
    MOCKER_CPP(
        static_cast<uint32_t (AicpuModelErrProc::*)(const AicoreErrMsgInfo&, uint32_t, uint32_t&)>(
            &AicpuModelErrProc::AddErrLog))
        .stubs()
        .will(returnValue((uint32_t)0));
    MOCKER_CPP(&AicpuModel::GetModelTsId).stubs().will(returnValue(1));

    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 0;
    expSqe_.ts_id = 1;
    expSqe_.cmd_type = AICPU_ERR_MSG_REPORT;

    expSqe_.u.aicpu_err_msg_report.result_code = 8;
    expSqe_.u.aicpu_err_msg_report.stream_id = 8;
    expSqe_.u.aicpu_err_msg_report.task_id = 8;
    expSqe_.u.aicpu_err_msg_report.offset = UINT32_MAX;

    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlDataDumpReport)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_DATADUMP_REPORT;

    info->u.ts_to_aicpu_datadump.model_id = UINT16_MAX;
    info->u.ts_to_aicpu_datadump.stream_id = 8;
    info->u.ts_to_aicpu_datadump.task_id = 8;
    info->u.ts_to_aicpu_datadump.stream_id1 = UINT16_MAX;
    info->u.ts_to_aicpu_datadump.task_id1 = UINT16_MAX;
    info->u.ts_to_aicpu_datadump.ack_stream_id = 8;
    info->u.ts_to_aicpu_datadump.ack_task_id = 8;
    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_DATADUMP_RESPONSE;
    expSqe_.u.aicpu_dump_resp.result_code = 0;
    expSqe_.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_REPORT;
    expSqe_.u.aicpu_dump_resp.stream_id = 8;
    expSqe_.u.aicpu_dump_resp.task_id = 8;
    MOCKER_CPP(
        static_cast<int32_t (OpDumpTaskManager::*)(TaskInfoExt&, const DumpFileName&)>(&OpDumpTaskManager::DumpOpInfo))
        .stubs()
        .will(returnValue(0));

    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlDebugDataDumpReport)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->cmd_type = AICPU_DATADUMP_REPORT;
    info->pid = 1;
    info->ts_id = 4;
    info->vf_id = 2;
    info->tid = 3;

    info->u.ts_to_aicpu_datadump.model_id = 2;
    info->u.ts_to_aicpu_datadump.stream_id = 8;
    info->u.ts_to_aicpu_datadump.task_id = 8;
    info->u.ts_to_aicpu_datadump.stream_id1 = 9;
    info->u.ts_to_aicpu_datadump.task_id1 = 9;
    info->u.ts_to_aicpu_datadump.ack_stream_id = 8;
    info->u.ts_to_aicpu_datadump.ack_task_id = 8;

    MOCKER_CPP(
        static_cast<int32_t (OpDumpTaskManager::*)(TaskInfoExt&, const DumpFileName&)>(&OpDumpTaskManager::DumpOpInfo))
        .stubs()
        .will(returnValue(0));
    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_DATADUMP_RESPONSE;

    expSqe_.u.aicpu_dump_resp.result_code = 0;
    expSqe_.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_REPORT;
    expSqe_.u.aicpu_dump_resp.task_id = 8;
    expSqe_.u.aicpu_dump_resp.stream_id = 8;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlDataDumpLoadInfoReport)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_DATADUMP_LOADINFO;

    info->u.ts_to_aicpu_datadumploadinfo.dumpinfoPtr = 8;
    info->u.ts_to_aicpu_datadumploadinfo.length = 8;
    info->u.ts_to_aicpu_datadumploadinfo.task_id = 8;
    info->u.ts_to_aicpu_datadumploadinfo.stream_id = 8;

    MOCKER_CPP(
        static_cast<int32_t (OpDumpTaskManager::*)(const char_t* const, const uint32_t, AicpuSqeAdapter&)>(
            &OpDumpTaskManager::LoadOpMappingInfo))
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(GetAicpuRunMode).stubs().will(returnValue(0));
    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_DATADUMP_RESPONSE;

    expSqe_.u.aicpu_dump_resp.result_code = 0;
    expSqe_.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_LOADINFO;
    expSqe_.u.aicpu_dump_resp.task_id = 8;
    expSqe_.u.aicpu_dump_resp.stream_id = 8;
    expSqe_.u.aicpu_dump_resp.reserved = STARS_DATADUMP_LOAD_INFO;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlTimeoutConfig)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_TIMEOUT_CONFIG;

    info->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    info->u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 500;
    info->u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    info->u.ts_to_aicpu_timeout_cfg.op_wait_timeout_en = 0;
    info->u.ts_to_aicpu_timeout_cfg.op_wait_timeout = 0;

    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_TIMEOUT_CONFIG_RESPONSE;

    expSqe_.u.aicpu_timeout_cfg_resp.result = 0;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlFftsPlusDataDumpReport)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_FFTS_PLUS_DATADUMP_REPORT;

    info->u.ts_to_aicpu_ffts_plus_datadump.model_id = UINT16_MAX;
    info->u.ts_to_aicpu_ffts_plus_datadump.stream_id = 8;
    info->u.ts_to_aicpu_ffts_plus_datadump.task_id = 8;
    info->u.ts_to_aicpu_ffts_plus_datadump.stream_id1 = UINT16_MAX;
    info->u.ts_to_aicpu_ffts_plus_datadump.task_id1 = UINT16_MAX;
    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_DATADUMP_RESPONSE;

    expSqe_.u.aicpu_dump_resp.result_code = 0;
    expSqe_.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_REPORT;
    expSqe_.u.aicpu_dump_resp.task_id = 8;
    expSqe_.u.aicpu_dump_resp.stream_id = 8;
    MOCKER_CPP(
        static_cast<int32_t (OpDumpTaskManager::*)(TaskInfoExt&, const DumpFileName&)>(&OpDumpTaskManager::DumpOpInfo))
        .stubs()
        .will(returnValue(0));

    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ClearMsgAndSqe();
}

TEST_F(SqeMessageAdapterTEST, ProcessHWTSControlInfoLoad)
{
    MOCK();
    event_info eventInfo{};
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe* info = reinterpret_cast<TsAicpuSqe*>(eventInfo.priv.msg);

    info->pid = 1;
    info->vf_id = 2;
    info->tid = 3;
    info->ts_id = 4;
    info->cmd_type = AICPU_INFO_LOAD;

    info->u.ts_to_aicpu_info.aicpuInfoPtr = 1;
    info->u.ts_to_aicpu_info.length = 1;
    info->u.ts_to_aicpu_info.stream_id = 8;
    info->u.ts_to_aicpu_info.task_id = 8;

    expSqe_.pid = 1;
    expSqe_.vf_id = 2;
    expSqe_.tid = 3;
    expSqe_.ts_id = 4;
    expSqe_.cmd_type = AICPU_INFO_LOAD_RESPONSE;
    expSqe_.u.aicpu_resp.result_code = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    expSqe_.u.aicpu_resp.cmd_type = AICPU_INFO_LOAD;
    expSqe_.u.aicpu_resp.task_id = 8;
    expSqe_.u.aicpu_resp.stream_id = 8;
    int ret = AicpuEventManager::GetInstance().ProcessHWTSControlEvent(eventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ClearMsgAndSqe();
}