/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_cust_dump_process.h"

#include <string.h>
#include <sched.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_util.h"
#include "aicpusd_info.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "dump_task.h"
#include "aicpusd_send_platform_Info_to_custom.h"

namespace AicpuSchedule {
    namespace {
        // aicpusd 与 custaicpusd 是同样的groupid
        constexpr const uint32_t DATA_DUMP_GRUOP_ID = 31U;
        constexpr const uint32_t DATA_DUMP_THREAD_INDEX = 0U;
        constexpr const int32_t  DATA_DUMP_TIMEOUT_INTERVAL = 3000;
        constexpr const uint32_t SLEEP_USECS = 50000U;
        constexpr const uint64_t DATA_DUMP_EVENT_MASK = (1ULL << static_cast<uint32_t>(EVENT_CCPU_CTRL_MSG));
    };
    AicpuSdLoadPlatformInfoProcess &AicpuSdLoadPlatformInfoProcess::GetInstance()
    {
        static AicpuSdLoadPlatformInfoProcess instance;
        return instance;
    }
    int32_t AicpuSdLoadPlatformInfoProcess::SendLoadPlatformInfoMessageToCustSync(const uint8_t * const msg, const uint32_t len) const
    {
        UNUSED(msg);
        UNUSED(len);
        return AICPU_SCHEDULE_OK;
    }
    void AicpuSdLoadPlatformInfoProcess::LoadPlatformInfoSemPost()
    {
        UNUSED(loadPlatformInfoProcessSem_);
        return;
    }
    int32_t AicpuSdLoadPlatformInfoProcess::SendMsgToMain(const void * const msg, const uint32_t len)
    {
        UNUSED(msg);
        UNUSED(len);
        sem_init(&loadPlatformInfoProcessSem_, 0, 0U);
        sem_destroy(&loadPlatformInfoProcessSem_);
        return AICPU_SCHEDULE_OK;
    }
    AicpuSdCustDumpProcess::~AicpuSdCustDumpProcess()
    {
        UnitCustDataDumpProcess();
    }

    AicpuSdCustDumpProcess &AicpuSdCustDumpProcess::GetInstance()
    {
        static AicpuSdCustDumpProcess instance;
        return instance;
    }

    AicpuSdCustDumpProcess::AicpuSdCustDumpProcess()
        : deviceId_(0U), runningFlag_(true), initFlag_(false)
    {
    }

    int32_t AicpuSdCustDumpProcess::InitCustDumpProcess(
        const uint32_t deviceId, const aicpu::AicpuRunMode runMode)
    {
        initFlag_ = false;
        UNUSED(deviceId);
        UNUSED(runMode);
        return 0;
    }

    int32_t AicpuSdCustDumpProcess::SetDataDumpThreadAffinity() const
    {
        return 0;
    }

    void AicpuSdCustDumpProcess::StartProcessEvent()
    {
    }
 
    void AicpuSdCustDumpProcess::LoopProcessEvent()
    {
    }
 
    int32_t AicpuSdCustDumpProcess::ProcessMessage(const int32_t timeout)
    {
        UNUSED(timeout);
        return 0;
    }

    void AicpuSdCustDumpProcess::UnitCustDataDumpProcess()
    {
    }

    int32_t AicpuSdCustDumpProcess::DoCustDatadumpTask(const event_info &drvEventInfo) const
    {
        UNUSED(drvEventInfo);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuSdCustDumpProcess::DoUdfDatadumpTask(const event_info &drvEventInfo) const
    {
        UNUSED(drvEventInfo);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuSdCustDumpProcess::DatadumpTaskProcess(const event_info &drvEventInfo) const
    {
        UNUSED(drvEventInfo);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuSdCustDumpProcess::DoUdfDatadumpSubmitEventSync(const char_t * const msg,
        const uint32_t len, struct event_proc_result &rsp) const
    {
        UNUSED(msg);
        UNUSED(len);
        UNUSED(rsp);
        return AICPU_SCHEDULE_OK;
    }
    bool AicpuSdCustDumpProcess::IsValidUdf(const int32_t sendPid) const
    {
        UNUSED(sendPid);
        return true;
    }

    bool AicpuSdCustDumpProcess::IsValidCustAicpu(const int32_t sendPid) const
    {
        UNUSED(sendPid);
        return true;
    }
}
int32_t CreateDatadumpThread(const struct TsdSubEventInfo * const msg)
{
    UNUSED(msg);
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}