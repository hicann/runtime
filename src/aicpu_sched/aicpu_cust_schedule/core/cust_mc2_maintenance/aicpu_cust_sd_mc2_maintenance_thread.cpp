/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_cust_sd_mc2_maintenance_thread.h"
#include <cstring>
#include <sched.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "tsd.h"
#include "aicpu_cust_sd_mc2_maintenance_thread_api.h"


namespace AicpuSchedule {
    const uint32_t DEFAULT_GROUP_ID_TO_TSD_CLIENT = 30U;
    AicpuCustMc2MaintenanceThread &AicpuCustMc2MaintenanceThread::GetInstance(uint32_t type)
    {
        if (type == 0) {
            static AicpuCustMc2MaintenanceThread instance(type);
            return instance;
        }
        static AicpuCustMc2MaintenanceThread instance(type);
        return instance;
    }

    AicpuCustMc2MaintenanceThread::~AicpuCustMc2MaintenanceThread()
    {
        UnitCustMc2MaintenanceProcess();
        if (processThread_.joinable()) {
            processThread_.join();
        }
    }

    AicpuCustMc2MaintenanceThread::AicpuCustMc2MaintenanceThread(uint32_t type)
        : initFlag_(false),
          threadId_(0LU),
          processEventFuncPtr_(nullptr),
          processEventFuncParam_(nullptr),
          stopProcessEventFuncPtr_(nullptr),
          stopProcessEventFuncParam_(nullptr),
          type_(type)
    {
    }
    void AicpuCustMc2MaintenanceThread::SendCustMc2CreateThreadMsgToMain() const
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

    int32_t AicpuCustMc2MaintenanceThread::CreateCustMc2MaintenanceThread()
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
            processThread_ = std::thread(&AicpuCustMc2MaintenanceThread::StartProcessEvent, this);
        } catch (std::exception &e) {
            aicpusd_err("create thread file:%s", e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustMc2MaintenanceThread::InitCustMc2MaintenanceProcess(AicpuMC2MaintenanceFuncPtr loopFun,
        void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
    {
        aicpusd_info("init cust mc2 maintenance process start, type[%u]", type_);
        uint32_t runMode;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed. type[%u]", type_);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        if (runMode != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            aicpusd_info("not pcie mode no need this thread type[%u]", type_);
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
            aicpusd_err("workerSme_ init failed, type[%u], %s", type_, strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        SendCustMc2CreateThreadMsgToMain();
        const int32_t semWaitRet = sem_wait(&workerSme_);
        if (semWaitRet == -1) {
            sem_destroy(&workerSme_);
            aicpusd_err("workerSme wait failed, type[%u], %s", type_, strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        sem_destroy(&workerSme_);
        initFlag_ = true;
        aicpusd_info("init cust mc2 maintenance process finish. type[%u]", type_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustMc2MaintenanceThread::SetCustMc2MaintenanceThreadAffinity()
    {
        std::vector<uint32_t> ccpuIds = AicpuDrvManager::GetInstance().GetCcpuList();
        if (ccpuIds.empty()) {
            aicpusd_run_info("ccpu list is empty no need bind core");
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
                aicpusd_err("aicpu bind tid by self, res[%d], error[%s]. type[%u]", ret, strerror(errno), type_);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            } else {
                aicpusd_run_info("aicpu bind by self success. type[%u]", type_);
                return AICPU_SCHEDULE_OK;
            }
        }
    }
    void AicpuCustMc2MaintenanceThread::StartProcessEvent()
    {
        if (SetCustMc2MaintenanceThreadAffinity() != AICPU_SCHEDULE_OK) {
            aicpusd_err("CustMc2 Maintenance thread bind core failed. type[%u]", type_);
            sem_post(&workerSme_);
            return;
        }
        sem_post(&workerSme_);
        aicpusd_run_info("post work sem finish. type[%u]", type_);
        ProcessEventFunc();
        ClearCustMc2MaintenanceProcess();
        aicpusd_run_info("CustMc2 thread ProcessEventFunc finished. type[%u]", type_);
    }
    void AicpuCustMc2MaintenanceThread::ProcessEventFunc() const
    {
        if (processEventFuncPtr_ == nullptr) {
            aicpusd_err("the processEventFuncPtr not register. type[%u]", type_);
            return;
        }
        processEventFuncPtr_(processEventFuncParam_);
    }

    void AicpuCustMc2MaintenanceThread::ClearCustMc2MaintenanceProcess()
    {
        aicpusd_info("ClearCustMc2MaintenanceProcess start. type[%u]", type_);
        processEventFuncPtr_ = nullptr;
        processEventFuncParam_ = nullptr;
        stopProcessEventFuncPtr_ = nullptr;
        stopProcessEventFuncParam_ = nullptr;
        initFlag_ = false;
        aicpusd_info("ClearCustMc2MaintenanceProcess finish. type[%u]", type_);
    }

    void AicpuCustMc2MaintenanceThread::StopProcessEventFunc() const
    {
        // 调用结束回调
        if (stopProcessEventFuncPtr_ == nullptr) {
            aicpusd_err("the stopProcessEventFuncPtr not register. type[%u]", type_);
            return;
        }
        stopProcessEventFuncPtr_(stopProcessEventFuncParam_);
    }

    void AicpuCustMc2MaintenanceThread::UnitCustMc2MaintenanceProcess()
    {
        aicpusd_info("UnitCustMc2MaintenanceProcess start. type[%u]", type_);
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
        aicpusd_info("UnitCustMc2MaintenanceProcess finish. type[%u]", type_);
    }
    int32_t AicpuCustMc2MaintenanceThread::RegisterProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
    {
        if (funPtr == nullptr) {
            aicpusd_err("the process funPtr is null. type[%u]", type_);
            return AICPU_SCHEDULE_PARAMETER_IS_NULL;
        }
        processEventFuncPtr_ = funPtr;
        processEventFuncParam_ = param;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustMc2MaintenanceThread::RegisterStopProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
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
int32_t CreateCustMc2MaintenanceThread(const struct TsdSubEventInfo * const msg)
{
    if (msg == nullptr) {
        aicpusd_err("msg is null");
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    const struct AicpuSchedule::CreateCtrlThreadArgs *createCtrlThreadArgsPtr = PtrToPtr<const char_t, const struct AicpuSchedule::CreateCtrlThreadArgs>(msg->priMsg);
    if (createCtrlThreadArgsPtr == nullptr) {
        aicpusd_err("args ptr is null");
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    (void)msg;
    uint32_t type = createCtrlThreadArgsPtr->type;
    aicpusd_info("aicpu create ctrl thread type[%u]", type);
    int32_t ret = AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(type).CreateCustMc2MaintenanceThread();
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Create Cust Mc2 Maintenance Thread failed, ret[%d], type[%u]", ret, type);
        return ret;
    }
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
int32_t StartMC2MaintenanceThread(AicpuMC2MaintenanceFuncPtr loopFun,
    void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
{
    int32_t ret = AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(THREAD_TYPE_HCOM).InitCustMc2MaintenanceProcess(loopFun,
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
    int32_t ret = AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(type).InitCustMc2MaintenanceProcess(loopFun,
        paramLoopFun, stopNotifyFun, paramStopFun);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return ret;
    }
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}
#ifdef __cplusplus
}
#endif