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
#include "log_file_util.h"
#include "securec.h"
#include "adcore_api.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "msnpureport_options.h"
#include "errno.h"
#include "msnpureport_config.h"
#include "msnpureport_report.h"
#include "msnpureport_file_mgr.h"
#include "msnpureport_utils.h"
#include "msnpureport_stub.h"
#include "dsmi_common_interface.h"
#include "msnpureport_print.h"
#include "ide_daemon_api.h"
#include "log_communication.h"
#include "log_system_api.h"
#include <future>

extern "C" {
int MsnTest(int argc, char **argv);
extern int32_t MsnSetLogLevel(ArgInfo *argInfo, const char *arg, LogLevelType levelType);
extern int32_t MsnSetIcacheRange(ArgInfo *argInfo, const char *arg);
extern int32_t MsnSetAcceleratorRecover(ArgInfo *argInfo, const char *arg);
extern int32_t MsnSetCoreSwitch(ArgInfo *argInfo, const char *arg, enum ConfigType type);
extern int32_t MsnSetCoreId(ArgInfo *argInfo, char *arg);
extern int32_t MsnSetSingleCommit(ArgInfo *argInfo, const char *arg);
extern int32_t MsnSetDeviceId(ArgInfo *argInfo, const char *arg);
extern bool IsHaveExecPermission(void);
extern void GetHostDrvLog(void);
extern int32_t MsnReportPermanent(uint32_t devId, FileAgeingParam *param);
extern int CreateLogRootPath();
extern void *MsnReportRecvSlogd(void *args);
extern void MsnReportFaultEventHandle(struct dsmi_event *event);
extern void *MsnReportRecvLogDaemon(void *args);
extern void MsnFileMgrDeleteLogDaemonFile(const char *fileName, int32_t fileType);
extern void MsnReportPermanentStop(void);
extern int32_t MsnReportCreateThreadSingle(uint32_t devId, ThreadInfo *threadInfo, ThreadArgInfo *threadArg,
                                           void * (*func)(void *), int32_t logType);
extern int32_t MsnReportInitDevInfo(uint32_t devId);
extern bool MsnReportCheckDeviceAlive(uint32_t logicId);
extern void* SlogSyncThread(void *arg);
extern int32_t MsnFileMgrWriteData(const char *writeFile, const LogReportMsg *reportMsg);

extern ThreadInfo g_slogdThread[MAX_DEV_NUM];
extern ThreadInfo g_logDaemonThread[MAX_DEV_NUM];
extern char g_logPath[MMPA_MAX_PATH + 1];
extern mmStructOption g_reportOptions[23];
}

static int32_t AdxDevCommShortLinkStub(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result,
    uint32_t length, uint32_t timeout)
{
    if (req == NULL || type != HDC_SERVICE_TYPE_IDE_FILE_TRANS || req->type != COMPONENT_MSNPUREPORT) {
        return EN_ERROR;
    }

    struct MsnReq *msnReq = (struct MsnReq *)req->value;
    char *msg = NULL;
    if (msnReq->cmdType == CONFIG_SET && (msnReq->subCmd >= LOG_LEVEL && msnReq->subCmd < INVALID_TYPE)) {
        msg = "Configuration successfully set.";
    } else if (msnReq->cmdType == CONFIG_GET) {
        msg = "Icache check Range:123456,Accelerator Recover:Enable,Aic Coremask:0x3F,Aiv Coremask:0x3FFF|"
            "Event:Enable,Global:Error,PROFILING:Error,";
    } else if (msnReq->cmdType == REPORT) {
        msg = "";
    }
    struct ConfigInfo *configInfo = (struct ConfigInfo *)result;
    configInfo->isError = false;
    configInfo->len = strlen(msg) + 1;
    strcpy_s(configInfo->value, length - sizeof(struct ConfigInfo), msg);

    return EN_OK;
}

static int32_t AdxDevCommShortLinkError1(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result,
    uint32_t length, uint32_t timeout)
{
    struct ConfigInfo *configInfo = (struct ConfigInfo *)result;
    configInfo->isError = true;
    const char *msg = "failed";
    configInfo->len = strlen(msg);
    strcpy_s(configInfo->value, length - sizeof(struct ConfigInfo), msg);
    return 0;
}

static int32_t AdxDevCommShortLinkError2(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result,
    uint32_t length, uint32_t timeout)
{
    struct ConfigInfo *configInfo = (struct ConfigInfo *)result;
    configInfo->isError = true;
    const char *msg = "failed";
    configInfo->len = strlen(msg) + 1;
    strcpy_s(configInfo->value, length - sizeof(struct ConfigInfo), msg);
    return 0;
}

static int32_t AdxRecvMsgStubSlogd(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    static int32_t callCount = 0;
    char *error1 = CONNECT_OCCUPIED_MESSAGE;
    char *error2 = CONTAINER_NO_SUPPORT_MESSAGE;
    char *error3 = "ERROR";
    if (callCount == 0) {
        (void)memcpy_s(*data, *len, error1, strlen(error1));
        *len = strlen(error1);
    } else if (callCount == 1) {
        (void)memcpy_s(*data, *len, error2, strlen(error2));
        *len = strlen(error2);
    } else if (callCount == 2) {
        (void)memcpy_s(*data, *len, error3, strlen(error3));
        *len = strlen(error3);
    } else {
        (void)memcpy_s(*data, *len, HDC_END_MSG, strlen(HDC_END_MSG));
        *len = strlen(HDC_END_MSG);
    }
    callCount++;
    return 0;
}

