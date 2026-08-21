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
#include "task_info.hpp"
#include "runtime_task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "error_message_manage.hpp"
#include "enum_desc.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr const uint32_t ASYNC_MEMORY_NUM = 2U;
constexpr uint8_t DSA_SQE_UPDATE_OFFSET = 16U;
} // namespace

TIMESTAMP_EXTERN(rtMemcpyAsync_drvDeviceGetTransWay);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemConvertAddr);

#ifdef __RT_CFG_HOST_CHIP_HI3559A__
rtError_t AllocCpyTmpMem(TaskInfo* const taskInfo, uint32_t& cpyType, const void*& src, void*& des, uint64_t size)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();
    rtError_t error = RT_ERROR_NONE;
    if ((cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) || (cpyType == RT_MEMCPY_HOST_TO_DEVICE)) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, stream->Device_()->Id_());
        } else {
            error =
                driver->DevMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        ERROR_RETURN(
            error, "Alloc src failed,size=%" PRIu64 "(bytes), device_id=%u, retCode=%#x", size,
            stream->Device_()->Id_(), error);
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->srcPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, size, "malloc");
        errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << RtPtrToValue(memcpyAsyncTaskInfo->srcPtr) << ", src=0x" << RtPtrToValue(src)
               << std::dec << ", destMax=" << sizeof(size) << ", count=" << sizeof(size) << ".";
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1020, "Preparing temporary memory for asynchronous memory copy", "memcpy_s",
                std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
            return RT_ERROR_SEC_HANDLE;
        }
        src = (void*)memcpyAsyncTaskInfo->srcPtr;
    } else if ((cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) || (cpyType == RT_MEMCPY_DEVICE_TO_HOST)) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = des;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, stream->Device_()->Id_());
        } else {
            error =
                driver->DevMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        ERROR_RETURN(
            error, "Alloc dest failed, size=%u(bytes), device_id=%u, retCode=%#x", size, stream->Device_()->Id_(),
            error);
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->desPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, size, "malloc");
        des = (void*)memcpyAsyncTaskInfo->desPtr;
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    }
    return error;
}

#else
rtError_t AllocCpyTmpMem(
    TaskInfo* const taskInfo, uint32_t& cpyType, const void*& srcAddr, void*& desAddr, const uint64_t addrSize)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    constexpr uint32_t ASYNC_MEMORY_ALIGN_SIZE = 64U;
    constexpr uint32_t ASYNC_MEMORY_SIZE = ASYNC_MEMORY_NUM * 64U;
    rtError_t error = RT_ERROR_NONE;
    if (cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < ASYNC_MEMORY_SIZE), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes).", addrSize);

        if (stream->Device_()->IsAddrFlatDev()) {
            error = driver->HostMemAlloc(
                &memcpyAsyncTaskInfo->srcPtr, (addrSize + ASYNC_MEMORY_SIZE), stream->Device_()->Id_());
        } else {
            memcpyAsyncTaskInfo->srcPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
        }

        ERROR_RETURN(error, "HostMemAlloc failed, retCode=%#x", static_cast<uint32_t>(error));
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->srcPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
            addrSize + ASYNC_MEMORY_SIZE, "malloc");

        const uintptr_t offset =
            reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) + static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) % static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE));
        const errno_t rc = memcpy_s(reinterpret_cast<void*>(offset), addrSize, srcAddr, addrSize);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << offset << ", src=0x" << RtPtrToValue(srcAddr) << std::dec
               << ", destMax=" << sizeof(addrSize) << ", count=" << sizeof(addrSize) << ".";
            if (stream->Device_()->IsAddrFlatDev()) {
                COND_PROC_RETURN_AND_MSG_OUTER(rc != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020,
                                               (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
                                               memcpyAsyncTaskInfo->srcPtr = nullptr,
                                               "Preparing temporary memory for asynchronous memory copy", "memcpy_s",
                                               std::to_string(rc), strerror(rc), ss.str().c_str());
            } else {
                COND_PROC_RETURN_AND_MSG_OUTER(
                    rc != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020, free(memcpyAsyncTaskInfo->srcPtr);
                    memcpyAsyncTaskInfo->srcPtr = nullptr, "Preparing temporary memory for asynchronous memory copy",
                    "memcpy_s", std::to_string(rc), strerror(rc), ss.str().c_str());
            }
        }

        srcAddr = reinterpret_cast<void*>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < ASYNC_MEMORY_SIZE), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes)."
            " Expected value: [0, %" PRIu64 "].",
            addrSize, MAX_UINT64_NUM);
        memcpyAsyncTaskInfo->desPtr = malloc(addrSize + ASYNC_MEMORY_SIZE);
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->desPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
            addrSize + ASYNC_MEMORY_SIZE, "malloc");
        const uintptr_t offset =
            reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) + static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) % static_cast<uint64_t>(ASYNC_MEMORY_ALIGN_SIZE));
        desAddr = reinterpret_cast<void*>(offset);
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    } else {
        // no operation
    }
    return error;
}

