/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_desc.hpp"
#include "api_impl_v201.hpp"

#include "context.hpp"
#include "dqs_c.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {

namespace {
constexpr uint32_t V201_TASK_SN_STREAM_ID_MASK = 0xFFFFU;
constexpr uint32_t V201_TASK_SN_TASK_ID_SHIFT = 16U;

uint32_t GetTaskIdFromTaskSnV201(const uint32_t streamId, const uint32_t taskSn)
{
    if ((taskSn & V201_TASK_SN_STREAM_ID_MASK) != (streamId & V201_TASK_SN_STREAM_ID_MASK)) {
        return taskSn;
    }
    return taskSn >> V201_TASK_SN_TASK_ID_SHIFT;
}

bool AllocTaskSnV201(
    const Runtime::TaskSnHookOp op, const TaskInfo* const task, const uint32_t streamId, const uint32_t taskId,
    uint32_t& taskSn)
{
    if (op == Runtime::TaskSnHookOp::ALLOC_TASK_SN) {
        if ((task == nullptr) || (task->stream == nullptr)) {
            return false;
        }
        taskSn = ((static_cast<uint32_t>(task->id) << V201_TASK_SN_TASK_ID_SHIFT) |
                  (static_cast<uint32_t>(task->stream->Id_()) & V201_TASK_SN_STREAM_ID_MASK)) &
                 0x7FFFFFFFU;
        return true;
    }

    if (op == Runtime::TaskSnHookOp::MODEL_TASK_ID) {
        if (task == nullptr) {
            return false;
        }
        taskSn = static_cast<uint32_t>(task->id);
        return true;
    }

    if (op == Runtime::TaskSnHookOp::THREAD_LOCAL_TASK_ID) {
        taskSn = GetTaskIdFromTaskSnV201(streamId, taskId);
        return true;
    }
    return false;
}
} // namespace

ApiImplV201::ApiImplV201()
{
    Runtime* const runtime = Runtime::runtime_;
    if (runtime != nullptr) {
        runtime->SetAllocTaskSnHook(&AllocTaskSnV201);
    }
}

// dqs
rtError_t ApiImplV201::LaunchDqsTask(Stream* const stm, const rtDqsTaskCfg_t* const taskCfg)
{
    return DqsLaunchTask(stm, taskCfg);
}

rtError_t ApiImplV201::EventRecord(Event* const evt, Stream* const stm, const uint32_t flag)
{
    if (flag == RT_EVENT_RECORD_EXTERNAL) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ApiImplDavid::EventRecord(evt, stm, flag);
}

rtError_t ApiImplV201::StreamWaitEvent(Stream* const stm, Event* const evt, const uint32_t timeout, const uint32_t flag)
{
    if (flag == RT_EVENT_WAIT_EXTERNAL) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ApiImplDavid::StreamWaitEvent(stm, evt, timeout, flag);
}

// model
rtError_t ApiImplV201::ModelAttrSet(Model* const mdl, const rtModelAttr attrId, void* const value)
{
    RT_LOG(RT_LOG_INFO, "ModelAttrSet, attrId=%d.", static_cast<int32_t>(attrId));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        mdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Setting a model attribute");
    if (attrId != RT_MODEL_ATTR_SCH_MODE) {
        RT_LOG_OUTER_MSG_WITH_FUNC(
            ErrorCode::EE1003, ModelAttrToString(attrId), "attrId",
            RtFmtMsg("RT_MODEL_ATTR_SCH_MODE(%d)", static_cast<int32_t>(RT_MODEL_ATTR_SCH_MODE)));
        return RT_ERROR_INVALID_VALUE;
    }
    const rtMdlSchMode schMode = *(static_cast<rtMdlSchMode*>(value));
    if (schMode == RT_MDL_SCH_EXCLUSIVE) {
        mdl->SetSchMode(ModelSchedMode::RT_MODEL_SCHED_EXCLUSIVE);
    } else {
        mdl->SetSchMode(ModelSchedMode::RT_MODEL_SCHED_NORMAL);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
