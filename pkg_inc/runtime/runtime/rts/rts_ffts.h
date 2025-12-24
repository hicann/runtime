/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_FFTS_H
#define CCE_RUNTIME_RTS_FFTS_H

#include <stdlib.h>

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif
/**
 * @brief get kernel inter core sync address
 *
 * @param addr inter core sync address
 * @param len buffer len
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetInterCoreSyncAddr(uint64_t *addr, uint32_t *len);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_FFTS_H