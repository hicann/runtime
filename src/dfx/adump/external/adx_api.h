/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_API_H
#define ADX_API_H
#include <stdint.h>
#include "extra_config.h"
#define ADX_API __attribute__((visibility("default")))
#ifdef __cplusplus
extern "C" {
#endif
/**
 * @brief       get device log
 * @param [in]  unsigned short devId : device id
 * @param [in]  desPath : store device log path of host
 * @param [in]  logType : device log type(slog, stackcore, bbox, message etc.)
 * @param [in]  timeout : 0 wait_always, > 0 wait_timeout; unit: ms
 * @return
 *      0 : success; other : failed
 */
ADX_API int32_t AdxGetDeviceFileTimeout(uint16_t devId, IdeString desPath, IdeString logType, uint32_t timeout);
ADX_API int32_t AdxGetDeviceFile(uint16_t devId, IdeString desPath, IdeString logType);
ADX_API int32_t AdxGetSpecifiedFile(uint16_t devId, IdeString desPath, IdeString logType, int32_t hdcType, int32_t compType);
#ifdef __cplusplus
}
#endif
#endif