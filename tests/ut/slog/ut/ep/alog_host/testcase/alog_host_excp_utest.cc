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
#include "plog_file_mgr.h"
#include "dlog_level_mgr.h"
using namespace std;
using namespace testing;

#include <dlfcn.h>
#include <fcntl.h>
#include <unistd.h>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include "slog.h"
#include "plog.h"
#include "acl_log.h"
#include "alog_pub.h"
#include "slog_api.h"
#include "plog_drv.h"
#include "plog_core.h"
#include "self_log_stub.h"
#include "ascend_hal_stub.h"
#include "dlog_console.h"
#include "dlog_attr.h"
#include "plog_stub.h"
#include "log_file_util.h"

extern "C" {
void DlogFree(void);
void DlogInit(void);

void DlogInitServerType(void);
}

class EP_ALOG_HOST_EXCP_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        MOCKER(dlopen).stubs().will(invoke(logDlopen));
        MOCKER(dlclose).stubs().will(invoke(logDlclose));
        MOCKER(dlsym).stubs().will(invoke(logDlsym));

        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test suite");
    }

public:
    void DlogConstructor()
    {
        DlogInit();
        (void)ProcessLogInit();
    }

    void DlogDestructor()
    {
        (void)ProcessLogFree();
        DlogFree();
    }
    bool DlogCheckPrint() {}
    bool DlogCheckPrintNum() {}
    bool DlogCheckFileValue() {}
};

// init host file list failed(malloc failed)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogFileMgrInitHostFailed)
{
    void* space = malloc(TOOL_MAX_PATH + 1);
    MOCKER(LogMalloc).stubs().will(repeat(space, 4)).then(returnValue((void*)NULL));
    MOCKER(LogFree).expects(exactly(4));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    EXPECT_EQ(LOG_FAILURE, PlogFileMgrInit());
    EXPECT_EQ(4, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("malloc filename array failed"));
    EXPECT_EQ(1, CheckErrLog("init host file list failed"));
    free(space);
    space = NULL;
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    PlogFileMgrExit();
}

// init host file list failed(no permission)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogFileMgrInitHostFailedNoPemission)
{
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(-1));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    EXPECT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(1, CheckErrLog("get valid path failed"));
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    PlogFileMgrExit();
    GlobalMockObject::verify();
    ResetErrLog();

    char path[256] = {0};
    (void)sprintf_s(path, 256, "%s/log", PATH_ROOT);
    setenv("ASCEND_PROCESS_LOG_PATH", path, 1);
    EXPECT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrExit();
    EXPECT_EQ(0, GetErrLogNum());
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    GlobalMockObject::verify();
}

// device日志回传落盘session异常关闭
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogPrint_DeviceLogSessionClose)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    int32_t devId = 0;
    MOCKER(DrvBufRead).stubs().will(invoke(DrvBufReadSessionClose));
    EXPECT_EQ(SYS_OK, DlogReportStart(devId, 0));
    MOCKER(drvHdcSessionConnect).stubs().will(invoke(drvHdcSessionConnectClose));
    DlogReportStop(devId);
    DlogDestructor();
    EXPECT_LE(1, CheckErrLog("create session failed, drvErr=34"));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// plog初始化 hdc服务失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInit_CreateHdcClientFailed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    MOCKER(drvHdcClientCreate).stubs().will(invoke(drvHdcClientCreate_failed));
    DlogConstructor();

    DlogDestructor();
    EXPECT_LE(1, CheckErrLog("create hdc client failed."));
    EXPECT_EQ(0, CheckErrLog("pthread(alogFlush) join failed"));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// plog获取platform失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInit_GetPaltformFailed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    MOCKER(DrvGetPlatformInfo).stubs().will(returnValue(-1)); // can not mocker drvGetPlatformInfo because of g_platform
    EXPECT_EQ(-1, DlogReportInitialize());

    EXPECT_EQ(0, DlogReportFinalize());
    EXPECT_EQ(1, CheckErrLog("get platform info failed."));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// 日志级别控制
// 接口入参异常
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_setlevel_ByIntf)
{
    // 初始化级别
    int32_t enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // moduleId非法
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(INVLID_MOUDLE_ID + 1, DLOG_ERROR, 0));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(INVLID_MOUDLE_ID + 1, &enableEvent));

    // level非法
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, -1, 0));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, LOG_INVALID_LEVEL + 1, 0));

    // 恢复级别至初始化
    EXPECT_EQ(SYS_OK, dlog_setlevel(ALL_MODULE, DLOG_ERROR, 1));
}

// buffer申请失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, plog_buffer_init_failed)
{
    MOCKER(DrvBufRead).stubs().will(invoke(DrvBufReadSessionClose));
    // 初始化级别
    int32_t enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // moduleId非法
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(INVLID_MOUDLE_ID + 1, DLOG_ERROR, 0));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(INVLID_MOUDLE_ID + 1, &enableEvent));

    // level非法
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, -1, 0));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, LOG_INVALID_LEVEL + 1, 0));

    // 恢复级别至初始化
    EXPECT_EQ(SYS_OK, dlog_setlevel(ALL_MODULE, DLOG_ERROR, 1));
}

// getenv ASCEND_SLOG_PRINT_TO_STDOUT only once
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    bool ret = DlogCheckEnvStdout();
    EXPECT_EQ(false, ret);

    ret = DlogCheckEnvStdout();
    EXPECT_EQ(false, ret);
}

// ---------------------------------------------------------------------------
// issue #768: ASCEND_SLOG_PRINT_TO_STDOUT 改名为 ASCEND_LOG_PRINT_TO_STDOUT
// DlogCheckEnvStdout 使用 static 缓存，仅首次求值，因此每个分支必须在独立进程
// (threadsafe death test 会重新 exec 测试二进制) 中验证，避免缓存跨用例污染。
// ---------------------------------------------------------------------------

// 自维测日志 (SELF_LOG_INFO/WARN) 在 UT 下经 self_log_stub 落到 PATH_ROOT/LogFile.txt
static bool Issue768SelfLogHas(const char* substr)
{
    char cmd[600] = {0};
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "grep -a -q \"%s\" %s/LogFile.txt", substr, PATH_ROOT);
    return system(cmd) == 0;
}

// 白盒分支：校验返回值 + 各维测日志（废弃告警 / 开启 INFO / 非法值 WARN）是否符合预期。
// 返回 0 表示全部符合，非 0 表示某项不符（便于死亡测试退出码定位）。
// invalidSubstr：期望出现的非法值告警子串（新旧变量合法值域不同，告警文案不同）；nullptr 表示不应出现非法值告警。
static int Issue768ScenarioCheckStdout(
    const char* newVal, const char* oldVal, bool expectEnabled, bool expectDeprecatedWarn, bool expectEnableInfo,
    const char* invalidSubstr)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    if (newVal != nullptr) {
        setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    }
    if (oldVal != nullptr) {
        setenv("ASCEND_SLOG_PRINT_TO_STDOUT", oldVal, 1);
    }
    bool enabled = DlogCheckEnvStdout();
    if (enabled != expectEnabled) {
        return 1;
    }
    // 废弃告警：仅在回退旧变量时出现
    if (Issue768SelfLogHas("'ASCEND_SLOG_PRINT_TO_STDOUT' is deprecated") != expectDeprecatedWarn) {
        return 2;
    }
    // 开启 INFO：生效时精确断言变量名+取值回显；未生效时断言无任何开启 INFO
    if (expectEnableInfo) {
        char expectInfo[256] = {0};
        const char* effVar = (newVal != nullptr) ? "ASCEND_LOG_PRINT_TO_STDOUT" : "ASCEND_SLOG_PRINT_TO_STDOUT";
        const char* effVal = (newVal != nullptr) ? newVal : oldVal;
        (void)snprintf_s(
            expectInfo, sizeof(expectInfo), sizeof(expectInfo) - 1U,
            "Log-to-stdout enabled by environment variable '%s' (value: %s)", effVar, effVal);
        if (!Issue768SelfLogHas(expectInfo)) {
            return 3;
        }
    } else if (Issue768SelfLogHas("Log-to-stdout enabled by environment variable")) {
        return 3;
    }
    // 非法值 WARN
    if (invalidSubstr != nullptr) {
        if (!Issue768SelfLogHas(invalidSubstr)) {
            return 4;
        }
    } else if (Issue768SelfLogHas("Log-to-stdout disabled")) {
        return 4;
    }
    return 0;
}

// 长值分支：取值长度 >= STDOUT_ENV_VALUE_LEN 时 mmGetEnv 返回 EN_INVALID_PARAM，
// 走"不回显取值"的非法值告警分支（区别于回显取值的 else 分支）。
// 校验：关闭打屏 + 该告警出现 + 过长取值未被回显。
static int Issue768ScenarioCheckStdoutLongValue(const char* envName, const char* longVal)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    setenv(envName, longVal, 1);
    if (DlogCheckEnvStdout() != false) {
        return 1;
    }
    // 不回显取值的非法值告警："Invalid value for environment variable '<name>'; expected ..."
    if (!Issue768SelfLogHas("Invalid value for environment variable")) {
        return 2;
    }
    // 缓冲区未取到值，过长取值不得出现在告警中
    if (Issue768SelfLogHas(longVal)) {
        return 3;
    }
    return 0;
}

// 二进制端到端：通过 dlog 打印接口，校验打屏与落盘两个维度的行为。
// issue #1307 行为变更仅在新变量上生效：新变量开启（=1/2/3）时打屏+同步落盘；
// 旧变量=1 为兼容档（只打屏、不落盘，#1307 前的旧行为）；关闭/未配置时不打屏、默认落盘。
// expectStdout 同时驱动打屏断言与兼容档判定；返回 0 符合预期，1/2/3 为断言失败定位码。
// stdout 捕获工具定义位于 issue #1307 区块，此处前置声明复用
static void Issue1307RedirectStdout(const char* captureFile);
static bool Issue1307FileHas(const char* file, const char* substr);

static int Issue768RunStdoutE2eScenario(const char* newVal, const char* oldVal, bool expectStdout)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    if (newVal != nullptr) {
        setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    }
    if (oldVal != nullptr) {
        setenv("ASCEND_SLOG_PRINT_TO_STDOUT", oldVal, 1);
    }
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    const char* capture = PATH_ROOT "/stdout_capture.txt";
    Issue1307RedirectStdout(capture);
    DlogInit();
    (void)ProcessLogInit();
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_EXCP_UTEST][issue768] e2e stdout switch test.");
    (void)ProcessLogFree();
    DlogFree();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    (void)fflush(stdout);
    // 打屏断言：expectStdout 决定日志 marker 是否出现在 stdout 捕获中
    if (Issue1307FileHas(capture, "e2e stdout switch test") != expectStdout) {
        return 1;
    }
    bool diskExists = (access(PATH_ROOT "/debug", F_OK) == 0);
    bool legacy = expectStdout && (newVal == nullptr) && (oldVal != nullptr) && (strcmp(oldVal, "1") == 0);
    if (legacy) {
        return diskExists ? 2 : 0; // 旧变量=1 兼容档：只打屏，不落盘
    }
    return diskExists ? 0 : 3;     // 新变量开启（打屏+落盘）或关闭（默认落盘）
}

// 参数：(new, old, expectEnabled, expectDeprecatedWarn, expectEnableInfo, invalidSubstr)
// TC-768-001 新变量=1 开启：开启 INFO，无废弃/无非法
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_on)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("1", nullptr, true, false, true, nullptr)), testing::ExitedWithCode(0),
        "");
}

// TC-768-002 新变量=0 显式关闭：静默（无任何维测日志）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_off_silent)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("0", nullptr, false, false, false, nullptr)), testing::ExitedWithCode(0),
        "");
}

// TC-768-003 仅旧变量=1，兼容档开启（STDOUT_LEVEL_LEGACY）：废弃 WARN + 开启 INFO
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_old_env_compat)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(nullptr, "1", true, true, true, nullptr)), testing::ExitedWithCode(0),
        "");
}

// TC-768-004 新变量=0 且旧变量=1，新变量优先关闭（不回退旧变量、无废弃告警、无开启 INFO）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_priority)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("0", "1", false, false, false, nullptr)), testing::ExitedWithCode(0), "");
}

// TC-768-005 两变量均未配置，默认关闭：静默
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_default_off)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(nullptr, nullptr, false, false, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-768-006 新变量为非法值，关闭：新合法值域告警（0/1/2/3），无废弃/无开启 INFO
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_invalid)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(
            "abc", nullptr, false, false, false, "expected '0', '1', '2' or '3'. Log-to-stdout disabled")),
        testing::ExitedWithCode(0), "");
}

// TC-768-007 旧变量为非法值（新变量未设）：废弃 WARN + 旧合法值域告警（0/1），关闭
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_old_env_invalid)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(
            nullptr, "xyz", false, true, false, "expected '0' or '1'. Log-to-stdout disabled")),
        testing::ExitedWithCode(0), "");
}

// TC-768-008 新变量取值过长（16 字符 >= STDOUT_ENV_VALUE_LEN）：
// mmGetEnv 返回 EN_INVALID_PARAM，走不回显取值的非法值告警分支，关闭打屏
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_value_too_long)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdoutLongValue("ASCEND_LOG_PRINT_TO_STDOUT", "1111111111111111")),
        testing::ExitedWithCode(0), "");
}

// TC-768-009 旧变量取值过长（新变量未设）：回退旧变量后同样走不回显取值的非法值告警分支
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_old_env_value_too_long)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdoutLongValue("ASCEND_SLOG_PRINT_TO_STDOUT", "1111111111111111")),
        testing::ExitedWithCode(0), "");
}

// TC-768-101 新变量=1，日志打屏并同步落盘（#1307 新行为）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_new_env_stdout)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue768RunStdoutE2eScenario("1", nullptr, true)), testing::ExitedWithCode(0), "");
}

// TC-768-102 仅旧变量=1，兼容档只打屏（不落盘，#1307 前旧行为）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_old_env_compat_stdout)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue768RunStdoutE2eScenario(nullptr, "1", true)), testing::ExitedWithCode(0), "");
}

// TC-768-103 两变量均未配置，日志默认落盘（不打屏）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_default_to_file)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue768RunStdoutE2eScenario(nullptr, nullptr, false)), testing::ExitedWithCode(0), "");
}

// TC-768-104 新变量=0 且旧变量=1，新变量优先，日志落盘（不打屏）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_new_env_priority_to_file)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue768RunStdoutE2eScenario("0", "1", false)), testing::ExitedWithCode(0), "");
}

// ---------------------------------------------------------------------------
// issue #1307: ASCEND_LOG_PRINT_TO_STDOUT 新增取值 2/3（按级别阈值打屏），
// 且打屏开启时同步落盘一份；旧变量 ASCEND_SLOG_PRINT_TO_STDOUT 不适配此特性：
// =1 走兼容档（只打屏、不落盘），2/3 为非法值。DlogGetEnvStdoutLevel 返回：
// -1 关闭；DLOG_DEBUG 无阈值(新变量=1)；DLOG_WARN(=2)；DLOG_ERROR(=3)；
// STDOUT_LEVEL_LEGACY 旧变量=1 兼容档。static 缓存仅首次求值，沿用独立进程（death test）验证。
// ---------------------------------------------------------------------------

// 白盒分支：校验 DlogGetEnvStdoutLevel 返回值 + 各维测日志。返回 0 表示全部符合。
// invalidSubstr：期望出现的非法值告警子串（新旧变量合法值域不同，告警文案不同）；nullptr 表示不应出现非法值告警。
// globalEnv（issue #1519）：额外配置的 ASCEND_GLOBAL_LOG_LEVEL 取值；nullptr 表示确保未配置。
// 预期语义（#1519）：阈值档（2/3）时打屏阈值与全局级别取最大值；=1/未配置/非法全局值不参与组合。
static int Issue1307ScenarioCheckLevel(
    const char* newVal, const char* oldVal, int32_t expectLevel, bool expectEnableInfo, const char* invalidSubstr,
    bool expectDeprecatedWarn, const char* globalEnv)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    if (newVal != nullptr) {
        setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    }
    if (oldVal != nullptr) {
        setenv("ASCEND_SLOG_PRINT_TO_STDOUT", oldVal, 1);
    }
    if (globalEnv != nullptr) {
        setenv("ASCEND_GLOBAL_LOG_LEVEL", globalEnv, 1);
    }
    if (DlogGetEnvStdoutLevel() != expectLevel) {
        return 1;
    }
    // 开启 INFO：生效时精确断言变量名+取值回显；未生效时断言无任何开启 INFO
    if (expectEnableInfo) {
        char expectInfo[256] = {0};
        const char* effVar = (newVal != nullptr) ? "ASCEND_LOG_PRINT_TO_STDOUT" : "ASCEND_SLOG_PRINT_TO_STDOUT";
        const char* effVal = (newVal != nullptr) ? newVal : oldVal;
        (void)snprintf_s(
            expectInfo, sizeof(expectInfo), sizeof(expectInfo) - 1U,
            "Log-to-stdout enabled by environment variable '%s' (value: %s)", effVar, effVal);
        if (!Issue768SelfLogHas(expectInfo)) {
            return 2;
        }
    } else if (Issue768SelfLogHas("Log-to-stdout enabled by environment variable")) {
        return 2;
    }
    if (invalidSubstr != nullptr) {
        if (!Issue768SelfLogHas(invalidSubstr)) {
            return 3;
        }
    } else if (Issue768SelfLogHas("Log-to-stdout disabled")) {
        return 3;
    }
    if (Issue768SelfLogHas("'ASCEND_SLOG_PRINT_TO_STDOUT' is deprecated") != expectDeprecatedWarn) {
        return 4;
    }
    return 0;
}

// 将 stdout 重定向到捕获文件，供打屏内容断言。
static void Issue1307RedirectStdout(const char* captureFile)
{
    int32_t fd = open(captureFile, O_RDWR | O_CREAT | O_TRUNC, 0600);
    if (fd < 0) {
        std::exit(10);
    }
    if (dup2(fd, STDOUT_FILENO) < 0) {
        std::exit(11);
    }
    (void)close(fd);
}

static bool Issue1307FileHas(const char* file, const char* substr)
{
    char cmd[600] = {0};
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "grep -a -q \"%s\" %s", substr, file);
    return system(cmd) == 0;
}

static bool Issue1307DirHas(const char* dir, const char* substr)
{
    char cmd[600] = {0};
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "grep -a -r -q \"%s\" %s", substr, dir);
    return system(cmd) == 0;
}

// 统计文件中包含指定子串的行数（grep -c），供磁盘满场景的限频断言使用。
static int Issue1307FileCount(const char* file, const char* substr)
{
    char cmd[600] = {0};
    (void)snprintf_s(cmd, sizeof(cmd), sizeof(cmd) - 1U, "grep -a -c \"%s\" %s", substr, file);
    FILE* fp = popen(cmd, "r");
    if (fp == NULL) {
        return -1;
    }
    char line[32] = {0};
    (void)fgets(line, sizeof(line), fp);
    (void)pclose(fp);
    return atoi(line);
}

// E2E：按 bit0=DEBUG, bit1=INFO, bit2=WARN, bit3=ERROR 校验打屏内容（阈值过滤）
// 与 PATH_ROOT/debug 落盘内容（级别门）。返回 0 符合预期。
// 预期语义：打屏级别 = max(ASCEND_GLOBAL_LOG_LEVEL 级别门, 打屏阈值)。
static int Issue1307RunStdoutThresholdScenario(
    const char* newVal, const char* oldVal, const char* globalLevel, unsigned stdoutMask, unsigned diskMask)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    if (newVal != nullptr) {
        setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    }
    if (oldVal != nullptr) {
        setenv("ASCEND_SLOG_PRINT_TO_STDOUT", oldVal, 1);
    }
    setenv("ASCEND_GLOBAL_LOG_LEVEL", globalLevel, 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);

    const char* capture = PATH_ROOT "/stdout_capture.txt";
    Issue1307RedirectStdout(capture);

    DlogInit();
    (void)ProcessLogInit();
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[issue1307] LEVEL_DEBUG_MARKER");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[issue1307] LEVEL_INFO_MARKER");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[issue1307] LEVEL_WARN_MARKER");
    dlog_error(SLOG | DEBUG_LOG_MASK, "[issue1307] LEVEL_ERROR_MARKER");
    (void)ProcessLogFree();
    DlogFree();

    (void)fflush(stdout);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    static const char* markers[4] = {
        "LEVEL_DEBUG_MARKER", "LEVEL_INFO_MARKER", "LEVEL_WARN_MARKER", "LEVEL_ERROR_MARKER"};
    for (int32_t i = 0; i < 4; i++) {
        if (Issue1307FileHas(capture, markers[i]) != ((stdoutMask & (1U << i)) != 0)) {
            return 20 + i;
        }
        if (Issue1307DirHas(PATH_ROOT "/debug", markers[i]) != ((diskMask & (1U << i)) != 0)) {
            return 30 + i;
        }
    }
    return 0;
}

// TC-1307-001 新变量=2：阈值 WARN
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_new_env_warn)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("2", nullptr, DLOG_WARN, true, nullptr, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-002 新变量=3：阈值 ERROR
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_new_env_error3)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("3", nullptr, DLOG_ERROR, true, nullptr, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-003 新变量=1：无阈值（DLOG_DEBUG）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_new_env_all)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("1", nullptr, DLOG_DEBUG, true, nullptr, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-004 新变量非法值 "4"：关闭 + 新合法值域告警（0/1/2/3）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_invalid_value)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel(
            "4", nullptr, -1, false, "expected '0', '1', '2' or '3'. Log-to-stdout disabled", false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-005 新变量=3 优先于旧变量=1：阈值语义生效
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_new_env_priority)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("3", "1", DLOG_ERROR, true, nullptr, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-006 仅旧变量=2：非法值（旧变量不适配 2/3）→ 关闭 + 旧合法值域告警（0/1）+ 废弃告警
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_old_env_invalid)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel(
            nullptr, "2", -1, false, "expected '0' or '1'. Log-to-stdout disabled", true, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-007 新变量=0 显式关闭：静默
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_new_env_off)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("0", nullptr, -1, false, nullptr, false, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-008 仅旧变量=1：兼容档 STDOUT_LEVEL_LEGACY（只打屏、不落盘）+ 废弃告警
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_old_env_legacy)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel(nullptr, "1", STDOUT_LEVEL_LEGACY, true, nullptr, true, nullptr)),
        testing::ExitedWithCode(0), "");
}

