/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ccu_sqe.hpp"
#include "stream.hpp"
#include "error_message_manage.hpp"
#include "task_execute_time.h"

namespace cce {
namespace runtime {
constexpr uint8_t TASK_SQE_NUM_TWO = 2U;

void ConstructDavidSqeForCcuLaunchTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsCcuSqe * const sqe = &(command->ccuSqe);
    Stream * const stream = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_CCU;

    CcuLaunchTaskInfo *tskinfo = &(taskInfo->u.ccuLaunchTask);
    sqe->resv.ccuResvDesc2.missionId = tskinfo->missionId;
    sqe->resv.ccuResvDesc2.dieId = tskinfo->dieId;
    sqe->resv.ccuResvDesc2.ccuSize = tskinfo->ccu_size;
    sqe->kernelCredit = static_cast<uint8_t>(GetCCUCredit(tskinfo->timeout));
    sqe->timeout = tskinfo->timeout;
    sqe->sqeLength = 1U;
    sqe->instStartId = tskinfo->instStartId;
    sqe->instCnt = tskinfo->instCnt;
    sqe->instAddrKeyValue = tskinfo->key;

    uint32_t *args = tskinfo->args;
    for (uint32_t i = 0U; i < CCU_1ST_SQE_ARGS_LEN; i++) {
        sqe->usrData[i] = args[i];
    }
    rtDavidSqe_t *sqeAddr = command + 1U;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + 1U;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    const errno_t ret = memcpy_s(sqeAddr, sizeof(rtDavidStarsCommonSqe_t),
        (args + CCU_1ST_SQE_ARGS_LEN), (sizeof(uint32_t) * CCU_2ND_SQE_LEFT_LEN));
    if (ret != EOK) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed, ret=%d, src size=%zu, dst size=%zu",
            ret, sizeof(rtDavidStarsCommonSqe_t), (sizeof(uint32_t) * CCU_2ND_SQE_LEFT_LEN));
        return;
    }
    PrintDavidSqe(command, "CcuLaunchTask Part0");
    PrintDavidSqe(sqeAddr, "CcuLaunchTask Part1");
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%hu, task_id=%hu, missionId=%hu, dieId=%hu, instStartId=%hu, "
        "instCnt=%hu", stream->Device_()->Id_(), stream->Id_(), taskInfo->id, tskinfo->missionId, tskinfo->dieId,
        tskinfo->instStartId, tskinfo->instCnt);
    return;
}

template<typename T>
static void FusionCcuSubSqeCommonInit(const rtCcuTaskInfo_t * const subInfo, const TaskInfo *const taskInfo, uint8_t taskCnt,
    T  const sqe)
{
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    Stream *const stm = taskInfo->stream;

    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_FUSION;
    sqe->header.lock = 0U;
    sqe->header.unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.ptrMode = 0U;
    sqe->header.rttMode = 0U;
    sqe->header.headUpdate = 0U;
    sqe->header.reserved = 0U;
    sqe->header.blockDim = 0U;
    sqe->header.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->header.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);

    /* word2 */
    sqe->taskCnt = taskCnt - 1U;
    sqe->resv.ccuResvDesc1.missionId = subInfo->missionId;
    sqe->resv.ccuResvDesc1.dieId = subInfo->dieId;
    sqe->resv.ccuResvDesc1.res1 = 0U;
    sqe->resv.ccuResvDesc1.aic = fusionKernelTask->aicAivType;
    sqe->resv.ccuResvDesc1.subType = fusionKernelTask->sqeSubType;
    sqe->resv.ccuResvDesc1.ccuSize = (sqe->taskCnt == 0U) ? 0U : 1U;

    /* word3 */
    sqe->sqeLength = fusionKernelTask->sqeLen - 1U;
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->timeout = subInfo->timeout;
    sqe->res4 = 0U;

    /* word4-5 */
    sqe->instStartId = subInfo->instStartId;
    sqe->instCnt = subInfo->instCnt;
    sqe->instAddrKeyValue = subInfo->key;

    return;
}

