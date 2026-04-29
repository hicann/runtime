/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "davinci_kernel_task.h"
#include "task_info.h"
#include "stars_cond_isa_helper.hpp"
#include "inner_thread_local.hpp"
#include "model_update_task.h"
#include "event.hpp"
#include "kernel_utils.hpp"


namespace cce {
namespace runtime {
namespace {
constexpr const uint32_t ASYNC_MEMORY_NUM = 2U;
constexpr uint8_t DSA_SQE_UPDATE_OFFSET = 16U;
} // namespace

TIMESTAMP_EXTERN(rtMemcpyAsync_drvDeviceGetTransWay);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemConvertAddr);

#if F_DESC("MemcpyAsyncTask")

#ifdef __RT_CFG_HOST_CHIP_HI3559A__
rtError_t AllocCpyTmpMem(TaskInfo * const taskInfo, uint32_t &cpyType,
                         const void *&src, void *&des, uint64_t size)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    rtError_t error = RT_ERROR_NONE;
    if ((cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) || (cpyType == RT_MEMCPY_HOST_TO_DEVICE)) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, stream->Device_()->Id_());
        } else {
            error = driver->DevMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size,
                                        RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        ERROR_RETURN(error, "Alloc src failed,size=%" PRIu64 "(bytes), device_id=%u, retCode=%#x",
                               size, stream->Device_()->Id_(), error);
        COND_RETURN_ERROR_MSG_INNER(memcpyAsyncTaskInfo->srcPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                                    "Alloc copy malloc failed, src ptr is null.");
        errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
            "Memcpy_s failed, retCode is %d, size is %" PRIu64 "", rc, size);
        src = (void *)memcpyAsyncTaskInfo->srcPtr;
    } else if ((cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) || (cpyType == RT_MEMCPY_DEVICE_TO_HOST)) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = des;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, stream->Device_()->Id_());
        } else {
            error = driver->DevMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size,
                                        RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        ERROR_RETURN(error, "Alloc dest failed, size=%u(bytes), device_id=%u, retCode=%#x",
            size, stream->Device_()->Id_(), error);
        COND_RETURN_ERROR_MSG_INNER(memcpyAsyncTaskInfo->desPtr == nullptr,
                                    RT_ERROR_MEMORY_ALLOCATION, "Malloc dest ptr failed.");
        des = (void *)memcpyAsyncTaskInfo->desPtr;
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    }
    return error;
}

#else
rtError_t AllocCpyTmpMem(TaskInfo * const taskInfo, uint32_t &cpyType,
                         const void *&srcAddr,
                         void *&desAddr,
                         const uint64_t addrSize)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    constexpr uint32_t ASYNC_MEMORY_ALIGN_SIZE = 64U;
    constexpr uint32_t ASYNC_MEMORY_SIZE = ASYNC_MEMORY_NUM * 64U;
    rtError_t error = RT_ERROR_NONE;
    if (cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < ASYNC_MEMORY_SIZE), RT_ERROR_INVALID_VALUE,
            "Malloc size too large, can't memory align! size=%" PRIu64 "(bytes)", addrSize);

        if (stream->Device_()->IsAddrFlatDev()) {
            error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->srcPtr, (addrSize + ASYNC_MEMORY_SIZE), stream->Device_()->Id_());
        } else {
            memcpyAsyncTaskInfo->srcPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
        }

        ERROR_RETURN(error, "HostMemAlloc failed, retCode=%#x", static_cast<uint32_t>(error));
        COND_PROC_RETURN_ERROR((memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            RT_LOG_INNER_DETAIL_MSG(RT_SYSTEM_INNER_ERROR, {"target", "size"},
            {"srcAddress", std::to_string(addrSize + ASYNC_MEMORY_SIZE)});,
            "alloc src address failed, malloc size is %" PRIu64,
            addrSize + ASYNC_MEMORY_SIZE);

        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) +
                                    static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE) -
                                    (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) %
                                    static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE));
        const errno_t rc = memcpy_s(reinterpret_cast<void *>(offset), addrSize, srcAddr, addrSize);
        if (stream->Device_()->IsAddrFlatDev()) {
            COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
                (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
                memcpyAsyncTaskInfo->srcPtr = nullptr;,
                "Memcpy_s failed, retCode is %d, size is %" PRIu64, rc, addrSize);
        } else {
            COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
                free(memcpyAsyncTaskInfo->srcPtr);
                memcpyAsyncTaskInfo->srcPtr = nullptr;,
                "Memcpy_s failed, retCode is %d, size is %" PRIu64, rc, addrSize);
        }
        srcAddr = reinterpret_cast<void *>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < ASYNC_MEMORY_SIZE), RT_ERROR_INVALID_VALUE,
            "Malloc size too large, can't memory align! size=%" PRIu64 "(bytes), valid range is [0, %" PRIu64 "]",
            addrSize, MAX_UINT64_NUM);
        memcpyAsyncTaskInfo->desPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
	    COND_PROC_RETURN_ERROR((memcpyAsyncTaskInfo->desPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            RT_LOG_INNER_DETAIL_MSG(RT_SYSTEM_INNER_ERROR, {"target", "size"},
            {"destAddress", std::to_string(addrSize + ASYNC_MEMORY_SIZE)});,
            "Malloc dest address failed, malloc size is %" PRIu64,
            (addrSize + ASYNC_MEMORY_SIZE));
        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) +
                                 static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE) -
                                 (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) %
                                 static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE));
        desAddr = reinterpret_cast<void *>(offset);
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    }  else {
        // no operation
    }
    return error;
}

rtError_t AllocCpyTmpMemForDavid(TaskInfo * const taskInfo, uint32_t &cpyType,
    const void *&srcAddr, void *&desAddr, const uint64_t addrSize)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    constexpr uint32_t asyncMemoryAlignSize = 64U;
    constexpr uint32_t asyncMemorySize = ASYNC_MEMORY_NUM * 64U;
    rtError_t error = RT_ERROR_NONE;
    if (cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < asyncMemorySize), RT_ERROR_INVALID_VALUE,
            "Malloc size too large, can't memory align! size=%" PRIu64 "(bytes)", addrSize);
        error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->srcPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
        COND_PROC_RETURN_ERROR((memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            RT_LOG_INNER_DETAIL_MSG(RT_SYSTEM_INNER_ERROR, {"target", "size"},
            {"srcAddress", std::to_string(addrSize + asyncMemorySize)});,
            "HostMemAlloc src address failed, malloc size is %" PRIu64, addrSize + asyncMemorySize);
        ERROR_RETURN(error, "HostMemAlloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) +
            static_cast<uint64_t>(asyncMemoryAlignSize) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) % static_cast<uint64_t>(asyncMemoryAlignSize));
        error = driver->MemCopySync(reinterpret_cast<void *>(offset), addrSize, srcAddr, addrSize, RT_MEMCPY_HOST_TO_HOST);
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, error,
            (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
            memcpyAsyncTaskInfo->srcPtr = nullptr;,
            "MemCopySync failed, retCode is %d, size is %" PRIu64, error, addrSize);
        srcAddr = reinterpret_cast<void *>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < asyncMemorySize), RT_ERROR_INVALID_VALUE,
            "Malloc size too large, can't memory align! size=%" PRIu64 "(bytes), valid range is [0, %" PRIu64 "]",
            addrSize, MAX_UINT64_NUM);
        error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->desPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
	    COND_PROC_RETURN_ERROR((memcpyAsyncTaskInfo->desPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            RT_LOG_INNER_DETAIL_MSG(RT_SYSTEM_INNER_ERROR, {"target", "size"},
            {"destAddress", std::to_string(addrSize + asyncMemorySize)});,
            "HostMemAlloc dest address failed, malloc size is %" PRIu64,
            (addrSize + asyncMemorySize));
        ERROR_RETURN(error, "HostMemAlloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) +
                                 static_cast<uint64_t>(asyncMemoryAlignSize) -
                                 (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) %
                                 static_cast<uint64_t>(asyncMemoryAlignSize));
        desAddr = reinterpret_cast<void *>(offset);
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    }  else {
        // no operation
    }
    return error;
}
#endif

rtError_t AllocCpyTmpMemFor3588(TaskInfo * const taskInfo, uint32_t &cpyType,
                                const void *&src, void *&des, uint64_t size)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = stream->Device_()->Driver_();
    rtError_t error = RT_ERROR_NONE;
    if ((cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) || (cpyType == RT_MEMCPY_HOST_TO_DEVICE)) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, stream->Device_()->Id_());
        } else {
            error = driver->DevMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size,
                                        RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->srcPtr == nullptr),
                                    RT_ERROR_MEMORY_ALLOCATION,
                                    "Alloc mem failed err=%#x,size=%" PRIu64 "(bytes),devId=%u.",
                                    error, size, stream->Device_()->Id_());
        const errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, rc != EOK, RT_ERROR_SEC_HANDLE,
            "Memcpy_s failed, retCode is %d, size is %" PRIu64 "", rc, size);
        src = (void *)memcpyAsyncTaskInfo->srcPtr;
    } else if ((cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) || (cpyType == RT_MEMCPY_DEVICE_TO_HOST)) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = des;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, stream->Device_()->Id_());
        } else {
            error = driver->DevMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size,
                                        RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->desPtr == nullptr),
                                    RT_ERROR_MEMORY_ALLOCATION,
                                    "Malloc dest ptr failed, err=%#x, size=%" PRIu64 "(bytes), devId:%u.",
                                    error, size, stream->Device_()->Id_());
        des = (void *)memcpyAsyncTaskInfo->desPtr;
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    } else {
        // no operation
    }
    return error;
}

void ReleaseCpyTmpMemFor3588(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = stream->Device_()->Driver_();

    if (memcpyAsyncTaskInfo->srcPtr != nullptr) {
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
        } else {
            driver->DevMemFree(memcpyAsyncTaskInfo->srcPtr, stream->Device_()->Id_());
        }
        memcpyAsyncTaskInfo->srcPtr = nullptr;
    }

    if (memcpyAsyncTaskInfo->desPtr != nullptr) {
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            driver->HostMemFree(memcpyAsyncTaskInfo->desPtr);
        } else {
            driver->DevMemFree(memcpyAsyncTaskInfo->desPtr, stream->Device_()->Id_());
        }
        memcpyAsyncTaskInfo->desPtr = nullptr;
    }
}

rtError_t MemcpyAsyncTaskCommonInit(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MEMCPY;
    taskInfo->typeName = const_cast<char_t*>("MEMCPY_ASYNC");
    memcpyAsyncTaskInfo->copyType = 0U;
    memcpyAsyncTaskInfo->copyMethod = 0U;
    memcpyAsyncTaskInfo->copyKind = 0U;
    memcpyAsyncTaskInfo->size = 0U;
    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->srcPtr = nullptr;
    memcpyAsyncTaskInfo->desPtr = nullptr;
    memcpyAsyncTaskInfo->originalDes = nullptr;
    memcpyAsyncTaskInfo->releaseArgHandle = nullptr;
    memcpyAsyncTaskInfo->copyDataType = 0U;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->sqeOffset = 0U;
    memcpyAsyncTaskInfo->dmaKernelConvertFlag = false;
    memcpyAsyncTaskInfo->dsaSqeUpdateFlag = false;
    memcpyAsyncTaskInfo->sqId = 0U;
    memcpyAsyncTaskInfo->taskPos = 0U;
    memcpyAsyncTaskInfo->d2dOffsetFlag = false;
    memcpyAsyncTaskInfo->isD2dCross = false;
    memcpyAsyncTaskInfo->isSqeUpdateH2D = false;
    memcpyAsyncTaskInfo->isSqeUpdateD2H = false;
    memcpyAsyncTaskInfo->isConcernedRecycle = false;

    memcpyAsyncTaskInfo->ubDma.isUbAsyncMode = false;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.fixed_size = 0U;
    memcpyAsyncTaskInfo->dmaAddr.virt_id = 0U;
    memcpyAsyncTaskInfo->memcpyAddrInfo = nullptr;
    if (memcpyAsyncTaskInfo->guardMemVec == nullptr) {
        memcpyAsyncTaskInfo->guardMemVec = new (std::nothrow) std::vector<std::shared_ptr<void>>();
        COND_RETURN_ERROR_MSG_INNER(memcpyAsyncTaskInfo->guardMemVec == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "memcpyAsyncTaskInfo->guardMemVec new memory fail!");
        taskInfo->needPostProc = true;
    }
    return RT_ERROR_NONE;
}

uint32_t GetSqeNumForMemcopyAsync(const rtMemcpyKind_t kind, bool isModelByUb, uint32_t cpyType, uint32_t cpyMethod)
{
    if (!Runtime::Instance()->GetConnectUbFlag()) {
        return 1U;
    }
    // ub图下沉场景
    if (isModelByUb) {
        return 1U;
    }

    // UB 2D异步拷贝和批量异步拷贝需要1个sqe ub db
    if (cpyMethod == RT_ASYNC_CPY_BATCH || cpyMethod == RT_ASYNC_CPY_2D) {
        return 1U;
    }

    // 单算子
    if ((kind == RT_MEMCPY_HOST_TO_DEVICE) || (kind == RT_MEMCPY_DEVICE_TO_HOST) ||
        (kind == RT_MEMCPY_HOST_TO_DEVICE_EX) || (kind == RT_MEMCPY_DEVICE_TO_HOST_EX) ||
        (cpyType == RT_MEMCPY_DIR_D2D_UB)) {
        return 2U;
    }
    return 1U;
}

rtError_t ConvertD2DCpyType(const Stream *const stm, uint32_t &cpyType, const void *const srcAddr, void *const desAddr)
{
    Driver *const driver = stm->Device_()->Driver_();
    uint8_t transType = 0U;
    TIMESTAMP_BEGIN(rtMemcpyAsync_drvDeviceGetTransWay);
    const rtError_t error = driver->GetTransWayByAddr(RtPtrToUnConstPtr<void *>(srcAddr), desAddr, &transType);
    TIMESTAMP_END(rtMemcpyAsync_drvDeviceGetTransWay);

    ERROR_RETURN_MSG_INNER(
        error, "D2D memcpy async, get channel type failed, retCode=%#x.", static_cast<uint32_t>(error));

    switch (transType) {
        case RT_MEMCPY_CHANNEL_TYPE_PCIe:
            cpyType = RT_MEMCPY_DIR_D2D_PCIe;
            RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_D2D_PCIe, direct= %u", cpyType);
            break;
        case RT_MEMCPY_CHANNEL_TYPE_HCCs:
            cpyType = RT_MEMCPY_DIR_D2D_HCCs;
            RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_D2D_HCCs, direct= %u", cpyType);
            break;
        case RT_MEMCPY_CHANNEL_TYPE_UB:
            cpyType = RT_MEMCPY_DIR_D2D_UB;
            RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType RT_MEMCPY_DIR_D2D_UB, direct= %u", cpyType);
            break;
        default:
            cpyType = RT_MEMCPY_DIR_D2D_SDMA;
            RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_D2D_SDMA, direct= %u", cpyType);
            break;
    }
    return RT_ERROR_NONE;
}

rtError_t ConvertCpyType(TaskInfo * const taskInfo, const uint32_t cpyType,
                         const void *const srcAddr, void *const desAddr)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->copyKind = cpyType;
    uint32_t copyTypeTmp;

    RT_LOG(RT_LOG_DEBUG, "MemcpyAsyncTask::ConvertCpyType, cpyType=%u.", cpyType);

    if (cpyType == RT_MEMCPY_HOST_TO_DEVICE) {
        copyTypeTmp = RT_MEMCPY_DIR_H2D;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_HOST_TO_DEVICE, direct=%u.", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST) {
        copyTypeTmp = RT_MEMCPY_DIR_D2H;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DEVICE_TO_HOST, direct=%u.", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_DEVICE) {
        const rtError_t error = ConvertD2DCpyType(taskInfo->stream, copyTypeTmp, srcAddr, desAddr);
        ERROR_RETURN_MSG_INNER(error, "D2D memcpy async, ConvertD2DCpyType failed, retCode=%#x.", static_cast<uint32_t>(error));
    } else if (cpyType == RT_MEMCPY_SDMA_AUTOMATIC_ADD) {
        copyTypeTmp = RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_SDMA_AUTOMATIC_ADD, direct= %u", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_SDMA_AUTOMATIC_MAX) {
        copyTypeTmp = RT_MEMCPY_DIR_SDMA_AUTOMATIC_MAX;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_SDMA_AUTOMATIC_MAX, direct= %u", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_SDMA_AUTOMATIC_MIN) {
        copyTypeTmp = RT_MEMCPY_DIR_SDMA_AUTOMATIC_MIN;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_SDMA_AUTOMATIC_MIN, direct= %u", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL) {
        copyTypeTmp = RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL;
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ConvertCpyType MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL, direct= %u", copyTypeTmp);
    } else if (cpyType == RT_MEMCPY_ADDR_DEVICE_TO_DEVICE) {
        copyTypeTmp = RT_MEMCPY_ADDR_D2D_SDMA;
    } else {
        copyTypeTmp = memcpyAsyncTaskInfo->copyKind;
    }

    memcpyAsyncTaskInfo->copyType = copyTypeTmp;

    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskInitV1(TaskInfo * const taskInfo, void *memcpyAddrInfo, const uint64_t cpySize)
{
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V1 failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());

    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->memcpyAddrInfo = memcpyAddrInfo;
    memcpyAsyncTaskInfo->size = cpySize;

    // use copyKind_ = RT_MEMCPY_RESERVED to distinguish from the ptr_mode=0 mode
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTaskInfo->copyKind = RT_MEMCPY_RESERVED;
    RT_LOG(RT_LOG_DEBUG, "MemcpyAsyncPtr Task Init, devId=%d, cpySize=%" PRIu64,
        devId, cpySize);
    return RT_ERROR_NONE;
}

rtError_t ConvertAsyncDma2D(TaskInfo * const taskInfo2D, void *const dst, const uint64_t dstPitch,
                                const void *const src, const uint64_t srcPitch, const uint64_t width,
                                const uint64_t height, const uint64_t fixedSize)
{
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG(RT_LOG_ERROR, "pcie does not support");
        return RT_ERROR_INVALID_VALUE;
    }   

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo2D->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo2D->stream;
    Driver * const driver = taskInfo2D->stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    AsyncDmaWqeInputInfo2D input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo2D), 0, sizeof(AsyncDmaWqeInputInfo2D));
    memcpyAsyncTaskInfo->ubDma.isUbAsyncMode = true;

    input.tsId = stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();
    input.dst = dst;
    input.dpitch = dstPitch;
    input.src = const_cast<void *>(src);
    input.spitch = srcPitch;
    input.width = width;
    input.height = height;
    input.fixedSize = fixedSize;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqe2D(devId, input, &output);
    ERROR_RETURN_MSG_INNER(error, "drv create asyncDmaWqe2D failed, retCode=%#x.", static_cast<uint32_t>(error));

    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.pi = output.pi;
    memcpyAsyncTaskInfo->ubDma.fixedSize = output.fixedSize;
    memcpyAsyncTaskInfo->size = output.fixedSize;

    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskInitV2(TaskInfo * const taskInfo, void *const dst, const uint64_t dstPitch,
                                const void *const srcAddr, const uint64_t srcPitch, const uint64_t width,
                                const uint64_t height, const uint32_t kind, const uint64_t fixedSize)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V2 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    if (kind == RT_MEMCPY_HOST_TO_DEVICE) {
        memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_H2D;
    } else if (kind == RT_MEMCPY_DEVICE_TO_HOST) {
        memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_D2H;
    } else if (kind == RT_MEMCPY_DEVICE_TO_DEVICE){
        error = ConvertCpyType(taskInfo, kind, srcAddr, dst);
        ERROR_RETURN_MSG_INNER(error, "Convert copy type failed, retCode=%#x, kind=%u", error, kind);
    } else {
        // reserve
    }

    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(stream->Device_()->Id_());
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    // d2d copy data convert
    if ((copyType == RT_MEMCPY_DIR_D2D_SDMA) || (copyType == RT_MEMCPY_DIR_D2D_HCCs) || (copyType == RT_MEMCPY_DIR_D2D_PCIe)) {
        memcpyAsyncTaskInfo->src = const_cast<void *>(srcAddr);
        memcpyAsyncTaskInfo->destPtr = dst;
        RT_LOG(RT_LOG_DEBUG, "MemcpyAsync2dTask Init, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64
        ", width=%" PRIu64 ", height=%" PRIu64 ", fixedSize:%" PRIu64 ", copyType=%u.",
        dstPitch, srcPitch, width, height, fixedSize, memcpyAsyncTaskInfo->copyType);
        // copy one line data once time
        memcpyAsyncTaskInfo->size = width;
        return RT_ERROR_NONE;
    } else {
        // david UB 单算子场景 走 UB Doorbell模式
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType) && !stream->GetBindFlag()) {
            error = ConvertAsyncDma2D(taskInfo, dst, dstPitch, srcAddr, srcPitch, width, height, fixedSize);
            ERROR_RETURN_MSG_INNER(error, "ConvertAsyncDma2D failed, retCode=%#x.", error);
            memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
        } else {
            // d2h or h2d data convert
            error = driver->MemCopy2D(dst, dstPitch, srcAddr, srcPitch, width, height, kind,
                DEVMM_MEMCPY2D_ASYNC_CONVERT, fixedSize, &(memcpyAsyncTaskInfo->dmaAddr));
            ERROR_RETURN_MSG_INNER(error, "invoke rtMemcpy2DAsync failed, retCode=%#x.", error);
            memcpyAsyncTaskInfo->isConcernedRecycle = true;
            memcpyAsyncTaskInfo->size = memcpyAsyncTaskInfo->dmaAddr.fixed_size;
            if (stream->Device_()->IsDavidPlatform() && IsPcieDma(memcpyAsyncTaskInfo->copyType) && !(Runtime::Instance()->GetConnectUbFlag())) {
                memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
            }
            RT_LOG(RT_LOG_DEBUG, "MemcpyAsync2dTask Init, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64
            ", width=%" PRIu64 ", height=%" PRIu64 ", fixedSize:%" PRIu64 ", copyType=%u, dmaKernelConvertFlag=%u.",
            dstPitch, srcPitch, width, height, fixedSize, memcpyAsyncTaskInfo->copyType, memcpyAsyncTaskInfo->dmaKernelConvertFlag);
        }
        return RT_ERROR_NONE;
    }
}

rtError_t ConvertAsyncDma(TaskInfo * const taskInfo, TaskInfo * const updateTaskInfo, bool isSqeUpdate)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    AsyncDmaWqeInputInfo input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo), 0, sizeof(AsyncDmaWqeInputInfo));
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    memcpyAsyncTaskInfo->ubDma.isUbAsyncMode = isUbMode ? true : false;

    if (isSqeUpdate) {
        input.info.sqe_pos = updateTaskInfo->id;
        input.info.sqId = updateTaskInfo->stream->GetSqId();
        input.tsId = updateTaskInfo->stream->Device_()->DevGetTsId();
    } else {
        if (isUbMode) {
            input.destPtr = memcpyAsyncTaskInfo->destPtr;
            input.tsId = stream->Device_()->DevGetTsId();
        } else {
            RT_LOG(RT_LOG_ERROR, "pcie does not support");
            return RT_ERROR_INVALID_VALUE;
        }
    }
    input.sqId = stream->GetSqId();
    input.src = memcpyAsyncTaskInfo->src;
    input.size = memcpyAsyncTaskInfo->size;
    input.cpyType = memcpyAsyncTaskInfo->copyType;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, isUbMode, isSqeUpdate);
    ERROR_RETURN_MSG_INNER(error, "drv create asyncDmaWqe failed, retCode=%#x.", static_cast<uint32_t>(error));
    if (isUbMode) {
        // 模型场景下驱动接口wqe返回空，wqeLen返回0，不使用这两个参数
        memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
        memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
        memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
        memcpyAsyncTaskInfo->ubDma.wqeLen = output.wqeLen;
        memcpyAsyncTaskInfo->ubDma.wqePtr = output.wqe;
        memcpyAsyncTaskInfo->ubDma.pi = 1U;
        if (output.wqeLen != 0) {
            const errno_t ret = memcpy_s(memcpyAsyncTaskInfo->ubDma.wqe.data(), sizeof(rtDavidSqe_t),
                output.wqe, static_cast<size_t>(output.wqeLen));
            COND_LOG_ERROR(ret != EOK, "Memcpy_s failed, retCode=%d, size=%zu(bytes).",
                ret, static_cast<size_t>(output.wqeLen));
        }
    } else {
         memcpyAsyncTaskInfo->dmaAddr = output.dmaAddr;
    }
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskInitV3(TaskInfo * const taskInfo, uint32_t cpyType, const void *srcAddr,
    void *desAddr, const uint64_t cpySize, const rtTaskCfgInfo_t *cfgInfo, const rtD2DAddrCfgInfo_t * const addrCfg)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V3 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);

    if (Runtime::Instance()->isRK3588HostCpu()) {
        error = AllocCpyTmpMemFor3588(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    } else if (stream->Device_()->IsDavidPlatform()){
        error = AllocCpyTmpMemForDavid(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    } else {
        error = AllocCpyTmpMem(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    }
    ERROR_RETURN_MSG_INNER(error, "Alloc copy memory failed, retCode=%#x, size=%" PRIu64 "(bytes)", error, cpySize);

    error = ConvertCpyType(taskInfo, cpyType, srcAddr, desAddr);
    ERROR_RETURN_MSG_INNER(error, "Convert copy type failed, retCode=%#x, size=%" PRIu64 "(bytes).",
        error, cpySize);
    memcpyAsyncTaskInfo->size = cpySize;
    if (cfgInfo != nullptr) {
        memcpyAsyncTaskInfo->qos = cfgInfo->qos;
        memcpyAsyncTaskInfo->partId = cfgInfo->partId;
        if (cfgInfo->d2dCrossFlag == true) {
            memcpyAsyncTaskInfo->isD2dCross = cfgInfo->d2dCrossFlag;
        }
    } else {
        memcpyAsyncTaskInfo->qos = 0U;
        memcpyAsyncTaskInfo->partId = 0U;
    }
    RT_LOG(RT_LOG_INFO, "Init qos=%u, partId=%u.", memcpyAsyncTaskInfo->qos, memcpyAsyncTaskInfo->partId);

    memcpyAsyncTaskInfo->d2dOffsetFlag = false;
    if (addrCfg != nullptr) {
        memcpyAsyncTaskInfo->d2dOffsetFlag = true;
        memcpyAsyncTaskInfo->dstOffset = addrCfg->dstOffset;
        memcpyAsyncTaskInfo->srcOffset = addrCfg->srcOffset;
        RT_LOG(RT_LOG_INFO, "cpySize=%llu, srcOffset=%llu, dstOffset=%llu.",
            memcpyAsyncTaskInfo->size,  memcpyAsyncTaskInfo->srcOffset, memcpyAsyncTaskInfo->dstOffset);
    }

    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA && !stream->Device_()->IsDavidPlatform()) {
        uint64_t sourceAddr;
        uint64_t destAddr;
        error = driver->MemAddressTranslate(devId, reinterpret_cast<uintptr_t>(srcAddr), &sourceAddr);
        ERROR_RETURN_MSG_INNER(error,
            "Convert D2D source memory address from virtual to physic failed, retCode=%#x.", error);
        error = driver->MemAddressTranslate(devId, reinterpret_cast<uintptr_t>(desAddr), &destAddr);
        ERROR_RETURN_MSG_INNER(error,
            "Convert D2D dest memory address from virtual to dma physic failed, retCode=%#x.", error);

        memcpyAsyncTaskInfo->src = reinterpret_cast<void *>(static_cast<uintptr_t>(sourceAddr));
        memcpyAsyncTaskInfo->destPtr = reinterpret_cast<void *>(static_cast<uintptr_t>(destAddr));
    } else {
        memcpyAsyncTaskInfo->src = const_cast<void *>(srcAddr);
        memcpyAsyncTaskInfo->destPtr = desAddr;
    }

    if (stream->Device_()->IsStarsPlatform()) {
        memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
        RT_LOG(RT_LOG_INFO, "CopyType=%u: use virtual address directly.", copyType);
        if (!stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_PCIE_DMA_ASYNC_WITH_USER_VA)) {
            return RT_ERROR_NONE;
        }
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
            error = ConvertAsyncDma(taskInfo, nullptr);
            ERROR_RETURN_MSG_INNER(error, "ConvertAsyncDma failed, retCode=%#x.", error);
            taskInfo->needPostProc = true;
        } else if (IsPcieDma(memcpyAsyncTaskInfo->copyType) && (driver->GetRunMode() == RT_RUN_MODE_ONLINE)) {
            error = driver->MemConvertAddr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcAddr)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(desAddr)), cpySize, &(memcpyAsyncTaskInfo->dmaAddr));
            ERROR_RETURN_MSG_INNER(error,
                "Convert memory address from virtual to dma physical failed, retCode=%#x.", error);
            memcpyAsyncTaskInfo->size = memcpyAsyncTaskInfo->dmaAddr.fixed_size;
            taskInfo->needPostProc = true;
        } else {
            // 除DavidUbDma和PcieDma之外的其他情况不处理
        }
        return RT_ERROR_NONE;
    }

    // pcie
    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA)) {
        TIMESTAMP_BEGIN(rtMemcpyAsync_drvMemConvertAddr);
        error = driver->MemConvertAddr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcAddr)),
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(desAddr)), cpySize, &(memcpyAsyncTaskInfo->dmaAddr));
        TIMESTAMP_END(rtMemcpyAsync_drvMemConvertAddr);
        ERROR_RETURN_MSG_INNER(error,
            "Convert memory address from virtual to dma physical failed, retCode=%#x.", error);
        // dmaAddr.fixed_size may not be equal to size
        memcpyAsyncTaskInfo->size = memcpyAsyncTaskInfo->dmaAddr.fixed_size;
    }

    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncD2HTaskInit(TaskInfo * const taskInfo, const void *srcAddr, const uint64_t cpySize,
                                 uint32_t sqId, uint32_t pos)
{
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncD2HTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->copyKind = static_cast<uint32_t>(RT_MEMCPY_DEVICE_TO_HOST);
    memcpyAsyncTaskInfo->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_D2H);
    memcpyAsyncTaskInfo->size = cpySize;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->src = const_cast<void *>(srcAddr);
    memcpyAsyncTaskInfo->dsaSqeUpdateFlag = true;
    memcpyAsyncTaskInfo->sqId = sqId;
    memcpyAsyncTaskInfo->taskPos = pos;
    memcpyAsyncTaskInfo->sqeOffset = DSA_SQE_UPDATE_OFFSET;

    RT_LOG(RT_LOG_INFO, "dev_id=%d, stream_id=%d, sqId=%u, pos=%u",
        devId, stream->Id_(), memcpyAsyncTaskInfo->sqId, memcpyAsyncTaskInfo->taskPos);

    return RT_ERROR_NONE;
}

void ToCommandBodyForMemcpyAsyncTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;

    command->u.memcpyTask.dir = static_cast<uint8_t>(copyType);
    command->u.memcpyTask.d2dOffsetFlag = 0U;
    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask::ToCommandBody, command->u.memcpyTask.dir=%u.",
        static_cast<uint32_t>(command->u.memcpyTask.dir));

    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA)) {
        command->u.memcpyTask.memcpyType = memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag; // single copy
        command->u.memcpyTask.length = memcpyAsyncTaskInfo->dmaAddr.phyAddr.len;
        command->u.memcpyTask.srcBaseAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src));
        command->u.memcpyTask.dstBaseAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst));
        command->u.memcpyTask.dmaOffsetAddr.offset = memcpyAsyncTaskInfo->dmaAddr.offsetAddr.offset;
        command->u.memcpyTask.isAddrConvert = RT_DMA_ADDR_CONVERT;
    } else {
        command->u.memcpyTask.memcpyType = 0U;  // single copy
        command->u.memcpyTask.length = memcpyAsyncTaskInfo->size;
        command->u.memcpyTask.srcBaseAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src));
        command->u.memcpyTask.dstBaseAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->destPtr));
        command->u.memcpyTask.dmaOffsetAddr.offset = 0LU;
        command->u.memcpyTask.isAddrConvert = RT_NOT_NEED_CONVERT;
        command->u.memcpyTask.copyDataType = memcpyAsyncTaskInfo->copyDataType;
    }
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA) {
        command->u.memcpyTask.isAddrConvert = RT_NO_DMA_ADDR_CONVERT;
        if (memcpyAsyncTaskInfo->d2dOffsetFlag) {
            command->u.memcpyTask.d2dOffsetFlag = 1U;
            command->u.memcpyTask.d2dAddrOffset.srcOffsetLow =
                static_cast<uint32_t>(memcpyAsyncTaskInfo->srcOffset & 0x00000000FFFFFFFFULL);
            command->u.memcpyTask.d2dAddrOffset.dstOffsetLow =
                static_cast<uint32_t>(memcpyAsyncTaskInfo->dstOffset & 0x00000000FFFFFFFFULL);
            command->u.memcpyTask.d2dAddrOffset.srcOffsetHigh =
                static_cast<uint16_t>((memcpyAsyncTaskInfo->srcOffset & 0x0000FFFF00000000ULL) >> UINT32_BIT_NUM);
            command->u.memcpyTask.d2dAddrOffset.dstOffsetHigh =
                static_cast<uint16_t>((memcpyAsyncTaskInfo->dstOffset & 0x0000FFFF00000000ULL) >> UINT32_BIT_NUM);

            RT_LOG(RT_LOG_INFO, "command offset=%hu-%u-%hu-%u",
                command->u.memcpyTask.d2dAddrOffset.srcOffsetHigh,
                command->u.memcpyTask.d2dAddrOffset.srcOffsetLow,
                command->u.memcpyTask.d2dAddrOffset.dstOffsetHigh,
                command->u.memcpyTask.d2dAddrOffset.dstOffsetLow);
        } else {
            command->u.memcpyTask.noDmaOffsetAddr.srcVirAddr = MAX_UINT32_NUM;
            command->u.memcpyTask.noDmaOffsetAddr.dstVirAddr = MAX_UINT32_NUM;
        }
    }
    command->taskInfoFlag = stream->GetTaskRevFlag(taskInfo->bindFlag);
    RT_LOG(RT_LOG_INFO, "command d2dOffsetFlag=%u", command->u.memcpyTask.d2dOffsetFlag);
}

void SetStarsResultForMemcpyAsyncTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if ((logicCq.errorType & CQE_ERROR_MAP_TIMEOUT) != 0U) {
            taskInfo->errorCode = TS_ERROR_SDMA_TIMEOUT;
        } else if (logicCq.errorCode == TS_ERROR_SDMA_OVERFLOW) {
            taskInfo->errorCode = TS_ERROR_SDMA_OVERFLOW;
        } else {
            taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
        }
    }
}

bool GetModuleIdByMemcpyAddr(Driver * const driver, void *memcpyAddr, uint32_t *moduleId)
{
    if (driver == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get module id failed, driver is nullptr.");
        return false;
    }
    const rtError_t ret = driver->GetAddrModuleId(memcpyAddr, moduleId);
    if (ret != RT_ERROR_NONE) {
        return false;
    }
    return true;
}

void PrintModuleIdProc(Driver * const driver, char_t * const errStr, void *src, void *dst, int32_t *count)
{
    int32_t countNum = *count;
    uint32_t srcModuleId = static_cast<uint32_t>(SVM_INVALID_MODULE_ID);
    uint32_t dstModuleId = static_cast<uint32_t>(SVM_INVALID_MODULE_ID);
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void *>(&src), &srcModuleId)) {
        if (srcModuleId == static_cast<uint32_t>(SVM_INVALID_MODULE_ID)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", src_module_id not find");
        } else {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", src_module_id=%u", srcModuleId);
        }
    }
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void *>(&dst), &dstModuleId)) {
        if (dstModuleId == static_cast<uint32_t>(SVM_INVALID_MODULE_ID)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", dst_module_id not find");
        } else {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),", dst_module_id=%u", dstModuleId);
        }
    }

    *count = countNum;
}

static void PrintUbdmaErrorInfo(const MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo)
{
    if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
        RT_LOG(RT_LOG_ERROR, "ub async copy error, die_id=%u, functionId=%u, jettyId=%u,"
            " wqeLen=%d, is_ub_mode=%d, is_sqe_update=%d, pi=%u, fixedSize(fixedCnt)=%llu.",
            memcpyAsyncTaskInfo->ubDma.dieId, memcpyAsyncTaskInfo->ubDma.functionId, memcpyAsyncTaskInfo->ubDma.jettyId,
            memcpyAsyncTaskInfo->ubDma.wqeLen, memcpyAsyncTaskInfo->ubDma.isUbAsyncMode,
            memcpyAsyncTaskInfo->isSqeUpdateH2D, memcpyAsyncTaskInfo->ubDma.pi, memcpyAsyncTaskInfo->ubDma.fixedSize);
    }
}

void PrintErrorInfoForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    const int32_t streamId = stream->Id_();

    PrintUbdmaErrorInfo(memcpyAsyncTaskInfo);

    char_t errMsg[MSG_LENGTH] = {};
    char_t * const errStr = errMsg;
    int32_t countNum = sprintf_s(errStr, static_cast<size_t>(MSG_LENGTH),
        "Memory async copy failed, device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu, ",
        devId, streamId, taskInfo->id, taskInfo->flipNum);
    COND_RETURN_VOID((countNum < 0) || (countNum > MSG_LENGTH), "sprintf_s failed, count=%d", countNum)

    Stream *const reportStream = GetReportStream(stream);
    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA)
        && (!memcpyAsyncTaskInfo->dmaKernelConvertFlag)) {
        if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
            countNum += sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%u, sq_id=%u, task_pos=%u, cp_size=%#" PRIx64,
                copyType, memcpyAsyncTaskInfo->sqId, memcpyAsyncTaskInfo->taskPos, memcpyAsyncTaskInfo->size);
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS, "%s", errStr);
            (void)snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_dev_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)));
        } else {
            countNum += sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%u, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%u",
                copyType, static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS, "%s", errStr);
            (void)snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst)));
        }
    } else {
        countNum += sprintf_s(errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
            "copy_type=%u, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%" PRIu64, copyType,
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->size);
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL, "%s", errStr);

        if ((copyKind == RT_MEMCPY_RESERVED) && (copyType == RT_MEMCPY_ADDR_D2D_SDMA)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", memcpyAddrInfo=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->memcpyAddrInfo)));
            rtMemcpyAddrInfo addrInfo;
            const rtError_t ret = driver->MemCopySync(&addrInfo, sizeof(rtMemcpyAddrInfo),
                memcpyAsyncTaskInfo->memcpyAddrInfo, sizeof(rtMemcpyAddrInfo), RT_MEMCPY_DEVICE_TO_HOST);
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "MemCopySync failed, retCode=%#x.", ret);
            } else {
                countNum += snprintf_truncated_s(errStr + countNum,
                    static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum),
                    ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64, addrInfo.src, addrInfo.dst);
                PrintModuleIdProc(driver, errStr, reinterpret_cast<void *>(addrInfo.src),
                    reinterpret_cast<void *>(addrInfo.dst), &countNum);
            }
        } else {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->destPtr)));
            PrintModuleIdProc(driver, errStr, memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr, &countNum);
        }
    }
    RT_LOG(RT_LOG_ERROR, "%s.", errStr);
}

void RecycleTaskResourceForMemcpyAsyncTask(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if ((memcpyAsyncTaskInfo->desPtr != nullptr) &&
        (memcpyAsyncTaskInfo->originalDes != nullptr) && (memcpyAsyncTaskInfo->destPtr != nullptr)) {
        const errno_t rc = memcpy_s(memcpyAsyncTaskInfo->originalDes, memcpyAsyncTaskInfo->size,
                                    memcpyAsyncTaskInfo->destPtr, memcpyAsyncTaskInfo->size);
        COND_RETURN_VOID(rc != EOK, "memcpy_s failed, retCode=%d srcSize=%" PRIu64 ", dstSize=%" PRIu64,
            rc, memcpyAsyncTaskInfo->size, memcpyAsyncTaskInfo->size);
    }
}

uint8_t ReduceOpcodeHigh(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    uint8_t opcode;
    const int32_t switchFlag = static_cast<int32_t>(memcpyAsyncTaskInfo->copyDataType);
    switch (switchFlag) {
        case RT_DATA_TYPE_INT8: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT8);
            break;
        }
        case RT_DATA_TYPE_INT16: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT16);
            break;
        }
        case RT_DATA_TYPE_INT32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT32);
            break;
        }
        case RT_DATA_TYPE_FP16: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_FP16);
            break;
        }
        case RT_DATA_TYPE_FP32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_FP32);
            break;
        }
        case RT_DATA_TYPE_BFP16: {
            if (Runtime::Instance()->ChipIsHaveStars()) {
                opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_BFP16);
            } else {
                RT_LOG(RT_LOG_WARNING, "DataType=%u is out of range or not support.",
                    static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType));
                opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            }
            break;
        }
        default: {
            // Should not run here.
            // if not support, it will return RT_ERROR_FEATURE_NOT_SUPPORT at context.cc's reduce ability check.
            // Only for code style, 0x80 is reserved value of STRAS opcode.
            RT_LOG(RT_LOG_WARNING, "DataType=%u is out of range or not support.",
                   static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType));
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            break;
        }
    }
    return opcode;
}

uint8_t ReduceOpcodeLow(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    uint8_t opcode;
    switch (memcpyAsyncTaskInfo->copyKind) {
        case RT_MEMCPY_SDMA_AUTOMATIC_ADD: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_ADD);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_MAX: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_MAX);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_MIN: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_MIN);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_EQUAL: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_EQUAL);
            break;
        }
        default: {
            RT_LOG(RT_LOG_WARNING, "Type out of range: copyKind=%u", memcpyAsyncTaskInfo->copyKind);
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            break;
        }
    }
    return opcode;
}

uint8_t GetOpcodeForReduce(TaskInfo * const taskInfo)
{
    const uint8_t opcodeHigh = ReduceOpcodeHigh(taskInfo);
    const uint8_t opcodeLow = ReduceOpcodeLow(taskInfo);
    if ((static_cast<int32_t>(opcodeHigh) == RT_STARS_MEMCPY_ASYNC_OP_RESERVED) ||
        (static_cast<int32_t>(opcodeLow) == RT_STARS_MEMCPY_ASYNC_OP_RESERVED)) {
        // Should not run here. 0x80 is reserved value of STARS opcode
        return static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
    } else {
        return opcodeHigh | opcodeLow;
    }
}

bool IsPcieDma(const uint32_t copyTypeFlag)
{
    if ((copyTypeFlag == RT_MEMCPY_DIR_H2D) || (copyTypeFlag == RT_MEMCPY_DIR_D2H)
        || (copyTypeFlag == RT_MEMCPY_DIR_D2D_PCIe)) {
        return true;
    } else {
        return false;
    }
}

bool IsDavidUbDma(const uint32_t copyTypeFlag)
{
    if ((Runtime::Instance()->GetConnectUbFlag()) && ((copyTypeFlag == RT_MEMCPY_DIR_H2D)
        || (copyTypeFlag == RT_MEMCPY_DIR_D2H) || (copyTypeFlag == RT_MEMCPY_DIR_D2D_UB))) {
        return true;
    }
    return false;
}

uint32_t GetSendSqeNumForAsyncDmaTask(const TaskInfo * const taskInfo)
{
    if (taskInfo->u.memcpyAsyncTaskInfo.ubDma.isUbAsyncMode) {
        return 2U;
    }
    return 1U;
}

#endif

#if F_DESC("MixKernelUpdateTask")
static void MixKernelUpdateDebug(TaskInfo * const updateTask, const rtFftsPlusMixAicAivCtx_t * const newFftsCtx)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 0) {
        return;
    }

    Stream * const stream = updateTask->stream;
    Driver * const curDrv = stream->Device_()->Driver_();
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    const void *contextAddr = aicTaskInfo->descAlignBuf;
    rtFftsPlusMixAicAivCtx_t oldFftsCtx = {};

    const rtError_t error = curDrv->MemCopySync(static_cast<void *>(&oldFftsCtx), sizeof(oldFftsCtx),
                                                contextAddr, CONTEXT_LEN, RT_MEMCPY_DEVICE_TO_HOST);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "MemCopySync failed, retCode=%#x.", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "update mix kernel, device_id=%u, stream_id=%u, task_id=%hu",
        stream->Device_()->Id_(), stream->Id_(), updateTask->id);

    RT_LOG(RT_LOG_INFO, "old context debug info");
    ShowDavinciTaskMixDebug(&oldFftsCtx);

    RT_LOG(RT_LOG_INFO, "new context debug info");
    ShowDavinciTaskMixDebug(newFftsCtx);
    return;
}

rtError_t MixKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize)
{
    Stream * const stream = updateTask->stream;
    const uint32_t devId = static_cast<uint32_t>(stream->Device_()->Id_());
    Driver * const driver = updateTask->stream->Device_()->Driver_();
    rtFftsPlusMixAicAivCtx_t fftsCtx = {};

    rtError_t error = driver->HostMemAlloc(hostAddr, allocSize, devId);
    ERROR_RETURN_MSG_INNER(error, "alloc host memory failed, retCode=%#x.", error);

    uint32_t minStackSize = 0U;
    FillFftsAicAivCtxForDavinciTask(updateTask, &fftsCtx, minStackSize);
    UNUSED(minStackSize);
    error = driver->MemCopySync(*hostAddr, allocSize, static_cast<const void *>(&fftsCtx),
                                sizeof(fftsCtx), RT_MEMCPY_HOST_TO_HOST);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        (void)driver->HostMemFree(*hostAddr),
        "MemCopySync failed, retCode=%#x.", static_cast<uint32_t>(error));

    MixKernelUpdateDebug(updateTask, &fftsCtx);

    return RT_ERROR_NONE;                          
}