rtError_t AllocCpyTmpMemForDavid(
    TaskInfo* const taskInfo, uint32_t& cpyType, const void*& srcAddr, void*& desAddr, const uint64_t addrSize)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    constexpr uint32_t asyncMemoryAlignSize = 64U;
    constexpr uint32_t asyncMemorySize = ASYNC_MEMORY_NUM * 64U;
    rtError_t error = RT_ERROR_NONE;
    if (cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < asyncMemorySize), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes).", addrSize);
        error =
            driver->HostMemAlloc(&memcpyAsyncTaskInfo->srcPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
        COND_RETURN_ERROR(
            (memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "HostMemAlloc src address failed, malloc size is %" PRIu64, addrSize + asyncMemorySize);
        ERROR_RETURN(error, "HostMemAlloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        const uintptr_t offset =
            reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) + static_cast<uint64_t>(asyncMemoryAlignSize) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->srcPtr) % static_cast<uint64_t>(asyncMemoryAlignSize));
        error =
            driver->MemCopySync(reinterpret_cast<void*>(offset), addrSize, srcAddr, addrSize, RT_MEMCPY_HOST_TO_HOST);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr),
            "MemCopySync failed, retCode is %d, size is %" PRIu64, error, addrSize);
        srcAddr = reinterpret_cast<void*>(offset);
    } else if (cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = desAddr;
        COND_RETURN_ERROR_MSG_INNER(
            ((MAX_UINT64_NUM - addrSize) < asyncMemorySize), RT_ERROR_INVALID_VALUE,
            "The requested memory is too large and cannot be aligned, size=%" PRIu64 "(bytes)."
            " Expected value: [0, %" PRIu64 "].",
            addrSize, MAX_UINT64_NUM);
        error =
            driver->HostMemAlloc(&memcpyAsyncTaskInfo->desPtr, (addrSize + asyncMemorySize), stream->Device_()->Id_());
        COND_RETURN_ERROR(
            (memcpyAsyncTaskInfo->desPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "HostMemAlloc dest address failed, malloc size is %" PRIu64, (addrSize + asyncMemorySize));
        ERROR_RETURN(error, "HostMemAlloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        const uintptr_t offset =
            reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) + static_cast<uint64_t>(asyncMemoryAlignSize) -
            (reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->desPtr) % static_cast<uint64_t>(asyncMemoryAlignSize));
        desAddr = reinterpret_cast<void*>(offset);
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    } else {
        // no operation
    }
    return error;
}
#endif

rtError_t AllocCpyTmpMemFor3588(
    TaskInfo* const taskInfo, uint32_t& cpyType, const void*& src, void*& des, uint64_t size)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = stream->Device_()->Driver_();
    rtError_t error = RT_ERROR_NONE;
    if ((cpyType == RT_MEMCPY_HOST_TO_DEVICE_EX) || (cpyType == RT_MEMCPY_HOST_TO_DEVICE)) {
        cpyType = RT_MEMCPY_HOST_TO_DEVICE;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, stream->Device_()->Id_());
        } else {
            error =
                driver->DevMemAlloc(&(memcpyAsyncTaskInfo->srcPtr), size, RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->srcPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "Failed to alloc memory, err=%#x, size=%" PRIu64 "(bytes), devId=%u.", error, size,
            stream->Device_()->Id_());
        const errno_t rc = memcpy_s(memcpyAsyncTaskInfo->srcPtr, size, src, size);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "dest=0x" << RtPtrToValue(memcpyAsyncTaskInfo->srcPtr) << ", src=0x" << RtPtrToValue(src)
               << std::dec << ", destMax=" << size << ", count=" << size << ".";
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1020, "Preparing temporary memory for asynchronous memory copy", "memcpy_s",
                std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
            return RT_ERROR_SEC_HANDLE;
        }
        src = (void*)memcpyAsyncTaskInfo->srcPtr;
    } else if ((cpyType == RT_MEMCPY_DEVICE_TO_HOST_EX) || (cpyType == RT_MEMCPY_DEVICE_TO_HOST)) {
        cpyType = RT_MEMCPY_DEVICE_TO_HOST;
        memcpyAsyncTaskInfo->originalDes = des;
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = driver->HostMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, stream->Device_()->Id_());
        } else {
            error =
                driver->DevMemAlloc(&(memcpyAsyncTaskInfo->desPtr), size, RT_MEMORY_DEFAULT, stream->Device_()->Id_());
        }
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE) || (memcpyAsyncTaskInfo->desPtr == nullptr), RT_ERROR_MEMORY_ALLOCATION,
            "Failed to malloc dest ptr, err=%#x, size=%" PRIu64 "(bytes), devId:%u.", error, size,
            stream->Device_()->Id_());
        des = (void*)memcpyAsyncTaskInfo->desPtr;
        memcpyAsyncTaskInfo->isConcernedRecycle = true;
    } else {
        // no operation
    }
    return error;
}

