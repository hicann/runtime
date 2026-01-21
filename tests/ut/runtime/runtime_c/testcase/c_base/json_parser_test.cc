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
#include <memory>
#include <fstream>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include "securec.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_linux.h"
#include "json_parser.h"

using namespace testing;

class UtestJsonParseTest : public testing::Test {
 protected:
  void SetUp() {
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNull) {
  const char *json = "null";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsNull(jsonObj));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicTrue) {
  const char *json = "true";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsBool(jsonObj));
  ASSERT_TRUE(GetCJsonBool(jsonObj));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicFalse) {
  const char *json = "false";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsBool(jsonObj));
  ASSERT_FALSE(GetCJsonBool(jsonObj));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber) {
  const char *json = "123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsInt(jsonObj));
  EXPECT_EQ(GetCJsonInt(jsonObj), 123);
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber1) {
  const char *json = "-123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsInt(jsonObj));
  EXPECT_EQ(GetCJsonInt(jsonObj), -123);
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber2) {
  const char *json = "+123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsInt(jsonObj));
  EXPECT_EQ(GetCJsonInt(jsonObj), 123);
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber3) {
  const char *json = "1.23";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  EXPECT_EQ(GetCJsonDouble(jsonObj), 1.23);
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber4) {
  const char *json = "1.23e-2";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > 0.0122) && (value < 0.0124)));
  FreeCJsonObj(jsonObj);
}


TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber5) {
  const char *json = "1.23e2";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > 122) && (value < 124)));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber6) {
  const char *json = "1.23E2";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > 122) && (value < 124)));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber7) {
  const char *json = "-123.0";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > -124) && (value < -122)));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber8) {
  const char *json = "+123.0";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > 122.0) && (value < 124.0)));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicNumber9) {
  const char *json = " 123.0";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsDouble(jsonObj));
  double value = GetCJsonDouble(jsonObj);
  EXPECT_TRUE(((value > 122.0) && (value < 124.0)));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString) {
  const char *json = "\"123\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "123");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_b) {
  const char *json = "\"\\b\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\b");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_f) {
  const char *json = "\"\\f\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\f");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_n) {
  const char *json = "\"\\n\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\n");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_r) {
  const char *json = "\"\\r\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\r");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_t) {
  const char *json = "\"\\t\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\t");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString2) {
  const char *json = "\"\\123\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString3) {
  const char *json = "\"\\\"123\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObj));
  ASSERT_STREQ(GetCJsonString(jsonObj), "\"123");
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicInvalid0) {
  const char *json = "123\"";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicInvalid1) {
  const char *json = "[123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));

  MOCKER(EmplaceBackVector).stubs().will(returnValue((void *)nullptr));
  CJsonObj *jsonObj1 = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj1 == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicInvalid2) {
  const char *json = "{123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicInvalid3) {
  const char *json = "\\123";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicObj) {
  const char *json = "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsObj(jsonObj));
  CJsonObj *jsonObjValue = GetCJsonSubObj(jsonObj, "a");
  ASSERT_TRUE((jsonObjValue != nullptr));
  ASSERT_TRUE(CJsonIsBool(jsonObjValue));
  ASSERT_TRUE(GetCJsonBool(jsonObjValue));

  jsonObjValue = GetCJsonSubObj(jsonObj, "b");
  ASSERT_TRUE((jsonObjValue != nullptr));
  ASSERT_TRUE(CJsonIsBool(jsonObjValue));
  ASSERT_FALSE(GetCJsonBool(jsonObjValue));

  jsonObjValue = GetCJsonSubObj(jsonObj, "c");
  ASSERT_TRUE((jsonObjValue != nullptr));
  ASSERT_TRUE(CJsonIsInt(jsonObjValue));
  ASSERT_EQ(GetCJsonInt(jsonObjValue), 123);

  jsonObjValue = GetCJsonSubObj(jsonObj, "d");
  ASSERT_TRUE((jsonObjValue != nullptr));
  ASSERT_TRUE(CJsonIsString(jsonObjValue));
  ASSERT_STREQ(GetCJsonString(jsonObjValue), "123");

  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicObjInvalid) {
  const char *json = "{\"a\" : true; \"b\" : false, \"c\" : 123, \"d\" : \"123\"}";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));

  MOCKER(EmplaceSortVector).stubs().will(returnValue((void *)nullptr));
  CJsonObj *jsonObj1 = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj1 == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicObjInvalid1) {
  const char *json = "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\",}";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicArray) {
  const char *json = "[0, 1, 2]";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsArray(jsonObj));
  ASSERT_EQ(GetCJsonArraySize(jsonObj), 3);

  for (int i = 0; i < 3; i++) {
    CJsonObj *jsonObjValue = CJsonArrayAt(jsonObj, i);
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsInt(jsonObjValue));
    ASSERT_EQ(GetCJsonInt(jsonObjValue), i);
  }

  CJsonObj *jsonObjValue = CJsonArrayAt(jsonObj, 4);
  ASSERT_TRUE((jsonObjValue == nullptr));

  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicArrayObj) {
  const char *json = "[{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsArray(jsonObj));
  ASSERT_EQ(GetCJsonArraySize(jsonObj), 3);

  for (int i = 0; i < 3; i++) {
    CJsonObj *jsonObjIt = CJsonArrayAt(jsonObj, i);
    CJsonObj *jsonObjValue = GetCJsonSubObj(jsonObjIt, "a");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsBool(jsonObjValue));
    ASSERT_TRUE(GetCJsonBool(jsonObjValue));

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "b");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsBool(jsonObjValue));
    ASSERT_FALSE(GetCJsonBool(jsonObjValue));

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "c");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsInt(jsonObjValue));
    ASSERT_EQ(GetCJsonInt(jsonObjValue), 123);

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "d");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsString(jsonObjValue));
    ASSERT_STREQ(GetCJsonString(jsonObjValue), "123");
  }

  CJsonObj *jsonObjValue = CJsonArrayAt(jsonObj, 4);
  ASSERT_TRUE((jsonObjValue == nullptr));

  FreeCJsonObj(jsonObj);
}


