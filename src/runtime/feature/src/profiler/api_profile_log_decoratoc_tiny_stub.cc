/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_profile_log_decorator.hpp"
#include "profiler.hpp"
#include "profile_log_record.hpp"
#include "dev.h"

namespace cce {
namespace runtime {
rtError_t ApiProfileLogDecorator::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                                  const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(retCntNotify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    UNUSED(inCntNotify);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                                  const rtCntNtyRecordInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                           const rtCntNtyWaitInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::GetCntNotifyAddress(CountNotify * const inCntNotify,
                                                      uint64_t * const cntNotifyAddress, rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm,
    rtFusionArgsEx_t *argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiProfileLogDecorator::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
}
}