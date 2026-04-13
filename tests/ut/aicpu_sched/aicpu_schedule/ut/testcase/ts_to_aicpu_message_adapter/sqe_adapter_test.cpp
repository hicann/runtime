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
#include "ts_aicpu_sqe_adapter.h"

using namespace AicpuSchedule;
using namespace aicpu;

class TsAicpuSqeAdapterTEST : public ::testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TsAicpuSqeAdapterTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TsAicpuSqeAdapterTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "TsAicpuSqeAdapterTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "TsAicpuSqeAdapterTEST TearDown" << std::endl;
    }
};

TEST_F(TsAicpuSqeAdapterTEST, ConstructorWithSqe)
{
    TsAicpuSqe sqe = {};
    sqe.pid = 1;
    sqe.cmd_type = AICPU_MODEL_OPERATE;
    sqe.vf_id = 2;
    sqe.tid = 3;
    sqe.ts_id = 4;
    
    TsAicpuSqeAdapter adapter(sqe);
    EXPECT_EQ(adapter.pid_, 1);
    EXPECT_EQ(adapter.cmdType_, AICPU_MODEL_OPERATE);
    EXPECT_EQ(adapter.vfId_, 2);
    EXPECT_EQ(adapter.tid_, 3);
    EXPECT_EQ(adapter.tsId_, 4);
    EXPECT_FALSE(adapter.IsAdapterInvaildParameter());
}

TEST_F(TsAicpuSqeAdapterTEST, DefaultConstructor)
{
    TsAicpuSqeAdapter adapter;
    EXPECT_TRUE(adapter.IsAdapterInvaildParameter());
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuModelOperateInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_MODEL_OPERATE;
    sqe.u.aicpu_model_operate.arg_ptr = 0x5A5A;
    sqe.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    sqe.u.aicpu_model_operate.model_id = 63;
    sqe.u.aicpu_model_operate.sq_id = 1;
    sqe.u.aicpu_model_operate.task_id = 2;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuModelOperateInfo info = {};
    adapter.GetAicpuModelOperateInfo(info);
    
    EXPECT_EQ(info.arg_ptr, 0x5A5A);
    EXPECT_EQ(info.cmd_type, TS_AICPU_MODEL_LOAD);
    EXPECT_EQ(info.model_id, 63);
    EXPECT_EQ(info.stream_id, 1);
    EXPECT_EQ(info.task_id, 2);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuTaskReportInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AIC_TASK_REPORT;
    sqe.u.ts_to_aicpu_task_report.task_id = 8;
    sqe.u.ts_to_aicpu_task_report.model_id = 8;
    sqe.u.ts_to_aicpu_task_report.result_code = 8;
    sqe.u.ts_to_aicpu_task_report.stream_id = 8;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuTaskReportInfo info = {};
    adapter.GetAicpuTaskReportInfo(info);
    
    EXPECT_EQ(info.task_id, 8);
    EXPECT_EQ(info.model_id, 8);
    EXPECT_EQ(info.result_code, 8);
    EXPECT_EQ(info.stream_id, 8);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuDataDumpInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_DATADUMP_REPORT;
    sqe.u.ts_to_aicpu_datadump.model_id = 2;
    sqe.u.ts_to_aicpu_datadump.stream_id = 8;
    sqe.u.ts_to_aicpu_datadump.task_id = 8;
    sqe.u.ts_to_aicpu_datadump.stream_id1 = 9;
    sqe.u.ts_to_aicpu_datadump.task_id1 = 9;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuDataDumpInfo info = {};
    adapter.GetAicpuDataDumpInfo(info);
    
    EXPECT_EQ(info.dump_task_id, 8);
    EXPECT_EQ(info.dump_stream_id, 8);
    EXPECT_EQ(info.debug_dump_task_id, 9);
    EXPECT_EQ(info.debug_dump_stream_id, 9);
    EXPECT_EQ(info.is_model, true);
    EXPECT_EQ(info.is_debug, true);
}

