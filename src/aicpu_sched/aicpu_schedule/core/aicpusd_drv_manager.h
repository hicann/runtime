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

#include <cstdint>
#include <fcntl.h>
#include <unistd.h>
#include <vector>
#include <map>
#include <string>
#include "aicpusd_context.h"
#include "ascend_hal.h"
#include "aicpu_context.h"
#include "aicpusd_feature_ctrl.h"

namespace AicpuSchedule {
    // invalid aicpuid
    constexpr uint32_t INVALID_AICPU_ID = 65535U;
    class AicpuDrvManager {
    public:
        static AicpuDrvManager &GetInstance();

        int32_t GetNormalAicpuDCpuInfo(const std::vector<uint32_t> &deviceVec);
        int32_t GetThreadVfAicpuDCpuInfo(const std::vector<uint32_t> &deviceVec);
        int32_t GetNormalAicpuInfo(const std::vector<uint32_t> &deviceVec);
        int32_t GetCcpuInfo(const std::vector<uint32_t> &deviceVec);

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to init.
        * @param [in] deviceId : device id.
        * @param [in] hostPid : host pid.
        * @param [in] vfId : vf id.
        * @param [in] hasThread : has thread flag.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t InitDrvMgr(const std::vector<uint32_t> &deviceVec, const pid_t hostPid,
                           const uint32_t vfId, const bool hasThread,
                           const aicpu::AicpuRunMode runMode = aicpu::AicpuRunMode::INVALID_MODE,
                           const std::string &hostProcName = "");

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to init driver sched module.
        * @param [in] grpId : the group id.
        * @param [in] priority : event priority
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t InitDrvSchedModule(const uint32_t grpId,
                                   const std::map<EVENT_ID, SCHEDULE_PRIORITY> &priority);

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to subscribe queue not-empty event.
        * @param [in] queueId : the queue id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t SubscribeQueueNotEmptyEvent(const uint32_t queueId) const;

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to un-subscribe queue not-empty event.
        * @param [in] queueId : the queue id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t UnSubscribeQueueNotEmptyEvent(const uint32_t queueId) const;

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to subscribe queue not-full event.
        * @param [in] queueId : the queue id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t SubscribeQueueNotFullEvent(const uint32_t queueId) const;

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used to un-subscribe queue not-full event.
        * @param [in] queueId : the queue id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t UnSubscribeQueueNotFullEvent(const uint32_t queueId) const;

        /**
        * @ingroup AicpuDrvManager
        * @brief it is used qurey buff group info including groupname and attribute.
        * @param [in] procId : process id.
        * @param [in] buffGrpInfo : buff info include name and attribute.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t QueryProcBuffInfo(uint32_t procId, std::map<std::string, GroupShareAttr> &buffGrpInfo) const;

        uint32_t GetDeviceId() const
        {
            return (deviceVec_.size() == 0LU) ? 0U : deviceVec_[0];
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

        uint32_t GetVfId() const
        {
            return vfId_;
        }

        uint32_t GetGroupId() const
        {
            return groupId_;
        }

        bool HasThread() const
        {
            return hasThread_;
        }

        std::vector<uint32_t> GetDeviceList() const;

        uint32_t GetAicpuNum() const;

        uint32_t GetAicpuNumPerDevice() const;

        uint32_t GetAicpuPhysIndex(const uint32_t aicpuLogIndex, const uint32_t deviceId) const;

        std::vector<uint32_t> GetAicpuPhysIndexs(const uint32_t deviceId);

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

        int32_t BindHostPid(const std::string &signStr,
                            const int32_t mode,
                            const uint32_t vfId,
                            const enum devdrv_process_type cpType) const;

        int32_t CheckBindHostPid() const;

        inline std::string GetHostProcName() const
        {
            return hostProcName_;
        }

        uint32_t GetCcpuPhysIndex(const uint32_t ccpuLogIndex, const uint32_t deviceId) const
        {
            if (ccpuLogIndex >= ccpuIdVec_.size()) {
                aicpusd_err("Invalid ccpu index %u %u", ccpuLogIndex, ccpuIdVec_.size());
                return 0;
            }
            const uint32_t phyIndex = (coreNumPerDev_ * deviceId) + ccpuIdVec_[ccpuLogIndex];
            return phyIndex;
        }

        std::vector<uint32_t> GetCcpuList()
        {
            return ccpuIdVec_;
        }

    private:
        AicpuDrvManager() : deviceVec_({}), deviceNum_(0UL), coreNumPerDev_(0U), hostPid_(0), groupId_(0U),
                            hasThread_(false), isInit_(false), aicpuNumPerDev_(0U), aicpuBaseId_(0U), dcpuBase_(0U),
                            dcpuNum_(0U), vfId_(0U), uniqueVfId_(0U), hostProcName_(""), aicpuIdVec_({}),
                            aicpuPhyIds_({}), ccpuIdVec_({}) {};

        virtual ~AicpuDrvManager() = default;

        AicpuDrvManager(const AicpuDrvManager &) = delete;

        AicpuDrvManager &operator=(const AicpuDrvManager &) = delete;

        int32_t InitDrvZone() const;

        void DettachAllDevice(const size_t deviceIndex) const;

        int32_t AicpuGetDeviceInfo(uint32_t deviceId, const DEV_MODULE_TYPE moduleType, const DEV_INFO_TYPE infoType,
                                   int64_t *value) const;

        void InitDrvMgrCaluniqueVfId(const std::vector<uint32_t> &deviceVec, const uint32_t vfId);

        void InitSocType(const uint32_t deviceId);

        bool IsSvmShareGrp(const std::string &grpName) const;

        // the id of the chip.
        std::vector<uint32_t> deviceVec_;

        // device num
        size_t deviceNum_;

        // core num of device
        uint32_t coreNumPerDev_;

        // the pid of host process
        pid_t hostPid_;

        // the id is used to group in process.
        uint32_t groupId_;

        // it is used to mark which is in call mode or multi-thread mode.
        bool hasThread_;

        // init function called or not, lhisi is will be false
        bool isInit_;

        // aicpu core num
        uint32_t aicpuNumPerDev_;

        // aicpu base index
        uint32_t aicpuBaseId_;

        // dcpu base index
        uint32_t dcpuBase_;

        // dcpu number
        uint32_t dcpuNum_;

        // vf id
        uint32_t vfId_;

        // calc by deviceId and vfId for vfId uniqueization
        uint32_t uniqueVfId_;

        // host proc name
        std::string hostProcName_;

        // aicpu index
        std::vector<uint32_t> aicpuIdVec_;

        // aicpu physic index
        std::vector<uint32_t> aicpuPhyIds_;

        // ccpu index
        std::vector<uint32_t> ccpuIdVec_;
    };
}

#endif // CORE_AICPUSD_DRV_MANAGER_H