// TC-1307-101 E2E：=1 + GLOBAL=3，门与阈值均 error：stdout 仅 error，落盘仅 error
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level1_with_gate3)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("1", nullptr, "3", 0x8U, 0x8U)), testing::ExitedWithCode(0), "");
}

// TC-1307-102 E2E：=2 + GLOBAL=0：stdout 仅 warn+error，落盘全部四级
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level2_with_gate0)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("2", nullptr, "0", 0xCU, 0xFU)), testing::ExitedWithCode(0), "");
}

// TC-1307-103 E2E：=3 + GLOBAL=0：stdout 仅 error，落盘全部四级
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level3_with_gate0)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("3", nullptr, "0", 0x8U, 0xFU)), testing::ExitedWithCode(0), "");
}

// TC-1307-104 E2E（组合一）：GLOBAL=3 + =2：stdout error，落盘 error
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level2_with_gate3)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("2", nullptr, "3", 0x8U, 0x8U)), testing::ExitedWithCode(0), "");
}

// TC-1307-105 E2E（组合二）：GLOBAL=2 + =3：stdout error，落盘 warn+error
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level3_with_gate2)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("3", nullptr, "2", 0x8U, 0xCU)), testing::ExitedWithCode(0), "");
}

// TC-1307-106 E2E：STDOUT_LOG_MASK 显式打屏保持原行为（只打屏不落盘）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_mask_without_env)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit([]() {
            unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
            unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
            setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
            const char* capture = PATH_ROOT "/stdout_capture.txt";
            Issue1307RedirectStdout(capture);
            DlogInit();
            (void)ProcessLogInit();
            DlogRecord(SLOG | STDOUT_LOG_MASK, DLOG_INFO, "[issue1307] STDOUT_MASK_INFO_MARKER");
            (void)ProcessLogFree();
            DlogFree();
            unsetenv("ASCEND_PROCESS_LOG_PATH");
            (void)fflush(stdout);
            if (!Issue1307FileHas(capture, "STDOUT_MASK_INFO_MARKER")) {
                return 1;
            }
            if (Issue1307DirHas(PATH_ROOT "/debug", "STDOUT_MASK_INFO_MARKER")) {
                return 2;
            }
            return 0;
        }()),
        testing::ExitedWithCode(0), "");
}

// TC-1307-107 E2E：=2 时 run 型日志（固定 INFO 门）不打屏、正常落盘 run 目录
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level2_run_log)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit([]() {
            setenv("ASCEND_LOG_PRINT_TO_STDOUT", "2", 1);
            setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
            setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
            const char* capture = PATH_ROOT "/stdout_capture.txt";
            Issue1307RedirectStdout(capture);
            DlogInit();
            (void)ProcessLogInit();
            AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_INFO, "[issue1307] RUN_INFO_MARKER");
            (void)ProcessLogFree();
            DlogFree();
            unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
            unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
            unsetenv("ASCEND_PROCESS_LOG_PATH");
            (void)fflush(stdout);
            if (Issue1307FileHas(capture, "RUN_INFO_MARKER")) {
                return 1;
            }
            if (!Issue1307DirHas(PATH_ROOT "/run", "RUN_INFO_MARKER")) {
                return 2;
            }
            return 0;
        }()),
        testing::ExitedWithCode(0), "");
}

// TC-1307-108 E2E：旧变量=1 兼容档：全部打屏、不落盘（#1307 前旧行为）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_legacy_old_env)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit([]() {
            unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
            setenv("ASCEND_SLOG_PRINT_TO_STDOUT", "1", 1);
            setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
            setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
            const char* capture = PATH_ROOT "/stdout_capture.txt";
            Issue1307RedirectStdout(capture);
            DlogInit();
            (void)ProcessLogInit();
            dlog_debug(SLOG | DEBUG_LOG_MASK, "[issue1307] LEGACY_DEBUG_MARKER");
            dlog_info(SLOG | DEBUG_LOG_MASK, "[issue1307] LEGACY_INFO_MARKER");
            dlog_warn(SLOG | DEBUG_LOG_MASK, "[issue1307] LEGACY_WARN_MARKER");
            dlog_error(SLOG | DEBUG_LOG_MASK, "[issue1307] LEGACY_ERROR_MARKER");
            (void)ProcessLogFree();
            DlogFree();
            unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
            unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
            unsetenv("ASCEND_PROCESS_LOG_PATH");
            (void)fflush(stdout);
            static const char* markers[4] = {
                "LEGACY_DEBUG_MARKER", "LEGACY_INFO_MARKER", "LEGACY_WARN_MARKER", "LEGACY_ERROR_MARKER"};
            for (int32_t i = 0; i < 4; i++) {
                if (!Issue1307FileHas(capture, markers[i])) {
                    return 1;
                }
            }
            if (Issue1307DirHas(PATH_ROOT "/debug", "LEGACY_ERROR_MARKER")) {
                return 2;
            }
            return 0;
        }()),
        testing::ExitedWithCode(0), "");
}

