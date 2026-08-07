/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <chrono>
#include <vector>
#include <securec.h>
#include "gtest/gtest.h"
#include "tsd_sha256.h"
#include "common/type_def.h"
#include "tsd_log.h"

using namespace tsd;
using namespace std;

class TsdSha256Test : public testing::Test {
protected:
    virtual void SetUp() { cout << "Before TsdSha256Test()" << endl; }

    virtual void TearDown() { cout << "After TsdSha256Test" << endl; }
};

// ============================================================
// 默认路径准确性测试（NIST 测试向量）
// ============================================================

TEST_F(TsdSha256Test, EmptyString)
{
    const uint8_t data[] = {};
    std::string result = sha256::ComputeHexString(data, 0);
    EXPECT_EQ(result, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
}

TEST_F(TsdSha256Test, SingleCharA)
{
    const uint8_t data[] = {'a'};
    std::string result = sha256::ComputeHexString(data, 1);
    EXPECT_EQ(result, "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
}

TEST_F(TsdSha256Test, Abc)
{
    const uint8_t data[] = {'a', 'b', 'c'};
    std::string result = sha256::ComputeHexString(data, 3);
    EXPECT_EQ(result, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
}

TEST_F(TsdSha256Test, MessageDigest)
{
    const std::string input = "message digest";
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
}

TEST_F(TsdSha256Test, LowercaseAlphabet)
{
    const std::string input = "abcdefghijklmnopqrstuvwxyz";
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
}

TEST_F(TsdSha256Test, NumericString20)
{
    const std::string input = "12345678901234567890";
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "6ed645ef0e1abea1bf1e4e935ff04f9e18d39812387f63cda3415b46240f0405");
}

TEST_F(TsdSha256Test, AlphanumericFull)
{
    const std::string input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "db4bfcbd4da0cd85a60c3c37d3fbd8805c77f15fc6b1fdfe614ee0a7c8fdb4c0");
}

TEST_F(TsdSha256Test, ThousandAs)
{
    std::string input(1000, 'a');
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "41edece42d63e8d9bf515a9ba6932e1c20cbc9f5a5d134645adb5db1b9737ea3");
}

TEST_F(TsdSha256Test, HelloWorld)
{
    const std::string input = "Hello, World!";
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f");
}

TEST_F(TsdSha256Test, BinaryData)
{
    const uint8_t data[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                            0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
    std::string result = sha256::ComputeHexString(data, 16);
    EXPECT_EQ(result, "be45cb2605bf36bebde684841a28f0fd43c69850a3dce5fedba69928ee3a8991");
}

TEST_F(TsdSha256Test, ExactOneBlock)
{
    std::string input(64, '0');
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "60e05bd1b195af2f94112fa7197a5c88289058840ce7c6df9693756bc6250f55");
}

TEST_F(TsdSha256Test, ExactTwoBlocks)
{
    std::string input(128, 'B');
    std::string result = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "7abaa701a6f4bb8d9ea3872a315597eb6f2ccfd03392d8d10560837f6136d06a");
}

TEST_F(TsdSha256Test, IncrementalUpdate)
{
    const std::string full = "abcdefghijklmnopqrstuvwxyz";
    std::string oneShot = sha256::ComputeHexString(PtrToPtr<const char, const uint8_t>(full.data()), full.size());

    sha256::Context ctx;
    sha256::Init(ctx);
    sha256::Update(ctx, PtrToPtr<const char, const uint8_t>(full.data()), 10);
    sha256::Update(ctx, PtrToPtr<const char, const uint8_t>(full.data() + 10), 16);
    uint8_t digest[sha256::DIGEST_LENGTH];
    sha256::Final(ctx, digest);

    char hex[65];
    for (int i = 0; i < 32; i++) {
        (void)snprintf_s(hex + i * 2, 3, 2, "%02x", digest[i]);
    }
    EXPECT_EQ(std::string(hex), oneShot);
}

// ============================================================
// 软件路径准确性测试（强制走 CompressBlockSoft）
// ============================================================

TEST_F(TsdSha256Test, SoftEmptyString)
{
    const uint8_t data[] = {};
    std::string result = sha256::ComputeHexStringSoft(data, 0);
    EXPECT_EQ(result, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
}

TEST_F(TsdSha256Test, SoftSingleCharA)
{
    const uint8_t data[] = {'a'};
    std::string result = sha256::ComputeHexStringSoft(data, 1);
    EXPECT_EQ(result, "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
}

TEST_F(TsdSha256Test, SoftAbc)
{
    const uint8_t data[] = {'a', 'b', 'c'};
    std::string result = sha256::ComputeHexStringSoft(data, 3);
    EXPECT_EQ(result, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
}

TEST_F(TsdSha256Test, SoftMessageDigest)
{
    const std::string input = "message digest";
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
}

TEST_F(TsdSha256Test, SoftLowercaseAlphabet)
{
    const std::string input = "abcdefghijklmnopqrstuvwxyz";
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
}

TEST_F(TsdSha256Test, SoftThousandAs)
{
    std::string input(1000, 'a');
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "41edece42d63e8d9bf515a9ba6932e1c20cbc9f5a5d134645adb5db1b9737ea3");
}

TEST_F(TsdSha256Test, SoftHelloWorld)
{
    const std::string input = "Hello, World!";
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f");
}

TEST_F(TsdSha256Test, SoftExactOneBlock)
{
    std::string input(64, '0');
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "60e05bd1b195af2f94112fa7197a5c88289058840ce7c6df9693756bc6250f55");
}

TEST_F(TsdSha256Test, SoftExactTwoBlocks)
{
    std::string input(128, 'B');
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "7abaa701a6f4bb8d9ea3872a315597eb6f2ccfd03392d8d10560837f6136d06a");
}

TEST_F(TsdSha256Test, SoftBinaryData)
{
    const uint8_t data[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                            0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
    std::string result = sha256::ComputeHexStringSoft(data, 16);
    EXPECT_EQ(result, "be45cb2605bf36bebde684841a28f0fd43c69850a3dce5fedba69928ee3a8991");
}

TEST_F(TsdSha256Test, SoftAlphanumericFull)
{
    const std::string input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "db4bfcbd4da0cd85a60c3c37d3fbd8805c77f15fc6b1fdfe614ee0a7c8fdb4c0");
}

TEST_F(TsdSha256Test, SoftNumericString20)
{
    const std::string input = "12345678901234567890";
    std::string result = sha256::ComputeHexStringSoft(PtrToPtr<const char, const uint8_t>(input.data()), input.size());
    EXPECT_EQ(result, "6ed645ef0e1abea1bf1e4e935ff04f9e18d39812387f63cda3415b46240f0405");
}

// 软件路径与默认路径结果一致性验证（1MB 数据）
TEST_F(TsdSha256Test, SoftConsistencyWith1MB)
{
    const size_t SIZE = 1024 * 1024;
    std::vector<uint8_t> data(SIZE, 0xAB);
    std::string resultDefault = sha256::ComputeHexString(data.data(), data.size());
    std::string resultSoft = sha256::ComputeHexStringSoft(data.data(), data.size());
    EXPECT_EQ(resultDefault, resultSoft);
}
