/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
namespace cce {
namespace runtime {
rtError_t ApiProfileDecorator::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                               const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(retCntNotify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    UNUSED(inCntNotify);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                               const rtCntNtyRecordInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                        const rtCntNtyWaitInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::GetCntNotifyAddress(CountNotify * const inCntNotify, uint64_t * const cntNotifyAddress,
                                                   rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm,
    rtFusionArgsEx_t *argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    Stream * const stm, const uint32_t flag)
{
    UNUSED(fftsPlusTaskInfo);
    UNUSED(stm);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileDecorator::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiDecorator::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiDecorator::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiDecorator::GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    UNUSED(devType);
    UNUSED(devCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

}
}