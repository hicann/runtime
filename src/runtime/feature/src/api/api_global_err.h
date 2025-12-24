/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_GLOBAL_ERR_H
#define CCE_RUNTIME_API_GLOBAL_ERR_H
#include "base.hpp"
namespace cce {
namespace runtime {
// Only for API, Get the last errcode and record it in the current thread and current ctx.
rtError_t GetRtExtErrCodeAndSetGlobalErr(const rtError_t errCode);
rtError_t RtCheckDeviceIdListValid(const uint32_t * const devIdList, const uint32_t devCnt);
rtError_t RtCheckDeviceIdValid(const uint32_t deviceId);
}
}
#endif
