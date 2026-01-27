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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "lite_dbg_desc.h"
#include "hal_ts.h"
#include "datadump_worker.h"
#include "datadump_write_file.h"
#include "num_to_str.h"
#include "float16_process.h"
#include "liteos_basic.h"
#define nullptr NULL
#ifdef __cplusplus
extern "C" {
#endif
void ClearLiteDbgInputDescHead(struct LiteDbgInputDescHead *input_head_ptr);
void ClearLiteDbgOutputDescHead(struct LiteDbgOutputDescHead *output_head_ptr);
void ClearLiteDbgOpDescHead(struct LiteDbgOpDescHead *op_head_ptr);

void ClearHandleAndBuff(bool flag, file_t *handle, uint8_t *buff);
drvError_t halEschedWaitEvent(uint32_t tId, void *outInfo, uint32_t *infotype, uint32_t *ctrlinfo, uint32_t *outsize, int32_t timeout);
uint32_t DoOnce();
uint32_t ProcessEvent(void *outInfo, uint32_t *infoType, uint32_t *ctrlInfo, uint32_t *outsize);
uint32_t InitDataDump();
uint32_t StopDataDump();
uint32_t ProcessLoadOpMappingEvent(void *outInfo, uint32_t outsize);
uint32_t ProcessDumpDataEvent(dump_mailbox_info_t *mailbox_out);
int32_t Unload(uint8_t *outInfo, uint32_t outsize);
uint32_t DoDump(uint8_t * const base_addr, const uint64_t len, file_t *handle, uint8_t *buff);
void drv_uart_send(const char *fmt, ...);
uint32_t CreateWorker();
file_t *file_open(const char *filename, const char *mode);
int32_t file_create(char *filename, size_t size);
size_t file_read(void *dst, size_t size, size_t nmemb, file_t *file);
size_t file_write(const void *src, size_t size, size_t nmemb, file_t *file);
int32_t file_seek(file_t *file, long offset, int32_t whence);
long int file_tell(file_t *file);
uint32_t DoOnce();
extern uint32_t dumpStatsDouble(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsFloat(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsFloat16(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsInt32(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsUint32(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsInt64(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsUint64(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsInt8(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsInt16(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsUint8(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsUint16(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);
uint32_t dumpStatsBool(uint8_t *dataAddr, uint32_t dataSize, char *buff, uint32_t buffLen);

#ifdef __cplusplus
}
#endif
class TlvDatadump_c_Ut : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TlvDatadump_c_Ut, DatadumpInitDatadumpUtSuccess_UT)
{
    int ret = 0;
    uint8_t file[] = 
    {
        0,0,0,0,90,90,90,90,0,0,0,0,11,0,0,0,99,111,110,99,97,116,95,110,97,110,111,1,0,0,0,198,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,169,1,0,0,0,0,0,0,8,0,0,0,99,111,110,99,97,92,46,50,1,0,0,0,9,0,0,0,67,111,110,99,97,116,86,50,68,2,0,0,0,12,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,4,0,0,0,180,0,0,0,2,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,5,0,0,0,120,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, // outputsize
        0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,0,2,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,8,0,0,0,48,0,0,0,1,0,0,0,0,115,0,0,0,0,0,0,224,114,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,229,0,0,0,0,0,0,0,0,0,0
    };
    int len = sizeof(file) / sizeof(uint8_t);
    void *outBUff  = malloc(len+10000);
    memcpy(outBUff, file, len);
    char * dumPathTemp = "./dumPath/";
    uint64_t * stepIdAddr = malloc(sizeof(uint64_t));
    *stepIdAddr = 100;
    void *outInfo = outBUff;
    uint32_t outsize = len;
    uint8_t *tlv1 = (uint8_t *)((uint8_t *)outBUff + len);
    struct TlvHead *tlv = (struct TlvHead *)tlv1;
    tlv->type = DBG_L1_TLV_TYPE_MODEL_DESC;
    tlv->len = sizeof(DbgModelDescTlv1);
    uint8_t *memCpyTlv1Addr = (uint8_t *)(tlv1 + sizeof(struct TlvHead));
    DbgModelDescTlv1 *dbgModelDesc = (DbgModelDescTlv1 *)(memCpyTlv1Addr);
    dbgModelDesc->flag = 1;
    dbgModelDesc->model_id = 3;
    dbgModelDesc->step_id_addr = stepIdAddr;
    dbgModelDesc->iterations_per_loop_addr = nullptr;
    dbgModelDesc->loop_cond_addr = nullptr;
    dbgModelDesc->dump_data = 1;
    dbgModelDesc->dump_mode = 2;
    uint8_t *tlv2 = (uint8_t *)(memCpyTlv1Addr + sizeof(DbgModelDescTlv1));
    struct TlvHead *tlvDumpPath = (struct TlvHead *)tlv2;
    tlvDumpPath->type = DBG_L1_TLV_TYPE_DUMP_PATH;
    tlvDumpPath->len = strlen(dumPathTemp);
    uint8_t *memCpyTlv2Addr = (uint8_t *)(tlv2 + sizeof(struct TlvHead));
    memcpy(memCpyTlv2Addr, dumPathTemp, tlvDumpPath->len);
    ret = ProcessLoadOpMappingEvent(outInfo, outsize);
    EXPECT_EQ(ret, 0);
    dump_mailbox_info_t *info = (dump_mailbox_info_t *)malloc(sizeof(dump_mailbox_info_t));
    uint8_t *  p = (uint8_t *)malloc(sizeof(uint64_t));
    uint8_t * a[10];
    for (int i = 0; i < 10; i++) {
        a[i] = p;
    }
    uint8_t * ioa_base_addr_l = (uint8_t *)a;
    uint8_t * weight_base_addr_l = p;
    uint8_t * workspace_base_addr_l = p;
    memset(info, 0, sizeof(dump_mailbox_info_t));
    info->ioa_base_addr_l = ioa_base_addr_l;
    info->weight_base_addr_l = weight_base_addr_l;
    info->workspace_base_addr_l = workspace_base_addr_l;
    info->task_id = 0;
    info->mid = 3;
    ProcessDumpDataEvent(info);
    dbgModelDesc->flag = 0;
    memcpy(memCpyTlv2Addr, dumPathTemp, tlvDumpPath->len);
    ret = ProcessLoadOpMappingEvent(outInfo, outsize);
    EXPECT_EQ(ret, 0);
    dbgModelDesc->flag = 2;
    memcpy(memCpyTlv2Addr, dumPathTemp, tlvDumpPath->len);
    ret = ProcessLoadOpMappingEvent(outInfo, outsize);
    free(outBUff);
    free(stepIdAddr);
    free(info);
    free(p);
    EXPECT_EQ(ret, -1);
}

TEST_F(TlvDatadump_c_Ut, DatadumpInitDatadumpUtSuccessStats_UT)
{
    int ret = 0;
    uint8_t file[] = 
    {
        0,0,0,0,90,90,90,90,0,0,0,0,11,0,0,0,99,111,110,99,97,116,95,110,97,110,111,1,0,0,0,198,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,169,1,0,0,0,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,1,0,0,0,9,0,0,0,67,111,110,99,97,116,86,50,68,2,0,0,0,12,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,4,0,0,0,180,0,0,0,2,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,60,57,0,0,0,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,5,0,0,0,120,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,//outputsize
        0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,0,0,90,57,0,0,0,0,0,0,2,0,0,0,8,0,0,0,99,111,110,99,97,116,118,50,8,0,0,0,48,0,0,0,1,0,0,0,0,115,0,0,0,0,0,0,224,114,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,229,0,0,0,0,0,0,0,0,0,0
    };
    int len = sizeof(file) / sizeof(uint8_t);
    void *outBUff  = malloc(len+10000);
    memcpy(outBUff, file, len);
    char * dumPathTemp = "./dumPath/";
    uint64_t * stepIdAddr = malloc(sizeof(uint64_t));
    *stepIdAddr = 100;
    void *outInfo = outBUff;
    uint32_t outsize = len;
    uint8_t *tlv1 = (uint8_t *)((uint8_t *)outBUff + len);
    struct TlvHead *tlv = (struct TlvHead *)tlv1;
    tlv->type = DBG_L1_TLV_TYPE_MODEL_DESC;
    tlv->len = sizeof(DbgModelDescTlv1);
    uint8_t *memCpyTlv1Addr = (uint8_t *)(tlv1 + sizeof(struct TlvHead));
    DbgModelDescTlv1 *dbgModelDesc = (DbgModelDescTlv1 *)(memCpyTlv1Addr);
    dbgModelDesc->flag = 1;
    dbgModelDesc->model_id = 3;
    dbgModelDesc->step_id_addr = stepIdAddr;
    dbgModelDesc->iterations_per_loop_addr = nullptr;
    dbgModelDesc->loop_cond_addr = nullptr;
    dbgModelDesc->dump_data = 0;
    dbgModelDesc->dump_mode = 2;
    uint8_t *tlv2 = (uint8_t *)(memCpyTlv1Addr + sizeof(DbgModelDescTlv1));
    struct TlvHead *tlvDumpPath = (struct TlvHead *)tlv2;
    tlvDumpPath->type = DBG_L1_TLV_TYPE_DUMP_PATH;
    tlvDumpPath->len = strlen(dumPathTemp);
    uint8_t *memCpyTlv2Addr = (uint8_t *)(tlv2 + sizeof(struct TlvHead));
    memcpy(memCpyTlv2Addr, dumPathTemp, tlvDumpPath->len);
    ret = ProcessLoadOpMappingEvent(outInfo, outsize);
    EXPECT_EQ(ret, 0);
    dump_mailbox_info_t *info = (dump_mailbox_info_t *)malloc(sizeof(dump_mailbox_info_t));
    uint8_t *  p = (uint8_t *)malloc(sizeof(uint64_t));
    uint8_t * a[10];
    for (int i = 0; i < 10; i++) {
        a[i] = p;
    }
    uint8_t * ioa_base_addr_l = (uint8_t *)a;
    uint8_t * weight_base_addr_l = p;
    uint8_t * workspace_base_addr_l = p;
    memset(info, 0, sizeof(dump_mailbox_info_t));
    info->ioa_base_addr_l = ioa_base_addr_l;
    info->weight_base_addr_l = weight_base_addr_l;
    info->workspace_base_addr_l = workspace_base_addr_l;
    info->task_id = 0;
    info->mid = 3;
    ProcessDumpDataEvent(info);
    dbgModelDesc->flag = 0;
    memcpy(memCpyTlv2Addr, dumPathTemp, tlvDumpPath->len);
    ret = ProcessLoadOpMappingEvent(outInfo, outsize);
    free(outBUff);
    free(stepIdAddr);
    free(info);
    free(p);
    EXPECT_EQ(ret, 0);
}

TEST_F(TlvDatadump_c_Ut, Uint64ToStr_UT)
{
    uint64_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = Uint64ToStr(num, numStr, MAX_NUM_STR_LEN);
    num = -1;
    numStrLen = Uint64ToStr(num, numStr, MAX_NUM_STR_LEN);
    numStrLen = Uint64ToStr(num, nullptr, MAX_NUM_STR_LEN);
    numStrLen = Uint64ToStr(num, nullptr, 0);
    EXPECT_EQ(numStrLen, 0);
}
TEST_F(TlvDatadump_c_Ut, Uint32ToStr_UT)
{
    uint32_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = Uint32ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, Uint16ToStr_UT)
{
    uint32_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = Uint16ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, int16ToStr_UT)
{
    int16_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = int16ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, Uint8ToStr_UT)
{
    uint8_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = Uint8ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, int64ToStr_UT)
{
    int64_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = int64ToStr(num, numStr, MAX_NUM_STR_LEN);
    numStrLen = int64ToStr(num, nullptr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 0);

}
TEST_F(TlvDatadump_c_Ut, int32ToStr_UT)
{
    int32_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = int32ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, int8ToStr_UT)
{
    int8_t num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = int8ToStr(num, numStr, MAX_NUM_STR_LEN);
    num = -1;
    numStrLen = int8ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 1);
}
TEST_F(TlvDatadump_c_Ut, double_to_string1_UT)
{
    double num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = double_to_string1(num, numStr, 1);
    EXPECT_EQ(numStrLen, 3);
}

TEST_F(TlvDatadump_c_Ut, fp64ToStr_UT)
{
    double num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = fp64ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 18);
}
TEST_F(TlvDatadump_c_Ut, fp32ToStr_UT)
{
    float num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = fp32ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 9);
}
TEST_F(TlvDatadump_c_Ut, fp16ToStr_UT)
{
    float num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = fp16ToStr(num, numStr, MAX_NUM_STR_LEN);
    EXPECT_EQ(numStrLen, 5);
}

TEST_F(TlvDatadump_c_Ut, fpxxToStr_UT)
{
    double num = 1;
    char numStr[MAX_NUM_STR_LEN] = "";
    uint32_t numStrLen = fpxxToStr(num, numStr, MAX_NUM_STR_LEN, 1);
    numStrLen = fpxxToStr(num, numStr, MAX_NUM_STR_LEN, 1);
    EXPECT_EQ(numStrLen, 3);
}

TEST_F(TlvDatadump_c_Ut, fp16ToFloat_UT)
{
    uint16_t num = 0x416f; // 二进制：0100000101101111
    float value = fp16ToFloat(num); // 0x402DE000 二进制：01000000001011011110000000000000
    EXPECT_EQ(*(uint32_t *)(&value), 0x402DE000);
}

TEST_F(TlvDatadump_c_Ut, GetInputStr_UT)
{
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetInputStr(buff, buffLen);
     EXPECT_EQ(value, 5);
}

TEST_F(TlvDatadump_c_Ut, GetOutputStr_UT)
{
    char buff[50] = "";
    uint32_t buffLen = 50;
    uint32_t value = GetOutputStr(buff, buffLen);
    EXPECT_EQ(value, 6);
}

TEST_F(TlvDatadump_c_Ut, GetCSVStr_UT)
{
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetCSVStr(buff, buffLen);
    EXPECT_EQ(value, 4);
}

TEST_F(TlvDatadump_c_Ut, GetEnterStr_UT)
{
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetEnterStr(buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, GetFp64Str_UT)
{
    double num = 1.1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetFp64Str(num, buff, buffLen);
    EXPECT_EQ(value, 18);
}

TEST_F(TlvDatadump_c_Ut, GetFp32Str_UT)
{
    float num = 1.1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetFp32Str(num, buff, buffLen);
    EXPECT_EQ(value, 9);
}
TEST_F(TlvDatadump_c_Ut, GetFp16Str_UT)
{
    float num = 1.1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetFp16Str(num, buff, buffLen);
    EXPECT_EQ(value, 5);
}

TEST_F(TlvDatadump_c_Ut, GetXStr_UT)
{
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetXStr(buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, GetCommaStr_UT)
{
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetCommaStr(buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, GetSizeStr_UT)
{
    uint64_t num = 1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetSizeStr(num, buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, GetDimStr_UT)
{
    uint64_t num = 1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetDimStr(num, buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, GetIndexStr_UT)
{
    uint32_t num = 1;
    char buff[50];
    uint32_t buffLen = 50;
    uint32_t value = GetIndexStr(num, buff, buffLen);
    EXPECT_EQ(value, 1);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsDouble_UT)
{
    double dataAddr[10];
    uint32_t dataSize = sizeof(double) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsDouble((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 62);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsFloat_UT)
{
    float dataAddr[10] = {1.1,2.2,3.3,4.4,5.5,6.6,7.7,8.8,9.9,10.10};
    uint32_t dataSize = sizeof(float ) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsFloat((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 45);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsFloat16_UT)
{
    uint16_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(uint16_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsFloat16((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 36);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsInt32_UT)
{
    int32_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(int32_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsInt32((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsUint32_UT)
{
    uint32_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(uint32_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsUint32((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsInt64_UT)
{
    int64_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(int64_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsInt64((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsUint64_UT)
{
    uint64_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(uint64_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsUint64((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsInt8_UT)
{
    int8_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(int8_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsInt8((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsInt16_UT)
{
    int16_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(int16_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsInt16((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsUint8_UT)
{
    uint8_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(uint8_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsUint8((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

TEST_F(TlvDatadump_c_Ut, dumpStatsUint16_UT)
{
    uint16_t dataAddr[10]={1,2,3,4,5,6,7,8,9,10};
    uint32_t dataSize = sizeof(uint16_t) * 10;
    char buff[100];
    uint32_t buffLen = 100;
    uint32_t value = dumpStatsUint16((uint8_t *)dataAddr, dataSize, buff, buffLen);
    EXPECT_EQ(value, 29);
}

int memset_s_return_1(void *dest, int destMax, int c, int count)
{
    return 1;
}
void* LiteOsMalloc_return_NULL(size_t size_UT)
{
    return nullptr;
}

TEST_F(TlvDatadump_c_Ut, LiteOsCalloc_UT)
{
    void *p = nullptr;
    p = LiteOsCalloc(100);
    EXPECT_NE(p, NULL);
    LiteOsFree(p);
    MOCKER(memset_s) .stubs() .will(invoke(memset_s_return_1));
    p = LiteOsCalloc(100);
    LiteOsFree(p);
    MOCKER(LiteOsMalloc) .stubs() .will(invoke(LiteOsMalloc_return_NULL));
    p = LiteOsCalloc(100);
    LiteOsFree(p);
    EXPECT_EQ(p, NULL);
}
int32_t LiteOsCreateThread_return_1(LiteOsThread *threadHandle, UserProcFunc func)
{
    return 1;
}
void * ProcFunc(void *)
{
    return;
}

int pthread_create_return_1(pthread_t *__restrict, const pthread_attr_t *__restrict, void *(*)(void *), void *__restrict)
{
    return 1;
}
TEST_F(TlvDatadump_c_Ut, LiteOsCreateThread_UT)
{
    MOCKER(pthread_create) .stubs() .will(invoke(pthread_create_return_1));
    int a;
    LiteOsThread *threadHandle = (LiteOsThread *)(&a);
    UserProcFunc func = ProcFunc;
    int32_t ret = LiteOsCreateThread(threadHandle, func);
    threadHandle = nullptr;
    ret = LiteOsCreateThread(threadHandle, func);
    EXPECT_EQ(ret, LITEOSEN_INVALID_PARAM);
}

TEST_F(TlvDatadump_c_Ut, ProcessEvent_UT)
{
    dump_mailbox_info_t info;
    uint32_t tId = 0;
    uint32_t infoType = 0;
    uint32_t ctrlInfo = 0;
    uint32_t outsize = 0;
    ProcessEvent((void *)(&info), &infoType, &ctrlInfo, &outsize);
    infoType = 1;
    ProcessEvent((void *)(&info), &infoType, &ctrlInfo, &outsize);
    infoType = 3;
    uint32_t ret = ProcessEvent((void *)(&info), &infoType, &ctrlInfo, &outsize);
    EXPECT_EQ(ret, 0);
}

drvError_t halEschedWaitEvent_return_1(uint32_t tId, void *outInfo, uint32_t *infotype, uint32_t *ctrlinfo, uint32_t *outsize, int32_t timeout)
{
    return 1;
}

TEST_F(TlvDatadump_c_Ut, DoOnce_UT)
{
    DoOnce();
    MOCKER(halEschedWaitEvent) .stubs() .will(invoke(halEschedWaitEvent_return_1));
    uint32_t ret = DoOnce();
    EXPECT_EQ(ret, 1);
}
int pthread_attr_setstacksize_stub(pthread_attr_t *attr, size_t stackSize)
{
    /* Reject inadequate stack sizes */
    if ((attr == nullptr) || (stackSize < 2048)) {
        return 22;
    }

    return 0;
}
TEST_F(TlvDatadump_c_Ut, InitDataDump_UT)
{
    uint32_t ret = 0;
    InitDataDump();
    MOCKER(pthread_attr_setstacksize) .stubs() .will(invoke(pthread_attr_setstacksize_stub));
    ret = InitDataDump();
    EXPECT_EQ(ret, 0);
    ret = StopDataDump();
    EXPECT_EQ(ret, 0);
}
TEST_F(TlvDatadump_c_Ut, ClearHandleAndBuff_UT)
{
    bool flag = true;
    char *dumpPath = "./a";
    char *mode = "a";
    file_t *handle = file_open(dumpPath, mode);
    uint8_t *buff = (uint8_t *)malloc(8);
    EXPECT_NE(buff, NULL);
    ClearHandleAndBuff(flag, handle, buff);
}

TEST_F(TlvDatadump_c_Ut, ClearLiteDbgInputDescHead_UT)
{
    struct LiteDbgInputDescHead *input_head_ptr = nullptr;
    ClearLiteDbgInputDescHead(input_head_ptr);
    EXPECT_EQ(input_head_ptr, NULL);
}

TEST_F(TlvDatadump_c_Ut, ClearLiteDbgOutputDescHead_UT)
{
    struct LiteDbgOutputDescHead *output_head_ptr = nullptr;
    ClearLiteDbgOutputDescHead(output_head_ptr);
    EXPECT_EQ(output_head_ptr, NULL);
}

TEST_F(TlvDatadump_c_Ut, ClearLiteDbgOpDescHead_UT)
{
    struct LiteDbgOpDescHead *op_head_ptr = nullptr;
    ClearLiteDbgOpDescHead(op_head_ptr);
    EXPECT_EQ(op_head_ptr, NULL);
}