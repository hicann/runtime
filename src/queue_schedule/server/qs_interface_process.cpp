/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "qs_interface_process.h"
#include <securec.h>
#include <unistd.h>
#include "common/bqs_log.h"
#include "common/bqs_util.h"
#include "msprof_manager.h"
#include "queue_schedule_hal_interface_ref.h"
#include "common/bqs_feature_ctrl.h"

namespace bqs {
    // 查询bind信息间隔
    constexpr uint32_t QUERY_BIND_HOST_PID_INTERVBALE = 10000U;
    // 查询bind超时时间
#ifndef aicpusd_UT
    constexpr uint32_t QUERY_BIND_HOST_PID_TIME = 120000000U;
#else
    constexpr uint32_t QUERY_BIND_HOST_PID_TIME = 100000U;
#endif
    // bind结果的日志输出周期
    constexpr uint32_t QUERY_BIND_HOST_PID_LOG_INTERVAL = 1000U;
    QueueScheduleInterface &QueueScheduleInterface::GetInstance()
    {
        static QueueScheduleInterface instance;
        return instance;
    }

    /**
     * @ingroup QueueScheduleInterface
     * @brief it use to initialize aicpu schedule.
     * @param [in] params InitQsParams
     * @return BQS_STATUS_OK: success, other: error code
     */
    int32_t QueueScheduleInterface::InitQueueScheduler(const InitQsParams &params)
    {
        const std::unique_lock<std::mutex> lk(mutexForInit_);
        BQS_LOG_INFO("Start up BqsInterface.numaFlag[%d]", params.numaFlag);
        if (bqs::GetRunContext() != bqs::RunContext::HOST) {
            const auto initCpuInfoRet = BindCpuUtils::GetDevCpuInfo(params.deviceId, aiCpuIds_, ctrlCpuIds_,
                                                                    coreNumPerDev_, aicpuNum_, aicpuBaseId_);
            if (initCpuInfoRet != BQS_STATUS_OK) {
                return static_cast<int32_t>(initCpuInfoRet);
            }
        }
        if (params.numaFlag) {
            const auto initCpuInfoRet = BindCpuUtils::GetDevCpuInfo(params.deviceIdExtra, aiCpuIdsExtra_,
                ctrlCpuIdsExtra_, coreNumPerDevExtra_, aicpuNumExtra_, aicpuBaseIdExtra_);
            if (initCpuInfoRet != BQS_STATUS_OK) {
                BQS_LOG_ERROR("GetDevCpuInfo error");
                return static_cast<int32_t>(initCpuInfoRet);
            }
        }

        queueSchedule_.reset(new (std::nothrow) QueueSchedule(params));
        if (queueSchedule_ == nullptr) {
            BQS_LOG_ERROR("Fail to allocate QueueSchedule");
            return static_cast<int32_t>(BQS_STATUS_INNER_ERROR);
        }
        BQS_LOG_INFO("Prepare bind process with host process, deviceId[%u], RunContext is [%u]",
                     params.deviceId, static_cast<uint32_t>(bqs::GetRunContext()));
        // bind process with hostpid in process mode
        if ((bqs::GetRunContext() != bqs::RunContext::HOST) &&
            (params.starter != bqs::QsStartType::START_BY_DEPLOYER) &&
            (params.runMode != QueueSchedulerRunMode::MULTI_THREAD)) {
                const auto bindRet = CheckBindHostPid(params.pid);
                if (bindRet != bqs::BQS_STATUS_OK) {
                    BQS_LOG_ERROR("BindHostPid failed");
                    return static_cast<int32_t>(bindRet);
            }
        }
        // init profiling
        const bool profFlag = params.profFlag;
        BqsMsprofManager::GetInstance().InitBqsMsprofManager(profFlag, params.profCfgData);

        const bqs::BqsStatus bsqStatus = queueSchedule_->StartQueueSchedule();
        if (bsqStatus != bqs::BQS_STATUS_OK) {
            BQS_LOG_ERROR("QueueSchedule start failed, ret=%d", static_cast<int32_t>(bsqStatus));
            return static_cast<int32_t>(bsqStatus);
        }
        return static_cast<int32_t>(BQS_STATUS_OK);
    }

    void QueueScheduleInterface::WaitForStop()
    {
        if (queueSchedule_ != nullptr) {
            queueSchedule_->WaitForStop();
        }
    }

    /**
     * @ingroup QueueScheduleInterface
     * @brief it use to destroy all model.
     */
    int32_t QueueScheduleInterface::Destroy() const
    {
        if (queueSchedule_ != nullptr) {
            queueSchedule_->Destroy();
        }
        return static_cast<int32_t>(BQS_STATUS_OK);
    }

