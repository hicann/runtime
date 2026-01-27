/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "model_c.hpp"
#include "notify_c.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "task_david.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stream_david.hpp"
#include "stream_c.hpp"

namespace cce {
namespace runtime {

rtError_t ModelDebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId, Stream * const dftStm)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    *streamId = static_cast<uint32_t>(dftStm->Id_());

    COND_RETURN_WARN(mdl->IsDebugRegister(),
        RT_ERROR_DEBUG_REGISTER_FAILED, "model repeat debug register!");

    TaskInfo *rtDbgRegTask = nullptr;
    error = CheckTaskCanSend(dftStm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        dftStm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    dftStm->StreamLock();
    error = AllocTaskInfo(&rtDbgRegTask, dftStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, dftStm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        dftStm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDbgRegTask, dftStm, pos);
    (void)DebugRegisterTaskInit(rtDbgRegTask, mdl->Id_(), addr, flag);
    error = DavidSendTask(rtDbgRegTask, dftStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(rtDbgRegTask);
                                       TaskRollBack(dftStm, pos);
                                       dftStm->StreamUnLock();,
                                       "Failed to submit DebugRegisterTask, stream_id=%d, retCode=%#x",
                                       dftStm->Id_(), static_cast<uint32_t>(error));
    dftStm->StreamUnLock();
    *taskId = rtDbgRegTask->taskSn;
    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DebugRegisterTask, retCode=%#x.",
        static_cast<uint32_t>(error));

    mdl->SetDebugRegister(true);
    return error;
}

rtError_t ModelDebugUnRegister(Model * const mdl, Stream * const dftStm)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    COND_RETURN_WARN(!mdl->IsDebugRegister(),
        RT_ERROR_DEBUG_UNREGISTER_FAILED, "model is not debug register!");

    TaskInfo *rtDbgUnregTask = nullptr;
    error = CheckTaskCanSend(dftStm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.", dftStm->Id_(),
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    dftStm->StreamLock();
    error = AllocTaskInfo(&rtDbgUnregTask, dftStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, dftStm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        dftStm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDbgUnregTask, dftStm, pos);
    (void)DebugUnRegisterTaskInit(rtDbgUnregTask, mdl->Id_());
    error = DavidSendTask(rtDbgUnregTask, dftStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(rtDbgUnregTask);
                                       TaskRollBack(dftStm, pos);
                                       dftStm->StreamUnLock();,
                                       "Failed to submit DebugUnRegisterTask, stream_id=%d, retCode=%#x",
                                       dftStm->Id_(), static_cast<uint32_t>(error));
    dftStm->StreamUnLock();
    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DebugUnRegisterTask, retCode=%#x.",
        static_cast<uint32_t>(error));

    mdl->SetDebugRegister(false);
    return error;
}

rtError_t MdlTaskUpdate(const Stream * const desStm, uint32_t desTaskId, Stream *sinkStm,
    rtMdlTaskUpdateInfo_t *para)
{
    void *devCopyMem = nullptr;
    uint32_t tilingTabLen = 0;
    Device *dev = sinkStm->Device_();
    Context * const curCtx = desStm->Context_();
    rtError_t error = curCtx->CopyTilingTabToDev(static_cast<Program *>(para->hdl),
        dev, &devCopyMem, &tilingTabLen);
    ERROR_RETURN_MSG_INNER(error, "BuildTilingTbl fail, error=%#x.", static_cast<uint32_t>(error));

    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    error = CheckTaskCanSend(sinkStm);
    ERROR_PROC_RETURN_MSG_INNER(error, (void)dev->Driver_()->DevMemFree(devCopyMem, sinkStm->Device_()->Id_());,
        "stream_id=%d check fail, retCode=%#x.", sinkStm->Id_(), static_cast<uint32_t>(error));
    sinkStm->StreamLock();
    error = AllocTaskInfo(&tsk, sinkStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                sinkStm->StreamUnLock();
                                (void)dev->Driver_()->DevMemFree(devCopyMem, sinkStm->Device_()->Id_());,
                                "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                sinkStm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, sinkStm, pos);
    (void)ModelTaskUpdateInit(tsk, static_cast<uint16_t>(desStm->Id_()), desTaskId,
                              static_cast<uint16_t>(sinkStm->Id_()), devCopyMem, tilingTabLen, para);
    error = DavidSendTask(tsk, sinkStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(tsk);
                                TaskRollBack(sinkStm, pos);
                                sinkStm->StreamUnLock();
                                (void)dev->Driver_()->DevMemFree(devCopyMem, dev->Id_());,
                                "Failed to submit model update task, error=%#x.", static_cast<uint32_t>(error));
    sinkStm->StreamUnLock();
    sinkStm->PushbackTilingTblAddr(devCopyMem);
    RT_LOG(RT_LOG_INFO, "device_id=%u, devCopyMem=%p, stream_id=%d pos=%u.",
        dev->Id_(), devCopyMem, sinkStm->Id_(),pos);
    return RT_ERROR_NONE;
}

rtError_t MdlAbort(Model * const mdl)
{
    rtError_t error;
    Stream *streamObj = nullptr;
    Context * const context = mdl->Context_();

    // stars model abort to ts
    TaskInfo submitTask = {};
    TaskInfo *executeTask = nullptr;
    if (mdl->ModelExecuteType() != EXECUTOR_AICPU) {
        RT_LOG(RT_LOG_DEBUG, "Submit abort task to ts");
        streamObj = context->DefaultStream_();
        error = streamObj->ModelAbortById(mdl->Id_());
        COND_RETURN_ERROR((error == RT_ERROR_TSFW_TASK_ABORT_STOP), error,
            "Model abort stop before post process, model_id=%u.", mdl->Id_());

        // if last Synchronize timeout, need Synchronize here
        auto * const exeStm = mdl->GetExeStream();
        if ((exeStm != nullptr) && exeStm->GetNeedSyncFlag()) {
            const rtError_t ret = exeStm->Synchronize(false, 100); // 100 wait 100ms
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_DEBUG, "In model abort, Synchronize return is %d.", ret);
            }
            exeStm->SetNeedSyncFlag(false);
        }
        return RT_ERROR_NONE;
    }

    error = context->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &streamObj);
    ERROR_RETURN_MSG_INNER(error, "Abort model, fail to create stream, retCode=%#x!", static_cast<uint32_t>(error));
    std::function<void()> const stmDestroy = [&context, &streamObj]() {
        (void)context->StreamDestroy(streamObj);
    };
    ScopeGuard streamGuard(stmDestroy);
    executeTask = nullptr;
    error = CheckTaskCanSend(streamObj);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamObj->Id_(),
        static_cast<uint32_t>(error));
    const uint32_t executorFlag = mdl->GetModelExecutorType();
    uint32_t pos = 0xFFFFU;
    streamObj->StreamLock();
    error = AllocTaskInfo(&executeTask, streamObj, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, streamObj->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamObj->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(executeTask, streamObj, pos);
    (void)ModelToAicpuTaskInit(executeTask, mdl->Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_ABORT), executorFlag,
        RtPtrToValue(mdl->GetAicpuModelInfo()));
    error = DavidSendTask(executeTask, streamObj);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(executeTask);
                                TaskRollBack(streamObj, pos);
                                streamObj->StreamUnLock();,
                                "Failed to submit model abort task, error=%#x.", static_cast<uint32_t>(error));
    streamObj->StreamUnLock();
    RT_LOG(RT_LOG_DEBUG, "Submit task to ts, model_id=%u, executor_flag=%u, stream_id=%d.",
        mdl->Id_(), executorFlag, streamObj->Id_());
    error = streamObj->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize model abort stream, retCode=%#x.",
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t AicpuMdlDestroy(Model * const mdl)
{
    Context * const context = mdl->Context_();
    Stream * const defaultStream = context->DefaultStream_();

    TaskInfo *toAicpuTask = nullptr;
    const uint32_t executorFlag = mdl->GetModelExecutorType();
    rtError_t error = CheckTaskCanSend(defaultStream);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", defaultStream->Id_(),
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    defaultStream->StreamLock();
    error = AllocTaskInfo(&toAicpuTask, defaultStream, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, defaultStream->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        defaultStream->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(toAicpuTask, defaultStream, pos);
    (void)ModelToAicpuTaskInit(toAicpuTask, mdl->Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_ABORT), executorFlag,
        RtPtrToValue(mdl->GetAicpuModelInfo()));
    error = DavidSendTask(toAicpuTask, defaultStream);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(toAicpuTask);
                                TaskRollBack(defaultStream, pos);
                                defaultStream->StreamUnLock();,
                                "Failed to submit ModelToAicpuTask task, model_id=%u, error=%#x.",
                                mdl->Id_(), static_cast<uint32_t>(error));
    defaultStream->StreamUnLock();
    error = defaultStream->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Fail to synchronize stream, model_id=%u, stream_id=%d, retCode=%#x!", mdl->Id_(),
        defaultStream->Id_(), static_cast<uint32_t>(error));
    return error;
}

