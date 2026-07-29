/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
namespace cce {
namespace runtime {
rtError_t NpuDriver::CreateAsyncDmaWqe(
    uint32_t devId, const AsyncDmaWqeInputInfo& input, AsyncDmaWqeOutputInfo* output, bool isUbMode, bool isSqeUpdate)
{
    UNUSED(devId);
    UNUSED(input);
    UNUSED(output);
    UNUSED(isSqeUpdate);
    UNUSED(isUbMode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::DestroyAsyncDmaWqe(uint32_t devId, struct AsyncDmaWqeDestroyInfo* destroyPara, bool isUbMode)
{
    UNUSED(devId);
    UNUSED(destroyPara);
    UNUSED(isUbMode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::CreateAsyncDmaWqe2D(
    uint32_t devId, const AsyncDmaWqeInputInfo2D& input, AsyncDmaWqeOutputInfo* output)
{
    UNUSED(devId);
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::DestroyAsyncDmaWqe2D(uint32_t devId, struct AsyncDmaWqeDestroyInfo2D* destroyPara)
{
    UNUSED(devId);
    UNUSED(destroyPara);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::CreateAsyncDmaWqeBatch(
    uint32_t devId, const AsyncDmaWqeInputInfoBatch& input, AsyncDmaWqeOutputInfo* output)
{
    UNUSED(devId);
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::DestroyAsyncDmaWqeBatch(uint32_t devId, struct AsyncDmaWqeDestroyInfoBatch* destroyPara)
{
    UNUSED(devId);
    UNUSED(destroyPara);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetStarsInfo(const uint32_t deviceId, const uint32_t tsId, uint64_t& addr)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(addr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetTsfwVersion(const uint32_t deviceId, const uint32_t tsId, uint32_t& version)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(version);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::UnmapSqRegVirtualAddrBySqid(const int32_t deviceId, const uint32_t tsId, const uint32_t sqId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::WriteNotifyRecord(const uint32_t deviceId, const uint32_t tsId, const uint32_t notifyId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(notifyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::QueryUbInfo(const uint32_t deviceId, rtUbDevQueryCmd cmd, void* const devInfo)
{
    UNUSED(deviceId);
    UNUSED(cmd);
    UNUSED(devInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetDevResAddress(
    const uint32_t deviceId, const rtDevResInfo* const resInfo, uint64_t* resAddr, uint32_t* resLen)
{
    UNUSED(deviceId);
    UNUSED(resInfo);
    UNUSED(resAddr);
    UNUSED(resLen);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::ReleaseDevResAddress(const uint32_t deviceId, const rtDevResInfo* const resInfo)
{
    UNUSED(deviceId);
    UNUSED(resInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetSqAddrInfo(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint64_t& sqAddr)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(sqAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::SqArgsCopyWithUb(uint32_t devId, struct halSqTaskArgsInfo* sqArgs)
{
    UNUSED(devId);
    UNUSED(sqArgs);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::SetSqTail(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, const uint32_t tail)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(tail);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StopSqSend(const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::ResumeSqSend(const uint32_t deviceId, const uint32_t tsId)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamTaskFill(
    uint32_t devId, uint32_t streamId, void* streamMem, void* taskInfo, uint32_t taskCnt)
{
    UNUSED(devId);
    UNUSED(streamId);
    UNUSED(taskInfo);
    UNUSED(taskCnt);
    UNUSED(streamMem);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ResetSqCq(
    const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, const uint32_t streamFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(streamFlag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::ResetLogicCq(
    const uint32_t deviceId, const uint32_t tsId, const uint32_t logicCqId, const uint32_t streamFlag)
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(logicCqId);
    UNUSED(streamFlag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetSqRegVirtualAddrBySqidForDavid(
    const int32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint64_t* const addr) const
{
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(sqId);
    UNUSED(addr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::GetTsegInfoByVa(
    uint32_t devid, uint64_t va, uint64_t size, uint32_t flag, struct halTsegInfo* tsegInfo)
{
    UNUSED(devid);
    UNUSED(va);
    UNUSED(size);
    UNUSED(flag);
    UNUSED(tsegInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::PutTsegInfo(uint32_t devid, struct halTsegInfo* tsegInfo)
{
    UNUSED(devid);
    UNUSED(tsegInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamMemPoolCreate(
    const uint32_t deviceId, const uint64_t poolId, const uint64_t size, bool isGraphPool, uint64_t& outVa)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    UNUSED(size);
    UNUSED(isGraphPool);
    UNUSED(outVa);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamMemPoolDestroy(const uint32_t deviceId, const uint64_t poolId)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamMemPoolTrim(
    const uint32_t deviceId, const uint64_t poolId, uint64_t* size, uint64_t poolUsedSize, uint64_t poolFreeSize)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    UNUSED(size);
    UNUSED(poolUsedSize);
    UNUSED(poolFreeSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::AsyncDmaJettyCreate(
    const uint32_t devId, const uint32_t piType, const uint32_t depth, const uint32_t dir, uint64_t* const handle)
{
    UNUSED(devId);
    UNUSED(piType);
    UNUSED(depth);
    UNUSED(dir);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::AsyncDmaJettyDestroy(const uint32_t devId, const uint64_t handle)
{
    UNUSED(devId);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::AsyncDmaJettyQuery(
    const uint32_t devId, const uint64_t handle, uint32_t& dieId, uint32_t& functionId, uint32_t& jettyId)
{
    UNUSED(devId);
    UNUSED(handle);
    UNUSED(dieId);
    UNUSED(functionId);
    UNUSED(jettyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::AsyncDmaWqeConvert(const uint32_t devId, AsyncWqeInputPara* inParam, AsyncWqeOutputPara* outParam)
{
    UNUSED(devId);
    UNUSED(inParam);
    UNUSED(outParam);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::AsyncDmaWqeFill(const uint32_t devId, AsyncWqeFillInfo* fillInfo)
{
    UNUSED(devId);
    UNUSED(fillInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
rtError_t NpuDriver::StreamMemPoolSetAttr(
    const uint32_t deviceId, const uint64_t poolId, const rtMemPoolAttr attr, void* value)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    UNUSED(attr);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamMemPoolGetAttr(
    const uint32_t deviceId, const uint64_t poolId, const rtMemPoolAttr attr, void* value)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    UNUSED(attr);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::StreamMemPoolAsyncConfig(
    const uint32_t deviceId, const uint64_t poolId, const uint64_t va, const uint64_t size, const bool flag)
{
    UNUSED(deviceId);
    UNUSED(poolId);
    UNUSED(va);
    UNUSED(size);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::DevMemAllocHugePageManaged(
    void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId,
    const bool isLogError, const bool readOnlyFlag, const bool cpOnlyFlag)
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(type);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(cpOnlyFlag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::DevMemAllocManaged(
    void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId,
    const bool isLogError, const bool readOnlyFlag, const bool starsTillingFlag, const bool cpOnlyFlag) const
{
    UNUSED(dptr);
    UNUSED(size);
    UNUSED(type);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(starsTillingFlag);
    UNUSED(cpOnlyFlag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce