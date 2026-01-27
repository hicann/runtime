/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPU_SD_CUST_DUMP_PROCESS_H
#define CORE_AICPU_SD_CUST_DUMP_PROCESS_H

#include <atomic>
#include <vector>
#include <mutex>
#include <semaphore.h>
#include <thread>

#include "tsd.h"
#include "aicpu_event_struct.h"
#include "ascend_hal.h"
#include "type_def.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"

namespace AicpuSchedule {

class AicpuSdCustDumpProcess {
public:
    /*
    * 实例获取
    */
    static AicpuSdCustDumpProcess &GetInstance();

    /*
    * 完成dump，模块的初始化，包括event模块初始化，以及回调线程拉起
    */
    int32_t InitCustDumpProcess(const uint32_t deviceId, const aicpu::AicpuRunMode runMode);

    /*
    * 消息处理回调函数
    */
    void LoopProcessEvent();

    /*
    * 销毁资源
    */
    void UnitCustDataDumpProcess();
    /*
    * 获取进程是否启动标志
    */
    void GetCustDumpProcessInitFlag(bool &flag);
    int32_t CreateUdfDatadumpThread(const char_t *msg, const uint32_t len);
    bool IsValidUdf(const int32_t sendPid) const;
    bool IsValidCustAicpu(const int32_t sendPid) const;

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
    * 消息处理函数
    */
    int32_t ProcessMessage(const int32_t timeout);

    int32_t DoCustDatadumpTask(const event_info &drvEventInfo) const;
    int32_t DoUdfDatadumpTask(const event_info &drvEventInfo) const;
    int32_t DoUdfDatadumpSubmitEventSync(const char_t * const msg,
        const uint32_t len, struct event_proc_result &rsp) const;
    int32_t DatadumpTaskProcess(const event_info &drvEventInfo) const;
    AicpuSdCustDumpProcess();
    ~AicpuSdCustDumpProcess();
    AicpuSdCustDumpProcess(const AicpuSdCustDumpProcess &) = delete;
    AicpuSdCustDumpProcess &operator = (const AicpuSdCustDumpProcess &) = delete;
    uint32_t deviceId_;
    bool runningFlag_;
    std::atomic<bool> initFlag_;
    std::thread msgThread_;
    std::mutex initMutex_;
    sem_t workerSme_;
};
}
#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus
    __attribute__((visibility("default"))) __attribute__((weak)) int32_t CreateDatadumpThread(const struct TsdSubEventInfo * const msg);
#ifdef __cplusplus
}
#endif  // __cplusplus
#endif // CORE_AICPU_CUST_SD_DUMP_PROCESS_H