/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_PROF_MAP_GE_MODEL_DEVICE_HPP
#define CCE_RUNTIME_PROF_MAP_GE_MODEL_DEVICE_HPP

#include <mutex>
#include <map>
#include "runtime/base.h"

namespace cce {
namespace runtime {
class ProfMapGeModelDevice {
public:
    static ProfMapGeModelDevice &Instance();
    ~ProfMapGeModelDevice() = default;
    void SetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
    void UnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
    rtError_t GetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t * const deviceId);
    void DelAllData();
private:
    std::map<const uint32_t, const uint32_t> modelDeviceMap_; // key: geModelId, value: deviceId;
    std::mutex mapMutex_;
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_PROF_MAP_GE_MODEL_DEVICE_HPP
