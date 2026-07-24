/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/sub_process_controller.h"
#include "tsd_log.h"
#include "tsd_scope_guard.h"
#include "tsd/status.h"
#include "tsd_util_func.h"

namespace {
constexpr uint64_t PROCESS_OPEN_MAX_ENV_CNT = 128UL;
constexpr uint64_t PROCESS_OPEN_MAX_EXT_PARAM_CNT = 128UL;
constexpr uint32_t MAX_PROCESS_PID_CNT = 1024U;
constexpr uint32_t CLOSE_PID_PER_LOOP = 50U;
} // namespace

namespace tsd {

SubProcessController::SubProcessController(
    TsdProcessController& tsdCtrl, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr,
    PackageManager& packageMgr, ProcessSharedContext& sharedCtx)
    : tsdCtrl_(tsdCtrl),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      packageMgr_(packageMgr),
      sharedCtx_(sharedCtx)
{}

bool SubProcessController::SetCommonOpenParamList(MessageContext& ctx, const ProcOpenArgs* const procArgs) const
{
    if ((procArgs->envCnt > PROCESS_OPEN_MAX_ENV_CNT) || (procArgs->extParamCnt > PROCESS_OPEN_MAX_EXT_PARAM_CNT)) {
        TSD_ERROR("input param error envCnt:%llu, extParamCnt:%llu", procArgs->envCnt, procArgs->extParamCnt);
        return false;
    }
    try {
        ctx.subProcOpenType = static_cast<uint32_t>(procArgs->procType);
        if ((procArgs->filePath != nullptr) && (procArgs->pathLen != 0)) {
            const std::string filePath(procArgs->filePath, procArgs->pathLen);
            ctx.hasSubProcFilePath = true;
            ctx.subProcFilePath = filePath;
            TSD_INFO("filePath:%s", filePath.c_str());
        }
        if ((procArgs->procType == TSD_SUB_PROC_BUILTIN_UDF) || (procArgs->procType == TSD_SUB_PROC_UDF)) {
            for (uint64_t index = 0; index < procArgs->envCnt; index++) {
                const std::string envName(procArgs->envParaList[index].envName, procArgs->envParaList[index].nameLen);
                const std::string envValue(
                    procArgs->envParaList[index].envValue, procArgs->envParaList[index].valueLen);
                TSD_INFO("input envName:%s, envValue:%s", envName.c_str(), envValue.c_str());
                ctx.subProcEnvList.emplace_back(envName, envValue);
            }
        }
        for (uint64_t cnt = 0; cnt < procArgs->extParamCnt; cnt++) {
            const std::string extParam(procArgs->extParamList[cnt].paramInfo, procArgs->extParamList[cnt].paramLen);
            TSD_INFO(
                "cnt:%llu, extra parameters:%s, len:%llu", cnt, extParam.c_str(), procArgs->extParamList[cnt].paramLen);
            ctx.subProcExtParamList.push_back(extParam);
        }
    } catch (std::exception& e) {
        TSD_ERROR("input str is invalid reason:%s", e.what());
        return false;
    }
    return true;
}

TSD_StatusT SubProcessController::ConstructCommonOpenMsg(HDCMessage& hdcMsg, const ProcOpenArgs* procArgs) const
{
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    if (!SetCommonOpenParamList(ctx, procArgs)) {
        TSD_ERROR("input param is error, SetCommonOpenParamList failed");
        return TSD_INTERNAL_ERROR;
    }

    std::string runtimePkgPath;
    packageMgr_.GetAscendLatestIntallPath(runtimePkgPath);
    if (!runtimePkgPath.empty()) {
        ctx.ascendInstallPath = runtimePkgPath;
        TSD_RUN_INFO("runtimePkgPath:%s", runtimePkgPath.c_str());
    }

    if (procArgs->procType == SubProcType::TSD_SUB_PROC_HCCP) {
        ctx.withSubProcLogLevel = true;
    }
    return HdcMessageBuilder::BuildCommonOpen(hdcMsg, ctx);
}

TSD_StatusT SubProcessController::SendCommonOpenMsg(const ProcOpenArgs* procArgs)
{
    HDCMessage hdcMsg;
    if (ConstructCommonOpenMsg(hdcMsg, procArgs) != TSD_OK) {
        TSD_ERROR("construct open msg error");
        return TSD_INTERNAL_ERROR;
    }
    const TSD_StatusT ret = commAgent_.SendMsg(hdcMsg);
    if (ret != TSD_OK) {
        TSD_ERROR("send msg to device error");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT SubProcessController::OpenSubProc(ProcOpenArgs* openArgs)
{
    if (openArgs == nullptr) {
        TSD_ERROR("openArgs is null");
        return TSD_INTERNAL_ERROR;
    }
    if (openArgs->subPid == nullptr) {
        TSD_ERROR("openArgs->subPid is null");
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("enter into ProcessOpenSubProc subtype:%u", static_cast<uint32_t>(openArgs->procType));
    if (!capabilityMgr_.CheckSubProcSupported(static_cast<SubProcType>(openArgs->procType))) {
        TSD_ERROR("ProcessOpenSubProc versionCheck failed, subtype[%u]", static_cast<uint32_t>(openArgs->procType));
        return TSD_INTERNAL_ERROR;
    }

    auto ret = tsdCtrl_.InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    ret = SendCommonOpenMsg(openArgs);
    TSD_CHECK(ret == TSD_OK, ret, "SendCommonOpenMsg failed.");

    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "wait heterogeneous open msg rsp failed.");

    *(openArgs->subPid) = static_cast<pid_t>(sharedCtx_.openSubPid);
    if (openArgs->procType == SubProcType::TSD_SUB_PROC_HCCP) {
        tsdCtrl_.SetStartedHccp(true);
        tsdCtrl_.SetHccpPid(sharedCtx_.openSubPid);
    }
    TSD_RUN_INFO(
        "OpenSubProc success type:%u, pid:%u", static_cast<uint32_t>(openArgs->procType), sharedCtx_.openSubPid);
    return TSD_OK;
}

TSD_StatusT SubProcessController::CloseSubProc(const pid_t closePid)
{
    if (closePid <= 0) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    if (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_HS_AISERVER_FEATURE_BIT)) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("enter into ProcessCloseSubProc subpid:%d", closePid);
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null in Close function");
    HDCMessage msg;
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    ctx.closeSubProcPid = static_cast<uint32_t>(closePid);
    const TSD_StatusT buildRet = HdcMessageBuilder::BuildCloseSubProc(msg, ctx);
    TSD_CHECK(buildRet == TSD_OK, buildRet, "build TSD_CLOSE_SUB_PROC msg failed.");

    if (tsdCtrl_.IsStartedHccp() && (static_cast<uint32_t>(closePid) == tsdCtrl_.GetHccpPid())) {
        tsdCtrl_.SetStartedHccp(false);
        tsdCtrl_.SetHccpPid(0);
    }

    TSD_StatusT ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send remove msg to device error", sharedCtx_.logicDeviceId);
        return TSD_INTERNAL_ERROR;
    }
    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
    TSD_RUN_INFO("leave ProcessCloseSubProc subpid:%u", closePid);
    return TSD_OK;
}

TSD_StatusT SubProcessController::GetSubProcStatus(ProcStatusInfo* pidInfo, const uint32_t arrayLen)
{
    if ((pidInfo == nullptr) || (arrayLen == 0U)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_DEBUG("enter into GetSubProcStatus");
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null in Close function");
    HDCMessage msg;
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    ctx.subProcPidList.reserve(arrayLen);
    for (uint32_t index = 0; index < arrayLen; index++) {
        ctx.subProcPidList.push_back(static_cast<uint32_t>(pidInfo[index].pid));
    }
    const TSD_StatusT buildRet = HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx);
    TSD_CHECK(buildRet == TSD_OK, buildRet, "build TSD_GET_SUB_PROC_STATUS msg failed.");
    const ScopeGuard closeFileGuard([this]() {
        sharedCtx_.pidArry = nullptr;
        sharedCtx_.pidArryLen = 0U;
    });
    sharedCtx_.pidArry = pidInfo;
    sharedCtx_.pidArryLen = arrayLen;
    TSD_StatusT ret = commAgent_.SendMsg(msg);
    TSD_CHECK(ret == TSD_OK, ret, "send GetSubProcStatus msg to device failed.");
    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait GetSubProcStatus response from device failed.");
    TSD_DEBUG("leave GetSubProcStatus");
    return TSD_OK;
}

TSD_StatusT SubProcessController::GetSubProcListStatus(ProcStatusParam* pidInfo, const uint32_t arrayLen)
{
    if ((pidInfo == nullptr) || (arrayLen == 0U) || (arrayLen > MAX_PROCESS_PID_CNT)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_INFO("enter into GetSubProcListStatus");
    TSD_CHECK_NULLPTR(commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null");
    HDCMessage msg;
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    ctx.subProcPidList.reserve(arrayLen);
    ctx.subProcTypeList.reserve(arrayLen);
    for (uint32_t index = 0; index < arrayLen; index++) {
        ctx.subProcPidList.push_back(static_cast<uint32_t>(pidInfo[index].pid));
        ctx.subProcTypeList.push_back(static_cast<uint32_t>(pidInfo[index].procType));
    }
    const TSD_StatusT buildRet = HdcMessageBuilder::BuildGetSubProcStatus(msg, ctx);
    TSD_CHECK(buildRet == TSD_OK, buildRet, "build TSD_GET_SUB_PROC_STATUS msg failed.");
    const ScopeGuard closeFileGuard([this]() {
        sharedCtx_.pidList = nullptr;
        sharedCtx_.pidArryLen = 0U;
    });
    sharedCtx_.pidList = pidInfo;
    sharedCtx_.pidArryLen = arrayLen;
    TSD_StatusT ret = commAgent_.SendMsg(msg);
    TSD_CHECK(ret == TSD_OK, ret, "send GetSubProcListStatus msg to device failed.");
    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait GetSubProcListStatus response from device failed.");
    TSD_INFO("leave GetSubProcListStatus");
    return TSD_OK;
}

TSD_StatusT SubProcessController::RemoveFileOnDevice(const char_t* const filePath, const uint64_t pathLen)
{
    if ((filePath == nullptr) || (pathLen == 0UL) || (pathLen >= 4096UL)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    try {
        const std::string dstPath(filePath, pathLen);
        TSD_RUN_INFO("input dstpath:%s", dstPath.c_str());
        if (!CheckValidatePath(dstPath)) {
            TSD_ERROR("dstPath[%s] is not correct", dstPath.c_str());
            return TSD_INTERNAL_ERROR;
        }
        if (dstPath.find("..") != std::string::npos) {
            TSD_ERROR("input path:%s is error", dstPath.c_str());
            return TSD_INTERNAL_ERROR;
        }
    } catch (std::exception& e) {
        TSD_ERROR("input fileName is invalid reason:%s", e.what());
        return TSD_INTERNAL_ERROR;
    }
    if (!capabilityMgr_.IsSupportCommonInterface(TSD_SUPPORT_HS_AISERVER_FEATURE_BIT)) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return TSD_INTERNAL_ERROR;
    }
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null in Close function");
    HDCMessage msg;
    const std::string remvePath(filePath, pathLen);
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    ctx.removeFilePath = remvePath;
    TSD_StatusT ret = HdcMessageBuilder::BuildRemoveFile(msg, ctx);
    TSD_CHECK(ret == TSD_OK, ret, "build TSD_REMOVE_FILE msg failed.");
    ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send remove msg to device error", sharedCtx_.logicDeviceId);
        return TSD_INTERNAL_ERROR;
    }
    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
    return TSD_OK;
}

TSD_StatusT SubProcessController::CloseSubProcList(const ProcStatusParam* closeList, const uint32_t listSize)
{
    TSD_RUN_INFO(
        "enter ExecuteClosePidList cnt:%u, tsdSupportLevel_:%u", listSize, capabilityMgr_.GetTsdSupportLevel());
    if ((listSize > MAX_PROCESS_PID_CNT) || (listSize == 0U) || (closeList == nullptr)) {
        TSD_ERROR("pid list size invalid:%u", listSize);
        return TSD_INTERNAL_ERROR;
    }
    if (commAgent_.GetDeviceComm() == nullptr) {
        TSD_RUN_INFO("device comm client is null, skip close sub proc list");
        return TSD_HDC_CLIENT_CLOSED_EXTERNAL;
    }
    if (!TSD_BITMAP_GET(capabilityMgr_.GetTsdSupportLevel(), TSD_SUPPORT_CLOSE_LIST_BIT)) {
        TSD_StatusT singleCloseRet = TSD_OK;
        for (uint32_t index = 0U; index < listSize; index++) {
            if (CloseSubProc(closeList[index].pid) != TSD_OK) {
                singleCloseRet = TSD_INTERNAL_ERROR;
                TSD_ERROR("close pid:%d failed", closeList[index].pid);
            }
        }
        return singleCloseRet;
    }

    const uint32_t loopCnt = listSize / CLOSE_PID_PER_LOOP;
    const uint32_t reserveCnt = listSize % CLOSE_PID_PER_LOOP;
    for (uint32_t cnt = 0U; cnt < loopCnt; cnt++) {
        if (ExecuteClosePidList(closeList, cnt * CLOSE_PID_PER_LOOP, CLOSE_PID_PER_LOOP) != TSD_OK) {
            TSD_ERROR("ExecuteClosePidList failed cnt:%u", cnt);
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("ExecuteClosePidList success cnt:%u", cnt);
    }

    if (ExecuteClosePidList(closeList, loopCnt * CLOSE_PID_PER_LOOP, reserveCnt) != TSD_OK) {
        TSD_ERROR("ExecuteClosePidList failed reserveCnt:%u", reserveCnt);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("ExecuteClosePidList success reserveCnt:%u", reserveCnt);
    return TSD_OK;
}

TSD_StatusT SubProcessController::ExecuteClosePidList(
    const ProcStatusParam* closeList, const uint32_t startIndex, const uint32_t pidCnt)
{
    if ((closeList == nullptr) || (pidCnt == 0U) || (pidCnt > MAX_PROCESS_PID_CNT)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_CHECK_NULLPTR(commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null");
    HDCMessage msg;
    MessageContext ctx = tsdCtrl_.BuildBaseMessageContext();
    ctx.subProcPidList.reserve(pidCnt);
    ctx.subProcTypeList.reserve(pidCnt);
    for (uint32_t index = 0U; index < pidCnt; index++) {
        const uint32_t curPid = static_cast<uint32_t>(closeList[index + startIndex].pid);
        const uint32_t curType = static_cast<uint32_t>(closeList[index + startIndex].procType);
        ctx.subProcPidList.push_back(curPid);
        ctx.subProcTypeList.push_back(curType);
        TSD_INFO("add close subproc:%d, proctype:%u", closeList[index + startIndex].pid, curType);
        if (tsdCtrl_.IsStartedHccp() && (closeList[index + startIndex].procType == SubProcType::TSD_SUB_PROC_HCCP) &&
            (curPid == tsdCtrl_.GetHccpPid())) {
            tsdCtrl_.SetStartedHccp(false);
            tsdCtrl_.SetHccpPid(0);
        }
    }
    const TSD_StatusT buildRet = HdcMessageBuilder::BuildCloseSubProcList(msg, ctx);
    TSD_CHECK(buildRet == TSD_OK, buildRet, "build TSD_CLOSE_SUB_PROC_LIST msg failed.");
    TSD_StatusT ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send close pid array msg to device error", sharedCtx_.logicDeviceId);
        return TSD_INTERNAL_ERROR;
    }
    ret = tsdCtrl_.WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait close pid array response from device failed.");
    TSD_RUN_INFO("leave ExecuteClosePidList startindex:%u, cnt:%u", startIndex, pidCnt);
    return TSD_OK;
}

} // namespace tsd
