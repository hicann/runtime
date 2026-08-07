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
#include "weak_ascend_hal.h"
#include "tsd_log.h"
#include "tsd_util_func.h"
#include "common_util_func.h"

using namespace tsd;
using namespace std;

namespace {
int dladdrFake1(const void*, Dl_info* info)
{
    info->dli_fname = "test";
    return 1;
}

int dladdrFake2(const void*, Dl_info* info)
{
    info->dli_fname = "/home/test";
    return 1;
}
} // namespace

class TsdUtilFuncTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        testEnv_ = std::make_unique<ScopedEnvVar>("TEST_ENV_VAR");
        testFlagEnv_ = std::make_unique<ScopedEnvVar>("TEST_FLAG");
        notExistEnv_ = std::make_unique<ScopedEnvVar>("NOT_EXIST_ENV");
        notExistFlag_ = std::make_unique<ScopedEnvVar>("NOT_EXIST_FLAG");
        (void)unsetenv("NOT_EXIST_ENV");
        (void)unsetenv("NOT_EXIST_FLAG");
        cout << "Before TsdUtilFuncTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After TsdUtilFuncTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreEnvironment();
            throw;
        }
        GlobalMockObject::reset();
        RestoreEnvironment();
    }

    void RestoreEnvironment()
    {
        testEnv_.reset();
        testFlagEnv_.reset();
        notExistEnv_.reset();
        notExistFlag_.reset();
    }

    std::unique_ptr<ScopedEnvVar> testEnv_;
    std::unique_ptr<ScopedEnvVar> testFlagEnv_;
    std::unique_ptr<ScopedEnvVar> notExistEnv_;
    std::unique_ptr<ScopedEnvVar> notExistFlag_;
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

TEST_F(TsdUtilFuncTest, CalFileSize_ExistingFile_ReturnsExactSize)
{
    ScopedTempFile file("test content");
    ASSERT_TRUE(file.IsValid());

    EXPECT_EQ(CalFileSize(file.Path()), 12UL);
}

TEST_F(TsdUtilFuncTest, CalFileSizeNotExist)
{
    ScopedTempFile file;
    ASSERT_TRUE(file.IsValid());
    file.Remove();
    EXPECT_EQ(CalFileSize(file.Path()), 0UL);
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

TEST_F(TsdUtilFuncTest, GetScheduleEnv_VariableExists_ReturnsValue)
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

TEST_F(TsdUtilFuncTest, GetFlagFromEnv_ValueMatches_ReturnsTrue)
{
    setenv("TEST_FLAG", "1", 1);
    bool ret = GetFlagFromEnv("TEST_FLAG", "1");
    EXPECT_EQ(ret, true);
    unsetenv("TEST_FLAG");
}

TEST_F(TsdUtilFuncTest, GetFlagFromEnv_ValueDiffers_ReturnsFalse)
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

TEST_F(TsdUtilFuncTest, CheckValidatePath_EmptyPath_ReturnsFalse)
{
    string path = "";
    bool ret = CheckValidatePath(path);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdUtilFuncTest, SafeStrerror_ErrnoSet_ReturnsSystemMessage)
{
    errno = ENOENT;
    EXPECT_EQ(SafeStrerror(), "No such file or directory");
}

TEST_F(TsdUtilFuncTest, TransStrToInt_DecimalInput_ReturnsValue)
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

TEST_F(TsdUtilFuncTest, RemoveOneFile_ExistingFile_RemovesPath)
{
    ScopedTempFile file("test content");
    ASSERT_TRUE(file.IsValid());

    RemoveOneFile(file.Path());

    EXPECT_NE(access(file.Path().c_str(), F_OK), 0);
}

TEST_F(TsdUtilFuncTest, RemoveOneFile_NonEmptyDirectory_LeavesDirectory)
{
    ScopedTempDir dir;
    ASSERT_TRUE(dir.IsValid());
    ASSERT_TRUE(dir.WriteFile("test_file.txt", "test content"));

    RemoveOneFile(dir.Path());

    EXPECT_EQ(access(dir.Path().c_str(), F_OK), 0);
}

TEST_F(TsdUtilFuncTest, IsDirEmptyEmptyDir)
{
    ScopedTempDir dir;
    ASSERT_TRUE(dir.IsValid());

    EXPECT_TRUE(IsDirEmpty(dir.Path()));
}

TEST_F(TsdUtilFuncTest, IsDirNotEmptyDir)
{
    ScopedTempDir dir;
    ASSERT_TRUE(dir.IsValid());
    ASSERT_TRUE(dir.WriteFile("test_file.txt", "test content"));

    EXPECT_FALSE(IsDirEmpty(dir.Path()));
}

TEST_F(TsdUtilFuncTest, IsDirEmptyNotExist)
{
    ScopedTempDir dir;
    ASSERT_TRUE(dir.IsValid());
    const std::string path = dir.Path();
    EXPECT_EQ(rmdir(path.c_str()), 0);
    EXPECT_TRUE(IsDirEmpty(path));
}

TEST_F(TsdUtilFuncTest, CalFileSha256HashValue_KnownContent_ReturnsExpectedDigest)
{
    ScopedTempFile file("test content for hash");
    ASSERT_TRUE(file.IsValid());

    EXPECT_EQ(CalFileSha256HashValue(file.Path()), "ee63779c8078ead9b4c682d6bd8662edac699d851ed85cd120d3236609bb3253");
}

TEST_F(TsdUtilFuncTest, CalFileSha256HashValueNotExist)
{
    ScopedTempFile file;
    ASSERT_TRUE(file.IsValid());
    file.Remove();
    EXPECT_EQ(CalFileSha256HashValue(file.Path()), "");
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
    uint32_t deviceId = 0U;
    uint32_t vfId = 0U;
    uint32_t ret = CalcUniqueVfId(deviceId, vfId);
    EXPECT_EQ(ret, vfId);
}

TEST_F(TsdUtilFuncTest, GetHostSoPath_DladdrFails_ReturnsEmpty)
{
    MOCKER(dladdr).stubs().will(returnValue(0));
    std::string path = tsd::GetHostSoPath();
    EXPECT_EQ(path, "");
}

TEST_F(TsdUtilFuncTest, GetHostSoPath_DladdrReturnsNullName_ReturnsEmpty)
{
    MOCKER(dladdr).stubs().will(returnValue(1));
    std::string path = tsd::GetHostSoPath();
    EXPECT_EQ(path, "");
}

TEST_F(TsdUtilFuncTest, GetHostSoPath_BinaryNameWithoutDirectory_ReturnsCurrentDirectory)
{
    MOCKER(dladdr).stubs().will(invoke(dladdrFake1));
    std::string path = tsd::GetHostSoPath();
    EXPECT_EQ(path, "./");
}

TEST_F(TsdUtilFuncTest, GetHostSoPath_AbsoluteBinaryPath_ReturnsParentDirectory)
{
    MOCKER(dladdr).stubs().will(invoke(dladdrFake2));
    std::string path = tsd::GetHostSoPath();
    EXPECT_EQ(path, "/home/");
}
