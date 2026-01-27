/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TPRT_TYPE_H
#define TPRT_TYPE_H

#include <stdbool.h>
#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

typedef void *TprtResHandle_t;
#define SQCQ_INFO_LENGTH 8
#define SQCQ_RESV_LENGTH 8

typedef enum tagTprtSqCqPropType {
    TPRT_SQCQ_PROP_SQ_STATUS = 0x0, // quit, running, error
    TPRT_SQCQ_PROP_SQ_HEAD,
    TPRT_SQCQ_PROP_SQ_TAIL,
    TPRT_SQCQ_PROP_SQ_DISABLE_TO_ENABLE,
    TPRT_SQCQ_PROP_SQ_CQE_STATUS, /* read clear */
    TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT,
    TPRT_SQCQ_PROP_MAX
} TprtSqCqPropType_t;

typedef struct tagTprtTaskSendInfo_t {
    uint8_t *sqeAddr;
    uint32_t sqId;
    uint32_t sqeNum;
} TprtTaskSendInfo_t;

typedef enum tagSqCqOpType {
    TPRT_ALLOC_SQ_TYPE = 0,
    TPRT_ALLOC_CQ_TYPE,
    TPRT_FREE_SQ_TYPE,
    TPRT_FREE_CQ_TYPE,
    TPRT_QUERY_SQ_INFO,
    TPRT_QUERY_CQ_INFO,
    TPRT_CONFIG_SQ,
    TPRT_INVALID_TYPE,
} TprtSqCqOpType_t;

typedef enum tagTprtSqState_t {
    TPRT_SQ_STATE_IS_RUNNING = 0,
    TPRT_SQ_STATE_ERROR_ENCOUNTERED= 1,
    TPRT_SQ_STATE_IS_QUITTED = 2,
} TprtSqState_t;

typedef struct TprtSqCqOpInfo {
    TprtSqCqOpType_t type;
    uint16_t reqId;
    TprtSqCqPropType_t prop;
    uint32_t value[SQCQ_INFO_LENGTH];
} TprtSqCqOpInfo_t;

typedef struct TprtSqCqInputInfo {
    uint32_t reqId;
    TprtSqCqOpType_t inputType;
} TprtSqCqInputInfo_t;

typedef struct TprtCfgInfo {
    uint32_t sqcqMaxNum;
    uint32_t sqcqMaxDepth;
    uint32_t timeoutMonitorUint;  // unit:ms
    uint32_t defaultExeTimeout;  // unit:ms
} TprtCfgInfo_t;

typedef struct TprtSqCqQueryInfo {
    TprtSqCqOpType_t type;
    uint32_t devId;
    uint32_t resId;
    TprtSqCqPropType_t prop;
    uint32_t value[SQCQ_INFO_LENGTH];
} TprtSqCqQueryInfo_t;

typedef struct tagTprtReportCqeInfo {
    TprtSqCqOpType_t type;
    uint32_t cqId;
    uint8_t *cqeAddr;
    uint32_t cqeNum;
    uint32_t reportCqeNum; /* output */
    uint32_t res[SQCQ_RESV_LENGTH];
} TprtReportCqeInfo_t;

typedef struct tagTprtLogicCqReport_t {
    uint32_t taskSn;
    uint32_t errorCode;    // cqe acc_status/sq_sw_status
    uint8_t errorType;     // bit0 ~ bit5 cqe stars_defined_err_code, bit 6 cqe warning bit
    uint8_t sqeType;
    uint16_t sqId;
    uint16_t sqHead;
    uint16_t reserved0;
} TprtLogicCqReport_t;

#if defined(__cplusplus)
}
#endif

#endif