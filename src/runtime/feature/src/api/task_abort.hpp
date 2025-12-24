/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_TASK_ABORT_HPP
#define CCE_RUNTIME_TASK_ABORT_HPP

#include "base.hpp"

#ifdef __cplusplus
extern "C" {  
#endif // __cplusplus

rtError_t rtStreamTaskAbort(rtStream_t stm);
rtError_t rtStreamRecover(rtStream_t stm);
rtError_t rtGetModelList(int32_t devId, rtModelList_t *mdlList);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // CCE_RUNTIME_TASK_ABORT_HPP