TEST_F(UtestJsonParseTest, JsonParseCaseBasicObjArray) {
  const char *json = "{\"a\" : [0, 1, 2]}";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsObj(jsonObj));
  CJsonObj *jsonObjValue = GetCJsonSubObj(jsonObj, "a");
  ASSERT_TRUE((jsonObjValue != nullptr));

  ASSERT_TRUE(CJsonIsArray(jsonObjValue));
  ASSERT_EQ(GetCJsonArraySize(jsonObjValue), 3);

  for (int i = 0; i < 3; i++) {
    CJsonObj *jsonObjIt = CJsonArrayAt(jsonObjValue, i);
    ASSERT_TRUE((jsonObjIt != nullptr));
    ASSERT_TRUE(CJsonIsInt(jsonObjIt));
    ASSERT_EQ(GetCJsonInt(jsonObjIt), i);
  }

  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFile) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  CJsonObj *jsonObj = CJsonFileParse(filePath);
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsObj(jsonObj));
  CJsonObj *jsonObjA1 = GetCJsonSubObj(jsonObj, "a");
  ASSERT_TRUE((jsonObjA1 != nullptr));

  ASSERT_TRUE(CJsonIsArray(jsonObjA1));
  ASSERT_EQ(GetCJsonArraySize(jsonObjA1), 3);

  for (int i = 0; i < 3; i++) {
    CJsonObj *jsonObjIt = CJsonArrayAt(jsonObjA1, i);
    CJsonObj *jsonObjValue = GetCJsonSubObj(jsonObjIt, "a");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsBool(jsonObjValue));
    ASSERT_TRUE(GetCJsonBool(jsonObjValue));

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "b");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsBool(jsonObjValue));
    ASSERT_FALSE(GetCJsonBool(jsonObjValue));

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "c");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsInt(jsonObjValue));
    ASSERT_EQ(GetCJsonInt(jsonObjValue), 123);

    jsonObjValue = GetCJsonSubObj(jsonObjIt, "d");
    ASSERT_TRUE((jsonObjValue != nullptr));
    ASSERT_TRUE(CJsonIsString(jsonObjValue));
    ASSERT_STREQ(GetCJsonString(jsonObjValue), "123");
  }

  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonKey) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  size_t offset;
  size_t len = CJsonParseKeyPosition(json, strlen(json), "a", &offset);
  ASSERT_EQ(offset, 7);
  ASSERT_EQ(len, strlen("[{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                        "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                        "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]"));
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKey) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "a");
  ASSERT_TRUE((subJson != nullptr));
  ASSERT_STREQ(subJson, "[{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]");
  free(subJson);
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKey1) {
  const char *json = "{\"a\" : 123, \"b\": [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "a");
  ASSERT_TRUE((subJson != nullptr));
  ASSERT_STREQ(subJson, "123");
  free(subJson);

  subJson = CJsonFileParseKey(filePath, "b");
  ASSERT_TRUE((subJson != nullptr));
  ASSERT_STREQ(subJson, "[{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                      "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]");
  free(subJson);
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKeyFail) {
  const char *json = "{\"a\" : 123, \"b\": [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false; \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "a");
  ASSERT_TRUE((subJson == nullptr));

  subJson = CJsonFileParseKey(filePath, "b");
  ASSERT_TRUE((subJson == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKeyFail0) {
  const char *json = "null";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "null");
  ASSERT_TRUE((subJson == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKeyFail1) {
  const char *json = "123";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "123");
  ASSERT_TRUE((subJson == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseJsonFileKeyFail2) {
  const char *json = "\"123\"";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *subJson = CJsonFileParseKey(filePath, "123");
  ASSERT_TRUE((subJson == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicString_abnormal) {
  const char *json = "\"123\"";
  MOCKER(memcpy_s).stubs().will(returnValue(-1));
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}

TEST_F(UtestJsonParseTest, JsonParseCaseBasicObjArray_abnormal) {
  const char *json = "{\"a\" : [0, 1, 2]}";
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj != nullptr));
  ASSERT_TRUE(CJsonIsObj(jsonObj));
  MOCKER(SortVectorAtKey).stubs().will(returnValue((void *)nullptr));
  CJsonObj *jsonObjValue = GetCJsonSubObj(jsonObj, "a");
  ASSERT_TRUE((jsonObjValue == nullptr));
  FreeCJsonObj(jsonObj);
}

TEST_F(UtestJsonParseTest, CJsonFileParse_mmRealPath_Abnormal) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char *path = nullptr;
  MOCKER(realpath).stubs().will(returnValue(path));
  CJsonObj *jsonObj = CJsonFileParse(filePath);
  ASSERT_TRUE(jsonObj == nullptr);
}

TEST_F(UtestJsonParseTest, CJsonFileParse_mmOpenFile_Abnormal) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  mmFileHandle *fd = nullptr;
  MOCKER(fopen).stubs().will(returnValue(fd));
  CJsonObj *jsonObj = CJsonFileParse(filePath);
  ASSERT_TRUE(jsonObj == nullptr);
}

TEST_F(UtestJsonParseTest, CJsonFileParse_mmMalloc_Abnormal) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                                "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  char resolvedPath[PATH_MAX];
  int32_t ret = mmRealPath(filePath, resolvedPath, PATH_MAX);
  mmFileHandle *fd = mmOpenFile(resolvedPath, FILE_READ);
  MOCKER(fopen).stubs().will(returnValue(fd));
  MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
  CJsonObj *jsonObj = CJsonFileParse(filePath);
  ASSERT_TRUE(jsonObj == nullptr);
}

int MemcpyStub(void *dest, int destMax, const void *src, int count) {
  (void)memcpy(dest, src, count);
  return 0;
}

int MemcpyStubFail(void *dest, int destMax, const void *src, int count) {
  return -1;
}

TEST_F(UtestJsonParseTest, CJsonFileParseKey_Memcpy_s_Abnormal) {
  const char *json = "{\"a\" : [{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                    "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]}";
  const char *filePath = "test.json";
  std::ofstream stream(filePath);
  stream << json;
  stream.close();

  // invoke in will not effect.
  MOCKER(memcpy_s).stubs().will(invoke(MemcpyStub)).then(invoke(MemcpyStub)).then(invoke(MemcpyStubFail));
  char *subJson = CJsonFileParseKey(filePath, "a");
  ASSERT_TRUE((subJson == nullptr));
}

TEST_F(UtestJsonParseTest, CJsonParse_mmMalloc_2_Abnormal) {
  const char *json = "\"123\"";
  char *obj = (char *)malloc(sizeof(CJsonObj));
  MOCKER(malloc).stubs().will(returnValue((void *)obj)).then(returnValue((void *)nullptr));
  CJsonObj *jsonObj = CJsonParse(json, strlen(json));
  ASSERT_TRUE((jsonObj == nullptr));
}