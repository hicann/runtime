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

#include <map>
#include <sys/time.h>
#include "driver/ascend_hal.h"
#include "aicpusd_status.h"
#include "securec.h"
#include "aicpusd_common.h"
#include "aicpusd_hal_interface_ref.h"

#ifdef __cplusplus
extern "C" {
#endif
#ifdef __cplusplus
}
#endif

namespace {
    constexpr const uint32_t DEVICE_NUM = 64U;
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
    // 特权开关打开为1
    constexpr int64_t SAFE_VERIFY_OPEN = 1;
}

namespace AicpuSchedule {
    AicpuDrvManager &AicpuDrvManager::GetInstance()
    {
        static AicpuDrvManager instance;
        return instance;
    }

    int32_t AicpuDrvManager::GetNormalAicpuInfo(const uint32_t deviceId)
    {
        int64_t aicpuNum = 0;
        int64_t aicpuBitMap = 0;
        int32_t ret = 0;
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_CORE_NUM, &aicpuNum) +
                  halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_OCCUPY, &aicpuBitMap);
        } else {
            ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &aicpuNum) +
                  halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_OCCUPY, &aicpuBitMap);
        }
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halGetDeviceInfo failed, ret[%d], deviceId[%u], DEV_MODULE_TYPE[%d], DEV_INFO_TYPE[%d]",
                        ret, deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
                        static_cast<int32_t>(INFO_TYPE_PF_OCCUPY));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        aicpusd_run_info("aicpuBitMap[%lld], aicpuNum[%lld]", aicpuBitMap, aicpuNum);
        aicpuNum_ = static_cast<uint32_t>(aicpuNum);
        aicpuIdVec_.clear();
        for (uint32_t i = 0U; i < DEVICE_MAX_CPU_NUM; i++) {
            if ((static_cast<uint64_t>(aicpuBitMap) & 0x1UL) != 0) {
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

    int32_t AicpuDrvManager::InitDrvMgr(const uint32_t deviceId, const pid_t hostPid,
                                        const uint32_t vfId, const bool hasThread)
    {
        if (deviceId >= DEVICE_NUM) {
            aicpusd_err("invalid device id[%u]", deviceId);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        SetSafeVerifyFlag(deviceId);
        InitSocType(deviceId);
        int32_t ret;
        if (!FeatureCtrl::IsAosCore()) {
            ret = GetNormalAicpuInfo(deviceId);
            if (ret != 0) {
                aicpusd_err("GetNormalAicpuInfo error, ret[%d]", ret);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            GetCcpuInfo(deviceId);
        }

        uint32_t deviceIdTmp = deviceId;
        if (FeatureCtrl::IsVfModeDie1(deviceId)) {
            int64_t pfDeviceId = 0;
            ret = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_DIE_ID, &pfDeviceId);
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("halGetDeviceInfo get pfDeviceId fail in device[%d], ret[%d]", deviceId, ret);
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
        uint32_t retDrv = static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_AICPU,
            INFO_TYPE_CORE_NUM, &aicpuNum));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_AICPU,
            INFO_TYPE_OS_SCHED, &aicpuOsSched));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_CCPU,
            INFO_TYPE_CORE_NUM, &ccpuNum));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_CCPU,
            INFO_TYPE_OS_SCHED, &ccpuOsSched));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_DCPU,
            INFO_TYPE_CORE_NUM, &dcpuNum));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_DCPU,
            INFO_TYPE_OS_SCHED, &dcpuOsSched));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_TSCPU,
            INFO_TYPE_CORE_NUM, &tsCpuNum));
        retDrv |= static_cast<uint32_t>(halGetDeviceInfo(deviceIdTmp, MODULE_TYPE_TSCPU,
            INFO_TYPE_OS_SCHED, &tsCpuOsSched));
        if (retDrv != 0U) {
            aicpusd_err("halGetDeviceInfo failed, ret[%u]", retDrv);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        if (FeatureCtrl::IsAosCore()) {
            aicpuNum_ = aicpuNum;
            if (ccpuOsSched != 0) {
                aicpuBaseId_ += ccpuNum;
            }
            if (dcpuOsSched != 0) {
                aicpuBaseId_ += dcpuNum;
            }
        }
        // connot overflow
        coreNumPerDev_ = (ccpuNum * ccpuOsSched) +
                         (dcpuNum * dcpuOsSched) +
                         (aicpuNum * aicpuOsSched) +
                         (tsCpuNum * tsCpuOsSched);
        dcpuBase_ = (deviceIdTmp * coreNumPerDev_) + ccpuNum;
        dcpuNum_ = dcpuNum;
        aicpusd_run_info("device id[%u], host pid[%d], first aicpu index[%u], aicpu num[%u],"
                         " dcpu base index[%u], dcpu num[%u], vf id[%u]",
                         deviceIdTmp, hostPid, aicpuBaseId_, aicpuNum_, dcpuBase_, dcpuNum_, vfId);
        deviceId_ = deviceId;
        hostPid_ = hostPid;
        vfId_ = vfId;
        hasThread_ = hasThread;
        isInit_ = true;

        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            uniqueVfId_ = deviceId;
        } else {
            uniqueVfId_ = vfId;
            if (FeatureCtrl::IsAosCore()) {
                return AICPU_SCHEDULE_OK;
            }
            if ((deviceId != 0U) && (vfId != 0U)) {
                uint32_t maxNumSpDev = 0U;
                const auto vfMaxRet = halGetDeviceVfMax(deviceId, &maxNumSpDev);
                if ((vfMaxRet != DRV_ERROR_NONE) || (maxNumSpDev > DEVICE_MAX_SPLIT_NUM)) {
                    aicpusd_err("Failed to get device cat vf number, result[%d], max num[%u].", vfMaxRet, maxNumSpDev);
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
                uniqueVfId_ = maxNumSpDev * deviceId + vfId;
            }
        }

        return AICPU_SCHEDULE_OK;
    }

    void AicpuDrvManager::InitSocType(const uint32_t deviceId)
    {
        int64_t hardwareVersion = 0L;
        const int32_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Get device info failed, deviceId=%u", deviceId);
            return;
        }

        FeatureCtrl::Init(hardwareVersion, deviceId);
        return;
    }

    int32_t AicpuDrvManager::InitDrvSchedModule(const uint32_t grpId)
    {
        // use driver event means has thread
        hasThread_ = true;
        aicpusd_info("Attach device[%u] to drv scheduler.", deviceId_);
        int32_t ret = halEschedAttachDevice(deviceId_);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to attach device in drv, result[%d].", ret);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        aicpusd_info("Create group[%u], type[%d]", grpId, GRP_TYPE_BIND_DP_CPU);
        ret = halEschedCreateGrp(deviceId_, grpId, GRP_TYPE_BIND_DP_CPU);
        if (ret != DRV_ERROR_NONE) {
            (void) halEschedDettachDevice(deviceId_);
            aicpusd_err("Failed to attach device in drv, result[%d].", ret);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        if (FeatureCtrl::ShouldInitDrvThread() && (&halDrvEventThreadInit != nullptr)) {
            ret = halDrvEventThreadInit(deviceId_);
            aicpusd_run_info("Enable process drv queue msg on ccpu, ret is %d.", static_cast<int32_t>(ret));
        }

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
                aicpusd_run_info("call drvQueryProcessHostPid success, hostpid[%d], cpType[%d]", hostpid, cpType);
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
        aicpusd_info("Get aicpu core num[%u]", aicpuNum_);
        return aicpuNum_;
    }

    int32_t AicpuDrvManager::GetCcpuInfo(const uint32_t deviceId)
    {
        int64_t ccpuBitMap = 0;
        const int32_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_CCPU, INFO_TYPE_OCCUPY, &ccpuBitMap);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halGetDeviceInfo failed, devid:%u, ret[%d]", deviceId, ret);
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

    void AicpuDrvManager::SetSafeVerifyFlag(const uint32_t deviceId)
    {
        int64_t verifyFlag = 0;
        const auto drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_CUST_OP_ENHANCE, &verifyFlag);
        if (drvRet == DRV_ERROR_NOT_SUPPORT) {
            aicpusd_info("safe flag not support");
            return;
        }
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_run_warn("get device info by halGetDeviceInfo failed, errorCode[%d] deviceId[%u]", drvRet, deviceId);
            return;
        }
        if (verifyFlag == SAFE_VERIFY_OPEN) {
            needSafeVerify_ = false;
            aicpusd_info("set verify flag to false");
        }
    }
}  // namespace AicpuSchedule