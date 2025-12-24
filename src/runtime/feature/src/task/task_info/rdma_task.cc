/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "stars_cond_isa_helper.hpp"
#include "context.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "notify.hpp"

namespace cce {
namespace runtime {

#if F_DESC("RdmaSendTask")
rtError_t RdmaSendTaskInit(TaskInfo* taskInfo, const uint32_t sqId, const uint32_t wqeId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_RDMA_SEND;
    taskInfo->typeName = const_cast<char_t*>("RDMA_SEND");
    taskInfo->u.rdmaSendTask.sqIndex = sqId;
    taskInfo->u.rdmaSendTask.wqeIndex = wqeId;
    return RT_ERROR_NONE;
}

void ToCommandBodyForRdmaSendTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    RT_LOG(RT_LOG_INFO, "index=0x%x, wqe_index=%u.",
        taskInfo->u.rdmaSendTask.sqIndex, taskInfo->u.rdmaSendTask.wqeIndex);
    command->u.rdmaSendTask.sqIndex = taskInfo->u.rdmaSendTask.sqIndex;
    command->u.rdmaSendTask.wqeIndex = taskInfo->u.rdmaSendTask.wqeIndex;
}

#endif

#if F_DESC("RdmaDbSendTask")
rtError_t RdmaDbSendTaskInit(TaskInfo* taskInfo, const uint32_t dbIndex, const uint64_t dbInfo, const uint32_t taskSeq)
{
    RdmaDbSendTaskInfo* rdmaDbSend = &taskInfo->u.rdmaDbSendTask;

    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_RDMA_DB_SEND;
    taskInfo->typeName = const_cast<char_t*>("RDMA_DB_SEND");
    RT_LOG(RT_LOG_INFO, "dbIndex=%#x, dbInfo=%#" PRIx64, dbIndex, dbInfo);
    rdmaDbSend->taskDbIndex.value = dbIndex;
    rdmaDbSend->taskDbInfo.value = dbInfo;

    // check vfid and dieid
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        if (taskInfo->stream->GetBindFlag()) {
            RT_LOG(RT_LOG_INFO, "taskSeq=%u", taskSeq);
            rdmaDbSend->taskSeq = taskSeq;
        }
        const uint32_t vfId = rdmaDbSend->taskDbIndex.dbIndexStars.vfId;
        const uint32_t dieId = rdmaDbSend->taskDbIndex.dbIndexStars.dieId;
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_HCCL, vfId != 0U,
            RT_ERROR_INVALID_VALUE, "invalid vfId, vfId=%u", vfId);

        const int64_t phyDieId = taskInfo->stream->Device_()->GetPhyDieId();
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_HCCL, static_cast<uint32_t>(phyDieId) != dieId,
            RT_ERROR_INVALID_VALUE, "invalid dieId, dieId=%u, phyDieId=%u", dieId, static_cast<uint32_t>(phyDieId));
    }

    return RT_ERROR_NONE;
}

void ToCommandBodyForRdmaDbSendTask(TaskInfo* taskInfo, rtCommand_t * const command)
{
    RdmaDbSendTaskInfo* rdmaDbSend = &taskInfo->u.rdmaDbSendTask;

    RT_LOG(RT_LOG_INFO, "dbIndex=%#x, dbInfo=%#" PRIx64,
        rdmaDbSend->taskDbIndex.value, rdmaDbSend->taskDbInfo.value);
    command->u.rdmaDbSendTask.dbIndex = rdmaDbSend->taskDbIndex.value;
    command->u.rdmaDbSendTask.dbInfo = rdmaDbSend->taskDbInfo.value;
}

uint32_t GetSendSqeNumForRdmaDbSendTask(TaskInfo * const taskInfo)
{
    if (taskInfo->stream->GetBindFlag()) {
        taskInfo->bindFlag = true;
    }

    constexpr uint32_t num = 1U;
    RT_LOG(RT_LOG_INFO, "ChipType=%u, BindFlag=%hhu, SqeNum=%u", Runtime::Instance()->GetChipType(),
        taskInfo->bindFlag, num);
    return num;
}

