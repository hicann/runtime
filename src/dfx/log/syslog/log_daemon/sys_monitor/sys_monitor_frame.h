/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SYS_MONITOR_FRAME_H
#define SYS_MONITOR_FRAME_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif
/* sys monitor is not supported in multi-thread */

/**
 * @brief       : init sys monitor
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
 int32_t SysmonitorInit(void);

 /**
 * @brief       : start sys monitor process
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
 int32_t SysmonitorProcess(void);

 /**
 * @brief       : exit sys monitor process
 */
 void SysmonitorExit(void);

#ifdef __cplusplus
}
#endif
#endif
