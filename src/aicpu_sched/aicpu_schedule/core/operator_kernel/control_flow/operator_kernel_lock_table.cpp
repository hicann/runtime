/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_lock_table.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_LOCK_TABLE = "lockTable";
}  // namespace

int32_t OperatorKernelLockTable::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start ModelLockTable. modelId=%u, streamId=%u, taskId=%u.",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Cannot get model by modelId:[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const LockTableTaskParam * const lockParam =
        PtrToPtr<void, LockTableTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    const int32_t lockType = lockParam->lockType;
    const uint32_t tableId = lockParam->tableId;

    const auto triedTable = model->GetTableTryLock();
    if ((triedTable != INVALID_TABLE_ID) && (triedTable != static_cast<int64_t>(tableId))) {
        aicpusd_err("model[%u] was tring to lock table[%d], can not try to lock table[%u]",
            taskContext.modelId, triedTable, tableId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    model->SetTableTryLock(static_cast<int64_t>(tableId));

    EventWaitManager::TableUnlockWaitManager().ResetEventState(static_cast<size_t>(taskContext.modelId));
    do {
        bool lockRet = false;
        if (lockType == 0) {
            lockRet = TableLockManager::GetInstance().RdLockTable(tableId);
        } else if (lockType == 1) {
            lockRet = TableLockManager::GetInstance().WrLockTable(tableId);
        } else {
            aicpusd_err("Invalid lockType[%d].", lockType);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (lockRet) {
            model->RecordLockedTable(tableId);
            aicpusd_info("model[%u] lock table[%u], type[%d] success.", taskContext.modelId, tableId, lockType);
            model->SetTableTryLock(INVALID_TABLE_ID);
            break;
        }

        bool needWait = false;
        EventWaitManager::TableUnlockWaitManager().WaitEvent(static_cast<size_t>(taskContext.modelId),
            taskContext.streamId, needWait);
        if (needWait) {
            // pending
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            break;
        }
    } while (true);

    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_LOCK_TABLE, OperatorKernelLockTable);
}  // namespace AicpuSchedule