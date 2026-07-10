/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_error.hpp"
#include "notify_enum_desc.hpp"
#include "cond_enum_desc.hpp"
#include "device_enum_desc.hpp"
#include "capture_model_enum_desc.hpp"
#include "osal.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "elf.hpp"
#include "runtime/kernel.h"
#include "error_message_manage.hpp"
#include "capture_model_utils.hpp"
#include "npu_driver.hpp"
#include "simd_memsetd32.h"
#include "common_memset_d32.h"

namespace cce {
namespace runtime {
static string g_fusionSubTypeStr[RT_FUSION_END] = {
    "HCOM",
    "AICPU",
    "AIC",
    "CCU"
};
static unordered_set<string> g_fusionAllowedList {
    "HCOMAIC",
    "AICPUAIC",
    "CCUAIC",
    "CCU"
};

rtError_t ApiErrorDecorator::WriteValuePtr(void * const writeValueInfo, Stream * const stm,
    void * const pointedAddr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(writeValueInfo, RT_ERROR_INVALID_VALUE, "Writing data to the specified memory");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(pointedAddr, RT_ERROR_INVALID_VALUE, "Writing data to the specified memory");
    return impl_->WriteValuePtr(writeValueInfo, stm, pointedAddr);
}

rtError_t ApiErrorDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                             const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(retCntNotify, RT_ERROR_INVALID_VALUE, "CntNotify creation");
    int32_t realDeviceId;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "Failed to convert the user device ID %d to driver device ID.", deviceId);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(!((flag == RT_NOTIFY_FLAG_DEFAULT) || (flag == RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV)),
        RT_ERROR_INVALID_VALUE, NotifyFlagToString(flag), "flag", "RT_NOTIFY_FLAG_DEFAULT(0) or RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV(1)");
    return impl_->CntNotifyCreate(realDeviceId, retCntNotify, flag);
}

rtError_t ApiErrorDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "CntNotify destruction");
    return impl_->CntNotifyDestroy(inCntNotify);
}

rtError_t ApiErrorDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                             const rtCntNtyRecordInfo_t * const info)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "CntNotify recording");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(info, RT_ERROR_INVALID_VALUE, "CntNotify recording");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(((info->mode >= RECORD_MODE_MAX) || (info->mode == RECORD_INVALID_MODE)), 
        RT_ERROR_INVALID_VALUE, RecordModeToString(info->mode), "info->mode",
        "RECORD_STORE_MODE(0), RECORD_ADD_MODE(1), RECORD_WRITE_BIT_MODE(2) or RECORD_CLEAR_BIT_MODE(4)");
    const rtError_t error = impl_->CntNotifyRecord(inCntNotify, stm, info);
    ERROR_RETURN(error, "count notify record failed.");
    return error;
}

rtError_t ApiErrorDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                      const rtCntNtyWaitInfo_t * const info)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "Waiting for CntNotify");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(info, RT_ERROR_INVALID_VALUE, "Waiting for CntNotify");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME((info->mode >= WAIT_MODE_MAX), RT_ERROR_INVALID_VALUE, 
        WaitModeToString(info->mode), "info->mode", "[0, " + std::to_string(WAIT_MODE_MAX) + ")");
    const rtError_t error = impl_->CntNotifyWaitWithTimeout(inCntNotify, stm, info);
    ERROR_RETURN(error, "count notify record failed.");
    return error;
}

rtError_t ApiErrorDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "CntNotify reset");
    const rtError_t error = impl_->CntNotifyReset(inCntNotify, stm);
    ERROR_RETURN(error, "count notify reset failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                                 rtNotifyType_t const regType)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "Obtaining the on-device address of a CntNotify object");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(cntNotifyAddress, RT_ERROR_INVALID_VALUE, "Obtaining the on-device address of a CntNotify object");
    return impl_->GetCntNotifyAddress(inCntNotify, cntNotifyAddress, regType);
}

