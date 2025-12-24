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
#include "ascend_hal_stub.h"
#include "self_log_stub.h"
#include "slogd_flush.h"
#include "log_path_mgr.h"
#include "slogd_appnum_watch.h"
#include "slogd_config_mgr.h"
#include "log_sys_report.h"
#include "log_sys_get.h"
#include "adcore_api.h"
#include "log_communication.h"
#include "log_drv.h"
#include <mutex>

using namespace std;
using namespace testing;

#define SINGLE_EXPORT_LOG        "slog_single"
#define MSG_STATUS_LONG_LINK     12
static std::map<std::string, std::string> g_dataSingleBuffer;
static std::map<std::string, std::string> g_dataContinusBuffer;
static std::mutex g_continusMtx;

extern "C" {
extern ToolMutex g_confMutex;
extern SlogdStatus g_slogdStatus;
extern StLogFileList g_fileList;
LogStatus SlogdLogClassifyInit(int32_t devId, bool isDocker);
void SlogdLogClassifyExit(void);
extern int32_t g_adcoreReturnError;
}

class EP_SLOGD_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        DlogConstructor();
        ResetErrLog();
        system("touch " KERNEL_LOG_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        MOCKER(CreateAppLogWatchThread).stubs();
        g_adcoreReturnError = 0;
    }

    virtual void TearDown()
    {
        DlogDestructor();
        g_continusMtx.lock();
        g_dataContinusBuffer.clear();
        g_continusMtx.unlock();
        g_adcoreReturnError = 0;
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE);
        system("rm -rf " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        g_slogdStatus = SLOGD_RUNNING;
        LogRecordSigNo(0);
    }

    int SlogdCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/MDC_SLOGD_FLUSH_FUNC_UTEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }
    static void DlogDestructor() {
        log_release_buffer();
    }
    int32_t SlogdGetPrintNum(const char *path, const char *dir)
    {
        char cmd[200] = {0};
        sprintf(cmd, " cat %s/%s/* | wc -l", path, dir);

        int ret = SlogdCmdGetIntRet(path, cmd);
        return ret;
    }
};

static void CheckLogResult(const char *msg, const char *fileName, int32_t logNum, std::map<std::string, std::string> &data)
{
    int32_t count = 0;
    size_t pos = 0;
    size_t len = strlen(msg);
    for (auto& item : data) {
        if (item.first.find(fileName) != std::string::npos) {
            while ((pos = item.second.find(msg, pos)) != std::string::npos) {
                count++;
                pos += len;
            }
        }
    }
    EXPECT_EQ(logNum, count);
}

static void CheckLogResultRange(const char *msg, const char *fileName, int32_t logNum, std::map<std::string, std::string> &data)
{
    int32_t count = 0;
    size_t pos = 0;
    size_t len = strlen(msg);
    for (auto& item : data) {
        if (item.first.find(fileName) != std::string::npos) {
            while ((pos = item.second.find(msg, pos)) != std::string::npos) {
                count++;
                pos += len;
            }
        }
    }
    EXPECT_LE(logNum, count);
}

static int32_t AdxSendMsgSingleStub(const CommHandle *handle, AdxString data, uint32_t len)
{
    static uint32_t count = 0;
    static std::string fileName;
    if (count % 2 == 0) {
        fileName = std::string(data, len);
    } else {
        if (g_dataSingleBuffer.find(fileName) != g_dataSingleBuffer.end()) {
            count++;
            return -1;
        }
        g_dataSingleBuffer.emplace(fileName, std::string(data, len));
        fileName.clear();
    }
    count++;
    return 0;
}

int32_t AdxSendMsg(const CommHandle *handle, AdxString data, uint32_t len)
{
    if (data == NULL) {
        return -1;
    }
    if (strcmp(data, HDC_END_MSG) == 0) {
        return 0;
    }
    LogReportMsg *msg = (LogReportMsg *)data;
    if (msg->magic != LOG_REPORT_MAGIC) {
        return -1;
    }
    const std::vector<std::string>logNameMap = {
        "debug/device-os/device-os.log",
        "security/device-os/device-os.log",
        "run/device-os/device-os.log",
        "run/event/event.log",
        "debug/device-0/device-0.log"
    };
    if (msg->logType > 4) {
        return -1;
    }
    std::string fileName = logNameMap[msg->logType];
    g_continusMtx.lock();
    auto it = g_dataContinusBuffer.find(fileName);
    if (it!= g_dataContinusBuffer.end()) {
        it->second += msg->buf;
    } else {
        g_dataContinusBuffer.emplace(fileName, msg->buf);
    }
    g_continusMtx.unlock();
    return 0;
}

static void ContinuousExportSessoionCreate()
{
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_REPORT;
    handle->timeout = 0;
    handle->client = nullptr;

    size_t len = sizeof(LogDataMsg) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->status = MSG_STATUS_LONG_LINK;
    value->devId = 0;
    value->sliceLen = 0;

    EXPECT_EQ(0, SysReportProcess(handle, value, len));
    free(value);
}

