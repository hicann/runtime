/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stream.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack(1)
struct RtDavidStarsCmoSqeArch9201 {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t cmoType : 2;
    uint32_t cmoId : 12;
    uint32_t res1 : 18;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3;

    /* word4 */
    uint32_t opcode : 8;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t stride : 2;
    uint32_t ie2 : 1;
    uint32_t compEn : 1;
    uint32_t allocate : 1;
    uint32_t victimHint : 2;
    uint32_t res4 : 11;

    /* word5 */
    uint16_t sqeId;
    uint8_t mapamPartId;
    uint8_t mpamns : 1;
    uint8_t pmg : 2;
    uint8_t qos : 4;
    uint8_t d2dOffsetFlag : 1;

    /* word6 */
    uint16_t srcStreamId;
    uint16_t srcSubStreamId;

    /* word7-15 */
    union {
        CmoStride00 strideMode0;
        CmoStride01 strideMode1;
        CmoStride10 strideMode2;
    } u;
};
#pragma pack(pop)

static void ConstructDavidArch9201CmoSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsCmoSqeArch9201* const sqe = reinterpret_cast<RtDavidStarsCmoSqeArch9201*>(&davidSqe->cmoSqe);
    SetCommonCmoParameters(sqe, taskInfo);
    sqe->allocate = 0U;
    sqe->victimHint = 0U;
    sqe->sqeId = 0U;
    sqe->d2dOffsetFlag = 0U;
    RT_LOG(
        RT_LOG_INFO,
        "ptr_mode=%u, length_inner=%u, op_code=0x%x, device_id=%u, stream_id=%d, task_id=%hu, "
        "task_sn=%u, cmo_id=%u.",
        static_cast<uint32_t>(sqe->header.ptrMode), static_cast<uint32_t>(sqe->u.strideMode2.lengthInner),
        static_cast<uint32_t>(sqe->opcode), taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id,
        taskInfo->taskSn, sqe->cmoId);
    PrintDavidSqe(davidSqe, "CmoTask");
}

static void ConstructDavidSqeForArch9201CmoTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    ConstructDavidSqeForCmoTaskCommon(taskInfo, sqe, sqeInfo, &ConstructDavidArch9201CmoSqe);
}

static bool CmoTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForDavidCmoTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    RegTaskFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_CMO, funcs);
    RegDavidSqeFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_CMO, &ConstructDavidSqeForArch9201CmoTask);

    return true;
}

static bool g_cmoTaskRegister = CmoTaskRegister();

} // namespace runtime
} // namespace cce
