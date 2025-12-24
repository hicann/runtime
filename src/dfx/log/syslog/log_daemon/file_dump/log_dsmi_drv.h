/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_DSMI_DRV_H
#define LOG_DSMI_DRV_H
#include "ascend_hal.h"
#include "extra_config.h"

namespace Adx {
int32_t LogIdeGetRunEnvBySession(HDC_SESSION session, IdeI32Pt runEnv);
int32_t LogIdeGetPidBySession(HDC_SESSION session, IdeI32Pt pid);
}
#endif