// TC-1307-109 E2E：新变量=2 优先于旧变量=1：阈值过滤 + 同步落盘（新语义生效）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_level2_priority_over_old)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307RunStdoutThresholdScenario("2", "1", "0", 0xCU, 0xFU)), testing::ExitedWithCode(0), "");
}

// E2E：事件日志（DLOG_EVENT 独立级别）的打屏行为。事件仅受 ASCEND_GLOBAL_EVENT_ENABLE 门控、
// 落盘走独立映射（run 目录），不参与级别阈值过滤：仅无阈值档（新变量=1）与旧变量=1 兼容档上屏。
// expectStdout/expectDisk 为预期上屏/落盘。返回 0 符合预期，1/2 为断言失败定位码。
static int Issue1307RunEventScenario(const char* newVal, const char* oldVal, bool expectStdout, bool expectDisk)
{
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    if (newVal != nullptr) {
        setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    }
    if (oldVal != nullptr) {
        setenv("ASCEND_SLOG_PRINT_TO_STDOUT", oldVal, 1);
    }
    setenv("ASCEND_GLOBAL_EVENT_ENABLE", "1", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    const char* capture = PATH_ROOT "/stdout_capture.txt";
    Issue1307RedirectStdout(capture);
    DlogInit();
    (void)ProcessLogInit();
    DlogEventInner(SLOG, "[issue1307] EVENT_LOG_MARKER");
    (void)ProcessLogFree();
    DlogFree();
    unsetenv("ASCEND_GLOBAL_EVENT_ENABLE");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    (void)fflush(stdout);
    if (Issue1307FileHas(capture, "EVENT_LOG_MARKER") != expectStdout) {
        return 1;
    }
    // 落盘断言限定 run 目录（事件日志的独立落盘映射）；
    // 不得以 PATH_ROOT 为范围——stdout 捕获文件同在 PATH_ROOT 下，会误判为已落盘
    if (Issue1307DirHas(PATH_ROOT "/run", "EVENT_LOG_MARKER") != expectDisk) {
        return 2;
    }
    return 0;
}

// TC-1307-112 E2E：事件日志+新变量=1（无阈值档）：随打屏输出，落盘正常（run 目录）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_event_level1_kept)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunEventScenario("1", nullptr, true, true)), testing::ExitedWithCode(0), "");
}

// TC-1307-113 E2E：事件日志+新变量=2：不参与阈值过滤，不上屏，落盘正常
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_event_level2_filtered)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunEventScenario("2", nullptr, false, true)), testing::ExitedWithCode(0), "");
}

// TC-1307-114 E2E：事件日志+新变量=3：不上屏，落盘正常
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_event_level3_filtered)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunEventScenario("3", nullptr, false, true)), testing::ExitedWithCode(0), "");
}

// TC-1307-115 E2E：事件日志+旧变量=1 兼容档：照常打屏，不落盘（#1307 前旧行为）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_event_legacy_printed)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunEventScenario(nullptr, "1", true, false)), testing::ExitedWithCode(0), "");
}

// ---------------------------------------------------------------------------
// issue #1519：ASCEND_LOG_PRINT_TO_STDOUT 阈值档（2/3）与 ASCEND_GLOBAL_LOG_LEVEL
// 组合取最大值：打屏阈值 = max(打屏变量级别, 全局变量级别)，作用于所有日志类别
// （run/security 类日志的落盘级别门不受全局变量影响，但上屏受组合阈值约束）。
// =1（无阈值档）不参与组合；全局变量未配置/非法值不参与组合；落盘行为保持不变。
// ---------------------------------------------------------------------------

// TC-1519-001 白盒：GLOBAL=3 + STDOUT=2 → 组合阈值 ERROR（issue 原始场景）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_comb3and2)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("2", nullptr, DLOG_ERROR, true, nullptr, false, "3")),
        testing::ExitedWithCode(0), "");
}

// TC-1519-002 白盒：GLOBAL=2 + STDOUT=3 → 组合阈值 ERROR（反向组合）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_comb2and3)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("3", nullptr, DLOG_ERROR, true, nullptr, false, "2")),
        testing::ExitedWithCode(0), "");
}

// TC-1519-003 白盒：GLOBAL=0 + STDOUT=2 → 组合取较高者 WARN（全局低于阈值不放宽）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_comb0and2)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("2", nullptr, DLOG_WARN, true, nullptr, false, "0")),
        testing::ExitedWithCode(0), "");
}

// TC-1519-004 白盒：GLOBAL=3 + STDOUT=1 → =1 无阈值档不参与组合（=1 行为不受影响）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_comb3and1)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("1", nullptr, DLOG_DEBUG, true, nullptr, false, "3")),
        testing::ExitedWithCode(0), "");
}

// TC-1519-005 白盒：GLOBAL 非法值 + STDOUT=2 → 非法全局值不参与组合（阈值不变）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_level_comb_invalid_global)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue1307ScenarioCheckLevel("2", nullptr, DLOG_WARN, true, nullptr, false, "9")),
        testing::ExitedWithCode(0), "");
}

