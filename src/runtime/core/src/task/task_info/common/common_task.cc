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
#include "context.hpp"
#include "task_manager.h"
#include "common_task.h"

namespace cce {
namespace runtime {
#if F_DESC("StarsCommonTask")
void StarsCommonTaskUnInit(TaskInfo * const taskInfo)
{
    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;
    const auto dev = taskInfo->stream->Device_();
    // randomDevAddr内存需要释放
    if (starsCommTask->randomDevAddr != nullptr) {
        (void)(dev->Driver_())->DevMemFree(starsCommTask->randomDevAddr, dev->Id_());
        starsCommTask->randomDevAddr = nullptr;
        RT_LOG(RT_LOG_INFO, "randomDevAddr free success.");
    }
    if (starsCommTask->cmdList == nullptr) {
        return;
    }
    RT_LOG(RT_LOG_INFO, "StarsCommonTask UnInit cmdlist,flag=%u", starsCommTask->flag);
    if ((starsCommTask->flag & RT_KERNEL_CMDLIST_NOT_FREE) == 0U) {
        RT_LOG(RT_LOG_INFO, "stars common task uninit cmdlist,call DevMemFree");
        (void)(dev->Driver_())->DevMemFree(starsCommTask->cmdList, dev->Id_());
    } else {
        RT_LOG(RT_LOG_INFO, "not need to free cmdlist.");
    }
    starsCommTask->cmdList = nullptr;
}

void PrintDsaErrorInfoForStarsCommonTask(TaskInfo* taskInfo)
{
    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;
    rtStarsDsaSqe_t *sqe = RtPtrToPtr<rtStarsDsaSqe_t*, rtStarsCommonSqe_t*>(&starsCommTask->commonStarsSqe.commonSqe);
    rtDsaCfgParam param = {};
    param.u8 = static_cast<uint8_t>(sqe->paramAddrValBitmap);
    uint64_t value = 0UL;
    void *devPtr = nullptr;
    std::stringstream debugInfo;
    rtError_t ret = RT_ERROR_NONE;

    debugInfo << "stream_id=" << sqe->sqeHeader.rtStreamId << ",task_id=" << sqe->sqeHeader.taskId;
    if (param.bits.seed == 0U) {
        devPtr = RtValueToPtr<void *>((static_cast<uint64_t>(sqe->dsaCfgSeedHigh) << UINT32_BIT_NUM) |
            static_cast<uint64_t>(sqe->dsaCfgSeedLow));
        rtPtrAttributes_t attr = {};
        ret = taskInfo->stream->Device_()->Driver_()->PtrGetAttributes(devPtr, &attr);
        if ((ret == RT_ERROR_NONE) && (attr.location.type == RT_MEMORY_LOC_DEVICE)) {
            (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(&value, sizeof(value), devPtr, sizeof(value), RT_MEMCPY_DEVICE_TO_HOST);
            debugInfo << ", dsa_cfg_seed addr=" << devPtr << ",value=0x" << std::hex << value;
        } else {
            debugInfo << ", dsa_cfg_seed addr=" << devPtr << " is invalid";
        }
    }
    if (param.bits.randomNumber == 0U) {
        devPtr = RtValueToPtr<void *>((static_cast<uint64_t>(sqe->dsaCfgNumberHigh) << UINT32_BIT_NUM) |
            static_cast<uint64_t>(sqe->dsaCfgNumberLow));
        rtPtrAttributes_t attr = {};
        ret = taskInfo->stream->Device_()->Driver_()->PtrGetAttributes(devPtr, &attr);
        if ((ret == RT_ERROR_NONE) && (attr.location.type == RT_MEMORY_LOC_DEVICE)) {
            (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(&value, sizeof(value), devPtr, sizeof(value), RT_MEMCPY_DEVICE_TO_HOST);
            debugInfo << ", dsa_cfg_random_number addr=" << devPtr << ", value=0x" << std::hex << value;
        } else {
            debugInfo << ", dsa_cfg_random_number addr=" << devPtr << " is invalid";
        }
    }
    RT_LOG(RT_LOG_ERROR, "%s", debugInfo.str().c_str());
    PrintErrorSqe(RtPtrToPtr<rtStarsSqe_t*, rtStarsDsaSqe_t* >(sqe), "dsaTask");
}

void PrintErrorInfoForStarsCommonTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const int32_t streamId = taskInfo->stream->Id_();
    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    RtErrModuleType errModule = ERR_MODULE_RTS;
    if (starsCommTask->commonStarsSqe.commonSqe.sqeHeader.type == RT_STARS_SQE_TYPE_DSA) {
        errModule = ERR_MODULE_FE;
        PrintDsaErrorInfoForStarsCommonTask(taskInfo);
    }
    STREAM_REPORT_ERR_MSG(reportStream, errModule, "Task execution failed, device_id=%u, stream_id=%d, %s=%hu,"
        "flip_num=%hu, task_type=%d(%s).", devId, streamId, TaskIdDesc(), taskInfo->id, taskInfo->flipNum,
        static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
}

rtError_t GetIsCmdListNotFreeValByDvppCfg(rtDvppCfg_t *cfg, bool &isCmdListNotFree)
{
    // cfg support nullptr, no need process
    NULL_PTR_RETURN_NOLOG(cfg, RT_ERROR_NONE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);

    for (size_t idx = 0U; idx < cfg->numAttrs; idx++) {
        switch (cfg->attrs[idx].id) {
            case RT_DVPP_CMDLIST_NOT_FREE:
                isCmdListNotFree = cfg->attrs[idx].value.isCmdListNotFree;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "dvpp cfg attr id[%u] is invalid, should be [1, %u)",
                    cfg->attrs[idx].id, RT_DVPP_MAX);
                return RT_ERROR_INVALID_VALUE;
        }
    }

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("WriteValuePtrTask")
rtError_t WriteValuePtrTaskInit(TaskInfo* taskInfo, const void* const pointedAddr, TaskWrCqeFlag cqeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "WriteValuePtrTask";
    taskInfo->type = TS_TASK_TYPE_WRITE_VALUE;

    WriteValueTaskInfo* writeValTsk = &taskInfo->u.writeValTask;
    // pointedAddr是平台相关的二级指针描述符，由SQE构造阶段解析。
    writeValTsk->sqeAddr = RtPtrToValue(pointedAddr);
    writeValTsk->cqeFlag = cqeFlag;
    writeValTsk->ptrFlag = 1U;

    return RT_ERROR_NONE;
}

rtError_t CaptureRecordExternalTaskInit(TaskInfo* taskInfo, const void* const recordSlotAddr, TaskWrCqeFlag cqeFlag)
{
    const rtError_t ret = WriteValuePtrTaskInit(taskInfo, recordSlotAddr, cqeFlag);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    taskInfo->typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo->type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    return RT_ERROR_NONE;
}
#endif

#if F_DESC("WriteValueTask")
rtError_t WriteValueTaskInit(TaskInfo *taskInfo, uint64_t addr, WriteValueSize size,
                             uint8_t *value, TaskWrCqeFlag cqeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "WriteValueTask";
    taskInfo->type = TS_TASK_TYPE_WRITE_VALUE;

    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    writeValTsk->addr = addr;
    writeValTsk->awSize = size;
    writeValTsk->cqeFlag = cqeFlag;
    const uint32_t writeLen = (1U << static_cast<uint32_t>(size));

    for (uint32_t i = 0U; i < writeLen; i++) {
        writeValTsk->value[i] = value[i];
    }

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("CommonCmdTask")
void CommonCmdTaskInit(TaskInfo * const taskInfo, const PhCmdType cmdType, const CommonCmdTaskInfo * cmdInfo)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_COMMON_CMD;
    commonCmdTaskInfo->cmdType = static_cast<uint16_t>(cmdType);
    if (cmdType == PhCmdType::CMD_STREAM_CLEAR) {
        taskInfo->typeName = "STREAM_CLEAR_TASK";
        commonCmdTaskInfo->streamId = static_cast<uint16_t>(cmdInfo->streamId);
        commonCmdTaskInfo->step = static_cast<uint16_t>(cmdInfo->step);
    } else if (cmdType == PhCmdType::CMD_NOTIFY_RESET) {
        taskInfo->typeName = "NOTIFY_RESET_TASK";
        commonCmdTaskInfo->notifyId = cmdInfo->notifyId;
    } else {
        // no operation
    }
    return;
}
#endif

}  // namespace runtime
}  // namespace cce
