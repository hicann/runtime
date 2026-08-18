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
#include "config_manager.h"
#include "feature_manager.h"
#include "error_code.h"
#include "uploader_mgr.h"

using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;

class FeatureManagerTest : public testing::Test {
protected:
    void SetUp() override { FeatureManager::instance()->Uninit(); }

    void TearDown() override { FeatureManager::instance()->Uninit(); }
};

TEST_F(FeatureManagerTest, InitWillReturnSuccessWhenInitFirstTime)
{
    int32_t ret = FeatureManager::instance()->Init();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(FeatureManagerTest, InitWillReturnSuccessWhenInitRepeated)
{
    int32_t ret1 = FeatureManager::instance()->Init();
    EXPECT_EQ(ret1, PROFILING_SUCCESS);

    int32_t ret2 = FeatureManager::instance()->Init();
    EXPECT_EQ(ret2, PROFILING_SUCCESS);
}

TEST_F(FeatureManagerTest, GetIncompatibleFeaturesWillReturnV1FeaturesWhenIsV2False)
{
    ASSERT_EQ(FeatureManager::instance()->Init(), PROFILING_SUCCESS);

    size_t featureSize = 0;
    FeatureRecord* features = FeatureManager::instance()->GetIncompatibleFeatures(&featureSize, false);

    ASSERT_NE(features, nullptr);
    EXPECT_EQ(featureSize, 2);
    EXPECT_STREQ(features[0].featureName, "ATTR");
    EXPECT_STREQ(features[0].info.compatibility, "1");
    EXPECT_STREQ(features[0].info.featureVersion, "2");
    EXPECT_STREQ(features[0].info.affectedComponent, "all");
    EXPECT_STREQ(features[0].info.affectedComponentVersion, "all");
    EXPECT_STREQ(features[0].info.infoLog, "It not support feature: ATTR!");
    EXPECT_STREQ(features[1].featureName, "AICORE_SHAPE");
    EXPECT_STREQ(features[1].info.compatibility, "1");
    EXPECT_STREQ(features[1].info.featureVersion, "1");
    EXPECT_STREQ(features[1].info.affectedComponent, "all");
    EXPECT_STREQ(features[1].info.affectedComponentVersion, "all");
}

TEST_F(FeatureManagerTest, GetIncompatibleFeaturesWillReturnV2FeaturesWhenIsV2TrueAndPlatformIsV410)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));

    ASSERT_EQ(FeatureManager::instance()->Init(), PROFILING_SUCCESS);

    size_t featureSize = 0;
    FeatureRecord* features = FeatureManager::instance()->GetIncompatibleFeatures(&featureSize, true);

    ASSERT_NE(features, nullptr);
    EXPECT_EQ(featureSize, 3);

    EXPECT_STREQ(features[0].featureName, "ATTR");
    EXPECT_STREQ(features[0].info.compatibility, "1");
    EXPECT_STREQ(features[0].info.infoLog, "It not support feature: ATTR!");
    EXPECT_STREQ(features[1].featureName, "MemoryAccess");
    EXPECT_STREQ(features[1].info.compatibility, "1");
    EXPECT_STREQ(features[1].info.infoLog, "It not support feature: MEMORY_ACCESS!");
    EXPECT_STREQ(features[2].featureName, "AICORE_SHAPE");
    EXPECT_STREQ(features[2].info.compatibility, "1");
    EXPECT_STREQ(features[2].info.featureVersion, "1");

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType).reset();
}

TEST_F(FeatureManagerTest, GetIncompatibleFeaturesWillReturnV1FeaturesWhenIsV2TrueButPlatformIsUnknown)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::MINI_TYPE));

    ASSERT_EQ(FeatureManager::instance()->Init(), PROFILING_SUCCESS);

    size_t featureSize = 0;
    FeatureRecord* features = FeatureManager::instance()->GetIncompatibleFeatures(&featureSize, true);

    ASSERT_NE(features, nullptr);
    EXPECT_EQ(featureSize, 2);
    EXPECT_STREQ(features[0].featureName, "ATTR");
    EXPECT_STREQ(features[1].featureName, "AICORE_SHAPE");
    EXPECT_STREQ(features[1].info.featureVersion, "1");

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType).reset();
}

TEST_F(FeatureManagerTest, GetIncompatibleFeaturesWillReturnNullptrWhenFeaturesSizeIsNull)
{
    ASSERT_EQ(FeatureManager::instance()->Init(), PROFILING_SUCCESS);

    FeatureRecord* features = FeatureManager::instance()->GetIncompatibleFeatures(nullptr, true);

    EXPECT_EQ(features, nullptr);
}

TEST_F(FeatureManagerTest, UninitWillReturnSuccessWhenUninitAfterInit)
{
    ASSERT_EQ(FeatureManager::instance()->Init(), PROFILING_SUCCESS);

    FeatureManager::instance()->Uninit();

    int32_t ret = FeatureManager::instance()->Init();
    EXPECT_EQ(ret, PROFILING_SUCCESS); // 反初始化后可重新初始化
    FeatureManager::instance()->Uninit();
}
