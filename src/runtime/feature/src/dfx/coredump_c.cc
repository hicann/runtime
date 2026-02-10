/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "coredump_c.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {

constexpr uint64_t L0A_L0B_SIZE_V100 = 65536ULL; // L0B_SIZE相同
constexpr uint64_t L0C_UB_SIZE_V100 = 262144ULL; // UB_SIZE相同
constexpr uint64_t L1_SIZE_V100 = 524288ULL;
constexpr uint64_t COREDUMP_MEM_SIZE = 4096ULL;
constexpr uint32_t DIE_NUM = 2U;
constexpr uint32_t AIC_NUM_ONE_DIE_V100 = 18U;
constexpr uint32_t AIV_NUM_ONE_DIE_V100 = AIC_NUM_ONE_DIE_V100 * 2U;
constexpr uint32_t AIC_NUM_V100 = DIE_NUM * AIC_NUM_ONE_DIE_V100;
constexpr uint32_t AIV_NUM_V100 = DIE_NUM * AIV_NUM_ONE_DIE_V100;

static const std::map<rtDebugMemoryType_t, uint64_t> debugMemSizeMap = {
    {RT_MEM_TYPE_L0A, L0A_L0B_SIZE_V100},
    {RT_MEM_TYPE_L0B, L0A_L0B_SIZE_V100},
    {RT_MEM_TYPE_L0C, L0C_UB_SIZE_V100},
    {RT_MEM_TYPE_L1, L1_SIZE_V100},
    {RT_MEM_TYPE_UB, L0C_UB_SIZE_V100},
};

static rtError_t CheckMemoryParam(const rtDebugMemoryParam_t *const param)
{
    NULL_PTR_RETURN_MSG(param, RT_ERROR_INVALID_VALUE);
    const auto &iter = debugMemSizeMap.find(param->debugMemType);
    if (iter != debugMemSizeMap.end()) {
        const bool isValid = ((param->srcAddr + param->memLen) <= iter->second);
        COND_RETURN_ERROR((!isValid), RT_ERROR_INVALID_VALUE, "CheckMemoryParam fail, debugMemType=%d, srcAddr=0x%llx, "
            "memLen=%llu.", param->debugMemType, param->srcAddr, param->memLen);
    }
    if (param->debugMemType == RT_MEM_TYPE_REGISTER) {
        COND_RETURN_ERROR((param->elementSize == 0U), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam fail, elementSize can not be 0.", param->debugMemType, param->srcAddr, param->memLen);
        COND_RETURN_ERROR((param->memLen % param->elementSize != 0U), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam register fail, memLen=%llu, elementSize=%u.", param->memLen, param->elementSize);
    }
    if (param->debugMemType == RT_MEM_TYPE_REGISTER_DIRECT) {
        COND_RETURN_ERROR((param->memLen == 0U), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam fail, memLen can not be 0, debugMemType=%d, memLen=%llu", param->debugMemType, param->memLen);
    }
    return RT_ERROR_NONE;
}

static rtError_t CheckCoreParam(const uint32_t coreType, const uint32_t coreId)
{
    COND_RETURN_ERROR(((coreType > RT_CORE_TYPE_AIV)), RT_ERROR_INVALID_VALUE,
        "coreType=%u is invalid, valid range is [0, %d]", coreType, RT_CORE_TYPE_AIV);

    if (coreType == RT_CORE_TYPE_AIC) {
        COND_RETURN_ERROR((coreId >= AIC_NUM_V100), RT_ERROR_INVALID_VALUE,
            "aic coreId=%u is invalid, valid range is [0, %u)", coreId, AIC_NUM_V100);
    } else {
        COND_RETURN_ERROR((coreId >= AIV_NUM_V100), RT_ERROR_INVALID_VALUE,
            "aiv coreId=%u is invalid, valid range is [0, %u)", coreId, AIV_NUM_V100);
    }
    return RT_ERROR_NONE;
}

static uint32_t GetDieOffset(const uint32_t coreType, const uint32_t coreId)
{
    const uint32_t dieId = (coreType == 0U) ? (coreId / AIC_NUM_ONE_DIE_V100) : (coreId / AIV_NUM_ONE_DIE_V100);
    const uint32_t coreIdOnDie = (coreType == 0U) ? (coreId % AIC_NUM_ONE_DIE_V100) : (coreId % AIV_NUM_ONE_DIE_V100);
    const uint32_t offsetBase = coreIdOnDie + (AIC_NUM_ONE_DIE_V100 + AIV_NUM_ONE_DIE_V100) * dieId;
    return  (coreType == 0U) ? offsetBase : offsetBase + AIC_NUM_ONE_DIE_V100;
}

static RtDebugCmdType GetDebugCmdType(rtDebugMemoryType_t debugMemType)
{
    if (debugMemType == RT_MEM_TYPE_REGISTER){
        return READ_REGISTER_BY_CURPROCESS;
    } else if (debugMemType == RT_MEM_TYPE_REGISTER_DIRECT) {
        return READ_REGISTER_DIRECT_BY_CURPROCESS;
    } else {
        return READ_LOCAL_MEMORY_BY_CURPROCESS;
    }
}

static rtError_t ConstructReadAICoreSendInfo(const Context *ctx, const rtDebugMemoryParam_t * const param,
    const void *devMem)
{
    uint64_t remainSize = param->memLen;
    uint64_t offset = 0U;
    Driver * const devDrv = ctx->Device_()->Driver_();
    rtError_t ret = RT_ERROR_NONE;
    while (remainSize > 0U) {
        ret = devDrv->MemSetSync(devMem, COREDUMP_MEM_SIZE, 0U, COREDUMP_MEM_SIZE);
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "memset fail, ret=%u, addr=%p", ret, devMem);
        RtDebugSendInfo sendInfo = {};
        rtDebugReportInfo_t reportInfo = {};

        sendInfo.reqId = GetDebugCmdType(param->debugMemType);
        sendInfo.isReturn = true;
        sendInfo.dataLen = static_cast<uint32_t>(sizeof(rtStarsLocalMemoryParam_t));
        rtStarsLocalMemoryParam_t *memoryParam = RtPtrToPtr<rtStarsLocalMemoryParam_t *, uint8_t *>(sendInfo.params);
        memoryParam->coreType = param->coreType;
        memoryParam->coreId = param->coreId;
        memoryParam->debugMemType = param->debugMemType; // 读取local mem时，rts枚举取值当前与ts侧的定义一致
        memoryParam->elementSize = param->elementSize;
        memoryParam->srcAddr = param->srcAddr + offset;
        memoryParam->dstAddr = RtPtrToValue(devMem);

        if (remainSize > COREDUMP_MEM_SIZE) {
            memoryParam->memLen = COREDUMP_MEM_SIZE;
            remainSize -= COREDUMP_MEM_SIZE;
        } else {
            memoryParam->memLen = remainSize;
            remainSize = 0U;
        }

        ret = ctx->SendAndRecvDebugTask(&sendInfo, &reportInfo);
        COND_RETURN_ERROR(((ret != RT_ERROR_NONE) || (reportInfo.returnVal != 0U)), RT_ERROR_INVALID_VALUE,
            "DebugReadAICore failed, retCode=%#x, reportVal=%u, coreType=%u, coreId=%u, debugMemType=%u, "
            "elementSize=%u, memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.", ret, reportInfo.returnVal, param->coreType,
            param->coreId, param->debugMemType, memoryParam->elementSize, memoryParam->memLen, memoryParam->srcAddr,
            memoryParam->dstAddr);
        ret = devDrv->MemCopySync(ValueToPtr(param->dstAddr + offset), memoryParam->memLen, devMem,
            memoryParam->memLen, RT_MEMCPY_DEVICE_TO_HOST);
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "mem copy failed, retCode=%#x, dstAddr=0x%llx, srcAddr=%p, "
            "memLen=%llu.", ret, param->dstAddr + offset, devMem, memoryParam->memLen);

        offset += memoryParam->memLen;
    }
    return ret;
}

static rtError_t DebugReleaseDevMem(const Context *curCtx)
{
    RtDebugSendInfo sendInfo = {};
    rtDebugReportInfo_t reportInfo = {};
    sendInfo.reqId = RELEASE_COREDUMP_MEMORY;
    sendInfo.isReturn = true;
    const rtError_t ret = curCtx->SendAndRecvDebugTask(&sendInfo, &reportInfo);
    COND_RETURN_ERROR(((ret != RT_ERROR_NONE) || (reportInfo.returnVal != 0U)), RT_ERROR_INVALID_VALUE,
        "DebugReleaseDevMem failed, retCode=%#x.", ret, reportInfo.returnVal);
    return RT_ERROR_NONE;
}

rtError_t ReadAICoreDebugInfo(const rtDebugMemoryParam_t * const param)
{
    const Runtime *const rt = Runtime::Instance();
    Context *curCtx = rt->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device *device = curCtx->Device_();
    NULL_PTR_RETURN(device, RT_ERROR_DEVICE_NULL);
    COND_RETURN_ERROR((!device->IsCoredumpEnable()), RT_ERROR_INVALID_VALUE, "Coredump mode is disabled.");

    rtError_t ret = CheckMemoryParam(param);
    COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
    RT_LOG(RT_LOG_DEBUG, "coreType=%u, coreId=%u, debugMemType=%u, elementSize=%u, "
        "memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.", param->coreType, param->coreId, param->debugMemType,
        param->elementSize, param->memLen, param->srcAddr, param->dstAddr);

    Driver * const devDrv = device->Driver_();
    NULL_PTR_RETURN_MSG_OUTER(devDrv, RT_ERROR_DRV_PTRNULL);
    const uint32_t deviceId = device->Id_();
    void *devMem = nullptr;
    ret = devDrv->DevMemAlloc(&devMem, COREDUMP_MEM_SIZE, RT_MEMORY_HBM, deviceId);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "malloc mem fail, ret=%u", ret);
    ScopeGuard guard([&devMem, &devDrv, &deviceId]() {
        (void)devDrv->DevMemFree(devMem, deviceId);
        devMem = nullptr;
    });

    ret = ConstructReadAICoreSendInfo(curCtx, param, devMem);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "ReadAICore fail, ret=%u", ret);
    return DebugReleaseDevMem(curCtx);
}

rtError_t GetStackBufferInfo(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
    const void **stack, uint32_t *stackSize)
{
    const Runtime *const rt = Runtime::Instance();
    Context *curCtx = rt->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device *device = curCtx->Device_();
    NULL_PTR_RETURN(device, RT_ERROR_DEVICE_NULL);
    const auto ret = CheckCoreParam(coreType, coreId);
    COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
    Program * const programHdl = RtPtrToPtr<Program *>(binHandle);
    *stackSize = KERNEL_STACK_SIZE_32K;
    const void *stackPhyBase = device->GetStackPhyBase32k();
    const uint32_t maxMinStackSize = programHdl->GetMaxMinStackSize();
    const uint32_t deviceCustomerStackSize = device->GetDeviceAllocStackSize();
    if ((deviceCustomerStackSize != 0U) && (maxMinStackSize > KERNEL_STACK_SIZE_32K)) {
        *stackSize = deviceCustomerStackSize;
        stackPhyBase = device->GetCustomerStackPhyBase();
    }
    *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * GetDieOffset(coreType, coreId));
    RT_LOG(RT_LOG_DEBUG, "coreType=%u, coreId=%u, stackSize=%u", coreType, coreId, *stackSize);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce