/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_DFX_H
#define CCE_RUNTIME_RT_DFX_H

#include "base.h"
#include "runtime/rt_external_event.h"

#if defined(__cplusplus)
extern "C" {
#endif

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

// max task tag buffer is 1024(include '\0')
#define TASK_TAG_MAX_LEN    1024U

/**
 * @brief set aicpu device attribute.
 * it is used for aicpu device to be aware of environment config
 * @param [in] key  attrubute key.
 * @param [in] val  attrubute value.
 * @return RT_ERROR_NONE for ok
 * @return other failed
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t rtSetAicpuAttr(const char_t *key, const char_t *val);

RT_RUNTIME_DEPRECATED_DECLS_END
#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_DFX_H
