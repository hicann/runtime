/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_MEM_H
#define CCE_RUNTIME_MEM_H

#include <stddef.h>
#include "base.h"
#include "config.h"
#include "stream.h"
#include "mem_base.h"
#include "rt_stars_define.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup dvrt_mem
 * @brief memory type
 */
#define RT_MEMORY_DEFAULT (0x0U)   // default memory on device
#define RT_MEMORY_HBM (0x2U)       // HBM memory on device
#define RT_MEMORY_RDMA_HBM (0x3U)  // RDMA-HBM memory on device
#define RT_MEMORY_DDR (0x4U)       // DDR memory on device
#define RT_MEMORY_SPM (0x8U)       // shared physical memory on device
#define RT_MEMORY_P2P_HBM (0x10U)  // HBM memory on other 4P device
#define RT_MEMORY_P2P_DDR (0x11U)  // DDR memory on other device
#define RT_MEMORY_DDR_NC (0x20U)   // DDR memory of non-cache
#define RT_MEMORY_TS (0x40U)       // Used for Ts memory
#define RT_MEMORY_TS_4G (0x40U)    // Used for Ts memory(only 51)
#define RT_MEMORY_HOST (0x81U)     // Memory on host
#define RT_MEMORY_SVM (0x90U)      // Memory for SVM
#define RT_MEMORY_HOST_SVM (0x90U) // Memory for host SVM
#define RT_MEMORY_RESERVED (0x100U)

// MEMORY_UB (0x1U << 15U) It has been occupied by GE/FE. Do not use it.
#define RT_MEMORY_L1 (0x1U << 16U)
#define RT_MEMORY_L2 (0x1U << 17U)

/**
 * @ingroup dvrt_mem
 * @brief memory info type for rtMemGetInfoByType
 */
#define RT_MEM_INFO_TYPE_DDR_SIZE          (0x1U)   // DDR memory type 
#define RT_MEM_INFO_TYPE_HBM_SIZE          (0x2U)   // HBM memory type
#define RT_MEM_INFO_TYPE_DDR_P2P_SIZE      (0x3U)   // DDR P2P memory type
#define RT_MEM_INFO_TYPE_HBM_P2P_SIZE      (0x4U)   // HBM P2P memory type
#define RT_MEM_INFO_TYPE_ADDR_CHECK        (0x5U)   // check addr
#define RT_MEM_INFO_TYPE_CTRL_NUMA_INFO    (0x6U)   // query device ctrl numa id config
#define RT_MEM_INFO_TYPE_AI_NUMA_INFO      (0x7U)   // query device ai numa id config
#define RT_MEM_INFO_TYPE_BAR_NUMA_INFO     (0x8U)   // query device bar numa id config
#define RT_MEM_INFO_TYPE_SVM_GRP_INFO      (0x9U)   // query device svm group info
#define RT_MEM_INFO_TYPE_UB_TOKEN_INFO     (0xAU)   // query device ub token info
#define RT_MEM_INFO_TYPE_SYS_NUMA_INFO     (0xBU)   // query device sys numa id config
#define RT_MEM_INFO_TYPE_MAX               (0xCU)   // max type

/**
 * @ingroup dvrt_mem
 * @brief memory Policy
 */
#define RT_MEMORY_POLICY_NONE (0x0U)                     // Malloc mem prior huge page, then default page
#define RT_MEMORY_POLICY_HUGE_PAGE_FIRST (0x400U)    // Malloc mem prior huge page, then default page, 0x1U << 10U
#define RT_MEMORY_POLICY_HUGE_PAGE_ONLY (0x800U)     // Malloc mem only use huge page, 0x1U << 11U
#define RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY (0x1000U)  // Malloc mem only use default page, 0x1U << 12U
// Malloc mem prior huge page, then default page, for p2p, 0x1U << 13U
#define RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P (0x2000U)
#define RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P (0x4000U)     // Malloc mem only use huge page, use for p2p, 0x1U << 14U
#define RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P (0x8000U)  // Malloc mem only use default page, use for p2p, 0x1U << 15U
#define RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY (0x10000U)   // Malloc mem only use 1G huge page, 0x1U << 16U
#define RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P (0x20000U)   // Malloc mem only use 1G huge page, use for p2p, 0x1U << 17U

/**
 * @ingroup dvrt_mem
 * @brief memory attribute
 */
#define RT_MEMORY_ATTRIBUTE_DEFAULT (0x0U)
// memory read only attribute, now only dvpp memory support.
#define RT_MEMORY_ATTRIBUTE_READONLY (0x100000U)    // Malloc readonly, 1<<20.

#define MEM_ALLOC_TYPE_BIT (0x3FFU)  // mem type bit in <0, 9>

/**
 * @ingroup dvrt_mem
 * @brief virt mem type
 */
#define RT_MEM_DVPP (0x0U)
#define RT_MEM_DEV (0x4000000U) // MEM_DEV, 1<<26.

#define RT_MEMORY_ALIGN_SIZE_BIT (27U) // mem align bit in <27, 31>
#define RT_MEMORY_ALIGN_SIZE_MASK (0xf8000000U)

/**
 * @ingroup dvrt_mem
 * @brief (memory type | memory Policy) or (RT_MEM_INFO_xxx)
 */
typedef uint32_t rtMemType_t;

/**
 * @ingroup dvrt_mem
 * @brief memory advise type
 */