rtError_t ApiErrorDecorator::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(inCntNotify, RT_ERROR_INVALID_VALUE, "Obtaining the ID of a CntNotify object");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(notifyId, RT_ERROR_INVALID_VALUE, "Obtaining the ID of a CntNotify object");
    return impl_->GetCntNotifyId(inCntNotify, notifyId);
}

rtError_t ApiErrorDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(info, RT_ERROR_INVALID_VALUE, "Writing data to the specified memory");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(((static_cast<uint32_t>(info->size) >= WRITE_VALUE_SIZE_TYPE_BUFF) ||
        (info->size == WRITE_VALUE_SIZE_TYPE_INVALID)), RT_ERROR_INVALID_VALUE,
        WriteValueSizeTypeToString(info->size), "info->size",
        "[1, " + std::to_string(WRITE_VALUE_SIZE_TYPE_BUFF) + ")");
    const uint64_t temp = 0ULL;
    const uint64_t info_size = static_cast<uint64_t>(info->size) - 1;
    COND_RETURN_AND_MSG_OUTER(static_cast<bool>((~(~temp << info_size )) & info->addr),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, "Writing data to the specified memory", 
        std::to_string(info->addr), "info->addr", "Address is not aligned by size " + std::to_string(info->size));
    return impl_->WriteValue(info, stm);
}

rtError_t ApiErrorDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(taskInfo, RT_ERROR_INVALID_VALUE, "CCU task delivery");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(taskInfo->args, RT_ERROR_INVALID_VALUE, "CCU task delivery");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC((taskInfo->instCnt == RT_CCU_INST_CNT_INVALID), RT_ERROR_INVALID_VALUE,
        "CCU task delivery", taskInfo->instCnt, "not equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC((taskInfo->instStartId >= RT_CCU_INST_START_MAX), RT_ERROR_INVALID_VALUE,
        "CCU task delivery", taskInfo->instStartId, "[0, " + std::to_string(RT_CCU_INST_START_MAX) + ")");
    // 1 or 13 to sqe ccu size
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC(
        (taskInfo->argSize != RT_CCU_SQE_ARGS_LEN) && (taskInfo->argSize != RT_CCU_SQE_ARGS_LEN_32B), RT_ERROR_INVALID_VALUE,
        "CCU task delivery", taskInfo->argSize, std::to_string(RT_CCU_SQE_ARGS_LEN) + " or " + std::to_string(RT_CCU_SQE_ARGS_LEN_32B));
    return impl_->CCULaunch(taskInfo, stm);
}

rtError_t ApiErrorDecorator::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(devInfo, RT_ERROR_INVALID_VALUE, "Obtaining UB device information");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(static_cast<uint32_t>(cmd) >= QUERY_TYPE_BUFF, RT_ERROR_INVALID_VALUE, 
        UbDevQueryCmdToString(cmd), "cmd", "[0, " + std::to_string(QUERY_TYPE_BUFF) + ")");
    return impl_->UbDevQueryInfo(cmd, devInfo);
}

rtError_t ApiErrorDecorator::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(resInfo, RT_ERROR_INVALID_VALUE, "Obtaining the virtual address based on the device resource information mapping");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(addrInfo, RT_ERROR_INVALID_VALUE, "Obtaining the virtual address based on the device resource information mapping");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(addrInfo->len, RT_ERROR_INVALID_VALUE, "Obtaining the virtual address based on the device resource information mapping");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(addrInfo->resAddress, RT_ERROR_INVALID_VALUE, "Obtaining the virtual address based on the device resource information mapping");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME((resInfo->resType >= RT_RES_TYPE_MAX) || (resInfo->resType < 0), RT_ERROR_INVALID_VALUE, 
        DevResTypeToString(resInfo->resType), "resInfo->resType", "[0, " + std::to_string(RT_RES_TYPE_MAX) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME((resInfo->procType >= RT_PROCESS_CPTYPE_MAX) || (resInfo->procType < 0), RT_ERROR_INVALID_VALUE, 
        DevResProcTypeToString(resInfo->procType), "resInfo->procType", "[0, " + std::to_string(RT_PROCESS_CPTYPE_MAX) + ")");
    return impl_->GetDevResAddress(resInfo, addrInfo);
}

