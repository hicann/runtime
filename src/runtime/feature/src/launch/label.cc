/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "label.hpp"

#include "context.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_submit.hpp"
namespace cce {
namespace runtime {
LabelAllocator::LabelAllocator(const uint16_t labelMax)
    : NoCopy(),
      labelMaxNum_(labelMax),
      curInitLabelNum_(RT_MAX_LABEL_INIT_NUM)
{
    // init 64 label id first, add new id to list after alloc
    for (uint16_t i = 0U; i < RT_MAX_LABEL_INIT_NUM; i++) {
        labelIds_[i] = static_cast<uint16_t>(LABEL_FREE);
        freeLabelIdsList.push_back(i);
    }
}

rtError_t LabelAllocator::LabelIdAlloc(uint16_t &idAlloc)
{
    uint16_t labelId;
    mutex_.lock();
    while (!freeLabelIdsList.empty()) {
        labelId = freeLabelIdsList.front();
        freeLabelIdsList.pop_front();
        if (curInitLabelNum_ < labelMaxNum_) {
            labelIds_[curInitLabelNum_] = static_cast<uint16_t>(LABEL_FREE);
            freeLabelIdsList.push_back(curInitLabelNum_);
            curInitLabelNum_++;
        }

        /* labelId must be within [0, labelMaxNum_) */
        if ((labelId < labelMaxNum_) && (labelIds_[labelId] == static_cast<uint16_t>(LABEL_FREE))) {
            labelIds_[labelId] = static_cast<uint16_t>(LABEL_ALLOCATED);
            idAlloc = labelId;
            mutex_.unlock();
            return RT_ERROR_NONE;
        }
    }

    mutex_.unlock();
    return RT_ERROR_LABEL_ID;
}

rtError_t LabelAllocator::LabelIdFree(const uint16_t idFree)
{
    if (idFree >= labelMaxNum_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Invalid label id, label range is [0,%hu), current id=%hu!",
            labelMaxNum_, idFree);
        return RT_ERROR_LABEL_ID;
    }

    mutex_.lock();
    if (labelIds_[idFree] == static_cast<uint16_t>(LABEL_FREE)) {
        mutex_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Repeat free label id=%hu", idFree);
        return RT_ERROR_LABEL_FREE;
    }
    labelIds_[idFree] = static_cast<uint16_t>(LABEL_FREE);
    freeLabelIdsList.push_back(idFree);
    mutex_.unlock();

    return RT_ERROR_NONE;
}

Label::Label(Model * const mdl)
    : NoCopy(),
      model_(mdl),
      labelId_(MAX_UINT16_NUM),
      stream_(nullptr),
      context_(nullptr),
      setFlag_(false),
      devDstAddr_(nullptr)
{
    mgrType_ = (mdl == nullptr) ? LABEL_MGR_TYPE_RT : LABEL_MGR_TYPE_MODEL;
}

Label::~Label() noexcept
{
    (void)LabelIdFree(labelId_);
    setFlag_ = false;
    model_ = nullptr;
}

rtError_t Label::LabelIdAlloc(uint16_t &idAlloc)
{
    rtError_t ret;
    if (mgrType_ == LABEL_MGR_TYPE_MODEL) {
        NULL_PTR_RETURN_MSG(model_, RT_ERROR_MODEL_NULL);
        ret = model_->LabelAlloc(this, idAlloc);
        if (ret != RT_ERROR_NONE) {
            model_ = nullptr;
        } else {
            RT_LOG(RT_LOG_INFO, "label id alloc succ, label_id=%hu.", idAlloc);
        }
    } else {
        LabelAllocator * const allocatorPtr = Runtime::Instance()->LabelAllocator_();
        NULL_PTR_RETURN_MSG(allocatorPtr, RT_ERROR_LABEL_ALLOCATOR);
        ret = allocatorPtr->LabelIdAlloc(idAlloc);
        RT_LOG(RT_LOG_INFO, "label id alloc end, labelId=%hu.", idAlloc);
    }
    return ret;
}

rtError_t Label::LabelIdFree(const uint16_t idFree)
{
    rtError_t ret;
    if (mgrType_ == LABEL_MGR_TYPE_MODEL) {
        COND_RETURN_WARN(model_ == nullptr, RT_ERROR_NONE,
                         "model is null, don't need free label, label_id=%hu.", idFree);
        ret = model_->LabelFree(idFree);
        if (ret == RT_ERROR_LABEL_MODEL_RELEASED) {
            model_ = nullptr;
            RT_LOG(RT_LOG_WARNING, "model released, don't need free label, label_id=%hu.", idFree);
            return RT_ERROR_NONE;
        }
    } else {
        LabelAllocator * const allocatorPtr = Runtime::Instance()->LabelAllocator_();
        NULL_PTR_RETURN_MSG(allocatorPtr, RT_ERROR_LABEL_ALLOCATOR);
        ret = allocatorPtr->LabelIdFree(idFree);
    }
    return ret;
}

rtError_t Label::Setup(Context * const curCtx)
{
    context_ = curCtx;
    return LabelIdAlloc(labelId_);
}

rtError_t Label::Set(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_STREAM_MODEL);
    COND_RETURN_ERROR_MSG_INNER((mgrType_ == LABEL_MGR_TYPE_MODEL) && (stm->Model_() != model_),
        RT_ERROR_LABEL_MODEL, "Set label failed, stream don't bind to label mdl!");
    COND_RETURN_ERROR_MSG_INNER((stream_ != nullptr) && (stream_ != stm), RT_ERROR_LABEL_STREAM,
        "Set label failed, label stream not same with create stream!");
    COND_RETURN_ERROR_MSG_INNER(setFlag_, RT_ERROR_LABEL_SET,
        "Set label failed, label already set!");

    Device * const dev = context_->Device_();
    COND_RETURN_ERROR_MSG_INNER(((devDstAddr_ == nullptr) &&
        (dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_MORE_LABEL))),
        RT_ERROR_LABEL_PHY_ADDR_NULL,
        "Need call label list cpy api before set label task.");

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *labelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_LABEL_SET, errorReason);
    NULL_PTR_RETURN_MSG(labelTask, errorReason);

    rtError_t error = LabelSetTaskInit(labelTask, labelId_, devDstAddr_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Init label set task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    error = dev->SubmitTask(labelTask, context_->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Submit label set task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    setFlag_ = true;
    stream_ = stm;
    stm->InsertLabelList(this);

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(labelTask);
    return error;
}

rtError_t Label::SetStream(Stream * const stm)
{
    COND_RETURN_ERROR_MSG_INNER(stream_ != nullptr, RT_ERROR_LABEL_STREAM, "Create label failed, already create!");

    stream_ = stm;
    return RT_ERROR_NONE;
}

rtError_t Label::Switch(const void * const ptr, const rtCondition_t condition, const uint32_t val, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_LABEL_MODEL);

    Device * const dev = context_->Device_();

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *labelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_LABEL_SWITCH, errorReason);
    NULL_PTR_RETURN_MSG(labelTask, errorReason);

    rtError_t error = LabelSwitchTaskInit(labelTask, ptr, condition, val, labelId_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Init label switch task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    error = dev->SubmitTask(labelTask, context_->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Submit label switch task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(labelTask, stm->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(labelTask);
    return error;
}

rtError_t Label::Goto(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_LABEL_MODEL);

    Device * const dev = context_->Device_();

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *labelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_LABEL_GOTO, errorReason);
    NULL_PTR_RETURN_MSG(labelTask, errorReason);

    rtError_t error = LabelGotoTaskInit(labelTask, labelId_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Init label goto task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    error = dev->SubmitTask(labelTask, context_->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Submit label goto task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(labelTask, stm->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(labelTask);
    return error;
}

rtError_t Label::StreamGoto(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_LABEL_MODEL);

    Device * const dev = context_->Device_();
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;

    TaskInfo *labelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_LABEL_GOTO, errorReason);
    NULL_PTR_RETURN_MSG(labelTask, errorReason);

    (void)StreamLabelGotoTaskInit(labelTask, labelId_);
    error = dev->SubmitTask(labelTask, context_->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Submit stream label goto task failed, retCode=%#x!",
                         static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(labelTask, stm->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(labelTask);
    return error;
}

rtError_t Label::SetLabelDevAddr(void * const addr)
{
    COND_RETURN_ERROR_MSG_INNER(devDstAddr_ != nullptr, RT_ERROR_SAME_LABELS_IN_SWITCH,
        "Label addr repeat setting, maybe have same labels in switch task.");
    devDstAddr_ = addr;
    return RT_ERROR_NONE;
}
}
}
