/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <cstdint>
#include <dlfcn.h>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "osal.h"
#include "utils/utils.h"
#include "ascend_hal.h"

#ifdef __PROF_LLT
#define STATIC
#else
#define STATIC static
#endif

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using AdprofStartFunc = int32_t (*) (int32_t argc, const char** argv);
using AdprofIsExitFunc = bool (*) ();

const static std::string LIBASCEND_DEVPROF_LIB_PATH = "libascend_devprof.so";
const static std::string HOST_PID = "host_pid:";
const static std::string DEV_ID = "dev_id:";
constexpr int32_t MIN_ARGC = 4;
constexpr int32_t HOST_PID_INDEX = 1;
constexpr int32_t DEV_ID_INDEX = 2;
constexpr uint32_t SLEEP_TIME = 500U;
constexpr uint32_t QUERY_BIND_HOST_PID_TIME = 500U;
constexpr uint32_t QUERY_BIND_HOST_PID_INTERVAL = 50U;

STATIC int32_t CheckBindHostPid(const char *arg)
{
    MSPROF_LOGI("Check bind host pid");
    std::string hostPidStr(arg);
    auto index = hostPidStr.find(HOST_PID);
    if (index == std::string::npos) {
        MSPROF_LOGE("get host pid failed");
        return PROFILING_FAILED;
    }
    hostPidStr = hostPidStr.substr(index + HOST_PID.size());
    uint32_t hostPid = 0;
    if (!Utils::StrToUint32(hostPid, hostPidStr)) {
        MSPROF_LOGE("host pid '%s' invalid", hostPidStr.c_str());
        return PROFILING_FAILED;
    }

    drvError_t ret = DRV_ERROR_NONE;
    uint32_t getHostPid = 0;
    int32_t pid = OsalGetPid();
    uint32_t cpType = DEVDRV_PROCESS_CPTYPE_MAX;
    for (uint32_t i = 0; i < QUERY_BIND_HOST_PID_TIME / QUERY_BIND_HOST_PID_INTERVAL; i++) {
        ret = drvQueryProcessHostPid(pid, nullptr, nullptr, &getHostPid, &cpType);
        if (ret == DRV_ERROR_NO_PROCESS) {
            MSPROF_LOGI("call drvQueryProcessHostPid try again");
            OsalSleep(QUERY_BIND_HOST_PID_INTERVAL);
            continue;
        }
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("call drvQueryProcessHostPid failed, ret:%d", ret);
            return PROFILING_FAILED;
        }
        MSPROF_LOGI("call drvQueryProcessHostPid result, hostpid:%u, cpType:%u", hostPid, cpType);
        if (getHostPid == hostPid) {
            MSPROF_LOGI("check host pid success");
            return PROFILING_SUCCESS;
        }
        OsalSleep(QUERY_BIND_HOST_PID_INTERVAL);
    }
    MSPROF_LOGE("Check bind host pid failed");
    return PROFILING_FAILED;
}

STATIC void Start(int32_t argc, const char *argv[])
{
    void *handle = OsalDlopen(LIBASCEND_DEVPROF_LIB_PATH.c_str(), RTLD_LAZY | RTLD_NODELETE);
    if (!handle) {
        MSPROF_LOGE("Failed to load library: %s, dlopen error: %s\n", LIBASCEND_DEVPROF_LIB_PATH.c_str(), dlerror());
        return;
    }
    AdprofStartFunc adprofStartFunc = Utils::ReinterpretCast<int32_t (int32_t argc, const char** argv)>(
        OsalDlsym(handle, "AdprofStart"));
    if (adprofStartFunc == nullptr) {
        MSPROF_LOGE("Failed to load AdprofStart function from %s", LIBASCEND_DEVPROF_LIB_PATH.c_str());
        OsalDlclose(handle);
        return;
    }
    int32_t ret = adprofStartFunc(argc, argv);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Failed to run AdprofStart function from %s", LIBASCEND_DEVPROF_LIB_PATH.c_str());
        OsalDlclose(handle);
        return;
    }

    AdprofIsExitFunc adprofIsExitFunc = Utils::ReinterpretCast<bool ()>(OsalDlsym(handle, "GetIsExit"));
    if (adprofIsExitFunc == nullptr) {
        MSPROF_LOGE("Failed to load GetIsExit function from %s", LIBASCEND_DEVPROF_LIB_PATH.c_str());
        OsalDlclose(handle);
        return;
    }
    while (!adprofIsExitFunc()) {
        OsalSleep(SLEEP_TIME);
    }
    OsalDlclose(handle);
    return;
}

#ifdef __PROF_LLT
int32_t LltMain(int32_t argc, const char *argv[])
#else
int32_t main(int32_t argc, const char *argv[])
#endif
{
    MSPROF_EVENT("adprof start");
    if (argc < MIN_ARGC) {
        MSPROF_LOGE("argc is less than %d", MIN_ARGC);
        MSPROF_EVENT("adprof exit");
        return PROFILING_FAILED;
    }

    if (CheckBindHostPid(argv[HOST_PID_INDEX]) != PROFILING_SUCCESS) {
        MSPROF_EVENT("adprof exit");
        return PROFILING_FAILED;
    }

    std::string devIdStr(argv[DEV_ID_INDEX]);
    auto index = devIdStr.find(DEV_ID);
    if (index == std::string::npos) {
        MSPROF_LOGE("not find device id");
        return PROFILING_FAILED;
    }
    devIdStr = devIdStr.substr(index + DEV_ID.size());
    uint32_t hostDevId;
    if (!Utils::StrToUint32(hostDevId, devIdStr)) {
        MSPROF_LOGE("device id %s is invalid", devIdStr.c_str());
        return PROFILING_FAILED;
    }

    uint32_t localDevId = 0;
    drvError_t err = drvGetLocalDevIDByHostDevID(hostDevId, &localDevId);
    FUNRET_CHECK_EXPR_ACTION(err != DRV_ERROR_NONE, return PROFILING_FAILED,
        "Failed to get local device id, devId=%u, ret=%d.", hostDevId, static_cast<int32_t>(err));
    MSPROF_LOGI("Get local device id %u by id %u.", localDevId, hostDevId);
    err = halDrvEventThreadInit(localDevId);
    if (err != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to init drv event thread, ret=%d.", static_cast<int32_t>(err));
        return PROFILING_FAILED;
    }

    Start(argc, argv);

    err = halDrvEventThreadUninit(localDevId);
    if (err != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to uninit drv event thread, ret=%d.", static_cast<int32_t>(err));
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("adprof exit");
    return PROFILING_SUCCESS;
}