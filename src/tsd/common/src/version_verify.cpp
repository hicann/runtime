/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/version_verify.h"
#include "inc/log.h"
namespace tsd {
namespace {
    // 如果修改了涉及tsdclient和tsdaemon需要配合的特性，则需要在此map中增加对应的特性信息，防止client或server单独升级导致运行结果不可控
    // map的关键字是建立通信的类型，值是当前版本影响兼容性所新增、修改、删除的特性列表
    // 每次更新版本号的时候，可以清空map，该map仅用于存放同一版本内的特性变化
    // 示例 {HDCMessage::TSD_START_PROC_MSG, {"feature1","feature2"}}
    // 由于1，2包和3-8包存在新老版本使用问题，兼容校验是feature_list字符串比较，所以这里的字符串千万不能更改，更改会出现新老版本兼容性问题
    std::map<HDCMessage::MsgType, std::set<std::string>> g_tsdFeatureList = {
        {HDCMessage::TSD_CHECK_PACKAGE, {"check before send aicpu package"}},
        {HDCMessage::TSD_START_QS_MSG, {"check before send open qs message"}},
        {HDCMessage::TSD_CHECK_PACKAGE_RETRY, {"get check code retry"}},
    };
    // 版本号不能修改，修改会导致client和server版本不一致。
    // 新的server端虽然支持TSD_CHECK_PACKAGE消息，但是旧的client会认为不支持，无法发送。
    constexpr uint32_t TSD_VERSION = 1230U;
}

/**
 * @ingroup VersionVerify
 * @param [in] msg : message send by client
 * @brief add version info to message which client will send to server
 */
void VersionVerify::SetVersionInfo(HDCMessage& msg) const
{
    // client need send it's version info to server once
    HDCMessage::VersionInfo * const verInfo = msg.mutable_version_info();
    TSD_RUN_INFO("VersionVerify: send client version to server");
    if (verInfo == nullptr) {
        return;
    }
    verInfo->set_version(TSD_VERSION);
    for (const auto &iter : g_tsdFeatureList) {
        HDCMessage::VersionInfo::FeatureList * const fl = verInfo->add_feature_list();
        if (fl == nullptr) {
            return;
        }
        fl->set_msg_type(iter.first);
        std::string serializedFeatures; // for log print
        for (const std::string &feature : iter.second) {
            serializedFeatures = serializedFeatures + feature;
            fl->add_feature(feature);
        }
        TSD_INFO("send feature_info:{msgType:%u, features:{%s}}", iter.first, serializedFeatures.c_str());
    }
}

/**
 * @ingroup VersionVerify
 * @param [in] peerVersionInfo : client version info
 * @brief check whether client and server can establish communication
 */
bool VersionVerify::PeerVersionCheck(const HDCMessage::VersionInfo& peerVersionInfo)
{
    if (peerVersionInfo.version() <= 0U) {
        TSD_ERROR("VersionVerify: Get peer version[%u] is invalid", peerVersionInfo.version());
        return false;
    }
    TSD_RUN_INFO("VersionVerify: Check client version info, server[%u], client[%u]",
                 peerVersionInfo.version(), TSD_VERSION);
    ParseVersionInfo(peerVersionInfo);
    peerVersion_ = static_cast<uint32_t>(peerVersionInfo.version());
    return peerVersion_ == TSD_VERSION;
}

/**
 * @ingroup VersionVerify
 * @param [in] peerVersionInfo : client version info
 * @brief parse and save version info send from client
 */
void VersionVerify::ParseVersionInfo(const HDCMessage::VersionInfo& peerVersionInfo)
{
    for (int32_t i = 0; i < peerVersionInfo.feature_list_size(); i++) {
        const HDCMessage::VersionInfo::FeatureList &peerFeatureList = peerVersionInfo.feature_list(i);
        std::set<std::string> feature;
        for (int32_t j = 0; j < peerFeatureList.feature_size(); j++) {
            (void)feature.insert(peerFeatureList.feature(j));
        }
        peerFeatureList_[peerFeatureList.msg_type()] = feature;
    }
    TSD_RUN_INFO("VersionVerify: pass client version info success");
}

/**
 * @ingroup VersionVerify
 * @param [in] msgType : communication type
 * @param [in] peer_version_info : client version info
 * @brief check whether this type of communication can be understood by server
 */
bool VersionVerify::SpecialFeatureCheck(const HDCMessage::MsgType& msgType)
{
    // test message need not check
    if ((msgType == HDCMessage::TEST_HDC_SEND) || (msgType == HDCMessage::TEST_HDC_RSP)) {
        return true;
    }
    // msgType only need check once
    const auto alreadyCheckedIter = alreadyCheckedList_.find(msgType);
    if (alreadyCheckedIter != alreadyCheckedList_.end()) {
        return alreadyCheckedIter->second;
    }
    // 该特性之前的消息类型都没有加到VersionInfo里面，此类消息不做限制
    // 如果当前type在client和server的VersionInfo里面都不在，则认为是当前版本之前定义的消息类型，不做限制
    const auto tsdFeatureIter = g_tsdFeatureList.find(msgType);
    const auto peerFeatureIter = peerFeatureList_.find(msgType);
    if ((tsdFeatureIter == g_tsdFeatureList.end()) && (peerFeatureIter == peerFeatureList_.end())) {
        TSD_RUN_INFO("VersionVerify: previous type[%u], supported", static_cast<uint32_t>(msgType));
        (void)alreadyCheckedList_.insert(std::make_pair(msgType, true));
        return true;
    }
    // 当且仅当client和server端的VersionInfo都存在该msgType（新增的），并且对应的feature_list相同才认为是可以通信的版本
    if ((tsdFeatureIter != g_tsdFeatureList.end()) && (peerFeatureIter != peerFeatureList_.end())) {
        std::map<std::set<std::string>, int32_t> compareList = {{tsdFeatureIter->second, 1}};
        if (compareList.find(peerFeatureIter->second) != compareList.end()) {
            TSD_RUN_INFO("VersionVerify: new type[%u], supported", static_cast<uint32_t>(msgType));
            (void)alreadyCheckedList_.insert(std::make_pair(msgType, true));
            return true;
        }
    }
    TSD_RUN_INFO("VersionVerify: msgType[%u] is not supported, please check and update your software",
                 static_cast<uint32_t>(msgType));
    (void)alreadyCheckedList_.insert(std::make_pair(msgType, false));
    return false;
}
} // namesapce tsd
