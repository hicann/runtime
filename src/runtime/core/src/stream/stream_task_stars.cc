/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_task_c.hpp"

#include <cinttypes>

#include "cmo_task.h"
#include "common_task.h"
#include "ctrl_sq.hpp"
#include "device.hpp"
#include "enum_desc.hpp"
#include "inner_thread_local.hpp"
#include "maintenance_task.h"
#include "runtime_dump_task.h"
#include "stream.hpp"
#include "stream_task.h"
#include "task.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
namespace {

void InitStarsSdmaCmoSqe(rtStarsSdmaSqe_t* const sdmaCmoSqe, const Stream* const stm, const rtCmoOpCode_t cmoOpCode)
{
    sdmaCmoSqe->opcode = static_cast<uint8_t>(cmoOpCode);
    sdmaCmoSqe->qos = 6U;
    sdmaCmoSqe->partid = 63U;
    sdmaCmoSqe->sssv = 1U;
    sdmaCmoSqe->dssv = 1U;
    sdmaCmoSqe->sns = 1U;
    sdmaCmoSqe->dns = 1U;
    sdmaCmoSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaCmoSqe->dst_streamid = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaCmoSqe->src_sub_streamid = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaCmoSqe->dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
}

} // namespace

rtError_t StreamNopTask(Stream* const stm)
{
    Device* const device = stm->Device_();
    TaskInfo taskSubmit = {};
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* rtNopTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_NOP, errorReason);
    NULL_PTR_RETURN(rtNopTask, errorReason);

    rtError_t error = NopTaskInit(rtNopTask);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init NopTask, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtNopTask->id, error);

    error = device->SubmitTask(rtNopTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NopTask, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(rtNopTask, stm->AllocTaskStreamId());

    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtNopTask);
    return error;
}

