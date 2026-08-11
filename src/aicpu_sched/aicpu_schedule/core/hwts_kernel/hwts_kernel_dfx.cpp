/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_dfx.h"

#include "aicpu_context.h"
#include "aicpu_prof.h"
#include "aicpusd_profiler.h"
#include "profiling_adp.h"
#include "aicpusd_monitor.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_hal_interface_ref.h"
#include "tsd.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_err_process.h"
#include "dump_task.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string CFG_LOG_ADDR = "CfgLogAddr";
const std::string DUMP_DATA_INFO = "DumpDataInfo";
const std::string SET_AICPU_DFX = "SetAicpuDfx";
constexpr uint32_t CUSTOM_CP_CCPU_GROUP_ID = 31U;

enum class DfxCpType : uint8_t {
    AICPUSD = 0,        /* aicpusd */
    CUSTOM_AICPUSD = 1, /* custom_aicpusd */
};
} // namespace

int32_t CfgLogAddrTsKernel::Compute(const aicpu::HwtsTsKernel& tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel CfgLogAddr event.");
    const auto cfgMsg = PtrToPtr<void, aicpu::AicpuConfigMsg>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (cfgMsg == nullptr) {
        aicpusd_err("param base for config log is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(*cfgMsg);
    return AICPU_SCHEDULE_OK;
}

int32_t DumpDataInfoTsKernel::Compute(const aicpu::HwtsTsKernel& tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel dump data event");
    const aicpu::HwtsCceKernel& kernel = tsKernelInfo.kernelBase.cceKernel;
    // dump op has two param, one is protobuf addr
    constexpr uint32_t singleOpDumpParamNum = 2U;
    constexpr size_t len = sizeof(aicpu::AicpuParamHead) + (singleOpDumpParamNum * sizeof(uint64_t));
    const aicpu::AicpuParamHead* const paramHead = PtrToPtr<void, aicpu::AicpuParamHead>(ValueToPtr(kernel.paramBase));
    if (paramHead == nullptr) {
        aicpusd_err("paramHead for DumpDataKernel is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (static_cast<size_t>(paramHead->length) != len) {
        aicpusd_err("data dump param length[%u] shoulf be [%zu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto ioAddrBase = PtrToPtr<void, uint64_t>(ValueToPtr(kernel.paramBase + sizeof(aicpu::AicpuParamHead)));
    const uint64_t opMappingInfoAddr = ioAddrBase[0];
    const uint64_t* const lenAddr = PtrToPtr<void, uint64_t>(ValueToPtr(ioAddrBase[1]));
    if (lenAddr == nullptr) {
        aicpusd_err("data dump proto length address is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("Get proto len from address[%llu]", ioAddrBase[1]);
    const uint64_t opMappingInfoLen = *lenAddr;
    aicpusd_info("Proto len[%llu] from address[%llu]", opMappingInfoLen, opMappingInfoAddr);

    const AicpuSchedule::OpDumpTaskManager& dumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
    return dumpTaskMgr.DumpOpInfoForUnknowShape(opMappingInfoAddr, opMappingInfoLen);
}

int32_t SetAicpuDfxTsKernel::Compute(const aicpu::HwtsTsKernel& tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel SetAicpuDfx event.");
    const auto dfxInfo = PtrToPtr<void, aicpu::AicpuDfxInfo>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (dfxInfo == nullptr) {
        aicpusd_err("param base for dfx info is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto cpType = static_cast<DfxCpType>(dfxInfo->cpType);
    if (cpType == DfxCpType::AICPUSD) {
        aicpusd_info("Set dfx info for aicpusd, infoAddr is %lu.", dfxInfo->infoAddr);
        aicpu::AicpuSetDfxInfo(dfxInfo->infoAddr);
        return AICPU_SCHEDULE_OK;
    }
    if (cpType == DfxCpType::CUSTOM_AICPUSD) {
        aicpusd_info("Set dfx info for custom_aicpusd, infoAddr is %lu.", dfxInfo->infoAddr);
        return SetDfxInfoToCustomSd(dfxInfo->infoAddr);
    } else {
        aicpusd_err("dfx info cpType[%u] is invalid", dfxInfo->cpType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
}

int32_t SetAicpuDfxTsKernel::SetDfxInfoToCustomSd(const uint64_t infoAddr) const
{
    AicpuDfxInfoReq req = {};
    req.infoAddr = infoAddr;
    event_summary syncDfxInfo = {};
    syncDfxInfo.msg = PtrToPtr<AicpuDfxInfoReq, char_t>(&req);
    syncDfxInfo.msg_len = static_cast<uint32_t>(sizeof(AicpuDfxInfoReq));
    syncDfxInfo.dst_engine = CCPU_DEVICE;
    syncDfxInfo.policy = ONLY;
    syncDfxInfo.pid = AicpuScheduleInterface::GetInstance().GetAicpuCustSdProcId();
    syncDfxInfo.grp_id = CUSTOM_CP_CCPU_GROUP_ID;
    syncDfxInfo.event_id = EVENT_CCPU_CTRL_MSG;
    syncDfxInfo.subevent_id = AICPU_SUB_EVENT_SET_DFX_INFO;

    int32_t syncRet = 0;
    event_reply drvAck = {};
    drvAck.buf = PtrToPtr<int32_t, char>(&syncRet);
    drvAck.buf_len = sizeof(int32_t);
    const int32_t timeOutMs = 5000;
    const auto drvRet =
        halEschedSubmitEventSync(AicpuDrvManager::GetInstance().GetDeviceId(), &syncDfxInfo, timeOutMs, &drvAck);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to submit event to custom sd, ret=[%d].", static_cast<int32_t>(drvRet));
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    if (syncRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to set dfx info for custom sd, ret=[%d].", syncRet);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    return AICPU_SCHEDULE_OK;
}

REGISTER_HWTS_KERNEL(CFG_LOG_ADDR, CfgLogAddrTsKernel);
REGISTER_HWTS_KERNEL(DUMP_DATA_INFO, DumpDataInfoTsKernel);
REGISTER_HWTS_KERNEL(SET_AICPU_DFX, SetAicpuDfxTsKernel);
} // namespace AicpuSchedule
