/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_EVENT_H
#define CCE_RUNTIME_RTS_EVENT_H

#include <stdlib.h>

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum {
    RT_EVENT_STATUS_NOT_RECORDED = 0,
    RT_EVENT_STATUS_RECORDED = 1,
} rtEventRecordStatus;

/**
 * @ingroup event_flags
 * @brief event op bit flags
 */
#define RT_EVENT_FLAG_DEFAULT         0x0U
#define RT_EVENT_FLAG_SYNC            0x01U
#define RT_EVENT_FLAG_TRACE_STREAM    0x02U
#define RT_EVENT_FLAG_TIME_LINE       0x08U
#define RT_EVENT_FLAG_EXTERNAL        0x20U

typedef enum {
    NOTIFY_TABLE_SLICE  = 0U,
    NOTIFY_CNT_ST_SLICE  = 1U,
    NOTIFY_CNT_ADD_SLICE  = 2U,
    NOTIFY_CNT_BIT_WR_SLICE  = 3U,
    NOTIFY_CNT_BIT_CLR_SLICE  = 4U,
    NOTIFY_TYPE_MAX
} rtNotifyType_t;

typedef enum {
    RECORD_STORE_MODE = 0x0U,
    RECORD_ADD_MODE = 0x1U,
    RECORD_WRITE_BIT_MODE = 0x2U,
    RECORD_INVALID_MODE = 0x3U, // invalid, cannot set
    RECORD_CLEAR_BIT_MODE = 0x4U,
    RECORD_MODE_MAX
} rtCntNotifyRecordMode_t;

typedef enum {
    WAIT_LESS_MODE = 0x0U,
    WAIT_EQUAL_MODE = 0x1U,
    WAIT_BIGGER_MODE = 0x2U,
    WAIT_BIGGER_OR_EQUAL_MODE = 0x3U,
    WAIT_BITMAP_MODE = 0x4U,
    WAIT_MODE_MAX
} rtCntNotifyWaitMode_t;

typedef struct {
    rtCntNotifyWaitMode_t mode;
    uint32_t value;
    uint32_t timeout;
    bool isClear;
    uint8_t rev[3U];
} rtCntNtyWaitInfo_t;

typedef struct {
    rtCntNotifyRecordMode_t mode;
    uint32_t value;
} rtCntNtyRecordInfo_t;

/**
 * @ingroup dvrt_event
 * @brief create event instance with flag
 * @param [in|out] evt   created event
 * @param [in] flag  event op flag
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventCreate(rtEvent_t *evt, uint64_t flag);

/**
 * @ingroup dvrt_event
 * @brief create event instance with flag for single mode
 * @param [in|out] evt  created event
 * @param [in] flag  flag event op flag
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventCreateEx(rtEvent_t *evt, uint64_t flag);

/**
 * @ingroup dvrt_event
 * @brief destroy event instance
 * @param [in] evt   event to destroy
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventDestroy(rtEvent_t evt);

/**
 * @ingroup dvrt_event
 * @brief get event id
 * @param [in] evt event to be get
 * @param [in|out] evtId   event id
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventGetId(rtEvent_t evt, uint32_t *evtId);

/**
 * @ingroup dvrt_event
 * @brief Queries an event's status
 * @param [in] evt   event to query
 * @param [in out] status event status
 * @return ACL_RT_SUCCESS  for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for others
 */
RTS_API rtError_t rtsEventQueryStatus(rtEvent_t evt, rtEventRecordStatus *status);

/**
 * @ingroup dvrt_event
 * @brief event record
 * @param [in] evt   event to record
 * @param [in] stm   stream handle
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventRecord(rtEvent_t evt, rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief wait an recorded event for stream
 * @param [in] stream   the wait stream
 * @param [in] evt   the event to wait
 * @param [in] timeout  the wait timeout
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventWait(rtStream_t stream, rtEvent_t evt, uint32_t timeout);

/**
 * @ingroup dvrt_event
 * @brief wait event to be complete
 * @param [in] evt   event to wait
 * @param [in] timeout event wait timeout
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 * @return ACL_ERROR_RT_EVENT_SYNC_TIMEOUT for timeout
 */
RTS_API rtError_t rtsEventSynchronize(rtEvent_t evt, const int32_t timeout);

/**
 * @ingroup dvrt_event
 * @brief get the elapsed time from a event after event recorded.
 * @param [in] timeStamp   time in ms
 * @param [in] evt  event handle
 * @return ACL_RT_SUCCESS for ok, errno for failed
 */
RTS_API rtError_t rtsEventGetTimeStamp(uint64_t *timeStamp, rtEvent_t evt);

/**
 * @ingroup dvrt_event
 * @brief event reset
 * @param [in] evt   event to reset
 * @param [in] stm   stream handle
 * @return ACL_RT_SUCCESS for ok
 */
RTS_API rtError_t rtsEventReset(rtEvent_t evt, rtStream_t stm);

/**
 * @ingroup dvrt_stream
 * @brief inquire avaliable event count
 * @param [out] eventCount  avaliable event Count
 * @return ACL_RT_SUCCESS for complete
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEventGetAvailNum(uint32_t *eventCount);

/**
 * @ingroup dvrt_event
 * @brief computes the elapsed time between events.
 * @param [in] timeInterval   time between start and end in ms
 * @param [in] startEvent  starting event
 * @param [in] endEvent  ending event
 * @return ACL_RT_SUCCESS for ok, errno for failed
 */
RTS_API rtError_t rtsEventElapsedTime(float32_t *timeInterval, rtEvent_t startEvent, rtEvent_t endEvent);

/**
 * @ingroup dvrt_event
 * @brief Create a notify
 * @param [in|out] notify   notify to be created
 * @param [in] flag  notify op flag
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsNotifyCreate(rtNotify_t *notify, uint64_t flag);

/**
 * @ingroup dvrt_event
 * @brief Destroy a notify
 * @param [in] notify   notify to be destroyed
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsNotifyDestroy(rtNotify_t notify);

/**
 * @ingroup dvrt_event
 * @brief Record a notify
 * @param [in] notify notify to be recorded
 * @param [in] stm  input stream
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsNotifyRecord(rtNotify_t notify, rtStream_t stm);

/**
 * @ingroup dvrt_event
 * @brief Wait for a notify with time out
 * @param [in] notify notify to be wait
 * @param [in] stm  input stream
 * @param [in] timeout  input timeOut
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsNotifyWaitAndReset(rtNotify_t notify, rtStream_t stm, uint32_t timeout);

/**
 * @ingroup dvrt_event
 * @brief get notify id
 * @param [in] notify notify to be get
 * @param [in|out] notifyId   notify id
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsNotifyGetId(rtNotify_t notify, uint32_t *notifyId);

/**
 * @ingroup dvrt_event
 * @brief Batch reset notify
 * @param [in] notifies notify to be reset
 * @param [in] num length of notifies
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNotifyBatchReset(rtNotify_t *notifies, uint32_t num);

/**
 * @ingroup dvrt_event
 * @brief Reset all Notify for the current device in the current process
 * @return ACL_RT_SUCCESS for ok, errno for failed
 */
RTS_API rtError_t rtNotifyResetAll();

/**
 * @ingroup dvrt_event
 * @brief Set a notify to IPC notify
 * @param [in] notify   notify to be set to IPC notify
 * @param [out] key   identification key
 * @param [in] len   length of name
 * @param [in] flag flag for this operation. The valid flags are:
 *          RT_NOTIFY_FLAG_DEFAULT : Default behavior.
 *          RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION : Remove the whitelist verification for PID.
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNotifyGetExportKey(rtNotify_t notify, char_t *key,  uint32_t len, uint64_t flag);

/**
 * @ingroup dvrt_event
 * @brief Open IPC notify
 * @param [out] notify the opened notify
 * @param [in] key identification key
 * @param [in] flag flag for this operation. The valid flags are:
 *         RT_NOTIFY_FLAG_DEFAULT : Default behavior.
 *         RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS : Enables direct access to notify allocations on a peer device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsNotifyImportByKey(rtNotify_t *notify, const char_t *key, uint64_t flag);

/**
 * @ingroup dvrt_event
 * @brief Ipc set notify pid
 * @param [in] notify notify to be queried
 * @param [in] pid process id
 * @param [in] num length of pid[]
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num);

/**
 * @ingroup dvrt_event
 * @brief Set the server pids of the shared notify
 * @param [in] notify notify to be queried
 * @param [in] serverPids  whitelisted server pids
 * @param [in] num  number of serverPids array
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num);

/**
 * @ingroup rt_stars
 * @brief create count notify
 * @param [in] deviceId
 * @param [out] retCntNotify: count notify object
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyCreate(const int32_t deviceId, rtCntNotify_t * const cntNotify);

/**
 * @ingroup rt_stars
 * @brief create count notify
 * @param [in] deviceId
* @param [in] flags: For details, see the definition of event.h
 * @param [out] retCntNotify: count notify object
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyCreateWithFlag(const int32_t deviceId, rtCntNotify_t * const cntNotify, const uint32_t flags);

/**
 * @ingroup rt_stars
 * @brief count notify record
 * @param [in] inCntNotify count notify object
 * @param [in] stm stream
 * @param [in] value count value
 * @param [in] mode record mode
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyRecord(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                                    const rtCntNtyRecordInfo_t * const info);

/**
 * @ingroup rt_stars
 * @brief count notify wait
 * @param [in] inCntNotify count notify object
 * @param [in] stm stream
 * @param [in] timeout Timeout interval
 * @param [in] value count value
 * @param [in] mode wait mode
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyWaitWithTimeout(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                                             const rtCntNtyWaitInfo_t * const info);

/**
 * @ingroup rt_stars
 * @brief count noitfy reset
 * @param [in] inCntNotify count notify object
 * @param [in] stm stream
 * @return RT_ERROR_NONE for ok, others failed
 */

