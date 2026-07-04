/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "cond_enum_desc.hpp"
#include "stars_cond_isa_helper.hpp"
#include "context.hpp"
#include "aclgraph_cond_task.h"
#include "model.hpp"
#include "notify.hpp"
#include <cstring>

namespace cce {
namespace runtime {

#if F_DESC("aclgraph condition task")
static void GetCondTaskTotalSqAndModelCount(CondHandle *condHandle, uint64_t &totalSqCount, uint64_t &modelCount)
{
    std::vector<Model*> &subModels = condHandle->GetSubCaptureModels();
    modelCount = subModels.size();

    totalSqCount = 0U;
    for (Model *subModel : subModels) {
        std::list<Stream*> headStreams = subModel->GetHeadStreamList_();
        totalSqCount += static_cast<uint32_t>(headStreams.size());
    }

    return;
}

static rtError_t CondTaskFuncCallDevMemAlloc(TaskInfo* taskInfo, CondHandle *condHandle)
{
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    void *devMem = nullptr;
    Stream * const stream = taskInfo->stream;
    const Device *dev = stream->Device_();
    uint64_t totalSqCount  = 0U;
    uint64_t modelCount = 0U;
    GetCondTaskTotalSqAndModelCount(condHandle, totalSqCount, modelCount);

    /* totalSqCount * 2U + modelCount * 3U 为了存储条件算子用到的几个dev地址，含义见下文注释 */
    const uint64_t allocSize = (totalSqCount * 2U + modelCount * 3U) * sizeof(uint64_t) + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u",
                    ret, condTaskInfo->funCallMemSize, dev->Id_());
        return ret;
    }

    condTaskInfo->baseFuncCallDevMem = devMem;

    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void *>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, const uintptr_t>(devMemAlign);
    }
    /* 从第一个模型到最后一个，依次存放每个模型sqlistAddr的首地址 */
    const uint64_t totalModelSize = modelCount * sizeof(uint64_t);
    const uint64_t totalSqSize = totalSqCount * sizeof(uint64_t);
    condTaskInfo->headSqArrPtrArrSvmMem =  RtValueToPtr<void *>(RtPtrToValue(devMem) + TS_STARS_COND_DFX_SIZE);
    /* 依次存放所有模型sqlist */
    condTaskInfo->headSqArrDataSvmMem = RtValueToPtr<void *>(RtPtrToValue(condTaskInfo->headSqArrPtrArrSvmMem) + totalModelSize);
    condTaskInfo->headSqArrDataSvmMemSize = totalSqSize;

    /* 依次存放每个模型sqcount */
    condTaskInfo->modelSqCountArrSvmMem = RtValueToPtr<void *>(RtPtrToValue(condTaskInfo->headSqArrDataSvmMem) + totalSqSize);

    /* 依次存放每个模型sqSvmlistAddr的首地址 */
    condTaskInfo->streamSvmPtrArrSvmMem = RtValueToPtr<void *>(RtPtrToValue(condTaskInfo->modelSqCountArrSvmMem) + totalModelSize);
    /* 依次存放所有模型sqSvmlist */
    condTaskInfo->streamSvmDataSvmMem = RtValueToPtr<void *>(RtPtrToValue(condTaskInfo->streamSvmPtrArrSvmMem) + totalModelSize);
    condTaskInfo->streamSvmDataSvmMemSize = totalSqSize;

    return RT_ERROR_NONE;
}

static rtError_t AllocCondTaskFuncCallMem(TaskInfo* taskInfo)
{
    void *devMem = nullptr;
    Stream * const stream = taskInfo->stream;
    const Device *dev = stream->Device_();

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    /* totalSqCount * 3U + modelCount * 2U 为了存储条件算子用到的几个dev地址，含义见下文注释 */
    const uint64_t allocSize = condTaskInfo->funCallMemSize +
        TS_STARS_COND_DFX_SIZE + COND_TASK_RESV_LEN_FOR_COND_EXECUTE + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u",
                    ret, condTaskInfo->funCallMemSize, dev->Id_());
        return ret;
    }

    condTaskInfo->baseFuncCallSvmMem = devMem;

    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void *>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, const uintptr_t>(devMemAlign);
    }
    condTaskInfo->funcCallSvmMem = devMem;
    condTaskInfo->dfxPtr = RtValueToPtr<void *>(RtPtrToValue(condTaskInfo->funcCallSvmMem) + condTaskInfo->funCallMemSize);

    return RT_ERROR_NONE;
}

