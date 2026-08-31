/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api_esched.hpp"
#include "runtime.hpp"
#include "device_enum_desc.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtEschedSubmitEventSync(int32_t devId, rtEschedEventSummary_t* evt, rtEschedEventReply_t* ack)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedSubmitEventSync(devId, evt, ack);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedAttachDevice(int32_t devId)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedAttachDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedDettachDevice(int32_t devId)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedDettachDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedWaitEvent(
    int32_t devId, uint32_t grpId, uint32_t threadId, int32_t timeout, rtEschedEventSummary_t* evt)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedWaitEvent(devId, grpId, threadId, timeout, evt);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_REPORT_TIMEOUT, ACL_ERROR_RT_REPORT_TIMEOUT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedCreateGrp(int32_t devId, uint32_t grpId, rtGroupType_t type)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedCreateGrp(devId, grpId, type);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedSubmitEvent(int32_t devId, rtEschedEventSummary_t* evt)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedSubmitEvent(devId, evt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedSubscribeEvent(int32_t devId, uint32_t grpId, uint32_t threadId, uint64_t eventBitmap)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedSubscribeEvent(devId, grpId, threadId, eventBitmap);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedAckEvent(int32_t devId, rtEventIdType_t evtId, uint32_t subeventId, char_t* msg, uint32_t len)
{
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);
    const rtError_t error = apiEschedInstance->EschedAckEvent(devId, evtId, subeventId, msg, len);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtEschedQueryInfo(
    const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* inPut, rtEschedOutputInfo* outPut)
{
    const Runtime* const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    ApiEsched* const apiEschedInstance = ApiEsched::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiEschedInstance);

    if (!IS_SUPPORT_CHIP_FEATURE(
            rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DRIVER_ESCHED_QUERY_INFO)) {
        RT_LOG(
            RT_LOG_ERROR, "Chip type %s(%d) does not support.", ChipTypeToName(rtInstance->GetChipType()),
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    const rtError_t ret = apiEschedInstance->EschedQueryInfo(devId, type, inPut, outPut);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
