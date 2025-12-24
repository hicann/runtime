/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_DEVICE_API_H
#define PROF_DEVICE_API_H

#include <map>
#include <string>
#include "aprof_pub.h"
#include "singleton/singleton.h"
namespace ProfAPI {
class ProfDevApi : public analysis::dvvp::common::singleton::Singleton<ProfDevApi> {
public:
    ProfDevApi();
    ~ProfDevApi() override;
    int32_t ProfInit(uint32_t dataType, void *data, uint32_t dataLen);
    int32_t ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);
    int32_t ProfFinalize();
    uint64_t ProfStr2Id(const char *hashInfo, size_t length);
    int32_t ProfReportAdditionalInfo(uint32_t agingFlag, const void *data, uint32_t length);
    int32_t ProfReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
    size_t ProfGetBatchReportMaxSize(uint32_t type);

private:
    void *libHandle_{nullptr};
    std::map<std::string, void *> funcMap_;
};
}
#endif