#define RT_MEMORY_ADVISE_EXE (0x02U)
#define RT_MEMORY_ADVISE_THP (0x04U)
#define RT_MEMORY_ADVISE_PLE (0x08U)
#define RT_MEMORY_ADVISE_PIN (0x16U)


/**
 * @ingroup dvrt_mem
 * @brief memory type mask for RT_MEM_INFO_TYPE_ADDR_CHECK
 */
#define RT_MEM_MASK_SVM_TYPE    (0x1U)
#define RT_MEM_MASK_DEV_TYPE    (0x2U)
#define RT_MEM_MASK_HOST_TYPE   (0x4U)
#define RT_MEM_MASK_DVPP_TYPE   (0x8U)
#define RT_MEM_MASK_HOST_AGENT_TYPE (0x10U)
#define RT_MEM_MASK_RSVD_TYPE   (0x20U)

/**
 * @ingroup dvrt_mem
 * @brief register host memory
 */
#define RT_MEM_HOST_REGISTER_MAPPED (0X2U)
#define RT_MEM_HOST_REGISTER_PINNED (0X10000000U)

/**
 * @ingroup dvrt_mem
 * @brief memory copy type
 */
typedef enum tagRtMemcpyKind {
    RT_MEMCPY_HOST_TO_HOST = 0,  // host to host
    RT_MEMCPY_HOST_TO_DEVICE,    // host to device
    RT_MEMCPY_DEVICE_TO_HOST,    // device to host
    RT_MEMCPY_DEVICE_TO_DEVICE,  // device to device, 1P && P2P
    RT_MEMCPY_MANAGED,           // managed memory
    RT_MEMCPY_ADDR_DEVICE_TO_DEVICE,
    RT_MEMCPY_HOST_TO_DEVICE_EX, // host  to device ex (only used for 8 bytes)
    RT_MEMCPY_DEVICE_TO_HOST_EX, // device to host ex
    RT_MEMCPY_DEFAULT,           // auto infer copy dir
    RT_MEMCPY_RESERVED,
} rtMemcpyKind_t;

typedef enum tagRtMemInfoType {
    RT_MEMORYINFO_DDR,
    RT_MEMORYINFO_HBM,
    RT_MEMORYINFO_DDR_HUGE,               // Hugepage memory of DDR
    RT_MEMORYINFO_DDR_NORMAL,             // Normal memory of DDR
    RT_MEMORYINFO_HBM_HUGE,               // Hugepage memory of HBM
    RT_MEMORYINFO_HBM_NORMAL,             // Normal memory of HBM
    RT_MEMORYINFO_DDR_P2P_HUGE,           // Hugepage memory of DDR
    RT_MEMORYINFO_DDR_P2P_NORMAL,         // Normal memory of DDR
    RT_MEMORYINFO_HBM_P2P_HUGE,           // Hugepage memory of HBM
    RT_MEMORYINFO_HBM_P2P_NORMAL,         // Normal memory of HBM
    RT_MEMORYINFO_HBM_HUGE1G,             // 1G HugePage memory of HBM
    RT_MEMORYINFO_HBM_P2P_HUGE1G,         // 1G HugePage memory of HBM
} rtMemInfoType_t;

typedef rtMemInfoType_t rtMemInfoType;

typedef enum rtMemcpyAttributeId {
    RT_MEMCPY_ATTRIBUTE_RSV = 0,
    RT_MEMCPY_ATTRIBUTE_CHECK = 1,
    RT_MEMCPY_ATTRIBUTE_MAX = 2,
} rtMemcpyAttributeId_t;
 
typedef union rtMemcpyAttributeValue_union {
    uint32_t rsv[4];
    uint32_t checkBitmap; // bit0：Do not check for matching between address and kind；bit1：check addr is page-lock
} rtMemcpyAttributeValue_t;
 
typedef struct rtMemcpyAttribute {
    rtMemcpyAttributeId_t id;
    rtMemcpyAttributeValue_t value;
} rtMemcpyAttribute_t;
 
typedef struct rtMemcpyConfig {
    rtMemcpyAttribute_t* attrs;
    uint32_t numAttrs;
} rtMemcpyConfig_t;

/**
 * @ingroup dvrt_mem
 * @brief memory copy channel  type
 */
typedef enum tagRtMemcpyChannelType {
    RT_MEMCPY_CHANNEL_TYPE_INNER = 0,  // 1P
    RT_MEMCPY_CHANNEL_TYPE_PCIe,
    RT_MEMCPY_CHANNEL_TYPE_HCCs,  // not support now
    RT_MEMCPY_CHANNEL_TYPE_UB,
    RT_MEMCPY_CHANNEL_TYPE_RESERVED,
} rtMemcpyChannelType_t;

/**
 * @ingroup rt_kernel
 * @brief ai core memory size
 */
typedef struct rtAiCoreMemorySize {
    uint32_t l0ASize;
    uint32_t l0BSize;
    uint32_t l0CSize;
    uint32_t l1Size;
    uint32_t ubSize;
    uint32_t l2Size;
    uint32_t l2PageNum;
    uint32_t blockSize;
    uint64_t bankSize;
    uint64_t bankNum;
    uint64_t burstInOneBlock;
    uint64_t bankGroupNum;
} rtAiCoreMemorySize_t;

/**
 * @ingroup dvrt_mem
 * @brief memory type
 */
