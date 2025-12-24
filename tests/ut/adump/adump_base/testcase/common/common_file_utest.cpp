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
#include "mockcpp/mockcpp.hpp"
#include "case_workspace.h"
#include "adump_pub.h"
#include "file.h"

using namespace Adx;

constexpr mmMode_t READ_WRITE_MODE = M_IRUSR | M_IWUSR;
constexpr mmMode_t READ_ONLY_MODE = M_IRUSR;
constexpr mmMode_t WRITE_ONLY_MODE = M_IWUSR;


class CommonFileUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
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

    std::string writeOnlyFile = ws.Touch("write_only.txt");
    ws.Chmod("write_only.txt", "222");
    EXPECT_EQ(File(writeOnlyFile, M_RDONLY).IsFileOpen(), ADUMP_FAILED);
    EXPECT_EQ(File(writeOnlyFile, M_WRONLY).IsFileOpen(), ADUMP_SUCCESS);

    std::string readOnlyFile = ws.Touch("read_only.txt");
    ws.Chmod("read_only.txt", "444");
    EXPECT_EQ(File(readOnlyFile, M_WRONLY).IsFileOpen(), ADUMP_FAILED);
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

    // test write nullptr
    EXPECT_EQ(rwFile.Write(nullptr, 0), 0);
    EXPECT_EQ(rwFile.Write(nullptr, 2), EN_ERROR);

    // test write large data to file
    int64_t longLength = 3000000000; // more than 2G
    char* longCtx = (char*)malloc(longLength);
    EXPECT_GE(rwFile.Write(longCtx, longLength), 0);
    free(longCtx);
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

    // src file cann't read
    ws.Chmod(srcFileName, "222");
    EXPECT_EQ(File::Copy(srcPath, dstPath), ADUMP_FAILED);

    // dst file can't write
    ws.Chmod(srcFileName, "444");
    ws.Chmod(dstFileName, "444");
    EXPECT_EQ(File::Copy(srcPath, dstPath), ADUMP_FAILED);


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