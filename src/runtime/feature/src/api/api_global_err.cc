/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_global_err.h"
#include "errcode_manage.hpp"
#include "thread_local_container.hpp"
#include "runtime.hpp"
namespace cce {
namespace runtime {
rtError_t GetRtExtErrCodeAndSetGlobalErr(const rtError_t errCode)
{
    const rtError_t ret = RT_GET_EXT_ERRCODE(errCode);
    if (ret == ACL_RT_SUCCESS) {
        return ret;
    }

    // For API, Cannot call Specific object methods, need to use Runtime* 
    Runtime *rt = Runtime::Instance();
    if (rt != nullptr) {
        rt->SetGlobalErr(ret);
    }
    
    return ret;
}

rtError_t RtCheckDeviceIdListValid(const uint32_t * const devIdList, const uint32_t devCnt)
{
    int32_t npuDrvDevCnt = 1;
    const auto rt = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rt, RT_ERROR_API_NULL);
    const rtError_t ret = rt->GetNpuDeviceCnt(npuDrvDevCnt);
    RT_LOG(RT_LOG_DEBUG, "npuDrvDevCnt:%u.", npuDrvDevCnt);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, ret != RT_ERROR_NONE, ACL_ERROR_RT_INTERNAL_ERROR,
        "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(ret));
    for (uint32_t i = 0U; i < devCnt; i++) {
        COND_RETURN_OUT_ERROR_MSG_CALL(devIdList[i] >= static_cast<uint32_t>(npuDrvDevCnt), RT_ERROR_INVALID_VALUE,
            "Invalid deviceId, current deviceId=%u, valid device range is [0, %d)", devIdList[i], npuDrvDevCnt);
    }
    return RT_ERROR_NONE;
}

rtError_t RtCheckDeviceIdValid(const uint32_t deviceId)
{
    int32_t npuDevCnt = 1;
    const auto rt = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rt, RT_ERROR_API_NULL);
    const rtError_t error = rt->GetNpuDeviceCnt(npuDevCnt);
    RT_LOG(RT_LOG_DEBUG, "npuDevCnt:%u.", npuDevCnt);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, ACL_ERROR_RT_INTERNAL_ERROR,
        "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, deviceId >= static_cast<uint32_t>(npuDevCnt), RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u, valid device range is [0, %d)", deviceId, npuDevCnt);
    return RT_ERROR_NONE;
}
}
}
