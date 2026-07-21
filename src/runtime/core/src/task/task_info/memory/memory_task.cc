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
#include "task_info.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "davinci_kernel_task.h"
#include "stars_cond_isa_helper.hpp"
#include "inner_thread_local.hpp"
#include "model_update_task.h"
#include "event.hpp"
#include "kernel_utils.hpp"
#include "stream_jetty_handler.h"
#include "capture_model_utils.hpp"

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
        COND_RETURN_AND_MSG_OUTER(memcpyAsyncTaskInfo->srcPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, size, "malloc");
        errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << RtPtrToValue(memcpyAsyncTaskInfo->srcPtr) << ", src=0x" << RtPtrToValue(src)
               << std::dec << ", destMax=" << sizeof(size) << ", count=" << sizeof(size) << ".";
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__,
                "memcpy_s", std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
            return RT_ERROR_SEC_HANDLE;
        }
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
        COND_RETURN_AND_MSG_OUTER(memcpyAsyncTaskInfo->desPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, size, "malloc");
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
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes).", addrSize);

        if (stream->Device_()->IsAddrFlatDev()) {
            error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->srcPtr, (addrSize + ASYNC_MEMORY_SIZE), stream->Device_()->Id_());
        } else {
            memcpyAsyncTaskInfo->srcPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
        }

        ERROR_RETURN(error, "HostMemAlloc failed, retCode=%#x", static_cast<uint32_t>(error));
        COND_RETURN_AND_MSG_OUTER(memcpyAsyncTaskInfo->srcPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, addrSize + ASYNC_MEMORY_SIZE, "malloc");

        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) +
                                    static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE) -
                                    (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) %
                                    static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE));
        const errno_t rc = memcpy_s(reinterpret_cast<void *>(offset), addrSize, srcAddr, addrSize);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << offset << ", src=0x" << RtPtrToValue(srcAddr)
               << std::dec << ", destMax=" << sizeof(addrSize) << ", count=" << sizeof(addrSize) << ".";
            if (stream->Device_()->IsAddrFlatDev()) {
                COND_PROC_RETURN_AND_MSG_OUTER(rc != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020,
                    (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);memcpyAsyncTaskInfo->srcPtr = nullptr, __func__,
                    "memcpy_s", std::to_string(rc), strerror(rc), ss.str().c_str());
            } else {
                COND_PROC_RETURN_AND_MSG_OUTER(rc != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020,
                    free(memcpyAsyncTaskInfo->srcPtr);memcpyAsyncTaskInfo->srcPtr = nullptr, __func__, "memcpy_s",
                    std::to_string(rc), strerror(rc), ss.str().c_str());
            }
        }
        srcAddr = reinterpret_cast<void *>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < ASYNC_MEMORY_SIZE), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes)."
            " Expected value: [0, %" PRIu64 "].", addrSize, MAX_UINT64_NUM);
        memcpyAsyncTaskInfo->desPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
        COND_RETURN_AND_MSG_OUTER(memcpyAsyncTaskInfo->desPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, addrSize + ASYNC_MEMORY_SIZE, "malloc");
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
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes).", addrSize);
        error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->srcPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
        COND_RETURN_ERROR((memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "HostMemAlloc src address failed, malloc size is %" PRIu64, addrSize + asyncMemorySize);
        ERROR_RETURN(error, "HostMemAlloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        const uintptr_t offset = reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) +
            static_cast<uint64_t>(asyncMemoryAlignSize) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) % static_cast<uint64_t>(asyncMemoryAlignSize));
        error = driver->MemCopySync(reinterpret_cast<void *>(offset), addrSize, srcAddr, addrSize, RT_MEMCPY_HOST_TO_HOST);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr),
            "MemCopySync failed, retCode is %d, size is %" PRIu64, error, addrSize);
        srcAddr = reinterpret_cast<void *>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < asyncMemorySize), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes)."
            " Expected value: [0, %" PRIu64 "].", addrSize, MAX_UINT64_NUM);
        error = driver->HostMemAlloc(&memcpyAsyncTaskInfo->desPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
	    COND_RETURN_ERROR((memcpyAsyncTaskInfo->desPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
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
        COND_RETURN_ERROR((error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "Failed to alloc memory, err=%#x, size=%" PRIu64 "(bytes), devId=%u.",
            error, size, stream->Device_()->Id_());
        const errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << RtPtrToValue(memcpyAsyncTaskInfo->srcPtr) << ", src=0x" << RtPtrToValue(src)
               << std::dec << ", destMax=" << size << ", count=" << size << ".";
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__,
                "memcpy_s", std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
            return RT_ERROR_SEC_HANDLE;
        }
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
        COND_RETURN_ERROR((error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->desPtr == nullptr),
            RT_ERROR_MEMORY_ALLOCATION,
            "Failed to malloc dest ptr, err=%#x, size=%" PRIu64 "(bytes), devId:%u.",
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
        COND_RETURN_AND_MSG_OUTER(memcpyAsyncTaskInfo->guardMemVec == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, sizeof(std::vector<std::shared_ptr<void>>), "new");
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

    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "D2D memcpy async, get channel type failed, retCode=%#x.",
        static_cast<uint32_t>(error));

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
        ERROR_RETURN_MSG_INNER(error, "Failed to convert the D2D asynchronous copy type, retCode=%#x.", static_cast<uint32_t>(error));
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

static rtError_t ConvertAsyncDma2DForSoftWareSq(TaskInfo * const taskInfo2D, void *const dst,
    const void *const src, const uint64_t dstPitch, const uint64_t srcPitch,
    const uint64_t width, const uint64_t height, const uint64_t fixedSize)
{
    Stream * const stream = taskInfo2D->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo2D->u.memcpyAsyncTaskInfo);
    
    rtError_t error = RT_ERROR_NONE;
    JettyType jettyType = StreamJettyHandler::GetJettyTypeFromTask(taskInfo2D);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_2D);
    input.matrix2d.src = RtPtrToPtr<uint64_t *>(RtPtrToPtr<uintptr_t>(src));
    input.matrix2d.dst = RtPtrToPtr<uint64_t *>(RtPtrToPtr<uintptr_t>(dst));

    input.matrix2d.dpitch = dstPitch;
    input.matrix2d.spitch = srcPitch;
    input.matrix2d.width = width;
    input.matrix2d.height = height;
    input.matrix2d.fixedSize = fixedSize;
    error = StreamJettyHandler::HandleUbDmaTask(
        taskInfo2D, jettyType, &input, &output);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "HandleUbDmaTask failed, device_id=%u, stream_id=%d, retCode=%#x.",
            devId, stream->Id_(), error);
        return error;
    }
    uint64_t size = (output.fixedCnt == 1U) ? width * height : output.fixedSize;
    memcpyAsyncTaskInfo->ubDma.fixedSize = size;
    memcpyAsyncTaskInfo->size = size;
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
    Stream * const stream = taskInfo2D->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo2D->u.memcpyAsyncTaskInfo);
    
    if (stream->IsSoftwareSqEnable()) {
        return ConvertAsyncDma2DForSoftWareSq(taskInfo2D, dst, src, dstPitch, srcPitch, width, height, fixedSize);
    }

    Driver * const driver = stream->Device_()->Driver_();
    AsyncDmaWqeInputInfo2D input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo2D), 0, sizeof(AsyncDmaWqeInputInfo2D));

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
        ERROR_RETURN_MSG_INNER(error, "Failed to convert the D2D asynchronous copy typeD2D, retCode=%#x, kind=%u.", error, kind);
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
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
            error = ConvertAsyncDma2D(taskInfo, dst, dstPitch, srcAddr, srcPitch, width, height, fixedSize);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "ConvertAsyncDma2D failed, retCode=%#x.", error);
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

