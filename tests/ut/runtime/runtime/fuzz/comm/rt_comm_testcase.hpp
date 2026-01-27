/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __COMM_TESTCASE__
#define __COMM_TESTCASE__

#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "runtime/rt.h"

int rt_event_ctx_test(int32_t device, uint32_t flags, int32_t priority, uint32_t sleepTime, uint32_t count, int32_t listener);

int rt_kernel_test(rtDevBinary_t *binary, uint32_t funcMode, int32_t device, int32_t priority, uint64_t size,
                   uint32_t blockDim, uint32_t argsSize, rtL2Ctrl_t *l2ctrl);

#endif //__COMM_TESTCASE__