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
#include "slogd_communication.h"
#include "log_pm_sig.h"
#include "log_file_util.h"

extern "C" {
    #include "operate_loglevel.h"
    #include "log_config_api.h"
    #include "log_common.h"
    #include <sys/inotify.h>
    #include "slogd_utest_stub.h"
    #include "ascend_hal.h"
    #include "share_mem.h"
    #include "dlog_common.h"
    #include "dlog_time.h"
    #include "log_path_mgr.h"
    #include "log_level_parse.h"

typedef struct TagFileDataBuf {
    int len;
    char *data;
} FileDataBuf;

typedef struct {
    int32_t devId;
    int32_t moduleNum;
    char *globalLevel;
    char *eventLevel;
    char *moduleLevel;
} GetLevelInfo; // level info for cmd "GetLogLevel"

    LogRt WriteToSlogCfg(const char *cfgFile, const FileDataBuf filebuf);
    void RespSettingResult(LogRt res, toolMsgid queueId, const char *logLevelResult);
    void HandleLogLevelChange(bool setDlogFlag);
    LogRt GetLogLevelValue(char *logLevelResult, int32_t devId, bool isNewStyle);
    int32_t FindLevelFunc(const Buff *node, ArgPtr arg, bool isNewStyle);
    LogRt SetLogLevelValue(LogCmdMsg data);
    LogRt SetGlobalLogLevel(char *data, int32_t devId);
    LogRt SetModuleLogLevel(char *data, int32_t devId);
    LogRt SetEventLevelValue(char *data);
    LogRt ConstructLevelStr(char *str, int strLen);
    LogRt ConstructModuleStr(char *str, int strLen);
    int UpdateLevelToShMem(void);
    int InitModuleArrToShMem();
    bool IsModule(const char *confName);
    void ReceiveAndProcessLogLevel(void);
    extern INT32 ThreadLock(void);
    extern INT32 ThreadUnLock(void);
    extern LogRt SetSlogCfgLevel(const char *cfgFile, const char *cfgName, int level);
    LogRt SetAllModuleLevel(int32_t devId, int32_t logLevel);
    LogRt SetDlogLevel(int32_t devId);
    extern LogRt ReadFileAll(const char *cfgFile, FileDataBuf *dataBuf);
    extern int ProcessValue(char *valStr, int minValue, int maxValue, bool isSwitch);
    extern LogRt ConvertLevelStrToNum(const char *confName, const char *valStr, int *val, const int minBound,
        const int maxBound);
    extern LogRt ConvertEnableStrToNum(const char *confName, const char *valStr, int *val, const int disableValue,
        const int enableValue);
    void *OperateLogLevel(const ArgPtr args);
    LogStatus MsgQueueDelete(toolMsgid queueId);
}

#define LLT_SLOG_DIR "llt/abl/slog"

#define GLOBAL_ENABLE_MAX_LEN 8
#define SINGLE_MODULE_MAX_LEN 24

class SlogdSetLogLevel : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdSetLogLevel::SetUp()
{
    MOCKER(LogConfListUpdate).stubs().will(returnValue(0));
    SlogdCommunicationInit();
}

void SlogdSetLogLevel::TearDown()
{
    SlogdCommunicationExit();
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, LogStrStartsWith)
{
    //MOCKER(strncmp).stubs().will(returnValue(0));
    EXPECT_TRUE(LogStrStartsWith("Hello World!", "Hello"));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, StartsWith1)
{
    EXPECT_FALSE(LogStrStartsWith("Hello World!", NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetGlobalLoglevelNotData)
{
    EXPECT_EQ(ARGV_NULL, SetGlobalLogLevel(NULL, NULL));
}

TEST_F(SlogdSetLogLevel, SetGlobalLoglevel_InvalidData)
{
    int32_t devId = 0;
    EXPECT_EQ(ARGV_NULL, SetGlobalLogLevel(NULL, devId));

    char data1[] = ")[2]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetGlobalLogLevel(data1, devId));

    char data2[] = "[2](";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetGlobalLogLevel(data2, devId));

    char data3[] = "[2..]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetGlobalLogLevel(data3, devId));

    char data4[] = "[-2]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetGlobalLogLevel(data4, devId));
}

TEST_F(SlogdSetLogLevel, SetGlobalLoglevel_Fail)
{
    int32_t devId = 0;
    char data[] = "[warning]";

    MOCKER(ThreadLock).stubs().will(returnValue(0));
    MOCKER(ThreadUnLock).stubs().will(returnValue(0));
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(LOG_RESERVED));
    MOCKER(SetAllModuleLevel).stubs().will(returnValue(LOG_RESERVED));
    MOCKER(SetDlogLevel).stubs().will(returnValue(LOG_RESERVED));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(LOG_RESERVED, SetGlobalLogLevel(data, devId));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetGlobalLoglevel_OK)
{
    int32_t devId = 0;
    char data[] = "[warning]";

    MOCKER(ThreadLock).stubs().will(returnValue(0));
    MOCKER(ThreadUnLock).stubs().will(returnValue(0));
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(SetAllModuleLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(SetDlogLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SUCCESS, SetGlobalLogLevel(data, devId));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetAllModuleLevel_NULL)
{
    int32_t devId = 0;
    int32_t level = 1;
    MOCKER(GetModuleInfos).stubs().will(returnValue((const ModuleInfo *)NULL));
    EXPECT_EQ(ARGV_NULL, SetAllModuleLevel(devId, level));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetAllModuleLevel_Failed)
{
    int32_t devId = 0;
    int32_t level = 1;
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(LOG_RESERVED));
    EXPECT_EQ(LOG_RESERVED, SetAllModuleLevel(devId, level));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetModuleLoglevel_InvalidData)
{
    int32_t devId = 0;
    EXPECT_EQ(ARGV_NULL, SetModuleLogLevel(NULL, devId));

    char data1[] = ")[slog:info]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetModuleLogLevel(data1, devId));

    char data2[] = "[slog:info](";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetModuleLogLevel(data2, devId));

    char data3[] = "[slog]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetModuleLogLevel(data3, devId));

    char data4[] = "[slog1:error]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetModuleLogLevel(data4, devId));

    char data5[] = "[slog:info1]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetModuleLogLevel(data5, devId));

    char data6[] = "[SLOGDGGGGGGGGDDDGDGDGDDDDDDDDDDDDGGGGGGGGGGDDDDDDDDDDGGGGGGGGGGDDDDDDDDDDDDDGGGGGGGGGGDDDDDDDDDDDDDDDGGGGGGGGGGGGGGDDDDDDDDDDDDDGGGGGGGGGGGGGGGGGGDDDDDDDDDDGGGGGGGDDDDDDDDDD:warning]";
    EXPECT_EQ(STR_COPY_FAILED, SetModuleLogLevel(data6, devId));
}

TEST_F(SlogdSetLogLevel, SetModuleLogLevel_Fail)
{
    int32_t devId = 0;
    char data[] = "[slog:warning]";

    MOCKER(ThreadLock).stubs().will(returnValue(0));
    MOCKER(ThreadUnLock).stubs().will(returnValue(0));
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(LOG_RESERVED));
    MOCKER(SetDlogLevel).stubs().will(returnValue(LOG_RESERVED));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(LOG_RESERVED, SetModuleLogLevel(data, devId));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetModuleLoglevel_Success)
{
    int32_t devId = 0;
    char data[] = "[slog:warning]";

    MOCKER(ThreadLock).stubs().will(returnValue(0));
    MOCKER(ThreadUnLock).stubs().will(returnValue(0));
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(SetDlogLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SUCCESS, SetModuleLogLevel(data, devId));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetModuleLogLevel_Firmware)
{
    int32_t devId = 0;
    char data[] = "[TS:info]";
    uint32_t deviceNum = 4;

    MOCKER(SetDlogLevel).stubs().will(returnValue(SUCCESS));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    EXPECT_EQ(SUCCESS, SetModuleLogLevel(data, devId));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, GetLogLevelValueTest)
{
    char logLevelResult[MSG_MAX_LEN];
    MOCKER(calloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(CALLOC_FAILED, GetLogLevelValue(logLevelResult, 0, true));
    EXPECT_EQ(CALLOC_FAILED, GetLogLevelValue(logLevelResult, 0, false));
}

TEST_F(SlogdSetLogLevel, GetLogLevelValueTest1)
{
    char logLevelResult[MSG_MAX_LEN];
    MOCKER(LogConfListTraverse).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SUCCESS, GetLogLevelValue(logLevelResult, 0, true));
    EXPECT_EQ(SUCCESS, GetLogLevelValue(logLevelResult, 0, false));
}

