/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_EXCEPTION_CALLBACK_H
#define ADX_EXCEPTION_CALLBACK_H
#include <cstdint>
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ADX_API __declspec(dllexport)
#else
#define ADX_API __attribute__((visibility("default")))
#endif
namespace Adx {

/**
 * @name  HeadProcess
 * @brief Callback for increasing target size
 * @param addr          [IN] Pointer to the header addr
 * @param headerSize    [IN] Header size
 * @param newHeaderSize [OUT] New header size after target size is added
 * @return success: 0, fail: -1
 */
using HeadProcess = int32_t (*)(uint32_t deviceId, const void *addr, uint64_t headerSize, uint64_t &newHeaderSize);

/**
 * @name  TensorProcess
 * @brief Callback for increasing target size content
 * @param addr      [IN] Pointer to the header addr
 * @param size      [IN] Header size
 * @param fd        [IN] File descriptor
 * @return success: 0, fail: -1
 */
using TensorProcess = int32_t (*)(uint32_t deviceId, const void *addr, uint64_t size, int32_t fd);

enum class DfxTensorType : uint16_t {
    INVALID_TENSOR = 0,
    GENERAL_TENSOR = 1,
    INPUT_TENSOR,
    OUTPUT_TENSOR,
    WORKSPACE_TENSOR,
    ASCENDC_LOG = 5,
    MC2_CTX,
    TILING_DATA,
    L1,
    L2,
    OVERFLOW_ADDRESS = 10,
    FFTS_ADDRESS,
    SHAPE_TENSOR,
    ARGS = 101,    // args以下为 coredump 新增的，中间预留，从101开始定义
    STACK = 102,
    DEVICE_KERNEL_OBJECT = 103,   //device侧GM中算子.o数据
};

/**
 * @name  AdumpRegHeadProcess
 * @brief Callback register for header size increase
 * @param tensorType    [IN] tensor type
 * @param headProcess   [IN] Callback function for header size increase
 * @return success: 0, fail: -1
 */
ADX_API int32_t AdumpRegHeadProcess(DfxTensorType tensorType, HeadProcess headProcess);

/**
 * @name  AdumpRegTensorProcess
 * @brief Callback register for tensor data writing
 * @param tensorType      [IN] tensor type
 * @param tensorProcess   [IN] Callback function for tensor data writing
 * @return success: 0, fail: -1
 */
ADX_API int32_t AdumpRegTensorProcess(DfxTensorType tensorType, TensorProcess tensorProcess);

} // namespace Adx

#endif