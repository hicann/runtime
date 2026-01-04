/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "heterogenous.h"
#include "utils.h"
#define private public
#define protected public
#include "config.hpp"
#include "runtime.hpp"
#include "task_info.hpp"
#include "stream.hpp"
#undef protected
#undef private
#include "driver.hpp"


using namespace testing;
using namespace cce::runtime;
class CloudV2ConfigTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"Config test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"Config test end"<<std::endl;
    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

static void CreateACorrectIniFile(const char * const filename)
{
    std::ofstream myfile;
    myfile.open(filename);

    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=1\n";

    myfile.close();
}

static void CreateAWrongIniFile(const char * const filename)
{
    std::ofstream myfile;
    myfile.open(filename);

    myfile<<"111111\n";
    myfile<<"222222=1\n";

    myfile.close();
}

static void CreateAInvalidArgIniFile(const char * const filename)
{
    std::ofstream myfile;
    myfile.open(filename);

    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=A\n";

    myfile.close();
}

static void CreateAOutOfRangeIniFile(const char * const filename)
{
    std::ofstream myfile;
    myfile.open(filename);

    myfile<<"[Global Config]\n";
    myfile<<"IsHeterogenousMode=99999999999999999999999999999999999999\n";

    myfile.close();
}

static void RemoveFile(const char * const filename)
{
    const std::string cmd = "rm -rf ";
    const std::string myfile = filename;
    const std::string full_command = cmd + myfile;

    system(full_command.c_str());
}

static void MakeDir(const char * const dirName)
{
    const std::string cmd = "mkdir -p ";
    const std::string name = dirName;
    const std::string full_command = cmd + name;

    system(full_command.c_str());
}

TEST_F(CloudV2ConfigTest, test_config_ini_reader)
{
    const std::string key("IsHeterogenousMode=");

    const char * const file1 = "tmpCorrect.ini";
    CreateACorrectIniFile(file1);
    int32_t val = -1;
    const std::string strfile1(file1);
    bool ret = GetConfigIniValueInt32(strfile1, key, val);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(val, 1);
    RemoveFile(file1);

    const char * const file2 = "tmpWrong.ini";
    CreateAWrongIniFile(file2);
    const std::string strfile2(file2);
    val = -1;
    ret = GetConfigIniValueInt32(strfile2, key, val);
    EXPECT_EQ(ret, false);
    RemoveFile(file2);

    const char * const file3 = "tmpInvalidArg.ini";
    CreateAInvalidArgIniFile(file3);
    const std::string strfile3(file3);
    val = -1;
    ret = GetConfigIniValueInt32(strfile3, key, val);
    EXPECT_EQ(ret, false);
    RemoveFile(file3);

    const char * const file4 = "tmpOutOfRange.ini";
    CreateAOutOfRangeIniFile(file4);
    const std::string strfile4(file4);
    val = -1;
    ret = GetConfigIniValueInt32(strfile4, key, val);
    EXPECT_EQ(ret, false);
    RemoveFile(file4);

    ret = GetConfigIniValueInt32("", key, val);
    EXPECT_EQ(ret, false); // filename is empty
}

TEST_F(CloudV2ConfigTest, test_heterogenous_with_set_env)
{
    const std::string pathDirPrefix = "/tmp";
    const std::string pathDirPosfix = "/runtime/conf/";
    const std::string pathDir = pathDirPrefix + pathDirPosfix;
    const std::string pathFilename = "RuntimeConfig.ini";
    const std::string pathFull = pathDir + pathFilename;
    MakeDir(pathDir.c_str());
    CreateACorrectIniFile(pathFull.c_str());
    setenv("ASCEND_LATEST_INSTALL_PATH", pathDirPrefix.c_str(), 1);
    EXPECT_EQ(ReadHeterogenousModeFromConfigIni(), 1);
    RemoveFile(pathFull.c_str());
    unsetenv("ASCEND_LATEST_INSTALL_PATH");
}

TEST_F(CloudV2ConfigTest, test_heterogenous_without_set_env)
{
    EXPECT_EQ(ReadHeterogenousModeFromConfigIni(), 0);
}