void ReleaseCpyTmpMemFor3588(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = stream->Device_()->Driver_();

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

rtError_t MemcpyAsyncTaskCommonInit(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
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
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->guardMemVec == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
            sizeof(std::vector<std::shared_ptr<void>>), "new");
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
    if (cpyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH) ||
        cpyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D)) {
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

rtError_t ConvertD2DCpyType(const Stream* const stm, uint32_t& cpyType, const void* const srcAddr, void* const desAddr)
{
    Driver* const driver = stm->Device_()->Driver_();
    uint8_t transType = 0U;
    TIMESTAMP_BEGIN(rtMemcpyAsync_drvDeviceGetTransWay);
    const rtError_t error = driver->GetTransWayByAddr(RtPtrToUnConstPtr<void*>(srcAddr), desAddr, &transType);
    TIMESTAMP_END(rtMemcpyAsync_drvDeviceGetTransWay);

    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "D2D memcpy async, get channel type failed, retCode=%#x.",
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

rtError_t ConvertCpyType(
    TaskInfo* const taskInfo, const uint32_t cpyType, const void* const srcAddr, void* const desAddr)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
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
        ERROR_RETURN_MSG_INNER(
            error, "Failed to convert the D2D asynchronous copy type, retCode=%#x.", static_cast<uint32_t>(error));
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

rtError_t MemcpyAsyncTaskInitV1(TaskInfo* const taskInfo, void* memcpyAddrInfo, const uint64_t cpySize)
{
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V1 failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());

    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->memcpyAddrInfo = memcpyAddrInfo;
    memcpyAsyncTaskInfo->size = cpySize;

    // use copyKind_ = RT_MEMCPY_RESERVED to distinguish from the ptr_mode=0 mode
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTaskInfo->copyKind = RT_MEMCPY_RESERVED;
    RT_LOG(RT_LOG_DEBUG, "MemcpyAsyncPtr Task Init, devId=%d, cpySize=%" PRIu64, devId, cpySize);
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskInitV2(
    TaskInfo* const taskInfo, void* const dst, const uint64_t dstPitch, const void* const srcAddr,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const uint32_t kind, const uint64_t fixedSize)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V2 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    if (kind == RT_MEMCPY_HOST_TO_DEVICE) {
        memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_H2D;
    } else if (kind == RT_MEMCPY_DEVICE_TO_HOST) {
        memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_D2H;
    } else if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
        error = ConvertCpyType(taskInfo, kind, srcAddr, dst);
        ERROR_RETURN_MSG_INNER(
            error, "Failed to convert the D2D asynchronous copy typeD2D, retCode=%#x, kind=%s.", error,
            MemcpyKindToStr(static_cast<rtMemcpyKind_t>(kind)));
    } else {
        // reserve
    }

    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(stream->Device_()->Id_());
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    // d2d copy data convert
    if ((copyType == RT_MEMCPY_DIR_D2D_SDMA) || (copyType == RT_MEMCPY_DIR_D2D_HCCs) ||
        (copyType == RT_MEMCPY_DIR_D2D_PCIe)) {
        memcpyAsyncTaskInfo->src = const_cast<void*>(srcAddr);
        memcpyAsyncTaskInfo->destPtr = dst;
        RT_LOG(
            RT_LOG_DEBUG,
            "MemcpyAsync2dTask Init, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64 ", height=%" PRIu64
            ", fixedSize:%" PRIu64 ", copyType=%u.",
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
            error = driver->MemCopy2D(
                dst, dstPitch, srcAddr, srcPitch, width, height, kind, DEVMM_MEMCPY2D_ASYNC_CONVERT, fixedSize,
                &(memcpyAsyncTaskInfo->dmaAddr));
            ERROR_RETURN_MSG_INNER(error, "invoke rtMemcpy2DAsync failed, retCode=%#x.", error);
            memcpyAsyncTaskInfo->isConcernedRecycle = true;
            memcpyAsyncTaskInfo->size = memcpyAsyncTaskInfo->dmaAddr.fixed_size;
            if (stream->Device_()->IsDavidPlatform() && IsPcieDma(memcpyAsyncTaskInfo->copyType) &&
                !(Runtime::Instance()->GetConnectUbFlag())) {
                memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
            }
            RT_LOG(
                RT_LOG_DEBUG,
                "MemcpyAsync2dTask Init, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64 ", height=%" PRIu64
                ", fixedSize:%" PRIu64 ", copyType=%u, dmaKernelConvertFlag=%u.",
                dstPitch, srcPitch, width, height, fixedSize, memcpyAsyncTaskInfo->copyType,
                memcpyAsyncTaskInfo->dmaKernelConvertFlag);
        }
        return RT_ERROR_NONE;
    }
}

