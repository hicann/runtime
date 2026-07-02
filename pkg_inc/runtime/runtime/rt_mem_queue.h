/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_MEM_QUEUE_H
#define CCE_RUNTIME_RT_MEM_QUEUE_H

#include "base.h"
#include "runtime/rt_external_mem.h"

#if defined(__cplusplus)
extern "C" {
#endif

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

#define RT_BUFF_SP_HUGEPAGE_ONLY (1 << 1)

typedef enum rt_queue_work_mode {
    RT_QUEUE_MODE_PUSH = 1,
    RT_QUEUE_MODE_PULL,
} RT_QUEUE_WORK_MODE;

/**
 * @ingroup rt_mem_queue
 * @brief init queue schedule
 * @param [in] devId   the logical device id
 * @param [in] grpName   the name of group, can be nullptr
 * @return RT_ERROR_NONE for ok
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMemQueueInitQS(int32_t devId, const char_t *grpName);

/**
 * @ingroup rt_mem_queue
 * @brief mbuf queue export for share
 * @param [in] devId   the logical id of the shared device
 * @param [in] qid     the shared Memory queue id
 * @param [in] peerDevId   the logical device id of peer
 * @param [in] shareName   the name of the share memque
 * @return RT_ERROR_NONE for ok
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMemQueueExport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName);

/**
 * @ingroup rt_mem_queue
 * @brief mbuf queue unexport for share
 * @param [in] devId    the logical id of the shared device
 * @param [in] qid  the shared Memory queue id
 * @param [in] peerDevId   the logical device id of peer
 * @param [in] shareName   the name of the share memque
 * @return RT_ERROR_NONE for ok
 */
 RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMemQueueUnExport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName);

/**
 * @ingroup rt_mem_queue
 * @brief mbuf queue import
 * @param [in] devId   the logical id of the import device
 * @param [in] peerDevId   the logical device id of peer
 * @param [in] shareName   the name of the shared memque
 * @param [out] qid   the queue id of the import device
 * @return RT_ERROR_NONE for ok
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMemQueueImport(int32_t devId, int32_t peerDevId, const char * const shareName, uint32_t * const qid);

/**
 * @ingroup rt_mem_queue
 * @brief mbuf queue unimport
 * @param [in] devId   the logical id of the import device
 * @param [in] qid     the queue id of the import device
 * @param [in] peerDevId   the logical device id of peer
 * @param [in] shareName   the name of the shared memque
 * @return RT_ERROR_NONE for ok
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMemQueueUnImport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName);

/**
* @ingroup rt_mem_queue
* @brief append mbuf to mbuf chain
* @param [inout] memBufChainHead, the mbuf chain head
* @param [in] memBuf, the mbuf to append
* @return RT_ERROR_NONE for ok
*/
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMbufChainAppend(rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf);

/**
* @ingroup rt_mem_queue
* @brief get mbuf num in mbuf chain
* @param [in] memBufChainHead, the mbuf chain head
* @param [out] num, the mbuf chain size
* @return RT_ERROR_NONE for ok
*/
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMbufChainGetMbufNum(rtMbufPtr_t memBufChainHead, uint32_t *num);

/**
* @ingroup rt_mem_queue
* @brief get mbuf in mbuf chain
* @param [in] mbufChainHead, the mbuf chain head
* @param [in] index, the mbuf index which to get in chain
* @param [out] mbuf, the mbuf to get
* @return RT_ERROR_NONE for ok
*/
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtMbufChainGetMbuf(rtMbufPtr_t memBufChainHead, uint32_t index, rtMbufPtr_t *memBuf);

RT_RUNTIME_DEPRECATED_DECLS_END
#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_MEM_QUEUE_H
