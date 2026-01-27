/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "model.hpp"
#if (!defined(CFG_VECTOR_CAST))
#include <algorithm>
#endif
#include <functional>
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "stream.hpp"
#include "api.hpp"
#include "task.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "error_message_manage.hpp"
#include "npu_driver.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "stub_task.hpp"
#include "task_info.h"
#include "utils.h"
#include "memory_task.h"
#include "ctrl_sq.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr int16_t MODEL_SCH_GROUP_ID_DEFAULT = 0;
constexpr int32_t MAX_WAIT_TIME = 5000;
constexpr const char_t *AICPU_EXT_INFO_CONFIG_OP_NAME = "AicpuCfgExtInfo";
}
Model::Model(ModelType type)
    : NoCopy(),
      lastStreamId_(0U),
      kernelTaskId_(MAX_UINT32_NUM),
      firstTaskId_(MAX_UINT32_NUM),
      exeStream_(nullptr),
      needSubmitTask_(false),
      isDebugRegister_(false),
      context_(nullptr),
      executorFlag_(EXECUTOR_NONE),
      aicpuModelInfo_(nullptr),
      streamInfoPtr_(nullptr),
      aicpuTaskInfoPtr_(nullptr),
      queueInfoPtr_(nullptr),
      modeID_(nullptr),
      endGraphName_(nullptr),
      activeStreamName_(nullptr),
      endGraphNum_(0U),
      modelExitNum_(0U),
      notifier_(nullptr),
      labelAllocator_(nullptr),
      isModelDelete_(false),
      schGroupId_(MODEL_SCH_GROUP_ID_DEFAULT),
      labelCount_(0ULL),
      labelCountPtr_(nullptr),
      firstExecuteFlag_(true),
      funcCallHostMem_(nullptr),
      funCallMemSize_(0ULL),
      funcCallSvmMem_(0ULL),
      baseFuncCallSvmMem_(nullptr),
      funcCallDfxBaseSvmMem_(nullptr),
      dfxPtr_(nullptr),
      modelType_(type)
{
}

Model::~Model() noexcept
{
    // context_ is null means setup is not called, no need release member
    if (context_ == nullptr) {
        return;
    }

    DELETE_O(notifier_);
    DELETE_O(labelAllocator_);
    DELETE_O(endGraphNotify_);

    const std::list<Stream *> streamsCpy(streams_);
    for (Stream * const streamObj : streamsCpy) {
        (void)UnbindStream(streamObj, true);
        if (streamObj->GetModelNum() == 0) {
            context_->InsertStreamList(streamObj);
        }
    }

    {
        const std::unique_lock<std::mutex> lk(labelMapMutex_);
        isModelDelete_ = true;
        for (auto &it : labelMap_) {
            it.second->UnbindModel();
        }
        labelMap_.clear();
    }

    CmoIdFree();

    (void) ClearMemory();
    if (id_ != MODEL_ID_INVALID) {
        Device * const dev = context_->Device_();
        Driver * const deviceDrv = dev->Driver_();
        (void) deviceDrv->ModelIdFree(id_, dev->Id_(), dev->DevGetTsId());
        id_ = MODEL_ID_INVALID;
    }
    h2dJettyInfoList_.clear();
    d2dJettyInfoList_.clear();
}

rtError_t Model::Setup(Context * const contextIn)
{
    context_ = contextIn;
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();

    rtError_t error = deviceDrv->ModelIdAlloc(&id_, devId, tsId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc model id failed, tsId=%u, retCode=%#x!", tsId, static_cast<uint32_t>(error));
        return error;
    }

    error = deviceDrv->DevMemAlloc(&aicpuModelInfo_, sizeof(rtAicpuModelInfo_t), RT_MEMORY_DEFAULT, devId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc aicpu model info failed, model_id=%d, device_id=%u, retCode=%#x!",
               id_, devId, static_cast<uint32_t>(error));
        return error;
    }

    error = MallocDevValue(&id_, static_cast<uint32_t>(sizeof(int32_t)), &modeID_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc dev value failed, model_id=%d, device_id=%u, retCode=%#x!",
               id_, devId, static_cast<uint32_t>(error));
        return error;
    }

    error = MallocDevString("endGraph", &endGraphName_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc dev string[endGraph] failed, model_id=%d, device_id=%u, retCode=%#x!",
               id_, devId, static_cast<uint32_t>(error));
        return error;
    }

    error = MallocDevString("activeEntryStream", &activeStreamName_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
               "Malloc dev string[activeEntryStream] failed, model_id=%d, device_id=%u, retCode=%#x!",
               id_, devId, static_cast<uint32_t>(error));
        return error;
    }

    notifier_ = OsalFactory::CreateNotifier();
    NULL_PTR_RETURN_MSG(notifier_, RT_ERROR_NOTIFY_NULL);

    const uint32_t tsVersion = dev->GetTschVersion();
    if ((tsVersion >= static_cast<uint32_t>(TS_VERSION_MORE_LABEL)) || (dev->GetType_() == Device::STUB_DEVICE)) {
        labelAllocator_ = new (std::nothrow) LabelAllocator(MAX_UINT16_NUM);
    } else {
        labelAllocator_ = new (std::nothrow) LabelAllocator(static_cast<uint16_t>(RT_MAX_LABEL_NUM));
    }
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, labelAllocator_ == nullptr, RT_ERROR_LABEL_ALLOCATOR,
                               "Setup model failed, new LabelAllocator failed.");

    if (dev->IsStarsPlatform()) {
        error = dev->Driver_()->DevMemAlloc(&labelCountPtr_, sizeof(uint64_t), RT_MEMORY_DDR, dev->Id_());
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Malloc labelCountPtr failed, model_id=%d, retCode=%#x!",
                id_, static_cast<uint32_t>(error));
            return error;
        }
    }
    return error;
}

rtError_t Model::AicpuModelDestroy()
{
    Stream * const defaultStream = context_->DefaultStream_();
    Device * const dev = defaultStream->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return AicpuMdlDestroy(this);
    }
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtAicpuModelParam param = 
            { Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_DESTROY), executorFlag_, RtPtrToValue(aicpuModelInfo_) };
        return dev->GetCtrlSQ().SendAicpuModelMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_MODEL_DESTROY, param);
    }

    TaskFactory * const devTaskFactory = dev->GetTaskFactory();
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *toAicpuTask = defaultStream->AllocTask(&taskSubmit, TS_TASK_TYPE_MODEL_TO_AICPU, errorReason);
    NULL_PTR_RETURN_MSG(toAicpuTask, errorReason);

    std::unique_ptr<TaskInfo, std::function<void(TaskInfo *)>> taskGuard(toAicpuTask, [=](TaskInfo* const recycleTask) {
        (void)devTaskFactory->Recycle(recycleTask);
    });

    (void)ModelToAicpuTaskInit(toAicpuTask, Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_DESTROY),
        executorFlag_, RtPtrToValue(aicpuModelInfo_));
    rtError_t error = dev->SubmitTask(toAicpuTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to submit ModelToAicpuTask, model_id=%d, retCode=%#x!", id_,
                         static_cast<uint32_t>(error));
        return error;
    }
    // release ownership of toAicpuTask
    (void)taskGuard.release();
    error = defaultStream->Synchronize();
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Fail to synchronize stream, model_id=%d, stream_id=%d, retCode=%#x!", id_,
                         defaultStream->Id_(), static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t Model::TearDown()
{
    DELETE_O(endGraphNotify_);

    rtError_t error = RT_ERROR_NONE;
    if (NeedLoadAicpuModelTask()) {
        error = AicpuModelDestroy();
        ERROR_RETURN_MSG_INNER(error, "Failed to destroy aicpu model, retCode=%#x!", static_cast<uint32_t>(error));
    }

    error = ClearMemory();
    ERROR_RETURN_MSG_INNER(error, "Failed to clear memory, retCode=%#x!", static_cast<uint32_t>(error));

    // unbind model from label
    {
        const std::unique_lock<std::mutex> lk(labelMapMutex_);
        isModelDelete_ = true;
        for (auto &it : labelMap_) {
            it.second->UnbindModel();
        }
        labelMap_.clear();
    }
    return RT_ERROR_NONE;
}

void Model::ReplaceArgHandle(const uint16_t streamId, const uint16_t taskId, void *argHandle)
{
    if (argHandle != nullptr) {
        const uint32_t key = (streamId << 16U) | taskId;
        auto iter = argLoaderRecord_.find(key);
        if (iter != argLoaderRecord_.end()) {
            iter->second = argHandle;
        }
    }
}

rtError_t Model::ClearMemory()
{
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    ArgLoader * const argLoaderObj = dev->ArgLoader_();

    rtError_t error;
    for (const auto &argHandle : argLoaderRecord_) {
        (void)argLoaderObj->Release(argHandle.second);
    }
    argLoaderRecord_.clear();

    for (struct DMA_ADDR curDmaAddr : dmaAddrRecord_) {
        error = deviceDrv->MemDestroyAddr(&curDmaAddr);
        ERROR_RETURN_MSG_INNER(error, "Free dma addr failed after convert memory address, retCode=%#x!",
                               static_cast<uint32_t>(error));
    }
    dmaAddrRecord_.clear();
    for (void * const activeArgs : argActiveStreamRecord_) {
        (void)deviceDrv->DevMemFree(activeArgs, dev->Id_());
    }
    argActiveStreamRecord_.clear();

    for (auto &iter : mapAicpuTask_) {
        iter.second.clear();
    }
    mapAicpuTask_.clear();

    if (aicpuModelInfo_ != nullptr) {
        (void)deviceDrv->DevMemFree(aicpuModelInfo_, dev->Id_());
        aicpuModelInfo_ = nullptr;
    }

    if (streamInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(streamInfoPtr_, dev->Id_());
        streamInfoPtr_ = nullptr;
    }

    if (aicpuTaskInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(aicpuTaskInfoPtr_, dev->Id_());
        aicpuTaskInfoPtr_ = nullptr;
    }

    if (queueInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(queueInfoPtr_, dev->Id_());
        queueInfoPtr_ = nullptr;
    }

    if (modeID_ != nullptr) {
        (void)deviceDrv->DevMemFree(modeID_, dev->Id_());
        modeID_ = nullptr;
    }

    if (endGraphName_ != nullptr) {
        (void)deviceDrv->DevMemFree(endGraphName_, dev->Id_());
        endGraphName_ = nullptr;
    }

    if (activeStreamName_ != nullptr) {
        (void)deviceDrv->DevMemFree(activeStreamName_, dev->Id_());
        activeStreamName_ = nullptr;
    }

    if (labelCountPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(labelCountPtr_, dev->Id_());
        labelCountPtr_ = nullptr;
    }

    if (funcCallHostMem_ != nullptr) {
        free(funcCallHostMem_);
        funcCallHostMem_ = nullptr;
    }

    if (baseFuncCallSvmMem_ != nullptr) {
        (void)deviceDrv->DevMemFree(baseFuncCallSvmMem_, dev->Id_());
        baseFuncCallSvmMem_ = nullptr;
        dfxPtr_ = nullptr;
        funcCallSvmMem_ = 0ULL;
    }

    if (funcCallDfxBaseSvmMem_ != nullptr) {
        (void)deviceDrv->DevMemFree(funcCallDfxBaseSvmMem_, dev->Id_());
        funcCallDfxBaseSvmMem_ = nullptr;
        dfxPtr_ = nullptr;
    }
    (void)MemWaitDevListFree(dev);

    funCallMemSize_ = 0ULL;

    return RT_ERROR_NONE;
}