TEST_F(SlogdSetLogLevel, GetLogLevelValueTest2)
{
    char logLevelResult[MSG_MAX_LEN];
    MOCKER(LogConfListTraverse).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(STR_COPY_FAILED, GetLogLevelValue(logLevelResult, 0, true));
    EXPECT_EQ(STR_COPY_FAILED, GetLogLevelValue(logLevelResult, 0, false));
}

TEST_F(SlogdSetLogLevel, FindLevelFunc)
{
    ConfList node1 = { GLOBALLEVEL_KEY, "5", NULL };
    char globalLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char debugLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char runLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char eventLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char moduleLevel[SINGLE_MODULE_MAX_LEN] = { 0 };
    GetLevelInfo level = { 0, 0, globalLevel, eventLevel, moduleLevel };
    FindLevelFunc((const Buff *)&node1, (ArgPtr)&level, false);
    EXPECT_STREQ("ERROR", level.globalLevel);

    ConfList node2 = { ENABLEEVENT_KEY, "2", NULL };
    FindLevelFunc((const Buff *)&node2, (ArgPtr)&level, true);
    EXPECT_STREQ("ENABLE", level.eventLevel);

    ConfList node3 = { "SLOG", "1", NULL };
    FindLevelFunc((const Buff *)&node3, (ArgPtr)&level, false);
    EXPECT_STREQ("SLOG:INFO ", level.moduleLevel);
    EXPECT_EQ(1, level.moduleNum);
    memset_s(moduleLevel, SINGLE_MODULE_MAX_LEN, 0, SINGLE_MODULE_MAX_LEN);
    ConfList node4 = { "SLOG", "1", NULL };
    FindLevelFunc((const Buff *)&node4, (ArgPtr)&level, true);
    EXPECT_STREQ("SLOG:INFO,", level.moduleLevel);
    EXPECT_EQ(2, level.moduleNum);
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, IsModuleTest)
{
    const char *confName = "SLOG";
    EXPECT_EQ(TRUE, IsModule(confName));
}

TEST_F(SlogdSetLogLevel, SetLoglevelValueInvalidData)
{
    LogCmdMsg recv1 = { 0, 0, "setLogLevel" };
    LogCmdMsg recv2 = { 0, 0, "SetLogLevel[]" };
    LogCmdMsg recv3 = { 0, 0, "SetLogLevel(3)[]" };

    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetLogLevelValue(recv1));
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetLogLevelValue(recv2));
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetLogLevelValue(recv3));
}

TEST_F(SlogdSetLogLevel, OperateLogLevel)
{
    MOCKER(InitModuleArrToShMem).stubs().will(returnValue(SYS_OK));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(0)).then(returnValue(1));
    MOCKER(MsgQueueOpen).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(MsgQueueRecv).stubs().will(returnValue(1));
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(-1));
    MOCKER(MsgQueueDelete).stubs().will(returnValue(1));
    EXPECT_EQ((void*)0, OperateLogLevel(NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, OperateLogLevel2)
{
    LogCmdMsg data = { 1, 0, "special pid=" };
    MOCKER(InitModuleArrToShMem).stubs().will(returnValue(SYS_OK));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    MOCKER(MsgQueueOpen).stubs().will(returnValue(0));
    MOCKER(MsgQueueDelete).stubs().will(returnValue(1));
    MOCKER(MsgQueueRecv).stubs().with(any(), outBoundP((void*)&data), any(), any()).will(returnValue(0));
    EXPECT_EQ((void*)0, OperateLogLevel(NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, OperateLogLevel3)
{
    MOCKER(InitModuleArrToShMem).stubs().will(returnValue(SYS_OK));
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    MOCKER(MsgQueueOpen).stubs().will(returnValue(0));
    MOCKER(SetLogLevelValue).stubs().will(returnValue(SUCCESS));
    MOCKER(RespSettingResult).stubs();
    MOCKER(MsgQueueDelete).stubs().will(returnValue(1));
    MOCKER(MsgQueueRecv).stubs().will(returnValue(0));
    EXPECT_EQ((void*)0, OperateLogLevel(NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, OperateLogLevel4)
{
    LogCmdMsg data = { 0, 0, "" };
    MOCKER(memset_s).stubs().will(returnValue(0));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    MOCKER(MsgQueueOpen).stubs().will(returnValue(0));
    MOCKER(MsgQueueDelete).stubs().will(returnValue(1));
    MOCKER(MsgQueueRecv).stubs().will(returnValue(1));
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(EINTR));
    EXPECT_EQ((void*)0, OperateLogLevel(NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel1)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    EXPECT_EQ(ARGV_NULL, SetSlogCfgLevel(NULL,"global_level", 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel2)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    MOCKER(ReadFileAll).stubs().will(returnValue(LOG_RESERVED));
    EXPECT_EQ(LOG_RESERVED, SetSlogCfgLevel(file, "global_level", 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel3)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    MOCKER(ReadFileAll).stubs().with(any(), outBoundP(&buf)).will(returnValue(SUCCESS));
    EXPECT_EQ(INPUT_INVALID, SetSlogCfgLevel(file, "", 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel4)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 3);
    MOCKER(ReadFileAll).stubs().with(any(), outBoundP(&buf)).will(returnValue(SUCCESS));
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(MALLOC_FAILED, SetSlogCfgLevel(file, "global_level", 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel5)
{
    GlobalMockObject::reset();
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 3);
    MOCKER(ReadFileAll).stubs().with(any(), outBoundP(&buf)).will(returnValue(SUCCESS));
    EXPECT_EQ(SUCCESS, SetSlogCfgLevel(file, "global_leve", 1));

    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetSlogCfgLevel6)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "\nglobal_level=%d", 3);
    MOCKER(ReadFileAll).stubs().with(any(), outBoundP(&buf)).will(returnValue(SUCCESS));
    MOCKER(WriteToSlogCfg).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SUCCESS, SetSlogCfgLevel(file, "global_level", 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest1)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(MALLOC_FAILED, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest2)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(ToolRealPath).stubs().will(returnValue(-1));
    EXPECT_EQ(GET_CONF_FILEPATH_FAILED, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest3)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfCheckPath).stubs().will(returnValue(false));
    EXPECT_EQ(CONF_FILEPATH_INVALID, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest4)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;
    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfCheckPath).stubs().will(returnValue(true));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(-1));
    EXPECT_EQ(OPEN_CONF_FAILED, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest5)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;
    buf.len = 17;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfCheckPath).stubs().will(returnValue(true));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(1));
    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, WriteToSlogCfgTest6)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    buf.len = 16;
    buf.data = (char*)malloc(buf.len);
    sprintf(buf.data, "global_level=%d", 1);
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfCheckPath).stubs().will(returnValue(true));
    MOCKER(ToolOpenWithMode).stubs().will(returnValue(1));
    MOCKER(ToolWrite).stubs().will(returnValue(buf.len));
    EXPECT_EQ(SUCCESS, WriteToSlogCfg(file, buf));
    GlobalMockObject::reset();
    free(buf.data);
    buf.data = NULL;
}

TEST_F(SlogdSetLogLevel, ReadFileAll1)
{
    EXPECT_EQ(ARGV_NULL, ReadFileAll(NULL, NULL));
}

