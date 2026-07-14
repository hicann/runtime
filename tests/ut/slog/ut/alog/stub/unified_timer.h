/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef UNIFIED_TIMER_H
#define UNIFIED_TIMER_H

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

enum TimerType {
    ONESHOT_TIMER = 0,
    PERIODIC_TIMER = 1,
};

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // UNIFIED_TIMER_H
