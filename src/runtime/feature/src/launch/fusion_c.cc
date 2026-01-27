/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "fusion_c.hpp"
#include "stream_c.hpp"
#include "context.hpp"
#include "stars_david.hpp"
#include "error_message_manage.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stream.hpp"
#include "task_submit.hpp"
#include "profiler_c.hpp"
#include "aix_c.hpp"
namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtFusionLaunch_ArgLoadAll);
TIMESTAMP_EXTERN(rtLaunchKernel_SubMit);

constexpr uint8_t RT_FUSION_CCU_DIE0_BIT_MOVE = 3U;
constexpr uint8_t RT_FUSION_CCU_DIE1_BIT_MOVE = 4U;
constexpr uint8_t RT_MISSION_INDEX_ONE = 1U;
constexpr uint8_t RT_MISSION_INDEX_TWO = 2U;
constexpr uint8_t RT_MISSION_INDEX_THREE = 3U;
constexpr uint8_t RT_MISSION_INDEX_FOUR = 4U;

static rtError_t PreProcAicAivTaskForFusion(rtFusionSubTaskInfo_t *const fusionTask, const Stream * const stm,
    Program *&prog, rtAicAivFusionInfo_t *aicAivInfo, LaunchTaskCfgInfo_t *launchTaskCfg)
{
    rtError_t error = RT_ERROR_NONE;
    rtAicoreFusionInfo_t * const aicInfo = &(fusionTask->task.aicoreInfo);
    void * const stubFunc = aicInfo->stubFunc;
    void * const progHandle = aicInfo->hdl;
    if ((stubFunc == nullptr && progHandle == nullptr) || (stubFunc != nullptr && progHandle != nullptr)) {
        RT_LOG(RT_LOG_ERROR, "invalid input, stubFunc=%p, progHandle=%p, stream_id=%d.",
            stubFunc, progHandle, stm->Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    rtLaunchConfig_t *cfgInfo = aicInfo->config;
    NULL_PTR_RETURN_MSG_OUTER(cfgInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfgInfo->attrs, RT_ERROR_INVALID_VALUE);
    error = GetLaunchConfigInfo(cfgInfo, launchTaskCfg);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Kernel launch GetLaunchConfigInfo failed, stream_id=%d.", stm->Id_());

    uint64_t tilingKey = 0ULL;
    if (progHandle != nullptr)  {
        tilingKey = aicInfo->tilingKey;
    }

    const uint32_t coreDim = launchTaskCfg->blockDim;
    uint32_t kernelType = 0U;
    uint8_t mixType = NO_MIX;
    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    Module *launchMdl = nullptr;
    Kernel *registeredKernel = nullptr;

    error = StreamLaunchKernelPrepare(stm, registeredKernel, prog, kernelType, launchMdl, stubFunc,
                                addr1, addr2, progHandle, tilingKey);
    COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, error, "kernel launch prepare failed,"
        "stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    mixType = registeredKernel->GetMixType();
    aicAivInfo->mach = kernelType;
    aicAivInfo->dimNum = coreDim;
    aicAivInfo->mixType = mixType;
    aicAivInfo->funcAddr = addr1;
    aicAivInfo->funcAddr1 = addr2;
    aicAivInfo->kernel = registeredKernel;
    aicAivInfo->program = (prog != nullptr) ? prog : RtPtrToPtr<Program *>(progHandle);
    RT_LOG(RT_LOG_INFO, "kernel info: stream_id=%d, kernelType=%u, kernel_name=%s,"
        "mixType=%u, taskRation=%u, tilingKey=%llu.", stm->Id_(), kernelType,
        registeredKernel->Name_().c_str(), mixType, registeredKernel->GetTaskRation(),
        tilingKey);
    return RT_ERROR_NONE;
}

static bool CheckCcuMissionIdSingleDie(rtCcuTaskInfo_t *ccuTaskInfo, uint32_t num)
{
    if (num == 1) {
        return true;
    }
    return (ccuTaskInfo[num - 1].missionId > ccuTaskInfo[num - 2].missionId) &&
        CheckCcuMissionIdSingleDie(ccuTaskInfo, num - 1);
}

static bool CheckCcuMissionIdDoubleDie(rtCcuTaskInfo_t *ccuTaskInfo, uint32_t num)
{
    if (num == RT_MISSION_INDEX_TWO) {
        return true;
    }
    return (ccuTaskInfo[num - RT_MISSION_INDEX_ONE].missionId > ccuTaskInfo[num - RT_MISSION_INDEX_THREE].missionId) &&
        (ccuTaskInfo[num - RT_MISSION_INDEX_TWO].missionId > ccuTaskInfo[num - RT_MISSION_INDEX_FOUR].missionId) &&
        CheckCcuMissionIdDoubleDie(ccuTaskInfo, num - RT_MISSION_INDEX_TWO);
}

static bool CheckCcuMissionId(rtCcuTaskInfo_t *ccuTaskInfo, uint32_t num, bool isDoubleDie)
{
    if (isDoubleDie) {
        return CheckCcuMissionIdDoubleDie(ccuTaskInfo, num);
    }
    return CheckCcuMissionIdSingleDie(ccuTaskInfo, num);
}

static rtError_t PreProcCcuTaskForFusion(rtFusionSubTaskInfo_t *const fusionTask, uint8_t &sqeSubType,
    uint32_t &sqeLen, uint8_t &ccuArgSize)
{
    rtCcuTaskGroup_t * const ccuInfo = &(fusionTask->task.ccuInfo);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(ccuInfo->taskNum == 0U || ccuInfo->taskNum > FUSION_SUB_TASK_MAX_CCU_NUM, 
        RT_ERROR_INVALID_VALUE, ccuInfo->taskNum, "(0, " + std::to_string(FUSION_SUB_TASK_MAX_CCU_NUM) + "]");    
    NULL_PTR_RETURN_MSG_OUTER(ccuInfo->ccuTaskInfo, RT_ERROR_INVALID_VALUE);

    uint8_t isHas128B = 0U;
    uint8_t isHas32B = 0U;
    uint32_t dieIdArrange = 0U;
    uint32_t checkArrange = 0U;

    // get ccu subType
    for (uint32_t i = 0U; i < ccuInfo->taskNum; i++) {
        NULL_PTR_RETURN_MSG_OUTER(ccuInfo->ccuTaskInfo[i].args, RT_ERROR_INVALID_VALUE);
        COND_RETURN_OUT_ERROR_MSG_CALL(ccuInfo->ccuTaskInfo[i].argSize != RT_CCU_SQE128B_ARGS_SIZE &&
            ccuInfo->ccuTaskInfo[i].argSize != RT_CCU_SQE32B_ARGS_SIZE, RT_ERROR_INVALID_VALUE,
            "ccu subTask [%u] argSize is invalid, it should be 1 or 13.", i);
        COND_RETURN_OUT_ERROR_MSG_CALL(ccuInfo->ccuTaskInfo[i].dieId > 1, RT_ERROR_INVALID_VALUE,
            "ccu subTask die id is invalid, it should between [0,1].");
        COND_RETURN_OUT_ERROR_MSG_CALL(ccuInfo->ccuTaskInfo[i].missionId > RT_CCU_MISSION_ID_MAX,
            RT_ERROR_INVALID_VALUE, "ccu subTask mission id is invalid, it should <= %u.",
            RT_CCU_MISSION_ID_MAX);
        COND_RETURN_OUT_ERROR_MSG_CALL(ccuInfo->ccuTaskInfo[i].instCnt == RT_CCU_INST_CNT_INVALID,
            RT_ERROR_INVALID_VALUE, "ccu subTask instCnt is invalid, it should not be %u.",
            RT_CCU_INST_CNT_INVALID);
        COND_RETURN_OUT_ERROR_MSG_CALL(ccuInfo->ccuTaskInfo[i].instStartId >= RT_CCU_INST_START_MAX,
            RT_ERROR_INVALID_VALUE, "ccu subTask instStartId is invalid, it should be [%u, %u).",
            0U, RT_CCU_INST_START_MAX);
        sqeSubType |= (ccuInfo->ccuTaskInfo[i].dieId == 0U) ? (1U << RT_FUSION_CCU_DIE0_BIT_MOVE) :
            (1U << RT_FUSION_CCU_DIE1_BIT_MOVE);
        // 双die上 0、1排布合法性
        dieIdArrange |= static_cast<uint32_t>(ccuInfo->ccuTaskInfo[i].dieId) << i;
        checkArrange = ((i & 1U) == 1U) ? checkArrange : ((checkArrange << 2U) | 0x2U);
        isHas32B |= ccuInfo->ccuTaskInfo[i].argSize == RT_CCU_SQE32B_ARGS_SIZE ? 1U : 0U;
        isHas128B |= ccuInfo->ccuTaskInfo[i].argSize == RT_CCU_SQE128B_ARGS_SIZE ? 1U : 0U;
    }
    COND_RETURN_OUT_ERROR_MSG_CALL((isHas32B == 1U) && (isHas128B == 1U), RT_ERROR_INVALID_VALUE,
        "ccu subTasks' argSize is invalid, it should be all 32B or 128B.");

    // 双die num奇数返错 0x18 -> 11000
    const bool isDoubleDie = (sqeSubType & 0x18U) == 0x18U ? true : false;
    uint8_t taskNum = static_cast<uint8_t>(ccuInfo->taskNum);
    if (isDoubleDie) {
        COND_RETURN_OUT_ERROR_MSG_CALL(((taskNum & 1U) == 1U), RT_ERROR_INVALID_VALUE,
            "ccu subTasks' num %u is invalid, it should be even number when double die.", taskNum);
        COND_RETURN_OUT_ERROR_MSG_CALL((dieIdArrange != checkArrange), RT_ERROR_INVALID_VALUE,
            "ccu subTasks' arrangement %u is wrong when double die.", dieIdArrange);
        taskNum = taskNum / 2U;
    }

    COND_RETURN_OUT_ERROR_MSG_CALL((isHas32B == 1U) && (taskNum <= 1U), RT_ERROR_INVALID_VALUE,
        "ccu subTask argSize is invalid, taskNum should > 1 when argSize is 1 per die.");
    COND_RETURN_OUT_ERROR_MSG_CALL((isHas128B == 1U) && (taskNum > 1U), RT_ERROR_INVALID_VALUE,
        "ccu subTask argSize is invalid, taskNum should be 1 when argSize is 13 per die.");
    ccuArgSize = (isHas32B == 1U) ? RT_CCU_SQE32B_ARGS_SIZE : RT_CCU_SQE128B_ARGS_SIZE;
    // mission id的递增
    COND_RETURN_OUT_ERROR_MSG_CALL(!CheckCcuMissionId(ccuInfo->ccuTaskInfo, static_cast<int32_t>(ccuInfo->taskNum),
        isDoubleDie), RT_ERROR_INVALID_VALUE, "ccu subTasks' mission id is invalid, it should increase.");

    // when fusion type is "ccu + aic" or "ccu + ccu", ccu sqe' size must be occupied 4*64B=256B.
    sqeLen += 4U;

    RT_LOG(RT_LOG_EVENT, "ccu task info: sqeSubType=%hhu, taskNum=%u.", sqeSubType,
        ccuInfo->taskNum);
    return RT_ERROR_NONE;
}

static void FusionKernelTaskProc(const rtFunsionTaskInfo_t * const fusionKernel, TaskInfo * const taskInfo,
    const rtAicAivFusionInfo_t * const aicAivInfo, const LaunchTaskCfgInfo_t * const launchTaskCfg, uint8_t ccuArgSize)
{
    const uint32_t subKernelNum = fusionKernel->subTaskNum;
    FusionKernelTaskInit(taskInfo);
    for (uint32_t idx = 0; idx < subKernelNum; idx++) {
        const rtFusionType_t subKernelType = fusionKernel->subTask[idx].type;
        const rtFusionSubTaskInfo_t * const subKernelInfo = &(fusionKernel->subTask[idx]);
        switch (subKernelType) {
            case RT_FUSION_AICORE:
                AixKernelTaskInitForFusion(taskInfo, aicAivInfo, launchTaskCfg);
                break;
            case RT_FUSION_CCU:
                taskInfo->u.fusionKernelTask.ccuSqeNum = subKernelInfo->task.ccuInfo.taskNum;
                taskInfo->u.fusionKernelTask.ccuArgSize = ccuArgSize;
                break;
            default:
                RT_LOG(RT_LOG_INFO, "sub task [%u]'s type=%u.", idx,
                    static_cast<uint32_t>(subKernelType));
                break;
        }
    }
}

static rtError_t FusionKernelTaskPreProc(rtFunsionTaskInfo_t * const fusionKernel, Stream * const stm, Program *&prog,
    uint32_t &sqeLen, uint8_t &sqeSubType, uint8_t &ccuArgSize, rtAicAivFusionInfo_t *aicAivInfo,
    LaunchTaskCfgInfo_t *launchTaskCfg)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t subKernelNum = fusionKernel->subTaskNum;

    std::array<uint32_t, RT_FUSION_CCU> fusionSubTaskMove = {
        RT_FUSION_HCOMCPU_BIT_MOVE,
        RT_FUSION_AICPU_BIT_MOVE,
        RT_FUSION_AIC_BIT_MOVE
    };
    for (uint32_t idx = 0; idx < subKernelNum; idx++) {
        uint32_t subKernelType = fusionKernel->subTask[idx].type;
        rtFusionSubTaskInfo_t * const subKernelInfo = &(fusionKernel->subTask[idx]);
        switch (subKernelType) {
            case RT_FUSION_AICORE:
                error = PreProcAicAivTaskForFusion(subKernelInfo, stm, prog, aicAivInfo, launchTaskCfg);
                ERROR_RETURN(error, "stream_id=%d failed to proc aic/aiv sub task, retCode=%#x.",
                    stm->Id_(), static_cast<uint32_t>(error));
                sqeSubType |= (1U << fusionSubTaskMove[subKernelType]);
                sqeLen += 1U;
                break;
            case RT_FUSION_HCOM_CPU:
                COND_RETURN_OUT_ERROR_MSG_CALL(fusionKernel->subTask[idx].task.aicpuInfo.blockDim != 1U,
                    RT_ERROR_INVALID_VALUE,
                    "stream_id=%d hcom_cpu task's blkdim is invalid, it should be 1, but now blkdim=%u.",
                    stm->Id_(), fusionKernel->subTask[idx].task.aicpuInfo.blockDim);
                subKernelType += (stm->Device_()->IsSupportHcomcpu() == 1U) ? 0U : 1U;
                sqeSubType |= (1U << fusionSubTaskMove[subKernelType]);
                sqeLen += 1U;
                break;
            case RT_FUSION_AICPU:
                sqeSubType |= (1U << FUSION_SUBTASK_MOVE[subKernelType]);
                sqeLen += 1U;
                break;
            case RT_FUSION_CCU:
                error = PreProcCcuTaskForFusion(subKernelInfo, sqeSubType, sqeLen, ccuArgSize);
                ERROR_RETURN(error, "stream_id=%d failed to proc ccu sub task, retCode=%#x",
                    stm->Id_(), static_cast<uint32_t>(error));
                /* 0x18U means die0 ccu + die1 ccu */
                COND_RETURN_OUT_ERROR_MSG_CALL((subKernelNum == 1U) && ((sqeSubType != 0x18U) ||
                    (ccuArgSize != RT_CCU_SQE128B_ARGS_SIZE)), RT_ERROR_INVALID_VALUE,
                    "If only have ccu task (without aic task), fusion only accept double die 128B ccu, "
                    "ccuArgsSize=%u, sqeSubType=0x%x.", ccuArgSize, sqeSubType);
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "sub task [%u]'s type is invalid, type=%u.", idx,
                    static_cast<uint32_t>(subKernelType));
                return RT_ERROR_INVALID_VALUE;
        }
    }
    RT_LOG(RT_LOG_INFO, "sqeLen=%hhu, sqeSubType=%hhu, stream_id=%d.", sqeLen, sqeSubType, stm->Id_());
    return error;
}

static void SetArgsFusionKernel(const rtFusionArgsEx_t * const argsInfo,
                                TaskInfo * const taskInfo, DavidArgLoaderResult * const result)
{
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    fusionKernelTask->argsInfo = const_cast<rtFusionArgsEx_t*>(argsInfo);
    fusionKernelTask->argsSize = argsInfo->argsSize;
    fusionKernelTask->args = result->kerArgs;

    const uint8_t aicpuNum = argsInfo->aicpuNum;
    for (uint8_t i = 0U; i < aicpuNum; ++i) {
        fusionKernelTask->aicpuArgsDesc[i].soName = static_cast<void *>(RtPtrToPtr<char_t *>(fusionKernelTask->args) +
            argsInfo->aicpuArgs[i].soNameAddrOffset);
        fusionKernelTask->aicpuArgsDesc[i].funcName = static_cast<void *>(RtPtrToPtr<char_t *>(fusionKernelTask->args) +
            argsInfo->aicpuArgs[i].kernelNameAddrOffset);
    }

    // only for aclgraph
    fusionKernelTask->oldArgHandle = fusionKernelTask->argHandle;

    if (result->handle != nullptr) {
        fusionKernelTask->argHandle = result->handle;
        taskInfo->needPostProc = true;
    }
    taskInfo->stmArgPos = static_cast<DavidStream *>(taskInfo->stream)->GetArgPos();
    result->stmArgPos = UINT32_MAX;
    result->handle = nullptr;
}

static rtError_t CheckUpdateFusionTaskInfo(const TaskInfo * const updateTask, uint32_t sqeLen, uint8_t sqeSubType,
    const Kernel * const kernel, uint8_t kernelType, const Stream * const stm)
{
    if (updateTask->stream->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update task must be a sinked task, stream_id=%d, task_id=%hu.",
               updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_MODEL_NULL;
    }

    if (stm->Model_() != nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update stream must be a single operator stream, stream_id=%d, task_id=%hu.",
            updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_STREAM_MODEL;
    }

    if (updateTask->u.fusionKernelTask.sqeLen != sqeLen) {
        RT_LOG(RT_LOG_ERROR, "check fusion sqe num failed, old sqeLen=%u, new sqeLen=%u.",
            updateTask->u.fusionKernelTask.sqeLen, sqeLen);
        return RT_ERROR_INVALID_VALUE;
    }

    if ((sqeSubType & (1U << RT_FUSION_AIC_BIT_MOVE)) == 0U) {
        RT_LOG(RT_LOG_ERROR, "The update subtask does not include the aicore task, sqeSubType=0x%x.", sqeSubType);
        return RT_ERROR_INVALID_VALUE;
    }

    if ((updateTask->u.fusionKernelTask.aicPart.kernel->GetMixType() != kernel->GetMixType()) ||
        (updateTask->u.fusionKernelTask.aicPart.kernel->GetFuncType() != kernel->GetFuncType()) ||
        (updateTask->u.fusionKernelTask.aicAivType != kernelType)) {
        RT_LOG(RT_LOG_ERROR, "check kernel type failed, stream_id=%d, task_id=%hu, "
            "old mixType=%u, funcType=%u, machine=%u, new mixType=%u, funcType=%u, machine=%u.",
            updateTask->stream->Id_(), updateTask->id, updateTask->u.fusionKernelTask.aicPart.kernel->GetMixType(),
            updateTask->u.fusionKernelTask.aicPart.kernel->GetFuncType(), updateTask->u.fusionKernelTask.aicAivType,
            kernel->GetMixType(), kernel->GetFuncType(), kernelType);
        return RT_ERROR_KERNEL_TYPE;
    }

    return RT_ERROR_NONE;
}

