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

TEST_F(CommonPathUtest, Test_Path_HasParentDirSegment)
{
    EXPECT_EQ(Path::HasParentDirSegment(".."), true);
    EXPECT_EQ(Path::HasParentDirSegment("../file.bin"), true);
    EXPECT_EQ(Path::HasParentDirSegment("dir/../file.bin"), true);
    EXPECT_EQ(Path::HasParentDirSegment("dir/.."), true);

    EXPECT_EQ(Path::HasParentDirSegment("file.bin"), false);
    EXPECT_EQ(Path::HasParentDirSegment("my..file.bin"), false);
    EXPECT_EQ(Path::HasParentDirSegment("dir/..file.bin"), false);
    EXPECT_EQ(Path::HasParentDirSegment(".../file.bin"), false);
}

TEST_F(CommonPathUtest, Test_Path_IsUnderDirectory)
{
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/root"), true);
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/root/"), true);
    EXPECT_EQ(Path::IsUnderDirectory("/root/", "/root/sub"), true);
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/root/sub/deep"), true);

    // 前缀相同但不是同一路径段，不能误判为子路径
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/root_evil"), false);
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/rootevil/sub"), false);
    EXPECT_EQ(Path::IsUnderDirectory("/root/sub", "/root"), false);
    EXPECT_EQ(Path::IsUnderDirectory("/root", "/other"), false);

    EXPECT_EQ(Path::IsUnderDirectory("", "/root"), false);
    EXPECT_EQ(Path::IsUnderDirectory("/root", ""), false);
}

TEST_F(CommonPathUtest, Test_Path_BuildFullPathUnderRoot)
{
    Tools::CaseWorkspace ws("Test_Path_BuildFullPathUnderRoot");
    std::string root = ws.Mkdir("dump_root");
    std::string canonicalFile;

    EXPECT_EQ(Path::BuildFullPathUnderRoot("", "file.bin", canonicalFile), false);
    EXPECT_EQ(Path::BuildFullPathUnderRoot(root, "", canonicalFile), false);
    EXPECT_EQ(Path::BuildFullPathUnderRoot(root, "../escape.bin", canonicalFile), false);

    // 正常场景：文件落在根目录下，父目录被自动创建
    EXPECT_EQ(Path::BuildFullPathUnderRoot(root, "file.bin", canonicalFile), true);
    EXPECT_EQ(canonicalFile, Path(root).Concat("file.bin").GetString());

    EXPECT_EQ(Path::BuildFullPathUnderRoot(root, "sub/dir/file.bin", canonicalFile), true);
    EXPECT_EQ(Path::IsUnderDirectory(root, canonicalFile), true);
    EXPECT_EQ(Path(root).Concat("sub/dir").GetString(), Path(canonicalFile).ParentPath().GetString());

    // 根目录不存在时会被递归创建，仍视为合法
    std::string newRoot = ws.Root() + "/no_exist_root";
    EXPECT_EQ(Path::BuildFullPathUnderRoot(newRoot, "file.bin", canonicalFile), true);
    EXPECT_EQ(Path::IsUnderDirectory(newRoot, canonicalFile), true);
}

TEST_F(CommonPathUtest, Test_Path_BuildFullPathUnderRoot_RejectSymlinkEscape)
{
    Tools::CaseWorkspace ws("Test_Path_BuildFullPathUnderRoot_Symlink");
    std::string root = ws.Mkdir("dump_root");
    std::string outside = ws.Mkdir("outside_dir");
    std::string canonicalFile;

    // 在落盘根目录下预置一个指向外部的软链接目录
    std::string linkPath = Path(root).Concat("escape_link").GetString();
    ASSERT_EQ(symlink(outside.c_str(), linkPath.c_str()), 0);

    // relativeFile 不含 '..'，但经软链接解析后逃逸出 rootPath，必须被拒绝
    EXPECT_EQ(Path::BuildFullPathUnderRoot(root, "escape_link/file.bin", canonicalFile), false);
}
