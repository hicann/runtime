/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_DFX_H
#define CCE_RUNTIME_RTS_DFX_H

#include <stdlib.h>

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup rts_profiling
 * @brief Support users customized profiling breakpoint at specified network locations.
 * @param [in] userdata the user data.
 * @param [in] length the data length.
 * @param [in] stream the stream.
 * @return RT_ERROR_NONE for ok.
 * @return other for error.
 */
RTS_API rtError_t rtsProfTrace(void *userdata,  int32_t length , rtStream_t stream);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_DFX_H