rtError_t MemcpyAsyncTaskInitV3(
    TaskInfo* const taskInfo, uint32_t cpyType, const void* srcAddr, void* desAddr, const uint64_t cpySize,
    const rtTaskCfgInfo_t* cfgInfo, const rtD2DAddrCfgInfo_t* const addrCfg)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V3 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);

    if (Runtime::Instance()->isRK3588HostCpu()) {
        error = AllocCpyTmpMemFor3588(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    } else if (stream->Device_()->IsDavidPlatform()) {
        error = AllocCpyTmpMemForDavid(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    } else {
        error = AllocCpyTmpMem(taskInfo, cpyType, srcAddr, desAddr, cpySize);
    }
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to alloc copy memory, retCode=%#x, size=%" PRIu64 "(bytes)", error,
        cpySize);

    error = ConvertCpyType(taskInfo, cpyType, srcAddr, desAddr);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert copy type, retCode=%#x, size=%" PRIu64 "(bytes).", error,
        cpySize);
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
        RT_LOG(
            RT_LOG_INFO, "cpySize=%llu, srcOffset=%llu, dstOffset=%llu.", memcpyAsyncTaskInfo->size,
            memcpyAsyncTaskInfo->srcOffset, memcpyAsyncTaskInfo->dstOffset);
    }

    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA && !stream->Device_()->IsDavidPlatform()) {
        uint64_t sourceAddr;
        uint64_t destAddr;
        error = driver->MemAddressTranslate(devId, reinterpret_cast<uintptr_t>(srcAddr), &sourceAddr);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error,
            "Convert D2D source memory address from virtual to physic failed, retCode=%#x.", error);
        error = driver->MemAddressTranslate(devId, reinterpret_cast<uintptr_t>(desAddr), &destAddr);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error,
            "Convert D2D dest memory address from virtual to dma physic failed, retCode=%#x.", error);

        memcpyAsyncTaskInfo->src = reinterpret_cast<void*>(static_cast<uintptr_t>(sourceAddr));
        memcpyAsyncTaskInfo->destPtr = reinterpret_cast<void*>(static_cast<uintptr_t>(destAddr));
    } else {
        memcpyAsyncTaskInfo->src = const_cast<void*>(srcAddr);
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
            error = driver->MemConvertAddr(
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcAddr)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(desAddr)), cpySize, &(memcpyAsyncTaskInfo->dmaAddr));
            COND_RETURN_ERROR(
                (error != RT_ERROR_NONE), error,
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
        error = driver->MemConvertAddr(
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcAddr)),
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(desAddr)), cpySize, &(memcpyAsyncTaskInfo->dmaAddr));
        TIMESTAMP_END(rtMemcpyAsync_drvMemConvertAddr);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "Convert memory address from virtual to dma physical failed, retCode=%#x.",
            error);
        // dmaAddr.fixed_size may not be equal to size
        memcpyAsyncTaskInfo->size = memcpyAsyncTaskInfo->dmaAddr.fixed_size;
    }

    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncD2HTaskInit(
    TaskInfo* const taskInfo, const void* srcAddr, const uint64_t cpySize, uint32_t sqId, uint32_t pos)
{
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncD2HTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->copyKind = static_cast<uint32_t>(RT_MEMCPY_DEVICE_TO_HOST);
    memcpyAsyncTaskInfo->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_D2H);
    memcpyAsyncTaskInfo->size = cpySize;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->src = const_cast<void*>(srcAddr);
    memcpyAsyncTaskInfo->dsaSqeUpdateFlag = true;
    memcpyAsyncTaskInfo->sqId = sqId;
    memcpyAsyncTaskInfo->taskPos = pos;
    memcpyAsyncTaskInfo->sqeOffset = DSA_SQE_UPDATE_OFFSET;

    RT_LOG(
        RT_LOG_INFO, "dev_id=%d, stream_id=%d, sqId=%u, pos=%u", devId, stream->Id_(), memcpyAsyncTaskInfo->sqId,
        memcpyAsyncTaskInfo->taskPos);

    return RT_ERROR_NONE;
}

void ToCommandBodyForMemcpyAsyncTask(TaskInfo* const taskInfo, rtCommand_t* const command)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;

    command->u.memcpyTask.dir = static_cast<uint8_t>(copyType);
    command->u.memcpyTask.d2dOffsetFlag = 0U;
    RT_LOG(
        RT_LOG_INFO, "MemcpyAsyncTask::ToCommandBody, command->u.memcpyTask.dir=%u.",
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
        command->u.memcpyTask.memcpyType = 0U; // single copy
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

            RT_LOG(
                RT_LOG_INFO, "command offset=%hu-%u-%hu-%u", command->u.memcpyTask.d2dAddrOffset.srcOffsetHigh,
                command->u.memcpyTask.d2dAddrOffset.srcOffsetLow, command->u.memcpyTask.d2dAddrOffset.dstOffsetHigh,
                command->u.memcpyTask.d2dAddrOffset.dstOffsetLow);
        } else {
            command->u.memcpyTask.noDmaOffsetAddr.srcVirAddr = MAX_UINT32_NUM;
            command->u.memcpyTask.noDmaOffsetAddr.dstVirAddr = MAX_UINT32_NUM;
        }
    }
    command->taskInfoFlag = stream->GetTaskRevFlag(taskInfo->bindFlag);
    RT_LOG(RT_LOG_INFO, "command d2dOffsetFlag=%u", command->u.memcpyTask.d2dOffsetFlag);
}

void SetStarsResultForMemcpyAsyncTask(TaskInfo* const taskInfo, const rtCqReport_t& logicCq)
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

bool GetModuleIdByMemcpyAddr(Driver const* const driver, void* memcpyAddr, uint32_t* moduleId)
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

void PrintModuleIdProc(Driver const* const driver, char_t* const errStr, void* src, void* dst, int32_t& countNum)
{
    uint32_t srcModuleId = SVM_INVALID_MODULE_ID;
    uint32_t dstModuleId = SVM_INVALID_MODULE_ID;
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void*>(&src), &srcModuleId)) {
        if (srcModuleId != SVM_INVALID_MODULE_ID) {
            countNum += snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_module_id=%u", srcModuleId);
        }
    }
    if (GetModuleIdByMemcpyAddr(driver, reinterpret_cast<void*>(&dst), &dstModuleId)) {
        if (dstModuleId != SVM_INVALID_MODULE_ID) {
            countNum += snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", dst_module_id=%u", dstModuleId);
        }
    }
}

static void PrintUbdmaErrorInfo(const MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo)
{
    if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
        RT_LOG(
            RT_LOG_ERROR,
            "ub async copy error, die_id=%u, functionId=%u, jettyId=%u,"
            " wqeLen=%d, is_sqe_update=%d, pi=%u, fixedSize(fixedCnt)=%llu.",
            memcpyAsyncTaskInfo->ubDma.dieId, memcpyAsyncTaskInfo->ubDma.functionId, memcpyAsyncTaskInfo->ubDma.jettyId,
            memcpyAsyncTaskInfo->ubDma.wqeLen, memcpyAsyncTaskInfo->isSqeUpdateH2D, memcpyAsyncTaskInfo->ubDma.pi,
            memcpyAsyncTaskInfo->ubDma.fixedSize);
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
        const char_t* desc;
    };

    static const CopyTypeToStr table[] = {
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

void PrintErrorInfoForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    const int32_t streamId = stream->Id_();

    PrintUbdmaErrorInfo(memcpyAsyncTaskInfo);

    uint8_t errorModuleType = ERR_MODULE_RTS;
    char_t errMsg[MSG_LENGTH] = {};
    char_t* const errStr = errMsg;
    int32_t countNum = sprintf_s(
        errStr, static_cast<size_t>(MSG_LENGTH),
        "Asynchronous memory copy failed, device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu, ", devId, streamId,
        taskInfo->id, taskInfo->flipNum);
    if ((countNum < 0) || (countNum > MSG_LENGTH)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call sprintf_s, count=%d.", countNum);
        return;
    }

    Stream* const reportStream = GetReportStream(stream);
    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA) &&
        (!memcpyAsyncTaskInfo->dmaKernelConvertFlag)) {
        if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
            countNum += sprintf_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%s, sq_id=%u, task_pos=%u, cp_size=%#" PRIx64, TransMemCopyDirToStr(copyType),
                memcpyAsyncTaskInfo->sqId, memcpyAsyncTaskInfo->taskPos, memcpyAsyncTaskInfo->size);
            (void)snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_dev_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)));
        } else {
            countNum += sprintf_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                "copy_type=%s, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%u",
                TransMemCopyDirToStr(copyType), static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
                static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
            (void)snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst)));
        }
    } else {
        errorModuleType = GetMemCpyErrorModule(copyType);
        countNum += sprintf_s(
            errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
            "copy_type=%s, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%" PRIu64,
            TransMemCopyDirToStr(copyType), static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->size);

        if ((copyKind == RT_MEMCPY_RESERVED) && (copyType == RT_MEMCPY_ADDR_D2D_SDMA)) {
            countNum += snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", memcpyAddrInfo=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->memcpyAddrInfo)));
            PrintAsyncPtrProc(driver, errStr, memcpyAsyncTaskInfo->memcpyAddrInfo, countNum);
        } else {
            countNum += snprintf_truncated_s(
                errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
                ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src)),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->destPtr)));
            PrintModuleIdProc(driver, errStr, memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr, countNum);
        }
    }
    STREAM_REPORT_ERR_MSG(reportStream, errorModuleType, "%s", errStr);
}

void RecycleTaskResourceForMemcpyAsyncTask(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if ((memcpyAsyncTaskInfo->desPtr != nullptr) && (memcpyAsyncTaskInfo->originalDes != nullptr) &&
        (memcpyAsyncTaskInfo->destPtr != nullptr)) {
        const errno_t rc = memcpy_s(
            memcpyAsyncTaskInfo->originalDes, memcpyAsyncTaskInfo->size, memcpyAsyncTaskInfo->destPtr,
            memcpyAsyncTaskInfo->size);
        if (rc != EOK) {
            RT_LOG_INNER_MSG(
                RT_LOG_ERROR,
                "Failed to call memcpy_s to copy memcpyAsyncTaskInfo->destPtr,"
                " src=%p, dest=%p, dest_max=%" PRIu64 ", count=%" PRIu64 ", retCode=%#x.",
                memcpyAsyncTaskInfo->destPtr, memcpyAsyncTaskInfo->originalDes, memcpyAsyncTaskInfo->size,
                memcpyAsyncTaskInfo->size, rc);
            return;
        }
    }
}

bool IsPcieDma(const uint32_t copyTypeFlag)
{
    if ((copyTypeFlag == RT_MEMCPY_DIR_H2D) || (copyTypeFlag == RT_MEMCPY_DIR_D2H) ||
        (copyTypeFlag == RT_MEMCPY_DIR_D2D_PCIe)) {
        return true;
    } else {
        return false;
    }
}

bool IsDavidUbDma(const uint32_t copyTypeFlag)
{
    if ((Runtime::Instance()->GetConnectUbFlag()) &&
        ((copyTypeFlag == RT_MEMCPY_DIR_H2D) || (copyTypeFlag == RT_MEMCPY_DIR_D2H) ||
         (copyTypeFlag == RT_MEMCPY_DIR_D2D_UB))) {
        return true;
    }
    return false;
}

} // namespace runtime
} // namespace cce
