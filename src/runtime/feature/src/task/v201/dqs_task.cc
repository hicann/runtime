/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "stream_with_dqs.hpp"
#include "stars_cond_isa_struct.hpp"
#include "error_message_manage.hpp"
#include "dqs_task_info.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_dqs_cond_isa_helper.hpp"
#include "stars_cond_isa_batch_struct.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t dqsPoolIdMask = 0x3FFU;      // pool_id in mbuf handle. bit[9:0]
constexpr uint32_t TS_ID_P = 0x0U;
constexpr uint64_t TS_STARS_SUBSYS_PHY_ADDR_P = 0x580000000ULL;
constexpr uint32_t STARS_CNTNOTIFY_THRESHOLD_DEFAULT_P = 4U;
constexpr uint64_t TS_STARS_REG_OFFSET = 0x20000000ULL;
constexpr uint64_t TS_STARS_CHIP_OFFSET = 0x40000000000ULL;

constexpr uint64_t TS_STARS_SUBSYS_PHY_ADDR_F = 0x20880000000ULL;
constexpr uint32_t STARS_CNTNOTIFY_THRESHOLD_DEFAULT_F = 2U;

constexpr uint32_t STARS_CNTNOTIFY_SLICE_LINE_CNT_ID_NUM = 4U;
constexpr uint32_t STARS_CNTNOTIFY_GROUP_SIZE = 16U;
constexpr uint64_t STARS_CNTNOTIFY_SLICE_CNT_INTERVAL = 0x10000ULL;
constexpr uint64_t STARS_CNTNOTIFY_GROUP_INTERVAL = 0x1000ULL;
constexpr uint32_t STARS_CNTNOTIFY_CNT_ID_INTERVAL = 0x80U;

/* STARS_NOTIFY_CFG Base address of Module's Register */
constexpr uint64_t SOC_STARS_NOTIFY_CFG_BASE = 0x10000000ULL;

constexpr uint64_t SOC_STARS_NOTIFY_CFG_STARS_NOTIFY_CNT_ST_SLICE0_0_REG = SOC_STARS_NOTIFY_CFG_BASE + 0x2000000ULL; 
constexpr uint64_t SOC_STARS_NOTIFY_CFG_STARS_NOTIFY_CNT_BIT_CLR_SLICE0_0_REG = SOC_STARS_NOTIFY_CFG_BASE + 0x2000060ULL; 

static rtError_t InitFuncCallParaForDqsEnqueueTask(TaskInfo* taskInfo, RtStarsDqsFcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");

    uint16_t *const execTimesSvm = stm->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.sqId = static_cast<uint32_t>(stm->GetSqId());

    fcPara.ctrlSpaceAddr = RtPtrToValue(ctrlSpacePtr);
    fcPara.mbufPoolIndexMax = ctrlSpacePtr->output_queue_num;

    size_t offset = offsetof(stars_dqs_ctrl_space_t, output_qmngr_enqueue_addrs);
    fcPara.enqueOpAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_qmngr_ow_addrs);
    fcPara.prodqOwAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_mbuf_list);
    fcPara.ouputMbufHandleAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_mbuf_free_addrs); // 这里使用ctrlSpace地址，是共享内存，内核态做了映射
    fcPara.mbufFreePara.mbufFreeAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    return RT_ERROR_NONE;
}

static inline void InitDqsCommonTaskInfo(
    DqsCommonTaskInfo *const commonTaskInfo, const size_t funCallMemSize, const uint32_t sqId)
{
    commonTaskInfo->funcCallSvmMem = nullptr;
    commonTaskInfo->baseFuncCallSvmMem = nullptr;
    commonTaskInfo->dfxPtr = nullptr;
    commonTaskInfo->funCallMemSize = funCallMemSize;
    commonTaskInfo->sqId = sqId;

    return;
}