TEST_F(TsAicpuSqeAdapterTEST, IsOpMappingDumpTaskInfoVaild)
{
    TsAicpuSqe sqe = {};
    TsAicpuSqeAdapter adapter(sqe);
    
    AicpuOpMappingDumpTaskInfo info(1, 2, 3, 4);
    EXPECT_TRUE(adapter.IsOpMappingDumpTaskInfoVaild(info));
    
    AicpuOpMappingDumpTaskInfo infoInvalid(0xFFFF + 1, 2, 3, 4);
    EXPECT_FALSE(adapter.IsOpMappingDumpTaskInfoVaild(infoInvalid));
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuDataDumpInfoLoad)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_DATADUMP_LOADINFO;
    sqe.u.ts_to_aicpu_datadumploadinfo.dumpinfoPtr = 8;
    sqe.u.ts_to_aicpu_datadumploadinfo.length = 8;
    sqe.u.ts_to_aicpu_datadumploadinfo.task_id = 8;
    sqe.u.ts_to_aicpu_datadumploadinfo.stream_id = 8;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuDataDumpInfoLoad info = {};
    adapter.GetAicpuDataDumpInfoLoad(info);
    
    EXPECT_EQ(info.dumpinfoPtr, 8);
    EXPECT_EQ(info.length, 8);
    EXPECT_EQ(info.task_id, 8);
    EXPECT_EQ(info.stream_id, 8);
}

TEST_F(TsAicpuSqeAdapterTEST, TsAicpuSqeTimeOutConfigInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_TIMEOUT_CONFIG;
    sqe.u.ts_to_aicpu_timeout_cfg.op_execute_timeout_en = 1;
    sqe.u.ts_to_aicpu_timeout_cfg.op_execute_timeout = 500;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuTimeOutConfigInfo info = {};
    adapter.GetAicpuTimeOutConfigInfo(info);
    
    EXPECT_EQ((uint32_t)info.i.op_execute_timeout_en, 1);
    EXPECT_EQ((uint32_t)info.i.op_execute_timeout, 500);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuInfoLoad)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_INFO_LOAD;
    sqe.u.ts_to_aicpu_info.aicpuInfoPtr = 1;
    sqe.u.ts_to_aicpu_info.length = 1;
    sqe.u.ts_to_aicpu_info.stream_id = 8;
    sqe.u.ts_to_aicpu_info.task_id = 8;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuInfoLoad info = {};
    adapter.GetAicpuInfoLoad(info);
    
    EXPECT_EQ(info.aicpuInfoPtr, 1);
    EXPECT_EQ(info.length, 1);
    EXPECT_EQ(info.stream_id, 8);
    EXPECT_EQ(info.task_id, 8);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuMsgVersionInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_MSG_VERSION;
    sqe.u.aicpu_msg_version.magic_num = 0x5A5A;
    sqe.u.aicpu_msg_version.version = 1;
    
    TsAicpuSqeAdapter adapter(sqe);
    AicpuMsgVersionInfo info = {};
    adapter.GetAicpuMsgVersionInfo(info);
    
    EXPECT_EQ(info.magic_num, 0x5A5A);
    EXPECT_EQ(info.version, 1);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicErrReportInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AIC_ERROR_REPORT;
    sqe.u.ts_to_aicpu_aic_err_report.result_code = 1;

    TsAicpuSqeAdapter adapter(sqe);
    AicErrReportInfo info = {};
    adapter.GetAicErrReportInfo(info);

    EXPECT_EQ(info.u.aicError.result_code, 1);
}

TEST_F(TsAicpuSqeAdapterTEST, GetAicpuDumpFFTSPlusDataInfo)
{
    TsAicpuSqe sqe = {};
    sqe.cmd_type = AICPU_FFTS_PLUS_DATADUMP_REPORT;
    sqe.u.ts_to_aicpu_ffts_plus_datadump.model_id = 10;
    sqe.u.ts_to_aicpu_ffts_plus_datadump.stream_id = 5;
    sqe.u.ts_to_aicpu_ffts_plus_datadump.task_id = 6;

    TsAicpuSqeAdapter adapter(sqe);
    AicpuDumpFFTSPlusDataInfo info = {};
    adapter.GetAicpuDumpFFTSPlusDataInfo(info);

    EXPECT_EQ(info.i.model_id, 10);
    EXPECT_EQ(info.i.stream_id, 5);
    EXPECT_EQ(info.i.task_id, 6);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuDumpResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.pid = 100;
    sqe.vf_id = 1;
    sqe.tid = 2;
    sqe.ts_id = 3;
    sqe.cmd_type = AICPU_DATADUMP_REPORT;
    sqe.u.ts_to_aicpu_datadump.ack_stream_id = 10;
    sqe.u.ts_to_aicpu_datadump.ack_task_id = 20;
    sqe.u.ts_to_aicpu_datadump.model_id = 5;

    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    TsAicpuSqeAdapter adapter(sqe);
    int32_t ret = adapter.AicpuDumpResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuDataDumpLoadResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.tid = 2;
    sqe.ts_id = 3;
    sqe.cmd_type = AICPU_DATADUMP_LOADINFO;
    sqe.u.ts_to_aicpu_datadumploadinfo.task_id = 15;
    sqe.u.ts_to_aicpu_datadumploadinfo.stream_id = 25;
    TsAicpuSqeAdapter adapter(sqe);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuDataDumpLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(TsAicpuSqeAdapterTEST, AicpuModelOperateResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.vf_id = 1;
    sqe.tid = 2;
    sqe.ts_id = 3;
    sqe.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_LOAD;
    sqe.u.aicpu_model_operate.model_id = 10;
    sqe.u.aicpu_model_operate.task_id = 5;
    sqe.u.aicpu_model_operate.sq_id = 6;

    TsAicpuSqeAdapter adapter(sqe);
    MOCKER(halEschedAckEvent).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuModelOperateResponseToTs(0, 1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuMsgVersionResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.tid = 2;
    sqe.ts_id = 3;
    sqe.cmd_type = AICPU_MSG_VERSION;
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    TsAicpuSqeAdapter adapter(sqe);
    int32_t ret = adapter.AicpuMsgVersionResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, ErrorMsgResponseToTs)
{
    TsAicpuSqe sqe = {};
    TsAicpuSqeAdapter adapter(sqe);
    
    ErrMsgRspInfo rspInfo = {};
    rspInfo.ts_id = 3;
    rspInfo.err_code = 1;
    rspInfo.stream_id = 10;
    rspInfo.task_id = 20;
    rspInfo.model_id = 5;
    rspInfo.offset = 0;

    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    int32_t ret = adapter.ErrorMsgResponseToTs(rspInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuTimeOutConfigResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.tid = 2;
    sqe.ts_id = 3;

    TsAicpuSqeAdapter adapter(sqe);
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuTimeOutConfigResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuInfoLoadResponseToTs)
{
    TsAicpuSqe sqe = {};
    sqe.tid = 2;
    sqe.ts_id = 3;
    sqe.u.ts_to_aicpu_info.task_id = 15;
    sqe.u.ts_to_aicpu_info.stream_id = 25;

    TsAicpuSqeAdapter adapter(sqe);

    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuInfoLoadResponseToTs(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuRecordResponseToTsWithError)
{
    TsAicpuSqe sqe = {};
    TsAicpuSqeAdapter adapter(sqe);
    
    AicpuRecordInfo info = {};
    info.ts_id = 3;
    info.record_type = 1;
    info.record_id = 100;
    info.fault_task_id = 10;
    info.fault_stream_id = 20;
    info.ret_code = 1;
    info.dev_id = 0;
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuRecordResponseToTs(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(TsAicpuSqeAdapterTEST, AicpuRecordResponseToTsSuccess)
{
    TsAicpuSqe sqe = {};
    TsAicpuSqeAdapter adapter(sqe);
    
    AicpuRecordInfo info = {};
    info.ts_id = 3;
    info.record_type = 1;
    info.record_id = 100;
    info.fault_task_id = 10;
    info.fault_stream_id = 20;
    info.ret_code = 0;
    info.dev_id = 0;

    MOCKER(halTsDevRecord).stubs().will(returnValue(0));
    int32_t ret = adapter.AicpuRecordResponseToTs(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