static rtError_t HandleUbModeDmaResult(TaskInfo * const taskInfo, const AsyncDmaWqeOutputInfo &output)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    
    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.wqeLen = output.wqeLen;
    memcpyAsyncTaskInfo->ubDma.wqePtr = output.wqe;
    memcpyAsyncTaskInfo->ubDma.pi = 1U;
    if (output.wqeLen != 0) {
        const errno_t ret = memcpy_s(memcpyAsyncTaskInfo->ubDma.wqe.data(), sizeof(rtDavidSqe_t),
            output.wqe, static_cast<size_t>(output.wqeLen));
        if (ret != EOK) {
            RT_LOG(RT_LOG_ERROR, "Failed to call memcpy_s to copy output.wqe, src=%p, dest=%p, dest_max=%zu, count=%zu,"
                " retCode=%#x.", output.wqe, memcpyAsyncTaskInfo->ubDma.wqe.data(), sizeof(rtDavidSqe_t), static_cast<size_t>(output.wqeLen), ret);
            return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t ConvertAsyncDmaForSoftWareSqUb(TaskInfo * const taskInfo, TaskInfo * const updateTask, bool isSqeUpdate)
{
    Stream * const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    
    // for task update, external event场景, 只会在单算子流上下memcpy
    if (isSqeUpdate) {
        COND_RETURN_ERROR(updateTask == nullptr, RT_ERROR_INVALID_VALUE,
            "updateTask is null when isSqeUpdate is true.");
    }
    if (isSqeUpdate && ((stream->Flags() & RT_STREAM_PERSISTENT) == 0)) {
        AsyncDmaWqeInputInfo input = {};
        input.tsId = stream->Device_()->DevGetTsId();
        input.sqId = stream->GetSqId();
        input.src = memcpyAsyncTaskInfo->src;
        input.size = memcpyAsyncTaskInfo->size;
        input.cpyType = memcpyAsyncTaskInfo->copyType;
        input.destPtr = RtValueToPtr<void *>(updateTask->stream->GetSqBaseAddr() + (updateTask->pos) * sizeof(rtDavidSqe_t));
        AsyncDmaWqeOutputInfo output = {};
        Driver * const driver = stream->Device_()->Driver_();
        const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, true, false);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.", static_cast<uint32_t>(error));
        return HandleUbModeDmaResult(taskInfo, output);
    }

    JettyType jettyType = StreamJettyHandler::GetJettyTypeFromTask(taskInfo);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_NORMAL);
    input.normal.dst = static_cast<uint8_t *>(memcpyAsyncTaskInfo->destPtr);
    input.normal.src = static_cast<uint8_t *>(memcpyAsyncTaskInfo->src);
    rtError_t error = RT_ERROR_NONE;
    if (isSqeUpdate) {
        void* sqeDeviceAddr =
            RtValueToPtr<void*>(updateTask->stream->GetSqBaseAddr() + (updateTask->pos) * sizeof(rtDavidSqe_t));
        input.normal.dst = static_cast<uint8_t*>(sqeDeviceAddr);
    }
    input.normal.len = memcpyAsyncTaskInfo->size;
    error = StreamJettyHandler::HandleUbDmaTask(
        taskInfo, jettyType, &input, &output);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "HandleUbDmaTask failed, device_id=%u, stream_id=%d, retCode=%#x.",
        devId, stream->Id_(), error);
    return error;
}

