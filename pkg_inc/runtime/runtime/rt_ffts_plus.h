/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_FFTS_PLUS_H
#define CCE_RUNTIME_RT_FFTS_PLUS_H

#include "base.h"
#include "rt_ffts_plus_define.h"
#include "rt_stars_define.h"
#include "runtime/rt_external_ffts.h"
#if defined(__cplusplus) && !defined(COMPILE_OMG_PACKAGE)
extern "C" {
#endif

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtGetAddrAndPrefCntWithHandle(void *hdl, const void *kernelInfoExt, void **addr,
    uint32_t *prefetchCnt);

RT_RUNTIME_DEPRECATED_DECLS_END

#if defined(__cplusplus) && !defined(COMPILE_OMG_PACKAGE)
}
#endif
#endif // CCE_RUNTIME_RT_FFTS_PLUS_H
