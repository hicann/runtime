/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_TDT_STATUS_H
#define INC_TDT_STATUS_H
#include "common/type_def.h"
namespace tsd {
#ifdef __cplusplus
    using TSD_StatusT = uint32_t;
#else
    typedef uint32_t TSD_StatusT;
#endif
    // success code
    constexpr TSD_StatusT TSD_OK = 0U;
    // 区分TSD不对外的枚举，对外枚举ID从100开始
    enum ErroCodeExt : TSD_StatusT {
        TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT = 100U,
        TSD_SUBPROCESS_BINARY_FILE_DAMAGED = 101U,
        TSD_DEVICE_DISCONNECTED = 102U,
        TSD_VERIFY_OPP_FAIL = 103U,
        TSD_ADD_AICPUSD_TO_CGROUP_FAILED = 104U,
        TSD_HDC_CLIENT_CLOSED_EXTERNAL = 105U,
        TSD_OPEN_NOT_SUPPORT_FOR_ADC = 200U,
        TSD_OPEN_DEFAULT_NET_SERVICE_FAILED = 201U,
        TSD_OPEN_NOT_SUPPORT_NET_SERVICE = 202U,
        TSD_CLOSE_NOT_SUPPORT_NET_SERVICE = 203U,
    };
}
#endif  // INC_TDT_STATUS_H
