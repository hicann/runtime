/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_STARS_H
#define CCE_RUNTIME_RTS_STARS_H

#include <stdlib.h>

#include "base.h"
#include "rt_stars_define.h"

#if defined(__cplusplus)
extern "C" {
#endif

#pragma pack(push)
#pragma pack(1)
typedef enum {
    RT_DVPP_CMDLIST_NOT_FREE = 1U,
    RT_DVPP_MAX
} rtDvppAttrId;

typedef union {
    bool isCmdListNotFree;
    uint32_t rsv[4];
} rtDvppAttrVal_t;

typedef struct {
    rtDvppAttrId id;
    rtDvppAttrVal_t value;
} rtDvppAttr_t;

typedef struct {
    rtDvppAttr_t *attrs;
    size_t numAttrs;
} rtDvppCfg_t;
#pragma pack(pop)

typedef struct {
    uint8_t isAddr;           // 0: value, 1: addr
    uint8_t valueOrAddr[8];   // 当isAddr=0，请根据dataType填充相应字节数，如fp16, bf16填充前2个字节;fp32，uint32, int32，则填充前4个字节; uint64, int64则填充8个字节。当isAddr=1时，则填充8字节的地址值
    uint8_t size;             // 对valueOrAddr实际填充的字节数
    uint8_t rsv[6];
} rtRandomParaInfo_t;

// dropout bitmask
typedef struct {
    rtRandomParaInfo_t dropoutRation;
} rtDropoutBitMaskInfo_t;

// 均匀分布
typedef struct {
    rtRandomParaInfo_t min;
    rtRandomParaInfo_t max;
} rtUniformDisInfo_t;

// 正态分布、截断正态分布
typedef struct {
    rtRandomParaInfo_t mean;
    rtRandomParaInfo_t stddev;
} rtNormalDisInfo_t;

typedef enum {
    RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK = 0, // dropout bitmask
    RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS,          // 均匀分布
    RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS,           // 正态分布
    RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS,  // 截断正态分布
    RT_RANDOM_NUM_FUNC_TYPE_MAX
} rtRandomNumFuncType;

typedef enum {
    RT_RANDOM_NUM_DATATYPE_INT32 = 0,
    RT_RANDOM_NUM_DATATYPE_INT64,
    RT_RANDOM_NUM_DATATYPE_UINT32,
    RT_RANDOM_NUM_DATATYPE_UINT64,
    RT_RANDOM_NUM_DATATYPE_BF16,
    RT_RANDOM_NUM_DATATYPE_FP16,
    RT_RANDOM_NUM_DATATYPE_FP32,
    RT_RANDOM_NUM_DATATYPE_MAX
} rtRandomNumDataType;

typedef struct {
    rtRandomNumFuncType funcType;
    union {
        rtDropoutBitMaskInfo_t dropoutBitmaskInfo; // for dropout bitmask
        rtUniformDisInfo_t uniformDisInfo; // 均匀分布
        rtNormalDisInfo_t normalDisInfo; // 正态分布、截断正态分布
    } paramInfo;
} rtRandomNumFuncParaInfo_t;

typedef struct {
    rtRandomNumDataType dataType;
    rtRandomNumFuncParaInfo_t randomNumFuncParaInfo;
    void *randomParaAddr;  // 判断是否为空指针
    void *randomResultAddr;   // GE申请内存
    void *randomCounterAddr;  // GE申请内存
    rtRandomParaInfo_t randomSeed;
    rtRandomParaInfo_t randomNum;
    uint8_t rsv[8];
} rtRandomNumTaskInfo_t;

/**
 * @ingroup rts_stars
 * @brief launch DVPP task
 * @param [in] sqe dvpp sqe
 * @param [in] sqeLen dvpp sqe length
 * @param [in] stm stream
 * @param [in] cfg dvpp option cfg
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtLaunchDvppTask(const void *sqe, uint32_t sqeLen, rtStream_t stm, rtDvppCfg_t *cfg);

/**
 * @ingroup rts_stars
 * @brief launch random num task
 * @param [in] taskInfo random num task info
 * @param [in] stm stream
 * @param [in] reserve reserve param
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsLaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stm, void *reserve);

/**
 * @ingroup rts_stars
 * @brief launch barrier cmo task on the stream.
 * @param [in] taskInfo     barrier task info
 * @param [in] stm          launch task on the stream
 * @param [in] flag         flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsLaunchBarrierTask(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief write va addr value
 * @param [in] writeValueInfo : write value info
 * @param [in] stm
 * @param [in] pointedAddr : the device virtual addr for write value sqe, user should alloc 64B(sqe' size) for that
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtWriteValuePtr(void * const writeValueInfo, rtStream_t const stm, void * const pointedAddr);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_STARS_H