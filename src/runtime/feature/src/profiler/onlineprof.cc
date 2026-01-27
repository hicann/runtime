/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "onlineprof.hpp"
#include "securec.h"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
rtError_t OnlineProf::OnlineProfMalloc(Stream * const stm)
{
    rtError_t ret;
    errno_t memRet;
    rtError_t freeRet1 = RT_ERROR_NONE;
    rtError_t freeRet2 = RT_ERROR_NONE;
    rtError_t freeRet3 = RT_ERROR_NONE;
    /* malloc addr */
    void *deviceMem = nullptr;
    void *hostRtMem = nullptr;
    void *hostTsMem = nullptr;

    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    Device * const dev = stm->Device_();
    Driver * const deviceDrv = dev->Driver_();
    constexpr uint64_t memSize = static_cast<uint64_t>(ONLINEPROF_MEM_SIZE) * 2UL;
    const rtChipType_t chipType = stm->Device_()->GetChipType();
    Runtime * const rtInstance = Runtime::Instance();
    const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, memSize);
    ret = deviceDrv->DevMemAlloc(&deviceMem, memSize, memType, dev->Id_());
    ERROR_RETURN(ret, "Alloc online profiling device memory failed, "
        "size=%" PRIu64 ", type=%d, id=%d, retCode=%#x!", memSize, RT_MEMORY_DEFAULT, dev->Id_(),
        static_cast<uint32_t>(ret));

    if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE_DEVICE_MEM_CLEAR)) {
        ret = deviceDrv->MemSetSync(deviceMem, memSize, 0U, memSize);
        ERROR_GOTO_MSG_INNER(ret, ERROR_FREE, "Memset sync device memory failed, "
                                               "size=%" PRIu64 ", retCode=%#x!", memSize, static_cast<uint32_t>(ret));

        ret = deviceDrv->DevMemFlushCache(RtPtrToValue(deviceMem),
            static_cast<size_t>(memSize));
        ERROR_GOTO_MSG_INNER(ret, ERROR_FREE, "Online profiling memory flush failed, size=%zu, retCode=%#x!",
            static_cast<size_t>(memSize), static_cast<uint32_t>(ret));
    }

    ret = deviceDrv->HostMemAlloc(&hostRtMem, static_cast<uint64_t>(ONLINEPROF_MEM_SIZE), dev->Id_());
    ERROR_GOTO(ret, ERROR_FREE, "Alloc start online profiling host runtime memory failed, "
                                           "size=%u, retCode=%#x!", ONLINEPROF_MEM_SIZE, static_cast<uint32_t>(ret));

    memRet = memset_s(hostRtMem, ONLINEPROF_MEM_SIZE, 0, ONLINEPROF_MEM_SIZE);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, memRet != EOK, ERROR_FREE, ret, RT_ERROR_SEC_HANDLE,
        "Online prof malloc failed, memset_s fail, size=%u, retCode=%u!", ONLINEPROF_MEM_SIZE,
        static_cast<uint32_t>(ret));

    ret = deviceDrv->HostMemAlloc(&hostTsMem, static_cast<uint64_t>(ONLINEPROF_MEM_SIZE), dev->Id_());
    ERROR_GOTO(ret, ERROR_FREE, "Alloc start online profiling host tsch memory failed, "
                                           "size=%u, retCode=%#x!", ONLINEPROF_MEM_SIZE, static_cast<uint32_t>(ret));

    memRet = memset_s(hostTsMem, ONLINEPROF_MEM_SIZE, 0, ONLINEPROF_MEM_SIZE);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, memRet != EOK, ERROR_FREE, ret, RT_ERROR_SEC_HANDLE,
        "Online prof malloc failed, memset_s fail, size=%u, retCode=%u!", ONLINEPROF_MEM_SIZE,
        static_cast<uint32_t>(ret));

    stm->SetOnProfDeviceAddr(deviceMem);
    stm->SetOnProfHostRtAddr(hostRtMem);
    stm->SetOnProfHostTsAddr(hostTsMem);
    return RT_ERROR_NONE;

ERROR_FREE:
    if (deviceMem != nullptr) {
        freeRet1 = deviceDrv->DevMemFree(deviceMem, dev->Id_());
    }
    if (hostRtMem != nullptr) {
        freeRet2 = deviceDrv->HostMemFree(hostRtMem);
    }
    if (hostTsMem != nullptr) {
        freeRet3 = deviceDrv->HostMemFree(hostTsMem);
    }
    ERROR_RETURN_MSG_INNER(freeRet1, "Free online profiling memory[deviceMem] failed, "
                 "retCode=%#x!", static_cast<uint32_t>(ret));
    ERROR_RETURN_MSG_INNER(freeRet2, "Free online profiling memory[hostRtMem] failed, "
                 "retCode=%#x!", static_cast<uint32_t>(ret));
    ERROR_RETURN_MSG_INNER(freeRet3, "Free online profiling memory[hostTsMem] failed, "
                 "retCode=%#x!", static_cast<uint32_t>(ret));
    return ret;
}

rtError_t OnlineProf::OnlineProfFree(Stream * const stm)
{
    rtError_t error;
    /* free memory */
    void *deviceMem = nullptr;
    void *hostRtMem = nullptr;
    void *hostTsMem = nullptr;
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    Device * const dev = stm->Device_();
    Driver * const deviceDrv = dev->Driver_();

    deviceMem = stm->GetOnProfDeviceAddr();
    if (deviceMem != nullptr) {
        error = deviceDrv->DevMemFree(deviceMem, dev->Id_());
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory deviceMem failed, "
                 "retCode=%#x!", static_cast<uint32_t>(error));
    }

    hostRtMem = stm->GetOnProfHostRtAddr();
    if (hostRtMem != nullptr) {
        error = deviceDrv->HostMemFree(hostRtMem);
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory hostRtMem failed, retCode=%#x",
                 static_cast<uint32_t>(error));
    }

    hostTsMem = stm->GetOnProfHostTsAddr();
    if (hostTsMem != nullptr) {
        error = deviceDrv->HostMemFree(hostTsMem);
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory hostTsMem failed, retCode=%#x",
                 static_cast<uint32_t>(error));
    }
    stm->SetOnProfDeviceAddr(nullptr);
    stm->SetOnProfHostRtAddr(nullptr);
    stm->SetOnProfHostTsAddr(nullptr);

    return RT_ERROR_NONE;
}