static int32_t AdxRecvMsgStub(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    static int32_t callCount = 0;
    MsnServerResultInfo retInfo = { 0 };
    char *error1 = CONNECT_OCCUPIED_MESSAGE;
    char *error2 = CONTAINER_NO_SUPPORT_MESSAGE;
    char *error3 = "ERROR";
    const uint32_t msgSize = 128;
    if (callCount == 0) {
        retInfo.retCode = 1;
        (void)memcpy_s(retInfo.retMsg, msgSize, error1, strlen(error1));
    } else if (callCount == 1) {
        retInfo.retCode = 2;
        (void)memcpy_s(retInfo.retMsg, msgSize, error2, strlen(error2));
    } else if (callCount == 2) {
        retInfo.retCode = 3;
        (void)memcpy_s(retInfo.retMsg, msgSize, error3, strlen(error3));
    } else {
        retInfo.retCode = 0;
        (void)memcpy_s(retInfo.retMsg, msgSize, HDC_END_MSG, strlen(HDC_END_MSG));
    }
    (void)memcpy_s(*data, *len, &retInfo, sizeof(retInfo));
    *len = sizeof(retInfo);
    callCount++;
    return 0;
}
static void EXPECT_CheckErrLogNum(int32_t num)
{
    MOCKER(MsnGetLogPrintMode).expects(exactly(num)).will(returnValue(0));
}

class MsnpureportUtest : public testing::Test
{
    protected:
        static void SetUpTestCase()
        {
            std::cout << "msnpureport_main SetUP" << std::endl;
            system("mkdir -p " PATH_ROOT);
            chdir(PATH_ROOT);
        }
        static void TearDownTestCase()
        {
            std::cout << "msnpureport_main TearDown" << std::endl;
        }
        virtual void SetUp()
        {
            optind = 1;
            MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
            MOCKER(dlopen).stubs().will(invoke(DlopenStub));
            MOCKER(dlsym).stubs().will(invoke(DlsymStub));
            MOCKER(dlclose).stubs().will(returnValue(0));
            MsnSetLogPrintMode(1);
            std::cout << "a test SetUP" << std::endl;
        }
        virtual void TearDown()
        {
            system("rm -rf " PATH_ROOT "/*");
            std::cout << "a test TearDown" << std::endl;
            GlobalMockObject::verify();
        }
    public:
        void GetFileList(std::string &filePath, std::vector<std::string> &fileList)
        {
            DIR* dir = opendir(filePath.c_str());
            if (dir == NULL) {
                return;
            }
            struct dirent *entry;
            while ((entry = readdir(dir)) != nullptr) {
                if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
                    continue;
                }
                fileList.emplace_back(filePath + "/" + std::string(entry->d_name));
            }
            closedir(dir);
        }
        void CheckFileNum(std::string filePath, std::string filename, int32_t num)
        {
            std::string path = std::string(g_logPath) + filePath;
            std::vector<std::string> fileList;
            GetFileList(path, fileList);
            int32_t fileCount = 0;
            for (std::string &file : fileList) {
                if (file.substr(file.find_last_of('/') + 1, filename.size()) == filename) {
                    fileCount++;
                }
            }
            EXPECT_EQ(num, fileCount);
        }
};

TEST_F(MsnpureportUtest, Docker)
{
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(false));
    char *argv[] = {"msnpureport", "config", "--get", "--docker"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv));
    char *argv1[] = {"msnpureport", "report", "--docker"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv1));

    GlobalMockObject::reset();
    MOCKER(MsnIsDockerEnv).stubs().will(returnValue(true));
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));

    char *argv2[] = {"msnpureport", "config", "--get", "--docker"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv2));
    char *argv3[] = {"msnpureport", "report", "--docker"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv3));

    char *argv4[] = {"msnpureport", "config", "--get"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv4));
    char *argv5[] = {"msnpureport", "report"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(2, argv5));
    char *argv6[] = {"msnpureport", "config", "--set"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv6));
}

TEST_F(MsnpureportUtest, Help)
{
    int argc = 2;
    char *argv[] = { "msnpureport", "help"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(argc, argv));
    char *argv1[] = { "msnpureport", "config", "--help"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv1));
    char *argv2[] = { "msnpureport", "report", "--help"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv2));
}

TEST_F(MsnpureportUtest, Version)
{
    int argc = 2;
    char *argv[] = { "msnpureport", "version"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(argc, argv));
}

TEST_F(MsnpureportUtest, Main)
{
    char *argv1[] = {"msnpureport", "test1"};
    EXPECT_EQ(EN_ERROR, MsnTest(2, argv1));

    char *argv2[] = {"msnpureport", "config", "--get"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv2));

    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv3[] = {"msnpureport", "report"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(2, argv3));

    char *argv4[] = {"msnpureport", "config", "--get", "test", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv4));
    char *argv5[] = {"msnpureport", "config", "--get", "-d", "0000"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv5));
}

TEST_F(MsnpureportUtest, ConfigSet)
{
    MOCKER(AdxDevCommShortLink).stubs().will(invoke(AdxDevCommShortLinkStub));
    char *argv[] = {"msnpureport", "config", "--set", "--icachecheck", "12345", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(7, argv));

    char *argv1[] = {"msnpureport", "config", "--set", "--accelerator_recover", "0", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(7, argv1));

    char *argv2[] = {"msnpureport", "config", "--set", "--singlecommit", "1", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(7, argv2));

    char *argv3[] = {"msnpureport", "config", "--set", "--aiv_switch", "0", "--coreid", "3,4", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(9, argv3));
    char *argv4[] = {"msnpureport", "config", "--set", "--aic_switch", "0", "--coreid", "3,4", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(9, argv4));
}

TEST_F(MsnpureportUtest, ConfigSetLogLevel)
{
    MOCKER(AdxDevCommShortLink).stubs().will(invoke(AdxDevCommShortLinkStub));
    char *argv1[] = {"msnpureport", "config", "--set", "--log", "--global", "info", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(8, argv1));
    char *argv2[] = {"msnpureport", "config", "--set", "--log", "--module", "FMK:debug", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(8, argv2));
    char *argv3[] = {"msnpureport", "config", "--set", "--log", "--event", "disable", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(8, argv3));
    char *argv4[] = {"msnpureport", "config", "--set", "--aic_switch", "1", "--log", "--event", "disable", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(10, argv4));
    char *argv5[] = {"msnpureport", "config", "--set", "--log", "info"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv5));
    char *argv6[] = {"msnpureport", "config", "--set", "--log", "--event", "test"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv6));
}

TEST_F(MsnpureportUtest, ConfigGet)
{
    int argc = 5;
    char *argv[] = {"msnpureport", "config", "--get", "-d", "0"};
    optind = 1;
    MOCKER(AdxDevCommShortLink).stubs().will(invoke(AdxDevCommShortLinkStub));
    EXPECT_EQ(EN_OK, MsnTest(argc, argv));
}

TEST_F(MsnpureportUtest, ConfigError)
{
    MOCKER(AdxDevCommShortLink).stubs().will(returnValue(0));
    char *argv[] = {"msnpureport", "config", "--get", "-d", "0", "--set", "--icachecheck", "512"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(8, argv));
    char *argv1[] = {"msnpureport", "config", "-d", "0", "--set", "--icachecheck", "512", "--get"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(8, argv1));
    char *argv2[] = {"msnpureport", "config", "--set", "--aic_switch", "0", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(7, argv2));
    optind = 1;
    char *argv3[] = { "msnpureport", "config", "--set", "--singlecommit", "0001", "-d", "0"};
    EXPECT_EQ(EN_ERROR, MsnTest(7, argv3));
    optind = 1;
    char *argv4[] = {"msnpureport", "config", "--aic_switch", "1", "--coreid", "1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv4));
    char *argv5[] = {"msnpureport", "config", "--log", "--global", "info"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv5));
    optind = 1;
    char *argv14[] = {"msnpureport", "config", "--set", "--aic_switch", "00001", "--coreid", "1", "-d", "0"};
    EXPECT_EQ(EN_ERROR, MsnTest(9, argv14));
    optind = 1;
    char *argv15[] = {"msnpureport", "config", "--set", "--aic_switch", "1", "--coreid", "00001", "-d", "0"};
    EXPECT_EQ(EN_ERROR, MsnTest(9, argv15));
    char *argv16[] = {"msnpureport", "config", "--set", "--aiv_switch", "00001", "--coreid", "1", "-d", "0"};
    EXPECT_EQ(EN_ERROR, MsnTest(9, argv16));
    optind = 1;
    char *argv17[] = {"msnpureport", "config", "--set", "--aiv_switch", "1", "--coreid", "00001", "-d", "0"};
    EXPECT_EQ(EN_ERROR, MsnTest(9, argv17));
}

TEST_F(MsnpureportUtest, MsnSetLogLevel)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    std::string arg("test");
    EXPECT_EQ(EN_ERROR, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_GLOBAL));
    argInfo.subCmd = LOG_LEVEL;
    arg = "enable";
    EXPECT_EQ(EN_OK, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_EVENT));
    arg = "info";
    EXPECT_EQ(EN_ERROR, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_GLOBAL));
    argInfo.valueLen = 0;
    EXPECT_EQ(EN_OK, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_GLOBAL));
    arg = "FMK:debug";
    argInfo.valueLen = 0;
    EXPECT_EQ(EN_OK, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_MODULE));
    arg = "FMKdebug";
    argInfo.valueLen = 0;
    EXPECT_EQ(EN_ERROR, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_MODULE));
    arg = "TEST:debug";
    argInfo.valueLen = 0;
    EXPECT_EQ(EN_ERROR, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_MODULE));
    arg = "test";
    argInfo.valueLen = 0;
    EXPECT_EQ(EN_ERROR, MsnSetLogLevel(&argInfo, arg.c_str(), LOGLEVEL_GLOBAL));
}

TEST_F(MsnpureportUtest, MsnSetIcacheRange)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    std::string arg("test");
    EXPECT_EQ(EN_ERROR, MsnSetIcacheRange(&argInfo, arg.c_str()));
    arg = "9999999999999999";
    EXPECT_EQ(EN_ERROR, MsnSetIcacheRange(&argInfo, arg.c_str()));
    arg = "-128";
    EXPECT_EQ(EN_ERROR, MsnSetIcacheRange(&argInfo, arg.c_str()));
    arg = "256";
    EXPECT_EQ(EN_OK, MsnSetIcacheRange(&argInfo, arg.c_str()));
    arg = "256";
    EXPECT_EQ(EN_ERROR, MsnSetIcacheRange(&argInfo, arg.c_str()));
    EXPECT_EQ(ICACHE_RANGE, argInfo.subCmd);
}