static rtError_t AsyncJettyToHead(const Model * const mdl, Stream * const stm)
{
    if (mdl->GetFirstExecute()) {
        return RT_ERROR_NONE;
    }

    if ((mdl->GetH2dJettyInfo().empty()) && ( mdl->GetD2dJettyInfo().empty())) {
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "ub model includes async copy task, h2d_list_size=%d, d2d_list_size=%d.",
        mdl->GetH2dJettyInfo().size(), mdl->GetD2dJettyInfo().size());

    rtError_t error = RT_ERROR_NONE;
    rtUbDbInfo_t dbInfo;
    dbInfo.wrCqe = 0U;
    dbInfo.dbNum = UB_DOORBELL_NUM_MIN;

    for (auto &info : mdl->GetH2dJettyInfo()) {
        dbInfo.info[0].dieId = info.dieId;
        dbInfo.info[0].jettyId = info.jettyId;
        dbInfo.info[0].functionId = info.functionId;
        dbInfo.info[0].piValue = info.piValue;
        error = StreamUbDbSend(&dbInfo, stm);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "send h2d ub doorbell failed, stream_id=%d, model_sq_id=%u, error=%d.", stm->Id_(), info.sqId, error);
    }

    for (auto &info : mdl->GetD2dJettyInfo()) {
        dbInfo.info[0].dieId = info.dieId;
        dbInfo.info[0].jettyId = info.jettyId;
        dbInfo.info[0].functionId = info.functionId;
        dbInfo.info[0].piValue = info.piValue;
        error = StreamUbDbSend(&dbInfo, stm);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "send d2d ub doorbell failed, stream_id=%d, model_sq_id=%u, error=%d.", stm->Id_(), info.sqId, error);
    }

    return RT_ERROR_NONE;
}

rtError_t ModelSubmitExecuteTask(Model * const mdl, Stream * const streamIn)
{
    /* UB互连场景下如果模型中下过H2D/D2H/跨片D2D，需要先下UB DB任务 */
    rtError_t error = AsyncJettyToHead(mdl, streamIn);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ub doorbell send failed, stream_id=%d, model_id=%u", streamIn->Id_(), mdl->Id_());

    // private func, the caller guarantees that the pointer is not nullptr
    const uint32_t executeType = mdl->ModelExecuteType();
    const uint32_t executorFlag = mdl->GetModelExecutorType();
    RT_LOG(RT_LOG_DEBUG, "execute stream, model execute type=%u, model_id=%u, stream_id=%d.",
           executeType, mdl->Id_(), streamIn->Id_());
    COND_RETURN_ERROR_MSG_INNER((executeType > EXECUTOR_AICPU), RT_ERROR_MODEL_EXECUTOR,
            "Unsupported executor type=%u, modelId=%u.", executeType, mdl->Id_());

    TaskInfo *exeTask = nullptr;
    error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    streamIn->StreamLock();
    error = AllocTaskInfo(&exeTask, streamIn, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(exeTask, streamIn, pos);
    if (executeType == EXECUTOR_AICPU) {
        error = ModelToAicpuTaskInit(exeTask, mdl->Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_EXECUTE),
            executorFlag, RtPtrToValue(mdl->GetAicpuModelInfo()));
    } else if (executeType == EXECUTOR_TS) {
        error = ModelExecuteTaskInit(exeTask, mdl, mdl->Id_(), mdl->GetFirstTaskId());
    } else {
        // no need to do
    }
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "exeTask init failed, retCode=%#x.", static_cast<uint32_t>(error));
        TaskUnInitProc(exeTask);
        TaskRollBack(streamIn, pos);
        streamIn->StreamUnLock();
        return RT_ERROR_MODEL_EXECUTOR;
    }
    exeTask->stmArgPos = static_cast<DavidStream *>(streamIn)->GetArgPos();
    error = DavidSendTask(exeTask, streamIn);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(exeTask);
                                TaskRollBack(streamIn, pos);
                                streamIn->StreamUnLock();,
                                "Model execute failed, model_id=%u!", mdl->Id_());
    streamIn->StreamUnLock();
    error = SubmitTaskPostProc(streamIn, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t GetAndSaveD2dJettyInfo(Model * const mdl, uint32_t sqId, uint32_t deviceId, uint32_t tsId)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_D2D_ASYNC_JETTY_INFO;

    COND_RETURN_ERROR(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");
    const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    /* D2D Jetty队列在首次下发任务时才创建，如果没下发过，返回未初始化 */
    if (drvRet == DRV_ERROR_UNINIT) {
        return RT_ERROR_NONE;
    }
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "[drv api] halSqCqQuery d2d jetty info failed, device_id=%u, sq_id=%u, drv_ret=%d.",
            deviceId, sqId, drvRet);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    if (queryInfoIn.value[0] != 0U) {
        UbAsyncJettyInfo info = {};
        info.jettyId = queryInfoIn.value[1];
        info.dieId = queryInfoIn.value[3];
        info.functionId = queryInfoIn.value[2];
        info.piValue = queryInfoIn.value[0];
        info.sqId = sqId;
        mdl->SetD2dJettyInfo(info);
    }

    return RT_ERROR_NONE;
}

static rtError_t GetAndSaveH2dJettyInfo(Model * const mdl, uint32_t sqId, uint32_t deviceId, uint32_t tsId)
{
    struct halSqCqQueryInfo queryInfoIn = {};
    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = tsId;
    queryInfoIn.sqId = sqId;
    queryInfoIn.cqId = 0U;
    queryInfoIn.prop = DRV_SQCQ_PROP_H2D_ASYNC_JETTY_INFO;

    COND_RETURN_ERROR(&halSqCqQuery == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halSqCqQuery does not exist.");
    const drvError_t drvRet = halSqCqQuery(deviceId, &queryInfoIn);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "[drv api] halSqCqQuery h2d jetty info failed, device_id=%u, sq_id=%u, drv_ret=%d.",
            deviceId, sqId, drvRet);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    constexpr uint32_t jettyDepth = 2048U;
    if ((queryInfoIn.value[0] != jettyDepth) && (queryInfoIn.value[0] != 0U)) {
        UbAsyncJettyInfo info = {};
        info.jettyId = queryInfoIn.value[1];
        info.dieId = queryInfoIn.value[3];
        info.functionId = queryInfoIn.value[2];
        info.piValue = queryInfoIn.value[0];
        info.sqId = sqId;
        mdl->SetH2dJettyInfo(info);
    }

    return RT_ERROR_NONE;
}

static void GetAndSaveJettyInfo(Model * const mdl)
{
    if (mdl->GetProcJettyInfoFlag()) {
        return;
    }

    mdl->SetProcJettyInfoFlag(true);

    rtError_t error = RT_ERROR_NONE;
    if (mdl->GetUbModelH2dFlag()) {
        RT_LOG(RT_LOG_INFO, "ub model includes async h2d copy task.");
        for (Stream * const sinkStream : mdl->StreamList_()) {
            error = GetAndSaveH2dJettyInfo(mdl, sinkStream->GetSqId(), sinkStream->Device_()->Id_(),
                sinkStream->Device_()->DevGetTsId());
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "GetH2DJettyInfo failed, device_id=%d, sq_id=%u, error=%d.",
                    sinkStream->Device_()->Id_(), sinkStream->GetSqId(), error);
            }
        }
    }

    if (mdl->GetUbModelD2dFlag()) {
        RT_LOG(RT_LOG_INFO, "ub model includes async d2d copy task.");
        for (Stream * const sinkStream : mdl->StreamList_()) {
            error = GetAndSaveD2dJettyInfo(mdl, sinkStream->GetSqId(), sinkStream->Device_()->Id_(),
                sinkStream->Device_()->DevGetTsId());
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "GetD2DJettyInfo failed, device_id=%d, sq_id=%u, error=%d.",
                    sinkStream->Device_()->Id_(), sinkStream->GetSqId(), error);
            }
        }
    }
    return;
}

rtError_t ModelLoadCompleteByStream(Model * const mdl)
{
    Stream *stream = nullptr;
    std::function<void()> const stmDestroy = [&mdl, &stream]() {
        if (mdl->NeedLoadAicpuModelTask() && (stream != nullptr)) {
            (void)mdl->Context_()->StreamDestroy(stream);
        }
    };
    ScopeGuard streamGuard(stmDestroy);
    rtError_t error = mdl->LoadCompleteByStreamPrep(stream);
    ERROR_RETURN_MSG_INNER(error, "LoadCompleteByStreamPrep failed, retCode=%#x!", static_cast<uint32_t>(error));

    /* Mini should notify TS model load success for benchmarks,
    and decoupling model load with NPU power for lite */
    TaskInfo *aicpuTask = nullptr;
    TaskInfo *maintainceTask = nullptr;
    bool isNeedStreamReuse = false;
    const bool isContextContainAicpuModel = mdl->Context_()->GetAicpuExecuteModel();
    const bool isNeedLoadAicpuModel = mdl->NeedLoadAicpuModelTask();
    const uint32_t executorFlag = mdl->GetModelExecutorType();
    uint32_t pos = 0xFFFFU;
    // per sink stream load complete for mini/cloud
    for (Stream * const sinkStream : mdl->StreamList_()) {
        if (((sinkStream->Flags() & RT_STREAM_AICPU) == 0) && (sinkStream->isModelComplete == false)) {
            sinkStream->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
            if (sinkStream->GetModelNum() > 1) {
                RT_LOG(RT_LOG_EVENT, "stream[%d] reused by model[%u].", sinkStream->Id_(), mdl->Id_());
                isNeedStreamReuse = true;
            }
            sinkStream->isModelComplete = true;
            RT_LOG(RT_LOG_DEBUG, "Load for model_id=%u, stream_id=%d.", mdl->Id_(), sinkStream->Id_());
        }
    }

    GetAndSaveJettyInfo(mdl);

    if (isNeedStreamReuse && isContextContainAicpuModel) {
        ERROR_RETURN_MSG_INNER(RT_ERROR_FEATURE_NOT_SUPPORT, "aicpu execute model not support stream reuse,"
            " retCode=%#x!", static_cast<uint32_t>(RT_ERROR_FEATURE_NOT_SUPPORT));
    }

    maintainceTask = nullptr;
    error = CheckTaskCanSend(stream);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stream->Id_(), static_cast<uint32_t>(error));
    stream->StreamLock();
    error = AllocTaskInfo(&maintainceTask, stream, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stream->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                stream->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(maintainceTask, stream, pos);
    (void)DavidModelMaintainceTaskInit(maintainceTask,
        MMT_MODEL_PRE_PROC, mdl, stream, RT_MODEL_HEAD_STREAM, mdl->GetFirstTaskId());
    error = DavidSendTask(maintainceTask, stream);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(maintainceTask);
                                TaskRollBack(stream, pos);
                                stream->StreamUnLock();,
                                "Failed to submit stream load complete task, sink stream_id=%d, retCode=%#x",
                                stream->Id_(), static_cast<uint32_t>(error));
    stream->StreamUnLock();
    mdl->SetNeedSubmitTask(true);

    if (isNeedLoadAicpuModel) {
        RT_LOG(RT_LOG_DEBUG, "packet model info for aicpu angine, model_id=%u, stream_id=%d.", mdl->Id_(), stream->Id_());
        aicpuTask = nullptr;
        stream->StreamLock();
        error = AllocTaskInfo(&aicpuTask, stream, pos);
        ERROR_PROC_RETURN_MSG_INNER(error, stream->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                stream->Id_(), static_cast<uint32_t>(error));
        SaveTaskCommonInfo(aicpuTask, stream, pos);
        (void)ModelToAicpuTaskInit(aicpuTask, mdl->Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_LOAD), executorFlag,
                                   RtPtrToValue(mdl->GetAicpuModelInfo()));
        error = DavidSendTask(aicpuTask, stream);
        ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(aicpuTask);
                                    TaskRollBack(stream, pos);
                                    stream->StreamUnLock();,
                                    "Failed to submit aicpu model load task, model_id=%u, retCode=%#x!",
                                    mdl->Id_(), static_cast<uint32_t>(error));
        stream->StreamUnLock();
    }

    /* 这部分往下可以考虑提出来作为公共函数处理 */
    error = mdl->LoadCompleteByStreamPostp(stream);
    ERROR_RETURN_MSG_INNER(error, "LoadCompleteByStreamPostp failed, retCode=%#x!", static_cast<uint32_t>(error));
    streamGuard.ReleaseGuard();
    return error;
}

