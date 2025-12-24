/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_server_core.h"
#include "ascend_hal.h"
#include "adiag_print.h"
#include "trace_session_mgr.h"
#include "ktrace_ts.h"
#include "trace_send_mgr.h"
#include "trace_server_socket.h"

STATIC int32_t g_devId = -1;

void TraceServerSetDevId(int32_t devId)
{
    g_devId = devId;
}

STATIC INLINE int32_t TraceServerGetDevId(void)
{
    return g_devId;
}

TraStatus TraceServerMgrProcess(void)
{
    TraStatus ret = TraceServerSessionInit();
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("trace server session init failed.");
        return TRACE_FAILURE;
    }

    ret = TraceServiceInit(g_devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("trace server init failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void TraceServerMgrExit(void)
{
    TraceServerSessionExit();
}

STATIC TraStatus GetDevNumIDs(uint32_t *deviceNum, uint32_t *deviceIdArray)
{
    int32_t devNum = 0;
    int32_t devId[MAX_DEV_NUM] = { 0 };
    int32_t ret = log_get_device_id(devId, &devNum, MAX_DEV_NUM);
    if ((ret != 0) || (devNum > MAX_DEV_NUM) || (devNum < 0)) {
        ADIAG_ERR("get device id failed, result=%d, device_number=%d.", ret, devNum);
        return TRACE_FAILURE;
    }
    *deviceNum = (uint32_t)devNum;
    int32_t idx = 0;
    for (; idx < devNum; idx++) {
        if ((devId[idx] >= 0) && (devId[idx] < MAX_DEV_NUM)) {
            deviceIdArray[idx] = (uint32_t)devId[idx];
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceServerPfProcess(void)
{
    uint32_t deviceIdArray[MAX_DEV_NUM] = { 0U };    // device-side device id array
    uint32_t devNum = 0;
    TraStatus ret = GetDevNumIDs(&devNum, deviceIdArray);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    ret = KtraceTsCreateThread(devNum, deviceIdArray);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create trace ts thread failed.");
        return TRACE_FAILURE;
    }
    ret = TraceServerCreateSocketRecv(-1);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create socket receive failed.");
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

STATIC TraStatus TraceServerVfProcess(uint32_t devId)
{
    uint32_t deviceIdArray[1] = { devId };
    TraStatus ret = KtraceTsCreateThread(1U, deviceIdArray);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create trace ts thread failed.");
        return TRACE_FAILURE;
    }
    ret = TraceServerCreateSocketRecv((int32_t)devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create socket receive failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraStatus TraceServerRecvProcess(void)
{
    int32_t devId = TraceServerGetDevId();
    if (devId == -1) {
        return TraceServerPfProcess();
    } else if ((devId >= MIN_VFID_NUM) && (devId <= MAX_VFID_NUM)) {
        return TraceServerVfProcess((uint32_t)devId);
    } else {
        ADIAG_ERR("invalid device id(%d).", devId);
        return TRACE_FAILURE;
    }
}

void TraceServerRecvExit(void)
{
    TraceServerDestroySocketRecv();
    KtraceTsDestroyThread();
}

TraStatus TraceServerSendProcess(void)
{
    return TraceServerCreateSendThread();
}

void TraceServerSendExit(void)
{
    TraceServerDestroySendThread();
}