/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdlib>
#include <cstring>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "env_internal_api.h"
#include "common_util_func.h"

using namespace tsd;
using namespace std;

namespace {
constexpr size_t ENV_VALUE_MAX_LEN = 1024UL * 1024UL;
char g_envBuffer[ENV_VALUE_MAX_LEN + 1];
} // namespace

class EnvInternalApiTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        fallbackEnv_ = std::make_unique<ScopedEnvVar>("TEST_ENV_FALLBACK");
        notExistEnv_ = std::make_unique<ScopedEnvVar>("NOT_EXIST_ENV");
        cout << "Before EnvInternalApiTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After EnvInternalApiTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            fallbackEnv_.reset();
            notExistEnv_.reset();
            throw;
        }
        GlobalMockObject::reset();
        fallbackEnv_.reset();
        notExistEnv_.reset();
    }

    std::unique_ptr<ScopedEnvVar> fallbackEnv_;
    std::unique_ptr<ScopedEnvVar> notExistEnv_;
};

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_MmSysValuePresent_ReturnsMmSysValue)
{
    const char* envValue = "test_value_123";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "DATAMASTER_RUN_MODE", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_NullPointer)
{
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(nullptr)));
    unsetenv("NOT_EXIST_ENV");

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "NOT_EXIST_ENV", result);

    EXPECT_EQ(result, "");
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_ValueTooLong)
{
    (void)memset_s(g_envBuffer, ENV_VALUE_MAX_LEN, 'a', ENV_VALUE_MAX_LEN);
    g_envBuffer[ENV_VALUE_MAX_LEN] = '\0';

    MOCKER(mmSysGetEnv).stubs().will(returnValue(&g_envBuffer[0]));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "LONG_ENV", result);

    EXPECT_EQ(result, "");
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_ValueAtMaxLenMinus1)
{
    (void)memset_s(g_envBuffer, ENV_VALUE_MAX_LEN - 1, 'a', ENV_VALUE_MAX_LEN - 1);
    g_envBuffer[ENV_VALUE_MAX_LEN - 1] = '\0';

    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(g_envBuffer)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "MAX_LEN_ENV", result);

    EXPECT_EQ(result.length(), ENV_VALUE_MAX_LEN - 1);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_EmptyValue)
{
    const char* envValue = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "EMPTY_ENV", result);

    EXPECT_EQ(result, "");
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_OverwriteExistingValue)
{
    const char* envValue = "new_value";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result = "old_value";
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "OVERWRITE_ENV", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_SpecialCharsInValue)
{
    const char* envValue = "value with spaces\nand\ttabs";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "SPECIAL_ENV", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_ChineseCharsInValue)
{
    const char* envValue = "中文测试值";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "CHINESE_ENV", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_MultipleCalls)
{
    const char* envValue1 = "first_value";
    const char* envValue2 = "second_value";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    std::string result1;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV1", result1);
    EXPECT_EQ(result1, envValue1);

    std::string result2;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV2", result2);
    EXPECT_EQ(result2, envValue2);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_ValueExactlyMaxLen)
{
    (void)memset_s(g_envBuffer, ENV_VALUE_MAX_LEN, 'a', ENV_VALUE_MAX_LEN);
    g_envBuffer[ENV_VALUE_MAX_LEN] = '\0';

    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(g_envBuffer)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "EXACT_MAX_ENV", result);

    EXPECT_EQ(result, "");
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_ShortValue)
{
    const char* envValue = "short";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "SHORT_ENV", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_LongButValidValue)
{
    char longValue[1024];
    (void)memset_s(longValue, 1023, 'b', 1023);
    longValue[1023] = '\0';

    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(longValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "LONG_VALID_ENV", result);

    EXPECT_EQ(result.length(), 1023);
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_NullEnvName)
{
    const char* envValue = "test";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, nullptr, result);

    EXPECT_EQ(result, "test");
}

TEST_F(EnvInternalApiTest, GetEnvFromMmSys_DifferentEnvIds)
{
    const char* envValue = "id_test_value";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_ASAN_RUN_MODE, "ASAN_RUN_MODE", result);

    EXPECT_EQ(result, envValue);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_MatchExact)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "DATAMASTER_RUN_MODE", "1");

    EXPECT_EQ(result, true);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_NotMatch)
{
    const char* envValue = "0";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "DATAMASTER_RUN_MODE", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_EmptyEnvValue)
{
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(nullptr)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "EMPTY_FLAG_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_EnvStrNull)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, nullptr, "1");

    EXPECT_EQ(result, true);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_CaseSensitive)
{
    const char* envValue = "ONE";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "CASE_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_ValueWithSpaces)
{
    const char* envValue = " 1 ";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "SPACE_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_ValueZero)
{
    const char* envValue = "0";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ZERO_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_ValueTwo)
{
    const char* envValue = "2";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "TWO_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_TrueString)
{
    const char* envValue = "true";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "TRUE_ENV", "1");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_MultipleDifferentFlags)
{
    const char* envValue1 = "1";
    const char* envValue2 = "0";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    bool result1 = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "FLAG1", "1");
    EXPECT_EQ(result1, true);

    bool result2 = GetFlagFromMmSys(MM_ENV_ASAN_RUN_MODE, "FLAG2", "1");
    EXPECT_EQ(result2, false);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_ExpectedValueDifferent)
{
    const char* envValue = "enabled";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "DIFF_ENV", "enabled");

    EXPECT_EQ(result, true);
}

TEST_F(EnvInternalApiTest, GetFlagFromMmSys_EmptyStringMatch)
{
    const char* envValue = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "EMPTY_MATCH_ENV", "");

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_True)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, true);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_False_ValueZero)
{
    const char* envValue = "0";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_False_ValueTwo)
{
    const char* envValue = "2";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_False_NotSet)
{
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(nullptr)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_False_EmptyValue)
{
    const char* envValue = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_False_InvalidValue)
{
    const char* envValue = "invalid";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsFpgaMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_MultipleCallsConsistency)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)));

    bool result1 = IsFpgaMmSysEnv();
    bool result2 = IsFpgaMmSysEnv();
    bool result3 = IsFpgaMmSysEnv();

    EXPECT_EQ(result1, true);
    EXPECT_EQ(result2, true);
    EXPECT_EQ(result3, true);
}

TEST_F(EnvInternalApiTest, IsFpgaMmSysEnv_AfterEnvChange)
{
    const char* envValue1 = "0";
    const char* envValue2 = "1";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    bool result1 = IsFpgaMmSysEnv();
    EXPECT_EQ(result1, false);

    bool result2 = IsFpgaMmSysEnv();
    EXPECT_EQ(result2, true);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_True)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsAsanMmSysEnv();

    EXPECT_EQ(result, true);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_False_ValueZero)
{
    const char* envValue = "0";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsAsanMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_False_NotSet)
{
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(nullptr)));

    bool result = IsAsanMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_False_EmptyValue)
{
    const char* envValue = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsAsanMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_False_InvalidValue)
{
    const char* envValue = "invalid";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result = IsAsanMmSysEnv();

    EXPECT_EQ(result, false);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_MultipleCallsConsistency)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)));

    bool result1 = IsAsanMmSysEnv();
    bool result2 = IsAsanMmSysEnv();
    bool result3 = IsAsanMmSysEnv();

    EXPECT_EQ(result1, true);
    EXPECT_EQ(result2, true);
    EXPECT_EQ(result3, true);
}

TEST_F(EnvInternalApiTest, IsAsanMmSysEnv_AfterEnvChange)
{
    const char* envValue1 = "0";
    const char* envValue2 = "1";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    bool result1 = IsAsanMmSysEnv();
    EXPECT_EQ(result1, false);

    bool result2 = IsAsanMmSysEnv();
    EXPECT_EQ(result2, true);
}

TEST_F(EnvInternalApiTest, Combined_FpgaAndAsanBothTrue)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)));

    bool fpgaResult = IsFpgaMmSysEnv();
    bool asanResult = IsAsanMmSysEnv();

    EXPECT_EQ(fpgaResult, true);
    EXPECT_EQ(asanResult, true);
}