rtError_t MdlBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const uint32_t flag)
{
    TaskInfo *maintainceTask = nullptr;
    Stream *stm = mdl->Context_()->DefaultStream_();
    const rtModelStreamType_t streamType =
        (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) ? RT_MODEL_HEAD_STREAM : RT_MODEL_WAIT_ACTIVE_STREAM;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_PROC_RETURN_MSG_INNER(error, mdl->ModelRemoveStream(streamIn);, "stream_id=%d check failed, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = AllocTaskInfo(&maintainceTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();mdl->ModelRemoveStream(streamIn);,
        "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&maintainceTask, &stm, &pos, &mdl, &streamIn]() {
        TaskUnInitProc(maintainceTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
        mdl->ModelRemoveStream(streamIn);
    };

    ScopeGuard tskErrRecycle(errRecycle);
    SaveTaskCommonInfo(maintainceTask, stm, pos);
    error = DavidModelMaintainceTaskInit(maintainceTask, MMT_STREAM_ADD, mdl, streamIn, streamType, 0U);
    ERROR_RETURN_MSG_INNER(error, "DavidModelMaintainceTaskInit failed, stream_id=%d, model_id=%u!",
                           stm->Id_(), mdl->Id_());
    error = DavidSendTask(maintainceTask, stm);
    ERROR_RETURN_MSG_INNER(error, "DavidModelMaintainceTaskInit failed, stream_id=%d, model_id=%u!",
                           stm->Id_(), mdl->Id_());
    stm->StreamUnLock();
    tskErrRecycle.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t MdlUnBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const bool force)
{
    const uint32_t devId = streamIn->Device_()->Id_();
    const uint32_t tsId = streamIn->Device_()->DevGetTsId();
    const uint32_t sqId = streamIn->GetSqId();
    const uint32_t tail = streamIn->GetCurSqPos();
    Driver* driver = streamIn->Device_()->Driver_();
    uint16_t devTail = 0;
    rtError_t error;
    do {
        error = driver->GetSqTail(devId, tsId, sqId, devTail);
        COND_PROC((error != RT_ERROR_NONE) ||
            (streamIn->Device_()->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)), break);
    } while (static_cast<uint16_t>(tail) != devTail);

    mdl->ModelRemoveStream(streamIn);
    Context * const context = mdl->Context_();
    Stream * const defaultStream = context->DefaultStream_();
    error = CheckTaskCanSend(defaultStream);
    ERROR_PROC_RETURN_MSG_INNER(error, mdl->ModelPushFrontStream(streamIn);,
                                "stream_id=%d check failed, retCode=%#x, current unbind stream_id=%d.",
                                defaultStream->Id_(), static_cast<uint32_t>(error), streamIn->Id_());

    TaskInfo *maintainceTask = nullptr;
    uint32_t pos = 0xFFFFU;
    defaultStream->StreamLock();
    error = AllocTaskInfo(&maintainceTask, defaultStream, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, defaultStream->StreamUnLock();
                                       mdl->ModelPushFrontStream(streamIn);,
                                       "stream_id=%d check failed, retCode=%#x.",
                                       defaultStream->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(maintainceTask, defaultStream, pos);
    (void)DavidModelMaintainceTaskInit(maintainceTask, MMT_STREAM_DEL, mdl, streamIn, RT_MODEL_HEAD_STREAM, 0U);
    error = DavidSendTask(maintainceTask, defaultStream);
    if ((!force) && (error != RT_ERROR_NONE)) {
        TaskUnInitProc(maintainceTask);
        TaskRollBack(defaultStream, pos);
        defaultStream->StreamUnLock();
        mdl->ModelPushFrontStream(streamIn);
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream unbind failed, stream_id=%d, model_id=%u!", streamIn->Id_(), mdl->Id_());
        return error;
    }
    defaultStream->StreamUnLock();
    defaultStream->Synchronize();
    return RT_ERROR_NONE;
}

static rtError_t MdlEndGraphForAicpuStream(Model * const mdl, Stream * const stm,
    const uint32_t flags, const uint32_t modelExecuteType)
{
    TaskInfo taskSubmit = {};
    TaskInfo *rtAddEndGraphTask = &taskSubmit;
    rtAddEndGraphTask->stream = stm;

    (void)AddEndGraphTaskInit(rtAddEndGraphTask, mdl->Id_(), modelExecuteType,
        RtPtrToValue(mdl->GetDevModelID()), RtPtrToValue(mdl->GetDevString(RT_DEV_STRING_ENDGRAPH)),
        static_cast<uint8_t>(flags));
    const rtError_t error = ProcAicpuTask(rtAddEndGraphTask);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(rtAddEndGraphTask);, "process aicpu task fail.");
    mdl->IncEndGraphNum();
    return RT_ERROR_NONE;
}

static rtError_t MdlAddEndGraphForAicpuModel(Model * const mdl, Stream * const stm,
    const uint32_t flags, const uint32_t modelExecuteType)
{
    if ((stm->Flags() & RT_STREAM_AICPU) != 0U) {
        return MdlEndGraphForAicpuStream(mdl, stm, flags, modelExecuteType);
    }
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    TaskInfo *rtAddEndGraphTask = nullptr;
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = AllocTaskInfo(&rtAddEndGraphTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, model_id=%u, stream_id=%d, retCode=%#x.",
        mdl->Id_(), stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtAddEndGraphTask, stm, pos);
    (void)AddEndGraphTaskInit(rtAddEndGraphTask, mdl->Id_(), modelExecuteType,
        RtPtrToValue(mdl->GetDevModelID()), RtPtrToValue(mdl->GetDevString(RT_DEV_STRING_ENDGRAPH)),
        static_cast<uint8_t>(flags));
    error = DavidSendTask(rtAddEndGraphTask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(rtAddEndGraphTask);
                                TaskRollBack(stm, pos);
                                stm->StreamUnLock();,
                                "Failed to submit AddEndGraphTask, retCode=%#x", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    mdl->IncEndGraphNum();
    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), rtAddEndGraphTask->taskSn);
    return RT_ERROR_NONE;
}

rtError_t MdlAddEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t modelExecuteType = mdl->ModelExecuteType();
    stm->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    const uint32_t endGraphNum = mdl->EndGraphNum_();
    COND_RETURN_OUT_ERROR_MSG_CALL(endGraphNum >= 1U, RT_ERROR_MODEL_ENDGRAPH,
        "Model add end graph failed, current endGraphNum(%u), model must have only one endgraph.", endGraphNum);
    if ((modelExecuteType != EXECUTOR_AICPU)) {
        const bool isBindThisModel = ((stm->Model_() != nullptr) && (stm->Model_()->Id_() == mdl->Id_()));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
            (stm->GetModelNum() == 0) || (!isBindThisModel), RT_ERROR_STREAM_INVALID,
            "stream %d has not been add to model %u", stm->Id_(), mdl->Id_());

        Notify *notify = const_cast<Notify *>(mdl->GetEndGraphNotify());
        if (notify == nullptr) {
            RT_LOG(RT_LOG_INFO, "create notify, stream_id=%d", stm->Id_());
            notify = new (std::nothrow) Notify(stm->Device_()->Id_(), stm->Device_()->DevGetTsId());
            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, notify == nullptr, RT_ERROR_NOTIFY_NEW,
                "Add end graph of model failed, new notify failed.");

            error = notify->Setup();
            ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(notify);,
                                        "Notify setup failed, retCode=%#x.", static_cast<uint32_t>(error));
        }

        error = NtyRecord(notify, stm);
        ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(notify);,
                                    "Notify record failed, retCode=%#x.", static_cast<uint32_t>(error));

        notify->SetEndGraphModel(mdl);
        mdl->SetEndGraphNotify(notify);
        RT_LOG(RT_LOG_INFO, "notify record ok. stream_id=%d", stm->Id_());
        return RT_ERROR_NONE;
    }
    error = MdlAddEndGraphForAicpuModel(mdl, stm, flags, modelExecuteType);
    return error;
}

}  // namespace runtime
}  // namespace cce