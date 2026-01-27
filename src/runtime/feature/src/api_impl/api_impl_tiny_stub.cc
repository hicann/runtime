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

rtError_t ApiImpl::DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    UNUSED(devId);
    UNUSED(type);
    UNUSED(stmList);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::DeviceGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    UNUSED(devId);
    UNUSED(mdlList);
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

rtError_t ApiImpl::MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    UNUSED(deviceId);
    UNUSED(isHugeOnly);
    UNUSED(freeSize);
    UNUSED(totalSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDeviceInfoByAttrMisc(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    UNUSED(deviceId);
    UNUSED(attr);
    UNUSED(val);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    UNUSED(deviceId);
    UNUSED(attr);
    UNUSED(val);
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
}
}