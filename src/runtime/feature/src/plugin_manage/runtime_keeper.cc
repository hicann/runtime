/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime_keeper.h"
#include "runtime.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif
#include "context_data_manage.h"
#include "task_fail_callback_data_manager.h"
#include "prof_ctrl_callback_manager.hpp"
#include "thread_local_container.hpp"
#include "dev_info_manage.h"
#include "global_state_manager.hpp"
#ifdef XPU_UT
#include "tprt.hpp"
#endif

namespace {
constexpr int64_t RTS_INVALID_HARDWARE_VERSION = 0xFFFFFFFFFFFFFFFFLL;

}  // namespace

namespace cce {
namespace runtime {
// Do not delete g_unusedThreadEnv, to add the .tbss or .tdata section in elf file (libruntime.so),
// When the so file is loaded in lazy mode(dlopen),
// Memory allocation is performed for thread variables only when the tls section is identified.
// __aarch64__  still crashes(centos libc 2.17 < 2.22, gcc 7.3), no define
#ifdef __x86_64__
static __THREAD_LOCAL__ uint32_t g_unusedThreadEnv = 0;
#endif
#if RUNTIME_API
Runtime *Runtime::runtime_ = nullptr;
#endif
static bool g_isRuntimeKeeperExiting = false;
static RuntimeKeeper g_runtimeKeeper;

rtError_t GetDeviceType(int64_t *hwVersion)
{
    int64_t hardwareVersion = RTS_INVALID_HARDWARE_VERSION;
    drvError_t drvRet = halGetDeviceInfo(RT_DEV_ZERO, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    if (drvRet != DRV_ERROR_NONE) {
        uint32_t devCnt = 0U;
        drvError_t drvNumRet = drvGetDevNum(&devCnt);
        if (drvNumRet != DRV_ERROR_NONE) {
            devCnt = RT_MAX_DEV_NUM;
        }

        for (uint32_t i = 0U; i < devCnt; i++) {
            drvRet = halGetDeviceInfo(i, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
            if (drvRet == DRV_ERROR_NONE) {
                RT_LOG(RT_LOG_EVENT, "workingDev=%u", i);
                break;
            }
        }
    }

    if (drvRet != DRV_ERROR_NONE) {
        if (drvRet != DRV_ERROR_NOT_SUPPORT) {
            DRV_ERROR_PROCESS(drvRet,
                "Call halGetDeviceInfo failed: drvRet=%d, module type=%d, info type=%d.",
                drvRet,
                MODULE_TYPE_SYSTEM,
                INFO_TYPE_VERSION);
        } else {
            RT_LOG(RT_LOG_WARNING,
                "[Call][halGetDeviceInfo] failed, function does not support, module type=%d,"
                " info type=%d.",
                MODULE_TYPE_SYSTEM,
                INFO_TYPE_VERSION);
        }
    } else {
        *hwVersion = hardwareVersion;
    }

    RT_LOG(RT_LOG_INFO, "hardwareVersion=%#" PRIx64, hardwareVersion);
    return RT_GET_DRV_ERRCODE(drvRet);
}

#if STATIC_RT_LIB
static Runtime *CreateRuntimeImpl(void **soHandle)
{
    UNUSED(soHandle);
    cce::runtime::Runtime* rt = new (std::nothrow) cce::runtime::Runtime();
    #ifdef XPU_UT
        cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    #endif
    return rt;
}

static void DestroyRuntimeImpl(Runtime *rt, const void *soHandle)
{
    UNUSED(soHandle);
    DELETE_O(rt);
    #ifdef XPU_UT
        DELETE_O(cce::tprt::TprtManage::tprt_);
        cce::tprt::TprtManage::tprt_ = nullptr;
    #endif
}
#else
static const std::string LIBRUNTIME_SO_NAME = "libruntime_v100.so";  // default so name
using ConstructFunc = Runtime *(*)();
using DesConstructFunc = void (*)(Runtime *);

static rtChipType_t g_chipType = CHIP_BEGIN;
rtChipType_t Runtime::GetChipType()
{
    if (GlobalContainer::GetSocType() != SOC_BEGIN) {
        return GlobalContainer::GetRtChipType();
    }
    return g_chipType;
}

static rtChipType_t GetChipType()
{
    int64_t hwVersion = RTS_INVALID_HARDWARE_VERSION;
    rtChipType_t chipType = GlobalContainer::GetRtChipType();
    const rtError_t ret = GetDeviceType(&hwVersion);
    if (ret == RT_ERROR_NONE) {
        const rtChipType_t type = static_cast<rtChipType_t>(PLAT_GET_CHIP(static_cast<uint64_t>(hwVersion)));
        if ((type != CHIP_NO_DEVICE) && (type >= CHIP_BEGIN) && (type < CHIP_END)) {
            chipType = type;
        }
    }
    g_chipType = chipType;
    return chipType;
}

static const std::string GetLibRuntimeSoName()
{
    const rtChipType_t chipType = GetChipType();
    std::string soName;
    const rtError_t ret = GET_PLATFORM_LIB_INFO(chipType, soName);
    if ((ret != RT_ERROR_NONE) || (soName.empty())) {
        RT_LOG(RT_LOG_ERROR, "Find chipType %d fail", static_cast<int32_t>(chipType));
        return LIBRUNTIME_SO_NAME;
    }
    return soName;
}

static Runtime *CreateRuntimeImpl(void **soHandle)
{
    const std::string libSoName = GetLibRuntimeSoName();
    constexpr const int32_t flags = static_cast<int32_t>(static_cast<uint32_t>(MMPA_RTLD_NOW));
    void *const handlePtr = mmDlopen(libSoName.c_str(), flags);
    if (handlePtr == nullptr) {
        const char_t *const dlRet = mmDlerror();
        RT_LOG(RT_LOG_ERROR, "Open %s failed, dlerror() = %s", libSoName.c_str(), dlRet);
        return nullptr;
    }
    ConstructFunc const func = RtPtrToPtr<ConstructFunc>(mmDlsym(handlePtr, "ConstructRuntimeImpl"));
    if (func == nullptr) {
        RT_LOG(RT_LOG_ERROR, "No symbol found in %s.", libSoName.c_str());
        (void)mmDlclose(handlePtr);
        return nullptr;
    }
    Runtime *rt = func();
    if (rt == nullptr) {
        (void)mmDlclose(handlePtr);
        RT_LOG(RT_LOG_ERROR, "From %s Create Runtime Instance fail", libSoName.c_str());
        return nullptr;
    }
    *soHandle = handlePtr;
    RT_LOG(RT_LOG_EVENT, "Open %s successfully", libSoName.c_str());
    return rt;
}

static void DestroyRuntimeImpl(Runtime *rt, void *soHandle)
{
    if ((soHandle == nullptr) || (rt == nullptr)) {
        RT_LOG(RT_LOG_INFO, "soHandle or rt is nullptr");
        return;
    }
    DesConstructFunc const func = RtPtrToPtr<DesConstructFunc, void *>(mmDlsym(soHandle, "DestructorRuntimeImpl"));
    if (func == nullptr) {
        const std::string libSoName = GetLibRuntimeSoName();
        RT_LOG(RT_LOG_ERROR, "No symbol found in %s.", libSoName.c_str());
        return;
    }
    func(rt);
    RT_LOG(RT_LOG_INFO, "Destroy Runtime success");
    return;
}

#endif

#ifndef CFG_DEV_PLATFORM_PC
ErrorManager& RuntimeKeeper::errManager_ = ErrorManager::GetInstance();
#endif

RuntimeKeeper::RuntimeKeeper() : NoCopy(), runtime_(nullptr)
{
    // Do not delete &g_unusedThreadEnv, O3 Will optimize, Missing tls section
#ifdef __x86_64__
    RT_LOG(RT_LOG_INFO, "start: %p", &g_unusedThreadEnv);
#endif
    (void)GlobalStateManager::GetInstance();
    (void)ErrorcodeManage::Instance();
#ifndef CFG_DEV_PLATFORM_PC
    (void)ErrorManager::GetInstance();
#endif
    (void)ProfCtrlCallbackManager::Instance();
    (void)TaskFailCallBackManager::Instance();
    (void)ContextDataManage::Instance();
    (void)DevInfoManage::Instance();
}

RuntimeKeeper::~RuntimeKeeper()
{
    g_isRuntimeKeeperExiting = true;
    try {
        DestroyRuntimeImpl(runtime_, soHandle_);
    } catch (...) {}

    Runtime::runtime_ = nullptr;
    runtime_ = nullptr;
    if (soHandle_ != nullptr) {
        (void)mmDlclose(soHandle_);
    }
    soHandle_ = nullptr;
}

Runtime *RuntimeKeeper::BootRuntime()
{
    if (bootStage_.CompareExchange(BOOT_INIT, BOOT_ON)) {
        // get chip type and dlopen different so
        void *handle = nullptr;
        runtime_ = CreateRuntimeImpl(&handle);
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
            runtime_ == nullptr,
            nullptr,
            bootStage_.Set(BOOT_INIT),
            "Runtime boot failed, new Runtime failed.");

        RT_LOG(RT_LOG_INFO, "new Runtime ok, Runtime_alloc_size %zu.", sizeof(Runtime));

        if (runtime_->Init() != RT_ERROR_NONE) {
            DestroyRuntimeImpl(runtime_, handle);
            runtime_ = nullptr;
            (void)mmDlclose(handle);
            bootStage_.Set(BOOT_INIT);
            return nullptr;
        }
        const rtError_t error = MsprofRegisterCallback(RUNTIME, &rtProfilingCommandHandle);
        if (error != RT_ERROR_NONE) {
            DELETE_O(runtime_);
            bootStage_.Set(BOOT_INIT);
            return nullptr;
        }
        soHandle_ = handle;
        bootStage_.Set(BOOT_DONE);
    } else {
        uint32_t tmpValue = bootStage_.Value();
        while ((tmpValue != BOOT_DONE) && (tmpValue != BOOT_INIT)) {
            tmpValue = bootStage_.Value();
        }
        if (runtime_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Runtime boot failed, new Runtime failed.");
        }
        return runtime_;
    }
    return runtime_;
}

Runtime *RuntimeKeeperGetRuntime()
{
    return (g_runtimeKeeper.BootRuntime());
}

bool IsRuntimeKeeperExiting(void)
{
    return g_isRuntimeKeeperExiting;
}
}  // namespace runtime
}  // namespace cce