#endif

#if F_DESC("SqeUpdateH2DTask")
rtError_t SqeUpdateH2DTaskInit(TaskInfo * const taskInfo, void *srcAddr,
                               void *dstAddr, const uint64_t cpySize, void *releaseArgHandle, void * const updateArgHandle)
{
    NULL_PTR_RETURN(srcAddr, RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(dstAddr, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "SqeUpdateH2DTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo *memcpyAsyncTask  = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    taskInfo->typeName = "MEMCPY_ASYNC_SQE_UPDATE_H2D";

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTask->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTask->copyKind = static_cast<uint32_t>(RT_MEMCPY_HOST_TO_DEVICE);
    memcpyAsyncTask->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_H2D);
    memcpyAsyncTask->size = cpySize;
    memcpyAsyncTask->src = srcAddr;
    memcpyAsyncTask->destPtr = dstAddr;
    memcpyAsyncTask->isSqeUpdateH2D = true;
    memcpyAsyncTask->dmaKernelConvertFlag = true;
    memcpyAsyncTask->releaseArgHandle = releaseArgHandle;
    memcpyAsyncTask->updateArgHandle = updateArgHandle;

    RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%u", devId, stream->Id_());

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("NormalKernelUpdateTask")
rtError_t NormalKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr,
                                    const uint64_t allocSize)
{
    Stream * const stream = updateTask->stream;
    const uint32_t devId = static_cast<uint32_t>(stream->Device_()->Id_());
    Driver * const driver = updateTask->stream->Device_()->Driver_();
    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(stream->Model_());
    rtStarsSqe_t sqe = {};

    /* alloc host memory */
    rtError_t error = driver->HostMemAlloc(hostAddr, allocSize, devId);
    ERROR_RETURN_MSG_INNER(error, "alloc host memory failed, retCode=%#x.", error);

    /* construct new sqe */
    RT_LOG(RT_LOG_INFO, "update normal kernel, device_id=%u, stream_id=%d, task_id=%hu",
        devId, stream->Id_(), updateTask->id);

    ConstructAICoreSqeForDavinciTask(updateTask, &sqe);

    if (stream->IsSoftwareSqEnable() && (captureModel != nullptr)) {
        if (!captureModel->IsSendSqe()) {
            (void)memcpy_s(RtPtrToPtr<void *>(RtPtrToValue(stream->GetSqeBuffer()) + sizeof(rtStarsSqe_t) * updateTask->pos),
                           sizeof(rtStarsSqe_t), RtPtrToPtr<void *, rtStarsSqe_t *>(&sqe), sizeof(rtStarsSqe_t));
        }
    }

    error = driver->MemCopySync(*hostAddr, allocSize, static_cast<const void *>(&sqe),
                                sizeof(sqe), RT_MEMCPY_HOST_TO_HOST);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        (void)driver->HostMemFree(*hostAddr),
        "MemCopySync failed, retCode=%#x.", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;                          
}

/* D2H copy, src = sqeBaseAddr + sqeOffset, dst info = sqId + pos + sqeOffset, convert dst addr by ts-agent */
rtError_t UpdateD2HTaskInit(TaskInfo * const taskInfo, const void *sqeBaseAddr, const uint64_t cpySize,
                                        const uint32_t sqId, const uint32_t pos, const uint8_t sqeOffset)
{
    NULL_PTR_RETURN(sqeBaseAddr, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "UpdateD2HTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    taskInfo->typeName = "MEMCPY_ASYNC_SQE_UPDATE";

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->copyKind = static_cast<uint32_t>(RT_MEMCPY_DEVICE_TO_HOST);
    memcpyAsyncTaskInfo->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_D2H);
    memcpyAsyncTaskInfo->size = cpySize;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->src = RtValueToPtr<void *>(RtPtrToValue(sqeBaseAddr) + sqeOffset);
    memcpyAsyncTaskInfo->sqId = sqId;
    memcpyAsyncTaskInfo->taskPos = pos;
    memcpyAsyncTaskInfo->sqeOffset = sqeOffset;
    memcpyAsyncTaskInfo->isSqeUpdateD2H = true;

    RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%d, sqId=%u, pos=%u, sqeOffset=%u",
        devId, stream->Id_(), memcpyAsyncTaskInfo->sqId,
        memcpyAsyncTaskInfo->taskPos, sqeOffset);

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("MemWriteValueTask")
rtError_t MemWriteValueTaskInit(TaskInfo *taskInfo, const void * const devAddr, const uint64_t value)
{
    TaskCommonInfoInit(taskInfo);
    MemWriteValueTaskInfo *memWriteValueTask = &taskInfo->u.memWriteValueTask;
    memWriteValueTask->devAddr = RtPtrToValue(devAddr);
    memWriteValueTask->value = value;

    return RT_ERROR_NONE;
}

void DoCompleteSuccessForIpcRecordTask(TaskInfo* taskInfo, const uint32_t devId)
{
    MemWriteValueTaskInfo *memWriteValueTask = &taskInfo->u.memWriteValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWriteValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWriteValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    IpcHandleVa *vaHandle = event->GetIpcHandleVa();
    COND_RETURN_VOID(event->GetIpcHandleVa() == nullptr, "ipcHandleVa is nullptr");
    uint16_t curIndex = memWriteValueTask->curIndex;
    event->IpcVaLock();
    if (vaHandle->deviceMemRef[curIndex] > 0U) { // do complete success call
        vaHandle->deviceMemRef[curIndex]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, event_id=%u, current_id=%u, count already is zero",
            devId, curIndex, vaHandle->currentIndex);
    }
    if (vaHandle->deviceMemRef[curIndex] == 0U) {
        uint8_t* addr = event->GetCurrentHostMem() + curIndex;
        event->SetIpcFinished();
        (void)memset_s(RtPtrToPtr<void*>(addr), sizeof(uint8_t), 0, sizeof(uint8_t));
    }
    event->IpcEventCountSub();
    event->IpcVaUnLock();

    IpcEventDestroy(&event, MAX_INT32_NUM, false);
    RT_LOG(RT_LOG_INFO, "ipc record complete device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        devId, stream->Id_(), taskInfo->id, curIndex);
}

#endif

#if F_DESC("MemWaitValueTask")
void MemWaitTaskUnInit(TaskInfo *taskInfo)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    if (memWaitValueTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        if (taskInfo->type != TS_TASK_TYPE_CAPTURE_WAIT) {
            (void)dev->Driver_()->DevMemFree(memWaitValueTask->baseFuncCallSvmMem, dev->Id_());
        }
        memWaitValueTask->baseFuncCallSvmMem = nullptr;
        memWaitValueTask->funcCallSvmMem2 = nullptr;
        memWaitValueTask->writeValueAddr = nullptr;
    }

    if (memWaitValueTask->profDisableStatusAddr != 0UL) {
        const auto dev = taskInfo->stream->Device_();
        (void)dev->Driver_()->DevMemFree(RtValueToPtr<void *>(memWaitValueTask->profDisableStatusAddr), dev->Id_());
        memWaitValueTask->profDisableStatusAddr = 0UL;
    }

    memWaitValueTask->funCallMemSize2 = 0UL;
}

void StarsV2IpcEventWaitTaskUnInit(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWaitValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWaitValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    IpcHandleVa *vaHandle = event->GetIpcHandleVa();
    COND_RETURN_VOID(event->GetIpcHandleVa() == nullptr, "ipcHandleVa is nullptr");
    uint16_t curIndex = memWaitValueTask->curIndex;
    event->IpcVaLock();
    if (vaHandle->deviceMemRef[curIndex] > 0U) {
        vaHandle->deviceMemRef[curIndex]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, event_id=%u, current_id=%u, count already is zero",
            stream->Device_()->Id_(), curIndex, vaHandle->currentIndex);
    }
    if (vaHandle->deviceMemRef[curIndex] == 0U) {
        uint8_t* addr = event->GetCurrentHostMem() + curIndex;
        (void)memset_s(RtPtrToPtr<void*>(addr), sizeof(uint8_t), 0, sizeof(uint8_t));
    }
    event->IpcEventCountSub();
    event->IpcVaUnLock();
 
    IpcEventDestroy(&event, MAX_INT32_NUM, false);
 
    if (memWaitValueTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        (void)dev->Driver_()->DevMemFree(memWaitValueTask->baseFuncCallSvmMem, dev->Id_());
        memWaitValueTask->baseFuncCallSvmMem = nullptr;
        memWaitValueTask->funcCallSvmMem2 = nullptr;
        memWaitValueTask->writeValueAddr = nullptr;
    }
    memWaitValueTask->funCallMemSize2 = 0UL;
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, curIndex);
}
 
void StarsV2IpcEventRecordTaskUnInit(TaskInfo* taskInfo)
{
    MemWriteValueTaskInfo *memWriteValueTask = &taskInfo->u.memWriteValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWriteValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWriteValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    IpcHandleVa *vaHandle = event->GetIpcHandleVa();
    COND_RETURN_VOID(event->GetIpcHandleVa() == nullptr, "ipcHandleVa is nullptr");
    uint16_t curIndex = memWriteValueTask->curIndex;
    event->IpcVaLock();
    if (vaHandle->deviceMemRef[curIndex] > 0U) {
        vaHandle->deviceMemRef[curIndex]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, event_id=%u, current_id=%u, count already is zero",
            stream->Device_()->Id_(), curIndex, vaHandle->currentIndex);
    }
    if (vaHandle->deviceMemRef[curIndex] == 0U) {
        uint8_t* addr = event->GetCurrentHostMem() + curIndex;
        event->SetIpcFinished();
        (void)memset_s(RtPtrToPtr<void*>(addr), sizeof(uint8_t), 0, sizeof(uint8_t));
    }
    event->IpcEventCountSub();
    event->IpcVaUnLock();
 
    IpcEventDestroy(&event, MAX_INT32_NUM, false);
    RT_LOG(RT_LOG_INFO, "ipc wait complete, device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, curIndex);
}

uint32_t GetSendSqeNumForMemWaitTask(const TaskInfo * const taskInfo)
{
    UNUSED(taskInfo);
    return MEM_WAIT_SQE_NUM;
}

static rtError_t AllocFuncCallMemForMemWaitTask(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    if (taskInfo->stream->IsSoftwareSqEnable()) {
        if (taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_WAIT_PROF)) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcEx));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcExWithoutProf));
        }
    } else {
        if (taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_WAIT_PROF)) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFc));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcWithoutProf));
        }
    }

    void *devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = memWaitValueTask->funCallMemSize2 +
        MEM_WAIT_WRITE_VALUE_ADDRESS_LEN + FUNC_CALL_INSTR_ALIGN_SIZE;
    rtError_t ret = RT_ERROR_NONE;
    if (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT) {
        if (taskInfo->stream->Model_() == nullptr || allocSize > MEM_WAIT_SPLIT_SIZE) {
            RT_LOG(RT_LOG_ERROR, "Model is null or capture wait alloc size=%llu max than %u.", allocSize, MEM_WAIT_SPLIT_SIZE);
            return RT_ERROR_MODEL_NULL;
        }
        ret = taskInfo->stream->Model_()->MemWaitDevAlloc(&devMem, taskInfo->stream->Device_());
    } else {
        ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    }
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), dev_id=%u",
                      ret, allocSize, dev->Id_());

    memWaitValueTask->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uint64_t devMemAlign2 = (((RtPtrToValue(devMem)) >> 8U) + 1UL) << 8U;
        memWaitValueTask->funcCallSvmMem2 = RtValueToPtr<void *>(devMemAlign2);
    } else {
        memWaitValueTask->funcCallSvmMem2 = devMem;
    }

    void *devMem3 = RtValueToPtr<void *>(RtPtrToValue(memWaitValueTask->funcCallSvmMem2) +
        memWaitValueTask->funCallMemSize2);
    if ((RtPtrToValue(devMem3) & 0x1FULL) != 0ULL) {
        // 2 ^ 5 is 32 align
        const uint64_t devMemAlign3 = (((RtPtrToValue(devMem3)) >> 5U) + 1UL) << 5U;
        memWaitValueTask->writeValueAddr = RtValueToPtr<void *>(devMemAlign3);
    } else {
        memWaitValueTask->writeValueAddr = devMem3;
    }

    return RT_ERROR_NONE;
}



rtError_t MemWaitValueTaskInit(TaskInfo *taskInfo, const void * const devAddr,
                               const uint64_t value, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);

    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;

    memWaitValueTask->devAddr = RtPtrToValue(devAddr);
    memWaitValueTask->value = value;
    memWaitValueTask->flag = flag;
    memWaitValueTask->baseFuncCallSvmMem = nullptr;
    memWaitValueTask->funcCallSvmMem2 = nullptr;
    memWaitValueTask->writeValueAddr = nullptr;
    memWaitValueTask->funCallMemSize2 = 0ULL;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    rtError_t ret = AllocFuncCallMemForMemWaitTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", ret);

    Stream * const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    void *addr = nullptr;
    ret = stream->Device_()->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(sizeof(uint64_t)), RT_MEMORY_HBM, devId);
    ERROR_PROC_RETURN_MSG_INNER(ret,
        MemWaitTaskUnInit(taskInfo),
        "Alloc mem failed, device_id=%u, retCode=%#x", devId, static_cast<uint32_t>(ret));

    uint64_t initValue = 0UL;
    (void)stream->Device_()->Driver_()->MemCopySync(addr, sizeof(uint64_t), static_cast<const void *>(&initValue),
                                                    sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);    
    memWaitValueTask->profDisableStatusAddr = RtPtrToValue(addr);
    return RT_ERROR_NONE;
}

void DoCompleteSuccessForIpcWaitTask(TaskInfo* taskInfo, const uint32_t devId)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWaitValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWaitValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    IpcHandleVa *vaHandle = event->GetIpcHandleVa();
    COND_RETURN_VOID(event->GetIpcHandleVa() == nullptr, "ipcHandleVa is nullptr");
    uint16_t curIndex = memWaitValueTask->curIndex;
    event->IpcVaLock();
    if (vaHandle->deviceMemRef[curIndex] > 0U) { // do complete success call
        vaHandle->deviceMemRef[curIndex]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, event_id=%u, current_id=%u, count already is zero",
            devId, curIndex, vaHandle->currentIndex);
    }
    if (vaHandle->deviceMemRef[curIndex] == 0U) {
        uint8_t* addr = event->GetCurrentHostMem() + curIndex;
        (void)memset_s(RtPtrToPtr<void*>(addr), sizeof(uint8_t), 0, sizeof(uint8_t));
    }
    event->IpcEventCountSub();
    event->IpcVaUnLock();

    IpcEventDestroy(&event, MAX_INT32_NUM, false);
    RT_LOG(RT_LOG_INFO, "Ipc wait complete device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        devId, stream->Id_(), taskInfo->id, curIndex);
}

rtError_t MemcpyAsyncTaskPrepare(TaskInfo* const updateTask, void** const hostAddr)
{
    Stream * const stream = updateTask->stream;
    const uint32_t devId = static_cast<uint32_t>(stream->Device_()->Id_());
    Driver * const driver = updateTask->stream->Device_()->Driver_();
    constexpr uint64_t allocSize = sizeof(rtStarsSqe_t);
    rtStarsSqe_t sqe = {};
 
    rtError_t error = driver->HostMemAlloc(hostAddr, allocSize, devId);
    ERROR_RETURN_MSG_INNER(error, "alloc host memory failed, retCode=%#x.", error);
 
    /* construct new sqe */
    RT_LOG(RT_LOG_INFO, "update task, device_id=%u, stream_id=%d, task_id=%hu",
        devId, stream->Id_(), updateTask->id);
 
    ToConstructSqe(updateTask, &sqe);
    error = driver->MemCopySync(*hostAddr, allocSize, static_cast<const void *>(&sqe),
                                allocSize, RT_MEMCPY_HOST_TO_HOST);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        (void)driver->HostMemFree(*hostAddr),
        "MemCopySync failed, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t UpdateLabelSwitchTask(TaskInfo * const updateTask)
{
    uint64_t physicPtr = 0UL;
    StreamSwitchTaskInfo* streamSwitchTask = &(updateTask->u.streamswitchTask);
    const int32_t devId = static_cast<int32_t>(updateTask->stream->Device_()->Id_());
    rtError_t error = updateTask->stream->Device_()->Driver_()->MemAddressTranslate(
        devId, streamSwitchTask->ptr, &physicPtr);
    ERROR_RETURN_MSG_INNER(error, "Convert memory address to dma physic failed,retCode=%#x,ptr=%#" PRIx64 ".",
        error, streamSwitchTask->ptr);
 
    uint64_t physicValuePtr = 0UL;
    error = updateTask->stream->Device_()->Driver_()->MemAddressTranslate(
        devId, streamSwitchTask->valuePtr, &physicValuePtr);
    ERROR_RETURN_MSG_INNER(error,
        "Convert memory address to dma physic failed,retCode=%#x,valuePtr=%#" PRIx64 ".",
        error, streamSwitchTask->valuePtr);
 
    streamSwitchTask->phyPtr = physicPtr;
    streamSwitchTask->phyValuePtr = physicValuePtr;
    return error;
}
 
rtError_t UpdateTaskD2HSubmit(const TaskInfo * const updateTask, void *sqeAddr, Stream * const stm)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    const size_t allocSize = sizeof(rtStarsSqe_t);
    const uint32_t sqId = updateTask->stream->GetSqId();
    const uint32_t pos = updateTask->pos;

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);
    
    std::function<void()> const rtMemcpyAsyncTaskRecycle = [&stm, &rtMemcpyAsyncTask]() {
        (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    };
    ScopeGuard taskGuard(rtMemcpyAsyncTaskRecycle);

    rtError_t error = UpdateD2HTaskInit(rtMemcpyAsyncTask, sqeAddr, allocSize, sqId, pos, 0U);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), allocSize, error);
        return error;
    }
 
    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            updateTask->stream->Device_()->Id_(), stm->Id_(), allocSize, error);
        return error;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), updateTask->id, error);
    
    taskGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

static rtError_t UpdateModelUpdateTask(TaskInfo * const taskInfo)
{
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    uint64_t tilingTaboffset = 0ULL;
    uint64_t tilingKeyOffset = 0ULL;
    uint64_t blockDimOffset = 0ULL;
    uint64_t descBufOffset = MAX_UINT64_NUM;
    void *devCopyMem = mdlUpdateTaskInfo->tilingTabAddr;

    rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->tilingKeyAddr), &tilingKeyOffset);
    ERROR_RETURN_MSG_INNER(error, "tilingKeyAddr MemAddressTranslate error=%d", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->blockDimAddr), &blockDimOffset);
    ERROR_RETURN_MSG_INNER(error, "blockDimAddr MemAddressTranslate error=%d", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(devCopyMem), &tilingTaboffset);
    ERROR_RETURN_MSG_INNER(error, "devCopyMem MemAddressTranslate error=%d", error);

    if (mdlUpdateTaskInfo->fftsPlusTaskDescBuf != nullptr) {
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->fftsPlusTaskDescBuf), &descBufOffset);
    } else {
        error = SetMixDescBufOffset(taskInfo, mdlUpdateTaskInfo->desStreamId, mdlUpdateTaskInfo->destaskId, &descBufOffset);
    }
    ERROR_RETURN_MSG_INNER(error, "descBuf MemAddressTranslate error=%d", error);

    mdlUpdateTaskInfo->descBufOffset = descBufOffset;
    mdlUpdateTaskInfo->tilingKeyOffset = tilingKeyOffset;
    mdlUpdateTaskInfo->blockDimOffset = blockDimOffset;
    mdlUpdateTaskInfo->tilingTabOffset = tilingTaboffset;
    RT_LOG(RT_LOG_DEBUG, "descBufOffset=%lu, tilingKeyOffset=%lu, blockDimOffset=%u, tilingTabOffset=%u, prgHandle=%p.",
        descBufOffset, tilingKeyOffset, blockDimOffset, tilingTaboffset, mdlUpdateTaskInfo->prgHandle);
    return RT_ERROR_NONE;
}
 
rtError_t UpdateTaskH2DSubmit(TaskInfo * const updateTask, Stream * const stm, void* sqeDeviceAddr)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    rtError_t error = RT_ERROR_NONE;
    constexpr uint64_t copySize = sizeof(rtStarsSqe_t);
    Driver *const curDrv = stm->Device_()->Driver_();
 
    if (updateTask->type == TS_TASK_TYPE_MODEL_TASK_UPDATE) {
        error = UpdateModelUpdateTask(updateTask);
    } else if (updateTask->type == TS_TASK_TYPE_STREAM_SWITCH) {
        error = UpdateLabelSwitchTask(updateTask);
    } else {
        // do nothing
    }
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update dma or offset failed, ret=%d", error);
    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);
    std::function<void()> const rtMemcpyAsyncTaskRecycle = [&stm, &rtMemcpyAsyncTask]() {
        (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    };
    ScopeGuard taskGuard(rtMemcpyAsyncTaskRecycle);

    /* hostAddr is new sqe info */
    void *hostAddr = nullptr;
    error = MemcpyAsyncTaskPrepare(updateTask, &hostAddr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), error);
        return error;
    }
 
    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, sqeDeviceAddr, copySize, nullptr, nullptr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), copySize, error);
        (void)curDrv->HostMemFree(hostAddr);
        return error;
    }

    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), error);
        return error;
    }
    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), rtMemcpyAsyncTask->id, error);
    taskGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

void IpcEventDestroy(IpcEvent **eventPtr, int32_t freeId, bool isNeedDestroy)
{
    COND_RETURN_VOID(*eventPtr == nullptr, "event is nullptr");
    (*eventPtr)->EventDestroyLock();
    bool canEventbeDelete = (*eventPtr)->TryFreeEventIdAndCheckCanBeDelete(freeId, isNeedDestroy);
    (*eventPtr)->EventDestroyUnLock();
    if (canEventbeDelete) {
        (void)(*eventPtr)->ReleaseDrvResource();
        delete *eventPtr;
        (*eventPtr) = nullptr;
    }
}

static void SetCommonTaskParams(rtTaskParams* const params)
{
    params->taskGrp = nullptr;
    params->opInfoPtr = nullptr;
    params->opInfoSize = 0U;
}

rtError_t GetCaptureRecordTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_RECORD;
    SetCommonTaskParams(params);

    Event *event = taskInfo->u.memWriteValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER(event, RT_ERROR_INVALID_VALUE);
    params->eventRecordTaskParams.event = event;
    params->eventRecordTaskParams.eventFlag = event->GetEventFlag();

    return RT_ERROR_NONE;
}

rtError_t GetCaptureWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_WAIT;
    SetCommonTaskParams(params);

    Event *event = taskInfo->u.memWaitValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER(event, RT_ERROR_INVALID_VALUE);
    params->eventWaitTaskParams.event = event;
    params->eventWaitTaskParams.eventFlag = event->GetEventFlag();

    return RT_ERROR_NONE;
}

rtError_t GetCaptureResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_RESET;
    SetCommonTaskParams(params);

    Event *event = taskInfo->u.memWriteValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER(event, RT_ERROR_INVALID_VALUE);
    params->eventResetTaskParams.event = event;
    params->eventResetTaskParams.eventFlag = event->GetEventFlag();

    return RT_ERROR_NONE;
}


rtError_t GetWriteValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_VALUE_WRITE;
    SetCommonTaskParams(params);

    params->valueWriteTaskParams.devAddr = RtValueToPtr<void*>(taskInfo->u.memWriteValueTask.devAddr);
    params->valueWriteTaskParams.value = taskInfo->u.memWriteValueTask.value;

    return RT_ERROR_NONE;
}

rtError_t GetWaitValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_VALUE_WAIT;
    SetCommonTaskParams(params);

    params->valueWaitTaskParams.devAddr = RtValueToPtr<void*>(taskInfo->u.memWaitValueTask.devAddr);
    params->valueWaitTaskParams.value = taskInfo->u.memWaitValueTask.value;
    params->valueWaitTaskParams.flag = taskInfo->u.memWaitValueTask.flag;

    return RT_ERROR_NONE;
}

static rtError_t CheckUpdatingTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    rtTaskType taskType;
    rtError_t error = ConvertTaskType(taskInfo, &taskType);
    ERROR_RETURN(error, "get task type failed, retCode=%#x.", error);
    // RT_TASK_DEFAULT表示外部不识别的类型，报错并打印RTS内部具体的Task类型
    COND_RETURN_ERROR(taskType == RT_TASK_DEFAULT, RT_ERROR_INVALID_VALUE,
        "current taskType(%d) is invalid", taskInfo->type);

    COND_RETURN_ERROR(params->taskGrp != nullptr, RT_ERROR_INVALID_VALUE, "taskGrp must be nullptr");
    COND_RETURN_ERROR(params->opInfoPtr != nullptr, RT_ERROR_INVALID_VALUE, "opInfoPtr must be nullptr");
    COND_RETURN_ERROR(params->opInfoSize != 0U, RT_ERROR_INVALID_VALUE, "opInfoSize must be 0");

    return RT_ERROR_NONE;
}

rtError_t UpdateWriteValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    ERROR_RETURN(CheckUpdatingTaskParams(taskInfo, params), "task type or input params is invalid");

    TaskUnInitProc(taskInfo);
    (void)MemWriteValueTaskInit(taskInfo, params->valueWriteTaskParams.devAddr, params->valueWriteTaskParams.value);
    taskInfo->u.memWriteValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    taskInfo->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo->typeName = "MEM_WRITE_VALUE";

    Stream* stm = taskInfo->stream;
    Device* dev = stm->Device_();
    RT_LOG(RT_LOG_INFO, "update or convert to ValueWriteTask succ: device_id=%u, stream_id=%d, task_id=%hu, "
        "typeName=%s, taskType=%d, devAddr=%#llx, value=%llu",
        dev->Id_(), stm->Id_(), taskInfo->id,
        taskInfo->typeName, taskInfo->type, taskInfo->u.memWriteValueTask.devAddr, taskInfo->u.memWriteValueTask.value);
    return RT_ERROR_NONE;
}

rtError_t UpdateWaitValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    ERROR_RETURN(CheckUpdatingTaskParams(taskInfo, params), "task type or input params is invalid");

    TaskUnInitProc(taskInfo);
    // 需要先赋值类型，此类型会影响Init中的内存申请方式
    taskInfo->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    taskInfo->typeName = "MEM_WAIT_VALUE";
    rtError_t error = MemWaitValueTaskInit(taskInfo, params->valueWaitTaskParams.devAddr,
        params->valueWaitTaskParams.value, params->valueWaitTaskParams.flag);
    ERROR_RETURN_MSG_INNER(error, "mem wait value init failed, retCode=%#x.", error);
    taskInfo->u.memWaitValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;

    Stream* stm = taskInfo->stream;
    Device* dev = stm->Device_();
    RT_LOG(RT_LOG_INFO, "update or convert to ValueWaitTask succ: device_id=%u, stream_id=%d, task_id=%hu, "
        "typeName=%s, taskType=%d, devAddr=%#llx, value=%llu, flag=%u",
        dev->Id_(), stm->Id_(), taskInfo->id,
        taskInfo->typeName, taskInfo->type, taskInfo->u.memWaitValueTask.devAddr,
        taskInfo->u.memWaitValueTask.value, taskInfo->u.memWaitValueTask.flag);
    return RT_ERROR_NONE;
}

#endif

}  // namespace runtime
}  // namespace cce
