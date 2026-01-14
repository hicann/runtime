/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"

#include "runtime/rts/rts_dfx.h"

#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

aclError aclrtProfTraceImpl(void *userdata, int32_t length, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtProfTrace);
    ACL_LOG_INFO("start to execute AclrtProfTrace, length is [%d]", length);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(userdata);
    const auto rtErr = rtsProfTrace(userdata, length, stream);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsProfTrace failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}
