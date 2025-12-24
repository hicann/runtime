/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_EXTERNAL_MODEL_H
#define CCE_RUNTIME_RT_EXTERNAL_MODEL_H

#include "rt_external_base.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup rt_model
 * @brief add stream sq lock task
 * @param [in]  stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetStreamSqLock(rtStream_t stm);

/**
 * @ingroup rt_model
 * @brief add stream sq unlock task
 * @param [in]  stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetStreamSqUnlock(rtStream_t stm);

typedef enum tagModelQueueFlag {
    RT_MODEL_INPUT_QUEUE = 0,
    RT_MODEL_OUTPUT_QUEUE = 1
} rtModelQueueFlag_t;

/**
 * @ingroup rt_model
 * @brief bind queue
 * @param [in] mdl     model to bind
 * @param [in] queueId   queueId to bind
 * @param [in] flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtModelBindQueue(rtModel_t mdl, uint32_t queueId, rtModelQueueFlag_t flag);

/**
 * @ingroup rtMsgSend
 * @brief msg send
 * @param [in] tId      rcv thread id
 * @param [in] sendTid  send thread id
 * @param [in] timeout  time out
 * @param [in] sendInfo tlv info
 * @param [in] size     tlv size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMsgSend(uint32_t tId, uint32_t sendTid, int32_t timeout, void *sendInfo, uint32_t size);

/**
 * @ingroup rtSetTaskDescDumpFlag
 * @brief set taskdesc dump flag
 * @param [in] taskDescBaseAddr  TaskDesc Base Addr
 * @param [in] taskDescSize      Static TaskDesc Partition size
 * @param [in] taskId   task id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetTaskDescDumpFlag(void *taskDescBaseAddr, size_t taskDescSize, uint32_t taskId);

/**
 * @ingroup rt_dump_Init
 * @brief dump init
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDumpInit(void);

/**
 * @ingroup rt_dump_deInit
 * @brief dump deinit
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDumpDeInit(void);

/**
 * @ingroup rt_model
 * @brief add stream task to model 
 * @param [in] stm
 * @param [in] captureMdl
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtStreamAddToModel(rtStream_t stm, rtModel_t captureMdl);

/*
 * @ingroup rt_model
 * @brief enable debug for dump overflow exception
 * @param [in] addr: ddr address of kernel exception dumpped
 * @param [in] mdl: model handle
 * @param [in] flag: debug flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDebugRegister(rtModel_t mdl, uint32_t flag, const void *addr,
                                  uint32_t *streamId, uint32_t *taskId);

/*
 * @ingroup rt_model
 * @brief disable debug for dump overflow exception
 * @param [in] mdl: model handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDebugUnRegister(rtModel_t mdl);

/*
 * @ingroup rt_model
 * @brief disable debug for dump overflow exception with stream
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDebugUnRegisterForStream(rtStream_t stm);

/**
 * @ingroup rt_model
 * @brief get model id
 * @param [in] mdl
 * @param [out] modelId   model id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtModelGetId(rtModel_t mdl, uint32_t *modelId);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RT_EXTERNAL_MODEL_H