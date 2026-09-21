/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_ipc_memory.hpp"
#include "api_impl_creator.hpp"
#include "context.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"

#include <algorithm>
#include <mutex>
#include <new>
#include <string>
#include <unordered_map>

namespace cce {
namespace runtime {
namespace {
rtError_t IpcSetMemoryNameImpl(
    const void* const ptr, const uint64_t byteCount, char_t* const name, const uint32_t len, const uint64_t flags)
{
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG(RT_LOG_WARNING, "chipType=%d does not support, return.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    auto error = curCtx->Device_()->Driver_()->CreateIpcMem(ptr, byteCount, name, len);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        error = curCtx->Device_()->Driver_()->SetIpcMemAttr(
            name, SHMEM_ATTR_TYPE_NO_WLIST_IN_SERVER, SHMEM_NO_WLIST_ENABLE);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    RT_LOG(RT_LOG_DEBUG, "Name=%s, byteCount=%" PRIu64 ", len=%u, flags=%#" PRIx64 ".", name, byteCount, len, flags);
    return error;
}

rtError_t IpcOpenMemoryImpl(void** const ptr, const char_t* const name, const uint64_t flags)
{
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    std::string ipcName(name);
    RT_LOG(RT_LOG_INFO, "Open ipc memory, name=%s, flags=%#" PRIx64 ".", ipcName.c_str(), flags);
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = curCtx->Device_();
    if ((flags & RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS) != 0UL) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetPhyDevIdByIpcMemName(name, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    uint64_t latestAttr = 0UL; // if not set, use 0 to drv, otherwise update with cfg
    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it != ipcMemNameMap.end()) {
            latestAttr = it->second.latestAttr;
        }
    }

    error = dev->Driver_()->OpenIpcMem(name, RtPtrToPtr<uint64_t*>(ptr), curCtx->Device_()->Id_(), latestAttr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "open ipc memory failed, name=%s, attr=%#" PRIx64 ".", ipcName.c_str(), latestAttr);
        return error;
    }

    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it == ipcMemNameMap.end()) {
            ipcMemInfo_t& info = ipcMemNameMap[ipcName];
            info.latestAttr = latestAttr;
            info.vaList.push_back(RtPtrToValue(*ptr));
        } else {
            it->second.vaList.push_back(RtPtrToValue(*ptr));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t IpcCloseMemoryImpl(const void* const ptr)
{
    RT_LOG(RT_LOG_DEBUG, "Start close ipc memory.");
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "closing the IPC shared memory");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint64_t vaData = RtPtrToValue(ptr);
    const rtError_t error = curCtx->Device_()->Driver_()->CloseIpcMem(vaData);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "close ipc memory failed, vptr=%#" PRIx64 ".", vaData);
        return error;
    }

    const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    for (auto mapIter = ipcMemNameMap.begin(); mapIter != ipcMemNameMap.end(); ++mapIter) {
        ipcMemInfo_t& info = mapIter->second;
        auto vaIter = std::find(info.vaList.begin(), info.vaList.end(), vaData);
        if (vaIter != info.vaList.end()) {
            (void)info.vaList.erase(vaIter);
            if (info.vaList.empty()) {
                (void)ipcMemNameMap.erase(mapIter);
            }
            RT_LOG(RT_LOG_DEBUG, "close ipc mem success, vptr=%#" PRIx64 ".", vaData);
            return error;
        }
    }
    RT_LOG(RT_LOG_WARNING, "ipc memory vptr=%#" PRIx64 " not found in map, may be closed already.", vaData);
    return RT_ERROR_NONE;
}

rtError_t IpcCloseMemoryByNameImpl(const char_t* const name)
{
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "closing the IPC shared memory");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const std::string ipcName(name);
    RT_LOG(RT_LOG_DEBUG, "start close ipc memory, name=%s.", ipcName.c_str());
    uint64_t va;
    bool nameNotFound = false;
    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it == ipcMemNameMap.end()) {
            nameNotFound = true;
        } else {
            // the case just set attr but not open, so vaList is empty, just return RT_ERROR_NONE
            if (it->second.vaList.empty()) {
                RT_LOG(RT_LOG_WARNING, "not import mem, should not close ipc memory by name=%s.", ipcName.c_str());
                (void)ipcMemNameMap.erase(it);
                return RT_ERROR_NONE;
            }
            va = it->second.vaList.front();
        }
    }

    if (nameNotFound) {
        RT_LOG(RT_LOG_DEBUG, "destroy ipc memory by IpcDestroyMemoryName, name=%s.", name);
        return curCtx->Device_()->Driver_()->DestroyIpcMem(name);
    }

    const rtError_t error = curCtx->Device_()->Driver_()->CloseIpcMem(va);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "close ipc mem failed, name=%s, va=%#" PRIx64 ".", ipcName.c_str(), va);
        return error;
    }

    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it != ipcMemNameMap.end()) {
            auto vaIter = std::find(it->second.vaList.begin(), it->second.vaList.end(), va);
            if (vaIter != it->second.vaList.end()) {
                (void)it->second.vaList.erase(vaIter);
            }

            if (it->second.vaList.empty()) {
                (void)ipcMemNameMap.erase(it);
            }
        }
    }

    RT_LOG(RT_LOG_DEBUG, "close ipc memory by CloseIpcMem, name=%s.", ipcName.c_str());
    return RT_ERROR_NONE;
}

