/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars.hpp"
#include "cq_adapter.hpp"
#include "task_info_base.hpp"
#include "stars_sqe.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

#define RT_LOGIC_CQE_STREAM_ID_MASK (0x7FFFU)

static inline uint64_t StarsCqGetTimestamp(const rtStarsCqe_t* const starsCqe)
{
    uint64_t timestamp;

    timestamp = (uint64_t)(((uint64_t)starsCqe->cqeStatus.sysCnt.syscntHigh) << UINT32_BIT_NUM);
    timestamp |= (uint64_t)starsCqe->cqeStatus.sysCnt.syscntLow;

    return timestamp;
}

static inline uint8_t StarsCqGetSqeType(const rtStarsCqe_t* const starsCqe)
{
    return starsCqe->cqeStatus.errorInfo.sqeType;
}

static inline uint8_t StarsCqGetWarnType(const rtStarsCqe_t* const starsCqe)
{
    return (uint8_t)(starsCqe->warn << 6U); /* cqe warn offset: 6 */
}

static inline uint8_t StarsCqGetErrType(const rtStarsCqe_t* const starsCqe)
{
    return (uint8_t)((starsCqe->cqeStatus.sysCnt.syscntLow & 0x3F) | StarsCqGetWarnType(starsCqe));
}

static inline uint32_t StarsCqGetErrCode(const rtStarsCqe_t* const starsCqe)
{
    return starsCqe->cqeStatus.sysCnt.syscntHigh;
}

static inline bool StarsCqHasSyscnt(const rtStarsCqe_t* const starsCqe)
{
    return (((starsCqe->evt == 1) || (starsCqe->placeHolder == 1)) && (starsCqe->errorBit == 0));
}

void ConvertStarsCqeToRtCqe(const rtStarsCqe_t* const starsCqe, rtCqReport_t* const rtCqe)
{
    if (StarsCqHasSyscnt(starsCqe)) {
        rtCqe->u.timeStamp = StarsCqGetTimestamp(starsCqe);
        rtCqe->sqeType = (starsCqe->evt != 0) ? RT_STARS_SQE_TYPE_EVENT_RECORD : RT_STARS_SQE_TYPE_PLACE_HOLDER;
        rtCqe->errorCode = 0U;
        /* No error, get warning */
        rtCqe->errorType = StarsCqGetWarnType(starsCqe);
    } else {
        rtCqe->u.value = 0UL;
        rtCqe->sqeType = StarsCqGetSqeType(starsCqe);
        rtCqe->errorCode = StarsCqGetErrCode(starsCqe);
        rtCqe->errorType = StarsCqGetErrType(starsCqe);
    }
    rtCqe->streamId = starsCqe->streamId & RT_LOGIC_CQE_STREAM_ID_MASK;
    rtCqe->taskId = starsCqe->taskId;
    rtCqe->sqId = starsCqe->sqId;
    rtCqe->sqHead = starsCqe->sqHead;
    rtCqe->nextTaskVld = false;
    rtCqe->notifyAttached = false;
    rtCqe->reserved0 = 0U;
    rtCqe->reserved1 = 0U;
    rtCqe->reserved2 = 0UL;

    return;
}

rtError_t RtCqRecv(
    const CqWaitInfo& waitInfo, rtCqReport_t* const rtCqe, const uint32_t allocCnt, uint32_t& realCnt,
    const Device* const dev)
{
    const uint32_t maxCount = (allocCnt > RT_MILAN_MAX_QUERY_CQE_NUM) ? RT_MILAN_MAX_QUERY_CQE_NUM : allocCnt;
    uint32_t cnt = 0U;
    rtError_t error = RT_ERROR_NONE;

    if (waitInfo.isLogicCq) {
        rtLogicCqReport_t logicCqReportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
        error = dev->Driver_()->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t*>(logicCqReportInfo), maxCount, cnt);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        for (uint32_t index = 0U; index < cnt; index++) {
            ConvertLogicCqeToRtCqe(&logicCqReportInfo[index], &rtCqe[index]);
        }
    } else {
        rtStarsCqe_t phyCqReportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
        error = dev->Driver_()->CqReport(waitInfo, RtPtrToPtr<uint8_t*>(phyCqReportInfo), maxCount, cnt);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        for (uint32_t index = 0U; index < cnt; index++) {
            ConvertStarsCqeToRtCqe(&phyCqReportInfo[index], &rtCqe[index]);
        }
    }

    realCnt = cnt;

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