static rtError_t ConvertAsyncDmaForSoftWareSqPcie(MemcpyAsyncTaskInfo * const cpyAsyncTask, TaskInfo * const updateTask)
{
    rtError_t error = RT_ERROR_NONE;
    Stream *updateStm = updateTask->stream;
    Driver * const curDrv = updateStm->Device_()->Driver_();
    cpyAsyncTask->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(updateStm->Device_()->Id_());
    void *sqeDeviceAddr = RtValueToPtr<void *>(updateStm->GetSqBaseAddr() + (updateTask->pos) * sizeof(rtDavidSqe_t));
    error = curDrv->MemConvertAddr(RtPtrToValue(cpyAsyncTask->src), RtPtrToValue(sqeDeviceAddr),
        cpyAsyncTask->size, &(cpyAsyncTask->dmaAddr));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Failed to convert memory address, device_id=%d, stream_id=%d, retCode=%#x.",
            updateStm->Device_()->Id_(), updateStm->Id_(), static_cast<uint32_t>(error));
    cpyAsyncTask->destPtr = sqeDeviceAddr;
    cpyAsyncTask->size = cpyAsyncTask->dmaAddr.fixed_size;
    return RT_ERROR_NONE;
}

/*
    only for UB
    非扩流场景下, UB通过驱动获取DWQE,扩流场景:走jetty manager
    taskInfo: 下ubdma的流
*/
rtError_t ConvertAsyncDma(TaskInfo * const taskInfo)
{
    Stream * const stream = taskInfo->stream;
    Driver * const driver = stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "pcie is not supported.");
        return RT_ERROR_INVALID_VALUE;
    }
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    if (stream->IsSoftwareSqEnable()) {
        return ConvertAsyncDmaForSoftWareSqUb(taskInfo, nullptr, false);
    }
    
    AsyncDmaWqeInputInfo input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo), 0, sizeof(AsyncDmaWqeInputInfo));
    input.destPtr = memcpyAsyncTaskInfo->destPtr;
    input.tsId = stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();
    input.src = memcpyAsyncTaskInfo->src;
    input.size = memcpyAsyncTaskInfo->size;
    input.cpyType = memcpyAsyncTaskInfo->copyType;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, true, false);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.", static_cast<uint32_t>(error));
    
    return HandleUbModeDmaResult(taskInfo, output);
}

/*
    for task update
    非扩流场景下, PCIE通过驱动将目标更新的sqe addr转成dmaAddr，UB通过驱动获取DWQE
    扩流场景:1.pcie通过目的地址转换描述符 2.ub走jetty manager
    taskInfo: 下dma任务的stm,可能是模型里的stm,也可能是单算子流
    updateTaskInfo:  task update目标, 要被更新的task
*/
rtError_t ConvertAsyncDmaForTaskUpdate(TaskInfo * const taskInfo, TaskInfo * const updateTaskInfo)
{
    Stream * const stream = taskInfo->stream;
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    // task update目标流为扩流的流
    if (updateTaskInfo->stream->IsSoftwareSqEnable()) {
        Stream *updateStm = updateTaskInfo->stream;
        if (updateStm->GetSqBaseAddr() == 0ULL) {
            rtError_t err = updateStm->AllocSoftwareSqAddr(
                CAPTURE_TASK_RESERVED_NUM + updateStm->Device_()->GetDevProperties().expandStreamRsvTaskNum);
            COND_RETURN_ERROR(err != RT_ERROR_NONE, err, "Failed to allocate software SQ address, device_id=%d, stream_id=%d, retCode=%#x.",
                updateStm->Device_()->Id_(), updateStm->Id_(), static_cast<uint32_t>(err));
        }
        if (isUbMode) {
            return ConvertAsyncDmaForSoftWareSqUb(taskInfo, updateTaskInfo, true);
        } else {
            return ConvertAsyncDmaForSoftWareSqPcie(memcpyAsyncTaskInfo, updateTaskInfo);
        }
    }

    AsyncDmaWqeInputInfo input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo), 0, sizeof(AsyncDmaWqeInputInfo));
    input.info.sqe_pos = updateTaskInfo->id;
    input.info.sqId = updateTaskInfo->stream->GetSqId();
    input.tsId = updateTaskInfo->stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();
    input.src = memcpyAsyncTaskInfo->src;
    input.size = memcpyAsyncTaskInfo->size;
    input.cpyType = memcpyAsyncTaskInfo->copyType;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const uint32_t devId = stream->Device_()->Id_();
    Driver * const driver = stream->Device_()->Driver_();
    const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, isUbMode, true);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.", static_cast<uint32_t>(error));
    
    if (isUbMode) {
        return HandleUbModeDmaResult(taskInfo, output);
    }
    memcpyAsyncTaskInfo->dmaAddr = output.dmaAddr;
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
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Failed to alloc copy memory, retCode=%#x, size=%" PRIu64 "(bytes)",
        error, cpySize);

    error = ConvertCpyType(taskInfo, cpyType, srcAddr, desAddr);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Failed to convert copy type, retCode=%#x, size=%" PRIu64 "(bytes).",
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
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Convert D2D source memory address from virtual to physic failed, retCode=%#x.", error);
        error = driver->MemAddressTranslate(devId, reinterpret_cast<uintptr_t>(desAddr), &destAddr);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
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
            error = ConvertAsyncDma(taskInfo);
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ConvertAsyncDma failed, retCode=%#x.", error);
            taskInfo->needPostProc = true;
        } else if (IsPcieDma(memcpyAsyncTaskInfo->copyType) && (driver->GetRunMode() == RT_RUN_MODE_ONLINE)) {
            error = driver->MemConvertAddr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcAddr)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(desAddr)), cpySize, &(memcpyAsyncTaskInfo->dmaAddr));
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
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
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
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

