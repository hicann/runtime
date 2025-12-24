/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C" {
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include "ascend_hal.h"
#include "mmpa_api.h"
#include "adcore_api.h"
#include "ide_tlv.h"
#include "log_system_api.h"
#include "msnpureport_print.h"
#include "msnpureport_stub.h"
#include "msn_operate_log_level.h"

typedef void* MsnMemHandle;
extern int32_t MsnCreatePacket(int32_t devId, const char *value, uint32_t valueLen, void **buf, int32_t *bufLen);
extern int32_t MsnOperateDeviceLevel(const HDC_CLIENT client, const struct tlv_req *req, \
                           char *logLevelResult, int32_t logLevelResultLength, int32_t logOperatonType);
extern MsnMemHandle MsnXmalloc(size_t size);
}

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;

class MSN_OPERATE_LOG_LEVEL_UTEST: public testing::Test {
protected:
    void SetUp();
    void TearDown();
};

void MSN_OPERATE_LOG_LEVEL_UTEST::SetUp()
{
}

void MSN_OPERATE_LOG_LEVEL_UTEST::TearDown()
{
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLevelMallocFail)
{
    HDC_CLIENT client = (void*)100;
    char value[] = "data";
    int len = sizeof(struct tlv_req)+strlen(value)+1;
    struct tlv_req *req = (struct tlv_req*)malloc(len);
    char *logLevelResult = "test";

    MOCKER(malloc).stubs().will(returnValue((void*)nullptr));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLevel(client, req, logLevelResult, 1025, 0));
    GlobalMockObject::reset();
    free(req);
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLevelTransportFail)
{
    HDC_CLIENT client = (void*)100;
    char value[] = "data";
    int len = sizeof(struct tlv_req)+strlen(value)+1;
    struct tlv_req *req = (struct tlv_req*)malloc(len);
    char *logLevelResult = "test";

    MOCKER(AdxSendMsgAndGetResultByType)
        .stubs()
        .will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLevel(client, req, logLevelResult, 1025, 1));
    GlobalMockObject::reset();
    free(req);
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLevelStrcpyFail)
{
    HDC_CLIENT client = (void*)100;
    char value[] = "data";
    int len = sizeof(struct tlv_req)+strlen(value)+1;
    struct tlv_req *req = (struct tlv_req*)malloc(len);
    char *logLevelResult = "test";

    MOCKER(AdxSendMsgAndGetResultByType).stubs().will(returnValue(EN_OK));
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLevel(client, req, logLevelResult, 1025, 1));
    GlobalMockObject::reset();
    free(req);
}

static int AdxSendMsgAndGetResultByTypeSuccStub(enum drvHdcServiceType type, IdeTlvConReq req, char *const resultBuf,
    uint32_t resultLen)
{
    char *successResult = "++NO++";
    strncpy_s(resultBuf, sizeof(successResult), successResult,sizeof(successResult));
    return EN_OK;
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLevelReadResult)
{
    HDC_CLIENT client = (void*)100;
    char value[] = "data";
    int len = sizeof(struct tlv_req)+strlen(value)+1;
    struct tlv_req *req = (struct tlv_req*)malloc(len);
    char *logLevelResult = "test";

    MOCKER(AdxSendMsgAndGetResultByType)
        .stubs()
        .will(invoke(AdxSendMsgAndGetResultByTypeSuccStub));

    MOCKER(strncpy_s)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLevel(client, req, logLevelResult, 1025, 1));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLevel(client, req, logLevelResult, 1025, 0));
    GlobalMockObject::reset();
    free(req);
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnCreatePacketTest)
{
    CmdClassT type = IDE_BBOX_REQ;
    const char *value = "test one!";
    uint32_t valueLen = 0;
    void *buf;
    int bufLen;

    EXPECT_EQ(EN_ERROR, MsnCreatePacket(1, value, valueLen, NULL, &bufLen));
    valueLen = UINT32_MAX;
    EXPECT_EQ(EN_ERROR, MsnCreatePacket(1, value, valueLen, &buf, &bufLen));
    valueLen = 10;
    EXPECT_EQ(EN_OK, MsnCreatePacket(1, value, valueLen, &buf, &bufLen));
    if (buf != NULL) {
        free(buf);
    }

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(EN_ERROR, MsnCreatePacket(1, value, valueLen, &buf, &bufLen));

    EXPECT_EQ(22, bufLen);
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLogLevelTestInputFail)
{
    uint16_t devId = 0;
    const char *logLevel = nullptr;
    char *logLevelResult = nullptr;
    int logOperatonType = 0;

    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLogLevel(devId, logLevel, logLevelResult, 1025, logOperatonType));
    GlobalMockObject::verify();
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLogLevelTestCreatePacketFail)
{
    uint16_t devId = 0;
    const char *logLevel = "1";
    char logLevelResult[512];
    int logOperatonType = 0;

    MOCKER(MsnCreatePacket).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLogLevel(devId, logLevel, logLevelResult, 1025, logOperatonType));
    GlobalMockObject::verify();
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLogLevelTestOperateDeviceLevelFail)
{
    uint16_t devId = 0;
    const char *logLevel = "1";
    char logLevelResult[512];
    int logOperatonType = 0;

    MOCKER(MsnCreatePacket).stubs().will(returnValue(EN_OK));
    MOCKER(MsnOperateDeviceLevel).stubs().will(returnValue(26)).then(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLogLevel(devId, logLevel, logLevelResult, 1025, logOperatonType));
    GlobalMockObject::verify();
    EXPECT_EQ(EN_ERROR, MsnOperateDeviceLogLevel(devId, logLevel, logLevelResult, 1025, logOperatonType));
    GlobalMockObject::verify();
}

TEST_F(MSN_OPERATE_LOG_LEVEL_UTEST, MsnOperateDeviceLogLevelTestSucc)
{
    uint16_t devId = 0;
    const char *logLevel = "1";
    char logLevelResult[512];
    int logOperatonType = 0;

    MOCKER(MsnCreatePacket).stubs().will(returnValue(EN_OK));
    MOCKER(MsnOperateDeviceLevel).stubs().will(returnValue(EN_OK));
    EXPECT_EQ(EN_OK, MsnOperateDeviceLogLevel(devId, logLevel, logLevelResult, 1025, logOperatonType));
    GlobalMockObject::verify();
}
