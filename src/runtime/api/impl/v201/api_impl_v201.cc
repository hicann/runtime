/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl_v201.hpp"

#include "dqs_c.hpp"

namespace cce {
namespace runtime {

// dqs
rtError_t ApiImplV201::LaunchDqsTask(Stream* const stm, const rtDqsTaskCfg_t* const taskCfg)
{
    return DqsLaunchTask(stm, taskCfg);
}

rtError_t ApiImplV201::EventRecord(Event* const evt, Stream* const stm, const uint32_t flag)
{
    if (flag == RT_EVENT_RECORD_EXTERNAL) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ApiImplDavid::EventRecord(evt, stm, flag);
}

rtError_t ApiImplV201::StreamWaitEvent(Stream* const stm, Event* const evt, const uint32_t timeout, const uint32_t flag)
{
    if (flag == RT_EVENT_WAIT_EXTERNAL) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ApiImplDavid::StreamWaitEvent(stm, evt, timeout, flag);
}

} // namespace runtime
} // namespace cce