static rtError_t AllocDqsCommonTaskFuncCall(DqsCommonTaskInfo* const commonTaskInfo, const TaskInfo* const taskInfo)
{
    void *devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = commonTaskInfo->funCallMemSize + TS_STARS_COND_DFX_SIZE + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "alloc func call memory failed,retCode=%#x,size=%" PRIu64 "(Byte),dev_id=%u",
                      ret, commonTaskInfo->funCallMemSize, dev->Id_());

    commonTaskInfo->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uint64_t devMemAlign = (((RtPtrToValue(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtValueToPtr<void *>(devMemAlign);
    }
    commonTaskInfo->funcCallSvmMem = devMem;
    commonTaskInfo->dfxPtr =
        RtValueToPtr<void *>(RtPtrToValue(commonTaskInfo->funcCallSvmMem) + commonTaskInfo->funCallMemSize);

    return RT_ERROR_NONE;
}

static rtError_t FreeDqsCommonTaskFuncCall(DqsCommonTaskInfo* const commonTaskInfo, const TaskInfo* const taskInfo)
{
    if (commonTaskInfo->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        const rtError_t ret = dev->Driver_()->DevMemFree(commonTaskInfo->baseFuncCallSvmMem, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free func call mem failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        commonTaskInfo->baseFuncCallSvmMem = nullptr;
        commonTaskInfo->dfxPtr = nullptr;
        commonTaskInfo->funcCallSvmMem = nullptr;
    }

    commonTaskInfo->funCallMemSize = 0UL;
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsEnqueueTask(TaskInfo* taskInfo)
{
    RtStarsDqsFcPara fcPara = {};
    rtError_t ret = InitFuncCallParaForDqsEnqueueTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed,retCode=%#x.", ret);
    DqsCommonTaskInfo *dqsEnqueueTask = &(taskInfo->u.dqsEnqueueTask);
    ret = AllocDqsCommonTaskFuncCall(dqsEnqueueTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
    fcPara.dfxAddr = RtPtrToValue(dqsEnqueueTask->dfxPtr);
    RtStarsDqsEnqueueFc fc = {};
    ConstructDqsEnqueueFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(dqsEnqueueTask->funcCallSvmMem, dqsEnqueueTask->funCallMemSize, &fc,
        dqsEnqueueTask->funCallMemSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsEnqueueTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs Enqueue func call failed,retCode=%#x.", ret);
    }
 
    return ret;
}

static rtError_t InitFuncCallParaForDqsDequeueTask(TaskInfo* taskInfo, RtStarsDqsFcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");

    uint16_t *const execTimesSvm = stm->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.sqId = static_cast<uint32_t>(stm->GetSqId());

    fcPara.ctrlSpaceAddr = RtPtrToValue(ctrlSpacePtr);

    size_t offset = offsetof(stars_dqs_ctrl_space_t, input_mbuf_list);
    fcPara.inputMbufHandleAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, input_queue_gqm_base_addrs);
    fcPara.gqmAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    RT_LOG(RT_LOG_INFO,"gqmAddr=%#llx, inputMbufHandleAddr=%#llx", fcPara.gqmAddr, fcPara.inputMbufHandleAddr);

    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsDequeueTask(TaskInfo* taskInfo)
{
    RtStarsDqsFcPara fcPara = {};
    rtError_t ret = InitFuncCallParaForDqsDequeueTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed,retCode=%#x.", ret);
    DqsCommonTaskInfo *dqsDequeueTask = &(taskInfo->u.dqsDequeueTask);
    ret = AllocDqsCommonTaskFuncCall(dqsDequeueTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
    fcPara.dfxAddr = RtPtrToValue(dqsDequeueTask->dfxPtr);
    RtStarsDqsDequeueFc fc = {};
    ConstructDqsDequeueFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(dqsDequeueTask->funcCallSvmMem, dqsDequeueTask->funCallMemSize, &fc,
        dqsDequeueTask->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsDequeueTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs Dequeue func call failed,retCode=%#x.", ret);
    }

    return ret;
}

static uint64_t GetNotifyRecordBaseAddr(const StreamWithDqs *stm, uint32_t notifyId, uint32_t tsId)
{
    int32_t chipId = 0;
    rtError_t ret = stm->Device_()->Driver_()->GetCentreNotify(6, &chipId); /* index 6可以获取chipid */
    if (ret != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,"Get board info fail, retCode=%#x", ret);
        return 0x0ULL;
    }
    RT_LOG(RT_LOG_INFO,"Get board info success. (chipId=%u)", chipId);

    uint64_t starsRegBaseAddr = (tsId == TS_ID_P) ? TS_STARS_SUBSYS_PHY_ADDR_P : TS_STARS_SUBSYS_PHY_ADDR_F;
    starsRegBaseAddr = starsRegBaseAddr + static_cast<uint64_t>(chipId) * TS_STARS_CHIP_OFFSET + TS_STARS_REG_OFFSET;
    const uint32_t threshold = (tsId == 0U) ? STARS_CNTNOTIFY_THRESHOLD_DEFAULT_P : STARS_CNTNOTIFY_THRESHOLD_DEFAULT_F;
    const uint32_t notifyNumPerSlice = threshold * STARS_CNTNOTIFY_SLICE_LINE_CNT_ID_NUM;
    // calculate notify record addr by slice and group
    const uint32_t sliceId = notifyId / notifyNumPerSlice;
    // group isolated by 4KB
    const uint32_t groupId = (notifyId % notifyNumPerSlice) / STARS_CNTNOTIFY_GROUP_SIZE;
    const uint32_t groupOffset = (notifyId % notifyNumPerSlice) % STARS_CNTNOTIFY_GROUP_SIZE;

    return starsRegBaseAddr + static_cast<uint64_t>(sliceId) * STARS_CNTNOTIFY_SLICE_CNT_INTERVAL +
        static_cast<uint64_t>(groupId) * STARS_CNTNOTIFY_GROUP_INTERVAL +
        static_cast<uint64_t>(groupOffset) * STARS_CNTNOTIFY_CNT_ID_INTERVAL;
}

static uint64_t GetNotifyRecordAddr(bool isRead, const StreamWithDqs *stm)
{
    uint64_t offset = 0;
    if (isRead) {
        offset = SOC_STARS_NOTIFY_CFG_STARS_NOTIFY_CNT_ST_SLICE0_0_REG;
    } else { /* 清零的标记位 */
        offset = SOC_STARS_NOTIFY_CFG_STARS_NOTIFY_CNT_BIT_CLR_SLICE0_0_REG;
    }

    const CountNotify *notify = stm->GetDqsCountNotify();
    NULL_PTR_RETURN_MSG(notify, RT_ERROR_NOTIFY_NULL);

    const uint32_t notifyId = notify->GetCntNotifyId();
    const uint32_t tsId = notify->GetTsId();

    const uint64_t baseAddr = GetNotifyRecordBaseAddr(stm, notifyId, tsId);
    if (baseAddr == 0x0ULL) {
        return 0x0ULL;
    }

    return baseAddr + offset;
}

static rtError_t InitFuncCallParaForDqsBatchDequeueTask(TaskInfo* taskInfo, RtStarsDqsBatchDeqFcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");
    fcPara.dfxAddr = 0x0ULL;
    fcPara.gqmAddr = RtPtrToValue(ctrlSpacePtr->input_queue_gqm_base_addrs);
    fcPara.inputMbufHandleAddr = RtPtrToValue(ctrlSpacePtr->input_mbuf_cache_list);
    fcPara.mbufFreeAddr = RtPtrToValue(ctrlSpacePtr->input_mbuf_free_addrs);

    fcPara.cntNotifyReadAddr = GetNotifyRecordAddr(true, stm);
    fcPara.cntNotifyClearAddr = GetNotifyRecordAddr(false, stm);
    if ((fcPara.cntNotifyReadAddr == 0x0ULL) || (fcPara.cntNotifyClearAddr == 0x0ULL)) {
        return RT_ERROR_NOTIFY_BASE;
    }
    fcPara.sqId = static_cast<uint32_t>(stm->GetSqId());

    fcPara.cntOffset = static_cast<uint8_t>(offsetof(input_mbuf_cache_t, cnt));
    fcPara.sizeofHandleCache = static_cast<uint8_t>(sizeof(input_mbuf_cache_t));

    fcPara.mbufPoolIndexMax = static_cast<uint16_t>(ctrlSpacePtr->input_queue_num);

    RT_LOG(RT_LOG_INFO,"gqmAddr=%#llx, inputMbufHandleAddr=%#llx cntNotifyReadAddr=%#llx cntNotifyClearAddr=%#llx mbufFreeAddr=%#llx",
        fcPara.gqmAddr, fcPara.inputMbufHandleAddr, fcPara.cntNotifyReadAddr, fcPara.cntNotifyClearAddr, fcPara.mbufFreeAddr);

    RT_LOG(RT_LOG_INFO,"sqId=%#llx, cntOffset=%#llx sizeofHandleCache=%#llx mbufPoolIndexMax=%#llx",
        fcPara.sqId, fcPara.cntOffset, fcPara.sizeofHandleCache, fcPara.mbufPoolIndexMax);

    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsBatchDequeueTask(TaskInfo* taskInfo)
{
    RtStarsDqsBatchDeqFcPara fcPara = {};
    rtError_t ret = InitFuncCallParaForDqsBatchDequeueTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed,retCode=%#x.", ret);
    DqsCommonTaskInfo *dqsBatchDequeueTask = &(taskInfo->u.dqsBatchDequeueTask);
    ret = AllocDqsCommonTaskFuncCall(dqsBatchDequeueTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
    fcPara.dfxAddr = RtPtrToValue(dqsBatchDequeueTask->dfxPtr);
    RtStarsDqsBatchDequeueFc fc = {};
    ConstructDqsBatchDequeueFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(dqsBatchDequeueTask->funcCallSvmMem, dqsBatchDequeueTask->funCallMemSize, &fc,
        dqsBatchDequeueTask->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsBatchDequeueTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs Dequeue func call failed,retCode=%#x.", ret);
    }

    return ret;
}

static rtError_t FreeSvmMemForDqsZeroCopyTask(TaskInfo * const taskInfo)
{
    DqsZeroCopyTaskInfo *dqsZeroCopyTask = &(taskInfo->u.dqsZeroCopyTask);
    rtError_t ret = FreeDqsCommonTaskFuncCall(&(dqsZeroCopyTask->commonTaskInfo), taskInfo);
    ERROR_RETURN(ret, "free dqs common task func call failed, retCode=%#x", static_cast<uint32_t>(ret));

    const auto dev = taskInfo->stream->Device_();
    if (dqsZeroCopyTask->destPtr != nullptr) {
        ret = dev->Driver_()->DevMemFree(dqsZeroCopyTask->destPtr, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free dest svm mem failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        dqsZeroCopyTask->destPtr = nullptr;
    }

    if (dqsZeroCopyTask->offsetPtr != nullptr) {
        ret = dev->Driver_()->DevMemFree(dqsZeroCopyTask->offsetPtr, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free offset svm mem failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        dqsZeroCopyTask->offsetPtr = nullptr;
    }

    dqsZeroCopyTask->allocSize = 0ULL;
    return RT_ERROR_NONE;
}

static rtError_t AllocSvmMemForDqsZeroCopyTask(TaskInfo* const taskInfo, const DqsTaskConfig * const cfg)
{
    DqsZeroCopyTaskInfo *dqsZeroCopyTask = &(taskInfo->u.dqsZeroCopyTask);
    rtError_t ret = AllocDqsCommonTaskFuncCall(&(dqsZeroCopyTask->commonTaskInfo), taskInfo);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    std::function<void()> const errRecycle = [&ret, &taskInfo]() {
        if (ret != RT_ERROR_NONE) {
            (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsZeroCopyTask.commonTaskInfo), taskInfo);
        }
    };
    ScopeGuard drvErrRecycle(errRecycle);

    void *dest = nullptr;
    const uint64_t count = cfg->zeroCopyCfg->count;
    const uint64_t allocSize = sizeof(uint64_t) * count;
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->DevMemAlloc(&dest, allocSize, RT_MEMORY_DDR, dev->Id_());
    ERROR_RETURN(ret, 
        "Alloc dest memory failed, retCode=%#x, size=%" PRIu64 "(Byte), dev_id=%u", ret, allocSize, dev->Id_());
    dqsZeroCopyTask->destPtr = dest;

    void *offset = nullptr;
    ret = dev->Driver_()->DevMemAlloc(&offset, allocSize, RT_MEMORY_DDR, dev->Id_());
    ERROR_RETURN(ret, 
        "Alloc offset memory failed, retCode=%#x, size=%" PRIu64 "(bytes), dev_id=%u", ret, allocSize, dev->Id_());
    drvErrRecycle.ReleaseGuard();

    dqsZeroCopyTask->offsetPtr = offset;
    dqsZeroCopyTask->allocSize = allocSize;
    RT_LOG(RT_LOG_INFO, "Alloc svm mem for DqsZeroCopy with offset, destAddr=%#llx, offsetAddr=%#llx, size=%" PRIu64,
        dest, offset, allocSize);
    return RT_ERROR_NONE;
}

static rtError_t InitFuncCallParaForDqsZeroCopyTask(TaskInfo* const taskInfo,
                                                              RtStarsDqsZeroCopyPara &fcPara,
                                                              const DqsTaskConfig * const cfg)
{
    const rtDqsZeroCopyType copyType = cfg->zeroCopyCfg->copyType;
    const uint16_t queueId = cfg->zeroCopyCfg->queueId;
    uint32_t queueIndex = 0U;
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    NULL_PTR_RETURN_MSG(ctrlSpacePtr, RT_ERRORCODE_BASE);

    if (copyType == RT_DQS_ZERO_COPY_INPUT) {
        for (; queueIndex < ctrlSpacePtr->input_queue_num; queueIndex++) {
            if (queueId == ctrlSpacePtr->input_queue_ids[queueIndex]) {
                fcPara.mbufHandleAddr = RtPtrToValue(&ctrlSpacePtr->input_mbuf_list[queueIndex]);
                fcPara.mbufBaseAddr = RtPtrToValue(&ctrlSpacePtr->input_data_pool_base_addrs[queueIndex]);
                fcPara.blockSizeAddr = RtPtrToValue(&ctrlSpacePtr->input_data_pool_block_size_list[queueIndex]);
                break;
            }
        }
        COND_RETURN_ERROR((queueIndex >= ctrlSpacePtr->input_queue_num), RT_ERROR_INVALID_VALUE, "Invalid queueId!");
    } else if (copyType == RT_DQS_ZERO_COPY_OUTPUT) {
        for (; queueIndex < ctrlSpacePtr->output_queue_num; queueIndex++) {
            if (queueId == ctrlSpacePtr->output_queue_ids[queueIndex]) {
                fcPara.mbufHandleAddr = RtPtrToValue(&ctrlSpacePtr->output_mbuf_list[queueIndex]);
                fcPara.mbufBaseAddr = RtPtrToValue(&ctrlSpacePtr->output_data_pool_base_addrs[queueIndex]);
                fcPara.blockSizeAddr = RtPtrToValue(&ctrlSpacePtr->output_data_pool_block_size_list[queueIndex]);
                break;
            }
        }
        COND_RETURN_ERROR((queueIndex >= ctrlSpacePtr->output_queue_num), RT_ERROR_INVALID_VALUE, "Invalid queueId!");
    } else {
        RT_LOG(RT_LOG_ERROR, "Invalid DqsZeroCopy type, copyType=%u", static_cast<uint32_t>(copyType));
        return RT_ERROR_INVALID_VALUE;
    }

    fcPara.count = cfg->zeroCopyCfg->count;
    fcPara.isCpyAddrLow32First = (cfg->zeroCopyCfg->cpyAddrOrder == RT_DQS_ZERO_COPY_ADDR_ORDER_LOW32_FIRST);
    RT_LOG(RT_LOG_INFO, "Init DqsZeroCopy with offset function call params, copyType=%u, isCpyAddrLow32First=%u, "
        "mbufHandleAddr=%#llx, mbufBaseAddr=%#llx, blockSizeAddr=%#llx, count=%u, queueId=%u",
        static_cast<uint32_t>(cfg->zeroCopyCfg->copyType), static_cast<uint32_t>(fcPara.isCpyAddrLow32First),
        fcPara.mbufHandleAddr, fcPara.mbufBaseAddr, fcPara.blockSizeAddr, fcPara.count, queueId);
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsZeroCopyTask(TaskInfo* const taskInfo, const DqsTaskConfig * const cfg)
{
    rtError_t ret = AllocSvmMemForDqsZeroCopyTask(taskInfo, cfg);
    ERROR_RETURN(ret, "Alloc svm mem failed, retCode=%#x.", static_cast<uint32_t>(ret));
    RtStarsDqsZeroCopyPara fcPara = {};
    DqsZeroCopyTaskInfo *dqsZeroCopyTask = &(taskInfo->u.dqsZeroCopyTask);
    fcPara.destAddr = RtPtrToValue(dqsZeroCopyTask->destPtr);
    fcPara.offsetAddr = RtPtrToValue(dqsZeroCopyTask->offsetPtr);

    std::function<void()> const errRecycle = [&ret, &taskInfo]() {
        if (ret != RT_ERROR_NONE) {
            (void)FreeSvmMemForDqsZeroCopyTask(taskInfo);
        }
    };
    ScopeGuard tskErrRecycle(errRecycle);
    ret = InitFuncCallParaForDqsZeroCopyTask(taskInfo, fcPara, cfg);
    ERROR_RETURN(ret, "Init func call para failed, retCode=%#x.",
        static_cast<uint32_t>(ret));

    RtStarsDqsZeroCopyFc fc = {};
    ConstructDqsZeroCopyFc(fc, fcPara);

    DqsCommonTaskInfo * const commonTaskInfo = &(dqsZeroCopyTask->commonTaskInfo);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(commonTaskInfo->funcCallSvmMem,commonTaskInfo->funCallMemSize, &fc,
        commonTaskInfo->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    ERROR_RETURN(ret, "MemCopySync for DqsZeroCopy func call failed, retCode=%#x.", ret);

    ret = dev->Driver_()->MemCopySync(dqsZeroCopyTask->destPtr, dqsZeroCopyTask->allocSize, cfg->zeroCopyCfg->dest,
        dqsZeroCopyTask->allocSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    ERROR_RETURN(ret, "MemCopySync for DqsZeroCopy dest failed, retCode=%#x.", ret);

    ret = dev->Driver_()->MemCopySync(dqsZeroCopyTask->offsetPtr, dqsZeroCopyTask->allocSize, cfg->zeroCopyCfg->offset,
        dqsZeroCopyTask->allocSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    ERROR_RETURN(ret, "MemCopySync for DqsZeroCopy offset failed, retCode=%#x.", ret);
    tskErrRecycle.ReleaseGuard();

    return ret;
}

static rtError_t InitFuncCallParaForDqsMbufFreeTask(TaskInfo* const taskInfo, RtDqsMbufFreeFcPara &fcPara)
{
    // 由于执行条件算子下发时，mbuf pool id 还没确定，无法从驱动接口查询，从ctrlSpace中 input_mbuf_free_addrs 获取
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_ERROR(streamWithDqs == nullptr, RT_ERROR_INVALID_VALUE, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpacePtr = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");

    fcPara.ctrlSpaceAddr = RtPtrToValue(ctrlSpacePtr);

    size_t offset = offsetof(stars_dqs_ctrl_space_t, input_mbuf_free_addrs); // 这里使用ctrlSpace地址，是共享内存，内核态做了映射
    fcPara.mbufFreeAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset); 

    offset = offsetof(stars_dqs_ctrl_space_t, input_mbuf_list);
    fcPara.mbufHandleAddr = fcPara.ctrlSpaceAddr + static_cast<uint64_t>(offset);

    fcPara.mbufPoolIndexMax = ctrlSpacePtr->input_queue_num;
    return RT_ERROR_NONE;
}

void DqsMbufFreeTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsMbufFreeTask), taskInfo);
}

void DqsBatchDequeTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsBatchDequeueTask), taskInfo);
}

void PrintErrorInfoForDqsMbufFreeTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpace = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_VOID(ctrlSpace == nullptr,
        "dqs control space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);

    return;
}

void PrintErrorInfoForDqsBatchDequeueTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpace = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_VOID(ctrlSpace == nullptr,
        "dqs control space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);

    /* todo:如果写cqe_status，这个地方应该就不需要了吧 */
    uint32_t dfx[2U];
    const auto dev = taskInfo->stream->Device_();
    (void)dev->Driver_()->MemCopySync(dfx, sizeof(dfx),
        taskInfo->u.dqsBatchDequeueTask.dfxPtr, sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
    RT_LOG(RT_LOG_ERROR, "dqs dqsBatchDequeueTask error,  pop result=%u, stream_id=%d, task_id=%u,  pop_result=%u, hadle_value=%u",
        devId, taskInfo->stream->Id_(), taskInfo->id, dfx[0U], dfx[1U]);

    return;
}

static rtError_t InitFuncCallParaForDqsInterChipPreProcTask(TaskInfo* const taskInfo, RtStarsDqsInterChipPreProcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_inter_chip_space_t *interChipSpaceBasePtr = stm->GetDqsInterChipSpace();
    NULL_PTR_RETURN_MSG(interChipSpaceBasePtr, RT_ERRORCODE_BASE);

    DqsInterChipProcTaskInfo* dqsTask = &(taskInfo->u.dqsInterChipPreProcTask);
    const uint32_t groupIdx = dqsTask->groupIdx;
    const uint64_t interChipSpaceAddr = RtPtrToValue(interChipSpaceBasePtr) +
        static_cast<uint64_t>(groupIdx * sizeof(stars_dqs_inter_chip_space_t));
    constexpr size_t dstAddrOffset = offsetof(stars_memcpy_ptr_sdma_sqe_t, dst_addr);
    size_t offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_handle);
    fcPara.dstMbufHandleAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_alloc_addr);
    fcPara.dstMbuffAllocAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_head_pool_block_size);
    fcPara.dstMbufHeadBlockSizeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_data_pool_block_size);
    fcPara.dstMbufDataBlockSizeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_head_pool_base_addr);
    fcPara.dstMbufHeadBaseAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_data_pool_base_addr);
    fcPara.dstMbufDataBaseAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, mbuf_data_memcpy_sqe);
    fcPara.mbufDataSdmaSqeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset + dstAddrOffset);

    offset = offsetof(stars_dqs_inter_chip_space_t, mbuf_head_memcpy_sqe);
    fcPara.mbufHeadSdmaSqeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset + dstAddrOffset);

    RT_LOG(RT_LOG_INFO, "Init dqs inter-chip pre-proc params: groupIdx=%u, interChipSpaceAddr=%#llx, "
        "dstMbufHandleAddr=%#llx, dstMbuffAllocAddr=%#llx, dstMbufHeadBlockSizeAddr=%#llx, dstMbufDataBlockSizeAddr=%#llx, "
        "dstMbufHeadBaseAddr=%#llx, dstMbufDataBaseAddr=%#llx, mbufDataSdmaSqeAddr=%#llx, mbufHeadSdmaSqeAddr=%#llx, "
        "dstAddrOffset=%" PRIu64, groupIdx, interChipSpaceAddr, fcPara.dstMbufHandleAddr, fcPara.dstMbuffAllocAddr,
        fcPara.dstMbufHeadBlockSizeAddr, fcPara.dstMbufDataBlockSizeAddr, fcPara.dstMbufHeadBaseAddr,
        fcPara.dstMbufDataBaseAddr, fcPara.mbufDataSdmaSqeAddr, fcPara.mbufHeadSdmaSqeAddr,
        static_cast<uint64_t>(dstAddrOffset));
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsInterChipPreProcTask(TaskInfo* const taskInfo)
{
    RtStarsDqsInterChipPreProcPara fcPara = {};
    rtError_t ret = InitFuncCallParaForDqsInterChipPreProcTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call para failed, retCode=%#x", static_cast<uint32_t>(ret));

    DqsCommonTaskInfo *const commonTaskInfo = &(taskInfo->u.dqsInterChipPreProcTask.commonTaskInfo);
    ret = AllocDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x", static_cast<uint32_t>(ret));

    RtStarsDqsInterChipPreProcFc fc = {};
    ConstructDqsInterChipPreProcFc(fc, fcPara);

    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(commonTaskInfo->funcCallSvmMem, commonTaskInfo->funCallMemSize, &fc,
        commonTaskInfo->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for DqsInterChipPreProcTask failed, retCode=%#x", ret);
    }

    return ret;
}

static rtError_t PrepareSqeInfoForDqsInterChipMemcpyTask(TaskInfo* const taskInfo, void *&memcpyAddrInfo,
    const uint32_t groupIdx, const DqsInterChipTaskType type)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_inter_chip_space_t *interChipSpaceBasePtr = stm->GetDqsInterChipSpace();
    NULL_PTR_RETURN_MSG(interChipSpaceBasePtr, RT_ERRORCODE_BASE);

    uint64_t fieldOffset = 0ULL;
    if (type == DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_HEAD) {
        fieldOffset = offsetof(stars_dqs_inter_chip_space_t, mbuf_head_memcpy_sqe);
    } else if (type == DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_DATA) {
        fieldOffset = offsetof(stars_dqs_inter_chip_space_t, mbuf_data_memcpy_sqe);
    } else {
        RT_LOG(RT_LOG_ERROR, "Invaild type, streamId=%d, type=%d.", stm->Id_(), static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }

    const uint64_t interChipSpaceAddr =
        RtPtrToValue(interChipSpaceBasePtr) + static_cast<uint64_t>(groupIdx * sizeof(stars_dqs_inter_chip_space_t));
    memcpyAddrInfo = RtValueToPtr<void *>(interChipSpaceAddr + fieldOffset);
    RT_LOG(RT_LOG_DEBUG, "Prepare dqs inter-chip memcopy task info, memcpyAddrInfo=%p, streamId=%d, groupIdx=%u, type=%d",
           memcpyAddrInfo, stm->Id_(), groupIdx, static_cast<int32_t>(type));

    return RT_ERROR_NONE;
}