rtError_t Model::CheckBindStream(const Stream * const streamIn) const
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    RT_LOG(RT_LOG_DEBUG, "Bind-Stream stream start, stream_id=%d.", streamIn->Id_());
    const int32_t streamId = streamIn->Id_();
    if (streamIn->GetModelNum() >= RT_MAX_MODELS_IN_ONE_STREAM) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, streamId, "The number of models exceeds the upper limit 256");
        return RT_ERROR_STREAM_REUSE_LIMIT_MODEL_NUM;
    }

    const bool isBindDup = (streamIn->Model_() != nullptr);
    if (isBindDup) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, streamId, "The stream is already bound");
        return RT_ERROR_STREAM_MODEL;
    }

    const bool isAicpuStreamBind = ((streamIn->Flags() & RT_STREAM_AICPU) != 0U) && (streamIn->GetModelNum() != 0U);
    if (isAicpuStreamBind) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, streamId, "The AI CPU stream is reused");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    bool isSupportStreamReuse = false;
    Device * const dev = context_->Device_();
    const bool isVersionFits = dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_MODEL_STREAM_REUSE);
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_REUSE) && (isVersionFits) &&
        (dev->Driver_()->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE))) {
        isSupportStreamReuse = true;
    }
    
    if (!isSupportStreamReuse && (streamIn->GetModelNum() != 0)) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, streamId, "The model has been bound to another stream");
        return RT_ERROR_STREAM_MODEL;
    }
    return RT_ERROR_NONE;
}

rtError_t Model::ModelBindTaskSubmit(Stream * const execStream, Stream * const streamIn,
    const uint32_t flag)
{
    Device * const dev = context_->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return MdlBindTaskSubmit(this, streamIn, flag);
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *maintainceTask = nullptr;
    
    TaskFactory * const devTaskFactory = streamIn->Device_()->GetTaskFactory();
    /* HWTS does not support sink task pool */
    const rtModelStreamType_t streamType =
        (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) ? RT_MODEL_HEAD_STREAM : RT_MODEL_WAIT_ACTIVE_STREAM;
    maintainceTask = execStream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
    COND_PROC_RETURN_ERROR_MSG_INNER(maintainceTask == nullptr, errorReason, streams_.remove(streamIn);,
        "Check param failed, maintainceTask can not be null.");
    rtError_t error = ModelMaintainceTaskInit(maintainceTask, MMT_STREAM_ADD, this, streamIn, streamType, 0U);
    if (error != RT_ERROR_NONE) {
        (void)devTaskFactory->Recycle(maintainceTask);
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "ModelMaintainceTaskInit failed, stream_id=%d, model_id=%d!",
            streamIn->Id_(), id_);
        return error;
    }

    error = dev->SubmitTask(maintainceTask);
    if (error != RT_ERROR_NONE) {
        (void)devTaskFactory->Recycle(maintainceTask);
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream bind failed, stream_id=%d, model_id=%d!", streamIn->Id_(), id_);
        return error;
    }
    return error;
}

rtError_t Model::EnterBindStream(Stream * const streamIn, const uint32_t flag)
{
    Device * const dev = context_->Device_();
    if (dev->IsStarsPlatform()) {
        streamIn->SetBindFlag(false); // set bind flag false for model stream reuse;
        streamIn->SetModel(this);
        streamIn->SetBindFlag(true); // set bind flag for alloc task resource;
        rtError_t error = RT_ERROR_NONE;
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
            error = dev->GetCtrlSQ().SendModelBindMsg(this, streamIn, flag);
        } else {
            Stream * const execStream = context_->DefaultStream_();
            error = ModelBindTaskSubmit(execStream, streamIn, flag);
            ERROR_RETURN_MSG_INNER(error, "ModelBindTaskSubmit failed, modelId=%u.", Id_());
            error = execStream->Synchronize();
        }
        if (error != RT_ERROR_NONE) {
            streamIn->DelModel(this);
            streamIn->SetBindFlag(false);
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream bind failed, "
                "stream_id=%d, model_id=%d, default stream sync error, retCode=%#x!",
                streamIn->Id_(), id_, static_cast<uint32_t>(error));
            return error;
        }
        streamIn->SetDebugRegister(streamIn->IsModelsDebugRegister());
        return RT_ERROR_NONE;
    } else {
        Stream * const execStream = streamIn;
        rtError_t error = ModelBindTaskSubmit(execStream, streamIn, flag);
        ERROR_RETURN_MSG_INNER(error, "ModelBindTaskSubmit failed, modelId=%u.", Id_());

        streamIn->SetModel(this);
        streamIn->SetBindFlag(true); // set bind flag for alloc task resource;
        return RT_ERROR_NONE;
    }
}

rtError_t Model::BindStream(Stream * const streamIn, const uint32_t flag)
{
    streamIn->SetLatestModlId(id_);
    rtError_t error = CheckBindStream(streamIn);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    streams_.push_front(streamIn);
    if (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) {
        headStreams_.push_back(streamIn);
    }

    /* AICPU streamIn no need sent to TS */
    if ((streamIn->Flags() & RT_STREAM_AICPU) != 0U) {
        streamIn->SetModel(this);
        this->Context_()->SetAicpuExecuteModel();
        return RT_ERROR_NONE;
    }

    error = EnterBindStream(streamIn, flag);
    if (error != RT_ERROR_NONE) {
         streams_.remove(streamIn);
         if (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) {
            headStreams_.remove(streamIn);
         }
         return error;
    }

    streamIn->InsertCacheStream();
    RT_LOG(RT_LOG_DEBUG, "bind stream end, stream_id=%d, model_id=%d.", streamIn->Id_(), id_);
    return RT_ERROR_NONE;
}

rtError_t Model::DisableSq(const Stream * const streamIn) const
{
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    const uint32_t sqId = streamIn->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t deviceId = dev->Id_();

    const rtError_t error = deviceDrv->DisableSq(deviceId, tsId, sqId);
    ERROR_RETURN_MSG_INNER(error, "Disable sq failed, stream_id=%d, sq_id=%u, device_id=%u, retCode=%#x.",
        streamIn->Id_(), sqId, deviceId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t Model::ModelUnBindTaskSubmit(Stream * const streamIn, const bool force)
{
    Device * const dev = context_->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return MdlUnBindTaskSubmit(this, streamIn, force);
    }

    /* HWTS does not support sink task pool */
    rtError_t syncRet = RT_ERROR_NONE;
    if (Runtime::Instance()->IsSupportOpTimeoutMs()) {
        syncRet = streamIn->ModelWaitForTask(streamIn->GetLastTaskId(), false);
    } else {
        syncRet = streamIn->Synchronize();
    }
    COND_RETURN_ERROR_MSG_INNER(syncRet != RT_ERROR_NONE, syncRet, "ModelWaitForTask failed.");
    streams_.remove(streamIn);

    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return dev->GetCtrlSQ().SendModelUnbindMsg(this, streamIn, force);
    }
    TaskFactory * const devTaskFactory = context_->Device_()->GetTaskFactory();
    Stream * const defaultStream = context_->DefaultStream_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *maintainceTask = defaultStream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
    NULL_PTR_RETURN_MSG(maintainceTask, errorReason);

    (void)ModelMaintainceTaskInit(maintainceTask, MMT_STREAM_DEL, this, streamIn, RT_MODEL_HEAD_STREAM, 0U);

    rtError_t error = context_->Device_()->SubmitTask(maintainceTask);
    if ((!force) && (error != RT_ERROR_NONE)) {
        (void)devTaskFactory->Recycle(maintainceTask);
        streams_.push_front(streamIn);
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream unbind failed, streamId=%d, modelId=%d!", streamIn->Id_(), id_);
        return error;
    }
    error = (context_->DefaultStream_())->Synchronize();
    if (error != RT_ERROR_NONE) {
        streams_.push_front(streamIn);
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t Model::UnbindStream(Stream * const streamIn, const bool force)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);

    const int32_t streamId = streamIn->Id_();
    RT_LOG(RT_LOG_DEBUG, "unbind stream start, stream_id=%d, model_id=%d.", streamId, id_);

    streamIn->SetLatestModlId(id_);
    COND_RETURN_ERROR_MSG_INNER(streamIn->GetModelNum() == 0 || (streamIn->Model_()->Id_() != static_cast<uint32_t>(id_)),
                                RT_ERROR_STREAM_MODEL,
                                "Stream unbind failed, stream is not bound with specified model, stream_id=%d, "
                                "specified model_id=%d!", streamId, id_);

    /* AICPU streamIn no need sent to TS */
    if ((streamIn->Flags() & RT_STREAM_AICPU) != 0U) {
        streams_.remove(streamIn);
        streamIn->DelModel(this);
        headStreams_.remove(streamIn);
        return RT_ERROR_NONE;
    }

    rtError_t error = ModelUnBindTaskSubmit(streamIn, force);
    ERROR_RETURN_MSG_INNER(
        error, "Stream unbind failed, stream_id=%d, retCode=%#x!", streamId, static_cast<uint32_t>(error));

    streamIn->DelModel(this);
    streamIn->SetBindFlag(false);
    streamIn->EraseCacheStream();
    headStreams_.remove(streamIn);
    RT_LOG(RT_LOG_INFO, "unbind stream end, stream_id=%d, model_id=%d.", streamId, id_);
    return RT_ERROR_NONE;
}

rtError_t Model::AddStream(Stream * const streamIn, const uint32_t flag)
{
    streamIn->SetLatestModlId(id_);
    rtError_t error = CheckBindStream(streamIn);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    streams_.push_front(streamIn);
    if (flag == static_cast<uint32_t>(RT_HEAD_STREAM)) {
        headStreams_.push_back(streamIn);
    }

    /* AICPU streamIn no need sent to TS */
    if ((streamIn->Flags() & RT_STREAM_AICPU) != 0U) {
        streamIn->SetModel(this);
        this->Context_()->SetAicpuExecuteModel();
        return RT_ERROR_NONE;
    }

    streamIn->SetModel(this);
    streamIn->SetBindFlag(true); // set bind flag for alloc task resource;
    streamIn->InsertCacheStream();
    RT_LOG(RT_LOG_DEBUG, "add stream to model end, stream_id=%d, model_id=%d.", streamIn->Id_(), id_);
    return RT_ERROR_NONE;
}

