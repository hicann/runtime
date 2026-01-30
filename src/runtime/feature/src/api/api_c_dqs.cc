/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "runtime_keeper.h"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

static rtError_t DqsTaskLaunch(const rtStream_t stm, const rtDqsTaskCfg_t * const taskCfg)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->LaunchDqsTask(RtPtrToPtr<Stream *>(stm), taskCfg);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchDqsTask(const rtStream_t stm, const rtDqsTaskCfg_t * const taskCfg)
{
    return DqsTaskLaunch(stm, taskCfg);
}

#ifdef __cplusplus
}
#endif // __cplusplus