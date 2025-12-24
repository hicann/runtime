/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CALL_BACK_SAMPLE_H_
#define CALL_BACK_SAMPLE_H_

#include "utils.h"
#include "acl/acl.h"
namespace ExceptionCallBackSpace {
    class ExceptionCallBackSample {
        public:
            ExceptionCallBackSample();
            virtual ~ExceptionCallBackSample();
            int Init();
            int Callback();
            int Destroy();
            static void ThreadFunc(void *arg);
            static void CallBackFunc(void *arg);
            static void ExceptionCallBackFunc(aclrtExceptionInfo *exceptionInfo);

        public:
            static int32_t deviceId_;
            static aclrtContext context_;
            static aclrtStream stream_;
    };
}


#endif