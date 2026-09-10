/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "reusable_buffer_reset.h"
#include "utils.h"

int main()
{
    INFO_LOG("Start to run 5_reusable_buffer_reset sample.");
    if (RunReusableBufferReset() != 0) {
        ERROR_LOG("Run the 5_reusable_buffer_reset sample failed.");
        return -1;
    }
    INFO_LOG("Run the 5_reusable_buffer_reset sample successfully.");
    return 0;
}