rtError_t Model::DelStream(Stream * const streamIn)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);

    const int32_t streamId = streamIn->Id_();
    RT_LOG(RT_LOG_DEBUG, "del stream from model start, stream_id=%d, model_id=%d.", streamId, id_);

    streamIn->SetLatestModlId(id_);
    COND_RETURN_ERROR_MSG_INNER(streamIn->GetModelNum() == 0 || (streamIn->Model_()->Id_() != static_cast<uint32_t>(id_)),
                                RT_ERROR_STREAM_MODEL,
                                "Stream unbind failed, stream is not bound with specified model, stream_id=%d, "
                                "specified model_id=%d!", streamId, id_);

    /* AICPU streamIn no need sent to TS */
    if ((streamIn->Flags() & RT_STREAM_AICPU) != 0U) {
        streams_.remove(streamIn);
        streamIn->DelModel(this);
        headStreams_.remove(streamIn);
        return RT_ERROR_NONE;
    }

    streams_.remove(streamIn);
    streamIn->DelModel(this);
    streamIn->SetBindFlag(false);
    streamIn->EraseCacheStream();
    headStreams_.remove(streamIn);
    RT_LOG(RT_LOG_INFO, "del stream from model end, stream_id=%d, model_id=%d.", streamId, id_);
    return RT_ERROR_NONE;
}

rtError_t Model::BindSqPerStream(Stream * const streamIn, const uint32_t flag)
{
    Stream * const execStream = context_->DefaultStream_();

    rtError_t error = ModelBindTaskSubmit(execStream, streamIn, flag);
    ERROR_RETURN_MSG_INNER(error, "ModelBindTaskSubmit failed, model_id=%d, stream_id=%d, sq_id=%u.",
        id_, streamIn->Id_(), streamIn->GetSqId());

    error = execStream->Synchronize();
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "model bind sq failed, "
        "model_id=%d, stream_id=%d, sq_id=%u, default stream sync error, retCode=%#x!",
        id_, streamIn->Id_(), streamIn->GetSqId(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t Model::UnBindSqPerStream(Stream * const streamIn)
{
    if (streamIn->GetSqId() == UINT32_MAX) {
        RT_LOG(RT_LOG_INFO, "no need to unbind sq, stream_id=%d, model_id=%d.", streamIn->Id_(), id_);
        return RT_ERROR_NONE;
    }

    Device * const dev = context_->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return MdlUnBindTaskSubmit(this, streamIn, true);
    }

    const rtError_t syncRet = streamIn->Synchronize();
    COND_RETURN_ERROR_MSG_INNER(syncRet != RT_ERROR_NONE, syncRet, "Synchronize failed.");

    // 这里逻辑跟unbind那边不一样, 需要确认差异原因
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return dev->GetCtrlSQ().SendModelUnbindMsg(this, streamIn, false);
    }
    TaskFactory * const devTaskFactory = context_->Device_()->GetTaskFactory();
    Stream * const defaultStream = context_->DefaultStream_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *maintainceTask = defaultStream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
    NULL_PTR_RETURN_MSG(maintainceTask, errorReason);

    (void)ModelMaintainceTaskInit(maintainceTask, MMT_STREAM_DEL, this, streamIn, RT_MODEL_HEAD_STREAM, 0U);

    rtError_t error = context_->Device_()->SubmitTask(maintainceTask);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)devTaskFactory->Recycle(maintainceTask),
        "model unbind sq failed, model_id=%d, stream_id=%d, sq_id=%u.",
        id_, streamIn->Id_(), streamIn->GetSqId());

    error = defaultStream->Synchronize();
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "model_id=%d, stream_id=%d, sq_id=%u, retCode=%#x!",
        id_, streamIn->Id_(), streamIn->GetSqId(), static_cast<uint32_t>(error));

    return error;
}

uint32_t Model::GetStreamIdBySqId(const uint16_t sqId) const
{
    for (auto stm : StreamList_()) {
        if (stm->GetSqId() == sqId) {
            return static_cast<uint32_t>(stm->Id_());
        }
    }

    return UINT32_MAX;
}

rtError_t Model::LoadComplete()
{
    Device * const dev = context_->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return ModelLoadCompleteByStream(this);
    }

    return LoadCompleteByStream();
}

rtError_t Model::SendAicpuModelLoadMsg(Stream *stream) const
{
    RT_LOG(RT_LOG_DEBUG, "packet model info for aicpu engine, model_id=%u, stream_id=%d.",  Id_(), stream->Id_());
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *aicpuTask = stream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_TO_AICPU, errorReason);
    NULL_PTR_RETURN_MSG(aicpuTask, errorReason);

    (void)ModelToAicpuTaskInit(aicpuTask, Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_LOAD), executorFlag_,
                                RtPtrToValue(aicpuModelInfo_));
    rtError_t error = stream->Device_()->SubmitTask(aicpuTask);
    if (error != RT_ERROR_NONE) {
        (void)stream->Device_()->GetTaskFactory()->Recycle(aicpuTask);
        RT_LOG(RT_LOG_ERROR, "Failed to submit aicpu model load task, model_id=%d, retCode=%#x!", id_, static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t Model::LoadCompleteByStreamPrep(Stream * &stream)
{
    rtError_t error = PacketAicpuModelInfo();
    ERROR_RETURN_MSG_INNER(error, "Fail to packet aicpu model task!");
    const bool isNeedLoadAicpuModel = NeedLoadAicpuModelTask();
    Device * const dev = context_->Device_();
    if (isNeedLoadAicpuModel) {
        COND_RETURN_ERROR_MSG_INNER(endGraphNum_ != 1U, RT_ERROR_MODEL_ENDGRAPH,
            "End graph num(%u) must be equal to 1", endGraphNum_);
        error = context_->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &stream);
        ERROR_RETURN_MSG_INNER(error, "Fail to create model load stream, retCode=%#x!", static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "create a aicpu stream for model load, model_id=%u, stream_id=%d.", Id_(), stream->Id_());
    } else if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        COND_RETURN_ERROR_MSG_INNER(streams_.empty(), RT_ERROR_MODEL_STREAM, "There is no stream of the model");
        CtrlSQ& ctrlSQ = dev->GetCtrlSQ();
        stream = ctrlSQ.GetStream();
        RT_LOG(RT_LOG_DEBUG, "use ctrl stream for model load");
    } else {
        COND_RETURN_ERROR_MSG_INNER(streams_.empty(), RT_ERROR_MODEL_STREAM, "There is no stream of the model");
        stream = context_->DefaultStream_();
        RT_LOG(RT_LOG_DEBUG, "create not a aicpu stream for model load");
    }

    stream->SetLatestModlId(id_);
    if (dev->IsStarsPlatform()) {
        error = dev->Driver_()->MemCopySync(labelCountPtr_, sizeof(uint64_t), &labelCount_,
            sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_RETURN_MSG_INNER(error, "Failed to copy label count, retCode=%#x!",
                static_cast<uint32_t>(error));
        }
    }
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, (endGraphNotify_ == nullptr) && dev->IsStarsPlatform() &&
        (GetModelExecutorType() != EXECUTOR_AICPU), RT_ERROR_MODEL_NOT_END,
        "endGraphNotify_ is null, rtEndGraph must be called before rtModelLoadComplete!");
    return RT_ERROR_NONE;
}

static bool CheckSqQuery(const Stream * const stm)
{
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_LOAD_COMPLETE_TO_RTSQ)) {
        if ((stm->Flags() & RT_STREAM_AICPU) != 0) {
            return false;
        }
        return true;
    }

    return false;
}

rtError_t Model::LoadCompleteByStreamPostp(Stream *const stream)
{
    const bool isNeedLoadAicpuModel = NeedLoadAicpuModelTask();
    stream->isModelComplete = true;
    rtError_t error = stream->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize default stream, retCode=%#x!", static_cast<uint32_t>(error));
    isModelComplete_ = true;
    SetFirstExecute(true);

    for (Stream * const sinkStream : streams_) {
        if (!CheckSqQuery(sinkStream)) {
            break;
        }
        const uint32_t sqId = sinkStream->GetSqId();
        const uint32_t tsId = sinkStream->Device_()->DevGetTsId();
        const uint32_t devId = sinkStream->Device_()->Id_();
        const uint32_t flags = sinkStream->Flags();
        Driver* driver = sinkStream->Device_()->Driver_();
        uint16_t devTail = 0;
        const uint32_t totalTask = sinkStream->GetCurSqPos();
        if ((flags & RT_STREAM_AICPU) != 0U) { continue; }
        mmTimespec timeBegin = mmGetTickCount();
        uint64_t diff = 0ULL;        
        do {
            COND_PROC(driver->GetSqTail(devId, tsId, sqId, devTail) != RT_ERROR_NONE, break);
            diff = GetTimeInterval(timeBegin);
        } while ((devTail < static_cast<uint16_t>(totalTask)) && (diff <= MAX_WAIT_TIME)); // Max wait time is 5000 ms
        COND_PROC((diff > MAX_WAIT_TIME), RT_LOG(RT_LOG_EVENT,
            "refresh SqTail time is more than 5s, model_id=%u, stream_id=%d, devTail=%hu, totalTask=%u",
            Id_(), sinkStream->Id_(), devTail, totalTask));
    }

    if (isNeedLoadAicpuModel) {
        error = context_->StreamDestroy(stream);
        ERROR_RETURN_MSG_INNER(error, "Failed to destroy model load stream, retCode=%#x!",
                               static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "destroy a aicpu stream for model load, model_id=%u, stream_id=%d.", Id_(), stream->Id_());
    }

    return RT_ERROR_NONE;
}

rtError_t Model::LoadCompleteByStream(void)
{
    Stream *stream = nullptr;
    rtError_t syncError = RT_ERROR_NONE;
    rtError_t error = LoadCompleteByStreamPrep(stream);
    ERROR_RETURN_MSG_INNER(error, "LoadCompleteByStreamPrep failed, retCode=%#x!",
        static_cast<uint32_t>(error));
    /* Mini should notify TS model load success for benchmarks,
    and decoupling model load with NPU power for lite */
    TaskInfo submitTask = {};
    TaskInfo submitTaskInfo = {};
    TaskInfo *maintainceTask = nullptr;
    bool isNeedStreamReuse = false;
    const bool isContextContainAicpuModel = this->Context_()->GetAicpuExecuteModel();

    const bool isNeedLoadAicpuModel = NeedLoadAicpuModelTask();
    Device * const dev = stream->Device_();
    TaskFactory * const devTaskFactory = dev->GetTaskFactory();
    rtError_t errorReason;
    // per sink stream load complete for mini/cloud
    for (Stream * const sinkStream : streams_) {
        if (((sinkStream->Flags() & RT_STREAM_AICPU) != 0)) {
            continue;
        }

        if (!dev->IsStarsPlatform()) {
            maintainceTask = sinkStream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
            NULL_PTR_RETURN_MSG(maintainceTask, errorReason);

            (void)ModelMaintainceTaskInit(maintainceTask,
                MMT_STREAM_LOAD_COMPLETE, this, sinkStream, RT_MODEL_HEAD_STREAM, firstTaskId_);

            error = dev->SubmitTask(maintainceTask);
            ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to submit stream load complete task, retCode=%#x!",
                                 static_cast<uint32_t>(error));
            error = sinkStream->Synchronize();
            syncError = ((syncError == RT_ERROR_NONE) ? error : syncError);
        }

        sinkStream->SetLatestModlId(id_);
        if (sinkStream->GetModelNum() > 1) {
            RT_LOG(RT_LOG_EVENT, "stream[%d] reused by model[%d].", sinkStream->Id_(), id_);
            isNeedStreamReuse = true;
        }
    }
    ERROR_RETURN_MSG_INNER(syncError, "Failed to synchronize sink stream, retCode=%#x!",
        static_cast<uint32_t>(syncError));

    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        error = dev->GetCtrlSQ().SendModelLoadCompleteMsg(this, firstTaskId_);
        ERROR_RETURN_MSG_INNER(error, "SendModelLoadCompleteMsg failed, retCode=%#x!", static_cast<uint32_t>(error));
    } else {
        maintainceTask = stream->AllocTask(&submitTaskInfo, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
        NULL_PTR_RETURN_MSG(maintainceTask, errorReason);

        (void)ModelMaintainceTaskInit(maintainceTask,
            MMT_MODEL_PRE_PROC, this, stream, RT_MODEL_HEAD_STREAM, firstTaskId_);

        error = dev->SubmitTask(maintainceTask);
        ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to submit model pre proc task, retCode=%#x!",
                            static_cast<uint32_t>(error));
    }
    SetNeedSubmitTask(true);
    if (isNeedLoadAicpuModel) {
        SendAicpuModelLoadMsg(stream);
        ERROR_RETURN_MSG_INNER(error, "SendAicpuModelLoadMsg failed, retCode=%#x!", static_cast<uint32_t>(error));
    }
    error = LoadCompleteByStreamPostp(stream);
    ERROR_RETURN_MSG_INNER(error, "LoadCompleteByStreamPostp failed, retCode=%#x!",
        static_cast<uint32_t>(error));

    return error;
ERROR_TASK:
    (void)devTaskFactory->Recycle(maintainceTask);
    return error;
}

void Model::ExecuteComplete(void)
{
    (void) notifier_->Triger();
}

rtError_t Model::SynchronizeExecute(Stream * const stm, int32_t timeout)
{
    uint64_t time1;
    uint64_t time2;
    uint64_t time4;
    const mmTimespec timeBegin = mmGetTickCount();
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != context_, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%u.", stm->Id_());
    rtError_t error = RT_ERROR_NONE;
    const uint32_t executeType = ModelExecuteType();
    RT_LOG(RT_LOG_DEBUG, "sync execute stream, model execute type=%u, model_id=%u, stream_id=%d.",
           executeType, Id_(), stm->Id_());

    stm->SetSyncMdlId(id_);
    Device * const dev = context_->Device_();
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, (endGraphNotify_ == nullptr) && dev->IsStarsPlatform() &&
                               (executeType != EXECUTOR_AICPU), RT_ERROR_MODEL_NOT_END,
                               "endGraphNotify_ is null, rtEndGraph must be called before rtModelExecute!");
    bool isNeedExecuteTimeoutMinotor =
        dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTE_TIMEOUT_MONITOR);
    time1 = GetTimeInterval(timeBegin);
    error = SubmitExecuteTask(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit exeTask, stream_id=%d.", stm->Id_());
    time2 = GetTimeInterval(timeBegin);
    if ((dev->IsStarsPlatform()) && (executeType != EXECUTOR_AICPU)) {
        error = NtyWait(endGraphNotify_, stm, MAX_UINT32_NUM);
        ERROR_RETURN_MSG_INNER(error, "Failed to wait notify, retCode=%#x.", static_cast<uint32_t>(error));

        error = stm->Synchronize(false, timeout);
        ERROR_RETURN_MSG_INNER(error, "Fail to synchronize forbidden stream, retCode=%#x!",
                               static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_INFO, "model synchronize execute success.");
        const uint64_t time3 = GetTimeInterval(timeBegin);
        COND_PROC((isNeedExecuteTimeoutMinotor && (time3 > ADC_MODEL_EXE_TIMEOUT)),
            RT_LOG(RT_LOG_EVENT,
                "sync/model exec timeout, time1=%lums, time2=%lums, time3=%lums, stream_id=%d, model_id=%u",
                time1, time2, time3, stm->Id_(), Id_()));

        return RT_ERROR_NONE;
    }

    if (Runtime::Instance()->GetDisableThread()) {
        stm->isModelExcel = true;
        error = stm->Synchronize(false, timeout);
    } else if (executeType == EXECUTOR_TS) {
        (void)notifier_->Wait();
        (void)notifier_->Reset();
        error = stm->GetError();
    } else {
        error = stm->Synchronize(false, timeout);
    }
    ERROR_RETURN(error, "Fail to synchronize forbidden stream_id=%d, retCode=%#x!", stm->Id_(),
                 static_cast<uint32_t>(error));
    time4 = GetTimeInterval(timeBegin);
    COND_PROC((isNeedExecuteTimeoutMinotor && (time4 > ADC_MODEL_EXE_TIMEOUT)),
        RT_LOG(RT_LOG_EVENT,
            "sync/model exec timeout, time1=%lums, time2=%lums, time4=%lums, stream_id=%d, model_id=%u",
            time1, time2, time4, stm->Id_(), Id_()));

    return RT_ERROR_NONE;
}

rtError_t Model::GetStreamToSyncExecute(int32_t timeout)
{
    Stream *executeStream = nullptr;
    Stream *onlineStream = context_->OnlineStream_();
    Stream *defaultStream = context_->DefaultStream_();
    if (onlineStream != nullptr) {
        executeStream = onlineStream;
        RT_LOG(RT_LOG_DEBUG, "use online stream for model execute, model_id=%d.", id_);
    } else {
        executeStream = defaultStream;
        RT_LOG(RT_LOG_DEBUG, "use default stream for model execute, model_id=%d.", id_);
    }
    SetExeStream(executeStream);
    const rtError_t error = SynchronizeExecute(executeStream, timeout);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Model synchronize execute failed, model_id=%d, timeout=%dms!", id_, timeout);
        RT_LOG(RT_LOG_ERROR, "model[%s] execute failed!", GetName().c_str());
    }

    Device* const dev = context_->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SYNC_TIMEOUT_ABORT)) {
        if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
            const rtError_t error1 = ModelAbort();
            COND_PROC(error1 != RT_ERROR_NONE,
                RT_LOG(RT_LOG_ERROR, "model abort failed=%#x,stmId=%d,mdlId=%u,mdlName=%s",
                    error1, executeStream->Id_(), Id_(), GetName().c_str()));
        }
    }

    return error;
}

rtError_t Model::SubmitExecuteTask(Stream * const streamIn)
{
    if (streamIn->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        return ModelSubmitExecuteTask(this, streamIn);
    }
    // private func, the caller guarantees that the pointer is not nullptr
    Device * const dev = context_->Device_();
    uint32_t executeType = ModelExecuteType();
    TaskInfo submitTask = {};
    TaskInfo *exeTask = &submitTask;
    exeTask->stream = streamIn;
    RT_LOG(RT_LOG_DEBUG, "execute stream, model execute type=%u, model_id=%u, stream_id=%d.",
           executeType, Id_(), streamIn->Id_());

    if (firstExecuteFlag_) {
        for (auto stm : streams_) {
            stm->SetLatestModlId(id_);
        }
    }

    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;
    TaskFactory * const devTaskFactory = dev->GetTaskFactory();
    if (executeType == EXECUTOR_TS) {
        TaskInfo *modelExeTask = streamIn->AllocTask(exeTask, TS_TASK_TYPE_MODEL_EXECUTE, errorReason);
        NULL_PTR_RETURN_MSG(modelExeTask, errorReason);
        exeTask = modelExeTask;
        error = ModelExecuteTaskInit(modelExeTask, this, Id_(), firstTaskId_);
    }else if (executeType == EXECUTOR_AICPU) {
        TaskInfo *modelToAicpuExeTask = streamIn->AllocTask(exeTask, TS_TASK_TYPE_MODEL_TO_AICPU, errorReason);
        NULL_PTR_RETURN_MSG(modelToAicpuExeTask, errorReason);
        exeTask = modelToAicpuExeTask;
        error = ModelToAicpuTaskInit(modelToAicpuExeTask, Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_EXECUTE),
            executorFlag_, RtPtrToValue(aicpuModelInfo_));
    } else {
        ERROR_RETURN_MSG_INNER(RT_ERROR_MODEL_EXECUTOR,
            "Unsupported executor type=%u, modelId=%d.", executeType, id_);
    }

    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "executeTask init failed, retCode=%#x.", static_cast<uint32_t>(error));
        (void) devTaskFactory->Recycle(exeTask);
        exeTask = nullptr;
        return RT_ERROR_MODEL_EXECUTOR;
    }

    error = dev->SubmitTask(exeTask);
    if (error != RT_ERROR_NONE) {
        (void)dev->GetTaskFactory()->Recycle(exeTask);
        exeTask = nullptr;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Model execute failed, model_id=%d.", id_);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t Model::GetStreamToAsyncExecute(Stream *stm)
{
    Device * const dev = context_->Device_();
    rtError_t error = RT_ERROR_NONE;
    bool isDelTmpStream = false;
    int32_t tmpStreamId = 0;
    const uint32_t modelId = Id_();

    if (stm == nullptr) {
        if (NeedLoadAicpuModelTask()) {
            error = context_->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &stm);
            ERROR_RETURN_MSG_INNER(error, "Fail to create model exe stream, retCode=%#x!",
                                   static_cast<uint32_t>(error));
            RT_LOG(RT_LOG_DEBUG, "create a aicpu stream for model execute, model_id=%u, "
                   "stream_id=%d.", modelId, stm->Id_());
            isDelTmpStream = true;
            tmpStreamId = stm->Id_();
        } else {
            stm = context_->DefaultStream_();
        }
    }
    SetExeStream(stm);
    /* stars wait notify, does not need to send task to tscpu */
    if ((dev->IsStarsPlatform()) && (GetModelExecutorType() != EXECUTOR_AICPU)) {
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_GE, endGraphNotify_ == nullptr, ERROR_RELEASE, error,
            RT_ERROR_MODEL_NOT_END, "endGraphNotify_ is null, rtEndGraph must be called before rtModelExecute!");
    }

    if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXE_DOT_NEED_LOAD_COMPLETE)) &&
        (GetModelExecutorType() != EXECUTOR_AICPU)) {
        COND_RETURN_ERROR((!isModelComplete_),
            RT_ERROR_MODEL_NOT_END, "model is not load complete, stream_id=%d, model_id=%u", stm->Id_(), modelId);
    }

    error = SubmitExecuteTask(stm);
    ERROR_GOTO_MSG_INNER(error, ERROR_RELEASE, "Failed to submit execute task, stream_id=%d.", stm->Id_());

    if ((dev->IsStarsPlatform()) && (GetModelExecutorType() != EXECUTOR_AICPU)) {
        if (modelType_ == RT_MODEL_CAPTURE_MODEL) {
            const CaptureModel * const captureMdl = dynamic_cast<CaptureModel const *>(this);
            if (captureMdl->IsSoftwareSqEnable()) {
                error = endGraphNotify_->Wait(stm, MAX_UINT32_NUM, true, this);
            } else {
                error = NtyWait(endGraphNotify_, stm, MAX_UINT32_NUM);
            }
        } else {
            error = NtyWait(endGraphNotify_, stm, MAX_UINT32_NUM);
        }
        ERROR_RETURN_MSG_INNER(error, "Failed to wait notify, retCode=%#x.", static_cast<uint32_t>(error));
    }

    if (isDelTmpStream) {
        error = context_->StreamDestroy(stm);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, SetExeStream(nullptr);,
                               "fail to destroy model exe stream, retCode=%#x", static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "destroy a aicpu stream for model execute, model_id=%u, stream_id=%u.",
               modelId, tmpStreamId);
    }

    return RT_ERROR_NONE;

