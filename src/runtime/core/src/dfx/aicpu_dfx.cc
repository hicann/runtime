/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_dfx.hpp"

#include <vector>
#include "aicpu_c.hpp"
#include "aicpu_timeout_control.h"
#include "device.hpp"
#include "parse_kernel_dfx_info.hpp"
#include "printf.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
rtError_t SetupAicpuPrintfDfx(Device* device, uint32_t devId)
{
    NULL_PTR_RETURN(device, RT_ERROR_DEVICE_NULL);
    uint64_t aicpuPrintfAddrVal = 0;
    rtError_t ret = device->GetPrintFifoAddrAndCreateThread(&aicpuPrintfAddrVal, PRINT_AICPU);
    COND_RETURN_WARN((ret != RT_ERROR_NONE), ret, "GetPrintFifoAddrAndCreateThread for AICPU failed! error=%#x", ret);

    const std::lock_guard<std::mutex> lock(device->GetAicpuDfxInitMutex());
    if (device->IsAicpuPrintfReady()) {
        return RT_ERROR_NONE;
    }

    Stream* const ctrlStm = device->GetCtrlSQStream(device->PrimaryStream_());
    COND_RETURN_WARN(ctrlStm == nullptr, RT_ERROR_STREAM_NULL, "GetCtrlSQStream failed for SetAicpuDfx");

    constexpr size_t dfxInfoSize = sizeof(AicpuDfxInfo);
    constexpr uint64_t numAttrs = 1U;
    const size_t attrsTotalSize = sizeof(AicpuDfxAttrInfo) * static_cast<size_t>(numAttrs);
    const size_t totalSize = dfxInfoSize + attrsTotalSize;

    void* devDfxMem = nullptr;
    ret = device->Driver_()->DevMemAlloc(&devDfxMem, totalSize, RT_MEMORY_HBM, devId, MODULEID_RUNTIME);
    COND_RETURN_WARN((ret != RT_ERROR_NONE), ret, "devDfxMem alloc failed! error=%#x", ret);

    std::vector<uint8_t> buffer(totalSize, 0);
    auto* const dfxInfo = reinterpret_cast<AicpuDfxInfo*>(buffer.data());
    auto* const attrInfo = reinterpret_cast<AicpuDfxAttrInfo*>(buffer.data() + dfxInfoSize);

    dfxInfo->attrs = PtrToValue(devDfxMem) + dfxInfoSize;
    dfxInfo->numAttrs = numAttrs;
    attrInfo->attrId = static_cast<uint32_t>(AicpuDfxAttrId::MEM_INFO);
    attrInfo->value.printfMemInfo.printfMemAddr = aicpuPrintfAddrVal;
    attrInfo->value.printfMemInfo.printfMemSize = device->GetAicpuPrintfMemSize();
    attrInfo->value.printfMemInfo.resv0 = 0U;

    ret = device->Driver_()->MemCopySync(devDfxMem, totalSize, buffer.data(), totalSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devDfxMem, devId);
        RT_LOG(RT_LOG_WARNING, "devDfxMem copy failed! error=%#x", ret);
        return ret;
    }

    AicpuSetDfxArgs dfxArgs = {};
    dfxArgs.cpType = 1U;
    dfxArgs.dfxPtr = PtrToValue(devDfxMem);

    void* devDfxArgs = nullptr;
    ret = device->Driver_()->DevMemAlloc(&devDfxArgs, sizeof(dfxArgs), RT_MEMORY_HBM, devId, MODULEID_RUNTIME);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devDfxMem, devId);
        RT_LOG(RT_LOG_WARNING, "alloc devDfxArgs failed! error=%#x", ret);
        return ret;
    }
    ret = device->Driver_()->MemCopySync(
        devDfxArgs, sizeof(dfxArgs), &dfxArgs, sizeof(dfxArgs), RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devDfxMem, devId);
        (void)device->Driver_()->DevMemFree(devDfxArgs, devId);
        RT_LOG(RT_LOG_WARNING, "H2D copy devDfxArgs failed! error=%#x", ret);
        return ret;
    }

    const rtKernelLaunchNames_t dfxLaunchName = {nullptr, "SetAicpuDfx", ""};
    rtArgsEx_t dfxArgsInfo = {};
    dfxArgsInfo.args = devDfxArgs;
    dfxArgsInfo.argsSize = static_cast<uint32_t>(sizeof(AicpuSetDfxArgs));
    dfxArgsInfo.isNoNeedH2DCopy = 1U;
    uint64_t dfxTimeout = 0UL;
    if (Runtime::Instance()->IsSupportOpTimeoutMs()) {
        dfxTimeout = MAX_UINT64_NUM;
    }
    ret = StreamLaunchCpuKernel(&dfxLaunchName, 1U, &dfxArgsInfo, ctrlStm, RT_KERNEL_DEFAULT, dfxTimeout);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devDfxMem, devId);
        (void)device->Driver_()->DevMemFree(devDfxArgs, devId);
        RT_LOG(RT_LOG_WARNING, "launch SetAicpuDfx failed! error=%#x", ret);
        return ret;
    }

    ret = ctrlStm->Synchronize(false, 10000);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devDfxMem, devId);
        (void)device->Driver_()->DevMemFree(devDfxArgs, devId);
        RT_LOG(RT_LOG_WARNING, "SetAicpuDfx sync failed! error=%#x", ret);
        return ret;
    }

    (void)device->Driver_()->DevMemFree(devDfxArgs, devId);
    device->SetAicpuDfxSent(true);
    RT_LOG(RT_LOG_INFO, "SetAicpuDfx execute success, dfx addr: %lu", dfxArgs.dfxPtr);
    return RT_ERROR_NONE;
}

