/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under
 * the terms and conditions of CANN Open Software License Agreement Version 2.0
 * (the "License"). Please refer to the License for details. You may not use
 * this file except in compliance with the License. THIS SOFTWARE IS PROVIDED ON
 * AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS
 * FOR A PARTICULAR PURPOSE. See LICENSE in the root of the software repository
 * for the full text of the License.
 */

#include "api_impl_event.hpp"

#include "ipc_event.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "context_manage.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImplEvent::IpcOpenEventHandle(rtIpcEventHandle_t* handle, IpcEvent** const event)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        event, RT_ERROR_INVALID_VALUE, "Obtaining the event handle information and event pointer");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        handle, RT_ERROR_INVALID_VALUE, "Obtaining the event handle information and event pointer");
    RT_LOG(RT_LOG_INFO, "IpcOpenEventHandle start");

    Runtime::Instance()->CallApiBegin(RT_PROF_API_OPEN_EVENT_HANDLE);

    rtError_t error = RT_ERROR_NONE;
    do {
        Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
        if (!ContextManage::CheckContextIsValid(curCtx)) {
            ContextManage::ReportContextValidationError();
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }

        Device* const dev = curCtx->Device_();
        *event = new (std::nothrow) IpcEvent(dev, RT_EVENT_IPC, curCtx);
        if (*event == nullptr) {
            error = RT_ERROR_EVENT_NEW;
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(IpcEvent), "new");
            break;
        }
        RT_LOG(RT_LOG_INFO, "new event success");

        error = (*event)->IpcOpenEventHandle(handle);
        if (error != RT_ERROR_NONE) {
            DELETE_O(*event);
            RT_LOG(RT_LOG_ERROR, "IpcOpenEventHandle failed, retCode=%#x", error);
            break;
        }

        InitEmbeddedInnerHandle<Event>(*event);
    } while (false);

    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplEvent::IpcGetEventHandle(IpcEvent* const evt, rtIpcEventHandle_t* handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(handle, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    COND_RETURN_AND_MSG_OUTER(
        evt->GetEventFlag() != RT_EVENT_IPC, RT_ERROR_INVALID_VALUE, ErrorCode::EE1006,
        "Obtaining the IPC event handle", RtFmtMsg("Parameter evt.eventFlag_ value %" PRIu64, evt->GetEventFlag()),
        "Only IPC events are supported");
    Runtime::Instance()->CallApiBegin(RT_PROF_API_GET_EVENT_HANDLE);
    const rtError_t error = evt->IpcGetEventHandle(handle);
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

} // namespace runtime
} // namespace cce
