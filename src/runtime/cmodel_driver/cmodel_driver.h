/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CMODEL_DRIVER_H__
#define __CMODEL_DRIVER_H__

#include "securec.h"
#include "driver/ascend_hal.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#define  DRVSTUB_LOG_ON 1

#ifdef DRVSTUB_LOG_ON
#define DRVSTUB_LOG(format, ...) do {    \
        (void)fprintf(stdout, "[DRVSTUB_LOG] %s:%d %s:" format "\n", (const char *)__FILE__, __LINE__, __func__,    \
        ##__VA_ARGS__);    \
    } while (false)
#else
#define DRVSTUB_LOG(format, ...)
#endif

#define COND_RETURN_CMODEL(COND, ERRCODE, format, ...) if (COND) {    \
        DRVSTUB_LOG(format, ##__VA_ARGS__);    \
        return (ERRCODE);    \
    }

#define COND_GOTO_CMODEL(COND, LABEL, ERROR, ERRCODE, format, ...) \
    if (COND) {                                            \
        DRVSTUB_LOG(format, ##__VA_ARGS__);                          \
        ERROR = (drvError_t)(ERRCODE);                               \
        goto LABEL;                                        \
    }

#ifndef UNUSED
#define UNUSED(expr) do { \
    (void)(expr); \
} while (false)
#endif

/*
 * @ingroup driver-stub
 * @brief stub. there are 1 devices.
 */
#define MAX_DEV_NUM (1)
/*
 * @ingroup driver-stub
 * @brief stub.turn device handle to device id.
 */
#define DEVICE_HANDLE_TO_ID(X) X

/**
* @ingroup driver-stub
* @brief Copy the data in the source buffer to the destination buffer synchronously
* @attention
* 1. The destination buffer must have enough space to store the contents of the source buffer to be copied.
* 2. (offline) This interface cannot process data larger than 2G
* @param [in] dst  Unsigned 64-bit integer, memory address to be initialized
* @param [in] destMax  The maximum number of valid initial memory values that can be set
* @param [in] value  16-bit unsigned, initial value set
* @param [in] num  Set the number of memory space initial values
* @param [in] kind  Set the direction of memory copy
* @return DRV_ERROR_NONE : success
* @return DRV_ERROR_INVALID_HANDLE : Internal error, copy failed
*/
DVresult cmodelDrvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t size, drvMemcpyKind_t kind);

/**
* @ingroup driver-stub
* @brief Release host-side memory resources
* @attention null
* @param [in] pp  Pointer to the memory space to be released
* @return DRV_ERROR_NONE : success
* @return DRV_ERROR_INVALID_VALUE : Pointer is empty
*/
drvError_t cmodelDrvFreeHost(void *pp);


/**
* @ingroup driver-stub
* @brief open device
* @attention:
*   1)it will return error when reopen device
*   2)assure invoked TsdOpen successfully, before invoke this api
* @param [in] devId  device id
* @param [out] devInfo  device information
* @return   0 for success, others for fail
*/
drvError_t drvDeviceOpen(void **devInfo, uint32_t devId);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __DRIVER_QUEUE_H__ */
