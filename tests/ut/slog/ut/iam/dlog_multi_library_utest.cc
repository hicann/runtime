/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"

#include <algorithm>
#include <array>
#include <cstdlib>
#include <cstring>
#include <dlfcn.h>
#include <fcntl.h>
#include <fstream>
#include <iterator>
#include <map>
#include <string>
#include <sys/stat.h>
#include <unistd.h>

#include "dlog_async_process.h"
#include "dlog_unified_timer_api.h"
#include "log_iam_pub.h"
#include "unified_timer_error_code.h"

namespace {
struct Timer {
    void (*callback)(void);
    TimerType type;
};

std::map<std::string, Timer> g_timers;
uint32_t g_duplicateCount = 0;
bool g_fireSyncTimers = false;

constexpr std::array<const char*, 4> kLibraryPaths = {
    DLOG_MULTI_SLOG_PATH, DLOG_MULTI_ALOG_PATH, DLOG_MULTI_APP_PATH, DLOG_MULTI_DRIVER_PATH};
constexpr std::array<const char*, 4> kServiceRoots = {
    "/tmp/dlog_multi_slog", "/tmp/dlog_multi_alog", "/tmp/dlog_multi_app", "/tmp/dlog_multi_driver"};
constexpr std::array<const char*, 4> kMarkers = {"slog marker", "alog marker", "app marker", "driver marker"};
using Record = void (*)(int32_t, int32_t, const char*, ...);
using WriteLog = void (*)(const LogMsg*);
using Cleanup = void (*)(void);

template <typename Function>
Function GetFunction(void* handle, const char* name)
{
    return reinterpret_cast<Function>(dlsym(handle, name));
}

void FireTimers(TimerType type)
{
    const auto timers = g_timers;
    for (const auto& entry : timers) {
        if (entry.second.type == type) {
            if (type == ONESHOT_TIMER) {
                g_timers.erase(entry.first);
            }
            entry.second.callback();
        }
    }
}

bool ServiceContains(size_t index, const char* marker)
{
    std::ifstream service(std::string(kServiceRoots[index]) + "/iam", std::ios::binary);
    const std::string contents((std::istreambuf_iterator<char>(service)), std::istreambuf_iterator<char>());
    return contents.find(marker) != std::string::npos;
}

bool FileContains(const std::string& path, const char* marker)
{
    std::ifstream service(path, std::ios::binary);
    const std::string contents((std::istreambuf_iterator<char>(service)), std::istreambuf_iterator<char>());
    return contents.find(marker) != std::string::npos;
}

bool CreateServiceFile(const char* root)
{
    (void)mkdir(root, 0750);
    const int serviceFd = open((std::string(root) + "/iam").c_str(), O_CREAT | O_RDWR | O_TRUNC, 0600);
    if (serviceFd < 0) {
        return false;
    }
    (void)close(serviceFd);
    return true;
}

bool PrepareAutoLoadServices(const char* dlogRoot)
{
    return CreateServiceFile(dlogRoot) && CreateServiceFile("/tmp/dlog_autoload_slog");
}

void CleanupAutoLoadServices(const char* dlogRoot)
{
    (void)unlink((std::string(dlogRoot) + "/iam").c_str());
    (void)unlink("/tmp/dlog_autoload_slog/iam");
    (void)rmdir(dlogRoot);
    (void)rmdir("/tmp/dlog_autoload_slog");
}

void CheckResult(int& result, bool condition, const char* message)
{
    if (!condition) {
        fprintf(stderr, "%s\n", message);
        result = 1;
    }
}

bool OpenAutoLibrary(const char* path, const char* errorMessage, void*& handle, Record& record)
{
    handle = dlopen(path, RTLD_NOW | RTLD_LOCAL);
    if (handle == nullptr) {
        fprintf(stderr, "%s: %s\n", errorMessage, dlerror());
        return false;
    }
    record = GetFunction<Record>(handle, "DlogRecord");
    return record != nullptr;
}

void VerifyAutoLoadSlog(
    void* dlog, void* slog, Record dlogRecord, Record slogRecord, const std::string& dlogService,
    const std::string& slogService, int& result)
{
    Dl_info info = {};
    CheckResult(result, dladdr(reinterpret_cast<void*>(slogRecord), &info) != 0, "cannot locate slog public API");
    CheckResult(
        result, (info.dli_fname != nullptr) && (strcmp(info.dli_fname, DLOG_AUTOLOAD_SLOG_PATH) == 0),
        "dlopen libslog.so resolved a different library");
    CheckResult(result, g_duplicateCount == 0, "dlopen libslog.so registered a duplicate timer");
    CheckResult(result, g_timers.size() == 2, "slog constructor did not register its own timer");
    dlogRecord(SLOG, DLOG_ERROR, "%s", "dlog after libslog");
    slogRecord(SLOG, DLOG_ERROR, "%s", "slog after dlopen");
    FireTimers(PERIODIC_TIMER);
    CheckResult(
        result, FileContains(dlogService, "dlog after libslog"), "dlog stopped writing after dlopen libslog.so");
    CheckResult(result, FileContains(slogService, "slog after dlopen"), "slog public API produced no log after dlopen");
    CheckResult(result, !FileContains(dlogService, "slog after dlopen"), "slog public API was routed to dlog");
    CheckResult(result, !FileContains(slogService, "dlog after libslog"), "dlog public API was routed to slog");
    // The auto-load fixtures hide their destructor symbols; release resources through the test stub before unloading.
    const auto cleanupSlog = GetFunction<Cleanup>(slog, "IamSlogStubExit");
    CheckResult(result, cleanupSlog != nullptr, "slog cleanup entry is unavailable");
    if (cleanupSlog != nullptr) {
        cleanupSlog();
    }
    CheckResult(result, dlclose(slog) == 0, "dlclose libslog.so failed");
    CheckResult(result, g_timers.size() == 1, "slog cleanup removed another library's timer");
    dlogRecord(SLOG, DLOG_ERROR, "%s", "dlog after unloading libslog");
    FireTimers(PERIODIC_TIMER);
    CheckResult(
        result, FileContains(dlogService, "dlog after unloading libslog"), "dlog stopped writing after unloading slog");
    const auto cleanupDlog = GetFunction<Cleanup>(dlog, "IamSlogStubExit");
    CheckResult(result, cleanupDlog != nullptr, "dlog cleanup entry is unavailable");
    if (cleanupDlog != nullptr) {
        cleanupDlog();
    }
    CheckResult(result, dlclose(dlog) == 0, "dlclose libunified_dlog.so failed");
    CheckResult(result, g_timers.empty(), "auto-load cleanup left timers registered");
}

int RunAutoLoadScenario(bool driverVariant)
{
    const char* dlogRoot = driverVariant ? "/tmp/dlog_autoload_driver" : "/tmp/dlog_autoload_app";
    const char* dlogPath = driverVariant ? DLOG_AUTOLOAD_DRIVER_PATH : DLOG_AUTOLOAD_APP_PATH;
    const std::string dlogService = std::string(dlogRoot) + "/iam";
    const std::string slogService = "/tmp/dlog_autoload_slog/iam";
    if (!PrepareAutoLoadServices(dlogRoot)) {
        return 1;
    }
    int result = 0;
    void* dlog = nullptr;
    Record dlogRecord = nullptr;
    if (!OpenAutoLibrary(dlogPath, "dlopen libunified_dlog.so failed", dlog, dlogRecord)) {
        CleanupAutoLoadServices(dlogRoot);
        return 1;
    }
    CheckResult(result, g_timers.size() == 1, "dlog constructor did not register a timer");
    CheckResult(result, dlsym(dlog, "DllMain") == nullptr, "dlog fixture exposes UT-only initialization entry");
    dlogRecord(SLOG, DLOG_ERROR, "%s", "dlog before libslog");
    FireTimers(PERIODIC_TIMER);
    CheckResult(
        result, FileContains(dlogService, "dlog before libslog"), "dlog public API did not write before loading slog");
    void* slog = nullptr;
    Record slogRecord = nullptr;
    if (!OpenAutoLibrary("libslog.so", "dlopen libslog.so failed", slog, slogRecord)) {
        CleanupAutoLoadServices(dlogRoot);
        return 1;
    }
    VerifyAutoLoadSlog(dlog, slog, dlogRecord, slogRecord, dlogService, slogService, result);
    CleanupAutoLoadServices(dlogRoot);
    return result;
}

void WriteInitialLog(size_t index, bool useSyncTimers, WriteLog writeLog)
{
    LogMsg message = {};
    message.type = DEBUG_LOG;
    message.level = DLOG_ERROR;
    message.moduleId = SLOG;
    if (useSyncTimers) {
        const size_t markerLength = strlen(kMarkers[index]);
        std::fill(message.msg, message.msg + sizeof(message.msg) - 1, 'x');
        std::copy(kMarkers[index], kMarkers[index] + markerLength, message.msg);
        message.msgLength = sizeof(message.msg) - 1;
        for (size_t count = 0; count < DEF_SIZE / message.msgLength; count++) {
            writeLog(&message);
        }
        return;
    }
    (void)strcpy_s(message.msg, sizeof(message.msg), kMarkers[index]);
    message.msgLength = strlen(message.msg);
    writeLog(&message);
}

bool LoadScenarioLibrary(size_t index, bool useSyncTimers, std::array<void*, 4>& handles)
{
    const std::string servicePath = std::string(kServiceRoots[index]) + "/iam";
    (void)mkdir(kServiceRoots[index], 0750);
    const int serviceFd = open(servicePath.c_str(), O_CREAT | O_RDWR | O_TRUNC, 0600);
    if (serviceFd < 0) {
        return false;
    }
    (void)close(serviceFd);
    handles[index] = dlopen(kLibraryPaths[index], RTLD_NOW | RTLD_LOCAL);
    if (handles[index] == nullptr) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        return false;
    }
    const auto notify = GetFunction<void (*)(IAMResourceStatus)>(handles[index], "IamSlogStubNotifyResource");
    const auto writeLog = GetFunction<WriteLog>(handles[index], "DlogWriteToBuf");
    const auto initialize = GetFunction<void (*)(void)>(handles[index], "DllMain");
    if ((notify == nullptr) || (writeLog == nullptr) || (initialize == nullptr)) {
        return false;
    }
    initialize();
    notify(IAM_RESOURCE_READY);
    WriteInitialLog(index, useSyncTimers, writeLog);
    return true;
}

