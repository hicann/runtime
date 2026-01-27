/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_ctrl_model.h"
#include "runtime/rt_model.h"
#include "error_codes/rt_error_codes.h"
#include "error_manage.h"
#include "log_inner.h"
#include "subscribe_manager.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef struct RtCtrlMdlInfo {
    void* taskDesc; // static_task_desc and dynamic_task_desc
    uint32_t phyMdlId;
} RtCtrlMdlInfo;

typedef struct MdlExecParam {
    CTRL_MODEL_TYPE type;
    uint32_t sqid;
    uint8_t meType;
    void* cbFn;
    void *cbData;
    bool sync;
} MdlExecParam;

static RtCtrlMdlInfo g_rtCtrlMdlInfo[MODEL_TYPE_MAX] = {
    {NULL, UINT32_MAX},
    {NULL, UINT32_MAX}
};

static void GetMdlExecuteInfo(MdlExecParam *param, rtMdlExecute_t* modelExec)
{
    modelExec->ioaSrcAddr = NULL;
    modelExec->dynamicTaskPtr = (void*)((char*)g_rtCtrlMdlInfo[param->type].taskDesc + MODEL_TASK_DESC_SIZE);
    modelExec->workPtr = NULL;
    modelExec->sync = param->sync;
    modelExec->vld = 1;
    modelExec->taskProf = 0;
    modelExec->mid = (uint8_t)g_rtCtrlMdlInfo[param->type].phyMdlId;
    modelExec->ioaSize = 0;
    modelExec->sqid = param->sqid;
    modelExec->meType = param->meType;
    modelExec->cbFn = (uintptr_t)param->cbFn;
    modelExec->cbData = param->cbData;
    modelExec->mpamId = 0UL;
    modelExec->aicQos = 0UL;
    modelExec->aicOst = 0UL;
    modelExec->mecTimeThreshHold = 0UL;
    return;
}

static rtError_t CreateTaskDescInfo(struct halGetTaskDescInput* input, struct halGetTaskDescOutput* out)
{
    drvError_t drvRet = halMemAlloc(&(input->mdl_ctrl_info.static_task_desc),
        MODEL_TASK_DESC_SIZE + MODEL_TASK_DESC_SIZE, RT_MEMORY_DEFAULT);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halMemAlloc failed, ret=%d.", drvRet);
        return ErrorConvert(drvRet);
    }

    input->mdl_ctrl_info.dynamic_task_desc = (void*)(
        (char*)input->mdl_ctrl_info.static_task_desc + MODEL_TASK_DESC_SIZE);
    input->mdl_ctrl_info.static_task_desc_size = MODEL_TASK_DESC_SIZE;
    input->mdl_ctrl_info.dynamic_task_desc_size = MODEL_TASK_DESC_SIZE;

    drvRet = halGetTaskDesc(input, out);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halGetTaskDesc failed, ret=%d.", drvRet);
        (void)halMemFree(input->mdl_ctrl_info.static_task_desc);
        return ErrorConvert(drvRet);
    }

    return ACL_RT_SUCCESS;
}

rtError_t InitCtrlMdl(CTRL_MODEL_TYPE type)
{
    struct halGetTaskDescInput input = {{type, NULL, 0UL, NULL, 0UL}};
    struct halGetTaskDescOutput out = {0};
    rtError_t rtRet = CreateTaskDescInfo(&input, &out);
    if (rtRet != ACL_RT_SUCCESS) {
        return rtRet;
    }

    rtMdlLoad_t modelLoad = {0};
    modelLoad.totalTaskNum = out.task_num;
    modelLoad.taskDescBaseAddr = input.mdl_ctrl_info.static_task_desc;

    uint32_t phyModelId = 0U;
    rtRet = rtNanoModelLoad(&modelLoad, &phyModelId);
    if (rtRet != ACL_RT_SUCCESS) {
        (void)halMemFree(input.mdl_ctrl_info.static_task_desc);
        return rtRet;
    }

    g_rtCtrlMdlInfo[type].taskDesc = input.mdl_ctrl_info.static_task_desc;
    g_rtCtrlMdlInfo[type].phyMdlId = phyModelId;
    RT_LOG_INFO("type[%d], phyMid[%u]", type, phyModelId);

    return ACL_RT_SUCCESS;
}

void DeInitCtrlMdl(void)
{
    for (uint8_t i = 0; i < MODEL_TYPE_MAX; i++) {
        if (g_rtCtrlMdlInfo[i].taskDesc != NULL) {
            (void)halMemFree(g_rtCtrlMdlInfo[i].taskDesc);
            g_rtCtrlMdlInfo[i].taskDesc = NULL;
        }

        if (g_rtCtrlMdlInfo[i].phyMdlId != UINT32_MAX) {
            rtError_t rtRet = rtNanoModelDestroy(g_rtCtrlMdlInfo[i].phyMdlId);
            if (rtRet != ACL_RT_SUCCESS) {
                RT_LOG_ERROR("destroy modelID[%d] failed, ret=%d.", g_rtCtrlMdlInfo[i].phyMdlId, rtRet);
            }
            g_rtCtrlMdlInfo[i].phyMdlId = UINT32_MAX;
        }
    }

    return;
}

static inline rtError_t CtrlMdlExec(MdlExecParam* param)
{
    rtMdlExecute_t modelExec;
    GetMdlExecuteInfo(param, &modelExec);
    return rtNanoModelExecute(&modelExec);
}

rtError_t SendNullMdl(uint32_t sqId)
{
    MdlExecParam param = {NULLMODEL, sqId, MDL_NORMAL, NULL, NULL, true};
    return CtrlMdlExec(&param);
}

static rtError_t SendCallBackMdl(rtCallback_t callBackFunc, void *fnData, uint32_t sqId, bool isBlock)
{
    uint8_t meType = (isBlock) ? MDL_BLOCK_CALLBACK : MDL_NON_BLOCK_CALLBACK;
    MdlExecParam param = {CALLBACK, sqId, meType, callBackFunc, fnData, false};
    return CtrlMdlExec(&param);
}

rtError_t rtProcessReport(int32_t timeout)
{
    if ((timeout < -1) || (timeout == 0)) {
        RT_LOG_ERROR("invalid timeout[%d].", timeout);
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    uint64_t subscribeUUID = GetCurSubscribeId();
    if (subscribeUUID == UINT64_MAX) {
        RT_LOG_ERROR("no subscribeInfo of current thread.");
        return ACL_ERROR_RT_THREAD_SUBSCRIBE;
    }

    tsCbReport_t rpt[RPT_MAX_NUM] = {0};
    struct halCbIrqInput input = {(int64_t)subscribeUUID, (timeout == -1) ? 0 : timeout, rpt, RPT_MAX_NUM};
    struct halCbIrqOutput output = {0};
    drvError_t drvRet = halCbIrqWait(&input, &output);
    if (drvRet != DRV_ERROR_NONE) {
        if (drvRet == DRV_ERROR_WAIT_TIMEOUT) {
            RT_LOG_WARNING("wait timeout, ret=%d.", drvRet);
        } else {
            RT_LOG_ERROR("wait failed, ret=%d.", drvRet);
        }
        return ErrorConvert(drvRet);
    }

    RT_LOG_INFO("rptNum=%d.", output.rpt_num);
    for (uint8_t i = 0; i < output.rpt_num; i++) {
        void (*callbackFunc)(void *userData) = (void *)input.rpt[i].fn;
        if (callbackFunc == NULL) {
            continue;
        }
        (void)callbackFunc(input.rpt[i].cb_data);
        RT_LOG_INFO("rptNum[%d], callback func exec success.", i);
        if (input.rpt[i].me_type == MDL_BLOCK_CALLBACK) {
            drvRet = halSqResume(input.rpt[i].devid, input.rpt[i].sqid);
            if (drvRet != DRV_ERROR_NONE) {
                RT_LOG_ERROR("resume failed, ret=%d.", drvRet);
                return ErrorConvert(drvRet);
            }
        }
    }

    return ACL_RT_SUCCESS;
}

rtError_t rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stm, bool isBlock)
{
    rtStream_t stream = stm;
    if (stream == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    if (GetStreamThreadID(stream, SUBSCRIBE_CALLBACK) == UINT64_MAX) {
        RT_LOG_ERROR("stream is not registered.");
        return ACL_ERROR_RT_STREAM_NO_CB_REG;
    }

    return SendCallBackMdl(callBackFunc, fnData, GetStreamSqID(stream), isBlock);
}

rtError_t rtSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    return SubscribeReport(threadId, stm, SUBSCRIBE_CALLBACK);
}

rtError_t rtUnSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    return UnSubscribeReport(threadId, stm, SUBSCRIBE_CALLBACK);
}

#if defined(__cplusplus)
}
#endif