bool GetModuleIdByMemcpyAddr(Driver const * const driver, void *memcpyAddr, uint32_t *moduleId)
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

void PrintModuleIdProc(Driver const * const driver, char_t * const errStr, void *src, void *dst, int32_t &countNum)
{
    uint32_t srcModuleId = static_cast<uint32_t>(SVM_INVALID_MODULE_ID);
    uint32_t dstModuleId = static_cast<uint32_t>(SVM_INVALID_MODULE_ID);
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void *>(&src), &srcModuleId)) {
        if (srcModuleId != static_cast<uint32_t>(SVM_INVALID_MODULE_ID)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", src_module_id=%u", srcModuleId);
        }
    }
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void *>(&dst), &dstModuleId)) {
        if (dstModuleId != static_cast<uint32_t>(SVM_INVALID_MODULE_ID)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),", dst_module_id=%u", dstModuleId);
        }
    }
}

static void PrintUbdmaErrorInfo(const MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo)
{
    if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
        RT_LOG(RT_LOG_ERROR, "ub async copy error, die_id=%u, functionId=%u, jettyId=%u,"
            " wqeLen=%d, is_ub_mode=%d, is_sqe_update=%d, pi=%u, fixedSize(fixedCnt)=%llu.",
            memcpyAsyncTaskInfo->ubDma.dieId, memcpyAsyncTaskInfo->ubDma.functionId, memcpyAsyncTaskInfo->ubDma.jettyId,
            memcpyAsyncTaskInfo->ubDma.wqeLen,
            memcpyAsyncTaskInfo->isSqeUpdateH2D, memcpyAsyncTaskInfo->ubDma.pi, memcpyAsyncTaskInfo->ubDma.fixedSize);
    }
}

static uint8_t GetMemCpyErrorModule(const uint32_t copyType)
{
    uint8_t errorModuleType = ERR_MODULE_RTS;
    if ((copyType >= RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL)) {
        errorModuleType = ERR_MODULE_HCCL;
    }
    return errorModuleType;
}

static const char_t* TransMemCopyDirToStr(const uint32_t copyType)
{
    struct CopyTypeToStr {
        rtMemCopyAsyncDirect type;
        const char_t *desc;
    };

    static const  CopyTypeToStr table[] = {
        {RT_MEMCPY_DIR_H2D, "MEMCPY_DIR_H2D(0)"},
        {RT_MEMCPY_DIR_D2H, "MEMCPY_DIR_D2H(1)"},
        {RT_MEMCPY_DIR_D2D_SDMA, "MEMCPY_DIR_D2D_SDMA(2)"},
        {RT_MEMCPY_DIR_D2D_HCCs, "MEMCPY_DIR_D2D_HCCS(3)"},
        {RT_MEMCPY_DIR_D2D_PCIe, "MEMCPY_DIR_D2D_PCIE(4)"},
        {RT_MEMCPY_ADDR_D2D_SDMA, "MEMCPY_ADDR_D2D_SDMA(5)"},
        {RT_MEMCPY_DIR_D2D_UB, "MEMCPY_DIR_D2D_UB(6)"},
        {RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD, "MEMCPY_DIR_SDMA_AUTOMATIC_ADD(10)"},
        {RT_MEMCPY_DIR_SDMA_AUTOMATIC_MAX, "MEMCPY_DIR_SDMA_AUTOMATIC_MAX(11)"},
        {RT_MEMCPY_DIR_SDMA_AUTOMATIC_MIN, "MEMCPY_DIR_SDMA_AUTOMATIC_MIN(12)"},
        {RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL, "MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL(13)"},
    };

    for (const auto& element : table) {
        if (copyType == static_cast<uint32_t>(element.type)) {
            return element.desc;
        }
    }
    return "UNKNOWN";
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

    uint8_t errorModuleType = ERR_MODULE_RTS;
    char_t errMsg[MSG_LENGTH] = {};
    char_t * const errStr = errMsg;
    int32_t countNum = sprintf_s(errStr, static_cast<size_t>(MSG_LENGTH),
        "Asynchronous memory copy failed, device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu, ",
        devId, streamId, taskInfo->id, taskInfo->flipNum);
    if ((countNum < 0) || (countNum > MSG_LENGTH)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call sprintf_s, count=%d.", countNum);
        return;
    }

    Stream *const reportStream = GetReportStream(stream);
    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA)
        && (!memcpyAsyncTaskInfo->dmaKernelConvertFlag)) {
        if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
            countNum += sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%s, sq_id=%u, task_pos=%u, cp_size=%#" PRIx64,
                TransMemCopyDirToStr(copyType), memcpyAsyncTaskInfo->sqId, memcpyAsyncTaskInfo->taskPos,
                memcpyAsyncTaskInfo->size);
            (void)snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_dev_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)));
        } else {
            countNum += sprintf_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%s, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%u",
                TransMemCopyDirToStr(copyType), static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
            (void)snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst)));
        }
    } else {
        errorModuleType = GetMemCpyErrorModule(copyType);
        countNum += sprintf_s(errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
            "copy_type=%s, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%" PRIu64, TransMemCopyDirToStr(copyType),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->size);

        if ((copyKind == RT_MEMCPY_RESERVED) && (copyType == RT_MEMCPY_ADDR_D2D_SDMA)) {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)), ", memcpyAddrInfo=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->memcpyAddrInfo)));
            PrintAsyncPtrProc(driver, errStr, memcpyAsyncTaskInfo->memcpyAddrInfo, countNum);
        } else {
            countNum += snprintf_truncated_s(errStr + countNum,
                (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->destPtr)));
            PrintModuleIdProc(driver, errStr, memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr, countNum);
        }
    }
    STREAM_REPORT_ERR_MSG(reportStream, errorModuleType, "%s", errStr);
}