rtError_t ApiErrorDecorator::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(resInfo, RT_ERROR_INVALID_VALUE, "Unmapping the virtual address of the device");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(static_cast<uint32_t>(resInfo->resType) >= RT_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        DevResTypeToString(resInfo->resType), "resInfo->resType", "[0, " + std::to_string(RT_RES_TYPE_MAX) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(static_cast<uint32_t>(resInfo->procType) >= RT_PROCESS_CPTYPE_MAX, RT_ERROR_INVALID_VALUE, 
        DevResProcTypeToString(resInfo->procType), "resInfo->procType", "[0, " + std::to_string(RT_PROCESS_CPTYPE_MAX) + ")");
    return impl_->ReleaseDevResAddress(resInfo);
}

rtError_t ApiErrorDecorator::UbDbSend(rtUbDbInfo_t *const dbInfo, Stream *const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(dbInfo, RT_ERROR_INVALID_VALUE, "Delivering a UB doorbell task");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC((dbInfo->dbNum != UB_DOORBELL_NUM_MIN) && (dbInfo->dbNum != UB_DOORBELL_NUM_MAX),
        RT_ERROR_INVALID_VALUE, "Delivering a UB doorbell task", dbInfo->dbNum, "1 or 2");
    if (dbInfo->dbNum == UB_DOORBELL_NUM_MAX) {
        COND_RETURN_AND_MSG_OUTER((dbInfo->info[0].dieId == dbInfo->info[1].dieId) &&
                                (dbInfo->info[0].jettyId == dbInfo->info[1].jettyId) &&
                                (dbInfo->info[0].functionId == dbInfo->info[1].functionId),
            RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Delivering a UB doorbell task", "dbInfo->info[1]",
            RtFmtMsg("An entry with the same functionId %u, dieId %u, and jettyId %u already exists in the SQE",
                dbInfo->info[1].functionId, dbInfo->info[1].dieId, dbInfo->info[1].jettyId));
    }
    return impl_->UbDbSend(dbInfo, stm);
}

rtError_t ApiErrorDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(wqeInfo, RT_ERROR_INVALID_VALUE, "Delivering a UB Direct task");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(wqeInfo->wqe, RT_ERROR_INVALID_VALUE, "Delivering a UB Direct task");
    COND_RETURN_AND_MSG_OUTER((wqeInfo->wqeSize == 0 && wqeInfo->wqePtrLen != UB_DIRECT_WQE_MIN_LEN) ||
        (wqeInfo->wqeSize == 1 && wqeInfo->wqePtrLen != UB_DIRECT_WQE_MAX_LEN), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1017, "Delivering a UB Direct task", "wqeInfo->wqePtrLen or wqeInfo->wqeSize", 
        RtFmtMsg("Parameter wqeInfo->wqePtrLen %u and parameter wqeInfo->wqeSize %u do not match",
            wqeInfo->wqePtrLen, wqeInfo->wqeSize));
    return impl_->UbDirectSend(wqeInfo, stm);
}

static rtError_t CheckArgsForFusionKernel(const rtFusionArgsEx_t * const argsInfo)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(argsInfo, RT_ERROR_INVALID_VALUE, "Checking the validity of fusion kernel startup parameters");
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(argsInfo->args, RT_ERROR_INVALID_VALUE, "Checking the validity of fusion kernel startup parameters");
    const uint8_t aicpuTaskNum = argsInfo->aicpuNum;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC(aicpuTaskNum > FUSION_SUB_TASK_MAX_CPU_NUM, RT_ERROR_INVALID_VALUE,
        "Checking the validity of fusion kernel startup parameters",
        aicpuTaskNum, "[0, " + std::to_string(FUSION_SUB_TASK_MAX_CPU_NUM) + "]");
    if (argsInfo->isNoNeedH2DCopy == 0U) {
        if (argsInfo->aicpuNum > 0) {
            NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(argsInfo->aicpuArgs, RT_ERROR_INVALID_VALUE, "Checking the validity of fusion kernel startup parameters");
            for (uint8_t i = 0U; i < argsInfo->aicpuNum; i++) {
                COND_RETURN_AND_MSG_OUTER(argsInfo->aicpuArgs[i].soNameAddrOffset >= argsInfo->argsSize,
                    RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking the validity of fusion kernel startup parameters",
                    RtFmtMsg("argsInfo->aicpuArgs[%hu].soNameAddrOffset or argsInfo->argsSize", i),
                    RtFmtMsg("Parameter argsInfo->aicpuArgs[%hu].soNameAddrOffset %u should be less than parameter argsInfo->argsSize %u",
                        i, argsInfo->aicpuArgs[i].soNameAddrOffset, argsInfo->argsSize));
                COND_RETURN_AND_MSG_OUTER(argsInfo->aicpuArgs[i].kernelNameAddrOffset >= argsInfo->argsSize,
                    RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking the validity of fusion kernel startup parameters",
                    RtFmtMsg("argsInfo->aicpuArgs[%hu].kernelNameAddrOffset or argsInfo->argsSize", i),
                    RtFmtMsg("Parameter argsInfo->aicpuArgs[%hu].kernelNameAddrOffset %u should be less than parameter argsInfo->argsSize %u",
                        i, argsInfo->aicpuArgs[i].kernelNameAddrOffset, argsInfo->argsSize));
            }
        }
        if (argsInfo->hostInputInfoNum != 0U) {
            NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(argsInfo->hostInputInfoPtr, RT_ERROR_INVALID_VALUE, "Checking the validity of fusion kernel startup parameters");
            for (int16_t i = 0U; i < argsInfo->hostInputInfoNum; i++) {
                COND_RETURN_AND_MSG_OUTER(argsInfo->hostInputInfoPtr[i].addrOffset >= argsInfo->argsSize,
                    RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking the validity of fusion kernel startup parameters",
                    RtFmtMsg("argsInfo->hostInputInfoPtr[%hu].addrOffset or argsInfo->argsSize", i),
                    RtFmtMsg("Parameter argsInfo->hostInputInfoPtr[%hu].addrOffset %u should be less than parameter argsInfo->argsSize %u",
                        i, argsInfo->hostInputInfoPtr[i].addrOffset, argsInfo->argsSize));
                COND_RETURN_AND_MSG_OUTER(argsInfo->hostInputInfoPtr[i].dataOffset >= argsInfo->argsSize,
                    RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking the validity of fusion kernel startup parameters",
                    RtFmtMsg("argsInfo->hostInputInfoPtr[%hu].dataOffset or argsInfo->argsSize", i),
                    RtFmtMsg("Parameter argsInfo->hostInputInfoPtr[%hu].dataOffset %u should be less than parameter argsInfo->argsSize %u",
                        i, argsInfo->hostInputInfoPtr[i].dataOffset, argsInfo->argsSize));
            }
        }
    }
    RT_LOG(RT_LOG_INFO, "aicpuTaskNum=%hhu, args=%#" PRIx64 ", argsSize=%u, isNoNeedH2DCopy=%hhu, hostInputInfoNum=%hu.",
        aicpuTaskNum, argsInfo->args, argsInfo->argsSize, argsInfo->isNoNeedH2DCopy, argsInfo->hostInputInfoNum);
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo)
{
    Runtime * const rtInstance = Runtime::Instance();
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FUSION)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    // 1. check args  sub & 0x7 != 0
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(fusionInfo, RT_ERROR_INVALID_VALUE, "Fused operator task delivery");

    rtFunsionTaskInfo_t *fusionTask = static_cast<rtFunsionTaskInfo_t *>(fusionInfo);
    const uint32_t subTaskNum = fusionTask->subTaskNum;
    COND_RETURN_AND_MSG_OUTER((subTaskNum == 0U || subTaskNum > FUSION_SUB_TASK_MAX_NUM), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1012, "Fused operator task delivery", subTaskNum, "fusion subtask number",
        RtFmtMsg("The valid value range is [1, %u]", FUSION_SUB_TASK_MAX_NUM));

    string fusionList = "";
    for (uint32_t idx = 0U; idx < subTaskNum; idx++) {
        const rtFusionType_t subKernelType = fusionTask->subTask[idx].type;
        COND_RETURN_AND_MSG_OUTER((subKernelType >= RT_FUSION_END), RT_ERROR_INVALID_VALUE, ErrorCode::EE1012, "Fused operator task delivery",
            subKernelType, "fusion subtask type",
            RtFmtMsg("The value range of attribute type of parameter subtask whose index is %u should be (0, %u)", idx, RT_FUSION_END));
        fusionList += g_fusionSubTypeStr[subKernelType];
    }

    // check fusion task list is valid or not
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_TASK_FUSION_DOT_ONLY_AICPUAIC)) {
        COND_RETURN_AND_MSG_OUTER(g_fusionAllowedList.find(fusionList) == g_fusionAllowedList.end(), RT_ERROR_INVALID_VALUE,
            ErrorCode::EE1006, "Fused operator task delivery", "FusionList value " + fusionList,
            "Fusion tasks support only the combinations of HCOMM and AI Core, AI CPU and AI Core, CCU and AIC, or a single CCU task");
    } else {
        //  1952 only supports A3(aicpu + aic) task
        COND_RETURN_AND_MSG_OUTER(fusionList != "AICPUAIC", RT_ERROR_INVALID_VALUE,
            ErrorCode::EE1006, "Fused operator task delivery", "FusionList value " + fusionList,
            "Fusion tasks support only the combination of AI CPU and AI Core");
    }

    RT_LOG(RT_LOG_INFO, "fusion launch: subTaskNum=%u, fusion list=%s.", subTaskNum, fusionList.c_str());
    COND_PROC(fusionList == "CCU", return impl_->FusionLaunch(fusionInfo, stm, nullptr));

    const rtError_t error = CheckArgsForFusionKernel(argsInfo);
    ERROR_RETURN(error, "check argsInfo failed, retCode=%#x.", static_cast<uint32_t>(error));

    return impl_->FusionLaunch(fusionInfo, stm, argsInfo);
}

