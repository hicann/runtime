/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "exception_info_common.h"
#include "adump_pub.h"
#include "log/hdc_log.h"

namespace Adx {
int32_t ExceptionInfoCommon::GetExceptionInfo(const rtExceptionInfo &exception,
                                              rtExceptionExpandType_t exceptionTaskType,
                                              rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    if (exceptionTaskType == RT_EXCEPTION_AICORE) {
        exceptionArgsInfo = exception.expandInfo.u.aicoreInfo.exceptionArgs;
    } else if (exceptionTaskType == RT_EXCEPTION_FFTS_PLUS) {
        exceptionArgsInfo = exception.expandInfo.u.fftsPlusInfo.exceptionArgs;
    } else if (exceptionTaskType == RT_EXCEPTION_FUSION) {
        exceptionArgsInfo = exception.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs;
    } else {
        IDE_LOGW("Exception type[%d] is not supported.", static_cast<int32_t>(exceptionTaskType));
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}
}  // namespace Adx