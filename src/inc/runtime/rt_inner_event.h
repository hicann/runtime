/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_EVENT_H
#define CCE_RUNTIME_RT_INNER_EVENT_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_EVENT_RECORD_DEFAULT (0x00U)
#define RT_EVENT_RECORD_EXTERNAL (0x01U)
#define RT_EVENT_WAIT_DEFAULT (0x00U)
#define RT_EVENT_WAIT_EXTERNAL (0x01U)

/**
 * @ingroup dvrt_event
 * @brief record an event with operation-level behavior flag
 * @param [in] evt event to record
 * @param [in] stm stream handle
 * @param [in] flag RT_EVENT_RECORD_DEFAULT for normal record, RT_EVENT_RECORD_EXTERNAL for ACL graph external record
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtEventRecordWithFlag(rtEvent_t evt, rtStream_t stm, uint32_t flag);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_EVENT_H
