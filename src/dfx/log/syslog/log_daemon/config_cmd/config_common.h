/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CONFIG_COMMON_H
#define CONFIG_COMMON_H

#include <stdint.h>
#include "msnpureport_common.h"

#define RESULT_BUFFER_LEN   1024U

// Error code
#define CONFIG_OK                  0
#define CONFIG_ERROR               (-1)
#define CONFIG_INVALID_PARAM       (-2)
#define CONFIG_MUTEX_ERROR         (-3)
#define CONFIG_MEM_WRITE_FAILED    (-4)
#define CONFIG_MALLOC_FAILED       (-5)
#define CONFIG_BUFFER_NOT_ENOUGH   (-6)
#define CONFIG_LOG_MSGQUEUE_FAILED (-7)

#define SET_SUCCESS_MSG             "Configuration successfully set"

#endif