ERROR_RELEASE:
    if (isDelTmpStream) {
        const rtError_t error2 = context_->StreamDestroy(stm);
        COND_LOG_ERROR(error2!= RT_ERROR_NONE, "fail to destroy model exe stream, retCode=%#x",
                       static_cast<uint32_t>(error2));
    }

    RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to execute model, model_id=%d!", id_);
    SetExeStream(nullptr);
    return error;
}

rtError_t Model::Execute(Stream * const stm, int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    Stream *curStm = stm;

    COND_RETURN_ERROR_MSG_INNER((curStm != nullptr) && (curStm->Context_() != context_),
        RT_ERROR_STREAM_CONTEXT, "Stream is not in current ctx!");

    COND_RETURN_ERROR((GetModelExecutorType() == EXECUTOR_AICPU) && (queueInfo_.size() > 0UL),
                      RT_ERROR_MODEL_EXE_FAILED, "Repeated AICPU model execution!");

    // MAX_INT32_NUM means that stream is type of RT_STREAM_FORBIDDEN_DEFAULT
    const bool syncFlag = ((curStm != nullptr) &&
                           ((curStm->Flags() & RT_STREAM_FORBIDDEN_DEFAULT) != 0));
    if (syncFlag) {
        RT_LOG(RT_LOG_INFO, "synchronize execute model, timeout=%dms.", timeout);
        const uint32_t modelId = Id_();
        const mmTimespec timeBegin = mmGetTickCount();
        error = GetStreamToSyncExecute(timeout);
        Device* const dev = context_->Device_();
        const uint64_t time1 = GetTimeInterval(timeBegin);
        COND_PROC(((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTE_TIMEOUT_MONITOR)) &&
            (time1 > ADC_MODEL_EXE_TIMEOUT)),
            RT_LOG(RT_LOG_EVENT,
                "sync/model exec timeout, time1=%lums, stream_id=%d, model_id=%u", time1, curStm->Id_(), modelId));
        return error;
    }

    error = GetStreamToAsyncExecute(curStm);
    return error;
}

rtError_t Model::AiCpuModelSyncExecute()
{
    rtError_t error = RT_ERROR_NONE;
    bool isDelTmpStream = false;
    int32_t tmpStreamId = 0;
    const uint32_t modelId = Id_();
    Stream *stm = nullptr;

    if (NeedLoadAicpuModelTask()) {
        error = context_->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &stm);
        ERROR_RETURN_MSG_INNER(error, "Fail to create model exe stream, retCode=%#x!",
                                static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "create a aicpu stream for model execute, model_id=%u, "
                "stream_id=%d.", modelId, stm->Id_());
        isDelTmpStream = true;
        tmpStreamId = stm->Id_();
    } else {
        stm = context_->DefaultStream_();
    }

    SetExeStream(stm);
    error = SubmitExecuteTask(stm);
    ERROR_GOTO_MSG_INNER(error, ERROR_RELEASE, "Failed to submit execute task, stream_id=%d.", stm->Id_());

    if (isDelTmpStream) {
        error = context_->StreamDestroy(stm);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, SetExeStream(nullptr);,
                               "fail to destroy model exe stream, retCode=%#x", static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "destroy a aicpu stream for model execute, model_id=%u, stream_id=%d.",
               modelId, tmpStreamId);
    }

    return RT_ERROR_NONE;

ERROR_RELEASE:
    if (isDelTmpStream) {
        const rtError_t error2 = context_->StreamDestroy(stm);
        COND_LOG_ERROR(error2!= RT_ERROR_NONE, "fail to destroy model exe stream, retCode=%#x",
                       static_cast<uint32_t>(error2));
    }

    RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to execute model, model_id=%d!", id_);
    SetExeStream(nullptr);
    return error;
}

rtError_t Model::ExecuteSync(int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t modelId = Id_();
    COND_RETURN_ERROR((GetModelExecutorType() == EXECUTOR_AICPU) && (queueInfo_.size() > 0UL),
                      RT_ERROR_MODEL_EXE_FAILED, "Repeated AICPU model execution!");

    if (GetModelExecutorType() == EXECUTOR_AICPU) {
        RT_LOG(RT_LOG_INFO, "synchronize execute aicpu model.");
        error = AiCpuModelSyncExecute();
        return error;
    }

    RT_LOG(RT_LOG_INFO, "synchronize execute model, timeout=%dms.", timeout);
    const mmTimespec timeBegin = mmGetTickCount();
    Stream *executeStream = context_->DefaultStream_();
    SetExeStream(executeStream);
    error = SynchronizeExecute(executeStream, timeout);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Model synchronize execute failed, model_id=%d, timeout=%dms!", id_, timeout);
    }
    Device* const dev = context_->Device_();
    const uint64_t time1 = GetTimeInterval(timeBegin);
    COND_PROC(((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTE_TIMEOUT_MONITOR)) &&
        (time1 > ADC_MODEL_EXE_TIMEOUT)),
    RT_LOG(RT_LOG_EVENT,
        "sync/model exec timeout, time1=%lums, stream_id=%d, model_id=%u", time1, executeStream->Id_(), modelId));
    return error;
}

rtError_t Model::ExecuteAsync(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    Stream *curStm = stm;
    COND_RETURN_ERROR_MSG_INNER((curStm != nullptr) && (curStm->Context_() != context_),
        RT_ERROR_STREAM_CONTEXT, "Stream is not in current ctx!");
    COND_RETURN_WARN(GetModelExecutorType() == EXECUTOR_AICPU, 
        RT_ERROR_FEATURE_NOT_SUPPORT, "feature does not support!");

    error = GetStreamToAsyncExecute(curStm);
    return error;
}

rtError_t Model::SaveAicpuStreamTask(const Stream * const streamIn, const rtCommand_t * const command)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    rtAicpuTaskInfo_t taskInfo;
    taskInfo.taskID = command->taskID;
    taskInfo.streamID = static_cast<uint32_t>(streamIn->Id_());
    tsTaskType_t const type = static_cast<tsTaskType_t>(command->type);

    if (type == TS_TASK_TYPE_ACTIVE_AICPU_STREAM) {
        taskInfo.kernelType = command->u.activeAicpuStreamTask.literalDstBase;
        taskInfo.kernelName = command->u.activeAicpuStreamTask.funcPtr;
        taskInfo.kernelSo = 0UL;
        taskInfo.paraBase = command->u.activeAicpuStreamTask.funcDesc;
        taskInfo.taskFlag = 0U;
    } else if (type == TS_TASK_TYPE_KERNEL_AICPU) {
        taskInfo.kernelType = command->u.kernelTask.literalDstBase;
        taskInfo.kernelName = command->u.kernelTask.funcPtr;
        taskInfo.kernelSo = command->u.kernelTask.literalSrcAddr;
        taskInfo.paraBase = command->u.kernelTask.funcDesc;
        taskInfo.taskFlag = 0U;
    } else if (type == TS_TASK_TYPE_MODEL_END_GRAPH) {
        taskInfo.kernelType = static_cast<uint32_t>(TS_AICPU_KERNEL_CCE);
        taskInfo.kernelName = command->u.modelEndGraphTask.endGraphNamePtr;
        taskInfo.kernelSo = 0UL;
        taskInfo.paraBase = command->u.modelEndGraphTask.argptr;
        taskInfo.taskFlag = 0U;
    } else {
        RT_LOG(RT_LOG_DEBUG, "don't need save task, not aicpu stream task, stream_id=%u, "
               "task_id=%u, task_type=%d.",\
               taskInfo.streamID, taskInfo.taskID, static_cast<uint32_t>(type));
        return RT_ERROR_NONE;
    }

    mapAicpuTask_[static_cast<uint32_t>(streamIn->Id_())].push_back(taskInfo);
    RT_LOG(RT_LOG_DEBUG, "save aicpu stream task, stream_id=%u, task_id=%u, kernel_type=%u, task_type=%d.",
        taskInfo.streamID, taskInfo.taskID, taskInfo.kernelType, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t Model::PacketAllStreamInfo(rtAicpuModelInfo_t * const aicpuModelInfoIn)
{
    const size_t streamInfoSize = aicpuModelInfoIn->streamInfoNum * sizeof(rtModelStreamInfo_t);
    rtModelStreamInfo_t *streamInfo = new (std::nothrow)rtModelStreamInfo_t[aicpuModelInfoIn->streamInfoNum];
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, streamInfo == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Packet all stream info failed, failed to new streamInfo, size=%zu(bytes).", streamInfoSize);
    RT_LOG(RT_LOG_INFO, "new rtModelStreamInfo_t success, Runtime_alloc_size %zu.", streamInfoSize);

    rtModelStreamInfo_t *curStreamInfo = streamInfo;
    for (Stream * const streamObj : streams_) {
        curStreamInfo->streamID = static_cast<uint32_t>(streamObj->Id_());
        const uint32_t bHeadStream = IsModelHeadStream(streamObj) ? RT_STREAM_HEAD : 0U;
        curStreamInfo->streamFlag = streamObj->Flags() | bHeadStream;
        curStreamInfo++;
    }

    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    rtError_t error = deviceDrv->DevMemAlloc(&streamInfoPtr_, streamInfoSize, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc stream info failed, modelId=%d, deviceId=%u!", id_, dev->Id_());
        DELETE_A(streamInfo);
        return error;
    }

    aicpuModelInfoIn->streamInfoPtr = RtPtrToValue(streamInfoPtr_);
    if (deviceDrv->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        error = deviceDrv->MemCopySync(streamInfoPtr_, streamInfoSize, RtPtrToPtr<void *>(streamInfo),
            streamInfoSize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC,
                "Failed to memory copy stream info, model_id=%d, device_id=%u, size=%zu(bytes), retCode=%#x.",
                id_, dev->Id_(), streamInfoSize, static_cast<uint32_t>(error));
        }
        error = deviceDrv->DevMemFlushCache(RtPtrToValue(streamInfoPtr_), streamInfoSize);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to flush stream info, model_id=%d, device_id=%u, "
                                                     "retCode=%#x", id_, dev->Id_(), static_cast<uint32_t>(error));
        }
    } else {
        error = deviceDrv->MemCopySync(streamInfoPtr_, streamInfoSize,
            RtPtrToPtr<void *>(streamInfo), streamInfoSize, RT_MEMCPY_DEVICE_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to memory copy stream info, model_id=%d, device_id=%u, "
                                                     "retCode=%#x", id_, dev->Id_(), static_cast<uint32_t>(error));
        }
    }

    DELETE_A(streamInfo);
    return RT_ERROR_NONE;

FAIL_ALLOC:
    DELETE_A(streamInfo);
    (void)deviceDrv->DevMemFree(streamInfoPtr_, dev->Id_());
    streamInfoPtr_ = nullptr;
    return error;
}

rtError_t Model::PacketAicpuTaskInfo(rtAicpuModelInfo_t * const infoAicpuModel)
{
    rtError_t error;
    Device * const dev = context_->Device_();
    const uint64_t aicpuTaskSize = infoAicpuModel->aicpuTaskNum * sizeof(rtAicpuTaskInfo_t);

    rtAicpuTaskInfo_t *taskInfo = new (std::nothrow)rtAicpuTaskInfo_t[infoAicpuModel->aicpuTaskNum];
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, taskInfo == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                               "New aicpu taskInfo failed, num=%u.",
                               static_cast<uint32_t>(infoAicpuModel->aicpuTaskNum));

    rtAicpuTaskInfo_t *curTaskInfo = taskInfo;
    for (auto &iter : mapAicpuTask_) {
        for (auto &tempTask : iter.second) {
            *curTaskInfo = tempTask;
            curTaskInfo++;
        }
    }

    COND_PROC_RETURN_ERROR_MSG_INNER((aicpuTaskInfoPtr_ != nullptr),
        RT_ERROR_MODEL_BASE, DELETE_A(taskInfo), "Model load complete can only be executed once.");
    error = dev->Driver_()
        ->DevMemAlloc(&aicpuTaskInfoPtr_, aicpuTaskSize, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc aicpu task information failed, model_id=%d, "
               "device_id=%u, retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));
        DELETE_A(taskInfo);
        return error;
    }

    infoAicpuModel->aicpuTaskPtr = RtPtrToValue(aicpuTaskInfoPtr_);
    if (dev->Driver_()->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        error = dev->Driver_()->MemCopySync(aicpuTaskInfoPtr_, aicpuTaskSize,
            RtPtrToPtr<void *>(taskInfo), aicpuTaskSize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to memory copy aicpu task information, "
                "modelId=%d, deviceId=%u, retCode=%#x!", id_, dev->Id_(),
                static_cast<uint32_t>(error));
        }
        error = dev->Driver_()->DevMemFlushCache(RtPtrToValue(aicpuTaskInfoPtr_),
            static_cast<size_t>(aicpuTaskSize));
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to flush aicpu task information, "
                "modelId=%d, deviceId=%u, retCode=%#x!", id_, dev->Id_(),
                static_cast<uint32_t>(error));
        }
    } else {
        error = dev->Driver_()->MemCopySync(aicpuTaskInfoPtr_, aicpuTaskSize,
            RtPtrToPtr<void *>(taskInfo), aicpuTaskSize, RT_MEMCPY_DEVICE_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to memory copy stream information, "
                "modelId=%d, deviceId=%u, retCode=%#x!", id_, dev->Id_(),
                static_cast<uint32_t>(error));
        }
    }

    DELETE_A(taskInfo);
    return RT_ERROR_NONE;

FAIL_ALLOC:
    DELETE_A(taskInfo);
    (void)dev->Driver_()->DevMemFree(aicpuTaskInfoPtr_, dev->Id_());
    aicpuTaskInfoPtr_ = nullptr;
    return error;
}

rtError_t Model::PacketQueueInfo(rtAicpuModelInfo_t * const aicpuModelInfoIn)
{
    rtError_t error;
    const uint64_t queueInfoSize = queueInfo_.size() * sizeof(rtModelQueueInfo_t);
    Device * const dev = context_->Device_();

    error = dev->Driver_()->DevMemAlloc(&queueInfoPtr_, queueInfoSize, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc stream info failed, modelId=%d, deviceId=%u, size=%" PRIu64 ", retCode=%#x!",
               id_, dev->Id_(), queueInfoSize, static_cast<uint32_t>(error));
        return error;
    }

    aicpuModelInfoIn->queueInfoPtr = RtPtrToValue(queueInfoPtr_);
    aicpuModelInfoIn->queueSize = static_cast<uint16_t>(queueInfo_.size());
    if (dev->Driver_()->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        error = dev->Driver_()->MemCopySync(queueInfoPtr_, queueInfoSize, &queueInfo_[0U],
            queueInfoSize, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to memory copy queue information, modelId=%d, deviceId=%u, "
            "size=%" PRIu64 "(bytes), retCode=%#x!", id_, dev->Id_(), queueInfoSize, static_cast<uint32_t>(error));
        error = dev->Driver_()->DevMemFlushCache(RtPtrToValue(queueInfoPtr_), static_cast<size_t>(queueInfoSize));
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to flush queue information, modelId=%d, deviceId=%u, "
            "size=%" PRIu64 "(bytes), retCode=%#x!", id_, dev->Id_(), queueInfoSize, static_cast<uint32_t>(error));
    } else {
        error = dev->Driver_()->MemCopySync(queueInfoPtr_, queueInfoSize,
            &queueInfo_[0U], queueInfoSize, RT_MEMCPY_DEVICE_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Failed to copy queue information, modelId=%d, deviceId=%u, "
            "size=%" PRIu64 "(bytes), retCode=%#x!", id_, dev->Id_(), queueInfoSize, static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;

    FAIL_ALLOC:
        (void)dev->Driver_()->DevMemFree(queueInfoPtr_, dev->Id_());
        queueInfoPtr_ = nullptr;
        return error;
}

rtError_t Model::PacketAicpuModelInfo()
{
    rtAicpuModelInfo_t infoAicpuModel;
    rtError_t error;

    Device * const dev = context_->Device_();

    infoAicpuModel.moduleID = Id_();
    infoAicpuModel.tsId = dev->DevGetTsId();
    infoAicpuModel.streamInfoNum = static_cast<uint16_t>(streams_.size());
    infoAicpuModel.aicpuTaskNum = 0U;
    infoAicpuModel.queueSize = 0U;
    for (auto &iter : mapAicpuTask_) {
        infoAicpuModel.aicpuTaskNum += static_cast<uint16_t>(iter.second.size());
    }

    if (infoAicpuModel.streamInfoNum > 0U) {
        error = PacketAllStreamInfo(&infoAicpuModel);
        if (error != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Packet all stream info, modelId=%d, deviceId=%u, retCode=%#x!",
                id_, dev->Id_(), static_cast<uint32_t>(error));
            return error;
        }
    }

    if (infoAicpuModel.aicpuTaskNum > 0U) {
        error = PacketAicpuTaskInfo(&infoAicpuModel);
        ERROR_GOTO_MSG_INNER(error, PACKAGE_AICPU_FAIL,
            "Packet aicpu task information failed, modelId=%d, deviceId=%u, "
            "retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));
    }

    if (queueInfo_.size() > 0U) {
        error = PacketQueueInfo(&infoAicpuModel);
        ERROR_GOTO_MSG_INNER(error, PACKAGE_QUEUE_FAIL, "Packet queue information failed, modelId=%d, deviceId=%u,"
            "retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));
    }

    if (dev->Driver_()->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        error = dev->Driver_()->MemCopySync(aicpuModelInfo_, sizeof(rtAicpuModelInfo_t),
            RtPtrToPtr<void *>(&infoAicpuModel), sizeof(rtAicpuModelInfo_t), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, FAIL, "Copy stream information failed, modelId=%d, deviceId=%u, "
            "retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));

        error = dev->Driver_()->DevMemFlushCache(RtPtrToValue(aicpuModelInfo_), sizeof(rtAicpuModelInfo_t));
        ERROR_GOTO_MSG_INNER(error, FAIL, "Flush stream information failed, modelId=%d, deviceId=%u, "
            "retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));
    } else {
        error = dev->Driver_()->MemCopySync(aicpuModelInfo_, sizeof(rtAicpuModelInfo_t),
            RtPtrToPtr<void *>(&infoAicpuModel), sizeof(rtAicpuModelInfo_t), RT_MEMCPY_DEVICE_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, FAIL, "Copy stream information failed, modelId=%d, deviceId=%u, "
            "retCode=%#x!", id_, dev->Id_(), static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
FAIL:
    (void)dev->Driver_()->DevMemFree(queueInfoPtr_, dev->Id_());
    queueInfoPtr_ = nullptr;
PACKAGE_QUEUE_FAIL:
    (void)dev->Driver_()->DevMemFree(aicpuTaskInfoPtr_, dev->Id_());
    aicpuTaskInfoPtr_ = nullptr;
PACKAGE_AICPU_FAIL:
    (void)dev->Driver_()->DevMemFree(streamInfoPtr_, dev->Id_());
    streamInfoPtr_ = nullptr;
    return error;
}

bool Model::NeedLoadAicpuModelTask()
{
    return ((ModelExecuteType() == EXECUTOR_AICPU) && (aicpuTaskInfoPtr_ != nullptr));
}
uint32_t Model::ModelExecuteType()
{
    if (GetModelExecutorType() == EXECUTOR_AICPU) {
        return EXECUTOR_AICPU;
    }

    if (GetModelExecutorType() == EXECUTOR_TS) {
        for (Stream * const stm : streams_) {
            if ((IsModelHeadStream(stm)) &&
                ((stm->Flags() & RT_STREAM_AICPU) != 0U)) {
                SetModelExecutorType(EXECUTOR_NONE);
                return EXECUTOR_NONE;
            }
        }
        return EXECUTOR_TS;
    }
#if (!defined(CFG_VECTOR_CAST))
    const bool useAicpuExcutor = std::any_of(streams_.begin(), streams_.end(), [&](Stream * const stm) {
        return (IsModelHeadStream(stm)) && ((stm->Flags() & RT_STREAM_AICPU) != 0U);
    });
    if (useAicpuExcutor) {
        SetModelExecutorType(EXECUTOR_AICPU);
        return EXECUTOR_AICPU;
    }
#endif
    SetModelExecutorType(EXECUTOR_TS);
    return EXECUTOR_TS;
}

// if last Synchronize timeout, need Synchronize here
void Model::SyncExeStream(void) const
{
    auto * const exeStm = GetExeStream();
    if ((exeStm != nullptr) && exeStm->GetNeedSyncFlag()) {
        const rtError_t ret = exeStm->Synchronize(false, 100); // 100 wait 100ms
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_DEBUG, "In model abort, Synchronize return is %d.", ret);
        }
        exeStm->SetNeedSyncFlag(false);
    }
}

rtError_t Model::ModelAbort()
{
    rtError_t error;
    Stream *streamObj = nullptr;
    Device * const dev = context_->Device_();
    // stars model abort to ts
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *executeTask = nullptr;
    if (dev->IsStarsPlatform() && (ModelExecuteType() != EXECUTOR_AICPU)) {
        RT_LOG(RT_LOG_DEBUG, "Submit abort task to ts");
        if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM)) {
            error = context_->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &streamObj);
            ERROR_RETURN_MSG_INNER(error, "Fail to create model abort stream, retCode=%#x!",
                                   static_cast<uint32_t>(error));
        } else if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
            dev->GetCtrlSQ().SendModelAbortMsg(this);
            SyncExeStream();
            return RT_ERROR_NONE;
        } else {
            streamObj = context_->DefaultStream_();
        }

        executeTask = streamObj->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
        NULL_PTR_GOTO_MSG_INNER(executeTask, ERROR_DESTROY, error, errorReason);

        (void)ModelMaintainceTaskInit(executeTask, MMT_MODEL_ABORT, this, streamObj, RT_MODEL_HEAD_STREAM, 0U);

        error = dev->SubmitTask(executeTask);
        if (error != RT_ERROR_NONE) {
            goto ERROR_RECYCLE;
        }

        error = streamObj->Synchronize();
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to synchronize model abort stream, retCode=%#x!",
                            static_cast<uint32_t>(error));
        if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM)) {
            error = context_->StreamDestroy(streamObj);
            ERROR_RETURN_MSG_INNER(error, "Failed to destroy model abort stream, retCode=%#x!",
                                   static_cast<uint32_t>(error));
        }

        SyncExeStream();
        return RT_ERROR_NONE;
    }

    error = context_->StreamCreate(static_cast<uint32_t>(RT_STREAM_PRIORITY_DEFAULT), 0U, &streamObj);
    ERROR_RETURN_MSG_INNER(error, "Abort model, fail to create stream, retCode=%#x!", static_cast<uint32_t>(error));

    executeTask = streamObj->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_TO_AICPU, errorReason);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(executeTask == nullptr, ERROR_DESTROY, error,
        errorReason, "Model abort failed, task is NULL.");

    (void)ModelToAicpuTaskInit(executeTask, Id_(), static_cast<uint32_t>(TS_AICPU_MODEL_ABORT), executorFlag_,
                               RtPtrToValue(aicpuModelInfo_));

    error = dev->SubmitTask(executeTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit task, retCode=%#x!", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_DEBUG, "Submit task to ts, model_id=%u, executor_flag=%u, stream_id=%d.",
           Id_(), executorFlag_, streamObj->Id_());
    error = streamObj->Synchronize();
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to synchronize model abort stream, retCode=%#x!",
                         static_cast<uint32_t>(error));

    error = context_->StreamDestroy(streamObj);
    ERROR_RETURN_MSG_INNER(error, "Failed to destroy model abort stream, retCode=%#x!", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(executeTask);
ERROR_DESTROY:
    if (streamObj != context_->DefaultStream_()) {
        (void)context_->StreamDestroy(streamObj);
    }
    return error;
}

rtError_t Model::BindQueue(const uint32_t queueId, const rtModelQueueFlag_t flag)
{
    rtModelQueueInfo_t info;
    info.queueID = queueId;
    info.flag = static_cast<uint32_t>(flag);
    queueInfo_.push_back(info);

    return RT_ERROR_NONE;
}

rtError_t Model::MallocDevString(const char_t * const str, void **ptr) const
{
    NULL_PTR_RETURN_MSG(str, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(ptr, RT_ERROR_INVALID_VALUE);
    const size_t devStrLen = strnlen(str, MALLOC_DEV_NAME_STRING_MAX);
    COND_RETURN_ERROR_MSG_INNER(devStrLen == 0UL, RT_ERROR_INVALID_VALUE,
        "Malloc device string failed, stream length must be greater than 0.");

    const size_t devStrBufLen = devStrLen + 1UL;
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    rtError_t error = deviceDrv->DevMemAlloc(ptr, devStrBufLen, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc device string failed, string=%s, kind=%d(RT_MEMORY_DEFAULT), "
                                       "retCode=%d!", str, RT_MEMORY_DEFAULT, static_cast<uint32_t>(error));
        return error;
    }

    error = deviceDrv->MemSetSync(*ptr, devStrBufLen, 0U, devStrBufLen);
    if (error != RT_ERROR_NONE) {
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Memset string failed, string=%s, size=%zu, retCode=%#x!",
                             str, devStrBufLen, static_cast<uint32_t>(error));
    }

    error = deviceDrv->MemCopySync(*ptr, devStrLen, str, devStrLen, RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Memory copy string failed, string=%s, size=%zu, retCode=%#x!",
                             str, devStrLen, static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;

FAIL_ALLOC:
    (void)deviceDrv->DevMemFree(*ptr, dev->Id_());
    *ptr = nullptr;
    return error;
}

rtError_t Model::MallocDevValue(const void * const data, const uint32_t size, void **ptr) const
{
    NULL_PTR_RETURN_MSG(data, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(ptr, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(size == 0U, RT_ERROR_INVALID_VALUE,
        "Malloc device value failed, data size(%u) must be greater than 0.", size);

    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();

    rtError_t error = deviceDrv->DevMemAlloc(ptr, static_cast<uint64_t>(size), RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc device value failed, size=%u, kind=%u(RT_MEMORY_DEFAULT), "
                                       "retCode=%#x!", size, RT_MEMORY_DEFAULT, static_cast<uint32_t>(error));
        return error;
    }

    error = deviceDrv->MemSetSync(*ptr, static_cast<uint64_t>(size), 0U, static_cast<uint64_t>(size));
    if (error != RT_ERROR_NONE) {
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC, "Memset value failed, size=%u, retCode=%#x!", size,
                             static_cast<uint32_t>(error));
    }

    error = deviceDrv->MemCopySync(
        *ptr, static_cast<uint64_t>(size), data, static_cast<uint64_t>(size), RT_MEMCPY_HOST_TO_DEVICE);
    if (error != RT_ERROR_NONE) {
        ERROR_GOTO_MSG_INNER(error, FAIL_ALLOC,
            "Memory copy value failed, size=%u(bytes), kind=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x!",
            size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;

FAIL_ALLOC:
    (void)deviceDrv->DevMemFree(*ptr, dev->Id_());
    *ptr = nullptr;
    return error;
}

rtError_t Model::LoadCompleteByCallAiCpuIntf()
{
    rtError_t rtError = RT_ERROR_NONE;
    rtError_t error = PacketAicpuModelInfo();
    ERROR_RETURN_MSG_INNER(error, "Failed to packet aicpu model task.");
    if (NeedLoadAicpuModelTask()) {
        COND_RETURN_ERROR_MSG_INNER(endGraphNum_ != 1U, RT_ERROR_MODEL_ENDGRAPH,
            "Load complete by call aicpu(tf) failed, endGraphNum(%u) must be equal to 1", endGraphNum_);
    }
    Stream * const defaultStream = context_->DefaultStream_();
    Device * const dev = defaultStream->Device_();
    TaskFactory * const curTaskFactory = dev->GetTaskFactory();

    /* Mini should notify TS model load success for benchmarks,
    and decoupling model load with NPU power for lite */
    TaskInfo *maintainceTask = nullptr;
    TaskInfo submitTask = {};
    TaskInfo submitTaskInfo = {};
    rtError_t errorReason;

    COND_RETURN_ERROR_MSG_INNER(streams_.empty(), RT_ERROR_MODEL_STREAM, "model is empty.");
    // per sink defaultStream load complete for mini/cloud
    for (Stream * const sinkStream : streams_) {
        maintainceTask = sinkStream->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
        NULL_PTR_RETURN_MSG(maintainceTask, errorReason);

        (void)ModelMaintainceTaskInit(maintainceTask, MMT_STREAM_LOAD_COMPLETE, this,
                                      sinkStream, RT_MODEL_HEAD_STREAM, firstTaskId_);

        error = dev->SubmitTask(maintainceTask);
        ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to submit stream load complete task, retCode=%#x!",
                             static_cast<uint32_t>(error));
        error = sinkStream->Synchronize();
        if (unlikely((error != RT_ERROR_NONE) && (rtError == RT_ERROR_NONE))) {
            rtError = error;
            RT_LOG(RT_LOG_WARNING, "Synchronize Stream fail, retCode=%#x!", static_cast<uint32_t>(error));
        }
    }

    maintainceTask = defaultStream->AllocTask(&submitTaskInfo, TS_TASK_TYPE_MODEL_MAINTAINCE, errorReason);
    NULL_PTR_RETURN(maintainceTask, errorReason);

    (void)ModelMaintainceTaskInit(maintainceTask, MMT_MODEL_PRE_PROC, this,
        defaultStream, RT_MODEL_HEAD_STREAM, firstTaskId_);

    error = dev->SubmitTask(maintainceTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to submit model pre proc task, retCode=%#x!",
                         static_cast<uint32_t>(error));

    SetNeedSubmitTask(true);

    if (NeedLoadAicpuModelTask()) {
        error = dev->AicpuModelLoad(aicpuModelInfo_);
        ERROR_RETURN_MSG_INNER(error, "Failed to load aicpu model task, mode_id=%d, retCode=%#x!", id_,
                               static_cast<uint32_t>(error));
    }

    error = defaultStream->Synchronize();
    if (unlikely((error != RT_ERROR_NONE) && (rtError == RT_ERROR_NONE))) {
        rtError = error;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Synchronize defaultStream fail");
    }

    return rtError;

ERROR_TASK:
    (void)curTaskFactory->Recycle(maintainceTask);
    return rtError;
}

rtError_t Model::LabelAlloc(Label * const labelIn, uint16_t &labelId)
{
    const std::unique_lock<std::mutex> lk(labelMapMutex_);
    COND_RETURN_ERROR_MSG_INNER(isModelDelete_, RT_ERROR_LABEL_ALLOCATOR,
        "Label alloc failed, can't alloc label after model tear down.");
    const rtError_t ret = labelAllocator_->LabelIdAlloc(labelId);
    ERROR_RETURN_MSG_INNER(ret, "Failed to alloc label id.");
    labelMap_[labelId] = labelIn;
    return ret;
}

rtError_t Model::LabelFree(const uint16_t labelId)
{
    const std::unique_lock<std::mutex> lk(labelMapMutex_);
    COND_RETURN_WARN(isModelDelete_, RT_ERROR_LABEL_MODEL_RELEASED,
        "don't free label resource after model tear down, label_id=%u.", static_cast<uint32_t>(labelId));
    (void)labelMap_.erase(labelId);
    return labelAllocator_->LabelIdFree(labelId);
}

rtError_t Model::CmoIdAlloc(const uint32_t logicId, uint16_t &cmoId)
{
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_CMO_BARRIER)) {
        return RT_ERROR_NONE;
    }

    int32_t tempId = 0;
    const std::unique_lock<std::mutex> lk(cmoIdMapMutex_);
    const auto it = logicIdToCMOIdMap_.find(logicId);
    if (it == logicIdToCMOIdMap_.end()) {
        const rtError_t error = deviceDrv->CmoIdAlloc(&tempId, dev->Id_(), dev->DevGetTsId());
        ERROR_RETURN(error, "Failed to alloc cmo id, retCode=%#x.", static_cast<uint32_t>(error));
        cmoId = static_cast<uint16_t>(tempId);
        logicIdToCMOIdMap_[logicId] = cmoId;
    } else {
        cmoId = it->second;
    }
    RT_LOG(RT_LOG_INFO, "alloc com id success, logicId=%u, cmoId=%hu.", logicId, cmoId);
    return RT_ERROR_NONE;
}

