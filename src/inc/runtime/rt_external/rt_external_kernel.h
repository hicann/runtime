/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_EXTERNAL_KERNEL_H
#define CCE_RUNTIME_RT_EXTERNAL_KERNEL_H

#include "rt_external_base.h"
#include "rt_external_preload.h"
#include "rt_external_stars_define.h"

#if defined(__cplusplus)
extern "C" {
#endif

RTS_API rtError_t  rtGetNotifyAddress(rtNotify_t notify, uint64_t * const notifyAddres);

/**
* @ingroup rt_kernel
* @brief set input argments size for exception
* @param [in] sizeInfo argments size info
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtSetExceptionExtInfo(const rtArgsSizeInfo_t * const sizeInfo);

/**
 * @ingroup rt_kernel
 * @brief start fusion kernels.
 * @param [in] stm   stream for fusion kernels
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtKernelFusionStart(rtStream_t stm);

/**
 * @ingroup rt_kernel
 * @brief end fusion kernels.
 * @param [in] stm   stream for fusion kernels
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtKernelFusionEnd(rtStream_t stm);

/**
 * @ingroup rt_kernel
 * @brief register device binary metadata
 * @param [in] hdl    device binary description
 * @param [in] metadata  device binary metadata
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMetadataRegister(void *hdl, const char_t *metadata);

/**
 * @ingroup rt_kernel
 * @brief magic number of elf binary for aicore
 */
#define RT_DEV_BINARY_MAGIC_ELF 0x43554245U

/**
 * @ingroup rt_kernel
 * @brief magic number of elf binary for aicpu
 */
#define RT_DEV_BINARY_MAGIC_ELF_AICPU 0x41415243U

/**
 * @ingroup rt_kernel
 * @brief magic number of elf binary for aivector
 */
#define RT_DEV_BINARY_MAGIC_ELF_AIVEC 0x41415246U

/**
 * @ingroup rt_kernel
 * @brief magic number of elf binary for aicube
 */
#define RT_DEV_BINARY_MAGIC_ELF_AICUBE 0x41494343U
/**
 * @ingroup rt_kernel_flags
 * @brief kernel op bit flags
 */
#define RT_KERNEL_DEFAULT (0x00U)
#define RT_KERNEL_CONVERT (0x01U)
#define RT_KERNEL_DUMPFLAG (0x02U)
#define RT_FUSION_KERNEL_DUMPFLAG (0x04U)
#define RT_KERNEL_CUSTOM_AICPU (0x08U)
#define RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG (0x10U)
#define RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG  (0x20U)
// cmdlist does not need to be released by the runtime.
#define RT_KERNEL_CMDLIST_NOT_FREE                (0x40U)
#define RT_KERNEL_USE_SPECIAL_TIMEOUT             (0x100U)

/**
 * @ingroup rt_kernel
 * @brief host memory input struct
 */
typedef struct rtHostInputInfo {
    uint32_t addrOffset;
    uint32_t dataOffset;
} rtHostInputInfo_t;

/**
 * @ingroup rt_kernel
 * @brief args struct
 */
typedef struct tagRtArgsEx {
    void *args;                     // args host mem addr
    rtHostInputInfo_t *hostInputInfoPtr;     // nullptr means no host mem input
    uint32_t argsSize;              // input + output + tiling addr size + tiling data size + host mem
    uint32_t tilingAddrOffset;      // tiling addr offset
    uint32_t tilingDataOffset;      // tiling data offset
    uint16_t hostInputInfoNum;      // hostInputInfo num
    uint8_t hasTiling;              // if has tiling: 0 means no tiling
    uint8_t isNoNeedH2DCopy;        // is no need host to device copy: 0 means need H2D copy,
                                    // others means doesn't need H2D copy.
    uint8_t reserved[4];
} rtArgsEx_t;

typedef struct tagRtAicpuArgsEx {
    void *args; // args host mem addr
    rtHostInputInfo_t *hostInputInfoPtr; // nullptr means no host mem input
    rtHostInputInfo_t *kernelOffsetInfoPtr; // KernelOffsetInfo, it is different for CCE Kernel and fwk kernel
    uint32_t argsSize;
    uint16_t hostInputInfoNum; // hostInputInfo num
    uint16_t kernelOffsetInfoNum; // KernelOffsetInfo num
    uint32_t soNameAddrOffset; // just for CCE Kernel, default value is 0xffff for FWK kernel
    uint32_t kernelNameAddrOffset; // just for CCE Kernel, default value is 0xffff for FWK kernel
    bool isNoNeedH2DCopy; // is no need host to device copy: 0 means need H2D copy,
                               // other means doesn't need H2D copy.
    uint16_t timeout;  // timeout for aicpu exit
    uint8_t reserved;
} rtAicpuArgsEx_t;

/**
 * @ingroup rt_kernel
 * @brief shared memory data control
 */
typedef struct tagRtSmData {
    uint64_t L2_mirror_addr;          // preload or swap source addr
    uint32_t L2_data_section_size;    // every data size
    uint8_t L2_preload;               // 1 - preload from mirrorAddr, 0 - no preload
    uint8_t modified;                 // 1 - data will be modified by kernel, 0 - no modified
    uint8_t priority;                 // data priority
    int8_t prev_L2_page_offset_base;  // remap source section offset
    uint8_t L2_page_offset_base;      // remap destination section offset
    uint8_t L2_load_to_ddr;           // 1 - need load out, 0 - no need
    uint8_t reserved[2];              // reserved
} rtSmData_t;

/**
 * @ingroup rt_kernel
 * @brief shared memory description
 */
typedef struct tagRtSmCtrl {
    rtSmData_t data[8];  // data description
    uint64_t size;       // max page Num
    uint8_t remap[64];   /* just using for static remap mode, default:0xFF
                          array index: virtual l2 page id, array value: physic l2 page id */
    uint8_t l2_in_main;  // 0-DDR, 1-L2, default:0xFF
    uint8_t reserved[3];
} rtSmDesc_t;

/**
 * @ingroup rtAicpuKernelLaunchExWithArgs
 * @brief launch cpu kernel to device with dump identifier and kernelType
 * @param [in] kernelType    aicpu kernel type
 * @param [in] opName        address of op name
 * @param [in] blockDim      block dimensions
 * @param [in] argsInfo      argments address for kernel function
 * @param [in] smDesc        shared memory description
 * @param [in] stm           associated stream
 * @param [in] flags         dump flag or others function flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtAicpuKernelLaunchExWithArgs(const uint32_t kernelType, const char_t * const opName,
                                                const uint32_t blockDim, const rtAicpuArgsEx_t *argsInfo,
                                                rtSmDesc_t * const smDesc, const rtStream_t stm,
                                                const uint32_t flags);

/**
 * @ingroup dvrt_mem
 * @brief HCCL copy ffts args
 * @param [in] stm task stream
 * @param [in] argsInfo args info
 * @param [out] devArgsAddr device mem addr for args
 * @param [out] argsHandle copy handler
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtGetDevArgsAddr(rtStream_t stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle);

/**
 * @ingroup rt_kernel
 * @brief Get Stack Buffer
 * @param [in] binHandle    bin handle
 * @param [in] coreType     core type
 * @param [in] coreId       core id
 * @param [out] stack       stack buffer
 * @param [out] stackSize   stack size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                                   const void **stack, uint32_t *stackSize);

/**
 * @ingroup rt_kernel
 * @brief L1 fusion dump addr transfered to device
 * @param [in] mdl    handle info
 * @param [in] addr     ddr address of L1 Fusion Dump
 * @param [in] dumpSize memory size
 * @param [in] flag     memory flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDumpAddrSet(rtModel_t mdl, void *addr, uint32_t dumpSize, uint32_t flag);

/**
 * @ingroup rt_kernel
 * @brief load dump info to aicpu
 * @param [in] dumpInfo   dump info
 * @param [in] length   length of dump info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDatadumpInfoLoad(const void *dumpInfo, uint32_t length);

/**
 * @ingroup rt_kernel
 * @brief load aicpu info
 * @param [in] aicpuInfo   aicpu info
 * @param [in] length   length of aicpu info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtAicpuInfoLoad(const void *aicpuInfo, uint32_t length);

#define RT_CCU_INST_CNT_INVALID (0U)
#define RT_CCU_INST_START_MAX   (32768U)
typedef struct tagRtCcuTaskInfo {
    uint8_t dieId;
    uint8_t missionId;
    uint16_t timeout;
    uint16_t instStartId;
    uint16_t instCnt;
    uint32_t key;
    uint32_t argSize;    // 1 or 13. 1 means 32B ccu sqe; 13 means 128B ccu sqe
    uint64_t args[RT_CCU_SQE_ARGS_LEN];
} rtCcuTaskInfo_t;

/**
 * @ingroup rt_kernel
 * @brief CCU Kernel Launch to device
 * @param [in] taskInfo  task information of CCU
 * @param [in] stm  associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtCCULaunch(rtCcuTaskInfo_t *taskInfo,  rtStream_t const stm);

/**
 * @ingroup rtCpuKernelLaunchWithFlag(abandoned)
 * @brief launch cpu kernel to device  with dump identifier
 * @param [in] soName        so name
 * @param [in] kernelName    kernel name
 * @param [in] blockDim      block dimensions
 * @param [in] argsInfo      argments address for kernel function
 * @param [in] smDesc        shared memory description
 * @param [in] stm           associated stream
 * @param [in] flag          dump flag or others function flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t blockDim,
                                            const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm,
                                            uint32_t flags);

/**
 * @ingroup rts_kernel
 * @brief engine type [AICORE, AIVECTOR]
 */
typedef enum {
    RT_ENGINE_TYPE_AIC = 0,
    RT_ENGINE_TYPE_AIV
} rtEngineType;

/**
 * @ingroup rts_kernel
 * @brief kernel launch option config type
 */
typedef enum {
    RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE = 1,
    RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE,
    // vector core使能使用
    RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE,
    // vector core使能使用
    RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET,
    RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH,
    RT_LAUNCH_KERNEL_ATTR_DATA_DUMP,
    RT_LAUNCH_KERNEL_ATTR_TIMEOUT,
    RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US,
    RT_LAUNCH_KERNEL_ATTR_MAX
} rtLaunchKernelAttrId;

/**
 * @ingroup rts_kernel
 * @brief kernel launch option config value
 */
typedef union {
    uint8_t schemMode;
    uint32_t localMemorySize;
    rtEngineType engineType;
    uint32_t blockDimOffset;
    uint8_t isBlockTaskPrefetch;  // 任务下发时判断是否sqe后续需要刷新标记（tiling key依赖下沉场景）0:disable 1:enable
    uint8_t isDataDump; // 0:disable 1:enable
    uint16_t timeout;
    uint64_t timeoutUs; // uint:us
    uint32_t rsv[4];
} rtLaunchKernelAttrVal_t;

/**
 * @ingroup rts_kernel
 * @brief kernel launch option config struct
 */
typedef struct {
    rtLaunchKernelAttrId id;
    rtLaunchKernelAttrVal_t value;
} rtLaunchKernelAttr_t;

/**
 * @ingroup rts_kernel
 * @brief kernel launch option config info
 */
typedef struct {
    rtLaunchKernelAttr_t *attrs;
    size_t numAttrs;
} rtKernelLaunchCfg_t;

/**
 * @ingroup rts_kernel
 * @brief rts Launch Kernel
 * @param [in] funcHandle  function Handle
 * @param [in] blockDim  block dimensions
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] argsHandle  args Handle
 * @param [in] reserve  reserve param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                            rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle, void *reserve);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RT_EXTERNAL_KERNEL_H