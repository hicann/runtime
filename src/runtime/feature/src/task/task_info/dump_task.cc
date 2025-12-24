/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "debug_task.h"

namespace cce {
namespace runtime {
constexpr const uint16_t STARS_DATADUMP_LOADINFO_END_BITMAP = 0x20U;
#if F_DESC("FusionDumpAddrSetTask")
rtError_t FusionDumpAddrSetTaskInit(TaskInfo* taskInfo, const uint16_t modelIndex, const void *const address,
                                    const uint32_t dumpDataSize,
                                    const uint32_t fusionFlag)
{
    COND_RETURN_ERROR_MSG_INNER((dumpDataSize == 0U), RT_ERROR_DUMP_ADDR_SET_FAILED,
        "Init fusion dump address set task failed,dump size is 0.");

    FusionDumpAddrSetTaskInfo *fusionDumpAddrSet = &(taskInfo->u.fusionDumpAddrSetTask);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_FUSIONDUMP_ADDR_SET;
    taskInfo->typeName = "FUSIONDUMP_ADDR_SET";
    fusionDumpAddrSet->dumpSize = dumpDataSize;
    fusionDumpAddrSet->modelId = modelIndex;
    fusionDumpAddrSet->addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(address));
    fusionDumpAddrSet->flag = static_cast<uint8_t>(fusionFlag);
    fusionDumpAddrSet->combAddr = 0U;
    return RT_ERROR_NONE;
}

void ToCommandBodyForFusionDumpAddrSetTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    FusionDumpAddrSetTaskInfo *fusionDumpAddrSet = &(taskInfo->u.fusionDumpAddrSetTask);
    const uint64_t addr = fusionDumpAddrSet->addr;
    const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()), addr, &(fusionDumpAddrSet->combAddr));
    COND_RETURN_VOID(error != RT_ERROR_NONE, "translate failed, retCode=%#x, address=%#" PRIx64 ".", error, addr);
    RT_LOG(RT_LOG_INFO, "vir_addr=%#" PRIx64 ", comb_addr=%#" PRIx64 ", dumpSize=%u, modelID=%u.",
        addr, fusionDumpAddrSet->combAddr, fusionDumpAddrSet->dumpSize,
        fusionDumpAddrSet->modelId);

    command->u.fusionDumpAddrSetTask.dumpAddrPtr = fusionDumpAddrSet->combAddr;
    command->u.fusionDumpAddrSetTask.dumpSize = fusionDumpAddrSet->dumpSize;
    command->u.fusionDumpAddrSetTask.model_id = static_cast<uint16_t>(fusionDumpAddrSet->modelId);
    command->u.fusionDumpAddrSetTask.flag = fusionDumpAddrSet->flag;
}

#endif

#if F_DESC("DataDumpLoadInfoTask")
rtError_t DataDumpLoadInfoTaskInit(TaskInfo* taskInfo, const void *const dumpInfoPtr,
    const uint32_t len, const uint16_t kernelType)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DATADUMP_LOADINFO;
    taskInfo->typeName = "DATADUMP_LOADINFO";
    taskInfo->u.dataDumpLoadInfoTask.dumpInfo = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(dumpInfoPtr));
    taskInfo->u.dataDumpLoadInfoTask.length = len;
    taskInfo->u.dataDumpLoadInfoTask.kernelType = kernelType;
    RT_LOG(RT_LOG_DEBUG, "data dump loadinfo, stream_id=%d, task_id=%hu, length=%u, flag=%u, task_type=%d(%s)",
           taskInfo->stream->Id_(), taskInfo->id, len, kernelType,
           static_cast<int32_t>(taskInfo->type), taskInfo->typeName);

    return RT_ERROR_NONE;
}

void ToCommandBodyForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.dataDumpLoadInfoTask.dumpInfoPtr = taskInfo->u.dataDumpLoadInfoTask.dumpInfo;
    command->u.dataDumpLoadInfoTask.length = taskInfo->u.dataDumpLoadInfoTask.length;
}

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

void SetStarsResultForDataDumpLoadInfoTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        taskInfo->errorCode = logicCq.errorCode;
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU, "aicpu task happen error, retCode=%#x.",
            taskInfo->errorCode);
    }
}

#endif

#if F_DESC("DebugRegisterTask")
rtError_t DebugRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId,
                                const void *const address,
                                const uint32_t curFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->u.debugRegisterTask.addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(address));
    auto dev = taskInfo->stream->Device_();
    if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_DEBUG_REGISTER_WITH_VA_ADDR)) {
        uint64_t pptr;
        const rtError_t error = dev->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(dev->Id_()),
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(address)), &pptr);
        ERROR_RETURN_MSG_INNER(error, "Convert memory from virtual to dma physical failed!");
        RT_LOG(RT_LOG_DEBUG, "pptr offset=%#" PRIx64 ".", pptr);
        taskInfo->u.debugRegisterTask.addr = pptr;
    }

    taskInfo->type = TS_TASK_TYPE_DEBUG_REGISTER;
    taskInfo->typeName = "DEBUG_REGISTER";
    taskInfo->u.debugRegisterTask.modelId = mdlId;
    taskInfo->u.debugRegisterTask.flag = curFlag;

    return RT_ERROR_NONE;
}

void ToCommandBodyForDebugRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.debugRegisterTask.addr = taskInfo->u.debugRegisterTask.addr;
    RT_LOG(RT_LOG_DEBUG, "command->u.debugRegisterTask.addr=%#" PRIx64 ".", command->u.debugRegisterTask.addr);
    command->u.debugRegisterTask.modelId = taskInfo->u.debugRegisterTask.modelId;
    command->u.debugRegisterTask.flag = taskInfo->u.debugRegisterTask.flag;
}

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
rtError_t DebugUnRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_DEBUG_UNREGISTER;
    taskInfo->typeName = "DEBUG_UNREGISTER";
    taskInfo->u.debugUnRegisterTask.modelId = mdlId;
    return RT_ERROR_NONE;
}

void ToCommandBodyForDebugUnRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.debugUnRegisterTask.modelId = taskInfo->u.debugUnRegisterTask.modelId;
}

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
rtError_t DebugRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId,
                                         const void *const address,
                                         const uint32_t curFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->u.debugRegisterForStreamTask.addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(address));
    auto dev = taskInfo->stream->Device_();
     if (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_DEBUG_REGISTER_WITH_VA_ADDR)) {
        uint64_t pptr = 0ULL;
        const rtError_t error = dev->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(dev->Id_()),
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(address)), &pptr);
        ERROR_RETURN_MSG_INNER(error, "Convert memory address from virtual to dma physical failed!");
        RT_LOG(RT_LOG_DEBUG, "pptr offset=%#" PRIx64, pptr);
        taskInfo->u.debugRegisterForStreamTask.addr = pptr;
    }

    taskInfo->type = TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM;
    taskInfo->typeName = "DEBUG_REGISTER_FOR_STREAM";
    taskInfo->u.debugRegisterForStreamTask.streamId = stmId;
    taskInfo->u.debugRegisterForStreamTask.flag = curFlag;

    return RT_ERROR_NONE;
}

void ToCommandBodyForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.debugRegisterForStreamTask.addr = taskInfo->u.debugRegisterForStreamTask.addr;
    RT_LOG(RT_LOG_DEBUG, "command->u.debugRegisterTask.addr=%#" PRIx64, command->u.debugRegisterForStreamTask.addr);
    command->u.debugRegisterForStreamTask.streamId = taskInfo->u.debugRegisterForStreamTask.streamId;
    command->u.debugRegisterForStreamTask.flag = taskInfo->u.debugRegisterForStreamTask.flag;
}

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

rtError_t DebugUnRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "DEBUG_UNREGISTER_FOR_STREAM";
    taskInfo->type = TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM;
    taskInfo->u.debugUnRegisterForStreamTask.streamId = stmId;
    return RT_ERROR_NONE;
}

void ToCmdBodyForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.debugUnRegisterForStreamTask.streamId = taskInfo->u.debugUnRegisterForStreamTask.streamId;
}

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

}  // namespace runtime
}  // namespace cce