rtError_t StreamCmoAddrTaskLaunch(
    void* const cmoAddrInfo, const uint64_t destMax, const rtCmoOpCode_t cmoOpCode, Stream* const stm,
    const uint32_t flag)
{
    UNUSED(destMax);
    UNUSED(flag);
    rtError_t error;
    const int32_t streamId = stm->Id_();
    Device* const device = stm->Device_();
    rtCmoAddrInfo* const starsCmoAddrInfo = static_cast<rtCmoAddrInfo*>(cmoAddrInfo);
    if (stm->Model_() == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "CMO Addr task stream is not in model. device_id=%d, stream_id=%d.",
            static_cast<int32_t>(stm->Device_()->Id_()), streamId);
        return RT_ERROR_MODEL_NULL;
    }
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* cmoAddrTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_CMO, errorReason);
    NULL_PTR_RETURN_MSG(cmoAddrTask, errorReason);

    rtStarsSdmaSqe_t sdmaCmoSqe = {};
    InitStarsSdmaCmoSqe(&sdmaCmoSqe, stm, cmoOpCode);
    RT_LOG(
        RT_LOG_DEBUG, "cmoAddrInfo=0x%llx, cmoOpCode=%s, device_id=%u, stream_id=%d",
        RtPtrToValue<rtCmoAddrInfo*>(starsCmoAddrInfo), CmoOpCodeToString(cmoOpCode).c_str(), device->Id_(), streamId);

    Driver* const devDrv = device->Driver_();
    if (devDrv != nullptr) {
        constexpr uint64_t dstMax = 8ULL;
        error = devDrv->MemCopySync(starsCmoAddrInfo, dstMax, &sdmaCmoSqe, dstMax, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_GOTO(
            error, ERROR_RECYCLE,
            "Failed to memcpy from host to dev, device_id=%u, size=%" PRIu64 "(bytes), retCode=%#x.", device->Id_(),
            dstMax, error);

        if (devDrv->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = device->Driver_()->DevMemFlushCache(RtPtrToValue<rtCmoAddrInfo*>(starsCmoAddrInfo), dstMax);
            ERROR_GOTO(
                error, ERROR_RECYCLE, "Failed to flush stream info, device_id=%u, retCode=%#x.", device->Id_(), error);
        }
    }

    (void)CmoAddrTaskInit(cmoAddrTask, starsCmoAddrInfo, cmoOpCode);

    error = device->SubmitTask(cmoAddrTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit CMO task, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(cmoAddrTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(cmoAddrTask);
    return error;
}

rtError_t StreamNpuGetFloatStatus(
    void* const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode, Stream* const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    Device* const device = stm->Device_();
    RT_LOG(RT_LOG_INFO, "Begin to create NpuGetFloatStatus task.");

    TaskInfo submitTask = {};
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;

    TaskInfo* rtNpuGetFloatStatusTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, errorReason);
    NULL_PTR_RETURN(rtNpuGetFloatStatusTask, errorReason);

    (void)NpuGetFloatStaTaskInit(rtNpuGetFloatStatusTask, outputAddrPtr, outputSize, checkMode, isDebug);

    error = device->SubmitTask(rtNpuGetFloatStatusTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NPUGetFloatStatus task, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(rtNpuGetFloatStatusTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtNpuGetFloatStatusTask);
    return error;
}

rtError_t StreamNpuClearFloatStatus(const uint32_t checkMode, Stream* const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    Device* const device = stm->Device_();
    RT_LOG(RT_LOG_INFO, "Begin to create NpuClearFloatStatus task.");

    TaskInfo submitTask = {};
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;

    TaskInfo* rtNpuClearFloatStatusTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, errorReason);
    NULL_PTR_RETURN(rtNpuClearFloatStatusTask, errorReason);

    (void)NpuClrFloatStaTaskInit(rtNpuClearFloatStatusTask, checkMode, isDebug);

    RT_LOG(RT_LOG_INFO, "Begin to submit NpuClearFloatStatus task.");
    error = device->SubmitTask(rtNpuClearFloatStatusTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NPUClearFloatStatus task, retCode=%#x.", error);

    RT_LOG(RT_LOG_INFO, "NpuClearFloatStatus task submitted.");

    GET_THREAD_TASKID_AND_STREAMID(rtNpuClearFloatStatusTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtNpuClearFloatStatusTask);
    return error;
}

rtError_t StreamSetOverflowSwitch(Stream* const stm, const uint32_t flags, Stream* const defaultStm)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo* tsk = nullptr;
    Device* const device = stm->Device_();
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        uint32_t flipTaskId = 0;
        RtOverflowSwitchSetParam param = {stm, flags};
        error = device->GetCtrlSQ().SendOverflowSwitchSetMsg(
            RtCtrlMsgType::RT_CTRL_MSG_SET_OVERFLOW_SWITCH, param, &flipTaskId);
        ERROR_RETURN(error, "Failed to send overflow switch set message, retCode=%#x.", error);
        SET_THREAD_TASKID_AND_STREAMID(device->GetCtrlSQStream(defaultStm)->Id_(), flipTaskId);
    } else {
        NULL_PTR_RETURN_MSG(defaultStm, RT_ERROR_STREAM_NULL);
        TaskInfo submitTask = {};
        rtError_t errorReason = RT_ERROR_TASK_NEW;
        tsk = defaultStm->AllocTask(&submitTask, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, errorReason);
        NULL_PTR_RETURN(tsk, errorReason);

        (void)OverflowSwitchSetTaskInit(tsk, stm, flags);
        error = device->SubmitTask(tsk);
        ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit OverflowSwitchSetTask, retCode=%#x.", error);
        GET_THREAD_TASKID_AND_STREAMID(tsk, defaultStm->Id_());
    }

    stm->SetOverflowSwitch(flags != 0U);
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask submitted.");
    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t StreamDatadumpInfoLoad(
    const void* const dumpInfo, const uint32_t length, const uint32_t flag, Stream* const dftStm)
{
    rtError_t error;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    Device* const device = dftStm->Device_();
    const int32_t streamId = dftStm->Id_();
    const tsAicpuKernelType kernelType =
        ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ? TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;

    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDataDumpLoadInfoParam param = {dumpInfo, length, static_cast<uint16_t>(kernelType)};
        return device->GetCtrlSQ().SendDataDumpLoadInfoMsg(RtCtrlMsgType::RT_CTRL_MSG_DATADUMP_INFOLOAD, param);
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtDumpLoadInfoTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DATADUMP_LOADINFO, errorReason);
    NULL_PTR_RETURN_MSG(rtDumpLoadInfoTask, errorReason);

    error = DataDumpLoadInfoTaskInit(rtDumpLoadInfoTask, dumpInfo, length, static_cast<uint16_t>(kernelType));
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE,
        "Failed to init data dump info load task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.", streamId,
        rtDumpLoadInfoTask->id, error);

    error = device->SubmitTask(rtDumpLoadInfoTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit data dump info load task, retCode=%#x.", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize data dump info load task, retCode=%#x.", error);

    return error;

ERROR_RECYCLE:
    dftStm->SetErrCode(0U);
    (void)device->GetTaskFactory()->Recycle(rtDumpLoadInfoTask);
    return error;
}

rtError_t StreamAicpuInfoLoad(
    Stream* const dftStm, const void* const aicpuInfo, const uint32_t length, Device* const device)
{
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtAicpuInfoLoadParam param = {aicpuInfo, length};
        return device->GetCtrlSQ().SendAicpuInfoLoadMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_INFOLOAD, param);
    }
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtAicpuLoadInfoTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_AICPU_INFO_LOAD, errorReason);
    NULL_PTR_RETURN_MSG(rtAicpuLoadInfoTask, errorReason);

    const int32_t streamId = dftStm->Id_();
    rtError_t error = AicpuInfoLoadTaskInit(rtAicpuLoadInfoTask, aicpuInfo, length);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init AI CPU info load task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
        streamId, rtAicpuLoadInfoTask->id, error);

    error = device->SubmitTask(rtAicpuLoadInfoTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AI CPU info load task, retCode=%#x.", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize AI CPU info load task, retCode=%#x.", error);

    return error;

ERROR_RECYCLE:
    dftStm->SetErrCode(0U);
    (void)device->GetTaskFactory()->Recycle(rtAicpuLoadInfoTask);
    return error;
}

rtError_t StreamDebugRegister(
    Stream* const debugStream, const uint32_t flag, const void* const addr, uint32_t* const streamId,
    uint32_t* const taskId, Stream* const defaultStm)
{
    rtError_t error;
    Device* const device = debugStream->Device_();
    Stream* setStm = nullptr;
    if (device->IsStarsPlatform() == true) {
        setStm = debugStream;
    } else {
        setStm = defaultStm;
    }
    NULL_PTR_RETURN_MSG(setStm, RT_ERROR_STREAM_NULL);
    *streamId = static_cast<uint32_t>(setStm->Id_());

    COND_RETURN_WARN(
        debugStream->IsDebugRegister(), RT_ERROR_DEBUG_REGISTER_FAILED, "stream already debug registered!");

    RT_LOG(RT_LOG_INFO, "send task stream_id=%d, debug_stream_id=%d.", setStm->Id_(), debugStream->Id_());

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtDbgRegStreamTask = setStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, errorReason);
    NULL_PTR_RETURN_MSG(rtDbgRegStreamTask, errorReason);

    *taskId = static_cast<uint32_t>(rtDbgRegStreamTask->id);
    error = DebugRegisterForStreamTaskInit(rtDbgRegStreamTask, static_cast<uint32_t>(debugStream->Id_()), addr, flag);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE,
        "Failed to init debug register for stream task, stream_id=%d, debug_stream_id=%d, task_id=%" PRIu16
        ", retCode=%#x.",
        *streamId, debugStream->Id_(), rtDbgRegStreamTask->id, error);

    error = device->SubmitTask(rtDbgRegStreamTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit debug register for stream task, retCode=%#x.", error);

    *taskId = GetFlipTaskId(rtDbgRegStreamTask->id, rtDbgRegStreamTask->flipNum);

    if (device->IsStarsPlatform() != true) {
        error = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize debug register for stream task, retCode=%#x.", error);
    }
    debugStream->SetDebugRegister(true);
    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtDbgRegStreamTask);
    return RT_ERROR_DEBUG_REGISTER_FAILED;
}

rtError_t StreamDebugUnRegister(Stream* const debugStream, Stream* const defaultStm)
{
    rtError_t error;
    Device* const device = debugStream->Device_();
    Stream* setStm = nullptr;
    if (device->IsStarsPlatform() == true) {
        setStm = debugStream;
    } else {
        setStm = defaultStm;
    }
    NULL_PTR_RETURN_MSG(setStm, RT_ERROR_STREAM_NULL);

    COND_RETURN_WARN(
        !debugStream->IsDebugRegister(), RT_ERROR_DEBUG_UNREGISTER_FAILED, "stream is not debug registered!");

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtDbgUnregStreamTask =
        setStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, errorReason);
    NULL_PTR_RETURN_MSG(rtDbgUnregStreamTask, errorReason);

    (void)DebugUnRegisterForStreamTaskInit(rtDbgUnregStreamTask, debugStream->Id_());

    error = device->SubmitTask(rtDbgUnregStreamTask);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to submit debug unregister for stream task, retCode=%#x.", error);

    if (device->IsStarsPlatform() != true) {
        error = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize debug unregister for stream task, retCode=%#x.", error);
    }
    debugStream->SetDebugRegister(false);

    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtDbgUnregStreamTask);
    return RT_ERROR_DEBUG_UNREGISTER_FAILED;
}

} // namespace runtime
} // namespace cce
