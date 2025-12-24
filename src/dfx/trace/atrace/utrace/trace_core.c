/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adiag_print.h"
#include "trace_attr.h"
#include "trace_driver_api.h"
#include "tracer_core.h"
#include "trace_event.h"
#include "stacktrace_dumper.h"
#include "stacktrace_signal.h"
#include "trace_recorder.h"

#ifdef ATRACE_API
#include "atrace_client_core.h"
/**
 * @brief       : initialize dynamic library
 * @return      : NA
 */
STATIC CONSTRUCTOR void TraceInit(void)
{
    TraStatus ret = TraceAttrInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init attr failed, ret=%d.", ret);
    if (!AtraceCheckSupported()) {
        ADIAG_INF("atrace is not supported, init nothing.");
        return;
    }
    ret = TraceRecorderInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init recorder failed, ret=%d.", ret);

    ret = TraceEventInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init event failed, ret=%d.", ret);

    ret = TracerInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init tracer failed, ret=%d.", ret);

    ret = AtraceClientInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init trace client failed, ret=%d.", ret);

    ret = TraceDumperInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init stacktrace dumper failed, ret=%d.", ret);

    ret = TraceSignalInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init signal failed, ret=%d.", ret);
    ADIAG_INF("init trace successfully.");
}

/**
 * @brief       : finalize dynamic library
 * @return      : NA
 */
STATIC DESTRUCTOR void TraceExit(void)
{
    if (AtraceCheckSupported()) {
        TraceSignalExit();
        TraceDumperExit();
        AtraceClientExit();
        TracerExit();
        TraceEventExit();
        TraceRecorderExit();
    }
    TraceAttrExit();
}

#else
#include "utrace_socket.h"
/**
 * @brief       : initialize dynamic library
 * @return      : NA
 */
STATIC CONSTRUCTOR void TraceInit(void)
{
    TraStatus ret = TraceAttrInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init attr failed, ret=%d.", ret);
    if (!AtraceCheckSupported()) {
        ADIAG_INF("atrace is not supported, init nothing.");
        return;
    }
    ret = TraceRecorderInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init recorder failed, ret=%d.", ret);

    ret = TraceEventInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init event failed, ret=%d.", ret);

    ret = TraceSignalInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init signal failed, ret=%d.", ret);

    ret = TracerInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return, "init tracer failed, ret=%d.", ret);

    ADIAG_INF("init trace successfully.");
}

/**
 * @brief       : finalize dynamic library
 * @return      : NA
 */
STATIC DESTRUCTOR void TraceExit(void)
{
    if (AtraceCheckSupported()) {
        TracerExit();
        TraceSignalExit();
        TraceEventExit();
        TraceRecorderExit();
        UtraceCloseSocket();
    }
    TraceAttrExit();
}
#endif