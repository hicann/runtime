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
    std::array<bool, FEATURE_MAX_VALUE> tmp{false};
    error = info.GetChipFeatureSet(CHIP_910_B_93, tmp);
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

void test_soc_info_by_soc_type_and_name(const rtSocType_t socType, const char_t *const socName)
{
    rtSocInfo_t socInfo = {SOC_END, CHIP_END, ARCH_END, nullptr};
    rtError_t result = RT_ERROR_NONE;
 
    // 1. get soc info by type
    result = DevInfoManage::Instance().GetSocInfo(socType, socInfo);
 
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(socInfo.socType, socType);
    EXPECT_EQ(socInfo.chipType, CHIP_DAVID);
    EXPECT_EQ(socInfo.archType, ARCH_V100);
    EXPECT_EQ(strcmp(socInfo.socName, socName), 0);
 
    // 2. get soc info by name
    result = DevInfoManage::Instance().GetSocInfo(socName, socInfo);
 
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(socInfo.socType, socType);
    EXPECT_EQ(socInfo.chipType, CHIP_DAVID);
    EXPECT_EQ(socInfo.archType, ARCH_V100);
    EXPECT_EQ(strcmp(socInfo.socName, socName), 0);
}
 
TEST_F(DevInfoManageTest, GetSocInfo_David_V120_test)
{
    const rtSocType_t socType_957c = SOC_ASCEND950PR_957C;
    const char_t *const socName_957c = "Ascend950PR_957c";
    test_soc_info_by_soc_type_and_name(socType_957c, socName_957c);
 
    const rtSocType_t socType_95a1 = SOC_ASCEND950DT_95A1;
    const char_t *const socName_95a1 = "Ascend950DT_95A1";
    test_soc_info_by_soc_type_and_name(socType_95a1, socName_95a1);
 
    const rtSocType_t socType_95a2 = SOC_ASCEND950DT_95A2;
    const char_t *const socName_95a2 = "Ascend950DT_95A2";
    test_soc_info_by_soc_type_and_name(socType_95a2, socName_95a2);
 
    const rtSocType_t socType_9595 = SOC_ASCEND950DT_9595;
    const char_t *const socName_9595 = "Ascend950DT_9595";
    test_soc_info_by_soc_type_and_name(socType_9595, socName_9595);
 
    const rtSocType_t socType_9596 = SOC_ASCEND950DT_9596;
    const char_t *const socName_9596 = "Ascend950DT_9596";
    test_soc_info_by_soc_type_and_name(socType_9596, socName_9596);
 
    const rtSocType_t socType_9585 = SOC_ASCEND950DT_9585;
    const char_t *const socName_9585 = "Ascend950DT_9585";
    test_soc_info_by_soc_type_and_name(socType_9585, socName_9585);
 
    const rtSocType_t socType_9586 = SOC_ASCEND950DT_9586;
    const char_t *const socName_9586 = "Ascend950DT_9586";
    test_soc_info_by_soc_type_and_name(socType_9586, socName_9586);
 
    const rtSocType_t socType_9583 = SOC_ASCEND950DT_9583;
    const char_t *const socName_9583 = "Ascend950DT_9583";
    test_soc_info_by_soc_type_and_name(socType_9583, socName_9583);
 
    const rtSocType_t socType_9571 = SOC_ASCEND950DT_9571;
    const char_t *const socName_9571 = "Ascend950DT_9571";
    test_soc_info_by_soc_type_and_name(socType_9571, socName_9571);
 
    const rtSocType_t socType_9573 = SOC_ASCEND950DT_9573;
    const char_t *const socName_9573 = "Ascend950DT_9573";
    test_soc_info_by_soc_type_and_name(socType_9573, socName_9573);
}
 
void test_dev_info_by_soc_name(const char_t *const socName)
{
    RtDevInfo devInfo = {CHIP_END, ARCH_END, PG_VER_END, nullptr};
 
    rtError_t result = DevInfoManage::Instance().GetDevInfo(socName, devInfo);
 
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(devInfo.chipType, CHIP_DAVID);
    EXPECT_EQ(devInfo.archType, ARCH_V100);
    EXPECT_EQ(strcmp(devInfo.socName, socName), 0);
}
 
TEST_F(DevInfoManageTest, get_david_v120_dev_info_test)
{
    const char_t *const socName_957c = "Ascend950PR_957c";
    test_dev_info_by_soc_name(socName_957c);
 
    const char_t *const socName_95a1 = "Ascend950DT_95A1";
    test_dev_info_by_soc_name(socName_95a1);
 
    const char_t *const socName_95a2 = "Ascend950DT_95A2";
    test_dev_info_by_soc_name(socName_95a2);
 
    const char_t *const socName_9595 = "Ascend950DT_9595";
    test_dev_info_by_soc_name(socName_9595);
 
    const char_t *const socName_9596 = "Ascend950DT_9596";
    test_dev_info_by_soc_name(socName_9596);
 
    const char_t *const socName_9585 = "Ascend950DT_9585";
    test_dev_info_by_soc_name(socName_9585);
 
    const char_t *const socName_9586 = "Ascend950DT_9586";
    test_dev_info_by_soc_name(socName_9586);
 
    const char_t *const socName_9583 = "Ascend950DT_9583";
    test_dev_info_by_soc_name(socName_9583);
 
    const char_t *const socName_9571 = "Ascend950DT_9571";
    test_dev_info_by_soc_name(socName_9571);
 
    const char_t *const socName_9573 = "Ascend950DT_9573";
    test_dev_info_by_soc_name(socName_9573);
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