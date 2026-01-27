/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef CORE_AICPUSD_MC2_MAINTENANCE_THREAD_H
#define CORE_AICPUSD_MC2_MAINTENANCE_THREAD_H
 
#include <atomic>
#include <mutex>
#include <thread>
#include <semaphore.h>

#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_mc2_maintenance_thread.h"

namespace AicpuSchedule {
constexpr uint32_t RESERVED_SIZE = 92U;
#pragma pack(push, 1)
// CreateCtrlThreadArgs size is MAX_EVENT_PRI_MSG_LENGTH
struct CreateCtrlThreadArgs {
    int32_t type = 0;
    char reserved[RESERVED_SIZE] = {};
};
#pragma pack(pop)
class AicpuMc2MaintenanceThread {
public:
    /*
    * 实例获取
    */
    static AicpuMc2MaintenanceThread &GetInstance(uint32_t type);
 
    /*
    * 完成mc2，模块的初始化，包括event模块初始化，以及回调线程拉起
    */
    int32_t InitMc2MaintenanceProcess(AicpuMC2MaintenanceFuncPtr loopFun,
        void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun);
 
    /*
    * 销毁资源
    */
    void UnitMc2MantenanceProcess();
    /*
    * 注册回调函数
    */
    int32_t RegisterProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param);
    /*
    * 注册回调函数终止函数
    */
    int32_t RegisterStopProcessEventFunc(AicpuMC2MaintenanceFuncPtr funPtr, void *param);
    /*
    * 创建并启动mc2维测线程
    */
    int32_t CreateMc2MantenanceThread();

private:
    /*
    * 给主线程发送启动mc2维测线程的事件
    */
    void SendMc2CreateThreadMsgToMain() const;
    /*
    * Mc2Mantenance 线程初始化
    */
    void StartProcessEvent();
 
    /*
    * Mc2Mantenance 线程绑核，绑核到ccpu上
    */
    int32_t SetMc2MantenanceThreadAffinity();

    /*
    * Mc2Mantenance 线程回调函数执行
    */
    void ProcessEventFunc() const;
    /*
    * Mc2Mantenance 清理资源
    */
    void ClearMc2MantenanceProcess();
    /*
    * Mc2Mantenance 线程回调函数停止
    */
    void StopProcessEventFunc() const;

    AicpuMc2MaintenanceThread(uint32_t type);
    ~AicpuMc2MaintenanceThread();
    AicpuMc2MaintenanceThread(const AicpuMc2MaintenanceThread &) = delete;
    AicpuMc2MaintenanceThread &operator = (const AicpuMc2MaintenanceThread &) = delete;
    std::atomic<bool> initFlag_;
    std::thread processThread_;
    std::mutex initMutex_;
    sem_t workerSme_;
    uint64_t threadId_;
    AicpuMC2MaintenanceFuncPtr processEventFuncPtr_;
    void *processEventFuncParam_;
    AicpuMC2MaintenanceFuncPtr stopProcessEventFuncPtr_;
    void *stopProcessEventFuncParam_;
    uint32_t type_;
};
}

#endif // CORE_AICPUSD_MC2_MAINTENANCE_THREAD_H