/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSN_OPERATE_LOG_LEVEL_H
#define MSN_OPERATE_LOG_LEVEL_H
#include <stdint.h>
/**
    * @brief set or get device log level
    * @param [in] uint16_t devId: device id
    * @param [in] const char *logLevel: device log level(debug/info/warning/error/null etc.)
    * @param [in]logLevelResult: log level result
    * @param [in]logOperatonType: log operaton type
    * @return 0: success; other : failed
    */
int32_t MsnOperateDeviceLogLevel(uint16_t devId,
                                 const char *logLevel,
                                 char *logLevelResult,
                                 int32_t logLevelResultLength,
                                 int32_t logOperatonType);
#endif