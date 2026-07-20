/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc_message_builder.h"

#include <string>

#include "capability_manager.h"
#include "env_internal_api.h"
#include "tsd_log.h"
#include "tsd_util_func.h"

namespace tsd {
namespace {
// Compute the tsdclient capability bitmap. Side-effect (TSD_INFO log) is
// intentionally preserved so the produced HDCMessage and surrounding log
// output are byte-equivalent to the legacy implementation.
uint32_t BuildTsdClientCapabilityLevel()
{
    uint32_t curSupport = 0U;
    TSD_BITMAP_SET(curSupport, TSDCLIENT_SUPPORT_NEW_ERRORCODE);
    TSD_INFO("Set tsdclient capability level, value is [%u].", curSupport);
    return curSupport;
}

// Set both the modulo device id (used for routing) and the real device id
// (used for callback verification) carried by every per-device HDC message.
void SetDeviceIds(HDCMessage& msg, const MessageContext& ctx)
{
    msg.set_device_id(ctx.logicDeviceId % PER_OS_CHIP_NUM);
    // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    msg.set_real_device_id(ctx.logicDeviceId);
}

// Populate proc_sign_pid with the process tgid, and optionally the sign string.
TSD_StatusT SetProcSignPid(HDCMessage& msg, const MessageContext& ctx, const bool withSign = false)
{
    ProcessSignPid* const signPid = msg.mutable_proc_sign_pid();
    if (signPid == nullptr) {
        TSD_ERROR("signPid is null.");
        return TSD_INTERNAL_ERROR;
    }
    signPid->set_proc_pid(static_cast<uint32_t>(ctx.procSign.tgid));
    if (withSign) {
        signPid->set_proc_sign(std::string(ctx.procSign.sign));
    }
    TSD_RUN_INFO(
        "[HdcMessageBuilder] tsd get process sign successfully, procpid[%u]", static_cast<uint32_t>(ctx.procSign.tgid));
    return TSD_OK;
}

// Append the sub-process entries described by ctx (pid list + optional type
// list) to the given SubProcStatus repeated field, keeping the type list and
// the status list parallel.
void FillSubProcList(
    HDCMessage& msg, const MessageContext& ctx, google::protobuf::RepeatedPtrField<SubProcStatus>* statusList)
{
    for (size_t index = 0U; index < ctx.subProcPidList.size(); index++) {
        SubProcStatus* const curStatus = statusList->Add();
        if (index < ctx.subProcTypeList.size()) {
            msg.add_sub_proc_type_list(ctx.subProcTypeList[index]);
        }
        curStatus->set_sub_proc_pid(ctx.subProcPidList[index]);
    }
}
} // namespace

TSD_StatusT HdcMessageBuilder::BuildOpen(HDCMessage& hdcMsg, const MessageContext& ctx)
{
    hdcMsg.set_rank_size(ctx.rankSize);
    hdcMsg.set_start_hccp(ctx.startHccp);
    hdcMsg.set_start_cp(ctx.startCp);
    hdcMsg.set_profiling_mode(ctx.profilingMode);
    SetDeviceIds(hdcMsg, ctx);
    LogLevel* const level = hdcMsg.mutable_log_level();
    if (level == nullptr) {
        TSD_ERROR("mutable log level error");
        return TSD_INTERNAL_ERROR;
    }
    level->set_log_level(ctx.logLevel);
    CcecpuLogLevel* const ccecpuLogLevel = hdcMsg.mutable_ccecpu_log_level();
    if (ccecpuLogLevel != nullptr) {
        ccecpuLogLevel->set_ccecpu_log_level(ctx.ccecpuLogLevel);
    }
    AicpuLogLevel* const aicpuLogLevel = hdcMsg.mutable_aicpu_log_level();
    if (aicpuLogLevel != nullptr) {
        aicpuLogLevel->set_aicpu_log_level(ctx.aicpuLogLevel);
    }
    const TSD_StatusT signRet = SetProcSignPid(hdcMsg, ctx, true);
    if (signRet != TSD_OK) {
        return signRet;
    }
    hdcMsg.set_check_code(ctx.aicpuKernelCheckCode);
    hdcMsg.set_extendpkg_check_code(ctx.aicpuExtendKernelCheckCode);
    hdcMsg.set_ascendcpppkg_check_code(ctx.ascendcppCheckCode);
    hdcMsg.set_type(HDCMessage::TSD_START_PROC_MSG);
    hdcMsg.set_device_mode(ctx.aicpuDeviceMode);
    hdcMsg.set_aicpu_sched_mode(static_cast<uint32_t>(ctx.aicpuSchedMode));
    const uint32_t tsdclientCapabilityLevel = BuildTsdClientCapabilityLevel();
    hdcMsg.set_tsdclient_capability_level(tsdclientCapabilityLevel);
    std::string aicpuPath;
    GetEnvFromMmSys(MM_ENV_ASCEND_AICPU_PATH, "ASCEND_AICPU_PATH", aicpuPath);
    AscendAicpuPath* const ascendAicpuPath = hdcMsg.mutable_ascend_aicpu_path();
    if (ascendAicpuPath == nullptr) {
        TSD_ERROR("mutable ascend aicpu path error");
        return TSD_INTERNAL_ERROR;
    }
    ascendAicpuPath->set_ascend_aicpu_path(aicpuPath);
    return TSD_OK;
}

TSD_StatusT HdcMessageBuilder::BuildClose(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_CLOSE_PROC_MSG);
    msg.set_rank_size(ctx.rankSize);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildUpdateProfiling(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_UPDATE_PROIFILING_MSG);
    msg.set_profiling_mode(ctx.profilingMode);
    msg.set_rank_size(ctx.rankSize);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildOmFileDecompress(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS);
    msg.set_omfile_name(ctx.omfileName);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildPackageCheckCode(HDCMessage& msg, const MessageContext& ctx)
{
    msg.set_real_device_id(ctx.logicDeviceId);
    msg.set_type(static_cast<HDCMessage::MsgType>(ctx.msgType));
    msg.set_check_code(ctx.checkCode);
    msg.set_before_send_pkg(ctx.beforeSendPkg);
    return SetProcSignPid(msg, ctx, true);
}

TSD_StatusT HdcMessageBuilder::BuildCapability(HDCMessage& msg, const MessageContext& ctx)
{
    const CapabilitySpec* spec = FindCapabilitySpec(ctx.capabilityType);
    if (spec != nullptr) {
        msg.set_type(spec->msgType);
    }
    SetDeviceIds(msg, ctx);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildCloseSubProc(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC);
    msg.set_close_sub_proc_pid(ctx.closeSubProcPid);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildRemoveFile(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_REMOVE_FILE);
    msg.set_remove_file_path(ctx.removeFilePath);
    return SetProcSignPid(msg, ctx);
}

TSD_StatusT HdcMessageBuilder::BuildCannHsCheckCode(HDCMessage& msg, const MessageContext& ctx)
{
    msg.set_real_device_id(ctx.logicDeviceId);
    msg.set_type(HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE);
    msg.set_package_max_process_time(ctx.packageMaxProcessTime);
    msg.set_package_worker_type(ctx.packageWorkerType);
    msg.set_package_type(ctx.packageType);
    SinkPackageHashCodeInfo* const pkgHostInfo = msg.add_package_hash_code_list();
    if (pkgHostInfo == nullptr) {
        TSD_ERROR("add package hash code list error");
        return TSD_INTERNAL_ERROR;
    }
    pkgHostInfo->set_package_name(ctx.packageName);
    pkgHostInfo->set_hash_code(ctx.hashCode);
    return TSD_OK;
}

TSD_StatusT HdcMessageBuilder::BuildGetSubProcStatus(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS);
    const TSD_StatusT ret = SetProcSignPid(msg, ctx);
    if (ret != TSD_OK) {
        return ret;
    }
    FillSubProcList(msg, ctx, msg.mutable_sub_proc_status_list());
    return TSD_OK;
}

TSD_StatusT HdcMessageBuilder::BuildCloseSubProcList(HDCMessage& msg, const MessageContext& ctx)
{
    SetDeviceIds(msg, ctx);
    msg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC_LIST);
    const TSD_StatusT ret = SetProcSignPid(msg, ctx);
    if (ret != TSD_OK) {
        return ret;
    }
    FillSubProcList(msg, ctx, msg.mutable_close_sub_list());
    return TSD_OK;
}

TSD_StatusT HdcMessageBuilder::BuildCommonOpen(HDCMessage& msg, const MessageContext& ctx)
{
    HelperSubProcess* const subProcessInfo = msg.mutable_helper_sub_proc();
    if (subProcessInfo == nullptr) {
        TSD_ERROR("helper_sub_proc is null.");
        return TSD_INTERNAL_ERROR;
    }
    subProcessInfo->set_process_type(ctx.subProcOpenType);
    if (ctx.hasSubProcFilePath) {
        subProcessInfo->set_file_path(ctx.subProcFilePath);
    }
    for (const std::pair<std::string, std::string>& env : ctx.subProcEnvList) {
        EnvPara* const evnParam = subProcessInfo->add_env_list();
        if (evnParam == nullptr) {
            TSD_ERROR("add env list error");
            return TSD_INTERNAL_ERROR;
        }
        evnParam->set_env_name(env.first);
        evnParam->set_env_value(env.second);
    }
    for (const std::string& extParam : ctx.subProcExtParamList) {
        subProcessInfo->add_ext_param_list(extParam);
    }
    if (!ctx.ascendInstallPath.empty()) {
        msg.set_ascend_install_path(ctx.ascendInstallPath);
    }
    if (ctx.withSubProcLogLevel) {
        LogLevel* const level = msg.mutable_log_level();
        if (level != nullptr) {
            level->set_log_level(ctx.logLevel);
        }
    }
    msg.set_type(HDCMessage::TSD_OPEN_SUB_PROC);
    SetDeviceIds(msg, ctx);
    return SetProcSignPid(msg, ctx, true);
}
} // namespace tsd
