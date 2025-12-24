/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef GE_STUB_H
#define GE_STUB_H
namespace ge {
int32_t ProfCtrlHandle(uint32_t dataType, void *data, uint32_t dataLen);
int32_t ExecuteModel(uint32_t modelId);
int32_t ExecuteOp();
int32_t LoadModel(uint32_t *modelId);
int32_t UnloadModel(uint32_t modelId);
}
#endif

