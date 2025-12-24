/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stars_cond_isa_helper.hpp"
#include "task_manager.h"
#include "stream_sqcq_manage.hpp"
#include "stream_task.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtStreamCreate_drvDeviceGetBareTgid);

#if F_DESC("CreateStreamTask")
rtError_t CreateStreamTaskInit(TaskInfo * const taskInfo, const uint32_t flag)
{
    CreateStreamTaskInfo *createStreamTaskInfo = &(taskInfo->u.createStreamTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_CREATE_STREAM;
    taskInfo->typeName = "CREATE_STREAM";
    createStreamTaskInfo->streamAttr = flag;
    return RT_ERROR_NONE;
}

void ToCommandBodyForCreateStreamTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    uint32_t pid;
    uint8_t groupId;
    CreateStreamTaskInfo *createStreamTaskInfo = &(taskInfo->u.createStreamTaskInfo);
    Stream * const stream = taskInfo->stream;

    TIMESTAMP_BEGIN(rtStreamCreate_drvDeviceGetBareTgid);
    Driver * const dev = stream->Device_()->Driver_();
    (void)dev->DeviceGetBareTgid(&pid);
    TIMESTAMP_END(rtStreamCreate_drvDeviceGetBareTgid);
    command->u.creatStream.pid = pid;
    command->u.creatStream.vfId = 0U;
    command->u.creatStream.vStreamId = 0U;
    command->u.creatStream.runtimeVersion = RUNTIME_BUILD_VERSION;
    command->u.creatStream.supportLogToHost = stream->Device_()->GetTsLogToHostFlag();
    if (Runtime::Instance()->GetDisableThread()) {
        command->u.creatStream.shareLogicCqId = static_cast<uint16_t>(stream->Device_()->GetShareLogicCqId());
    } else {
        command->u.creatStream.shareLogicCqId = 0U;
    }

    command->u.creatStream.l2BaseVaddr = RtPtrToValue<void *>(stream->L2BaseVaddr());
    command->u.creatStream.asid = static_cast<uint16_t>((stream->Device_()->GetTTBR_()) >> 48U); // shift 48 bit
    command->u.creatStream.asid_baddr = static_cast<uint64_t>((stream->Device_()->GetTTBR_()) & (0x0000FFFFFFFFFFFFU));
    command->u.creatStream.SMMU_subStreamID = static_cast<uint16_t>(stream->Device_()->GetSSID_());
    command->u.creatStream.SQ_id = 0U;
    command->u.creatStream.priority = static_cast<uint8_t>(stream->GetPriority());
    command->u.creatStream.threadId = taskInfo->tid;
    command->u.creatStream.streamAttr = static_cast<uint8_t>(createStreamTaskInfo->streamAttr);
    command->u.creatStream.group_id = stream->GetGroupId();
    command->u.creatStream.deviceId = stream->Device_()->Id_();

    if (stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_THREAD_LOCAL)) {
        const uint8_t tmp = InnerThreadLocalContainer::GetGroupId();
        groupId = (tmp != UNINIT_GROUP_ID) ? tmp : stream->Device_()->GetGroupId();
    } else {
        groupId = stream->Device_()->GetGroupId();
    }

    command->u.creatStream.group_id = groupId;
    RT_LOG(RT_LOG_DEBUG,
        "bare tgid=%u, user pid=%d, l2BaseVaddr=%#" PRIx64 ", asid=%u, SMMU_subStreamID=%u,"
        " runtimeVersion=%u, thread_id=%u, group_id=%u, deviceId=%u,streamId:%d",
        pid,
        mmGetPid(),
        command->u.creatStream.l2BaseVaddr,
        static_cast<uint32_t>(command->u.creatStream.asid),
        static_cast<uint32_t>(command->u.creatStream.SMMU_subStreamID),
        static_cast<uint32_t>(command->u.creatStream.runtimeVersion),
        command->u.creatStream.threadId,
        static_cast<uint32_t>(command->u.creatStream.group_id),
        command->u.creatStream.deviceId,
        stream->Id_());
}

