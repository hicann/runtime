/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "para_convertor.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
rtError_t ConvertArgsByArgsHandle(rtArgsEx_t &oldArgs, const RtArgsHandle *const argsHandle,
    rtHostInputInfo_t specialArgsInfos[], const uint8_t arrayArgsNum)
{
    oldArgs.args = argsHandle->buffer;
    oldArgs.argsSize = static_cast<uint32_t>(argsHandle->argsSize);
    oldArgs.hasTiling = false;
    oldArgs.isNoNeedH2DCopy = 0U;
    oldArgs.hostInputInfoPtr = nullptr;
    oldArgs.hostInputInfoNum = 0U;
    COND_RETURN_WITH_NOLOG(argsHandle->placeHolderNum == 0U, RT_ERROR_NONE);

    uint8_t phIndex = 0U;
    for (uint8_t idx = 0U; idx < argsHandle->realUserParamNum; idx++) {
        if (argsHandle->para[idx].type == 0U) { // 0 is Common param, 1 is place holder param
            continue;
        }
        COND_RETURN_OUT_ERROR_MSG_CALL(phIndex >= arrayArgsNum, RT_ERROR_INVALID_VALUE,
            "phIndex[%u] should less than phNum[%u].", phIndex, arrayArgsNum);
        specialArgsInfos[phIndex].dataOffset = static_cast<uint32_t>(argsHandle->para[idx].dataOffset);
        specialArgsInfos[phIndex].addrOffset = argsHandle->para[idx].paraOffset;
        phIndex++;
    }

    oldArgs.hostInputInfoPtr = specialArgsInfos;
    oldArgs.hostInputInfoNum = argsHandle->placeHolderNum;

    return RT_ERROR_NONE;
}

rtError_t ConvertCpuArgsByArgsHandle(rtCpuKernelArgs_t &oldArgs, const RtArgsHandle *const argsHandle,
    rtHostInputInfo_t specialArgsInfos[], const uint8_t arrayArgsNum)
{
    rtAicpuArgsEx_t &cpuKernelArgs = oldArgs.baseArgs;
    cpuKernelArgs.args = argsHandle->buffer;
    cpuKernelArgs.argsSize = argsHandle->argsSize;
    cpuKernelArgs.isNoNeedH2DCopy = false;
    cpuKernelArgs.hostInputInfoPtr = nullptr;
    cpuKernelArgs.hostInputInfoNum = 0U;
    cpuKernelArgs.kernelOffsetInfoPtr = nullptr;
    cpuKernelArgs.kernelOffsetInfoNum = 0U;

    // 刷新kernelNameAddrOffset和soNameAddrOffset
    CpuKernelSysArgsInfo cpuInfo = argsHandle->cpuKernelSysArgsInfo;
    cpuKernelArgs.kernelNameAddrOffset = cpuInfo.kernelNameOffset;
    cpuKernelArgs.soNameAddrOffset = cpuInfo.soNameOffset;
    const size_t headOffset = cpuInfo.soNameOffset + cpuInfo.soNameSize;
    oldArgs.cpuParamHeadOffset = headOffset;
    RT_LOG(RT_LOG_DEBUG, "cpuParamHeadOffset=%zu, soNameOffset=%zu, soNameSize=%zu", headOffset, cpuInfo.soNameOffset, cpuInfo.soNameSize);

    COND_RETURN_WITH_NOLOG(argsHandle->placeHolderNum == 0U, RT_ERROR_NONE);

    uint8_t phIndex = 0U;
    for (uint8_t idx = 0U; idx < argsHandle->realUserParamNum; idx++) {
        if (argsHandle->para[idx].type == 0U) { // 0 is Common param, 1 is place holder param
            continue;
        }
        COND_RETURN_OUT_ERROR_MSG_CALL(phIndex >= arrayArgsNum, RT_ERROR_INVALID_VALUE,
            "phIndex[%u] should less than phNum[%u].", phIndex, arrayArgsNum);
        specialArgsInfos[phIndex].dataOffset = argsHandle->para[idx].dataOffset;
        specialArgsInfos[phIndex].addrOffset = argsHandle->para[idx].paraOffset;
        phIndex++;
    }

    cpuKernelArgs.hostInputInfoPtr = specialArgsInfos;
    cpuKernelArgs.hostInputInfoNum = argsHandle->placeHolderNum;

    return RT_ERROR_NONE;
}

