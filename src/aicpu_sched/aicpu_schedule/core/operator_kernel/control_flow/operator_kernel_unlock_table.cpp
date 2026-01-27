/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_kernel_unlock_table.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_resource_manager.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_UNLOCK_TABLE = "unlockTable";
}  // namespace

int32_t OperatorKernelUnlockTable::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start ModelUnlockTable. modelId=%u, streamId=%u, taskId=%u.",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const UnlockTableTaskParam * const unlockParam =
        PtrToPtr<void, UnlockTableTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    const uint32_t tableId = unlockParam->tableId;

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Cannot get model by modelId:[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    if (!model->IsTableLocked(tableId)) {
        aicpusd_warn("table[%u] has not been locked before", tableId);
        return AICPU_SCHEDULE_OK;
    }

    TableLockManager::GetInstance().UnLockTable(tableId);
    model->ClearLockedTable(tableId);

    // send unlock event
    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = model->GetId();
    subEventInfo.para.unlockTableInfo.tableId = tableId;
    return AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
        AICPU_SUB_EVENT_TABLE_UNLOCK,
        CP_DEFAULT_GROUP_ID,
        true);
}


REGISTER_OPERATOR_KERNEL(KERNEL_UNLOCK_TABLE, OperatorKernelUnlockTable);
}  // namespace AicpuSchedule