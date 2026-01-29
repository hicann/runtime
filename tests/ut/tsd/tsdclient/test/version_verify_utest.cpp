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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "inc/version_verify.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;
class VersionVerifyTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before VersionVerifyTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After VersionVerifyTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(VersionVerifyTest, PeerVersionCheckFalse)
{
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    HDCMessage::VersionInfo peer_version_info;
    peer_version_info.set_version(0);
    bool ret = versionVerify->PeerVersionCheck(peer_version_info);
    EXPECT_EQ(false, ret);
}

TEST_F(VersionVerifyTest, SpecialFeatureCheck)
{
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    versionVerify->peerFeatureList_[HDCMessage::TSD_START_PROC_MSG] = {"test1"};
    bool ret = versionVerify->SpecialFeatureCheck(HDCMessage::TSD_START_PROC_MSG);
    EXPECT_EQ(false, ret);
}

TEST_F(VersionVerifyTest, SetVersionInfo)
{
    HDCMessage msg;
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    versionVerify->SetVersionInfo(msg);
    uint32_t version = msg.mutable_version_info()->version();
    EXPECT_EQ(version, 1230);

    versionVerify->ParseVersionInfo(msg.version_info());
    EXPECT_EQ(versionVerify->peerFeatureList_.empty(), false);

}
TEST_F(VersionVerifyTest, PeerVersionCheckTrue)
{
    HDCMessage::VersionInfo peerVersionInfo;
    peerVersionInfo.set_version(1230);
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    bool ret = versionVerify->PeerVersionCheck(peerVersionInfo);
    EXPECT_EQ(ret, true);
}

TEST_F(VersionVerifyTest, SpecialFeatureCheck_fail_001)
{
    HDCMessage::VersionInfo peerVersionInfo;
    const HDCMessage::MsgType msgType = HDCMessage::TSD_OPEN_SUB_PROC_RSP;
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    versionVerify->alreadyCheckedList_.insert(std::make_pair(msgType, false));
    bool ret = versionVerify->SpecialFeatureCheck(msgType);
    EXPECT_EQ(ret, false);
}

TEST_F(VersionVerifyTest, SpecialFeatureCheck_fail_002)
{
    HDCMessage::VersionInfo peerVersionInfo;
    const HDCMessage::MsgType msgType = HDCMessage::TSD_OPEN_SUB_PROC_RSP;
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    versionVerify->peerFeatureList_.clear();
    bool ret = versionVerify->SpecialFeatureCheck(msgType);
    EXPECT_EQ(ret, true);
}

TEST_F(VersionVerifyTest, SpecialFeatureCheck_for_compatible_scenario)
{
    std::shared_ptr<VersionVerify> versionVerify = std::make_shared<VersionVerify>();
    // attention: 模拟老版驱动device侧支持的feature list，不可修改
    versionVerify->peerFeatureList_[HDCMessage::TSD_CHECK_PACKAGE] = {"check before send aicpu package"};
    versionVerify->peerFeatureList_[HDCMessage::TSD_START_QS_MSG] = {"check before send open qs message"};
    versionVerify->peerFeatureList_[HDCMessage::TSD_CHECK_PACKAGE_RETRY] = {"get check code retry"};

    EXPECT_TRUE(versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE));
    EXPECT_TRUE(versionVerify->SpecialFeatureCheck(HDCMessage::TSD_START_QS_MSG));
    EXPECT_TRUE(versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE_RETRY));
    // attention:这里模拟的是peerFeatureList_和SpecialFeatureCheck里面需要校验的g_tsdFeatureList两个内容不匹配的场景
    // 修改g_tsdFeatureList会导致这种场景，需要注意
    versionVerify->peerFeatureList_.clear();
    versionVerify->alreadyCheckedList_.clear();
    versionVerify->peerFeatureList_[HDCMessage::TSD_START_QS_MSG] = {"check before send open qs message"};
    versionVerify->peerFeatureList_[HDCMessage::TSD_CHECK_PACKAGE_RETRY] = {"get check code retry"};
    versionVerify->peerFeatureList_[HDCMessage::TSD_CHECK_PACKAGE] = {"check before send aicpu package error msg"};
    EXPECT_FALSE(versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE));
}