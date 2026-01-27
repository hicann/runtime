/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_KERNEL_H
#define CCE_RUNTIME_RTS_KERNEL_H

#include <stdlib.h>

#include "kernel.h"
#include "rt_preload_task.h"

#if defined(__cplusplus)
extern "C" {
#endif

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
 * @brief kernel launch option timeout value
 */
typedef struct {
    uint32_t timeoutLow;  // low  32bit
    uint32_t timeoutHigh; // high 32bit
} rtTimeoutUs;

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
    uint16_t timeout;       // uint:s
    rtTimeoutUs timeoutUs;  // uint:us
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

typedef enum {
    RT_LOAD_BINARY_OPT_LAZY_LOAD = 1,
    RT_LOAD_BINARY_OPT_MAGIC = 2,
    RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE = 3,
    RT_LOAD_BINARY_OPT_MAX
} rtLoadBinaryOption;

typedef union {
    uint32_t isLazyLoad;
    uint32_t magic;
    int32_t cpuKernelMode; // 0 ：仅需要加载json，1 ：加载cpu so & json，2: LoadFromData
    uint32_t rsv[4];
} rtLoadBinaryOptionValue_t;

typedef struct {
    rtLoadBinaryOption optionId;
    rtLoadBinaryOptionValue_t value;
} rtLoadBinaryOption_t;

typedef struct {
    rtLoadBinaryOption_t *options;
    size_t numOpt;
} rtLoadBinaryConfig_t;

/**
 * @ingroup rts_kernel
 * @brief kernel launch args placeHolder info
 */
typedef struct {
    uint32_t addrOffset;
    uint32_t dataOffset;
} rtPlaceHolderInfo_t;

/**
 * @ingroup rts_kernel
 * @brief Load kernel binary from file with given path. Runtime will parse function symbol from given bin, then register
 * kernel to kernel table which is managed in runtime. If enable optional config RT_LOAD_BINARY_OPT_LAZY_LOAD,
 * runtime will not copy kernel to devices, otherwise will.
 * @param binPath kernel binary path
 * @param optionalCfg  optional cfg, can be nullptr.
 * @param handle output param: the load result.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsBinaryLoadFromFile(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                        rtBinHandle *handle);

/**
 * @ingroup rts_kernel
 * @brief Load kernel binary from given bin data buffer. Runtime will parse function symbol from given buffer,
 * then register kernel to kernel table which is managed in runtime.
 * If enable optional config RT_LOAD_BINARY_OPT_LAZY_LOAD, runtime will not copy kernel to devices, otherwise will.
 * @param data kernel binary data ptr.
 * @param length kernel binary data length.
 * @param optionalCfg optional cfg, can be nullptr.
 * @param handle output param: the load result.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsBinaryLoadFromData(const void * const data, const uint64_t length,
                                        const rtLoadBinaryConfig_t * const optionalCfg, rtBinHandle *handle);

/**
 * @ingroup rts_kernel
 * @brief Unload kernel binary. Will unregister all kernels the binary contains. Make sure no stream using these
 * kernels.
 * @param binHandle the binary to be unload.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsBinaryUnload(const rtBinHandle binHandle);

/**
 * @ingroup rts_kernel
 * @brief Get function handle with the kernel name.
 * @param binHandle binary handle to search from.
 * @param kernelName kernel name to be searched.
 * @param funcHandle output param: if find, this will be the function handle.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsFuncGetByName(const rtBinHandle binHandle, const char_t *kernelName, rtFuncHandle *funcHandle);

/**
 * @ingroup rts_kernel
 * @brief Get function handle with the function entry.
 * @param binHandle binary handle to search from.
 * @param funcEntry function entry, the suffix number. E.g., kernel_foo_123, `123` is the function entry.
 * @param funcHandle output param: if find, this will be the function handle.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsFuncGetByEntry(const rtBinHandle binHandle, const uint64_t funcEntry, rtFuncHandle *funcHandle);

/**
 * @ingroup rts_kernel
 * @brief get kernel pc start address in device, if kernel is mix, the output param aicAddr and aivAddr are both valid,
 * otherwise, there will be only one valid address.
 * @param funcHandle the kernel
 * @param aicAddr output param: kernel pc start address of aicore
 * @param aivAddr output param: kernel pc start address of aivector
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsFuncGetAddr(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr);

/**
 * @ingroup rts_kernel
 * @brief register cpu func by funcName and opType, funcHandle will get
 * @param binHandle binary handle to register func.
 * @param funcName cpu kernel func name.
 * @param opType cpu kernel op type.
 * @param funcHandle output param: func Handle.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsRegisterCpuFunc(
    rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle);

/**
 * @ingroup rts_kernel
 * @brief rts Launch Kernel
 * @param [in] funcHandle  function Handle
 * @param [in] numBlocks  block dimensions
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] hostArgs  host args ptr
 * @param [in] argsSize  args total size
 * @param [in] placeHolderArray  place holder info array
 * @param [in] placeHolderNum  place holder num
 * @return RT_ERROR_NONE for ok
 */
rtError_t rtsLaunchKernelWithHostArgs(rtFuncHandle funcHandle, uint32_t numBlocks, rtStream_t stm, rtKernelLaunchCfg_t *cfg,
    void *hostArgs, uint32_t argsSize, rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum);

/**
 * @ingroup rts_kernel
 * @brief rts Launch Kernel
 * @param [in] funcHandle  function Handle
 * @param [in] numBlocks  block dimensions
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] argsInfo  args info
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsLaunchCpuKernel(const rtFuncHandle funcHandle, uint32_t numBlocks, rtStream_t stm,
    const rtKernelLaunchCfg_t *cfg, rtCpuKernelArgs_t *argsInfo);

/**
 * @ingroup rts_kernel
 * @brief get thread last task id
 * @param [out] taskId  thread task id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetThreadLastTaskId(uint32_t *taskId);

/**
 * @ingroup rts_kernel
 * @brief launch npu clear float status task
 * @param [in] checkMode   check mode
 * @param [in] stm   associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNpuClearFloatOverFlowStatus(uint32_t checkMode, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief launch npu get float status task
 * @param [in] outputAddrPtr  pointer to op output addr
 * @param [in] outputSize   op output size
 * @param [in] checkMode   check mode
 * @param [in] stm   associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNpuGetFloatOverFlowStatus(void *outputAddrPtr, uint64_t outputSize, uint32_t checkMode,
                                               rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief launch npu get float status task
 * @param [in] outputAddrPtr  pointer to op output addr
 * @param [in] outputSize   op output size
 * @param [in] checkMode   check mode
 * @param [in] stm   associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNpuGetFloatOverFlowDebugStatus(void *outputAddrPtr, uint64_t outputSize, uint32_t checkMode,
                                                    rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief launch npu clear float status task
 * @param [in] checkMode   check mode
 * @param [in] stm   associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNpuClearFloatOverFlowDebugStatus(uint32_t checkMode, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief add callback launch task in stream.
 * @param [in] callBackFunc    app callback function
 * @param [in] fnData          user data
 * @param [in] stm             subscribed stream
 * @param [in] isBlock         specifies whether the callback function invocation blocks the device,
 *                             0: non-blocking; 1: blocking
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stm, bool isBlock);

/**
 * @ingroup rts_kernel
 * @brief subscribe stream callback report.
 * @param [in] threadId   thread id for stream
 * @param [in] stm   stream for subscribe
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSubscribeReport(uint64_t threadId, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief process callback report.
 * @param [in] timeout   if timeout=-1, while(1); else timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsProcessReport(int32_t timeout);

/**
 * @ingroup rts_kernel
 * @brief unsubscribe callback report.
 * @param [in] threadId   thread id for stream
 * @param [in] stm   stream for subscribe
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsUnSubscribeReport(uint64_t threadId, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief rts Launch Kernel
 * @param [in] funcHandle  function Handle
 * @param [in] numBlocks  block dimensions
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] argsHandle  args Handle
 * @param [in] reserve  reserve param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t numBlocks, rtStream_t stm,
                                            rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle, void *reserve);

/**
 * @ingroup rts_kernel
 * @brief kernel args init.
 * @param [in] funcHandle   kernel handle
 * @param [out] argsHandle   args handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsInit(rtFuncHandle funcHandle, rtArgsHandle *argsHandle);

/**
 * @ingroup rts_kernel
 * @brief kernel args append.
 * @param [in] argsHandle   args handle
 * @param [in] para   user para addr
 * @param [in] paraSize   user para size
 * @param [out] paraHandle   para handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsAppend(rtArgsHandle argsHandle, void *para, size_t paraSize, rtParaHandle *paraHandle);

/**
 * @ingroup rts_kernel
 * @brief kernel args append place holder.
 * @param [in] argsHandle   args handle
 * @param [out] paraHandle   para handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsAppendPlaceHolder(rtArgsHandle argsHandle, rtParaHandle *paraHandle);

/**
 * @ingroup rts_kernel
 * @brief kernel args finalize
 * @param [in] argsHandle   args handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsFinalize(rtArgsHandle argsHandle);

/**
 * @ingroup rts_kernel
 * @brief kernel args append place holder.
 * @param [in] argsHandle   args handle
 * @param [in] paraHandle   para handle
 * @param [in] para   para ptr
 * @param [in] paraSize   para size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsParaUpdate(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para,
                                          size_t paraSize);

/**
 * @ingroup rts_kernel
 * @brief init kernel args by user memory
 * @param [in] funcHandle   kernel handle
 * @param [out] argsHandle   args handle
 * @param [in] userHostMem   user host memory
 * @param [in] actualArgsSize   actual args size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsInitByUserMem(rtFuncHandle funcHandle, rtArgsHandle argsHandle, void *userHostMem,
                                             size_t actualArgsSize);

/**
 * @ingroup rts_kernel
 * @brief get kernel args memory size
 * @param [in] funcHandle   kernel handle
 * @param [in] userArgsSize   user args size
 * @param [out] actualArgsSize   actual args size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsGetMemSize(rtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize);

/**
 * @ingroup rts_kernel
 * @brief get kernel args handle memory size
 * @param [in] funcHandle   kernel handle
 * @param [out] memSize   memory size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsGetHandleMemSize(rtFuncHandle funcHandle, size_t *memSize);

/**
 * @ingroup rts_kernel
 * @brief get kernel args buffer of placeholder
 * @param [in] argsHandle   args handle
 * @param [in] dataSize   data size of placeholder pointing
 * @param [out] bufferAddr   real buffer addr of placeholder pointing
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsKernelArgsGetPlaceHolderBuffer(rtArgsHandle argsHandle, rtParaHandle paraHandle, size_t dataSize,
                                                    void **bufferAddr);

/**
 * @ingroup rts_kernel
 * @brief register kernel callback function
 * @param [in] symbol   the symbol that matches the kernel callback function
 * @param [in] callback kernel callback function
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsRegKernelLaunchFillFunc(const char_t *symbol, rtKernelLaunchFillFunc callback);

/**
 * @ingroup rts_kernel
 * @brief unregister kernel callback function by symbol
 * @param [in] symbol   the symbol that matches the kernel callback function
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsUnRegKernelLaunchFillFunc(const char_t *symbol);

/**
 * @ingroup rts_kernel
 * @brief get l2cache offset
 * @param [in] deviceId   device id
 * @param [out]  offset l2cache offset
 * @return  0 for success, others for fail
 */
RTS_API rtError_t rtsGetNonCacheAddrOffset(uint32_t deviceId, uint64_t *offset);


/**
 * @ingroup rts_kernel
 * @brief get kernel name
 * @param [in] funcHandle  function Handle
 * @param [in] maxLen max length of kernel name
 * @param [out] name kernel name
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsFuncGetName(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name);

/**
 * @ingroup rt_kernel
 * @brief Kernel Launch to device
 * @param [in] funcHandle  function Handle
 * @param [in] config task config info
 * @param [in] argsHandle  args Handle
 * @param [in] stm  associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtLaunchKernelExByFuncHandle(rtFuncHandle funcHandle, rtLaunchConfig_t* launchConfig,
    rtLaunchArgsHandle argsHandle, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief get hardware sync Addr for Mix kernel.
 * @param [out] addr   hardware sync addr
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetHardwareSyncAddr(void **addr);

/**
 * @ingroup rts_kernel
 * @brief get Saturation Status task
 * @param [in] outputAddrPtr  pointer to op output addr
 * @param [in] outputSize   op output size
 * @param [in] stm  associated stream
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsGetFloatOverflowStatus(void *const outputAddrPtr, const uint64_t outputSize, rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief clear Saturation Status task
 * @param [in] stm  associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsResetFloatOverflowStatus(rtStream_t stm);

/**
 * @ingroup rts_kernel
 * @brief rts Launch Kernel
 * @param [in] funcHandle  function Handle
 * @param [in] numBlocks  block dimensions
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] args  argment address for kernel function
 * @param [in] argsSize  argment size
 * @param [in] reserve  reserve param
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsLaunchKernelWithDevArgs(rtFuncHandle funcHandle, uint32_t numBlocks, rtStream_t stm,
                                             rtKernelLaunchCfg_t *cfg, const void *args, uint32_t argsSize,
                                             void *reserve);

/**
 * @ingroup rts_kernel
 * @brief add callback launch task in stream.
 * @param [in] stm  associated stream
 * @param [in] callBackFunc    app callback function
 * @param [in] fnData          user data
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsLaunchHostFunc(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData);

/**
 * @ingroup rt_kernel
 * @brief Get Bin dev address
 * @param [in] binHandle    bin handle
 * @param [out] bin         bin addr
 * @param [out] binSize     bin size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsBinaryGetDevAddress(const rtBinHandle binHandle, void **bin, uint32_t *binSize);


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
RTS_API rtError_t rtsGetStackBuffer(const rtBinHandle binHandle, const rtCoreType_t coreType, const uint16_t coreId,
                                   const void **stack, uint32_t *stackSize);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_KERNEL_H