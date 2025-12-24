/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_RAS_H
#define CCE_RUNTIME_RT_RAS_H

#include "base.h"
#include "event.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum {
    RT_NO_ERROR = 0, // no error
    RT_ERROR_MEMORY,
    RT_ERROR_L2,
    RT_ERROR_AICORE,
    RT_ERROR_LINK,
    RT_ERROR_OTHERS = 0xFFFF, // other errors
} rtErrType;

typedef enum {
    RT_AICORE_ERROR_UNKNOWN = 0,
    RT_AICORE_ERROR_SW,
    RT_AICORE_ERROR_HW_LOCAL,
} rtAicoreErrorType;

typedef struct {
    size_t arraySize;
    rtMemRepairAddr repairAddrArray[RT_MAX_RECORD_PA_NUM_PER_DEV];
} rtMemUceArray;

typedef union {
    rtMemUceArray uceInfo;
    rtAicoreErrorType aicoreErrType;
} rtErrorInfoDetail;

typedef struct {
    uint8_t tryRepair;
    uint8_t hasDetail; // 1 means detail effective
    uint8_t rsv[2];
    rtErrType errorType;
    rtErrorInfoDetail detail;
} rtErrorInfo;


/**
 * @brief get error verbose info.
 * attention:
 *  1. it's used for get error verbose info when a fault event occurs.
 *  2. it must be called after the fault event is obtained and before the task abort is submitted.
 * @param [in] deviceId    : device id.
 * @param [out] errorInfo  : returned error info.
 * @return RT_ERROR_NONE for ok
 * @return other failed
 */
RTS_API rtError_t rtsGetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo);

/**
 * @brief repair error based on verbose info.
 * attention:
 *  1. it's used for repair error based on verbose info when a fault event occurs.
 *  2. it must be called after the rtsGetErrorVerbose.
 * @param [in] deviceId    : device id.
 * @param [in] errorInfo   : error verbose info, obatin from rtsGetErrorVerbose.
 * @return RT_ERROR_NONE for ok
 * @return other failed
 */
RTS_API rtError_t rtsRepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_RAS_H
