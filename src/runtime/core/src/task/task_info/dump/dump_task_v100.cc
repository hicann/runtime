/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "task_info_v100.h"
#include "stars.hpp"
#include "error_code.h"
#include "dump_task.h"

namespace cce {
namespace runtime {
constexpr const uint16_t STARS_DATADUMP_LOADINFO_END_BITMAP = 0x20U;

#if F_DESC("DataDumpLoadInfoTask")
void ConstructSqeForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_DATADUMP_LOADINFO;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.data_dump_load_info.dumpinfoPtr = taskInfo->u.dataDumpLoadInfoTask.dumpInfo;
    sqe->u.data_dump_load_info.length = taskInfo->u.dataDumpLoadInfoTask.length;
    sqe->u.data_dump_load_info.stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->u.data_dump_load_info.task_id = taskInfo->id;
    sqe->u.data_dump_load_info.kernel_type = taskInfo->u.dataDumpLoadInfoTask.kernelType;
    sqe->u.data_dump_load_info.reserved = STARS_DATADUMP_LOADINFO_END_BITMAP;

    PrintSqe(command, "DataDumpLoadInfoTask");
    RT_LOG(RT_LOG_INFO, "DataDumpLoadInfoTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

void DoCompleteSuccessForDataDumpLoadInfoTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(errorCode);
        RT_LOG(RT_LOG_ERROR, "Data Dump Load Info retCode=%#x, [%s].",
               errorCode, GetTsErrCodeDesc(errorCode));
    }
}

#endif

#if F_DESC("DebugRegisterTask")
void ConstructSqeForDebugRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_DEBUG_REGISTER;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.model_debug_register_info.addr = taskInfo->u.debugRegisterTask.addr;
    sqe->u.model_debug_register_info.modelId = taskInfo->u.debugRegisterTask.modelId;
    sqe->u.model_debug_register_info.flag = taskInfo->u.debugRegisterTask.flag;

    PrintSqe(command, "DebugRegister");
    RT_LOG(RT_LOG_INFO, "DebugRegisterTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}

#endif

#if F_DESC("DebugUnRegisterTask")
void ConstructSqeForDebugUnRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_DEBUG_UNREGISTER;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.model_debug_register_info.modelId = taskInfo->u.debugUnRegisterTask.modelId;

    PrintSqe(command, "DebugUnRegister");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}

#endif

#if F_DESC("DebugRegisterForStreamTask")
void ConstructSqeForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.stream_debug_register_info.addr = taskInfo->u.debugRegisterForStreamTask.addr;
    sqe->u.stream_debug_register_info.streamId = taskInfo->u.debugRegisterForStreamTask.streamId;
    sqe->u.stream_debug_register_info.flag = taskInfo->u.debugRegisterForStreamTask.flag;

    PrintSqe(command, "DebugRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugRegisterForStreamTask stream_id:%d task_id:%u",
        stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}

#endif

#if F_DESC("DebugUnRegisterForStreamTask")
void ConstructSqeForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe *const sqe = &(command->phSqe);
    Stream *stm = taskInfo->stream;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.stream_debug_register_info.streamId = taskInfo->u.debugUnRegisterForStreamTask.streamId;

    PrintSqe(command, "DebugUnRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterForStreamTask stream_id:%d task_id:%u",
        stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

#if F_DESC("AicpuInfoLoadTask")
void ConstructSqeForAicpuInfoLoadTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_AICPU_INFO_LOAD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.ai_cpu_load_info.aicpufoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    sqe->u.ai_cpu_load_info.length = taskInfo->u.aicpuInfoLoadTask.length;
    sqe->u.ai_cpu_load_info.stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->u.ai_cpu_load_info.task_id = taskInfo->id;
    sqe->u.ai_cpu_load_info.reserved[0] = 0U;
    sqe->u.ai_cpu_load_info.reserved[1] = 0U;

    PrintSqe(command, "AicpuInfoLoadTask");
    RT_LOG(RT_LOG_INFO, "AicpuInfoLoadTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

void DoCompleteSuccessForAicpuInfoLoadTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(errorCode);
        RT_LOG(RT_LOG_ERROR, "Ai Cpu Load Info retCode=%#x, [%s].",
               errorCode, GetTsErrCodeDesc(errorCode));
    }
}
#endif

void ConstructSqeForNopTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 0U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_NOP;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    PrintSqe(command, "NoOperationTask");
}

}  // namespace runtime
}  // namespace cce
