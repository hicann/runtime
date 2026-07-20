/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_INNER_KERNEL_H
#define CCE_RUNTIME_INNER_KERNEL_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum tagRtStackType { RT_STACK_TYPE_SCALAR = 0, RT_STACK_TYPE_SIMT } rtStackType_t;

/**
 * @ingroup rt_kernel
 * @brief Get Stack Buffer
 * @param [in] binHandle    bin handle
 * @param [in] deviceId     device id
 * @param [in] stackType    stack type
 * @param [in] coreType     core type
 * @param [in] coreId       core id
 * @param [out] stack       stack buffer
 * @param [out] stackSize   stack size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetStackBuffer(
    const rtBinHandle binHandle, uint32_t deviceId, const uint32_t stackType, const uint32_t coreType,
    const uint16_t coreId, const void** stack, uint32_t* stackSize);

/**
 * @ingroup rt_kernel
 * @brief get kernel size, if kernel is mix, the output param aicSize and aivSize are both valid,
 * otherwise, there will be only one valid size.
 * @param [in] funcHandle the kernel
 * @param [out] aicSize   kernel size of aicube
 * @param [out] aivSize   kernel size of aivector
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtFuncGetSize(const rtFuncHandle funcHandle, size_t* aicSize, size_t* aivSize);

/**
 * @ingroup rt_kernel
 * @brief Find binHandle based on funcHandle.
 * @param [in] funcHandle  the kernel
 * @param [out] binHandle  bin handle
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtFunctionGetBinary(const rtFuncHandle funcHandle, rtBinHandle* binHandle);

/**
 * @brief get parameter count from function handle.
 * @param [in]  func        function handle
 * @param [out] paramCount  parameter count
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtFunctionGetParamCount(const void* func, size_t* paramCount);

/**
 * @brief get parameter info from function handle by index.
 * @param [in]  func        function handle
 * @param [in]  paramIndex  parameter index
 * @param [out] paramOffset parameter offset in bytes
 * @param [out] paramSize   parameter size in bytes
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtFunctionGetParamInfo(const void* func, size_t paramIndex, size_t* paramOffset, size_t* paramSize);

/**
 * @brief get available dynamic ubuf size per block from function handle.
 * @param [in]  func            function handle
 * @param [in]  flags           reserved
 * @param [out] dynamicUbufSize available dynamic ubuf size in bytes
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtFunctionGetAvailDynUbufPerBlock(void* func, uint32_t flags, size_t* dynamicUbufSize);

/**
 * @ingroup rt_kernel
 * @brief find the device address and size associated with symbol.
 * @param [in] hostVar   device symbol reference.
 * @param [out] devPtr   device pointer associated with symbol.
 * @param [out] size   size of object associated with symbol.
 * @retval ACL_RT_SUCCESS for ok.
 * @retval RT_ERROR_INVALID_SYMBOL invalid device symbol.
 * @retval ACL_ERROR_RT_PARAM_INVALID for error input.
 */
RTS_API rtError_t rtSymbolLookup(const void* hostVar, void** devPtr, size_t* size);

/**
 * @ingroup rts_kernel
 * @brief Get global symbol address and size from binary.
 * @param [in] binHandle    bin handle
 * @param [in] name         global symbol name
 * @param [out] dptr        global symbol device address (can be nullptr)
 * @param [out] size        global symbol size (can be nullptr)
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_SYMBOL_NOT_FOUND if symbol not found
 */
RTS_API rtError_t rtBinaryGetGlobal(const rtBinHandle binHandle, const char* name, void** dptr, size_t* size);

/**
 * @ingroup rt_kernel
 * @brief Get function handle by function symbol.
 * @param [in] symbol kernel function name
 * @param [out] funcHandle if find, this will be the function handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 * @return ACL_ERROR_RT_INVALID_DEVICE_FUNCTION for symbol not found in funcsymbol table
 */
RTS_API rtError_t rtGetFuncBySymbol(const void* symbol, rtFuncHandle* funcHandle);

#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_INNER_KERNEL_H