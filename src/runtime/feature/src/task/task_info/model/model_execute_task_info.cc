/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stream.hpp"
#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "notify.hpp"
#include "stars_cond_isa_helper.hpp"
#include "device/device_error_proc.hpp"
#include "hwts.hpp"
#include "model.hpp"
#include "error_code.h"
#include "error_message_manage.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {
namespace {
const std::set<int32_t> MEM_ERROR_CODE = {TS_ERROR_AICORE_MTE_ERROR,
                                          TS_ERROR_SDMA_LINK_ERROR,
                                          TS_ERROR_SDMA_POISON_ERROR};
} // namespace 
#if F_DESC("ModelExecuteTask")

// 针对model exe性能优化需求，host侧和device侧内存释放挪到model粒度释放
static rtError_t FreeFuncCallMemForModelExecuteTask(const TaskInfo * const taskInfo)
{
    UNUSED(taskInfo);
    return RT_ERROR_NONE;
}

// save func data to host memory
static rtError_t SaveFuncCallDataForModelExecuteTask(TaskInfo * const taskInfo,
    const std::vector<uint64_t> &headSq, const std::vector<uint64_t> &streamSvmAddr)
{
    const size_t headSqArrMax = headSq.size();
    const size_t streamSvmArrMax = streamSvmAddr.size();
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    uint8_t *dstMem =
        reinterpret_cast<uint8_t *>(modelExecuteTaskInfo->model->GetFuncCallHostMem()) + sizeof(RtStarsModelExeFuncCall);

    rtError_t ret = memcpy_s(dstMem, (headSqArrMax * sizeof(uint64_t)),
                             headSq.data(), (headSqArrMax * sizeof(uint64_t)));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s headSqArr failed.");

    dstMem = dstMem + headSqArrMax * sizeof(uint64_t);
    ret = memcpy_s(dstMem, (streamSvmArrMax * sizeof(uint64_t)), streamSvmAddr.data(),
        (streamSvmArrMax * sizeof(uint64_t)));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s streamSvmAddrArr failed.");
    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallHostMemAndSvmMem(TaskInfo * const taskInfo)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    Device * const dev = model->Context_()->Device_();
    Driver * const deviceDrv = dev->Driver_();

    if (model->GetFuncCallHostMem() != nullptr) {
        free(model->GetFuncCallHostMem());
        model->SetFuncCallHostMem(nullptr);
        model->SetDfxPtr(nullptr);
    }

    if (model->GetBaseFuncCallSvmMem() != nullptr) {
        (void)deviceDrv->DevMemFree(model->GetBaseFuncCallSvmMem(), dev->Id_());
        model->SetBaseFuncCallSvmMem(nullptr);
        model->SetFunCallMemSize(0ULL);
    }

    if (model->GetFuncCallDfxBaseSvmMem() != nullptr) {
        (void)deviceDrv->DevMemFree(model->GetFuncCallDfxBaseSvmMem(), dev->Id_());
        model->SetFuncCallDfxBaseSvmMem(nullptr);
        model->SetDfxPtr(nullptr);
    }
    return RT_ERROR_NONE;
}

static rtError_t DfxCombineFuncCallDevMemAlloc(Model *model, TaskInfo * const taskInfo)
{
    rtError_t ret;
    void *devMem = nullptr;
    void *dfxPtr = nullptr;
    Stream * const stream = taskInfo->stream;
    const Device *dev = stream->Device_();
    const uint64_t allocSize = model->GetFunCallMemSize() +
        TS_STARS_COND_DFX_SIZE + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u",
                    ret, model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }

    model->SetBaseFuncCallSvmMem(devMem);
    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void *>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, const uintptr_t>(devMemAlign);
    }
    model->SetFuncCallSvmMem(RtPtrToValue<const void *>(devMem));

    dfxPtr = RtValueToPtr<void *>(model->GetFuncCallSvmMem() + model->GetFunCallMemSize());
    model->SetDfxPtr(dfxPtr);
    return RT_ERROR_NONE;
}

static rtError_t DfxSplitFuncCallDevMemAlloc(Model *model, TaskInfo * const taskInfo)
{
    rtError_t ret;
    void *devMem = nullptr;
    void *devMemDfx = nullptr;
    Stream * const stream = taskInfo->stream;
    const Device *dev = stream->Device_();
    constexpr bool readonly = true;
    uint64_t allocSize = model->GetFunCallMemSize() + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    // alloc funcCall devMem which is readonly.
    ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_(), MODULEID_RUNTIME, true, readonly);
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc funcCall memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u",
                    ret, model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }
    // alloc funcCall devMem for dfx, cannot use readonly and need align.
    allocSize = TS_STARS_COND_DFX_SIZE + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    ret = dev->Driver_()->DevMemAlloc(&devMemDfx, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMemDfx == nullptr)) {
        (void)dev->Driver_()->DevMemFree(devMem, dev->Id_());
        devMem = nullptr;
        RT_LOG(RT_LOG_ERROR, "alloc funcCall dfx memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u",
                    ret, model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }

    model->SetBaseFuncCallSvmMem(devMem);
    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void *>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void *>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void *, const uintptr_t>(devMemAlign);
    }
    model->SetFuncCallSvmMem(RtPtrToValue<const void *>(devMem));

    model->SetFuncCallDfxBaseSvmMem(devMemDfx);
    if ((RtPtrToPtr<uintptr_t, void *>(devMemDfx) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemDfxAlign = (((RtPtrToPtr<uintptr_t, void *>(devMemDfx)) >> 8U) + 1UL) << 8U;
        devMemDfx = RtPtrToPtr<void *, const uintptr_t>(devMemDfxAlign);
    }
    model->SetDfxPtr(devMemDfx);

    return RT_ERROR_NONE;
}

rtError_t AllocFuncCallMemForModelExecuteTask(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara)
{
    std::vector<uint64_t> headSqArr;
    std::vector<uint64_t> streamSvmAddrArr;
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    rtError_t ret;

    std::list<Stream *> const headStmList = model->GetHeadStreamList_();
    for (Stream * const stm : headStmList) {
        headSqArr.emplace_back(stm->GetSqId());
        streamSvmAddrArr.emplace_back(RtPtrToValue(stm->GetExecutedTimesSvm()));

        RT_LOG(RT_LOG_INFO, "stream_id:%d, sq_id:%u.", stm->Id_(), stm->GetSqId());
    }

    const uint64_t headSqArrMax = headSqArr.size();
    const uint64_t streamSvmArrMax = streamSvmAddrArr.size();
    COND_RETURN_ERROR((headSqArrMax == 0ULL), RT_ERROR_MODEL_EXECUTOR, "model stream para error, headSqArrMax=%" PRIu64,
                      headSqArrMax);

    const uint64_t funCallMemSize =
        sizeof(RtStarsModelExeFuncCall) + (headSqArrMax + streamSvmArrMax) * sizeof(uint64_t);
    model->SetFunCallMemSize(funCallMemSize);

    model->SetFuncCallHostMem(malloc(funCallMemSize));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, model->GetFuncCallHostMem() == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                               "alloc funcCall memory failed.");

    RT_LOG(RT_LOG_INFO, "funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64, model->GetFuncCallHostMem(),
           model->GetFunCallMemSize());

    //save data to funcCallHostMem
    ret = SaveFuncCallDataForModelExecuteTask(taskInfo, headSqArr, streamSvmAddrArr);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "save funcCall data failed, retCode=%#x.", ret);

    if (taskInfo->stream->Device_()->IsSupportFeature(
            RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_SPLIT_FUNC_CALL)) {
        ret = DfxSplitFuncCallDevMemAlloc(model, taskInfo);
    } else {
        ret = DfxCombineFuncCallDevMemAlloc(model, taskInfo);
    }
    if (ret != RT_ERROR_NONE) {
        (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
        RT_LOG(RT_LOG_ERROR, "alloc funcCall device Memory failed, retCode=%#x.", ret);
        return ret;
    }

    funcCallPara.funcCallAddr = model->GetFuncCallSvmMem();
    funcCallPara.headSqArrAddr = funcCallPara.funcCallAddr + sizeof(RtStarsModelExeFuncCall);
    funcCallPara.streamSvmArrAddr = funcCallPara.headSqArrAddr + (headSqArrMax * sizeof(uint64_t));
    funcCallPara.headSqArrMax = headSqArrMax;
    funcCallPara.streamSvmArrMax = streamSvmArrMax;

    RT_LOG(RT_LOG_DEBUG,
           "first execute. funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64 ", funcCallSvmMem=%#" PRIx64
           ", baseFuncCallSvmMem=%#" PRIx64 ", dfxAddr=%#" PRIx64,
           model->GetFuncCallHostMem(), model->GetFunCallMemSize(), model->GetFuncCallSvmMem(),
           model->GetBaseFuncCallSvmMem(), model->GetDfxPtr());

    return RT_ERROR_NONE;
}

static rtError_t ConstructFuncCallPara(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara)
{
    Stream * const stream = taskInfo->stream;
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    const rtError_t ret = AllocFuncCallMemForModelExecuteTask(taskInfo, funcCallPara);
    ERROR_RETURN(ret, "alloc func call svm failed, retCode=%#x.", ret);

    funcCallPara.sqHeadOffset = STARS_SIMPLE_SQ_HEAD_OFFSET;
    const DevProperties props = taskInfo->stream->Device_()->GetDevProperties();
    funcCallPara.sqTailOffset = props.sqTailOffset;
    funcCallPara.sqFsmSelBasAddr = static_cast<uint64_t>(props.fsmSelBase);
    if (props.starsResourceAddrCalculateMethod == 
        StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO) {
        const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
        const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
        const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();
        funcCallPara.sqFsmSelBasAddr = funcCallPara.sqFsmSelBasAddr +
            (chipOffset * static_cast<uint64_t>(stream->Device_()->GetPhyChipId())) +
            (dieOffset * static_cast<uint64_t>(stream->Device_()->GetPhyDieId())) + chipAddr;
    }
    if (props.starsBaseMethod == StarsBaseMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
        const uint64_t baseAddr = taskInfo->stream->Device_()->GetStarsRegBaseAddr();
        RT_LOG(RT_LOG_INFO, "baseAddr=0x%llx", baseAddr);    
        if (baseAddr == 0ULL) {
            RT_LOG(RT_LOG_ERROR, "invalid device_id, physic chip_id=%u, die_id=%u, stream_id=%d.",
                    taskInfo->stream->Device_()->Id_(), taskInfo->stream->Device_()->GetPhyChipId(),
                    taskInfo->stream->Device_()->GetPhyDieId(), taskInfo->stream->Id_());
            return RT_ERROR_DEVICE_INVALID;
        }
        funcCallPara.sqFsmSelBasAddr = baseAddr + STARSV2_SIMPLE_RTSQ_FSM_SEL_REG;
    }
    funcCallPara.sqVirtualAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream->Device_()->GetSqVirtualArrBaseAddr_()));
    funcCallPara.dfxAddr = reinterpret_cast<uint64_t>(modelExecuteTaskInfo->model->GetDfxPtr());
    return RT_ERROR_NONE;
}

rtError_t StarsV2ConstructFuncCallPara(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara)
{
    Stream * const stream = taskInfo->stream;
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    const rtError_t ret = AllocFuncCallMemForModelExecuteTask(taskInfo, funcCallPara);
    ERROR_RETURN(ret, "alloc func call svm failed, retCode=%#x.", ret);

    funcCallPara.sqHeadOffset = STARS_SIMPLE_SQ_HEAD_OFFSET;
    funcCallPara.sqTailOffset = STARS_SIMPLE_SQ_TAIL_OFFSET;
    const uint64_t baseAddr = taskInfo->stream->Device_()->GetStarsRegBaseAddr();
    RT_LOG(RT_LOG_INFO, "baseAddr=0x%llx", baseAddr);    
    if (baseAddr == 0ULL) {
        RT_LOG(RT_LOG_ERROR, "invalid device_id, physic chip_id=%u, die_id=%u, stream_id=%d.",
               taskInfo->stream->Device_()->Id_(), taskInfo->stream->Device_()->GetPhyChipId(),
               taskInfo->stream->Device_()->GetPhyDieId(), taskInfo->stream->Id_());
        return RT_ERROR_DEVICE_INVALID;
    }
    funcCallPara.sqFsmSelBasAddr = baseAddr + STARSV2_SIMPLE_RTSQ_FSM_SEL_REG;
    funcCallPara.sqTailOffset = static_cast<uint16_t>(STARSV2_SIMPLE_SQ_TAIL_OFFSET) ;
    RT_LOG(RT_LOG_INFO, "chip_id=%lld,die_id=%lld,rtSqFsmState=0x%llx", stream->Device_()->GetPhyChipId(),
        stream->Device_()->GetPhyDieId(), funcCallPara.sqFsmSelBasAddr);

    funcCallPara.sqVirtualAddr =
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(stream->Device_()->GetSqVirtualArrBaseAddr_()));
    funcCallPara.dfxAddr = reinterpret_cast<uint64_t>(modelExecuteTaskInfo->model->GetDfxPtr());
    return RT_ERROR_NONE;
}

