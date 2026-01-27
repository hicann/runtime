/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
namespace cce {
namespace runtime {
void Context::GetStreamlist(rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    UNUSED(type);
    UNUSED(stmList);
    return;
}

void Context::GetModelList(rtModelList_t *mdlList)
{
    UNUSED(mdlList);
    return;
}

rtError_t Context::TryRecycleCaptureModelResource(const uint32_t allocSqNum, const uint32_t ntfCnt,
    const CaptureModel * const excludeMdl)
{
    UNUSED(allocSqNum);
    UNUSED(ntfCnt);
    UNUSED(excludeMdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

TIMESTAMP_EXTERN(FftsPlusTaskInit);
rtError_t Context::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
                                      const uint32_t flag)
{
    UNUSED(fftsPlusTaskInfo);
    UNUSED(stm);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::RdmaDbSendToDev(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm,
    const uint32_t taskSqe) const
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    UNUSED(taskSqe);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
}
}