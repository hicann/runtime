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
#include "osal.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "elf.hpp"
#include "runtime/kernel.h"
#include "error_message_manage.hpp"
#include "runtime/mem.h"
#include "capture_model_utils.hpp"
#include "npu_driver.hpp"

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
    NULL_PTR_RETURN_MSG(writeValueInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(pointedAddr, RT_ERROR_INVALID_VALUE);
    return impl_->WriteValuePtr(writeValueInfo, stm, pointedAddr);
}

rtError_t ApiErrorDecorator::DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    NULL_PTR_RETURN_MSG_OUTER(stmList, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((type != RT_NOTSINKED_STREAM), RT_ERROR_INVALID_VALUE,
        "Invalid stream type=%d, valid type range is [0, %d)", type, RT_STREAM_TYPE_MAX);
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "devId=%d is invalid, retCode=%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "devId=%d is invalid, drv devId=%d, retCode=%#x", devId, realDeviceId, static_cast<uint32_t>(error));

    return impl_->DeviceGetStreamlist(realDeviceId, type, stmList);
}

rtError_t ApiErrorDecorator::DeviceGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    NULL_PTR_RETURN_MSG_OUTER(mdlList, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "devId=%d is invalid, retCode=%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "devId=%d is invalid, drv devId=%d, retCode=%#x", devId, realDeviceId, static_cast<uint32_t>(error));

    return impl_->DeviceGetModelList(realDeviceId, mdlList);
}

rtError_t ApiErrorDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                             const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(retCntNotify, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error device_id:%d is err:%#x", deviceId, static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(!((flag == RT_NOTIFY_FLAG_DEFAULT) || (flag == RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV)),
        RT_ERROR_INVALID_VALUE, flag, std::to_string(RT_NOTIFY_FLAG_DEFAULT) + " or " + std::to_string(RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV));
    return impl_->CntNotifyCreate(realDeviceId, retCntNotify, flag);
}

rtError_t ApiErrorDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    return impl_->CntNotifyDestroy(inCntNotify);
}

rtError_t ApiErrorDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                             const rtCntNtyRecordInfo_t * const info)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((info->mode >= RECORD_MODE_MAX) || (info->mode == RECORD_INVALID_MODE)), 
        RT_ERROR_INVALID_VALUE, info->mode, "[0, 3) & (3, " + std::to_string(static_cast<uint32_t>(RECORD_MODE_MAX)) + ")");
    const rtError_t error = impl_->CntNotifyRecord(inCntNotify, stm, info);
    ERROR_RETURN(error, "count notify record failed.");
    return error;
}

rtError_t ApiErrorDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                      const rtCntNtyWaitInfo_t * const info)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((info->mode >= WAIT_MODE_MAX), RT_ERROR_INVALID_VALUE, 
        info->mode, "[0, " + std::to_string(WAIT_MODE_MAX) + ")");
    const rtError_t error = impl_->CntNotifyWaitWithTimeout(inCntNotify, stm, info);
    ERROR_RETURN(error, "count notify record failed.");
    return error;
}

rtError_t ApiErrorDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->CntNotifyReset(inCntNotify, stm);
    ERROR_RETURN(error, "count notify reset failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                                 rtNotifyType_t const regType)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cntNotifyAddress, RT_ERROR_INVALID_VALUE);
    // Driver now only support NOTIFY_CNT_ST_SLICE for count notify
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((regType != NOTIFY_CNT_ST_SLICE), RT_ERROR_INVALID_VALUE, 
        regType, std::to_string(NOTIFY_CNT_ST_SLICE));
    return impl_->GetCntNotifyAddress(inCntNotify, cntNotifyAddress, regType);
}

rtError_t ApiErrorDecorator::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    NULL_PTR_RETURN_MSG_OUTER(inCntNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(notifyId, RT_ERROR_INVALID_VALUE);
    return impl_->GetCntNotifyId(inCntNotify, notifyId);
}

rtError_t ApiErrorDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(((static_cast<uint32_t>(info->size) >= WRITE_VALUE_SIZE_TYPE_BUFF) ||
        (info->size == WRITE_VALUE_SIZE_TYPE_INVALID)), RT_ERROR_INVALID_VALUE,
        "Write value size[%d] does not support, it should between [1, %d).", info->size,
        WRITE_VALUE_SIZE_TYPE_BUFF);
    const uint64_t temp = 0ULL;
    const uint64_t info_size = static_cast<uint64_t>(info->size) - 1;
    COND_RETURN_ERROR_MSG_INNER(static_cast<bool>((~(~temp << info_size )) & info->addr),
        RT_ERROR_INVALID_VALUE, "Address [%lu] is not aligned by awsize [%d].", info->addr, info->size);
    return impl_->WriteValue(info, stm);
}

