/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_log.hpp"
#include "runtime/base.h"
#include "stars_david.hpp"
#include "david_sqe_adapter.hpp"
#include "stars_base.hpp"
#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "runtime_task_manager.h"
#include "error_code.h"
#include "stream_david.hpp"
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_external_event_cond_isa_helper.hpp"
#include "error_message_manage.hpp"
#include "task_execute_time.h"
#include "stream_jetty_handler.h"
#include "ipc_event.hpp"
#include "logic_sq.hpp"
#include "logic_sq_manage.hpp"
#include "memset_common.h"

#include <cstdint>

namespace cce {
namespace runtime {

static void ConstructDavidMemcpySqePtr(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpyPtrSqe* const sqe = &(davidSqe->memcpyAsyncPtrSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    sqe->header.ptrMode = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->va = 1U;
    sqe->sdmaSqeBaseAddrLow =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x00000000FFFFFFFFUL);
    sqe->sdmaSqeBaseAddrHigh = static_cast<uint32_t>(
        (RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x0001FFFF00000000UL) >> UINT32_BIT_NUM);
    PrintDavidSqe(davidSqe, "MemcpyAsyncPtr");
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, memcpyAddrInfo=%p .", taskInfo->stream->Device_()->Id_(),
        stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->memcpyAddrInfo);
}

void ConstructDavidMemcpySqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;

    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        ConstructDavidMemcpySqePtr(taskInfo, davidSqe, sqBaseAddr);
        return;
    }

    RT_LOG(
        RT_LOG_INFO, "ConstructDavidMemcpySqe, type=" RT_ENUM_LOG_FORMAT("%d") ".",
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(taskInfo->type), RT_ENUM_LOG_NAME(taskInfo->typeName)));
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpySqe* const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    /* b605-b606 do not support ADDR D2D SDMA */
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA) {
        sqe->header.preP = 1U;
    }

    if (stream->IsDebugRegister() && (!stream->GetBindFlag())) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->kernelCredit = GetSdmaKernelCredit();

    sqe->srcStreamId = 0x1FU; // get sid and ssid from sq, leave 0 here
    sqe->u.strideMode0.dstStreamId = 0x1FU;
    sqe->srcSubStreamId = 1U;
    sqe->u.strideMode0.dstSubStreamId = 1U;
    RT_LOG(
        RT_LOG_INFO, "ConstructDavidSqe, dstSubStreamId=%u", static_cast<uint32_t>(sqe->u.strideMode0.dstSubStreamId));
    sqe->u.strideMode0.lengthMove = memcpyAsyncTaskInfo->size;
    sqe->u.strideMode0.srcAddrLow = static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->src) & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.srcAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->src) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->u.strideMode0.dstAddrLow =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.dstAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->vaValid = 0U;
    sqe->ie2 = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns = 1U;
    sqe->dns = 1U;
    sqe->qos = memcpyAsyncTaskInfo->qos;
    sqe->sro = 0U;
    sqe->dro = 0U;
    sqe->mapamPartId = memcpyAsyncTaskInfo->partId;
    sqe->mpamns = 0U;
    sqe->stride = 0U;
    sqe->compEn = 0U;
    sqe->pmg = 0U;
    if ((copyType == RT_MEMCPY_DIR_D2D_SDMA) || (copyType == RT_MEMCPY_ADDR_D2D_SDMA)) {
        sqe->qos = 6U;
    }
    sqe->res1 = 0U;
    sqe->res2 = 0U;
    sqe->res3 = 0U;
    sqe->res4 = 0U;

    sqe->d2dOffsetFlag = 0U;
    sqe->u.strideMode0.srcOffsetLow = 0U;
    sqe->u.strideMode0.dstOffsetLow = 0U;
    sqe->u.strideMode0.srcOffsetHigh = 0U;
    sqe->u.strideMode0.dstOffsetHigh = 0U;
    if ((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && memcpyAsyncTaskInfo->d2dOffsetFlag) {
        sqe->d2dOffsetFlag = 1U;
        sqe->u.strideMode0.srcOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->srcOffset);
        sqe->u.strideMode0.dstOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->dstOffset);
        sqe->u.strideMode0.srcOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->srcOffset) >> UINT32_BIT_NUM);
        sqe->u.strideMode0.dstOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->dstOffset) >> UINT32_BIT_NUM);
    }
}

void InitStarsSdmaSqeForDavid(RtDavidStarsMemcpySqe* sdmaSqe, const rtTaskCfgInfo_t* const cfgInfo, const Stream* stm)
{
    sdmaSqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    if (cfgInfo != nullptr) {
        sdmaSqe->mapamPartId = cfgInfo->partId;
    } else {
        sdmaSqe->mapamPartId = 0U;
    }
    sdmaSqe->opcode = 0U;
    sdmaSqe->qos = 6U;
    sdmaSqe->sssv = 1U;
    sdmaSqe->dssv = 1U;
    sdmaSqe->sns = 1U;
    sdmaSqe->dns = 1U;
    sdmaSqe->sro = 0U;
    sdmaSqe->dro = 0U;
    sdmaSqe->mpamns = 0U;
    sdmaSqe->stride = 0U;
    sdmaSqe->compEn = 0U;
    sdmaSqe->pmg = 0U;

    sdmaSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->u.strideMode0.dstStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->srcSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->u.strideMode0.dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
}

#if F_DESC("MemcpyAsyncTask")
void ReleaseCpyTmpMemForDavid(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    if (memcpyAsyncTaskInfo->srcPtr != nullptr) {
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
        memcpyAsyncTaskInfo->srcPtr = nullptr;
    }
    if (memcpyAsyncTaskInfo->desPtr != nullptr) {
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->desPtr);
        memcpyAsyncTaskInfo->desPtr = nullptr;
    }
}

void StarsV2DoCompleteSuccessForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    Stream* const stream = taskInfo->stream;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        switch (static_cast<int16_t>(taskInfo->mte_error)) {
            case TS_ERROR_SDMA_POISON_ERROR:
                errorCode = TS_ERROR_SDMA_POISON_ERROR;
                stream->SetErrCode(errorCode);
                break;
            case TS_ERROR_SDMA_LINK_ERROR:
                errorCode = TS_ERROR_SDMA_LINK_ERROR;
                stream->SetErrCode(errorCode);
                break;
            default:
                stream->SetErrCode(errorCode);
                break;
        }
        if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
            RT_LOG(RT_LOG_ERROR, "mem async copy error, retCode=%#x, [%s].", errorCode, GetTsErrCodeDesc(errorCode));
            PrintErrorInfoForMemcpyAsyncTask(taskInfo, devId);
            TaskFailCallBack(
                static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id), taskInfo->tid, errorCode,
                stream->Device_());
        }
    }
}
/**
 * 将 srcs/dsts/sizes 三个数组整体左移 fixedCnt 个元素，使后续 batch DMA仅处理剩余条目。
 * 当 handleFixedSize 为 true 且 fixedSize 非零时，额外对剩余首元素做偏移修正：src/dst 指针前进 fixedSize 字节，
 * size 减去 fixedSize，用于处理 fixed-size 未拷贝完成的残余部分
 */
static rtError_t ShiftBatchArrays(AsyncDmaBatchInfo& batchInfo, bool handleFixedSize = false)
{
    if (batchInfo.fixedCnt == 0) {
        return RT_ERROR_NONE;
    }

    const uint64_t realCnt = batchInfo.count;
    const size_t offset = static_cast<size_t>(batchInfo.fixedCnt);
    errno_t memRet =
        memmove_s(batchInfo.srcs, realCnt * sizeof(void*), batchInfo.srcs + offset, realCnt * sizeof(void*));
    COND_RETURN_ERROR(memRet != EOK, RT_ERROR_SEC_HANDLE, "memmove_s srcs failed, retCode=%#x.", memRet);
    memRet = memmove_s(batchInfo.dsts, realCnt * sizeof(void*), batchInfo.dsts + offset, realCnt * sizeof(void*));
    COND_RETURN_ERROR(memRet != EOK, RT_ERROR_SEC_HANDLE, "memmove_s dsts failed, retCode=%#x.", memRet);
    memRet =
        memmove_s(batchInfo.sizes, realCnt * sizeof(uint64_t), batchInfo.sizes + offset, realCnt * sizeof(uint64_t));
    COND_RETURN_ERROR(memRet != EOK, RT_ERROR_SEC_HANDLE, "memmove_s sizes failed, retCode=%#x.", memRet);

    if (handleFixedSize && batchInfo.fixedSize != 0) {
        if (batchInfo.sizes[0] < batchInfo.fixedSize) {
            RT_LOG(
                RT_LOG_ERROR, "Invalid fixedSize=%lu exceeds element size=%lu.", batchInfo.fixedSize,
                batchInfo.sizes[0]);
            return RT_ERROR_INVALID_VALUE;
        }
        batchInfo.srcs[0] = RtValueToPtr<void*>(RtPtrToValue(batchInfo.srcs[0]) + batchInfo.fixedSize);
        batchInfo.dsts[0] = RtValueToPtr<void*>(RtPtrToValue(batchInfo.dsts[0]) + batchInfo.fixedSize);
        batchInfo.sizes[0] -= batchInfo.fixedSize;
    }
    return RT_ERROR_NONE;
}

static rtError_t ConvertUBDmaBatchForModel(TaskInfo* const taskInfo, AsyncDmaBatchInfo& batchInfo)
{
    Stream* const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    rtError_t error = RT_ERROR_NONE;
    const JettyType jettyType = StreamJettyHandler::GetJettyTypeFromTask(taskInfo);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_BATCH);

    error = ShiftBatchArrays(batchInfo, true);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    input.batch.len = batchInfo.sizes;
    input.batch.count = batchInfo.count > MAX_BATCH_DMA_CNT ? MAX_BATCH_DMA_CNT : batchInfo.count;
    input.batch.src = RtPtrToPtr<uint64_t*>(batchInfo.srcs);
    input.batch.dst = RtPtrToPtr<uint64_t*>(batchInfo.dsts);

    error = StreamJettyHandler::HandleUbDmaTask(taskInfo, jettyType, &input, &output);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "HandleUbDmaTask failed, device_id=%u, stream_id=%d, jetty_type=%s(%u), retCode=%#x.", devId,
            stream->Id_(), JettyTypeName(jettyType), static_cast<uint32_t>(jettyType), error);
        return error;
    }
    memcpyAsyncTaskInfo->ubDma.fixedSize = output.fixedSize;
    memcpyAsyncTaskInfo->ubDma.fixedCnt = output.fixedCnt;
    memcpyAsyncTaskInfo->size = output.fixedCnt;
    return RT_ERROR_NONE;
}

rtError_t ConvertAsyncDmaBatch(TaskInfo* const taskInfo, AsyncDmaBatchInfo& batchInfo)
{
    const bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG(RT_LOG_ERROR, "pcie does not support");
        return RT_ERROR_INVALID_VALUE;
    }

    Stream* const stream = taskInfo->stream;
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if (stream->GetBindFlag() || stream->IsSoftwareSqEnable()) {
        return ConvertUBDmaBatchForModel(taskInfo, batchInfo);
    }

    rtError_t shiftErr = ShiftBatchArrays(batchInfo);
    COND_RETURN_ERROR(
        shiftErr != RT_ERROR_NONE, shiftErr, "ShiftBatchArrays failed, retCode=%#x.", static_cast<uint32_t>(shiftErr));

    Driver* const driver = stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    AsyncDmaWqeInputInfoBatch input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfoBatch), 0, sizeof(AsyncDmaWqeInputInfoBatch));

    input.tsId = stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();

    input.srcs = batchInfo.srcs;
    input.dsts = batchInfo.dsts;
    input.lens = batchInfo.sizes;
    input.count = batchInfo.count > MAX_BATCH_DMA_CNT ? MAX_BATCH_DMA_CNT : batchInfo.count;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqeBatch(devId, input, &output);
    ERROR_RETURN(error, "drv create asyncDmaWqeBatch failed, retCode=%#x.", static_cast<uint32_t>(error));

    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.pi = output.pi;
    memcpyAsyncTaskInfo->ubDma.fixedCnt = output.fixedCnt;
    memcpyAsyncTaskInfo->size = output.fixedCnt;
    return RT_ERROR_NONE;
}

static void ReleaseMemcpyBatchTaskParams(MemcpyBatchTaskParamsInfo* const params)
{
    if (params == nullptr) {
        return;
    }
    DELETE_A(params->dsts);
    DELETE_A(params->destMaxs);
    DELETE_A(params->srcs);
    DELETE_A(params->sizes);
    DELETE_A(params->attrs);
    DELETE_A(params->attrsIndexes);
    delete params;
}

