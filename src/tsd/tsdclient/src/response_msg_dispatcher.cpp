/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/response_msg_dispatcher.h"
#include "tsd_log.h"

namespace tsd {

ResponseMsgDispatcher::ResponseMsgDispatcher(
    ProcessSharedContext& ctx, PackageManager& pkgMgr, CapabilityManager& capMgr)
    : sharedCtx_(ctx), packageMgr_(pkgMgr), capabilityMgr_(capMgr)
{}

void ResponseMsgDispatcher::StoreProcListStatus(const HDCMessage& msg)
{
    if (msg.type() != HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP) {
        return;
    }
    const uint32_t curCnt = static_cast<uint32_t>(msg.sub_proc_status_list_size());
    if (sharedCtx_.pidArryLen < curCnt) {
        TSD_ERROR("pidArryLen_:%u smaller than curCnt:%u", sharedCtx_.pidArryLen, curCnt);
        return;
    }
    for (int32_t j = 0; j < static_cast<int32_t>(curCnt); j++) {
        if (sharedCtx_.pidArry != nullptr) {
            sharedCtx_.pidArry[j].pid = static_cast<pid_t>(msg.sub_proc_status_list(j).sub_proc_pid());
            sharedCtx_.pidArry[j].curStat = static_cast<SubProcessStatus>(msg.sub_proc_status_list(j).proc_status());
            TSD_INFO(
                "pid:%d, status:%d", static_cast<int32_t>(sharedCtx_.pidArry[j].pid),
                static_cast<int32_t>(sharedCtx_.pidArry[j].curStat));
        } else if (sharedCtx_.pidList != nullptr) {
            sharedCtx_.pidList[j].pid = static_cast<pid_t>(msg.sub_proc_status_list(j).sub_proc_pid());
            sharedCtx_.pidList[j].curStat = static_cast<SubProcessStatus>(msg.sub_proc_status_list(j).proc_status());
            TSD_INFO(
                "pid:%d, status:%d", static_cast<int32_t>(sharedCtx_.pidList[j].pid),
                static_cast<int32_t>(sharedCtx_.pidList[j].curStat));
        } else {
            TSD_ERROR("pid array or list is null");
        }
    }
}

void ResponseMsgDispatcher::DeviceMsgProcess(const HDCMessage& msg)
{
    const uint32_t realDeviceId = msg.real_device_id();
    const uint32_t deviceId = msg.device_id();
    sharedCtx_.rspCode = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    sharedCtx_.errMsg = msg.error_info().message();
    sharedCtx_.errorLog = msg.error_info().error_log();
    const HDCMessage::MsgType msgType = msg.type();
    sharedCtx_.startOrStopFailCode = msg.error_info().error_code();

    capabilityMgr_.UpdateStateFromMsg(msg);

    if (msgType == HDCMessage::TSD_OPEN_SUB_PROC_RSP) {
        sharedCtx_.openSubPid = msg.helper_sub_pid();
    }
    StoreProcListStatus(msg);
    if (!sharedCtx_.startOrStopFailCode.empty()) {
        TSD_ERROR("[TsdClient] DeviceMsgProc failed errcode[%s]", sharedCtx_.startOrStopFailCode.c_str());
    }
    packageMgr_.StoreAllPkgHashValue(msg);
    if (msgType == HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP) {
        packageMgr_.HandleDevicePluginVersionRsp(msg);
    }
    TSD_INFO(
        "[TsdClient] DeviceMsgProcess recvMsg realDeviceId[%u] msgType[%u] localDevId[%u] rspCode[%u] "
        "heterogeneousSubPid[%u], tsdSupportLevel_[%u]",
        realDeviceId, static_cast<uint32_t>(msgType), deviceId, msg.tsd_rsp_code(), sharedCtx_.openSubPid,
        capabilityMgr_.GetTsdSupportLevel());
}

void ResponseMsgDispatcher::PidQosMsgProc(const HDCMessage& msg)
{
    sharedCtx_.rspCode = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    if (sharedCtx_.rspCode == ResponseCode::FAIL) {
        return;
    }
    capabilityMgr_.HandlePidQosRsp(msg);
}

void ResponseMsgDispatcher::SaveDeviceCheckCode(const HDCMessage& msg) { packageMgr_.SaveDeviceCheckCode(msg); }

} // namespace tsd
