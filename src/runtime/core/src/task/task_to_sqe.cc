/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task_to_sqe.hpp"
#include <cinttypes>
#include "event.hpp"
#include "common/enum_to_string_utils.hpp"

namespace cce {
namespace runtime {
using pfnNanoTaskToSqe = rtError_t (*)(const rtTaskInput_t* const taskInput, uint32_t* taskLen);

static constexpr pfnNanoTaskToSqe g_BufToFunc[MAX_TASK][RT_TASK_TYPE_MAX] = {
        {nullptr, nullptr, &ConstructAicoreStaticSqe, &ConstructHostFuncStaticSqe},
        {nullptr, nullptr, &ConstructAicoreDynamicSqe, &ConstructHostFuncDynamicSqe},
        {nullptr, nullptr, &ConstructAicoreParamSqe, &ConstructHostFuncParamSqe}
};

rtError_t ConstructSqeByTaskInput(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    const rtTaskBuffType_t taskBufferType = taskInput->compilerInfo.bufType;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME((taskBufferType >= MAX_TASK) || (taskBufferType < HWTS_STATIC_TASK_DESC),
        RT_ERROR_INVALID_VALUE, TaskBuffTypeToString(taskBufferType), "taskBufferType",
        "HWTS_STATIC_TASK_DESC(0), HWTS_DYNAMIC_TASK_DESC(1) or PARAM_TASK_INFO_DESC(2)");

    const rtTaskType_t type = taskInput->compilerInfo.taskType;
    COND_RETURN_AND_MSG_OUTER((type != RT_TASK_TYPE_KERNEL_NANO_AICORE) && (type != RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "rtTaskBuild", "taskInput->compilerInfo.taskType",
        "The current task type does not support this operation");
    pfnNanoTaskToSqe funcHandle = g_BufToFunc[taskBufferType][type];
    if (funcHandle == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    return funcHandle(taskInput, taskLen);
}

rtError_t PreLoadPrefetchSqe::ConstructSqe(const rtParamBufDesc_t& paramBufDesc, rtPrefetchSqe_t* prefetchSqe,
                                         uint32_t bufferLen, uint32_t* taskLen)
{
    constexpr uint16_t maxDataLen = PRELOAD_PARAM_BUFFER_MAX_N;
    const uint16_t prefetchBufSize = paramBufDesc.prefetchBufSize;
    const uint16_t paramBufSize  = paramBufDesc.paramBufSize;

    COND_RETURN_ERROR_MSG_INNER((prefetchBufSize > maxDataLen) || (paramBufSize > maxDataLen), RT_ERROR_INVALID_VALUE,
        "The value of prefetchBufSize %hu and paramBufSize %hu must be less than or equal to that of maxDataLen %hu.",
        prefetchBufSize, paramBufSize, maxDataLen);

    const uint32_t totalSize = static_cast<uint32_t>((sizeof(rtPrefetchSqe_t) * prefetchBufSize) +
        (sizeof(rtPreLoadSqe_t)) * paramBufSize);

    COND_RETURN_ERROR_MSG_INNER(bufferLen < totalSize, RT_ERROR_INVALID_VALUE,
        "The value of bufferLen %u must be greater than or equal to that of totalSize %u.",
        bufferLen, totalSize);

    for (uint16_t i = 0U; i < prefetchBufSize; i++) {
        prefetchSqe->opType = paramBufDesc.prefetchBufInfo[i].opType;
        prefetchSqe->res0 = 0U;
        prefetchSqe->dataSize = paramBufDesc.prefetchBufInfo[i].dataSize;
        prefetchSqe->dstOffset = paramBufDesc.prefetchBufInfo[i].dstOffset;
        prefetchSqe->res1 = 0U;
        prefetchSqe->srcOffset = paramBufDesc.prefetchBufInfo[i].srcOffset;
        prefetchSqe++;
    }

    rtPreLoadSqe_t* preLoadSqe = RtPtrToPtr<rtPreLoadSqe_t*>(prefetchSqe);
    for (uint16_t i = 0U; i < paramBufSize; i++) {
        preLoadSqe->argOffsetAddrLow = get_low_32_addr(paramBufDesc.paramBufInfo[i]);
        preLoadSqe->argOffsetAddrHigh = get_high_32_addr(paramBufDesc.paramBufInfo[i]);
        preLoadSqe++;
    }

    *taskLen = totalSize;
    RT_LOG(RT_LOG_INFO, "Construct prefetch Sqe success. taskLen=%u.", *taskLen);
    return RT_ERROR_NONE;
}

rtError_t ConstructAicoreParamSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    rtPrefetchSqe_t* prefetchSqe = RtPtrToPtr<rtPrefetchSqe_t*>(taskInput->dataBuffer);
    const uint32_t bufferLen = taskInput->bufferLen;
    const rtParamBufDesc_t &paramBufDesc = taskInput->compilerInfo.u.nanoAicoreTask.u.paramBufDesc;
    return PreLoadPrefetchSqe::ConstructSqe(paramBufDesc, prefetchSqe, bufferLen, taskLen);
}

rtError_t ConstructHostFuncParamSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    const uint32_t bufferLen = taskInput->bufferLen;
    const rtParamBufDesc_t &paramBufDesc = taskInput->compilerInfo.u.nanoHostFuncTask.u.paramBufDesc;

    if (bufferLen < paramBufDesc.bufSize) {
        RT_LOG(RT_LOG_ERROR, "paramBufSize [%u] greater bufferLen [%u].", paramBufDesc.bufSize, bufferLen);
        return RT_ERROR_INVALID_VALUE;
    }

    const errno_t ret = memcpy_s(taskInput->dataBuffer, bufferLen, paramBufDesc.bufInfo, paramBufDesc.bufSize);
    if (ret != EOK) {
        std::stringstream ss;
        ss << std::hex << "dest=0x" << RtPtrToValue(taskInput->dataBuffer)
           << ", src=0x" << RtPtrToValue(paramBufDesc.bufInfo)
           << std::dec << ", destMax=" << bufferLen << ", count=" << paramBufDesc.bufSize << ".";
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__,
            "memcpy_s", std::to_string(ret).c_str(), strerror(ret), ss.str().c_str());
        return RT_ERROR_SEC_HANDLE;
    }