uint64_t GetFuncCallMemSizeForCaptureCondTask(rtCondTaskType_t type)
{
    switch (type) {
        case RT_COND_TASK_TYPE_IF:
            return sizeof(RtStarsCaptureIfCondFc);

        case RT_COND_TASK_TYPE_SWITCH:
            return sizeof(RtStarsCaptureSwitchCondFc);

        case RT_COND_TASK_TYPE_WHILE:
            return sizeof(RtStarsCaptureWhileCondFc);

        default:
            RT_LOG(RT_LOG_ERROR, "Invalid cond type, cond type=%d", type);
            return 0U;
    }
}

rtError_t FreeFuncCallDevForCaptureCondTask(TaskInfo * const taskInfo)
{
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    const auto dev = taskInfo->stream->Device_();
    rtError_t ret = RT_ERROR_NONE;

    if (condTaskInfo->funcCallHostMem != nullptr) {
        free(condTaskInfo->funcCallHostMem);
        condTaskInfo->funcCallHostMem = nullptr;
    }

    if (condTaskInfo->baseFuncCallDevMem != nullptr) {
        ret = dev->Driver_()->DevMemFree(condTaskInfo->baseFuncCallDevMem, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free func call svm mem free failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        condTaskInfo->baseFuncCallDevMem = nullptr;

        condTaskInfo->headSqArrPtrArrSvmMem = nullptr;
        condTaskInfo->headSqArrDataSvmMem = nullptr;
        condTaskInfo->headSqArrDataSvmMemSize = 0;
        condTaskInfo->modelSqCountArrSvmMem = nullptr;
        condTaskInfo->streamSvmPtrArrSvmMem = nullptr;
        condTaskInfo->streamSvmDataSvmMem = nullptr;
        condTaskInfo->streamSvmDataSvmMemSize = 0;
    }

    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallMemForCaptureCondTask(TaskInfo * const taskInfo)
{
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    const auto dev = taskInfo->stream->Device_();
    rtError_t ret = RT_ERROR_NONE;

    if (condTaskInfo->baseFuncCallSvmMem != nullptr) {
        ret = dev->Driver_()->DevMemFree(condTaskInfo->baseFuncCallSvmMem, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free func call svm mem free failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        condTaskInfo->baseFuncCallSvmMem = nullptr;
        condTaskInfo->funcCallSvmMem = nullptr;
        condTaskInfo->dfxPtr = nullptr;
    }

    condTaskInfo->funCallMemSize = 0UL;
    (void)FreeFuncCallDevForCaptureCondTask(taskInfo);
    return RT_ERROR_NONE;
}

static rtError_t AllocJumpBackFuncCallMemForCaptureCondTask(TaskInfo *taskInfo)
{
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    void *devMem = nullptr;
    condTaskInfo->jumpBackFunCallMemSize = sizeof(RtStarsCaptureWhileCondJumpBackFc);
    const Device *dev = taskInfo->stream->Device_();
    const uint64_t allocSize = condTaskInfo->jumpBackFunCallMemSize + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), RT_ERROR_MEMORY_ALLOCATION,
        "alloc jumpBack func call mem failed, retCode=%#x.", ret);
    condTaskInfo->jumpBackBaseFuncCallSvmMem = devMem;
    if ((RtPtrToPtr<uintptr_t, void *>(devMem) & 0xFFULL) != 0ULL) {
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, const uintptr_t>(devMemAlign);
    }
    condTaskInfo->jumpBackFuncCallSvmMem = devMem;
    return RT_ERROR_NONE;
}

rtError_t CaptureConditionTaskInit(TaskInfo *taskInfo, CondHandle *condHandle)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "CONDITION_OP";
    taskInfo->type = TS_TASK_TYPE_CAPTURE_CONDITION;
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    condTaskInfo->condHandle = condHandle;
    taskInfo->sqeNum = (condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) ? COND_TASK_WHILE_SQE_NUM : COND_TASK_IF_SWITCH_SQE_NUM;

    condTaskInfo->funCallMemSize = GetFuncCallMemSizeForCaptureCondTask(condHandle->GetCondType());
    COND_RETURN_ERROR(condTaskInfo->funCallMemSize == 0, RT_ERROR_INVALID_VALUE, "Invalid cond type, cond type=%d", condHandle->GetCondType());

    Notify *notify = condHandle->GetSubModelNotify();
    COND_RETURN_ERROR((notify == nullptr), RT_ERROR_NOTIFY_NULL, "Sub model end graph notify is null.");

    condTaskInfo->notifyId = notify->GetNotifyId();
    condTaskInfo->notifyTimeout = MAX_UINT32_NUM;
    if (condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) {
        // 申请while条件算子中第二个条件算子任务，用于判断是否继续执行while子模型
        const rtError_t ret = AllocJumpBackFuncCallMemForCaptureCondTask(taskInfo);
        ERROR_RETURN(ret, "alloc jumpBack func call mem failed, retCode=%#x.", ret);
    }

    return AllocCondTaskFuncCallMem(taskInfo);
}

void CaptureConditionTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeFuncCallMemForCaptureCondTask(taskInfo);

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    if (condTaskInfo->jumpBackBaseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        dev->Driver_()->DevMemFree(condTaskInfo->jumpBackBaseFuncCallSvmMem, dev->Id_());
        condTaskInfo->jumpBackBaseFuncCallSvmMem = nullptr;
        condTaskInfo->jumpBackFuncCallSvmMem = nullptr;
        condTaskInfo->jumpBackFunCallMemSize = 0;
    }
}

rtError_t CheckCondTaskParamsSize(rtCondTaskParams params)
{
    RT_LOG(RT_LOG_DEBUG, "condition type=%u, condition size=%u", params.type, params.size);
    switch (params.type) {
        case RT_COND_TASK_TYPE_IF:
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
                (params.size != RT_COND_NUMBER_ONE) && (params.size != RT_COND_NUMBER_TWO),
                RT_ERROR_INVALID_VALUE, params.size,
                "1 or 2");
            return RT_ERROR_NONE;
        case RT_COND_TASK_TYPE_WHILE:
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(params.size != RT_COND_NUMBER_ONE,
                RT_ERROR_INVALID_VALUE, params.size,
                "1");
            return RT_ERROR_NONE;
        case RT_COND_TASK_TYPE_SWITCH:
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(params.size == RT_COND_NUMBER_ZERO,
                RT_ERROR_INVALID_VALUE, params.size,
                "greater than 0");
            return RT_ERROR_NONE;
        default:
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(true, RT_ERROR_INVALID_VALUE, CondTaskTypeToString(params.type),
                "params.type", "[0, " + std::to_string(RT_COND_TASK_TYPE_SWITCH) + "]");
    }
}

rtError_t PostProcCaptureConditionTask(CondHandle *condHandle, Stream * const stm, const uint16_t taskId)
{
    Notify *notify = condHandle->GetSubModelNotify();
    for (Model *mdl : condHandle->GetSubCaptureModels()) {
        CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
        if (subModel == nullptr) {
            continue;
        }
        subModel->SetEndGraphNotify(notify);
    }

    // 存储stream id, task id, handle到父capture model中
    Stream *captureStm = stm->GetCaptureStream();
    NULL_PTR_RETURN(captureStm, RT_ERROR_STREAM_NULL);

    Model *mdl = captureStm->Model_();
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    NULL_PTR_RETURN(captureModel, RT_ERROR_MODEL_NULL);

    const rtError_t error = captureModel->StoreCondHandleTaskInfo(captureStm->Id_(), taskId, condHandle);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "capture model condition task submit, origin stream_id=%d, stream_id=%d, task_id=%u",
        stm->Id_(), captureStm->Id_(), taskId);
    return RT_ERROR_NONE;
}

