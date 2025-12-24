/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_NNOPBASE_H
#define OP_API_OP_API_COMMON_INC_OPDEV_NNOPBASE_H

#include "runtime/base.h"
#include "opdev/common_types.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    void *addr;
    size_t size;
    bool isOptional;
    bool isVector;
    size_t elementSize;
} NnopbaseAttrAddr;

/**
 * @description: find static kernel path for hostapi
 * @param [in] opType
 * @param [in] tensors input and output tensor
 * @param [in] numTensors input and output number
 * @param [in] dynamicIndex dynamic input and output index
 * @param [in] dynamicCount every dynamic input number
 * @param [in] numDynamic dynamic input and output number
 * @param [in] attrs attributes
 * @param [in] numAttrs attribute number
 * @param [in] implMode high performance and high precision switch
 * @param [in] deterMode deterministic switch
 * @param [in] valueDepend valueDepend input index
 * @param [in] numValueDepend valueDepend input number
 * @return if find static kernel return path else return nullptr
 */
const char *NnopbaseFindStaticKernel(const char *opType, const aclTensor* tensors[],
    int64_t numTensors, const int64_t dynamicIndex[], const int64_t dynamicCount[],
    int64_t numDynamic, const NnopbaseAttrAddr* attrs[], int64_t numAttrs, int64_t implMode, int64_t deterMode,
    const int64_t valueDepend[], int64_t numValueDepend);


/**
 * @description: 获取从stream和event
 * @param [in] stream 用户传入的主stream
 * @param [in] subStream 创建的从stream
 * @param [in] evtA 创建的eventA
 * @param [in] evtB 创建的eventB
 * @param [in] streamLckPtr 返回的stream级别的锁
 * @return OK for ok
 * @return ACLNN_ERR_RUNTIME_ERROR for error input
 */
aclnnStatus NnopbaseGetStreamAndEvent(const rtStream_t stream, rtStream_t *subStream,
    rtEvent_t *evtA, rtEvent_t *evtB, std::shared_ptr<std::mutex> &streamLckPtr);
#ifdef __cplusplus
}
#endif
#endif
