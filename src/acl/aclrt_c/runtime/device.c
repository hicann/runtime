/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acl/acl_rt.h"
#include "log_inner.h"
#include "runtime/rt.h"
#include "ge_executor_rt.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtSetDevice(int32_t deviceId) {
  const rtError_t rtErr = rtSetDevice(deviceId);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("open device %d failed, rt ret = %d.", deviceId,
                       (int32_t)(rtErr));
    return rtErr;
  }
  Status ret = GeNofifySetDevice(0, (uint32_t)deviceId);
  if (ret != SUCCESS) {
    ACL_LOG_CALL_ERROR("prof notify device %d fail, result = %d.", deviceId,
                       (int32_t)(ret));
    return ret;
  }
  ACL_LOG_INFO("set deviceId = %d success", deviceId);
  return ACL_SUCCESS;
}

aclError aclrtResetDevice(int32_t deviceId) {
  const rtError_t rtErr = rtDeviceReset(deviceId);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("reset device %d failed, rt ret = %d.", deviceId,
                       (int32_t)(rtErr));
    return rtErr;
  }
  ACL_LOG_INFO("reset deviceId = %d success.", deviceId);
  return ACL_SUCCESS;
}

aclError aclrtGetDevice(int32_t *deviceId) {
  if (deviceId == NULL) {
    ACL_LOG_ERROR("deviceId is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  const rtError_t rtErr = rtGetDevice(deviceId);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_INFO("can not get device id, rt ret = %d.", (int32_t)(rtErr));
    return rtErr;
  }
  ACL_LOG_INFO("get device success, deviceId = %d.", *deviceId);
  return ACL_SUCCESS;
}

aclError aclrtGetRunMode(aclrtRunMode *runMode) {
  if (runMode == NULL) {
    ACL_LOG_ERROR("runMode is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  rtRunMode rtMode;
  const rtError_t rtErr = rtGetRunMode(&rtMode);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("get runMode failed ret = %d.", (int32_t)(rtErr));
    return rtErr;
  }
  if (rtMode == RT_RUN_MODE_OFFLINE) {
    *runMode = ACL_DEVICE;
    return ACL_SUCCESS;
  }
  *runMode = ACL_HOST;
  ACL_LOG_INFO("get runMode success, runMode = %d.", (int32_t)(*runMode));
  return ACL_SUCCESS;
}
#if defined(__cplusplus)
}
#endif