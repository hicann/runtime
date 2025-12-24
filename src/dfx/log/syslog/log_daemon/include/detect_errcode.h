/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DETECT_ERRCODE_H
#define DETECT_ERRCODE_H
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define DETECT_SUCCESS                                  0
#define DETECT_FAILURE                                  1
#define DETECT_ERROR_INVALID_ARGUMENT                   2
#define DETECT_ERROR_BAD_ALLOC                          3
#define DETECT_ERROR_OUT_OF_BUFFER                      4
#define DETECT_ERROR_COMMUNICATION                      200
#define DETECT_ERROR_TESTCASE_FAIL                      500000   // CPU STL检测异常

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
