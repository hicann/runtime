/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"

#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <fcntl.h>
#include <string>
#include <unistd.h>

#include "log_hardware_zip.h"
#include "log_file_info.h"
#include "zip_sdk.h"

extern "C" {
void HardwareZipStubReset(void);
void HardwareZipStubSetDeflateInitResult(int result);
void HardwareZipStubSetDeflateResult(int result, unsigned long availOut);
void HardwareZipStubSetDeflateEndResult(int result);
void HardwareCompressEnd(struct zip_stream* zipStream);
LogStatus HardwareCompressInit(int32_t fd, struct zip_stream* zipStream);
LogStatus HardwareCompressBufferInit(struct zip_stream* zipStream, char* dest, uint32_t destTotalLen);
int32_t HardwareSrcDataCopy(const char* source, int32_t* sourceLen, struct zip_stream* zipStream);
int32_t HardwareZipProcess(struct zip_stream* zipStream, int32_t flush, char* dest, size_t destAvailLen);
}

class HardwareZipCoverageUtest : public testing::Test {
protected:
    static constexpr const char* SOURCE_PATH = "/tmp/hardware_zip_coverage.log";

    void SetUp() override
    {
        HardwareZipStubReset();
        (void)std::remove(SOURCE_PATH);
        (void)std::remove("/tmp/hardware_zip_coverage.log.gz");
    }

    void TearDown() override
    {
        (void)std::remove(SOURCE_PATH);
        (void)std::remove("/tmp/hardware_zip_coverage.log.gz");
    }
};

TEST_F(HardwareZipCoverageUtest, RejectsInvalidBufferArguments)
{
    char* dest = nullptr;
    uint32_t destLen = 0;
    EXPECT_EQ(LOG_INVALID_PTR, HardwareCompressBuffer(nullptr, 1U, &dest, &destLen));
    EXPECT_EQ(LOG_INVALID_PTR, HardwareCompressBuffer("data", 4U, nullptr, &destLen));
    EXPECT_EQ(LOG_INVALID_PARAM, HardwareCompressBuffer("data", 0U, &dest, &destLen));
}

TEST_F(HardwareZipCoverageUtest, CompressesBufferThroughHardwareSdkBoundary)
{
    char* dest = nullptr;
    uint32_t destLen = 0;
    ASSERT_EQ(LOG_SUCCESS, HardwareCompressBuffer("hardware zip", 12U, &dest, &destLen));
    ASSERT_NE(nullptr, dest);
    EXPECT_EQ(11U, destLen);
    EXPECT_EQ('\x1f', dest[0]);
    EXPECT_EQ('z', dest[10]);
    std::free(dest);
}

TEST_F(HardwareZipCoverageUtest, CompressesFileAndRemovesSource)
{
    {
        std::ofstream source(SOURCE_PATH);
        ASSERT_TRUE(source.is_open());
        source << "hardware zip file content";
    }

    ASSERT_EQ(LOG_SUCCESS, HardwareCompressFile(SOURCE_PATH));
    EXPECT_EQ(nullptr, std::fopen(SOURCE_PATH, "rb"));
    FILE* compressed = std::fopen("/tmp/hardware_zip_coverage.log.gz", "rb");
    ASSERT_NE(nullptr, compressed);
    EXPECT_EQ(0, std::fclose(compressed));
}

TEST_F(HardwareZipCoverageUtest, RemovesDestinationWhenHardwareInitFails)
{
    {
        std::ofstream source(SOURCE_PATH);
        ASSERT_TRUE(source.is_open());
        source << "hardware zip failure";
    }
    HardwareZipStubSetDeflateInitResult(-1);

    EXPECT_EQ(LOG_FAILURE, HardwareCompressFile(SOURCE_PATH));
    FILE* source = std::fopen(SOURCE_PATH, "rb");
    ASSERT_NE(nullptr, source);
    EXPECT_EQ(0, std::fclose(source));
    EXPECT_EQ(nullptr, std::fopen("/tmp/hardware_zip_coverage.log.gz", "rb"));
}

TEST_F(HardwareZipCoverageUtest, CoversHardwareBoundaryFailures)
{
    EXPECT_EQ(LOG_FAILURE, HardwareCompressFile(nullptr));
    EXPECT_EQ(LOG_FAILURE, HardwareCompressFile(""));
    EXPECT_EQ(LOG_FAILURE, HardwareCompressFile("/tmp/hardware_zip_missing.log"));

    std::string longPath(MAX_FILEPATH_LEN, 'x');
    EXPECT_EQ(LOG_FAILURE, HardwareCompressFile(longPath.c_str()));

    char* dest = nullptr;
    uint32_t destLen = 0;
    EXPECT_EQ(LOG_INVALID_PTR, HardwareCompressBuffer("data", 4U, &dest, nullptr));
    EXPECT_EQ(LOG_INVALID_PARAM, HardwareCompressBuffer("data", UINT32_MAX, &dest, &destLen));
    HardwareZipStubSetDeflateInitResult(-1);
    EXPECT_EQ(LOG_FAILURE, HardwareCompressBuffer("data", 4U, &dest, &destLen));
    EXPECT_EQ(nullptr, dest);
    HardwareZipStubReset();

    zip_stream stream = {};
    int32_t fullFd = open("/dev/full", O_WRONLY);
    ASSERT_GE(fullFd, 0);
    EXPECT_EQ(LOG_FAILURE, HardwareCompressInit(fullFd, &stream));
    ASSERT_EQ(0, close(fullFd));
    char tiny[1] = { 0 };
    EXPECT_EQ(LOG_FAILURE, HardwareCompressBufferInit(&stream, tiny, sizeof(tiny)));

    char output[32] = { 0 };
    ASSERT_EQ(LOG_SUCCESS, HardwareCompressBufferInit(&stream, output, sizeof(output)));
    int32_t sourceLen = 0;
    EXPECT_EQ(INVALID, HardwareSrcDataCopy("", &sourceLen, &stream));
    zip_stream invalidStream = {};
    sourceLen = 4;
    EXPECT_EQ(INVALID, HardwareSrcDataCopy("data", &sourceLen, &invalidStream));
    sourceLen = 4;
    EXPECT_EQ(4, HardwareSrcDataCopy("data", &sourceLen, &stream));
    EXPECT_EQ(0, sourceLen);
    std::string largeSource((1024U * 1024U) + 1U, 'x');
    sourceLen = static_cast<int32_t>(largeSource.size());
    EXPECT_EQ(1024 * 1024, HardwareSrcDataCopy(largeSource.data(), &sourceLen, &stream));
    EXPECT_EQ(1, sourceLen);
    EXPECT_EQ(INVALID, HardwareZipProcess(&stream, HZIP_FLUSH_TYPE_FINISH, output, 0));
    HardwareZipStubSetDeflateResult(-1, 0U);
    EXPECT_EQ(INVALID, HardwareZipProcess(&stream, HZIP_FLUSH_TYPE_FINISH, output, sizeof(output)));
    HardwareZipStubSetDeflateResult(HZIP_OK, 1024U * 1024U);
    EXPECT_EQ(INVALID, HardwareZipProcess(&stream, HZIP_FLUSH_TYPE_FINISH, output, sizeof(output)));
    HardwareZipStubSetDeflateEndResult(-1);
    HardwareCompressEnd(&stream);
}