void Construct1stSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe)
{
    // 构造第1个SQE：条件算子，判断条件变量值并跳转执行子模型
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream *stm = taskInfo->stream;

    RtStarsFunctionCallSqe &sqe0 = sqe->fuctionCallSqe;
    sqe0.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe0.csc = 1U;
    sqe0.sqeHeader.l1_lock = 0U;
    sqe0.sqeHeader.l1_unlock = 0U;
    sqe0.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe0.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe0.sqeHeader.block_dim = 0U;
    sqe0.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe0.sqeHeader.task_id = taskInfo->id;
    sqe0.conds_sub_type = CONDS_SUB_TYPE_CAPTURE_MODEL_COND;
    const uint64_t funcAddr = RtPtrToValue(condTaskInfo->funcCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->funCallMemSize / 4UL), sqe0);
    PrintSqe(sqe, "CaptureConditionTask[0]:CondFirst");
}

void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe)
{
    // 构造第2个SQE：NotifyWait，等待子模型执行完成的notify信号
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream *stm = taskInfo->stream;

    RtStarsNotifySqe &notifySqe = sqe->notifySqe;
    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    notifySqe.header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    notifySqe.kernel_credit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe.header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    notifySqe.header.task_id = taskInfo->id;
    notifySqe.notify_id = condTaskInfo->notifyId;
    notifySqe.timeout = condTaskInfo->notifyTimeout;
    PrintSqe(sqe, "CaptureConditionTask[1]:NotifyWait");
}

void ConstructCaptureConditionJumpBackFc(TaskInfo * const taskInfo, RtStarsCaptureWhileCondJumpBackFc &fc)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream *stm = taskInfo->stream;
    const uint64_t sqHeadPre = static_cast<uint64_t>(stm->GetCurSqPos() % stm->GetSqDepth());

    ConstructLoadImm(r1, RtPtrToValue(condTaskInfo->condHandle->GetDevAddr()), RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, fc.loadDevAddr);

    const uint64_t offset = offsetof(RtStarsCaptureWhileCondJumpBackFc, end) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r2, offset, fc.jumpPcToEnd);
    // *devptr等于0，退出while
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beqToSkip);

    // modifySqHeadOffset
    // load sqHead to r4
    ConstructLHWI(r4, sqHeadPre, fc.lhwi);
    ConstructLLWI(r4, sqHeadPre, fc.llwi);
    // load sqid from virtual addr to r3
    ConstructLoadImm(r3, stm->GetSqIdMemAddr(), RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, fc.loadSqId);

    // r4 = r4 < 16
    ConstructOpImmSlli(r4, r4, 16U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli);
    // r3 = r3 | r4, sqId=[10:0], head=[31:16]
    ConstructOpOp(r3, r4, r3, RT_STARS_COND_ISA_OP_FUNC3_OR, RT_STARS_COND_ISA_OP_FUNC7_OR, fc.op);
    // modify sq head by goto_r
    ConstructGotoR(r3, r5, fc.goto_pre);
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsCaptureWhileCondJumpBackFc) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "construct jump back cond task funcall, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void Construct3rdSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe)
{
    // 构造第3个SQE：JumpBack（仅while类型），条件成立时跳回循环起始位置重新执行
    Stream * const stm = taskInfo->stream;
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    RtStarsCaptureWhileCondJumpBackFc fc = {};
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsCaptureWhileCondJumpBackFc));
    ConstructCaptureConditionJumpBackFc(taskInfo, fc);

    RtStarsFunctionCallSqe &sqe2 = sqe->fuctionCallSqe;
    const rtError_t ret = stm->Device_()->Driver_()->MemCopySync(condTaskInfo->jumpBackFuncCallSvmMem,
        condTaskInfo->jumpBackFunCallMemSize, &fc, funcCallSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }

    sqe2.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe2.csc = 1U;
    sqe2.sqeHeader.l1_lock = 0U;
    sqe2.sqeHeader.l1_unlock = 0U;
    sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe2.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe2.sqeHeader.block_dim = 0U;
    sqe2.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe2.sqeHeader.task_id = taskInfo->id;
    sqe2.conds_sub_type = CONDS_SUB_TYPE_CAPTURE_MODEL_COND_JUMPBACK;
    const uint64_t funcAddr = RtPtrToValue(condTaskInfo->jumpBackFuncCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->jumpBackFunCallMemSize / 4UL), sqe2);
    PrintSqe(sqe, "Construct3rdSqeForCaptureConditionTask");
    RT_LOG(RT_LOG_INFO, "Construct3rdSqeForCaptureConditionTask current stream_id=%d task_id=%hu.",
        stm->Id_(), taskInfo->id);
}

void ConstructSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Construct1stSqeForCaptureConditionTask(taskInfo, &command[0]);
    Construct2ndSqeForCaptureConditionTask(taskInfo, &command[1]);

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    if (condTaskInfo->condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) {
        Construct3rdSqeForCaptureConditionTask(taskInfo, &command[2]);
    }
}

static rtError_t ConstructCaptureCondTaskFc(CaptureConditionTaskInfo *condTaskInfo, rtStarsCaptureCondFcPara_t &para)
{
    rtError_t ret;
    switch (condTaskInfo->condHandle->GetCondType()) {
        case RT_COND_TASK_TYPE_IF:
            {
                RtStarsCaptureIfCondFc fcIf;
                ConstructCaptureIfCondFc(para, fcIf);
                ret = memcpy_s(condTaskInfo->funcCallHostMem, condTaskInfo->funCallMemSize, &fcIf, sizeof(fcIf));
                COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "memcpy fcIf failed.");
            }
            break;
        case RT_COND_TASK_TYPE_WHILE:
            {
                RtStarsCaptureWhileCondFc fcWhile;
                ConstructCaptureWhileCondFc(para, fcWhile);
                ret = memcpy_s(condTaskInfo->funcCallHostMem, condTaskInfo->funCallMemSize, &fcWhile, sizeof(fcWhile));
                COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "memcpy fcWhile failed.");
            }
            break;
        case RT_COND_TASK_TYPE_SWITCH:
            {
                RtStarsCaptureSwitchCondFc fcSwitch;
                ConstructCaptureSwitchCondFc(para, fcSwitch);
                ret = memcpy_s(condTaskInfo->funcCallHostMem, condTaskInfo->funCallMemSize,
                    &fcSwitch, sizeof(fcSwitch));
                COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "memcpy fcSwitch failed.");
            }
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "unsupported condType=%d.", condTaskInfo->condHandle->GetCondType());
            return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

void ConstructCaptureCondTaskDeltaOffset(rtCondTaskType_t condType, rtStarsCaptureCondFcPara_t &para)
{
    switch (condType) {
        case RT_COND_TASK_TYPE_IF:
            para.deltaOffset = offsetof(RtStarsCaptureIfCondFc, modelExe) / sizeof(uint32_t);
            break;
        case RT_COND_TASK_TYPE_WHILE:
            para.deltaOffset = offsetof(RtStarsCaptureWhileCondFc, modelExe) / sizeof(uint32_t);
            break;
        case RT_COND_TASK_TYPE_SWITCH:
            para.deltaOffset = offsetof(RtStarsCaptureSwitchCondFc, modelExe) / sizeof(uint32_t);
            break;
        default:
            RT_LOG(RT_LOG_EVENT, "unsupported condType=%d.", condType);
    }
}

