/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STREAM_H
#define CCE_RUNTIME_STREAM_H

#include <stdlib.h>

#include "base.h"
#include "event.h"
#include "runtime/rt_external_stream.h"
#include "runtime/rt_external_model.h"

#if defined(__cplusplus)
extern "C" {
#endif

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

#define RT_STREAM_FAST_LAUNCH (0x200U)
#define RT_STREAM_FAST_SYNC   (0x400U)
#define RT_STREAM_CP_PROCESS_USE (0x800U) // RT_STREAM_CP_PROCESS_USE does not support OR with other flags

/**
 * @ingroup stream_config
 * @brief stream config params
 */
typedef struct TagStreamConfigHandle {
    void *workPtr;
    size_t workSize;
    size_t flag;
    uint32_t priority;
} rtStreamConfigHandle;

typedef enum tagRtClearStep {
    RT_STREAM_STOP = 0,
    RT_STREAM_CLEAR,
} rtClearStep_t;

/**
 * @ingroup stream_capture_status
 * @brief stream capture status
 */
typedef enum tagRtStreamCaptureStatus {
    RT_STREAM_CAPTURE_STATUS_NONE        = 0, /* The stream is not capturing */
    RT_STREAM_CAPTURE_STATUS_ACTIVE      = 1, /* The stream is capturing */
    RT_STREAM_CAPTURE_STATUS_INVALIDATED = 2, /* The stream was capturing but an error has invalidated the capture sequence. 
                                                 The capture sequence must be terminated with rtStreamEndCapture on the stream. */

    RT_STREAM_CAPTURE_STATUS_MAX
} rtStreamCaptureStatus;

#define RT_MAX_MODELS_IN_ONE_STREAM (256)

/**
 * @ingroup dvrt_stream
 * @brief create stream instance
 * @param [in|out] stm   created stream
 * @param [in] priority   stream priority
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamCreate(rtStream_t *stm, int32_t priority);

/**
 * @ingroup dvrt_stream
 * @brief create stream instance for external api
 * @param [in|out] stm   created stream
 * @param [in] priority   stream priority
 * @param [in] flags  stream op flags
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamCreateWithFlagsExternal(rtStream_t *stm, int32_t priority, uint32_t flags);

/**
 * @ingroup dvrt_stream
 * @brief create stream instance
 * @param [in|out] stm   created stream
 * @param [in] handle   stream config
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamCreateWithConfig(rtStream_t *stm, rtStreamConfigHandle *handle);

/**
 * @ingroup dvrt_stream
 * @brief query stream priority
 * @param [in] stm  to query
 * @param [out] priority   stream priority
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamGetPriority(const rtStream_t stm, uint32_t *priority);

/**
 * @ingroup dvrt_stream
 * @brief query stream flags
 * @param [in] stm  to query
 * @param [out] flags  stream op flags
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamGetFlags(const rtStream_t stm, uint32_t *flags);


/**
 * @ingroup dvrt_stream
 * @brief destroy stream instance.
 * @param [in] stm   the stream to destroy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamDestroy(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief force destroy stream instance.
 * @param [in] stm   the stream to destroy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamDestroyForce(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief wait an recorded event for stream
 * @param [in] stm   the wait stream
 * @param [in] event   the event to wait
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamWaitEvent(rtStream_t stm, rtEvent_t evt);

/**
 * @ingroup dvrt_stream
 * @brief wait an recorded event for stream
 * @param [in] stm   the wait stream
 * @param [in] event   the event to wait
 * @param [in] timeout   timeout value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamWaitEventWithTimeout(rtStream_t stm, rtEvent_t evt, uint32_t timeout);

/**
 * @ingroup dvrt_stream
 * @brief wait stream to be complete
 * @param [in] stm   stream to wait
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamSynchronize(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief wait stream to be complete and set timeout
 * @param [in] stm   stream to wait
 * @param [in] timeout   timeout value,the unit is milliseconds
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamSynchronizeWithTimeout(rtStream_t stm, int32_t timeout);

/**
 * @ingroup dvrt_stream
 * @brief queries an asynchronous stream for completion status
 * @param [in] stm   stream to query
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_STREAM_NOT_COMPLETE for not complete
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamQuery(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief get stream id from a stream handle
 * @param [in] stm   stream hadle
 * @param [in] streamId   stream id
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetStreamId(rtStream_t stm, int32_t *streamId);

/**
 * @ingroup dvrt_stream
 * @brief inquire available stream count
 * @param [in] streamType   Stream Type
 * @param [out] streamCount  available streamCount
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount);

/**
 * @ingroup dvrt_stream
 * @brief inquire available event count
 * @param [out] eventCount  available event Count
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetAvailEventNum(uint32_t * const eventCount);

/**
 * @ingroup dvrt_stream
 * @brief Name a stream
 * @param [in] stm  stream to be named
 * @param [in] name   identification name
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtNameStream(rtStream_t stm, const char_t *name);

/**
 * @brief execute extensible stream switch task
 * @param [in] ptr   pointer of value
 * @param [in] condition   judge condition
 * @param [in] value_ptr   pointer of target value
 * @param [in] true_stream   stream to be activated when value is not zero
 * @param [in] stm   stream id
 * @param [in] dataType   data type of target value
 * @return RT_ERROR_NONE for complete
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamSwitchEx(void *ptr, rtCondition_t condition, void *valuePtr, rtStream_t trueStream,
                                   rtStream_t stm, rtSwitchDataType_t dataType);

/**
 * @ingroup dvrt_stream
 * @brief Active a stream
 * @param [in] activeStream stream to be activated
 * @param [in] stm input stream to init task
 * @return RT_ERROR_NONE for complete
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamActive(rtStream_t activeStream, rtStream_t stm);

/**
 * @brief execute extensible stream case switch task
 * @param [in] ptr   pointer of value
 * @param [in] size  pointer num of value
 * @param [in] valuePtr  pointer of target value, length = size * elementSize
 * @param [in] trueStreamPtr streams to be activated
 * @param [in] elementSize  size of to be activated true streams
 * @param [in] stm input stream to init task
 * @param [in] dataType   data type of target value
 * @return RT_ERROR_NONE for complete
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamSwitchN(void *ptr, uint32_t size, void *valuePtr, rtStream_t *trueStreamPtr,
                                  uint32_t elementSize, rtStream_t stm, rtSwitchDataType_t dataType);

/*
 * @ingroup dvrt_stream
 * @brief enable or disable stream overflow
 * @param [in] stm: stream handle
 * @param [in] flag: 0:disable others:enable
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtSetStreamOverflowSwitch(rtStream_t stm, uint32_t flags);

/*
 * @ingroup dvrt_stream
 * @brief get whether overflow of the stream is enable or disable
 * @param [in] stm: stream handle
 * @param [out] flag: 0:disable others:enable
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetStreamOverflowSwitch(rtStream_t stm, uint32_t *flags);

/*
 * @ingroup dvrt_stream
 * @brief get stream geOpTag
 * @param [in] stm: stream handle
 * @param [out] geOpTag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetStreamTag(rtStream_t stm, uint32_t *geOpTag);

/**
 * @ingroup dvrt_stream
 * @brief clearing tasks on stream for mc2
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamClear(rtStream_t stm, rtClearStep_t step);

/**
 * @ingroup dvrt_stream
 * @brief clean stream
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamTaskClean(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief get current default stream
 * @param [out] stm: default stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtCtxGetCurrentDefaultStream(rtStream_t *stm);

/**
 * @ingroup dvrt_stream
 * @brief reg stream state callback func
 * @param [int] regName register name
 * @param [int] callback callback func
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtRegStreamStateCallback(const char_t *regName, const rtStreamStateCallback callback);

/**
 * @ingroup dvrt_stream
 * @brief abort stream
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamAbort(rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief stream begin capture
 * @param [in] stm: stream handle
 * @param [in] mode: capture mode
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode);

/**
 * @ingroup dvrt_stream
 * @brief stream end capture
 * @param [in] stm: stream handle
 * @param [out] captureMdl: model handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl);

/**
 * @ingroup dvrt_stream
 * @brief get stream capture info
 * @param [in] stm: stream handle
 * @param [out] status: capture status
 * @param [out] captureMdl: model handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus * const status,
                                         rtModel_t *captureMdl);

/**
 * @ingroup dvrt_stream
 * @brief exchange the capture mode of the current thread
 * @param [in] mode: indicates the capture mode to be set
 * @param [out] mode: capture mode before setting
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode);

RT_RUNTIME_DEPRECATED_DECLS_END
#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_STREAM_H
