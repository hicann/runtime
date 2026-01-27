/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_mc2_maintenance_thread.h"
#include <string.h>
#include <sched.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "tsd.h"
#include "aicpusd_mc2_maintenance_thread_api.h"


namespace AicpuSchedule {
    const uint32_t DEFAULT_GROUP_ID_TO_TSD_CLIENT = 30U;
    AicpuMc2MaintenanceThread &AicpuMc2MaintenanceThread::GetInstance(uint32_t type)
    {
        if (type == 0) { // mc2
            static AicpuMc2MaintenanceThread mc2Instance(type);
            return mc2Instance;
        } 
        // profiling
        static AicpuMc2MaintenanceThread profInstance(type);
        return profInstance;
    }

    AicpuMc2MaintenanceThread::~AicpuMc2MaintenanceThread()
    {
        UnitMc2MantenanceProcess();
        if (processThread_.joinable()) {
            processThread_.join();
        }
    }

    AicpuMc2MaintenanceThread::AicpuMc2MaintenanceThread(uint32_t type)
        : initFlag_(false),
          threadId_(0LU),
          processEventFuncPtr_(nullptr),
          processEventFuncParam_(nullptr),
          stopProcessEventFuncPtr_(nullptr),
          stopProcessEventFuncParam_(nullptr),
          type_(type)
    {
    }
    void AicpuMc2MaintenanceThread::SendMc2CreateThreadMsgToMain() const
    {
        TsdSubEventInfo msg = {};
        event_summary eventInfo = {};
        eventInfo.pid = static_cast<pid_t>(getpid());
        eventInfo.grp_id = DEFAULT_GROUP_ID_TO_TSD_CLIENT;
        eventInfo.dst_engine = CCPU_DEVICE;
        eventInfo.event_id = EVENT_CCPU_CTRL_MSG;
        eventInfo.subevent_id = TSD_EVENT_START_MC2_THREAD;
        eventInfo.msg_len = sizeof(TsdSubEventInfo);
        eventInfo.msg = PtrToPtr<TsdSubEventInfo, char_t>(&msg);
        struct CreateCtrlThreadArgs *createCtrlThreadArgsPtr = PtrToPtr<char_t, struct CreateCtrlThreadArgs>(msg.priMsg);
        createCtrlThreadArgsPtr->type = type_;

        uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const drvError_t ret = halEschedSubmitEvent(deviceId, &eventInfo);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to submit, eventId: [%d], ret: [%d].", TSD_EVENT_START_MC2_THREAD, ret);
        }

        return;
    }

    int32_t AicpuMc2MaintenanceThread::CreateMc2MantenanceThread()
    {
        if (initFlag_) {
            aicpusd_info("the thread no need to multiple init, threadId[%llu]", threadId_);
            return AICPU_SCHEDULE_OK;
        }
        try {
            if (processThread_.joinable()) {
                aicpusd_run_info("processThread join begin, threadId[%llu]", threadId_);
                processThread_.join();
                aicpusd_run_info("processThread join end, threadId[%llu]", threadId_);
            }
            processThread_ = std::thread(&AicpuMc2MaintenanceThread::StartProcessEvent, this);
        } catch (std::exception &e) {
            aicpusd_err("create thread file:%s", e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuMc2MaintenanceThread::InitMc2MaintenanceProcess(AicpuMC2MaintenanceFuncPtr loopFun,
        void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
    {
        aicpusd_info("type[%u]", type_);
        uint32_t runMode;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed. type[%u]", type_);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        if (runMode != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            aicpusd_info("not pcie mode no need this thread. type[%u]", type_);
            return AICPU_SCHEDULE_NOT_SUPPORT;
        }
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (initFlag_) {
            aicpusd_info("the thread is already init, threadId[%llu], type[%u]", threadId_, type_);
            return AICPU_SCHEDULE_THREAD_ALREADY_EXISTS;
        }
        int32_t ret = 0;
        ret = RegisterProcessEventFunc(loopFun, paramLoopFun);
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            return ret;
        }
        ret = RegisterStopProcessEventFunc(stopNotifyFun, paramStopFun);
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            return ret;
        }
        const int32_t semRet = sem_init(&workerSme_, 0, 0U);
        if (semRet == -1) {
            aicpusd_err("workerSme_ init failed, %s, type[%u]", strerror(errno), type_);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        SendMc2CreateThreadMsgToMain();
        const int32_t semWaitRet = sem_wait(&workerSme_);
        if (semWaitRet == -1) {
            sem_destroy(&workerSme_);
            aicpusd_err("workerSme wait failed, %s, type[%u]", strerror(errno), type_);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        sem_destroy(&workerSme_);
        initFlag_ = true;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuMc2MaintenanceThread::SetMc2MantenanceThreadAffinity()
    {
        std::vector<uint32_t> ccpuIds = AicpuDrvManager::GetInstance().GetCcpuList();
        if (ccpuIds.empty()) {
            aicpusd_run_info("ccpu list is empty no need bind core. type[%u]", type_);
            return AICPU_SCHEDULE_OK;
        }
        if (AicpuUtil::IsEnvValEqual(ENV_NAME_PROCMGR_AICPU_CPUSET, "1")) {
            aicpusd_err("the chip not support, please check. type[%u]", type_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        } else {
            pthread_t threadId = pthread_self();
            threadId_ = GetTid();
            cpu_set_t cpuset;
            for (const auto cpuId: ccpuIds) {
                CPU_SET(cpuId, &cpuset);
                aicpusd_info("prepare bind threadId=%lu to cpuId=%u, type=%u", threadId, static_cast<uint32_t>(cpuId), type_);
            }
            const int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
            if (ret != 0) {
                aicpusd_err("aicpu bind tid by self, res[%d], error[%s], type[%u].", ret, strerror(errno), type_);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            } else {
                aicpusd_run_info("aicpu bind by self success. type[%u]", type_);
                return AICPU_SCHEDULE_OK;
            }
        }
    }
    void AicpuMc2MaintenanceThread::StartProcessEvent()
    {
        if (SetMc2MantenanceThreadAffinity() != AICPU_SCHEDULE_OK) {
            aicpusd_err("Mc2 Maintenance thread bind core failed. type[%u]", type_);
            sem_post(&workerSme_);
            return;
        }
        aicpusd_info("StartProcessEvent type[%u]", type_);
        sem_post(&workerSme_);
        aicpusd_run_info("post work sem finish. type[%u]", type_);
        ProcessEventFunc();
        ClearMc2MantenanceProcess();
        aicpusd_run_info("mc2 thread ProcessEventFunc finished. type[%u]", type_);
    }
    void AicpuMc2MaintenanceThread::ProcessEventFunc() const
    {
        if (processEventFuncPtr_ == nullptr) {
            aicpusd_err("the processEventFuncPtr not register. type[%u]", type_);
            return;
        }
        processEventFuncPtr_(processEventFuncParam_);
    }

    void AicpuMc2MaintenanceThread::ClearMc2MantenanceProcess()
    {
        aicpusd_info("ClearMc2MantenanceProcess start. type[%u]", type_);
        processEventFuncPtr_ = nullptr;
        processEventFuncParam_ = nullptr;
        stopProcessEventFuncPtr_ = nullptr;
        stopProcessEventFuncParam_ = nullptr;
        initFlag_ = false;
        type_ = 0U;
        aicpusd_info("ClearMc2MantenanceProcess finish. type[%u]", type_);
    }

    void AicpuMc2MaintenanceThread::StopProcessEventFunc() const
    {
        // 调用结束回调
        if (stopProcessEventFuncPtr_ == nullptr) {
            aicpusd_err("the stopProcessEventFuncPtr not register. type[%u]", type_);
            return;
        }
        stopProcessEventFuncPtr_(stopProcessEventFuncParam_);
    }

    void AicpuMc2MaintenanceThread::UnitMc2MantenanceProcess()
    {
        aicpusd_info("UnitMc2MantenanceProcess start. type[%u]", type_);
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (!initFlag_) {
            aicpusd_info("the thread is already stop");
            return;
        }
        StopProcessEventFunc();
        aicpusd_info("StopProcessEventFunc finished. type[%u]", type_);
        processEventFuncPtr_ = nullptr;
        processEventFuncParam_ = nullptr;
        stopProcessEventFuncPtr_ = nullptr;
        stopProcessEventFuncParam_ = nullptr;
        initFlag_ = false;
        aicpusd_info("UnitMc2MantenanceProcess finish. type[%u]", type_);
    }
    int32_t AicpuMc2MaintenanceThread::RegisterProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
    {
        if (funPtr == nullptr) {
            aicpusd_err("the process funPtr is null. type[%u]", type_);
            return AICPU_SCHEDULE_PARAMETER_IS_NULL;
        }
        processEventFuncPtr_ = funPtr;
        processEventFuncParam_ = param;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuMc2MaintenanceThread::RegisterStopProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
    {
        if (funPtr == nullptr) {
            aicpusd_err("the stop funPtr is null. type[%u]", type_);
            return AICPU_SCHEDULE_PARAMETER_IS_NULL;
        }
        stopProcessEventFuncPtr_ = funPtr;
        stopProcessEventFuncParam_ = param;
        return AICPU_SCHEDULE_OK;
    }
}
int32_t CreateMc2MantenanceThread(const struct TsdSubEventInfo * const msg)
{
    AICPUSD_CHECK((msg != nullptr), AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR, "msg is nulll");
    const struct AicpuSchedule::CreateCtrlThreadArgs *createCtrlThreadArgsPtr = PtrToPtr<const char_t, const struct AicpuSchedule::CreateCtrlThreadArgs>(msg->priMsg);
    AICPUSD_CHECK((createCtrlThreadArgsPtr != nullptr), AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR, "args ptr is nulll");
    uint32_t type = createCtrlThreadArgsPtr->type;
    aicpusd_info("aicpu create ctrl thread type[%u]", type);
    int32_t ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(type).CreateMc2MantenanceThread();
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Create Mc2 Maintenance Thread failed, ret[%d] type[%u]", ret, type);
        return ret;
    }
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}
int32_t StartMC2MaintenanceThread(AicpuMC2MaintenanceFuncPtr loopFun,
    void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
{
    int32_t ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(THREAD_TYPE_HCOM).InitMc2MaintenanceProcess(loopFun,
        paramLoopFun, stopNotifyFun, paramStopFun);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return ret;
    }
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

int32_t AicpuCreateCtrlThread(uint32_t type, AicpuMC2MaintenanceFuncPtr loopFun,
    void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
{
    if ((type != THREAD_TYPE_HCOM) && (type != THREAD_TYPE_ASCPP_PROF)) {
        aicpusd_err("Aicpu create ctrl thread failed, type is [%u], only support [0-1]", type);
        return AICPU_SCHEDULE_NOT_SUPPORT;
    }
    int32_t ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(type).InitMc2MaintenanceProcess(loopFun,
        paramLoopFun, stopNotifyFun, paramStopFun);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return ret;
    }
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}