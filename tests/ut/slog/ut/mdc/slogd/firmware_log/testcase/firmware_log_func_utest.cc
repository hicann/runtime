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
#include "mockcpp/mockcpp.hpp"
#include "slogd_firmware_log.h"
#include "log_pm_sig.h"
#include "self_log_stub.h"
#include "slogd_stub.h"
#include "log_recv_interface.h"
#include "slogd_config_mgr.h"
#include "slogd_group_log.h"
#include "slogd_firmware_log.h"
#include "log_recv.h"
#include "ascend_hal_stub.h"
#include "log_path_mgr.h"
#include "iam.h"
#include "log_pm_sr.h"

using namespace std;
using namespace testing;

#define SLOG_CONF_FILE  "slog_func_A1SUs28SDBwhdcus.conf"
extern GeneralGroupInfo g_groupInfo;
extern "C"
{
LogStatus SlogdLogClassifyInit(int32_t devId, bool isDocker);
void SlogdLogClassifyExit(void);
extern enum IAMResourceStatus g_slogdCompressResStatus;
extern enum SystemState g_systemState;
}
class MDC_FIRMWARE_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        g_slogdCompressResStatus = IAM_RESOURCE_READY;
        g_systemState = WORKING;
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("mkdir -p " FILE_DIR);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
    }

    static void DlogDestructor()
    {
    }
    void DlogCreateCmdFile(int32_t clockId)
    {
        FILE *fp = fopen(BOOTARGS_FILE_PATH, "w");
        uint32_t length = 1024;
        char msg[length];
        snprintf_s(msg, length, length - 1, "[MDC_FIRMWARE_FUNC_UTEST][Log] test for dpclk=%d", clockId);
        fwrite(msg, length, 1, fp);
        fclose(fp);
    }
};

static int log_read_stub(int device_id, char *buf, unsigned int *size, int timeout)
{
    LogMsgHead msgHead = { 0 };
    char buffer[1024] = "test for firmware log.\n";
    msgHead.dataLen = strlen(buffer) + 1;
    memcpy_s(buf, 1024, &msgHead, sizeof(LogMsgHead));
    memcpy_s(buf + sizeof(LogMsgHead), 1024 - sizeof(LogMsgHead), buffer, strlen(buffer) + 1);
    *size = sizeof(LogMsgHead) + strlen(buffer) + 1;
    usleep(timeout * 1000);
    return 0;
}

static int log_read_stub_invalid_head(int device_id, char *buf, unsigned int *size, int timeout)
{
    LogMsgHead msgHead = { 0 };
    msgHead.slogFlag = 1;
    char buffer[1024] = "test for firmware log.\n";
    msgHead.dataLen = strlen(buffer) + 1;
    memcpy_s(buf, 1024, &msgHead, sizeof(LogMsgHead));
    memcpy_s(buf + sizeof(LogMsgHead), 1024 - sizeof(LogMsgHead), buffer, strlen(buffer) + 1);
    *size = sizeof(LogMsgHead) + strlen(buffer) + 1;
    return 0;
}

static int32_t FirmwareFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, "device-0_")) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

static void CheckLogFile(char *path, uint32_t length, ToolFilter filterFunc)
{
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(path, &nameList, filterFunc, alphasort);
    int32_t logNum = 0;
    char fileName[1024] = { 0 };
    for (int32_t i = 0; i < totalNum; i++) {
        SELF_LOG_INFO("nameList[i]->d_name=%s.", nameList[i]->d_name);
        memset_s(fileName, 1024, 0, 1024);
        snprintf_s(fileName, 1024, 1023, "%s/%s", path, nameList[i]->d_name);
        if (strstr(nameList[i]->d_name, "act.log.gz") != nullptr) {
            logNum++;
            continue;
        }
    }
    EXPECT_EQ(1, logNum);
    ToolScandirFree(nameList, totalNum);
}

// 固件日志
TEST_F(MDC_FIRMWARE_FUNC_UTEST, SlogdFirmwareLog)
{
    // 初始化
    DlogConstructor();
    DlogCreateCmdFile(100);
    LogRecordSigNo(0);
    system("mkdir -p " FILE_DIR "debug/device-0/");

    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(log_read).stubs().will(invoke(log_read_stub));

    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLogClassifyInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());

    // 拉起固件日志服务
    sleep(4);
    EXPECT_EQ(0, GetErrLogNum());
 
    LogRecordSigNo(15);
    sleep(3);

    char path[1024] = { 0 };
    snprintf(path, 1024, "%s/debug/device-0/", FILE_DIR);
    CheckLogFile(path, 1024, FirmwareFileFilter);
    // 释放
    SlogdReceiveExit();
    SlogdFlushExit();
    SlogdLogClassifyExit();
    DlogDestructor();
}

TEST_F(MDC_FIRMWARE_FUNC_UTEST, SlogdFirmwareLogNoGroup)
{
    // 初始化
    DlogConstructor();
    DlogCreateCmdFile(100);
    LogRecordSigNo(0);
    system("mkdir -p " FILE_DIR "debug/device-0/");
    system("rm " SLOG_CONF_FILE_PATH);

    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(log_read).stubs()
        .will(invoke(log_read_stub_invalid_head))
        .then(invoke(log_read_stub_invalid_head))
        .then(invoke(log_read_stub));

    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLogClassifyInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());

    // 拉起固件日志服务
    sleep(4);
 
    LogRecordSigNo(15);
    sleep(3);
 
    char path[1024] = { 0 };
    snprintf(path, 1024, "%s/debug/device-0/", FILE_DIR);
    CheckLogFile(path, 1024, FirmwareFileFilter);
    // 释放
    SlogdReceiveExit();
    SlogdFlushExit();
    SlogdLogClassifyExit();
    DlogDestructor();
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
}