TEST_F(EnvInternalApiTest, Combined_FpgaAndAsanBothFalse)
{
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(static_cast<char*>(nullptr)))
        .then(returnValue(static_cast<char*>(nullptr)));

    bool fpgaResult = IsFpgaMmSysEnv();
    bool asanResult = IsAsanMmSysEnv();

    EXPECT_EQ(fpgaResult, false);
    EXPECT_EQ(asanResult, false);
}

TEST_F(EnvInternalApiTest, Combined_FpgaTrueAsanFalse)
{
    const char* envValue1 = "1";
    const char* envValue2 = "0";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    bool fpgaResult = IsFpgaMmSysEnv();
    bool asanResult = IsAsanMmSysEnv();

    EXPECT_EQ(fpgaResult, true);
    EXPECT_EQ(asanResult, false);
}

TEST_F(EnvInternalApiTest, Combined_FpgaFalseAsanTrue)
{
    const char* envValue1 = "0";
    const char* envValue2 = "1";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)));

    bool fpgaResult = IsFpgaMmSysEnv();
    bool asanResult = IsAsanMmSysEnv();

    EXPECT_EQ(fpgaResult, false);
    EXPECT_EQ(asanResult, true);
}

TEST_F(EnvInternalApiTest, Combined_BothEnvChanged)
{
    const char* envValue1 = "0";
    const char* envValue2 = "1";
    const char* envValue3 = "1";
    const char* envValue4 = "0";

    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue1)))
        .then(returnValue(const_cast<char*>(envValue2)))
        .then(returnValue(const_cast<char*>(envValue3)))
        .then(returnValue(const_cast<char*>(envValue4)));

    bool fpga1 = IsFpgaMmSysEnv();
    bool asan1 = IsAsanMmSysEnv();
    EXPECT_EQ(fpga1, false);
    EXPECT_EQ(asan1, true);

    bool fpga2 = IsFpgaMmSysEnv();
    bool asan2 = IsAsanMmSysEnv();
    EXPECT_EQ(fpga2, true);
    EXPECT_EQ(asan2, false);
}

TEST_F(EnvInternalApiTest, Boundary_ShortestValidValue)
{
    const char* envValue = "a";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "SHORT_ENV", result);

    EXPECT_EQ(result, "a");
}

TEST_F(EnvInternalApiTest, Boundary_ValueLenOneByte)
{
    const char* envValue = "x";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ONE_BYTE_ENV", result);

    EXPECT_EQ(result.length(), 1UL);
}

TEST_F(EnvInternalApiTest, Boundary_GetFlagWithDifferentExpectedValues)
{
    const char* envValue = "test";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(const_cast<char*>(envValue)));

    bool result1 = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV", "test");
    bool result2 = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV", "TEST");
    bool result3 = GetFlagFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV", "test ");

    EXPECT_EQ(result1, true);
    EXPECT_EQ(result2, false);
    EXPECT_EQ(result3, false);
}

TEST_F(EnvInternalApiTest, Boundary_MultipleEnvIdsInSequence)
{
    const char* envValue = "1";
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)));

    std::string result1;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV1", result1);
    std::string result2;
    GetEnvFromMmSys(MM_ENV_ASAN_RUN_MODE, "ENV2", result2);
    std::string result3;
    GetEnvFromMmSys(static_cast<mmEnvId>(100), "ENV3", result3);

    EXPECT_EQ(result1, envValue);
    EXPECT_EQ(result2, envValue);
    EXPECT_EQ(result3, envValue);
}

TEST_F(EnvInternalApiTest, Boundary_GetEnvResultReuse)
{
    const char* envValue = "shared_value";
    MOCKER(mmSysGetEnv)
        .stubs()
        .will(returnValue(const_cast<char*>(envValue)))
        .then(returnValue(const_cast<char*>(envValue)));

    std::string result;
    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV1", result);
    EXPECT_EQ(result, envValue);

    GetEnvFromMmSys(MM_ENV_DATAMASTER_RUN_MODE, "ENV2", result);
    EXPECT_EQ(result, envValue);
}
