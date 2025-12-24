/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "dev_info_manage.h"
#include "soc_info.h"

using namespace testing;
using namespace cce::runtime;

class DevInfoManageTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

TEST_F(DevInfoManageTest, DevInfoManageDestroy)
{
    DevInfoManage info;
    info.SetDestroy();
    std::unordered_set<RtOptionalFeatureType> s;
    bool ret = info.RegChipFeatureSet(CHIP_910_B_93, s);
    EXPECT_EQ(ret, false);
    ret = info.IsSupportChipFeature(CHIP_910_B_93, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
    rtSocInfo_t soc;
    ret = info.RegisterSocInfo(soc);
    EXPECT_EQ(ret, false);
    rtSocInfo_t soc2[2];
    ret = info.BatchRegSocInfo(soc2, 2);
    EXPECT_EQ(ret, false);
    rtError_t error = info.GetSocInfo(nullptr, soc);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = info.GetSocInfo(CHIP_910_B_93, ARCH_V100, soc);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = info.GetChipFeatureSet(CHIP_910_B_93, s);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ret = info.RegPlatformSoNameInfo(CHIP_910_B_93, "lib");
    EXPECT_EQ(ret, false);
    std::string str;
    error = info.GetPlatformSoName(CHIP_910_B_93, str);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = info.GetSocInfo(0, soc);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(DevInfoManageTest, DevInfoManagePlatform)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_910_B_93, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
    bool ret = info.RegPlatformSoNameInfo(CHIP_910_B_93, "libruntime.so");
    EXPECT_EQ(ret, true);
    result = info.GetPlatformSoName(CHIP_910_B_93, soName);
    EXPECT_EQ(soName, std::string("libruntime.so"));
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfo)
{
    DevInfoManage info;
    RtDevInfo i = {CHIP_910_B_93, ARCH_V100, PG_VER_BIN10, "Ascend910_9362"};
    bool ret = info.RegisterDevInfo(i);
    EXPECT_EQ(ret, true);
    std::string soName;
    RtDevInfo out;
    rtError_t result = info.GetDevInfo("Ascend910_9362", out);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(out.archType, ARCH_V100);
    EXPECT_EQ(out.chipType, CHIP_910_B_93);
    EXPECT_EQ(out.pgType, PG_VER_BIN10);
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfo)
{
    DevInfoManage info;
    rtSocInfo_t s = {SOC_ASCEND910B1, CHIP_910_B_93, ARCH_C220, "Ascend910B1"};
    bool ret = info.RegisterSocInfo(s);
    EXPECT_EQ(ret, true);
    rtSocInfo_t out;
    rtError_t result = info.GetSocInfo("Ascend910B1", out);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(out.archType, ARCH_C220);
    EXPECT_EQ(out.chipType, CHIP_910_B_93);
    EXPECT_EQ(out.socType, SOC_ASCEND910B1);
}

TEST_F(DevInfoManageTest, GetSocInfo)
{
    rtSocInfo_t s = {SOC_ASCEND910B1, CHIP_910_B_93, ARCH_C220, "Ascend910_9391"};
    rtError_t result = GetSocInfoByName("Ascend910_9372", s);
    EXPECT_EQ(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinX90)
{
    DevInfoManage info;
    rtSocInfo_t out;
    rtError_t result = info.GetSocInfo("KirinX90", out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinX90)
{
    DevInfoManage info;
    RtDevInfo out;
    rtError_t result = info.GetDevInfo("KirinX90", out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirinX90)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_X90, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirinX90)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_X90, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirin9030)
{
    DevInfoManage info;
    rtSocInfo_t out;
    rtError_t result = info.GetSocInfo("Kirin9030", out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirin9030)
{
    DevInfoManage info;
    RtDevInfo out;
    rtError_t result = info.GetDevInfo("Kirin9030", out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirin9030)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_9030, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirin9030)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_9030, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}