rtError_t ApiErrorDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    NULL_PTR_RETURN_MSG(taskInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(taskInfo->args, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((taskInfo->instCnt == RT_CCU_INST_CNT_INVALID), RT_ERROR_INVALID_VALUE, 
        taskInfo->instCnt, "not equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((taskInfo->instStartId >= RT_CCU_INST_START_MAX), RT_ERROR_INVALID_VALUE, 
        taskInfo->instStartId, "[0, " + std::to_string(RT_CCU_INST_START_MAX) + ")");
        
    // 1 or 13 to sqe ccu size
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (taskInfo->argSize != RT_CCU_SQE_ARGS_LEN) && (taskInfo->argSize != RT_CCU_SQE_ARGS_LEN_32B), RT_ERROR_INVALID_VALUE, 
        taskInfo->argSize, std::to_string(RT_CCU_SQE_ARGS_LEN) + " or " + std::to_string(RT_CCU_SQE_ARGS_LEN_32B));
    return impl_->CCULaunch(taskInfo, stm);
}

rtError_t ApiErrorDecorator::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    NULL_PTR_RETURN_MSG(devInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(cmd) >= QUERY_TYPE_BUFF, RT_ERROR_INVALID_VALUE, 
        cmd, "[0, " + std::to_string(QUERY_TYPE_BUFF) + ")");
    return impl_->UbDevQueryInfo(cmd, devInfo);
}

rtError_t ApiErrorDecorator::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    NULL_PTR_RETURN_MSG(resInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(addrInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(addrInfo->len, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(addrInfo->resAddress, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((resInfo->resType >= RT_RES_TYPE_MAX) || (resInfo->resType < 0), RT_ERROR_INVALID_VALUE, 
        resInfo->resType, "[0, " + std::to_string(RT_RES_TYPE_MAX) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((resInfo->procType >= RT_PROCESS_CPTYPE_MAX) || (resInfo->procType < 0), RT_ERROR_INVALID_VALUE, 
        resInfo->procType, "[0, " + std::to_string(RT_PROCESS_CPTYPE_MAX) + ")");
    return impl_->GetDevResAddress(resInfo, addrInfo);
}

rtError_t ApiErrorDecorator::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    NULL_PTR_RETURN_MSG(resInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(resInfo->resType) >= RT_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        resInfo->resType, "[0, " + std::to_string(RT_RES_TYPE_MAX) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(resInfo->procType) >= RT_PROCESS_CPTYPE_MAX, RT_ERROR_INVALID_VALUE, 
        resInfo->procType, "[0, " + std::to_string(RT_PROCESS_CPTYPE_MAX) + ")");
    return impl_->ReleaseDevResAddress(resInfo);
}

rtError_t ApiErrorDecorator::UbDbSend(rtUbDbInfo_t *const dbInfo, Stream *const stm)
{
    NULL_PTR_RETURN_MSG(dbInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((dbInfo->dbNum != UB_DOORBELL_NUM_MIN) && (dbInfo->dbNum != UB_DOORBELL_NUM_MAX), 
        RT_ERROR_INVALID_VALUE, dbInfo->dbNum, "1 or 2");    
    if (dbInfo->dbNum == UB_DOORBELL_NUM_MAX) {
        COND_RETURN_OUT_ERROR_MSG_CALL((dbInfo->info[0].dieId == dbInfo->info[1].dieId) &&
                                       (dbInfo->info[0].jettyId == dbInfo->info[1].jettyId) &&
                                       (dbInfo->info[0].functionId == dbInfo->info[1].functionId),
            RT_ERROR_INVALID_VALUE, "An entry with the same functionId (%u), dieId (%u), and jettyId (%u) already exists in the SQE.",
            dbInfo->info[0].functionId, dbInfo->info[0].dieId, dbInfo->info[0].jettyId);
    }
    return impl_->UbDbSend(dbInfo, stm);
}

rtError_t ApiErrorDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(wqeInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(wqeInfo->wqe, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((wqeInfo->wqeSize == 0 && wqeInfo->wqePtrLen != UB_DIRECT_WQE_MIN_LEN) ||
        (wqeInfo->wqeSize == 1 && wqeInfo->wqePtrLen != UB_DIRECT_WQE_MAX_LEN), RT_ERROR_INVALID_VALUE,
        "Invalid parameter. wqeSize:%u and wqePtrLen:%u do not match.", wqeInfo->wqeSize, wqeInfo->wqePtrLen);
    return impl_->UbDirectSend(wqeInfo, stm);
}

static rtError_t CheckArgsForFusionKernel(const rtFusionArgsEx_t * const argsInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->args, RT_ERROR_INVALID_VALUE);
    const uint8_t aicpuTaskNum = argsInfo->aicpuNum;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(aicpuTaskNum > FUSION_SUB_TASK_MAX_CPU_NUM, RT_ERROR_INVALID_VALUE, 
        aicpuTaskNum, "[0, " + std::to_string(FUSION_SUB_TASK_MAX_CPU_NUM) + "]");
    if (argsInfo->isNoNeedH2DCopy == 0U) {
        if (argsInfo->aicpuNum > 0) {
            NULL_PTR_RETURN_MSG(argsInfo->aicpuArgs, RT_ERROR_INVALID_VALUE);
            for (uint8_t i = 0U; i < argsInfo->aicpuNum; i++) {
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->aicpuArgs[i].soNameAddrOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->aicpuArgs[%hu].soNameAddrOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->aicpuArgs[%hu].soNameAddrOffset = %u, parameter argsInfo->argsSize = %u.", 
                    i, i, argsInfo->aicpuArgs[i].soNameAddrOffset, argsInfo->argsSize);
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->aicpuArgs[i].kernelNameAddrOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->aicpuArgs[%hu].kernelNameAddrOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->aicpuArgs[%hu].kernelNameAddrOffset = %u, parameter argsInfo->argsSize = %u.",                    
                    i, i, argsInfo->aicpuArgs[i].kernelNameAddrOffset, argsInfo->argsSize);
            }
        }
        if (argsInfo->hostInputInfoNum != 0U) {
            COND_RETURN_OUT_ERROR_MSG_CALL(argsInfo->hostInputInfoPtr == nullptr,
                RT_ERROR_INVALID_VALUE, "host input info ptr is nullptr, invalid param.");
            for (int16_t i = 0U; i < argsInfo->hostInputInfoNum; i++) {
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->hostInputInfoPtr[i].addrOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->hostInputInfoPtr[%hu].addrOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->hostInputInfoPtr[%hu].addrOffset = %u, parameter argsInfo->argsSize = %u.", 
                    i, i, argsInfo->hostInputInfoPtr[i].addrOffset, argsInfo->argsSize);
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->hostInputInfoPtr[i].dataOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->hostInputInfoPtr[%hu].dataOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->hostInputInfoPtr[%hu].dataOffset = %u, parameter argsInfo->argsSize = %u.", 
                    i, i, argsInfo->hostInputInfoPtr[i].dataOffset, argsInfo->argsSize);                  
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
    NULL_PTR_RETURN_MSG(fusionInfo, RT_ERROR_INVALID_VALUE);

    rtFunsionTaskInfo_t *fusionTask = static_cast<rtFunsionTaskInfo_t *>(fusionInfo);
    const uint32_t subTaskNum = fusionTask->subTaskNum;
    COND_RETURN_OUT_ERROR_MSG_CALL((subTaskNum == 0U || subTaskNum > FUSION_SUB_TASK_MAX_NUM), RT_ERROR_INVALID_VALUE,
        "Fusion subtask num %u is invalid, its range should be in [1, %u].", subTaskNum, FUSION_SUB_TASK_MAX_NUM);

    string fusionList = "";
    for (uint32_t idx = 0U; idx < subTaskNum; idx++) {
        const rtFusionType_t subKernelType = fusionTask->subTask[idx].type;
        COND_RETURN_OUT_ERROR_MSG_CALL((subKernelType >= RT_FUSION_END), RT_ERROR_INVALID_VALUE,
            "The value range of attribute type %u of parameter subtask whose index is %u should be (0, %d).",
            static_cast<uint32_t>(subKernelType), idx, RT_FUSION_END);
        fusionList += g_fusionSubTypeStr[subKernelType];
    }

    // check fusion task list is valid or not
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_TASK_FUSION_DOT_ONLY_AICPUAIC)) {
        COND_RETURN_AND_MSG_OUTER(g_fusionAllowedList.find(fusionList) == g_fusionAllowedList.end(), RT_ERROR_INVALID_VALUE, 
            ErrorCode::EE1006, __func__, "fusionList=" + fusionList);
    } else {
        //  1952 only supports A3(aicpu + aic) task
        COND_RETURN_OUT_ERROR_MSG_CALL(fusionList != "AICPUAIC",
            RT_ERROR_INVALID_VALUE, "Fusion task list %s is invalid, not support.", fusionList.c_str());
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
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WITH_NOLOG(!stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_DOT_STREAM), 
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    return impl_->StreamRecover(stm);
}

rtError_t ApiErrorDecorator::StreamTaskClean(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    const bool isSupport =
        stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_DOT_STREAM) ||
        stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT);
    COND_RETURN_WITH_NOLOG(!isSupport, RT_ERROR_FEATURE_NOT_SUPPORT);
    COND_RETURN_ERROR_MSG_INNER((((stm->Flags() & RT_STREAM_PERSISTENT) == 0U) || (!stm->GetBindFlag())),
        RT_ERROR_STREAM_INVALID, "Stream must binded");
    COND_RETURN_ERROR_MSG_INNER(((stm->Flags() & RT_STREAM_AICPU) != 0U),
        RT_ERROR_STREAM_INVALID, "AICPU stream can not clean");
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_STREAM_MODEL);
    COND_RETURN_ERROR_MSG_INNER((!stm->Model_()->IsModelLoadComplete()),
        RT_ERROR_STREAM_INVALID, "Model not load complete");
    return impl_->StreamTaskClean(stm);
}

