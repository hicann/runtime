/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef EXCEPTION_INFO_COMMON_H
#define EXCEPTION_INFO_COMMON_H

#include "runtime/rt.h"

namespace Adx {
class ExceptionInfoCommon {
public:
    static int32_t GetExceptionInfo(const rtExceptionInfo &exception, rtExceptionExpandType_t exceptionTaskType,
        rtExceptionArgsInfo_t &exceptionArgsInfo);
};
}  // namespace Adx
#endif