typedef enum tagRtMemoryType {
    RT_MEMORY_TYPE_HOST = 1,
    RT_MEMORY_TYPE_DEVICE = 2,
    RT_MEMORY_TYPE_SVM = 3,
    RT_MEMORY_TYPE_DVPP = 4,
    RT_MEMORY_TYPE_USER = 5 // by user malloc, unkown memory
} rtMemoryType_t;

/**
 * @ingroup dvrt_mem
 * @brief ipc type
 */
typedef enum tagRtIpcMemAttrType {
    RT_IPC_ATTR_SIO = 0, 
    RT_IPC_ATTR_HCCS = 1,
    RT_IPC_ATTR_MAX
} rtIpcMemAttrType;

/**
 * @ingroup dvrt_mem
 * @brief memory attribute
 */
typedef struct tagRtPointerAttributes {
    rtMemoryType_t memoryType;  // host memory or device memory
    rtMemLocationType locationType;
    uint32_t deviceID;          // device ID
    uint32_t pageSize;
} rtPointerAttributes_t;

typedef struct {
    const char_t *name;
    const uint64_t size;
    uint32_t flag;
} rtMallocHostSharedMemoryIn;

typedef struct {
    int32_t fd;
    void *ptr;
    void *devPtr;
} rtMallocHostSharedMemoryOut;

typedef struct {
    const char_t *name;
    const uint64_t size;
    int32_t fd;
    void *ptr;
    void *devPtr;
} rtFreeHostSharedMemoryIn;

typedef struct {
    uint64_t total;
    uint64_t free;
    uint64_t hugeTotal;
    uint64_t hugeFree;
    uint64_t giantHugeTotal;
    uint64_t giantHugeFree;
} rtMemPhyInfo_t;

typedef struct {
    uint64_t **addr;
    uint32_t cnt;
    uint32_t memType;   // ex: RT_MEM_MASK_SVM_TYPE
    uint32_t flag;
} rtMemAddrInfo_t;

#define RT_NUMA_NUM_OF_PER_DEV_MAX  (0x40U)
typedef struct {
    uint32_t nodeCnt;
    int32_t nodeId[RT_NUMA_NUM_OF_PER_DEV_MAX];
} rtMemNumaInfo_t;

#define RT_SVM_GRP_NAME_LEN         (0x20U)
typedef struct {
    char name[RT_SVM_GRP_NAME_LEN];
} rtMemSvmGrpInfo_t;

typedef struct {
    uint64_t va;                /* Input para: Virtual address requested by the SVM module*/
    uint64_t size;              /* Input para: Virtual address size*/
    uint32_t tokenId;          /* Output para */
    uint32_t tokenValue;       /* Output para */
} rtMemUbTokenInfo_t;

typedef struct {
    union {
        rtMemPhyInfo_t phyInfo;
        rtMemAddrInfo_t addrInfo;
        rtMemNumaInfo_t numaInfo;
        rtMemSvmGrpInfo_t grpInfo;
        rtMemUbTokenInfo_t ubTokenInfo;
    };
} rtMemInfo_t;

typedef enum tagRtDebugMemoryType {
    RT_MEM_TYPE_L0A = 1,
    RT_MEM_TYPE_L0B = 2,
    RT_MEM_TYPE_L0C = 3,
    RT_MEM_TYPE_UB = 4,
    RT_MEM_TYPE_L1 = 5,
    RT_MEM_TYPE_DCACHE = 10,
    RT_MEM_TYPE_ICACHE = 11,
    RT_MEM_TYPE_REGISTER = 101,
    RT_MEM_TYPE_REGISTER_DIRECT = 102,
    RT_MEM_TYPE_MAX,
} rtDebugMemoryType_t;

typedef enum {
    RT_DEBUG_MEM_TYPE_L0A = 1,
    RT_DEBUG_MEM_TYPE_L0B = 2,
    RT_DEBUG_MEM_TYPE_L0C = 3,
    RT_DEBUG_MEM_TYPE_UB = 4,
    RT_DEBUG_MEM_TYPE_L1 = 5,
    RT_DEBUG_MEM_TYPE_DCACHE = 10,
    RT_DEBUG_MEM_TYPE_ICACHE = 11,
    RT_DEBUG_MEM_TYPE_REGISTER = 101,
    RT_DEBUG_MEM_TYPE_REGISTER_DIRECT = 102,
    RT_DEBUG_MEM_TYPE_MAX,
} rtDebugMemoryType;

typedef struct tagRtDebugMemoryParam {
    uint8_t coreType; // aic/aiv
    uint8_t reserve;
    uint16_t coreId;
    rtDebugMemoryType_t debugMemType;
    uint32_t elementSize;
    uint32_t reserved;
    uint64_t srcAddr;
    uint64_t dstAddr;  // host addr
    uint64_t memLen;
} rtDebugMemoryParam_t;

typedef struct {
    rtCoreType_t coreType; // aic/aiv
    uint8_t reserve;
    uint16_t coreId;
    rtDebugMemoryType debugMemType;
    uint32_t elementSize;
    uint32_t reserved;
    uint64_t srcAddr;
    uint64_t dstAddr;  // host addr
    uint64_t memLen;
} rtDebugMemoryParam;

#define RT_MEM_MODULE_NAME_LEN (32U)
#define RT_MEM_USAGE_INFO_RSV (8U)
typedef struct {
    char name[RT_MEM_MODULE_NAME_LEN]; /* module name */
    uint64_t curMemSize; /* the total amount of memory currently occupied by the module */
    uint64_t memPeakSize; /* the peak size of the total memory occupied by the module */
    size_t reserved[RT_MEM_USAGE_INFO_RSV];
} rtMemUsageInfo_t;

/**
 * @ingroup dvrt_mem
 * @brief alloc device memory
 * @param [in|out] devPtr   memory pointer
 * @param [in] size   memory size
 * @param [in] type   memory type
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief free device memory
 * @param [in|out] devPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtFree(void *devPtr);

/**
 * @ingroup dvrt_mem
 * @brief alloc device memory for dvpp
 * @param [in|out] devPtr   memory pointer
 * @param [in] size   memory size
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDvppMalloc(void **devPtr, uint64_t size, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief alloc device memory for dvpp, support set flag
 * @param [in|out] devPtr   memory pointer
 * @param [in] size   memory size
 * @param [in] flag   mem flag, can use mem attribute set read only.
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return others is error
 */
RTS_API rtError_t rtDvppMallocWithFlag(void **devPtr, uint64_t size, uint32_t flag, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief free device memory for dvpp
 * @param [in|out] devPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDvppFree(void *devPtr);

/**
 * @ingroup dvrt_mem
 * @brief alloc host memory
 * @param [in|out] hostPtr   memory pointer
 * @param [in] size   memory size
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMallocHost(void **hostPtr, uint64_t size, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief free host memory
 * @param [in] hostPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtFreeHost(void *hostPtr);

/**
 * @ingroup dvrt_mem
 * @brief free device memory with device synchronize
 * @param [in] devPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtFreeWithDevSync(void *devPtr);

/**
 * @ingroup dvrt_mem
 * @brief free host memory with device synchronize
 * @param [in] hostPtr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtFreeHostWithDevSync(void *hostPtr);

/**
 * @ingroup dvrt_mem
 * @brief get host memory map capabilities
 * @param [in] deviceId
 * @param [in] hacType
 * @param [out] capabilities
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtHostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities);

/**
 * @ingroup dvrt_mem
 * @brief alloc host shared memory
 * @param [in] in   alloc host shared memory inputPara pointer
 * @param [in] out   alloc host shared memory outputInfo pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */

RTS_API rtError_t rtMallocHostSharedMemory(rtMallocHostSharedMemoryIn *in,
                                           rtMallocHostSharedMemoryOut *out);

/**
 * @ingroup dvrt_mem
 * @brief free host memory
 * @param [in] in   free host shared memory inputPara pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */

RTS_API rtError_t rtFreeHostSharedMemory(rtFreeHostSharedMemoryIn *in);

/**
 * @ingroup dvrt_mem
 * @brief alloc managed memory
 * @param [in|out] ptr   memory pointer
 * @param [in] size   memory size
 * @param [in] flag   reserved, set to 0.
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief free managed memory
 * @param [in] ptr   memory pointer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemFreeManaged(void *ptr);

/**
 * @ingroup dvrt_mem
 * @brief alloc cached device memory
 * @param [in| devPtr   memory pointer
 * @param [in] size     memory size
 * @param [in] type     memory type
 * @param [in] moduleid alloc memory module id
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtMallocCached(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId);

/**
 * @ingroup dvrt_mem
 * @brief flush device mempory
 * @param [in] base   virtal base addr
 * @param [in] len    memory size
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtFlushCache(void *base, size_t len);

/**
 * @ingroup dvrt_mem
 * @brief invalid device mempory
 * @param [in] base   virtal base addr
 * @param [in] len    memory size
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtInvalidCache(void *base, size_t len);

/**
 * @ingroup dvrt_mem
 * @brief synchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind);

/**
 * @ingroup dvrt_mem for mbuff
 * @brief synchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind   memcpy type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyEx(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind);

/**
 * @ingroup dvrt_mem
 * @brief host task memcpy
 * @param [in] dst   destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @param [in] stm   task stream
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtMemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, rtMemcpyKind_t kind, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst   destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind   memcpy type
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind,
                                rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type, not check
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsyncWithoutCheckKind(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
                                                rtMemcpyKind_t kind, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief dsa update memcpy
 * @param [in] streamId dsa streamId
 * @param [in] taskId dsa
 * @param [in] src   source device address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtLaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                        rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @param [in] stm   asynchronized task stream
 * @param [in] memcpyConfig memory copy config  
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsyncEx(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
                                  rtMemcpyKind_t kind, rtStream_t stm, rtMemcpyConfig_t *memcpyConfig);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @param [in] stm   asynchronized task stream
 * @param [in] qosCfg   asynchronized task qosCfg
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
    rtMemcpyKind_t kind, rtStream_t stm, uint32_t qosCfg);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @param [in] stm   asynchronized task stream
 * @param [in] cfgInfo   task config
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
    rtMemcpyKind_t kind, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo);

typedef struct {
    uint32_t resv0;
    uint32_t resv1;
    uint32_t resv2;
    uint32_t len;
    uint64_t src;
    uint64_t dst;
} rtMemcpyAddrInfo;

RTS_API rtError_t rtMemcpyAsyncPtr(void *memcpyAddrInfo, uint64_t destMax, uint64_t count,
                                    rtMemcpyKind_t kind, rtStream_t stream, uint32_t qosCfg);

RTS_API rtError_t rtMemcpyAsyncPtrV2(void *memcpyAddrInfo, uint64_t destMax, uint64_t count,
                                    rtMemcpyKind_t kind, rtStream_t stream, const rtTaskCfgInfo_t *cfgInfo);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy
 * @param [in] dst   destination address pointer
 * @param [in] dstMax length of destination address memory
 * @param [in] dstOffset
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] srcOffset
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpyD2DAddrAsync(void *dst, uint64_t dstMax, uint64_t dstOffset, const void *src,
    uint64_t cnt, uint64_t srcOffset, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized reduce memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src   source address pointer
 * @param [in] cnt   the number of byte to copy
 * @param [in] kind  memcpy type
 * @param [in] type  data type
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtReduceAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                                rtDataType_t type, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized reduce memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src     source address pointer
 * @param [in] count   the number of byte to copy
 * @param [in] kind    memcpy type
 * @param [in] type    data type
 * @param [in] stm     asynchronized task stream
 * @param [in] qosCfg  asynchronized task qosCfg
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtReduceAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, uint32_t qosCfg);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized reduce memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src    source address pointer
 * @param [in] count  the number of byte to copy
 * @param [in] kind   memcpy type
 * @param [in] type   data type
 * @param [in] stm    asynchronized task stream
 * @param [in] cfgInfo   task config
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtReduceAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
    rtRecudeKind_t kind, rtDataType_t type, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized reduce memcpy
 * @param [in] dst     destination address pointer
 * @param [in] destMax length of destination address memory
 * @param [in] src    source address pointer
 * @param [in] cnt  the number of byte to copy
 * @param [in] kind   memcpy type
 * @param [in] type   data type
 * @param [in] stm    asynchronized task stream
 * @param [in] overflowAddr   addr of overflow flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtReduceAsyncV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, void *overflowAddr);

/**
 * @ingroup dvrt_mem
 * @brief synchronized memcpy2D
 * @param [in] dst      destination address pointer
 * @param [in] dstPitch pitch of destination memory
 * @param [in] src      source address pointer
 * @param [in] srcPitch pitch of source memory
 * @param [in] width    width of matrix transfer
 * @param [in] height   height of matrix transfer
 * @param [in] kind     memcpy type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpy2d(void *dst, uint64_t dstPitch, const void *src, uint64_t srcPitch, uint64_t width,
                             uint64_t height, rtMemcpyKind_t kind);

/**
 * @ingroup dvrt_mem
 * @brief asynchronized memcpy2D
 * @param [in] dst      destination address pointer
 * @param [in] dstPitch length of destination address memory
 * @param [in] src      source address pointer
 * @param [in] srcPitch length of destination address memory
 * @param [in] width    width of matrix transfer
 * @param [in] height   height of matrix transfer
 * @param [in] kind     memcpy type
 * @param [in] stm      asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemcpy2dAsync(void *dst, uint64_t dstPitch, const void *src, uint64_t srcPitch, uint64_t width,
                                  uint64_t height, rtMemcpyKind_t kind, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief read mem info while holding the core
 * @param [in] param
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDebugReadAICore(rtDebugMemoryParam_t *const param);

/**
 * @ingroup dvrt_mem
 * @brief Specifies how memory is use
 * @param [in] devPtr   memory pointer
 * @param [in] count    memory count
 * @param [in] advise   reserved, set to 1
 * @return RT_ERROR_NONE for ok
 * @return others for error
 */
RTS_API rtError_t rtMemAdvise(void *devPtr, uint64_t count, uint32_t advise);
/**
 * @ingroup dvrt_mem
 * @brief set memory with uint32_t value
 * @param [in] devPtr
 * @param [in] destMax length of destination address memory
 * @param [in] val
 * @param [in] cnt byte num
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t val, uint64_t cnt);

/**
 * @ingroup dvrt_mem
 * @brief set memory with uint32_t value async
 * @param [in] devPtr
 * @param [in] destMax length of destination address memory
 * @param [in] val
 * @param [in] cnt byte num
 * @param [in] stm
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemsetAsync(void *ptr, uint64_t destMax, uint32_t val, uint64_t cnt, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief get current device memory total and free
 * @param [out] freeSize
 * @param [out] totalSize
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemGetInfo(size_t *freeSize, size_t *totalSize);

/**
 * @ingroup dvrt_mem
 * @brief get the memory information of a specified device.
 * @param [in] devId
 * @param [in] type
 * @param [out] info
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info);

/**
 * @ingroup dvrt_mem
 * @brief get current device memory total and free
 * @param [in] memInfoType
 * @param [out] freeSize
 * @param [out] totalSize
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *freeSize, size_t *totalSize);

/**
 * @ingroup dvrt_mem
 * @brief set memory with uint32_t value
 * @param [in] devPtr
 * @param [in] len
 * @param [in] devId
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemPrefetchToDevice(void *devPtr, uint64_t len, int32_t devId);

/**
 * @ingroup dvrt_mem
 * @brief get memory attribute:Host or Device
 * @param [in] ptr
 * @param [out] attributes
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtPointerGetAttributes(rtPointerAttributes_t *attributes, const void *ptr);

/**
 * @ingroup dvrt_mem
 * @brief make memory shared interprocess and assigned a name
 * @param [in] ptr    device memory address pointer
 * @param [in] name   identification name
 * @param [in] byteCount   identification byteCount
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtIpcSetMemoryName(const void *ptr, uint64_t byteCount, char_t *name, uint32_t len);

/**
 * @ingroup dvrt_mem
 * @brief set the attribute of shared memory
 * @param [in] name   identification name 
 * @param [in] type   shared memory mapping type 
 * @param [in] attr   shared memory attribute
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
*/
RTS_API rtError_t rtIpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr);

/**
 * @ingroup dvrt_mem
 * @brief destroy a interprocess shared memory
 * @param [in] name   identification name
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtIpcDestroyMemoryName(const char_t *name);

/**
 * @ingroup dvrt_mem
 * @brief open a interprocess shared memory
 * @param [in|out] ptr    device memory address pointer
 * @param [in] name   identification name
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtIpcOpenMemory(void **ptr, const char_t *name);

/**
 * @ingroup dvrt_mem
 * @brief close a interprocess shared memory
 * @param [in] ptr    device memory address pointer
 * @param [in] name   identification name
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtIpcCloseMemory(const void *ptr);

/**
 * @ingroup dvrt_mem
 * @brief HCCL Async memory cpy
 * @param [in] sqIndex sq index
 * @param [in] wqeIndex moudle index
 * @param [in] stm asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtRDMASend(uint32_t sqIndex, uint32_t wqeIndex, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief Ipc set mem pid
 * @param [in] name name to be queried
 * @param [in] pid  process id
 * @param [in] num  length of pid[]
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtSetIpcMemPid(const char_t *name, int32_t pid[], int32_t num);

/**
 * @ingroup dvrt_mem
 * @brief HCCL Async memory cpy
 * @param [in] dbindex single device 0
 * @param [in] dbinfo doorbell info
 * @param [in] stm asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtRDMADBSend(uint32_t dbIndex, uint64_t dbInfo, rtStream_t stm);

typedef void* rtDrvMemHandle;
typedef struct DrvMemProp {
    uint32_t side;
    uint32_t devid;
    uint32_t module_id;

    uint32_t pg_type;
    uint32_t mem_type;
    uint64_t reserve;
} rtDrvMemProp_t;

typedef enum MemAccessFlags {
    RT_MEM_ACCESS_FLAGS_NONE = 0x0,
    RT_MEM_ACCESS_FLAGS_READ = 0x1,
    RT_MEM_ACCESS_FLAGS_READWRITE = 0x3,
    RT_MEM_ACCESS_FLAGS_MAX = 0x7FFFFFFF,
} rtMemAccessFlags;

typedef struct MemAccessDesc {
    rtMemAccessFlags flags;
    rtMemLocation location;
    uint8_t rsv[12];
} rtMemAccessDesc;

typedef enum DrvMemHandleType {
    RT_MEM_HANDLE_TYPE_NONE = 0x0,
} rtDrvMemHandleType;

typedef enum rtMemSharedHandleType {
    RT_MEM_SHARE_HANDLE_TYPE_DEFAULT = 0x1,
    RT_MEM_SHARE_HANDLE_TYPE_FABRIC = 0x2,
} rtMemSharedHandleType;

#define RT_MEM_SHARE_HANDLE_LEN 128
typedef struct DrvMemFabricHandle {
    uint8_t share_info[RT_MEM_SHARE_HANDLE_LEN];
} rtDrvMemFabricHandle;

typedef enum DrvMemAttrType {
    RT_ATTR_TYPE_MEM_MAP = 0,
    RT_ATTR_TYPE_MAX,
}rtDrvMemAttrType;

typedef enum DrvMemGranularityOptions {
    RT_MEM_ALLOC_GRANULARITY_MINIMUM = 0x0,
    RT_MEM_ALLOC_GRANULARITY_RECOMMENDED,
    RT_MEM_ALLOC_GRANULARITY_INVALID,
} rtDrvMemGranularityOptions;

typedef struct tagUbDbDetailInfo {
    uint16_t functionId : 7;
    uint16_t dieId : 1;
    uint16_t rsv : 8;
    uint16_t jettyId;
    uint16_t piValue;
} rtUbDbDetailInfo_t;

typedef struct tagUbDbInfo {
    uint8_t dbNum;
    uint8_t wrCqe;
    rtUbDbDetailInfo_t info[4];
} rtUbDbInfo_t;

typedef struct tagUbWqeInfo {
    uint16_t wrCqe : 1;
    uint16_t functionId : 7;
    uint16_t dieId : 1;
    uint16_t wqeSize : 1;
    uint16_t rsv : 6;
    uint16_t jettyId;
    uint8_t *wqe;
    uint16_t wqePtrLen;
} rtUbWqeInfo_t;

typedef enum tagAdviseMemType {
    RT_ADVISE_PERSISTENT = 0,
    RT_ADVISE_DEV_MEM = 1,
    RT_ADVISE_ACCESS_READONLY = 2,
    RT_ADVISE_ACCESS_READWRITE = 3,
    RT_ADVISE_TYPE_MAX
} rtAdviseMemType;

/**
 * @ingroup rt_stars
 * @brief ub doorbell send
 * @param [in] dbSendInfo       dbSendInfo input
 * @param [in] stm              stm: stream handle
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtUbDbSend(rtUbDbInfo_t *dbInfo,  rtStream_t stm);
 
/**
 * @ingroup rt_stars
 * @brief ub direct wqe send
 * @param [in] wqeInfo          wqeInfo input
 * @param [in] stm              stm: stream handle
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtUbDirectSend(rtUbWqeInfo_t *wqeInfo, rtStream_t stm);
/**
 * @ingroup dvrt_mem
 * @brief This command is used to reserve a virtual address range
 * @attention Only support ONLINE scene
 * @param [in] devPtr Resulting pointer to start of virtual address range allocated.
 * @param [in] size Size of the reserved virtual address range requested.
 * @param [in] alignment Alignment of the reserved virtual address range requested,  Currently unused, must be zero.
 * @param [in] devAddr Expected virtual address space start address Currently, Currently unused, must be zero.
 * @param [in] flags currently unused, must be zero.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to free a virtual address range reserved by halMemAddressReserve.
 * @attention Only support ONLINE scene.
 * @param [in] devPtr Starting address of the virtual address range to free.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtReleaseMemAddress(void* devPtr);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to alloc physical memory.
 * @attention Only support ONLINE scene.
 * @param [out] handle Value of handle returned,all operations on this allocation are to be performed using this handle.
 * @param [in] size Size of the allocation requested.
 * @param [in] prop Properties of the allocation to create.
 * @param [in] flags Currently unused, must be zero.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtMallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to free physical memory.
 * @attention Only support ONLINE scene.
 * @param [in] handle Value of handle which was returned previously by halMemCreate.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtFreePhysical(rtDrvMemHandle handle);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to map an allocation handle to a reserved virtual address range.
 * @attention Only support ONLINE scene.
 * @param [in] devPtr Address where memory will be mapped.
 * @param [in] size Size of the memory mapping.
 * @param [in] offset Currently unused, must be zero.
 * @param [in] handle Value of handle which was returned previously by halMemCreate.
 * @param [in] flag Currently unused, must be zero.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtMapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to unmap the backing memory of a given address range.
 * @attention Only support ONLINE scene.
 * @param [in] devPtr Starting address for the virtual address range to unmap.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtUnmapMem(void* devPtr);

/**
* @ingroup dvrt_mem
* @brief This command is used to set access to a reserved virtual address range for the other device.
* @attention
* 1. Only support ONLINE scene.
* 2. Support va->pa:
*    D2H,
*    D2D(sigle device, diffrent device with same host, diffrent device with diffrent host),
*    H2H(same host, diffrent host(support latter))
* 3. rtMemSetAccess: ptr and size must be same with rtMemMap, rtMemGetAccess: ptr and size is in range of set
* 4. after rtMemMap, if handle has owner(witch location pa handle is created or use witch device pa handle is imported)
*    the owner location has readwrite prop automatic, not need to set again
* 5. not support repeat set ptr to same location
* @param [in] virPtr mapped address.
* @param [in] size mapped size.
* @param [in] desc va location and access type, when location is device, id is devid.
* @param [in] count desc num.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
* @return RT_ERROR_DRV_ERR for driver error
*/
RTS_API rtError_t rtMemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count);

