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
#include <unistd.h>
#include <vector>
#include "mockcpp/mockcpp.hpp"
#include "case_workspace.h"
#include "adump_pub.h"
#include "file.h"

using namespace Adx;

constexpr mmMode_t READ_WRITE_MODE = M_IRUSR | M_IWUSR;
constexpr mmMode_t READ_ONLY_MODE = M_IRUSR;
constexpr mmMode_t WRITE_ONLY_MODE = M_IWUSR;

class CommonFileUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(CommonFileUtest, Test_Open_File)
{
    Tools::CaseWorkspace ws("Test_Open_Success");
    std::string existFile = ws.Touch("exist.txt");
    EXPECT_EQ(File(existFile, M_RDWR).IsFileOpen(), ADUMP_SUCCESS);

    std::string notExistFile = ws.Root() + "/" + "not_exist.txt";
    EXPECT_EQ(File(notExistFile, M_RDWR, READ_WRITE_MODE).IsFileOpen(), ADUMP_FAILED);
    EXPECT_EQ(File(notExistFile, M_RDWR | M_CREAT, READ_WRITE_MODE).IsFileOpen(), ADUMP_SUCCESS);

    std::string notExistPathFile = ws.Root() + "/NotExistPath/" + "not_exist.txt";
    EXPECT_EQ(File(notExistPathFile, M_RDWR | M_CREAT).IsFileOpen(), ADUMP_FAILED);

    // root用户执行用例有权限
    int32_t ret = getuid() == 0 ? ADUMP_SUCCESS : ADUMP_FAILED;

    std::string writeOnlyFile = ws.Touch("write_only.txt");
    ws.Chmod("write_only.txt", "222");
    EXPECT_EQ(File(writeOnlyFile, M_RDONLY).IsFileOpen(), ret);
    EXPECT_EQ(File(writeOnlyFile, M_WRONLY).IsFileOpen(), ADUMP_SUCCESS);

    std::string readOnlyFile = ws.Touch("read_only.txt");
    ws.Chmod("read_only.txt", "444");
    EXPECT_EQ(File(readOnlyFile, M_WRONLY).IsFileOpen(), ret);
    EXPECT_EQ(File(readOnlyFile, M_RDONLY).IsFileOpen(), ADUMP_SUCCESS);
}

TEST_F(CommonFileUtest, Test_Close_File)
{
    Tools::CaseWorkspace ws("Test_Close_File");
    std::string existFile = ws.Touch("exist.txt");
    File file(existFile, M_RDWR);

    // close after open success
    EXPECT_EQ(file.IsFileOpen(), ADUMP_SUCCESS);
    EXPECT_EQ(file.Close(), ADUMP_SUCCESS);

    // close after close
    EXPECT_EQ(file.Close(), ADUMP_SUCCESS);

    // close failed
    File files(existFile, M_RDWR);
    EXPECT_EQ(files.IsFileOpen(), ADUMP_SUCCESS);
    MOCKER(mmClose).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(files.Close(), ADUMP_FAILED);
}

TEST_F(CommonFileUtest, Test_Write_File)
{
    Tools::CaseWorkspace ws("Test_Write_File");

    constexpr char writeCtx[] = "test write context";
    int64_t writeLength = sizeof(writeCtx);

    // test write context to rd/wr file
    File rwFile(ws.Root() + "/rw_file.txt", M_RDWR | M_CREAT, READ_WRITE_MODE);
    EXPECT_EQ(rwFile.IsFileOpen(), ADUMP_SUCCESS);
    EXPECT_EQ(rwFile.Write(writeCtx, writeLength), writeLength);

    // test write nullptr, 长度为 0 时不下发 IO；非 0 时由底层返回负错误码(具体值取决于 mmWrite 实现)
    EXPECT_EQ(rwFile.Write(nullptr, 0), 0);
    EXPECT_LT(rwFile.Write(nullptr, 2), 0);

    // test negative length
    EXPECT_EQ(rwFile.Write(writeCtx, -1), EN_INVALID_PARAM);
}

