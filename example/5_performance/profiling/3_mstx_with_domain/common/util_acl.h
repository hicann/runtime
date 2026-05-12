/**
* Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef UTIL_ACL_H_
#define UTIL_ACL_H_

#include "acl/acl.h"
#include "common/util_mstx.h"

int Init(int32_t deviceId, aclrtContext* context, aclrtStream* stream)
{
    // 初始化系统资源
    ACL_CALL(aclInit(nullptr));
    ACL_CALL(aclrtSetDevice(deviceId));
    ACL_CALL(aclrtCreateContext(context, deviceId));
    ACL_CALL(aclrtSetCurrentContext(*context));
    ACL_CALL(aclrtCreateStream(stream));
    return 0;
}

int DeInit(int32_t deviceId, aclrtContext* context, aclrtStream* stream)
{
    ACL_CALL(aclrtDestroyStream(*stream));
    ACL_CALL(aclrtDestroyContext(*context));
    ACL_CALL(aclrtResetDevice(deviceId));
    ACL_CALL(aclFinalize());
    return 0;
}

# endif // UTIL_ACL_H_