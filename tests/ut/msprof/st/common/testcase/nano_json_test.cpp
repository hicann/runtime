/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "json/json.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

class NANO_JSON_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};
using namespace NanoJson;

TEST_F(NANO_JSON_TEST, json_insert_test) {
    NanoJson::Json json;
    EXPECT_EQ(json.End(), json.Begin());
    json["name"]="LeBorn James";
    EXPECT_EQ(true, json.Contains("name"));
    json["number"] = (const uint32_t)23;         //整数
    EXPECT_EQ(true, json.Contains("number"));
    json["salary(m)"] = 50.1;  // double
    EXPECT_EQ(true, json.Contains("salary(m)"));
    json["man"]=true;          //布尔值
    EXPECT_EQ(true, json.Contains("man"));
    json["children"]={(std::string)"LeBorn Jr",(std::string)"Bryce Maximus",(std::string)"Zhuri"};//数组
    EXPECT_EQ(true, json.Contains("children"));
    json["behavior"]["funny"]={1,2,3};              //对象中元素值
    EXPECT_EQ(true, json.Contains("behavior"));
    EXPECT_EQ(true, json["behavior"].Contains("funny"));
    std::vector<int> array = {1, 2, 3, 4};
    json["champion"] = array;
    EXPECT_EQ(true, json.Contains("champion"));

    std::unordered_map<std::string, std::string> map = {{"name","Wade"}, {"age","38"}};
    json["friends"] = map;

    EXPECT_STREQ("LeBorn James", json["name"].GetValue<std::string>().c_str());
    EXPECT_EQ(23, json["number"].GetValue<uint64_t>());
    EXPECT_EQ(50.1, json["salary(m)"].GetValue<double>());
    EXPECT_EQ(true, json["man"].GetValue<bool>());

    EXPECT_STREQ("LeBorn Jr", json["children"][0].GetValue<std::string>().c_str());
    EXPECT_STREQ("Bryce Maximus", json["children"][1].GetValue<std::string>().c_str());
    EXPECT_STREQ("Zhuri", json["children"][2].GetValue<std::string>().c_str());

    EXPECT_EQ(1, json["behavior"]["funny"][0].GetValue<int64_t>());
    EXPECT_EQ(2, json["behavior"]["funny"][1].GetValue<int64_t>());
    EXPECT_EQ(3, json["behavior"]["funny"][2].GetValue<int64_t>());
    json["behavior"]["funny"][2] = 20;
    EXPECT_EQ(20, json["behavior"]["funny"][2].GetValue<int64_t>());
    json["behavior"]["funny"][2] = 3;

    // EXPECT_EQ(4, json["champion"].size());
    EXPECT_EQ(1, json["champion"][0].GetValue<int64_t>());
    EXPECT_EQ(2, json["champion"][1].GetValue<int64_t>());
    EXPECT_EQ(3, json["champion"][2].GetValue<int64_t>());
    EXPECT_EQ(4, json["champion"][3].GetValue<int64_t>());

    EXPECT_STREQ("Wade", json["friends"]["name"].GetValue<std::string>().c_str());
    EXPECT_STREQ("38", json["friends"]["age"].GetValue<std::string>().c_str());

    std::string str = json.ToString();

    EXPECT_NE(std::string::npos, str.find("\"name\":\"Wade\""));
    EXPECT_NE(std::string::npos, str.find("\"age\":\"38\""));
    EXPECT_NE(std::string::npos, str.find("\"children\":[\"LeBorn Jr\",\"Bryce Maximus\",\"Zhuri\"]"));
    EXPECT_NE(std::string::npos, str.find("\"name\":\"LeBorn James\""));
    EXPECT_NE(std::string::npos, str.find("\"behavior\":{\"funny\":[1,2,3]}"));
    EXPECT_NE(std::string::npos, str.find("\"salary(m)\":50.100000"));
    EXPECT_NE(std::string::npos, str.find("\"number\":23"));
}

TEST_F(NANO_JSON_TEST, json_parse_test) {
    const std::string str = "{\"people\":{\"name\":\"lyh\"},\"number\":10,\"isMale\":[true,true,false,false,true,true,true,false,false,true],\"age\": 20.1, \"president\": null}";
    NanoJson::Json json;
    json.Parse(str);
    json["people"]["age"] = 100;

    EXPECT_STREQ("lyh", json["people"]["name"].GetValue<std::string>().c_str());

    EXPECT_EQ(100, json["people"]["age"].GetValue<int64_t>());
    EXPECT_EQ(10, json["number"].GetValue<uint64_t>());
    EXPECT_EQ(true, json["isMale"][0].GetValue<bool>());
    EXPECT_EQ(true, json["isMale"][1].GetValue<bool>());
    EXPECT_EQ(false, json["isMale"][2].GetValue<bool>());
    EXPECT_EQ(false, json["isMale"][3].GetValue<bool>());
    EXPECT_EQ(true, json["isMale"][4].GetValue<bool>());
    EXPECT_EQ(true, json["isMale"][5].GetValue<bool>());
    EXPECT_EQ(true, json["isMale"][6].GetValue<bool>());
    EXPECT_EQ(false, json["isMale"][7].GetValue<bool>());
    EXPECT_EQ(false, json["isMale"][8].GetValue<bool>());
    EXPECT_EQ(true, json["isMale"][9].GetValue<bool>());
    EXPECT_EQ(20.1, json["age"].GetValue<double>());
}

TEST_F(NANO_JSON_TEST, json_getvalue_test) {
    NanoJson::JsonValue val;
    NanoJson::Json json;
    val.type = NanoJson::JsonValueType::OBJECT;
    uint32_t a = 1;
    uint64_t b = 2;
    int32_t c = 3;
    int64_t d = 4;

    val["one"] = a;
    val["two"] = b;
    val["three"] = c;
    val["four"] = d;

    EXPECT_EQ(a, val["one"].GetValue<int64_t>());
    EXPECT_EQ(a, val["one"].GetValue<uint64_t>());
    EXPECT_EQ(b, val["two"].GetValue<int64_t>());
    EXPECT_EQ(b, val["two"].GetValue<uint64_t>());

    ASSERT_NO_THROW(json = val);
    json = val;

    for (auto iter = json.Begin(); iter != json.End(); iter++) {
        EXPECT_EQ(iter->second.type, val[iter->first].type);
        EXPECT_EQ(iter->second.value.uintValue, val[iter->first].value.uintValue);
    }

    NanoJson::JsonValue tmp(NanoJson::JsonValueType::BOOLEAN);
    EXPECT_EQ(tmp.type, NanoJson::JsonValueType::BOOLEAN);

    ASSERT_NO_THROW(tmp.GetValue<bool>());
    EXPECT_EQ(false, tmp.GetValue<bool>());
    ASSERT_NO_THROW(tmp.GetValue<int32_t>());
    EXPECT_EQ(0, tmp.GetValue<int32_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint32_t>());
    EXPECT_EQ(0, tmp.GetValue<uint32_t>());
    ASSERT_NO_THROW(tmp.GetValue<int64_t>());
    EXPECT_EQ(0, tmp.GetValue<int64_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint64_t>());
    EXPECT_EQ(0, tmp.GetValue<uint64_t>());

    tmp = true;
    EXPECT_EQ(tmp.type, NanoJson::JsonValueType::BOOLEAN);

    ASSERT_NO_THROW(tmp.GetValue<bool>());
    EXPECT_EQ(true, tmp.GetValue<bool>());
    ASSERT_NO_THROW(tmp.GetValue<int32_t>());
    EXPECT_EQ(1, tmp.GetValue<int32_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint32_t>());
    EXPECT_EQ(1, tmp.GetValue<uint32_t>());
    ASSERT_NO_THROW(tmp.GetValue<int64_t>());
    EXPECT_EQ(1, tmp.GetValue<int64_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint64_t>());
    EXPECT_EQ(1, tmp.GetValue<uint64_t>());

    tmp.type, NanoJson::JsonValueType::INT;
    tmp = 20;

    ASSERT_NO_THROW(tmp.GetValue<int32_t>());
    EXPECT_EQ(20, tmp.GetValue<int32_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint32_t>());
    EXPECT_EQ(20, tmp.GetValue<uint32_t>());
    ASSERT_NO_THROW(tmp.GetValue<int64_t>());
    EXPECT_EQ(20, tmp.GetValue<int64_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint64_t>());
    EXPECT_EQ(20, tmp.GetValue<uint64_t>());

    tmp = 0;
    ASSERT_NO_THROW(tmp.GetValue<bool>());
    EXPECT_EQ(false, tmp.GetValue<bool>());
    ASSERT_NO_THROW(tmp.GetValue<int32_t>());
    EXPECT_EQ(0, tmp.GetValue<int32_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint32_t>());
    EXPECT_EQ(0, tmp.GetValue<uint32_t>());
    ASSERT_NO_THROW(tmp.GetValue<int64_t>());
    EXPECT_EQ(0, tmp.GetValue<int64_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint64_t>());
    EXPECT_EQ(0, tmp.GetValue<uint64_t>());

    tmp = 1;
    ASSERT_NO_THROW(tmp.GetValue<bool>());
    EXPECT_EQ(true, tmp.GetValue<bool>());
    ASSERT_NO_THROW(tmp.GetValue<int32_t>());
    EXPECT_EQ(1, tmp.GetValue<int32_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint32_t>());
    EXPECT_EQ(1, tmp.GetValue<uint32_t>());
    ASSERT_NO_THROW(tmp.GetValue<int64_t>());
    EXPECT_EQ(1, tmp.GetValue<int64_t>());
    ASSERT_NO_THROW(tmp.GetValue<uint64_t>());
    EXPECT_EQ(1, tmp.GetValue<uint64_t>());

    NanoJson::JsonValue val1;
    EXPECT_EQ(val1.type, NanoJson::JsonValueType::INVALID);
    ASSERT_NO_THROW(val1.GetValue<bool>());  // Invalid时不抛出异常
    EXPECT_EQ(false, val1.GetValue<bool>());

    ASSERT_NO_THROW(val1.GetValue<double>());
    EXPECT_EQ(0.0, val1.GetValue<double>());

    ASSERT_NO_THROW(val1.GetValue<int64_t>());
    EXPECT_EQ(0, val1.GetValue<int64_t>());

    ASSERT_NO_THROW(val1.GetValue<uint64_t>());
    EXPECT_EQ(0, val1.GetValue<uint64_t>());

    ASSERT_NO_THROW(val1.GetValue<int32_t>());
    EXPECT_EQ(0, val1.GetValue<int32_t>());

    ASSERT_NO_THROW(val1.GetValue<uint32_t>());
    EXPECT_EQ(0, val1.GetValue<uint32_t>());

    ASSERT_NO_THROW(val1.GetValue<std::string>());
    EXPECT_STREQ("", val1.GetValue<std::string>().c_str());
}