static rtError_t ConstructCcuSubSqeFor128B(const rtCcuTaskInfo_t * const subInfo, rtDavidSqe_t * const davidSqe,
    const TaskInfo * const taskInfo, uint32_t &sqeIndex, uint8_t taskCnt, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    uint32_t pos = taskInfo->id + sqeIndex;
    if (sqBaseAddr != 0ULL) {
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    RtDavidStarsCcuSqe * const sqe = &(sqeAddr->ccuSqe);
    FusionCcuSubSqeCommonInit(subInfo, taskInfo, taskCnt, sqe);

    /* word6-15 memcpy, 10*4=40B */
    constexpr size_t firstCpySize = sizeof(uint32_t) * 10ULL;
    errno_t ret = memcpy_s(RtPtrToPtr<uint8_t *>(sqe) + sizeof(rtDavidSqe_t)-firstCpySize, firstCpySize,
        RtPtrToPtr<const uint8_t *>(subInfo->args), firstCpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s part1 failed,retCode=%d,"
        " size=%zu.", ret, firstCpySize);

    /* second ccu sqe part: 16*4=64 Byte */
    constexpr size_t secondCpySize = sizeof(rtDavidSqe_t);
    rtDavidSqe_t *sqeAddr1 = davidSqe + sqeIndex + 1U;
    if (sqBaseAddr != 0ULL) {
        pos = taskInfo->id + sqeIndex + 1U;
        sqeAddr1 = GetSqPosAddr(sqBaseAddr, pos);
    }

    ret = memcpy_s(sqeAddr1, sizeof(rtDavidSqe_t),
        (RtPtrToPtr<const uint8_t *>(&(subInfo->args[firstCpySize/8U]))), secondCpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s part2 failed, retCode=%d,"
        " size=%zu.", ret, secondCpySize);

    RT_LOG(RT_LOG_INFO, "taskIdx=%d, sqeIndex=%u, missionId=%hhu, dieId=%hhu, instStartId=%hd, instCnt=%hu,"
        "instAddrKeyValue=%u.", taskInfo->id, sqeIndex, subInfo->missionId, subInfo->dieId, subInfo->instStartId,
        subInfo->instCnt, subInfo->key);

    PrintDavidSqe(sqeAddr,  "128B FusionKernelTask-Ccu-1part");
    PrintDavidSqe(sqeAddr1,  "128B FusionKernelTask-Ccu-2part");

    sqeIndex += 2U;
    return RT_ERROR_NONE;
}

static rtError_t ConstructCcuSubSqeFor32B(const rtCcuTaskInfo_t * const subInfo, rtDavidSqe_t * const davidSqe,
    const TaskInfo * const taskInfo, uint32_t sqeIndex, uint32_t idx, uint8_t taskCnt, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + sqeIndex;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    /* word6-7 memcpy, 2*4=8B */
    constexpr uint8_t cpySize = sizeof(uint32_t) * 2;
    constexpr int32_t moveSize = static_cast<int32_t>(sizeof(RtDavidStarsCcuSqe32B) - cpySize);

    RtDavidStarsCcuSqe32B * const sqe = &(sqeAddr->ccuSqe32B[idx]);
    FusionCcuSubSqeCommonInit(subInfo, taskInfo, taskCnt, sqe);

    const errno_t ret = memcpy_s(RtPtrToPtr<uint8_t *>(sqe) + moveSize, cpySize, subInfo->args, cpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s failed,retCode=%d, Size=%d(bytes).",
        ret, cpySize);

    RT_LOG(RT_LOG_INFO, "taskIdx=%u, sqeIndex=%u, missionId=%hhu, dieId=%hhu, instStartId=%hu, instCnt=%hu,"
        "instAddrKeyValue=%u.", taskInfo->id, sqeIndex, subInfo->missionId, subInfo->dieId, subInfo->instStartId,
        subInfo->instCnt, subInfo->key);

    PrintDavidSqe(sqeAddr, "32B FusionKernelTask-Ccu", sizeof(RtDavidStarsCcuSqe32B));
    return RT_ERROR_NONE;
}

rtError_t ConstructCcuSubSqe(const TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    const uint32_t taskIdx, const uint64_t sqBaseAddr)
{
    rtError_t error = RT_ERROR_NONE;
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t * const fusionKernelInfo =
        static_cast<rtFunsionTaskInfo_t *>(const_cast<void *>(fusionKernelTask->fusionKernelInfo));
    rtCcuTaskGroup_t * const ccuInfo = &(fusionKernelInfo->subTask[taskIdx].task.ccuInfo);

    // 双die num奇数返错 0x18 -> 11000
    const bool isDoubleDie = (fusionKernelTask->sqeSubType & 0x18U) == 0x18U ? true : false;
    const uint8_t taskNum = static_cast<uint8_t>(ccuInfo->taskNum);
    const uint8_t taskCnt = isDoubleDie ? taskNum / 2U : taskNum;

    if (ccuInfo->ccuTaskInfo[0].argSize == RT_CCU_SQE32B_ARGS_SIZE) {
        uint32_t taskNum32B = ccuInfo->taskNum;
        const bool isOddNum = (taskNum32B % 2U == 1U);
        taskNum32B = isOddNum ? (taskNum32B - 1U) : taskNum32B;
        for (uint32_t i = 0U; i < taskNum32B; i += TASK_SQE_NUM_TWO) {
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[i]), davidSqe, taskInfo, sqeIndex, 0, taskCnt,
                                             sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[i + 1U]), davidSqe, taskInfo, sqeIndex, 1, taskCnt,
                                             sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
            sqeIndex += 1U;
        }
        // 32B sqe 是单数
        if (isOddNum) {
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[taskNum]), davidSqe, taskInfo, sqeIndex, 0,
                                             taskCnt, sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
        }
    } else {
        for (uint32_t i = 0;i < ccuInfo->taskNum; i++) {
            error = ConstructCcuSubSqeFor128B(&(ccuInfo->ccuTaskInfo[i]), davidSqe, taskInfo, sqeIndex, taskCnt,
                                              sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor128B failed.");
        }
    }
    sqeIndex = 4U;
    return error;
}
}  // namespace runtime
}  // namespace cce
