/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_MEM_BASE_H
#define CCE_MEM_BASE_H

#include "rt_stars_define.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum {
    RT_MEMCPY_KIND_HOST_TO_HOST = 0,        // host to host
    RT_MEMCPY_KIND_HOST_TO_DEVICE,          // host to device
    RT_MEMCPY_KIND_DEVICE_TO_HOST,          // device to host
    RT_MEMCPY_KIND_DEVICE_TO_DEVICE,        // device to device, 1P && P2P
    RT_MEMCPY_KIND_DEFAULT,                 // auto infer copy dir
    RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE,   // host to device ex (only used for 8 bytes) 解决host内存是栈内存和需要立即回收的场景
    RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE,  // 片内 D2D
    RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE,  // 跨片 D2D
    RT_MEMCPY_KIND_MAX,
} rtMemcpyKind;

typedef enum {
    RT_HOST_REGISTER_MAPPED = 0, // HOST_MEM map to device
    RT_HOST_REGISTER_MAX
} rtHostRegisterType;

typedef enum {
    RT_MEMORY_LOC_HOST = 0,
    RT_MEMORY_LOC_DEVICE,
    RT_MEMORY_LOC_UNREGISTERED,
    RT_MEMORY_LOC_MANAGED,
    RT_MEMORY_LOC_MAX,
} rtMemLocationType;

typedef struct {
    uint32_t id;
    rtMemLocationType type;
} rtMemLocation;

typedef struct {
    rtMemLocation location;
    uint32_t pageSize;
    uint32_t rsv[4];    // 预留字段，后续待驱动整改后返回内存类型
} rtPtrAttributes_t;

typedef struct{
    void *dst;
    void *src;
    uint64_t dstPitch;
    uint64_t srcPitch;
    uint64_t width;
    uint64_t height;
    rtMemcpyKind kind;
} rtMemcpy2DParams_t;

typedef struct {
  rtMemLocation dstLoc;
  rtMemLocation srcLoc;
  uint8_t rsv[16];
} rtMemcpyBatchAttr;

/*
    新的接口命名规则，enum类型不加 _t 
*/
typedef enum { 
    RT_MEM_ADVISE_NONE = 0,
    RT_MEM_ADVISE_DVPP,
    RT_MEM_ADVISE_TS,
    RT_MEM_ADVISE_CACHED,
} rtMallocAdvise;

/*
 与aclrtMemMallocPolicy保持一致
*/
typedef enum {
    RT_MEM_MALLOC_HUGE_FIRST,
    RT_MEM_MALLOC_HUGE_ONLY,
    RT_MEM_MALLOC_NORMAL_ONLY,
    RT_MEM_MALLOC_HUGE_FIRST_P2P,
    RT_MEM_MALLOC_HUGE_ONLY_P2P,
    RT_MEM_MALLOC_NORMAL_ONLY_P2P,
    RT_MEM_MALLOC_HUGE1G_ONLY,
    RT_MEM_MALLOC_HUGE1G_ONLY_P2P,
    RT_MEM_TYPE_LOW_BAND_WIDTH = 0x0100,            // DDR type -> RT_MEMORY_DDR
    RT_MEM_TYPE_HIGH_BAND_WIDTH = 0x1000,           // HBM type -> RT_MEMORY_HBM

    RT_MEM_ACCESS_USER_SPACE_READONLY = 0x100000,   // use for dvpp
} rtMallocPolicy;

typedef enum {
    RT_MEM_MALLOC_ATTR_RSV = 0,
    RT_MEM_MALLOC_ATTR_MODULE_ID,   // 申请内存的模块id
    RT_MEM_MALLOC_ATTR_DEVICE_ID,   // 指定deviceId申请内存
    RT_MEM_MALLOC_ATTR_VA_FLAG,   // 设置VA相关特性
    RT_MEM_MALLOC_ATTR_MAX
} rtMallocAttr;

typedef union {
    uint16_t moduleId;  // 默认不配置时，为RUNTIME_ID
    uint32_t deviceId;  // 默认不配置时，为ctx的deviceId
    uint32_t vaFlag;   // 默认不配置时，不使能此VA相关特性
    uint8_t rsv[8];     // 预留8字节
} rtMallocAttrValue;

typedef struct {
    rtMallocAttr attr;
    rtMallocAttrValue value;
} rtMallocAttribute_t;

typedef struct {
    rtMallocAttribute_t *attrs;
    size_t numAttrs;
} rtMallocConfig_t;

typedef struct {    // use for rtMallocAttrValue
    uint16_t moduleId;
    uint32_t deviceId;
} rtConfigValue_t;

typedef void* rtCmoDesc_t;

typedef enum tagRtRecudeKind {
    RT_MEMCPY_SDMA_AUTOMATIC_ADD = 10,  // D2D, SDMA inline reduce, include 1P, and P2P
    RT_MEMCPY_SDMA_AUTOMATIC_MAX = 11,
    RT_MEMCPY_SDMA_AUTOMATIC_MIN = 12,
    RT_MEMCPY_SDMA_AUTOMATIC_EQUAL = 13,
    RT_RECUDE_KIND_END = 14,
} rtRecudeKind_t;

typedef enum tagRtDataType {
    RT_DATA_TYPE_FP32 = 0,  // fp32
    RT_DATA_TYPE_FP16 = 1,  // fp16
    RT_DATA_TYPE_INT16 = 2, // int16
    RT_DATA_TYPE_INT4 = 3,  // int4
    RT_DATA_TYPE_INT8 = 4,  // int8
    RT_DATA_TYPE_INT32 = 5, // int32
    RT_DATA_TYPE_BFP16 = 6, // bfp16
    RT_DATA_TYPE_BFP32 = 7, // bfp32
    RT_DATA_TYPE_UINT8 = 8, // uint8
    RT_DATA_TYPE_UINT16 = 9, // uint16
    RT_DATA_TYPE_UINT32 = 10, // uint32
    RT_DATA_TYPE_END = 11,
} rtDataType_t;

typedef rtRecudeKind_t rtReduceKind;
typedef rtDataType_t rtDataType;

typedef struct {
    void *dst;
    void *src;
    size_t count;
    rtReduceKind kind;
    rtDataType type;
    uint32_t rsv[4];
} rtReduceInfo_t;

#if defined(__cplusplus)
}
#endif

#endif  // CCE_MEM_BASE_H