rtError_t ConstructCaptureCondTaskPara(TaskInfo *taskInfo, CondHandle *condHandle, rtStarsCaptureCondFcPara_t &para)
{
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream *stream = taskInfo->stream;
    Device *dev = stream->Device_();

    para.devAddr = RtPtrToValue(condHandle->GetDevAddr());
    para.sqIdMemAddr = stream->GetSqIdMemAddr();
    para.headSqArrPtrArrAddr = RtPtrToValue(condTaskInfo->headSqArrPtrArrSvmMem);
    para.modelSqCountArrAddr = RtPtrToValue(condTaskInfo->modelSqCountArrSvmMem);
    para.modelCount = condHandle->GetSubCaptureModels().size();

    const DevProperties props = dev->GetDevProperties();
    para.sqFsmSelBasAddr = static_cast<uint64_t>(props.fsmSelBase);
    if (props.starsResourceAddrCalculateMethod ==
        StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO) {
        const uint64_t chipAddr = dev->GetChipAddr();
        const uint64_t chipOffset = dev->GetChipOffset();
        const uint64_t dieOffset = dev->GetDieOffset();
        para.sqFsmSelBasAddr = para.sqFsmSelBasAddr +
            (chipOffset * static_cast<uint64_t>(dev->GetPhyChipId())) +
            (dieOffset * static_cast<uint64_t>(dev->GetPhyDieId())) + chipAddr;
    }
    if (props.starsBaseMethod == StarsBaseMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
        const uint64_t baseAddr = dev->GetStarsRegBaseAddr();
        if (baseAddr == 0ULL) {
            RT_LOG(RT_LOG_ERROR, "invalid baseAddr, device_id=%u.", dev->Id_());
            return RT_ERROR_DEVICE_INVALID;
        }
        para.sqFsmSelBasAddr = baseAddr + DAVID_SIMPLE_RTSQ_FSM_SEL_REG;
    }
    para.sqVirtualAddr = RtPtrToValue(dev->GetSqVirtualArrBaseAddr_());
    para.dfxAddr = RtPtrToValue(condTaskInfo->dfxPtr);
    para.sqHeadOffset = STARS_SIMPLE_SQ_HEAD_OFFSET;
    para.sqTailOffset = props.sqTailOffset;
    para.streamSvmPtrArrAddr = RtPtrToValue(condTaskInfo->streamSvmPtrArrSvmMem);
    const uint32_t taskPos = taskInfo->pos;
    const uint32_t sqDepth = stream->GetSqDepth();
    const uint32_t nextTaskPos = taskPos + taskInfo->sqeNum;
    para.sqHeadNext = nextTaskPos % sqDepth;

    ConstructCaptureCondTaskDeltaOffset(condTaskInfo->condHandle->GetCondType(), para);

    RT_LOG(RT_LOG_DEBUG, "devAddr=%#" PRIx64 ", sqIdMemAddr=%#" PRIx64 ", headSqArrPtrArrAddr=%#" PRIx64 ", "
        "modelSqCountArrAddr=%#" PRIx64 ", modelCount=%#" PRIx64 ", sqFsmSelBasAddr=%#" PRIx64 ", "
        "sqVirtualAddr=%#" PRIx64 ", dfxAddr=%#" PRIx64 ", sqHeadOffset=%u, sqTailOffset=%u, "
        "streamSvmPtrArrAddr=%#" PRIx64 ", deltaOffset=%#" PRIx64 ", sqHeadNext=%#" PRIx64 ".",
        para.devAddr, para.sqIdMemAddr, para.headSqArrPtrArrAddr, para.modelSqCountArrAddr,
        para.modelCount, para.sqFsmSelBasAddr, para.sqVirtualAddr, para.dfxAddr, para.sqHeadOffset,
        para.sqTailOffset, para.streamSvmPtrArrAddr, para.deltaOffset, para.sqHeadNext);

    return RT_ERROR_NONE;
}

rtError_t ReConstructCaptureConditionTaskFc(TaskInfo *taskInfo, CondHandle *condHandle)
{
    /* 先释放原先的内存，sq个数因为sk功能，可能会增、减 */
    (void)FreeFuncCallDevForCaptureCondTask(taskInfo);
    rtError_t ret = CondTaskFuncCallDevMemAlloc(taskInfo, condHandle);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", ret);

    Stream *stream = taskInfo->stream;
    Device *dev = stream->Device_();
    Driver *drv = dev->Driver_();

    std::vector<Model*> &subModels = condHandle->GetSubCaptureModels();
    const uint64_t modelCount = subModels.size();
    if (modelCount == 0U) {
        RT_LOG(RT_LOG_ERROR, "subCaptureModels is empty.");
        return RT_ERROR_INVALID_VALUE;
    }

    std::vector<uint64_t> headSqArrData;
    std::vector<uint64_t> modelSqCountArr;
    std::vector<uint64_t> streamSvmData;
    std::vector<uint64_t> headSqArrPtrArr;
    std::vector<uint64_t> streamSvmPtrArr;
    uint64_t totalSqCount = 0U;
    for (Model *subModel : subModels) {
        std::list<Stream*> headStreams = subModel->GetHeadStreamList_();
        const uint32_t sqCount = static_cast<uint32_t>(headStreams.size());
        modelSqCountArr.emplace_back(static_cast<uint64_t>(sqCount));

        for (Stream *stm : headStreams) {
            (void)headSqArrData.emplace_back(stm->GetSqId());
            (void)streamSvmData.emplace_back(RtPtrToValue(stm->GetExecutedTimesSvm()));
        }
        totalSqCount += sqCount;
    }

    const uint64_t totalModelSize = modelCount * sizeof(uint64_t);
    const uint64_t totalSqSize = totalSqCount * sizeof(uint64_t);

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    uint64_t sqDataAddr = RtPtrToValue(condTaskInfo->headSqArrDataSvmMem);
    uint64_t svmDataAddr = RtPtrToValue(condTaskInfo->streamSvmDataSvmMem);
    for (size_t i = 0U; i < modelCount; i++) {
        headSqArrPtrArr.emplace_back(sqDataAddr);
        sqDataAddr += modelSqCountArr[i] * sizeof(uint64_t);

        streamSvmPtrArr.emplace_back(svmDataAddr);
        svmDataAddr += modelSqCountArr[i] * sizeof(uint64_t);
    }

    condTaskInfo->funcCallHostMem = malloc(condTaskInfo->funCallMemSize);
    COND_RETURN_ERROR(condTaskInfo->funcCallHostMem == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc funcCallHostMem failed.");

    const rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    ret = drv->MemCopySync(condTaskInfo->headSqArrPtrArrSvmMem, totalModelSize, headSqArrPtrArr.data(), totalModelSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D ptrArr failed, retCode=%#x.", ret);

    ret = drv->MemCopySync(condTaskInfo->headSqArrDataSvmMem, totalSqSize, headSqArrData.data(), totalSqSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D sqData failed, retCode=%#x.", ret);

    ret = drv->MemCopySync(condTaskInfo->modelSqCountArrSvmMem, totalModelSize, modelSqCountArr.data(), totalModelSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D countArr failed, retCode=%#x.", ret);

    ret = drv->MemCopySync(condTaskInfo->streamSvmPtrArrSvmMem, totalModelSize, streamSvmPtrArr.data(), totalModelSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D svmPtrArr failed, retCode=%#x.", ret);

    ret = drv->MemCopySync(condTaskInfo->streamSvmDataSvmMem, totalSqSize, streamSvmData.data(), totalSqSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D svmData failed, retCode=%#x.", ret);

    rtStarsCaptureCondFcPara_t para = {};
    ret = ConstructCaptureCondTaskPara(taskInfo, condHandle, para);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "construct cond task para failed, device_id=%u, stream_id=%d, task_id=%u, condtype=%d, retCode=%#x.",
        dev->Id_(), stream->Id_(), taskInfo->id, condTaskInfo->condHandle->GetCondType(), ret);

    ret = ConstructCaptureCondTaskFc(condTaskInfo, para);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "construct cond task fc failed, device_id=%u, stream_id=%d, task_id=%u, condtype=%d, retCode=%#x.",
        dev->Id_(), stream->Id_(), taskInfo->id, condTaskInfo->condHandle->GetCondType(), ret);

    ret = drv->MemCopySync(condTaskInfo->funcCallSvmMem, condTaskInfo->funCallMemSize, condTaskInfo->funcCallHostMem, condTaskInfo->funCallMemSize, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "H2D funcCall failed, retCode=%#x.", ret);

    RT_LOG(RT_LOG_INFO, "ReConstructCaptureConditionTaskFc success, type=%d, modelCount=%" PRIu64 ".", condTaskInfo->condHandle->GetCondType(), modelCount);
    return RT_ERROR_NONE;
}

#endif

}  // namespace runtime
}  // namespace cce