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
#include "base.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "config.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "dvpp_grp.hpp"
#include "inner.hpp"
#include "osal.hpp"
#include "notify.hpp"
#include "prof_map_ge_model_device.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "toolchain/prof_api.h"
#include "prof_acl_api.h"
#include "soc_info.h"
#include "task_abort.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;
 
#ifdef __cplusplus
extern "C" {
#endif
 
VISIBILITY_DEFAULT
rtError_t rtGetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    Api *api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = api->GetTaskBufferLen(type, bufferLen);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtTaskBuild(const rtTaskInput_t * const taskInput, uint32_t* taskLen)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    Api *api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = api->TaskSqeBuild(taskInput, taskLen);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtGetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    const rtError_t ret = rtInstance->GetElfOffset(elfData, elfLen, offset);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtGetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetKernelBin(binFileName, buffer, length);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtFreeKernelBin(char_t * const buffer)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->FreeKernelBin(buffer);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtGetStreamBufferLen(const bool isHuge, uint32_t * const bufferLen)
{
    UNUSED(isHuge);
    UNUSED(bufferLen);
    Runtime *rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_PRE_BUILD_SQE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
 
    return ACL_RT_SUCCESS;
}
 
#ifdef __cplusplus
}
#endif