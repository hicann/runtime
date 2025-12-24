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
#include "path.h"

using namespace Adx;

class CommonPathUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(CommonPathUtest, Test_Path_Construct)
{
    Path path;
    EXPECT_EQ(path.GetString(), std::string(""));
    EXPECT_EQ(path.Empty(), true);

    std::string pathStr = "/path/to/test";
    path = pathStr;
    EXPECT_EQ(path.GetString(), pathStr);
    EXPECT_EQ(path.Empty(), false);

    path += "sub_dir";
    EXPECT_EQ(path.GetString(), std::string("/path/to/test/sub_dir/"));

    path.Assign(pathStr);
    EXPECT_EQ(path.GetString(), pathStr);
}

TEST_F(CommonPathUtest, Test_Path_Append_And_Concat)
{
    std::string pathWithEndline = "/path/with/endline/";
    EXPECT_EQ(Path(pathWithEndline).Append("dir").GetString(), std::string("/path/with/endline/dir/"));
    EXPECT_EQ(Path(pathWithEndline).Append("/dir").GetString(), std::string("/path/with/endline/dir/"));
    EXPECT_EQ(Path(pathWithEndline).Append("dir/").GetString(), std::string("/path/with/endline/dir/"));
    EXPECT_EQ(Path(pathWithEndline).Append("///dir/").GetString(), std::string("/path/with/endline/dir/"));
    EXPECT_EQ(Path(pathWithEndline).Append(" /dir/ ").GetString(), std::string("/path/with/endline/dir/"));
    EXPECT_EQ(Path(pathWithEndline).Append(" ///// ").GetString(), std::string("/path/with/endline/"));

    std::string pathWithoutEndline = "/path/without/endline";
    EXPECT_EQ(Path(pathWithoutEndline).Append("dir").GetString(), std::string("/path/without/endline/dir/"));
    EXPECT_EQ(Path(pathWithoutEndline).Append("/dir").GetString(), std::string("/path/without/endline/dir/"));
    EXPECT_EQ(Path(pathWithoutEndline).Append("dir/").GetString(), std::string("/path/without/endline/dir/"));
    EXPECT_EQ(Path(pathWithoutEndline).Append("/dir///").GetString(), std::string("/path/without/endline/dir/"));
    EXPECT_EQ(Path(pathWithoutEndline).Append(" /dir/ ").GetString(), std::string("/path/without/endline/dir/"));
}

TEST_F(CommonPathUtest, Test_Path_Concat)
{
    std::string pathWithEndline = "/path/with/endline/";
    EXPECT_EQ(Path(pathWithEndline).Concat("sub_path").GetString(), std::string("/path/with/endline/sub_path"));
    EXPECT_EQ(Path(pathWithEndline).Concat("file_name.txt").GetString(), std::string("/path/with/endline/file_name.txt"));
    EXPECT_EQ(Path(pathWithEndline).Concat(" //// ").GetString(), std::string("/path/with/endline/"));
}

TEST_F(CommonPathUtest, Test_Path_FileApi)
{
    Path filePath("/path/to/file/filename.txt");
    EXPECT_EQ(filePath.GetFileName(), std::string("filename.txt"));
    EXPECT_EQ(filePath.GetExtension(), std::string(".txt"));

    // extension
    EXPECT_EQ(Path().AddExtension(".txt").GetExtension(), std::string(""));
    EXPECT_EQ(Path("/path/to/filename").AddExtension(".txt").GetExtension(), std::string(".txt"));
    EXPECT_EQ(Path("/path/to/filename").AddExtension("txt").GetExtension(), std::string(".txt"));
    EXPECT_EQ(Path("/path/to/filename").AddExtension(" .txt").GetExtension(), std::string(".txt"));
}

TEST_F(CommonPathUtest, Test_Path_ParentPath)
{
    EXPECT_EQ(Path("/path/to/file/filename.txt").ParentPath().GetString(), std::string("/path/to/file"));
    EXPECT_EQ(Path("/").ParentPath().GetString(), std::string("/"));
    EXPECT_EQ(Path("only_file.txt").ParentPath().GetString(), std::string(""));
    EXPECT_EQ(Path("/path/to/dir/").ParentPath().GetString(), std::string("/path/to/dir"));
    EXPECT_EQ(Path("/path/to/dir").ParentPath().GetString(), std::string("/path/to"));
}

TEST_F(CommonPathUtest, Test_Path_RealPath)
{
    Tools::CaseWorkspace ws("Test_Path_RealPath");

    EXPECT_EQ(Path().RealPath(), false);

    std::string filePath = ws.Touch("test_file.txt");
    EXPECT_EQ(Path(filePath).RealPath(), true);

    std::string noExistPath = ws.Root() + "/no_exist_path/";
    EXPECT_EQ(Path(noExistPath).RealPath(), false);
}

TEST_F(CommonPathUtest, Test_Path_With_Entity)
{
    Tools::CaseWorkspace ws("Test_Path_With_Entity");
    std::string filePath = ws.Touch("test_file.txt");
    std::string dirPath = ws.Mkdir("test_dir");

    EXPECT_EQ(Path(filePath).Exist(), true);
    EXPECT_EQ(Path(filePath).IsDirectory(), false);
    EXPECT_EQ(Path(dirPath).Exist(), true);
    EXPECT_EQ(Path(dirPath).IsDirectory(), true);

    EXPECT_EQ(Path().CreateDirectory(), false);

    std::string newDir = ws.Root() + "/new_dir";
    EXPECT_EQ(Path(newDir).CreateDirectory(), true);

    std::string recursionCreateDir = ws.Root() + "/path/to/dir";
    EXPECT_EQ(Path(recursionCreateDir).CreateDirectory(), false);
    EXPECT_EQ(Path(recursionCreateDir).CreateDirectory(true), true);
    EXPECT_EQ(Path(recursionCreateDir).IsDirectory(), true);
}