/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "model_execute_task.h"
#include "stub_task.hpp"
#include "capture_model_utils.hpp"
#include "capture_model.hpp"
#include "cond_op_manager.hpp"

namespace cce {
namespace runtime {

// save func data to host memory
static rtError_t SaveFuncCallDataForModelExecuteTask(
    TaskInfo* const taskInfo, const std::vector<uint64_t>& headSq, const std::vector<uint64_t>& streamSvmAddr)
{
    const size_t headSqArrMax = headSq.size();
    const size_t streamSvmArrMax = streamSvmAddr.size();
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    uint8_t* dstMem = RtPtrToPtr<uint8_t*>(modelExecuteTaskInfo->model->GetFuncCallHostMem()) +
                      modelExecuteTaskInfo->model->GetFuncCallInstrSize();

    rtError_t ret =
        memcpy_s(dstMem, (headSqArrMax * sizeof(uint64_t)), headSq.data(), (headSqArrMax * sizeof(uint64_t)));
    COND_RETURN_ERROR_MSG_CALL(
        ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy headSq.data(), src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.",
        headSq.data(), dstMem, headSqArrMax * sizeof(uint64_t), headSqArrMax * sizeof(uint64_t), ret);

    dstMem = dstMem + headSqArrMax * sizeof(uint64_t);
    ret = memcpy_s(
        dstMem, (streamSvmArrMax * sizeof(uint64_t)), streamSvmAddr.data(), (streamSvmArrMax * sizeof(uint64_t)));
    COND_RETURN_ERROR_MSG_CALL(
        ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy streamSvmAddr.data(), src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.",
        streamSvmAddr.data(), dstMem, streamSvmArrMax * sizeof(uint64_t), streamSvmArrMax * sizeof(uint64_t), ret);
    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallHostMemAndSvmMem(TaskInfo* const taskInfo)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    if ((model == nullptr) || (model->Context_() == nullptr)) {
        return RT_ERROR_NONE;
    }
    Device* const dev = model->Context_()->Device_();
    Driver* const deviceDrv = dev->Driver_();

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

static rtError_t DfxCombineFuncCallDevMemAlloc(Model* model, TaskInfo* const taskInfo)
{
    rtError_t ret;
    void* devMem = nullptr;
    void* dfxPtr = nullptr;
    Stream* const stream = taskInfo->stream;
    const Device* dev = stream->Device_();
    const uint64_t allocSize =
        model->GetFunCallMemSize() + TS_STARS_COND_DFX_SIZE + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(
            RT_LOG_ERROR, "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u", ret,
            model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }

    model->SetBaseFuncCallSvmMem(devMem);
    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void*>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void*>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void*, const uintptr_t>(devMemAlign);
    }
    model->SetFuncCallSvmMem(RtPtrToValue<const void*>(devMem));

    dfxPtr = RtValueToPtr<void*>(model->GetFuncCallSvmMem() + model->GetFunCallMemSize());
    model->SetDfxPtr(dfxPtr);
    return RT_ERROR_NONE;
}

static rtError_t DfxSplitFuncCallDevMemAlloc(Model* model, TaskInfo* const taskInfo)
{
    rtError_t ret;
    void* devMem = nullptr;
    void* devMemDfx = nullptr;
    Stream* const stream = taskInfo->stream;
    const Device* dev = stream->Device_();
    constexpr bool readonly = true;
    uint64_t allocSize = model->GetFunCallMemSize() + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    // alloc funcCall devMem which is readonly.
    ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_(), MODULEID_RUNTIME, true, readonly);
    if ((ret != RT_ERROR_NONE) || (devMem == nullptr)) {
        RT_LOG(
            RT_LOG_ERROR, "alloc funcCall memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u", ret,
            model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }
    // alloc funcCall devMem for dfx, cannot use readonly and need align.
    allocSize = TS_STARS_COND_DFX_SIZE + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    ret = dev->Driver_()->DevMemAlloc(&devMemDfx, allocSize, RT_MEMORY_DDR, dev->Id_());
    if ((ret != RT_ERROR_NONE) || (devMemDfx == nullptr)) {
        (void)dev->Driver_()->DevMemFree(devMem, dev->Id_());
        devMem = nullptr;
        RT_LOG(
            RT_LOG_ERROR, "alloc funcCall dfx memory failed, retCode=%#x, size=%" PRIu64 "(bytes), device_id=%u", ret,
            model->GetFunCallMemSize(), dev->Id_());
        return ret;
    }

    model->SetBaseFuncCallSvmMem(devMem);
    // instr addr should align to 256b
    if ((RtPtrToPtr<uintptr_t, void*>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t, void*>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void*, const uintptr_t>(devMemAlign);
    }
    model->SetFuncCallSvmMem(RtPtrToValue<const void*>(devMem));

    model->SetFuncCallDfxBaseSvmMem(devMemDfx);
    if ((RtPtrToPtr<uintptr_t, void*>(devMemDfx) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemDfxAlign = (((RtPtrToPtr<uintptr_t, void*>(devMemDfx)) >> 8U) + 1UL) << 8U;
        devMemDfx = RtPtrToPtr<void*, const uintptr_t>(devMemDfxAlign);
    }
    model->SetDfxPtr(devMemDfx);

    return RT_ERROR_NONE;
}

rtError_t AllocFuncCallMemForModelExecuteTask(TaskInfo* const taskInfo, rtStarsModelExeFuncCallPara_t& funcCallPara)
{
    // aclgraph重新分配sq后需要重新构造FuncCallPara，headSqArrMax有可能改变，需要释放后重新申请内存
    (void)FreeFuncCallHostMemAndSvmMem(taskInfo);

    std::vector<uint64_t> headSqArr;
    std::vector<uint64_t> streamSvmAddrArr;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;

    std::list<Stream*> const headStmList = model->GetHeadStreamList_();
    for (Stream* const stm : headStmList) {
        (void)headSqArr.emplace_back(stm->GetSqId());
        (void)streamSvmAddrArr.emplace_back(RtPtrToValue(stm->GetExecutedTimesSvm()));

        RT_LOG(RT_LOG_INFO, "stream_id:%d, sq_id:%u.", stm->Id_(), stm->GetSqId());
    }

    const uint64_t headSqArrMax = headSqArr.size();
    const uint64_t streamSvmArrMax = streamSvmAddrArr.size();
    COND_RETURN_ERROR_MSG_INNER(
        (headSqArrMax == 0ULL), RT_ERROR_MODEL_EXECUTOR,
        "The head stream of the model does not have the corresponding SQ ID, headSqArrMax=%" PRIu64 ".", headSqArrMax);

    const uint64_t funCallMemSize =
        funcCallPara.funcCallInstrSize + (headSqArrMax + streamSvmArrMax) * sizeof(uint64_t);
    model->SetFunCallMemSize(funCallMemSize);
    model->SetFuncCallInstrSize(funcCallPara.funcCallInstrSize);
    model->SetFuncCallHostMem(malloc(funCallMemSize));
    COND_RETURN_AND_MSG_OUTER(
        model->GetFuncCallHostMem() == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, funCallMemSize,
        "malloc");

    RT_LOG(
        RT_LOG_INFO, "funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64, model->GetFuncCallHostMem(),
        model->GetFunCallMemSize());

    // save data to funcCallHostMem
    rtError_t ret = SaveFuncCallDataForModelExecuteTask(taskInfo, headSqArr, streamSvmAddrArr);
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
    funcCallPara.headSqArrAddr = funcCallPara.funcCallAddr + funcCallPara.funcCallInstrSize;
    funcCallPara.streamSvmArrAddr = funcCallPara.headSqArrAddr + (headSqArrMax * sizeof(uint64_t));
    funcCallPara.headSqArrMax = headSqArrMax;
    funcCallPara.streamSvmArrMax = streamSvmArrMax;

    RT_LOG(
        RT_LOG_DEBUG,
        "first execute. funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64 ", funcCallSvmMem=%#" PRIx64
        ", baseFuncCallSvmMem=%#" PRIx64 ", dfxAddr=%#" PRIx64,
        model->GetFuncCallHostMem(), model->GetFunCallMemSize(), model->GetFuncCallSvmMem(),
        model->GetBaseFuncCallSvmMem(), model->GetDfxPtr());

    return RT_ERROR_NONE;
}

rtError_t ConstructFuncCallParaForModelExecuteTask(
    TaskInfo* const taskInfo, rtStarsModelExeFuncCallPara_t& funcCallPara)
{
    Stream* const stream = taskInfo->stream;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    RtStarsModelExeFuncCall funcCall = {};
    funcCallPara.deltaOffset = 0ULL;
    funcCallPara.isCondTaskModelExec = false;
    funcCallPara.funcCallInstrSize = sizeof(funcCall);
    funcCallPara.checkSqStateInstrSize = sizeof(funcCall.checkSqFsm);
    funcCallPara.checkSqFsmInstrDistance = RtPtrToValue(&(funcCall.checkSqFsm.lhwi0)) - RtPtrToValue(&funcCall);
    funcCallPara.endInstrDistance = RtPtrToValue(&(funcCall.endInstr.nop)) - RtPtrToValue(&funcCall);
    funcCallPara.checkSqDisableErrInstrDistance =
        RtPtrToValue(&(funcCall.checkSqDisableErrInstr.lhwi0)) - RtPtrToValue(&funcCall);
    funcCallPara.checkSqHeadTailErrInstrDistance =
        RtPtrToValue(&(funcCall.checkSqHeadTailErrInstr.lhwi0)) - RtPtrToValue(&funcCall);
    funcCallPara.scanSqInstrDistance =
        RtPtrToValue(&(funcCall.scanSq.u.rootModelAdapt.lhwi1)) - RtPtrToValue(&funcCall);
    funcCallPara.errInstrDistance = RtPtrToValue(&(funcCall.errInstr.err)) - RtPtrToValue(&funcCall);
    funcCallPara.deactiveSqGotoRInstrDistance = RtPtrToValue(&(funcCall.deactiveSq.gotoR)) - RtPtrToValue(&funcCall);
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
        const uint64_t dieOffset = taskInfo->stream->Device_()->GetDieOffset();
        funcCallPara.sqFsmSelBasAddr = funcCallPara.sqFsmSelBasAddr +
                                       (chipOffset * static_cast<uint64_t>(stream->Device_()->GetPhyChipId())) +
                                       (dieOffset * static_cast<uint64_t>(stream->Device_()->GetPhyDieId())) + chipAddr;
    }
    if (props.starsBaseMethod == StarsBaseMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
        const uint64_t baseAddr = taskInfo->stream->Device_()->GetStarsRegBaseAddr();
        RT_LOG(RT_LOG_INFO, "baseAddr=0x%llx", baseAddr);
        if (baseAddr == 0ULL) {
            RT_LOG(
                RT_LOG_ERROR, "invalid device_id, physic chip_id=%u, die_id=%u, stream_id=%d.",
                taskInfo->stream->Device_()->Id_(), taskInfo->stream->Device_()->GetPhyChipId(),
                taskInfo->stream->Device_()->GetPhyDieId(), taskInfo->stream->Id_());
            return RT_ERROR_DEVICE_INVALID;
        }
        funcCallPara.sqFsmSelBasAddr = baseAddr + DAVID_SIMPLE_RTSQ_FSM_SEL_REG;
    }
    funcCallPara.sqVirtualAddr = RtPtrToValue(stream->Device_()->GetSqVirtualArrBaseAddr_());
    funcCallPara.dfxAddr = RtPtrToValue(modelExecuteTaskInfo->model->GetDfxPtr());
    return RT_ERROR_NONE;
}

static void PrintDebugInfoForModelExecute(const Model* model, size_t funcCallSize)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        const uint32_t* const cmdF = RtPtrToPtr<const uint32_t*>(model->GetFuncCallHostMem());
        for (size_t i = 0UL; i < (funcCallSize / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute before h2d instr[%zu]=0x%08x", i, *(cmdF + i));
        }

        const uint64_t* const cmdS =
            RtPtrToPtr<const uint64_t*>(RtPtrToPtr<uint8_t*>(model->GetFuncCallHostMem()) + funcCallSize);
        for (size_t i = 0UL; i < ((model->GetFunCallMemSize() - funcCallSize) / sizeof(uint64_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute before h2d sq data[%zu]=%#" PRIx64, i, *(cmdS + i));
        }
    }
}

static rtError_t FuncCallSvmMemCopy(const Device* const dev, const Model* const model)
{
    rtError_t error = RT_ERROR_NONE;
    Driver* const drv = dev->Driver_();
    const uint32_t devId = dev->Id_();
    const bool needAdvise =
        dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_SPLIT_FUNC_CALL) &&
        dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_TS_COMMON_CPU);
    const rtMemcpyKind_t kind = dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY) ?
                                    RT_MEMCPY_DEVICE_TO_DEVICE :
                                    RT_MEMCPY_HOST_TO_DEVICE;
    void* const dst = RtValueToPtr<void*>(model->GetFuncCallSvmMem());
    const uint64_t size = model->GetFunCallMemSize();
    void* const adviseAddr = model->GetBaseFuncCallSvmMem();
    const uint64_t adviseSize = size + static_cast<uint64_t>(FUNC_CALL_INSTR_ALIGN_SIZE);
    error = BinaryMemAdvise(adviseAddr, adviseSize, RT_ADVISE_ACCESS_READWRITE, dev, needAdvise);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = drv->MemCopySync(dst, size, model->GetFuncCallHostMem(), size, kind);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Memcpy failed, size=%" PRIu64 "(bytes), type=%d, retCode=%#x, device_id=%u.",
        size, kind, static_cast<uint32_t>(error), devId);
    error = BinaryMemAdvise(adviseAddr, adviseSize, RT_ADVISE_ACCESS_READONLY, dev, needAdvise);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return RT_ERROR_NONE;
}

static rtError_t PrepareModelExecuteFuncCallDefault(TaskInfo* const taskInfo)
{
    rtError_t ret;
    Model* const model = taskInfo->u.modelExecuteTaskInfo.model;
    RtStarsModelExeFuncCall funcCall = {};
    rtStarsModelExeFuncCallPara_t funcCallPara = {};
    ret = ConstructFuncCallParaForModelExecuteTask(taskInfo, funcCallPara);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "construct func call para failed, retCode=%#x.", ret);

    RT_LOG(
        RT_LOG_DEBUG,
        "Func call para, funcCallAddr=%#" PRIx64 ", headSqArrAddr=%#" PRIx64 ", headSqArrMax=%#" PRIx64
        ", streamSvmArrAddr=%#" PRIx64 ", streamSvmArrMax=%#" PRIx64 ", sqFsmSelBasAddr=%#" PRIx64
        ", dfxAddr=%#" PRIx64,
        funcCallPara.funcCallAddr, funcCallPara.headSqArrAddr, funcCallPara.headSqArrMax, funcCallPara.streamSvmArrAddr,
        funcCallPara.streamSvmArrMax, funcCallPara.sqFsmSelBasAddr, funcCallPara.dfxAddr);

    ConstrucModelExeFuncCall(funcCallPara, funcCall);
    ret = memcpy_s(
        model->GetFuncCallHostMem(), sizeof(RtStarsModelExeFuncCall), reinterpret_cast<void*>(&funcCall),
        sizeof(RtStarsModelExeFuncCall));
    COND_PROC_RETURN_ERROR_MSG_INNER(
        ret != EOK, RT_ERROR_SEC_HANDLE, (void)FreeFuncCallHostMemAndSvmMem(taskInfo),
        "Failed to call memcpy_s to copy funcCall, src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.",
        RtPtrToPtr<void*>(&funcCall), model->GetFuncCallHostMem(), sizeof(RtStarsModelExeFuncCall),
        sizeof(RtStarsModelExeFuncCall), ret);
    return ret;
}

rtError_t PrepareSqeInfoForModelExecuteTask(TaskInfo* const taskInfo)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    Stream* const stream = taskInfo->stream;
    const auto dev = stream->Device_();

    if (!stream->Device_()->IsStarsPlatform()) {
        return RT_ERROR_NONE;
    }
    rtError_t ret = RT_ERROR_NONE;
    if (unlikely(model->GetFirstExecute())) {
        std::unique_lock<std::mutex> lock(model->GetFirstExecuteMutex());
        if (model->GetFirstExecute()) {
            const CondIsaTaskFuncs* const funcs = GetCurrentCondIsaTaskFuncs();
            ret = ((funcs != nullptr) && (funcs->prepareModelExecuteFuncCall != nullptr)) ?
                      funcs->prepareModelExecuteFuncCall(taskInfo) :
                      PrepareModelExecuteFuncCallDefault(taskInfo);
            COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
            RT_LOG(RT_LOG_DEBUG, "model first execute.funcCallHostMem=%#" PRIx64, model->GetFuncCallHostMem());

            ret = FuncCallSvmMemCopy(dev, model);
            PrintDebugInfoForModelExecute(model, model->GetFuncCallInstrSize());
            if (ret != RT_ERROR_NONE) {
                (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
                RT_LOG(RT_LOG_ERROR, "MemCopySync for model exe func call failed, retCode=%#x.", ret);
            } else {
                model->SetFirstExecute(false);
            }
        }
    } else {
        if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE)) {
            ret = (dev->Driver_())
                      ->MemCopySync(
                          RtValueToPtr<void*>(model->GetFuncCallSvmMem()), model->GetFunCallMemSize(),
                          model->GetFuncCallHostMem(), model->GetFunCallMemSize(), RT_MEMCPY_DEVICE_TO_DEVICE);
            if (ret != RT_ERROR_NONE) {
                (void)FreeFuncCallHostMemAndSvmMem(taskInfo);
                RT_LOG(
                    RT_LOG_ERROR, "MemCopySync for model exe func call failed without first execute, retCode=%#x.",
                    ret);
                return ret;
            }
        }
        RT_LOG(
            RT_LOG_DEBUG,
            "not model first execute, funcCallHostMem=%#" PRIx64 ", funCallMemSize=%#" PRIx64
            ", funcCallSvmMem=%#" PRIx64 ", baseFuncCallSvmMem=%#" PRIx64 ", dfxAddr=%#" PRIx64,
            model->GetFuncCallHostMem(), model->GetFunCallMemSize(), model->GetFuncCallSvmMem(),
            model->GetBaseFuncCallSvmMem(), model->GetDfxPtr());
    }

    return ret;
}