static rtError_t InitFuncCallParaForDqsInterChipPostProcTask(TaskInfo* const taskInfo, RtStarsDqsInterChipPostProcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_INSTANCE_NULL);
    stars_dqs_inter_chip_space_t *interChipSpaceBasePtr = stm->GetDqsInterChipSpace();
    NULL_PTR_RETURN_MSG(interChipSpaceBasePtr, RT_ERROR_INSTANCE_NULL);
    DqsInterChipProcTaskInfo *dqsTask = &(taskInfo->u.dqsInterChipPostProcTask);
    const uint32_t groupIdx = dqsTask->groupIdx;
    const uint64_t interChipSpaceAddr =
        RtPtrToValue(interChipSpaceBasePtr) + static_cast<uint64_t>(groupIdx * sizeof(stars_dqs_inter_chip_space_t));
    fcPara.srcMbufHandleAddr = interChipSpaceAddr;

    size_t offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_handle);
    fcPara.dstMbufHandleAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, src_mbuf_free_addr);
    fcPara.srcMbufFreeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_mbuf_free_addr);
    fcPara.dstMbufFreeAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_qmngr_enqueue_addr);
    fcPara.dstQueueAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_inter_chip_space_t, dst_qmngr_ow_addr);
    fcPara.dstQmngrOwAddr = interChipSpaceAddr + static_cast<uint64_t>(offset);

    RT_LOG(RT_LOG_INFO, "Init dqs inter-chip post-proc params: groupIdx=%u, interChipSpaceAddr=%#llx, "
        "srcMbufHandle=%#llx, dstMbufHandle=%#llx, srcMbufFreeAddr=%#llx, dstMbufFreeAddr=%#llx, dstQmngrEnQueueAddr=%#llx, "
        "dstQmngrOwAddr=%#llx", groupIdx, interChipSpaceAddr, fcPara.srcMbufHandleAddr, fcPara.dstMbufHandleAddr,
        fcPara.srcMbufFreeAddr, fcPara.dstMbufFreeAddr, fcPara.dstQueueAddr, fcPara.dstQmngrOwAddr);
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsInterChipPostProcTask(TaskInfo* const taskInfo)
{
    RtStarsDqsInterChipPostProcPara fcPara = {};
    rtError_t ret = InitFuncCallParaForDqsInterChipPostProcTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call para failed, retCode=%#x", static_cast<uint32_t>(ret));

    DqsInterChipProcTaskInfo *dqsTask = &(taskInfo->u.dqsInterChipPostProcTask);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsTask->commonTaskInfo);
    ret = AllocDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x", static_cast<uint32_t>(ret));

    RtStarsDqsInterChipPostProcFc fc = {};
    ConstructDqsInterChipPostProcFc(fc, fcPara);

    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(commonTaskInfo->funcCallSvmMem,
        commonTaskInfo->funCallMemSize, &fc, commonTaskInfo->funCallMemSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for DqsInterChipPreProcTask failed, retCode=%#x", ret);
    }

    return ret;
}

static rtError_t PrepareSqeInfoForDqsMbufFreeTask(TaskInfo* const taskInfo)
{
    DqsCommonTaskInfo *dqsMbufFreeTask = &(taskInfo->u.dqsMbufFreeTask);
    rtError_t ret = AllocDqsCommonTaskFuncCall(dqsMbufFreeTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", ret);

    RtDqsMbufFreeFcPara fcPara = {};
    ret = InitFuncCallParaForDqsMbufFreeTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed, retCode=%#x.", ret);

    RtStarsDqsMbufFreeFc fc = {};
    ConstructMbufFreeInstrFc(fc, fcPara);
    ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(dqsMbufFreeTask->funcCallSvmMem,
        dqsMbufFreeTask->funCallMemSize, &fc, dqsMbufFreeTask->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsMbufFreeTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs MbufFree func call failed,retCode=%#x.", ret);
    }

    return ret;
}

rtError_t DqsEnqueueTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_ENQUEUE;
    taskInfo->typeName = "EnqueueTask";
    DqsCommonTaskInfo *dqsEnqueueTask = &(taskInfo->u.dqsEnqueueTask);
    InitDqsCommonTaskInfo(dqsEnqueueTask, sizeof(RtStarsDqsEnqueueFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsEnqueueTask(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "Init for DqsEnqueueTask failed,retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t DqsSingleDequeueTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_DEQUEUE;
    taskInfo->typeName = "DequeueTask";
    DqsCommonTaskInfo *const dqsDequeueTask = &(taskInfo->u.dqsDequeueTask);
    InitDqsCommonTaskInfo(dqsDequeueTask, sizeof(RtStarsDqsDequeueFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsDequeueTask(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "Init for DqsDequeueTask failed,retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t DqsBatchDequeueTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_BATCH_DEQUEUE;
    taskInfo->typeName = "BatchDequeueTask";
    DqsCommonTaskInfo *const dqsBatchDequeueTask = &(taskInfo->u.dqsBatchDequeueTask);
    InitDqsCommonTaskInfo(dqsBatchDequeueTask, sizeof(RtStarsDqsBatchDequeueFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsBatchDequeueTask(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "Init for BatchDequeueTask failed,retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t DqsDequeueTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    /* 总入口处已经做过入参校验，此处无需再做 */
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");
    if (ctrlSpacePtr->input_queue_num == 1) {
        return DqsSingleDequeueTaskInit(taskInfo, stream, cfg);
    } else {
        return DqsBatchDequeueTaskInit(taskInfo, stream, cfg);
    }

    return RT_ERROR_NONE;
}

rtError_t DqsZeroCopyTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_ZERO_COPY;
    taskInfo->typeName = "ZeroCopyTask";
    DqsCommonTaskInfo *const commonTaskInfo = &(taskInfo->u.dqsZeroCopyTask.commonTaskInfo);
    InitDqsCommonTaskInfo(commonTaskInfo, sizeof(RtStarsDqsZeroCopyFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsZeroCopyTask(taskInfo, cfg);
    ERROR_RETURN_MSG_INNER(error, "Init for DqsZeroCopyTask failed, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

void DqsZeroCopyTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsZeroCopyTask.commonTaskInfo), taskInfo);
}

void PrintErrorInfoForDqsZeroCopyTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpace = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_VOID(ctrlSpace == nullptr,
       "dqs control space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);
}

rtError_t DqsMbufFreeTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    rtError_t error = RT_ERROR_NONE;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_MBUF_FREE;
    taskInfo->typeName = "MbufFreeTask";
    InitDqsCommonTaskInfo(&(taskInfo->u.dqsMbufFreeTask), sizeof(RtStarsDqsMbufFreeFc), stream->GetSqId());

    error = PrepareSqeInfoForDqsMbufFreeTask(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "Init for DqsMbufFreeTask failed,retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t DqsSchedEndTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "SchedEndTask";
    taskInfo->type = TS_TASK_TYPE_DQS_SCHED_END;
 
    DqsSchedEndTaskInfo *dqsSchedEndTask = &taskInfo->u.dqsSchedEndTask;
    dqsSchedEndTask->stream = RtPtrToUnConstPtr<Stream*>(stream);
    return RT_ERROR_NONE;
}

rtError_t DqsInterChipPreProcTaskInit(TaskInfo *taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type)
{
    UNUSED(type);
    Stream *stm = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_INTER_CHIP_PREPROC;
    taskInfo->typeName = "DqsInterChipPreProcTask";

    DqsInterChipProcTaskInfo *dqsTask = &(taskInfo->u.dqsInterChipPreProcTask);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsTask->commonTaskInfo);
    dqsTask->groupIdx = groupIdx;
    InitDqsCommonTaskInfo(commonTaskInfo, sizeof(RtStarsDqsInterChipPreProcFc), stm->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsInterChipPreProcTask(taskInfo);
    ERROR_RETURN(error, "Init for DqsInterChipPreProcTask failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

void DqsInterChipPreProcTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsInterChipPreProcTask.commonTaskInfo), taskInfo);
}

void PrintErrorInfoForDqsInterChipPreProcTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_inter_chip_space_t *interChipSpace = streamWithDqs->GetDqsInterChipSpace();
    COND_RETURN_VOID(interChipSpace == nullptr,
        "dqs inter-chip space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);
}

rtError_t DqsInterChipMemcpyTaskInit(TaskInfo *taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type)
{
    void *memcpyAddrInfo = nullptr;
    rtError_t error = PrepareSqeInfoForDqsInterChipMemcpyTask(taskInfo, memcpyAddrInfo, groupIdx, type);
    ERROR_RETURN_MSG_INNER(error, "Prepare sqe info for dqs inter-chip mem copy task failed, "
        "groupIdx=%u, type=%u, retCode=%#x", groupIdx, static_cast<uint32_t>(type), static_cast<uint32_t>(error));

    error = MemcpyAsyncTaskInitV1(taskInfo, memcpyAddrInfo, 0ULL);
    ERROR_RETURN_MSG_INNER(error, "Dqs inter-chip mem copy task init failed, groupIdx=%u, type=%u, retCode=%#x",
        groupIdx, static_cast<uint32_t>(type), static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t DqsInterChipPostProcTaskInit(TaskInfo *taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type)
{
    UNUSED(type);
    Stream *stm = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_INTER_CHIP_POSTPROC;
    taskInfo->typeName = "DqsInterChipPostProcTask";

    DqsInterChipProcTaskInfo *dqsTask = &(taskInfo->u.dqsInterChipPostProcTask);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsTask->commonTaskInfo);
    dqsTask->groupIdx = groupIdx;
    InitDqsCommonTaskInfo(commonTaskInfo, sizeof(RtStarsDqsInterChipPostProcFc), stm->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsInterChipPostProcTask(taskInfo);
    ERROR_RETURN(error, "Init failed, retCode=%#x", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

void DqsInterChipPostProcTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsInterChipPostProcTask.commonTaskInfo), taskInfo);
}

void PrintErrorInfoForDqsInterChipPostProcTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_inter_chip_space_t *interChipSpace = streamWithDqs->GetDqsInterChipSpace();
    COND_RETURN_VOID(interChipSpace == nullptr,
        "dqs inter-chip space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);
}

void ConstructSqeForDqsMbufFreeTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *dqsTask = &(taskInfo->u.dqsMbufFreeTask);

    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_MBUF_FREE);

    const uint64_t funcAddr = RtPtrToValue(dqsTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsMbufFreeFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsMbufFree");
    RT_LOG(RT_LOG_INFO, "DqsMbufFree, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsEnqueueTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *dqsEnqueueTask = &(taskInfo->u.dqsEnqueueTask);

    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_ENQUEUE);

    const uint64_t funcAddr = RtPtrToValue(dqsEnqueueTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsEnqueueFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsEnqueue");
    RT_LOG(RT_LOG_INFO, "DqsEnqueue, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsDequeueTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *dqsDequeueTask = &(taskInfo->u.dqsDequeueTask);

    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_DEQUEUE);

    const uint64_t funcAddr = RtPtrToValue(dqsDequeueTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsDequeueFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsDequeue");
    RT_LOG(RT_LOG_INFO, "DqsDequeue, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsBatchDequeueTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *dqsBatchDequeueTask = &(taskInfo->u.dqsBatchDequeueTask);

    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_BATCH_DEQUEUE);

    const uint64_t funcAddr = RtPtrToValue(dqsBatchDequeueTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsBatchDequeueFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);
    PrintDavidSqe(davidSqe, "DqsBatchDequeue");
    RT_LOG(RT_LOG_INFO, "DqsBatchDequeue, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsFrameAlignTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *dqsFrameAlignTask = &(taskInfo->u.dqsFrameAlignTask);

    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_FRAME_ALIGN);
    sqe.header.preP = 1U; // pre_p: frame align in ts

    const uint64_t funcAddr = RtPtrToValue(dqsFrameAlignTask->funcCallSvmMem);
    const uint64_t funcCallSize = dqsFrameAlignTask->funCallMemSize;

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsFrameAlign");
    RT_LOG(RT_LOG_INFO, "DqsFrameAlignTask, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsZeroCopyTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsZeroCopyTaskInfo *dqsZeroCopyTask = &(taskInfo->u.dqsZeroCopyTask);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_ZERO_COPY);

    DqsCommonTaskInfo *const commonTaskInfo = &(dqsZeroCopyTask->commonTaskInfo);
    const uint64_t funcAddr = RtPtrToValue(commonTaskInfo->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsZeroCopyFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsZeroCopy");
    RT_LOG(RT_LOG_INFO, "DqsZeroCopy, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsConditionCopyTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    uint64_t funcCallSize = 0ULL;
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsCommonTaskInfo *commonTaskInfo = &(taskInfo->u.dqsCondCopyTask);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_CONDITION_COPY);

    const uint64_t funcAddr = RtPtrToValue(commonTaskInfo->funcCallSvmMem);
    funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsConditionCopyFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsConditionCopy");
    RT_LOG(RT_LOG_INFO, "DqsConditionCopy, device_id=%u, stream_id=%d, task_id=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsSchedEndTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsDqsSchedEndSqe &sqe = davidSqe->dqsSchedEndSqe;
    DqsSchedEndTaskInfo *const dqsSchedEndTask = &(taskInfo->u.dqsSchedEndTask);
    const Stream *const stream = dqsSchedEndTask->stream;
    const uint16_t sqId = stream->GetSqId();
    ConstructDqsSchedEndInstr(sqId, sqe);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_SCHED_END);
    PrintDavidSqe(davidSqe, "DqsSchedEnd");
    RT_LOG(RT_LOG_INFO, "DqsSchedEnd, deviceId=%u, streamId=%d, taskId=%hu, sqId=%u", 
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, sqId);
}

void ConstructSqeForDqsInterChipPreProcTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsInterChipProcTaskInfo *dqsInterChipPreProcTask = &(taskInfo->u.dqsInterChipPreProcTask);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(
        sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_INTER_CHIP_PREPROC);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsInterChipPreProcTask->commonTaskInfo);
    const uint64_t funcAddr = RtPtrToValue(commonTaskInfo->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsInterChipPreProcFc));
    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsInterChipPreProc");
    RT_LOG(RT_LOG_INFO, "DqsInterChipPreProc, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsInterChipPostProcTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsInterChipProcTaskInfo *dqsInterChipPostProcTask = &(taskInfo->u.dqsInterChipPostProcTask);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(
        sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_INTER_CHIP_POSTPROC);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsInterChipPostProcTask->commonTaskInfo);
    const uint64_t funcAddr = RtPtrToValue(commonTaskInfo->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsInterChipPostProcFc));
    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsInterChipPostProc");
    RT_LOG(RT_LOG_INFO, "DqsInterChipPostProc, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

void ConstructSqeForDqsAdspcTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    DqsAdspcTaskInfo *dqsAdspcTask = &(taskInfo->u.dqsAdspcTaskInfo);
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_ADSPC);
    DqsCommonTaskInfo *const commonTaskInfo = &(dqsAdspcTask->commonTaskInfo);
    const uint64_t funcAddr = RtPtrToValue(commonTaskInfo->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsAdspcFc));
    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsAdspcTask");
    RT_LOG(RT_LOG_INFO, "DqsAdspcTask, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

static rtError_t InitFuncCallParaForDqsPrepareTask(TaskInfo *taskInfo, RtStarsDqsPrepareFcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");

    fcPara.outputQueueNum = ctrlSpacePtr->output_queue_num;
    fcPara.dfxMbufAllocPoolIdx = RtPtrToValue(taskInfo->u.dqsPrepareTask.dfxPtr);
    fcPara.dfxMbufAllocResult = fcPara.dfxMbufAllocPoolIdx + sizeof(uint32_t);
    fcPara.ctrlSpacePtr = RtPtrToValue(ctrlSpacePtr);

    size_t offset = offsetof(stars_dqs_ctrl_space_t, input_mbuf_list);
    fcPara.csPtrInputMbufHandleAddr = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, input_head_pool_base_addrs);
    fcPara.csPtrInputHeadPoolBaseAddr = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, input_head_pool_block_size_list);
    fcPara.csPtrInputHeadPoolBlockSize = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_mbuf_alloc_addrs);
    fcPara.csPtrOutputMbufAllocAddr = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_mbuf_list);
    fcPara.csPtrOutputMbufHandleAddr = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_head_pool_base_addrs);
    fcPara.csPtrOutputHeadPoolBaseAddr = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    offset = offsetof(stars_dqs_ctrl_space_t, output_head_pool_block_size_list);
    fcPara.csPtrOutputHeadPoolBlockSize = fcPara.ctrlSpacePtr + static_cast<uint64_t>(offset);

    RT_LOG(RT_LOG_INFO, "init dqs prepare function call params, dfxPoolIdx=%#llx, dfxMbufAllocRes=%#llx, "
        "ctrlSpace=%#llx, inputMbufHandle=%#llx, inputHeadPoolBase=%#llx, inputHeadPoolBlkSize=%#llx, "
        "outputMbufAlloc=%#llx, outputMbufHandle=%#llx, outputHeadPoolBase=%#llx, outputHeadPoolBlkSize=%#llx",
        fcPara.dfxMbufAllocPoolIdx, fcPara.dfxMbufAllocResult, fcPara.ctrlSpacePtr, fcPara.csPtrInputMbufHandleAddr,
        fcPara.csPtrInputHeadPoolBaseAddr, fcPara.csPtrInputHeadPoolBlockSize, fcPara.csPtrOutputMbufAllocAddr,
        fcPara.csPtrOutputMbufHandleAddr, fcPara.csPtrOutputHeadPoolBaseAddr, fcPara.csPtrOutputHeadPoolBlockSize);
    
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsPrepareTask(TaskInfo* taskInfo)
{
    DqsCommonTaskInfo *dqsPrepareTask = &(taskInfo->u.dqsPrepareTask);
    rtError_t ret = AllocDqsCommonTaskFuncCall(dqsPrepareTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsPrepareFcPara fcPara = {};
    ret = InitFuncCallParaForDqsPrepareTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsPrepareOutFc fc = {};
    ConstructDqsPrepareFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(dqsPrepareTask->funcCallSvmMem, dqsPrepareTask->funCallMemSize, &fc,
        dqsPrepareTask->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsPrepareTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs prepare func call failed,retCode=%#x.", ret);
    }

    return ret;
}

void PrintErrorInfoForDqsPrepareTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpace = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_VOID(ctrlSpace == nullptr,
        "dqs ctrl space is nullptr, stream_id=%d, deviceId=%u", streamWithDqs->Id_(), devId);

    DqsCommonTaskInfo *dqsPrepareTask = &(taskInfo->u.dqsPrepareTask);
    uint32_t dfx[2U] = {0U};  // 0: pool_idx, 1: alloc result
    const auto dev = taskInfo->stream->Device_();
    (void)dev->Driver_()->MemCopySync(
        dfx, sizeof(dfx), dqsPrepareTask->dfxPtr, sizeof(dfx), RT_MEMCPY_DEVICE_TO_DEVICE);
    const uint32_t failPoolIdx = dfx[0U];
    RT_LOG(RT_LOG_ERROR, "dqs prepare error, alloc output mbuf handle failed, device_id=%u, stream_id=%d, task_id=%u, "
        "alloc error_result=%#x, idx=%u, pool_id=%u", devId, taskInfo->stream->Id_(), taskInfo->id, dfx[1U], failPoolIdx,
        ctrlSpace->output_mbuf_pool_ids[failPoolIdx]);

    return;
}

rtError_t DqsPrepareTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_PREPARE;
    taskInfo->typeName = "DqsPrepareTask";
    DqsCommonTaskInfo *dqsPrepareTask = &(taskInfo->u.dqsPrepareTask);
    InitDqsCommonTaskInfo(dqsPrepareTask, sizeof(RtStarsDqsPrepareOutFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsPrepareTask(taskInfo);
    ERROR_RETURN(error, "init for DqsPrepareTask failed, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t InitFuncCallParaForDqsFrameAlignTask(TaskInfo *taskInfo, RtStarsDqsFrameAlignFcPara &fcPara)
{
    StreamWithDqs *stm = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_INSTANCE_NULL);
    stars_dqs_ctrl_space_t *ctrlSpacePtr = stm->GetDqsCtrlSpace();
    COND_RETURN_ERROR((ctrlSpacePtr == nullptr), RT_ERROR_INVALID_VALUE, "ctrl space is nullptr.");
    fcPara.frameAlignResAddr = PtrToValue(&ctrlSpacePtr->align_res);
    fcPara.sqId = taskInfo->u.dqsFrameAlignTask.sqId;
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsFrameAlignTask(TaskInfo* taskInfo)
{
    DqsCommonTaskInfo *dqsFrameAlignTask = &(taskInfo->u.dqsFrameAlignTask);
    rtError_t ret = AllocDqsCommonTaskFuncCall(dqsFrameAlignTask, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsFrameAlignFcPara fcPara = {};
    ret = InitFuncCallParaForDqsFrameAlignTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call param failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsFrameAlignFc fc = {};
    ConstructDqsFrameAlignFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(dqsFrameAlignTask->funcCallSvmMem, dqsFrameAlignTask->funCallMemSize, &fc,
        dqsFrameAlignTask->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(dqsFrameAlignTask, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs frame align func call failed,retCode=%#x.", ret);
    }

    return ret;
}

rtError_t DqsFrameAlignTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    UNUSED(cfg);
    taskInfo->type = TS_TASK_TYPE_DQS_FRAME_ALIGN;
    taskInfo->typeName = "FrameAlignTask";

    DqsCommonTaskInfo *const dqsFrameAlignTask = &(taskInfo->u.dqsFrameAlignTask);
    InitDqsCommonTaskInfo(dqsFrameAlignTask, sizeof(RtStarsDqsFrameAlignFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsFrameAlignTask(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "Init for FrameAlignTask failed, retCode=%#x.", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

void DqsFrameAlignTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsFrameAlignTask), taskInfo);
}

static rtError_t InitFuncCallParaForDqsConditionCopyTask(RtStarsDqsConditionCopyPara &fcPara, const DqsTaskConfig *const cfg)
{
    const rtDqsConditionCopyCfg_t * const dqsCondCopyCfg = cfg->condCopyCfg;

    fcPara.conditionAddr = RtPtrToValue(dqsCondCopyCfg->condition);
    fcPara.dstAddr = RtPtrToValue(dqsCondCopyCfg->dst);
    fcPara.srcAddr = RtPtrToValue(dqsCondCopyCfg->src);
    fcPara.count = dqsCondCopyCfg->cnt / sizeof(uint64_t);

    RT_LOG(RT_LOG_INFO, "Init ConditionCopy function call params, conditionAddr=%#llx, dstAddr=%#llx, srcAddr=%#llx, "
        "copyCount=%" PRIu64, fcPara.conditionAddr, fcPara.dstAddr, fcPara.srcAddr, fcPara.count);
    return RT_ERROR_NONE;
}

static rtError_t PrepareSqeInfoForDqsConditionCopyTask(TaskInfo* taskInfo, const DqsTaskConfig *const cfg)
{
    DqsCommonTaskInfo *commonTaskInfo = &(taskInfo->u.dqsCondCopyTask);
    rtError_t ret = AllocDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsConditionCopyPara fcPara = {};
    ret = InitFuncCallParaForDqsConditionCopyTask(fcPara, cfg);
    ERROR_RETURN(ret, "Init func call param failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsConditionCopyFc fc = {};
    ConstructConditionCopyFc(fc, fcPara);
    const auto dev = taskInfo->stream->Device_();
    ret = dev->Driver_()->MemCopySync(commonTaskInfo->funcCallSvmMem, commonTaskInfo->funCallMemSize, &fc,
        commonTaskInfo->funCallMemSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs prepare func call failed, retCode=%#x.", ret);
    }

    return ret; 
}

void DqsConditionCopyTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsPrepareTask), taskInfo);
}

void PrintErrorInfoForDqsConditionCopyTask(TaskInfo* taskInfo, const uint32_t devId)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(taskInfo->stream);
    COND_RETURN_VOID(streamWithDqs == nullptr, "streamWithDqs is nullptr");

    stars_dqs_ctrl_space_t *ctrlSpace = streamWithDqs->GetDqsCtrlSpace();
    COND_RETURN_VOID(ctrlSpace == nullptr,
       "dqs control space is nullptr, stream_id=%d, device_id=%u", streamWithDqs->Id_(), devId);
}

rtError_t DqsConditionCopyTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_CONDITION_COPY;
    taskInfo->typeName = "DqsConditionCopyTask";
    DqsCommonTaskInfo *dqsCommonTaskInfo = &(taskInfo->u.dqsCondCopyTask);
    InitDqsCommonTaskInfo(dqsCommonTaskInfo, sizeof(RtStarsDqsConditionCopyFc), stream->GetSqId());

    const rtError_t error = PrepareSqeInfoForDqsConditionCopyTask(taskInfo, cfg);
    ERROR_RETURN(error, "init for DqsConditionCopyTask failed, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

void DqsPrepareTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsPrepareTask), taskInfo);
}

void ConstructSqeForDqsPrepareTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    const Stream *const stm = taskInfo->stream;
    InitDqsFunctionCallSqe(sqe, stm->GetStarsWrCqeFlag(), stm->Id_(), taskInfo->id, CONDS_SUB_TYPE_DQS_PREPARE);

    DqsCommonTaskInfo *dqsTask = &(taskInfo->u.dqsPrepareTask);
    const uint64_t funcAddr = RtPtrToValue(dqsTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsDqsPrepareOutFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "DqsPrepare");
    RT_LOG(RT_LOG_INFO, "DqsPrepare, deviceId=%u, streamId=%d, taskId=%hu",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

static void InitFuncCallParaForDqsAdspcTask(DqsAdspcTaskInfo *dqsAdspcTaskInfo, RtStarsDqsAdspcFcPara &fcPara,
                                            rtDqsAdspcTaskCfg_t *param)
{
    fcPara.qmngrEnqRegAddr = dqsAdspcTaskInfo->qmngrEnqRegAddr;
    fcPara.qmngrOwRegAddr = dqsAdspcTaskInfo->qmngrOwRegAddr;
    fcPara.mbufFreeRegAddr = dqsAdspcTaskInfo->mbufFreeRegAddr;
    fcPara.cqeHeadTailMask = dqsAdspcTaskInfo->cqeHeadTailMask;

    fcPara.cqeSize = param->cqeSize;
    fcPara.cqDepth = param->cqDepth;
    fcPara.mbufHandle = param->mbufHandle;
    fcPara.cqeBaseAddr = param->cqeBaseAddr;
    fcPara.cqeCopyAddr = param->cqeCopyAddr;
    fcPara.cqHeadRegAddr = param->cqHeadRegAddr;
    fcPara.cqTailRegAddr = param->cqTailRegAddr;

    fcPara.dfxAddr = RtPtrToValue(dqsAdspcTaskInfo->commonTaskInfo.dfxPtr);

    RT_LOG(RT_LOG_DEBUG, "dqs adspc task function call param: qmngrEnqRegAddr=%#llx, qmngrOwRegAddr=%#llx, "
        "mbufFreeRegAddr=%#llx, cqeHeadTailMask=%#x, cqeSize=%#x, cqDepth=%#x, mbufHandle=%#x, cqeBaseAddr=%#llx, "
        "cqeCopyAddr=%#llx, cqHeadRegAddr=%#llx, cqTailRegAddr=%#llx, dfxAddr=%#llx",
        fcPara.qmngrEnqRegAddr, fcPara.qmngrOwRegAddr, fcPara.mbufFreeRegAddr, fcPara.cqeHeadTailMask, fcPara.cqDepth,
        fcPara.cqeSize, fcPara.mbufHandle, fcPara.cqeBaseAddr, fcPara.cqeCopyAddr, fcPara.cqHeadRegAddr,
        fcPara.cqTailRegAddr, fcPara.dfxAddr);
}

static rtError_t PrepareSqeInfoForDqsAdspcTask(TaskInfo* taskInfo, const Stream * const stream,
                                               rtDqsAdspcTaskCfg_t *param)
{
    DqsAdspcTaskInfo *dqsAdspcTaskInfo = &(taskInfo->u.dqsAdspcTaskInfo);
    DqsCommonTaskInfo *commonTaskInfo = &(dqsAdspcTaskInfo->commonTaskInfo);
    rtError_t ret = AllocDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", static_cast<uint32_t>(ret));

    RtStarsDqsAdspcFcPara fcPara = {};
    InitFuncCallParaForDqsAdspcTask(dqsAdspcTaskInfo, fcPara, param);
    RtStarsDqsAdspcFc fc = {};
    ConstructDqsAdspcFc(fc, fcPara);

    const auto dev = stream->Device_();
    ret = dev->Driver_()->MemCopySync(commonTaskInfo->funcCallSvmMem, commonTaskInfo->funCallMemSize, &fc,
        commonTaskInfo->funCallMemSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        (void)FreeDqsCommonTaskFuncCall(commonTaskInfo, taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for Dqs Dequeue func call failed,retCode=%#x.", ret);
    }
    return ret;
}

rtError_t DqsAdspcTaskInit(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig *const cfg)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DQS_ADSPC;
    taskInfo->typeName = "DqsAdspcTask";
    DqsAdspcTaskInfo *dqsAdspcTaskInfo = &(taskInfo->u.dqsAdspcTaskInfo);
    DqsCommonTaskInfo *dqsCommonTask = &(dqsAdspcTaskInfo->commonTaskInfo);
    InitDqsCommonTaskInfo(dqsCommonTask, sizeof(RtStarsDqsAdspcFc), stream->GetSqId());

    // get qmngr op reg virtual addr
    rtDqsAdspcTaskCfg_t *param = cfg->adspcCfg;
    const auto dev = stream->Device_();
    DqsQueueInfo queInfo = {};
    rtError_t ret = dev->Driver_()->GetDqsQueInfo(dev->Id_(), static_cast<uint32_t>(param->queueId), &queInfo);
    ERROR_RETURN(ret, "query dqs queue info failed, retCode=%#x.", static_cast<uint32_t>(ret));
    if ((queInfo.queType != QMNGR_ENTITY_TYPE) || (queInfo.prodqOwAddr == 0ULL) || (queInfo.enqueOpAddr == 0ULL)) {
        RT_LOG(RT_LOG_ERROR, "enqueue and overwrite op reg addr is invalid, qid=%u", param->queueId);
        return RT_ERROR_INVALID_VALUE;
    }
    dqsAdspcTaskInfo->qmngrEnqRegAddr = queInfo.enqueOpAddr;
    dqsAdspcTaskInfo->qmngrOwRegAddr = queInfo.prodqOwAddr;

    // get mbuf pool free reg virtual addr
    DqsPoolInfo dqsPoolInfo = {};
    const uint32_t poolId = param->mbufHandle & dqsPoolIdMask;  // pool_id
    ret = dev->Driver_()->GetDqsMbufPoolInfo(poolId, &dqsPoolInfo);
    ERROR_RETURN(ret, "query dqs mbuf pool info failed, retCode=%#x.", static_cast<uint32_t>(ret));
    dqsAdspcTaskInfo->mbufFreeRegAddr = dqsPoolInfo.freeOpAddr;

    // Adspc的cqe为2的n次方（当前硬件下为8，这里参数化是为了后续硬件形态拓展）
    const uint8_t cqDepth = param->cqDepth;
    if ((cqDepth & (cqDepth - 1U)) != 0U) {
        RT_LOG(RT_LOG_ERROR, "cqe depth=%u is illegal, should be 2^n", cqDepth);
        return RT_ERROR_INVALID_VALUE;
    }
    // 对应的cqHead和tail的有效位Mask为 depth - 1
    dqsAdspcTaskInfo->cqeHeadTailMask = cqDepth - 1U;

    ret = PrepareSqeInfoForDqsAdspcTask(taskInfo, stream, param);
    ERROR_RETURN(ret, "init for DqsAdspcTask failed, retCode=%#x.", static_cast<uint32_t>(ret));
    return RT_ERROR_NONE;
}

void DqsAdspcTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeDqsCommonTaskFuncCall(&(taskInfo->u.dqsAdspcTaskInfo.commonTaskInfo), taskInfo);
}

void PrintErrorInfoForDqsAdspcTask(TaskInfo* taskInfo, const uint32_t devId)
{
    uint32_t dfx[3U]; // 0: cqHead, 1: cqTail, 2: qmngr ow value
    const auto dev = taskInfo->stream->Device_();
    (void)dev->Driver_()->MemCopySync(dfx, sizeof(dfx),
         taskInfo->u.dqsAdspcTaskInfo.commonTaskInfo.dfxPtr, sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
    RT_LOG(RT_LOG_ERROR, "dqs adspc task error, device_id=%u, stream_id=%d, task_id=%u, cqHead=%u, cqTail=%u, "
        "qmngr ow reg val=%#x", devId, taskInfo->stream->Id_(), taskInfo->id, dfx[0U], dfx[1U], dfx[2U]);
}

}
}