rtError_t OnlineProf::GetOnlineProfilingData(const Stream * const stm, rtProfDataInfo_t * const pProfData,
    const uint32_t profDataNum)
{
    /* read memory out */
    void * const hostRtMem = stm->GetOnProfHostRtAddr();
    NULL_PTR_RETURN_MSG(hostRtMem, RT_ERROR_PROF_HOST_MEM);

    void * const hostTsMem = stm->GetOnProfHostTsAddr();
    NULL_PTR_RETURN_MSG(hostTsMem, RT_ERROR_PROF_HOST_MEM);

    void * const deviceMem = stm->GetOnProfDeviceAddr();
    NULL_PTR_RETURN_MSG(deviceMem, RT_ERROR_PROF_DEVICE_MEM);

    uint64_t onlineProfAddr = RtPtrToValue(hostRtMem);
    rtProfDataInfo_t * const profRtSourceData = RtValueToPtr<rtProfDataInfo_t *>(onlineProfAddr + ONLINEPROF_HEAD_SIZE);
    uint64_t * const rtReadAddr = RtPtrToPtr<uint64_t *>(hostRtMem);
    uint64_t * const rtWriteAddr = RtValueToPtr<uint64_t *>(onlineProfAddr + (ONLINEPROF_HEAD_SIZE / 2U)); // 2:half head size
    rtError_t error = stm->Device_()->Driver_()->MemCopySync(hostTsMem, ONLINEPROF_MEM_SIZE,
        deviceMem, ONLINEPROF_MEM_SIZE, RT_MEMCPY_DEVICE_TO_HOST);
    ERROR_RETURN_MSG_INNER(error, "Copy memory from ts to runtime failed, size=%u, kind=%d(RT_MEMCPY_DEVICE_TO_HOST), "
        "retCode=%#x!", ONLINEPROF_MEM_SIZE,
        static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));

    onlineProfAddr = RtPtrToValue(hostTsMem);
    rtProfDataInfo_t * const profTsSourceData =
            RtValueToPtr<rtProfDataInfo_t *>(onlineProfAddr + ONLINEPROF_HEAD_SIZE);
    uint64_t * const tsReadAddr = RtPtrToPtr<uint64_t *>(hostTsMem);
    uint64_t * const tsWriteAddr =
            RtValueToPtr<uint64_t *>(onlineProfAddr + (ONLINEPROF_HEAD_SIZE / 2U));

    if (*tsWriteAddr != *rtWriteAddr) {
        RT_LOG(RT_LOG_WARNING, "ts write index: %" PRIu64 " is not same as rt write index %" PRIu64,
            *tsWriteAddr, *rtWriteAddr);
        *tsWriteAddr = *rtWriteAddr;
    }

    if (*tsReadAddr != *rtReadAddr) {
        RT_LOG(RT_LOG_WARNING, "ts read index: %" PRIu64 " is not same as rt read index %" PRIu64,
            *tsReadAddr, *rtReadAddr);
        *tsReadAddr = *rtReadAddr;
    }

    for (uint32_t profDataIndex = 0U; profDataIndex < profDataNum; profDataIndex++) {
        if (*rtReadAddr == *rtWriteAddr) { /* should not happen */
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to read data, current index=%u, need read num=%u",
                profDataIndex, profDataNum);
            break;
        }
        pProfData[profDataIndex].stubFunc = profRtSourceData[*rtReadAddr].stubFunc;
        pProfData[profDataIndex].blockDim = profRtSourceData[*rtReadAddr].blockDim;
        pProfData[profDataIndex].args     = profRtSourceData[*rtReadAddr].args;
        pProfData[profDataIndex].argsSize = profRtSourceData[*rtReadAddr].argsSize;
        pProfData[profDataIndex].smDesc   = profRtSourceData[*rtReadAddr].smDesc;
        pProfData[profDataIndex].stream   = profRtSourceData[*rtReadAddr].stream;
        if (stm != profRtSourceData[*rtReadAddr].stream) { /* need or not? If yes, need return? */
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "Invalid stream, kernel stream is different from input stream, id=%d", stm->Id_());
        }

        pProfData[profDataIndex].totalcycle = profTsSourceData[*rtReadAddr].totalcycle;
        pProfData[profDataIndex].ovcycle    = profTsSourceData[*rtReadAddr].ovcycle;
        RT_LOG(RT_LOG_DEBUG, "[ts write index=%" PRIu64 "] totalcycle=%" PRIu64 ", ovcycle=%" PRIu64, *rtReadAddr,
               pProfData[profDataIndex].totalcycle, pProfData[profDataIndex].ovcycle);

        *rtReadAddr = (*rtReadAddr + 1U) % MAX_ONLINEPROF_NUM;
    }
    *tsReadAddr = *rtReadAddr;

    error = stm->Device_()->Driver_()->MemCopySync(deviceMem, ONLINEPROF_MEM_SIZE,
        hostTsMem, ONLINEPROF_MEM_SIZE, RT_MEMCPY_HOST_TO_DEVICE);

    return error;
}
}
}
