/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "api_impl_soma.hpp"
#include "simd_memsetd32.h"
#include "common_memset_d32.h"

namespace cce {
namespace runtime {

rtError_t ApiImpl::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify, const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(retCntNotify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    UNUSED(inCntNotify);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                   const rtCntNtyRecordInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                            const rtCntNtyWaitInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    UNUSED(inCntNotify);
    UNUSED(notifyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                       rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    UNUSED(cmd);
    UNUSED(devInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    UNUSED(resInfo);
    UNUSED(addrInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;    
}

rtError_t ApiImpl::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    UNUSED(resInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT; 
}

rtError_t ApiImpl::WriteValuePtr(void * const writeValueInfo, Stream * const stm,
    void * const pointedAddr)
{
    UNUSED(writeValueInfo);
    UNUSED(stm);
    UNUSED(pointedAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskAbort(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamRecover(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskClean(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::DeviceResourceClean(int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase)
{
    UNUSED(prog);
    UNUSED(deviceBase);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
    const uint32_t flag)
{
    UNUSED(fftsPlusTaskInfo);
    UNUSED(stm);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

// dqs
rtError_t ApiImpl::LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg)
{
    UNUSED(stm);
    UNUSED(taskCfg);
    return RT_ERROR_FEATURE_NOT_SUPPORT;    
}

rtError_t ApiImpl::GetDeviceVirtualInfo(uint32_t deviceId, int64_t *val)
{
    UNUSED(deviceId);
    UNUSED(val);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDeviceNpuArch(uint32_t deviceId, int64_t *val)
{
    UNUSED(deviceId);
    UNUSED(val);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    UNUSED(deviceId);
    UNUSED(isHugeOnly);
    UNUSED(freeSize);
    UNUSED(totalSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
    const std::string &key, int64_t * const value)
{
    UNUSED(deviceId);
    UNUSED(label);
    UNUSED(key);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::EventWorkModeSet(uint8_t mode)
{
    UNUSED(mode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::EventWorkModeGet(uint8_t *mode)
{
    UNUSED(mode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    UNUSED(evt);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    UNUSED(event);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    UNUSED(memPool);
    UNUSED(poolProps);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::StreamMemPoolDestroy(const rtMemPool_t memPool)
{
    UNUSED(memPool);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    UNUSED(memPool);
    UNUSED(attr);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    UNUSED(memPool);
    UNUSED(attr);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::MemPoolMallocAsync(void ** const devPtr, const uint64_t size, const rtMemPool_t memPoolId,
                                      Stream * const stm)
{
    UNUSED(devPtr);
    UNUSED(size);
    UNUSED(memPoolId);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
 
rtError_t ApiImplSoma::MemPoolFreeAsync(void * const ptr, Stream * const stm)
{
    UNUSED(ptr);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(advise);
    UNUSED(location);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    UNUSED(attribute);
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(data);
    UNUSED(dataSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)
{
    UNUSED(attributes);
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(data);
    UNUSED(numAttributes);
    UNUSED(dataSizes);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
rtError_t ApiImplSoma::MemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep)
{
    UNUSED(memPool);
    UNUSED(minBytesToKeep);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplSoma::MemPoolTrimImplicit(bool includeGraphPool)
{
    UNUSED(includeGraphPool);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool ApiImplSoma::InMemPoolRegion(void * const ptr)
{
    UNUSED(ptr);
    return false;
}

rtError_t ApiImplSoma::MemPoolFreeSync(void* const ptr)
{
    UNUSED(ptr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemManagedPrefetchAsync(const void* ptr, size_t size, rtMemManagedLocation location,
    uint32_t flags, Stream* const stream)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(location);
    UNUSED(flags);
    UNUSED(stream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count,
    rtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags,
    Stream* const stream)
{
    UNUSED(ptrs);
    UNUSED(sizes);
    UNUSED(count);
    UNUSED(prefetchLocs);
    UNUSED(prefetchLocIdxs);
    UNUSED(numPrefetchLocs);
    UNUSED(flags);
    UNUSED(stream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemsetD32(void * const dst, const uint64_t destMax, const uint32_t value, const uint64_t count)
{
    (void)dst;
    (void)destMax;
    (void)value;
    (void)count;
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemsetD32Async(void* const dst, const uint64_t destMax,
        const uint32_t value, const uint64_t count, Stream* const stm)
{
    (void)dst;
    (void)destMax;
    (void)value;
    (void)count;
    (void)stm;
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCaptureEvent(const Stream * const stm, Event * const evt, Event ** const captureEvt,
    const bool isNewEvt)
{
    UNUSED(stm);
    UNUSED(evt);
    UNUSED(captureEvt);
    UNUSED(isNewEvt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CaptureEventRecord(Context * const ctx, Event * const evt, Stream * const stm)
{
    UNUSED(ctx);
    UNUSED(evt);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CaptureEventWait(Context * const ctx, Stream * const stm, Event * const evt, const uint32_t timeout)
{
    UNUSED(ctx);
    UNUSED(stm);
    UNUSED(evt);
    UNUSED(timeout);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CaptureEventReset(const Event * const evt, Stream * const stm)
{
    UNUSED(evt);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode, Model * const mdl)
{
    UNUSED(stm);
    UNUSED(mode);
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    UNUSED(stm);
    UNUSED(captureMdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
    Model ** const captureMdl)
{
    UNUSED(stm);
    UNUSED(status);
    UNUSED(captureMdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    UNUSED(mode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamBeginTaskGrp(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    UNUSED(stm);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    UNUSED(stm);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamEndTaskUpdate(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    UNUSED(mdl);
    UNUSED(num);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ModelDebugDotPrint(const Model * const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    UNUSED(mdl);
    UNUSED(path);
    UNUSED(flags);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    UNUSED(stm);
    UNUSED(captureMdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ModelCondHandleCreate(Model * const mdl, uint32_t defaultValue,
    rtCondHandleFlag_t flag, CondHandle ** const handle)
{
    UNUSED(mdl);
    UNUSED(defaultValue);
    UNUSED(flag);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ModelCondHandleGetCondPtr(CondHandle * const handle, uint64_t ** const devPtr)
{
    UNUSED(handle);
    UNUSED(devPtr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamAddCondTaskParasCheck(rtCondTaskParams params, Stream * const stm, CondHandle **handle)
{
    UNUSED(params);
    UNUSED(stm);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamAddCondTask(rtCondTaskParams params, Stream * const stm, uint32_t flags)
{
    UNUSED(params);
    UNUSED(stm);
    UNUSED(flags);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

}
}