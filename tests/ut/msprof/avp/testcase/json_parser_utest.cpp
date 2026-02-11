/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "json/json_parser.h"
#include "json/json_generator.h"
#include "securec.h"
#include "osal/osal_mem.h"
#include "logger/logger.h"

class JsonParserUtest : public testing::Test {
protected:
    void SetUp()
    {}

    void TearDown()
    {}
};

TEST_F(JsonParserUtest, JsonParseCaseBasicNull)
{
    const char *json = "null";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsNull(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicTrue)
{
    const char *json = "true";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsBool(jsonObj));
    ASSERT_TRUE(GetJsonBool(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicFalse)
{
    const char *json = "false";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsBool(jsonObj));
    ASSERT_FALSE(GetJsonBool(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicNumber)
{
    const char *json = "123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsInt(jsonObj));
    EXPECT_EQ(GetJsonInt(jsonObj), 123);
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicNumber1)
{
    const char *json = "-123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsInt(jsonObj));
    EXPECT_EQ(GetJsonInt(jsonObj), -123);
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicNumber2)
{
    const char *json = "+123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsInt(jsonObj));
    EXPECT_EQ(GetJsonInt(jsonObj), 123);
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicNumber3)
{
    const char *json = "1.23";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsDouble(jsonObj));
    EXPECT_EQ(GetJsonDouble(jsonObj), 1.23);
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicString)
{
    const char *json = "\"123\"";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsString(jsonObj));
    ASSERT_STREQ(GetJsonString(jsonObj), "123");
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicString2)
{
    const char *json = "\"\\123\"";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicString3)
{
    const char *json = "\"\\\"123\"";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsString(jsonObj));
    ASSERT_STREQ(GetJsonString(jsonObj), "\"123");
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicInvalid0)
{
    const char *json = "123\"";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicInvalid1)
{
    const char *json = "[123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicInvalid2)
{
    const char *json = "{123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicInvalid3)
{
    const char *json = "\\123";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicObj)
{
    const char *json = "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsObj(jsonObj));
    JsonObj *jsonObjValue = GetJsonSubObj(jsonObj, "a");
    ASSERT_TRUE((jsonObjValue != NULL));
    ASSERT_TRUE(JsonIsBool(jsonObjValue));
    ASSERT_TRUE(GetJsonBool(jsonObjValue));

    jsonObjValue = GetJsonSubObj(jsonObj, "b");
    ASSERT_TRUE((jsonObjValue != NULL));
    ASSERT_TRUE(JsonIsBool(jsonObjValue));
    ASSERT_FALSE(GetJsonBool(jsonObjValue));

    jsonObjValue = GetJsonSubObj(jsonObj, "c");
    ASSERT_TRUE((jsonObjValue != NULL));
    ASSERT_TRUE(JsonIsInt(jsonObjValue));
    ASSERT_EQ(GetJsonInt(jsonObjValue), 123);

    jsonObjValue = GetJsonSubObj(jsonObj, "d");
    ASSERT_TRUE((jsonObjValue != NULL));
    ASSERT_TRUE(JsonIsString(jsonObjValue));
    ASSERT_STREQ(GetJsonString(jsonObjValue), "123");

    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicObjInvalid)
{
    const char *json = "{\"a\" : true; \"b\" : false, \"c\" : 123, \"d\" : \"123\"}";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicObjInvalid1)
{
    const char *json = "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\",}";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj == NULL));
}

TEST_F(JsonParserUtest, JsonParseCaseBasicArray)
{
    const char *json = "[0, 1, 2]";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsArray(jsonObj));
    ASSERT_EQ(GetJsonArraySize(jsonObj), 3);

    for (int i = 0; i < 3; i++) {
        JsonObj *jsonObjValue = JsonArrayAt(jsonObj, i);
        ASSERT_TRUE((jsonObjValue != NULL));
        ASSERT_TRUE(JsonIsInt(jsonObjValue));
        ASSERT_EQ(GetJsonInt(jsonObjValue), i);
    }

    JsonObj *jsonObjValue = JsonArrayAt(jsonObj, 4);
    ASSERT_TRUE((jsonObjValue == NULL));

    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicArrayObj)
{
    const char *json = "[{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                       "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}, "
                       "{\"a\" : true, \"b\" : false, \"c\" : 123, \"d\" : \"123\"}]";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsArray(jsonObj));
    ASSERT_EQ(GetJsonArraySize(jsonObj), 3);

    for (int i = 0; i < 3; i++) {
        JsonObj *jsonObjIt = JsonArrayAt(jsonObj, i);
        JsonObj *jsonObjValue = GetJsonSubObj(jsonObjIt, "a");
        ASSERT_TRUE((jsonObjValue != NULL));
        ASSERT_TRUE(JsonIsBool(jsonObjValue));
        ASSERT_TRUE(GetJsonBool(jsonObjValue));

        jsonObjValue = GetJsonSubObj(jsonObjIt, "b");
        ASSERT_TRUE((jsonObjValue != NULL));
        ASSERT_TRUE(JsonIsBool(jsonObjValue));
        ASSERT_FALSE(GetJsonBool(jsonObjValue));

        jsonObjValue = GetJsonSubObj(jsonObjIt, "c");
        ASSERT_TRUE((jsonObjValue != NULL));
        ASSERT_TRUE(JsonIsInt(jsonObjValue));
        ASSERT_EQ(GetJsonInt(jsonObjValue), 123);

        jsonObjValue = GetJsonSubObj(jsonObjIt, "d");
        ASSERT_TRUE((jsonObjValue != NULL));
        ASSERT_TRUE(JsonIsString(jsonObjValue));
        ASSERT_STREQ(GetJsonString(jsonObjValue), "123");
    }

    JsonObj *jsonObjValue = JsonArrayAt(jsonObj, 4);
    ASSERT_TRUE((jsonObjValue == NULL));

    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, JsonParseCaseBasicObjArray)
{
    const char *json = "{\"a\" : [0, 1, 2]}";
    JsonObj *jsonObj = JsonParse(json);
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsObj(jsonObj));
    JsonObj *jsonObjValue = GetJsonSubObj(jsonObj, "a");
    ASSERT_TRUE((jsonObjValue != NULL));

    ASSERT_TRUE(JsonIsArray(jsonObjValue));
    ASSERT_EQ(GetJsonArraySize(jsonObjValue), 3);

    for (int i = 0; i < 3; i++) {
        JsonObj *jsonObjIt = JsonArrayAt(jsonObjValue, i);
        ASSERT_TRUE((jsonObjIt != NULL));
        ASSERT_TRUE(JsonIsInt(jsonObjIt));
        ASSERT_EQ(GetJsonInt(jsonObjIt), i);
    }

    JsonFree(jsonObj);
}
void TestNumber(double expect, char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    EXPECT_EQ(true, JsonIsDouble(jsonObj));
    EXPECT_EQ(expect, GetJsonDouble(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, TestJsonDouble)
{
    TestNumber(0.0, "0.0");
    TestNumber(1.5, "1.5");
    TestNumber(-1.5, "-1.5");
    TestNumber(3.1416, "3.1416");
    TestNumber(999999999999999.0, "999999999999999.0");
    TestNumber(1.0000000000000002, "1.0000000000000002");
}

void TestString(char *expect, char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    EXPECT_EQ(true, JsonIsString(jsonObj));
    EXPECT_EQ(0, strcmp(expect, GetJsonString(jsonObj)));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, TestJsonParseString)
{
    TestString("", "\"\"");
    TestString("Hello", "\"Hello\"");
    TestString("Hello\nWorld", "\"Hello\\nWorld\"");
    TestString("\" \\ / \b \f \n \r \t", "\"\\\" \\\\ \\/ \\b \\f \\n \\r \\t\"");
}

TEST_F(JsonParserUtest, TestJsonParseObject)
{
    JsonObj *obj = JsonParse(" { } ");
    ASSERT_TRUE((obj != NULL));
    ASSERT_TRUE(JsonIsObj(obj));
    JsonFree(obj);

    JsonObj *jsonObj = JsonParse(" { "
                                 "\"n\" : null , "
                                 "\"f\" : false , "
                                 "\"t\" : true , "
                                 "\"i\" : 123 , "
                                 "\"s\" : \"abc\", "
                                 "\"a\" : [ 1, 2, 3 ],"
                                 "\"o\" : { \"1\" : 1, \"2\" : 2, \"3\" : 3 }"
                                 " } ");
    ASSERT_TRUE((jsonObj != NULL));
    ASSERT_TRUE(JsonIsObj(jsonObj));
    JsonFree(jsonObj);
}

void TestInvalid(char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(NULL, jsonObj);
}

TEST_F(JsonParserUtest, TestInvalid)
{
    TestInvalid("nul");
    TestInvalid("");
    TestInvalid(" ");
    TestInvalid("?");
    TestInvalid("null x");
}

void TestRoundTrip(char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    char *newString = JsonToString(jsonObj);
    EXPECT_EQ(0, strcmp(json, newString));
    free(newString);
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, TestJsonToString)
{
    TestRoundTrip("null");
    TestRoundTrip("false");
    TestRoundTrip("true");
    TestRoundTrip("0");
    TestRoundTrip("1");
    TestRoundTrip("-1");
    TestRoundTrip("1.5");
    TestRoundTrip("1.1");
    TestRoundTrip("3.25");
    TestRoundTrip("-3.25");
    TestRoundTrip("34234233425.25");
    TestRoundTrip("-34234233425.25");
    TestRoundTrip("1.00000000000001");
    TestRoundTrip("\"\"");
    TestRoundTrip("\"Hello\\nWorld\"");
    TestRoundTrip("\"\\\" \\\\ / \\b \\f \\n \\r \\t\"");
    TestRoundTrip("[]");
    TestRoundTrip("[null,false,true,123,\"abc\",[1,2,3]]");
    TestRoundTrip("{}");
    TestRoundTrip(
        "{\"a\":[1,2,3],\"f\":false,\"i\":123,\"n\":null,\"o\":{\"1\":1,\"2\":2,\"3\":3},\"s\":\"abc\",\"t\":true}");
    TestRoundTrip("-9223372036854775808");
    TestRoundTrip("9223372036854775807");
    TestRoundTrip("9223372036854775808");
    TestRoundTrip("18446744073709551615");
}

void TestInt(int64_t expect, char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    EXPECT_EQ(true, JsonIsInt(jsonObj));
    EXPECT_EQ(expect, GetJsonInt(jsonObj));
    JsonFree(jsonObj);
}

void TestUint(uint64_t expect, char *json)
{
    JsonObj *jsonObj = JsonParse(json);
    EXPECT_EQ(true, jsonObj != NULL);
    EXPECT_EQ(true, JsonIsUint(jsonObj));
    EXPECT_EQ(expect, GetJsonUint(jsonObj));
    JsonFree(jsonObj);
}

TEST_F(JsonParserUtest, TestUint64)
{
    TestInt(0, "0");
    TestInt(-1, "-1");
    TestInt(-9223372036854775808, "-9223372036854775808");
    TestInt(9223372036854775807, "9223372036854775807");
    TestUint(9223372036854775808, "9223372036854775808");
    TestUint(18446744073709551615, "18446744073709551615");
}

TEST_F(JsonParserUtest, TestJsonMakeString)
{
    JsonObj *emptyObj = JsonInit();
    char *emptyStr = JsonToString(emptyObj);
    EXPECT_EQ(0, strcmp("null", emptyStr));
    JsonFree(emptyObj);
    free(emptyStr);

    JsonObj *subObj = JsonInit();
    subObj->SetValueByKey(subObj, "1", {"1", CJSON_STRING})
        ->SetValueByKey(subObj, "2", {"2", CJSON_STRING})
        ->SetValueByKey(subObj, "3", {"3", CJSON_STRING});

    JsonObj *arr = JsonInit();
    arr->AddArrayItem(arr, {{.intValue = 1}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 2}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 3}, .type = CJSON_INT});

    JsonObj *obj = JsonInit();
    obj->SetValueByKey(obj, "s", {"abc", CJSON_STRING})
        ->SetValueByKey(obj, "t", {{.boolValue = true}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "f", {{.boolValue = false}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "i", {{.intValue = 123}, .type = CJSON_INT})
        ->SetValueByKey(obj, "d", {{.doubleValue = 1.5}, .type = CJSON_DOUBLE})
        ->SetValueByKey(obj, "a", *arr)
        ->SetValueByKey(obj, "o", *subObj);

    JsonObj *objPtr = obj;
    objPtr->TravelByKey(&objPtr, "o")->SetValueByKey(objPtr, "1", {{.intValue = 111}, .type = CJSON_INT});
    EXPECT_EQ(CJSON_OBJ, objPtr->type);

    char *json3 = JsonToString(obj);
    char *expectJson = "{\"a\":[1,2,3],\"d\":1.5,\"f\":false,\"i\":123,\"o\":{\"1\":111,\"2\":\"2\",\"3\":\"3\"},\"s\":"
                       "\"abc\",\"t\":true}";
    EXPECT_EQ(0, strcmp(expectJson, json3));

    // test Contains
    EXPECT_EQ(true, obj->Contains(obj, "s"));
    EXPECT_EQ(false, obj->Contains(obj, "not_exist"));

    // test GetValueByKey
    void *notExist = obj->GetValueByKey(obj, "not_exist");
    EXPECT_EQ(NULL, notExist);
    const char *gotStr = obj->GetValueByKey(obj, "s")->stringValue;
    EXPECT_EQ(0, strcmp("abc", gotStr));
    int64_t gotInt = obj->GetValueByKey(obj, "i")->intValue;
    EXPECT_EQ(123, gotInt);
    bool gotTrue = obj->GetValueByKey(obj, "t")->boolValue;
    EXPECT_EQ(true, gotTrue);
    double gotDouble = obj->GetValueByKey(obj, "d")->doubleValue;
    EXPECT_EQ(1.5, gotDouble);

    free(json3);
    JsonFree(subObj);
    JsonFree(arr);
    JsonFree(obj);
}

void EXPECT_JsonMake()
{
    JsonObj *subObj = JsonInit();
    if (subObj == NULL) {
        return;
    }
    subObj->SetValueByKey(subObj, "1", {"1", CJSON_STRING})
        ->SetValueByKey(subObj, "2", {"2", CJSON_STRING})
        ->SetValueByKey(subObj, "3", {"3", CJSON_STRING})
        ->SetValueByKey(subObj, "3", {"30", CJSON_STRING});

    JsonObj *arr = JsonInit();
    if (arr == NULL) {
        JsonFree(subObj);
        return;
    }
    arr->AddArrayItem(arr, {{.intValue = 1}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 2}, .type = CJSON_INT})
        ->AddArrayItem(arr, {{.intValue = 3}, .type = CJSON_INT});

    JsonObj *obj = JsonInit();
    if (obj == NULL) {
        JsonFree(subObj);
        JsonFree(arr);
        return;
    }
    obj
        ->SetValueByKey(obj, "a", *arr)
        ->SetValueByKey(obj, "o", *subObj)
        ->SetValueByKey(obj, "s", {"abc", CJSON_STRING})
        ->SetValueByKey(obj, "t", {{.boolValue = true}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "f", {{.boolValue = false}, .type = CJSON_BOOL})
        ->SetValueByKey(obj, "i", {{.intValue = 123}, .type = CJSON_INT})
        ->SetValueByKey(obj, "d", {{.doubleValue = 1.5}, .type = CJSON_DOUBLE});
    
    char *newString = JsonToString(obj);
    if (newString != NULL) {
        MSPROF_LOGI("%s", newString);
    }
    free(newString);
    JsonFree(subObj);
    JsonFree(arr);
    JsonFree(obj);
}

TEST_F(JsonParserUtest, ToHeapStrMemoryLeakTest)
{
    testing::internal::CaptureStdout();

    JsonObj *dstObj = JsonInit();
    JsonObj *obj = JsonInit();
    obj->SetValueByKey(obj, "s", {"abc", CJSON_STRING});
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));

    JsonCopy(dstObj, obj);
    JsonFree(obj);
    JsonFree(dstObj);

    std::string outputLog = testing::internal::GetCapturedStdout();
    EXPECT_NE(outputLog.find("memcpy_s failed"), std::string::npos); 
}