void PrintErrorModelExecuteTaskFuncCall(TaskInfo* const task)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(task->u.modelExecuteTaskInfo);
    Model* model = modelExecuteTaskInfo->model;
    if (model->GetFuncCallSvmMem() == 0ULL) {
        RT_LOG(RT_LOG_ERROR, "FuncCallSvmMem is nullptr.");
        return;
    }
    RT_LOG(
        RT_LOG_ERROR, "funcCallSvmMem=0x%llx, funCallMemSize=%u.", model->GetFuncCallSvmMem(),
        model->GetFunCallMemSize());
    uint8_t* starsModelExefuncCall = new (std::nothrow) uint8_t[model->GetFunCallMemSize()];
    if (starsModelExefuncCall == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(uint8_t) * (model->GetFunCallMemSize()), "new");
        return;
    }
    const auto ret = task->stream->Device_()->Driver_()->MemCopySync(
        starsModelExefuncCall, model->GetFunCallMemSize(), RtValueToPtr<void*>(model->GetFuncCallSvmMem()),
        model->GetFunCallMemSize(), RT_MEMCPY_DEVICE_TO_HOST);
    if (ret == RT_ERROR_NONE) {
        const uint32_t* cmd = RtPtrToPtr<const uint32_t*>(starsModelExefuncCall);
        for (size_t i = 0UL; i < (model->GetFuncCallInstrSize() / sizeof(uint32_t)); i += 8UL) {
            RT_LOG(
                RT_LOG_ERROR, "FuncCall data : %08x %08x %08x %08x %08x %08x %08x %08x", *(cmd + i), *(cmd + i + 1U),
                *(cmd + i + 2U), *(cmd + i + 3U), *(cmd + i + 4U), *(cmd + i + 5U), *(cmd + i + 6U), *(cmd + i + 7U));
        }
    }
    delete[] starsModelExefuncCall;

    return;
}

} // namespace runtime
} // namespace cce