TEST_F(EP_SLOGD_FUNC_UTEST, FlushLog)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = LOG_FILE_PATH;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLogClassifyInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    ContinuousExportSessoionCreate();

    // 向buffer内写数据
    char msg[1024] = "test for slogd flush log.\n";
    LogInfo msgInfo = { DEBUG_LOG, SYSTEM, 100, 0, 0, 0, DLOG_ERROR };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);

    msgInfo = (LogInfo){ RUN_LOG, SYSTEM, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);

    msgInfo = (LogInfo){ SECURITY_LOG, SYSTEM, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);

    msgInfo = (LogInfo){ RUN_LOG, SYSTEM, 100, 0, 0, 0, DLOG_EVENT };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);

    msgInfo = (LogInfo){ DEBUG_LOG, APPLICATION, 100, 0, 0, 0, DLOG_ERROR };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);

    msgInfo = (LogInfo){ RUN_LOG, APPLICATION, 100, 0, 0, 0, DLOG_ERROR };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    // 等待flush线程创建并运行
    sleep(1);

    g_adcoreReturnError = -1;
    MOCKER(AdxSendMsg).reset();
    msgInfo = (LogInfo){ RUN_LOG, SYSTEM, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer((const char *)&msg, strlen((const char *)&msg), &msgInfo);
    sleep(1);

    // 释放
    LogRecordSigNo(15);
    SlogdReceiveExit();
    SlogdFlushExit();
    SlogdLogClassifyExit();
    SlogdConfigMgrExit();

    g_continusMtx.lock();
    CheckLogResult(msg, "debug/device-os/device-os", 1, g_dataContinusBuffer);
    CheckLogResult(msg, "run/device-os/device-os", 1, g_dataContinusBuffer);
    CheckLogResult(msg, "security/device-os/device-os", 1, g_dataContinusBuffer);
    CheckLogResult(msg, "run/event/event", 1, g_dataContinusBuffer);
    g_continusMtx.unlock();
    EXPECT_EQ(1, SlogdGetPrintNum(LOG_FILE_PATH, "/debug/device-app-100"));
    EXPECT_EQ(1, SlogdGetPrintNum(LOG_FILE_PATH, "/run/device-app-100"));
    EXPECT_EQ(0, SlogdGetPrintNum(LOG_FILE_PATH, "/security/device-app-100"));
}

TEST_F(EP_SLOGD_FUNC_UTEST, SingleExport)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = LOG_FILE_PATH;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdConfigMgrInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLogClassifyInit(-1, false));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());
    sleep(1);

    // 向buffer内写数据
    char *msg = "test for slogd flush log.\n";
    LogInfo msgInfo = { DEBUG_LOG, SYSTEM, 100, 0, 0, 0, DLOG_ERROR };
    SlogdWriteToBuffer(msg, strlen(msg), &msgInfo);

    msgInfo = (LogInfo){ RUN_LOG, SYSTEM, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer(msg, strlen(msg), &msgInfo);

    msgInfo = (LogInfo){ SECURITY_LOG, SYSTEM, 100, 0, 0, 0, DLOG_INFO };
    SlogdWriteToBuffer(msg, strlen(msg), &msgInfo);

    msgInfo = (LogInfo){ RUN_LOG, SYSTEM, 100, 0, 0, 0, DLOG_EVENT };
    SlogdWriteToBuffer(msg, strlen(msg), &msgInfo);

    // export
    AdxCommHandle handle = static_cast<AdxCommHandle>(LogMalloc(sizeof(CommHandle)));
    handle->type = OptType::COMM_HDC;
    handle->session = 0x123456;
    handle->comp = ComponentType::COMPONENT_SYS_GET;
    handle->timeout = 0;
    handle->client = nullptr;
    size_t len = sizeof(LogDataMsg) + strlen(SINGLE_EXPORT_LOG) + 1;
    LogDataMsg *value = (LogDataMsg *)malloc(len);
    memset_s(value, len, 0, len);
    value->devId = 0;
    value->sliceLen = strlen(SINGLE_EXPORT_LOG);
    memcpy_s(value->data, strlen(SINGLE_EXPORT_LOG), SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG));

    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgSingleStub));

    EXPECT_EQ(LOG_SUCCESS, SysGetProcess(handle, value, len));
    CheckLogResult(msg, "debug/device-os/device-os", 1, g_dataSingleBuffer);
    CheckLogResultRange("test for firmware log.", "debug/device-0/device-0", 1, g_dataSingleBuffer);
    CheckLogResult(msg, "run/device-os/device-os", 1, g_dataSingleBuffer);
    CheckLogResult(msg, "run/event/event", 1, g_dataSingleBuffer);
    CheckLogResult(msg, "security/device-os/device-os", 1, g_dataSingleBuffer);

    // 释放
    LogRecordSigNo(15);
    SlogdReceiveExit();
    SlogdFlushExit();
    SlogdLogClassifyExit();
    SlogdConfigMgrExit();
    free(value);
    free(handle);
}