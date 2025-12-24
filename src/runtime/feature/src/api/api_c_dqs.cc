/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "runtime_keeper.h"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

static rtError_t DqsTaskLaunch(const rtStream_t stm, const rtDqsTaskCfg_t * const taskCfg)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->LaunchDqsTask(RtPtrToPtr<Stream *>(stm), taskCfg);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsDqsSchedConfig(const rtStream_t stm, rtDqsSchedCfg_t * const config)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_SCHED_CONFIG;
    taskCfg.cfg = config;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsNotifyWait(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_NOTIFY_WAIT;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsDequeue(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_DEQUEUE;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsBatchDequeue(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_BATCH_DEQUEUE;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsZeroCopy(const rtStream_t stm, const rtDqsZeroCopyType copyType, rtZeroCopyCfg_t * const cfg)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(cfg, RT_ERROR_INVALID_VALUE);
    rtDqsTaskCfg_t taskCfg = {};
    rtDqsZeroCopyCfg_t zeroCfg = {};
    zeroCfg.copyType = copyType;
    zeroCfg.cpyAddrOrder = cfg->cpyAddrOrder;
    zeroCfg.queueId = cfg->queueId;
    zeroCfg.count = cfg->count;
    zeroCfg.dest = cfg->dest;
    zeroCfg.offset = cfg->offset;
    taskCfg.type = RT_DQS_TASK_ZERO_COPY;
    taskCfg.cfg = &zeroCfg;

    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsPrepare(const rtStream_t stm, rtDqsPrepareCfg_t * const cfg)
{
    UNUSED(cfg);
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_PREPARE_OUT;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsEnqueue(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_ENQUEUE;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsFree(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_FREE;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsFrameAlign(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_FRAME_ALIGN;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsSchedEnd(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_SCHED_END;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsInterChipInit(const rtStream_t stm)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_INTER_CHIP_INIT;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtsDqsLaunchAdspcTask(const rtStream_t stm, rtDqsAdspcTaskParam_t *const adspcParam)
{
    rtDqsTaskCfg_t taskCfg = {};
    taskCfg.type = RT_DQS_TASK_ADSPC;
    taskCfg.cfg = adspcParam;
    return DqsTaskLaunch(stm, &taskCfg);
}

VISIBILITY_DEFAULT
rtError_t rtLaunchDqsTask(const rtStream_t stm, const rtDqsTaskCfg_t * const taskCfg)
{
    return DqsTaskLaunch(stm, taskCfg);
}

#ifdef __cplusplus
}
#endif // __cplusplus