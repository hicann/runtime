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
#include "acl/acl_base.h"
#include "log_inner.h"
#include "runtime/rt.h"
#include "securec.h"

#ifdef __cplusplus
extern "C" {
#endif

aclrtStreamConfigHandle *aclrtCreateStreamConfigHandle(void) {
  aclrtStreamConfigHandle *configHandle =
      (aclrtStreamConfigHandle *)mmMalloc(sizeof(aclrtStreamConfigHandle));
  if (configHandle == NULL) {
    ACL_LOG_INNER_ERROR("malloc memory failed, create config handle failed.");
    return NULL;
  }
  memset_s(configHandle, sizeof(aclrtStreamConfigHandle), 0, sizeof(aclrtStreamConfigHandle));
  return configHandle;
}

aclError aclrtDestroyStreamConfigHandle(aclrtStreamConfigHandle *handle) {
  if (handle == NULL) {
    ACL_LOG_ERROR("handle is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  mmFree(handle);
  handle = NULL;
  return ACL_SUCCESS;
}

typedef aclError (*SetStreamConfigFunc)(aclrtStreamConfigHandle *const,
                                        const void *const, const size_t);

typedef struct {
  aclrtStreamConfigAttr configAttr;
  SetStreamConfigFunc configParamFunc;
} SetStreamConfigParamFuncMap;

static aclError SetStreamPriority(aclrtStreamConfigHandle *const handle,
                           const void *const attrValue,
                           const size_t valueSize) {
#define ACL_RT_MIN_PRIORITY 0
#define ACL_RT_MAX_PRIORITY 7
  if (valueSize != sizeof(uint32_t)) {
    ACL_LOG_INNER_ERROR(
        "valueSize[%zu] is invalid, it should be %zu",
        valueSize, sizeof(uint32_t));
    return ACL_ERROR_INVALID_PARAM;
  }
  const uint32_t value = *(const uint32_t *)(attrValue);
  if (!(value <= ACL_RT_MAX_PRIORITY)) {
    ACL_LOG_INNER_ERROR(
        "value[%u] is invalid, it should be in [%d, %d]", value,
        ACL_RT_MIN_PRIORITY, ACL_RT_MAX_PRIORITY);
    return ACL_ERROR_INVALID_PARAM;
  }
  handle->priority = value;
  return ACL_SUCCESS;
}

static aclError SetStreamFlag(aclrtStreamConfigHandle *const handle,
                       const void *const attrValue, const size_t valueSize) {
  if (valueSize != sizeof(size_t)) {
    ACL_LOG_INNER_ERROR(
        "valueSize[%zu] is invalid, it should be %zu",
        valueSize, sizeof(size_t));
    return ACL_ERROR_INVALID_PARAM;
  }
  const size_t value = *(const size_t *)(attrValue);
  handle->flag = value;
  return ACL_SUCCESS;
}

static aclError SetStreamWorkPtr(aclrtStreamConfigHandle *const handle,
                          const void *const attrValue, const size_t valueSize) {
  if (valueSize != sizeof(void *)) {
    ACL_LOG_INNER_ERROR(
        "valueSize[%zu] is invalid, it should be %zu",
        valueSize, sizeof(void *));
    return ACL_ERROR_INVALID_PARAM;
  }
  handle->workptr = *(void *const *)attrValue;
  return ACL_SUCCESS;
}

static aclError SetStreamWorkSize(aclrtStreamConfigHandle *const handle,
                           const void *const attrValue,
                           const size_t valueSize) {
  if (valueSize != sizeof(size_t)) {
    ACL_LOG_INNER_ERROR(
        "valueSize[%zu] is invalid, it should be %zu",
        valueSize, sizeof(size_t));
    return ACL_ERROR_INVALID_PARAM;
  }
  const size_t value = *(const size_t *)(attrValue);
  handle->workSize = value;
  return ACL_SUCCESS;
}

static SetStreamConfigParamFuncMap
    g_setStreamConfigMap[ACL_RT_STREAM_PRIORITY + 1] = {
        {ACL_RT_STREAM_WORK_ADDR_PTR, &SetStreamWorkPtr},
        {ACL_RT_STREAM_WORK_SIZE, &SetStreamWorkSize},
        {ACL_RT_STREAM_FLAG, &SetStreamFlag},
        {ACL_RT_STREAM_PRIORITY, &SetStreamPriority}};

aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle,
                                 aclrtStreamConfigAttr attr,
                                 const void *attrValue, size_t valueSize) {
  if (handle == NULL || attrValue == NULL) {
    ACL_LOG_ERROR("%s", handle == NULL  ? "handle is NULL" : "attrValue is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  SetStreamConfigFunc paramFunc = NULL;
  uint32_t attrCount =
    sizeof(g_setStreamConfigMap) / sizeof(SetStreamConfigParamFuncMap);
  if (attr >= attrCount) {
    ACL_LOG_INNER_ERROR("attr set invalid.");
    return ACL_ERROR_INVALID_PARAM;
  }
  paramFunc = g_setStreamConfigMap[attr].configParamFunc;
  aclError ret = paramFunc(handle, attrValue, valueSize);
  if (ret != ACL_SUCCESS) {
    return ret;
  }
  return ACL_SUCCESS;
}

aclError aclrtCreateStreamV2(aclrtStream *stream,
                             const aclrtStreamConfigHandle *handle) {
  if (stream == NULL) {
    ACL_LOG_ERROR("stream is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  rtStream_t rtStream = NULL;
  rtStreamConfigHandle rtHandle;
  memset_s(&rtHandle, sizeof(rtStreamConfigHandle), 0, sizeof(rtStreamConfigHandle));
  if (handle != NULL) {
      rtHandle.workPtr = handle->workptr;
      rtHandle.workSize = handle->workSize;
      rtHandle.flag = handle->flag;
      rtHandle.priority = handle->priority;
  }
  const rtError_t rtErr = rtStreamCreateWithConfig(&rtStream, &rtHandle);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("create stream failed ret=%d",
                       (int32_t)(rtErr));
    return rtErr;
  }

  *stream = (aclrtStream)(rtStream);
  return ACL_SUCCESS;
}

aclError aclrtDestroyStream(aclrtStream stream) {
  if (stream == NULL) {
    ACL_LOG_ERROR("stream is NULL");
    return ACL_ERROR_INVALID_PARAM;
  }
  const rtError_t rtErr = rtStreamDestroy((rtStream_t)(stream));
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("destroy stream failed ret=%d",
                       (int32_t)(rtErr));
    return rtErr;
  }
  return ACL_SUCCESS;
}

aclError aclrtSynchronizeStream(aclrtStream stream) {
  const rtError_t rtErr = rtStreamSynchronize((rtStream_t)(stream));
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("synchronize stream failed ret=%d",
                       (int32_t)(rtErr));
    return rtErr;
  }
  return ACL_SUCCESS;
}

#if defined(__cplusplus)
}
#endif