void GetAicAivTypeForFusion(uint8_t mixType, uint32_t machine, uint8_t &aicAivType)
{
    if (mixType != static_cast<uint8_t>(NO_MIX)) {
        if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC))) {
            aicAivType = 0U;
        } else {
            aicAivType = 1U;
        }
    } else {
        if (machine == Program::MACH_AI_VECTOR) {
            aicAivType = 1U;
        } else {
            aicAivType = 0U;
        }
    }
}

rtError_t LaunchFusionKernel(Stream* stm, void * const fusionKernelInfo, rtFusionArgsEx_t *argsInfo)
{
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    Program *prog = nullptr;
    Runtime * const rt = Runtime::Instance();
    rtFunsionTaskInfo_t *fusionKernel = static_cast<rtFunsionTaskInfo_t *>(fusionKernelInfo);

    uint32_t sqeLen = 0U;
    uint8_t sqeSubType = 0U;
    uint8_t ccuArgSize = 0U;
    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t launchTaskCfg = {};

    rtError_t error = FusionKernelTaskPreProc(fusionKernel, stm, prog, sqeLen, sqeSubType, ccuArgSize, &aicAivInfo, &launchTaskCfg);
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);,
        "Failed to pre proc fusion kernel task, retCode=%#x.", static_cast<uint32_t>(error));
    COND_PROC_RETURN_ERROR_MSG_INNER(sqeLen > SQE_NUM_PER_DAVID_TASK_MAX, RT_ERROR_INVALID_VALUE, rt->PutProgram(prog);,
        "sqelen:%u is invalid max:%u.", sqeLen, SQE_NUM_PER_DAVID_TASK_MAX);
    error = CheckTaskCanSend(stm);
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);, "stream_id=%d check failed, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, stm->IsTaskGroupUpdate());
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    TaskInfo *taskInfo = nullptr;
    std::function<void()> const errRecycle = [&result, &taskInfo, &stm, &pos, &prog, &dstStm]() {
        StreamLaunchKernelRecycle(result, taskInfo, prog, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&taskInfo, stm, pos, dstStm, sqeLen, true);
    ERROR_PROC_RETURN_MSG_INNER(error,
        stm->StreamUnLock();
        rt->PutProgram(prog);,
        "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    ScopeGuard tskErrRecycle(errRecycle);
    if (taskInfo->isUpdateSinkSqe == 1U) {
        uint8_t aicAivType = 0U;
        GetAicAivTypeForFusion(aicAivInfo.mixType, aicAivInfo.mach, aicAivType);
        error = CheckUpdateFusionTaskInfo(taskInfo, sqeLen, sqeSubType, aicAivInfo.kernel, aicAivType, stm);
        ERROR_RETURN_MSG_INNER(error, "stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(), aicAivType,
                               static_cast<uint32_t>(error));
    } else {
        SaveTaskCommonInfo(taskInfo, dstStm, pos, sqeLen);
    }
    FusionKernelTaskProc(fusionKernel, taskInfo, &aicAivInfo, &launchTaskCfg, ccuArgSize);

    if (argsInfo != nullptr) {
        error = davidStm->LoadArgsInfo(argsInfo, useArgPool, &result);
        ERROR_RETURN_MSG_INNER(error, "Failed to load args with stm pool, stream_id=%d, useArgPool=%u, retCode=%#x.",
            stm->Id_(), useArgPool, static_cast<uint32_t>(error));
        SetArgsFusionKernel(argsInfo, taskInfo, &result);
    }
    taskInfo->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    taskInfo->u.fusionKernelTask.fusionKernelInfo = const_cast<void *>(fusionKernelInfo);
    taskInfo->u.fusionKernelTask.sqeLen = sqeLen;
    taskInfo->u.fusionKernelTask.sqeSubType = sqeSubType;
    RT_LOG(RT_LOG_INFO, "sqeLen=%hhu, sqeSubType=%hhu, stream_id=%d.", sqeLen, sqeSubType, stm->Id_());
    if (taskInfo->isUpdateSinkSqe == 1U) {
        error = UpdateDavidKernelTaskSubmit(taskInfo, stm, sqeLen);
        if ((error != RT_ERROR_NONE) && (taskInfo->u.fusionKernelTask.oldArgHandle != nullptr)) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(taskInfo->u.fusionKernelTask.oldArgHandle);
            }
        }
        taskInfo->u.fusionKernelTask.oldArgHandle = nullptr;
        taskInfo->isUpdateSinkSqe = 0U;
    } else {
        error = DavidSendTask(taskInfo, dstStm);
    }
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    rt->PutProgram(prog);
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), taskInfo->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
