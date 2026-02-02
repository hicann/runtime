/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_drv_manager.h"
#include <sys/time.h>
#include <sstream>
#include "driver/ascend_hal.h"
#include "aicpusd_status.h"
#include "aicpusd_context.h"
#include "aicpusd_resource_manager.h"
#include "securec.h"
#include "type_def.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_feature_ctrl.h"

#ifdef __cplusplus
extern "C" {
#endif
#ifdef __cplusplus
}
#endif

namespace {
// device num
constexpr uint32_t DEVICE_NUM = 64U;
// first array index
constexpr size_t FIRST_INDEX = 0LU;
// max number of eatch device can split
constexpr const uint32_t DEVICE_MAX_SPLIT_NUM = 16U;
// max number of eatch device cpu
constexpr const uint32_t DEVICE_MAX_CPU_NUM = 16U;
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
}

namespace AicpuSchedule {
    AicpuDrvManager &AicpuDrvManager::GetInstance()
    {
        static AicpuDrvManager instance;
        return instance;
    }

    int32_t AicpuDrvManager::GetNormalAicpuDCpuInfo(const std::vector<uint32_t> &deviceVec)
    {
        uint32_t deviceIdTmp = deviceVec[FIRST_INDEX];
        drvError_t ret;
        if (FeatureCtrl::IsVfModeDie1(deviceVec[FIRST_INDEX])) {
            int64_t pfDeviceId = 0;
            ret = halGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_DIE_ID, &pfDeviceId);
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("halGetDeviceInfo get pfDeviceId fail in device[%d], ret[%d]", deviceVec[FIRST_INDEX], ret);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            deviceIdTmp = static_cast<uint32_t>(pfDeviceId);
        }
        int64_t aicpuNum = 0;
        int64_t aicpuOsSched = 0;
        int64_t ccpuNum = 0;
        int64_t ccpuOsSched = 0;
        int64_t dcpuNum = 0;
        int64_t dcpuOsSched = 0;
        int64_t tsCpuNum = 0;
        int64_t tsCpuOsSched = 0;
        uint32_t retDrv = static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_AICPU,
            INFO_TYPE_CORE_NUM, &aicpuNum));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_AICPU,
            INFO_TYPE_OS_SCHED, &aicpuOsSched));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_CCPU,
            INFO_TYPE_CORE_NUM, &ccpuNum));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_CCPU,
            INFO_TYPE_OS_SCHED, &ccpuOsSched));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_DCPU,
            INFO_TYPE_CORE_NUM, &dcpuNum));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_DCPU,
            INFO_TYPE_OS_SCHED, &dcpuOsSched));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_TSCPU,
            INFO_TYPE_CORE_NUM, &tsCpuNum));
        retDrv |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceIdTmp, MODULE_TYPE_TSCPU,
            INFO_TYPE_OS_SCHED, &tsCpuOsSched));
        if (retDrv != 0U) {
            aicpusd_err("AicpuGetDeviceInfo failed, ret[%u]", retDrv);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        if (FeatureCtrl::IsAosCore()) {
            aicpuNumPerDev_ = aicpuNum;
            if (ccpuOsSched != 0) {
                aicpuBaseId_ += ccpuNum;
            }
            if (dcpuOsSched != 0) {
                aicpuBaseId_ += dcpuNum;
            }
        }
        // connot overflow
        coreNumPerDev_ = (ccpuNum * ccpuOsSched) + (dcpuNum * dcpuOsSched) + (aicpuNum * aicpuOsSched) +
                         (tsCpuNum * tsCpuOsSched);
        aicpusd_run_info("GetNormalAicpuDCpuInfo, deviceId[%u], aicpu_num[%u], aicpu_os_sched[%u], ccpu_num[%u], "
            "ccpu_os_sched[%u], dcpu_num[%u], dcpu_os_sched[%u], tscpu_num[%u], tscpu_os_sched[%u].",
            deviceIdTmp, aicpuNum, aicpuOsSched, ccpuNum, ccpuOsSched, dcpuNum, dcpuOsSched, tsCpuNum, tsCpuOsSched);
        dcpuBase_ = (deviceIdTmp * coreNumPerDev_) + ccpuNum;
        dcpuNum_ = dcpuNum;
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuDrvManager::AicpuGetDeviceInfo(const uint32_t deviceId,
                                                const DEV_MODULE_TYPE moduleType,
                                                const DEV_INFO_TYPE infoType,
                                                int64_t *value) const
    {
        if (value == nullptr) {
            aicpusd_err("halGetDeviceInfo value is null, deviceId[%u], DEV_MODULE_TYPE[%d], DEV_INFO_TYPE[%d]",
                        deviceId, static_cast<int32_t>(moduleType), static_cast<int32_t>(infoType));
            return -1;
        }
        const auto ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(moduleType),
                                          static_cast<int32_t>(infoType), value);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halGetDeviceInfo failed, ret[%d], deviceId[%u] DEV_MODULE_TYPE[%d], DEV_INFO_TYPE[%d], "
                "value[%lld]", ret, deviceId, static_cast<int32_t>(moduleType), static_cast<int32_t>(infoType), *value);
        }
        return static_cast<int32_t>(ret);
    }

    int32_t AicpuDrvManager::GetNormalAicpuInfo(const std::vector<uint32_t> &deviceVec)
    {
        int64_t aicpuNum = 0;
        int64_t aicpuBitMap = 0;
        int32_t ret = 0;
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceVec[0])) {
            ret = AicpuGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_AICPU, INFO_TYPE_PF_CORE_NUM, &aicpuNum);
            if (ret != DRV_ERROR_NONE) {
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            ret = AicpuGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_AICPU, INFO_TYPE_PF_OCCUPY, &aicpuBitMap);
            if (ret != DRV_ERROR_NONE) {
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        } else {
            ret = AicpuGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &aicpuNum);
            if (ret != DRV_ERROR_NONE) {
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            ret = AicpuGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_AICPU, INFO_TYPE_OCCUPY, &aicpuBitMap);
            if (ret != DRV_ERROR_NONE) {
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        }

        aicpusd_run_info("aicpuBitMap[%lld], aicpuNum[%lld].", aicpuBitMap, aicpuNum);
        aicpuNumPerDev_ = static_cast<uint32_t>(aicpuNum);
        aicpuIdVec_.clear();

        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if (deployCtx == DeployContext::HOST) {
            for (int64_t i = 0; i < aicpuNum; ++i) {
                aicpuIdVec_.push_back(i);
            }
            return AICPU_SCHEDULE_OK;
        }

        for (uint32_t i = 0U; i < DEVICE_MAX_CPU_NUM; i++) {
            if ((aicpuBitMap & 0x1LL) != 0LL) {
                aicpuIdVec_.push_back(i);
            }
            aicpuBitMap = aicpuBitMap >> 1;
        }
        if (static_cast<uint32_t>(aicpuNum) != aicpuIdVec_.size()) {
            aicpusd_err("aicpunum bitmap error, aicpuNum[%lld],aicpuIdVecSize[%u]", aicpuNum, aicpuIdVec_.size());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::GetCcpuInfo(const std::vector<uint32_t> &deviceVec)
    {
        int64_t ccpuBitMap = 0;
        const int32_t ret = AicpuGetDeviceInfo(deviceVec[FIRST_INDEX], MODULE_TYPE_CCPU, INFO_TYPE_OCCUPY, &ccpuBitMap);
        if (ret != DRV_ERROR_NONE) {
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        aicpusd_run_info("ccpuBitMap[%lld].", ccpuBitMap);
        for (uint32_t i = 0U; i < DEVICE_MAX_CPU_NUM; i++) {
            if ((ccpuBitMap & 0x1LL) != 0LL) {
                ccpuIdVec_.push_back(i);
            }
            ccpuBitMap = ccpuBitMap >> 1;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::GetThreadVfAicpuDCpuInfo(const std::vector<uint32_t> &deviceVec)
    {
        const uint32_t deviceId = deviceVec[FIRST_INDEX];
        int64_t aicpuNum = 0L;
        uint32_t ret = static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_AICPU,
                                                                INFO_TYPE_CORE_NUM, &aicpuNum));
        int64_t aicpuOsSched = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_AICPU,
                                                        INFO_TYPE_OS_SCHED, &aicpuOsSched));
        int64_t ccpuNum = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_CCPU,
                                                        INFO_TYPE_CORE_NUM, &ccpuNum));
        int64_t ccpuOsSched = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_CCPU,
                                                        INFO_TYPE_OS_SCHED, &ccpuOsSched));
        int64_t dcpuNum = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_DCPU,
                                                        INFO_TYPE_CORE_NUM, &dcpuNum));
        int64_t dcpuOsSched = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_DCPU,
                                                        INFO_TYPE_OS_SCHED, &dcpuOsSched));
        int64_t tsCpuNum = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_TSCPU,
                                                        INFO_TYPE_CORE_NUM, &tsCpuNum));
        int64_t tsCpuOsSched = 0;
        ret |= static_cast<uint32_t>(AicpuGetDeviceInfo(deviceId, MODULE_TYPE_TSCPU,
                                                        INFO_TYPE_OS_SCHED, &tsCpuOsSched));
        if (ret != 0U) {
            aicpusd_err("AicpuGetDeviceInfo failed, ret[%u]", ret);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        if (FeatureCtrl::IsAosCore()) {
            aicpuNumPerDev_ = static_cast<uint32_t>(aicpuNum);
            if (ccpuOsSched != 0L) {
                aicpuBaseId_ += static_cast<uint32_t>(ccpuNum);
            }
            if (dcpuOsSched != 0L) {
                aicpuBaseId_ += static_cast<uint32_t>(dcpuNum);
            }
        }
        // connot overflow
        coreNumPerDev_ = (static_cast<uint32_t>(ccpuNum) * static_cast<uint32_t>(ccpuOsSched)) +
                         (static_cast<uint32_t>(dcpuNum) * static_cast<uint32_t>(dcpuOsSched)) +
                         (static_cast<uint32_t>(aicpuNum) * static_cast<uint32_t>(aicpuOsSched)) +
                         (static_cast<uint32_t>(tsCpuNum) * static_cast<uint32_t>(tsCpuOsSched));
        aicpusd_info("GetThreadVfAicpuDCpuInfo, deviceId[%u], aicpuNum[%llu], aicpuOsSched[%llu], ccpuNum[%llu], "
            "ccpuOsSched[%llu], dcpuNum[%llu], dcpuOsSched[%llu], tsCpuNum[%llu], tsCpuOsSched[%llu].",
            deviceId, aicpuNum, aicpuOsSched, ccpuNum, ccpuOsSched, dcpuNum, dcpuOsSched, tsCpuNum, tsCpuOsSched);
        dcpuBase_ = (deviceVec[FIRST_INDEX] * coreNumPerDev_) + static_cast<uint32_t>(ccpuNum);
        dcpuNum_ = static_cast<uint32_t>(dcpuNum);
        return AICPU_SCHEDULE_OK;
    }

    void AicpuDrvManager::InitDrvMgrCaluniqueVfId(const std::vector<uint32_t> &deviceVec, const uint32_t vfId)
    {
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceVec[0])) {
            uniqueVfId_ = deviceVec[0];
        } else {
            uniqueVfId_ = vfId;
            if (FeatureCtrl::IsAosCore()) {
                return;
            }
            if ((!deviceVec.empty()) && (deviceVec[FIRST_INDEX] != 0U) && (vfId != 0U)) {
                uint32_t maxNumSpDev = 0U;
                const auto vfMaxRet = halGetDeviceVfMax(deviceVec[FIRST_INDEX], &maxNumSpDev);
                if ((vfMaxRet != DRV_ERROR_NONE) || (maxNumSpDev > DEVICE_MAX_SPLIT_NUM)) {
                    aicpusd_err("Failed to get device cat vf number, result[%d], max num[%u].", vfMaxRet, maxNumSpDev);
                    return;
                }
                uniqueVfId_ = (maxNumSpDev * deviceVec[FIRST_INDEX]) + vfId;
            }
        }
        aicpusd_run_info("InitDrvMgr uniqueVfId=%u, deviceId=%u", uniqueVfId_, deviceVec[0]);
    }

    void AicpuDrvManager::InitSocType(const uint32_t deviceId)
    {
        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if (deployCtx == DeployContext::HOST) {
            return;
        }

        int64_t hardwareVersion = 0L;
        const int32_t ret = AicpuGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Get device info failed, deviceId=%u", deviceId);
            return;
        }

        FeatureCtrl::Init(hardwareVersion, deviceId);

        return;
    }

    int32_t AicpuDrvManager::InitDrvMgr(const std::vector<uint32_t> &deviceVec, const pid_t hostPid,
                                        const uint32_t vfId, const bool hasThread, const aicpu::AicpuRunMode runMode,
                                        const std::string &hostProcName)
    {
        if (deviceVec.size() == 0LU) {
            aicpusd_err("deviceList is empty, deviceNum[%zu]", deviceVec.size());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        InitSocType(deviceVec[0U]);

        auto ret = 0;
        if (!FeatureCtrl::IsAosCore()) {
            ret = GetNormalAicpuInfo(deviceVec);
            if (ret != 0) {
                aicpusd_err("GetNormalAicpuInfo error, ret[%d]", ret);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            ret = GetCcpuInfo(deviceVec);
            if (ret != 0) {
                aicpusd_err("GetCcpuInfo error, ret[%d]", ret);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        }

        deviceNum_ = deviceVec.size();
        for (size_t i = 0LU; i < deviceNum_; i++) {
            if (deviceVec[i] >= DEVICE_NUM) {
                aicpusd_err("invalid device id[%u]", deviceVec[i]);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        }

        if ((runMode == aicpu::AicpuRunMode::THREAD_MODE) && (vfId > 0)) {
            ret = GetThreadVfAicpuDCpuInfo(deviceVec);
        } else {
            ret = GetNormalAicpuDCpuInfo(deviceVec);
        }
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("get cpu info failed, ret[%d], vfId[%u], runMode[%u]", ret, vfId, runMode);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        InitDrvMgrCaluniqueVfId(deviceVec, vfId);
        aicpusd_run_info("host pid[%d], host proc name[%s], vf id[%u], first aicpu index[%u], aicpu num[%u],"
                         " dcpu base index[%u], dcpu num[%u].",
                         hostPid, hostProcName.c_str(), vfId, aicpuBaseId_, aicpuNumPerDev_, dcpuBase_, dcpuNum_);

        deviceVec_ = deviceVec;
        hostPid_ = hostPid;
        vfId_ = vfId;
        hasThread_ = hasThread;
        isInit_ = true;
        hostProcName_ = hostProcName;

        return AICPU_SCHEDULE_OK;
    }

    void AicpuDrvManager::DettachAllDevice(const size_t deviceIndex) const
    {
        for (size_t i = 0LU; i <= deviceIndex; i++) {
            (void)halEschedDettachDevice(deviceVec_[i]);
        }
    }

    int32_t AicpuDrvManager::InitDrvSchedModule(const uint32_t grpId,
                                                const std::map<EVENT_ID, SCHEDULE_PRIORITY> &priority)
    {
        // use driver event means has thread
        hasThread_ = true;
        int32_t ret = InitDrvZone();
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to init the drv zone, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        for (size_t i = 0LU; i < deviceNum_; i++) {
            aicpusd_info("Attach device[%u] to drv scheduler", deviceVec_[i]);
            ret = halEschedAttachDevice(deviceVec_[i]);
            if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_PROCESS_REPEAT_ADD)) {
                aicpusd_err("Failed to attach device in drv, result[%d], device[%u].", ret, deviceVec_[i]);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }

            GROUP_TYPE cpuGrpType = GRP_TYPE_BIND_DP_CPU;
            DeployContext deployCtx = DeployContext::DEVICE;
            const StatusCode status = GetAicpuDeployContext(deployCtx);
            if (status != AICPU_SCHEDULE_OK) {
                aicpusd_err("Get current deploy ctx failed.");
                return status;
            }
            const uint32_t aicpuNum = GetAicpuNumPerDevice();
            if ((deployCtx == DeployContext::HOST) || (aicpuNum == 0U)) {
                cpuGrpType = GRP_TYPE_BIND_CP_CPU;
            }
            aicpusd_info("Create group[%u], device[%d], type[%d]", grpId, deviceVec_[i], cpuGrpType);
            ret = halEschedCreateGrp(deviceVec_[i], grpId, cpuGrpType);
            if (ret != DRV_ERROR_NONE) {
                (void)DettachAllDevice(i);
                aicpusd_err("Failed to create group in drv, result[%d], group[%u], device[%d], type[%d].",
                    ret, grpId, deviceVec_[i], cpuGrpType);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            for (const auto &item : priority) {
                ret = halEschedSetEventPriority(deviceVec_[i], item.first, item.second);
                if (ret != DRV_ERROR_NONE) {
                    (void)DettachAllDevice(i);
                    aicpusd_err("Failed to set event[%d] priority, result[%d].", item.first, ret);
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
                aicpusd_info("Set event[%d] priority[%d] success.", item.first, item.second);
            }

            if (FeatureCtrl::ShouldInitDrvThread() && (deployCtx == DeployContext::DEVICE) && (&halDrvEventThreadInit != nullptr)) {
                // call driver interface
                ret = halDrvEventThreadInit(deviceVec_[i]);
                aicpusd_run_info("Enable process drv queue msg on ccpu, ret is %d.", static_cast<int32_t>(ret));
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::InitDrvZone() const
    {
        // init bufManager/eventManager
        if (hasThread_) {
            (void) BufManager::GetInstance().InitBufManager();
            (void) EventWaitManager::NotifyWaitManager(MAX_NOTIFY_COUNT);
            (void) EventWaitManager::EndGraphWaitManager(MAX_MODEL_COUNT);
            (void) ModelStreamManager::GetInstance();
            (void) EventWaitManager::QueueNotEmptyWaitManager(DEFAULT_QUEUE_COUNT);
            (void) EventWaitManager::QueueNotFullWaitManager(DEFAULT_QUEUE_COUNT);
            (void) EventWaitManager::PrepareMemWaitManager(MAX_MODEL_COUNT);
            (void) EventWaitManager::AnyQueNotEmptyWaitManager(MAX_MODEL_COUNT);
            (void) EventWaitManager::TableUnlockWaitManager(MAX_MODEL_COUNT);
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::SubscribeQueueNotEmptyEvent(const uint32_t queueId) const
    {
        const uint32_t deviceId = GetDeviceId();
        aicpusd_info("Begin to subscribe non-empty event, deviceId[%u], queueId[%u], groupId[%u].",
                     deviceId, queueId, groupId_);
        const drvError_t ret = halQueueSubscribe(deviceId, queueId, groupId_, QUEUE_TYPE_SINGLE);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to subscribe event for queue[%u], ret[%d].", queueId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        aicpusd_info("End to subscribe non-empty event, deviceId[%u], queueId[%u], groupId[%u].",
                     deviceId, queueId, groupId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::UnSubscribeQueueNotEmptyEvent(const uint32_t queueId) const
    {
        const uint32_t deviceId = GetDeviceId();
        aicpusd_info("Begin to unsubscribe non-empty event, deviceId[%u], queueId[%u].", deviceId, queueId);
        const drvError_t ret = halQueueUnsubscribe(deviceId, queueId);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_warn("Failed to unsubscribe event for queue[%u], ret[%d].", queueId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        aicpusd_info("End to unsubscribe non-empty event, deviceId[%u], queueId[%u].", deviceId, queueId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::SubscribeQueueNotFullEvent(const uint32_t queueId) const
    {
        const uint32_t deviceId = GetDeviceId();
        aicpusd_info("Begin to subscribe not full event, deviceId[%u], queueId[%u], groupId[%u].",
                     deviceId, queueId, groupId_);
        const drvError_t ret = halQueueSubF2NFEvent(deviceId, queueId, groupId_);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to subscribe the event of output queue[%u], ret[%d].", queueId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        aicpusd_info("End to subscribe not full event, deviceId[%u], queueId[%u], groupId[%u].",
                     deviceId, queueId, groupId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::UnSubscribeQueueNotFullEvent(const uint32_t queueId) const
    {
        const uint32_t deviceId = GetDeviceId();
        aicpusd_info("Begin to unsubscribe not full event, deviceId[%u], queueId[%u].", deviceId, queueId);
        const drvError_t ret = halQueueUnsubF2NFEvent(deviceId, queueId);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_warn("Failed to unsubscribe not full event for queue[%u], ret[%d].", queueId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        aicpusd_info("End to unsubscribe not full event, deviceId[%u], queueId[%u].", deviceId, queueId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::BindHostPid(const std::string &signStr,
                                         const int32_t mode,
                                         const uint32_t vfId,
                                         const enum devdrv_process_type cpType) const
    {
        aicpusd_info("Begin to bind host pid, device id[%u], host pid[%d], mode[%d], vfId[%u], cp type[%d]",
            deviceVec_[FIRST_INDEX], hostPid_, mode, vfId, cpType);
        if (mode >= static_cast<int32_t>(AicpuPlat::AICPU_MAX_PLAT)) {
            aicpusd_err("plat mode[%d] should less than %d", mode, AicpuPlat::AICPU_MAX_PLAT);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (cpType >= DEVDRV_PROCESS_CPTYPE_MAX) {
            aicpusd_err("cp type[%d] should less than %d", cpType, DEVDRV_PROCESS_CPTYPE_MAX);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        struct drvBindHostpidInfo para = {};
        for (size_t i = 0LU; i < deviceNum_; i++) {
            para.host_pid = hostPid_;
            para.vfid = vfId;
            para.len = static_cast<uint32_t>(PROCESS_SIGN_LENGTH);
            para.mode = mode;
            para.cp_type = cpType;
            para.chip_id = deviceVec_[i];
            const errno_t memRet = strcpy_s(para.sign, static_cast<size_t>(PROCESS_SIGN_LENGTH), signStr.c_str());
            if (memRet != EOK) {
                aicpusd_err("memcpy ret[%d], pid[%d], device id[%u], cp type[%d], mode[%d]",
                    memRet, hostPid_, deviceVec_[i], cpType, mode);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }

            const drvError_t drvRet = drvBindHostPid(para);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("Call drvBindHostPid failed, ret[%d] device id[%u], host pid[%d], mode[%d], cp type[%d],"
                    " vf id[%u]", drvRet, deviceVec_[i], hostPid_, mode, cpType, vfId);
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }
        }

        aicpusd_run_info("Bind host pid success, hostPid=%u, vfId=%u, mode=%d", hostPid_, vfId, mode);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuDrvManager::CheckBindHostPid() const
    {
        aicpusd_run_info("Start query process host pid");
        if (&drvQueryProcessHostPid == nullptr) {
            aicpusd_run_info("drvQueryProcessHostPid does not exist");
            return AICPU_SCHEDULE_OK;
        }
        drvError_t ret = DRV_ERROR_NONE;
        unsigned int hostpid = 0;
        unsigned int cpType = DEVDRV_PROCESS_CPTYPE_MAX;
        const int pid = static_cast<int>(getpid());
        for (uint32_t i = 0; i < QUERY_BIND_HOST_PID_TIME/QUERY_BIND_HOST_PID_INTERVBALE; i++) {
            ret = drvQueryProcessHostPid(pid, nullptr, nullptr, &hostpid, &cpType);
            if ((i % QUERY_BIND_HOST_PID_LOG_INTERVAL) == 0U) {
                aicpusd_run_info("Query process host pid end, ret=%d, hostpid=%u, expect=%u, cpType=%u",
                                 static_cast<int32_t>(ret), hostpid, hostPid_, cpType);
            }
            if (ret == DRV_ERROR_NO_PROCESS) {
                aicpusd_info("call drvQueryProcessHostPid try again");
                (void)usleep(QUERY_BIND_HOST_PID_INTERVBALE);
                continue;
            }

            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("call drvQueryProcessHostPid failed, ret[%d]", static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }

            aicpusd_info("call drvQueryProcessHostPid result, hostpid[%d], cpType[%d]", hostpid, cpType);
            if (hostPid_ == static_cast<pid_t>(hostpid)) {
                aicpusd_run_info("call drvQueryProcessHostPid successfully, hostpid[%d], cpType[%d].", hostpid, cpType);
                return AICPU_SCHEDULE_OK;
            } else {
                aicpusd_err("CheckBindHostPid failed, hostpid not right. ret[%d], pid[%d], hostpid[%d], cpType[%d]",
                            static_cast<int32_t>(ret), pid, hostpid, cpType);
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }
        }
        aicpusd_err("CheckBindHostPid failed, try timeout. ret[%d], pid[%d], hostpid[%d], cpType[%d]",
                    static_cast<int32_t>(ret), pid, hostpid, cpType);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    uint32_t AicpuDrvManager::GetAicpuNum() const
    {
        aicpusd_info("Get aicpu core num[%u], device num[%zu]", aicpuNumPerDev_, deviceNum_);
        return aicpuNumPerDev_ * static_cast<uint32_t>(deviceNum_);
    }

    std::vector<uint32_t> AicpuDrvManager::GetDeviceList() const
    {
        aicpusd_info("Get device list");
        return deviceVec_;
    }

    uint32_t AicpuDrvManager::GetAicpuNumPerDevice() const
    {
        aicpusd_info("Get aicpu core num[%u]", aicpuNumPerDev_);
        return aicpuNumPerDev_;
    }

    int32_t AicpuDrvManager::QueryProcBuffInfo(uint32_t procId,
                                               std::map<std::string, GroupShareAttr> &buffGrpInfo) const
    {
        std::unique_ptr<GroupQueryOutput> groupInfoPtr(new (std::nothrow) GroupQueryOutput());
        if (groupInfoPtr == nullptr) {
            aicpusd_err("groupInfoPtr malloc failed.");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        GroupQueryOutput &groupInfo = *(groupInfoPtr.get());
        uint32_t groupInfoLen = 0U;
        const auto drvRet = halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS, &procId,
            static_cast<uint32_t>(sizeof(procId)), PtrToPtr<GroupQueryOutput, void>(&groupInfo), &groupInfoLen);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Get group info of process[%u] failed, ret[%d]", procId, drvRet);
            return drvRet;
        }
        if ((static_cast<size_t>(groupInfoLen) % sizeof(groupInfo.grpQueryGroupsOfProcInfo[0])) != 0UL) {
            aicpusd_err("Output buffer size[%d] in halGrpQuery is invalid", groupInfoLen);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        const size_t groupNum = static_cast<size_t>(groupInfoLen) / sizeof(groupInfo.grpQueryGroupsOfProcInfo[0]);
        if (groupNum == 0UL) {
            buffGrpInfo.clear();
            aicpusd_info("Query proc[%u] buff succ, group number[%zu]", procId, groupNum);
            return AICPU_SCHEDULE_OK;
        }
        for (size_t i = 0UL; i < groupNum; ++i) {
            const std::string grpName(groupInfo.grpQueryGroupsOfProcInfo[i].groupName);
            if (!IsSvmShareGrp(grpName)) {
                buffGrpInfo[grpName] = groupInfo.grpQueryGroupsOfProcInfo[i].attr;
            }
        }
        aicpusd_info("Query proc[%u] buff succ, group number[%zu], size[%lu]", procId, groupNum, buffGrpInfo.size());
        return AICPU_SCHEDULE_OK;
    }

    uint32_t AicpuDrvManager::GetAicpuPhysIndex(const uint32_t aicpuLogIndex, const uint32_t deviceId) const
    {
        if (FeatureCtrl::IsAosCore()) {
            // connot overflow
            return ((aicpuBaseId_ + aicpuNumPerDev_) * deviceId) + aicpuBaseId_ + aicpuLogIndex;
        }
        if (FeatureCtrl::BindCpuOnlyOneDevice()) {
            // 只有一个device，vf切分到同一容器时会产生多个deviceId。
            return aicpuIdVec_[aicpuLogIndex];
        }
        return (coreNumPerDev_ * deviceId) + aicpuIdVec_[aicpuLogIndex];
    }

    std::vector<uint32_t> AicpuDrvManager::GetAicpuPhysIndexs(const uint32_t deviceId)
    {
        if (!aicpuPhyIds_.empty()) {
            return aicpuPhyIds_;
        }

        const uint32_t aicpuNum = GetAicpuNum();
        for (uint32_t i = 0U; i < aicpuNum; ++i) {
            const uint32_t aicpuLogicIdx = i % aicpuNumPerDev_;
            aicpuPhyIds_.emplace_back(GetAicpuPhysIndex(aicpuLogicIdx, deviceId));
        }

        return aicpuPhyIds_;
    }

    bool AicpuDrvManager::IsSvmShareGrp(const std::string &grpName) const
    {
        return grpName.find("svm_share_grp") != std::string::npos;
    }
}  // namespace AicpuSchedule