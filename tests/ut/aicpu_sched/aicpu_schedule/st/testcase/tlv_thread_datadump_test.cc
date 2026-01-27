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

#include <dlfcn.h>
#include <iostream>
#include <memory>
#include <map>
#include <thread>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <sstream>
#include <dlfcn.h>
#include <limits>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "ascend_hal_stub.h"
#include "datadump_common.h"
#include "datadump_datadump.h"
#include "datadump_dump_op_info.h"
#include "datadump_event_manager.h"
#include "datadump_event_process.h"
#include "datadump_log.h"
#include "datadump_stats.h"
#include "datadump_tlv_prase.h"
#include "datadump_worker.h"
#include "datadump_write_file.h"
#include "ge_stub.h"
#include "lite_dbg_desc.h"
#include "datadump_type.h"
#undef private

using namespace DataDump;
class TlvDatadumpSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};
TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStSuccess)
{
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(1));
    InitDataDump();
    auto ret = StopDataDump();
    EXPECT_EQ(ret, DATADUMP_OK);
}

TEST_F(TlvDatadumpSt, StopDatadumpStSuccess)
{
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(1));
    InitDataDump();
    InitDataDump();
    auto ret = StopDataDump();
    EXPECT_EQ(ret, DATADUMP_OK);
}

TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStdumpAddrIsNullFail)
{
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(1));

    std::string dump_file_path;
    std::string dump_file_name;
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    DbgOutsideAddPara para;
    DumpOpInfo dumpOpInfo(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    dump_mailbox_info_t mailbox_out;
    mailbox_out.task_id = 0;
    mailbox_out.mid = 0;
    uint8_t ** a[10];
    for (int i = 0; i < 10; i++) {
        a[i] = nullptr;
    }
    mailbox_out.ioa_base_addr_l = a;
    mailbox_out.weight_base_addr_l = a;
    mailbox_out.workspace_base_addr_l = a;
    auto ret = DatadumpEventProcess::GetInstance().ProcessDumpDataEvent(mailbox_out);
    EXPECT_EQ(ret, 21001);
}
TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStdumpFail1)
{
    std::string statsFilePath;
    statsFilePath = statsFilePath + "./modelid/" + ".csv";
    OpDumpFile opDumpFile(statsFilePath);
    std::ostringstream oss;
    oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,"
        << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";
    opDumpFile.DoDump(nullptr, oss.str().size());
    auto ret = opDumpFile.DoDump(NULL, oss.str().size());
    EXPECT_LE(ret, DUMP_FILE_INVALID_PARAM_ERROR);
}
TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStloadFail)
{
    MOCKER(memcpy_s)
    .stubs()
    .will(returnValue(0));
    uint8_t file[] =
    {0,0,0,0,90,90,90,90,0,0,0,0,11,0,0,0,99,111,
     110,99,97,116,95,110,97,110,111,1,0,0,0,198,
     1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,0,1,0,0,0,0,169,1,0,0,
     0,0,0,0,8,0,0,0,99,111,110,99,97,116,118,
     50,1,0,0,0,9,0,0,0,67,111,110,99,97,116,86,50,
     68,2,0,0,0,12,0,0,0,8,0,0,0,99,111,110,99,97,
     116,118,50,4,0,0,0,180,0,0,0,2,0,0,
     0,1,0,0,0,1,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,120,114,0,
     0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,
     0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,1,0,0,
     0,4,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,0,0,0,0,0,0,0,48,0,0,
     0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,1,0,0,0,16,0,0,
     0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,5,0,0,0,120,0,0,0,1,0,0,0,1,0,0,
     0,1,0,0,0,4,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,16,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,180,114,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,
     0,90,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,
     0,2,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,8,0,0,0,48,0,0,0,1,0,0,0,0,115,0,
     0,0,0,0,0,224,114,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,229,0,0,0,0,0,0,0,0,0,0};
    uint32_t outsize = sizeof(file) / sizeof(uint8_t);
    void *outBUff = nullptr;
    uint32_t dumpPathLen = 5;
    uint32_t paraLen = sizeof(DbgModelDescTlv1) + sizeof(TlvHead32) + sizeof(TlvHead32) + dumpPathLen;

    outBUff = malloc(outsize + paraLen + dumpPathLen);
    memcpy(outBUff, file, outsize);
    TlvHead32 *tlv_head_ptr = (TlvHead32 *)((uint8_t *)outBUff + outsize);
    DbgModelDescTlv1 *dbgModelDesc = (DbgModelDescTlv1 *)(tlv_head_ptr->data);
    dbgModelDesc->flag = 1;
    dbgModelDesc->model_id = 0;
    dbgModelDesc->step_id_addr = (uint64_t *)outBUff;
    dbgModelDesc->iterations_per_loop_addr = 0;
    dbgModelDesc->loop_cond_addr = 0;
    dbgModelDesc->dump_mode = 2;
    dbgModelDesc->dump_data = 1;
    TlvHead32 *tlv2 = (TlvHead32*)(dbgModelDesc->l2_tlv);
    tlv2->type = DBG_L1_TLV_TYPE_DUMP_PATH;
    tlv2->len = 5;
    char *str = (char *)tlv2->data;
    str[0] = 'm';
    str[1] = 'u';
    str[2] = 'l';
    str[3] = 'u';
    str[4] = '\0';
    auto ret = DatadumpEventProcess::GetInstance().ProcessLoadOpMappingEvent(outBUff, outsize);
    EXPECT_EQ(ret, 0);
    dump_mailbox_info_t mailbox_out;
    mailbox_out.task_id = 0;
    mailbox_out.mid = 0;
    uint8_t ** a[10];
    mailbox_out.ioa_base_addr_l = a;
    mailbox_out.weight_base_addr_l = outBUff;
    mailbox_out.workspace_base_addr_l = outBUff;
    ret = DatadumpEventProcess::GetInstance().ProcessDumpDataEvent(mailbox_out);
    dbgModelDesc->flag = 0;
    ret = DatadumpEventProcess::GetInstance().ProcessLoadOpMappingEvent(outBUff, outsize);
    EXPECT_EQ(ret, 0);
    dbgModelDesc->flag = 2;
    ret = DatadumpEventProcess::GetInstance().ProcessLoadOpMappingEvent(outBUff, outsize);
    EXPECT_EQ(ret, 21002);
    free(outBUff);
}

TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStLoadSuccess)
{
    MOCKER(memcpy_s)
    .stubs()
    .will(returnValue(0));
    uint8_t file[] =
    {0,0,0,0,90,90,90,90,0,0,0,0,11,0,0,0,99,111,110,
     99,97,116,95,110,97,110,111,1,0,0,0,198,
     1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     0,0,0,1,0,0,0,0,169,1,0,0,
     0,0,0,0,8,0,0,0,99,111,110,99,97,116,118,
     50,1,0,0,0,9,0,0,0,67,111,110,99,97,116,86,50,
     68,2,0,0,0,12,0,0,0,8,0,0,0,99,111,110,99,97,
     116,118,50,4,0,0,0,180,0,0,0,2,0,0,
     0,1,0,0,0,1,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,120,114,0,
     0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,
     0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,1,0,0,
     0,4,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,0,0,0,0,0,0,0,48,0,0,
     0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,1,0,0,0,16,0,0,
     0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,5,0,0,0,120,0,0,0,1,0,0,0,1,0,0,
     0,1,0,0,0,4,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,16,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,180,114,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,
     0,90,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,
     0,2,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,8,0,0,0,48,0,0,0,1,0,0,0,0,115,0,
     0,0,0,0,0,224,114,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,229,0,0,0,0,0,0,0,0,0,0};
    uint32_t outsize = sizeof(file) / sizeof(uint8_t);
    void *outBUff = nullptr;
    uint32_t dumpPathLen = 5;
    uint32_t paraLen = sizeof(DbgModelDescTlv1) + sizeof(TlvHead32) + sizeof(TlvHead32) + dumpPathLen;

    outBUff = malloc(outsize + paraLen + dumpPathLen);
    memcpy(outBUff, file, outsize);
    TlvHead32 *tlv_head_ptr = (TlvHead32 *)((uint8_t *)outBUff + outsize);
    DbgModelDescTlv1 *dbgModelDesc = (DbgModelDescTlv1 *)(tlv_head_ptr->data);
    dbgModelDesc->flag = 1;
    dbgModelDesc->model_id = 0;
    dbgModelDesc->step_id_addr = (uint64_t *)outBUff;
    dbgModelDesc->iterations_per_loop_addr = 0;
    dbgModelDesc->loop_cond_addr = 0;
    dbgModelDesc->dump_mode = 2;
    dbgModelDesc->dump_data = 1;
    TlvHead32 *tlv2 = (TlvHead32*)(dbgModelDesc->l2_tlv);
    tlv2->type = DBG_L1_TLV_TYPE_DUMP_PATH;
    tlv2->len = 5;
    char *str = (char *)tlv2->data;
    str[0] = 'm'; str[1] = 'u'; str[2] = 'l'; str[3] = 'u'; str[4] = '\0';
    auto ret = DatadumpEventProcess::GetInstance().ProcessLoadOpMappingEvent(outBUff, outsize);
    EXPECT_EQ(ret, 0);
    dump_mailbox_info_t mailbox_out;
    mailbox_out.task_id = 0;
    mailbox_out.mid = 0;
    uint8_t ** a[10];
    mailbox_out.ioa_base_addr_l = a;
    mailbox_out.weight_base_addr_l = outBUff;
    mailbox_out.workspace_base_addr_l = outBUff;
    ret = DatadumpEventProcess::GetInstance().ProcessDumpDataEvent(mailbox_out);
    EXPECT_EQ(ret, 0);
    dbgModelDesc->dump_data = 0;
    ret = DatadumpEventProcess::GetInstance().ProcessDumpDataEvent(mailbox_out);
    EXPECT_EQ(ret, 0);
    dbgModelDesc->dump_data = 2;
    ret = DatadumpEventProcess::GetInstance().ProcessDumpDataEvent(mailbox_out);
    EXPECT_EQ(ret, 0);
    dbgModelDesc->flag = 0;
    ret = DatadumpEventProcess::GetInstance().ProcessLoadOpMappingEvent(outBUff, outsize);
    EXPECT_EQ(ret, 0);
    free(outBUff);
}

TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStdumpFail)
{
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    std::string statsFilePath;
    statsFilePath = statsFilePath + "./modelid/" + ".csv";
    OpDumpFile opDumpFile(statsFilePath);
    std::ostringstream oss;
    oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,"
        << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";
    opDumpFile.DoDump(nullptr, oss.str().size());
    auto ret = opDumpFile.DoDump((uint8_t *)(oss.str().c_str()), oss.str().size());
    EXPECT_LE(ret, DUMP_FILE_INVALID_PARAM_ERROR);
}

TEST_F(TlvDatadumpSt, DatadumpStOpDumpFilepass)
{
        std::string statsFilePath;
        statsFilePath = statsFilePath + "./modelid/" + ".csv";
        OpDumpFile opDumpFile(statsFilePath);
        std::ostringstream oss;
        oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,"
            << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";
        opDumpFile.DoDump(nullptr, oss.str().size());
        auto ret = opDumpFile.DoDump((uint8_t *)(oss.str().c_str()), 0);
        EXPECT_EQ(ret, 0);
}

TEST_F(TlvDatadumpSt, DatadumpStOpDumpFileSuccess)
{
        std::string statsFilePath;
        statsFilePath = statsFilePath + "./modelid/" + ".csv";
        OpDumpFile opDumpFile(statsFilePath);
        std::ostringstream oss;
        oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,"
            << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";
        auto ret = opDumpFile.DoDump((uint8_t *)(oss.str().c_str()), oss.str().size());
        EXPECT_EQ(ret, 0);
}

TEST_F(TlvDatadumpSt, DatadumpStGetDataFormatStrTest)
{
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
       workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GetDataFormatStr(UINT16_MAX);
    EXPECT_STREQ(ret.c_str(), "-");
}
TEST_F(TlvDatadumpSt, DatadumpStGetDataTypeStrTest)
{
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
       workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GetDataTypeStr(UINT16_MAX);
    EXPECT_STREQ(ret.c_str(), "-");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestInt32)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<int32_t[]> datas(new int32_t[dataLen]);
    const uint32_t dataSize = dataLen * sizeof(int32_t);

    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    std::cout << "datas.get()=" << datas.get() << std::endl;
    int32_t * a = datas.get();
    std::cout << "a[0]=" << a[0] << a[1] << std::endl;
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t*)(datas.get()), dataSize, DT_INT32);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}


TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestFloat)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<float[]> datas(new float[dataLen]);
    const uint32_t dataSize = dataLen * sizeof(float);

    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_FLOAT);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestFloat16)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_FLOAT16);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestFloat16_INF_NAN)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);
    Eigen::half inf = std::numeric_limits<Eigen::half>::infinity();
    Eigen::half ninf = -std::numeric_limits<Eigen::half>::infinity();;
    Eigen::half nan = std::numeric_limits<Eigen::half>::quiet_NaN();
    datas[0] = inf;
    datas[1] = ninf;
    datas[2] = nan;
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = opDumpTask->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_FLOAT16);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestUint8)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint8_t[]> datas(new uint8_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint8_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_UINT8);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestInt8)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<int8_t[]> datas(new int8_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int8_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((int8_t *)(datas.get()), dataSize, DT_INT8);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestInt16)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<int16_t[]> datas(new int16_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int16_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_INT16);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestUint16)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint16_t[]> datas(new uint16_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint16_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_UINT16);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestInt64)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<int64_t[]> datas(new int64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int64_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_INT64);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestUINT32)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint32_t[]> datas(new uint32_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint32_t);
 
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = opDumpTask->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_UINT32);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestUint64)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint64_t[]> datas(new uint64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint64_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_UINT64);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestBool)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<bool[]> datas(new bool[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(bool);
    (void)memset(datas.get(), 0, dataSize);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_BOOL);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestFail)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<bool[]> datas(new bool[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(bool);
    (void)memset(datas.get(), 0, dataSize);
 
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = opDumpTask->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, 300);
    EXPECT_STREQ(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestDouble)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_DOUBLE);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestDouble_INF_NAN)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);
    double inf = std::numeric_limits<double>::infinity();
    double nan = std::numeric_limits<double>::quiet_NaN();
    datas[0] = inf;
    datas[0] = nan;
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = opDumpTask->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, DT_DOUBLE);
    EXPECT_STRNE(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestDefault)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = dumpOpInfo->GenerateDataStatsInfo((uint8_t *)(datas.get()), dataSize, UINT32_MAX);
    EXPECT_STREQ(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStGenerateDataStatsInfoTestNullptr)
{
    const uint32_t dataLen = 10U;
    const uint64_t dataSize = dataLen * sizeof(double);

    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    const auto ret = opDumpTask->GenerateDataStatsInfo((uint8_t *)(nullptr), dataSize, UINT32_MAX);
    EXPECT_STREQ(ret.c_str(), ",,,,,,");
}

TEST_F(TlvDatadumpSt, DatadumpStProcessDumpStats)
{
    const uint32_t dataLen = 10U;
    std::shared_ptr<int64_t[]> datas(new int64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int64_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l,
        workspace_base_addr_l, ioa_base_addr_l, para);
    std::string dumpFilePath("dumpfile");
    dumpOpInfo->para_.dump_mode = DUMP_MODE_ALL;
    LiteDbgOpDesc op;
    LiteDbgInputDesc input;
    input.baseAddr = (uint8_t *)(datas.get());
    input.size = dataSize;
    input.data_type = DT_INT64;
    input.format = FORMAT_ND;
    int64_t dim = 4;
    input.shape_dims.push_back(dim);
    input.shape_dims.push_back(dim);
    LiteDbgOutputDesc output;
    output.baseAddr = (uint8_t *)(datas.get());
    output.size = dataSize;
    output.data_type = DT_INT64;
    output.format = FORMAT_ND;
    output.shape_dims.push_back(dim);
    output.shape_dims.push_back(dim);
    op.input_list.push_back(input);
    op.output_list.push_back(output);
    const auto ret = dumpOpInfo->ProcessDumpStats(op, dumpFilePath);
    EXPECT_EQ(ret, 0);
}

TEST_F(TlvDatadumpSt, DatadumpStProcessEventNotFound)
{
        dump_mailbox_info_t info;
        uint32_t tId = 0;
        uint32_t infoType = 5;
        uint32_t ctrlInfo = 0;
        uint32_t outsize = 0;
        auto ret = DatadumpEventManager::GetInstance().ProcessEvent((void *)(&info), &infoType, &ctrlInfo, &outsize);
        EXPECT_EQ(ret, 0);
}

