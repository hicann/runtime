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

#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_interface_process.h"
namespace AicpuSchedule {
    AicpuMc2MaintenanceThread &AicpuMc2MaintenanceThread::GetInstance(uint32_t type)
    {
        (void)type;
        static AicpuMc2MaintenanceThread instance(0);
        return instance;
    }

    AicpuMc2MaintenanceThread::AicpuMc2MaintenanceThread(uint32_t type)
        : initFlag_(false), processEventFuncPtr_(nullptr),
          processEventFuncParam_(nullptr),
          stopProcessEventFuncPtr_(nullptr),
          stopProcessEventFuncParam_(nullptr)
    {
        (void)type;
    }

    AicpuMc2MaintenanceThread::~AicpuMc2MaintenanceThread()
    {
        UnitMc2MantenanceProcess();
    }

    int32_t AicpuMc2MaintenanceThread::InitMc2MaintenanceProcess(AicpuMC2MaintenanceFuncPtr loopFun,
        void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
    {
        (void)loopFun;
        (void)paramLoopFun;
        (void)stopNotifyFun;
        (void)paramStopFun;
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuMc2MaintenanceThread::SetMc2MantenanceThreadAffinity()
    {
        return AICPU_SCHEDULE_OK;
    }

    void AicpuMc2MaintenanceThread::StartProcessEvent()
    {
        return;
    }
    void AicpuMc2MaintenanceThread::ProcessEventFunc() const
    {
        return;
    }

    void AicpuMc2MaintenanceThread::StopProcessEventFunc() const
    {
        return;
    }

    void AicpuMc2MaintenanceThread::UnitMc2MantenanceProcess()
    {
        return;
    }
    void AicpuMc2MaintenanceThread::SendMc2CreateThreadMsgToMain() const
    {
        return;
    }
    int32_t AicpuMc2MaintenanceThread::RegisterProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
    {
        (void)funPtr;
        (void)param;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuMc2MaintenanceThread::RegisterStopProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param)
    {
        (void)funPtr;
        (void)param;
        return AICPU_SCHEDULE_OK;
    }
}

int32_t StartMC2MaintenanceThread(AicpuMC2MaintenanceFuncPtr loopFun,
    void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun)
{
    (void)loopFun;
    (void)paramLoopFun;
    (void)stopNotifyFun;
    (void)paramStopFun;
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}