// api:   0:   永不超时,  其他值:    超时时间,  不传timeout: 默认超时时间
// inner: 全F: 永不超时,  其他非零值: 超时时间,  0:          默认超时时间
uint64_t ConvertTimeoutToInner(uint64_t timeout)
{
    uint64_t timeoutTmp;
    if (timeout == 0U) {
        timeoutTmp = MAX_UINT64_NUM;
    } else if (timeout == MAX_UINT64_NUM) { // 最大超时时间，而非永不超时
        timeoutTmp = timeout - 1U;
    } else {
        timeoutTmp = timeout;
    }
    return timeoutTmp;
}

static inline bool IsCpuKernelSupportTimeout(const uint32_t flag)
{
    return ((flag & RT_KERNEL_USE_SPECIAL_TIMEOUT) != 0U);
}

uint64_t ConvertAicpuTimeout(const rtAicpuArgsEx_t * const argsInfo, const TaskCfg *taskCfg,
    const uint32_t flag)
{
    if ((taskCfg != nullptr) && (taskCfg->isExtendValid == 1U) && (taskCfg->extend.timeout != 0U)) {
        return taskCfg->extend.timeout;
    }

    if (IsCpuKernelSupportTimeout(flag) && (argsInfo != nullptr) && (argsInfo->timeout != 0U)) {
        if (argsInfo->timeout == MAX_UINT16_NUM) {
            return MAX_UINT64_NUM; // never timeout
        }
        return static_cast<uint64_t>(argsInfo->timeout) * RT_TIMEOUT_S_TO_US;
    }

    return 0UL;
}

rtError_t ConvertLaunchCfgToTaskCfg(TaskCfg &taskCfg, const rtKernelLaunchCfg_t* const cfg)
{
    uint64_t timeoutUs;
    taskCfg.isBaseValid = 1U;
    taskCfg.base.dumpflag = RT_KERNEL_DEFAULT;
    taskCfg.isExtendValid = 1U;
    taskCfg.extend.timeout = 0UL; // 默认值0U，代表默认超时时间
    // cfg support nullptr, no need process
    NULL_PTR_RETURN_NOLOG(cfg, RT_ERROR_NONE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);
    for (size_t idx = 0U; idx < cfg->numAttrs; idx++) {
        switch (cfg->attrs[idx].id) {
            case RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE:
                taskCfg.base.schemMode = cfg->attrs[idx].value.schemMode;
                break;
            case RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE:
                taskCfg.base.localMemorySize = cfg->attrs[idx].value.localMemorySize;
                break;
            case RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE:
                taskCfg.extend.engineType = cfg->attrs[idx].value.engineType;
                break;
            case RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET:
                taskCfg.base.blockDimOffset = cfg->attrs[idx].value.blockDimOffset;
                break;
            case RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH:
                taskCfg.extend.blockTaskPrefetch =
                    (cfg->attrs[idx].value.isBlockTaskPrefetch == BLOCK_PREFETCH_ENABLE);
                break;
            case RT_LAUNCH_KERNEL_ATTR_DATA_DUMP:
                taskCfg.base.dumpflag = (cfg->attrs[idx].value.isDataDump == DATA_DUMP_ENABLE) ?
                    RT_KERNEL_DUMPFLAG : RT_KERNEL_DEFAULT;
                break;
            case RT_LAUNCH_KERNEL_ATTR_TIMEOUT:
                taskCfg.extend.timeout = ConvertTimeoutToInner(
                        static_cast<uint64_t>(cfg->attrs[idx].value.timeout) * RT_TIMEOUT_S_TO_US);
                break;
            case RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US:
                timeoutUs = static_cast<uint64_t>(cfg->attrs[idx].value.timeoutUs.timeoutHigh) << 32U |
                    static_cast<uint64_t>(cfg->attrs[idx].value.timeoutUs.timeoutLow);
                taskCfg.extend.timeout = ConvertTimeoutToInner(timeoutUs);
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "Launch kernel attr type[%u] is invalid, should be [1, %u)",
                    cfg->attrs[idx].id, RT_LAUNCH_KERNEL_ATTR_MAX);
                return RT_ERROR_INVALID_VALUE;
        }
    }

    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce