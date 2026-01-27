/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_PULSE_H
#define AICPU_PULSE_H

#include <cstdint>
#include "common/type_def.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void (*PulseNotifyFunc)();

/**
 * aicpu pulse notify.
 * timer will call this method per second.
 */
void AicpuPulseNotify();

/**
 * Register kernel pulse notify func.
 * @param name name of kernel lib, must end with '\0' and unique.
 * @param func pulse notify function.
 * @return 0:success, other:failed.
 */
int32_t RegisterPulseNotifyFunc(const char_t * const name, const PulseNotifyFunc func);

/**
 * aicpu pulse notify.
 * call once when aicpu work end.
 */
void ClearPulseNotifyFunc();

#ifdef __cplusplus
}
#endif

#endif // AICPU_PULSE_H_
