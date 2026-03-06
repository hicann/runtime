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
#include "api.hpp"
#include "rt.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
RTS_API rtError_t rtTaskGetType(rtTask_t task, rtTaskType *type)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    
    const static bool isSupportAclGraph = IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH);
    if (!isSupportAclGraph) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->TaskGetType(static_cast<TaskInfo *>(task), type);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus