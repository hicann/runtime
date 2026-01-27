/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CORE_AICPUSD_MEMINFO_PROCESS_H
#define CORE_AICPUSD_MEMINFO_PROCESS_H

#include "aicpusd_status.h"
#include "ascend_hal_define.h"

namespace AicpuSchedule {
    class AicpuMemInfoProcess {
    public:
        static int32_t GetMemZoneInfo(BuffCfg &buffCfg);
    };
}
#endif // CORE_AICPUSD_JSON_READ_H