void WriteSurvivingLog(size_t index, void* handle, int& result)
{
    const auto writeLog = GetFunction<WriteLog>(handle, "DlogWriteToBuf");
    const auto flush = GetFunction<void (*)(void)>(handle, "DlogFlushBuf");
    LogMsg message = {};
    message.type = DEBUG_LOG;
    message.level = DLOG_ERROR;
    message.moduleId = SLOG;
    (void)strcpy_s(message.msg, sizeof(message.msg), "surviving library marker");
    message.msgLength = strlen(message.msg);
    writeLog(&message);
    flush();
    CheckResult(result, ServiceContains(index, "surviving library marker"), "surviving library stopped writing logs");
}

void CloseScenarioLibrary(size_t index, std::array<void*, 4>& handles, int& result)
{
    const auto exitIam = GetFunction<void (*)(void)>(handles[index], "DlogExitForIam");
    exitIam();
    CheckResult(result, dlclose(handles[index]) == 0, "failed to unload logging library");
    handles[index] = nullptr;
}

int RunScenario(const std::array<size_t, 3>& order, bool useSyncTimers)
{
    int result = 0;
    std::array<void*, 4> handles = {};
    for (size_t index : order) {
        if (!LoadScenarioLibrary(index, useSyncTimers, handles)) {
            return 1;
        }
    }
    CheckResult(result, g_duplicateCount == 0, "timer name collision between logging libraries");
    CheckResult(
        result, g_timers.size() == (useSyncTimers ? 6U : 3U), "not all logging libraries registered their timers");
    for (const char* library : {"slog", "alog", "dlog"}) {
        CheckResult(
            result, g_timers.count(std::string(library) + "_send_task_timer") == 1, "missing library's send timer");
        if (useSyncTimers) {
            CheckResult(
                result, g_timers.count(std::string(library) + "_sync_task_timer") == 1, "missing library's sync timer");
        }
    }
    FireTimers(useSyncTimers ? ONESHOT_TIMER : PERIODIC_TIMER);
    for (size_t index : order) {
        CheckResult(result, ServiceContains(index, kMarkers[index]), kMarkers[index]);
    }
    const size_t first = order.front();
    GetFunction<void (*)(void)>(handles[first], "DlogExitForIam")();
    CheckResult(result, dlclose(handles[first]) == 0, "failed to unload first logging library");
    handles[first] = nullptr;
    CheckResult(result, g_timers.size() == 2, "unloading one library removed another library's timer");
    g_fireSyncTimers = true;
    for (size_t index : order) {
        if (handles[index] != nullptr) {
            WriteSurvivingLog(index, handles[index], result);
            CloseScenarioLibrary(index, handles, result);
        }
        (void)unlink((std::string(kServiceRoots[index]) + "/iam").c_str());
        (void)rmdir(kServiceRoots[index]);
    }
    CheckResult(result, g_timers.empty(), "logging library left timers registered after unload");
    return result;
}
} // namespace