    uint32_t QueueScheduleInterface::GetAicpuPhysIndex(uint32_t deviceId, const uint32_t aicpuLogIndex) const
    {
        if (FeatureCtrl::IsAosCore()) {
            // connot overflow
            return ((aicpuBaseId_ + aicpuNum_) * deviceId) + aicpuBaseId_ + aicpuLogIndex;
        }

        if (aicpuLogIndex >= aiCpuIds_.size()) {
            BQS_LOG_INFO("Get aicpu index not success");
            return 0U;
        }

        if (FeatureCtrl::BindCpuOnlyOneDevice()) {
            // 只有一个device，vf切分到同一容器时会产生多个deviceId。
            return aiCpuIds_[aicpuLogIndex];
        }
        return (coreNumPerDev_ * deviceId) + aiCpuIds_[aicpuLogIndex];
    }

    uint32_t QueueScheduleInterface::GetExtraAicpuPhysIndex(uint32_t deviceId, const uint32_t aicpuLogIndex) const
    {
#ifdef _AOSCORE_
        // connot overflow
        return ((aicpuBaseIdExtra_ + aicpuNumExtra_) * deviceId) + aicpuBaseIdExtra_ + aicpuLogIndex;
#else
        if (aicpuLogIndex >= aiCpuIdsExtra_.size()) {
            BQS_LOG_ERROR("Get aicpu index error");
            return 0U;
        }
#ifdef BIND_CPU_ONLY_ONE_DEVICE
        // 只有一个device，vf切分到同一容器时会产生多个deviceId。
        return aiCpuIdsExtra_[aicpuLogIndex];
#else
        return (coreNumPerDevExtra_ * deviceId) + aiCpuIdsExtra_[aicpuLogIndex];
#endif
#endif
    }

    int32_t QueueScheduleInterface::CheckBindHostPid(const uint32_t selfHostPid) const
    {
        BQS_LOG_RUN_INFO("Start query process host pid");
        if (&drvQueryProcessHostPid == nullptr) {
            BQS_LOG_INFO("drvQueryProcessHostPid does not exist");
            return bqs::BQS_STATUS_OK;
        }
        drvError_t ret = DRV_ERROR_NONE;
        unsigned int hostpid = 0;
        unsigned int cpType = DEVDRV_PROCESS_CPTYPE_MAX;
        const int pid = static_cast<int>(getpid());
        for (uint32_t i = 0; i < QUERY_BIND_HOST_PID_TIME/QUERY_BIND_HOST_PID_INTERVBALE; i++) {
            ret = drvQueryProcessHostPid(pid, nullptr, nullptr, &hostpid, &cpType);
            if ((i % QUERY_BIND_HOST_PID_LOG_INTERVAL) == 0U) {
                BQS_LOG_RUN_INFO("Query process host pid end, ret=%d, hostpid=%u, expect=%u, cpType=%u",
                                 static_cast<int32_t>(ret), hostpid, selfHostPid, cpType);
            }
            if (ret == DRV_ERROR_NO_PROCESS) {
                BQS_LOG_INFO("call drvQueryProcessHostPid trg again");
                (void)usleep(QUERY_BIND_HOST_PID_INTERVBALE);
                continue;
            }
            if (ret != DRV_ERROR_NONE) {
                BQS_LOG_ERROR("call drvQueryProcessHostPid failed, ret[%d]", static_cast<int32_t>(ret));
                return bqs::BQS_STATUS_DRIVER_ERROR;
            }
            BQS_LOG_INFO("call drvQueryProcessHostPid result, hostpid[%d], cpType[%d]", hostpid, cpType);
            if (selfHostPid == static_cast<uint32_t>(hostpid)) {
                BQS_LOG_RUN_INFO("call drvQueryProcessHostPid success, hostpid[%d]", hostpid);
                return bqs::BQS_STATUS_OK;
            } else {
                BQS_LOG_ERROR("CheckBindHostPid failed, hostpid not right. ret[%d], pid[%d], hostpid[%d], cpType[%d]",
                              static_cast<int32_t>(ret), pid, hostpid, cpType);
                return bqs::BQS_STATUS_DRIVER_ERROR;
            }
        }
        BQS_LOG_ERROR("CheckBindHostPid failed, try timeout. ret[%d], pid[%d], hostpid[%d], cpType[%d]",
                      static_cast<int32_t>(ret), pid, hostpid, cpType);
        return bqs::BQS_STATUS_DRIVER_ERROR;
    }

    void QueueScheduleInterface::ReportAbnormal() const
    {
        if (queueSchedule_ != nullptr) {
            queueSchedule_->ReportAbnormal();
        }
    }
}