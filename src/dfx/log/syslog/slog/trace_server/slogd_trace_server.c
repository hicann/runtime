/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_trace_server.h"

#ifdef EP_MODE

#include "trace_server.h"

void LogTraceServiceInit(int32_t devId)
{
    TraceServerInit(devId);
}

LogStatus LogTraceServiceProcess(void)
{
    return TraceServerProcess();
}

void LogTraceServiceExit(void)
{
    TraceServerExit();
}

#else

void LogTraceServiceInit(int32_t devId)
{
    (void)devId;
}

LogStatus LogTraceServiceProcess(void)
{
    return LOG_SUCCESS;
}

void LogTraceServiceExit(void)
{
}

#endif