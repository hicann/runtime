/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdlib.h>
#include "acl/acl_base.h"
#include "acl/acl_rt.h"
#include "log_inner.h"
#include "runtime/dev.h"
#include "runtime/mem.h"
#include "model_config_rt.h"

static aclError GetAlignedSize(const size_t size, size_t *alignedSize) {
  const size_t DATA_MEMORY_ALIGN_SIZE = 32UL;
  if ((size + (DATA_MEMORY_ALIGN_SIZE * 2UL)) < size) {
    return ACL_ERROR_INVALID_PARAM;
  }
  *alignedSize = (size + (DATA_MEMORY_ALIGN_SIZE * 2UL) - 1UL) / DATA_MEMORY_ALIGN_SIZE * DATA_MEMORY_ALIGN_SIZE;
  return ACL_SUCCESS;
}

aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy) {
  size_t alignedSize = 0;
  if ((devPtr == NULL) || (size == 0UL) || (GetAlignedSize(size, &alignedSize) != ACL_SUCCESS)) {
    ACL_LOG_ERROR("%s", devPtr == NULL? "devPtr is NULL" : "size invalid");
    return ACL_ERROR_INVALID_PARAM;
  }
  rtMemType_t type = RT_MEMORY_DEFAULT;
  aclError ret = GetMemTypeFromPolicy(policy, &type);
  if (ret != ACL_SUCCESS) {
    return ret;
  }
  return rtMalloc(devPtr, alignedSize, type, (uint16_t)(APP));
}

aclError aclrtFree(void *devPtr) {
  if (devPtr == NULL) {
      ACL_LOG_ERROR("devPtr is NULL.");
      return ACL_ERROR_INVALID_PARAM;
  }
  return rtFree(devPtr);
}

static aclError MemcpyKindTranslate(const aclrtMemcpyKind kind, rtMemcpyKind_t *rtKind) {
  switch (kind) {
    case ACL_MEMCPY_HOST_TO_DEVICE: {
      *rtKind = RT_MEMCPY_HOST_TO_DEVICE;
      break;
    }
    case ACL_MEMCPY_DEVICE_TO_DEVICE: {
      *rtKind = RT_MEMCPY_DEVICE_TO_DEVICE;
      break;
    }
    case ACL_MEMCPY_DEVICE_TO_HOST: {
      *rtKind = RT_MEMCPY_DEVICE_TO_HOST;
      break;
    }
    case ACL_MEMCPY_HOST_TO_HOST: {
      *rtKind = RT_MEMCPY_HOST_TO_HOST;
      break;
    }
    default: {
      return ACL_ERROR_INVALID_PARAM;
    }
  }
  return ACL_SUCCESS;
}

aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind) {
  if (dst == NULL || src == NULL) {
    ACL_LOG_ERROR("%s",  dst == NULL? "dst is NULL": "src is NULL.");
    return ACL_ERROR_INVALID_PARAM;
  }
  rtMemcpyKind_t rtKind = RT_MEMCPY_RESERVED;
  const aclError ret = MemcpyKindTranslate(kind, &rtKind);
  if (ret != ACL_SUCCESS) {
    ACL_LOG_INNER_ERROR("invalid kind[%d]", (int32_t)(kind));
    return ret;
  }
  return rtMemcpy(dst, destMax, src, count, rtKind);
}

aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count) {
  if (devPtr == NULL) {
      ACL_LOG_ERROR("devPtr is NULL.");
      return ACL_ERROR_INVALID_PARAM;
  }
  return rtMemset(devPtr, maxCount, (uint32_t)(value), count);
}

aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total) {
  if (free == NULL || total == NULL) {
    ACL_LOG_ERROR("%s", free == NULL? "free is NULL" : "total is NULL.");
    return ACL_ERROR_INVALID_PARAM;
  }
  return rtMemGetInfoEx((rtMemInfoType_t)(attr), free, total);
}