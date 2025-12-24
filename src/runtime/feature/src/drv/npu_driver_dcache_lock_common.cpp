/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver_dcache_lock.hpp"
#include "base.hpp"
#include "runtime.hpp"
#include "errcode_manage.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "tsch_defines.h"

namespace cce {
namespace runtime {
rtError_t QueryDcacheLockStatus(uint32_t deviceId, uint32_t tsId, const void *dcacheAddr, bool &dCacheLockFlag)
{
    COND_RETURN_WARN(&halTsdrvCtl == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halTsdrvCtl does not exist.");
    ts_ctrl_msg_body_t queryDcacheLockStatusIn = {};
    ts_ctrl_msg_body_t queryDcacheLockStatusAck = {};
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);

    queryDcacheLockStatusIn.type = OP_QUERY_DCACHE_LOCK_STATUS;
    const uint64_t stackPhyBase = RtPtrToValue(dcacheAddr);
    queryDcacheLockStatusIn.u.query_dcache_lock_info.stack_phy_base_h =
        static_cast<uint32_t>((stackPhyBase >> UINT32_BIT_NUM) & MAX_UINT32_NUM);
    queryDcacheLockStatusIn.u.query_dcache_lock_info.stack_phy_base_l =
        static_cast<uint32_t>(stackPhyBase & MAX_UINT32_NUM);

    struct tsdrv_ctrl_msg para;
    para.tsid = tsId;
    para.msg_len = sizeof(ts_ctrl_msg_body_t);
    para.msg = static_cast<void *>(&queryDcacheLockStatusIn);

    const drvError_t drvRet = halTsdrvCtl(deviceId,
        TSDRV_CTL_CMD_CTRL_MSG,
        static_cast<void *>(&para),
        sizeof(tsdrv_ctrl_msg),
        static_cast<void *>(&queryDcacheLockStatusAck),
        &ackCount);

    COND_RETURN_WARN(drvRet != DRV_ERROR_NONE,
        RT_GET_DRV_ERRCODE(drvRet),
        "device_id=%u, ts_id=%u, drvRetCode=%u.",
        deviceId,
        tsId,
        drvRet);

    ts_query_dcache_lock_ack_info_t ackInfo = queryDcacheLockStatusAck.u.query_dcache_lock_ack_info;
    RT_LOG(RT_LOG_INFO,
        "get ack info from ts, status=%u, stack_phy_base_h=%llx, stack_phy_base_l=%llx, drvRet=%u.",
        ackInfo.status,
        ackInfo.stack_phy_base_h,
        ackInfo.stack_phy_base_l,
        drvRet);
    // 当有进程设置过之后，第二次就不需要再次lock了
    if (ackInfo.status != 0U) {
        dCacheLockFlag = true;
    } else {
        return RT_ERROR_NONE;
    }

    // 驱动会保证每次申请的VA相同，所以一旦dCacheLockFlag_为true与stackPhyBase32k_
    // 每次一致基本等价，这里增加一下日志维测
    const uint64_t ackStackPhyBase = (static_cast<uint64_t>(ackInfo.stack_phy_base_h) << UINT32_BIT_NUM |
                                      static_cast<uint64_t>(ackInfo.stack_phy_base_l));
    if (ackStackPhyBase != stackPhyBase) {
        RT_LOG(RT_LOG_EVENT,
            "Stack addr=%llx for ts buffer mode is not same with current stack addr=%llx.",
            ackStackPhyBase,
            stackPhyBase);
    }

    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
