/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_david.hpp"
#include "model_execute_task.h"
#include "model_graph_task.h"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "driver.hpp"
#include "stars.hpp"
#include "task_fail_callback_manager.hpp"
#include "davinci_kernel_task.h"
#include "event_task.h"
#include "memory_task.h"
#include "rdma_task.h"
#include "reduce_task.h"
#include "cond_op_stream_task.h"
#include "cond_op_label_task.h"
#include "debug_task.h"
#include "stream_task.h"
#include "davinci_multiple_task.h"
#include "common_task.h"
#include "cmo_task.h"
#include "dump_task.h"
#include "barrier_task.h"
#include "model_maintaince_task.h"
#include "notify_task.h"
#include "timeout_set_task.h"
#include "ringbuffer_maintain_task.h"
#include "model_update_task.h"
#include "model_to_aicpu_task.h"
#include "maintenance_task.h"
#include "davinci_kernel_task.h"
#include "ccu_task.hpp"
#include "error_code.h"
#include "task_manager.h"
#include "task_manager_david.h"
#include "device_error_proc.hpp"
#include "starsv2_base.hpp"
#include "fusion_task.h"
#include <vector>
namespace cce {
namespace runtime {

#if F_DESC("钩子注册框架")
static void DavidRegDoCompleteSuccFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &doCompleteSuccFunc = g_taskFuncArrays[chipType].doCompleteSuccFunc;
        for (auto &item : doCompleteSuccFunc) {
            item = &DoCompleteSuccess;
        }

        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &StarsV2DoCompleteSuccessForDavinciTask;
        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICORE] = &StarsV2DoCompleteSuccessForDavinciTask;
        doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICPU] = &StarsV2DoCompleteSuccessForDavinciTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_MEMCPY] = &StarsV2DoCompleteSuccessForMemcpyAsyncTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RECORD] = &DoCompleteSuccessForEventRecordTask;
        doCompleteSuccFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &DoCompleteSuccessForEventWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RESET] = &DoCompleteSuccessForEventResetTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DoCompleteSuccessForDavidEventRecordTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DoCompleteSuccessForDavidEventWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DoCompleteSuccessForDavidEventResetTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &DoCompleteSuccessForNotifyWaitTask;
        doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_RECORD] = &DoCompleteSuccessForNotifyRecordTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &DoCompleteSuccessForModelMaintainceTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &DoCompleteSuccessForModelExecuteTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &DoCompleteSuccForModelToAicpuTask;
        
        doCompleteSuccFunc[TS_TASK_TYPE_CCU_LAUNCH] = &DoCompleteSuccessForCcuLaunchTask;
        doCompleteSuccFunc[TS_TASK_TYPE_UB_DB_SEND] = &DoCompleteSuccessForUbDmaDbModeTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DIRECT_SEND] = &DoCompleteSuccessForUbDmaDirectWqeModeTask;
        doCompleteSuccFunc[TS_TASK_TYPE_FUSION_KERNEL] = &DoCompleteSuccessForFusionKernelTask;
    }
}

static void DavidRegTaskUnInitFunc(const std::vector<rtChipType_t> &chipTypes)
{
    PfnTaskUnInit *taskUnInitFunc = nullptr;
    for (auto chipType : chipTypes) {
        taskUnInitFunc = g_taskFuncArrays[chipType].taskUnInitFunc;
        for (uint32_t i = 0U; i < TS_TASK_TYPE_RESERVED; i++) {
            taskUnInitFunc[i] = nullptr;
        }

        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICORE] = &StarsV2DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &StarsV2DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICPU] = &StarsV2DavinciTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MULTIPLE_TASK] = &StarsV2DavinciMultipleTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MEMCPY] = &StarsV2MemcpyAsyncTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_EVENT_RECORD] = &EventRecordTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_EVENT_RESET] = &EventResetTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &DavidEventRecordTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &DavidEventResetTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &DavidEventWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ModelExecuteTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_SWITCH] = &StreamSwitchTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &StreamActiveTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &StreamLabelSwitchByIndexTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_STARS_COMMON] = &StarsCommonTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_FUSION_KERNEL] = &FusionKernelTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_MEM_WAIT_VALUE] = &MemWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_IPC_WAIT] = &StarsV2IpcEventWaitTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_IPC_RECORD] = &StarsV2IpcEventRecordTaskUnInit;
    }
}

static void DavidRegPrintErrorInfoFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &printErrorInfoFunc = g_taskFuncArrays[chipType].printErrorInfoFunc;
        for (auto &item : printErrorInfoFunc) {
            item = &PrintErrorInfoCommon;
        }

        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICPU] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICORE] = &PrintErrorInfoForDavinciTask;
        printErrorInfoFunc[TS_TASK_TYPE_MEMCPY] = &PrintErrorInfoForMemcpyAsyncTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &PrintErrorInfoForModelMaintainceTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &PrintErrorInfoForModelExecuteTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &PrintErrorInfoForModelToAicpuTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &PrintErrorInfoForStreamLabelSwitchByIndexTask;
        printErrorInfoFunc[TS_TASK_TYPE_STARS_COMMON] = &PrintErrorInfoForStarsCommonTask;
        printErrorInfoFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &PrintErrorInfoForNotifyWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_SWITCH] = &PrintErrorInfoForStreamSwitchTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &PrintErrorInfoForStreamActiveTask;
        printErrorInfoFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &PrintErrorInfoForEventWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &PrintErrorInfoForDavidEventWaitTask;
        printErrorInfoFunc[TS_TASK_TYPE_CMO] = &PrintErrorInfoForDavidCmoTask;
        printErrorInfoFunc[TS_TASK_TYPE_CCU_LAUNCH] = &PrintErrorInfoForCcuLaunchTask;
        printErrorInfoFunc[TS_TASK_TYPE_FUSION_KERNEL] = &PrintErrorInfoForFusionKernelTask;
        printErrorInfoFunc[TS_TASK_TYPE_UB_DB_SEND] = &PrintErrorInfoForUbDbSendTask;
        printErrorInfoFunc[TS_TASK_TYPE_DIRECT_SEND] = &PrintErrorInfoForUbDirectSendTask;
    }
}

static void DavidRegSetStarsResultFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &setStarsResultFunc = g_taskFuncArrays[chipType].setStarsResultFunc;
        for (auto &item : setStarsResultFunc) {
            item = &SetStarsResultCommonForDavid;
        }

        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICPU] = &StarsV2SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &StarsV2SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICORE] = &StarsV2SetStarsResultForDavinciTask;
        setStarsResultFunc[TS_TASK_TYPE_MEMCPY] = &SetStarsResultForMemcpyAsyncTask;
        setStarsResultFunc[TS_TASK_TYPE_EVENT_RECORD] = &SetStarsResultForEventRecordTask;
        setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &SetStarsResultForDavidEventRecordTask;
        setStarsResultFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &SetStarsResultForModelExecuteTask;
        setStarsResultFunc[TS_TASK_TYPE_DATADUMP_LOADINFO] = &SetStarsResultForDataDumpLoadInfoTask;
        setStarsResultFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &SetStarsResultForModelToAicpuTask;
        setStarsResultFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT] = &SetStarsResultForEventWaitTask;
        setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &SetStarsResultForEventWaitTask;
        setStarsResultFunc[TS_TASK_TYPE_AICPU_INFO_LOAD] = &SetStarsResultForAicpuInfoLoadTask;
        setStarsResultFunc[TS_TASK_TYPE_CCU_LAUNCH] = &SetResultForCcuLaunchTask;
        setStarsResultFunc[TS_TASK_TYPE_FUSION_KERNEL] = &SetStarsResultForFusionKernelTask;
        setStarsResultFunc[TS_TASK_TYPE_UB_DB_SEND] = &SetResultForUbDmaTask;
        setStarsResultFunc[TS_TASK_TYPE_DIRECT_SEND] = &SetResultForUbDmaTask;
    }
}

void RegDavidTaskFunc(void)
{
    static const std::vector<rtChipType_t> chipTypes = {
        CHIP_DAVID, CHIP_CLOUD_V5, CHIP_MC62CM12A, CHIP_XPU, CHIP_ASCEND_350
    };
    RegTaskToCommandFunc(chipTypes);
    RegTaskToDavidSqefunc();
    DavidRegTaskUnInitFunc(chipTypes);
    DavidRegDoCompleteSuccFunc(chipTypes);
    DavidRegPrintErrorInfoFunc(chipTypes);
    DavidRegSetStarsResultFunc(chipTypes);
    return;
}
#endif
}  // namespace runtime
}  // namespace cce
