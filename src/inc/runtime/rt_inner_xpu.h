/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_XPU_H
#define CCE_RUNTIME_RT_INNER_XPU_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum tagRtXpuDevType {
    RT_DEV_TYPE_DPU = 0,
    RT_DEV_TYPE_REV
} rtXpuDevType;

/**
 * @ingroup xpu dev
 * @brief get xpu device count
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [out] count Currently count=1
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount);

/**
 * @ingroup xpu dev
 * @brief set xpu device
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [in] devId Currently devId=0 is supported
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetXpuDevice(rtXpuDevType devType, const uint32_t devId);

/**
 * @ingroup xpu dev
 * @brief reset xpu device
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [in] devId Currently devId=0 is supported
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtResetXpuDevice(rtXpuDevType devType, const uint32_t devId);

/**
 * @ingroup dvrt_base
 * @brief register callback for xpu task fail
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [in] moduleName unique register name, can't be null
 * @param [in] callback fail task callback function
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtXpuSetTaskFailCallback(rtXpuDevType devType, const char_t *moduleName, rtTaskFailCallback callback);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_XPU_H