// TC-1519-101 E2E：GLOBAL=3 + STDOUT=2，run 类日志：WARN 不上屏（组合阈值 ERROR）、
// ERROR 上屏；run 目录正常落盘（落盘级别门不受影响，行为保持不变）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_comb_gate3_level2_run_log)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit([]() {
            setenv("ASCEND_LOG_PRINT_TO_STDOUT", "2", 1);
            setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
            setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
            const char* capture = PATH_ROOT "/stdout_capture.txt";
            Issue1307RedirectStdout(capture);
            DlogInit();
            (void)ProcessLogInit();
            AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_WARN, "[issue1519] RUN_WARN_MARKER");
            AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_ERROR, "[issue1519] RUN_ERROR_MARKER");
            (void)ProcessLogFree();
            DlogFree();
            unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
            unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
            unsetenv("ASCEND_PROCESS_LOG_PATH");
            (void)fflush(stdout);
            if (Issue1307FileHas(capture, "RUN_WARN_MARKER")) {
                return 1; // 组合阈值 ERROR：run 类 WARN 不得上屏
            }
            if (!Issue1307FileHas(capture, "RUN_ERROR_MARKER")) {
                return 2; // run 类 ERROR 应上屏
            }
            if (!Issue1307DirHas(PATH_ROOT "/run", "RUN_WARN_MARKER")) {
                return 3; // 落盘行为不变：run 类 WARN 正常落盘 run 目录
            }
            if (!Issue1307DirHas(PATH_ROOT "/run", "RUN_ERROR_MARKER")) {
                return 4; // 落盘行为不变：run 类 ERROR 正常落盘 run 目录
            }
            return 0;
        }()),
        testing::ExitedWithCode(0), "");
}

// TC-1519-102 E2E：GLOBAL=3 + STDOUT=2，security 类日志不上屏、security 目录正常落盘。
// security 类日志级别在 DlogParseLogMsg 中固定为 DLOG_INFO（先于打屏阈值过滤执行），
// 故阈值档下无论发起级别为何均不上屏，属设计行为；落盘行为保持不变。
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_comb_gate3_level2_security_log)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit([]() {
            setenv("ASCEND_LOG_PRINT_TO_STDOUT", "2", 1);
            setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
            setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
            const char* capture = PATH_ROOT "/stdout_capture.txt";
            Issue1307RedirectStdout(capture);
            DlogInit();
            (void)ProcessLogInit();
            dlog_info(SLOG | SECURITY_LOG_MASK, "[issue1519] SECURITY_INFO_MARKER");
            dlog_error(SLOG | SECURITY_LOG_MASK, "[issue1519] SECURITY_ERROR_MARKER");
            (void)ProcessLogFree();
            DlogFree();
            unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
            unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
            unsetenv("ASCEND_PROCESS_LOG_PATH");
            (void)fflush(stdout);
            if (Issue1307FileHas(capture, "SECURITY_INFO_MARKER")) {
                return 1; // 组合阈值 ERROR：security 类日志不得上屏
            }
            if (Issue1307FileHas(capture, "SECURITY_ERROR_MARKER")) {
                return 2; // security 类日志级别固定为 INFO，ERROR 发起亦不得上屏
            }
            if (!Issue1307DirHas(PATH_ROOT "/security", "SECURITY_INFO_MARKER")) {
                return 3; // 落盘行为不变：security 类日志正常落盘 security 目录
            }
            if (!Issue1307DirHas(PATH_ROOT "/security", "SECURITY_ERROR_MARKER")) {
                return 4;
            }
            return 0;
        }()),
        testing::ExitedWithCode(0), "");
}

// ---------------------------------------------------------------------------
// issue #1307 补充：磁盘满场景（plog 落盘写失败）的打屏与告警行为验证。
// 生产环境中 stdout 为终端/管道而非磁盘文件，磁盘满仅影响 plog 文件写入，
// 故按该语义桩化 ToolWrite：stdout 放行、其余写失败（比 RLIMIT_FSIZE 更贴近生产语义）。
// ---------------------------------------------------------------------------

// 磁盘满桩：fd 非 stdout 的写一律失败并计数（计数作为 syslog 限频断言的失败分母）。
static uint32_t g_issue1307DiskfullFailCnt = 0U;
static INT32 Issue1307DiskfullToolWrite(INT32 fd, const VOID* buf, UINT32 bufLen)
{
    if (fd == STDOUT_FILENO) {
        return (INT32)write(fd, buf, bufLen); // 打屏写放行
    }
    g_issue1307DiskfullFailCnt++;
    return -1;
}

