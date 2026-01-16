/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "osal.hpp"
#include "thread_local_container.hpp"
#include "notify.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtsEventCreate);
TIMESTAMP_EXTERN(rtsNotifyCreate);
}  // namespace runtime
}  // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
constexpr uint64_t RT_EVENT_FLAG_VALID_MASK =
    (RT_EVENT_FLAG_SYNC | RT_EVENT_FLAG_TRACE_STREAM | RT_EVENT_FLAG_TIME_LINE | RT_EVENT_FLAG_EXTERNAL | RT_EVENT_MC2);

VISIBILITY_DEFAULT
rtError_t rtEventCreate(rtEvent_t *evt)
{
    return rtEventCreateWithFlag(evt, RT_EVENT_DEFAULT);
}

VISIBILITY_DEFAULT
rtError_t rtsEventCreate(rtEvent_t *evt, uint64_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if ((flag & ~RT_EVENT_FLAG_VALID_MASK) != 0U) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(flag, "exclusive OR value with RT_EVENT_FLAG");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    if (flag == RT_EVENT_FLAG_DEFAULT) {
        flag = RT_EVENT_DEFAULT;
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsEventCreate);
    const rtError_t error = apiInstance->EventCreate(RtPtrToPtr<Event **>(evt), flag);
    TIMESTAMP_END(rtsEventCreate);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsEventCreateEx(rtEvent_t *evt, uint64_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (flag == RT_EVENT_FLAG_DEFAULT || (flag & ~RT_EVENT_FLAG_VALID_MASK) != 0U) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(flag, "exclusive OR value with RT_EVENT_FLAG and cannot be 0");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EventCreateEx(RtPtrToPtr<Event **>(evt), flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsEventDestroy(rtEvent_t evt)
{
    return rtEventDestroy(evt);
}

VISIBILITY_DEFAULT
rtError_t rtsEventGetId(rtEvent_t evt, uint32_t *evtId)
{
    return rtGetEventID(evt, evtId);
}

VISIBILITY_DEFAULT
rtError_t rtsEventQueryStatus(rtEvent_t evt, rtEventRecordStatus *status)
{
    return rtEventQueryStatus(evt, RtPtrToPtr<rtEventStatus_t *>(status));
}

VISIBILITY_DEFAULT
rtError_t rtsEventRecord(rtEvent_t evt, rtStream_t stm)
{
    return rtEventRecord(evt, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsEventWait(rtStream_t stream, rtEvent_t evt, uint32_t timeout)
{
    return rtStreamWaitEventWithTimeout(stream, evt, timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsEventSynchronize(rtEvent_t evt, const int32_t timeout)
{
    return rtEventSynchronizeWithTimeout(evt, timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsEventGetTimeStamp(uint64_t *timeStamp, rtEvent_t evt)
{
    return rtEventGetTimeStamp(timeStamp, evt);
}

VISIBILITY_DEFAULT
rtError_t rtsEventReset(rtEvent_t evt, rtStream_t stm)
{
    return rtEventReset(evt, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsEventGetAvailNum(uint32_t *eventCount)
{
    return rtGetAvailEventNum(eventCount);
}

VISIBILITY_DEFAULT
rtError_t rtsEventElapsedTime(float32_t *timeInterval, rtEvent_t startEvent, rtEvent_t endEvent)
{
    return rtEventElapsedTime(timeInterval, startEvent, endEvent);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyCreate(rtNotify_t *notify, uint64_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (flag != RT_NOTIFY_FLAG_DEFAULT && flag != RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(flag,
            std::to_string(RT_NOTIFY_FLAG_DEFAULT) + " or " + std::to_string(RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    int32_t deviceId = 0;
    const rtError_t rtRet = rtGetDevice(&deviceId);
    if (unlikely((rtRet) != ACL_RT_SUCCESS)) {
        return rtRet;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->NotifyCreate(deviceId, RtPtrToPtr<Notify **>(notify), flag);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyDestroy(rtNotify_t notify)
{
    return rtNotifyDestroy(notify);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyRecord(rtNotify_t notify, rtStream_t stm)
{
    return rtNotifyRecord(notify, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyWaitAndReset(rtNotify_t notify, rtStream_t stm, uint32_t timeout)
{
    if (timeout == UINT32_MAX) {
        return rtNotifyWait(notify, stm);
    }
    return rtNotifyWaitWithTimeOut(notify, stm, timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyGetId(rtNotify_t notify, uint32_t *notifyId)
{
    return rtGetNotifyID(notify, notifyId);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyBatchReset(rtNotify_t *notifies, uint32_t num)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(notifies, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(num <= 0, RT_ERROR_INVALID_VALUE, 
        num, "(0, " + std::to_string(MAX_UINT32_NUM) + "]");

    RT_LOG(RT_LOG_INFO, "start batch reset notify, num=%u.", num);
    // if notify reset err, break it and return
    rtError_t ret = RT_ERROR_NONE;
    for (uint32_t i = 0; i < num; i++) {
        ret = rtNotifyReset(notifies[i]);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
    }
    return RT_ERROR_NONE;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyResetAll()
{
    int32_t deviceId = 0;
    const rtError_t rtRet = rtGetDevice(&deviceId);
    if (unlikely((rtRet) != RT_ERROR_NONE)) {
        return rtRet;
    }

    RT_LOG(RT_LOG_INFO, "start to reset all notify, deviceId=%d.", deviceId);
    return rtResourceClean(deviceId, RT_NOTIFY_ID);
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyGetExportKey(rtNotify_t notify, char_t *key,  uint32_t len, uint64_t flag)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t error = apiInstance->IpcSetNotifyName(notifyPtr, key, len, flag);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsNotifyImportByKey(rtNotify_t *notify, const char_t *key, uint64_t flag)
{
    return rtIpcOpenNotifyWithFlag(notify, key, static_cast<uint32_t>(flag & MAX_UINT32_NUM));
}

VISIBILITY_DEFAULT
rtError_t rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num)
{
    // notify to ipc name
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support NotifySetImportPid.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(notifyPtr, RT_ERROR_INVALID_VALUE);
    const rtError_t error = apiInstance->SetIpcNotifyPid(notifyPtr->GetIpcName().c_str(), pid, num);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus