/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tsd_log.h"
#include "inc/process_mode_manager.h"
#include "inc/tsd_msg_parse_reg.h"

namespace tsd {
namespace {
const std::string UDF_PKG_NAME = "cann-udf-compat.tar.gz";
const std::string HCCD_PKG_NAME = "cann-hccd-compat.tar.gz";
}; // namespace
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc1, HDCMessage::TSD_START_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc2, HDCMessage::TSD_CLOSE_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc3, HDCMessage::TSD_UPDATE_PROIFILING_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc4, HDCMessage::TSD_CHECK_PACKAGE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc5, HDCMessage::TSD_GET_PID_QOS_RSP, &ProcessModeManager::CapabilityResMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc6, HDCMessage::TSD_DRV_BIND_HOST_PID_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc7, HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc8, HDCMessage::TSD_REMOVE_FILE_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc9, HDCMessage::TSD_OPEN_SUB_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc10, HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc11, HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc12, HDCMessage::TSD_CLOSE_SUB_PROC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc13, HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP,
    &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc14, HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc15, HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc16, HDCMessage::TSD_CLOSE_SUB_PROC_LIST_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc17, HDCMessage::TSD_GET_SUPPORT_ADPROF_RSP, &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc18, HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP, &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc19, HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP,
    &ProcessModeManager::PackageInfoMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc20, HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP,
    &ProcessModeManager::ServerToClientMsgProc);
TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(
    ServerToClientMsgProc21, HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP, &ProcessModeManager::PackageInfoMsgProc);

void ProcessModeManager::StoreProcListStatus(const HDCMessage& msg)
{
    if (msg.type() != HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP) {
        return;
    }
    // 与ge兼容性方案，后续ge接口替换后删除
    const uint32_t curCnt = static_cast<uint32_t>(msg.sub_proc_status_list_size());
    if (pidArryLen_ < curCnt) {
        TSD_ERROR("pidArryLen_:%u smaller than curCnt:%u", pidArryLen_, curCnt);
        return;
    }
    for (int32_t j = 0U; j < static_cast<int32_t>(curCnt); j++) {
        if (pidArry_ != nullptr) {
            // 与ge兼容性方案，如果ge代码替换后此代码删除
            pidArry_[j].pid = static_cast<pid_t>(msg.sub_proc_status_list(j).sub_proc_pid());
            pidArry_[j].curStat = static_cast<SubProcessStatus>(msg.sub_proc_status_list(j).proc_status());
            TSD_INFO(
                "pid:%d, status:%d", static_cast<int32_t>(pidArry_[j].pid), static_cast<int32_t>(pidArry_[j].curStat));
        } else if (pidList_ != nullptr) {
            pidList_[j].pid = static_cast<pid_t>(msg.sub_proc_status_list(j).sub_proc_pid());
            pidList_[j].curStat = static_cast<SubProcessStatus>(msg.sub_proc_status_list(j).proc_status());
            TSD_INFO(
                "pid:%d, status:%d", static_cast<int32_t>(pidList_[j].pid), static_cast<int32_t>(pidList_[j].curStat));
        } else {
            TSD_ERROR("pid array or list is null");
        }
    }
}
void ProcessModeManager::StoreAllPkgHashValue(const HDCMessage& msg)
{
    if ((msg.type() != HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP) &&
        (msg.type() != HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP)) {
        return;
    }

    for (size_t j = 0; j < msg.package_hash_code_list_size(); j++) {
        SinkPackageHashCodeInfo tempNode = msg.package_hash_code_list(j);
        SetDeviceCommonSinkPackHashValue(tempNode.package_name(), tempNode.hash_code());
    }
}
void ProcessModeManager::DeviceMsgProcess(const HDCMessage& msg)
{
    const uint32_t realDeviceId = msg.real_device_id();
    const uint32_t deviceId = msg.device_id();
    rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    errMsg_ = msg.error_info().message();
    errorLog_ = msg.error_info().error_log();
    const HDCMessage::MsgType msgType = msg.type();
    startOrStopFailCode_ = msg.error_info().error_code();

    capabilityMgr_.UpdateStateFromMsg(msg);

    if (msgType == HDCMessage::TSD_OPEN_SUB_PROC_RSP) {
        openSubPid_ = msg.helper_sub_pid();
    }
    StoreProcListStatus(msg);
    if (!startOrStopFailCode_.empty()) {
        TSD_ERROR("[TsdClient] DeviceMsgProc failed errcode[%s]", startOrStopFailCode_.c_str());
    }
    StoreAllPkgHashValue(msg);
    if (msgType == HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP) {
        HandleDevicePluginVersionRsp(msg);
    }
    TSD_INFO(
        "[TsdClient] DeviceMsgProc recvMsg realDeviceId[%u] msgType[%u] localDevId[%u] rspCode[%u]"
        "heterogeneousSubPid[%u], tsdSupportLevel_[%u]",
        realDeviceId, static_cast<uint32_t>(msgType), deviceId, msg.tsd_rsp_code(), openSubPid_,
        capabilityMgr_.GetTsdSupportLevel());
}

