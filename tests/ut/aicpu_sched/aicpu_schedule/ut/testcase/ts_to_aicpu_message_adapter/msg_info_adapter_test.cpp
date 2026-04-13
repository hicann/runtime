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
#include "ts_aicpu_msg_info_adapter.h"

using namespace AicpuSchedule;
using namespace aicpu;

class TsAicpuMsgInfoAdapterTEST : public ::testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TsAicpuMsgInfoAdapterTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TsAicpuMsgInfoAdapterTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "TsAicpuMsgInfoAdapterTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "TsAicpuMsgInfoAdapterTEST TearDown" << std::endl;
    }
};

TEST_F(TsAicpuMsgInfoAdapterTEST, ConstructorWithMsgInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.pid = 1;
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    msgInfo.vf_id = 2;
    msgInfo.tid = 3;
    msgInfo.ts_id = 4;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    EXPECT_EQ(adapter.pid_, 1);
    EXPECT_EQ(adapter.cmdType_, TS_AICPU_MODEL_OPERATE);
    EXPECT_EQ(adapter.vfId_, 2);
    EXPECT_EQ(adapter.tid_, 3);
    EXPECT_EQ(adapter.tsId_, 4);
    EXPECT_FALSE(adapter.IsAdapterInvaildParameter());
}

TEST_F(TsAicpuMsgInfoAdapterTEST, DefaultConstructor)
{
    TsAicpuMsgInfoAdapter adapter;
    EXPECT_TRUE(adapter.IsAdapterInvaildParameter());
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuModelOperateInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    msgInfo.u.aicpu_model_operate.arg_ptr = 0x5A5A;
    msgInfo.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    msgInfo.u.aicpu_model_operate.model_id = 63;
    msgInfo.u.aicpu_model_operate.stream_id = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuModelOperateInfo info = {};
    adapter.GetAicpuModelOperateInfo(info);
    
    EXPECT_EQ(info.arg_ptr, 0x5A5A);
    EXPECT_EQ(info.cmd_type, TS_AICPU_MODEL_LOAD);
    EXPECT_EQ(info.model_id, 63);
    EXPECT_EQ(info.stream_id, 1);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuTaskReportInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_TASK_REPORT;
    msgInfo.u.ts_to_aicpu_task_report.task_id = 8;
    msgInfo.u.ts_to_aicpu_task_report.model_id = 8;
    msgInfo.u.ts_to_aicpu_task_report.result_code = 8;
    msgInfo.u.ts_to_aicpu_task_report.stream_id = 8;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuTaskReportInfo info = {};
    adapter.GetAicpuTaskReportInfo(info);
    
    EXPECT_EQ(info.task_id, 8);
    EXPECT_EQ(info.model_id, 8);
    EXPECT_EQ(info.result_code, 8);
    EXPECT_EQ(info.stream_id, 8);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuDataDumpInfoNormal)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_task_id = 8;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_stream_id = 8;
    msgInfo.u.ts_to_aicpu_normal_datadump.is_model = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuDataDumpInfo info = {};
    adapter.GetAicpuDataDumpInfo(info);
    
    EXPECT_EQ(info.dump_task_id, 8);
    EXPECT_EQ(info.dump_stream_id, INVALID_VALUE16);
    EXPECT_EQ(info.is_model, true);
    EXPECT_EQ(info.is_debug, false);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuDataDumpInfoDebug)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;
    msgInfo.u.ts_to_aicpu_debug_datadump.dump_task_id = 8;
    msgInfo.u.ts_to_aicpu_debug_datadump.debug_dump_task_id = 9;
    msgInfo.u.ts_to_aicpu_debug_datadump.dump_stream_id = 8;
    msgInfo.u.ts_to_aicpu_debug_datadump.is_model = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuDataDumpInfo info = {};
    adapter.GetAicpuDataDumpInfo(info);
    
    EXPECT_EQ(info.dump_task_id, 8);
    EXPECT_EQ(info.debug_dump_task_id, 9);
    EXPECT_EQ(info.is_model, true);
    EXPECT_EQ(info.is_debug, true);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuDataDumpInfoDefault)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = 0xFF;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuDataDumpInfo info = {};
    adapter.GetAicpuDataDumpInfo(info);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, IsOpMappingDumpTaskInfoVaild)
{
    TsAicpuMsgInfo msgInfo = {};
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    
    AicpuOpMappingDumpTaskInfo info(1, 2, 3, 4);
    EXPECT_TRUE(adapter.IsOpMappingDumpTaskInfoVaild(info));
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuDumpTaskInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuOpMappingDumpTaskInfo opmappingInfo(100, 200, 300, 400);
    AicpuDumpTaskInfo dumpTaskInfo = {};
    adapter.GetAicpuDumpTaskInfo(opmappingInfo, dumpTaskInfo);
    
    EXPECT_EQ(dumpTaskInfo.task_id, 100);
    EXPECT_EQ(dumpTaskInfo.stream_id, INVALID_VALUE16);
    EXPECT_EQ(dumpTaskInfo.context_id, INVALID_VALUE16);
    EXPECT_EQ(dumpTaskInfo.thread_id, INVALID_VALUE16);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuDataDumpInfoLoad)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_DATADUMP_INFO_LOAD;
    msgInfo.u.ts_to_aicpu_datadump_info_load.dumpinfoPtr = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.length = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.task_id = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.stream_id = 8;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuDataDumpInfoLoad info = {};
    adapter.GetAicpuDataDumpInfoLoad(info);
    
    EXPECT_EQ(info.dumpinfoPtr, 8);
    EXPECT_EQ(info.length, 8);
    EXPECT_EQ(info.task_id, 8);
    EXPECT_EQ(info.stream_id, 8);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuDumpResponseToTsNormal)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_task_id = 8;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_stream_id = 8;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_type = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuDumpResponseToTsDebug)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_DEBUG_DATADUMP_REPORT;
    msgInfo.u.ts_to_aicpu_debug_datadump.dump_task_id = 8;
    msgInfo.u.ts_to_aicpu_debug_datadump.debug_dump_task_id = 9;
    msgInfo.u.ts_to_aicpu_debug_datadump.dump_stream_id = 8;
    msgInfo.u.ts_to_aicpu_debug_datadump.dump_type = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuDumpResponseToTsInvalid)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = 0xFF;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuDataDumpLoadResponseToTs)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_DATADUMP_INFO_LOAD;
    msgInfo.u.ts_to_aicpu_datadump_info_load.dumpinfoPtr = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.length = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.task_id = 8;
    msgInfo.u.ts_to_aicpu_datadump_info_load.stream_id = 8;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuDataDumpLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuModelOperateResponseToTs)
{
    MOCKER(halEschedAckEvent).stubs().will(returnValue(DRV_ERROR_NONE));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuModelOperateResponseToTs(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuActiveStreamSetMsg)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    ActiveStreamInfo info(1, 2, 0x12345678, 3, 4);
    adapter.AicpuActiveStreamSetMsg(info);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuMsgVersionInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    
    AicpuMsgVersionInfo info = {};
    adapter.GetAicpuMsgVersionInfo(info);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuMsgVersionResponseToTs)
{
    TsAicpuMsgInfo msgInfo = {};
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    
    int32_t ret = adapter.AicpuMsgVersionResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, ErrorMsgResponseToTs)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_TASK_REPORT;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    ErrMsgRspInfo rspInfo(1, 2, 3, 4, 5, 6);
    int32_t ret = adapter.ErrorMsgResponseToTs(rspInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuNoticeTsPidResponse)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    
    int32_t ret = adapter.AicpuNoticeTsPidResponse(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuTimeOutConfigInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_TIMEOUT_CONFIG;
    msgInfo.u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    msgInfo.u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 500;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuTimeOutConfigInfo info = {};
    adapter.GetAicpuTimeOutConfigInfo(info);
    
    EXPECT_EQ((uint32_t)info.i.op_execute_timeout_en, 1);
    EXPECT_EQ((uint32_t)info.i.op_execute_timeout, 500);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuTimeOutConfigResponseToTs)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_TIMEOUT_CONFIG;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicpuInfoLoad)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_INFO_LOAD;
    msgInfo.u.ts_to_aicpu_info_load.aicpu_info_ptr = 1;
    msgInfo.u.ts_to_aicpu_info_load.length = 1;
    msgInfo.u.ts_to_aicpu_info_load.stream_id = 8;
    msgInfo.u.ts_to_aicpu_info_load.task_id = 8;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuInfoLoad info = {};
    adapter.GetAicpuInfoLoad(info);
    
    EXPECT_EQ(info.aicpuInfoPtr, 1);
    EXPECT_EQ(info.length, 1);
    EXPECT_EQ(info.stream_id, 8);
    EXPECT_EQ(info.task_id, 8);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuInfoLoadResponseToTs)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_INFO_LOAD;
    msgInfo.u.ts_to_aicpu_info_load.aicpu_info_ptr = 1;
    msgInfo.u.ts_to_aicpu_info_load.length = 1;
    msgInfo.u.ts_to_aicpu_info_load.stream_id = 8;
    msgInfo.u.ts_to_aicpu_info_load.task_id = 8;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    int32_t ret = adapter.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, GetAicErrReportInfo)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AIC_ERROR_REPORT;
    msgInfo.u.aic_err_msg.result_code = 1;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicErrReportInfo info = {};
    adapter.GetAicErrReportInfo(info);
    
    EXPECT_EQ(info.u.aicErrorMsg.result_code, 1);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuRecordResponseToTsSuccess)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuRecordInfo info(1, 2, 0, 3, 4, 5, 6);
    int32_t ret = adapter.AicpuRecordResponseToTs(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuMsgInfoAdapterTEST, AicpuRecordResponseToTsFail)
{
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.cmd_type = TS_AICPU_MODEL_OPERATE;
    
    TsAicpuMsgInfoAdapter adapter(msgInfo);
    AicpuRecordInfo info(1, 2, 1, 3, 4, 5, 6);
    int32_t ret = adapter.AicpuRecordResponseToTs(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