void RecycleTaskResourceForMemcpyAsyncTask(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if ((memcpyAsyncTaskInfo->desPtr != nullptr) &&
        (memcpyAsyncTaskInfo->originalDes != nullptr) && (memcpyAsyncTaskInfo->destPtr != nullptr)) {
        const errno_t rc = memcpy_s(memcpyAsyncTaskInfo->originalDes, memcpyAsyncTaskInfo->size,
                                    memcpyAsyncTaskInfo->destPtr, memcpyAsyncTaskInfo->size);
        if (rc != EOK) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy memcpyAsyncTaskInfo->destPtr,"
                " src=%p, dest=%p, dest_max=%" PRIu64 ", count=%" PRIu64 ", retCode=%#x.", memcpyAsyncTaskInfo->destPtr, 
                memcpyAsyncTaskInfo->originalDes, memcpyAsyncTaskInfo->size, memcpyAsyncTaskInfo->size, rc);
            return;
        }
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
                RT_LOG(RT_LOG_WARNING, "DataType=%u is out of range or is not supported.",
                    static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType));
                opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            }
            break;
        }
        case RT_DATA_TYPE_UINT32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_UINT32);
            break;
        }
        default: {
            // Should not run here.
            // if not support, it will return RT_ERROR_FEATURE_NOT_SUPPORT at context.cc's reduce ability check.
            // Only for code style, 0x80 is reserved value of STRAS opcode.
            RT_LOG(RT_LOG_WARNING, "DataType=%u is out of range or is not supported.",
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
    const MemcpyAsyncTaskInfo *const memcpyAsyncTask = &(taskInfo->u.memcpyAsyncTaskInfo);

    /* Ascned950装备场景下的配置是pcie互联 */
    if (IsDavidUbDma(memcpyAsyncTask->copyType)) {
        // ub图下沉场景使用ub db
        if ((taskInfo->stream->Flags() & RT_STREAM_PERSISTENT) != 0U) {
            return 1U;
        }

        // UB 2D异步拷贝和批量异步拷贝需要1个sqe ub db
        uint32_t copyMethod = memcpyAsyncTask->copyMethod;
        if (copyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH) || 
            copyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D)) {
            return 1U;
        }
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
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Failed to alloc host memory, retCode=%#x.", error);

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
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Failed to alloc host memory, retCode=%#x.", error);

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
    if (vaHandle->currentIndex == curIndex) {
        event->SetIpcFinished();
    }
    event->IpcVaUnLock();
    IpcEventDestroy(&event, curIndex, false);
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

    memWaitValueTask->profDisableStatusAddr = 0UL;

    memWaitValueTask->funCallMemSize2 = 0UL;
}

void StarsV2IpcEventWaitTaskUnInit(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWaitValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWaitValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    const uint16_t curIndex = memWaitValueTask->curIndex;
    IpcEventDestroy(&event, curIndex, false);
 
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
    if (vaHandle->currentIndex == curIndex) {
        event->SetIpcFinished();
    }
    event->IpcVaUnLock();

    IpcEventDestroy(&event, curIndex, false);
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
        if (taskInfo->stream->Device_()->GetDevProperties().sqSwapShift == 0U) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcEx));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcExWithDynamicProf));
        }
    } else {
        if (taskInfo->stream->Device_()->GetDevProperties().sqSwapShift == 0U) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFc));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcWithDynamicProf));
        }
    }

    void *devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = memWaitValueTask->funCallMemSize2 +
        MEM_WAIT_WRITE_VALUE_ADDRESS_LEN + FUNC_CALL_INSTR_ALIGN_SIZE + sizeof(uint64_t);
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

    void *addr = RtValueToPtr<void *>(RtPtrToValue(memWaitValueTask->writeValueAddr) + MEM_WAIT_WRITE_VALUE_ADDRESS_LEN);
    uint64_t initValue = 0UL;
    (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(addr, sizeof(uint64_t), static_cast<const void *>(&initValue),
                                                    sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);    
    memWaitValueTask->profDisableStatusAddr = RtPtrToValue(addr);

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

    return RT_ERROR_NONE;
}

