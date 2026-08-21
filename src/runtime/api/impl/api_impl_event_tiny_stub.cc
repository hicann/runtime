/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_event.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImplEvent::GetEventID(Event* const evt, uint32_t* const evtId)
{
    UNUSED(evt);
    UNUSED(evtId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplEvent::EventQuery(Event* const evt)
{
    UNUSED(evt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplEvent::EventQueryStatus(Event* const evt, rtEventStatus_t* const status)
{
    UNUSED(evt);
    UNUSED(status);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplEvent::EventQueryWaitStatus(Event* const evt, rtEventWaitStatus_t* const status)
{
    UNUSED(evt);
    UNUSED(status);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplEvent::EventElapsedTime(float32_t* const retTime, Event* const startEvt, Event* const endEvt)
{
    UNUSED(retTime);
    UNUSED(startEvt);
    UNUSED(endEvt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplEvent::EventGetTimeStamp(uint64_t* const retTime, Event* const evt)
{
    UNUSED(retTime);
    UNUSED(evt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
