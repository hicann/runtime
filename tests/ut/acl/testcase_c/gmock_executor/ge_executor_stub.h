/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef UT_TESTCASE_C_GE_EXECUTOR_STUB_H
#define UT_TESTCASE_C_GE_EXECUTOR_STUB_H
#include <vector>
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "acl/acl_base.h"
#include "ge_executor_rt.h"
#include "runtime/rt.h"

class GeExecutorStubMock {
public:
  static GeExecutorStubMock& GetInstance() {
    static GeExecutorStubMock mock;
    return mock;
  }

  MOCK_METHOD0(GeInitialize, Status());
  MOCK_METHOD0(GeFinalize, Status());
  MOCK_METHOD1(GeDbgInit, Status(const char *configPath));
  MOCK_METHOD0(GeDbgDeInit, Status());
  MOCK_METHOD2(GeNofifySetDevice, Status(uint32_t chipId, uint32_t deviceId));
};

#endif