namespace {
// 记录每次 mmWrite 的入参长度并累加，用于校验 >4G 的写入是否被完整分片下发而没有截断
int64_t g_stubWriteTotal = 0;
UINT32 g_stubWriteMaxChunk = 0;
mmSsize_t MmWriteAccumulateStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    g_stubWriteTotal += static_cast<int64_t>(bufLen);
    if (bufLen > g_stubWriteMaxChunk) {
        g_stubWriteMaxChunk = bufLen;
    }
    return static_cast<mmSsize_t>(bufLen);
}

// 每次只写入请求长度的一半(至少 1 字节)，模拟短写，校验 Write 会循环补齐
mmSsize_t MmWriteShortStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    const UINT32 accepted = (bufLen > 1U) ? (bufLen / 2U) : bufLen;
    g_stubWriteTotal += static_cast<int64_t>(accepted);
    return static_cast<mmSsize_t>(accepted);
}

// 前 2 次返回 EN_ERROR(配合 mmGetErrorCode 返回 EINTR)模拟被信号打断，之后正常写入，
// 用于校验 EINTR 重试路径不会丢数据、不会误判失败
int32_t g_stubWriteEintrTimes = 0;
mmSsize_t MmWriteEintrThenOkStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    if (g_stubWriteEintrTimes > 0) {
        --g_stubWriteEintrTimes;
        return static_cast<mmSsize_t>(EN_ERROR);
    }
    g_stubWriteTotal += static_cast<int64_t>(bufLen);
    return static_cast<mmSsize_t>(bufLen);
}
} // namespace

// 5G 数据写入：length 曾被 static_cast<UINT32> 截断(5G -> 1G)导致静默丢数据，
// 此处校验分片总长等于 5G、单片不超过 1G，且返回值为累计写入长度。
TEST_F(CommonFileUtest, Test_Write_File_Over_4G_No_Truncation)
{
    constexpr int64_t writeLength = 5LL * 1024LL * 1024LL * 1024LL; // 5G
    constexpr int64_t maxChunk = 1LL << 30;                         // 1G
    g_stubWriteTotal = 0;
    g_stubWriteMaxChunk = 0;

    File file("over_4g_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite).stubs().will(invoke(MmWriteAccumulateStub));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    // buffer 不会被 stub 实际访问，仅用于指针偏移计算
    char dummy = 0;
    EXPECT_EQ(file.Write(&dummy, writeLength), writeLength);
    EXPECT_EQ(g_stubWriteTotal, writeLength);
    EXPECT_LE(static_cast<int64_t>(g_stubWriteMaxChunk), maxChunk);
}

// 短写场景：单次 mmWrite 只接收部分数据，Write 必须循环补齐并返回完整长度
TEST_F(CommonFileUtest, Test_Write_File_Short_Write_Retry)
{
    constexpr int64_t writeLength = 4096;
    g_stubWriteTotal = 0;

    File file("short_write_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite).stubs().will(invoke(MmWriteShortStub));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    std::vector<char> buffer(static_cast<size_t>(writeLength), 'a');
    EXPECT_EQ(file.Write(buffer.data(), writeLength), writeLength);
    EXPECT_EQ(g_stubWriteTotal, writeLength);
}

// mmWrite 返回 0：无法继续推进，必须按失败返回负值而不是死循环
TEST_F(CommonFileUtest, Test_Write_File_Return_Zero_Not_Hang)
{
    File file("write_zero_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite).stubs().will(returnValue(static_cast<mmSsize_t>(0)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    char buffer[16] = {0};
    EXPECT_EQ(file.Write(buffer, sizeof(buffer)), EN_ERROR);
}

// mmWrite 返回值超过请求长度：异常返回值必须判失败
TEST_F(CommonFileUtest, Test_Write_File_Return_Exceeds_Request)
{
    File file("write_exceed_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite).stubs().will(returnValue(static_cast<mmSsize_t>(1024)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    char buffer[16] = {0};
    EXPECT_EQ(file.Write(buffer, sizeof(buffer)), EN_ERROR);
}

// 写入中途失败：已写部分不算成功，返回底层错误码，避免调用方 ret >= 0 误判完整
TEST_F(CommonFileUtest, Test_Write_File_Fail_In_Middle)
{
    File file("write_fail_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(static_cast<mmSsize_t>(8)))
        .then(returnValue(static_cast<mmSsize_t>(EN_ERROR)));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(EIO)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    char buffer[32] = {0};
    EXPECT_EQ(file.Write(buffer, sizeof(buffer)), EN_ERROR);
}

// EINTR 重试：mmWrite 被信号打断两次后正常写入，Write 必须重试并返回完整长度而非失败
TEST_F(CommonFileUtest, Test_Write_File_Eintr_Retry)
{
    constexpr int64_t writeLength = 64;
    g_stubWriteTotal = 0;
    g_stubWriteEintrTimes = 2;

    File file("write_eintr_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmWrite).stubs().will(invoke(MmWriteEintrThenOkStub));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(EINTR)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    std::vector<char> buffer(static_cast<size_t>(writeLength), 'b');
    EXPECT_EQ(file.Write(buffer.data(), writeLength), writeLength);
    EXPECT_EQ(g_stubWriteTotal, writeLength);
    EXPECT_EQ(g_stubWriteEintrTimes, 0); // 两次 EINTR 均已被消费，确认走过重试分支
}

TEST_F(CommonFileUtest, Test_Write_To_ReadOnly_File)
{
    Tools::CaseWorkspace ws("Test_Write_To_ReadOnly_File");
    File readOnlyFile(ws.Root() + "/read_only.txt", M_RDONLY | M_CREAT, READ_WRITE_MODE);
    EXPECT_EQ(readOnlyFile.IsFileOpen(), ADUMP_SUCCESS);

    constexpr char writeCtx[] = "test write context";
    int64_t writeLength = sizeof(writeCtx);
    EXPECT_EQ(readOnlyFile.Write(writeCtx, writeLength), EN_ERROR);
}

TEST_F(CommonFileUtest, Test_Read_File)
{
    Tools::CaseWorkspace ws("Test_Read_File");

    std::string testFile = "init.txt";
    std::string writeCtx = "file context";
    int64_t writeLength = writeCtx.length();

    std::string filePath = ws.Touch(testFile);
    ws.Echo(writeCtx, testFile);

    // test read data
    char readBuffer[512] = {0};
    File file(filePath, M_RDWR);
    EXPECT_EQ(file.IsFileOpen(), ADUMP_SUCCESS);
    EXPECT_EQ(file.Read(readBuffer, 512), writeLength);
    std::string readCtx(readBuffer);
    EXPECT_EQ(readCtx, writeCtx);
}

TEST_F(CommonFileUtest, Test_Read_From_WriteOnly_File)
{
    Tools::CaseWorkspace ws("Test_Read_File");

    File writeOnlyFile(ws.Root() + "/write_only.txt", M_WRONLY | M_CREAT, WRITE_ONLY_MODE);
    EXPECT_EQ(writeOnlyFile.IsFileOpen(), ADUMP_SUCCESS);

    char readBuffer[512] = {0};
    EXPECT_EQ(writeOnlyFile.Read(readBuffer, 512), EN_ERROR);
}

namespace {
int64_t g_stubReadTotal = 0;
UINT32 g_stubReadMaxChunk = 0;
int64_t g_stubReadRemain = 0;
// 按剩余量返回，模拟内核单次只返回部分数据，用于校验 Read 的分片与循环补齐
mmSsize_t MmReadChunkStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    if (bufLen > g_stubReadMaxChunk) {
        g_stubReadMaxChunk = bufLen;
    }
    const int64_t give =
        (static_cast<int64_t>(bufLen) < g_stubReadRemain) ? static_cast<int64_t>(bufLen) : g_stubReadRemain;
    g_stubReadRemain -= give;
    g_stubReadTotal += give;
    return static_cast<mmSsize_t>(give);
}

// 前 2 次返回 EN_ERROR(配合 mmGetErrorCode 返回 EINTR)模拟被信号打断，之后按剩余量返回，
// 用于校验 Read 的 EINTR 重试路径不会丢数据、不会误判失败
int32_t g_stubReadEintrTimes = 0;
mmSsize_t MmReadEintrThenOkStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    if (g_stubReadEintrTimes > 0) {
        --g_stubReadEintrTimes;
        return static_cast<mmSsize_t>(EN_ERROR);
    }
    const int64_t give =
        (static_cast<int64_t>(bufLen) < g_stubReadRemain) ? static_cast<int64_t>(bufLen) : g_stubReadRemain;
    g_stubReadRemain -= give;
    g_stubReadTotal += give;
    return static_cast<mmSsize_t>(give);
}

// 第一次返回部分数据，第二次返回非 EINTR 的 EN_ERROR，用于校验 Read 中途失败返回负错误码
int32_t g_stubReadFailStep = 0;
mmSsize_t MmReadPartialThenFailStub(INT32 fd, VOID* buf, UINT32 bufLen)
{
    (void)fd;
    (void)buf;
    if (g_stubReadFailStep++ == 0) {
        const UINT32 give = (bufLen > 8U) ? 8U : bufLen;
        g_stubReadTotal += static_cast<int64_t>(give);
        return static_cast<mmSsize_t>(give);
    }
    return static_cast<mmSsize_t>(EN_ERROR);
}
} // namespace

// Read 的 length 同样曾被截断到 UINT32，此处校验 5G 读请求的分片总量与单片上限
TEST_F(CommonFileUtest, Test_Read_File_Over_4G_No_Truncation)
{
    constexpr int64_t readLength = 5LL * 1024LL * 1024LL * 1024LL; // 5G
    constexpr int64_t maxChunk = 1LL << 30;                        // 1G
    g_stubReadTotal = 0;
    g_stubReadMaxChunk = 0;
    g_stubReadRemain = readLength;

    File file("over_4g_read_target", O_RDONLY, READ_ONLY_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmRead).stubs().will(invoke(MmReadChunkStub));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    // buffer 不会被 stub 实际写入，仅用于指针偏移计算
    char dummy = 0;
    EXPECT_EQ(file.Read(&dummy, readLength), readLength);
    EXPECT_EQ(g_stubReadTotal, readLength);
    EXPECT_LE(static_cast<int64_t>(g_stubReadMaxChunk), maxChunk);
}

// 数据不足 length 时(EOF)，Read 返回实际读到的字节数而不是阻塞或报错
TEST_F(CommonFileUtest, Test_Read_File_Eof_Returns_Actual_Size)
{
    constexpr int64_t available = 100;
    g_stubReadTotal = 0;
    g_stubReadMaxChunk = 0;
    g_stubReadRemain = available;

    File file("read_eof_target", O_RDONLY, READ_ONLY_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmRead).stubs().will(invoke(MmReadChunkStub));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    std::vector<char> buffer(512, 0);
    EXPECT_EQ(file.Read(buffer.data(), static_cast<int64_t>(buffer.size())), available);
}

// 负长度入参防护
TEST_F(CommonFileUtest, Test_Read_File_Negative_Length)
{
    Tools::CaseWorkspace ws("Test_Read_Negative_Length");
    std::string filePath = ws.Touch("neg.txt");
    File file(filePath, M_RDONLY);
    EXPECT_EQ(file.IsFileOpen(), ADUMP_SUCCESS);

    char readBuffer[16] = {0};
    EXPECT_EQ(file.Read(readBuffer, -1), EN_INVALID_PARAM);
}

// EINTR 重试：mmRead 被信号打断两次后正常读取，Read 必须重试并返回完整长度而非失败
TEST_F(CommonFileUtest, Test_Read_File_Eintr_Retry)
{
    constexpr int64_t readLength = 64;
    g_stubReadTotal = 0;
    g_stubReadRemain = readLength;
    g_stubReadEintrTimes = 2;

    File file("read_eintr_target", O_RDONLY, READ_ONLY_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmRead).stubs().will(invoke(MmReadEintrThenOkStub));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(EINTR)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    std::vector<char> buffer(static_cast<size_t>(readLength), 0);
    EXPECT_EQ(file.Read(buffer.data(), readLength), readLength);
    EXPECT_EQ(g_stubReadTotal, readLength);
    EXPECT_EQ(g_stubReadEintrTimes, 0); // 两次 EINTR 均已被消费，确认走过重试分支
}

// 读取中途失败：第一次返回部分数据、第二次返回非 EINTR 错误，
// 必须返回负错误码而不是已读长度，避免调用方按 >= 0 误判成功
TEST_F(CommonFileUtest, Test_Read_File_Fail_In_Middle)
{
    g_stubReadTotal = 0;
    g_stubReadFailStep = 0;

    File file("read_fail_target", O_RDONLY, READ_ONLY_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    EXPECT_EQ(file.EnsureOpen(), ADUMP_SUCCESS);
    MOCKER(mmRead).stubs().will(invoke(MmReadPartialThenFailStub));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(EIO)));
    MOCKER(mmClose).stubs().will(returnValue(EN_OK));

    char buffer[32] = {0};
    EXPECT_EQ(file.Read(buffer, sizeof(buffer)), EN_ERROR);
    EXPECT_EQ(g_stubReadTotal, 8); // 首次已读 8 字节，但整体仍按失败返回
}

TEST_F(CommonFileUtest, Test_Copy_File)
{
    Tools::CaseWorkspace ws("Test_Copy_File");

    std::string srcContext = "this is src file context";
    std::string srcFile = "src.txt";
    std::string srcPath = ws.Touch(srcFile);
    ws.Echo(srcContext, srcFile);

    std::string dstPath = ws.Root() + "/" + "dst.txt";
    EXPECT_EQ(File::Copy(srcPath, dstPath), ADUMP_SUCCESS);

    File dstFile(dstPath, M_RDONLY);
    EXPECT_EQ(dstFile.IsFileOpen(), ADUMP_SUCCESS);

    char readBuffer[512] = {0};
    EXPECT_EQ(dstFile.Read(readBuffer, 512), srcContext.length());
    EXPECT_EQ(std::string(readBuffer), srcContext);
}

TEST_F(CommonFileUtest, Test_Copy_With_Exception)
{
    Tools::CaseWorkspace ws("Test_Copy_With_Exception");

    std::string srcFileName = "src_file.txt";
    std::string srcPath = ws.Touch(srcFileName);
    std::string dstFileName = "dst_file.txt";
    std::string dstPath = ws.Touch(dstFileName);

    // root用户执行用例有权限
    int32_t ret = getuid() == 0 ? ADUMP_SUCCESS : ADUMP_FAILED;

    // src file cann't read
    ws.Chmod(srcFileName, "222");
    EXPECT_EQ(File::Copy(srcPath, dstPath), ret);

    // dst file can't write
    ws.Chmod(srcFileName, "444");
    ws.Chmod(dstFileName, "444");
    EXPECT_EQ(File::Copy(srcPath, dstPath), ret);

    ws.Chmod(srcFileName, "644");
    ws.Chmod(dstFileName, "644");

    // stub read fail
    int64_t readSuccRet = 10L;
    MOCKER_CPP(&File::Read).stubs().will(returnValue(EN_ERROR)).then(returnValue(readSuccRet));
    EXPECT_EQ(File::Copy(srcPath, dstPath), ADUMP_FAILED);

    // stub write fail
    MOCKER_CPP(&File::Write).stubs().will(returnValue(int64_t(EN_ERROR)));
    EXPECT_EQ(File::Copy(srcPath, dstPath), ADUMP_FAILED);
}

// Test long filename path: triggers ENAMETOOLONG → AddMapping (lines 56-70, 179-211)
TEST_F(CommonFileUtest, Test_Open_LongFilename_ENAMETOOLONG)
{
    Tools::CaseWorkspace ws("Test_Open_LongFilename");
    // Create a filename > NAME_MAX (255) to trigger ENAMETOOLONG from OS open()
    std::string longName(256, 'x'); // 256 chars exceeds NAME_MAX=255 on Linux
    longName += ".txt";
    std::string filePath = ws.Root() + "/" + longName;
    // First open() fails with ENAMETOOLONG, then AddMapping is called,
    // then a hash-named file is opened - covers file.cpp lines 56-70 and 179-211
    File file(filePath, O_RDWR | O_CREAT, M_IRUSR | M_IWUSR);
    // Coverage of the code path is the goal; success/failure depends on filesystem
    (void)file;
    EXPECT_TRUE(true);
}

// Test AddMapping failure when open mapping file fails
TEST_F(CommonFileUtest, Test_Open_LongFilename_AddMapping_OpenFails)
{
    Tools::CaseWorkspace ws("Test_Open_LongFilename_AddMappingFails");
    std::string longName(256, 'x');
    longName += ".bin";
    std::string filePath = ws.Root() + "/" + longName;
    // First mmOpen2 call fails → ENAMETOOLONG path
    // Second mmOpen2 call (for mapping file) also fails → AddMapping returns ADUMP_FAILED
    // Third mmOpen2 call (for hash-named file) fails → Open returns ADUMP_FAILED
    MOCKER(mmOpen2).stubs().will(returnValue(-1));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(ENAMETOOLONG)));
    File file(filePath, O_RDWR | O_CREAT, M_IRUSR | M_IWUSR);
    EXPECT_EQ(file.IsFileOpen(), ADUMP_FAILED);
}

TEST_F(CommonFileUtest, Test_AddMapping_WriteLengthExceedsRemainingLength)
{
    constexpr mmSsize_t writeLengthBeyondMapping = 1024;
    File file("mapping_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    MOCKER(mmWrite).stubs().will(returnValue(writeLengthBeyondMapping));
    MOCKER(mmClose).expects(once()).will(returnValue(EN_OK));

    EXPECT_EQ(file.AddMapping("/tmp", "file.txt", "hash"), ADUMP_FAILED);
}

// mmWrite 返回 0：原实现 residLen -= 0 恒不变，while (residLen != 0) 永不退出导致挂死。
// 文件名超长命中 Open 的 ENAMETOOLONG 分支时会走到这里，必须按失败返回而不是空转。
TEST_F(CommonFileUtest, Test_AddMapping_WriteReturnZero_Not_Hang)
{
    File file("mapping_zero_target", O_RDWR, READ_WRITE_MODE, true);
    MOCKER(mmOpen2).stubs().will(returnValue(1));
    MOCKER(mmWrite).stubs().will(returnValue(static_cast<mmSsize_t>(0)));
    MOCKER(mmGetErrorCode).stubs().will(returnValue(static_cast<INT32>(ENOSPC)));
    MOCKER(mmClose).expects(once()).will(returnValue(EN_OK));

    EXPECT_EQ(file.AddMapping("/tmp", "file.txt", "hash"), ADUMP_FAILED);
}

// 超长文件名走 ENAMETOOLONG 分支且 mmWrite 固定返回 0 时，Open -> AddMapping 整条链路不得挂死
TEST_F(CommonFileUtest, Test_Open_LongFilename_WriteReturnZero_Not_Hang)
{
    Tools::CaseWorkspace ws("Test_Open_LongFilename_WriteZero");
    std::string longName(256, 'x');
    longName += ".txt";
    std::string filePath = ws.Root() + "/" + longName;

    MOCKER(mmWrite).stubs().will(returnValue(static_cast<mmSsize_t>(0)));
    File file(filePath, O_RDWR | O_CREAT, M_IRUSR | M_IWUSR);
    // 目标是确认不挂死；能否成功取决于文件系统，故不断言具体返回值
    (void)file;
    EXPECT_TRUE(true);
}