rtError_t IpcDestroyMemoryNameImpl(const char_t* const name)
{
    RT_LOG(RT_LOG_DEBUG, "Destroy ipc memory. name=%s.", name);
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "destroying the IPC shared memory");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->DestroyIpcMem(name);
}

rtError_t SetIpcMemPidImpl(const char_t* const name, int32_t pid[], const int32_t num)
{
    RT_LOG(RT_LOG_DEBUG, "Set ipc mem pid. name=%s.", name);
    Runtime* const rtInstance = Runtime::Instance();
    Context* const curCtx = (rtInstance == nullptr) ? nullptr : rtInstance->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1005, "setting the trustlist of processes that can share memory through IPC");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->SetIpcMemPid(name, pid, num);
}

} // namespace

bool IsImplIpcMemorySupported() { return true; }

ApiIpcMemory* CreateImplIpcMemoryAndGet()
{
    ApiIpcMemory* const apiImplIpcMemory = new (std::nothrow) ApiImplIpcMemory();
    if (apiImplIpcMemory == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplIpcMemory), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplIpcMemory failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplIpcMemory:Runtime_alloc_size %zu bytes", sizeof(ApiImplIpcMemory));
    return apiImplIpcMemory;
}

void DestroyImplIpcMemory(ApiIpcMemory*& apiImplIpcMemory)
{
    delete apiImplIpcMemory;
    apiImplIpcMemory = nullptr;
}

rtError_t ApiImplIpcMemory::IpcSetMemoryName(
    const void* const ptr, const uint64_t byteCount, char_t* const name, const uint32_t len, const uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        ptr, RT_ERROR_INVALID_VALUE, "Setting the memory to be shared between processes");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        name, RT_ERROR_INVALID_VALUE, "Setting the memory to be shared between processes");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(byteCount, "Setting the memory to be shared between processes");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(len, "Setting the memory to be shared between processes");

    constexpr uint64_t maxFlag = RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags > maxFlag), RT_ERROR_INVALID_VALUE, "Setting the memory to be shared between processes", flags,
        "[0, " + std::to_string(maxFlag) + "]");

    const rtError_t error = IpcSetMemoryNameImpl(ptr, byteCount, name, len, flags);
    ERROR_RETURN(
        error, "Ipc set memory name failed, name=%s, byteCount=%#" PRIx64 ", len=%u(bytes)", name, byteCount, len);
    return error;
}

rtError_t ApiImplIpcMemory::IpcOpenMemory(void** const ptr, const char_t* const name, const uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        ptr, RT_ERROR_INVALID_VALUE, "Opening the shared memory between processes");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        name, RT_ERROR_INVALID_VALUE, "Opening the shared memory between processes");

    constexpr uint64_t maxFlag = RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags > maxFlag), RT_ERROR_INVALID_VALUE, "Opening the shared memory between processes", flags,
        "[0, " + std::to_string(maxFlag) + "]");

    const rtError_t error = IpcOpenMemoryImpl(ptr, name, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, error);
    ERROR_RETURN(error, "Ipc open memory failed, name=%s.", name);
    return error;
}

rtError_t ApiImplIpcMemory::IpcCloseMemory(const void* const ptr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Closing the IPC shared memory");

    const rtError_t error = IpcCloseMemoryImpl(ptr);
    ERROR_RETURN(error, "Ipc close memory failed.");
    return error;
}

rtError_t ApiImplIpcMemory::IpcCloseMemoryByName(const char_t* const name)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(name, RT_ERROR_INVALID_VALUE, "Closing the IPC shared memory");

    const rtError_t error = IpcCloseMemoryByNameImpl(name);
    ERROR_RETURN(error, "Ipc close memory failed.");
    return error;
}

rtError_t ApiImplIpcMemory::IpcDestroyMemoryName(const char_t* const name)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(name, RT_ERROR_INVALID_VALUE, "Destroying the IPC shared memory");

    const rtError_t error = IpcDestroyMemoryNameImpl(name);
    ERROR_RETURN(error, "Ipc destroy memory name failed, name=%s.", name);
    return error;
}

rtError_t ApiImplIpcMemory::SetIpcMemPid(const char_t* const name, int32_t pid[], const int32_t num)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        name, RT_ERROR_INVALID_VALUE, "Setting the trustlist of processes that can share memory through IPC");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        pid, RT_ERROR_INVALID_VALUE, "Setting the trustlist of processes that can share memory through IPC");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        num <= 0, RT_ERROR_INVALID_VALUE, "Setting the trustlist of processes that can share memory through IPC", num,
        "(0, " + std::to_string(MAX_INT32_NUM) + "]");
    return SetIpcMemPidImpl(name, pid, num);
}

rtError_t ApiImplIpcMemory::ShmemSetPodPid(
    const char* const name, const uint32_t sdid, int32_t pid[], const int32_t num)
{
    RT_LOG(RT_LOG_INFO, "Start to ShmemSetPodPid name=%s, sdid=%u, pid=%d", name, sdid, pid[0]);
    return NpuDriver::ShmemSetPodPid(name, sdid, pid, num);
}

} // namespace runtime
} // namespace cce
