/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef UT_TESTCASE_C_RUNTIME_STUB_H__
#define UT_TESTCASE_C_RUNTIME_STUB_H__

#include <gmock/gmock.h>
#include "runtime/base.h"
#include "runtime/mem.h"
#include "runtime/rt.h"
#include "acl_base.h"
#include "acl_rt.h"

class RuntimeStubMock {
public:
  static RuntimeStubMock& GetInstance() {
    static RuntimeStubMock mock;
    return mock;
  }
  MOCK_METHOD0(rtInit, rtError_t());
  MOCK_METHOD2(rtSubscribeReport, rtError_t(uint64_t threadId, rtStream_t stream));
  MOCK_METHOD2(rtUnSubscribeReport, rtError_t(uint64_t threadId, rtStream_t stream));
  MOCK_METHOD4(rtCallbackLaunch, rtError_t(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock));
  MOCK_METHOD1(rtProcessReport, rtError_t(int32_t timeout));

  MOCK_METHOD2(rtSubscribeHostFunc, rtError_t(uint64_t threadId, rtStream_t stream));
  MOCK_METHOD2(rtUnSubscribeHostFunc, rtError_t(uint64_t threadId, rtStream_t stream));
  MOCK_METHOD1(rtProcessHostFunc, rtError_t(int32_t timeout));
  MOCK_METHOD1(rtCtxGetCurrent, rtError_t(rtContext_t *ctx));
  MOCK_METHOD1(rtGetRunMode, rtError_t(rtRunMode *mode));
  MOCK_METHOD2(rtStreamCreateWithConfig, rtError_t(rtStream_t *stream, rtStreamConfigHandle *handle));
};

rtError_t rtGetRunMode_Device_Normal_Invoke(rtRunMode *mode);
#endif