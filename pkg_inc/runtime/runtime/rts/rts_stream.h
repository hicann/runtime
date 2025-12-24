/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_STREAM_H
#define CCE_RUNTIME_RTS_STREAM_H

#include <stdlib.h>

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_STREAM_DESTORY_FLAG_DEFAULT 0x0ULL
#define RT_STREAM_DESTORY_FLAG_FORCE 0x1ULL  //Force destory: The stream will be destroyed without waiting for all tasks on the stream to be completed.

// Stream Mode 
#define RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE  (0x0U)  // 默认值，task出错时，处理完异常后继续执行流上的任务 
#define RT_STREAM_FAILURE_MODE_STOP_ON_FAILURE      (0x1U)  // 遇错即停

typedef enum { 
    RT_STREAM_ATTR_FAILURE_MODE = 1, 
    RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK = 2, 
    RT_STREAM_ATTR_USER_CUSTOM_TAG = 3,
    RT_STREAM_ATTR_CACHE_OP_INFO = 4,
    RT_STREAM_ATTR_MAX = 5,
} rtStreamAttr; 

typedef union {
    uint64_t failureMode;
    uint32_t overflowSwitch;
    uint32_t userCustomTag;
    uint32_t cacheOpInfoSwitch;
    uint32_t rsv[4];
} rtStreamAttrValue_t;

typedef enum { 
    RT_STREAM_CREATE_ATTR_FLAGS = 1,        // Stream创建flags 
    RT_STREAM_CREATE_ATTR_PRIORITY = 2,     // Stream优先级 
    RT_STREAM_CREATE_ATTR_MAX = 3
} rtStreamCreateAttrId;

typedef union { 
    uint32_t flags; 
    uint32_t priority;
    uint32_t rsv[4];
} rtStreamCreateAttrValue_t; 

typedef struct { 
    rtStreamCreateAttrId id;    //  属性id 
    rtStreamCreateAttrValue_t value; // 属性值 
} rtStreamCreateAttr_t; 

typedef struct { 
    rtStreamCreateAttr_t *attrs; // attrs配置的值 
    size_t numAttrs;  // attrs数量 
} rtStreamCreateConfig_t;

/**
 * @ingroup dvrt_stream
 * @brief create stream instance
 * @param [in|out] stm   created stream
 * @param [in] config   stream flags and priority
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsStreamCreate(rtStream_t *stream, rtStreamCreateConfig_t *config);

/**
 * @ingroup dvrt_stream
 * @brief set stream attribute
 * @param [in] stm   stream handle
 * @param [in] stmAttrId   stream attribute id
 * @param [in] attrValue  stream attribute value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsStreamSetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue); 

/**
 * @ingroup dvrt_stream
 * @brief get stream attribute
 * @param [in] stm   stream handle
 * @param [in] stmAttrId    stream attribute id
 * @param [out] attrValue   stream attribute value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsStreamGetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue);

/**
 * @ingroup rts_stream
 * @brief destory a stream
 * @param [in] stm   stream handle
 * @param [in] flags   destory flags
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamDestroy(rtStream_t stm, uint64_t flags);

/**
 * @ingroup rts_stream
 * @brief abort a stream. Tasks executing on the stream will be stopped and tasks delivered but not executed on the stream will be discarded.
 * @param [in] stm   stream handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamAbort(rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief synchronize a stream. Wait and return after all tasks of the stream completed within the specified time.
 * @param [in] stm   stream handle
 * @param [in] timeout   Max waiting duration of synchronization
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamSynchronize(rtStream_t stm, int32_t timeout);

/**
 * @ingroup rts_stream
 * @brief query whether all tasks on a stream are executed.
 * @param [in] stm   stream handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamQuery(rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief obtains the number of available streams.
 * @param [out] streamCount   the number of available streams currently
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamGetAvailableNum(uint32_t *streamCount);

/**
 * @ingroup rts_stream
 * @brief get stream id from a stream handle
 * @param [in] stm   stream handle
 * @param [in] streamId   stream id
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamGetId(rtStream_t stm, int32_t *streamId);

/**
 * @ingroup rts_stream
 * @brief create a task group for the tasks from a stream handle
 * @param [in] stm   stream handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamBeginTaskGrp(rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief complete the task group creation and output the task group handle
 * @param [in] stm     stream handle
 * @param [out] handle task group handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamEndTaskGrp(rtStream_t stm, rtTaskGrp_t *handle);

/**
 * @ingroup rts_stream
 * @brief stream begin update task
 * @param [in] stm: stream handle
 * @param [in] handle: task group handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle);

/**
 * @ingroup rts_stream
 * @brief stream end update task
 * @param [in] stm: stream handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsStreamEndTaskUpdate(rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief execute extensible stream switch task
 * @param [in] leftValue   pointer of value
 * @param [in] cond   judge condition
 * @param [in] rightValue   pointer of target value
 * @param [in] dataType   data type of target value
 * @param [in] trueStream   stream to be activated when leftValue equal rightValue
 * @param [in] falseStream   Reserved parameter
 * @param [in] stm   stream to send task
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSwitchStream(void *leftValue, rtCondition_t cond, void *rightValue,
    rtSwitchDataType_t dataType, rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream);

/**
 * @ingroup rts_stream
 * @brief active a stream
 * @param [in] activeStream   stream to be activated
 * @param [in] stream   stream to send task
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsActiveStream(rtStream_t activeStream, rtStream_t stream);

/**
 * @ingroup rts_stream
 * @brief  Set the value of the limited resources of the specified stream
 * @param [in]  stm    stream handle
 * @param [in]  type   resource limit type
 * @param [in]  value  the value of the limited resources
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsSetStreamResLimit(rtStream_t stm, const rtDevResLimitType_t type, const uint32_t value);

/**
 * @ingroup rts_stream
 * @brief  Reset the value of the limited resources of the specified stream
 * @param [in]  stm    stream handle
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsResetStreamResLimit(rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief  Get the value of the limited resources of the specified stream
 * @param [in]  stm    stream handle
 * @param [in]  type   resource limit type
 * @param [out] value  the value of the limited resources
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsGetStreamResLimit(const rtStream_t stm, const rtDevResLimitType_t type, uint32_t *const value);

/**
 * @ingroup rts_stream
 * @brief  Use specified stream resource in current thread
 * @param [in]  stm    stream handle
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsUseStreamResInCurrentThread(const rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief  Not use specified stream resource in current thread
 * @param [in]  stm    stream handle
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsNotUseStreamResInCurrentThread(const rtStream_t stm);

/**
 * @ingroup rts_stream
 * @brief  Get the value of the limited resources of the current thread
 * @param [in]  type   resource limit type
 * @param [out] value  the value of the limited resources
 * @return RT_ERROR_NONE the function is executed successfully
 * @return OtherValues Failure
 */
RTS_API rtError_t rtsGetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value);

typedef enum {
    RT_STREAM_STATE_CREATE_POST = 1,
    RT_STREAM_STATE_DESTROY_PRE
} rtStreamState;

typedef void (*rtsStreamStateCallback)(rtStream_t stm, rtStreamState state, void *args);

/**
 * @ingroup dvrt_stream
 * @brief reg stream state callback func
 * @param [in] regName register name
 * @param [in] callback stream state callback function
 * @param [in] args user args
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsRegStreamStateCallback(const char_t *regName, rtsStreamStateCallback callback,
                                            void *args);

/**
 * @ingroup dvrt_stream
 * @brief stop tasks on stream for mc2
 * @param [in] stm: stream handle
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsStreamStop(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief clean stream
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsPersistentTaskClean(rtStream_t stm);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_STREAM_H