void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    Stream * const stream = taskInfo->stream;

    if ((stream->Flags() & RT_STREAM_PRIMARY_FIRST_DEFAULT) != 0U) {
        const uint32_t *const tsData = static_cast<const uint32_t *>(data);
        const uint32_t payLoad = *tsData;
        // for create stream task, payLoad(0~11 bit): error code, payLoad(12~31 bit): tsch build version
        const uint32_t tschVersion = static_cast<uint32_t>(payLoad >> 12U);
        Device *const devicePtr = stream->Device_();
        const Stream *const defaultStream = devicePtr->PrimaryStream_();
        COND_RETURN_VOID(defaultStream == nullptr, "default stream is NULL.");
        if (stream->Id_() == defaultStream->Id_()) {
            devicePtr->SetTschVersion(tschVersion);
        }
        RT_LOG(RT_LOG_DEBUG, "CreateStreamTask set result, payLoad=%u.", payLoad);
    }
}

#endif

#if F_DESC("SetSqLockUnlockTask")
rtError_t SqLockUnlockTaskInit(TaskInfo* taskInfo, const bool isLock)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = isLock ? "SQ_LOCK" : "SQ_UNLOCK";
    taskInfo->type = TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK;
    taskInfo->u.sqLockUnlockTask.sqLock = isLock ? 1U : 0U;
    taskInfo->u.sqLockUnlockTask.sqUnlock = isLock ? 0U : 1U;
    return RT_ERROR_NONE;
}

// Construct the sq lock or unlock sqe.
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 0U;
    sqe->post_p = 0U;
    sqe->l2_lock = taskInfo->u.sqLockUnlockTask.sqLock;
    sqe->l2_unlock = taskInfo->u.sqLockUnlockTask.sqUnlock;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    PrintSqe(command, "SetSqLockUnlock");
    RT_LOG(RT_LOG_INFO, "send SetSqLockUnlock succ,"
        "sqe_type=%u,pre_p=%u,stream_id=%u,task_id=%u,task_type=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type);

    return;
}
#endif

#if F_DESC("StreamActiveTask")
rtError_t AllocFuncCallMemForStreamActiveTask(TaskInfo* taskInfo)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    streamActiveTask->funCallMemSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    void *devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = streamActiveTask->funCallMemSize + TS_STARS_COND_DFX_SIZE + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "alloc func call memory failed,retCode=%#x,size=%" PRIu64 "(bytes),dev_id=%u",
                      ret, streamActiveTask->funCallMemSize, dev->Id_());
    streamActiveTask->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue<void *>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToValue<void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, uintptr_t>(devMemAlign);
    }
    streamActiveTask->funcCallSvmMem = devMem;
    streamActiveTask->dfxPtr = RtPtrToPtr<void *, uint64_t>(RtPtrToPtr<uint64_t, void *>(streamActiveTask->funcCallSvmMem) +
        streamActiveTask->funCallMemSize);

    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallMemForStreamActiveTask(TaskInfo * const taskInfo)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    if (streamActiveTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        const rtError_t ret = dev->Driver_()->DevMemFree(streamActiveTask->baseFuncCallSvmMem, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free func call svm mem free failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        streamActiveTask->baseFuncCallSvmMem = nullptr;
        streamActiveTask->funcCallSvmMem = nullptr;
        streamActiveTask->dfxPtr = nullptr;
    }

    streamActiveTask->funCallMemSize = 0UL;
    return RT_ERROR_NONE;
}

rtError_t InitFuncCallParaForStreamActiveTask(TaskInfo* taskInfo, rtStarsStreamActiveFcPara_t &fcPara,
    const rtChipType_t chipType)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    const uint32_t activeStreamSqId = streamActiveTask->activeStreamSqId;
    uint16_t * const execTimesSvm = streamActiveTask->activeStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue<uint16_t *>(execTimesSvm);
    fcPara.sqId = activeStreamSqId;
    fcPara.dfxAddr = RtPtrToValue<void *>(streamActiveTask->dfxPtr);

    RT_LOG(RT_LOG_INFO, "Active streamId=%u,active sqId=%u", streamActiveTask->activeStreamId, activeStreamSqId);
    const uint64_t sqVirtualAddr = streamActiveTask->activeStream->GetSqRegVirtualAddr();

    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    DevProperties props;
    auto error = GET_DEV_PROPERTIES(chipType, props);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "Failed to get properties");
    if (props.isSupportInitFuncCallPara) {
        fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr;
        fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr + sqVirtualAddr;
        fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr + sqVirtualAddr;
        fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr + sqVirtualAddr;

        if (props.rtsqFsmStateAddrCalMethod == RtsqFsmStateAddrCalMethod::FSM_ADDR_CALCULATE_BY_DEVICE_INFO) {
            int64_t chipId;
            int64_t dieId;
            const uint32_t deviceId = streamActiveTask->activeStream->Device_()->Id_();
            rtError_t error = driver->GetDevInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_CHIP_ID, &chipId);
            ERROR_RETURN_MSG_INNER(error, "Get chip failed!, device_id=%u", deviceId);
            error = driver->GetDevInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_DIE_ID, &dieId);
            ERROR_RETURN_MSG_INNER(error, "Get die id failed!, device_id=%u", deviceId);

            const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
            const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
            const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + (chipOffset *
                static_cast<uint64_t>(chipId)) + (dieOffset * static_cast<uint64_t>(dieId)) +
                chipAddr;

            RT_LOG(RT_LOG_DEBUG, "Get device info ok, deviceId=%u, chipId=%" PRId64 ", dieId=%" PRId64 "fsm=%llx",
            deviceId, chipId, dieId, fcPara.rtSqFsmStateAddr);
        }

        if (props.starsBaseAddrMethod == StarsBaseAddrMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
            const uint64_t baseAddr = taskInfo->stream->Device_()->GetStarsRegBaseAddr();
            if (baseAddr == 0ULL) {
                RT_LOG(RT_LOG_ERROR, "invalid device_id, physic chip_id=%u, die_id=%u, stream_id=%d.",
                    taskInfo->stream->Device_()->Id_(), taskInfo->stream->Device_()->GetPhyChipId(),
                    taskInfo->stream->Device_()->GetPhyDieId(), taskInfo->stream->Id_());
                return RT_ERROR_DEVICE_INVALID;
            }
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + baseAddr;
            RT_LOG(RT_LOG_INFO, "active stream_id=%u, rtSqFsmState=0x%llx", activeStreamSqId, fcPara.rtSqFsmStateAddr);
        }
        
        if (props.rtSqEnableAddrCalMethod == RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_BY_TRUE_SQID) {
            fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr +
                                    RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(activeStreamSqId);
            fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(activeStreamSqId);
            fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(activeStreamSqId);
        }
    } else {
        RT_LOG(RT_LOG_DEBUG, "current chipType[%d] not support init func call para", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t PrepareSqeInfoForStreamActiveTask(TaskInfo* taskInfo)
{
    RtStarsStreamActiveFc fc = {};
    rtStarsStreamActiveFcPara_t fcPara = {};
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);

    const rtChipType_t chipType = taskInfo->stream->Device_()->GetChipType();
    rtError_t ret = AllocFuncCallMemForStreamActiveTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);

    if ((streamActiveTask->activeStreamSqId == UINT32_MAX) && streamActiveTask->activeStream->IsSoftwareSqEnable()) {
        CaptureModel *captureMdl =
            dynamic_cast<CaptureModel *>(streamActiveTask->activeStream->Model_());
        if (captureMdl != nullptr) {
            (void)captureMdl->MarkStreamActiveTask(taskInfo);
        } else {
            RT_LOG(RT_LOG_ERROR, "CaptureModel is null, active stream_id=%u, stream_id=%d, task_id=%u.",
                streamActiveTask->activeStreamId, taskInfo->stream->Id_(), taskInfo->id);
            return RT_ERROR_MODEL_NULL;
        }
        return RT_ERROR_NONE;
    }

    ret = InitFuncCallParaForStreamActiveTask(taskInfo, fcPara, chipType);
    ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);

    ConstructStreamActiveFc(fc, fcPara, 0U);

    const rtMemcpyKind_t kind = (
        taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ? 
        RT_MEMCPY_DEVICE_TO_DEVICE : RT_MEMCPY_HOST_TO_DEVICE;
    ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(taskInfo->u.streamactiveTask.funcCallSvmMem,
        taskInfo->u.streamactiveTask.funCallMemSize, &fc, sizeof(RtStarsStreamActiveFc), kind);
    return ret;
}

rtError_t ReConstructStreamActiveTaskFc(TaskInfo* taskInfo)
{
    RtStarsStreamActiveFc fc = {};
    rtStarsStreamActiveFcPara_t fcPara = {};

    const rtChipType_t chipType = taskInfo->stream->Device_()->GetChipType();

    rtError_t ret = InitFuncCallParaForStreamActiveTask(taskInfo, fcPara, chipType);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "Init func call para failed,retCode=%#x.", ret);

    ConstructStreamActiveFc(fc, fcPara, 0U);

    const rtMemcpyKind_t kind = (
        taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ? 
        RT_MEMCPY_DEVICE_TO_DEVICE : RT_MEMCPY_HOST_TO_DEVICE;
    ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(taskInfo->u.streamactiveTask.funcCallSvmMem,
        taskInfo->u.streamactiveTask.funCallMemSize, &fc, sizeof(RtStarsStreamActiveFc), kind);
    return ret;
}

rtError_t StreamActiveTaskInit(TaskInfo* taskInfo, const Stream * const stm)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_ACTIVE;
    taskInfo->typeName = "STREAM_ACTIVE";
    streamActiveTask->activeStreamId = static_cast<uint32_t>(stm->Id_());
    streamActiveTask->activeStream = const_cast<Stream*>(stm);
    streamActiveTask->activeStreamSqId = 0U;
    streamActiveTask->funcCallSvmMem = nullptr;
    streamActiveTask->baseFuncCallSvmMem = nullptr;
    streamActiveTask->dfxPtr = nullptr;
    streamActiveTask->funCallMemSize = 0UL;

    const bool starsFlag = stream->Device_()->IsStarsPlatform();
    if (starsFlag) {
        streamActiveTask->activeStreamSqId = stm->GetSqId();
        return PrepareSqeInfoForStreamActiveTask(taskInfo);
    }

    return RT_ERROR_NONE;
}

void StreamActiveTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeFuncCallMemForStreamActiveTask(taskInfo);
}

void ToCommandBodyForStreamActiveTask(TaskInfo* taskInfo, rtCommand_t * const command)
{
    command->u.streamactiveTask.activeStreamId = static_cast<uint16_t>(taskInfo->u.streamactiveTask.activeStreamId);
}

void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_ACTIVE;

    const uint64_t funcAddr = RtPtrToValue<void *>(streamActiveTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "StreamActiveTask");
    RT_LOG(RT_LOG_INFO, "StreamActiveTask stream_id=%d,task_id=%hu,active_stream_id=%u.",
        stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

void PrintErrorInfoForStreamActiveTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(dfx, sizeof(dfx), taskInfo->u.streamactiveTask.dfxPtr,
            sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(RT_LOG_ERROR, "stream_id=%u,task_id=%u,active_sq_id=%u,sqid=%" PRIu64 ",fsm_state=%" PRIu64
            ",enable=%" PRIu64 ",head=%" PRIu64 ",tail=%" PRIu64, streamId, taskId,
            taskInfo->u.streamactiveTask.activeStreamSqId,
            dfx[0U] & 0xFFFU, dfx[0U] >> 32U, dfx[1U], dfx[2U] >> 48U, dfx[3U] >> 48U);
    }

    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_GE,
        "StreamActiveTask execute failed,device_id=%u,stream_id=%d,%s=%u",
        devId, streamId, TaskIdDesc(), taskId);
}

#endif

#if F_DESC("ActiveAicpuStreamTask")
rtError_t ActiveAicpuStreamTaskInit(TaskInfo* taskInfo, const uint64_t argsParam, const uint32_t argsSizeLen,
                                    const uint64_t func, const uint32_t kernelTypeId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "ACTIVE_AICPU_STREAM";
    taskInfo->type = TS_TASK_TYPE_ACTIVE_AICPU_STREAM;
    taskInfo->u.activeAicpuStreamTask.args = argsParam;
    taskInfo->u.activeAicpuStreamTask.funcName = func;
    taskInfo->u.activeAicpuStreamTask.kernelType = kernelTypeId;
    taskInfo->u.activeAicpuStreamTask.argsSize = argsSizeLen;
    RT_LOG(RT_LOG_DEBUG, "Create active aicpu stream task,task_id=%u,task_type=%d(%s),stream_id=%d",
        taskInfo->id, taskInfo->type, taskInfo->typeName, taskInfo->stream->Id_());
    return RT_ERROR_NONE;
}

void ToCmdBodyForActiveAicpuStreamTask(TaskInfo* const taskInfo, rtCommand_t *const command)
{
    command->u.kernelTask.priority = taskInfo->stream->Priority();
    command->u.kernelTask.L2_size = 0U;
    command->u.kernelTask.L2PreloadCtrl = 0UL;
    command->u.kernelTask.funcPtr = taskInfo->u.activeAicpuStreamTask.funcName;
    command->u.kernelTask.funcDesc = taskInfo->u.activeAicpuStreamTask.args;
    command->u.kernelTask.literalSrcAddr = 0UL;
    command->u.kernelTask.literalDstBase = taskInfo->u.activeAicpuStreamTask.kernelType;
    command->u.kernelTask.literalSize = taskInfo->u.activeAicpuStreamTask.argsSize;
    command->u.kernelTask.blockDim = 1U;
    command->u.kernelTask.l2PreloadVirAddr = MAX_UINT32_NUM >> 6U; // move right 6 bits
}

#endif

#if F_DESC("OverflowSwitchSetTask")

rtError_t OverflowSwitchSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t flags)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "OVERFLOW_SWTICH_SET";
    taskInfo->type = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    taskInfo->u.overflowSwitchSetTask.targetStm = stm;
    taskInfo->u.overflowSwitchSetTask.switchFlag = (flags == 0U) ? false :true;
    return RT_ERROR_NONE;
}

void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe * const sqe = &(command->phSqe);
    OverflowSwitchSetTaskInfo *overflowSwiSet = &taskInfo->u.overflowSwitchSetTask;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_overflow_switch_info.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    sqe->u.stream_overflow_switch_info.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintSqe(command, "OverflowSwitchSetTask");
    const std::string switchFlag = overflowSwiSet->switchFlag ? "on" : "off";
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask target stream_id=%d switch %s",
        overflowSwiSet->targetStm->Id_(), switchFlag.c_str());
}
#endif

#if F_DESC("StreamTagSetTask")
rtError_t StreamTagSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t geOpTag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "STREAM_TAG_SET";
    taskInfo->type = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;

    taskInfo->u.stmTagSetTask.targetStm = stm;
    taskInfo->u.stmTagSetTask.geOpTag = geOpTag;
    return RT_ERROR_NONE;
}

void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    StreamTagSetTaskInfo *stmTagSetTsk = &taskInfo->u.stmTagSetTask;

    RtStarsPhSqe * const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_set_tag_info.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    sqe->u.stream_set_tag_info.geOpTag = stmTagSetTsk->geOpTag;

    PrintSqe(command, "StreamTagSetTask");
    RT_LOG(RT_LOG_INFO, "StreamTagSetTask target stream id=%d, sqe stream id =%hu, geOpTag=%u",
        stmTagSetTsk->targetStm->Id_(), sqe->rt_streamID, stmTagSetTsk->geOpTag);
}
#endif

#if F_DESC("SetStreamModeTask")
rtError_t SetStreamModeTaskInit(TaskInfo *taskInfo, const uint64_t mode)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "SET_STREAM_MODE";
    taskInfo->type = TS_TASK_TYPE_SET_STREAM_MODE;
    taskInfo->u.setStmModeTask.mode = mode;
    return RT_ERROR_NONE;
}

void ToCmdBodyForSetStreamModeTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.setStreamModeTask.mode = taskInfo->u.setStmModeTask.mode;
}

#endif

}  // namespace runtime
}  // namespace cce