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
#include "cq_adapter.hpp"
#include "task_info_base.hpp"
#include "stars_david.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

static inline uint64_t StarsCqGetTimestamp(const rtStarsV2Cqe_t* const starsCqe)
{
    uint64_t timestamp;

    timestamp = static_cast<uint64_t>((static_cast<uint64_t>(starsCqe->cqeStatus.sysCnt.syscntHigh)) << UINT32_BIT_NUM);
    timestamp |= static_cast<uint64_t>(starsCqe->cqeStatus.sysCnt.syscntLow);

    return timestamp;
}

static inline uint8_t StarsCqGetSqeType(const rtStarsV2Cqe_t* const starsCqe)
{
    return starsCqe->cqeStatus.errorInfo.sqeType;
}

static inline bool StarsCqIsDvppType(const rtStarsV2Cqe_t* const starsCqe)
{
    return (StarsCqGetSqeType(starsCqe) >= RT_DAVID_SQE_TYPE_VPC) &&
           (StarsCqGetSqeType(starsCqe) <= RT_DAVID_SQE_TYPE_JPEGD); /* dvpp sqe type, 12~14 */
}

static inline bool StarsCqIsAsyncDmaType(const rtStarsV2Cqe_t* const starsCqe)
{
    return (StarsCqGetSqeType(starsCqe) == RT_DAVID_SQE_TYPE_UBDMA) ||
           (StarsCqGetSqeType(starsCqe) == RT_DAVID_SQE_TYPE_ASYNCDMA); /* async sqe type, 9~10 */
}

static inline uint8_t StarsCqGetWarnType(const rtStarsV2Cqe_t* const starsCqe)
{
    return static_cast<uint8_t>(starsCqe->warn << 6U); /* starsCqe warn offset: 6 */
}

static inline uint8_t StarsCqGetErrType(const rtStarsV2Cqe_t* const starsCqe)
{
    return static_cast<uint8_t>((starsCqe->cqeStatus.sysCnt.syscntLow & 0x3FU) | StarsCqGetWarnType(starsCqe));
}

static inline uint32_t StarsCqGetErrCode(const rtStarsV2Cqe_t* const starsCqe)
{
    return starsCqe->cqeStatus.sysCnt.syscntHigh;
}

static inline uint32_t StarsCqGetIntErr(const rtStarsV2Cqe_t* const starsCqe)
{
    return starsCqe->cqeStatus.dvppInfo.intErr;
}

static inline bool StarsCqHasSyscnt(const rtStarsV2Cqe_t* const starsCqe)
{
    return (((starsCqe->notifyRecord == 1) || (starsCqe->placeHolder == 1)) && (starsCqe->errorBit == 0));
}

/* need to adapt stars_v2 */
void ConvertStarsCqeToRtCqe(const rtStarsV2Cqe_t* const starsCqe, rtCqReport_t* const rtCqe)
{
    if (StarsCqHasSyscnt(starsCqe)) {
        rtCqe->u.timeStamp = StarsCqGetTimestamp(starsCqe);
        rtCqe->sqeType =
            (starsCqe->notifyRecord != 0) ? RT_DAVID_SQE_TYPE_NOTIFY_RECORD : RT_DAVID_SQE_TYPE_PLACE_HOLDER;
        rtCqe->errorCode = 0;
        /* No error, get warning */
        rtCqe->errorType = StarsCqGetWarnType(starsCqe);
    } else {
        rtCqe->u.value = 0UL;
        rtCqe->sqeType = StarsCqGetSqeType(starsCqe);
        if (StarsCqIsDvppType(starsCqe)) {
            rtCqe->errorCode = StarsCqGetIntErr(starsCqe);
        } else {
            rtCqe->errorCode = StarsCqGetErrCode(starsCqe);
        }
        rtCqe->errorType = StarsCqGetErrType(starsCqe);
        if (StarsCqIsAsyncDmaType(starsCqe)) {
            rtCqe->u.info[0].jettyId = starsCqe->cqeStatus.ubdmaInfo.jettyId0;
            rtCqe->u.info[1].jettyId = starsCqe->cqeStatus.ubdmaInfo.jettyId1;
            rtCqe->u.info[0].status = starsCqe->cqeStatus.ubdmaInfo.status0;
            rtCqe->u.info[0].subStatus = starsCqe->cqeStatus.ubdmaInfo.subStatus0;
            rtCqe->u.info[1].status = starsCqe->cqeStatus.ubdmaInfo.status1;
            rtCqe->u.info[1].subStatus = starsCqe->cqeStatus.ubdmaInfo.subStatus1;
        }
    }

    rtCqe->streamId = starsCqe->streamId;
    rtCqe->taskId = starsCqe->taskId;
    rtCqe->sqId = starsCqe->sqId;
    rtCqe->sqHead = starsCqe->sqHead;
    rtCqe->nextTaskVld = starsCqe->cqeStatus.errorInfo.nextTaskVld;
    rtCqe->notifyAttached = starsCqe->cqeStatus.errorInfo.notifyAttached;
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
        rtStarsV2Cqe_t phyCqReportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
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
