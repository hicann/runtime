/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/shm.h>
#include "slogd_group_log.h"
#include "slogd_syslog.h"
#include "log_file_util.h"

extern "C"
{
#include "log_config_api.h"
#include "log_to_file.h"
#include "log_common.h"
#include "log_level_parse.h"
#include "securec.h"

#include <syslog.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <malloc.h>
#include <unistd.h>
#include <share_mem.h>

bool IsBlank(char ch);
void LogConfTrimString(char *str);
LogRt LogConfOpenFile(FILE **fp, const char *file);
LogRt LogConfListInsert(const char *confName, unsigned int nameLen, const char *confValue, unsigned int valueLen);
LogRt LogConfParseName(const char *lineBuf, char *confName, unsigned int nameLen, char **pos);
STATIC LogRt LogConfParseLine(const char *lineBuf, char *confName, unsigned int nameLen,
                     char *confValue, unsigned int valueLen);
int LogConfGetProcessFile(char *configPath, unsigned int len);
int LogSetConfigPathToShm(const char *configPath);
ShmErr ShMemOpen(int *shmId);
ShmErr ShMemCreat(int *shmId, toolMode perm);
int IsConfigShmExist();
ShmErr ShMemWrite(int shmId, const char *value, unsigned int len, unsigned int offset);
ShmErr ShMemRead(int shmId, char *value, size_t len, size_t offset);
void SlogdShmExit(void);
int InitShm(void);
extern bool IsBlankline(char ch);
extern int fseek(FILE* Stream, long _Offset, int _Origin);
extern int GetGroupIdByModuleId(int moduleId);
extern bool LogConfGroupGetSwitch(void);
extern char *LogConfRealPath(const char *file, const char *homeDir, size_t dirLen);
int32_t LogReplaceDefaultByDir(const char *path, char *homeDir, uint32_t len);
};

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define LLT_SLOG_DIR "llt/abl/slog"

using namespace std;
using namespace testing;

class CFG_PARSE_TEST : public testing::Test
{
    protected:
        static void SetupTestCase()
        {
            cout << "CFG_PARSE_TEST SetUP" <<endl;
        }
        static void TearDownTestCase()
        {
            cout << "CFG_PARSE_TEST TearDown" << endl;
        }
        virtual void SetUP()
        {
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            cout << "a test TearDown" << endl;
            GlobalMockObject::reset();
        }
};

TEST_F(CFG_PARSE_TEST, IsBlankline)
{
    EXPECT_EQ(true, IsBlankline('#'));
    EXPECT_EQ(false, IsBlankline('a'));
}

TEST_F(CFG_PARSE_TEST, IsBlank)
{
    EXPECT_EQ(true, IsBlank(' '));
    EXPECT_EQ(false, IsBlank('a'));
}

TEST_F(CFG_PARSE_TEST, LogConfCheckPath)
{
    EXPECT_EQ(false, LogConfCheckPath(NULL, 0));
}

TEST_F(CFG_PARSE_TEST, IsPathValidByConfig1)
{
    const char *ppath  = "/var/dlog/slog.conf";
    unsigned int len = strlen(ppath);

    EXPECT_EQ(true, LogConfCheckPath(ppath, len));
}

TEST_F(CFG_PARSE_TEST, IsPathValidByConfig2)
{
    const char *ppath  = "/var/dlog/slog.donf";
    unsigned int len = strlen(ppath);

    EXPECT_EQ(false, LogConfCheckPath(ppath, len));
}

TEST_F(CFG_PARSE_TEST, LogConfOpenFile)
{
    FILE *fp = NULL;
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));

    EXPECT_EQ(MALLOC_FAILED, LogConfOpenFile(&fp, NULL));
    GlobalMockObject::reset();

    char* file = "/" LLT_SLOG_DIR "/ut/slog.conf";
    MOCKER(LogReplaceDefaultByDir).stubs().will(returnValue(SYS_OK + 1));
    EXPECT_EQ(CFG_FILE_INVALID, LogConfOpenFile(&fp, file));
    GlobalMockObject::reset();

    file = LLT_SLOG_DIR "/ut/slog.conf";
    MOCKER(fopen).stubs().will(returnValue((FILE*)NULL));
    EXPECT_EQ(OPEN_FILE_FAILED, LogConfOpenFile(&fp,file));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, InitCfgSlogdSUCCESS)
{
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SYS_OK, LogConfInit());
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, InitCfgSlogdERROR1)
{
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(SYS_ERROR, LogConfInit());
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, InitCfgSlogdERROR2)
{
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK + 1));
    MOCKER(LogConfGetProcessFile).stubs().will(returnValue(SYS_ERROR));
    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SYS_OK, LogConfInit());
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, InitCfgSlogdSuccess)
{
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK + 1));
    MOCKER(LogConfGetProcessFile).stubs().will(returnValue(SYS_OK));
    MOCKER(LogSetConfigPathToShm).stubs().will(returnValue(SYS_OK));
    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SYS_OK, LogConfInit());
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, LogSetConfigPathToShmERROR0)
{
    EXPECT_EQ(SYS_ERROR, LogSetConfigPathToShm(NULL));

    char config[4096] = { 0 };
    EXPECT_EQ(SYS_ERROR, LogSetConfigPathToShm(config));
}

TEST_F(CFG_PARSE_TEST, LogSetConfigPathToShmERROR3)
{
    char config[4096] = "/llt/common/Config";
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_ERROR)); // SHM_ERROR
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED)); // SHM_SUCCEED
    EXPECT_EQ(SYS_ERROR, LogSetConfigPathToShm(config));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, LogSetConfigPathToShmERROR4)
{
    char config[4096] = "/llt/common/Config";
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED)); // SHM_OK
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_ERROR)); // SHM_SUCCEED
    EXPECT_EQ(SYS_ERROR, LogSetConfigPathToShm(config));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, LogSetConfigPathToShmOK)
{
    char config[4096] = "/llt/common/Config";
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_SUCCEED)); // SHM_OK
    MOCKER(ShMemWrite).stubs().will(returnValue(SHM_SUCCEED)); // SHM_OK
    EXPECT_EQ(SYS_OK, LogSetConfigPathToShm(config));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, IsConfigShmExist)
{
    MOCKER(ShMemOpen).stubs().will(returnValue(SHM_ERROR)); // SHM_ERROR
    EXPECT_EQ(SYS_ERROR, IsConfigShmExist());
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, LogConfRealPath)
{
    EXPECT_EQ(nullptr, LogConfRealPath("hi", nullptr, 0));
}

TEST_F(CFG_PARSE_TEST, realPathCheck1)
{
    char val[TOOL_MAX_PATH + 1] = "";
    EXPECT_EQ(NULL, LogConfRealPath("hi", val, TOOL_MAX_PATH + 2));
}

TEST_F(CFG_PARSE_TEST, TrimString0)
{
    char *str = "";
    LogConfTrimString(str);
    EXPECT_EQ("", str);
}

TEST_F(CFG_PARSE_TEST, TrimString1)
{
    char *str = "test1  asd\0";
    char buff[CONF_VALUE_MAX_LEN + 1] = "\0";
    strcpy_s(buff, CONF_VALUE_MAX_LEN, str);
    LogConfTrimString(&buff[0]);
    EXPECT_EQ(0, strcmp(buff, str));
}

TEST_F(CFG_PARSE_TEST, TrimString2)
{
    char *str = "test2\t  asd\0";
    char buff[CONF_VALUE_MAX_LEN + 1] = "\0";
    strcpy_s(buff, CONF_VALUE_MAX_LEN, str);
    LogConfTrimString(&buff[0]);
    EXPECT_EQ(0, strcmp(buff, "test2"));
}

TEST_F(CFG_PARSE_TEST, TrimString3)
{
    char *str = "test3#  asd";
    char buff[CONF_VALUE_MAX_LEN + 1] = "\0";
    strcpy_s(buff, CONF_VALUE_MAX_LEN, str);
    LogConfTrimString(&buff[0]);
    EXPECT_EQ(0, strcmp(buff, "test3"));
}

TEST_F(CFG_PARSE_TEST, TrimString4)
{
    char *str = "test4   # asd";
    char buff[CONF_VALUE_MAX_LEN + 1] = "\0";
    strcpy_s(buff, CONF_VALUE_MAX_LEN, str);
    LogConfTrimString(&buff[0]);
    EXPECT_EQ(0, strcmp(buff, "test4"));
}

TEST_F(CFG_PARSE_TEST, LogStrCheckNaturalNum)
{
    EXPECT_EQ(false,LogStrCheckNaturalNum(NULL));
    EXPECT_EQ(false,LogStrCheckNaturalNum(""));
    EXPECT_EQ(false,LogStrCheckNaturalNum("00"));
    EXPECT_EQ(false,LogStrCheckNaturalNum(" "));
    EXPECT_EQ(false,LogStrCheckNaturalNum("AA"));
    EXPECT_EQ(true,LogStrCheckNaturalNum("11"));
    EXPECT_EQ(true,LogStrCheckNaturalNum("0"));
    EXPECT_EQ(true,LogStrCheckNaturalNum("2147483647"));
    EXPECT_EQ(false,LogStrCheckNaturalNum("2147483648"));
    EXPECT_EQ(false,LogStrCheckNaturalNum("34343429496729"));
}

TEST_F(CFG_PARSE_TEST, InsertConfList00)
{
    EXPECT_EQ(SUCCESS, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    EXPECT_EQ(SUCCESS, LogConfListInsert("DLOG", strlen("DLOG") + 1, "1", strlen("1") + 1));
    LogConfListFree();
}

TEST_F(CFG_PARSE_TEST, InsertConfList01)
{
    EXPECT_EQ(ARGV_NULL, LogConfListInsert(NULL, 1, "1", strlen("1") + 1));

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(MALLOC_FAILED, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    GlobalMockObject::reset();

    MOCKER(strcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(STR_COPY_FAILED, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    GlobalMockObject::reset();

    EXPECT_EQ(SUCCESS, LogConfListInsert("DLOG", strlen("DLOG") + 1, "1", strlen("1") + 1));

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(MALLOC_FAILED, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    GlobalMockObject::reset();

    MOCKER(strcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(STR_COPY_FAILED, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    GlobalMockObject::reset();

    LogConfListFree();
}

TEST_F(CFG_PARSE_TEST, GetConfValueByList00)
{
    char value[CONF_VALUE_MAX_LEN + 1] = { 0 };
    EXPECT_EQ(SUCCESS, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    EXPECT_EQ(SUCCESS, LogConfListInsert("DLOG", strlen("DLOG") + 1, "1", strlen("1") + 1));
    EXPECT_EQ(CONF_VALUE_NULL, LogConfListGetValue("DS", strlen("DS") + 1, value, CONF_VALUE_MAX_LEN));
    EXPECT_EQ(SUCCESS, LogConfListGetValue("IDE", strlen("IDE") + 1, value, CONF_VALUE_MAX_LEN));
    LogConfListFree();
}

TEST_F(CFG_PARSE_TEST, GetConfValueByList01)
{
    char value[CONF_VALUE_MAX_LEN + 1] = { 0 };
    EXPECT_EQ(ARGV_NULL, LogConfListGetValue("IDE", strlen("IDE") + 1, value, CONF_VALUE_MAX_LEN + 1));
    EXPECT_EQ(SUCCESS, LogConfListInsert("IDE", strlen("IDE") + 1, "1", strlen("1") + 1));
    EXPECT_EQ(SUCCESS, LogConfListInsert("DLOG", strlen("DLOG") + 1, "1", strlen("1") + 1));
    MOCKER(strcpy_s).stubs().will(returnValue(SYS_OK + 1));
    EXPECT_EQ(STR_COPY_FAILED, LogConfListGetValue("IDE", strlen("IDE") + 1, value, CONF_VALUE_MAX_LEN));
    LogConfListFree();
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, ParseConfigBufHelper00)
{
    EXPECT_EQ(ARGV_NULL, LogConfParseName(NULL, NULL, 0, NULL));

    char* pos = NULL;
    char key[CONF_NAME_MAX_LEN + 1] = { 0 };
    char* line_buffer = "socket_port\r\n";
    EXPECT_EQ(LINE_NO_SYMBLE, LogConfParseName(line_buffer, key, CONF_NAME_MAX_LEN, &pos));
    GlobalMockObject::reset();

    line_buffer = " =1\r\n";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseName(line_buffer, key, CONF_NAME_MAX_LEN, &pos));
    GlobalMockObject::reset();

    line_buffer = "socket_port = 1\r\n";
    EXPECT_EQ(SUCCESS, LogConfParseName(line_buffer, key, CONF_NAME_MAX_LEN, &pos));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, ParseConfigBuf00)
{
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(NULL, NULL, 0, NULL, 0));

    char key[CONF_NAME_MAX_LEN + 1] = { 0 };
    char value[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char* line_buffer = "socket_port\r\n";
    MOCKER(LogConfParseName).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();

    line_buffer = "socket_port = 10\r\n";
    EXPECT_EQ(SUCCESS, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));

    line_buffer = "socket_port=10\r\n";
    EXPECT_EQ(SUCCESS, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));

    line_buffer = "socket_port=10 #aaa\r\n";
    EXPECT_EQ(SUCCESS, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();

    line_buffer = "enableEvent";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));

    line_buffer = "enableEvent=";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));

    line_buffer = "enableEvent= \t";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));

    line_buffer = "enableEvent= \r\n";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();

    line_buffer = "SLOG= # Slog\r\n";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();

    line_buffer = "socket_port =\r\n";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();

    line_buffer = "socket_port = #socker port\r\n";
    EXPECT_EQ(CONF_VALUE_NULL, LogConfParseLine(line_buffer, key, CONF_NAME_MAX_LEN, value, CONF_VALUE_MAX_LEN));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, UpdateConfList00)
{
    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(SUCCESS + 1, LogConfListUpdate("filename"));
    GlobalMockObject::reset();

    MOCKER(LogConfListInit).stubs().will(returnValue(SUCCESS));
    EXPECT_EQ(SUCCESS, LogConfListUpdate("filename"));
    GlobalMockObject::reset();
}

TEST_F(CFG_PARSE_TEST, InitShm)
{
    MOCKER(IsConfigShmExist).stubs().will(returnValue(SYS_OK));
    MOCKER(ShMemCreat).stubs().will(returnValue(SHM_SUCCEED));
    EXPECT_EQ(SYS_OK, InitShm());
    GlobalMockObject::reset();

    MOCKER(IsConfigShmExist).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ShMemCreat).stubs().will(returnValue(SHM_ERROR)); // SHM_ERROR
    EXPECT_EQ(SYS_ERROR, InitShm());
    GlobalMockObject::reset();

    MOCKER(IsConfigShmExist).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ShMemCreat).stubs().will(returnValue(SHM_SUCCEED));
    EXPECT_EQ(SYS_OK, InitShm());
    MOCKER(shmget).stubs().will(returnValue(0));
    ShMemRemove();
    GlobalMockObject::reset();
}
