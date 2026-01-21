/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <securec.h>
#include "gmock_executor/ge_executor_stub.h"
#ifdef __cplusplus
extern "C" {
#endif
Status GeInitialize() {
  return GeExecutorStubMock::GetInstance().GeInitialize();
}
Status GeFinalize() {
  return GeExecutorStubMock::GetInstance().GeFinalize();
}
Status GeDbgInit(const char *configPath) {
  return GeExecutorStubMock::GetInstance().GeDbgInit(configPath);
}
Status GeDbgDeInit(void) {
  return GeExecutorStubMock::GetInstance().GeDbgDeInit();
}
Status GeNofifySetDevice(uint32_t chipId, uint32_t deviceId) {
  return GeExecutorStubMock::GetInstance().GeNofifySetDevice(chipId, deviceId);
}
#ifdef __cplusplus
}
#endif