TEST_F(MsnpureportUtest, MsnSetAcceleratorRecover)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    std::string arg("test");
    EXPECT_EQ(EN_ERROR, MsnSetAcceleratorRecover(&argInfo, arg.c_str()));
    arg = "423";
    EXPECT_EQ(EN_ERROR, MsnSetAcceleratorRecover(&argInfo, arg.c_str()));
    arg = "0";
    EXPECT_EQ(EN_OK, MsnSetAcceleratorRecover(&argInfo, arg.c_str()));
    arg = "1";
    EXPECT_EQ(EN_ERROR, MsnSetAcceleratorRecover(&argInfo, arg.c_str()));
    argInfo.subCmd = (uint32_t)INVALID_TYPE;
    arg = "1";
    EXPECT_EQ(EN_OK, MsnSetAcceleratorRecover(&argInfo, arg.c_str()));
    EXPECT_EQ(ACCELERATOR_RECOVER, argInfo.subCmd);
}

TEST_F(MsnpureportUtest, MsnSetCoreSwitch)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    std::string arg("test");
    EXPECT_EQ(EN_ERROR, MsnSetCoreSwitch(&argInfo, arg.c_str(), AIV_SWITCH));
    arg = "423";
    EXPECT_EQ(EN_ERROR, MsnSetCoreSwitch(&argInfo, arg.c_str(), AIV_SWITCH));
    arg = "0";
    EXPECT_EQ(EN_OK, MsnSetCoreSwitch(&argInfo, arg.c_str(), AIV_SWITCH));
    arg = "1";
    EXPECT_EQ(EN_ERROR, MsnSetCoreSwitch(&argInfo, arg.c_str(), AIV_SWITCH));
    argInfo.subCmd = (uint32_t)INVALID_TYPE;
    arg = "1";
    EXPECT_EQ(EN_OK, MsnSetCoreSwitch(&argInfo, arg.c_str(), AIV_SWITCH));
    EXPECT_EQ(AIV_SWITCH, argInfo.subCmd);
}

TEST_F(MsnpureportUtest, MsnSetCoreId)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    char arg[MAX_VALUE_STR_LEN] = "test";
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    EXPECT_EQ(EN_OK, MsnSetCoreSwitch(&argInfo, "0", AIV_SWITCH));
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "9999999");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "1,2,3,4,5");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "0xFFFF");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, ",,,");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "1,,,");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    argInfo.coreSwitch = -1;
    strcpy_s(arg, MAX_VALUE_STR_LEN, "1");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    argInfo.coreSwitch = 1;
    strcpy_s(arg, MAX_VALUE_STR_LEN, "0xFFFF,1");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "1,1");
    EXPECT_EQ(EN_ERROR, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "0xFFFF");
    EXPECT_EQ(EN_OK, MsnSetCoreId(&argInfo, arg));
    strcpy_s(arg, MAX_VALUE_STR_LEN, "1,2");
    EXPECT_EQ(EN_OK, MsnSetCoreId(&argInfo, arg));
    EXPECT_EQ(AIV_SWITCH, argInfo.subCmd);
}

TEST_F(MsnpureportUtest, MsnSetSingleCommit)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)INVALID_TYPE, 0, 0, 0, -1, false, {0}};
    std::string arg("test");
    EXPECT_EQ(EN_ERROR, MsnSetSingleCommit(&argInfo, arg.c_str()));
    arg = "423";
    EXPECT_EQ(EN_ERROR, MsnSetSingleCommit(&argInfo, arg.c_str()));
    arg = "0";
    EXPECT_EQ(EN_OK, MsnSetSingleCommit(&argInfo, arg.c_str()));
    arg = "1";
    EXPECT_EQ(EN_ERROR, MsnSetSingleCommit(&argInfo, arg.c_str()));
    argInfo.subCmd = (uint32_t)INVALID_TYPE;
    arg = "1";
    EXPECT_EQ(EN_OK, MsnSetSingleCommit(&argInfo, arg.c_str()));
    EXPECT_EQ(SINGLE_COMMIT, argInfo.subCmd);
}

TEST_F(MsnpureportUtest, MsnSetDeviceId)
{
    ArgInfo argInfo;
    argInfo.deviceId = MAX_DEV_NUM;
    char *arg = "test";
    EXPECT_EQ(EN_ERROR, MsnSetDeviceId(&argInfo, arg));
    arg = "99";
    EXPECT_EQ(EN_ERROR, MsnSetDeviceId(&argInfo, arg));
    arg = "3";
    EXPECT_EQ(EN_ERROR, MsnSetDeviceId(&argInfo, arg));
    arg = "0";
    EXPECT_EQ(EN_OK, MsnSetDeviceId(&argInfo, arg));
    EXPECT_EQ(EN_ERROR, MsnSetDeviceId(&argInfo, arg));
}

