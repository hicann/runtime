/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TEST_RUNTIME_STUB_H
#define TEST_RUNTIME_STUB_H

#include "runtime/runtime/stream.h"

// 设置流状态桩的返回值：rtStreamGetCaptureInfo 返回 captureStatus，rtStreamGetFlags 返回 streamFlags
void SetStubStreamState(rtStreamCaptureStatus captureStatus, uint32_t streamFlags);

// 获取流状态桩的当前返回值
void GetStubStreamState(rtStreamCaptureStatus& captureStatus, uint32_t& streamFlags);

#endif // TEST_RUNTIME_STUB_H