static rtError_t AllocMemcpyBatchTaskParamArrays(MemcpyBatchTaskParamsInfo* const params)
{
    const size_t count = params->numBatches;
    const size_t numAttrs = params->numAttrs;
    using MemcpyDataPtr = void*;
    // 四个数组按相同下标共同描述一条子拷贝，长度均为当前 task 的 count。
    params->dsts = new (std::nothrow) MemcpyDataPtr[count];
    params->destMaxs = new (std::nothrow) size_t[count];
    params->srcs = new (std::nothrow) MemcpyDataPtr[count];
    params->sizes = new (std::nothrow) size_t[count];
    if ((params->dsts == nullptr) || (params->destMaxs == nullptr) || (params->srcs == nullptr) ||
        (params->sizes == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate memcpy batch task parameter arrays, count=%zu.", count);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    if (numAttrs != 0U) {
        // 每组属性与一个生效起点对应，两个数组的长度均为 numAttrs。
        params->attrs = new (std::nothrow) rtMemcpyBatchAttr[numAttrs];
        params->attrsIndexes = new (std::nothrow) size_t[numAttrs];
        if ((params->attrs == nullptr) || (params->attrsIndexes == nullptr)) {
            RT_LOG(RT_LOG_ERROR, "Failed to allocate memcpy batch task attribute arrays, numAttrs=%zu.", numAttrs);
            return RT_ERROR_MEMORY_ALLOCATION;
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t CopyMemcpyBatchTaskParams(
    const AsyncDmaBatchInfo& batchInfo, const MemcpyBatchTaskParamsInput* const input, const size_t firstIndex,
    const size_t firstAttr, const uint64_t completed, const uint64_t partialSize,
    MemcpyBatchTaskParamsInfo* const params)
{
    const size_t count = params->numBatches;
    const size_t numAttrs = params->numAttrs;
    // 工作数组已经指向本轮起点，直接保存前 count 个目的地址；只复制地址值，不复制业务数据。
    errno_t ret = memcpy_s(params->dsts, count * sizeof(void*), batchInfo.dsts, count * sizeof(void*));
    if (ret != EOK) {
        return RT_ERROR_SEC_HANDLE;
    }
    // 源地址也从本轮工作数组读取，保证与目的地址逐项对应，并保留前序转换产生的地址偏移。
    ret = memcpy_s(params->srcs, count * sizeof(void*), batchInfo.srcs, count * sizeof(void*));
    if (ret != EOK) {
        return RT_ERROR_SEC_HANDLE;
    }
    // 例：某条子拷贝原目的地址为 D，容量 512 字节、长度 300 字节，前序 task 承担其中 80 字节。
    // 本轮目的地址为 D+80，offset=80，返回的 destMaxs=512-80=432。
    // 本 task 若承担剩余全部字节，sizes=220；若只承担其中 100 字节，则 sizes=partialSize=100。
    for (size_t i = 0U; i < count; ++i) {
        // 如果一个子拷贝被分成两个task中去做的话，需要计算偏移,在本次拷贝中行把上一次任务已拷贝的去掉
        const uint64_t offset = RtPtrToValue(batchInfo.dsts[i]) - RtPtrToValue(input->dsts[firstIndex + i]);
        // 偏移不能超过原始容量，避免后续无符号减法得到错误的剩余容量。
        COND_RETURN_ERROR(
            offset > input->destMaxs[firstIndex + i], RT_ERROR_INVALID_VALUE,
            "Memcpy batch task destination offset exceeds its capacity.");
        // destMaxs 是从当前目的地址开始的可用容量，地址推进多少，原始容量就要扣减多少
        params->destMaxs[i] = input->destMaxs[firstIndex + i] - static_cast<size_t>(offset);
        // 如果改子拷贝是分成多个任务去拷贝，那就按照实际拷贝大小，记录实际拷贝的大小
        params->sizes[i] = ((partialSize != 0U) && (i == completed)) ? static_cast<size_t>(partialSize) :
                                                                       static_cast<size_t>(batchInfo.sizes[i]);
    }
    if (numAttrs != 0U) {
        ret = memcpy_s(
            params->attrs, numAttrs * sizeof(rtMemcpyBatchAttr), input->attrs + firstAttr,
            numAttrs * sizeof(rtMemcpyBatchAttr));
        if (ret != EOK) {
            return RT_ERROR_SEC_HANDLE;
        }
        // 把原始参数属性下标更新本为本次task中实际的下标
        // 第一组属性在当前 task 起点已经生效，其原始起点可能更早，统一将返回的生效起点设为 0。
        params->attrsIndexes[0] = 0U;
        // 后续属性的原始起点均在本 task 范围内，减去 firstIndex 即可换算为 task 内的下标。
        // 例如 task 从原始下标 4 开始，后续属性从原始下标 6 生效，则返回下标 6 - 4 = 2。
        for (size_t i = 1U; i < numAttrs; ++i) {
            params->attrsIndexes[i] = input->attrsIndexes[firstAttr + i] - firstIndex;
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t SaveMemcpyBatchTaskParams(
    MemcpyAsyncTaskInfo* const taskInfo, const AsyncDmaBatchInfo& batchInfo,
    const MemcpyBatchTaskParamsInput* const input)
{
    // input用户传入的原始参数；batchInfo 是本轮的工作数组，已按前序任务的转换结果推进地址和长度
    // taskInfo 提供当前 task 的转换范围，用于保存当前 task 的查询参数
    if (input == nullptr) {
        return RT_ERROR_NONE;
    }
    // 已转换时取驱动返回的完整子拷贝条数
    const uint64_t completed = taskInfo->dmaKernelConvertFlag ? taskInfo->ubDma.fixedCnt : batchInfo.count;
    // 驱动可能还转换了下一条子拷贝的一部分
    const uint64_t partialSize = taskInfo->dmaKernelConvertFlag ? taskInfo->ubDma.fixedSize : 0U;
    COND_RETURN_ERROR(
        (batchInfo.count > input->numBatches) || (completed > batchInfo.count) ||
            ((partialSize != 0U) && ((completed == batchInfo.count) || (partialSize > batchInfo.sizes[completed]))),
        RT_ERROR_INVALID_VALUE, "Invalid memcpy batch task range.");
    // 部分转换的子拷贝也要在查询数组中占一项，因此在完整条数之外额外计一条。
    const size_t count = static_cast<size_t>(completed + ((partialSize != 0U) ? 1U : 0U));
    if (count == 0U) {
        return RT_ERROR_NONE;
    }
    // batchInfo.count 表示进入本轮时剩余的子拷贝条数，总条数减去剩余条数即本轮首条子拷贝的原始下标
    const size_t firstIndex = input->numBatches - static_cast<size_t>(batchInfo.count);
    // firstAttr 是原始属性数组的下标
    size_t firstAttr = 0U;
    // 无属性时保留 0，后续无需申请和复制属性数组。
    size_t numAttrs = 0U;
    // 根据task承担哪些子拷贝，确定本次拷贝task中使用哪些属性，属性数量与子拷贝条数不同，一组属性可以供多条子拷贝共用
    if (input->numAttrs != 0U) {
        // 例：10 条子拷贝，attrs={A,B,C}，attrsIndexes={0,3,6}。
        // 下标 0~2 使用 A，3~5 使用 B，6~9 使用 C；task 包含 4~7 时，只需保留 B、C。
        // 下一组属性若已在本轮起点前或起点处生效，就继续向后查找，定位本轮首条拷贝使用的属性
        while ((firstAttr + 1U < input->numAttrs) && (input->attrsIndexes[firstAttr + 1U] <= firstIndex)) {
            ++firstAttr;
        }
        size_t endAttr = firstAttr + 1U;
        while ((endAttr < input->numAttrs) && (input->attrsIndexes[endAttr] < firstIndex + count)) {
            ++endAttr;
        }
        numAttrs = endAttr - firstAttr;
    }
    // 原始数组和工作数组不会由当前 task 持有，需要单独申请查询副本；{} 将成员指针初始化为空。
    MemcpyBatchTaskParamsInfo* const params = new (std::nothrow) MemcpyBatchTaskParamsInfo{};
    COND_RETURN_AND_MSG_OUTER(
        params == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(MemcpyBatchTaskParamsInfo), "new");
    ScopeGuard paramsGuard([params]() { ReleaseMemcpyBatchTaskParams(params); });
    params->numBatches = count;
    params->numAttrs = numAttrs;
    rtError_t error = AllocMemcpyBatchTaskParamArrays(params);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = CopyMemcpyBatchTaskParams(batchInfo, input, firstIndex, firstAttr, completed, partialSize, params);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    // 全部保存成功后交给 task 持有，Get 返回这些数组，任务回收时统一释放。
    taskInfo->batchParams = params;
    paramsGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncBatchTaskInit(
    TaskInfo* const taskInfo, AsyncDmaBatchInfo& batchInfo, const MemcpyBatchTaskParamsInput* const params)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V3 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
        // fixedSize清零，避免保存参数时误判存在部分子拷贝
        memcpyAsyncTaskInfo->ubDma.fixedSize = 0U;
        error = ConvertAsyncDmaBatch(taskInfo, batchInfo);
        ERROR_RETURN_MSG_INNER(error, "ConvertAsyncDmaBatch failed, retCode=%#x.", error);
        memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
    } else {
        // 除DavidUbDma之外的其他情况不处理
    }

    error = SaveMemcpyBatchTaskParams(memcpyAsyncTaskInfo, batchInfo, params);
    ERROR_RETURN_MSG_INNER(error, "Save memcpy batch task params failed, retCode=%#x.", error);
    return RT_ERROR_NONE;
}

static void AsyncDmaWqe2DProc(MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo, const Stream* const stream)
{
    const bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if (!ubFlag) {
        return;
    }

    AsyncDmaWqeDestroyInfo2D destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfo2D), 0, sizeof(AsyncDmaWqeDestroyInfo2D));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    destroyParm.ci = memcpyAsyncTaskInfo->ubDma.pi;
    destroyParm.wqe = memcpyAsyncTaskInfo->ubDma.wqePtr;

    const rtError_t error = stream->Device_()->Driver_()->DestroyAsyncDmaWqe2D(stream->Device_()->Id_(), &destroyParm);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqe2d failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "ub wqe async 2d release success, ci=%u, sq_id=%u.", destroyParm.ci, destroyParm.sqId);
}

static void AsyncDmaWqeBatchProc(MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo, const Stream* const stream)
{
    bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if (!ubFlag) {
        return;
    }

    AsyncDmaWqeDestroyInfoBatch destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfoBatch), 0, sizeof(AsyncDmaWqeDestroyInfoBatch));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    destroyParm.ci = memcpyAsyncTaskInfo->ubDma.pi;

    const rtError_t error =
        stream->Device_()->Driver_()->DestroyAsyncDmaWqeBatch(stream->Device_()->Id_(), &destroyParm);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqeBatch failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "ub wqe async batch release success, ci=%u, sq_id=%u.", destroyParm.ci, destroyParm.sqId);
}

static void AsyncDmaWqeBasicProc(MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo, const Stream* const stream)
{
    const bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if ((!ubFlag) && (!memcpyAsyncTaskInfo->isSqeUpdateH2D)) {
        return;
    }

    bool isUbMode = false;
    AsyncDmaWqeDestroyInfo destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfo), 0, sizeof(AsyncDmaWqeDestroyInfo));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    if (ubFlag) {
        destroyParm.wqe = memcpyAsyncTaskInfo->ubDma.wqePtr;
        destroyParm.size = memcpyAsyncTaskInfo->ubDma.wqeLen;
        isUbMode = true;
    } else {
        if (memcpyAsyncTaskInfo->isSqeUpdateH2D) {
            destroyParm.dmaAddr = &(memcpyAsyncTaskInfo->dmaAddr);
        } else {
            RT_LOG(RT_LOG_ERROR, "pcie does not support");
            return;
        }
    }
    rtError_t error =
        stream->Device_()->Driver_()->DestroyAsyncDmaWqe(stream->Device_()->Id_(), &destroyParm, isUbMode);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqe failed, retCode=%#x.", error);
    RT_LOG(
        RT_LOG_INFO, "ub wqe or pcie dma release success, is_ub_mode=%d, is_update=%d, sq_id=%u.", isUbMode,
        memcpyAsyncTaskInfo->isSqeUpdateH2D, destroyParm.sqId);
}

