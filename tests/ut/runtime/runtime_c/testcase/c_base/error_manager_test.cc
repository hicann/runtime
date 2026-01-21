/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <string.h>
#include <pthread.h>
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "vector.h"
#include "error_manager.h"

using namespace testing;

class UtestErrManagerTest : public testing::Test {
 protected:
  void SetUp() {
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

void *ThreadFunc(void *arg) {
  ReportInterErrMessage("E19999", "This is an inner error!");
  (void)GetErrorMessage();
  return nullptr;
}

TEST_F(UtestErrManagerTest, ReportInterErrMessage) {
  // 测试error_code不是内部错误码，返回-1
  ReportInterErrMessage("errcode", "errmsg");
  ReportInterErrMessage("60000", "This is an inner error!");

  pthread_t threadId;
  int ret = pthread_create(&threadId, nullptr, ThreadFunc, nullptr);
  if (ret != 0) {
    printf("create thread failed, err = %d\n", ret);
  }
  pthread_join(threadId, nullptr);

  // 内部错误码正常上报， GetErrorMessage返回正确的拼接格式，并且会清空当前线程上报的所有信息。
  ReportInterErrMessage("E19999", "This is an inner error!");
  char *errmsg1 = GetErrorMessage();
  ASSERT_STREQ(errmsg1, "E19999: Inner Error!\r\nThis is an inner error!\r\n");

  REPORT_INNER_ERROR("E29999", "Param input.size():%zu < %zu, check invalid", 5, 6);
  char *errmsg2 = GetErrorMessage();
  char *errmsg3 = GetErrorMessage();
  ASSERT_STREQ(errmsg3, NULL);

  // 覆盖EmplaceVector失败场景
  MOCKER(EmplaceBackVector).stubs().will(returnValue((void *)NULL));
  ReportInterErrMessage("E19999", "This is an inner error!");

  MOCKER(memcpy_s).stubs().will(returnValue(EINVAL));
  ReportInterErrMessage("E19999", "This is an inner error!");
  errmsg3 = GetErrorMessage();
  ASSERT_STREQ(errmsg3, NULL);

  MOCKER(malloc).stubs().will(returnValue((void *)NULL));
  ReportInterErrMessage("E19999", "This is an inner error!");
}

TEST_F(UtestErrManagerTest, ReportErrMessage) {
  // 非模板中的错误码
  REPORT_INPUT_ERROR("60000", ARRAY("value1", "value2"), ARRAY("34", "56"));
  // 模板argList跟用户传入的arglist不匹配
  REPORT_INPUT_ERROR("EH0001", ARRAY("vale","parm","reason"), ARRAY("ll", "lll", "lll"));
  REPORT_INPUT_ERROR("EH0002", ARRAY("param2"), ARRAY("ll"));

  // 外部错误码正常上报——模板里argList跟用户传入arglist一一匹配
  REPORT_INPUT_ERROR("EH0001", ARRAY("value","param","reason"), ARRAY("25", "x", "The value is too small"));
  REPORT_INPUT_ERROR("EH0002", ARRAY("param"), ARRAY("ll"));
  // 外部错误码正常上报，用户传入arglist比模板多一个参数, "reason"模板argList没有
  REPORT_INPUT_ERROR("EH0003", ARRAY("path", "reason", "value"), ARRAY("./a.text", "cannot find", "100"));
  char* errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, "EH0001: Value [25] for [x] is invalid. Reason: The value is too small.\r\n"
               "        TraceBack (most recent call last):\r\n"
               "        Argument [ll] must not be NULL.\r\n"
               "        Path [./a.text] is invalid. Reason: cannot find.\r\n");

  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg,
      "EK0201: Failed to allocate host memory for Profiling: 100.\r\n"
      "        PossibleCause: Available memory is insufficient.\r\n"
      "        Solution: Close unused applications.\r\n");

  // 覆盖EmplaceVector失败场景
  MOCKER(memcpy_s).stubs().will(returnValue(EINVAL));
  REPORT_INPUT_ERROR("EH0001", ARRAY("value","param","reason"), ARRAY("25", "x", "The value is too small"));
  errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);

  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnValue(-1));
  REPORT_INPUT_ERROR("EH0001", ARRAY("value", "param", "reason"), ARRAY("25", "x", "The value is too small"));

  char *ret = nullptr;
  char *(*strstr_ptr)(char *, const char *) = strstr;
  MOCKER(strstr_ptr).stubs().will(returnValue(ret));
  REPORT_INPUT_ERROR("EH0001", ARRAY("value", "param", "reason"), ARRAY("25", "x", "The value is too small"));
}

TEST_F(UtestErrManagerTest, GetErrorMessage) {
  char* errmsg1 = GetErrorMessage();
  ASSERT_STREQ(errmsg1, NULL);
  ReportInterErrMessage("E29999", "Param input.size() < minsize, check invalid");
  REPORT_INPUT_ERROR("E19001", ARRAY("errMsg", "redundancy", "file"), ARRAY("The file is corrupted", "this is test information", "a.cc"));
  ReportInterErrMessage("E19999", "This is an inner error!");
  REPORT_INPUT_ERROR("EH0001", ARRAY("value","param","reason"), ARRAY("25", "x", "The value is too small"));
  REPORT_INPUT_ERROR("EH0002", ARRAY("param"), ARRAY("ll"));
  char* errmsg2 = GetErrorMessage();
  ASSERT_STREQ(errmsg2, "E19001: Failed to open file[a.cc]. Reason: The file is corrupted.\r\n"
               "        Solution: Fix the error according to the error message.\r\n"
               "        TraceBack (most recent call last):\r\n"
               "        Param input.size() < minsize, check invalid\r\n"
               "        This is an inner error!\r\n"
               "        Value [25] for [x] is invalid. Reason: The value is too small.\r\n"
               "        Argument [ll] must not be NULL.\r\n");
  char* errmsg3 = GetErrorMessage();
  ASSERT_STREQ(errmsg3, NULL);
}

void *ThreadFunction(void *arg) {
  char *errmsg = GetErrorMessage();
  return (void *)errmsg;
}

TEST_F(UtestErrManagerTest, GetErrorMessageErrorThreadNull) {
  pthread_t threadId;
  char *param;
  int ret = pthread_create(&threadId, nullptr, ThreadFunction, nullptr);
  if (ret != 0) {
    printf("create thread failed, err = %d\n", ret);
  }
  pthread_join(threadId, (void **)&param);
  ASSERT_STREQ(param, nullptr);
}

void *ThreadFuncForInterInit(void *arg) {
  ReportInterErrMessage("E19999", "This is an inner error!");
  char *errmsg = GetErrorMessage();
  return (void *)errmsg;
}

TEST_F(UtestErrManagerTest, ReportInterErrMessageInitMallocNull) {
  MOCKER(malloc).stubs().will(returnValue((void *)NULL));
  pthread_t threadId;
  char *param;
  int ret = pthread_create(&threadId, nullptr, ThreadFuncForInterInit, nullptr);
  if (ret != 0) {
    printf("create thread failed, err = %d\n", ret);
  }
  pthread_join(threadId, (void **)&param);
  ASSERT_STREQ(param, nullptr);
}

void *ThreadFuncForOutMsgInit(void *arg) {
  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  char *errmsg = GetErrorMessage();
  return (void *)errmsg;
}

TEST_F(UtestErrManagerTest, ReportErrMessageInitMallocNull) {
  MOCKER(malloc).stubs().will(returnValue((void *)NULL));
  pthread_t threadId;
  char *param;
  int ret = pthread_create(&threadId, nullptr, ThreadFuncForOutMsgInit, nullptr);
  if (ret != 0) {
    printf("create thread failed, err = %d\n", ret);
  }
  pthread_join(threadId, (void **)&param);
  ASSERT_STREQ(param, nullptr);
}

TEST_F(UtestErrManagerTest, ReportErrMessageMallocFormatNull) {
  MOCKER(malloc).stubs().will(returnValue((void *)NULL));
  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, ReportErrMessageMallocErrMsgNull) {
  char *errcode = (char *)malloc(1);
  MOCKER(malloc).stubs().will(returnValue((void *)errcode)).then(returnValue((void *)NULL));
  ReportInterErrMessage("E19999", "This is an inner error!");
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, ReportInnerAndOuterMessageAbnormal) {
  ReportInterErrMessage("E19999", "This is an inner error!");
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnValue(-1));
  char *errmsg1 = GetErrorMessage();
  ASSERT_STREQ(errmsg1, NULL);

  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  MOCKER(malloc).stubs().will(returnValue((void *)NULL));
  char *errmsg2 = GetErrorMessage();
  ASSERT_STREQ(errmsg2, NULL);
}

TEST_F(UtestErrManagerTest, GetErrorMessageSprintfsOutErrMsg1Abnormal) {
  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnValue(-1));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, GetErrorMessageSprintfsOutErrMsg2Abnormal) {
  REPORT_INPUT_ERROR("EK0201", ARRAY("buf_size"), ARRAY("100"));
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnObjectList(1, -1));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, GetErrorMessageSprintfsOutErrMsg3Abnormal) {
  REPORT_INPUT_ERROR("EH0001", ARRAY("value", "param", "reason"), ARRAY("25", "x", "The value is too small"));
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnObjectList(1, 1, -1));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, GetErrorMessageSprintfsOutErrMsg4Abnormal) {
  REPORT_INPUT_ERROR("EH0001", ARRAY("value", "param", "reason"), ARRAY("25", "x", "The value is too small"));
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnObjectList(1, 1, 1, -1));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}

TEST_F(UtestErrManagerTest, GetErrorMessageSprintfsOutErrMsg5Abnormal) {
  REPORT_INPUT_ERROR("EH0001", ARRAY("value", "param", "reason"), ARRAY("25", "x", "The value is too small"));
  MOCKER((int (*)(char *, long unsigned int, const char *))sprintf_s).stubs().will(returnObjectList(1, 1, 1, 1, -1));
  char *errmsg = GetErrorMessage();
  ASSERT_STREQ(errmsg, NULL);
}