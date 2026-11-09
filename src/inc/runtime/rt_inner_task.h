/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_TASK_H
#define CCE_RUNTIME_RT_INNER_TASK_H

#include "base.h"
#include "mem_base.h"
#include "rt_inner_model.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef struct rtDim3 {
    uint32_t x;
    uint32_t y;
    uint32_t z;
} rtDim3;

typedef enum {
    RT_TASK_DEFAULT,
    RT_TASK_KERNEL,
    RT_TASK_EVENT_RECORD,
    RT_TASK_EVENT_WAIT,
    RT_TASK_EVENT_RESET,
    RT_TASK_VALUE_WRITE,
    RT_TASK_VALUE_WAIT,
    RT_TASK_MEMCPY,
    RT_TASK_MEMCPY_2D,
    RT_TASK_MEMSET,
    RT_TASK_MEMCPY_BATCH,
    RT_TASK_HOST,
    RT_TASK_COND,
    RT_TASK_NOTIFY_RECORD,
    RT_TASK_NOTIFY_WAIT,
    RT_TASK_SIMT_KERNEL,
} rtTaskType;

typedef enum rtKernelArgsType {
    RT_KERNEL_ARGS_UNSET = 0, // argsType not filled: the args/isHostArgs/argsSize fields carry the form
    RT_KERNEL_ARGS_ARRAY = 1,
    RT_KERNEL_ARGS_HOST_BUFFER = 2,
    RT_KERNEL_ARGS_DEVICE_BUFFER = 3,
} rtKernelArgsType;

typedef struct rtKernelTaskParams {
    void* funcHandle;
    rtKernelLaunchCfg_t* cfg;
    void* args;                // legacy args form, read on Set only when argsType is 0; on Get reports the loaded args
    uint32_t isHostArgs;       // legacy args form, 0: device memory, non-0: host memory; always 0 on Get
    size_t argsSize;           // legacy args form, size of args; on Get reports the loaded args size
    uint32_t numBlocks;
    rtKernelArgsType argsType; // RT_KERNEL_ARGS_ARRAY/HOST_BUFFER/DEVICE_BUFFER
    union {
        void** argsArray;      // RT_KERNEL_ARGS_ARRAY
        struct {
            void* hostArgs;
            size_t hostArgsSize;
            rtPlaceHolderInfo_t* placeHolderArray;
            size_t placeHolderNum;
        } hostBuffer; // RT_KERNEL_ARGS_HOST_BUFFER
        struct {
            void* deviceArgs;
            size_t deviceArgsSize;
        } deviceBuffer; // RT_KERNEL_ARGS_DEVICE_BUFFER
    };
    uint32_t rsv[2];
} rtKernelTaskParams;

typedef struct rtSimtKernelTaskParams {
    void* func;
    // flattened scalars mirroring aclmdlRISimtKernelTaskParams, layout matches rtDim3 gridDim + blockDim
    uint32_t gridDimX;
    uint32_t gridDimY;
    uint32_t gridDimZ;
    uint32_t blockDimX;
    uint32_t blockDimY;
    uint32_t blockDimZ;
    size_t dynUbufSize;
    rtKernelLaunchCfg_t* cfg;  // returns nullptr on Get, used on Set only
    rtKernelArgsType argsType; // ARRAY or HOST_BUFFER (see rtKernelArgsType)
    uint8_t rsv0[4];
    union {
        void** argsArray; // RT_KERNEL_ARGS_ARRAY
        struct {
            void* hostArgs;
            size_t hostArgsSize;
            rtPlaceHolderInfo_t* placeHolderArray;
            size_t placeHolderNum;
        } hostBuffer; // RT_KERNEL_ARGS_HOST_BUFFER
    };
} rtSimtKernelTaskParams;

typedef struct rtEventRecordTaskParams {
    rtEvent_t event;
    uint32_t eventFlag;
    uint32_t recordFlag;
} rtEventRecordTaskParams;

typedef struct rtEventWaitTaskParams {
    rtEvent_t event;
    uint32_t eventFlag;
    uint32_t waitFlag;
} rtEventWaitTaskParams;

typedef struct rtEventResetTaskParams {
    rtEvent_t event;
    uint32_t eventFlag;
    uint32_t resetFlag;
} rtEventResetTaskParams;

typedef struct rtValueWriteTaskParams {
    void* devAddr;
    uint64_t value;
} rtValueWriteTaskParams;

typedef struct rtValueWaitTaskParams {
    void* devAddr;
    uint64_t value;
    uint32_t flag;
} rtValueWaitTaskParams;

typedef struct rtMemcpyTaskParams {
    void* dst;
    void* src;
    size_t count;
    rtMemcpyKind kind;
} rtMemcpyTaskParams;

typedef struct rtMemsetTaskParams {
    void* devPtr;
    int32_t value;
    size_t count;
    uint32_t elementSize;
} rtMemsetTaskParams;

typedef struct rtMemcpy2DTaskParams {
    void* dst;
    void* src;
    size_t dpitch;
    size_t spitch;
    size_t width;
    size_t height;
    rtMemcpyKind kind;
} rtMemcpy2DTaskParams;

typedef struct rtMemcpyBatchTaskParams {
    void** dsts;
    size_t* destMaxs;
    void** srcs;
    size_t* sizes;
    size_t numBatches;
    rtMemcpyBatchAttr* attrs;
    size_t* attrsIndexes;
    size_t numAttrs;
} rtMemcpyBatchTaskParams;

typedef struct rtHostTaskParams {
    rtCallback_t fn;
    void* userData;
} rtHostTaskParams;

typedef struct rtNotifyRecordTaskParams {
    rtNotify_t notify;
} rtNotifyRecordTaskParams;

typedef struct rtNotifyWaitTaskParams {
    rtNotify_t notify;
    uint32_t timeout;
} rtNotifyWaitTaskParams;

typedef struct rtTaskParams {
    rtTaskType type;
    uint32_t rsv0[3];
    rtTaskGrp_t taskGrp;
    void* opInfoPtr;
    size_t opInfoSize;
    uint8_t rsv1[32];

    union {
        uint8_t rsv2[128];
        struct rtKernelTaskParams kernelTaskParams;
        struct rtSimtKernelTaskParams simtKernelTaskParams;
        struct rtEventRecordTaskParams eventRecordTaskParams;
        struct rtEventWaitTaskParams eventWaitTaskParams;
        struct rtEventResetTaskParams eventResetTaskParams;
        struct rtValueWriteTaskParams valueWriteTaskParams;
        struct rtValueWaitTaskParams valueWaitTaskParams;
        struct rtMemcpyTaskParams memcpyTaskParams;
        struct rtMemcpy2DTaskParams memcpy2DTaskParams;
        struct rtMemsetTaskParams memsetTaskParams;
        struct rtMemcpyBatchTaskParams memcpyBatchTaskParams;
        struct rtHostTaskParams hostTaskParams;
        struct rtCondTaskParams condTaskParams;
        struct rtNotifyRecordTaskParams notifyRecordTaskParams;
        struct rtNotifyWaitTaskParams notifyWaitTaskParams;
    };
} rtTaskParams;

/**
 * @ingroup rt_task
 * @brief get the type of the task
 * @param [in] task: task handle
 * @param [out] type: variable to store the task type
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtTaskGetType(rtTask_t task, rtTaskType* type);

/**
 * @ingroup rt_task
 * @brief get sequence id of the task
 * @param [in] task: task handle
 * @param [out] id: sequence id of the task
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtTaskGetSeqId(rtTask_t task, uint32_t* id);

/**
 * @ingroup rt_task
 * @brief Get task parameters
 * @details Retrieve current parameter information from the specified task
 * @note  This API only supports AclGraph
 * @param task [in] task handle
 * @param params [out] Output parameter to store the retrieved parameter information
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelTaskGetParams(rtTask_t task, rtTaskParams* params);

/**
 * @ingroup rt_task
 * @brief Set task parameters
 * @details Update parameter information for the specified task
 * @note  This API only supports AclGraph
 * @param task [in] task handle
 * @param params [in] Input parameter containing parameter information to be set
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t rtModelTaskSetParams(rtTask_t task, rtTaskParams* params);

/**
 * @ingroup rt_task
 * @brief Get kernel task launch config info
 * @details Get the launch config info for the specified kernel task
 * @note  This API only supports AclGraph
 * @param task [in] task handle
 * @param attrId [in] the id for config info
 * @param attrValue [out] Output config value corresponding to the attrId
 * @retval RT_ERROR_NONE for ok
 * @retval OtherValues Failure
 */
RTS_API rtError_t
rtModelKernelTaskGetAttribute(rtTask_t task, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t* attrValue);

/**
 * @ingroup rt_task
 * @brief Set the task to disabled
 * @param [in, out] task: task handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtModelTaskDisable(rtTask_t task);

/**
 * @ingroup rt_task
 * @brief cache extended info for the last task, specifically for debugging
 * @param [in] extendInfoPtr: pointer to the extended task information buffer
 * @param [in] infoSize: size of the buffer
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize);

/**
 * @ingroup rts_kernel
 * @brief launch kernel with args array.
 * @param [in] func  kernel handle
 * @param [in] numBlocks  block count
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] args  args array pointer
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t
rtLaunchKernelWithArgsArray(void* func, uint32_t numBlocks, rtStream_t stm, rtKernelLaunchCfg_t* cfg, void** args);

/**
 * @ingroup rts_kernel
 * @brief launch SIMT kernel with args array.
 * @param [in] func  kernel handle
 * @param [in] gridDim  grid dimensions
 * @param [in] blockDim  block dimensions
 * @param [in] dynUbufSize  dynamic ubuf size
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] args  args array pointer
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtLaunchSIMTKernelWithArgsArray(
    void* func, rtDim3 gridDim, rtDim3 blockDim, size_t dynUbufSize, rtStream_t stm, rtKernelLaunchCfg_t* cfg,
    void** args);

/**
 * @ingroup rts_kernel
 * @brief launch SIMT kernel with host args.
 * @param [in] func  kernel handle
 * @param [in] gridDim  grid dimensions
 * @param [in] blockDim  block dimensions
 * @param [in] dynUbufSize  dynamic ubuf size
 * @param [in] stm  associated stream
 * @param [in] cfg task t-v config
 * @param [in] hostArgs  host args data pointer
 * @param [in] argsSize  size of host args
 * @param [in] placeHolderArray  place holder info array
 * @param [in] placeHolderNum  number of place holders
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtLaunchSIMTKernelWithHostArgs(
    void* func, rtDim3 gridDim, rtDim3 blockDim, size_t dynUbufSize, rtStream_t stm, rtKernelLaunchCfg_t* cfg,
    void* hostArgs, uint32_t argsSize, rtPlaceHolderInfo_t* placeHolderArray, uint32_t placeHolderNum);

#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_RT_INNER_TASK_H