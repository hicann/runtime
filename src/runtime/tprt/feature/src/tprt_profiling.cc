/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tprt_profiling.hpp"
#include "tprt.hpp"
#include "tprt_base.hpp"
#include "tprt_sqe_cqe.h"
#include "aprof_pub.h"
namespace cce {
namespace tprt {

TprtProfiling::TprtProfiling()
{

}

TprtProfiling::~TprtProfiling()
{

}

uint32_t TprtProfiling::TprtReportTask(uint64_t startTime, uint64_t endTime, uint32_t devId, TprtSqe_t headTask) const
{
    if (TprtManage::Instance()->getTprtTaskReportEnable()) {
        MsprofCompactInfo compactInfo{};
        compactInfo.data.dpuTack.startTime = startTime;
        compactInfo.timeStamp = endTime;
        compactInfo.data.dpuTack.deviceId = devId;
        compactInfo.data.dpuTack.taskId = headTask.commonSqe.sqeHeader.dfxId;
        compactInfo.data.dpuTack.taskType = headTask.commonSqe.sqeHeader.type;
        const int32_t ret = MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        if (ret != MSPROF_ERROR_NONE) {
            return ret;
        }
    }
    return 0;
}
}
}