    RT_LOG(RT_LOG_INFO, "Construct host func prefetch Sqe success. taskLen=%u.", *taskLen);
    return RT_ERROR_NONE;
}

rtError_t PreLoadStaticSqe::ConstructSqe(const rtHwtsStaticTaskDesc_t& hwtsTaskDesc, uint64_t argOffset,
                                       rtStaticSqe_t* staticSqe, uint32_t* taskLen)
{
    staticSqe->type = hwtsTaskDesc.type;
    staticSqe->pre_p = hwtsTaskDesc.preP;
    staticSqe->post_p = hwtsTaskDesc.posP;
    staticSqe->dump_en = hwtsTaskDesc.dump;
    staticSqe->cond_s = hwtsTaskDesc.conds;
    staticSqe->res0 = hwtsTaskDesc.swapOut;
    staticSqe->uf = hwtsTaskDesc.uf;
    staticSqe->sw = hwtsTaskDesc.sw;
    staticSqe->res1 = 0U;
    staticSqe->prefetchNum = hwtsTaskDesc.prefetchNum;
    staticSqe->softUser = hwtsTaskDesc.softUser;
    staticSqe->res2 = 0U;
    staticSqe->kernelCredit = static_cast<uint8_t>(hwtsTaskDesc.kernelCredit);
    staticSqe->taskParamOffset = hwtsTaskDesc.taskParamOffset + static_cast<uint32_t>(argOffset);

    *taskLen = static_cast<uint32_t>(sizeof(rtStaticSqe_t));
    RT_LOG(RT_LOG_INFO, "Construct Static Sqe success. taskLen=%u, sqeType=%hu, argOffset=%" PRIu64 ".",
        *taskLen, staticSqe->type, argOffset);
    return RT_ERROR_NONE;
}

rtError_t ConstructAicoreStaticSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    rtStaticSqe_t* staticSqe = RtPtrToPtr<rtStaticSqe_t*>(taskInput->dataBuffer);
    const uint64_t argOffset = taskInput->argOffset;

    const rtHwtsStaticTaskDesc_t &hwtsTaskDesc = taskInput->compilerInfo.u.nanoAicoreTask.u.hwtsTaskDesc;
    return PreLoadStaticSqe::ConstructSqe(hwtsTaskDesc, argOffset, staticSqe, taskLen);
}

rtError_t ConstructHostFuncStaticSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    rtStaticSqe_t* staticSqe = RtPtrToPtr<rtStaticSqe_t*>(taskInput->dataBuffer);
    const uint64_t argOffset = taskInput->argOffset;

    const rtHwtsStaticTaskDesc_t &hwtsTaskDesc = taskInput->compilerInfo.u.nanoHostFuncTask.u.hwtsTaskDesc;
    return PreLoadStaticSqe::ConstructSqe(hwtsTaskDesc, argOffset, staticSqe, taskLen);
}

rtError_t PreLoadDynamicSqe::ConstructSqe(const rtHwtsDynamicTaskDesc_t& hwtsDynamicTaskDesc,
                                        rtDynamicSqe_t* dynamicSqe, uint32_t* taskLen)
{
    dynamicSqe->vld = hwtsDynamicTaskDesc.vld;
    dynamicSqe->codeSize = hwtsDynamicTaskDesc.codeSize;
    dynamicSqe->dynTaskDescSize = hwtsDynamicTaskDesc.dynTaskDescSize;
    dynamicSqe->blockDim = hwtsDynamicTaskDesc.blockDim;
    dynamicSqe->taskPcOffset = hwtsDynamicTaskDesc.taskPcOffset;

    *taskLen = static_cast<uint32_t>(sizeof(rtDynamicSqe_t));
    RT_LOG(RT_LOG_INFO, "Construct Dynamic Sqe success. taskLen=%zu.", *taskLen);
    return RT_ERROR_NONE;
}

rtError_t ConstructAicoreDynamicSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    rtDynamicSqe_t* dynamicSqe = RtPtrToPtr<rtDynamicSqe_t*>(taskInput->dataBuffer);

    const rtHwtsDynamicTaskDesc_t &hwtsDynamicTaskDesc = taskInput->compilerInfo.u.nanoAicoreTask.u.hwtsDynamicTaskDesc;
    return PreLoadDynamicSqe::ConstructSqe(hwtsDynamicTaskDesc, dynamicSqe, taskLen);
}


rtError_t ConstructHostFuncDynamicSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen)
{
    rtDynamicSqe_t* dynamicSqe = RtPtrToPtr<rtDynamicSqe_t*>(taskInput->dataBuffer);

    const rtHwtsDynamicTaskDesc_t &taskDesc = taskInput->compilerInfo.u.nanoHostFuncTask.u.hwtsDynamicTaskDesc;
    return PreLoadDynamicSqe::ConstructSqe(taskDesc, dynamicSqe, taskLen);
}

}
}
