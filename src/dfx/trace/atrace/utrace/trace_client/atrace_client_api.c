/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "atrace_api.h"
#include "trace_attr.h"
#include "atrace_client_core.h"
#include "adiag_print.h"

/**
 * @brief       create thread to receive trace of device
 * @param [in]  devId:      device id
 * @return      TraStatus
 */
TraStatus AtraceReportStart(int32_t devId)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceReportStart is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    return AtraceClientStart(devId);
}

/**
 * @brief       stop thread to receive trace of device
 * @param [in]  devId:      device id
 */
void AtraceReportStop(int32_t devId)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceReportStop is not supported on device side");
        return;
    }
    AtraceClientStop(devId);
}
