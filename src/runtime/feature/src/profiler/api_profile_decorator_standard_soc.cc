/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
namespace cce {
namespace runtime {
rtError_t ApiProfileDecorator::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_UB_DB_SEND);
    const rtError_t error = impl_->UbDbSend(dbInfo, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_UB_DIRECT_SEND);
    const rtError_t error = impl_->UbDirectSend(wqeInfo, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                               const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_COUNT_NOTIFY_CREATE);
    const rtError_t error = impl_->CntNotifyCreate(deviceId, retCntNotify, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    CallApiBegin(RT_PROF_API_COUNT_NOTIFY_DESTROY);
    const rtError_t error = impl_->CntNotifyDestroy(inCntNotify);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                               const rtCntNtyRecordInfo_t * const info)
{
    CallApiBegin(RT_PROF_API_COUNT_NOTIFY_RECORD);
    const rtError_t error = impl_->CntNotifyRecord(inCntNotify, stm, info);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                        const rtCntNtyWaitInfo_t * const info)
{
    CallApiBegin(RT_PROF_API_COUNT_NOTIFY_WAIT);
    const rtError_t error = impl_->CntNotifyWaitWithTimeout(inCntNotify, stm, info);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_GET_COUNT_NOTIFY_RESET);
    const rtError_t error = impl_->CntNotifyReset(inCntNotify, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetCntNotifyAddress(CountNotify * const inCntNotify, uint64_t * const cntNotifyAddress,
                                                   rtNotifyType_t const regType)
{
    CallApiBegin(RT_PROF_API_GET_COUNT_NOTIFY_ADDR);
    const rtError_t error = impl_->GetCntNotifyAddress(inCntNotify, cntNotifyAddress, regType);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_WRITE_VALUE);
    const rtError_t error = impl_->WriteValue(info, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    CallApiBegin(RT_PROF_API_CCU_LAUNCH);
    const rtError_t error = impl_->CCULaunch(taskInfo, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm,
    rtFusionArgsEx_t *argsInfo)
{
    CallApiBegin(RT_PROF_API_FUSION_KERNEL_LAUNCH);
    const rtError_t error = impl_->FusionLaunch(fusionInfo, stm, argsInfo);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    Stream * const stm, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_FFTS_PLUS_TASK_LAUNCH);
    const rtError_t error = impl_->FftsPlusTaskLaunch(fftsPlusTaskInfo, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_RDMASend);
    const rtError_t error = impl_->RDMASend(sqIndex, wqeIndex, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_RdmaDbSend);
    const rtError_t error = impl_->RdmaDbSend(dbIndex, dbInfo, stm);
    CallApiEnd(error);
    return error;
}

}
}