void *JsonMallocStub(int32_t size)
{
    return malloc(size);
}
int32_t g_jsonMallocSuccessCnt = 0;
void *JsonMallocTest(int32_t size)
{
    void *ret = nullptr;
    if (g_jsonMallocSuccessCnt > 0) {
        ret = JsonMallocStub(size);
    }
    g_jsonMallocSuccessCnt--;
    return ret;
}

TEST_F(JsonParserUtest, TestJsonGeneratorMallocFailed)
{
    MOCKER(OsalMalloc).stubs().will(invoke(JsonMallocTest));
    for (int32_t i = 0; i < 31; i++) {
        g_jsonMallocSuccessCnt = i;
        EXPECT_JsonMake();
    }
}

TEST_F(JsonParserUtest, TestJsonParserMallocFailed)
{
    MOCKER(OsalMalloc).stubs().will(invoke(JsonMallocTest));
    for (int32_t i = 0; i < 17; i++) {
        g_jsonMallocSuccessCnt = i;
        JsonObj *jsonObj = JsonParse(" { "
                                 "\"n\" : null , "
                                 "\"f\" : false , "
                                 "\"t\" : true , "
                                 "\"i\" : 123 , "
                                 "\"s\" : \"abc\", "
                                 "\"a\" : [ 1, 2, 3 ],"
                                 "\"o\" : { \"1\" : 1, \"2\" : 2, \"3\" : 3 }"
                                 " } ");
        JsonFree(jsonObj);
        EXPECT_EQ(jsonObj, nullptr);
    }
}

