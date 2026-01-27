/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_send_platform_Info_to_custom.h"

#include <string>
#include <sched.h>
#include <memory>
#include <semaphore.h>
#include <unistd.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "type_def.h"

namespace AicpuSchedule {
    namespace {
        // aicpusd 与 custaicpusd 是同样的groupid
        constexpr const uint64_t DATA_DUMP_EVENT_MASK = (1ULL << static_cast<uint32_t>(EVENT_CCPU_CTRL_MSG));
        constexpr const int32_t  DATA_DUMP_TIMEOUT_INTERVAL = 3000;
        constexpr const uint32_t SLEEP_USECS = 50000U;
    };

    AicpuSdLoadPlatformInfoProcess &AicpuSdLoadPlatformInfoProcess::GetInstance()
    {
        static AicpuSdLoadPlatformInfoProcess instance;
        return instance;
    }
    void AicpuSdLoadPlatformInfoProcess::LoadPlatformInfoSemPost()
    {
       sem_post(&loadPlatformInfoProcessSem_);
    }
    int32_t AicpuSdLoadPlatformInfoProcess::SendLoadPlatformInfoMessageToCustSync(const uint8_t * const msg, const uint32_t len) const
    {
        event_reply drvAck;
        event_proc_result result;
        drvAck.buf = PtrToPtr<event_proc_result, char_t>(&result);
        drvAck.buf_len = sizeof(event_proc_result);

        pid_t aicpuCustomPid = AicpuScheduleInterface::GetInstance().GetAicpuCustSdProcId();
        event_summary drvEvent = {};
        drvEvent.dst_engine = CCPU_DEVICE;
        drvEvent.policy = ONLY;
        drvEvent.pid = aicpuCustomPid;
        drvEvent.grp_id = 31U;
        drvEvent.event_id = EVENT_CCPU_CTRL_MSG;
        drvEvent.subevent_id = static_cast<uint32_t>(AICPU_SUB_EVENT_CUST_LOAD_PLATFORM);
        drvEvent.msg_len = EVENT_MAX_MSG_LEN;
        uint8_t eventMsg[EVENT_MAX_MSG_LEN] = {};
        auto eRet = memset_s(eventMsg, drvEvent.msg_len, 0, drvEvent.msg_len);
        if (eRet != EOK) {
            aicpusd_run_warn("Mem set error, ret=%d", eRet);
        }
        eRet = memcpy_s(eventMsg + sizeof(struct event_sync_msg), EVENT_MAX_MSG_LEN - sizeof(struct event_sync_msg),
                        msg, len);
        if (eRet != EOK) {
            aicpusd_err("Fail to memcpy, ret=[%d].", eRet);
            return eRet;
        }
        drvEvent.msg = PtrToPtr<uint8_t, char_t>(eventMsg);
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        int32_t ret = halEschedSubmitEventSync(deviceId, &drvEvent, 5000, &drvAck);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedSubmitEventSync failed, ret:%d, devid:%u, aicpuCustomPid:%u", ret, deviceId, aicpuCustomPid);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("send Platform Info msg success, devid:%u, aicpuCustomPid:%u", deviceId, aicpuCustomPid);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuSdLoadPlatformInfoProcess::SendMsgToMain(const void * const msg, const uint32_t len)
    {
        TsdSubEventInfo msgInfo = {};
        auto eRet = memcpy_s(&msgInfo, sizeof(TsdSubEventInfo), msg, len);
        if (eRet != EOK) {
            aicpusd_err("Fail to memcpy, ret=[%d].", eRet);
            return eRet;
        }
        event_summary eventInfo = {};
        eventInfo.pid = static_cast<pid_t>(getpid());
        eventInfo.grp_id = 30U;
        eventInfo.dst_engine = CCPU_DEVICE;
        eventInfo.event_id = EVENT_CCPU_CTRL_MSG;
        eventInfo.subevent_id = TSD_EVENT_LOAD_PLATFORM_TO_CUST;
        eventInfo.msg_len = sizeof(TsdSubEventInfo);
        eventInfo.msg =  PtrToPtr<TsdSubEventInfo, char_t>(&msgInfo);

        uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const int32_t semRet = sem_init(&loadPlatformInfoProcessSem_, 0, 0U);
        if (semRet == -1) {
            aicpusd_err("loadPlatformInfoProcessSem_ init failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        const drvError_t ret = halEschedSubmitEvent(deviceId, &eventInfo);
        if (ret != DRV_ERROR_NONE) {
            sem_destroy(&loadPlatformInfoProcessSem_);
            aicpusd_err("Failed to submit, eventId: [%d], ret: [%d].", TSD_EVENT_LOAD_PLATFORM_TO_CUST, ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        const int32_t semWaitRet = sem_wait(&loadPlatformInfoProcessSem_);
        if (semWaitRet == -1) {
            sem_destroy(&loadPlatformInfoProcessSem_);
            aicpusd_err("workerSme wait failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        sem_destroy(&loadPlatformInfoProcessSem_);
        return AICPU_SCHEDULE_OK;
    }
}

int32_t SendLoadPlatformInfoToCust(const struct TsdSubEventInfo * const msg)
{
    uint8_t message[EVENT_MAX_MSG_LEN] = {};
    auto len = sizeof(struct AICPULoadPlatformCustInfo);
    const AicpuSchedule::ScopeGuard ideSessGuard([]() {
        AicpuSchedule::AicpuSdLoadPlatformInfoProcess::GetInstance().LoadPlatformInfoSemPost();
    });
    auto ret = memcpy_s(message, EVENT_MAX_MSG_LEN, msg, len);
    if (ret != 0) {
        aicpusd_err("Memcpy failed. ret[%d], size[%u].", ret, len);
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AicpuSchedule::AicpuSdLoadPlatformInfoProcess::GetInstance().SendLoadPlatformInfoMessageToCustSync(message,
        len);
}