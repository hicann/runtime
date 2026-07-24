/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_check_code_service.h"
#include "package_manager.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "tsd_scope_guard.h"
#include "tsd_util_func.h"
#include "env_internal_api.h"

namespace tsd {

namespace {
constexpr uint32_t HELPER_PKG_LOAD_TIMEOUT = 10000U;
constexpr uint32_t DRIVER_EXTEND_MAX_PROCESS_TIME = 140U;

struct CheckCodeRspHandler {
    HDCMessage::MsgType msgType;
    void (*handle)(tsd::PackageCheckCodeService& svc, const HDCMessage& msg);
};

void HandleSingleCheckCodeRsp(tsd::PackageCheckCodeService& svc, const HDCMessage& msg, tsd::TsdLoadPackageType pkgType)
{
    svc.peerCheckCode_[static_cast<uint32_t>(pkgType)] = msg.check_code();
    svc.pkgRspCode_ = ((msg.tsd_rsp_code() == 0U) ? tsd::ResponseCode::SUCCESS : tsd::ResponseCode::FAIL);
}

void HandleRuntimeCheckCodeRsp(tsd::PackageCheckCodeService& svc, const HDCMessage& msg)
{
    HandleSingleCheckCodeRsp(svc, msg, tsd::TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME);
}

void HandleDshapeCheckCodeRsp(tsd::PackageCheckCodeService& svc, const HDCMessage& msg)
{
    HandleSingleCheckCodeRsp(svc, msg, tsd::TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE);
}

void HandleMultiCheckCodeRsp(tsd::PackageCheckCodeService& svc, const HDCMessage& msg)
{
    svc.peerCheckCode_[static_cast<uint32_t>(tsd::TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = msg.check_code();
    svc.peerCheckCode_[static_cast<uint32_t>(tsd::TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] =
        msg.extendpkg_check_code();
    svc.peerCheckCode_[static_cast<uint32_t>(tsd::TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] =
        msg.ascendcpppkg_check_code();
}

const CheckCodeRspHandler CHECK_CODE_RSP_HANDLERS[] = {
    {HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP, HandleRuntimeCheckCodeRsp},
    {HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP, HandleDshapeCheckCodeRsp},
    {HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP, HandleMultiCheckCodeRsp},
    {HDCMessage::TSD_CHECK_PACKAGE_RSP, HandleMultiCheckCodeRsp},
};
} // namespace

PackageCheckCodeService::PackageCheckCodeService(
    PackageManager& mgr, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageEnvInfo& envInfo,
    PackageHashStore& hashStore, ResponseCode& pkgRspCode, bool& getCheckCodeRetrySupport,
    std::string& loadPackageErrorMsg)
    : mgr_(mgr),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      envInfo_(envInfo),
      hashStore_(hashStore),
      pkgRspCode_(pkgRspCode),
      getCheckCodeRetrySupport_(getCheckCodeRetrySupport),
      loadPackageErrorMsg_(loadPackageErrorMsg)
{
    for (uint32_t index = 0U; index < static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX); index++) {
        peerCheckCode_[index] = 0U;
        hostCheckCode_[index] = 0U;
    }
}

TSD_StatusT PackageCheckCodeService::InitTsdClient()
{
    if (commAgent_.IsInit()) {
        TSD_INFO("[TsdClient] tsd client has already been initialized");
        return TSD_OK;
    }
    return commAgent_.InitTsdClient(envInfo_.IsAdcEnv());
}

TSD_StatusT PackageCheckCodeService::WaitPkgRsp(const uint32_t timeout, const bool ignoreRecvErr)
{
    const TSD_StatusT ret = commAgent_.RecvData(ignoreRecvErr, timeout);
    if ((ret != TSD_OK) || (static_cast<uint32_t>(pkgRspCode_) != 0U)) {
        if (!ignoreRecvErr) {
            TSD_ERROR(
                "tsd package wait response fail, ret[%u], rspCode[%u]", static_cast<uint32_t>(ret),
                static_cast<uint32_t>(pkgRspCode_));
        }
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT PackageCheckCodeService::GetDeviceCheckCodeOnce(const HDCMessage& msg)
{
    auto ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send check_code search message failed.");
        return ret;
    }

    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] wait package info response", envInfo_.GetLogicDeviceId(),
        commAgent_.GetSessionId());
    ret = commAgent_.RecvData();
    if (ret != TSD_OK) {
        TSD_RUN_INFO("not receive TSD_CHECK_PACKAGE rsp msg, just send pkg to server");
    }
    return TSD_OK;
}

TSD_StatusT PackageCheckCodeService::PrepareForCheckCode()
{
    const TSD_StatusT ret = mgr_.InitTsdClient();
    if (ret != TSD_OK) {
        TSD_RUN_WARN("[PackageManager][deviceId=%u] init failed for send aicpu package", envInfo_.GetLogicDeviceId());
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_HDC_CREATE_SESSION_FAILED;
    }
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_FOUND, "[PackageManager] devCommClient_ is null in Open function");
    return TSD_OK;
}

TSD_StatusT PackageCheckCodeService::GetDeviceCheckCode()
{
    if (mgr_.aicpuPackageExistInDevice_) {
        TSD_RUN_INFO(
            "[PackageManager][deviceId=%u] aicpu package already exist in device", envInfo_.GetLogicDeviceId());
        return TSD_AICPUPACKAGE_EXISTED;
    }

    TSD_StatusT ret = mgr_.PrepareForCheckCode();
    if (ret != TSD_OK) {
        return ret;
    }
    const ScopeGuard destroySessionGuard([this]() { this->commAgent_.ReleaseDeviceConnection(); });

    std::shared_ptr<VersionVerify> versionVerify = nullptr;
    (void)commAgent_.GetVersionVerify(versionVerify);
    TSD_CHECK_NULLPTR(versionVerify, TSD_INTERNAL_ERROR, "no VersionVerify available.");

    if (!versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE)) {
        TSD_RUN_INFO("[TsdClient] Device does not support search check_code before send aicpu package.");
        mgr_.aicpuPackageExistInDevice_ = true;
        return TSD_OK;
    }

    MessageContext ctx{};
    ctx.logicDeviceId = envInfo_.GetLogicDeviceId();
    ctx.asan = IsAsanMmSysEnv();
    ctx.checkCode = hostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)];
    ctx.extendpkgCheckCode =
        hostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)];
    ctx.ascendcppCheckCode = hostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)];
    HDCMessage msg;
    if (HdcMessageBuilder::BuildCheckPackage(msg, ctx) != TSD_OK) {
        TSD_ERROR("build check package msg failed");
        return TSD_INTERNAL_ERROR;
    }
    SetHostCheckCode(msg, TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    SetHostCheckCode(msg, TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL);
    SetHostCheckCode(msg, TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    if (mgr_.GetDeviceCheckCodeOnce(msg) != TSD_OK) {
        TSD_ERROR("get check code once failed.");
        return TSD_INTERNAL_ERROR;
    }
    mgr_.GetDeviceCheckCodeRetrySupport();

    mgr_.aicpuPackageExistInDevice_ = true;

    return TSD_OK;
}

void PackageCheckCodeService::GetDeviceCheckCodeRetrySupport()
{
    std::shared_ptr<VersionVerify> versionVerify = nullptr;
    (void)commAgent_.GetVersionVerify(versionVerify);
    if (versionVerify == nullptr) {
        TSD_ERROR("no VersionVerify available.");
        return;
    }
    getCheckCodeRetrySupport_ = versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
}

TSD_StatusT PackageCheckCodeService::GetDeviceCheckCodeRetry(const HDCMessage& msg)
{
    TSD_StatusT ret = mgr_.PrepareForCheckCode();
    if (ret != TSD_OK) {
        return ret;
    }
    const ScopeGuard destroySessionGuard([this]() { this->commAgent_.ReleaseDeviceConnection(); });
    if (mgr_.GetDeviceCheckCodeOnce(msg) != TSD_OK) {
        TSD_ERROR("get check code once failed.");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

void PackageCheckCodeService::SetHostCheckCode(HDCMessage& msg, TsdLoadPackageType type)
{
    const uint32_t packageType = static_cast<uint32_t>(type);
    if (envInfo_.packageName_[packageType].empty()) {
        return;
    }
    const std::string orgFile = envInfo_.packagePath_[packageType] + envInfo_.packageName_[packageType];
    hostCheckCode_[packageType] = CalFileSize(orgFile.c_str());
    switch (type) {
        case TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL:
            msg.set_check_code(hostCheckCode_[packageType]);
            break;
        case TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL:
            msg.set_extendpkg_check_code(hostCheckCode_[packageType]);
            break;
        case TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP:
            msg.set_ascendcpppkg_check_code(hostCheckCode_[packageType]);
            break;
        default:
            break;
    }
}

TSD_StatusT PackageCheckCodeService::GetDeviceHsPkgCheckCode(
    const uint32_t checkCode, const HDCMessage::MsgType msgType, const bool beforeSendFlag,
    const MessageContext& baseCtx)
{
    TSD_StatusT ret = mgr_.InitTsdClient();
    if (ret != TSD_OK) {
        TSD_ERROR("InitTsdClient failed");
        return TSD_INTERNAL_ERROR;
    }
    HDCMessage msg;
    MessageContext ctx = baseCtx;
    ctx.msgType = static_cast<uint32_t>(msgType);
    ctx.checkCode = checkCode;
    ctx.beforeSendPkg = beforeSendFlag;
    if (HdcMessageBuilder::BuildPackageCheckCode(msg, ctx) != TSD_OK) {
        TSD_ERROR("build package check code msg failed");
        return TSD_INTERNAL_ERROR;
    }
    ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send runtime checkcode failed msgtype:%u.", static_cast<uint32_t>(msgType));
        commAgent_.ReleaseDeviceConnection();
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] wait package info response msgType:%u", envInfo_.GetLogicDeviceId(),
        commAgent_.GetSessionId(), static_cast<uint32_t>(msgType));
    ret = mgr_.WaitPkgRsp(HELPER_PKG_LOAD_TIMEOUT);
    if (ret != TSD_OK) {
        if (beforeSendFlag) {
            TSD_RUN_INFO("not receive TSD_CHECK_PACKAGE rsp msg, just send pkg to server");
        } else {
            TSD_ERROR("not receive TSD_CHECK_PACKAGE failed Msgtype:%u", static_cast<uint32_t>(msgType));
            return TSD_INTERNAL_ERROR;
        }
    }
    TSD_RUN_INFO("GetDeviceHsPkgCheckCode success Msgtype:%u", static_cast<uint32_t>(msgType));
    return TSD_OK;
}

TSD_StatusT PackageCheckCodeService::GetCannHsPkgCheckCode(
    const std::string& pkgPureName, const std::string& hostPkgHash, const MessageContext& baseCtx)
{
    TSD_StatusT ret = mgr_.InitTsdClient();
    if (ret != TSD_OK) {
        TSD_ERROR("InitTsdClient failed");
        return TSD_INTERNAL_ERROR;
    }

    HDCMessage msg;
    MessageContext ctx = baseCtx;
    ctx.packageMaxProcessTime = DRIVER_EXTEND_MAX_PROCESS_TIME;
    ctx.packageWorkerType = static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK);
    ctx.packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK);
    ctx.packageName = pkgPureName;
    ctx.hashCode = hostPkgHash;
    if (HdcMessageBuilder::BuildCannHsCheckCode(msg, ctx) != TSD_OK) {
        TSD_ERROR("build cann hs check code msg failed");
        return TSD_INTERNAL_ERROR;
    }
    ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send cann hs check code failed");
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] wait cann package info response for %s", envInfo_.GetLogicDeviceId(),
        commAgent_.GetSessionId(), pkgPureName.c_str());
    ret = mgr_.WaitPkgRsp(DRIVER_EXTEND_MAX_PROCESS_TIME * 1000U);
    if (ret != TSD_OK) {
        TSD_ERROR("Wait response for package %s failed", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("Get check code for package %s success", pkgPureName.c_str());
    return TSD_OK;
}

void PackageCheckCodeService::HandleNormalPackageCheckCodeRsp(const HDCMessage& msg)
{
    const uint32_t packageType = static_cast<uint32_t>(msg.package_type());
    constexpr uint32_t packageTypeMax = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX);
    if (packageType >= packageTypeMax) {
        TSD_ERROR("The package type is larger than the max, max=%u, type=%u", packageTypeMax, packageType);
        return;
    }
    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK)) {
        hashStore_.StoreAllPkgHashValue(msg);
    } else {
        peerCheckCode_[packageType] = msg.check_code();
    }
    mgr_.deviceIdle_ = msg.device_idle();
    if (!mgr_.deviceIdle_) {
        TSD_RUN_WARN("device has process is running, skip load driver extend package");
    }
    pkgRspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    loadPackageErrorMsg_ = msg.error_info().error_log();
}

