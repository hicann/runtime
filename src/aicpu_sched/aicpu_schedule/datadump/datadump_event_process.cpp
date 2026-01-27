/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_event_process.h"
#include <sys/time.h>
#include <iomanip>
#include <vector>
#include <securec.h>
#include <memory>
#include <new>
#include <dlfcn.h>
#include "aicpu_event_struct.h"
#include "ascend_hal.h"
#include "aicpusd_threads_process.h"
#include "dump_task.h"
#include "tsd.h"
#include "ts_api.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_profiler.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "profiling_adp.h"
#include "aicpu_context.h"
#include "aicpu_engine.h"
#include "common/aicpusd_util.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_model_err_process.h"
#include "aicpu_async_event.h"
#include "aicpusd_context.h"
#include "type_def.h"

namespace AicpuSchedule {
    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to construct a object of AicpuEventProcess.
     */
    AicpuEventProcess::AicpuEventProcess()
        : exitQueueFlag_(false)
    {
    }

    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to destructor a object of AicpuEventProcess.
     */
    AicpuEventProcess::~AicpuEventProcess() {}

    AicpuEventProcess &AicpuEventProcess::GetInstance()
    {
        static AicpuEventProcess instance;
        return instance;
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process data dump event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessDumpDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        AicpuSqeAdapter::AicpuDataDumpInfo info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfo(info);
        aicpusd_info("Begin to dump data, stream id[%u], task id[%u], debug stream id[%u], debug task id[%u]," 
                     "is model[%u]", info.dump_stream_id, info.dump_task_id,
                     info.debug_dump_stream_id, info.debug_dump_task_id, info.is_model);
        // reserved 是否有用？？
        int32_t ret = AICPU_SCHEDULE_OK;
        TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.dump_stream_id),
                                        static_cast<volatile uint32_t>(info.dump_task_id));
        if (info.is_debug && FeatureCtrl::IsNoNeedDumpOpDebugProduct()) {
            aicpusd_warn("Not support to dump Op debug, stream id[%u],"
                            " task id[%u], stream id1[%u], task id1[%u], is model[%u],",
                            info.dump_stream_id, info.dump_task_id, info.debug_dump_stream_id, info.debug_dump_task_id,
                            info.is_model);
        } else {
            uint32_t fileNameTaskId = info.is_debug ? info.debug_dump_task_id : info.dump_task_id;
            uint32_t fileNameStreamId = info.is_debug ? info.debug_dump_stream_id : info.dump_stream_id;
            DumpFileName dumpFileName(fileNameStreamId, fileNameTaskId);
            ret = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
        }
        if (info.is_model && info.is_debug) {
            TaskInfoExt debugdumpTaskInfo(static_cast<volatile uint32_t>(info.debug_dump_stream_id),
                                  static_cast<volatile uint32_t>(info.debug_dump_task_id));
            DumpFileName dumpFileName(info.debug_dump_stream_id, info.debug_dump_task_id);
            const int32_t tmpRet = opDumpTaskMgr.DumpOpInfo(debugdumpTaskInfo, dumpFileName);
            ret = (ret == AICPU_SCHEDULE_OK)? tmpRet : ret;
        } // 模型流溢出检测
        return SendDumpResponceInfo(aicpuSqeAdapter, ret);
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process FFTSPlus data dump event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessDumpFFTSPlusDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        AicpuSqeAdapter::AicpuDumpFFTSPlusDataInfo info {};
        aicpuSqeAdapter.GetAicpuDumpFFTSPlusDataInfo(info);
        aicpusd_info("Begin to dump FFTSPlus data, stream id[%u], task id[%u], stream id1[%u], task id1[%u], " \
                     "model id[%u], context id[%u], thread id[%u], reserved[%u].",
                     info.i.stream_id, info.i.task_id, info.i.stream_id1, info.i.task_id1, static_cast<uint32_t>(info.i.model_id), info.i.context_id, info.i.thread_id, info.i.reserved[0]);

        int32_t ret = AICPU_SCHEDULE_OK;
        bool validDumpParam = false;
        if ((info.i.task_id != INVALID_VAL) && (info.i.stream_id != INVALID_VAL)) {
            validDumpParam = true;
            const bool isFftsPlusOverflow = (info.i.task_id1 != INVALID_VAL) && (info.i.stream_id1 != INVALID_VAL);
            uint32_t contextId = static_cast<volatile uint32_t>(info.i.context_id);
            uint32_t threadId = static_cast<volatile uint32_t>(info.i.thread_id);
            if (isFftsPlusOverflow) {
                contextId = INVALID_VAL;
                threadId = INVALID_VAL;
            }
            TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.i.stream_id),
                                           static_cast<volatile uint32_t>(info.i.task_id),
                                           contextId,
                                           threadId);
            DumpFileName dumpFileName(info.i.stream_id1, info.i.task_id1, info.i.context_id, info.i.thread_id);
            ret = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
        }
        if ((info.i.task_id1 != INVALID_VAL) && (info.i.stream_id1 != INVALID_VAL)) {
            validDumpParam = true;
            TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.i.stream_id1),
                                           static_cast<volatile uint32_t>(info.i.task_id1),
                                           static_cast<volatile uint32_t>(info.i.context_id),
                                           static_cast<volatile uint32_t>(info.i.thread_id));
            DumpFileName dumpFileName(info.i.stream_id1, info.i.task_id1, info.i.context_id, info.i.thread_id);
            const int32_t tmpRet = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
            ret = (ret == AICPU_SCHEDULE_OK)? tmpRet : ret;
        }

        if (!validDumpParam) {
            aicpusd_err("Invalid dump FFTSPlus param, stream id[%hu], task id[%hu], stream id1[%hu], task id1[%hu], " \
                        "context id[%hu], thread id[%u].",
                        info.i.stream_id, info.i.task_id, info.i.stream_id1,
                        info.i.task_id1, info.i.context_id, info.i.thread_id);
            ret = AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }

        return SendDumpResponceInfo(aicpuSqeAdapter, ret);
    }

 int32_t AicpuEventProcess::SendDumpResponceInfo(AicpuSqeAdapter &adapter,  const int32_t &dumpRet) const
    {        
        aicpusd_info("Begin to send response information using tsDevSendMsgAsync function.");
        auto ret = adapter.AicpuDumpResponseToTs(dumpRet);
        aicpusd_info("Finished to send dump report information, ret[%d].", ret);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to response info, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process op mapping load event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessLoadOpMappingEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        aicpusd_info("Begin to load op mapping event.");
        AicpuSqeAdapter::AicpuDataDumpInfoLoad info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfoLoad(info);
        const char_t * const opMappingInfo =
            PtrToPtr<void, char_t>(ValueToPtr(info.dumpinfoPtr));
        const uint32_t len = info.length;
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
         int32_t ret = opDumpTaskMgr.LoadOpMappingInfo(opMappingInfo, len, aicpuSqeAdapter);
        // send response information to ts.
        aicpusd_info("Begin to send response information using tsDevSendMsgAsync function; load ret[%d].", ret);
        ret = aicpuSqeAdapter.AicpuDataDumpLoadResponseToTs(ret);
        aicpusd_info("Finished to send dump load info report info, ret[%d].", ret);

        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to response info, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
    }
}
