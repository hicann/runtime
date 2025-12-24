/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKCORE_FILE_MONITOR_H
#define STACKCORE_FILE_MONITOR_H
#include <stdint.h>
#include <file_monitor_common.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief         : Initialize the global variable and register a periodic event to age stackcore files
 * @param [in]func: the function pointer for synchronizing files
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorInit(FileMonitorSyncFunc func);

/**
 * @brief         : Release the dynamic memory and delete the event for aging stackcore files
 * @param [in]    : -
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
void StackcoreMonitorExit(void);

/**
 * @brief          : start the stackcore file monitor after the session is established.
 * @param [in]     : -  
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorStart(void);

/**
 * @brief          : stop the stackcore file monitor after the session is disconnected.
 * @param [in]     : -  
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorStop(void);

#ifdef __cplusplus
}
#endif
#endif // STACKCORE_FILE_MONITOR_H