void ProcessModeManager::ServerToClientMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[ServerToClientMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->DeviceMsgProcess(msg);
}

void ProcessModeManager::HandleNormalPackageCheckCodeRsp(const HDCMessage& msg)
{
    const uint32_t packageType = static_cast<uint32_t>(msg.package_type());
    constexpr uint32_t packageTypeMax = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX);
    if (packageType >= packageTypeMax) {
        TSD_ERROR("The package type is larger than the max, max=%u, type=%u", packageTypeMax, packageType);
        return;
    }
    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK)) {
        StoreAllPkgHashValue(msg);
    } else {
        packagePeerCheckCode_[packageType] = msg.check_code();
    }
    deviceIdle_ = msg.device_idle();
    if (!deviceIdle_) {
        TSD_RUN_WARN("device has process is running, skip load driver extend package");
    }
    rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    loadPackageErrorMsg_ = msg.error_info().error_log();
}

void ProcessModeManager::HandleCannHsCheckCodeRsp(const HDCMessage& msg)
{
    if (msg.package_hash_code_list_size() == 0) {
        TSD_ERROR("Get package hash size from msg failed, is empty");
        return;
    }
    std::string pkgName = msg.package_hash_code_list(0).package_name();
    std::string deviceHashValue = msg.package_hash_code_list(0).hash_code();
    SetDeviceCommonSinkPackHashValue(pkgName, deviceHashValue);
    rspCode_ = (msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL;
    TSD_INFO("Set check code for %s success. rsp=%u", pkgName.c_str(), rspCode_);
}

void ProcessModeManager::HandleDevicePluginVersionRsp(const HDCMessage& msg)
{
    devicePluginVersions_.clear();
    for (int32_t i = 0; i < msg.device_plugin_versions_size(); ++i) {
        const auto& info = msg.device_plugin_versions(i);
        PluginPkgVersion ver;
        ver.version = info.version();
        ver.timestamp = info.timestamp();
        devicePluginVersions_[info.package_name()] = ver;
        TSD_RUN_INFO(
            "device plugin pkg:%s version:%s timestamp:%s", info.package_name().c_str(), ver.version.c_str(),
            ver.timestamp.c_str());
    }
    rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    TSD_RUN_INFO("device plugin info rsp, pkgCount:%d", msg.device_plugin_versions_size());
}

void ProcessModeManager::SaveDeviceCheckCode(const HDCMessage& msg)
{
    const HDCMessage::MsgType msgType = msg.type();
    if (msgType == HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP) {
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)] = msg.check_code();
        rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    } else if (msgType == HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP) {
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)] = msg.check_code();
        rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    } else if (msgType == HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP) {
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = msg.check_code();
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] =
            msg.extendpkg_check_code();
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] =
            msg.ascendcpppkg_check_code();
    } else if (msgType == HDCMessage::TSD_CHECK_PACKAGE_RSP) {
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = msg.check_code();
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] =
            msg.extendpkg_check_code();
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] =
            msg.ascendcpppkg_check_code();
        capabilityMgr_.UpdateStateFromMsg(msg);
    } else if (msgType == HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP) {
        HandleNormalPackageCheckCodeRsp(msg);
    } else if (msgType == HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP) {
        HandleCannHsCheckCodeRsp(msg);
    } else {
        TSD_RUN_INFO("msgType[%u] is not supported", static_cast<uint32_t>(msgType));
    }
}

void ProcessModeManager::PackageInfoMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[PackageInfoMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    TSD_INFO(
        "[PackageInfoMsgProc] [sessionID=%u] deviceId[%u], checkCode[%u]", sessionID, realDeviceId, msg.check_code());
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->SaveDeviceCheckCode(msg);
}

void ProcessModeManager::PidQosMsgProc(const HDCMessage& msg)
{
    rspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    if (rspCode_ == ResponseCode::FAIL) {
        return;
    }
    capabilityMgr_.HandlePidQosRsp(msg);
}

void ProcessModeManager::CapabilityResMsgProc(const uint32_t sessionID, const HDCMessage& msg)
{
    TSD_INFO("[CapabilityResMsgProc] [sessionID=%u]", sessionID);
    const uint32_t realDeviceId = msg.real_device_id();
    const std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(realDeviceId, DIE_MODE, false));
    TSD_CHECK_NULLPTR_VOID(client);
    client->PidQosMsgProc(msg);
}
} // namespace tsd