rtError_t ApiErrorDecorator::StreamTaskAbort(Stream * const stm)
{
    return impl_->StreamTaskAbort(stm);
}

rtError_t ApiErrorDecorator::StreamRecover(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_INVALID_VALUE, "Resuming tasks in a stream");
    COND_RETURN_WITH_NOLOG(!stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_DOT_STREAM), 
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    return impl_->StreamRecover(stm);
}

rtError_t ApiErrorDecorator::StreamTaskClean(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_INVALID_VALUE, "Clearing tasks in a stream");
    const bool isSupport =
        stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_DOT_STREAM) ||
        stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT);
    COND_RETURN_WITH_NOLOG(!isSupport, RT_ERROR_FEATURE_NOT_SUPPORT); 
    COND_RETURN_AND_MSG_OUTER(((stm->Flags() & RT_STREAM_PERSISTENT) == 0U), RT_ERROR_STREAM_INVALID, 
        ErrorCode::EE1011, "Clearing tasks in a stream", "RT_STREAM_PERSISTENT", "stream flag", 
        RtFmtMsg("Non-persistent stream (stream_id=%d) does not support stream task clearance", stm->Id_()));
    COND_RETURN_AND_MSG_OUTER((!stm->GetBindFlag()), RT_ERROR_STREAM_INVALID, ErrorCode::EE1017, "Clearing tasks in a stream",
        "stream", RtFmtMsg("Stream (stream_id=%d) must be bound to a model", stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(((stm->Flags() & RT_STREAM_AICPU) != 0U), RT_ERROR_STREAM_INVALID, 
        ErrorCode::EE1011, "Clearing tasks in a stream", "RT_STREAM_AICPU", "stream flag", 
        RtFmtMsg("AICPU stream (stream_id=%d) does not support stream task clearance", stm->Id_()));
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_STREAM_MODEL);
    COND_RETURN_AND_MSG_OUTER((!stm->Model_()->IsModelLoadComplete()), RT_ERROR_STREAM_INVALID, ErrorCode::EE1017, 
        "Clearing tasks in a stream", "stream",
        RtFmtMsg("Model (model_id=%u) where stream (stream_id=%d) is located has not been loaded. Clear stream tasks after the model is loaded",
        stm->Model_()->Id_(), stm->Id_()));
    COND_RETURN_WARN(IsStreamBindWithSubModel(stm), RT_ERROR_FEATURE_NOT_SUPPORT, "stream belongs to sub ACL Graph, does not support cleaning tasks");
    return impl_->StreamTaskClean(stm);
}

rtError_t ApiErrorDecorator::DeviceResourceClean(const int32_t devId)
{
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "Failed to convert the user device ID %d to driver device ID.", devId);
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "The driver device ID %d is invalid. The user device ID is %d, retCode=%#x", realDeviceId, devId, static_cast<uint32_t>(error));

    return impl_->DeviceResourceClean(realDeviceId);
}

rtError_t ApiErrorDecorator::GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(prog, RT_ERROR_INVALID_VALUE, "Obtaining the binary device start address of the operator");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(deviceBase, RT_ERROR_INVALID_VALUE, "Obtaining the binary device start address of the operator");
    return impl_->GetBinaryDeviceBaseAddr(prog, deviceBase);
}

rtError_t ApiErrorDecorator::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    Stream * const stm, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(fftsPlusTaskInfo, RT_ERROR_INVALID_VALUE, "Function Flow Task Scheduler (FFTS) Plus task delivery");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(fftsPlusTaskInfo->fftsPlusSqe, RT_ERROR_INVALID_VALUE, "Function Flow Task Scheduler (FFTS) Plus task delivery");
    ZERO_RETURN_AND_MSG_OUTER(fftsPlusTaskInfo->fftsPlusSqe->readyContextNum);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(fftsPlusTaskInfo->descBuf, RT_ERROR_INVALID_VALUE, "Function Flow Task Scheduler (FFTS) Plus task delivery");
    const rtFftsPlusSqe_t * const sqe = fftsPlusTaskInfo->fftsPlusSqe;

    COND_RETURN_AND_MSG_OUTER(CONTEXT_LEN * static_cast<uint32_t>(sqe->totalContextNum) !=
        fftsPlusTaskInfo->descBufLen, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Function Flow Task Scheduler (FFTS) Plus task delivery", "fftsPlusTaskInfo->descBufLen or fftsPlusTaskInfo->fftsPlusSqe->totalContextNum",
        RtFmtMsg("Parameter fftsPlusTaskInfo->descBufLen %zu should equal to the product of parameter"
            " fftsPlusTaskInfo->fftsPlusSqe->totalContextNum %u and %u", fftsPlusTaskInfo->descBufLen,
            static_cast<uint32_t>(sqe->totalContextNum), CONTEXT_LEN));

    const rtError_t error = impl_->FftsPlusTaskLaunch(fftsPlusTaskInfo, stm, flag);
    ERROR_RETURN(error, "FFTS plus launch failed");
    return error;
}

rtError_t ApiErrorDecorator::LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg)
{
    return impl_->LaunchDqsTask(stm, taskCfg);
}

rtError_t ApiErrorDecorator::MemGetInfoByDeviceId(
    uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(freeSize, RT_ERROR_INVALID_VALUE, "Obtaining memory information by device ID");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(totalSize, RT_ERROR_INVALID_VALUE, "Obtaining memory information by device ID");

    uint32_t realDeviceId;
    Runtime * const rt = Runtime::Instance();
    rtError_t error = rt->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", deviceId);
    
    int32_t cnt = 1;
    const auto npuDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    error = npuDrv->GetDeviceCount(&cnt);
    ERROR_RETURN(error, "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC(realDeviceId >= static_cast<uint32_t>(cnt),
        RT_ERROR_INVALID_VALUE, "Obtaining memory information by device ID", realDeviceId, "[0, " + std::to_string(cnt) + ")");

    error = impl_->MemGetInfoByDeviceId(realDeviceId, isHugeOnly, freeSize, totalSize);
    ERROR_RETURN(error, "Get memory info failed, deviceId=%u, isHugeOnly=%d, err=%#x.", 
        realDeviceId, isHugeOnly, static_cast<uint32_t>(error));
    return error;
}

