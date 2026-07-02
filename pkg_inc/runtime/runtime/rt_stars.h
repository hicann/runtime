/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_STARS_H
#define CCE_RUNTIME_RT_STARS_H

#include "base.h"
#include "rt_stars_define.h"
#include "runtime/rt_external_stars.h"
#if defined(__cplusplus)
extern "C" {
#endif

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

/**
 * @ingroup rt_stars
 * @brief launch stars task.
 * used for send star sqe directly.
 * @param [in] taskSqe     stars task sqe
 * @param [in] sqeLen      stars task sqe length
 * @param [in] stm      associated stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStarsTaskLaunch(const void *taskSqe, uint32_t sqeLen, rtStream_t stm);

/**
 * @ingroup rt_stars
 * @brief launch stars task.
 * used for send star sqe directly.
 * @param [in] taskSqe     stars task sqe
 * @param [in] sqeLen      stars task sqe length
 * @param [in] stm         associated stream
 * @param [in] flag        dump flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtStarsTaskLaunchWithFlag(const void *taskSqe, uint32_t sqeLen, rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief launch common cmo task on the stream.
 * @param [in] taskInfo     cmo task info
 * @param [in] stm          launch task on the stream
 * @param [in] flag         flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtCmoTaskLaunch(rtCmoTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);

/**
 * @ingroup dvrt_mem
 * @brief launch common cmo task on the stream.
 * @param [in] cmoAddrInfo      cmo task info
 * @param [in] destMax          destMax
 * @param [in] cmoOpCode        opcode
 * @param [in] stm              launch task on the stream
 * @param [in] flag             flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtCmoAddrTaskLaunch(void *cmoAddrInfo, uint64_t destMax, rtCmoOpCode_t cmoOpCode,
    rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief launch common cmo task on the stream.
 * @param [in] srcAddrPtr     prefetch addrs
 * @param [in] srcLen         prefetch addrs load
 * @param [in] cmoType        opcode   
 * @param [in] stm            stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm);

/**
 * @ingroup rt_stars
 * @brief launch barrier cmo task on the stream.
 * @param [in] taskInfo     barrier task info
 * @param [in] stm          launch task on the stream
 * @param [in] flag         flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtBarrierTaskLaunch(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);

/*
 * @ingroup dvrt_stream
 * @brief set stream geOpTag
 * @param [in] stm: stream handle
 * @param [in] geOpTag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtSetStreamTag(rtStream_t stm, uint32_t geOpTag);


RT_RUNTIME_DEPRECATED_DECLS_END
#if defined(__cplusplus)
}
#endif
#endif  // CCE_RUNTIME_RT_STARS_H
