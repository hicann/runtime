/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_TO_SQE_HPP__
#define __CCE_RUNTIME_TASK_TO_SQE_HPP__

#include <cstdint>
#include <rt_preload_task.h>
#include "task.hpp"

namespace cce{
namespace runtime {

#pragma pack(push)
#pragma pack (1)
/* parma sqe struct info */

typedef struct {
    /* word0 */
    uint16_t type : 3;
    uint16_t pre_p : 1;
    uint16_t post_p : 1;
    uint16_t dump_en : 1;
    uint16_t cond_s : 1;
    uint16_t res0 : 1;
    uint16_t uf : 1;
    uint16_t sw : 1;
    uint16_t res1 : 1;
    uint16_t prefetchNum : 5;
    uint16_t softUser : 6;
    uint16_t res2 : 2;
    uint8_t kernelCredit;

    /* word1 */
    uint32_t taskParamOffset;
} rtStaticSqe_t;

typedef struct {
    /* word0 */
    uint32_t vld : 1;
    uint32_t codeSize : 12;
    uint32_t dynTaskDescSize : 16;
    uint32_t blockDim : 3;

    /* word1 */
    uint32_t taskPcOffset;
} rtDynamicSqe_t;

typedef struct {
    /* word0 */
    uint32_t opType : 2;
    uint32_t res0 : 5;
    uint32_t dataSize : 25;

    /* word1 */
    uint32_t dstOffset : 25;
    uint32_t res1 : 7;

    /* word2 */
    uint32_t srcOffset;
} rtPrefetchSqe_t;

union rtTotalSqe_t {
    rtStaticSqe_t staticSqe;
    rtDynamicSqe_t DynamicSqe;
    rtPrefetchSqe_t PrefetchSqe;
};

typedef struct {
    /* word0 - 1 */
    uint32_t argOffsetAddrLow;
    uint32_t argOffsetAddrHigh;
} rtParmaSqe_t;

#pragma pack(pop)

inline uint32_t get_high_32_addr(uint64_t addr)
{
    return ((addr) >> 32) & 0xFFFFFFFF; // 取高32位
}

inline uint32_t get_low_32_addr(uint64_t addr)
{
    return (addr) & 0xFFFFFFFF;
}


class SqeInfo {
public:
    SqeInfo() = default;
    virtual ~SqeInfo() = default;
};

class ParmaStaticSqe : public SqeInfo {
public:
    using SqeInfo::SqeInfo;
    ~ParmaStaticSqe() override = default;
    static rtError_t ConstructSqe(const rtHwtsStaticTaskDesc_t& hwtsTaskDesc, uint64_t argOffset,
                                  rtStaticSqe_t* staticSqe, uint32_t* taskLen);
};

class ParmaDynamicSqe : public SqeInfo {
public:
    using SqeInfo::SqeInfo;
    ~ParmaDynamicSqe() override = default;
    static rtError_t ConstructSqe(const rtHwtsDynamicTaskDesc_t& hwtsDynamicTaskDesc,
                                  rtDynamicSqe_t* dynamicSqe, uint32_t* taskLen);
};

class ParmaPrefetchSqe : public SqeInfo {
public:
    using SqeInfo::SqeInfo;
    ~ParmaPrefetchSqe() override = default;
    static rtError_t ConstructSqe(const rtParamBufDesc_t& paramBufDesc, rtPrefetchSqe_t* prefetchSqe,
                                  uint32_t bufferLen, uint32_t* taskLen);
};

rtError_t ConstructAicoreStaticSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructHostFuncStaticSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructAicoreDynamicSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructHostFuncDynamicSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructAicoreParamSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructHostFuncParamSqe(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
rtError_t ConstructSqeByTaskInput(const rtTaskInput_t* const taskInput, uint32_t* taskLen);
}
}
#endif
