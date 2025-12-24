/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_NODE_H
#define TRACE_NODE_H

#include "atrace_types.h"
#include "trace_queue.h"
#include "trace_session_mgr.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define ADIAG_INFO_FLAG_START   0
#define ADIAG_INFO_FLAG_MID     1
#define ADIAG_INFO_FLAG_END     2

TraStatus TraceTsPushNode(SessionNode *sessionNode, uint8_t flag, void *data, uint32_t len);
TraceNode *TraceTsPopNode(SessionNode *sessionNode);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif