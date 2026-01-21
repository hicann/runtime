/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "model_config_rt.h"
#include <stdlib.h>
#include "log_inner.h"

#ifdef __cplusplus
extern "C"{
#endif

#define POLICY_MASK_LOW_BIT 0xFF
#define POLICY_MASK_HIGH_BIT 0xFF00

struct PageType {
  uint32_t aclPageType;
  uint32_t rtPageTypeBit;
};

static struct PageType g_pageMap[] = {
    {ACL_MEM_MALLOC_HUGE_FIRST, RT_MEMORY_POLICY_HUGE_PAGE_FIRST},
    {ACL_MEM_MALLOC_HUGE_ONLY, RT_MEMORY_POLICY_HUGE_PAGE_ONLY},
    {ACL_MEM_MALLOC_NORMAL_ONLY, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY},
    {ACL_MEM_MALLOC_HUGE_FIRST_P2P, RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P},
    {ACL_MEM_MALLOC_HUGE_ONLY_P2P, RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P},
    {ACL_MEM_MALLOC_NORMAL_ONLY_P2P, RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P}};


static int Compare(const void *a, const void *b) {
  return (int)((*(const struct PageType*)a).aclPageType - (*(const struct PageType*)b).aclPageType);
}


aclError GetMemTypeFromPolicy(aclrtMemMallocPolicy policy, rtMemType_t *type) {
  uint32_t flags = RT_MEMORY_DEFAULT;
  if (((uint32_t)policy & POLICY_MASK_HIGH_BIT) == ACL_MEM_TYPE_LOW_BAND_WIDTH) {
    flags = RT_MEMORY_DDR;
  } else if (((uint32_t)policy & POLICY_MASK_HIGH_BIT) == ACL_MEM_TYPE_HIGH_BAND_WIDTH) {
    flags = RT_MEMORY_HBM;
  } else {
    ACL_LOG_WARN("invalid policy high bit!");
  }

  size_t pageMapLen = sizeof(g_pageMap) / sizeof(g_pageMap[0]);
  size_t pagePairLen = sizeof(g_pageMap[0]);
  struct PageType pagePair = {(uint32_t)policy & POLICY_MASK_LOW_BIT, 0};
  struct PageType *searchRet = (struct PageType*)bsearch(&pagePair, g_pageMap, pageMapLen, pagePairLen, Compare);
  if (searchRet == NULL) {
    ACL_LOG_ERROR("invalid policy low bit!");
    return ACL_ERROR_INVALID_PARAM;
  }
  flags |= (*searchRet).rtPageTypeBit;
  *type = flags;
  return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif