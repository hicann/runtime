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

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId) {
  if (context == NULL) {
    ACL_LOG_ERROR("context is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }

  rtContext_t rtCtx = NULL;
  const rtError_t rtErr =
    rtCtxCreateEx(&rtCtx, (uint32_t)(RT_CTX_NORMAL_MODE), deviceId);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR(
        "create context failed, device is %d, ret=%d",
        deviceId, (int32_t)(rtErr));
    return rtErr;
  }

  *context = (aclrtContext)(rtCtx);
  return ACL_SUCCESS;
}

aclError aclrtDestroyContext(aclrtContext context) {
  if (context == NULL) {
    ACL_LOG_ERROR("context is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  const rtError_t rtErr = rtCtxDestroyEx((rtContext_t)(context));
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("destroy context failed, ret=%d",
                       (int32_t)(rtErr));
    return rtErr;
  }
  return ACL_SUCCESS;
}

aclError aclrtSetCurrentContext(aclrtContext context) {
  if (context == NULL) {
    ACL_LOG_ERROR("context is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  const rtError_t rtErr = rtCtxSetCurrent((rtContext_t)(context));
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("set current context failed, ret=%d",
                       (int32_t)(rtErr));
    return rtErr;
  }
  return ACL_SUCCESS;
}

aclError aclrtGetCurrentContext(aclrtContext *context) {
  if (context == NULL) {
    ACL_LOG_ERROR("context is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }

  rtContext_t rtCtx = NULL;
  const rtError_t rtErr = rtCtxGetCurrent(&rtCtx);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_INFO("can not get current context, ret=%d",
                 (int32_t)(rtErr));
    return rtErr;
  }

  *context = rtCtx;
  return ACL_SUCCESS;
}

#if defined(__cplusplus)
}
#endif