/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common.h"
#include "hal_ts.h"
#include "runtime/rt_model.h"
#include "error_manage.h"

#if defined(__cplusplus)
extern "C" {
#endif

static void CreateTsMdlDesc(rtMdlLoad_t *modelLoad, tsMdlDescInfo_t *tsModelDesc)
{
    tsModelDesc->taskdesc_base_addr = (uintptr_t)modelLoad->taskDescBaseAddr;
    tsModelDesc->pc_base_addr = (uintptr_t)modelLoad->pcBaseAddr;
    tsModelDesc->param_base_addr = (uintptr_t)modelLoad->paramBaseAddr;
    tsModelDesc->weight_base_addr = (uintptr_t)modelLoad->weightBaseAddr;
    tsModelDesc->total_task_num = modelLoad->totalTaskNum;
    tsModelDesc->sid = 0;
    tsModelDesc->om_flag = modelLoad->overflow_en;
    tsModelDesc->weight_prefetch_flag = modelLoad->weightPrefetch;
}

rtError_t rtNanoModelLoad(rtMdlLoad_t *modelLoad, uint32_t *phyModelId)
{
    if (modelLoad == NULL) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    uint8_t mdlID = 0;
    tsMdlDescInfo_t tsModelDesc;
    CreateTsMdlDesc(modelLoad, &tsModelDesc);
    drvError_t drvRet = halModelLoad(&tsModelDesc, &mdlID);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halModelLoad failed ret[%d].", drvRet);
        return ErrorConvert(drvRet);
    }
    *phyModelId = (uint32_t)mdlID;
    return ACL_RT_SUCCESS;
}

rtError_t rtNanoModelExecute(rtMdlExecute_t *modelExec)
{
    if (modelExec == NULL) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    struct halMdlExecInput input;
    struct halMdlExecOutput output;
    uint32_t tid = (uint32_t)mmGetTaskId();
    input.execInfo.desc_info.vld = modelExec->vld;
    input.execInfo.desc_info.cache_inv = 1; // always update cache
    input.execInfo.desc_info.sv = 0;
    input.execInfo.desc_info.task_prof = modelExec->taskProf;
    input.execInfo.desc_info.blk_prof = 0;
    input.execInfo.desc_info.mid = modelExec->mid;
    input.execInfo.desc_info.mec_soft = 0;
    input.execInfo.desc_info.qos_credit = 0;
    input.execInfo.desc_info.ioa_base_addr = (uint64_t)((uintptr_t)modelExec->ioaSrcAddr);
    input.execInfo.desc_info.dynamic_task_baseaddr = (uint64_t)((uintptr_t)modelExec->dynamicTaskPtr);
    input.execInfo.desc_info.mpamid = (uint16_t)modelExec->mpamId;
    input.execInfo.desc_info.mec_credit = 0;
    input.execInfo.desc_info.workspace_baseaddr = (uint64_t)((uintptr_t)modelExec->workPtr);
    input.execInfo.tid = tid;
    input.execInfo.ioa_size = modelExec->ioaSize;
    input.execInfo.sqid = (uint8_t)modelExec->sqid;
    input.execInfo.me_type = modelExec->meType;
    input.execInfo.cb_fn = modelExec->cbFn;
    input.execInfo.cb_data = modelExec->cbData;

    input.waitPara.tid = tid;
    input.waitPara.rpt = 0;
    input.waitPara.rpt_num = 0;
    input.waitPara.timeout = (uint32_t)modelExec->mecTimeThreshHold;
    if (modelExec->sync) {
        input.execInfo.desc_info.cqe = 1;
        input.ec_type = DESC_FILL_EXEC_SYNC;
    } else {
        input.execInfo.desc_info.cqe = 0;  // drv can not received hwts interrupts
        input.ec_type = DESC_FILL_EXEC;
    }
    drvError_t drvRet = halModelExec(0, &input, &output);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halModelExec failed ret[%d].", drvRet);
        return ErrorConvert(drvRet);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtNanoModelDestroy(uint32_t phyMdlId)
{
    drvError_t drvRet = halModelDestroy(phyMdlId);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halModelDestroy failed ret[%d].", drvRet);
        return ErrorConvert(drvRet);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtDumpInit()
{
    drvError_t drvRet = halDumpInit();
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halDumpInit failed ret[%d].", drvRet);
        return drvRet;
    }
    return RT_ERROR_NONE;
}

rtError_t rtDumpDeInit(void)
{
    drvError_t drvRet = halDumpDeinit();
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halDumpDeinit failed ret[%d].", drvRet);
        return drvRet;
    }
    return RT_ERROR_NONE;
}

rtError_t rtMsgSend(uint32_t tId, uint32_t sendTid, int32_t timeout, void *sendInfo, uint32_t size)
{
    drvError_t drvRet = halMsgSend(tId, sendTid, timeout, sendInfo, size);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halMsgSend failed ret[%d].", drvRet);
        return drvRet;
    }
    return RT_ERROR_NONE;
}

rtError_t rtSetTaskDescDumpFlag(void *taskDescBaseAddr, size_t taskDescSize, uint32_t taskId)
{
    if (taskDescBaseAddr == NULL) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    if (taskId * sizeof(HwtsTaskDesc) >= taskDescSize) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    ((HwtsTaskDesc *)((uint8_t *)taskDescBaseAddr + taskId * sizeof(HwtsTaskDesc)))->dump = 1;
    return RT_ERROR_NONE;
}

#if defined(__cplusplus)
}
#endif