// E2E：磁盘满场景校验。stdoutMask bit0=DEBUG, bit1=INFO, bit2=WARN, bit3=ERROR 为预期上屏级别。
// 断言：①打屏不受磁盘满影响（各级别条数符合打屏档位预期）；②终端写盘失败告警全进程仅 1 条
// （LOG_WARN_FPRINTF_ONCE 防刷屏）；③告警信息完整（数据长度/失败原因）；④syslog 层限频
// （SELF_LOG_ERROR_N 每 50 次失败至多 1 条；生产走 vsyslog 不进终端，UT stub 回显捕获文件以断言上界）；
// ⑤丢日志有 flush 层提示。返回 0 符合预期。
static int Issue1307RunDiskfullScenario(const char* newVal, const char* globalLevel, int repeat, unsigned stdoutMask)
{
    setenv("ASCEND_LOG_PRINT_TO_STDOUT", newVal, 1);
    setenv("ASCEND_GLOBAL_LOG_LEVEL", globalLevel, 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    const char* capture = PATH_ROOT "/stdout_capture.txt";
    Issue1307RedirectStdout(capture);
    MOCKER(ToolWrite).stubs().will(invoke(Issue1307DiskfullToolWrite));
    DlogInit();
    (void)ProcessLogInit();
    for (int i = 0; i < repeat; i++) {
        dlog_debug(SLOG | DEBUG_LOG_MASK, "[issue1307] DF%d_DEBUG_MARKER", i);
        dlog_info(SLOG | DEBUG_LOG_MASK, "[issue1307] DF%d_INFO_MARKER", i);
        dlog_warn(SLOG | DEBUG_LOG_MASK, "[issue1307] DF%d_WARN_MARKER", i);
        dlog_error(SLOG | DEBUG_LOG_MASK, "[issue1307] DF%d_ERROR_MARKER", i);
    }
    (void)ProcessLogFree();
    DlogFree();
    GlobalMockObject::reset();
    unsetenv("ASCEND_LOG_PRINT_TO_STDOUT");
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    (void)fflush(stdout);

    static const char* markers[4] = {"_DEBUG_MARKER", "_INFO_MARKER", "_WARN_MARKER", "_ERROR_MARKER"};
    for (int32_t i = 0; i < 4; i++) {
        int expect = ((stdoutMask & (1U << i)) != 0U) ? repeat : 0;
        if (Issue1307FileCount(capture, markers[i]) != expect) {
            return 10 + i;
        }
    }
    if (Issue1307FileCount(capture, "can not write log to file") != 1) {
        return 20;
    }
    if (Issue1307FileCount(capture, "possible reason") != 1) {
        return 21;
    }
    if (Issue1307FileCount(capture, "data_length") < 1) {
        return 22;
    }
    int sysLogCnt = Issue1307FileCount(capture, "write to file failed");
    if (sysLogCnt < 1) {
        return 30;
    }
    if ((uint32_t)sysLogCnt > (g_issue1307DiskfullFailCnt / 50U) + 2U) {
        return 31;
    }
    if (Issue1307FileCount(capture, "flush host log wrong") < 1) {
        return 32;
    }
    return 0;
}

// TC-1307-110 E2E：磁盘满+新变量=1：全量打屏不受影响、终端告警仅一次（无刷屏）、告警信息完整
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_diskfull_level1_no_flood)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunDiskfullScenario("1", "0", 50, 0xFU)), testing::ExitedWithCode(0), "");
}

// TC-1307-111 E2E：磁盘满+新变量=2：阈值过滤语义不受磁盘满影响，告警仍仅一次
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_stdout_diskfull_level2_threshold)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue1307RunDiskfullScenario("2", "0", 50, 0xCU)), testing::ExitedWithCode(0), "");
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, AlogInterfaceError)
{
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_ERROR, nullptr);
    EXPECT_EQ(0, AlogCheckDebugLevel(0, 100));
    EXPECT_EQ(0, AlogCheckDebugLevel(0, -1));
}

static void CallInvalidAcllogVaList(int32_t moduleId, int32_t level, const char* fmt, ...)
{
    va_list list;
    va_start(list, fmt);
    acllogVaList(moduleId, level, fmt, list);
    va_end(list);
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, AcllogInterfaceError)
{
    acllogRecord(0xff00, DLOG_INFO, nullptr);
    CallInvalidAcllogVaList(0xff00, DLOG_INFO, nullptr, 1);
    EXPECT_EQ(0, acllogCheckDebugLevel(0xff00, DLOG_NULL + 1));
    EXPECT_EQ(0, acllogCheckDebugLevel(-1, DLOG_INFO));
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInvalidModuleId)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
    DlogInner(-1, DLOG_INFO, "test invalid module id");
    DlogErrorInner(-1, "test invalid module id");
    DlogWarnInner(-1, "test invalid module id");
    DlogInfoInner(-1, "test invalid module id");
    DlogDebugInner(-1, "test invalid module id");
    DlogEventInner(-1, "test invalid module id");

    KeyValue stKeyValue[1];
    stKeyValue[0].kname = "game";
    stKeyValue[0].value = "over";

    DlogWithKVInner(-1, DLOG_INFO, stKeyValue, 1, "test invalid module id");

    DlogRecord(-1, DLOG_INFO, "test invalid module id");
    va_list list;
    DlogVaList(-1, DLOG_INFO, "test invalid module id", list);

    DlogInnerForC(-1, DLOG_INFO, "test invalid module id");
    DlogWithKVInnerForC(-1, DLOG_INFO, stKeyValue, 1, "test invalid module id");
    DlogRecordForC(-1, DLOG_INFO, "test invalid module id");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_NE(0, access(PATH_ROOT "/debug", F_OK));
    EXPECT_NE(0, access(PATH_ROOT "/run", F_OK));
    EXPECT_NE(0, access(PATH_ROOT "/security", F_OK));
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInitServerType)
{
    SetServerType(0, 0);
    DlogInitServerType();
    EXPECT_EQ(false, DlogIsPoolingDevice());

    SetServerType(0, 1);
    DlogInitServerType();
    EXPECT_EQ(false, DlogIsPoolingDevice());

    ReSetServerType();
    DlogInitServerType();
}

// init host file list failed(no permission to open)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogOpenNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(ToolOpenWithMode).stubs().will(returnValue(-1));
    dlog_error(
        SLOG | DEBUG_LOG_MASK,
        "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    // one error line since the chmod-on-failed-write was gated by the write result:
    // the spurious "change log file mode failed, file=" line no longer fires
    EXPECT_EQ(1, GetErrLogNum());
}

// init host file list failed(no permission to write)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogWriteNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    dlog_error(
        SLOG | DEBUG_LOG_MASK,
        "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(1, GetErrLogNum());
}

// init host file list failed(no permission to write)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogMkdirNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(LogMkdirRecur).stubs().will(returnValue(1));
    dlog_error(
        SLOG | DEBUG_LOG_MASK,
        "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(1, GetErrLogNum());
}