/**
* @ingroup dvrt_mem
* @brief This command is used to get access to a reserved virtual address range for the other device.
* @param [in] virPtr mapped address.
* @param [in] location va location, when location is device, id is devid.
* @param [out] flags access type from desc.
* @return RT_ERROR_NONE : success
* @return RT_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags);

/**
* @ingroup dvrt_mem
* @brief This command is used to export an allocation to a shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] handle Handle for the memory allocation.
* @param [in] handleType Currently unused, must be MEM_HANDLE_TYPE_NONE.
* @param [in] flags Currently unused, must be zero.
* @param [out] shareableHandle Export a shareable handle.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle);

/**
* @ingroup dvrt_mem
* @brief This command is used to export an allocation to a shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] handle Handle for the memory allocation.
* @param [in] handleType RT_MEM_SHARE_HANDLE_TYPE_DEFAULT or RT_MEM_SHARE_HANDLE_TYPE_FABRIC.
* @param [in] flags Currently unused, must be zero.
* @param [out] shareableHandle Export a shareable handle.
* @return RT_ERROR_NONE : success
* @return RT_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle);

/**
* @ingroup dvrt_mem
* @brief This command is used to import an allocation from a shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] shareableHandle Import a shareable handle.
* @param [in] devId Device id.
* @param [out] handle Value of handle returned, all operations on this allocation are to be performed using this handle.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle);

/**
* @ingroup dvrt_mem
* @brief This command is used to import an allocation from a shareable handle.
* @attention Only support ONLINE scene. Not support compute group.
* @param [in] shareableHandle Import a shareable handle.
* @param [in] handleType RT_MEM_SHARE_HANDLE_TYPE_DEFAULT or RT_MEM_SHARE_HANDLE_TYPE_FABRIC.
* @param [in] flags Currently unused, must be zero.
* @param [in] devid Device id. Since server-to-server communication requires the capabilities of the devices,
              the device ID is retained in the rtMemImportFromShareableHandleV2 interface.
* @param [out] handle Value of handle returned, all operations on this allocation are to be performed using this handle.
* @return RT_ERROR_NONE : success
* @return RT_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
    uint64_t flags, int32_t devId, rtDrvMemHandle *handle);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to configure the process whitelist which can use shareable handle.
 * @attention Only support ONLINE scene. Not support compute group.
 * @param [in] shareableHandle A shareable handle.
 * @param [in] pid Host pid whitelist array.
 * @param [in] pid_num Number of pid arrays.
 * @return RT_ERROR_NONE : success
 * @return RT_ERROR_XXX : fail
 */
RTS_API rtError_t rtMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum);

/**
 * @ingroup dvrt_mem
 * @brief This command is used to configure the process whitelist which can use shareable handle.
 * @attention Only support ONLINE scene. Not support compute group.
 * @param [in] shareableHandle A shareable handle.
 * @param [in] handleType RT_MEM_SHARE_HANDLE_TYPE_DEFAULT or RT_MEM_SHARE_HANDLE_TYPE_FABRIC.
 * @param [in] pid Host pid whitelist array.
 * @param [in] pid_num Number of pid arrays.
 * @return RT_ERROR_NONE : success
 * @return RT_ERROR_XXX : fail
 */
RTS_API rtError_t rtMemSetPidToShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int pid[], uint32_t pidNum);

/**
* @ingroup dvrt_mem
* @brief This command is used to calculate either the minimal or recommended granularity.
* @attention Only support ONLINE scene.
* @param [in] prop Properties of the allocation.
* @param [in] option Determines which granularity to return.
* @param [out] granularity Returned granularity.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtMemGetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity);

/**
 * @ingroup rts_mem
 * @brief Performs a batch of memory copies synchronous.
 * @param [in] dsts         Array of destination pointers.
 * @param [in] srcs         Array of memcpy source pointers.
 * @param [in] sizes        Array of sizes for memcpy operations.
 * @param [in] count        Size of dsts, srcs and sizes arrays.
 * @param [in] attrs        Array of memcpy attributes.
 * @param [in] attrsIdxs    Array of indices to specify which copies each entry in the attrs array applies to.
 *                          The attributes specified in attrs[k] will be applied to copies starting from attrsIdxs[k]
 *                          through attrsIdxs[k+1] - 1. Also attrs[numAttrs-1] will apply to copies starting from
 *                          attrsIdxs[numAttrs-1] through count - 1.
 * @param [in] numAttrs     Size of attrs and attrsIdxs arrays.
 * @param [out] failIdx     Pointer to a location to return the index of the copy where a failure was encountered.
 *                          The value will be SIZE_MAX if the error doesn't pertain to any specific copy.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_FEATURE_NOT_SUPPORT for not support
 */
