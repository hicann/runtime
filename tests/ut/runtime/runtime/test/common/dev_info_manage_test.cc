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
#include "platform_manager_v2.h"
#include "feature_type.h"

using namespace testing;
using namespace cce::runtime;

class DevInfoManageTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
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
    std::array<bool, FEATURE_MAX_VALUE> tmp{false};
    rtError_t error = info.GetChipFeatureSet(CHIP_910_B_93, tmp);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    ret = info.RegPlatformSoNameInfo(CHIP_910_B_93, "lib");
    EXPECT_EQ(ret, false);
    std::string str;
    error = info.GetPlatformSoName(CHIP_910_B_93, str);
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

TEST_F(DevInfoManageTest, GetChipTypeFromPlatform)
{
    rtChipType_t chipType = CHIP_END;
    rtError_t result = GetChipTypeFromPlatform("Ascend910A", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_CLOUD);

    result = GetChipTypeFromPlatform("Ascend610Lite", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_610LITE);

    result = GetChipTypeFromPlatform("BS9SX1AA", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_ADC);

    result = GetChipTypeFromPlatform("KirinX90", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_X90);

    result = GetChipTypeFromPlatform("Kirin9030", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_9030);

    result = GetChipTypeFromPlatform("KirinDev0000", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_DEV_0000);

    result = GetChipTypeFromPlatform("KirinDev0001", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_DEV_0001);

    result = GetChipTypeFromPlatform("KirinDev0002", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_DEV_0002);

    result = GetChipTypeFromPlatform("KirinDev0003", chipType);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(chipType, CHIP_DEV_0003);
}

TEST_F(DevInfoManageTest, GetNpuArchByName)
{
    const char_t* const socName_910B1 = "Ascend910B1";
    int32_t hardwareNpuArch;
    rtError_t result = GetNpuArchByName(socName_910B1, &hardwareNpuArch);
    EXPECT_EQ(result, RT_ERROR_NONE);
    EXPECT_EQ(hardwareNpuArch, 2201);

    const char_t* const socName_err = "Ascend";
    result = GetNpuArchByName(socName_err, &hardwareNpuArch);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE);
}

TEST_F(DevInfoManageTest, GetPlatformInfoWithNullInput)
{
    rtChipType_t chipType = CHIP_END;
    int32_t hardwareNpuArch = 0;
    EXPECT_EQ(GetChipTypeFromPlatform(nullptr, chipType), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(GetNpuArchByName(nullptr, &hardwareNpuArch), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(GetNpuArchByName("Ascend910B1", nullptr), RT_ERROR_INVALID_VALUE);
}

TEST_F(DevInfoManageTest, GetChipTypeFromPlatformInvalid)
{
    rtChipType_t chipType = CHIP_END;
    rtError_t result = GetChipTypeFromPlatform("ChipTypeMissing", chipType);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE);

    result = GetChipTypeFromPlatform("ChipTypeInvalid", chipType);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE);

    result = GetChipTypeFromPlatform("ChipTypeOutOfRange", chipType);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE);

    result = GetChipTypeFromPlatform("ChipTypeQueryError", chipType);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE);
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinX90)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_X90, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinX90)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_X90, out);
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

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirinX90)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_X90, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_X90";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirin9030)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_9030, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirin9030)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_9030, out);
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

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirin9030)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_9030, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_9030";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinDev0000)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_DEV_0000, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinDev0000)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0000, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirinDev0000)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_DEV_0000, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirinDev0000)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0000, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirinDev0000)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_DEV_0000, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_DEV_0000";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinDev0001)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_DEV_0001, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinDev0001)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0001, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirinDev0001)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_DEV_0001, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirinDev0001)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0001, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirinDev0001)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_DEV_0001, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_DEV_0001";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinDev0002)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_DEV_0002, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinDev0002)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0002, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirinDev0002)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_DEV_0002, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirinDev0002)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0002, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirinDev0002)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_DEV_0002, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_DEV_0002";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageSocInfoKirinDev0003)
{
    DevInfoManage info;
    std::string soName;
    rtError_t result = info.GetPlatformSoName(CHIP_DEV_0003, soName);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageDevInfoKirinDev0003)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0003, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureKirinDev0003)
{
    DevInfoManage info;
    bool ret = info.IsSupportChipFeature(CHIP_DEV_0003, RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL);
    EXPECT_EQ(ret, false);
}

TEST_F(DevInfoManageTest, DevInfoManageDevPropertiesKirinDev0003)
{
    DevInfoManage info;
    DevProperties out;
    rtError_t result = info.GetDevProperties(CHIP_DEV_0003, out);
    EXPECT_NE(result, RT_ERROR_NONE);
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureAllFalseKirinDev0003)
{
    DevInfoManage info;
    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(CHIP_DEV_0003, features);
    EXPECT_EQ(result, RT_ERROR_NONE);

    for (uint32_t i = 0; i < FEATURE_MAX_VALUE; i++) {
        EXPECT_EQ(features[i], false) << "Feature[" << i << "] should be false for CHIP_DEV_0003";
    }
}

TEST_F(DevInfoManageTest, DevInfoManageChipFeatureExtSegmentOutOfRange)
{
    DevInfoManage info;
    constexpr rtChipType_t EXT_CHIP_OUT_OF_RANGE = static_cast<rtChipType_t>(CHIP_EXT_END + 5);

    std::array<bool, FEATURE_MAX_VALUE> features;
    rtError_t result = info.GetChipFeatureSet(EXT_CHIP_OUT_OF_RANGE, features);
    EXPECT_EQ(result, RT_ERROR_INVALID_VALUE) << "Ext chip out of range should return error";
}

TEST_F(DevInfoManageTest, DevInfoManageRegChipFeatureExtSegmentOutOfRange)
{
    DevInfoManage info;
    constexpr rtChipType_t TEST_EXT_CHIP_OUT_OF_RANGE = static_cast<rtChipType_t>(CHIP_EXT_END + 1);

    std::unordered_set<RtOptionalFeatureType> featureSet = {
        RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P};

    bool ret = info.RegChipFeatureSet(TEST_EXT_CHIP_OUT_OF_RANGE, featureSet);
    EXPECT_EQ(ret, false) << "Register ext chip out of range should fail";
}