rtError_t InitAicpuPrintInfoImpl(RawDevice* device)
{
    device->aicpuPrintfMemSize_ = Runtime::Instance()->GetAicpuPrintfMemSize();
    if (device->aicpuPrintfAddr_ == nullptr) {
        rtError_t ret = device->driver_->DevMemAlloc(
            &device->aicpuPrintfAddr_, device->aicpuPrintfMemSize_, RT_MEMORY_HBM, device->deviceId_, MODULEID_RUNTIME);
        COND_RETURN_WARN(
            (ret != RT_ERROR_NONE), ret, "Malloc aicpu printf mem failed, device_id=%u, ret=%u.", device->deviceId_,
            ret);

        ret = InitAicpuPrintf(
            device->aicpuPrintfAddr_, static_cast<size_t>(device->aicpuPrintfMemSize_), device->driver_);
        if (ret != RT_ERROR_NONE) {
            (void)device->driver_->DevMemFree(device->aicpuPrintfAddr_, device->deviceId_);
            device->aicpuPrintfAddr_ = nullptr;
            RT_LOG(RT_LOG_WARNING, "InitAicpuPrintf failed, device_id=%u, ret=%u.", device->deviceId_, ret);
            return ret;
        }
    }

    RT_LOG(
        RT_LOG_INFO, "InitAicpuPrintInfo succ, device_id=%u, aicpuPrintfAddr_=%p, aicpuPrintfMemSize_=%u.",
        device->deviceId_, device->aicpuPrintfAddr_, device->aicpuPrintfMemSize_);
    return RT_ERROR_NONE;
}

rtError_t ParseAicpuPrintInfoImpl(RawDevice* device)
{
    if (!device->aicpuDfxSent_ || device->aicpuPrintfAddr_ == nullptr) {
        return RT_ERROR_NONE;
    }

    uint32_t userDeviceId = device->deviceId_;
    if (Runtime::Instance()->GetUserDevIdByDeviceId(device->deviceId_, &userDeviceId) != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "GetUserDevIdByDeviceId failed, fallback to driver deviceId=%u.", device->deviceId_);
        userDeviceId = device->deviceId_;
    }
    rtError_t ret;
    const rtParseDfxInfoFunc cb = ParseKernelDfxInfo::Instance()->GetCallback();
    if (cb != nullptr) {
        ret = ParseAicpuPrintfV2(
            device->aicpuPrintfAddr_, static_cast<size_t>(device->aicpuPrintfMemSize_), device->driver_, userDeviceId);
    } else {
        ret = ParseAicpuPrintf(
            device->aicpuPrintfAddr_, static_cast<size_t>(device->aicpuPrintfMemSize_), device->driver_, device);
    }
    COND_RETURN_WARN(
        (ret != RT_ERROR_NONE), ret, "ParseAicpuPrintInfo failed, device_id=%u, ret=%u.", device->deviceId_, ret);
    return RT_ERROR_NONE;
}

rtError_t CheckAicpuDfxSupportImpl(RawDevice* device)
{
    static const std::string checkKernelName = "tsKernel:SetAicpuDfx";
    bool isSupported = false;
    const rtError_t ret = AicpuTimeoutControl::CheckKernelSupported(device, checkKernelName, isSupported);
    COND_RETURN_WARN(ret != RT_ERROR_NONE, ret, "Check SetAicpuDfx support failed, ret=%#x", ret);

    device->aicpuDfxSupport_ = isSupported;
    RT_LOG(RT_LOG_INFO, "CheckAicpuDfxSupport result=%d", device->aicpuDfxSupport_);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
