/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "stars.hpp"
#include "stream.hpp"
#include "device.hpp"
#include "model.hpp"

namespace cce {
namespace runtime {

void ConstructCmoSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
    RtCmoKernelSqe *const sqe = &(command->cmoKernelSqe);
    sqe->header.ie = 0U;
    sqe->header.type = RT_STARS_SQE_TYPE_FFTS;
    sqe->header.post_p = 0U;
    sqe->header.pre_p = 0U;
    sqe->header.task_id = taskInfo->id;
    sqe->header.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->header.block_dim = 0U; // block_dim is not used by CMO
    sqe->header.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->fftsType = 0U;
    sqe->cmo = 1U; // enable cmo task
    sqe->wrrRatio = 1U;
    sqe->sqe_index = 0U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->schem = 0U;
    sqe->icachePrefetchCnt = 0U;

    sqe->cmo_type = cmoTsk->cmoSqeInfo.cmoType; // 0 is barrier, 1 is invalid, Prefetch is 2, Write_back is 3
    sqe->cmoId = cmoTsk->cmoid;

    sqe->opcode = cmoTsk->cmoSqeInfo.opCode; // memcpy opcode
    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->qos  = cmoTsk->cmoSqeInfo.qos;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->part_id = cmoTsk->cmoSqeInfo.partId;
    sqe->mpam = 0U;
    sqe->pmg = cmoTsk->cmoSqeInfo.pmg;
    sqe->format = 1U;
    sqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sqe->srcSubStreamId = static_cast<uint16_t>(taskInfo->stream->Device_()->GetSSID_());
    sqe->numOuter = cmoTsk->cmoSqeInfo.numOuter;
    sqe->numInner = cmoTsk->cmoSqeInfo.numInner;
    sqe->length = cmoTsk->cmoSqeInfo.lengthInner;
    sqe->src_addr_low  = static_cast<uint32_t>(cmoTsk->cmoSqeInfo.sourceAddr & 0x00000000FFFFFFFFU);
    sqe->src_addr_high = static_cast<uint32_t>((cmoTsk->cmoSqeInfo.sourceAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->stride_outer = cmoTsk->cmoSqeInfo.striderOuter;
    sqe->stride_inner = cmoTsk->cmoSqeInfo.striderInner;
    sqe->res1 = 0U;
    sqe->res2 = 0U;
    sqe->res3 = 0U;
    sqe->res4 = 0U;
    sqe->res5 = 0U;
    sqe->res6 = 0U;
    sqe->res7 = 0U;
    PrintSqe(command, "CmoTask");
    RT_LOG(RT_LOG_INFO, "CmoTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}

void ConstructCmoSdmaSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    RtStarsMemcpyAsyncSqe *const sqe = &(command->memcpyAsyncSqe);
    CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
    sqe->header.type = RT_STARS_SQE_TYPE_SDMA;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->header.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->header.task_id = taskInfo->id;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    // for prefetch
    sqe->opcode = cmoTsk->cmoSqeInfo.opCode; // 0x6U is cmoTask for prefetch Load
    sqe->ptrMode = 0U;
    sqe->length = cmoTsk->cmoSqeInfo.lengthInner;
    sqe->src_addr_low  = static_cast<uint32_t>(cmoTsk->cmoSqeInfo.sourceAddr & 0x00000000FFFFFFFFU);
    sqe->src_addr_high = static_cast<uint32_t>((cmoTsk->cmoSqeInfo.sourceAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    // sdmaCmo task not preempting other resources
    sqe->qos  = 6U; // only CHIP_910_B_93 sdma task qos: 6; partid: 63
    sqe->partid = 63U;

    sqe->src_streamid = 0U; // get sid and ssid from sq, leave 0 here
    sqe->dst_streamid = 0U;
    sqe->src_sub_streamid = 0U;
    sqe->dstSubStreamId = 0U;
    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->mpam = 0U;
    sqe->res3 = 0U;
    sqe->res4 = 0U;
    sqe->res5 = 0U;
    sqe->res6 = 0U;
    sqe->d2dOffsetFlag = 0U;
    sqe->srcOffsetLow = 0U;
    sqe->dstOffsetLow = 0U;
    sqe->srcOffsetHigh = 0U;
    sqe->dstOffsetHigh = 0U;
    RT_LOG(RT_LOG_INFO, "ptr_mode=%d, lengthInner=%d, opcode=0x%x, device_id=%d, stream_id=%d, task_id=%hu.",
        static_cast<int32_t>(sqe->ptrMode), static_cast<int32_t>(sqe->length), static_cast<int32_t>(sqe->opcode),
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()), taskInfo->stream->Id_(), taskInfo->id);
    PrintSqe(command, "CmoTask");
}

void ConstructCmoAddrSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CmoAddrTaskInfo *cmoAddrInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    RtStarsMemcpyAsyncPtrSqe * const sqe = &(command->memcpyAsyncPtrSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_SDMA;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = 1U;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->ptrMode = 1U;
    sqe->va = 1U;
    sqe->sdmaSqeBaseAddrLow = static_cast<uint32_t>(RtPtrToValue(cmoAddrInfo->cmoAddrInfo) & 0x00000000FFFFFFFFU);
    sqe->sdmaSqeBaseAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(cmoAddrInfo->cmoAddrInfo) & 0x0001FFFF00000000U) >> UINT32_BIT_NUM);
    RT_LOG(RT_LOG_INFO, "ConstructCmoAddrSqe, cmoAddrTaskInfo=%p, device_id=%d, stream_id=%d, task_id=%hu.",
        cmoAddrInfo->cmoAddrInfo, static_cast<int32_t>(stream->Device_()->Id_()),
        taskInfo->stream->Id_(), taskInfo->id);
    PrintSqe(command, "CmoAddrTask");
}

void ConstructSqeForCmoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream *stm = taskInfo->stream;
    Model *cmoModel = stm->Model_();

    if (taskInfo->stream->Device_()->GetDevProperties().CmoSqeVersion == SqeVersion::CMO_SQE_VERSION_V2) {
        if ((cmoModel != nullptr) && (cmoModel->GetModelType() == RT_MODEL_NORMAL)) {
            // CmoTask for normal model stream.
            ConstructCmoAddrSqe(taskInfo, command);
        } else {
            // CmoTask for single stream or capture scene.
            ConstructCmoSdmaSqe(taskInfo, command);
        }
        return;
    }

    ConstructCmoSqe(taskInfo, command);
}

void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const auto dev = taskInfo->stream->Device_();
    CmoAddrTaskInfo *cmoAddrTaskInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    const int32_t streamId = stream->Id_();
    const uint32_t taskId = taskInfo->id;
    if (stream->Model_() == nullptr) {
        return;
    }

    void *hostMemSrc = nullptr;
    constexpr uint64_t rtCmoAddrInfoSize = sizeof(rtCmoAddrInfo);
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMemSrc, rtCmoAddrInfoSize, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        return;
    }
    error = dev->Driver_()->MemCopySync(hostMemSrc, rtCmoAddrInfoSize,
        cmoAddrTaskInfo->cmoAddrInfo, rtCmoAddrInfoSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (error != RT_ERROR_NONE) {
        (void)dev->Driver_()->HostMemFree(hostMemSrc);
        RT_LOG(RT_LOG_ERROR, "Memcpy failed, size=%lu(bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
            rtCmoAddrInfoSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
        return;
    }

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t * const>(hostMemSrc);
    RT_LOG(RT_LOG_ERROR, "Sdma for CmoAddrTask in model stream execute failed, device_id=%u, stream_id=%d, task_id=%u",
        devId, streamId, taskId);
    for (size_t i = 0UL; i < (sizeof(rtCmoAddrInfo) / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_ERROR, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", "rtCmoAddrInfo",
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
    (void)dev->Driver_()->HostMemFree(hostMemSrc);
}
}  // namespace runtime
}  // namespace cce
