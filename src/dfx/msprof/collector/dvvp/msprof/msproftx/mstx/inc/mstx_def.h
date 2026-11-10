/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSTX_DATA_TYPE_H
#define MSTX_DATA_TYPE_H

#define MSTX_INVALID_RANGE_ID 0
#define MSTX_SUCCESS 0
#define MSTX_FAIL 1
#define MSTX_TOOLS_MSPROF_ID 0x1000

typedef enum { MODULE_INVALID, PROF_MODULE_MSPROF, PROF_MODULE_MSPTI, PROF_MODULE_SIZE } ProfModule;

/* 资源命名：与 mstx 头文件 mstxResourceType 保持一致 */
typedef enum {
    MSTX_RESOURCE_TYPE_INVALID = 0,
    MSTX_RESOURCE_TYPE_OS_THREAD = 1,
    MSTX_RESOURCE_TYPE_DEVICE = 2,
    MSTX_RESOURCE_TYPE_STREAM = 3,
    MSTX_RESOURCE_TYPE_EVENT = 4,
    MSTX_RESOURCE_TYPE_CATEGORY = 5,
    MSTX_RESOURCE_TYPE_GENERIC_POINTER = 6,
    MSTX_RESOURCE_TYPE_SIZE
} MstxResourceType;

#define MSTX_RESOURCE_NAME_MAX_LEN 64
typedef uint64_t mstxResourceHandle_t;
typedef struct MstxResourceAttributes {
    uint32_t version;
    uint32_t size;
    MstxResourceType resourceType;
    union {
        uint64_t idValue;
        const void* ptrValue;
    } identifier;
    const char* name;
    uint32_t category;
} MstxResourceAttributes;

typedef enum {
    MSTX_API_MODULE_INVALID = 0,
    MSTX_API_MODULE_CORE = 1,
    MSTX_API_MODULE_CORE_DOMAIN = 2,
    MSTX_API_MODULE_CORE_MEM = 3, // 占位：本仓不实现 mem 模块，但模块号必须与客户端一致
    MSTX_API_MODULE_CORE_NAME = 4,
    MSTX_API_MODULE_SIZE,         // end of the enum, new enum items must be added before this
    MSTX_API_MODULE_FORCE_INT = 0x7fffffff
} MstxFuncModule;

typedef enum {
    MSTX_FUNC_START = 0,
    MSTX_FUNC_MARKA = 1,
    MSTX_FUNC_RANGE_STARTA = 2,
    MSTX_FUNC_RANGE_END = 3,
    MSTX_API_CORE_MEMHEAP_REGISTER = 4,
    MSTX_API_CORE_MEMHEAP_UNREGISTER = 5,
    MSTX_API_CORE_MEM_REGIONS_REGISTER = 6,
    MSTX_API_CORE_MEM_REGIONS_UNREGISTER = 7,
    MSTX_FUNC_END
} MstxCoreFuncId;

typedef enum {
    MSTX_FUNC_NAME_START = 0,
    MSTX_FUNC_NAME_OS_THREAD = 1,
    MSTX_FUNC_NAME_DEVICE = 2,
    MSTX_FUNC_NAME_STREAM = 3,
    MSTX_FUNC_NAME_EVENT = 4,
    MSTX_FUNC_NAME_CATEGORY = 5,
    MSTX_FUNC_NAME_RESOURCE_CREATE = 6,
    MSTX_FUNC_NAME_RESOURCE_DESTROY = 7,
    MSTX_FUNC_NAME_END
} MstxCoreNameFuncId;

typedef enum {
    MSTX_FUNC_DOMAIN_START = 0,
    MSTX_FUNC_DOMAIN_CREATEA = 1,
    MSTX_FUNC_DOMAIN_DESTROY = 2,
    MSTX_FUNC_DOMAIN_MARKA = 3,
    MSTX_FUNC_DOMAIN_RANGE_STARTA = 4,
    MSTX_FUNC_DOMAIN_RANGE_END = 5,
    MSTX_FUNC_DOMAIN_END
} MstxCore2FuncId;

using mstxRangeId = uint64_t;

struct MstxDomainRegistrationSt {};
typedef struct MstxDomainRegistrationSt MstxDomainHandle;
typedef MstxDomainHandle* mstxDomainHandle_t;

typedef void* aclrtStream;
typedef void (*MstxFuncPointer)(void);
typedef MstxFuncPointer** MstxFuncTable;
typedef int (*MstxGetModuleFuncTableFunc)(MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize);
typedef int (*MstxInitInjectionFunc)(MstxGetModuleFuncTableFunc);

// mstx 模块表填充器：module 是本仓实现的模块号，setter 负责把实现写进对端提供的函数表。
// 各通道的遍历范围由自己的实现清单决定，不依赖对端枚举值 MSTX_API_MODULE_SIZE。
struct MstxModuleBinder {
    MstxFuncModule module;
    void (*setter)(MstxFuncTable outTable, unsigned int outSize);
};

#endif