extern "C" LogStatus DlogLoadTimerDll(void) { return LOG_SUCCESS; }
extern "C" LogStatus DlogCloseTimerDll(void) { return LOG_SUCCESS; }

extern "C" uint32_t DlogAddUnifiedTimer(const char* name, void (*callback)(void), int64_t period, TimerType type)
{
    (void)period;
    if (!g_timers.emplace(name, Timer{callback, type}).second) {
        g_duplicateCount++;
        return UNIFIED_TIMER_NAME_DUPLICATE;
    }
    if (g_fireSyncTimers && (type == ONESHOT_TIMER)) {
        g_timers.erase(name);
        callback();
    }
    return 0;
}

extern "C" uint32_t DlogRemoveUnifiedTimer(const char* name) { return g_timers.erase(name) == 1 ? 0 : 1; }

TEST(DlogMultiLibraryUtest, PeriodicTimersDeliverLogsInEveryLoadOrder)
{
    std::array<size_t, 3> order = {0, 1, 2};
    do {
        EXPECT_EXIT(std::exit(RunScenario(order, false)), testing::ExitedWithCode(0), "");
    } while (std::next_permutation(order.begin(), order.end()));
}

TEST(DlogMultiLibraryUtest, SyncTimersDeliverLogsInEveryLoadOrder)
{
    std::array<size_t, 3> order = {0, 1, 2};
    do {
        EXPECT_EXIT(std::exit(RunScenario(order, true)), testing::ExitedWithCode(0), "");
    } while (std::next_permutation(order.begin(), order.end()));
}

TEST(DlogMultiLibraryUtest, DriverUnifiedLibraryDeliversLogsInEveryLoadOrder)
{
    std::array<size_t, 3> order = {0, 1, 3};
    do {
        EXPECT_EXIT(std::exit(RunScenario(order, false)), testing::ExitedWithCode(0), "");
        EXPECT_EXIT(std::exit(RunScenario(order, true)), testing::ExitedWithCode(0), "");
    } while (std::next_permutation(order.begin(), order.end()));
}

TEST(DlogMultiLibraryUtest, DriverDlogThenDlopenSlogAutoInitializesPublicApi)
{
    EXPECT_EXIT(std::exit(RunAutoLoadScenario(true)), testing::ExitedWithCode(0), "");
}

TEST(DlogMultiLibraryUtest, AppDlogThenDlopenSlogAutoInitializesPublicApi)
{
    EXPECT_EXIT(std::exit(RunAutoLoadScenario(false)), testing::ExitedWithCode(0), "");
}
