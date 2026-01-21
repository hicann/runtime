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
#include "runtime/kernel.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream) {
  return rtSubscribeReport(threadId, (rtStream_t)stream);
}

aclError aclrtLaunchCallback(aclrtCallback fn, void *userData,
                             aclrtCallbackBlockType blockType,
                             aclrtStream stream) {
  if ((blockType != ACL_CALLBACK_BLOCK) &&
      (blockType != ACL_CALLBACK_NO_BLOCK)) {
    ACL_LOG_INNER_ERROR("invalid block type, the current blockType = %d",
                        blockType);
    return ACL_ERROR_INVALID_PARAM;
  }
  return rtCallbackLaunch((rtCallback_t)(fn), userData, (rtStream_t)(stream),
                          (blockType == ACL_CALLBACK_BLOCK));
}

aclError aclrtProcessReport(int32_t timeout) {
  return rtProcessReport(timeout);
}

aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream) {
  return rtUnSubscribeReport(threadId, (rtStream_t)(stream));
}

#if defined(__cplusplus)
}
#endif