TEST_F(MsnpureportUtest, MsnConfig)
{
    ArgInfo argInfo = {CONFIG_SET, (uint32_t)ICACHE_RANGE, 0, 0, 0, -1, false, {0}};
    std::string value("1234");
    memcpy_s(argInfo.value, MAX_VALUE_STR_LEN, value.c_str(), value.size());
    argInfo.valueLen = value.size() + 1;

    MOCKER(AdxDevCommShortLink).stubs().will(invoke(AdxDevCommShortLinkStub));
    EXPECT_EQ(EN_OK, MsnConfig(&argInfo));
}

TEST_F(MsnpureportUtest, MsnConfigError)
{
    EXPECT_EQ(EN_ERROR, MsnConfig(NULL));
    ArgInfo argInfo = {INVALID_CMD, 0, 0, 0, 0, -1, false, {0}};
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // invalid cmd
    argInfo.cmdType = REPORT;

    MOCKER(AdxDevCommShortLink)
        .stubs()
        .will(returnValue(-1))
        .then(invoke(AdxDevCommShortLinkError1))
        .then(invoke(AdxDevCommShortLinkError2));

    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // AdxDevCommShortLink return error
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // configInfo->len error
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // configInfo->isError = true 1
    argInfo.cmdType = CONFIG_GET;
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // configInfo->isError = true 2

    argInfo.cmdType = CONFIG_SET;
    MOCKER(memcpy_s).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // memcpy error

    MOCKER(MsnMalloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(EN_ERROR, MsnConfig(&argInfo));   // MsnMalloc error
}

TEST_F(MsnpureportUtest, MsnPrintInfo)
{
    EXPECT_CheckErrLogNum(1);
    int16_t devId = 0;
    char *info = NULL;
    MsnPrintInfo(devId, info);
}

TEST_F(MsnpureportUtest, Report)
{
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    MOCKER(AdxDevCommShortLink).stubs().will(invoke(AdxDevCommShortLinkStub));
    char *argv[] = {"msnpureport", "report", "--all"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv));

    char *argv1[] = {"msnpureport", "report", "--force"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv1));

    char *argv2[] = {"msnpureport", "report", "--type", "0", "--print", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(6, argv2));
    char *argv3[] = {"msnpureport", "report", "--type", "1", "--print", "1"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(6, argv3));
    char *argv4[] = {"msnpureport", "report", "--type", "2", "--log_level", "debug"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(6, argv4));
    char *argv5[] = {"msnpureport", "report", "--type", "3"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv5));
    char *argv6[] = {"msnpureport", "report", "--type", "4"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv6));
    char *argv7[] = {"msnpureport", "report", "--type", "5"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv7));
    char *argv8[] = {"msnpureport", "report", "-d", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv8));
    char *argv9[] = {"msnpureport", "report", "--device", "0"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(4, argv9));
    char *argv10[] = {"msnpureport", "report", "--device", "0", "-t", "2"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(6, argv10));
    char *argv11[] = {"msnpureport", "report", "--device", "0", "-a"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(5, argv11));
}

TEST_F(MsnpureportUtest, ReportError)
{
    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    char *argv[] = {"msnpureport", "report", "-a", "--permanent"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv));
    char *argv1[] = {"msnpureport", "report", "--permanent", "-f"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv1));
    char *argv2[] = {"msnpureport", "report", "--permanent", "-t", "1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv2));
    char *argv3[] = {"msnpureport", "report", "--type", "6"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv3));
    char *argv4[] = {"msnpureport", "report", "-a", "--type", "2"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv4));
    char *argv5[] = {"msnpureport", "report", "--type", "2", "-a"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv5));
    char *argv6[] = {"msnpureport", "report", "--print", "-1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv6));
    char *argv7[] = {"msnpureport", "report", "--print", "3"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv7));
    char *argv8[] = {"msnpureport", "report", "--print", "test"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv8));
    char *argv9[] = {"msnpureport", "report", "--log_level", "test"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv9));
    char *argv10[] = {"msnpureport", "report", "--log_level", "debug", "--log_level", "info"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv10));
    char *argv11[] = {"msnpureport", "report", "--print", "0", "--print", "1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv11));
    char *argv12[] = {"msnpureport", "report", "-d", "8"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv12));
    char *argv13[] = {"msnpureport", "report", "-d", "-1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv13));
    char *argv14[] = {"msnpureport", "report", "-d", "1.5"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv14));
    char *argv15[] = {"msnpureport", "report", "-d", "0", "-d", "1"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(6, argv15));
}

TEST_F(MsnpureportUtest, GetHostDrvLog)
{
    EXPECT_CheckErrLogNum(4);
    MOCKER(halGetDeviceInfoByBuff)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_NONE));
    GetHostDrvLog();
    GetHostDrvLog();
    MOCKER(mmAccess).stubs().will(returnValue(EN_ERROR));
    MOCKER(mmMkdir).stubs().will(returnValue(EN_ERROR)).then(returnValue(EN_OK));
    GetHostDrvLog();
    MOCKER(calloc).stubs().will(returnValue((void *)NULL));
    GetHostDrvLog();
}

TEST_F(MsnpureportUtest, ReportPermanentDefault)
{
    MOCKER(MsnReport).stubs().will(returnValue(EN_OK));
    char *argv[] = {"msnpureport", "report", "--permanent"};
    optind = 1;
    EXPECT_EQ(EN_OK, MsnTest(3, argv));
}

