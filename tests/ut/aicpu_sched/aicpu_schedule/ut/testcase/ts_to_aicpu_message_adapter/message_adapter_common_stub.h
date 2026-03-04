/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MESSAGE_ADAPTER_COMMON_STUB_H
#define MESSAGE_ADAPTER_COMMON_STUB_H
#include <functional>
#include <dlfcn.h>
#include <iostream>
#include <memory>
#include <map>
#include <thread>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <sstream>
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "aicpusd_worker.h"
#include "aicpu_event_struct.h"
#include "aicpu_pulse.h"
#include "aicpusd_info.h"
#include "aicpusd_cust_so_manager.h"
#include "profiling_adp.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_resource_limit.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "task_queue.h"
#include "tdt_server.h"
#include "aicpusd_model_execute.h"
#include "adump/ide_daemon_api.h"
#include "aicpu_task_struct.h"
#include "ascend_hal.h"
#include "aicpu_context.h"
#include "dynamic_sched.pb.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_util.h"
#include "aicpusd_mc2_maintenance_thread_api.h"
#include "aicpusd_message_queue.h"
#define private public
#include "aicpusd_profiler.h"
#include "aicpusd_args_parser.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpu_prof.h"
#include "aicpusd_args_parser.h"
#include "aicpusd_message_queue.h"
#include "aicpu_mc2_maintenance_thread.h"
#include "aicpusd_mc2_maintenance_thread.h"
#include "aicpusd_monitor.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_process.h"
#include "aicpusd_queue_event_process.h"
#include "aicpu_sharder.h"
#include "dump_task.h"
#include "aicpusd_task_queue.h"
#include "aicpu_engine.h"
#include "aicpusd_so_manager.h"
#include "aicpusd_send_platform_Info_to_custom.h"
#include "aicpusd_model_err_process.h"
#include "aicpusd_sqe_adapter.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_threads_process.h"
#include "securec.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;
inline TsAicpuMsgInfo expMsg_;
inline TsAicpuSqe expSqe_;
// tsDevSendMsgAsync
inline int32_t SqetsDevSendMsgAsyncStub(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned handleId)
{
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(msg);
    EXPECT_EQ(std::memcmp(ctrlMsg, &expSqe_, sizeof(TsAicpuSqe)), 0);
    return AICPU_SCHEDULE_OK;
}

inline int32_t MsgInfotsDevSendMsgAsyncStub(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned handleId)
{
    TsAicpuMsgInfo *ctrlMsg = reinterpret_cast<TsAicpuMsgInfo *>(msg);
    EXPECT_EQ(std::memcmp(ctrlMsg, &expMsg_, sizeof(TsAicpuMsgInfo)), 0);
    return AICPU_SCHEDULE_OK;
}

// halEschedAckEvent

inline int32_t SqehalEschedAckEventStub(uint32_t devId, EVENT_ID eventId, uint32_t subeventId, char *msg, uint32_t msgLen)
{
    hwts_response_t *hwtsResp = reinterpret_cast<hwts_response_t *>(msg);
    TsAicpuSqe *ctrlMsg = reinterpret_cast<TsAicpuSqe *>(hwtsResp->msg);
    EXPECT_EQ(std::memcmp(ctrlMsg, &expSqe_, sizeof(TsAicpuSqe)), 0);
    return AICPU_SCHEDULE_OK;
}

inline int32_t MsgInfohalEschedAckEventStub(uint32_t devId, EVENT_ID eventId, uint32_t subeventId, char *msg, uint32_t msgLen)
{
    hwts_response_t *hwtsResp = reinterpret_cast<hwts_response_t *>(msg);
    TsAicpuMsgInfo *ctrlMsg = reinterpret_cast<TsAicpuMsgInfo *>(hwtsResp->msg);
    EXPECT_EQ(std::memcmp(ctrlMsg, &expMsg_, sizeof(TsAicpuMsgInfo)), 0);
    return AICPU_SCHEDULE_OK;
}

inline void ClearMsgAndSqe() 
{
    memset_s(&expSqe_, sizeof(expSqe_), 0, sizeof(expSqe_));
    memset_s(&expMsg_, sizeof(expSqe_), 0, sizeof(expMsg_));
}

#endif //MESSAGE_ADAPTER_COMMON_STUB_H

