/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_esched.hpp"

#include <new>
#include <string>

#include "api_impl_creator.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "heterogenous.h"
#include "npu_driver.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
namespace {
inline bool IsHostCpuDevId(const int32_t devId) { return devId == DEFAULT_HOSTCPU_USER_DEVICE_ID; }
} // namespace

bool IsImplEschedSupported() { return true; }

ApiEsched* CreateImplEschedAndGet()
{
    ApiEsched* const apiImplEsched = new (std::nothrow) ApiImplEsched();
    if (apiImplEsched == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplEsched), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplEsched failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplEsched:Runtime_alloc_size %zu", sizeof(ApiImplEsched));
    return apiImplEsched;
}

void DestroyImplEsched(ApiEsched*& apiImplEsched)
{
    delete apiImplEsched;
    apiImplEsched = nullptr;
}

namespace {
rtError_t CheckCurCtxValid(const int32_t devId)
{
    if (Runtime::Instance()->GetSetDefaultDevIdFlag()) {
        Context* const curCtx = Runtime::Instance()->CurrentContext(true, devId);
        if (RtIsHeterogenous()) {
            RT_LOG(RT_LOG_DEBUG, "Heterogenous do not check ctx.");
            return RT_ERROR_NONE;
        }
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    }
    return RT_ERROR_NONE;
}

/* HostCPU场景下, 底软三件套(Mbuff/队列调度/事件调度)接口无需对DeviceID做转换 */
rtError_t ConvertUserDevIdToRealDevId(const int32_t devId, int32_t& realDeviceId)
{
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
        return RT_ERROR_NONE;
    }
    const rtError_t error =
        Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t*>(&realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %d to driver device ID.", devId);
    return RT_ERROR_NONE;
}

rtError_t ConvertUserDevIdToRealDevId(const uint32_t devId, uint32_t& realDeviceId)
{
    if (IsHostCpuDevId(static_cast<int32_t>(devId))) {
        realDeviceId = static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID);
        return RT_ERROR_NONE;
    }
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    return RT_ERROR_NONE;
}
} // namespace

rtError_t ApiImplEsched::EschedSubmitEventSync(
    const int32_t devId, rtEschedEventSummary_t* const evt, rtEschedEventReply_t* const ack)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Synchronous event submission");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ack, RT_ERROR_INVALID_VALUE, "Synchronous event submission");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        ((evt->eventId != RT_MQ_SCHED_EVENT_QS_MSG) && (evt->eventId != RT_MQ_SCHED_EVENT_DRV_CUSTOM_MSG)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Synchronous event submission", evt->eventId,
        std::to_string(RT_MQ_SCHED_EVENT_QS_MSG) + " or " + std::to_string(RT_MQ_SCHED_EVENT_DRV_CUSTOM_MSG));

    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "Start to submit event on drv devId %d.", realDeviceId);
    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedSubmitEventSync(realDeviceId, evt, ack);
}

rtError_t ApiImplEsched::EschedAttachDevice(const uint32_t devId)
{
    uint32_t realDeviceId = 0U;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%u].", realDeviceId);
    return NpuDriver::EschedAttachDevice(realDeviceId);
}

rtError_t ApiImplEsched::EschedDettachDevice(const uint32_t devId)
{
    uint32_t realDeviceId = 0U;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%u].", realDeviceId);
    return NpuDriver::EschedDettachDevice(realDeviceId);
}

rtError_t ApiImplEsched::EschedWaitEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const int32_t timeout,
    rtEschedEventSummary_t* const evt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Waiting for an event");

    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedWaitEvent(realDeviceId, grpId, threadId, timeout, evt);
}

rtError_t ApiImplEsched::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (type < RT_GRP_TYPE_BIND_DP_CPU) || (type > RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE), RT_ERROR_INVALID_VALUE,
        "Creating an event scheduling group", type,
        "[" + std::to_string(RT_GRP_TYPE_BIND_DP_CPU) + ", " + std::to_string(RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE) + "]");

    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedCreateGrp(realDeviceId, grpId, type);
}

rtError_t ApiImplEsched::EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t* const evt)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Event submission");

    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedSubmitEvent(realDeviceId, evt);
}

rtError_t ApiImplEsched::EschedSubscribeEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const uint64_t eventBitmap)
{
    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedSubscribeEvent(realDeviceId, grpId, threadId, eventBitmap);
}

rtError_t ApiImplEsched::EschedAckEvent(
    const int32_t devId, const rtEventIdType_t evtId, const uint32_t subeventId, char_t* const msg, const uint32_t len)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(msg, RT_ERROR_INVALID_VALUE, "Event confirmation");

    int32_t realDeviceId = 0;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = CheckCurCtxValid(realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].", realDeviceId);
    return NpuDriver::EschedAckEvent(realDeviceId, evtId, subeventId, msg, len);
}

rtError_t ApiImplEsched::EschedQueryInfo(
    const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* const inPut,
    rtEschedOutputInfo* const outPut)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inPut, RT_ERROR_INVALID_VALUE, "Information query");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(outPut, RT_ERROR_INVALID_VALUE, "Information query");

    uint32_t realDeviceId = 0U;
    rtError_t error = ConvertUserDevIdToRealDevId(devId, realDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "Start to Query Esched Info");
    error = CheckCurCtxValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%u].", realDeviceId);
    return NpuDriver::EschedQueryInfo(realDeviceId, type, inPut, outPut);
}

} // namespace runtime
} // namespace cce