void PackageCheckCodeService::HandleCannHsCheckCodeRsp(const HDCMessage& msg)
{
    if (msg.package_hash_code_list_size() == 0) {
        TSD_ERROR("Get package hash size from msg failed, is empty");
        return;
    }
    std::string pkgName = msg.package_hash_code_list(0).package_name();
    std::string deviceHashValue = msg.package_hash_code_list(0).hash_code();
    hashStore_.SetDeviceCommonSinkPackHashValue(pkgName, deviceHashValue);
    pkgRspCode_ = (msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL;
    TSD_INFO("Set check code for %s success. rsp=%u", pkgName.c_str(), pkgRspCode_);
}

void PackageCheckCodeService::SaveDeviceCheckCode(const HDCMessage& msg)
{
    const HDCMessage::MsgType msgType = msg.type();
    for (const auto& handler : CHECK_CODE_RSP_HANDLERS) {
        if (handler.msgType == msgType) {
            handler.handle(*this, msg);
            if (msgType == HDCMessage::TSD_CHECK_PACKAGE_RSP) {
                capabilityMgr_.UpdateStateFromMsg(msg);
            }
            return;
        }
    }
    if (msgType == HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP) {
        HandleNormalPackageCheckCodeRsp(msg);
    } else if (msgType == HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP) {
        HandleCannHsCheckCodeRsp(msg);
    } else {
        TSD_RUN_INFO("msgType[%u] is not supported", static_cast<uint32_t>(msgType));
    }
}

} // namespace tsd
