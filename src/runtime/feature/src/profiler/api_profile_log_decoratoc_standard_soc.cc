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

namespace cce {
namespace runtime {
rtError_t ApiProfileLogDecorator::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_UB_DB_SEND, profiler_);
    const rtError_t error = impl_->UbDbSend(dbInfo, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_UB_DIRECT_SEND, profiler_);
    const rtError_t error = impl_->UbDirectSend(wqeInfo, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                                  const uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_COUNT_NOTIFY_CREATE, profiler_);
    const rtError_t error = impl_->CntNotifyCreate(deviceId, retCntNotify, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_COUNT_NOTIFY_DESTROY, profiler_);
    const rtError_t error = impl_->CntNotifyDestroy(inCntNotify);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                                  const rtCntNtyRecordInfo_t * const info)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_COUNT_NOTIFY_RECORD, profiler_);
    const rtError_t error = impl_->CntNotifyRecord(inCntNotify, stm, info);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                           const rtCntNtyWaitInfo_t * const info)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_COUNT_NOTIFY_WAIT, profiler_);
    const rtError_t error = impl_->CntNotifyWaitWithTimeout(inCntNotify, stm, info);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GET_COUNT_NOTIFY_RESET, profiler_);
    const rtError_t error = impl_->CntNotifyReset(inCntNotify, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetCntNotifyAddress(CountNotify * const inCntNotify,
                                                      uint64_t * const cntNotifyAddress, rtNotifyType_t const regType)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GET_COUNT_NOTIFY_ADDR, profiler_);
    const rtError_t error = impl_->GetCntNotifyAddress(inCntNotify, cntNotifyAddress, regType);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_WRITE_VALUE, profiler_);
    const rtError_t error = impl_->WriteValue(info, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CCU_LAUNCH, profiler_);
    const rtError_t error = impl_->CCULaunch(taskInfo, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm,
    rtFusionArgsEx_t *argsInfo)
{
    if (profiler_->GetProfLogEnable()) {
        ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_FUSION_KERNEL_LAUNCH, profiler_);
        const rtError_t error = impl_->FusionLaunch(fusionInfo, stm, argsInfo);
        record.SaveRecord();
        return error;
    } else {
        return impl_->FusionLaunch(fusionInfo, stm, argsInfo);
    }
}

rtError_t ApiProfileLogDecorator::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_RDMASend, profiler_);
    const rtError_t error = impl_->RDMASend(sqIndex, wqeIndex, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_RdmaDbSend, profiler_);
    const rtError_t error = impl_->RdmaDbSend(dbIndex, dbInfo, stm);
    record.SaveRecord();
    return error;
}
}
}