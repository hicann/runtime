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

void TraceServerSetDevId(int32_t devId) { g_devId = devId; }

STATIC INLINE int32_t TraceServerGetDevId(void) { return g_devId; }

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

void TraceServerMgrExit(void) { TraceServerSessionExit(); }

STATIC TraStatus GetDevNumIDs(uint32_t* deviceNum, uint32_t* deviceIdArray, uint32_t idArraySize)
{
    ADIAG_CHK_EXPR_ACTION(deviceNum == NULL, return TRACE_FAILURE, "input device number pointer is null.");
    ADIAG_CHK_EXPR_ACTION(deviceIdArray == NULL, return TRACE_FAILURE, "input device id array pointer is null.");

    drvError_t drvErr = halGetDevNumEx(0, deviceNum);
    if ((drvErr != 0) || (*deviceNum > idArraySize)) {
        ADIAG_ERR(
            "get device num failed, result=%d, device_number=%u, device id array size=%u.", (int32_t)drvErr, *deviceNum,
            idArraySize);
        return TRACE_FAILURE;
    }
    drvErr = halGetDevIDsEx(0, deviceIdArray, idArraySize);
    if (drvErr != 0) {
        ADIAG_ERR("get device id array failed, result=%d.", (int32_t)drvErr);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceServerPfProcess(void)
{
    uint32_t deviceIdArray[MAX_DEV_NUM] = {0U}; // device-side device id array
    uint32_t devNum = 0;
    TraStatus ret = GetDevNumIDs(&devNum, deviceIdArray, MAX_DEV_NUM);
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
    uint32_t deviceIdArray[1] = {devId};
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

TraStatus TraceServerSendProcess(void) { return TraceServerCreateSendThread(); }

void TraceServerSendExit(void) { TraceServerDestroySendThread(); }