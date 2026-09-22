/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_debug_c.hpp"
#include "runtime.hpp"
#include "program.hpp"
#include <map>
#include "device.hpp"
#include "driver_enum_desc.hpp"
#include "driver.hpp"
#include "error_message_manage.hpp"
#include "osal.hpp"
#include "task.hpp"
#include "type_def.h"

namespace cce {
namespace runtime {
namespace {
constexpr uint64_t DEBUG_DEVMEM_LEN = 4096U;
constexpr uint64_t L0A_SIZE = 65536;  // 同L0B_SIZE
constexpr uint64_t L0C_SIZE = 262144; // 同UB_SIZE
constexpr uint64_t L1_SIZE = 1048576;

rtError_t CheckCoreParam(const uint32_t coreType, const uint32_t coreId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (coreType != 0 && coreType != 1), RT_ERROR_INVALID_VALUE,
        "Verifying the validity of the compute core type and stack type", coreType,
        "[0, " + std::to_string(RT_CORE_TYPE_AIV) + "]");
    if (coreType == 0) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
            (coreId >= RT_AICORE_NUM_25), RT_ERROR_INVALID_VALUE,
            "Verifying the validity of the compute core type and stack type", coreId,
            "[0, " + std::to_string(RT_AICORE_NUM_25) + ")");
    } else {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
            (coreId >= RT_AIVECTOR_NUM_50), RT_ERROR_INVALID_VALUE,
            "Verifying the validity of the compute core type and stack type", coreId,
            "[0, " + std::to_string(RT_AIVECTOR_NUM_50) + ")");
    }
    return RT_ERROR_NONE;
}

rtError_t CheckMemoryParam(const rtDebugMemoryParam_t* const param)
{
    static const std::map<rtDebugMemoryType_t, uint64_t> BUFFER_SIZE = {
        {RT_MEM_TYPE_L0A, L0A_SIZE}, {RT_MEM_TYPE_L0B, L0A_SIZE}, {RT_MEM_TYPE_L0C, L0C_SIZE},
        {RT_MEM_TYPE_UB, L0C_SIZE},  {RT_MEM_TYPE_L1, L1_SIZE},
    };

    NULL_PTR_RETURN_MSG(param, RT_ERROR_INVALID_VALUE);
    const auto& iter = BUFFER_SIZE.find(param->debugMemType);
    if (iter != BUFFER_SIZE.end()) {
        const bool isValid = ((param->srcAddr + param->memLen) <= iter->second);
        COND_RETURN_ERROR(
            (!isValid), RT_ERROR_INVALID_VALUE,
            "The read memory boundary exceeds the hardware memory boundary of the specified memory type,"
            " debugMemType=%s(%d), srcAddr=0x%llx, memLen=%llu.",
            DebugMemoryTypeName(param->debugMemType), param->debugMemType, param->srcAddr, param->memLen);
    }
    if (param->debugMemType == RT_MEM_TYPE_REGISTER) {
        COND_RETURN_ERROR(
            (param->elementSize == 0U), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam failed, elementSize cannot be 0, debugMemType=%s(%d), srcAddr=0x%llx, memLen=%llu.",
            DebugMemoryTypeName(param->debugMemType), param->debugMemType, param->srcAddr, param->memLen);
        COND_RETURN_ERROR(
            (param->memLen % param->elementSize != 0), RT_ERROR_INVALID_VALUE,
            "The read memory length %llu is not aligned with the register bit width %u.", param->memLen,
            param->elementSize);
    }
    return RT_ERROR_NONE;
}

} // namespace

rtError_t DebugReadAICore(const rtDebugMemoryParam_t* const param, const Device* const device)
{
    COND_RETURN_ERROR((!device->IsCoredumpEnable()), RT_ERROR_INVALID_VALUE, "Coredump mode is disabled!");
    auto ret = CheckMemoryParam(param);
    ERROR_RETURN(ret, "CheckMemoryParam fail.");
    RT_LOG(
        RT_LOG_INFO,
        "Start to DebugReadAICore, coreType=%u, coreId=%u, debugMemType=%u, elementSize=%u, "
        "memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.",
        param->coreType, param->coreId, param->debugMemType, param->elementSize, param->memLen, param->srcAddr,
        param->dstAddr);

    Driver* const devDrv = device->Driver_();
    const uint32_t deviceId = device->Id_();
    void* devMem = nullptr;
    uint64_t physicPtr = 0U;
    ret = devDrv->DevMemAlloc(&devMem, DEBUG_DEVMEM_LEN, RT_MEMORY_HBM, deviceId);
    ERROR_RETURN(ret, "Failed to allocate device memory, retCode=%#x.", ret);
    ScopeGuard guard([&devMem, &devDrv, &deviceId]() { (void)devDrv->DevMemFree(devMem, deviceId); });
    ret = devDrv->MemAddressTranslate(static_cast<int32_t>(deviceId), PtrToValue(devMem), &physicPtr);
    ERROR_RETURN(ret, "Failed to translate device memory address, ptr=%p, retCode=%#x.", devMem, ret);
    RT_LOG(RT_LOG_INFO, "Malloc tmp buffer, vptr=%p, pptr=0x%llx.", devMem, physicPtr);

    uint64_t remainSize = param->memLen;
    uint64_t offset = 0U;
    while (remainSize > 0U) {
        RtDebugSendInfo sendInfo = {};
        sendInfo.reqId = (param->debugMemType == RT_MEM_TYPE_REGISTER) ? READ_REGISTER_BY_CURPROCESS :
                                                                         READ_LOCAL_MEMORY_BY_CURPROCESS;
        sendInfo.isReturn = true;
        sendInfo.dataLen = static_cast<uint32_t>(sizeof(rtStarsLocalMemoryParam_t));
        rtStarsLocalMemoryParam_t* memoryParam = RtPtrToPtr<rtStarsLocalMemoryParam_t*, uint8_t*>(sendInfo.params);
        memoryParam->coreType = param->coreType;
        memoryParam->coreId = param->coreId;
        memoryParam->debugMemType = param->debugMemType; // 读取local mem时，rts枚举取值当前与ts侧的定义一致
        memoryParam->elementSize = param->elementSize;
        memoryParam->srcAddr = param->srcAddr + offset;
        memoryParam->dstAddr = physicPtr;
        if (remainSize > DEBUG_DEVMEM_LEN) {
            memoryParam->memLen = DEBUG_DEVMEM_LEN;
            remainSize -= DEBUG_DEVMEM_LEN;
        } else {
            memoryParam->memLen = remainSize;
            remainSize = 0U;
        }

        ret = devDrv->MemSetSync(devMem, DEBUG_DEVMEM_LEN, 0U, DEBUG_DEVMEM_LEN);
        ERROR_RETURN(ret, "Failed to set device memory, addr=%p, retCode=%#x.", devMem, ret);
        rtDebugReportInfo_t reportInfo = {};
        ret = SendAndRecvDebugTask(&sendInfo, &reportInfo, device);
        COND_RETURN_ERROR(
            ((ret != RT_ERROR_NONE) || (reportInfo.returnVal != 0U)), RT_ERROR_INVALID_VALUE,
            "DebugReadAICore failed, retCode=%#x, reportVal=%u, coreType=%u, coreId=%u, debugMemType=%s(%u), "
            "elementSize=%u, memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.",
            ret, reportInfo.returnVal, param->coreType, param->coreId, DebugMemoryTypeName(param->debugMemType),
            static_cast<uint32_t>(param->debugMemType), memoryParam->elementSize, memoryParam->memLen,
            memoryParam->srcAddr, memoryParam->dstAddr);

        ret = devDrv->MemCopySync(
            ValueToPtr(param->dstAddr + offset), memoryParam->memLen, devMem, memoryParam->memLen,
            RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(
            ret, "Failed to copy memory, retCode=%#x, dstAddr=0x%llx, srcAddr=%p, memLen=%llu.", ret,
            param->dstAddr + offset, devMem, memoryParam->memLen);

        offset += memoryParam->memLen;
    }
    RT_LOG(RT_LOG_INFO, "ReadAICore success");
    return RT_ERROR_NONE;
}

rtError_t GetStackBuffer(
    const Program* const programHdl, uint32_t deviceId, const uint32_t stackType, const uint32_t coreType,
    const uint32_t coreId, const void** stack, uint32_t* stackSize, const Device* const device)
{
    UNUSED(deviceId);
    UNUSED(stackType);
    const auto ret = CheckCoreParam(coreType, coreId);
    ERROR_RETURN(ret, "CheckCoreParam fail, coreType=%u, coreId=%u.", coreType, coreId);
    RT_LOG(
        RT_LOG_INFO, "Start to get stack buffer, bin handle %p, coreType %u, coreId %u", programHdl, coreType, coreId);

    *stackSize = programHdl->GetStackSize();
    const void* stackPhyBase =
        (*stackSize == KERNEL_STACK_SIZE_32K) ? device->GetStackPhyBase32k() : device->GetStackPhyBase16k();
    const uint32_t maxMinStackSize = programHdl->GetMaxMinStackSize();
    const uint32_t deviceCustomerStackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
    if ((deviceCustomerStackSize != 0U) && (maxMinStackSize > 0)) {
        // -o0的情况下不考虑16KB的栈，因为编译器-o0的情况下能识别最小为32KB的栈
        if (maxMinStackSize > KERNEL_STACK_SIZE_32K) {
            *stackSize = deviceCustomerStackSize;
            stackPhyBase = device->GetCustomerStackPhyBase();
        } else {
            *stackSize = KERNEL_STACK_SIZE_32K;
            stackPhyBase = device->GetStackPhyBase32k();
        }
    }
    const uint32_t aicNum = device->GetDevProperties().aicNumForCoreStack;
    if (coreType == 0U) {
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * coreId);
    } else {
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * (aicNum + coreId));
    }
    RT_LOG(RT_LOG_INFO, "Get stack addr %p, stackSize %u", *stack, *stackSize);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
