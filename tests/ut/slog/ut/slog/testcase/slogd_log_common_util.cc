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

#include <string>
#include <stdlib.h>
#include <errno.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <limits.h>
#include <stdio.h>
#include <pwd.h>
#include "log_types.h"
#include "log_file_info.h"
#include "log_print.h"
#include "log_file_util.h"

extern "C" {
    #include "slogd_utest_stub.h"
    #include "log_config_api.h"
    #include "log_ring_buffer.h"
    #include "log_path_mgr.h"
    #include "dlog_level_mgr.h"
    #include "log_level_parse.h"

    #define LOG_FOR_SELF_MAX_FILE_LENGTH 8
    #define LOG_DIR_FOR_SELF_LENGTH (CFG_LOGAGENT_PATH_MAX_LENGTH + LOG_FOR_SELF_MAX_FILE_LENGTH)

    extern char g_configFilePath[SLOG_CONF_PATH_MAX_LENGTH];
    extern char g_rootLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1];
    extern char g_selfLogPath[LOG_DIR_FOR_SELF_LENGTH + 1];
    int StrcatDir(char *path, const char *filename, const char *dir, unsigned int maxlen);
    int DlogStrcatDir(char *path, const char *filename, const char *dir, unsigned int maxlen);
    int LogConfGetProcessPath(char *processDir, unsigned int len);
    void LogCheckPathPermission(const char *dirPath);
    int32_t GetValidPath(char *path, int32_t pathLen, char *validPath, int32_t validPathLen);
    int LogConfGetProcessFile(char *configPath, unsigned int len);
    int LogConfGetProcessPath(char *processDir, unsigned int len);
    int LogInitRootPath(void);
    int32_t LogReplaceDefaultByDir(const char *path, char *homeDir, uint32_t len);
}

class SlogdLogCommon : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdLogCommon::SetUp()
{
    memset_s(g_configFilePath, SLOG_CONF_PATH_MAX_LENGTH, 0, SLOG_CONF_PATH_MAX_LENGTH);
    memset_s(g_rootLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1, 0, CFG_LOGAGENT_PATH_MAX_LENGTH + 1);
    memset_s(g_selfLogPath, LOG_DIR_FOR_SELF_LENGTH + 1, 0, LOG_DIR_FOR_SELF_LENGTH + 1);
}

void SlogdLogCommon::TearDown()
{

}

TEST_F(SlogdLogCommon, GetUserGroupID4)
{
    unsigned int uid;
    unsigned int gid;
    struct passwd pwd;
    pwd.pw_uid = 1;
    pwd.pw_gid = 1;
    MOCKER(getpwuid).stubs().will(returnValue((struct passwd *)&pwd));
    EXPECT_EQ(SYS_OK, ToolGetUserGroupId(&uid, &gid));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogGetHomedir1)
{
    EXPECT_EQ(SYS_ERROR, LogGetHomeDir(NULL, 0));
}

TEST_F(SlogdLogCommon, LogGetHomedir2)
{
    char homedir[TOOL_MAX_PATH] = "";

    MOCKER(getpwuid).stubs().will(returnValue((struct  passwd*)NULL));
    MOCKER(strcpy_s).stubs().will(returnValue(-1));

    EXPECT_EQ(SYS_ERROR, LogGetHomeDir(homedir, TOOL_MAX_PATH));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogGetHomedir3)
{
    char homedir[TOOL_MAX_PATH] = "";
    struct  passwd pw;
    pw.pw_dir = (char*)malloc(TOOL_MAX_PATH);
    strcpy(pw.pw_dir, "/home");

    MOCKER(getpwuid).stubs().will(returnValue(&pw));

    EXPECT_EQ(SYS_OK, LogGetHomeDir(homedir, TOOL_MAX_PATH));
    XFREE(pw.pw_dir);
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogGetProcessPath1)
{
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessPath(NULL, 0));
}

TEST_F(SlogdLogCommon,  LogGetProcessPath2)
{
    char processDir[TOOL_MAX_PATH] = "\0";
    int len  = 256;
    EXPECT_EQ(SYS_OK, LogConfGetProcessPath(processDir, len));
}

TEST_F(SlogdLogCommon,  LogGetProcessPath3)
{
    char processDir[TOOL_MAX_PATH] = "\0";
    int len  = 256;
    MOCKER(readlink).stubs().will(returnValue(4097));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessPath(processDir, len));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogGetProcessPath4)
{
    char processDir[TOOL_MAX_PATH] = "\0";
    int len  = 256;
    MOCKER(readlink).stubs().will(returnValue(10));
    EXPECT_EQ(SYS_OK, LogConfGetProcessPath(processDir, len));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogGetProcessConfigPath_Failed)
{
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(NULL, 0));

    char processDir[TOOL_MAX_PATH] = "\0";
    uint32_t len  = 256;
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();

    MOCKER(LogConfGetProcessPath).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();

    MOCKER(LogConfGetProcessPath).stubs().will(returnValue(SYS_OK + 1));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();

    MOCKER(strncpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();

    MOCKER(LogStrlen).stubs().will(returnValue(1024U));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();

    MOCKER(strcat_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(SYS_ERROR, LogConfGetProcessFile(processDir, len));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogInitLogAgentPath0)
{
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS));
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(SYS_ERROR, LogInitRootPath());
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogInitLogAgentPath1)
{
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS));
    MOCKER(GetValidPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, LogInitRootPath());
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogInitLogAgentPath2)
{
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS));
    MOCKER(GetValidPath).stubs().will(returnValue(SYS_OK));
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogInitRootPath());
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogInitLogAgentPath3)
{
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS));
    MOCKER(GetValidPath).stubs().will(returnValue(SYS_OK));
    MOCKER(strncpy_s).stubs().will(returnValue(0));
    MOCKER(LogCheckPathPermission).stubs();
    EXPECT_EQ(SYS_OK, LogInitRootPath());
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  LogInitLogAgentPath4)
{
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS + 1));
    MOCKER(LogCheckPathPermission).stubs();
    EXPECT_EQ(SYS_OK, LogInitRootPath());
    GlobalMockObject::reset();
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS + 1));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogInitRootPath());
    GlobalMockObject::reset();
    MOCKER(LogConfListGetValue).stubs().will(returnValue(SUCCESS));
    MOCKER(GetValidPath).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, LogInitRootPath());
}

TEST_F(SlogdLogCommon,  StrcatDir0)
{
    EXPECT_EQ(SYS_ERROR, StrcatDir(NULL,NULL,NULL,4096));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  StrcatDir1)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 6;
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  StrcatDir2)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    MOCKER(strcpy_s).stubs().will(returnValue(1));
    MOCKER(memset_s).stubs().will(returnValue(1));
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  StrcatDir3)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    MOCKER(strcat_s).stubs().will(returnValue(1));
    EXPECT_EQ(SYS_ERROR, StrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  StrcatDir4)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    EXPECT_EQ(SYS_OK, StrcatDir(path, filename, dir, maxlen));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  DlogStrcatDir0)
{
    EXPECT_EQ(SYS_ERROR, DlogStrcatDir(NULL,NULL,NULL,4096));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  DlogStrcatDir1)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 6;
    EXPECT_EQ(SYS_ERROR, DlogStrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  DlogStrcatDir2)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    MOCKER(strcpy_s).stubs().will(returnValue(1));
    MOCKER(memset_s).stubs().will(returnValue(1));
    EXPECT_EQ(SYS_ERROR, DlogStrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  DlogStrcatDir3)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    MOCKER(strcat_s).stubs().will(returnValue(1));
    EXPECT_EQ(SYS_ERROR, DlogStrcatDir(path, filename, dir, maxlen));
    EXPECT_EQ(0, strlen(path));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon,  DlogStrcatDir4)
{
    char path[TOOL_MAX_PATH] = "\0";
    char filename[] = "/slog";
    char dir[] = "/usr/slog";
    unsigned int maxlen = 4096;
    EXPECT_EQ(SYS_OK, DlogStrcatDir(path, filename, dir, maxlen));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir1)
{
    EXPECT_EQ(SYS_ERROR, LogReplaceDefaultByDir(NULL, NULL, NULL));
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir2)
{
    char homedir[TOOL_MAX_PATH] = "";

    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogReplaceDefaultByDir("/ide_daemon", homedir, TOOL_MAX_PATH));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir3)
{
    char homedir[TOOL_MAX_PATH] = "";

    EXPECT_EQ(SYS_OK, LogReplaceDefaultByDir("/ide_daemon", homedir, TOOL_MAX_PATH));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir4)
{
    char homedir[TOOL_MAX_PATH] = "";

    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    MOCKER(LogGetHomeDir).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, LogReplaceDefaultByDir("~/ide_daemon", homedir, TOOL_MAX_PATH));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir5)
{
    char homedir[TOOL_MAX_PATH] = "";

    MOCKER(strcat_s).stubs().will(returnValue(-1));
    MOCKER(LogGetHomeDir).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, LogReplaceDefaultByDir("~/ide_daemon", homedir, TOOL_MAX_PATH));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir6)
{
    char homedir[TOOL_MAX_PATH] = "";

    MOCKER(LogGetHomeDir).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, LogReplaceDefaultByDir("~/ide_daemon", homedir, TOOL_MAX_PATH));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogReplaceWaveWithHomedir7)
{
    char homedir[TOOL_MAX_PATH] = "";
    int len = 1;
    MOCKER(LogGetHomeDir).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_ERROR, LogReplaceDefaultByDir("~/ide_daemon", homedir, len));

    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, GetLevelByModuleId1)
{
    EXPECT_EQ(true, DlogSetLogTypeLevelByModuleId(1, 1, DEBUG_LOG_MASK));
    EXPECT_EQ(1, DlogGetLogTypeLevelByModuleId(1, DEBUG_LOG_MASK));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, SetLevelByModuleId1)
{
    EXPECT_EQ(FALSE,  DlogSetLogTypeLevelByModuleId(-1, 1, DEBUG_LOG_MASK));
    EXPECT_EQ(TRUE,  DlogSetLogTypeLevelByModuleId(1, 1, DEBUG_LOG_MASK));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, GetModuleInfoByName1)
{
    EXPECT_EQ(NULL, GetModuleInfoByName(NULL));
    GetModuleInfoByName("SLOG");
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogMkdir)
{
    char dir[10] = {0};
    EXPECT_EQ(ARGV_NULL, LogMkdir(NULL));

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SUCCESS, LogMkdir(dir));
    GlobalMockObject::reset();

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ToolMkdir).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(MKDIR_FAILED, LogMkdir(dir));
    GlobalMockObject::reset();

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR));
    MOCKER(ToolMkdir).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolChownPath).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(FAILED, LogMkdir(dir));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogAgentChangeLogPathMode4)
{
    MOCKER(ToolGetUserGroupId).stubs().will(returnValue(0));
    MOCKER(ToolChown).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolChownPath("huawei"));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, LogAgentChangeLogFdMode4)
{
    MOCKER(ToolGetUserGroupId).stubs().will(returnValue(0));
    MOCKER(fchown).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolFChownPath(3));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, GetModuleNameById01)
{
    EXPECT_EQ(NULL, GetModuleNameById(INVLID_MOUDLE_ID + 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, GetLevelNameById01)
{
    EXPECT_EQ(NULL, GetLevelNameById(DLOG_EVENT + 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdLogCommon, GetLevelByModuleId01)
{
    EXPECT_EQ(DLOG_MODULE_DEFAULT_LEVEL, DlogGetLogTypeLevelByModuleId(INVLID_MOUDLE_ID + 1, DEBUG_LOG_MASK));
    GlobalMockObject::reset();
}