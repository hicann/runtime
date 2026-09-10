/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "utils.h"
#include "watershed_image_staging.h"

int main()
{
    INFO_LOG("Start to run 0_watershed_image_staging sample.");
    if (RunWatershedImageStaging() != 0) {
        ERROR_LOG("Run the 0_watershed_image_staging sample failed.");
        return -1;
    }
    INFO_LOG("Run the 0_watershed_image_staging sample successfully.");
    return 0;
}
