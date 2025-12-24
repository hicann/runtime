/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_exception_callback.h"
#include "dump_tensor_plugin.h"
#include "log/adx_log.h"

namespace Adx {
int32_t AdumpRegHeadProcess(DfxTensorType tensorType, HeadProcess headProcess)
{
    IDE_CTRL_VALUE_FAILED(headProcess != nullptr, return -1, "HeadProcess is nullptr");
    DumpTensorPlugin::Instance().HeadCallbackRegister(tensorType, headProcess);
    IDE_LOGI("Received new head process registry for tensorType:%hu", tensorType);
    return 0;
}

int32_t AdumpRegTensorProcess(DfxTensorType tensorType, TensorProcess tensorProcess)
{
    IDE_CTRL_VALUE_FAILED(tensorProcess != nullptr, return -1, "TensorProcess is nullptr");
    DumpTensorPlugin::Instance().TensorCallbackRegister(tensorType, tensorProcess);
    IDE_LOGI("Received new tensor process registry for tensorType:%hu", tensorType);
    return 0;
}
}
