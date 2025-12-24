/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <signal.h>
#include <execinfo.h>
#include "slogd_config_mgr.h"
#include "slogd_communication.h"
#include "slogd_appnum_watch.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_firmware_log.h"
#include "slogd_collect_log.h"
#include "slogd_recv_msg.h"

extern "C"
{
    #include "slogd_utest_stub.h"
    #include "start_single_process.h"
    #include "log_config_api.h"
    #include "log_path_mgr.h"
    #include <getopt.h>

    int InitShm(void);
}

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define LOG_W(format, ...) do {} while (0);
using namespace std;
using namespace testing;

class SLOGD_MAIN_UTEST : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SLOGD_MAIN_UTEST::SetUp()
{
}

void SLOGD_MAIN_UTEST::TearDown()
{
}

extern char *optarg;
extern int optind, opterr, optopt;

void ProcSyslogdStub(){}
INT32 mmGetOptStub(INT32 argc, char * const * argv, const char *opts)
{
    optarg = NULL;
    return (INT32)'l';
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_negativeVf)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-v", "-1"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(-1, opt.v);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_ExceedVf)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-v", "64"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(-1, opt.v);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_NotNatural)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-v", "n2"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(-1, opt.v);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_approve_Level)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-l", "2"};
    int32_t mockRet_1 = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet_1)).then(returnValue(-1));
    EXPECT_EQ(SYS_OK, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(2, opt.l);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_LevelNegative)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-l", "-1"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(0, opt.l);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_LevelExceed)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-l", "5"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(0, opt.l);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_reject_LevelNotNatural)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 3;
    char *argv[3] = {"./slogd", "-l", "n2"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(0, opt.l);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_approve_docker)
{
    optind = 1;
    int32_t argc = 2;
    char *argv[2] = { "./slogd", "-d"};

    struct SlogdOptions opt = { 0, 0, -1, false};
    EXPECT_EQ(SYS_OK, ParseSlogdArgv(argc, argv, &opt));
    EXPECT_EQ(true, opt.d);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_MAIN_UTEST, parseSlogdArgv_help)
{
    const char *optstring = "nhl:v:";
    const struct option long_options[] = {
        {"vfid", required_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };

    optind = 1;
    int32_t argc = 2;
    char *argv[2] = {"./slogd", "-h"};
    int32_t mockRet = getopt_long(argc, (char **)argv, optstring, long_options, NULL);

    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(getopt_long).stubs().will(returnValue(mockRet)).then(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ParseSlogdArgv(argc, argv, &opt));
    GlobalMockObject::reset();
}