rtError_t ApiErrorDecorator::GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
    const std::string &key, int64_t * const value)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(value, RT_ERROR_INVALID_VALUE, "Querying the attribute value of a specified device from platform information");
    return impl_->GetDeviceInfoFromPlatformInfo(deviceId, label, key, value);
}


rtError_t ApiErrorDecorator::MemsetD32(void * const dst, const uint64_t destMax,
                                           const uint32_t value, const uint64_t count)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(dst, RT_ERROR_INVALID_VALUE, "Setting the memory content to a specified 32-bit unsigned integer value synchronously");
    ZERO_RETURN_AND_MSG_OUTER(count);

    const uint64_t requiredBytes = static_cast<uint64_t>(count) * sizeof(uint32_t);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC(requiredBytes > destMax, RT_ERROR_INVALID_VALUE,
        "Setting the memory content to a specified 32-bit unsigned integer value synchronously",
                                         requiredBytes,
                                         "required bytes exceed destMax=" + std::to_string(destMax));

    const rtError_t error = impl_->MemsetD32(dst, destMax, value, count);
    ERROR_RETURN(error, "MemsetD32 sync failed, destMax=%" PRIu64 ", value=0x%x, count=%zu",
                 destMax, value, count);
    return error;
}

rtError_t ApiErrorDecorator::MemsetD32Async(void * const dst, const uint64_t destMax,
                                            const uint32_t value, const uint64_t count,
                                            Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(dst, RT_ERROR_INVALID_VALUE, "Setting the memory content to a specified 32-bit unsigned integer value asynchronously");
    ZERO_RETURN_AND_MSG_OUTER(count);

    const uint64_t requiredBytes = count * sizeof(uint32_t);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC(requiredBytes > destMax, RT_ERROR_INVALID_VALUE,
        "Setting the memory content to a specified 32-bit unsigned integer value asynchronously",
                                         requiredBytes,
                                         "required bytes exceed destMax=" + std::to_string(destMax));

    const rtError_t error = impl_->MemsetD32Async(dst, destMax, value, count, stm);
    ERROR_RETURN(error, "MemsetD32 async failed, destMax=%" PRIu64 ", value=0x%x, count=%zu, stream=%p",
                 destMax, value, count, stm);
    return error;
}

rtError_t ApiErrorDecorator::EventWorkModeSet(uint8_t mode)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME(mode > static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE), 
        RT_ERROR_INVALID_VALUE, CaptureEventModeToString(mode), "mode",
        "[0, " + std::to_string(static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE)) + "]");
    return impl_->EventWorkModeSet(mode);
}

rtError_t ApiErrorDecorator::EventWorkModeGet(uint8_t *mode)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(mode, RT_ERROR_INVALID_VALUE, "Obtaining the event working mode");
    return impl_->EventWorkModeGet(mode);
}

rtError_t ApiErrorDecorator::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(handle, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(evt, RT_ERROR_INVALID_VALUE, "Obtaining the IPC event handle");
    COND_RETURN_AND_MSG_OUTER(evt->GetEventFlag() != RT_EVENT_IPC, RT_ERROR_INVALID_VALUE, ErrorCode::EE1006,
        "Obtaining the IPC event handle", RtFmtMsg("Parameter evt.eventFlag_ value %" PRIu64, evt->GetEventFlag()),
        "Only IPC events are supported");
    return impl_->IpcGetEventHandle(evt, handle);
}

rtError_t ApiErrorDecorator::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(event, RT_ERROR_INVALID_VALUE, "Obtaining the event handle information and event pointer");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(handle, RT_ERROR_INVALID_VALUE, "Obtaining the event handle information and event pointer");
    RT_LOG(RT_LOG_INFO, "IpcOpenEventHandle start");
    return impl_->IpcOpenEventHandle(handle, event);
}

}
}
