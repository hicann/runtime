/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <unistd.h>
#include <fstream>
#include <sys/stat.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "tsd/status.h"
#include "inc/weak_ascend_hal.h"
#include "log.h"
#include "tsd_util_func.h"
#include "common_util_func.h"
#include "inc/message_parse_server.h"

using namespace tsd;
using namespace std;

class TsdUtilFuncTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before TsdUtilFuncTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After TsdUtilFuncTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(TsdUtilFuncTest, TrimEmptyString)
{
    string str = "";
    Trim(str);
    EXPECT_EQ(str, "");
}

TEST_F(TsdUtilFuncTest, TrimOnlySpaces)
{
    string str = "   ";
    Trim(str);
    EXPECT_EQ(str, "");
}

TEST_F(TsdUtilFuncTest, TrimLeadingSpaces)
{
    string str = "   hello";
    Trim(str);
    EXPECT_EQ(str, "hello");
}

TEST_F(TsdUtilFuncTest, TrimTrailingSpaces)
{
    string str = "hello   ";
    Trim(str);
    EXPECT_EQ(str, "hello");
}

TEST_F(TsdUtilFuncTest, TrimBothSidesSpaces)
{
    string str = "   hello world   ";
    Trim(str);
    EXPECT_EQ(str, "hello world");
}

TEST_F(TsdUtilFuncTest, TrimNoSpaces)
{
    string str = "hello";
    Trim(str);
    EXPECT_EQ(str, "hello");
}

TEST_F(TsdUtilFuncTest, CalFileSizeSuccess)
{
    string filepath = "/tmp/test_file.txt";
    ofstream outfile(filepath);
    outfile << "test content";
    outfile.close();
    
    uint64_t size = CalFileSize(filepath);
    EXPECT_GT(size, 0UL);
    
    remove(filepath.c_str());
}

TEST_F(TsdUtilFuncTest, CalFileSizeNotExist)
{
    string filepath = "/tmp/not_exist_file.txt";
    uint64_t size = CalFileSize(filepath);
    EXPECT_EQ(size, 0UL);
}

TEST_F(TsdUtilFuncTest, CalFileSizeEmptyPath)
{
    string filepath = "";
    uint64_t size = CalFileSize(filepath);
    EXPECT_EQ(size, 0UL);
}

TEST_F(TsdUtilFuncTest, ValidateStrValidPattern)
{
    string str = "test123";
    string mode = "^[a-z0-9]+$";
    bool ret = ValidateStr(str, mode);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, ValidateStrInvalidPattern)
{
    string str = "test@123";
    string mode = "^[a-z0-9]+$";
    bool ret = ValidateStr(str, mode);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, ValidateStrEmptyString)
{
    string str = "";
    string mode = "^[a-z0-9]+$";
    bool ret = ValidateStr(str, mode);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, GetScheduleEnvSuccess)
{
    setenv("TEST_ENV_VAR", "test_value", 1);
    string envValue;
    GetScheduleEnv("TEST_ENV_VAR", envValue);
    EXPECT_EQ(envValue, "test_value");
    unsetenv("TEST_ENV_VAR");
}

TEST_F(TsdUtilFuncTest, GetScheduleEnvNotExist)
{
    string envValue;
    GetScheduleEnv("NOT_EXIST_ENV", envValue);
    EXPECT_EQ(envValue, "");
}

TEST_F(TsdUtilFuncTest, GetScheduleEnvNullName)
{
    string envValue;
    GetScheduleEnv(nullptr, envValue);
    EXPECT_EQ(envValue, "");
}

TEST_F(TsdUtilFuncTest, GetFlagFromEnvSuccess)
{
    setenv("TEST_FLAG", "1", 1);
    bool ret = GetFlagFromEnv("TEST_FLAG", "1");
    EXPECT_EQ(ret, true);
    unsetenv("TEST_FLAG");
}

TEST_F(TsdUtilFuncTest, GetFlagFromEnvFail)
{
    setenv("TEST_FLAG", "0", 1);
    bool ret = GetFlagFromEnv("TEST_FLAG", "1");
    EXPECT_EQ(ret, false);
    unsetenv("TEST_FLAG");
}

TEST_F(TsdUtilFuncTest, GetFlagFromEnvNotExist)
{
    bool ret = GetFlagFromEnv("NOT_EXIST_FLAG", "1");
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, CheckValidatePathValid)
{
    string path = "/home/user/test/path";
    bool ret = CheckValidatePath(path);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, CheckValidatePathInvalid)
{
    string path = "/home/user/test@path";
    bool ret = CheckValidatePath(path);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, CheckValidatePathEmpty)
{
    string path = "";
    bool ret = CheckValidatePath(path);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, SafeStrerror)
{
    string errorMsg = SafeStrerror();
    EXPECT_GE(errorMsg.length(), 0UL);
}

TEST_F(TsdUtilFuncTest, TransStrToIntSuccess)
{
    string para = "12345";
    int32_t value = 0;
    bool ret = TransStrToInt(para, value);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(value, 12345);
}

TEST_F(TsdUtilFuncTest, TransStrToIntNegative)
{
    string para = "-12345";
    int32_t value = 0;
    bool ret = TransStrToInt(para, value);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(value, -12345);
}

TEST_F(TsdUtilFuncTest, TransStrToIntInvalid)
{
    string para = "abc123";
    int32_t value = 0;
    bool ret = TransStrToInt(para, value);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, TransStrToIntEmpty)
{
    string para = "";
    int32_t value = 0;
    bool ret = TransStrToInt(para, value);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, RemoveOneFileSuccess)
{
    string filepath = "/tmp/test_remove_file.txt";
    ofstream outfile(filepath);
    outfile << "test content";
    outfile.close();
    
    RemoveOneFile(filepath);
    
    int32_t ret = access(filepath.c_str(), F_OK);
    EXPECT_NE(ret, 0);
}

TEST_F(TsdUtilFuncTest, RemoveOneFileNotExist)
{
    string filepath = "/tmp/not_exist_remove_file.txt";
    RemoveOneFile(filepath);
}

TEST_F(TsdUtilFuncTest, RemoveOneFileEmptyPath)
{
    string filepath = "";
    RemoveOneFile(filepath);
}

TEST_F(TsdUtilFuncTest, IsDirEmptyEmptyDir)
{
    string dirPath = "/tmp/test_empty_dir";
    mkdir(dirPath.c_str(), 0755);
    
    bool ret = IsDirEmpty(dirPath);
    EXPECT_EQ(ret, true);
    
    rmdir(dirPath.c_str());
}

TEST_F(TsdUtilFuncTest, IsDirNotEmptyDir)
{
    string dirPath = "/tmp/test_not_empty_dir";
    mkdir(dirPath.c_str(), 0755);
    
    string filepath = dirPath + "/test_file.txt";
    ofstream outfile(filepath);
    outfile << "test content";
    outfile.close();
    
    bool ret = IsDirEmpty(dirPath);
    EXPECT_EQ(ret, false);
    
    remove(filepath.c_str());
    rmdir(dirPath.c_str());
}

TEST_F(TsdUtilFuncTest, IsDirEmptyNotExist)
{
    string dirPath = "/tmp/not_exist_dir";
    bool ret = IsDirEmpty(dirPath);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, CalFileSha256HashValueSuccess)
{
    string filepath = "/tmp/test_hash_file.txt";
    ofstream outfile(filepath);
    outfile << "test content for hash";
    outfile.close();
    
    string hashValue = CalFileSha256HashValue(filepath);
    EXPECT_GT(hashValue.length(), 0UL);
    
    remove(filepath.c_str());
}

TEST_F(TsdUtilFuncTest, CalFileSha256HashValueNotExist)
{
    string filepath = "/tmp/not_exist_hash_file.txt";
    string hashValue = CalFileSha256HashValue(filepath);
    EXPECT_EQ(hashValue, "");
}

TEST_F(TsdUtilFuncTest, IsVfModeCheckedByDeviceIdTrue)
{
    bool ret = IsVfModeCheckedByDeviceId(32U);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, IsVfModeCheckedByDeviceIdTrueMax)
{
    bool ret = IsVfModeCheckedByDeviceId(63U);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, IsVfModeCheckedByDeviceIdFalseMin)
{
    bool ret = IsVfModeCheckedByDeviceId(31U);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, IsVfModeCheckedByDeviceIdFalseMax)
{
    bool ret = IsVfModeCheckedByDeviceId(64U);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, IsCurrentVfModeTrueByDeviceId)
{
    bool ret = IsCurrentVfMode(32U, 0U);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, IsCurrentVfModeTrueByVfId)
{
    bool ret = IsCurrentVfMode(0U, 1U);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdUtilFuncTest, IsCurrentVfModeFalse)
{
    bool ret = IsCurrentVfMode(0U, 0U);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, CalcUniqueVfIdVfModeByDeviceId)
{
    uint32_t deviceId = 32U;
    uint32_t vfId = 0U;
    uint32_t ret = CalcUniqueVfId(deviceId, vfId);
    EXPECT_EQ(ret, deviceId);
}

TEST_F(TsdUtilFuncTest, CalcUniqueVfIdDeviceIdZero)
{
    uint32_t deviceId = 0U;
    uint32_t vfId = 1U;
    uint32_t ret = CalcUniqueVfId(deviceId, vfId);
    EXPECT_EQ(ret, vfId);
}

TEST_F(TsdUtilFuncTest, CalcUniqueVfIdVfIdZero)
{
    uint32_t deviceId = 1U;
    uint32_t vfId = 0U;
    uint32_t ret = CalcUniqueVfId(deviceId, vfId);
    EXPECT_EQ(ret, vfId);
}

TEST_F(TsdUtilFuncTest, CalcUniqueVfIdBothZero)
{
    MessageParseServer *ptr = MessageParseServer::GetInstance();
    uint32_t deviceId = 0U;
    uint32_t vfId = 0U;
    uint32_t ret = CalcUniqueVfId(deviceId, vfId);
    EXPECT_EQ(ret, vfId);
}