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
        // do nothing, tiny support logic cq only
    }

    realCnt = cnt;

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
