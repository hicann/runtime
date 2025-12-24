/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_LOG_H
#define ADX_LOG_H
#include "msprof_dlog.h"
#define IDE_CTRL_VALUE_FAILED(err, action, logText, ...) do {          \
    if (!(err)) {                                                      \
        MSPROF_LOGE(logText, ##__VA_ARGS__);                           \
        action;                                                        \
    }                                                                  \
} while (0)

#define IDE_CTRL_VALUE_WARN(err, action, logText, ...) do {            \
    if (!(err)) {                                                      \
        MSPROF_LOGW(logText, ##__VA_ARGS__);                           \
        action;                                                        \
    }                                                                  \
} while (0)

#define IDE_CTRL_VALUE_WARN_EX(err, action, logText, ...) do {         \
    if (err) {                                                         \
        MSPROF_LOGW(logText, ##__VA_ARGS__);                           \
        action;                                                        \
    }                                                                  \
} while (0)

#endif