TEST_F(MsnpureportUtest, ReportPermanentParamError)
{
    MOCKER(AdxRecvMsg).stubs().will(returnValue(IDE_DAEMON_ERROR));
    char *argv[] = {"msnpureport", "report", "--permanent", "--sys_log_num", "0"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv));
    char *argv1[] = {"msnpureport", "report", "--permanent", "--sys_log_size", "test"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv1));
    char *argv2[] = {"msnpureport", "report", "--sys_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv2));
    char *argv3[] = {"msnpureport", "report", "--permanent", "--permanent"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(4, argv3));
    char *argv4[] = {"msnpureport", "report", "--permanent", "--sys_log_size", "10", "--sys_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(7, argv4));
    char *argv5[] = {"msnpureport", "report", "--permanent", "--device", "99"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv5));
    char *argv6[] = {"msnpureport", "report", "--permanent", "--stackcore_num", "101"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv6));
    char *argv7[] = {"msnpureport", "report", "--permanent", "--fault_event_num", "101"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv7));
    char *argv8[] = {"msnpureport", "report", "--permanent", "--fault_event_num", "10001"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(5, argv8));
}

TEST_F(MsnpureportUtest, ReportPermanentDavidPoolError)
{
    MOCKER(MsnIsPoolEnv).stubs().will(returnValue(true));
    char *argv1[] = {"msnpureport", "report", "--permanent"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv1));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv2[] = {"msnpureport", "report", "--permanent", "--sys_log_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv2));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv3[] = {"msnpureport", "report", "--permanent", "--sys_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv3));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv4[] = {"msnpureport", "report", "--permanent", "--fw_log_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv4));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv5[] = {"msnpureport", "report", "--permanent", "--fw_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv5));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv6[] = {"msnpureport", "report", "--permanent", "--event_log_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv6));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv7[] = {"msnpureport", "report", "--permanent", "--event_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv7));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv8[] = {"msnpureport", "report", "--permanent", "--sec_log_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv8));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv9[] = {"msnpureport", "report", "--permanent", "--sec_log_size", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv9));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv10[] = {"msnpureport", "report", "--permanent", "--stackcore_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv10));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv11[] = {"msnpureport", "report", "--permanent", "--fault_event_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv11));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv12[] = {"msnpureport", "report", "--permanent", "--bbox_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv12));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv13[] = {"msnpureport", "report", "--permanent", "--slogd_log_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv13));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
    char *argv14[] = {"msnpureport", "report", "--permanent", "--app_dir_num", "10"};
    optind = 1;
    EXPECT_EQ(EN_ERROR, MsnTest(3, argv14));
    g_reportOptions[REPORT_OPTION_INDEX] = (mmStructOption){"permanent", MMPA_NO_ARGUMENT, NULL, 3};  // 恢复全局变量 REPORT_ARGS_PERMANENT:3
}

TEST_F(MsnpureportUtest, ReportPermanentError)
{
    FileAgeingParam param = {10};
    EXPECT_EQ(EN_ERROR, MsnReportPermanent(0, &param));

    MOCKER(IsHaveExecPermission).stubs().will(returnValue(true));
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_OK));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    EXPECT_EQ(EN_OK, MsnReportPermanent(0, &param));
    EXPECT_EQ(EN_OK, MsnReportPermanent(MAX_DEV_NUM, &param));
    MOCKER(MsnGetDevIDs).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnReportPermanent(0, &param));
    MOCKER(MsnFileMgrInit).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnReportPermanent(0, &param));
    MOCKER(CreateLogRootPath).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnReportPermanent(0, &param));
}

TEST_F(MsnpureportUtest, MsnReportRecvSlogd)
{
    ThreadArgInfo args = {4, 0, 0, 0, false};
    MOCKER(AdxRecvMsg)
        .stubs()
        .will(returnValue(-1))
        .then(invoke(AdxRecvMsgStubSlogd))
        .then(invoke(AdxRecvMsgStubSlogd))
        .then(invoke(AdxRecvMsgStubSlogd))
        .then(invoke(AdxRecvMsgStubSlogd))
        .then(invoke(AdxRecvMsgStubSlogd))
        .then(returnValue(IDE_DAEMON_SOCK_CLOSE));
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));   // AdxRecvMsg failed
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));   // Another msnpureport
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));   // docker
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));   // Get start messages failed

    MOCKER(AdxCreateCommHandle).stubs().will(returnValue((AdxCommHandle)NULL));
    MOCKER(AdxIsCommHandleValid)
        .stubs()
        .will(repeat(0, 3))
        .then(returnValue(-1));
    args.isThreadExit = false;
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));
    args.isThreadExit = false;
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));
}

TEST_F(MsnpureportUtest, MsnReportSendError)
{
    ThreadArgInfo args = {4, 0, 0, 0, false};
    MOCKER(AdxSendMsg).stubs().will(returnValue(-1));
    EXPECT_EQ(NULL, MsnReportRecvSlogd(&args));   // AdxRecvMsg failed
    args.isThreadExit = true;
    sleep(2);
}

TEST_F(MsnpureportUtest, MsnFileMgrSaveFile)
{
    int32_t paramNum = sizeof(FileAgeingParam) / sizeof(uint32_t);
    FileAgeingParam param = {0};
    uint32_t *item = (uint32_t*)&param;
    for (int32_t i = 0; i < paramNum; i++) {
        item[i] = 3;
    }
    param.slogdLogFileNum = 1;
    const char *rootPath = "/tmp/msn";
    EXPECT_EQ(EN_OK, MsnFileMgrInit(&param, rootPath));
    char filename[MMPA_MAX_PATH] = "stackcore/dev-os-0/./stackcore.slogd.4324324";
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "stackcore/dev-os-0/./stackcore.slogd.4324324");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "stackcore/dev-os-0/./stackcore.slogd.432435432");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "slog/dev-os-0/slogd/slogdlog");
    EXPECT_EQ(EN_ERROR, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "system_info/device-0/fault_event_0xB4324_4324");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "system_info/device-0/fault_event_0x4C324_4321324");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "system_info/device-0/fault_event_0x46F794_437684");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "system_info/device-0/fault_event_0x46D794_4312354");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "hisi_logs/device-0/20240904095349-544001066/DONE");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "test");
    EXPECT_EQ(EN_ERROR, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));

    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "slog/dev-os-0/slogd/slogdlog_32424");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    strcpy_s(filename, MMPA_MAX_PATH, "stackcore/dev-os-0/./stackcore.slogd.4324324");
    EXPECT_EQ(EN_OK, MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, 0));
    MsnFileMgrExit();
}

static drvError_t drvDeviceGetPhyIdByIndexStub(uint32_t devIndex, uint32_t *phyId)
{
    if (devIndex == 0) {
        *phyId = 2;
    } else {
        *phyId = 0;
    }
    return DRV_ERROR_NONE;
}

static int32_t AdxGetDeviceFileTimeoutStub(uint16_t devId, IdeString desPath, IdeString logType, uint32_t timeout)
{
    (void)desPath;
    (void)logType;
    (void)timeout;
    EXPECT_EQ(2, devId);
    return 0;
}

TEST_F(MsnpureportUtest, MsnReportFaultEventHandle)
{
    int32_t paramNum = sizeof(FileAgeingParam) / sizeof(uint32_t);
    FileAgeingParam param = {0};
    uint32_t *item = (uint32_t*)&param;
    for (int32_t i = 0; i < paramNum; i++) {
        item[i] = 3;
    }

    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(invoke(drvDeviceGetPhyIdByIndexStub));
    MOCKER(AdxGetDeviceFileTimeout).stubs().will(invoke(AdxGetDeviceFileTimeoutStub));
    const char *rootPath = "/tmp/msn";
    EXPECT_EQ(EN_OK, MsnFileMgrInit(&param, rootPath));
    struct dsmi_event event= {DMS_FAULT_EVENT, {3123, 0}};
    MsnReportFaultEventHandle(&event);
    event.event_t.dms_event.assertion = 1;
    MsnReportFaultEventHandle(&event);
    event.event_t.dms_event.deviceid = 16;
    MsnReportFaultEventHandle(&event);
    MsnFileMgrExit();
}

TEST_F(MsnpureportUtest, MsnReportRecvLogDaemonSMP)
{
    ThreadArgInfo args = {4, 0, 2, 2, false};
    uint32_t devNum = 2;
    MOCKER(drvGetDevNum).stubs().with(outBoundP(&devNum, sizeof(devNum))).will(returnValue(0));
    MOCKER(AdxRecvMsg)
        .stubs()
        .will(returnValue(-1))
        .then(invoke(AdxRecvMsgStub))
        .then(invoke(AdxRecvMsgStub))
        .then(invoke(AdxRecvMsgStub))
        .then(invoke(AdxRecvMsgStub))
        .then(invoke(AdxRecvMsgStub))
        .then(returnValue(IDE_DAEMON_SOCK_CLOSE));
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));   // AdxRecvMsg failed
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));   // Another msnpureport
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));   // docker
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));   // Get start messages failed

    MOCKER(AdxCreateCommHandle).stubs().will(returnValue((AdxCommHandle)NULL));
    MOCKER(AdxIsCommHandleValid)
        .stubs()
        .will(repeat(IDE_DAEMON_OK, 11))
        .then(returnValue(-1));
    MOCKER(AdxRecvDevFileTimeout)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1))
        .then(repeat((int32_t)IDE_DAEMON_HDC_TIMEOUT, 5))
        .then(returnValue(1));
    MOCKER(MsnFileMgrSaveFile).stubs().will(returnValue(0));
    EXPECT_EQ(EN_OK, MsnReportInitDevInfo(0));
    args.isThreadExit = false;
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));     // timeout 5 times, heart beat lost
    args.isThreadExit = false;
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));     // log daemon process exit
}

TEST_F(MsnpureportUtest, MsnReportRecvLogDaemonHBL)
{
    ThreadArgInfo args = {4, 0, 2, 2, false};
    MOCKER(AdxRecvMsg)
        .stubs()
        .will(invoke(AdxRecvMsgStub));

    MOCKER(AdxCreateCommHandle).stubs().will(returnValue((AdxCommHandle)NULL));
    MOCKER(AdxIsCommHandleValid)
        .stubs()
        .will(repeat(IDE_DAEMON_OK, 11))
        .then(returnValue(-1));
    MOCKER(AdxRecvDevFileTimeout)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1))
        .then(repeat((int32_t)IDE_DAEMON_HDC_TIMEOUT, 5))
        .then(returnValue(1));
    MOCKER(MsnFileMgrSaveFile).stubs().will(returnValue(0));
    EXPECT_EQ(EN_OK, MsnReportInitDevInfo(0));
    args.isThreadExit = false;
    EXPECT_EQ(NULL, MsnReportRecvLogDaemon(&args));     // timeout 5 times, heart beat lost
}

