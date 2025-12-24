/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tracer_schedule.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "tracer_mgr_operate.h"

TraStatus TracerScheduleRegister(Tracer *tracer)
{
    tracer->mgr = (TracerMgr *)AdiagMalloc(sizeof(struct TracerMgr));
    if (tracer->mgr == NULL) {
        return TRACE_FAILURE;
    }

    tracer->mgr->op.tracerInitFunc = TracerScheduleInit;
    tracer->mgr->op.tracerExitFunc = TracerScheduleExit;
    tracer->mgr->op.tracerCreateFunc = TracerScheduleObjCreate;
    tracer->mgr->op.tracerGetFunc = TracerScheduleObjGet;
    tracer->mgr->op.tracerSubmitFunc = TracerScheduleObjSubmit;
    tracer->mgr->op.tracerDestroyFunc = TracerScheduleObjDestroy;
    tracer->mgr->op.tracerSaveFunc = TracerScheduleSave;
    tracer->mgr->op.tracerReportFunc = TracerScheduleReport;
    return TRACE_SUCCESS;
}

TraStatus TracerScheduleUnregister(Tracer *tracer)
{
    if (tracer->mgr == NULL) {
        return TRACE_SUCCESS;
    }
    tracer->mgr->op.tracerInitFunc = NULL;
    tracer->mgr->op.tracerExitFunc = NULL;
    tracer->mgr->op.tracerCreateFunc = NULL;
    tracer->mgr->op.tracerGetFunc = NULL;
    tracer->mgr->op.tracerSubmitFunc = NULL;
    tracer->mgr->op.tracerDestroyFunc = NULL;
    tracer->mgr->op.tracerSaveFunc = NULL;
    tracer->mgr->op.tracerReportFunc = NULL;
    ADIAG_SAFE_FREE(tracer->mgr);
    return TRACE_SUCCESS;
}
