/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc_message_builder.h"

#include <string>

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
}  // namespace

TSD_StatusT HdcMessageBuilder::BuildOpen(HDCMessage &hdcMsg, const MessageContext &ctx)
{
    hdcMsg.set_rank_size(ctx.rankSize);
    hdcMsg.set_start_hccp(ctx.startHccp);
    hdcMsg.set_start_cp(ctx.startCp);
    hdcMsg.set_profiling_mode(ctx.profilingMode);
    hdcMsg.set_device_id(ctx.logicDeviceId % PER_OS_CHIP_NUM);
    LogLevel * const level = hdcMsg.mutable_log_level();
    if (level == nullptr) {
        TSD_ERROR("mutable log level error");
        return TSD_INTERNAL_ERROR;
    }
    level->set_log_level(ctx.logLevel);
    CcecpuLogLevel * const ccecpuLogLevel = hdcMsg.mutable_ccecpu_log_level();
    if (ccecpuLogLevel != nullptr) {
        ccecpuLogLevel->set_ccecpu_log_level(ctx.ccecpuLogLevel);
    }
    AicpuLogLevel * const aicpuLogLevel = hdcMsg.mutable_aicpu_log_level();
    if (aicpuLogLevel != nullptr) {
        aicpuLogLevel->set_aicpu_log_level(ctx.aicpuLogLevel);
    }
    // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    hdcMsg.set_real_device_id(ctx.logicDeviceId);
    ProcessSignPid * const proSignPid = hdcMsg.mutable_proc_sign_pid();
    if (proSignPid == nullptr) {
        TSD_ERROR("mutable proSignPid error");
        return TSD_INTERNAL_ERROR;
    }
    proSignPid->set_proc_pid(static_cast<uint32_t>(ctx.procSign.tgid));
    const std::string signStr(ctx.procSign.sign);
    proSignPid->set_proc_sign(signStr);
    TSD_RUN_INFO("[TsdClient] tsd get process sign successfully, procpid[%u] signSize[%zu]",
                 static_cast<uint32_t>(ctx.procSign.tgid), signStr.length());
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
    AscendAicpuPath * const ascendAicpuPath = hdcMsg.mutable_ascend_aicpu_path();
    if (ascendAicpuPath == nullptr) {
        TSD_ERROR("mutable ascend aicpu path error");
        return TSD_INTERNAL_ERROR;
    }
    ascendAicpuPath->set_ascend_aicpu_path(aicpuPath);
    return TSD_OK;
}

TSD_StatusT HdcMessageBuilder::BuildClose(HDCMessage &msg, const MessageContext &ctx)
{
    msg.set_device_id(ctx.logicDeviceId % PER_OS_CHIP_NUM);
    // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    msg.set_real_device_id(ctx.logicDeviceId);
    msg.set_type(HDCMessage::TSD_CLOSE_PROC_MSG);
    msg.set_rank_size(ctx.rankSize);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    if (signPid == nullptr) {
        TSD_ERROR("protobuf new pidSign error");
        return TSD_INTERNAL_ERROR;
    }
    signPid->set_proc_pid(static_cast<uint32_t>(ctx.procSign.tgid));
    return TSD_OK;
}
}  // namespace tsd
