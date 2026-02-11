/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_api.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "data_manager.h"
#include "toolchain/prof_api.h"
#include "errno/error_code.h"
#include "osal/osal.h"
#include "platform_feature.h"
#include "platform.h"
#include "hal/hal_dsmi.h"
#include "utils/utils.h"

class UtilsUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(UtilsUtest, MsprofRealloc)
{
    bool boolStatus = true;
    do {
        void* oldPtr = OsalMalloc(10);
        if (oldPtr == nullptr) {
            boolStatus = false;
            EXPECT_TRUE(boolStatus);
            break;
        }
        void* testRealloc = MsprofRealloc(oldPtr, 10, 0);
        if (testRealloc == nullptr) {
            boolStatus = false;
        }
        EXPECT_FALSE(boolStatus);

        boolStatus = true;
        testRealloc = MsprofRealloc(oldPtr, 10, 20);
        if (testRealloc == nullptr) {
            boolStatus = false;
        }
        EXPECT_FALSE(boolStatus);
    } while (0);
}

TEST_F(UtilsUtest, RelativePathToAbsolutePath)
{
    bool boolStatus = true;
    char* path = "/home/testDir";
    int32_t resLen = 100;
    char* resultDir = (char *)OsalMalloc(resLen);
    RelativePathToAbsolutePath(path, resultDir, resLen);
    if (strcmp(resultDir, "/home/testDir") != 0) {
        boolStatus = false;
    }
    free(resultDir);
    EXPECT_TRUE(boolStatus);
}

TEST_F(UtilsUtest, CheckStringNumRange)
{
    EXPECT_FALSE(CheckStringNumRange("", "100"));
    EXPECT_FALSE(CheckStringNumRange("1000", "100"));
    EXPECT_FALSE(CheckStringNumRange("-10", "100"));
}

TEST_F(UtilsUtest, CheckUint32ToChar)
{
    char* str = TransferUint32ToString(0);
    EXPECT_EQ(strcmp(str, "0"), 0);
    free(str);

    str = TransferUint32ToString(10);
    EXPECT_EQ(strcmp(str, "10"), 0);
    free(str);

    str = TransferUint32ToString(4294967295);
    EXPECT_EQ(strcmp(str, "4294967295"), 0);
    free(str);
}

TEST_F(UtilsUtest, CheckUint64ToChar)
{
    char* str = TransferUint64ToString(0);
    EXPECT_EQ(strcmp(str, "0"), 0);
    free(str);

    str = TransferUint64ToString(10);
    EXPECT_EQ(strcmp(str, "10"), 0);
    free(str);

    str = TransferUint64ToString(18446744073709551615);
    EXPECT_EQ(strcmp(str, "18446744073709551615"), 0);
    free(str);
}

TEST_F(UtilsUtest, IsDirAccessible) {
    std::string path = "/notDir";
    EXPECT_EQ(false, IsDirAccessible(path.c_str()));

    MOCKER(OsalAccess2).stubs().will(returnValue(PROFILING_FAILED));
    path = "/tmp";
    EXPECT_EQ(false, IsDirAccessible(path.c_str()));
}

TEST_F(UtilsUtest, MsprofSysCycleTimeBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    MOCKER(HalGetHostFreq)
        .stubs()
        .will(returnValue((uint32_t)1000));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    EXPECT_EQ(PlatformHostFreqIsEnable(), true);

    MOCKER(PlatformHostFreqIsEnable)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    uint64_t cycleTime = MsprofSysCycleTime();
    EXPECT_EQ((cycleTime > 0), true);
    cycleTime = MsprofSysCycleTime();
    EXPECT_EQ((cycleTime > 0), true);

    PlatformFinalize(&count);
}

TEST_F(UtilsUtest, GetSelfPathTest)
{
    MOCKER(readlink)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(4097));
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(false, GetSelfPath("./"));
}
