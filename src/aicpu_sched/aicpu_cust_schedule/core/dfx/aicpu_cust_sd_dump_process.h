/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef CORE_AICPU_CUST_SD_DUMP_PROCESS_H
#define CORE_AICPU_CUST_SD_DUMP_PROCESS_H
 
#include <atomic>
#include <vector>
#include <mutex>
#include <thread>
#include <semaphore.h>
 
#include "aicpu_event_struct.h"
#include "ascend_hal.h"
#include "type_def.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
 
namespace AicpuSchedule {
struct DumpTaskMsg {
    uint32_t streamId;
    uint32_t taskId;
    sem_t    waitFlag;
    int32_t  dumpRet;
    bool     initFlag;
};
 
class AicpuCustDumpProcess {
public:
    /*
    * 实例获取
    */
    static AicpuCustDumpProcess &GetInstance();
 
    /*
    * 完成dump，模块的初始化，包括event模块初始化，以及回调线程拉起
    */
    int32_t InitDumpProcess(const uint32_t deviceId, const uint32_t workCnt);
 
    /*
    * 初始化waitCondition列表
    */
    int32_t InitWaitConVec(const uint32_t workCnt);
 
    /*
    * 销毁资源
    */
    void UnitDataDumpProcess();
 
    /*
    * 消息处理回调函数
    */
    void LoopProcessEvent();
 
    /*
    * 获取datadump的执行结果
    */
    int32_t GetDataDumpRetCode(const uint32_t threadIndex);
 
    /*
    * 对外接口开始datadump
    */
    int32_t BeginDatadumpTask(const uint32_t threadIndex, const uint32_t streamId, const uint32_t taskId);
private:
    /*
    * datadump 线程初始化
    */
    void StartProcessEvent();
 
    /*
    * datadump 线程绑核，绑核到ccpu上
    */
    int32_t SetDataDumpThreadAffinity() const;
 
    /*
    * 发送dump消息给aicpusd进程
    */
    int32_t SendDumpMessageToAicpuSd(char_t *msg, const uint32_t msgLen) const;
 
    /*
    * 解除对应线程的阻塞消息
    */
    int32_t ActiveTheBlockThread(const event_info &drvEventInfo);
    int32_t ProcessDumpMessage(const event_info &drvEventInfo);
    int32_t ProcessPlatformInfoMessage(const event_info &drvEventInfo) const;
    /*
    * 消息处理函数
    */
    int32_t ProcessMessage(const int32_t timeout);
 
    AicpuCustDumpProcess();
    ~AicpuCustDumpProcess();
    AicpuCustDumpProcess(const AicpuCustDumpProcess &) = delete;
    AicpuCustDumpProcess &operator = (const AicpuCustDumpProcess &) = delete;
    uint32_t deviceId_;
    bool runningFlag_;
    std::atomic<bool> initFlag_;
    std::vector<DumpTaskMsg> waitCondVec_;
    std::thread msgThread_;
    std::mutex initMutex_;
    sem_t workerSme_;
};
}
 
#endif // CORE_AICPU_CUST_SD_DUMP_PROCESS_H