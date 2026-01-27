/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_FEATURE_CTRL_H
#define QUEUE_SCHEDULE_FEATURE_CTRL_H

#include <cstdint>

namespace bqs {

class QSFeatureCtrl {
public:
    /**
     * @brief 检查是否支持可见设备功能
     * @return true-支持, false-不支持
     */
    static bool IsSupportSetVisibleDevices(int64_t chip);
    
    /**
     * @brief 检查是否设置线程FIFO调度
     * @param deviceId 设备ID
     * @return true-需要设置, false-不需要设置
     */
    static bool ShouldSetThreadFIFO(uint32_t deviceId);
    
    /**
     * @brief 检查是否添加到控制组(cgroup)
     * @param deviceId 设备ID
     * @return true-需要添加, false-不需要添加
     */
    static bool ShouldAddToCGroup(uint32_t deviceId);

    static bool UseErrorLogThreshold(uint32_t deviceId);

    static bool ShouldDisableRecvRequestEvent(uint32_t deviceId);

    static bool ShouldSetPidPriority(uint32_t deviceId);
};
} // namespace bqs
#endif // QUEUE_SCHEDULE_FEATURE_CTRL_H