void DoCompleteSuccessForIpcWaitTask(TaskInfo* taskInfo, const uint32_t devId)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(memWaitValueTask->event == nullptr, "event is nullptr");
    IpcEvent *event = dynamic_cast<IpcEvent *>(memWaitValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    uint16_t curIndex = memWaitValueTask->curIndex;

    IpcEventDestroy(&event, curIndex, false);
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
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Failed to alloc host memory, retCode=%#x.", error);
 
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
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Convert memory address to dma physic failed,retCode=%#x,ptr=%#" PRIx64 ".",
        error, streamSwitchTask->ptr);
 
    uint64_t physicValuePtr = 0UL;
    error = updateTask->stream->Device_()->Driver_()->MemAddressTranslate(
        devId, streamSwitchTask->valuePtr, &physicValuePtr);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
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
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "tilingKeyAddr MemAddressTranslate retCode=%#x.", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->blockDimAddr), &blockDimOffset);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "blockDimAddr MemAddressTranslate retCode=%#x", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(devCopyMem), &tilingTaboffset);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "devCopyMem MemAddressTranslate retCode=%#x.", error);

    if (mdlUpdateTaskInfo->fftsPlusTaskDescBuf != nullptr) {
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->fftsPlusTaskDescBuf), &descBufOffset);
    } else {
        error = SetMixDescBufOffset(taskInfo, mdlUpdateTaskInfo->desStreamId, mdlUpdateTaskInfo->destaskId, &descBufOffset);
    }
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "descBuf MemAddressTranslate retCode=%#x.", error);

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
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update dma or offset failed, retCode=%#x", error);
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
    bool canEventbeDelete = (*eventPtr)->TryFreeEventIdAndCheckCanBeDelete(freeId, isNeedDestroy);
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
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Record task parameters in capture mode");
    params->eventRecordTaskParams.event = event;
    params->eventRecordTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventRecordTaskParams.recordFlag = RT_EVENT_RECORD_DEFAULT;

    return RT_ERROR_NONE;
}

rtError_t GetCaptureWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_WAIT;
    SetCommonTaskParams(params);

    Event *event = taskInfo->u.memWaitValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Wait task parameters in capture mode");
    params->eventWaitTaskParams.event = event;
    params->eventWaitTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventWaitTaskParams.waitFlag = RT_EVENT_WAIT_DEFAULT;

    return RT_ERROR_NONE;
}

rtError_t GetCaptureResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_RESET;
    SetCommonTaskParams(params);

    Event *event = taskInfo->u.memWriteValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Reset task parameters in capture mode");
    params->eventResetTaskParams.event = event;
    params->eventResetTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventResetTaskParams.resetFlag = RT_EVENT_WAIT_DEFAULT;

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

    COND_RETURN_WARN(IsTaskBelongToSubCaptureMdl(taskInfo),
        RT_ERROR_FEATURE_NOT_SUPPORT, "task belongs to sub ACL Graph, does not support updating task parameters");

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
    taskInfo->sqeNum = 1U;

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
    taskInfo->sqeNum = GetSendSqeNum(taskInfo);

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

#if F_DESC("CreateL2AddrTask")
rtError_t CreateL2AddrTaskInit(TaskInfo * const taskInfo, const uint64_t ptePtrAddr)
{
    CreateL2AddrTaskInfo *createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_CREATE_L2_ADDR;
    taskInfo->typeName = "CREATE_L2_ADDR";
    createL2AddrTaskInfo->ptePA = ptePtrAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForCreateL2AddrTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    CreateL2AddrTaskInfo *createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.createL2Addr.l2BaseVaddrForsdma =
        RtPtrToValue<void *>(stream->Device_()->GetL2Buffer_());
    RT_LOG(RT_LOG_DEBUG, "l2BaseVaddrForsdma=%#" PRIx64, command->u.createL2Addr.l2BaseVaddrForsdma);
    command->u.createL2Addr.ptePA = createL2AddrTaskInfo->ptePA;
    RT_LOG(RT_LOG_DEBUG, "ptePA=%#" PRIx64, command->u.createL2Addr.ptePA);
    command->u.createL2Addr.pid = PidTidFetcher::GetCurrentPid();
    command->u.createL2Addr.virAddr = MAX_UINT32_NUM;
}
#endif

#if F_DESC("UpdateAddressTask")
rtError_t UpdateAddressTaskInit(TaskInfo* taskInfo, uint64_t devAddr, uint64_t len)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "Update_Address";
    taskInfo->type = TS_TASK_TYPE_UPDATE_ADDRESS;
    taskInfo->u.updateAddrTask.devAddr = devAddr;
    taskInfo->u.updateAddrTask.len = len;
    return RT_ERROR_NONE;
}
#endif

}  // namespace runtime
}  // namespace cce
