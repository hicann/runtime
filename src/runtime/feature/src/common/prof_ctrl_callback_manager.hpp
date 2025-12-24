/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_PROF_CTRL_CALLBACK_MANAGER_HPP
#define CCE_RUNTIME_PROF_CTRL_CALLBACK_MANAGER_HPP

#include "base.hpp"

namespace cce {
namespace runtime {

class ProfCtrlCallbackManager {
public:
    static ProfCtrlCallbackManager &Instance();
    rtError_t RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback);
    void Notify(const uint32_t dataType, void * const data, const uint32_t dataLen);
    void DelAllData();
    void SaveProfSwitchData(const rtProfCommandHandle_t * const data, const uint32_t len);
    void NotifyProfInfo(const uint32_t moduleId);
    uint64_t GetSwitchData() const;
private:
    ProfCtrlCallbackManager() = default;
    ~ProfCtrlCallbackManager() = default;
    ProfCtrlCallbackManager(const ProfCtrlCallbackManager &other) = delete;
    ProfCtrlCallbackManager &operator=(const ProfCtrlCallbackManager &other) = delete;
    ProfCtrlCallbackManager(ProfCtrlCallbackManager &&other) = delete;
    ProfCtrlCallbackManager &operator=(ProfCtrlCallbackManager &&other) = delete;
    void NotifyOneModule(const uint32_t moduleId, const uint32_t dataType, void * const data, const uint32_t dataLen);
private:
    std::map<std::uint32_t, rtProfCtrlHandle> callbackMap_;
    std::mutex mapMutex_;
    rtProfCommandHandle_t switchData_;
    bool switchIsSet_;
};

}
}

#endif // CCE_RUNTIME_PROF_CTRL_CALLBACK_MANAGER_HPP
