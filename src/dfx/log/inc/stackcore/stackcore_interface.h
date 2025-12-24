/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKCORE_INTERFACE_H
#define STACKCORE_INTERFACE_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief       : set stackcore file subdirectory to store files in the subdirectory
 * @param [in]  : subdir      subdirectory name
 * @return      : 0 success; -1 failed
 */
int StackcoreSetSubdirectory(const char *subdir);

#ifdef __cplusplus
}
#endif
#endif