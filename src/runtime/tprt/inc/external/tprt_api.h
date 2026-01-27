/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TPRT_API_H_
#define TPRT_API_H_
#include "tprt_error_code.h"
#include "tprt_type.h"
#if defined(__cplusplus)
extern "C" {
#endif
uint32_t TprtDeviceOpen(const uint32_t devId, const TprtCfgInfo_t *cfg);
uint32_t TprtDeviceClose(uint32_t devId);
uint32_t TprtSqCqCreate(const uint32_t devId, const TprtSqCqInputInfo *sqInfo, const TprtSqCqInputInfo *cqInfo);
uint32_t TprtSqCqDestroy(const uint32_t devId, const TprtSqCqInputInfo *sqInfo, const TprtSqCqInputInfo *cqInfo);
uint32_t TprtSqPushTask(const uint32_t devId, const TprtTaskSendInfo_t *sendInfo);
uint32_t TprtOpSqCqInfo(uint32_t devId, TprtSqCqOpInfo_t *opInfo);
uint32_t TprtCqReportRecv(uint32_t devId, TprtReportCqeInfo_t *cqeInfo);
uint32_t TprtGetSqState(uint32_t devId, TprtReportCqeInfo_t *cqeInfo);
#ifdef __cplusplus
}
#endif
#endif // TPRT_API_H_