/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DEVPROF_API_H
#define DEVPROF_API_H

#include <map>
#include <string>
#include "prof_dev_api.h"

class DevprofApi {
public:
    DevprofApi();
    ~DevprofApi();
    int32_t CheckFeatureIsOn(uint64_t feature);
    int32_t Start(int32_t argc, const char *argv[]);
    int32_t Stop();
    int32_t GetIsExit();
    uint64_t GetHashId(const char *hashInfo, size_t length);
    int32_t AicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para);
    int32_t ReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
    int32_t ReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
    size_t GetBatchReportMaxSize(uint32_t type);

    static DevprofApi *Instance() { return &item_; }

private:
    void *libHandle_{nullptr};
    std::map<std::string, void *> funcMap_;
    static DevprofApi item_;
};
#endif