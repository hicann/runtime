/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_DRV_MANAGER_H
#define CORE_AICPUSD_DRV_MANAGER_H
#include <string>
#include <vector>
#include <sys/types.h>
#include "ascend_hal.h"
#include "feature_ctrl.h"

namespace AicpuSchedule {
    class AicpuDrvManager {
    public:
        static AicpuDrvManager &GetInstance();

        int32_t GetNormalAicpuInfo(const uint32_t deviceId);

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to init.
        * @param [in] deviceId : device id.
        * @param [in] hostPid : host pid
        * @param [in] vfId : vf id
        * @param [in] hasThread : has thread flag.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t InitDrvMgr(const uint32_t deviceId, const pid_t hostPid,
                           const uint32_t vfId, const bool hasThread);

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to init driver sched module.
        * @param [in] grpId : the group id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t InitDrvSchedModule(const uint32_t grpId);

        uint32_t GetDeviceId() const
        {
            return deviceId_;
        }

        uint32_t GetUniqueVfId() const
        {
            return uniqueVfId_;
        }

        pid_t GetHostPid() const
        {
            if (isInit_) {
                return hostPid_;
            }
            return drvDeviceGetBareTgid();
        }

        uint32_t GetGroupId() const
        {
            return groupId_;
        }

        uint32_t GetVfId() const
        {
            return vfId_;
        }

        bool HasThread() const
        {
            return hasThread_;
        }

        uint32_t GetAicpuNum() const;

        uint32_t GetAicpuPhysIndex(const uint32_t aicpuLogIndex) const
        {
            if (FeatureCtrl::IsAosCore()) {
                // connot overflow
                return ((aicpuBaseId_ + aicpuNum_) * deviceId_) + aicpuBaseId_ + aicpuLogIndex;
            } else {
                return (coreNumPerDev_ * deviceId_) + aicpuIdVec_[aicpuLogIndex];
            }
        }

        uint32_t GetAicpuPhysIndexInVfMode(const uint32_t aicpuLogIndex, const uint32_t deviceId) const
        {
            if (FeatureCtrl::IsVfModeDie1(deviceId)) {
                return coreNumPerDev_ + aicpuIdVec_[static_cast<size_t>(aicpuLogIndex)];
            }
            return aicpuIdVec_[static_cast<size_t>(aicpuLogIndex)];
        }

        void GetDcpuRange(uint32_t &dcpuBase, uint32_t &dcpuNum) const
        {
            dcpuBase = dcpuBase_;
            dcpuNum = dcpuNum_;
        }

        int32_t CheckBindHostPid() const;

        int32_t GetCcpuInfo(const uint32_t deviceId);

        std::vector<uint32_t> GetCcpuList()
        {
            return ccpuIdVec_;
        }

        bool GetSafeVerifyFlag() const
        {
            return needSafeVerify_;
        }
    private:
        AicpuDrvManager() : deviceId_(0U), coreNumPerDev_(0U), hostPid_(0), vfId_(0U), groupId_(0U), hasThread_(false),
                            isInit_(false), aicpuNum_(0U), aicpuBaseId_(0U), aicpuIdVec_({}), dcpuBase_(0U),
                            dcpuNum_(0U), uniqueVfId_(0U), needSafeVerify_(true) {}

        ~AicpuDrvManager() = default;

        AicpuDrvManager(const AicpuDrvManager &) = delete;

        AicpuDrvManager &operator=(const AicpuDrvManager &) = delete;

        void InitSocType(const uint32_t deviceId);

        void SetSafeVerifyFlag(const uint32_t deviceId);

        // the id of the chip.
        uint32_t deviceId_;

        // core num of device
        uint32_t coreNumPerDev_;

        // the pid of host process
        pid_t hostPid_;

        // vf id
        uint32_t vfId_;

        // the id is used to group in process.
        uint32_t groupId_;

        // it is used to mark which is in call mode or multi-thread mode.
        bool hasThread_;

        // init function called or not, lhisi is will be false
        bool isInit_;

        // aicpu core num
        uint32_t aicpuNum_;

        // aicpu base index
        uint32_t aicpuBaseId_;

        // aicpu index
        std::vector<uint32_t> aicpuIdVec_;

        // dcpu base index
        uint32_t dcpuBase_;

        // dcpu number
        uint32_t dcpuNum_;

        // calc by deviceId and vfId for vfId uniqueization
        uint32_t uniqueVfId_;

        std::vector<uint32_t> ccpuIdVec_;

        bool needSafeVerify_;
    };
}
#endif // CORE_AICPUSD_DRV_MANAGER_H
