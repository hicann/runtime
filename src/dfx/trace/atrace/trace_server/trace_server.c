/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_server.h"
#include "trace_server_core.h"

/**
 * @brief       initialize trace server.
 * @param [in]  devId:         device id
 * @return      NA
 */
void TraceServerInit(int32_t devId)
{
    TraceServerSetDevId(devId);
    return;
}

/**
 * @brief       trace server process.
 * @return      TraStatus
 */
TraStatus TraceServerProcess(void)
{
    TraStatus ret = TraceServerMgrProcess();
    if (ret != TRACE_SUCCESS) {
        TraceServerExit();
        return TRACE_FAILURE;
    }
    ret = TraceServerSendProcess();
    if (ret != TRACE_SUCCESS) {
        TraceServerExit();
        return TRACE_FAILURE;
    }
    ret = TraceServerRecvProcess();
    if (ret != TRACE_SUCCESS) {
        TraceServerExit();
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       deinitialize trace server.
 * @return      NA
 */
void TraceServerExit(void)
{
    TraceServerRecvExit();
    TraceServerSendExit();
    TraceServerMgrExit();
}