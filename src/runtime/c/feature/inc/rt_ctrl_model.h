/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_C_FEATURE_RT_CTRL_MODEL_H
#define RUNTIME_C_FEATURE_RT_CTRL_MODEL_H

#include "runtime/rt.h"
#include "hal_ts.h"
#if defined(__cplusplus)
extern "C" {
#endif

#define MODEL_TASK_DESC_SIZE 64U
#define RPT_MAX_NUM 4U
#ifndef DEVICE_ID
#define DEVICE_ID 0U
#endif

rtError_t SendNullMdl(uint32_t sqId);
rtError_t InitCtrlMdl(CTRL_MODEL_TYPE type);
void DeInitCtrlMdl(void);

#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_RT_CTRL_MODEL_H