uint64_t GetRoceDbAddrForRdmaDbSendTask(TaskInfo* const taskInfo)
{
    int64_t chipId = 0U;
    const uint32_t deviceId = taskInfo->stream->Device_()->Id_();
    const rtError_t error = taskInfo->stream->Device_()->Driver_()->GetDevInfo(deviceId, MODULE_TYPE_SYSTEM,
        INFO_TYPE_PHY_CHIP_ID, &chipId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get chip failed!, device_id=%u", deviceId);
        return 0ULL;
    }
    const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
    const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
    const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();

    const uint64_t dbAddr = RT_ROCEE_BASE_ADDR_128G + RT_ROCEE_VF_DB_CFG0_REG_230 +
        chipOffset * static_cast<uint64_t>(chipId) +
        dieOffset * (taskInfo->u.rdmaDbSendTask.taskDbIndex.dbIndexStars.dieId) +
        chipAddr;
    return dbAddr;
}

void ConstructSqeSinkModeForRdmaDb1SendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    Stream * const stream = taskInfo->stream;

    // Construct sqe1
    const uint8_t sqDepthBitWidth = rdmaDbSendTask->taskDbIndex.dbIndexStars.sqDepthBitWidth;
    rtRdmaDbInfo_t dbInfo;
    dbInfo.value = rdmaDbSendTask->taskDbInfo.value;
    RtStarsRdmaSinkSqe1 &sqe1 = command->rdmaSinkSqe1;
    const uint16_t currentStreamId = static_cast<uint16_t>(stream->Id_());
    uint16_t * const execTimesSvm = stream->GetExecutedTimesSvm();
    const uint64_t svmAddr = RtPtrToValue<uint16_t *>(execTimesSvm);

    (void)memset_s(&sqe1, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    ConstructRdmaSink1Instr(static_cast<uint32_t>(dbInfo.cmd.sqProducerIdx),
        sqDepthBitWidth, svmAddr, sqe1);
    sqe1.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe1.csc = 1U;
    sqe1.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe1.sqeHeader.l1_lock = 1U;
    sqe1.sqeHeader.l1_unlock = 0U;
    sqe1.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe1.sqeHeader.block_dim = 0U;  // block_dim is not used by C-Conds
    sqe1.sqeHeader.rt_stream_id = currentStreamId;
    sqe1.sqeHeader.task_id = taskInfo->id;
    sqe1.condsSubType = CONDS_SUB_TYPE_RDMA_1;
    PrintSqe(command, "RdmaDbSendSink1");
}

void ConstructSqeSinkModeForRdmaDb2SendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    Stream * const stream = taskInfo->stream;
    rtRdmaDbInfo_t dbInfo;
    dbInfo.value = rdmaDbSendTask->taskDbInfo.value;
    const uint16_t currentStreamId = static_cast<uint16_t>(stream->Id_());

    // Construct sqe2
    RtStarsRdmaSinkSqe2 &sqe2 = command->rdmaSinkSqe2;
    const uint64_t dbAddr = GetRoceDbAddrForRdmaDbSendTask(taskInfo);
    if (dbAddr == 0ULL) {
        sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    dbInfo.cmd.sqProducerIdx = 0U;

    (void)memset_s(&sqe2, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    ConstructRdmaSink2Instr(dbAddr, dbInfo.value, sqe2);
    sqe2.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe2.csc = 0U;
    sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe2.sqeHeader.l1_lock = 0U;
    sqe2.sqeHeader.l1_unlock = 1U;
    sqe2.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe2.sqeHeader.block_dim = 0U;  // block_dim is not used by C-Conds
    sqe2.sqeHeader.rt_stream_id = currentStreamId;
    sqe2.sqeHeader.task_id = taskInfo->id;
    sqe2.condsSubType = CONDS_SUB_TYPE_RDMA_2;

    PrintSqe(command, "RdmaDbSendSink2");
}

void ConstructSqeNoSinkModeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    Stream * const stream = taskInfo->stream;
    RtStarsWriteValueSqe * const sqe = &(command->writeValueSqe);

    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->va = 0U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;

    sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_RDMA_DB_SEND;

    const uint64_t dbVal = taskInfo->u.rdmaDbSendTask.taskDbInfo.value; // GetRoceDbVal();
    const uint64_t dbAddr = GetRoceDbAddrForRdmaDbSendTask(taskInfo);   // GetRoceDbAddr();
    if (dbAddr == 0ULL) {
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    sqe->write_value_part0 = static_cast<uint32_t>(dbVal & MASK_32_BIT);
    sqe->write_value_part1 = static_cast<uint32_t>(dbVal >> UINT32_BIT_NUM);
    sqe->write_addr_low = static_cast<uint32_t>(dbAddr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((dbAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "RdmaDbSendNoSink");
    RT_LOG(RT_LOG_INFO, "RdmaDbSendTask no-sink device_id=%d, stream_id=%d, die_id=%u, task_id=%hu, sqProducerIdx=%u, "
        " dbAddr=%#" PRIx64" dbVal:%#" PRIx64,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->u.rdmaDbSendTask.taskDbIndex.dbIndexStars.dieId,
        taskInfo->id, taskInfo->u.rdmaDbSendTask.taskDbInfo.cmd.sqProducerIdx, dbAddr, dbVal);
}

void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    if (taskInfo->bindFlag != 0U) {
        if (rdmaDbSendTask->taskSeq == 1U) {
            return ConstructSqeSinkModeForRdmaDb1SendTask(taskInfo, command);
        } else if (rdmaDbSendTask->taskSeq == 2U) {
            return ConstructSqeSinkModeForRdmaDb2SendTask(taskInfo, command);
        } else {
            RT_LOG(RT_LOG_ERROR, "model taskSeq must be [1, 2], but taskSeq=%u", rdmaDbSendTask->taskSeq);
        }
    }
    return ConstructSqeNoSinkModeForRdmaDbSendTask(taskInfo, command);
}

rtError_t RdmaPiValueModifyTaskInit(TaskInfo *const taskInfo, const std::vector<uint64_t> &rdmaPiValueDeviceAddrVec)
{
    RdmaPiValueModifyInfo *rdmaPiValueModifyInfo = &(taskInfo->u.rdmaPiValueModifyInfo);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    taskInfo->typeName = "RDMA_PI_VALUE_MODIFY";
    rdmaPiValueModifyInfo->funCallMemAddr = nullptr;
    rdmaPiValueModifyInfo->funCallMemAddrAlign = nullptr;
    rdmaPiValueModifyInfo->dfxAddr = nullptr;
    rdmaPiValueModifyInfo->rdmaSubContextCount = 0U;

    Stream *stream = taskInfo->stream;
    Device *dev = stream->Device_();
    const uint64_t piValueVecLength = rdmaPiValueDeviceAddrVec.size();
    const uint64_t funCallMemAndPiValueMemSize =
        sizeof(RtStarsPivalueModifyFuncCall) + piValueVecLength * sizeof(uint64_t);
    const uint64_t dfxSize = piValueVecLength * sizeof(uint64_t);  // 记录value值
    const uint64_t allocSize = funCallMemAndPiValueMemSize + dfxSize + FUNC_CALL_INSTR_ALIGN_SIZE;

    void *funCallMemAddr = nullptr;
    auto ret = dev->Driver_()->DevMemAlloc(&funCallMemAddr, allocSize, RT_MEMORY_DDR, dev->Id_());
    if (ret != RT_ERROR_NONE || funCallMemAddr == nullptr) {
        RT_LOG(RT_LOG_ERROR,
            "alloc pi value array failed, allocSize=%llu, funCallMemAndPiValueMemSize=%llu, dfxSize=%llu, ret=%#x",
            allocSize,
            funCallMemAndPiValueMemSize,
            dfxSize,
            ret);
        return RT_ERROR_DRV_MEMORY;
    }
    rdmaPiValueModifyInfo->funCallMemSize = allocSize;

    uint64_t funCallMemAddrAlign = RtPtrToValue<void *>(funCallMemAddr);

    // instr addr should align to 256b
    
    if ((RtPtrToPtr<uintptr_t, void *>(funCallMemAddr) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        funCallMemAddrAlign = ((RtPtrToValue<void *>(funCallMemAddr) >> 8U) + 1UL) << 8U;
    }

    RtStarsPivalueModifyFuncCall funcCall = {};
    const uint64_t piValueArrAddr = funCallMemAddrAlign + sizeof(RtStarsPivalueModifyFuncCall);
    const uint64_t dfxAddr = piValueArrAddr + piValueVecLength * sizeof(uint64_t);
    ConstructRdmaPiValueModifyInstr(piValueArrAddr, piValueVecLength, dfxAddr, funcCall);

    RT_LOG(RT_LOG_DEBUG,
        "piValueVecLength size is %lu, funCallMemAddr is %p, funCallMemAddrAlign is %#" PRIx64
        ", piValueArrAddr is %#" PRIx64 ", dfxAddr is %#" PRIx64,
        piValueVecLength,
        funCallMemAddr,
        funCallMemAddrAlign,
        piValueArrAddr,
        dfxAddr);

    std::vector<uint8_t> hostFunCallMem(funCallMemAndPiValueMemSize);
    auto cpyRet = memcpy_s(
        hostFunCallMem.data(), sizeof(RtStarsPivalueModifyFuncCall), &funcCall, sizeof(RtStarsPivalueModifyFuncCall));
    if (cpyRet != EOK) {
        RT_LOG(RT_LOG_ERROR,
            "memcpy_s failed, funCallMemAndPiValueMemSize=%llu, cpyRet=%d",
            funCallMemAndPiValueMemSize,
            cpyRet);
        (void)dev->Driver_()->DevMemFree(funCallMemAddr, dev->Id_());
        return RT_ERROR_SEC_HANDLE;
    }

    uint8_t *hostPivalueMem = hostFunCallMem.data() + sizeof(RtStarsPivalueModifyFuncCall);
    cpyRet = memcpy_s(hostPivalueMem,
        piValueVecLength * sizeof(uint64_t),
        rdmaPiValueDeviceAddrVec.data(),
        piValueVecLength * sizeof(uint64_t));
    if (cpyRet != EOK) {
        RT_LOG(RT_LOG_ERROR,
            "memcpy_s failed, funCallMemAndPiValueMemSize=%llu, piValueVecLength=%lu, cpyRet=%d",
            funCallMemAndPiValueMemSize,
            piValueVecLength,
            cpyRet);
        (void)dev->Driver_()->DevMemFree(funCallMemAddr, dev->Id_());
        return RT_ERROR_SEC_HANDLE;
    }
    
    ret = dev->Driver_()->MemCopySync(RtPtrToPtr<void *, uint64_t>(funCallMemAddrAlign),
        funCallMemAndPiValueMemSize,
        hostFunCallMem.data(),
        funCallMemAndPiValueMemSize,
        RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "funCallMem memcopy failed, funCallMemAddr=%p, hostFunCallMem addr=%p, funCallMemSize=%llu, ret=%#x",
            funCallMemAddr,
            hostFunCallMem.data(),
            funCallMemAndPiValueMemSize,
            ret);
        (void)dev->Driver_()->DevMemFree(funCallMemAddr, dev->Id_());
        return ret;
    }

    rdmaPiValueModifyInfo->funCallMemAddr = funCallMemAddr;
    rdmaPiValueModifyInfo->funCallMemAddrAlign = RtPtrToPtr<void *, uint64_t>(funCallMemAddrAlign);
    rdmaPiValueModifyInfo->dfxAddr = RtPtrToPtr<void *, uint64_t>(dfxAddr);
    rdmaPiValueModifyInfo->rdmaSubContextCount = static_cast<uint32_t>(piValueVecLength);
    RT_LOG(RT_LOG_DEBUG,
        "funCallMemAddr is %p, funCallMemAddrAlign is %p, dfxAddr is %p, rdmaSubContextCount is %u",
        rdmaPiValueModifyInfo->funCallMemAddr,
        rdmaPiValueModifyInfo->funCallMemAddrAlign,
        rdmaPiValueModifyInfo->dfxAddr,
        rdmaPiValueModifyInfo->rdmaSubContextCount);
    return RT_ERROR_NONE;
}

void PrintErrorInfoForRDMAPiValueModifyTask(TaskInfo *const taskInfo, const uint32_t devId)
{
    const RdmaPiValueModifyInfo &rdmaPiValueModifyInfo = taskInfo->u.rdmaPiValueModifyInfo;
    const void *dfxAddr = rdmaPiValueModifyInfo.dfxAddr;
    RT_LOG(RT_LOG_ERROR,
        "devId=%u, task_id=%u, funCallMemAddr=%p, dfxAddr=%p, rdmaSubContextCount=%zu",
        devId,
        taskInfo->id,
        rdmaPiValueModifyInfo.funCallMemAddr,
        dfxAddr,
        rdmaPiValueModifyInfo.rdmaSubContextCount);
}

void GetRdmaTaskInfoFromFftsPlusTask(const rtFftsPlusTaskInfo_t *const fftsPlusTaskInfo, const void *deviceDescAlignBuf,
    std::vector<uint64_t> &rdmaPiValueDeviceAddrVec)
{
    if (fftsPlusTaskInfo->descAddrType != RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_HOST) {
        RT_LOG(RT_LOG_INFO, "fftsPlusTaskInfo->descAddrType is %zu", fftsPlusTaskInfo->descAddrType);
        return;
    }

    if (fftsPlusTaskInfo->descBufLen % CONTEXT_ALIGN_LEN != 0) {
        RT_LOG(RT_LOG_ERROR,
            "descBufLen is not aligned to CONTEXT_ALIGN_LEN, descBufLen=%zu",
            fftsPlusTaskInfo->descBufLen);
        return;
    }

    const size_t contextNum = fftsPlusTaskInfo->descBufLen / CONTEXT_ALIGN_LEN;
    const uint8_t *hostTotalContextAddr = static_cast<const uint8_t *>((fftsPlusTaskInfo->descBuf));
    const uint64_t deviceTotalContextAddr = RtPtrToValue<const void *>(deviceDescAlignBuf);
    for (size_t i = 0; i < contextNum; i++) {
        const uint64_t contextOffset = i * CONTEXT_ALIGN_LEN;
        const uint16_t contextType = *(RtPtrToPtr<const uint16_t *>((hostTotalContextAddr + contextOffset)));
        if (contextType == static_cast<uint16_t>(RT_CTX_TYPE_WRITE_VALUE_RDMA)) {
            constexpr size_t offset = offsetof(rtFftsPlusWriteValueCtx_t, writeValue);
            const uint64_t piValueOffset = contextOffset + offset;
            RT_LOG(RT_LOG_DEBUG, "rdma offset=%zu, piValueOffset=%lu.", offset, piValueOffset);
            rdmaPiValueDeviceAddrVec.push_back(deviceTotalContextAddr + piValueOffset);
        }
    }
}

rtError_t SubmitRdmaPiValueModifyTask(
    Stream *const stm, const rtFftsPlusTaskInfo_t *const fftsPlusTaskInfo, const void *deviceDescAlignBuf)
{
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec;
    GetRdmaTaskInfoFromFftsPlusTask(fftsPlusTaskInfo, deviceDescAlignBuf, rdmaPiValueDeviceAddrVec);

    if (rdmaPiValueDeviceAddrVec.size() > 0) {
        RT_LOG(RT_LOG_INFO, "rdma sub context size=%zu.", rdmaPiValueDeviceAddrVec.size());
        TaskInfo submitTask = {};
        rtError_t error = RT_ERROR_NONE;
        TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY, error);
        COND_RETURN_ERROR_MSG_INNER(
            tsk == nullptr, error, "Failed to alloc task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

        Device *const dev = stm->Device_();
        error = RdmaPiValueModifyTaskInit(tsk, rdmaPiValueDeviceAddrVec);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "task init failed, stream_id=%d, retCode=%#x.", stm->Id_(), error);
            (void)dev->GetTaskFactory()->Recycle(tsk);
            return error;
        }

        Stream *captureStm = stm->GetCaptureStream();
        CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(captureStm->Model_());
        COND_PROC_RETURN_ERROR(
            captureMdl == nullptr, RT_ERROR_MODEL_NULL, (void)dev->GetTaskFactory()->Recycle(tsk), "captureMdl is NULL");
        captureMdl->InsertRdmaPiValueModifyInfo(captureStm->Id_(), tsk->id);
        error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "submit rdma pi value modify task failed, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
            (void)dev->GetTaskFactory()->Recycle(tsk);
            return error;
        }
        GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    }
    return RT_ERROR_NONE;
}

void ConstructSqeRdmaPiValueModifyTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    Stream *const stream = taskInfo->stream;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    (void)memset_s(&sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_PI_VALUE_MODIFY;

    RdmaPiValueModifyInfo &rdmaPiValueModifyInfo = taskInfo->u.rdmaPiValueModifyInfo;
    
    const uint64_t funcAddr = RtPtrToValue<void*>(rdmaPiValueModifyInfo.funCallMemAddrAlign);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsPivalueModifyFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "RdmaPiValueModify");
    RT_LOG(RT_LOG_INFO, "RdmaPiValueModify stream_id=%d task_id=%hu.", stream->Id_(), taskInfo->id);
}

void RdmaPiValueModifyTaskUnInit(TaskInfo *taskInfo)
{
    RdmaPiValueModifyInfo &rdmaPiValueModifyInfo = taskInfo->u.rdmaPiValueModifyInfo;
    if (rdmaPiValueModifyInfo.funCallMemAddr != nullptr) {
        Device *dev = taskInfo->stream->Device_();
        Driver *deviceDrv = dev->Driver_();
        (void)deviceDrv->DevMemFree(rdmaPiValueModifyInfo.funCallMemAddr, dev->Id_());
        RT_LOG(RT_LOG_INFO, "free rdma pi value modify mem, funCallMemAddr=%p.", rdmaPiValueModifyInfo.funCallMemAddr);
    }
    rdmaPiValueModifyInfo.funCallMemAddr = nullptr;
    rdmaPiValueModifyInfo.funCallMemAddrAlign = nullptr;
    rdmaPiValueModifyInfo.dfxAddr = nullptr;
    rdmaPiValueModifyInfo.rdmaSubContextCount = 0U;
}

void PrintDfxInfoForRdmaPiValueModifyTask(const TaskInfo *taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) != 1) {
        return;
    }

    if ((taskInfo->u.notifywaitTask.isCountNotify) || (taskInfo->u.notifywaitTask.u.notify == nullptr) ||
        (taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel() == nullptr)) {
        return;
    }

    Model *mdl = taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel();
    if (mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        return;
    }

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    if (captureModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Dynamic cast to CaptureModel failed.");
        return;
    }
    Device *dev = taskInfo->stream->Device_();
    for (const auto &iter : captureModel->GetRdmaPiValueModifyTaskInfoMap()) {
        const int32_t streamId = iter.first;
        const auto &taskIds = iter.second;
        for (const auto &taskId : taskIds) {
            TaskInfo *taskPtr = dev->GetTaskFactory()->GetTask(streamId, taskId);
            if (taskPtr == nullptr || taskPtr->type != TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY) {
                continue;
            }
            const auto &rdmaPiValueModifyInfo = taskPtr->u.rdmaPiValueModifyInfo;
            if (rdmaPiValueModifyInfo.rdmaSubContextCount == 0) {
                RT_LOG(RT_LOG_WARNING, "rdmaSubContextCount is zero.");
                continue;
            }

            RT_LOG(RT_LOG_DEBUG,
                "stream_id=%d, task_id=%u, funCallMemAddr is %p, funCallMemAddrAlign is %p, dfxAddr is %p, "
                "rdmaSubContextCount is %u",
                streamId,
                taskId,
                rdmaPiValueModifyInfo.funCallMemAddr,
                rdmaPiValueModifyInfo.funCallMemAddrAlign,
                rdmaPiValueModifyInfo.dfxAddr,
                rdmaPiValueModifyInfo.rdmaSubContextCount);

            const void *dfxAddr = rdmaPiValueModifyInfo.dfxAddr;
            std::vector<uint64_t> rdmaPiValueInfo(rdmaPiValueModifyInfo.rdmaSubContextCount);
            const auto ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(rdmaPiValueInfo.data(),
                rdmaPiValueInfo.size() * sizeof(uint64_t),
                dfxAddr,
                rdmaPiValueInfo.size() * sizeof(uint64_t),
                RT_MEMCPY_DEVICE_TO_HOST);
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR,
                    "MemCopySync failed, dfxAddr=%p, size=%zu, ret=%#x",
                    dfxAddr,
                    rdmaPiValueInfo.size(),
                    ret);
                return;
            }
            for (size_t i = 0; i < rdmaPiValueInfo.size(); i++) {
                RT_LOG(RT_LOG_DEBUG, "rdmaPiValueInfo[%zu]=%#" PRIx64, i, rdmaPiValueInfo[i]);
            }
        }
    }
}

#endif

}  // namespace runtime
}  // namespace cce