TEST_F(MsnpureportUtest, MsnFileMgrDeleteLogDaemonFile)
{
    EXPECT_CheckErrLogNum(2);
    MOCKER(mmRmdir).stubs().will(returnValue(0));
    const char *filename = "/tmp/msn/test";
    MsnFileMgrDeleteLogDaemonFile(filename, 0);
    MsnFileMgrDeleteLogDaemonFile(filename, 4);
}

TEST_F(MsnpureportUtest, MsnReportPermanentStop)
{
    EXPECT_CheckErrLogNum(2);
    g_slogdThread[0].tid = 1;
    g_logDaemonThread[0].tid = 1;
    MOCKER(mmJoinTask).stubs().will(returnValue(-1));
    MsnReportPermanentStop();
}

TEST_F(MsnpureportUtest, MsnReportCreateThreadSingle)
{
    ThreadInfo threadInfo;
    ThreadArgInfo threadArgInfo;
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_ERROR, MsnReportCreateThreadSingle(0, &threadInfo, &threadArgInfo, MsnReportRecvLogDaemon, 0));

    MOCKER(AdxGetSpecifiedFile).stubs().will(returnValue(-1));
    MOCKER(AdxGetDeviceFileTimeout).stubs().will(returnValue(-1));
    ThreadArgInfo info = {ALL_LOG, 0, 0, 0, false};
    EXPECT_EQ(NULL, SlogSyncThread((void *)(&info)));
}

TEST_F(MsnpureportUtest, MsnReportGetDeviceStatusFailed)
{
    MOCKER(drvDeviceStatus).stubs().will(returnValue(1));
    EXPECT_EQ(false, MsnReportCheckDeviceAlive(0));
}

TEST_F(MsnpureportUtest, MsnUtilsGetDeviceIdFailed)
{
    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    uint32_t phyId = 0;
    int64_t masterId = 0;
    EXPECT_EQ(EN_ERROR, MsnGetDevMasterId(0, &phyId, &masterId));
}

TEST_F(MsnpureportUtest, MsnUtilsIsPoolEnv)
{
    EXPECT_EQ(false, MsnIsPoolEnv());

    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfo_stub));
    EXPECT_EQ(false, MsnIsPoolEnv());
}

TEST_F(MsnpureportUtest, WriteFileError)
{
    int32_t paramNum = sizeof(FileAgeingParam) / sizeof(uint32_t);
    FileAgeingParam param = {0};
    uint32_t *item = (uint32_t*)&param;
    for (int32_t i = 0; i < paramNum; i++) {
        item[i] = 3;
    }
    system("mkdir -p /tmp/msnpureport_utest");
    const char *rootPath = "/tmp/msnpureport_utest";
    EXPECT_EQ(EN_OK, MsnFileMgrInit(&param, rootPath));

    const char *log = "test log";
    void *buffer = malloc(sizeof(LogReportMsg) + strlen(log) + 1);
    LogReportMsg *msg = (LogReportMsg *)buffer;
    msg->bufLen = strlen(log) + 1;
    strcpy_s(msg->buf, msg->bufLen, log); 
    MOCKER(ToolWrite).stubs().will(repeat(-1, 4)).then(returnValue((int32_t)msg->bufLen));
    errno = ENOSPC;
    EXPECT_EQ(EN_ERROR, MsnFileMgrWriteData("/tmp/msnpureport_utest/tmp", msg));    // first error
    errno = ENOSPC;
    EXPECT_EQ(EN_ERROR, MsnFileMgrWriteData("/tmp/msnpureport_utest/tmp", msg));    // no log
    ToolTimeval timeVal = { 0, 0 };
    ToolGetTimeOfDay(&timeVal, NULL);
    timeVal.tvSec += 15 * 60 + 1;
    MOCKER(ToolGetTimeOfDay).stubs().with(outBoundP(&timeVal), any()).will(returnValue(SYS_OK));
    errno = ENOSPC;
    EXPECT_EQ(EN_ERROR, MsnFileMgrWriteData("/tmp/msnpureport_utest/tmp", msg));    // 15 min print
    errno = ENOENT;
    EXPECT_EQ(EN_ERROR, MsnFileMgrWriteData("/tmp/msnpureport_utest/tmp", msg));    // other error
    EXPECT_EQ(EN_OK, MsnFileMgrWriteData("/tmp/msnpureport_utest/tmp", msg));
    system("rm /tmp/msnpureport_utest/tmp");
    free(buffer);
}

TEST_F(MsnpureportUtest, MsnMkdir)
{
    for (int i = 0; i < 100; i++) {
        std::vector<std::future<void>> threads;
        for (int j = 0; j < 10; j++) {
            threads.emplace_back(std::async(std::launch::async, []()->void {
                EXPECT_EQ(EN_OK, MsnMkdir("/tmp/msnpureport_utest"));
            }));
        }
        for (auto &it : threads) {
            it.wait();
        }
        system("rm -r /tmp/msnpureport_utest");
    }

    EXPECT_EQ(EN_OK, MsnMkdir("/tmp/msnpureport_utest"));   // file access success

    MOCKER(mmAccess).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(EN_OK, MsnMkdir("/tmp/msnpureport_utest"));   // file exist
    system("rm -r /tmp/msnpureport_utest");
}