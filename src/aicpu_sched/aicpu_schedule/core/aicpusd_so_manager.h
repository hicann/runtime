/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SO_MANAGER_H
#define AICPU_SO_MANAGER_H

#include <string>

namespace AicpuSchedule {

class AicpuSoManager {
public:
    AicpuSoManager() = default;
    ~AicpuSoManager();
    static AicpuSoManager &GetInstance();

    /**
     * @brief set deviceId to dvpp
     * @param [in] deviceId
     * @return null
     */
    void SetDeviceIdToDvpp(uint32_t deviceId);

private:
    bool OpenSo(const std::string &soFile);
    void CloseSo();
    // so hande which opened by dlopen
    void *soHandle_ = nullptr;
};
}  // namespace AicpuSchedule
#endif