rtError_t ApiErrorDecorator::DeviceResourceClean(const int32_t devId)
{
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "devId=%d is invalid, retCode=%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "devId=%d is invalid, drv devId=%d, retCode=%#x", devId, realDeviceId, static_cast<uint32_t>(error));

    return impl_->DeviceResourceClean(realDeviceId);
}

rtError_t ApiErrorDecorator::GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(deviceBase, RT_ERROR_INVALID_VALUE);
    return impl_->GetBinaryDeviceBaseAddr(prog, deviceBase);
}

rtError_t ApiErrorDecorator::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    Stream * const stm, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(fftsPlusTaskInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(fftsPlusTaskInfo->fftsPlusSqe, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(fftsPlusTaskInfo->fftsPlusSqe->readyContextNum);
    NULL_PTR_RETURN_MSG_OUTER(fftsPlusTaskInfo->descBuf, RT_ERROR_INVALID_VALUE);
    const rtFftsPlusSqe_t * const sqe = fftsPlusTaskInfo->fftsPlusSqe;

    COND_RETURN_OUT_ERROR_MSG_CALL(
        ((CONTEXT_LEN) * (static_cast<uint32_t>(sqe->totalContextNum)) !=
        (static_cast<uint32_t>(fftsPlusTaskInfo->descBufLen))),
        RT_ERROR_INVALID_VALUE, "Invalid task information. descBufLen=%u(bytes), totalContextNum=%u.",
        static_cast<uint32_t>(fftsPlusTaskInfo->descBufLen), static_cast<uint32_t>(sqe->totalContextNum));

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
    NULL_PTR_RETURN_MSG_OUTER(freeSize, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(totalSize, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->MemGetInfoByDeviceId(deviceId, isHugeOnly, freeSize, totalSize);
    ERROR_RETURN(error, "Get memory info failed, deviceId=%u, isHugeOnly=%d, err=%#x.", 
        deviceId, isHugeOnly, static_cast<uint32_t>(error));
    return error;
}

rtError_t ApiErrorDecorator::GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
    const std::string &key, int64_t * const value)
{
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    return impl_->GetDeviceInfoFromPlatformInfo(deviceId, label, key, value);
}

rtError_t ApiErrorDecorator::GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "input error:deviceId:%u is err:%#x", deviceId, static_cast<uint32_t>(error));
    const auto npuDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    int32_t cnt = 1;
    error = npuDrv->GetDeviceCount(&cnt);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
        "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= static_cast<uint32_t>(cnt),
        RT_ERROR_INVALID_VALUE,
        "Get device info failed, invalid drv devId, current drv devId=%u , valid device range is [0, %d)",
        realDeviceId, cnt);

    return impl_->GetDeviceInfoByAttr(realDeviceId, attr, val);
}

rtError_t ApiErrorDecorator::EventWorkModeSet(uint8_t mode)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(mode > static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE), 
        RT_ERROR_INVALID_VALUE, mode, "[0, " + std::to_string(static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE)) + "]");
    return impl_->EventWorkModeSet(mode);
}

rtError_t ApiErrorDecorator::EventWorkModeGet(uint8_t *mode)
{
    NULL_PTR_RETURN_MSG_OUTER(mode, RT_ERROR_INVALID_VALUE);
    return impl_->EventWorkModeGet(mode);
}

rtError_t ApiErrorDecorator::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL(evt->GetEventFlag() != RT_EVENT_IPC, RT_ERROR_INVALID_VALUE,
        "only support RT_EVENT_IPC call rtIpcGetEventHandle, current flag %" PRIu64 ".", evt->GetEventFlag());
    return impl_->IpcGetEventHandle(evt, handle);
}

rtError_t ApiErrorDecorator::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    NULL_PTR_RETURN_MSG_OUTER(event, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    RT_LOG(RT_LOG_INFO, "IpcOpenEventHandle start");
    return impl_->IpcOpenEventHandle(handle, event);
}
}
}