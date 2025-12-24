/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "cmo_task.h"

namespace cce {
namespace runtime {
#if F_DESC("CmoTask")
rtError_t CmoTaskInit(TaskInfo *taskInfo, const rtCmoTaskInfo_t *const cmoTaskInfo, const Stream * const stm,
                      const uint32_t flag)
{
    (void)flag;
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "CMO";
    taskInfo->type = TS_TASK_TYPE_CMO;
    taskInfo->u.cmoTask.cmoid = 0U;
    Model *cmoModel = stm->Model_();

    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_CMO)) {
        if (cmoModel == nullptr) {
            CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
            // sqe info copy
            const errno_t error =  memcpy_s(
                &cmoTsk->cmoSqeInfo, sizeof(rtCmoTaskInfo_t), cmoTaskInfo, sizeof(rtCmoTaskInfo_t));
            if (error != EOK) {
                RT_LOG(RT_LOG_ERROR, "copy to CMO Sqe info failed, ret=%d, src size=%zu(bytes), "
                    "dst size=%zu(bytes)", error, sizeof(rtCmoTaskInfo_t), sizeof(rtCmoTaskInfo_t));
                return RT_ERROR_SEC_HANDLE;
            }

            RT_LOG(RT_LOG_DEBUG, "CmoTask Init, opCode=%u, length=%u", cmoTsk->cmoSqeInfo.opCode,
                cmoTsk->cmoSqeInfo.lengthInner);
            return RT_ERROR_NONE;
        } else {
            RT_LOG(RT_LOG_WARNING, "CMO task stream does not support in model.");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    } else if (cmoModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO task stream is not in model.");
        return RT_ERROR_MODEL_NULL;
    } else {
        // no operation
    }

    CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
    // sqe info copy
    const errno_t error = memcpy_s(&cmoTsk->cmoSqeInfo, sizeof(rtCmoTaskInfo_t), cmoTaskInfo, sizeof(rtCmoTaskInfo_t));
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to CMO Sqe info failed, ret=%d, src size=%zu(bytes), dst size=%zu(bytes)",
            error, sizeof(rtCmoTaskInfo_t), sizeof(rtCmoTaskInfo_t));
        return RT_ERROR_SEC_HANDLE;
    }

    const rtError_t ret = cmoModel->CmoIdAlloc(cmoTsk->cmoSqeInfo.logicId, cmoTsk->cmoid);
    ERROR_RETURN(ret, "Failed to alloc cmo id.");

    RT_LOG(RT_LOG_DEBUG, "CmoTaskInfo: cmoType=%u, logicId=%u, cmoId=%u",
        cmoTsk->cmoSqeInfo.cmoType, cmoTsk->cmoSqeInfo.logicId, cmoTsk->cmoid);
    return RT_ERROR_NONE;
}

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

rtError_t CmoAddrTaskInit(TaskInfo *taskInfo, void *cmoAddrInfo, const rtCmoOpCode_t cmoOpCode)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "CMO";
    taskInfo->type = TS_TASK_TYPE_CMO;
    taskInfo->u.cmoTask.cmoid = 0U;
    Stream * const stream = taskInfo->stream;
    Model *cmoModel = stream->Model_();

    if (cmoModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO Addr task stream is not in model. device_id=%d, stream_id=%d, task_id=%hu.",
            static_cast<int32_t>(stream->Device_()->Id_()), stream->Id_(), taskInfo->id);
        return RT_ERROR_MODEL_NULL;
    }

    CmoAddrTaskInfo *cmoAddrTask = &(taskInfo->u.cmoAddrTaskInfo);
    cmoAddrTask->cmoAddrInfo = cmoAddrInfo;
    cmoAddrTask->cmoOpCode = cmoOpCode;

    RT_LOG(RT_LOG_DEBUG, "CmoAddrTask Init, device_id=%d, stream_id=%d, task_id=%hu.",
        static_cast<int32_t>(stream->Device_()->Id_()), stream->Id_(), taskInfo->id);
    return RT_ERROR_NONE;
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
#endif

}  // namespace runtime
}  // namespace cce