TEST_F(SlogdSetLogLevel, ReadFileAll1_1)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(MALLOC_FAILED, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll2)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    MOCKER(ToolRealPath).stubs().will(returnValue(1));
    EXPECT_EQ(GET_CONF_FILEPATH_FAILED, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll2_1)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    MOCKER(LogConfCheckPath).stubs().will(returnValue(false));
    EXPECT_EQ(CONF_FILEPATH_INVALID, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll3)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    MOCKER(fopen).stubs().will(returnValue((FILE*)NULL));
    EXPECT_EQ(OPEN_CONF_FAILED, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll4)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    MOCKER(fopen).stubs().will(returnValue(stdout));
    MOCKER(fclose).stubs().will(returnValue(0));
    MOCKER(fstat).stubs().will(returnValue(-1));

    EXPECT_EQ(READ_FILE_ERR, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll5)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;

    struct stat st;

    st.st_size = 0;

    MOCKER(fopen).stubs().will(returnValue(stdout));
    MOCKER(fclose).stubs().will(returnValue(0));
    MOCKER(fstat).stubs().with(any(), outBoundP(&st)).will(returnValue(0));
    EXPECT_EQ(READ_FILE_ERR, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll6)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;
    buf.data = NULL;

    struct stat st;

    st.st_size = 16;

    MOCKER(fopen).stubs().will(returnValue(stdout));
    MOCKER(fclose).stubs().will(returnValue(0));
    MOCKER(fstat).stubs().with(any(), outBoundP(&st)).will(returnValue(0));
    MOCKER(fread).stubs().will(returnValue((size_t)0));

    EXPECT_EQ(READ_FILE_ERR, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll7)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;
    buf.data = NULL;

    struct stat st;

    st.st_size = 16;

    MOCKER(fopen).stubs().will(returnValue(stdout));
    MOCKER(fclose).stubs().will(returnValue(0));
    MOCKER(fstat).stubs().with(any(), outBoundP(&st)).will(returnValue(0));
    MOCKER(fread).stubs().will(returnValue((size_t)st.st_size));

    EXPECT_EQ(SUCCESS, ReadFileAll(file, &buf));

    if (buf.data)
    {
        free(buf.data);
    }
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ReadFileAll8)
{
    char *file = LLT_SLOG_DIR "/ut/slog.conf";
    FileDataBuf buf;
    buf.data = NULL;
    char *ptr = (char*)malloc(PATH_MAX + 1);

    struct stat st;
    st.st_size = 16;
    MOCKER(fopen).stubs().will(returnValue(stdout));
    MOCKER(fclose).stubs().will(returnValue(0));
    MOCKER(fstat).stubs().with(any(), outBoundP(&st)).will(returnValue(0));
    MOCKER(malloc).stubs().will(returnValue((void*)ptr)).then(returnValue((void*)NULL));
    EXPECT_EQ(MALLOC_FAILED, ReadFileAll(file, &buf));
    GlobalMockObject::reset();
}
TEST_F(SlogdSetLogLevel, SetEventLevelValue_InvalidData)
{
    EXPECT_EQ(ARGV_NULL, SetEventLevelValue(NULL));

    char data1[] = ")[enable]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetEventLevelValue(data1));

    char data2[] = "[enable](";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetEventLevelValue(data2));

    char data3[] = "[###]";
    EXPECT_EQ(LEVEL_INFO_ILLEGAL, SetEventLevelValue(data3));
}

TEST_F(SlogdSetLogLevel, SetEventLevelValue_Success)
{
    char data[] = "[disable]";
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(0));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(0, SetEventLevelValue(data));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetEventLevelValue_Fail)
{
    char data[] = "[disable]";
    MOCKER(SetSlogCfgLevel).stubs().will(returnValue(1));
    MOCKER(UpdateLevelToShMem).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(1, SetEventLevelValue(data));
    GlobalMockObject::reset();
}

void ChangeSignal2()
{
    LogRecordSigNo(1);
}

TEST_F(SlogdSetLogLevel, SetDlogLevel1)
{
    MOCKER(halGetDevNumEx).stubs().will(returnValue(1));
    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    EXPECT_EQ(GET_DEVICE_ID_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevelGetDevIdFailed)
{
    MOCKER(halGetDevIDsEx).stubs().will(returnValue(1));
    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    EXPECT_EQ(GET_DEVICE_ID_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel2)
{
    unsigned int deviceNum = 2;
    int channelTypeNum = 8;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_TS,
        LOG_CHANNEL_TYPE_MCU_DUMP,
        LOG_CHANNEL_TYPE_AICPU,
        LOG_CHANNEL_TYPE_LPM3,
        LOG_CHANNEL_TYPE_ISP,
        LOG_CHANNEL_TYPE_SIS,
        LOG_CHANNEL_TYPE_HSM,
        -1
    };

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel3)
{
    unsigned int deviceNum = 2;
    int channelTypeNum = 7;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_MCU_DUMP,
        LOG_CHANNEL_TYPE_AICPU,
        LOG_CHANNEL_TYPE_LPM3,
        LOG_CHANNEL_TYPE_ISP,
        LOG_CHANNEL_TYPE_SIS,
        LOG_CHANNEL_TYPE_HSM,
        -1
    };

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel4)
{
    unsigned int deviceNum = 2;
    int channelTypeNum = 5;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_AICPU,
        LOG_CHANNEL_TYPE_LPM3,
        -1
    };

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel5)
{
    unsigned int deviceNum = 2;
    int channelTypeNum = 5;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_LPM3,
        LOG_CHANNEL_TYPE_SIS_BIST,
        -1
    };

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType, sizeof(int) * channelTypeNum), outBoundP(&channelTypeNum), any())
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel6)
{
    unsigned int deviceNum = 2;
    int channelTypeNum = 5;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_MAX
    };

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel7)
{
    unsigned int deviceNum = 1;
    int channelTypeNum = 8;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_HSM,
        -1
    };

    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel8)
{
    unsigned int deviceNum = 1;
    int channelTypeNum = 8;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_ISP,
        -1
    };

    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, SetDlogLevel9)
{
    unsigned int deviceNum = 1;
    int channelTypeNum = 8;
    int deviceChnlType[LOG_CHANNEL_NUM_MAX] = {
        LOG_CHANNEL_TYPE_SIS,
        -1
    };

    MOCKER(halGetDevNumEx).stubs().with(any(), outBoundP(&deviceNum)).will(returnValue(0));
    MOCKER(log_get_channel_type)
        .stubs()
        .with(any(), outBoundP(deviceChnlType), outBoundP(&channelTypeNum), any())
        .will(returnValue(0));
    MOCKER(log_set_level).stubs().will(returnValue(-1));
    EXPECT_EQ(SET_LEVEL_ERR, SetDlogLevel(-1));
    GlobalMockObject::reset();
}

TEST_F(SlogdSetLogLevel, ConstructLevelStr)
{
    char *levelStr = (char *)malloc(LEVEL_ARR_LEN);
    if (levelStr == NULL) {
        printf("maloc failed.\n");
        return;
    }
    (void)memset(levelStr, 0, LEVEL_ARR_LEN);

    MOCKER(SlogdGetEventLevel).stubs().will(returnValue(2));
    MOCKER(SlogdGetGlobalLevel).stubs().will(returnValue(5));
    MOCKER(SlogdGetModuleLevel).stubs().will(returnValue(5));

    EXPECT_EQ(SUCCESS, ConstructLevelStr(levelStr, LEVEL_ARR_LEN));
    GlobalMockObject::reset();
    free(levelStr);
}

TEST_F(SlogdSetLogLevel, ConstructModuleStr)
{
    char *moduleStr = (char *)malloc(MODULE_ARR_LEN);
    if (moduleStr == NULL) {
        printf("maloc failed.\n");
        return;
    }
    (void)memset(moduleStr, 0, MODULE_ARR_LEN);

    EXPECT_EQ(SUCCESS, ConstructModuleStr(moduleStr, MODULE_ARR_LEN));
    GlobalMockObject::reset();
    free(moduleStr);
}

TEST_F(SlogdSetLogLevel, UpdateLevelToShMem)
{
    const char *pathTmp = "/usr/slog/";
    char workpath[256] = { 0 };
    strcpy(workpath, pathTmp);

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ConstructLevelStr).stubs().will(returnValue(LOG_RESERVED));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_ERROR));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_ERROR));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue((char *)workpath));
    MOCKER(ToolOpen).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue((char *)workpath));
    MOCKER(ToolOpen).stubs().will(returnValue(0));
    MOCKER(ToolChmod).stubs().will(returnValue(-1));
    MOCKER(ToolWrite).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue((char *)workpath));
    MOCKER(ToolOpen).stubs().will(returnValue(0));
    MOCKER(ToolChmod).stubs().will(returnValue(0));
    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, UpdateLevelToShMem());
    GlobalMockObject::reset();

    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED));
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue((char *)workpath));
    MOCKER(ToolOpen).stubs().will(returnValue(0));
    MOCKER(ToolChmod).stubs().will(returnValue(0));
    MOCKER(ToolWrite).stubs().will(returnValue(strlen(LEVEL_NOTIFY_FILE)));
    EXPECT_EQ(SYS_OK, UpdateLevelToShMem());
    GlobalMockObject::reset();
}