static void PrintDebugInfoForModelExecute(const Model *model)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        const uint32_t *const cmdF = reinterpret_cast<const uint32_t *>(model->GetFuncCallHostMem());
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeFuncCall) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute before h2d instr[%zu]=0x%08x", i, *(cmdF + i));
        }

        const uint64_t *const cmdS = reinterpret_cast<const uint64_t *>(
            reinterpret_cast<uint8_t *>(model->GetFuncCallHostMem()) + sizeof(RtStarsModelExeFuncCall));
        for (size_t i = 0UL; i < ((model->GetFunCallMemSize() - sizeof(RtStarsModelExeFuncCall)) / sizeof(uint64_t));
             i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute before h2d sq data[%zu]=%#" PRIx64, i, *(cmdS + i));
        }
    }
}

rtError_t PrepareSqeInfoForModelExecuteTask(TaskInfo * const taskInfo)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    Stream * const stream = taskInfo->stream;
    const auto dev = stream->Device_();

    if (!stream->Device_()->IsStarsPlatform()) {
        return RT_ERROR_NONE;
    }
    rtError_t ret = RT_ERROR_NONE;
    if (unlikely(model->GetFirstExecute())) {
        std::unique_lock<std::mutex> lock(model->GetFirstExecuteMutex());
        if(model->GetFirstExecute()){
            RtStarsModelExeFuncCall funcCall = {};
            rtStarsModelExeFuncCallPara_t funcCallPara = {};
            ret = ConstructFuncCallPara(taskInfo, funcCallPara);
            COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "construct func call para failed, retCode=%#x.", ret);

            RT_LOG(RT_LOG_DEBUG, "Func call para, funcCallAddr=%#" PRIx64 ", headSqArrAddr=%#" PRIx64
                    ", headSqArrMax=%#" PRIx64 ", streamSvmArrAddr=%#" PRIx64 ", streamSvmArrMax=%#" PRIx64
                    ", sqFsmSelBasAddr=%#" PRIx64 ", dfxAddr=%#" PRIx64,
                    funcCallPara.funcCallAddr, funcCallPara.headSqArrAddr,funcCallPara.headSqArrMax,
                    funcCallPara.streamSvmArrAddr, funcCallPara.streamSvmArrMax,
                    funcCallPara.sqFsmSelBasAddr, funcCallPara.dfxAddr);

            ConstrucModelExeFuncCall(funcCallPara, funcCall);
            ret = memcpy_s(model->GetFuncCallHostMem(), sizeof(RtStarsModelExeFuncCall),
                reinterpret_cast<void *>(&funcCall), sizeof(RtStarsModelExeFuncCall));
            if(unlikely(ret != EOK)){
                (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
                RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "Memcpy_s failed.");
                return RT_ERROR_SEC_HANDLE;
            }
            RT_LOG(RT_LOG_DEBUG,"model first execute.funcCallHostMem=%#" PRIx64, model->GetFuncCallHostMem());

            const rtMemcpyKind_t kind = (
                taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ? 
                RT_MEMCPY_DEVICE_TO_DEVICE : RT_MEMCPY_HOST_TO_DEVICE;
            ret = (dev->Driver_())->MemCopySync((void*)(uintptr_t)(model->GetFuncCallSvmMem()),
                model->GetFunCallMemSize(), model->GetFuncCallHostMem(), model->GetFunCallMemSize(), kind);

            PrintDebugInfoForModelExecute(model);

            if (ret != RT_ERROR_NONE) {
                (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
                RT_LOG(RT_LOG_ERROR, "MemCopySync for model exe func call failed, retCode=%#x.", ret);
            } else {
                model->SetFirstExecute(false);
            }
        }
    } else {
        if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE)) {
            ret = (dev->Driver_())->MemCopySync((void*)(uintptr_t)(model->GetFuncCallSvmMem()),
                model->GetFunCallMemSize(), model->GetFuncCallHostMem(), model->GetFunCallMemSize(), RT_MEMCPY_DEVICE_TO_DEVICE);
            if (ret != RT_ERROR_NONE) {
                (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
                RT_LOG(RT_LOG_ERROR, "MemCopySync for model exe func call failed without first execute, retCode=%#x.", ret);
                return ret;
            }
        }
        RT_LOG(RT_LOG_DEBUG, "not model first execute, funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64
                ", funcCallSvmMem=%#" PRIx64 ", baseFuncCallSvmMem=%#" PRIx64 ", dfxAddr=%#" PRIx64,
                model->GetFuncCallHostMem(), model->GetFunCallMemSize(), model->GetFuncCallSvmMem(),
                model->GetBaseFuncCallSvmMem(), model->GetDfxPtr());
    }

    return ret;
}

void ModelExecuteTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeFuncCallMemForModelExecuteTask(taskInfo);
}

rtError_t ModelExecuteTaskInit(TaskInfo * const taskInfo, Model *const modelPtr, const uint32_t modelIndex,
                               const uint32_t firstTaskIndex)
{
    COND_RETURN_ERROR_MSG_INNER(modelPtr == nullptr, RT_ERROR_MODEL_NULL,
        "Init ModelExecuteTask failed, modelPtr null.");

    ModelExecuteTaskInfo *modelExecTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MODEL_EXECUTE;
    taskInfo->typeName = "MODEL_EXECUTE";
    modelExecTaskInfo->modelId = modelIndex;
    modelExecTaskInfo->firstTaskId = firstTaskIndex;
    modelExecTaskInfo->model = modelPtr;
    modelExecTaskInfo->errorTaskId = 0U;
    modelExecTaskInfo->errorStreamId = 0U;

    return PrepareSqeInfoForModelExecuteTask(taskInfo);
}

void SetStarsResultForModelExecuteTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if ((logicCq.errorType & static_cast<uint8_t>(RT_STARS_EXIST_ERROR)) != 0U) {
        const uint32_t starsDefineErrorCode = logicCq.errorCode;
        if ((starsDefineErrorCode & static_cast<uint32_t>(RT_STARS_CQE_ERR_TYPE_EXCEPTION)) != 0U) {
            taskInfo->errorCode = TS_ERROR_ILLEGAL_PARAM;
            RT_LOG(RT_LOG_ERROR, "model status is busy when execute, model_id=%u, stream_id=%hu, task_id=%hu",
                modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
            return;
        }
        if (logicCq.errorType == 0x4U) {
            taskInfo->errorCode = TS_ERROR_TASK_TIMEOUT;
            RT_LOG(RT_LOG_ERROR, "ModelExecuteTask timout, model_id=%u, stream_id=%hu, task_id=%hu",
                   modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
            return;
        }

        if (logicCq.errorCode == 0) {
            taskInfo->errorCode = TS_ERROR_ILLEGAL_PARAM;
            RT_LOG(RT_LOG_ERROR, "ModelExecuteTask goto error instr, model_id=%u, stream_id=%hu, task_id=%hu",
                   modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
        }
    }
    return;
}

void SetResultForModelExecuteTask(TaskInfo * const taskInfo, const void * const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    const uint32_t *const tsData = static_cast<const uint32_t *>(data);
    const uint32_t payLoad = *tsData;
    const uint32_t highTaskId = *(tsData + 1U);
    const uint32_t streamIdEx = *(tsData + 2U);
    taskInfo->errorCode = (payLoad & 0xFFFU);
    modelExecuteTaskInfo->errorTaskId = ((payLoad >> 22U) & 0x3FFU) | (highTaskId << 10U);
    modelExecuteTaskInfo->errorStreamId =
        ((payLoad >> 12U) & 0x3FFU) | (streamIdEx << (static_cast<uint32_t>(RT_STREAM_ID_OFFSET)));

    RT_LOG(RT_LOG_DEBUG, "Payload=%u, highTaskId=%u, errorCode=0x%x, errorTaskId=%u, errorStreamId=%u.",
        payLoad, highTaskId, taskInfo->errorCode, modelExecuteTaskInfo->errorTaskId,
        modelExecuteTaskInfo->errorStreamId);
}

void ToCommandBodyForModelExecuteTask(TaskInfo * const taskInfo, rtCommand_t * const command)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.modelExecuteTask.model_id = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);
    command->u.modelExecuteTask.first_task_id = static_cast<uint16_t>(modelExecuteTaskInfo->firstTaskId);
    command->u.modelExecuteTask.asid = static_cast<uint16_t>((stream->Device_()->GetTTBR_()) >> 48U); // shift 48 bit
    command->u.modelExecuteTask.asid_baddr =
        static_cast<uint64_t>((stream->Device_()->GetTTBR_()) & (0x0000FFFFFFFFFFFFU));
    command->u.modelExecuteTask.SMMU_subStreamID = static_cast<uint16_t>(stream->Device_()->GetSSID_());
    RT_LOG(RT_LOG_DEBUG, "ModelExecute SMMU_subStreamID=%u",
        static_cast<uint32_t>(command->u.modelExecuteTask.SMMU_subStreamID));
    command->u.modelExecuteTask.tcr = stream->Device_()->GetTCR_();
    command->u.modelExecuteTask.sch_group_id = modelExecuteTaskInfo->model->GetSchGroupId();
}

void ConstructSqeForModelExecuteTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.sqeHeader.post_p = 1U;
    sqe.conds_sub_type = CONDS_SUB_TYPE_MODEL_EXEC;
    sqe.reserved1 = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);

    const uint64_t funcAddr = modelExecuteTaskInfo->model->GetFuncCallSvmMem();
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsModelExeFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "ModelExecuteTask");
    RT_LOG(RT_LOG_INFO, "ModelExecuteTask stream_id=%d task_id=%hu, model_id=%hu.",
        stream->Id_(), taskInfo->id, sqe.reserved1);
}

void PrintErrorModelExecuteTaskFuncCall(TaskInfo *const task)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(task->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    if (model->GetFuncCallSvmMem() == 0ULL) {
        RT_LOG(RT_LOG_ERROR, "FuncCallSvmMem is nullptr.");
        return;
    }
    RT_LOG(RT_LOG_ERROR, "funcCallSvmMem=0x%llx, funCallMemSize=%u.", model->GetFuncCallSvmMem(), model->GetFunCallMemSize());
    uint8_t *starsModelExefuncCall = new (std::nothrow) uint8_t[model->GetFunCallMemSize()];
    COND_RETURN_VOID(starsModelExefuncCall == nullptr, "FuncCall data malloc failed, funCallMemSize=%u.",
        model->GetFunCallMemSize());
    const auto ret = task->stream->Device_()->Driver_()->MemCopySync(starsModelExefuncCall,
        model->GetFunCallMemSize(),
        reinterpret_cast<void *>(model->GetFuncCallSvmMem()),
        model->GetFunCallMemSize(),
        RT_MEMCPY_DEVICE_TO_HOST);
    if (ret == RT_ERROR_NONE) {
        const uint32_t *cmd = reinterpret_cast<const uint32_t *>(starsModelExefuncCall);
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeFuncCall) / sizeof(uint32_t)); i += 8UL) {
            RT_LOG(RT_LOG_ERROR,
                "FuncCall data : %08x %08x %08x %08x %08x %08x %08x %08x",
                *(cmd + i), *(cmd + i + 1U), *(cmd + i + 2U), *(cmd + i + 3U),
                *(cmd + i + 4U), *(cmd + i + 5U), *(cmd + i + 6U), *(cmd + i + 7U));
        }
    }
    delete[] starsModelExefuncCall;

    return;
}

void PrintErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    if (stream->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(dfx, sizeof(dfx),
            modelExecuteTaskInfo->model->GetDfxPtr(), sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(RT_LOG_ERROR, "stream_id=%u, task_id=%u, sqVirtualAddr=%" PRIu64 ", head equal tail flag=%" PRIu64 ".",
                streamId, taskId, dfx[0U], dfx[1U]);

        PrintErrorModelExecuteTaskFuncCall(taskInfo);
    }

    RT_LOG(RT_LOG_ERROR,
        "model execute task failed, device_id=%u, model stream_id=%d, model task_id=%u, flip_num=%hu, "
        "model_id=%u, first_task_id=%u", devId, streamId, taskId,
        taskInfo->flipNum, modelExecuteTaskInfo->modelId, modelExecuteTaskInfo->firstTaskId);
}

TaskInfo *GetRealReportFaultTaskForModelExecuteTask(TaskInfo * const taskInfo)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    Device *const dev = stream->Device_();

    TaskInfo *taskPtr = GetTaskInfo(dev, modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId);
    return taskPtr;
}

void ReportErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;
    const uint32_t errorCode = taskInfo->errorCode;

    if ((errorCode == TS_ERROR_END_OF_SEQUENCE) ||
        (errorCode == TS_MODEL_ABORT_NORMAL) ||
        (errorCode == TS_ERROR_MODEL_ABORTED)) {
        return;
    }
    rtError_t rtErrCode = RT_ERROR_TSFW_RESERVED;
    RT_LOG(RT_LOG_ERROR, "model execute error, retCode=%#x, [%s].",
           errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
    PrintErrorInfo(taskInfo, devId);

    TaskInfo *taskPtr = GetRealReportFaultTaskForModelExecuteTask(taskInfo);

    COND_RETURN_VOID(taskPtr == nullptr,
                     "Can not find task_id=%u of stream_id=%u!",
                     modelExecuteTaskInfo->errorTaskId,
                     modelExecuteTaskInfo->errorStreamId);
    RT_LOG(RT_LOG_ERROR, "Real fault task, device_id=%u, stream_id=%d, task_id=%hu, type=%d[%s].",
        taskPtr->stream->Device_()->Id_(), taskPtr->stream->Id_(), taskPtr->id, taskPtr->type, taskPtr->typeName);

    if (unlikely(taskPtr->type == TS_TASK_TYPE_FFTS_PLUS)) {
        taskPtr->errorCode = errorCode;
        PrintErrorInfo(taskPtr, devId);
        return;
    }

    taskPtr->errorCode = errorCode;
    PrintErrorInfo(taskPtr, devId);
    // if lost socket, set error code for GE handle this error
    if (unlikely((taskPtr->drvErr == static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE))) ||
        (taskInfo->drvErr == static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE))) {
        RT_LOG(RT_LOG_ERROR,
            "Set stream drv error, error stream_id=%u, task_id=%u, model stream_id=%d, task_id=%hu, "
            "task driver error=%#x, ModelExecuteTask driver error=%#x.",
            modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId,
            static_cast<uint32_t>(stream->Id_()),
            taskInfo->id, taskPtr->drvErr, taskInfo->drvErr);
        stream->SetDrvErr(static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE));
    }
    TaskFailCallBack(modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId,
        taskInfo->tid, errorCode, stream->Device_());
}

void DoCompleteSuccessForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        TaskInfo *errTaskPtr = GetRealReportFaultTaskForModelExecuteTask(taskInfo);
        if (errTaskPtr != nullptr) {
            if (MEM_ERROR_CODE.find(errTaskPtr->mte_error) != MEM_ERROR_CODE.end()) {
                errorCode = static_cast<int32_t>(errTaskPtr->mte_error);
                errTaskPtr->mte_error = 0U;
            }
        }
        stream->SetErrCode(errorCode);
        ReportErrorInfoForModelExecuteTask(taskInfo, devId);
    }
    if ((!Runtime::Instance()->GetDisableThread()) && (modelExecuteTaskInfo->model != nullptr)) {
        modelExecuteTaskInfo->model->ExecuteComplete();
    }
}

static void ModelExecuteTaskaProcError(TaskInfo * const taskInfo, const uint32_t errCode)
{
    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.value = errCode;
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_STREAM_EXE_FAILED)) {
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) {
        taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) {
        taskInfo->errorCode = TS_ERROR_MODEL_ABORTED;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT)) {
        taskInfo->errorCode = TS_ERROR_AICPU_TIMEOUT;
    } else {
        // others model exe rsult does not support, default stream exe failed
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    modelExecuteTaskInfo->errorTaskId = swStatus.model_exec.task_id;
    modelExecuteTaskInfo->errorStreamId = swStatus.model_exec.stream_id;
    RT_LOG(RT_LOG_WARNING, "errorCode=0x%x, errorTaskId=%u, errorStreamId=%u.",
        taskInfo->errorCode, modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId);
}

static void ModelExecuteTaskProcErrorForSoftwareSq(TaskInfo * const taskInfo, const uint32_t errCode)
{
    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.value = errCode;
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_STREAM_EXE_FAILED)) {
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) {
        taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) {
        taskInfo->errorCode = TS_ERROR_MODEL_ABORTED;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT)) {
        taskInfo->errorCode = TS_ERROR_AICPU_TIMEOUT;
    } else {
        // others model exe rsult does not support, default stream exe failed
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    modelExecuteTaskInfo->errorTaskId = swStatus.model_exec_ex.task_id;
    modelExecuteTaskInfo->errorStreamId = modelExecuteTaskInfo->model->GetStreamIdBySqId(swStatus.model_exec_ex.sq_id);
    RT_LOG(RT_LOG_WARNING, "errorCode=0x%x, errorTaskId=%u, errorStreamId=%u, sqId=%hu.",
        taskInfo->errorCode, modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId,
        swStatus.model_exec_ex.sq_id);
}

static void DoCompleteStarsErrorForModelExecuteTask(TaskInfo * const taskInfo,
                                                    const uint32_t devId, const uint32_t errCode)
{
    /* 71 and 81 support */
    Device *const dev = taskInfo->stream->Device_();
    if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) && 
        (dev->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE))) {
        ModelExecuteTaskProcErrorForSoftwareSq(taskInfo, errCode);
    } else {
        ModelExecuteTaskaProcError(taskInfo, errCode);
    }
    DoCompleteSuccessForModelExecuteTask(taskInfo, devId);
}

rtError_t WaitExecFinishForModelExecuteTask(const TaskInfo *const taskInfo)
{
    Stream * const stream = taskInfo->stream;
    rtError_t error = RT_ERROR_NONE;
    if (!(stream->IsPendingListEmpty(RT_HOST_TASK_TYPE_MEMCPY))) {
        error = stream->ExecPendingList(RT_HOST_TASK_TYPE_MEMCPY);
    }
    return error;
}

static bool ModelIsExistInContext(const Model *mdl, const Stream *stream)
{
    if (stream != nullptr && stream->Context_() != nullptr) {
        Context *context = stream->Context_();
        return context->ModelIsExistInContext(mdl);
    }
    return false;
}

void ReportModelEndGraphErrorForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId)
{
    if (!Runtime::Instance()->ChipIsHaveStars()) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "Report model endGraph errcode=0x%x.", taskInfo->errorCode);
    Model *mdl = taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel();
    if (!ModelIsExistInContext(mdl, taskInfo->stream)) {
        RT_LOG(RT_LOG_ERROR, "this model is not in current context.");
        return;
    }
    TaskInfo mdlExecTsk = {};
    InitByStream(&mdlExecTsk, taskInfo->stream);
    /* In stars, modelExecute task is always followed by an endgraph task, modelExecuteTaskId = endgraphTaskId - 1 */
    mdlExecTsk.id = taskInfo->id - 1U;
    (void)ModelExecuteTaskInit(&mdlExecTsk, mdl, mdl->Id_(), 0U);
    (void)DoCompleteStarsErrorForModelExecuteTask(&mdlExecTsk, devId, taskInfo->errorCode);
    ModelExecuteTaskUnInit(&mdlExecTsk);
}

#endif
}  // namespace runtime
}  // namespace cce
