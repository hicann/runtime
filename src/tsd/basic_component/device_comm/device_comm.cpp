/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_comm.h"

#include "tsd_hdc_client.h"
#include "inc/basic_define.h"
#include "tsd_util_func.h"
#include "tsd_log.h"

namespace tsd {
    /**
    * @ingroup DeviceComm
    * @brief DeviceComm构造函数
    */
    DeviceComm::DeviceComm(const uint32_t devId, const DeviceCommType commType)
        : deviceId_(devId),
          commType_(commType)
    {
    }

    /**
    * @ingroup DeviceComm
    * @brief 静态工厂函数，根据 commType 生成具体子类实例并维护单例
    * @param [in] devId : 建立连接的Device设备ID
    * @param [in] commType : 设备通信类型
    * @return DeviceComm单例类实例
    */
    std::shared_ptr<DeviceComm> DeviceComm::GetInstance(const uint32_t devId, const DeviceCommType commType)
    {
        // 校验Client端，device ID范围[0-128)
        if (devId >= MAX_DEVNUM_PER_HOST) {
            TSD_ERROR("deviceId=%u is not supported, not in [0-128]", devId);
            return nullptr;
        }
        uint64_t curIndex = KeyCompose(devId, commType);
        std::shared_ptr<DeviceComm> deviceCommPtr = nullptr;
        {
            std::recursive_mutex *deviceCommMutex = MutexForDeviceCommMap();
            std::map<uint64_t, std::shared_ptr<DeviceComm>> *deviceCommMap = DeviceCommMap();
            std::unordered_map<uint32_t, CreatorFunc> *creatorMap = CreatorMap();
            TSD_CHECK(deviceCommMutex != nullptr, nullptr, "Fail to create deviceComm mutex");
            TSD_CHECK(deviceCommMap != nullptr, nullptr, "Fail to create deviceComm map");
            TSD_CHECK(creatorMap != nullptr, nullptr, "Fail to create creator map");
            const std::lock_guard<std::recursive_mutex> lk(*deviceCommMutex);
            const std::map<uint64_t, std::shared_ptr<DeviceComm>>::iterator iter = deviceCommMap->find(curIndex);
            if (iter != deviceCommMap->end()) {
                return iter->second;
            }
            const std::unordered_map<uint32_t, CreatorFunc>::iterator creatorIter =
                creatorMap->find(static_cast<uint32_t>(commType));
            if (creatorIter == creatorMap->end()) {
                TSD_ERROR("DeviceCommType=%u is not supported", static_cast<uint32_t>(commType));
                return nullptr;
            }
            deviceCommPtr = creatorIter->second(devId);
            TSD_CHECK((deviceCommPtr != nullptr), nullptr, "Fail to create deviceCommPtr");
            deviceCommMap->emplace(curIndex, deviceCommPtr);
        }
        return deviceCommPtr;
    }

    bool DeviceComm::Register(DeviceCommType type, CreatorFunc creator)
    {
        std::unordered_map<uint32_t, CreatorFunc> *creatorMap = CreatorMap();
        TSD_CHECK(creatorMap != nullptr, false, "Fail to create creator map");
        creatorMap->emplace(static_cast<uint32_t>(type), std::move(creator));
        return true;
    }
}