static void AsyncDmaWqeProc(MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo, const Stream* const stream)
{
    if ((stream->Flags() & RT_STREAM_PERSISTENT) != 0U || stream->IsSoftwareSqEnable()) {
        return;
    }
    if (memcpyAsyncTaskInfo->copyMethod == static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D)) {
        AsyncDmaWqe2DProc(memcpyAsyncTaskInfo, stream);
    } else if (memcpyAsyncTaskInfo->copyMethod == static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH)) {
        AsyncDmaWqeBatchProc(memcpyAsyncTaskInfo, stream);
    } else {
        AsyncDmaWqeBasicProc(memcpyAsyncTaskInfo, stream);
    }
}

void StarsV2MemcpyAsyncTaskUnInit(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    (void)RecycleTaskResourceForMemcpyAsyncTask(taskInfo);
    // release guard mem.
    if (memcpyAsyncTaskInfo->guardMemVec != nullptr) {
        memcpyAsyncTaskInfo->guardMemVec->clear();
        delete memcpyAsyncTaskInfo->guardMemVec;
        memcpyAsyncTaskInfo->guardMemVec = nullptr;
    }
    ReleaseMemcpyBatchTaskParams(memcpyAsyncTaskInfo->batchParams);
    memcpyAsyncTaskInfo->batchParams = nullptr;

    COND_RETURN_VOID(driver == nullptr, "driver_ pointer NULL.");
    if (memcpyAsyncTaskInfo->dmaKernelConvertFlag) {
        rtError_t error = RT_ERROR_NONE;
        // only for david, other chips free pcie-dma desc in ts_agent
        if (IsPcieDma(memcpyAsyncTaskInfo->copyType) && !(Runtime::Instance()->GetConnectUbFlag()) &&
            !(memcpyAsyncTaskInfo->isSqeUpdateH2D)) {
            error = driver->MemDestroyAddr(&(memcpyAsyncTaskInfo->dmaAddr));
            COND_RETURN_VOID(
                error != RT_ERROR_NONE, "free dma addr failed after convert memory address, retCode=%#x.", error);
            RT_LOG(RT_LOG_INFO, "pcie dma release success.");
        }

        if ((memcpyAsyncTaskInfo->isSqeUpdateH2D) && (memcpyAsyncTaskInfo->src != nullptr)) {
            (void)driver->HostMemFree(memcpyAsyncTaskInfo->src);
            memcpyAsyncTaskInfo->src = nullptr;
        }

        DavidStream* davidStm = static_cast<DavidStream*>(stream);
        if (memcpyAsyncTaskInfo->releaseArgHandle != nullptr) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(memcpyAsyncTaskInfo->releaseArgHandle);
            }
            memcpyAsyncTaskInfo->releaseArgHandle = nullptr;
        }

        AsyncDmaWqeProc(memcpyAsyncTaskInfo, stream);
    }

    ReleaseCpyTmpMemForDavid(taskInfo);
    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
}

void PrintAsyncPtrProc(Driver* const driver, char_t* const errStr, void* memcpyAddrInfo, int32_t& countNum)
{
    rtDavidMemcpyAddrInfo hostAddrInfo;
    const rtError_t ret = driver->MemCopySync(
        &hostAddrInfo, sizeof(rtDavidMemcpyAddrInfo), memcpyAddrInfo, sizeof(rtDavidMemcpyAddrInfo),
        RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync failed, retCode=%#x.", ret);
    } else {
        countNum += snprintf_truncated_s(
            errStr + countNum, static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum),
            ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64, hostAddrInfo.src, hostAddrInfo.dst);
        PrintModuleIdProc(
            driver, errStr, RtValueToPtr<void*>(hostAddrInfo.src), RtValueToPtr<void*>(hostAddrInfo.dst), countNum);
    }
}

uint32_t GetSendSqeNumForAsyncDmaTask(const TaskInfo* const taskInfo)
{
    const MemcpyAsyncTaskInfo* const memcpyAsyncTask = &(taskInfo->u.memcpyAsyncTaskInfo);
    /* Ascned950装备场景下的配置是pcie互联 */
    if (IsDavidUbDma(memcpyAsyncTask->copyType)) {
        // ub图下沉场景使用ub db
        if ((taskInfo->stream->Flags() & RT_STREAM_PERSISTENT) != 0U) {
            return 1U;
        }

        // UB 2D异步拷贝和批量异步拷贝需要1个sqe ub db
        const uint32_t copyMethod = memcpyAsyncTask->copyMethod;
        if (copyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH) ||
            copyMethod == static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D)) {
            return 1U;
        }
        return 2U;
    }
    return 1U;
}
#endif

#if F_DESC("MemsetAsyncTask")
void ConstructDavidSqeForMemsetAsyncTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    MemsetAsyncTaskInfo* memsetTask = &(taskInfo->u.memsetAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpySqe* const memcpySqe = &(davidSqe->memcpyAsyncSqe);
    memcpySqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    memcpySqe->header.preP = 0U;
    memcpySqe->header.postP = 0U;
    memcpySqe->kernelCredit = GetSdmaKernelCredit();
    memcpySqe->opcode = RT_STARS_MEMCPY_ASYNC_OP_KIND_MEMSET;
    memcpySqe->srcStreamId = 0x1FU;
    memcpySqe->u.strideMode0.dstStreamId = 0x1FU;
    memcpySqe->srcSubStreamId = 1U;
    memcpySqe->u.strideMode0.dstSubStreamId = 1U;
    const uint64_t destAddr = RtPtrToValue(memsetTask->targetPtr);
    // lengthMove 为 32bit，硬件语义 0 表示 4GB：整 4G 块的 fillCount(0x1_0000_0000) 截断为 0 即预期编码
    memcpySqe->u.strideMode0.lengthMove = static_cast<uint32_t>(memsetTask->fillCount);
    memcpySqe->u.strideMode0.srcAddrLow = static_cast<uint32_t>(destAddr & 0x00000000FFFFFFFFU);
    memcpySqe->u.strideMode0.srcAddrHigh = static_cast<uint32_t>((destAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    memcpySqe->u.strideMode0.dstAddrLow = memsetTask->fillValue;
    memcpySqe->u.strideMode0.dstAddrHigh = 0U;
    memcpySqe->vaValid = 0U;
    memcpySqe->ie2 = 0U;
    memcpySqe->sssv = 1U;
    memcpySqe->dssv = 1U;
    memcpySqe->sns = 1U;
    memcpySqe->dns = 1U;

    PrintDavidSqe(davidSqe, "SdmaMemsetTask");
    RT_LOG(
        RT_LOG_INFO, "SdmaMemsetTask, stream_id=%d, task_id=%hu, destAddr=%#" PRIx64 ", value=0x%x, size=%" PRIu64 ",",
        stream->Id_(), taskInfo->id, destAddr, memsetTask->fillValue, memsetTask->fillCount);
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

void MemsetAsyncTaskInit(
    TaskInfo* const taskInfo, void* const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
    const uint32_t elementSize)
{
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MEMSET;
    taskInfo->typeName = const_cast<char_t*>("MEMSET_ASYNC");

    MemsetAsyncTaskInfo* memsetAsyncTaskInfo = &(taskInfo->u.memsetAsyncTaskInfo);
    memsetAsyncTaskInfo->targetPtr = ptr;
    memsetAsyncTaskInfo->targetSize = destMax;
    memsetAsyncTaskInfo->fillValue = (elementSize == 1U) ? ExpandByteToU32(val) : val;
    memsetAsyncTaskInfo->originalValue = static_cast<int32_t>(val);
    memsetAsyncTaskInfo->fillCount = cnt;
    memsetAsyncTaskInfo->elementSize = elementSize;
}
#endif

#if F_DESC("MemWaitValueTask")
void ConstructDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    constexpr uint8_t MEM_WAIT_SQE_INDEX_1 = 1U;
    constexpr uint8_t MEM_WAIT_SQE_INDEX_2 = 2U;

    RtStarsMemWaitValueInstrFcParaWithDynamicProf fcPara = {};
    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream* const stream = taskInfo->stream;
    auto props = stream->Device_()->GetDevProperties();

    uint32_t taskPosTail =
        (stream->taskResMang_ == nullptr) ? (static_cast<Stream*>(stream))->GetCurSqPos() : taskInfo->id;
    // external wait task的SQE构造在capture end阶段，其pos不能使用GetCurSqPos()，需要使用capture时已经占位的pos
    taskPosTail =
        (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) ? stream->GetHwPosByPos(taskInfo->pos) : taskPosTail;
    fcPara.devAddr = memWaitValueTask->devAddr;
    fcPara.value = memWaitValueTask->value;
    fcPara.flag = memWaitValueTask->flag;
    fcPara.maxLoop = 15ULL; /* the max loop num */
    fcPara.sqId = stream->GetSqId();
    fcPara.sqHeadPre = (taskPosTail + 1) % stream->GetSqDepth();
    fcPara.awSize = memWaitValueTask->awSize;
    fcPara.sqIdMemAddr = stream->GetSqIdMemAddrByPos(taskInfo->pos);
    fcPara.profSwitchAddr = stream->Device_()->GetProfSwitchAddr();
    fcPara.profSwitchValue = 0x1ULL;
    fcPara.profDisableAddr = memWaitValueTask->profDisableStatusAddr;
    fcPara.swapBufferBaseAddr = props.swapBufferBaseAddr;
    fcPara.swapBufferUpdateAddr = stream->Device_()->GetStarsRegBaseAddr() + props.swapBufferUpdateRegOffset;
    fcPara.sqSwapShift = props.sqSwapShift;
    fcPara.swapBufferProfCfgOffset = props.swapBufferProfCfgOffset;

    if (stream->IsSoftwareSqEnable()) {
        fcPara.swapBufferUpdateValue = 0U;
        fcPara.swapBufferProfCfgAddr = 0U;
    } else {
        fcPara.swapBufferUpdateValue = 0x80000000U + fcPara.sqId; // bit[31]=1, bit[0-11]=sqId
        fcPara.swapBufferProfCfgAddr =
            fcPara.swapBufferBaseAddr + (fcPara.sqId << fcPara.sqSwapShift) + fcPara.swapBufferProfCfgOffset;
    }

    RT_LOG(
        RT_LOG_INFO,
        "swapBufferBaseAddr=0x%llx, swapBufferUpdateAddr=0x%llx, sqSwapShift=%u, sqId=%u, "
        "swapBufferProfCfgOffset=%u, swapBufferUpdateValue=0x%llx.",
        fcPara.swapBufferBaseAddr, fcPara.swapBufferUpdateAddr, fcPara.sqSwapShift, fcPara.sqId,
        fcPara.swapBufferProfCfgOffset, fcPara.swapBufferUpdateValue);

    // two sqes probably trigger a software constraint when the stream is full, add a nop sqe to evade
    ConstructNopSqeForMemWaitValueTask(taskInfo, davidSqe);

    rtDavidSqe_t* writeSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_1];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_1;
        writeSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructFirstDavidSqeForMemWaitValueTask(taskInfo, writeSqeAddr);

    rtDavidSqe_t* condSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_2];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_2;
        condSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructSecondDavidSqeForMemWaitValueTask(taskInfo, condSqeAddr, fcPara);
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

void ConstructNopSqeForMemWaitValueTask(const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtDavidPlaceHolderSqe* const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_NOP;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(davidSqe, "MemWaitValueTask nop sqe");
}

void ConstructFirstDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    Stream* const stream = taskInfo->stream;
    RtDavidStarsWriteValueSqe* sqe = &(davidSqe->writeValueSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->va = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = taskInfo->u.memWaitValueTask.awSize;

    constexpr uint64_t value = 0ULL;
    const uint64_t devAddr = RtPtrToValue(taskInfo->u.memWaitValueTask.writeValueAddr);
    if (devAddr == 0ULL) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }
    sqe->writeValuePart[0] = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->writeValuePart[1] = static_cast<uint32_t>(value >> UINT32_BIT_NUM);
    sqe->writeAddrLow = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(davidSqe, "MemWaitValueTask value write sqe");
    RT_LOG(
        RT_LOG_INFO,
        "MemWaitValueTask value write sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, taskSn=%u",
        stream->Id_(), taskInfo->id, devAddr, value, taskInfo->taskSn);
}

