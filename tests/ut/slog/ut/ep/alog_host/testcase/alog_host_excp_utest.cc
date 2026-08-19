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
#include <cstdlib>
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
void DllMain(void);
void DlogFree(void);
void PlogDriverLog(int32_t moduleId, int32_t level, const char* fmt, ...);
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
        DllMain();
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
static int Issue768ScenarioCheckStdout(
    const char* newVal, const char* oldVal, bool expectEnabled, bool expectDeprecatedWarn, bool expectEnableInfo,
    bool expectInvalidWarn)
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
    // 开启 INFO：值为 "1" 生效时出现
    if (Issue768SelfLogHas("Log-to-stdout enabled by environment variable") != expectEnableInfo) {
        return 3;
    }
    // 非法值 WARN
    if (Issue768SelfLogHas("expected '0' or '1'. Log-to-stdout disabled") != expectInvalidWarn) {
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

// 二进制端到端：通过 dlog 打印接口，按环境变量确认日志落盘 vs 打屏。
// 打屏开启时日志走 console，不会在 PATH_ROOT/debug 落盘目录产生文件。返回 0 符合预期。
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
    DllMain();
    (void)ProcessLogInit();
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_EXCP_UTEST][issue768] e2e stdout switch test.");
    (void)ProcessLogFree();
    DlogFree();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    bool diskExists = (access(PATH_ROOT "/debug", F_OK) == 0);
    if (expectStdout) {
        return diskExists ? 1 : 0; // 打屏开启：不落盘 debug
    }
    return diskExists ? 0 : 1;     // 打屏关闭：按默认落盘
}

// 参数：(new, old, expectEnabled, expectDeprecatedWarn, expectEnableInfo, expectInvalidWarn)
// TC-768-001 新变量=1 开启：开启 INFO，无废弃/无非法
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_on)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("1", nullptr, true, false, true, false)), testing::ExitedWithCode(0), "");
}

// TC-768-002 新变量=0 显式关闭：静默（无任何维测日志）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_off_silent)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("0", nullptr, false, false, false, false)), testing::ExitedWithCode(0),
        "");
}

// TC-768-003 仅旧变量=1，兼容开启：废弃 WARN + 开启 INFO
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_old_env_compat)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(nullptr, "1", true, true, true, false)), testing::ExitedWithCode(0), "");
}

// TC-768-004 新变量=0 且旧变量=1，新变量优先关闭（不回退旧变量、无废弃告警、无开启 INFO）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_priority)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("0", "1", false, false, false, false)), testing::ExitedWithCode(0), "");
}

// TC-768-005 两变量均未配置，默认关闭：静默
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_default_off)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(nullptr, nullptr, false, false, false, false)),
        testing::ExitedWithCode(0), "");
}

// TC-768-006 新变量为非法值，关闭：非法值 WARN，无废弃/无开启 INFO
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_new_env_invalid)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout("abc", nullptr, false, false, false, true)), testing::ExitedWithCode(0),
        "");
}

// TC-768-007 旧变量为非法值（新变量未设）：废弃 WARN + 非法值 WARN，关闭
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout_old_env_invalid)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        std::exit(Issue768ScenarioCheckStdout(nullptr, "xyz", false, true, false, true)), testing::ExitedWithCode(0),
        "");
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

// TC-768-101 新变量=1，日志打屏（不落盘）
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_e2e_new_env_stdout)
{
    testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(std::exit(Issue768RunStdoutE2eScenario("1", nullptr, true)), testing::ExitedWithCode(0), "");
}

// TC-768-102 仅旧变量=1，兼容打屏（不落盘）
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

    PlogDriverLog(-1, DLOG_INFO, "test invalid module id");

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
    EXPECT_EQ(2, GetErrLogNum());
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
