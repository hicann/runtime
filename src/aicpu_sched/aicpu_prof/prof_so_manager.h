/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_SO_MANAGER_H
#define PROF_SO_MANAGER_H

#include <mutex>
#include <vector>
#include <string>
#include <unordered_map>
#include "prof_dev_api.h"

namespace aicpu {
using ProfAicpuStartRegisterFunc = int32_t (*)(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para);
using ProfReportDataFunc = int32_t (*)(VOID_PTR data, uint32_t len);
using ProfReportAdditionalInfoFunc = int32_t (*)(uint32_t agingFlag, const VOID_PTR data, uint32_t length);
using ProfAdprofAicpuStopFunc = int32_t (*)();

using ProfMsprofInitFunc = int32_t (*)(uint32_t dataType, VOID_PTR data, uint32_t dataLen);
using ProfMsprofReportAdditionalInfoFunc = int32_t (*)(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

int32_t AdprofAicpuStartRegisterFunc(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para);

int32_t AdprofReportDataFunc(VOID_PTR data, uint32_t len);

int32_t AdprofReportAdditionalInfoFunc(uint32_t agingFlag, const VOID_PTR data, uint32_t length);

int32_t AdprofAicpuStopFunc();

int32_t MsprofInitFunc(uint32_t dataType, VOID_PTR data, uint32_t dataLen);

int32_t MsprofReportAdditionalInfoFunc(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

class ProfSoManager {
public:
    static ProfSoManager *GetInstance();

    virtual ~ProfSoManager();

    /**
     * load msprof so
     */
    void LoadSo();

    /**
     * unload msprof so
     */
    void UnloadSo();

    /**
     * get function
     * @param name msprof function name
     * @return void *
     */
    void *GetFunc(const std::string &name) const;

private:
    /**
     * Init Function Map
     */
    void InitFunctionMap(const std::vector<std::string> &funcName);
    ProfSoManager() = default;

    std::unordered_map<std::string, void *> funcMap_;
    
    void *soHandle_ = nullptr;
    std::mutex profMtx_;
};

} // namespace aicpu
#endif // PROF_SO_MANAGER_H