TEST_F(NANO_JSON_TEST, json_error_test) {
    std::string str = "{ \"}";

    ASSERT_ANY_THROW(NanoJson::Json json(str));
    ASSERT_ANY_THROW(NanoJson::Json json("123"));
    NanoJson::Json json;
    ASSERT_ANY_THROW(json.Parse(str));
    ASSERT_ANY_THROW(json.Parse("{ \"isman\" : test}"));
    ASSERT_ANY_THROW(json.Parse("{ \"isman\" , 0}"));
    ASSERT_ANY_THROW(json.Parse("{ \"isman\" : test"));
    ASSERT_ANY_THROW(json.Parse("{ \"isman\" : \"test\""));
    ASSERT_ANY_THROW(json.Parse("[ \"isman\" : 0   ]"));
    ASSERT_ANY_THROW(json.Parse("{ \"isman\" : false_test}"));
    ASSERT_ANY_THROW(json.Parse("{ \"age\" : .01}"));
    ASSERT_ANY_THROW(json.Parse("{ \"age\" : 00}"));
    ASSERT_ANY_THROW(json.Parse("{ \"age\" : -.01}"));
    ASSERT_ANY_THROW(json.Parse("{ \"age\" : 10.}"));
    ASSERT_ANY_THROW(json.Parse("{ \"group\" : [1, 2, 3}"));
    ASSERT_ANY_THROW(json.Parse("{ \"group\" : [10., -.01, ]}"));
    ASSERT_ANY_THROW(json.Parse("{ \"name\" : \"Zhang san}"));
    ASSERT_ANY_THROW(json.Parse("{ name\" : \"Zhang san\"}"));
    ASSERT_ANY_THROW(json.Parse("{ \"name : \"Zhang san\"}"));
    ASSERT_ANY_THROW(json.Parse("{ \"name\" : Zhang san\"}"));
    ASSERT_ANY_THROW(json.Parse("123"));   
    ASSERT_ANY_THROW(json.Parse("{\"123\"}"));
    ASSERT_ANY_THROW(json.Parse("{123}"));
}

TEST_F(NANO_JSON_TEST, json_pushback_test) {

    NanoJson::JsonValue val;
    val.type = NanoJson::JsonValueType::OBJECT;
    val.value.objectValue = new std::unordered_map<std::string, JsonValue>;
    val["version"] = "1.0";
    val["jobInfo"] = "NA";
    val["OS"] = "Linux-5.4.0-42-generic-#46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 2020";
    val["cpuCores"] = 1;

    NanoJson::JsonValue obj;
    obj.type = NanoJson::JsonValueType::OBJECT;
    obj.value.objectValue = new std::unordered_map<std::string, JsonValue>;

    obj["Id"] = 0;
    obj["Name"] = "GenuineIntel";
    obj["Frequency"] = "";
    obj["Logical_CPU_Count"] = 4;
    obj["Type"] = "Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz";

    NanoJson::JsonValue array;
    array.type = NanoJson::JsonValueType::ARRAY;
    array.value.arrayValue = new std::vector<JsonValue>;

    array.PushBack(obj);
    val["CPU"] = array;

    NanoJson::Json json(val);
    EXPECT_EQ(0, json["CPU"][0]["Id"].GetValue<int64_t>());
    EXPECT_STREQ("GenuineIntel", json["CPU"][0]["Name"].GetValue<std::string>().c_str());
    EXPECT_STREQ("", json["CPU"][0]["Frequency"].GetValue<std::string>().c_str());
    EXPECT_EQ(4, json["CPU"][0]["Logical_CPU_Count"].GetValue<int64_t>());
    EXPECT_STREQ("Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz", json["CPU"][0]["Type"].GetValue<std::string>().c_str());
}

TEST_F(NANO_JSON_TEST, json_obj_test) {
    std::string str = "{\"profiler\": \"on\",\"cann\": {\"modules\": [{\"module\": \"ACL\",\"prof_switch\": \"on\"},{\"module\": \"FRAMEWORK\",\"prof_switch\": \"on\"},{\"module\": \"RUNTIME\",\"prof_switch\": \"on\"},{\"module\": \"API\",\"reporter_switch\": \"on\"},{\"module\": \"COMPACT\",\"reporter_switch\": \"on\"},{\"module\": \"ADDITIONAL\",\"reporter_switch\": \"on\"}]}}";
    NanoJson::Json json(str);
    EXPECT_EQ(false, json["profiler"].Contains("channels"));
    EXPECT_EQ(false, json.Contains("channels"));
    NanoJson::JsonValue channels;
    channels = json["cann"]["channels"];
    EXPECT_EQ(channels.type, NanoJson::JsonValueType::INVALID);
    EXPECT_EQ(channels.GetValue<NanoJson::JsonArray>().size(), 0);
    EXPECT_EQ(channels.GetValue<NanoJson::JsonObj>().size(), 0);
}