TEST_F(TlvDatadumpSt, DatadumpInitDatadumpStExceptionDump)
{
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(1));
    uint8_t ** a[10];
    for (int i = 0; i < 10; i++) {
        a[i] = nullptr;
    }
    std::string dump_file_path;
    std::string dump_file_name;
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    DbgOutsideAddPara para;
    DumpOpInfo dumpOpInfo(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    dump_mailbox_info_t mailbox_out;
    mailbox_out.task_id = 0;
    mailbox_out.mid = 0;
    mailbox_out.ioa_base_addr_l = a;
    mailbox_out.weight_base_addr_l = a;
    mailbox_out.workspace_base_addr_l = a;
    uint32_t tId = 0;
    uint32_t infoType = 2;
    uint32_t ctrlInfo = 0;
    uint32_t outsize = 0;
    auto ret = DatadumpEventManager::GetInstance().ProcessEvent((void *)(&mailbox_out), &infoType, &ctrlInfo, &outsize);
    EXPECT_EQ(ret, 21001);
}
TEST_F(TlvDatadumpSt, DatadumpStProcessDumpStatsfailed1)
{
    MOCKER_CPP(&std::ofstream::good).stubs().will(returnValue(false));
    const uint32_t dataLen = 10U;
    std::shared_ptr<int64_t[]> datas(new int64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int64_t);
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    std::string dump_file_path;
    std::string dump_file_name;
    DbgOutsideAddPara para;
    std::shared_ptr<DumpOpInfo> opDumpTask = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    std::string dumpFilePath("dumpfile");
    opDumpTask->para_.dump_mode = DUMP_MODE_ALL;
    LiteDbgOpDesc op;
    LiteDbgInputDesc input;
    input.baseAddr = (uint8_t *)(datas.get());
    input.size = dataSize;
    input.data_type = DT_INT64;
    input.format = FORMAT_ND;
    int64_t dim = 4;
    input.shape_dims.push_back(dim);
    input.shape_dims.push_back(dim);
    LiteDbgOutputDesc output;
    output.baseAddr = (uint8_t *)(datas.get());
    output.size = dataSize;
    output.data_type = DT_INT64;
    output.format = FORMAT_ND;
    output.shape_dims.push_back(dim);
    output.shape_dims.push_back(dim);
    op.input_list.push_back(input);
    op.output_list.push_back(output);
    const auto ret = opDumpTask->ProcessDumpStats(op, dumpFilePath);
    EXPECT_EQ(ret, DUMP_FILE_WRITE_ERROR);
}
TEST_F(TlvDatadumpSt, DatadumpStOpDumpFileFailed1)
{
    std::string statsFilePath = "";
    statsFilePath = statsFilePath + "./modelid/1" + ".csv";
    OpDumpFile opDumpFile(statsFilePath);
    std::ostringstream oss;
    oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value," << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";
    auto ret = opDumpFile.DoDump((uint8_t *)(oss.str().c_str()), oss.str().size());
    EXPECT_EQ(ret, 0);
    ret = opDumpFile.Dump((uint8_t *)(oss.str().c_str()), 0);
    EXPECT_EQ(ret, DUMP_FILE_UNKNOW_ERROR);
    ret = opDumpFile.Dump(NULL, 0);
    EXPECT_EQ(ret, DUMP_FILE_UNKNOW_ERROR);
    opDumpFile.buff_ = NULL;
    ret = opDumpFile.DoDump((uint8_t *)(oss.str().c_str()), oss.str().size());
    EXPECT_EQ(ret, DUMP_FILE_INVALID_PARAM_ERROR);
}
TEST_F(TlvDatadumpSt, DatadumpGetDumpFileNameST)
{
    // void DumpOpInfo::GetDumpFileName(LiteDbgOpDesc &op, std::string &fileName)
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    DbgOutsideAddPara para;
    LiteDbgOpDesc op;
    std::shared_ptr<DumpOpInfo> dumpOpInfo = std::make_shared<DumpOpInfo>(weight_base_addr_l, workspace_base_addr_l, ioa_base_addr_l, para);
    op.op_name="012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012";
    std::string fileName;
    dumpOpInfo->GetDumpFileName(op, fileName);
    op.op_name="012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123/56789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901/34567890123456789012";
    dumpOpInfo->GetDumpFileName(op, fileName);
    EXPECT_STRNE(fileName.c_str(), op.op_name.c_str());
}