RTS_API rtError_t rtCntNotifyReset(rtCntNotify_t const inCntNotify, rtStream_t const stm);

/**
 * @ingroup rt_stars
 * @brief destroy count notify object
 * @param [in] inCntNotify count notify object
 * @param [in] len addr len
 * @param [in] stm stream
 * @param [in] isAsync async or sync
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyDestroy(rtCntNotify_t const inCntNotify);

/**
 * @ingroup rt_stars
 * @brief destroy count notify object
 * @param [in] inCntNotify count notify object
 * @param [out] cntNotifyAddress count notify address
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtGetCntNotifyAddress(rtCntNotify_t const inCntNotify, uint64_t * const cntNotifyAddress,
                                        rtNotifyType_t const regType);

/**
 * @ingroup rt_stars
 * @brief get count notify id
 * @param [in] inCntNotify count notify object
 * @param [out] notifyId notifyId
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtGetCntNotifyId(rtCntNotify_t inCntNotify, uint32_t * const notifyId);

/**
 * @ingroup rt_stars
 * @brief create count notify
 * @param [out] retCntNotify: count notify object
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCntNotifyCreateServer(rtCntNotify_t * const cntNotify, uint64_t flags);

typedef enum {
    RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE = 0x0U,
    RT_CNT_NOTIFY_RECORD_ADD_MODE = 0x1U,
    RT_CNT_NOTIFY_RECORD_BIT_OR_MODE = 0x2U,

    RT_CNT_NOTIFY_RECORD_BIT_AND_MODE = 0x4U,
    RT_CNT_NOTIFY_RECORD_MODE_MAX
} rtCntNotifyRecordMode;

typedef struct {
    rtCntNotifyRecordMode mode;
    uint32_t value;
} rtCntNotifyRecordInfo_t;

/**
 * @ingroup rt_stars
 * @brief count notify record
 * @param [in] cntNotify count notify object
 * @param [in] stm stream
 * @param [in] info count notify info
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stm,
                                     rtCntNotifyRecordInfo_t *info);

typedef enum {
    RT_CNT_NOTIFY_WAIT_LESS_MODE = 0x0U,
    RT_CNT_NOTIFY_WAIT_EQUAL_MODE = 0x1U,
    RT_CNT_NOTIFY_WAIT_BIGGER_MODE = 0x2U,
    RT_CNT_NOTIFY_WAIT_BIGGER_OR_EQUAL_MODE = 0x3U,
    RT_CNT_NOTIFY_WAIT_EQUAL_WITH_BITMASK_MODE = 0x4U,
    RT_CNT_NOTIFY_WAIT_MODE_MAX
} rtCntNotifyWaitMode;

typedef struct {
    rtCntNotifyWaitMode mode;
    uint32_t value;
    uint32_t timeout;
    bool isClear;
    uint8_t rev[3U];
} rtCntNotifyWaitInfo_t;

/**
 * @ingroup rt_stars
 * @brief count notify wait
 * @param [in] cntNotify count notify object
 * @param [in] stm stream
 * @param [in] info count notify info
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stm,
                                              rtCntNotifyWaitInfo_t *info);

/**
 * @ingroup rt_stars
 * @brief count notify reset
 * @param [in] cntNotify count notify object
 * @param [in] stm stream
 * @return RT_ERROR_NONE for ok, others failed
 */

RTS_API rtError_t rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stm);

/**
 * @ingroup rt_stars
 * @brief get count notify id
 * @param [in] cntNotify count notify object
 * @param [out] notifyId notifyId
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_EVENT_H