RTS_API rtError_t rtsMemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx);

/**
 * @ingroup rts_mem
 * @brief Performs a batch of memory copies synchronous.
 * @param [in] dsts         Array of destination pointers.
 * @param [in] destMaxs     Array of destination address memory lengths.
 * @param [in] srcs         Array of memcpy source pointers.
 * @param [in] sizes        Array of sizes for memcpy operations.
 * @param [in] count        Size of dsts, srcs and sizes arrays.
 * @param [in] attrs        Array of memcpy attributes.
 * @param [in] attrsIdxs    Array of indices to specify which copies each entry in the attrs array applies to.
 *                          The attributes specified in attrs[k] will be applied to copies starting from attrsIdxs[k]
 *                          through attrsIdxs[k+1] - 1. Also attrs[numAttrs-1] will apply to copies starting from
 *                          attrsIdxs[numAttrs-1] through count - 1.
 * @param [in] numAttrs     Size of attrs and attrsIdxs arrays.
 * @param [out] failIdx     Pointer to a location to return the index of the copy where a failure was encountered.
 *                          The value will be SIZE_MAX if the error doesn't pertain to any specific copy.
 * @param [in] stm   asynchronized task stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_FEATURE_NOT_SUPPORT for not support
 */
RTS_API rtError_t rtsMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream);

/**    
* @ingroup rts_mem
* @brief mem write value.
* @param [in] devAddr dev addr.
* @param [in] value write value.
* @param [in] flag reserved para.
* @param [in] stm stream for task launch.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtsValueWrite(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm);

/**
* @ingroup rts_mem
* @brief mem wait value.
* @param [in] devAddr dev addr.
* @param [in] value expect value.
* @param [in] flag wait mode.
* @param [in] stm stream for task launch.
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : fail
*/
RTS_API rtError_t rtsValueWait(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm);

/**
* @ingroup dvrt_mem
* @brief This command is used to return the result to the user via virtual address contrast with physical handle.
* @attention
* @param [in] virPtr the va that has been mapped to device memory.
* @param [out] handle physical addr handle.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
* @return RT_ERROR_DRV_ERR for driver error
*/
RTS_API rtError_t rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle);

/**
* @ingroup dvrt_mem
* @brief This command is used to return memory properties via physical address handle.
* @attention
* @param [in] handle physical addr handle.
* @param [out] prop prop Properties of the allocation.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
* @return RT_ERROR_DRV_ERR for driver error
*/
RTS_API rtError_t rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop);

/**
 * @ingroup dvrt_mem
 * @brief get start address and size of memory block
 * @param  [in] ptr Address whithin a certain memory block range
 * @param  [out] pbase Start address of the memory block
 * @param  [out] psize Size of th memory block
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtMemGetAddressRange(void *ptr, void **pbase, size_t *psize);
#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_MEM_H