void ConstructSecondDavidSqeForMemWaitValueTask(
    TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, const RtStarsMemWaitValueInstrFcParaWithDynamicProf& fcPara)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtDavidStarsFunctionCallSqe& sqe = davidSqe->fuctionCallSqe;

    rtError_t ret;
    uint64_t funcCallSize;
    if (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) {
        RtStarsExternalWaitFuncCall fcExternal = {};
        RtStarsExternalWaitFuncCallPara externalPara = {};
        externalPara.waitRefreshAddr = fcPara.devAddr;
        externalPara.maxLoop = fcPara.maxLoop;
        externalPara.sqIdMemAddr = fcPara.sqIdMemAddr;
        externalPara.sqHeadPre = fcPara.sqHeadPre;
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsExternalWaitFuncCall));
        ConstructExternalWaitFuncCall(fcExternal, externalPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            memWaitValueTask->funcCallSvmMem2, memWaitValueTask->funCallMemSize2, &fcExternal, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    } else if (taskInfo->stream->IsSoftwareSqEnable()) {
        RtStarsMemWaitValueLastInstrFcExWithDynamicProf fcEx = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcExWithDynamicProf));
        ConstructMemWaitValueInstr2ExWithDynamicProf(fcEx, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            memWaitValueTask->funcCallSvmMem2, memWaitValueTask->funCallMemSize2, &fcEx, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        RtStarsMemWaitValueLastInstrFcWithDynamicProf fc = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcWithDynamicProf));
        ConstructMemWaitValueInstr2WithDynamicProf(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            memWaitValueTask->funcCallSvmMem2, memWaitValueTask->funCallMemSize2, &fc, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    }
    if (ret != RT_ERROR_NONE) {
        sqe.header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.csc = 1U;
    sqe.condsSubType = CONDS_SUB_TYPE_MEM_WAIT_VALUE;

    const uint64_t funcAddr = RtPtrToValue(memWaitValueTask->funcCallSvmMem2);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "MemWaitValueTask condition sqe");
    RT_LOG(
        RT_LOG_INFO,
        "MemWaitValueTask condition sqe, device_id=%u, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, awSize=%u, sqHeadPre=%u, flag=%u, taskSn=%u",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, fcPara.devAddr, fcPara.value,
        static_cast<uint32_t>(fcPara.awSize), fcPara.sqHeadPre, fcPara.flag, taskInfo->taskSn);
}
#endif

#if F_DESC("MemWriteValueTask")
void ConstructDavidSqeForMemWriteValueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    MemWriteValueTaskInfo* const writeValTsk = &(taskInfo->u.memWriteValueTask);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtDavidStarsWriteValueSqe* const writeValueSqe = &(davidSqe->writeValueSqe);
    writeValueSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    writeValueSqe->va = 1U;
    writeValueSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    writeValueSqe->awsize = writeValTsk->awSize;
    writeValueSqe->snoop = 0U;
    writeValueSqe->awcache = 2U;
    writeValueSqe->awprot = 0U;

    const uint64_t value = taskInfo->u.memWriteValueTask.value;
    const uint64_t devAddr = taskInfo->u.memWriteValueTask.devAddr;
    if (devAddr == 0ULL) {
        writeValueSqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        UpdateDavidSqeHeadUpdate(taskInfo, sqe);
        return;
    }

    writeValueSqe->writeAddrLow = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    writeValueSqe->writeAddrHigh = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);
    writeValueSqe->writeValuePart[0] = static_cast<uint32_t>(value & MASK_32_BIT);
    writeValueSqe->writeValuePart[1] = static_cast<uint32_t>((value >> UINT32_BIT_NUM) & MASK_32_BIT);

    PrintDavidSqe(davidSqe, "MemWriteValueTask");
    RT_LOG(
        RT_LOG_INFO, "MemWriteValueTask stream_id=%d, awsize=%d ,task_id=%hu, devAddr=%#" PRIx64 ", value:%#" PRIx64,
        taskInfo->stream->Id_(), writeValueSqe->awsize, taskInfo->id, devAddr, value);
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}
#endif

static rtError_t HandleUbModeDmaResult(TaskInfo* const taskInfo, const AsyncDmaWqeOutputInfo& output)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.wqeLen = output.wqeLen;
    memcpyAsyncTaskInfo->ubDma.wqePtr = output.wqe;
    memcpyAsyncTaskInfo->ubDma.pi = 1U;
    if (output.wqeLen != 0) {
        const errno_t ret = memcpy_s(
            memcpyAsyncTaskInfo->ubDma.wqe.data(), sizeof(rtDavidSqe_t), output.wqe,
            static_cast<size_t>(output.wqeLen));
        if (ret != EOK) {
            RT_LOG(
                RT_LOG_ERROR,
                "Failed to call memcpy_s to copy output.wqe, src=%p, dest=%p, dest_max=%zu, count=%zu,"
                " retCode=%#x.",
                output.wqe, memcpyAsyncTaskInfo->ubDma.wqe.data(), sizeof(rtDavidSqe_t),
                static_cast<size_t>(output.wqeLen), ret);
            return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t ConvertUBDmaForModel(TaskInfo* const taskInfo, const TaskInfo* const updateTask, bool isSqeUpdate)
{
    Stream* const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    // for task update, external event场景, 只会在单算子流上下memcpy
    if (isSqeUpdate) {
        COND_RETURN_ERROR(
            updateTask == nullptr, RT_ERROR_INVALID_VALUE, "updateTask is null when isSqeUpdate is true.");
    }
    if (isSqeUpdate && ((stream->Flags() & RT_STREAM_PERSISTENT) == 0)) {
        AsyncDmaWqeInputInfo input = {};
        input.tsId = stream->Device_()->DevGetTsId();
        input.sqId = stream->GetSqId();
        input.src = memcpyAsyncTaskInfo->src;
        input.size = memcpyAsyncTaskInfo->size;
        input.cpyType = memcpyAsyncTaskInfo->copyType;
        input.destPtr = updateTask->stream->GetDeviceSqeAddrByPos(updateTask->pos);
        COND_RETURN_ERROR(
            input.destPtr == nullptr, RT_ERROR_INVALID_VALUE,
            "Get device sqe addr failed, device_id=%u, stream_id=%d, task_pos=%u.",
            updateTask->stream->Device_()->Id_(), updateTask->stream->Id_(), updateTask->pos);
        AsyncDmaWqeOutputInfo output = {};
        Driver* const driver = stream->Device_()->Driver_();
        const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, true, false);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.",
            static_cast<uint32_t>(error));
        return HandleUbModeDmaResult(taskInfo, output);
    }

    const JettyType jettyType = StreamJettyHandler::GetJettyTypeFromTask(taskInfo);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_NORMAL);
    input.normal.dst = RtPtrToPtr<uint8_t*>(memcpyAsyncTaskInfo->destPtr);
    input.normal.src = RtPtrToPtr<uint8_t*>(memcpyAsyncTaskInfo->src);
    rtError_t error = RT_ERROR_NONE;
    if (isSqeUpdate) {
        void* sqeDeviceAddr = updateTask->stream->GetDeviceSqeAddrByPos(updateTask->pos);
        COND_RETURN_ERROR(
            sqeDeviceAddr == nullptr, RT_ERROR_INVALID_VALUE,
            "Get device sqe addr failed, device_id=%u, stream_id=%d, task_pos=%u.",
            updateTask->stream->Device_()->Id_(), updateTask->stream->Id_(), updateTask->pos);
        input.normal.dst = RtPtrToPtr<uint8_t*>(sqeDeviceAddr);
    }
    input.normal.len = memcpyAsyncTaskInfo->size;
    error = StreamJettyHandler::HandleUbDmaTask(taskInfo, jettyType, &input, &output);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "HandleUbDmaTask failed, device_id=%u, stream_id=%d, retCode=%#x.", devId,
        stream->Id_(), error);
    return error;
}

static rtError_t ConvertAsyncDmaForSoftWareSqPcie(MemcpyAsyncTaskInfo* const cpyAsyncTask, TaskInfo* const updateTask)
{
    rtError_t error = RT_ERROR_NONE;
    Stream* updateStm = updateTask->stream;
    Driver* const curDrv = updateStm->Device_()->Driver_();
    cpyAsyncTask->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(updateStm->Device_()->Id_());
    void* sqeDeviceAddr = updateStm->GetDeviceSqeAddrByPos(updateTask->pos);
    COND_RETURN_ERROR(
        sqeDeviceAddr == nullptr, RT_ERROR_INVALID_VALUE,
        "Get device sqe addr failed, device_id=%u, stream_id=%d, task_pos=%u.", updateStm->Device_()->Id_(),
        updateStm->Id_(), updateTask->pos);
    error = curDrv->MemConvertAddr(
        RtPtrToValue(cpyAsyncTask->src), RtPtrToValue(sqeDeviceAddr), cpyAsyncTask->size, &(cpyAsyncTask->dmaAddr));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert memory address, device_id=%d, stream_id=%d, retCode=%#x.",
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
rtError_t ConvertAsyncDma(TaskInfo* const taskInfo)
{
    Stream* const stream = taskInfo->stream;
    Driver* const driver = stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "pcie is not supported.");
        return RT_ERROR_INVALID_VALUE;
    }
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    if (stream->GetBindFlag() || stream->IsSoftwareSqEnable()) {
        return ConvertUBDmaForModel(taskInfo, nullptr, false);
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
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.",
        static_cast<uint32_t>(error));

    return HandleUbModeDmaResult(taskInfo, output);
}

/*
    for task update
    非扩流场景下, PCIE通过驱动将目标更新的sqe addr转成dmaAddr，UB通过驱动获取DWQE
    扩流场景:1.pcie通过目的地址转换描述符 2.ub走jetty manager
    taskInfo: 下dma任务的stm,可能是模型里的stm,也可能是单算子流
    updateTaskInfo:  task update目标, 要被更新的task
*/
rtError_t ConvertAsyncDmaForTaskUpdate(TaskInfo* const taskInfo, TaskInfo* const updateTaskInfo)
{
    Stream* const stream = taskInfo->stream;
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    // task update目标流为扩流的流
    if (updateTaskInfo->stream->IsSoftwareSqEnable()) {
        Stream* updateStm = updateTaskInfo->stream;
        if (updateStm->GetDeviceSqeAddrByPos(updateTaskInfo->pos) == nullptr) {
            LogicSq* const logicSq = updateStm->GetLogicSqByPos(updateTaskInfo->pos);
            COND_RETURN_ERROR(
                logicSq == nullptr, RT_ERROR_INVALID_VALUE, "Get logic sq failed, device_id=%u, stream_id=%d, pos=%u.",
                updateStm->Device_()->Id_(), updateStm->Id_(), updateTaskInfo->pos);
            const rtError_t ret = logicSq->AllocDeviceSqeAddr(
                CAPTURE_TASK_RESERVED_NUM + updateStm->Device_()->GetDevProperties().expandStreamRsvTaskNum);
            COND_RETURN_ERROR(
                ret != RT_ERROR_NONE, ret,
                "Failed to allocate software SQ address, device_id=%u, stream_id=%d, retCode=%#x.",
                updateStm->Device_()->Id_(), updateStm->Id_(), static_cast<uint32_t>(ret));
        }
        if (isUbMode) {
            return ConvertUBDmaForModel(taskInfo, updateTaskInfo, true);
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
    Driver* const driver = stream->Device_()->Driver_();
    const rtError_t error = driver->CreateAsyncDmaWqe(devId, input, &output, isUbMode, true);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Failed to call drv interface to create asyncDmaWqe, retCode=%#x.",
        static_cast<uint32_t>(error));

    if (isUbMode) {
        return HandleUbModeDmaResult(taskInfo, output);
    }
    memcpyAsyncTaskInfo->dmaAddr = output.dmaAddr;
    return RT_ERROR_NONE;
}

#if F_DESC("IpcEventTask")
void StarsV2IpcEventWaitTaskUnInit(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream* const stream = taskInfo->stream;
    COND_RETURN_VOID(memWaitValueTask->event == nullptr, "event is nullptr");
    IpcEvent* event = dynamic_cast<IpcEvent*>(memWaitValueTask->event);
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
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%u", stream->Device_()->Id_(), stream->Id_(),
        taskInfo->id, curIndex);
}

void StarsV2IpcEventRecordTaskUnInit(TaskInfo* taskInfo)
{
    MemWriteValueTaskInfo* memWriteValueTask = &taskInfo->u.memWriteValueTask;
    Stream* const stream = taskInfo->stream;
    COND_RETURN_VOID(memWriteValueTask->event == nullptr, "event is nullptr");
    IpcEvent* event = dynamic_cast<IpcEvent*>(memWriteValueTask->event);
    COND_RETURN_VOID(event == nullptr, "dynamic_cast failed: event is not IpcEvent");
    IpcHandleVa* vaHandle = event->GetIpcHandleVa();
    COND_RETURN_VOID(event->GetIpcHandleVa() == nullptr, "ipcHandleVa is nullptr");
    uint16_t curIndex = memWriteValueTask->curIndex;
    event->IpcVaLock();
    if (vaHandle->currentIndex == curIndex) {
        event->SetIpcFinished();
    }
    event->IpcVaUnLock();

    IpcEventDestroy(&event, curIndex, false);
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%u", stream->Device_()->Id_(), stream->Id_(),
        taskInfo->id, curIndex);
}
#endif

} // namespace runtime
} // namespace cce
