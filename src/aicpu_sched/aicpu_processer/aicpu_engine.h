/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPU_ENGINE_H
#define AICPU_ENGINE_H

#include <stdint.h>
#include "common/type_def.h"

#ifdef __cplusplus
extern "C" {
#endif
enum aeStatus_t {
    AE_STATUS_SUCCESS = 0,
    AE_STATUS_TASK_FAIL = 1,
    AE_STATUS_END_OF_SEQUENCE = 6,
    AE_STATUS_SILENT_FAULT = 7,
    AE_STATUS_TASK_ABORT = 8,
    AE_STATUS_DETECT_FAULT = 9,
    AE_STATUS_DETECT_FAULT_NORAS = 10,
    AE_STATUS_DETECT_LOW_BIT_FAULT = 11,
    AE_STATUS_DETECT_LOW_BIT_FAULT_NORAS = 12,
    AE_STATUS_TASK_WAIT = 101,
    AE_STATUS_BAD_PARAM = 11001,
    AE_STATUS_OPEN_SO_FAILED = 11002,
    AE_STATUS_GET_KERNEL_NAME_FAILED = 11003,
    AE_STATUS_KERNEL_API_PARAM_INVALID = 11004,
    AE_STATUS_KERNEL_API_INNER_ERROR = 11005,
    AE_STATUS_INNER_ERROR = 11006,
    AE_STATUS_SO_NAME_INVALID = 11007,
    AE_STATUS_KERNEL_NAME_INVALID = 11008,
    AE_STATUS_RESERVED = 11009
};

/**
 * @ingroup aicpu engine
 * @brief aeCallInterface:
 *          a interface to call a function in a op kernfel lib
 * @param [in] addr     void *,  should be STR_KERNEL * format
 * @return int32_t
 */
int32_t aeCallInterface(const void * const addr);

/**
 * @ingroup aicpu engine
 * @brief aeClear: a interface to clear all ai kernel lib
 * @return aeStatus_t
*/
void aeClear();

/**
 * @ingroup aicpu engine
 * @brief aeBatchLoadKernelSo:
 *          a interface to load kernel so
 * @param [in] kernelType kernel type
 * @param [in] loadSoNum  load so number
 * @param [in] soNames    load so names
 * @return aeStatus_t
 */
aeStatus_t aeBatchLoadKernelSo(const uint32_t kernelType, const uint32_t loadSoNum,
                               const char_t * const * const soNames);

/**
 * @ingroup aicpu engine
 * @brief aeCloseSo:
 *          a interface to close so
 * @param [in] kernelType kernelType
 * @param [in] soName     load so name
 * @return aeStatus_t
 */
aeStatus_t aeCloseSo(const uint32_t kernelType, const char_t * const soName);

/**
 * @ingroup aicpu engine
 * @brief aeAddSoInWhiteList:
 *        add soname in white list
 * @param [in] soName     add so name
 * @return aeStatus_t
 */
aeStatus_t __attribute__((weak)) AeAddSoInWhiteList(const char_t * const soName);


/**
 * @ingroup aicpu engine
 * @brief aeDeleteSoInWhiteList:
 *        delete soname in white list
 * @param [in] soName     delete so name
 * @return void
 */
void __attribute__((weak)) AeDeleteSoInWhiteList(const char_t * const soName);

#ifdef __cplusplus
}
#endif
#endif  // AICPU_ENGINE_H
