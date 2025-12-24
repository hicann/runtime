/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __SOC_SPEC_H__
#define __SOC_SPEC_H__

#include <cstdint>
#include <string>


enum class NpuArch : uint32_t {
    DAV_1001 = 1001,
    DAV_1002 = 1002,
    DAV_1003 = 1003,
    DAV_1004 = 1004,
    DAV_1999 = 1999,
    DAV_2002 = 2002,
    DAV_2003 = 2003,
    DAV_2004 = 2004,
    DAV_2006 = 2006,
    DAV_2102 = 2102,
    DAV_2103 = 2103,
    DAV_2104 = 2104,
    DAV_2201 = 2201,
    DAV_3002 = 3002,
    DAV_3003 = 3003,
    DAV_3004 = 3004,
    DAV_3102 = 3102,
    DAV_3103 = 3103,
    DAV_3113 = 3113,
    DAV_3502 = 3502,
    DAV_3505 = 3505,
    DAV_3510 = 3510,
    DAV_3801 = 3801,
    DAV_5101 = 5101,
    DAV_5102 = 5102,
    DAV_5161 = 5161,
    DAV_9201 = 9201,
    DAV_9202 = 9202,
    DAV_9301 = 9301,
    DAV_RESV = 0xFFFF
};

#endif