rtError_t Model::GetCmoId(const uint32_t logicId, uint16_t &cmoId)
{
    Device * const dev = context_->Device_();
    if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_CMO_BARRIER)) {
        return RT_ERROR_NONE;
    }

    const std::unique_lock<std::mutex> lk(cmoIdMapMutex_);
    const auto iter = logicIdToCMOIdMap_.find(logicId);
    if (iter == logicIdToCMOIdMap_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not find cmo id map by logicId=%u.", logicId);
        return RT_ERROR_MODEL_EXIT_ID;
    }
    cmoId = iter->second;
    return RT_ERROR_NONE;
}

void Model::CmoIdFree(void)
{
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_CMO_BARRIER)) {
        return;
    }

    const std::unique_lock<std::mutex> lk(cmoIdMapMutex_);
    for (auto it = logicIdToCMOIdMap_.begin(); it != logicIdToCMOIdMap_.end(); it++) {
        const uint16_t tempCmoId = it->second;
        (void)deviceDrv->CmoIdFree(static_cast<int32_t>(tempCmoId), dev->Id_(), dev->DevGetTsId());
    }
    logicIdToCMOIdMap_.clear();
    return;
}

rtError_t Model::AicpuModelSetExtId(const uint32_t modelId, const uint32_t extId)
{
    aicpu::AicpuExtendInfo extInfoMsg;

    extInfoMsg.msgType = static_cast<uint8_t>(aicpu::AicpuExtInfoMsgType::EXT_MODEL_ID_MSG_TYPE);
    extInfoMsg.version = 0U;
    extInfoMsg.modelIdMap.modelId = modelId;
    extInfoMsg.modelIdMap.extendModelId = extId;

    rtKernelLaunchNames_t launchNames;
    launchNames.soName = nullptr;
    launchNames.kernelName = AICPU_EXT_INFO_CONFIG_OP_NAME;
    launchNames.opName = AICPU_EXT_INFO_CONFIG_OP_NAME;
    RT_LOG(RT_LOG_DEBUG, "Set task to aicpu, modelId=%u, extId=%u.", modelId, extId);
    const auto retErr = SendTaskToAicpu(&launchNames, 1U,
                                        static_cast<const void *>(&extInfoMsg),
                                        static_cast<uint32_t>(sizeof(aicpu::AicpuExtendInfo)), 0U);
    return retErr;
}

rtError_t Model::SendTaskToAicpu(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
                                 const void * const args, const uint32_t argsSize, const uint32_t flag)
{
    Device * const dev = context_->Device_();
    Stream * const stm = dev->PrimaryStream_();
    NULL_PTR_RETURN(stm, RT_ERROR_STREAM_NULL);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN(kernTask, errorReason);

    std::function<void()> const devTaskRecycle = [&dev, &kernTask]() {
        (void)dev->GetTaskFactory()->Recycle(kernTask);
    };
    ArgLoader * const devArgLdr = dev->ArgLoader_();
    ArgLoaderResult result{};
    ScopeGuard taskGuard(devTaskRecycle);
    // Init task
   AicpuTaskInit(kernTask, static_cast<uint16_t>(coreDim), flag);
    RT_LOG(RT_LOG_INFO, "flag=%u, kernelFlag=0x%x, blkdim=%u, soName=%s, kernel_name=%s.",
        flag, kernTask->u.aicpuTaskInfo.comm.kernelFlag, kernTask->u.aicpuTaskInfo.comm.dim,
        launchNames->soName != nullptr ? launchNames->soName : "null",
        launchNames->kernelName != nullptr ? launchNames->kernelName : "null");

    // Set args for task
    rtArgsEx_t argsInfo = {};
    argsInfo.args = const_cast<void *>(args);
    argsInfo.argsSize = argsSize;
    rtError_t retErr = devArgLdr->LoadCpuKernelArgs(&argsInfo, stm, &result);
    ERROR_RETURN(retErr, "Failed to load cpu Kernel args , retCode=%d.", retErr);

    SetArgs(kernTask, result.kerArgs, argsSize, nullptr, 0U, result.handle);
    result.handle = nullptr;

    retErr = FillKernelLaunchPara(launchNames, kernTask, dev->ArgLoader_());
    ERROR_RETURN(retErr, "Failed to fill kernel launch para, retCode=%d.", retErr);

    // Set kernel type and flags
    kernTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_AICPU);
    // Submit task
    retErr = dev->SubmitTask(kernTask);
    ERROR_RETURN(retErr, "Failed to submit kernel task, retCode=%d.", retErr);
    taskGuard.ReleaseGuard();

    return stm->Synchronize();
}

uint32_t Model::ModelGetNodes(void) const
{
    uint32_t nodeNum = 0U;
    for (Stream * const stm : streams_) {
        nodeNum += stm->GetDelayRecycleTaskSqeNum();
    }

    return nodeNum;
}

rtError_t Model::ModelDebugDotPrint(void) const
{
    const uint32_t deviceId = context_->Device_()->Id_();
    RT_LOG(RT_LOG_EVENT, "model dot print begin, device_id=%u, model_id=%d.", deviceId, id_);

    for (Stream * const stm : streams_) {
        stm->DebugDotPrintForModelStm();
    }

    if (modelType_ == RT_MODEL_CAPTURE_MODEL) {
        const CaptureModel * const captureMdl = dynamic_cast<CaptureModel const *>(this);
        captureMdl->DebugDotPrintTaskGroups(deviceId);
    }

    RT_LOG(RT_LOG_EVENT, "model dot print end, device_id=%u, model_id=%d.", deviceId, id_);

    return RT_ERROR_NONE;
}

rtError_t Model::ModelDebugJsonPrint(const char* path, const unsigned int flags) const
{
    (void)flags;
    const uint32_t deviceId = context_->Device_()->Id_();
    RT_LOG(RT_LOG_EVENT, "model json print begin, device_id=%u, model_id=%d.", deviceId, id_);

    std::string realFilePath = RealPathForFileNotExists(path);
    std::ofstream outputFile(realFilePath);
    COND_RETURN_OUT_ERROR_MSG_CALL((!outputFile.is_open()), RT_ERROR_INVALID_VALUE,
        "Invalid JSON file path or failed to open %s", path);
    outputFile << "[\n";
    uint32_t streamCnt = 0;
    bool isLastStream = false;
    for (Stream * const stm : streams_) {
        streamCnt++;
        isLastStream = (streamCnt == streams_.size()) ? true : false;
        stm->DebugDotPrintForModelStm();
        stm->DebugJsonPrintForModelStm(outputFile, Id_(), isLastStream);
    }
    outputFile << "]";
    outputFile.close();

    if (modelType_ == RT_MODEL_CAPTURE_MODEL) {
        const CaptureModel * const captureMdl = dynamic_cast<CaptureModel const *>(this);
        captureMdl->DebugDotPrintTaskGroups(deviceId);
    }

    RT_LOG(RT_LOG_EVENT, "model json print end, device_id=%u, model_id=%d.", deviceId, id_);

    return RT_ERROR_NONE;
}

rtError_t Model::GetModelName(const uint32_t maxLen, char_t * const name) const
{
    const errno_t error = memcpy_s(name, static_cast<size_t>(maxLen), name_.c_str(), name_.length() + 1U);
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to model name failed, ret=%d, length=%zu.",
               error, name_.length() + 1U);
        return RT_ERROR_SEC_HANDLE;
    }
    return RT_ERROR_NONE;
}

rtError_t Model::UpdateSnapShotSqe(void)
{
    rtError_t error = RT_ERROR_NONE;
    for (Stream * const stm : streams_) {
        error = stm->UpdateSnapShotSqe();
        ERROR_RETURN_MSG_INNER(error,
            "update tasks failed, model id=%u, stream_id=%d, retCode=%d", Id_(), stm->Id_(), error);
    }
    return error;
}
rtError_t Model::MemWaitDevAlloc(void **devMem, const Device * const dev)
{
    const uint32_t ALLOC_MAX_NUM = PAGE_SIZE / MEM_WAIT_SPLIT_SIZE;
    rtError_t ret = RT_ERROR_NONE;
    const std::lock_guard<std::mutex> lock(memWaitMutex_);
    if (currentAddr_ == nullptr || allocTimes_ == ALLOC_MAX_NUM) {
        currentAddr_ = nullptr;
        allocTimes_ = 0;
        ret = dev->Driver_()->DevMemAlloc(&currentAddr_, PAGE_SIZE, RT_MEMORY_DDR, dev->Id_());
        COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "alloc dev memory failed, retCode=%#x, size=%" PRIu64 "(bytes), dev_id=%u",
                      ret, PAGE_SIZE, dev->Id_());
        devAddrList_.push_back(currentAddr_);
    }
    *devMem = RtValueToPtr<void*>((RtPtrToValue)(currentAddr_) + allocTimes_ * MEM_WAIT_SPLIT_SIZE);
    allocTimes_++;
    return RT_ERROR_NONE;
}

}
}
