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

/**
 * @ingroup rt_model
 * @brief nano destroy model instance
 * @param [in] phyMdlId   model to destroy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtNanoModelDestroy(uint32_t phyMdlId);

typedef enum tagModelQueueFlag { RT_MODEL_INPUT_QUEUE = 0, RT_MODEL_OUTPUT_QUEUE = 1 } rtModelQueueFlag_t;

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

typedef struct tagMdlLoad {
    uint8_t overflow_en;
    uint16_t totalTaskNum;
    void* taskDescBaseAddr;
    void* pcBaseAddr;
    void* paramBaseAddr;
    void* weightBaseAddr;
    uint8_t weightPrefetch;
} rtMdlLoad_t;

/**
 * @ingroup rt_model
 * @brief nano model load
 * @param [out] phyModelId drv create model id
 * @param [in] modelLoad   model load param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtNanoModelLoad(rtMdlLoad_t* modelLoad, uint32_t* phyModelId);

typedef struct tagMdlExecute {
    void* ioaSrcAddr;
    void* dynamicTaskPtr;
    void* workPtr;
    bool sync;
    uint16_t vld;
    uint16_t taskProf;
    uint8_t mid;
    uint32_t ioaSize;
    uint32_t sqid;
    uint8_t meType;
    uintptr_t cbFn;
    void* cbData;
    size_t mpamId;
    size_t aicQos;
    size_t aicOst;
    size_t mecTimeThreshHold;
} rtMdlExecute_t;

/**
 * @ingroup rt_model
 * @brief nano model execute
 * @param [in] modelExec   model execute param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtNanoModelExecute(rtMdlExecute_t* modelExec);

/**
 * @ingroup rtMsgSend
 * @brief nano msg send
 * @param [in] tId      rcv thread id
 * @param [in] sendTid  send thread id
 * @param [in] timeout  time out
 * @param [in] sendInfo tlv info
 * @param [in] size     tlv size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMsgSend(uint32_t tId, uint32_t sendTid, int32_t timeout, void* sendInfo, uint32_t size);

/**
 * @ingroup rtSetTaskDescDumpFlag
 * @brief nano set taskdesc dump flag
 * @param [in] taskDescBaseAddr  TaskDesc Base Addr
 * @param [in] taskDescSize      Static TaskDesc Partition size
 * @param [in] taskId   task id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetTaskDescDumpFlag(void* taskDescBaseAddr, size_t taskDescSize, uint32_t taskId);

/**
 * @ingroup rt_dump_Init
 * @brief nano dump init
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDumpInit(void);

/**
 * @ingroup rt_dump_deInit
 * @brief nano dump deinit
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

/**
 * @ingroup rt_model
 * @brief register an HCCL stream with a normal model or an ACL Graph
 * @param [in] stream: non-null original HCCL stream in the current context
 * @param [in] mdl: non-null model in the current context
 * @details Duplicate registration succeeds. Normal models only record the association; the stream's
 * execution binding is unchanged. ACL Graphs use the existing stream capture procedure.
 * The caller must keep the stream alive until all associated models finish using it.
 * @return ACL_RT_SUCCESS for success, or the corresponding Runtime error
 */
RTS_API rtError_t rtModelAddHcclStream(rtStream_t stream, rtModel_t mdl);

/**
 * @ingroup rt_model
 * @brief get the unique original HCCL streams registered with this model
 * @param [in] mdl: valid non-null model; only its own registrations are returned
 * @param [out] streams: caller-owned array of borrowed stream handles; nullptr queries the count
 * @param [in,out] numStreams: required non-null pointer; when streams is non-null, its input value is
 * the array capacity in elements. On success it receives the actual count; on failure it remains unchanged.
 * Its input value is ignored when streams is nullptr.
 * @details The query is independent of the current context and does not change it.
 * To query only the count, pass streams as nullptr. Each call uses one snapshot of the registered set.
 * If the array capacity is insufficient, the array and numStreams remain unchanged.
 * Registration may increase the count between calls; query the count again, resize the array and retry.
 * On success, only the returned number of array elements are written and unused slots remain unchanged.
 * All failures leave outputs unchanged. Ordering is unspecified; querying does not retain streams.
 * Serialize resource destruction with querying and handle use.
 * Returned handles are borrowed and must only be used while their resources remain alive.
 * @return ACL_RT_SUCCESS for success, ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY for insufficient capacity,
 * or the corresponding Runtime error
 */
RTS_API rtError_t rtModelGetHcclStream(rtModel_t mdl, rtStream_t* streams, uint32_t* numStreams);

/**
 * @ingroup rt_model
 * @brief get the model directly bound to a stream for execution
 * @param [in] stream: valid non-null stream
 * @param [out] mdl: required non-null pointer to receive a borrowed model handle
 * @details The query is independent of the current context and does not change it.
 * An unbound stream succeeds and writes nullptr, including HCCL streams only registered with a model.
 * Capture relationships are not followed. Failures leave the output unchanged.
 * Stream binding/unbinding and resource destruction must be serialized with querying and use of the
 * borrowed model handle.
 * @return ACL_RT_SUCCESS for success, or the corresponding Runtime error
 */
RTS_API rtError_t rtGetModelByStream(rtStream_t stream, rtModel_t* mdl);

/*
 * @ingroup rt_model
 * @brief enable debug for dump overflow exception
 * @param [in] addr: ddr address of kernel exception dumpped
 * @param [in] mdl: model handle
 * @param [in] flag: debug flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDebugRegister(rtModel_t mdl, uint32_t flag, const void* addr, uint32_t* streamId, uint32_t* taskId);

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
RTS_API rtError_t rtModelGetId(rtModel_t mdl, uint32_t* modelId);

#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_RT_EXTERNAL_MODEL_H
