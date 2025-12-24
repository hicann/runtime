/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_MEMORY_REMOTE_H
#define SCD_MEMORY_REMOTE_H

#include <stddef.h>
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * @brief           read memory from remote process
 * @param [in]      addr:          address to read from
 * @param [in]      dst:           address to read to
 * @param [in]      size           read size
 * @return          real read size
 */
size_t ScdMemoryRemoteRead(uintptr_t addr , void *dst, size_t size);
#ifdef __cplusplus
}
#endif // __cplusplus
#endif