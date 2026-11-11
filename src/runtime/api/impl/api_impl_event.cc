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

#include <string>
#include "api_impl_event.hpp"

#include "event.hpp"
#include "device.hpp"
#include "ipc_event.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "context_manage.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImplEvent::GetEventID(Event* const evt, uint32_t* const evtId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Obtaining the event ID");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evtId, RT_ERROR_INVALID_VALUE, "Obtaining the event ID");
    COND_RETURN_WARN(
        evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC), RT_ERROR_FEATURE_NOT_SUPPORT,
        "IPC events are not supported by the rtGetEventID API");
    Runtime::Instance()->CallApiBegin(RT_PROF_API_GetEventID);
    const rtError_t error = evt->GetEventID(evtId);
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplEvent::EventQuery(Event* const evt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Event query");
    COND_RETURN_WARN(
        evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT, "The current mode is not supported, mode=%d",
        static_cast<int32_t>(evt->IsNewMode()));
    COND_RETURN_WARN(
        evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support querying status.");
    COND_RETURN_WARN(
        evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC), RT_ERROR_FEATURE_NOT_SUPPORT,
        "IPC events are not supported by the rtEventQuery API");
    COND_RETURN_AND_MSG_OUTER(
        evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016, "Event query",
        RtFmtMsg("Event (event_id=%d) during the capture stage is not supported", evt->EventId_()));

    Context* eventCtx = evt->Context_();
    if (eventCtx != nullptr) {
        const rtError_t error = eventCtx->CheckStatus();
        ERROR_RETURN(error, "context is aborted, status=%#x.", static_cast<uint32_t>(error));
    }
    return evt->Query();
}

rtError_t ApiImplEvent::EventQueryStatus(Event* const evt, rtEventStatus_t* const status)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Event status query");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(status, RT_ERROR_INVALID_VALUE, "Event status query");
    COND_RETURN_WARN(
        evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support querying status.");
    COND_RETURN_AND_MSG_OUTER(
        evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016, "Event status query",
        RtFmtMsg("Event (event_id=%d) during the capture stage is not supported", evt->EventId_()));

    Context* eventCtx = evt->Context_();
    if (eventCtx != nullptr) {
        const rtError_t error = eventCtx->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    *status = RT_EVENT_INIT;
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        return (dynamic_cast<IpcEvent*>(evt))->IpcEventQuery(status);
    }
    return evt->QueryEventStatus(status);
}

rtError_t ApiImplEvent::EventQueryWaitStatus(Event* const evt, rtEventWaitStatus_t* const status)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Event waiting status query");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(status, RT_ERROR_INVALID_VALUE, "Event waiting status query");
    COND_RETURN_WARN(
        evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT, "The current mode is not supported, mode=%d",
        static_cast<int32_t>(evt->IsNewMode()));
    COND_RETURN_WARN(
        evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support querying status.");
    COND_RETURN_WARN(
        evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC), RT_ERROR_FEATURE_NOT_SUPPORT,
        "IPC events are not supported by the rtEventQueryWaitStatus API");
    COND_RETURN_AND_MSG_OUTER(
        evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016, "Event waiting status query",
        RtFmtMsg("Event (event_id=%d) during the capture stage is not supported", evt->EventId_()));

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    rtError_t error = RT_ERROR_NONE;
    if (curCtx != nullptr) {
        Device* device = curCtx->Device_();
        (void)device->GetDevRunningState();
        error = device->GetDevStatus();
        COND_PROC_RETURN_ERROR_MSG_CALL(
            ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device->Id_())});
            , "Device[%u] fault, ret=%#x.", device->Id_(), error);
        error = device->GetDeviceStatus();
        ERROR_RETURN(error, "device_id=%d status=%d is abnormal.", device->Id_(), error);
        error = curCtx->GetFailureError();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    *status = EVENT_STATUS_NOT_READY;
    bool waitStatus = false;
    const bool isDisableThreadFlag = Runtime::Instance()->GetDisableThread();
    error = evt->QueryEventWaitStatus(isDisableThreadFlag, waitStatus);
    if (waitStatus) {
        *status = EVENT_STATUS_COMPLETE;
    }
    return error;
}

rtError_t ApiImplEvent::EventElapsedTime(float32_t* const timeInterval, Event* const startEvent, Event* const endEvent)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        timeInterval, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        startEvent, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        endEvent, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    COND_RETURN_AND_MSG_OUTER(
        startEvent->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016,
        "Computing the elapsed time between two events",
        RtFmtMsg("StartEvent %d during the capture stage is not supported", startEvent->EventId_()));
    COND_RETURN_AND_MSG_OUTER(
        endEvent->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016,
        "Computing the elapsed time between two events",
        RtFmtMsg("EndEvent %d during the capture stage is not supported", endEvent->EventId_()));
    COND_RETURN_WARN(
        (startEvent->GetEventFlag() == RT_EVENT_EXTERNAL || endEvent->GetEventFlag() == RT_EVENT_EXTERNAL),
        RT_ERROR_FEATURE_NOT_SUPPORT, "The external event does not support getting elapsed time.");
    COND_RETURN_WARN(
        (startEvent->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC) ||
         endEvent->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "IPC events are not supported by the rtEventElapsedTime API");
    return endEvent->ElapsedTime(timeInterval, startEvent);
}

rtError_t ApiImplEvent::EventGetTimeStamp(uint64_t* const timeStamp, Event* const evt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        timeStamp, RT_ERROR_INVALID_VALUE, "Obtaining the event execution end time");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Obtaining the event execution end time");
    COND_RETURN_WARN(
        evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support getting timestamp.");
    COND_RETURN_WARN(
        evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC), RT_ERROR_FEATURE_NOT_SUPPORT,
        "IPC events are not supported by the rtEventGetTimeStamp API");
    COND_RETURN_AND_MSG_OUTER(
        evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016, "Obtaining the event execution end time",
        RtFmtMsg("Event %d during the capture stage is not supported", evt->EventId_()));
    COND_RETURN_AND_MSG_OUTER(
        !evt->IsEventWithTimeline(), RT_ERROR_EVENT_TIMESTAMP_INVALID, ErrorCode::EE1017,
        "Obtaining an Event timestamp", "event",
        RtFmtMsg(
            "Event (event_id=%d) was created with flag %" PRIu64 ", which does not include RT_EVENT_TIME_LINE(8). "
            "Create the Event with RT_EVENT_TIME_LINE enabled",
            evt->EventId_(), evt->GetEventFlag()));
    return evt->GetTimeStamp(timeStamp);
}

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

rtError_t ApiImplEvent::IpcGetEventHandle(IpcEvent* const event, rtIpcEventHandle_t* handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(handle, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(event, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    COND_RETURN_AND_MSG_OUTER(
        event->GetEventFlag() != RT_EVENT_IPC, RT_ERROR_INVALID_VALUE, ErrorCode::EE1006,
        "Obtaining the IPC event handle", RtFmtMsg("Parameter event.eventFlag_ value %" PRIu64, event->GetEventFlag()),
        "Only IPC events are supported");
    Runtime::Instance()->CallApiBegin(RT_PROF_API_GET_EVENT_HANDLE);
    const rtError_t error = event->IpcGetEventHandle(handle);
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

} // namespace runtime
} // namespace cce
