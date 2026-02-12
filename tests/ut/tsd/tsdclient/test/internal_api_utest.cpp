/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include <iostream>
#include <vector>
#include <stdlib.h>
#include <cstdio>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa/mmpa_api.h"
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "inc/internal_api.h"
#undef private
#undef protected

using namespace tsd;

class InternalAPITest : public testing::Test
{
protected:
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


namespace {
    class ThrowClassExample
    {
    public:
        ThrowClassExample() {
            throw 3;
        }
        ThrowClassExample(int) {
            throw 4;
        }
        ThrowClassExample(int, int) {
            throw 5;
        }
        ~ThrowClassExample(){

        }
    };

    class NoThrowClassExample
    {
    public:
        NoThrowClassExample() {
        }
        NoThrowClassExample(int) {
        }
        NoThrowClassExample(int, int) {
        }
        ~NoThrowClassExample(){

        }
    };
}

TEST_F(InternalAPITest, Trim)
{
    std::string soName = " libtsdclient.so ";
    Trim(soName);
    EXPECT_EQ(soName, "libtsdclient.so");
}

TEST_F(InternalAPITest, CheckRealPath_001)
{
    std::string path  = "";
    MOCKER(realpath).stubs().will(returnValue(&path));
    bool ret = CheckRealPath(path);
    EXPECT_EQ(ret, false);
}

TEST_F(InternalAPITest, CheckRealPath_002)
{
    std::string path  = "test";
    MOCKER(memset_s).stubs().will(returnValue(-1));
    bool ret = CheckRealPath(path);
    EXPECT_EQ(ret, false);
}

TEST_F(InternalAPITest, GetConfigIniValueInt32)
{
    const std::string dirName = "./tsd/runtime/conf/";
    const std::string fileName = dirName + std::to_string(getpid()) + "1RuntimeConfig.ini";
    const std::string mkDirCmd = "mkdir -p " + dirName;
    system(mkDirCmd.c_str());

    std::ofstream myfile;
    myfile.open(fileName);
    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=1\n";
    myfile<<"AicpuSdRunMode=1\n";
    myfile.close();

    int32_t val = 0;
    EXPECT_TRUE(GetConfigIniValueInt32(fileName, "AicpuSdRunMode=", val));
    EXPECT_EQ(val, 1);

    const std::string rmFileCmd = "rm -f " + fileName;
    system(rmFileCmd.c_str());
}

TEST_F(InternalAPITest, GetConfigIniValueInt32WithoutFile)
{
    const std::string dirName = "./tsd/runtime/conf/";
    const std::string fileName = dirName + std::to_string(getpid()) + "2RuntimeConfig.ini";
    int32_t val = 0;
    EXPECT_FALSE(GetConfigIniValueInt32(fileName, "AicpuSdRunMode=", val));
}

TEST_F(InternalAPITest, GetConfigIniValueInt32WithoutRunMode)
{
    const std::string dirName = "./tsd/runtime/conf/";
    const std::string fileName = dirName + std::to_string(getpid()) + "3RuntimeConfig.ini";
    const std::string mkDirCmd = "mkdir -p " + dirName;
    system(mkDirCmd.c_str());

    std::ofstream myfile;
    myfile.open(fileName);
    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=1\n";
    myfile.close();

    int32_t val = 0;
    EXPECT_FALSE(GetConfigIniValueInt32(fileName, "AicpuSdRunMode=", val));

    const std::string rmFileCmd = "rm -f " + fileName;
    system(rmFileCmd.c_str());
}

TEST_F(InternalAPITest, GetConfigIniValueInt32WithInvalidRunMode)
{
    const std::string dirName = "./tsd/runtime/conf/";
    const std::string fileName = dirName + std::to_string(getpid()) + "4RuntimeConfig.ini";
    const std::string mkDirCmd = "mkdir -p " + dirName;
    system(mkDirCmd.c_str());

    std::ofstream myfile;
    myfile.open(fileName);
    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=1\n";
    myfile<<"AicpuSdRunMode=a\n";
    myfile.close();

    const std::string filePath = "/tt/ss/a";
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(remove).stubs().will(returnValue(0)).then(returnValue(1));
    RemoveOneFile(filePath);
    RemoveOneFile(filePath);

    int32_t val = 0;
    EXPECT_FALSE(GetConfigIniValueInt32(fileName, "AicpuSdRunMode=", val));

    const std::string rmFileCmd = "rm -f " + fileName;
    system(rmFileCmd.c_str());
}

TEST_F(InternalAPITest, IsDirEmptyTest)
{
    std::string path = "/tmp/test_tsd1";
    EXPECT_TRUE(IsDirEmpty(path));

    const std::string dirName = "./tsd/runtime/conf/";
    const std::string mkDirCmd = "mkdir -p " + dirName;
    const std::string fileName = dirName + std::to_string(getpid()) + "4RuntimeConfig.ini";
    system(mkDirCmd.c_str());

    std::ofstream myfile;
    myfile.open(fileName);
    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=1\n";
    myfile<<"AicpuSdRunMode=a\n";
    myfile.close();

    EXPECT_FALSE(IsDirEmpty(dirName));

    const std::string rmFileCmd = "rm -f " + fileName;
    system(rmFileCmd.c_str());
}