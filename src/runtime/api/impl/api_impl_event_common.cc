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

#include "event.hpp"
#include "ipc_event.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"

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
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
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

    Context* const curCtx = Runtime::Instance()->CurrentContext();
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

rtError_t ApiImplEvent::EventElapsedTime(float32_t* const retTime, Event* const startEvt, Event* const endEvt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        retTime, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        startEvt, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        endEvt, RT_ERROR_INVALID_VALUE, "Computing the elapsed time between two events");
    COND_RETURN_AND_MSG_OUTER(
        startEvt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016,
        "Computing the elapsed time between two events",
        RtFmtMsg("StartEvent %d during the capture stage is not supported", startEvt->EventId_()));
    COND_RETURN_AND_MSG_OUTER(
        endEvt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, ErrorCode::EE1016,
        "Computing the elapsed time between two events",
        RtFmtMsg("EndEvent %d during the capture stage is not supported", endEvt->EventId_()));
    COND_RETURN_WARN(
        (startEvt->GetEventFlag() == RT_EVENT_EXTERNAL || endEvt->GetEventFlag() == RT_EVENT_EXTERNAL),
        RT_ERROR_FEATURE_NOT_SUPPORT, "The external event does not support getting elapsed time.");
    COND_RETURN_WARN(
        (startEvt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC) ||
         endEvt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "IPC events are not supported by the rtEventElapsedTime API");
    return endEvt->ElapsedTime(retTime, startEvt);
}

rtError_t ApiImplEvent::EventGetTimeStamp(uint64_t* const retTime, Event* const evt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(retTime, RT_ERROR_INVALID_VALUE, "Obtaining the event execution end time");
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
    return evt->GetTimeStamp(retTime);
}

} // namespace runtime
} // namespace cce
