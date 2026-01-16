/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_SNAPSHOT_H
#define CCE_RUNTIME_RTS_SNAPSHOT_H
#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum { 
    RT_PROCESS_STATE_RUNNING = 0, 
    RT_PROCESS_STATE_LOCKED, 
    RT_PROCESS_STATE_BACKED_UP,
    RT_PROCESS_STATE_MAX 
} rtProcessState;

typedef enum {
    RT_SNAPSHOT_LOCK_PRE = 0,
    RT_SNAPSHOT_BACKUP_PRE,
    RT_SNAPSHOT_BACKUP_POST,
    RT_SNAPSHOT_RESTORE_PRE,
    RT_SNAPSHOT_RESTORE_POST,
    RT_SNAPSHOT_UNLOCK_POST,
} rtSnapShotStage;

typedef uint32_t (*rtSnapShotCallBack)(int32_t devId, void* args);

/**
 * @ingroup rts_snapshot
 * @brief lock the NPU process which will block further rts API calls
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotProcessLock();

/**
 * @ingroup rts_snapshot
 * @brief unlock the NPU process and allow it to continue making RTS API calls
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotProcessUnlock();

/**
 * @ingroup rts_snapshot
 * @brief returns the process state of a NPU process
 * @param [out] state, return the process state of a NPU process, the possible values for state are as follows:
 *   RT_PROCESS_STATE_RUNNING : Default process state,
 *   RT_PROCESS_STATE_LOCKED : RTS API locks are taken so further RTS API calls will block
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotProcessGetState(rtProcessState *state);

/**
 * @ingroup rts_snapshot
 * @brief backup the NPU process
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotProcessBackup();

/**
 * @ingroup rts_snapshot
 * @brief restore the NPU process from the last backup point
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotProcessRestore();

/**
 * @ingroup rts_snapshot
 * @brief registers a callback function for snapshot operation stages
 * @param [in] stage the snapshot stage at which the callback should be triggered
 *   The available stages are:
 *   @li RT_SNAPSHOT_LOCK_PRE         - Called before process lock for snapshot
 *   @li RT_SNAPSHOT_BACKUP_PRE       - Called before backup operation starts
 *   @li RT_SNAPSHOT_BACKUP_POST      - Called after backup operation completes
 *   @li RT_SNAPSHOT_RESTORE_PRE      - Called before restore operation starts
 *   @li RT_SNAPSHOT_RESTORE_POST     - Called after restore operation completes
 *   @li RT_SNAPSHOT_UNLOCK_POST      - Called after process unlock
 * @param [in] callback Pointer to the callback function with signature:
 *        @code
 *        uint32_t rtSnapShotCallBack(int32_t devId, void* args);
 *        @endcode
 *        The system will invoke this function when the specified stage is reached.
 *        The callback should return 0 on success, non-zero error code on failure.
 *        Must not be NULL.
 * @param [in] args User-defined argument pointer passed unchanged to the callback.
 *        This can be NULL if no additional data is needed.
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args);

/**
 * @ingroup rts_snapshot
 * @brief unregisters a previously registered callback function for a snapshot stage
 * @param [in] stage the snapshot stage at which the callback should be triggered
 *   The available stages are:
 *   @li RT_SNAPSHOT_LOCK_PRE         - Called before process lock for snapshot
 *   @li RT_SNAPSHOT_BACKUP_PRE       - Called before backup operation starts
 *   @li RT_SNAPSHOT_BACKUP_POST      - Called after backup operation completes
 *   @li RT_SNAPSHOT_RESTORE_PRE      - Called before restore operation starts
 *   @li RT_SNAPSHOT_RESTORE_POST     - Called after restore operation completes
 *   @li RT_SNAPSHOT_UNLOCK_POST      - Called after process unlock
 * @param [in] callback Pointer to the callback function with signature:
 *        @code
 *        uint32_t rtSnapShotCallBack(int32_t devId, void* args);
 *        @endcode
 *        The system will invoke this function when the specified stage is reached.
 *        The callback should return 0 on success, non-zero error code on failure.
 *        Must not be NULL.
 * @return ACL_RT_SUCCESS for ok, others failed
 */
RTS_API rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback);

#if defined(__cplusplus)
}
#endif

#endif
