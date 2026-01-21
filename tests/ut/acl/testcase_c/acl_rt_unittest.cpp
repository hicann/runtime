/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <vector>
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <iostream>
#include <fstream>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include "ge_executor_stub.h"
#include "log_inner.h"

#define protected public
#define private public

#undef private
#undef protected

#include <iostream>
#include "acl_rt.h"
#include "acl.h"
#include "runtime/base.h"
#include "runtime/mem.h"
#include "runtime_stub.h"
#include "mmpa_api.h"

using namespace std;
using namespace testing;

class AclRtTest : public testing::Test {
protected:
 void SetUp(){
  ON_CALL(MmpaStubMock::GetInstance(), mmMalloc(_)).WillByDefault(Invoke(mmMalloc_Normal_Invoke));
  ON_CALL(RuntimeStubMock::GetInstance(), rtInit()).WillByDefault(Return(SUCCESS));
  ON_CALL(GeExecutorStubMock::GetInstance(), GeInitialize()).WillByDefault(Return(SUCCESS));
  ON_CALL(GeExecutorStubMock::GetInstance(), GeDbgInit(_)).WillByDefault(Return(SUCCESS));
  ON_CALL(GeExecutorStubMock::GetInstance(), GeDbgDeInit()).WillByDefault(Return(SUCCESS));
  ON_CALL(GeExecutorStubMock::GetInstance(), GeFinalize()).WillByDefault(Return(SUCCESS));
  ON_CALL(GeExecutorStubMock::GetInstance(), GeNofifySetDevice(_, _)).WillByDefault(Return(SUCCESS));
  }

  void TearDown()
  {
    Mock::VerifyAndClearExpectations(&MmpaStubMock::GetInstance());
    Mock::VerifyAndClearExpectations(&RuntimeStubMock::GetInstance());
    Mock::VerifyAndClearExpectations(&GeExecutorStubMock::GetInstance());
  }
};

TEST_F(AclRtTest, aclInit_normal_nullptrConfig) {
  // configPath is illegal, GeDbgInit is not called.
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclInit_normal_nullStrConfig) {
  // configPath is illegal, GeDbgInit is not called.
  aclError ret = aclInit("");
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclInit_normal_illegalConfig) {
  // configPath is illegal, GeDbgInit is not called.
  aclError ret = aclInit("123");
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_init_finalize_normal_onceCall) {
  const char *json = "{}";
  const char *filePath = "acl.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();
  aclError ret = aclInit(filePath);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_init_finalize_normal_repeatedCall) {
  const char *json = "{}";
  const char *filePath = "acl.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();
  aclError ret = aclInit(filePath);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclInit_rtInitErr) {
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtInit()).Times(1).WillOnce(Return(ACL_ERROR_INTERNAL_ERROR));
  const char *json = "{}";
  const char *filePath = "acl.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();
  aclError ret = aclInit(filePath);
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclInit_GeInitError) {
  EXPECT_CALL(GeExecutorStubMock::GetInstance(), GeInitialize()).Times(1).WillOnce(Return(ACL_ERROR_GE_PARAM_INVALID));
  aclError ret = aclInit(NULL);
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclInit_DbgInitErr) {
  EXPECT_CALL(GeExecutorStubMock::GetInstance(), GeDbgInit(_)).Times(1).WillOnce(Return(ACL_ERROR_GE_PARAM_INVALID));
  const char *json = "{}";
  const char *filePath = "acl.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();
  aclError ret = aclInit(filePath);
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_get_version_normal) {
  int32_t majorVersion;
  int32_t minorVersion;
  int32_t patchVersion;
  aclError ret = aclrtGetVersion(&majorVersion, &minorVersion,
    &patchVersion);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_get_version_unnormal) {
  int32_t minorVersion;
  int32_t patchVersion;
  aclError ret = aclrtGetVersion(nullptr, &minorVersion,
    &patchVersion);
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_get_runmode_host_normal) {
  aclrtRunMode runmode;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtGetRunMode(_)).Times(1).WillOnce(Return(SUCCESS));
  aclError ret = aclrtGetRunMode(&runmode);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_get_runmode_device_normal) {
  aclrtRunMode runmode;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtGetRunMode(_)).Times(1)
      .WillOnce(Invoke(rtGetRunMode_Device_Normal_Invoke));
  aclError ret = aclrtGetRunMode(&runmode);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_get_runmode_unnormal) {
  aclError ret = aclrtGetRunMode(NULL);
  EXPECT_NE(ret, ACL_SUCCESS);

  aclrtRunMode runmode;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtGetRunMode(_)).Times(1).WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
  ret = aclrtGetRunMode(&runmode);
  EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(AclRtTest, acl_device_normal) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  int32_t devId;
  ret = aclrtGetDevice(&devId);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_device_unnormal) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(-1);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtGetDevice(NULL);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtGetDevice((int32_t *)0x2);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(-1);
  EXPECT_NE(ret, ACL_SUCCESS);

  EXPECT_CALL(GeExecutorStubMock::GetInstance(), GeNofifySetDevice(_, _)).Times(1).WillOnce(Return(ACL_ERROR_GE_PARAM_INVALID));
  ret = aclrtSetDevice(0);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_context_normal) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  aclrtContext context;
  int32_t deviceId = 0;
  ret = aclrtCreateContext(&context, deviceId);
  EXPECT_EQ(ret, ACL_SUCCESS);
  context = (aclrtContext)0x01;

  ret = aclrtSetCurrentContext(context);
  EXPECT_EQ(ret, ACL_SUCCESS);

  aclrtContext curContext;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtCtxGetCurrent(_)).Times(1).WillOnce(Return(SUCCESS));
  ret = aclrtGetCurrentContext(&curContext);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtDestroyContext(context);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_context_unnormal) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  int32_t deviceId = 0;
  ret = aclrtCreateContext(nullptr, deviceId);
  EXPECT_NE(ret, ACL_SUCCESS);

  aclrtContext context;
  ret = aclrtCreateContext(&context, -1);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtGetCurrentContext(nullptr);
  EXPECT_NE(ret, ACL_SUCCESS);

  aclrtContext curContext;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtCtxGetCurrent(_)).Times(1).WillOnce(Return(ACL_ERROR_RT_CONTEXT_NULL));
  ret = aclrtGetCurrentContext(&curContext);
  EXPECT_EQ(ret, ACL_ERROR_RT_CONTEXT_NULL);

  ret = aclrtSetCurrentContext(nullptr);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtDestroyContext(nullptr);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtSetCurrentContext((void *)0x2);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtDestroyContext((void *)0x2);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_stream_normal_withoutHandle) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  aclrtStream stream;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtStreamCreateWithConfig(_,_)).Times(1).WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
  ret = aclrtCreateStreamV2(&stream, NULL);
  EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtStreamCreateWithConfig(_,_)).Times(1).WillOnce(Return(SUCCESS));
  ret = aclrtCreateStreamV2(&stream, NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);
  stream = (aclrtStream)0x01;

  ret = aclrtSynchronizeStream(stream);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtDestroyStream(stream);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtCreateStreamConfigHandle_mmMallocErr) {
  EXPECT_CALL(MmpaStubMock::GetInstance(), mmMalloc(_)).WillOnce(Invoke(mmMalloc_Abnormal_Invoke));
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_EQ(handle, nullptr);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_paramNull) {
  uint32_t priority = 0;
  // handle is Null
  aclError ret = aclrtSetStreamConfigOpt(NULL, ACL_RT_STREAM_PRIORITY,
                                 &priority, sizeof(priority));
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_attrInvalid) {
  uint32_t priority = 0;
  // attr set invalid
  aclError ret = aclrtSetStreamConfigOpt((aclrtStreamConfigHandle *)0x1, (aclrtStreamConfigAttr)(ACL_RT_STREAM_PRIORITY + 1),
                                 &priority, sizeof(priority));
  EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_priority_abnormal) {
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);
  constexpr uint32_t priority_zero = 0;
  constexpr uint32_t priority_nine = 9;
  uint32_t priority = priority_zero;
  aclError ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_PRIORITY,
                                 &priority, 0);
  EXPECT_NE(ret, ACL_SUCCESS);

  priority = priority_nine;
  ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_PRIORITY,
                                 &priority, sizeof(priority));
  EXPECT_NE(ret, ACL_SUCCESS);
  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_priority_normal) {
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);
  uint32_t priority = 0;
  aclError ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_PRIORITY,
                                 &priority, sizeof(priority));
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_workPtr) {
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);
  void* workPtr = reinterpret_cast<void *>(0x0001);
  aclError ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_ADDR_PTR,
                                 &workPtr, 0);
  EXPECT_NE(ret, ACL_SUCCESS);
  EXPECT_NE(handle->workptr, workPtr);

  ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_ADDR_PTR,
                                &workPtr, sizeof(workPtr));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_EQ(handle->workptr, workPtr);
  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_workSize) {
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);
  size_t workSize = 100UL;
  aclError ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_SIZE,
                                 &workSize, 0);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_SIZE,
                                 &workSize, sizeof(workSize));
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtSetStreamConfigOpt_flag) {
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);
  size_t flag = 0;
  aclError ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_FLAG,
                             &flag, 0);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_FLAG,
                                 &flag, sizeof(flag));
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_stream_normal_withHandle) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  aclrtStream stream;
  aclrtStreamConfigHandle *handle = aclrtCreateStreamConfigHandle();
  EXPECT_NE(handle, nullptr);

  void* workPtr = reinterpret_cast<void *>(0x0001);
  size_t workSize = 100UL;
  size_t flag = 0;
  uint32_t priority = 0;
  aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_ADDR_PTR, &workPtr, sizeof(workPtr));
  aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_WORK_SIZE, &workSize, sizeof(workSize));
  aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_FLAG, &flag, sizeof(flag));
  aclrtSetStreamConfigOpt(handle, ACL_RT_STREAM_PRIORITY, &priority, sizeof(priority));
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtStreamCreateWithConfig(_,_)).Times(1).WillOnce(Return(SUCCESS));
  ret = aclrtCreateStreamV2(&stream, handle);
  EXPECT_EQ(ret, ACL_SUCCESS);
  stream = (aclrtStream)(0x01);

  ret = aclrtDestroyStream(stream);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtDestroyStreamConfigHandle(handle);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, acl_stream_unnormal) {
  aclError ret = aclInit(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret =  aclrtDestroyStreamConfigHandle(NULL);
  EXPECT_NE(ret, ACL_SUCCESS);

  uint32_t priority = 0;
  // handle is Null
  ret = aclrtSetStreamConfigOpt(NULL, ACL_RT_STREAM_PRIORITY,
                                 &priority, sizeof(priority));
  EXPECT_NE(ret, ACL_SUCCESS);
  // attr set invalid
  ret = aclrtSetStreamConfigOpt((aclrtStreamConfigHandle *)0x1, (aclrtStreamConfigAttr)(ACL_RT_STREAM_PRIORITY + 1),
                                 &priority, sizeof(priority));
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtCreateStreamV2(NULL, NULL);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtSynchronizeStream(NULL);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtSynchronizeStream((void *)0x2);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtDestroyStream(NULL);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtDestroyStream((void *)0x2);
  EXPECT_NE(ret, ACL_SUCCESS);

  ret = aclrtResetDevice(0);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclFinalize();
  EXPECT_EQ(ret, ACL_SUCCESS);
}

void CallBackFuncStub(void *arg) {
  (void)arg;
  int a = 1;
  a++;
}

TEST_F(AclRtTest, callback_aclrtSubscribeReportTest) {
  aclError ret;
  aclrtStream stream = (aclrtStream)0x01;
  uint64_t threadId = 1;

  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtSubscribeReport(_, _))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  ret = aclrtSubscribeReport(threadId, stream);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);

  stream = nullptr;
  ret = aclrtSubscribeReport(threadId, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, callback_aclrtUnSubscribeReportTest) {
  uint64_t threadId = 1;
  aclrtStream stream = (aclrtStream)0x01;

  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtUnSubscribeReport(_, _))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  aclError ret = aclrtUnSubscribeReport(threadId, stream);
  EXPECT_EQ(ret, ACL_SUCCESS);

  stream = nullptr;
  ret = aclrtUnSubscribeReport(threadId, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}


TEST_F(AclRtTest, aclrtLaunchCallback_paramInvalid) {
  aclrtStream stream = (aclrtStream)0x01;
  void *userData = nullptr;

  // 1. invalid blockType
  aclrtCallbackBlockType blockType = static_cast<aclrtCallbackBlockType>(2);
  aclError ret = aclrtLaunchCallback(CallBackFuncStub, userData, blockType, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  // 2. stream is NULL
  stream = nullptr;
  blockType = ACL_CALLBACK_NO_BLOCK;
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtCallbackLaunch(_, _, _, _))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  ret = aclrtLaunchCallback(CallBackFuncStub, userData, blockType, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtLaunchCallback_normal) {
  aclrtStream stream = (aclrtStream)0x01;
  void *userData = nullptr;

  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtCallbackLaunch(_, _, _, _))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_RT_SUCCESS));

  aclrtCallbackBlockType blockType = ACL_CALLBACK_BLOCK;
  aclError ret = aclrtLaunchCallback(CallBackFuncStub, userData, blockType, stream);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);

  blockType = ACL_CALLBACK_NO_BLOCK;
  ret = aclrtLaunchCallback(CallBackFuncStub, userData, blockType, stream);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(AclRtTest, callback_aclrtProcessReportTest) {
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtProcessReport(_))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  int32_t timeout = -1;
  aclError ret = aclrtProcessReport(timeout);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);

  ret = aclrtProcessReport(timeout);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, hostfunc_aclrtSubscribeHostFuncTest) {
  aclError ret;
  aclrtStream stream = (aclrtStream)0x01;
  uint64_t threadId = 1;

  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtSubscribeHostFunc(_, _))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  ret = aclrtSubscribeHostFunc(threadId, stream);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);

  stream = nullptr;
  ret = aclrtSubscribeHostFunc(threadId, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, hostfunc_aclrtUnSubscribeHostFuncTest) {
  uint64_t threadId = 1;
  aclrtStream stream = (aclrtStream)0x01;

  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtUnSubscribeHostFunc(_, _))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));

  aclError ret = aclrtUnSubscribeHostFunc(threadId, stream);
  EXPECT_EQ(ret, ACL_SUCCESS);

  stream = nullptr;
  ret = aclrtUnSubscribeHostFunc(threadId, stream);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, hostfunc_aclrtProcessHostFuncTest) {
  EXPECT_CALL(RuntimeStubMock::GetInstance(), rtProcessHostFunc(_))
      .WillOnce(Return(ACL_RT_SUCCESS))
      .WillOnce(Return(ACL_ERROR_INVALID_PARAM));
  int32_t timeout = -1;
  aclError ret = aclrtProcessHostFunc(timeout);
  EXPECT_EQ(ret, ACL_RT_SUCCESS);

  ret = aclrtProcessHostFunc(timeout);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, acl_GetRecentErrMsg) {
  REPORT_INPUT_ERROR(INVALID_NULL_POINTER_MSG, ARRAY(const_cast<char *>("param")), ARRAY(const_cast<char *>("datatest")));
  const char *message = aclGetRecentErrMsg();
  ASSERT_STREQ(message, "EH0002: Argument [datatest] must not be NULL.\r\n"
               "        Solution: Try again with a correct pointer argument.\r\n");
  message = aclGetRecentErrMsg();
  ASSERT_STREQ(message, NULL); 
}

TEST_F(AclRtTest, aclrtMalloc_sizeInvalid) {
  void *devPtr = nullptr;
  size_t size = static_cast<size_t>(-1);
  aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  size = static_cast<size_t>(0);
  ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMalloc_devPtrInvalid) {
  aclError ret = aclrtMalloc(NULL, 1, ACL_MEM_MALLOC_HUGE_FIRST);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMalloc_policyNotSupported) {
  void *devPtr = nullptr;
  size_t size = 1;
  // not support p2p scenes.
  aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
  EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
  ret = aclrtMalloc(&devPtr, size, (aclrtMemMallocPolicy)(ACL_MEM_TYPE_HIGH_BAND_WIDTH | ACL_MEM_MALLOC_NORMAL_ONLY_P2P));
  EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(AclRtTest, aclrtMalloc_policyInvalid) {
  void *devPtr = nullptr;
  size_t size = 1;
  aclError ret = aclrtMalloc(&devPtr, size, (aclrtMemMallocPolicy)0xffff);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMalloc_normal_singlePageType) {
  void *devPtr = nullptr;
  size_t size = 1;
  aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtFree(devPtr);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtMalloc_normal_singleMemoryType) {
  void *devPtr = nullptr;
  size_t size = 1;
  // memory type is DDR
  aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_TYPE_HIGH_BAND_WIDTH);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtFree(devPtr);
  EXPECT_EQ(ret, ACL_SUCCESS);

  // memory type is HBM
  ret = aclrtMalloc(&devPtr, size, ACL_MEM_TYPE_LOW_BAND_WIDTH);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtFree(devPtr);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtMalloc_normal_mixedMemoryType) {
  void *devPtr = nullptr;
  size_t size = 1;
  // policy contain both low and high width type, warn!.
  aclError ret = aclrtMalloc(&devPtr, size, (aclrtMemMallocPolicy)(ACL_MEM_TYPE_HIGH_BAND_WIDTH | ACL_MEM_TYPE_LOW_BAND_WIDTH));
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtFree(devPtr);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, memory_free_device) {
  void *devPtr = reinterpret_cast<void *>(0x01);
  aclError ret = aclrtFree(NULL);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
  ret = aclrtMalloc(&devPtr, 1, ACL_MEM_MALLOC_HUGE_ONLY);
  EXPECT_EQ(ret, ACL_SUCCESS);
  ret = aclrtFree(devPtr);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtMemSet_paramInvalid) {
    // 1. devPtr is NULL
    aclError ret = aclrtMemset(NULL, 1, 1, 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    // 2. param count > maxCount
    void *ptr = reinterpret_cast<void *>(0x01);
    constexpr size_t VALUE_MEMORY_COUNT = 2;
    size_t VALUE = 1;
    constexpr size_t DST_MEMORY_MAXCOUNT = 1;
    ret = aclrtMemset(ptr, DST_MEMORY_MAXCOUNT, VALUE, VALUE_MEMORY_COUNT);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMemSet_normal) {
    void *ptr = reinterpret_cast<void *>(0x01);
    aclError ret = aclrtMemset(ptr, 1, 1, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtMemcpy_paramNULL) {
  void *src = reinterpret_cast<void *>(0X02);
  aclError ret = aclrtMemcpy(NULL, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

  void *dst = reinterpret_cast<void *>(0X01);
  ret = aclrtMemcpy(dst, 1, NULL, 1, ACL_MEMCPY_HOST_TO_HOST);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMemcpy_kindInvalid) {
  void *dst = reinterpret_cast<void *>(0X01);
  void *src = reinterpret_cast<void *>(0X02);
  aclError ret = aclrtMemcpy(dst, 1, src, 1, (aclrtMemcpyKind)0x7FFFFFFFF);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMemcpy_countInvalid) {
  void *dst = reinterpret_cast<void *>(0X01);
  void *src = reinterpret_cast<void *>(0X02);
  // count is greater than destMax
  aclError  ret = aclrtMemcpy(dst, 1, src, 2, ACL_MEMCPY_HOST_TO_HOST);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtMemcpy_normal_ToHost) {
  void *dst = reinterpret_cast<void *>(0X01);
  void *src = reinterpret_cast<void *>(0X02);
  aclError ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_HOST);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtMemcpy_normal_ToDevice) {
  void *dst = reinterpret_cast<void *>(0X01);
  void *src = reinterpret_cast<void *>(0X02);
  aclError ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE);
  EXPECT_EQ(ret, ACL_SUCCESS);

  ret = aclrtMemcpy(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE);
  EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(AclRtTest, aclrtGetMemInfo_ParamNULL) {
  size_t free;
  aclError ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, NULL);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
  size_t total;
  ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, NULL, &total);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclRtTest, aclrtGetMemInfo_attrInvalid) {
  size_t free;
  size_t total;
  aclError ret = aclrtGetMemInfo((aclrtMemAttr)0x1000, &free, &total);
  EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_MEMORY_TYPE);
}

TEST_F(AclRtTest, aclrtGetMemInfo_normal) {
  size_t free;
  size_t total;
  aclError ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
  EXPECT_EQ(ret, ACL_SUCCESS);
}