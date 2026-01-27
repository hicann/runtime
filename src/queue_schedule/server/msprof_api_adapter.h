/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_MSPROF_API_ADAPTER_H
#define QUEUE_SCHEDULE_MSPROF_API_ADAPTER_H

#include "toolchain/prof_api.h"
#include "common/bqs_so_manager.h"

namespace bqs {

enum class ProfStatus : int32_t {
    PROF_SUCCESS,
    PROF_FAIL,
    PROF_INVALID_PARA,
    PROF_MSPROF_INNER_ERROR,
    PROF_MSPROF_API_NULLPTR
};

class BqsMsprofApiAdapter : public SoManager {
public:
    BqsMsprofApiAdapter(const std::string &soName) : SoManager(soName) {};
    ~BqsMsprofApiAdapter() = default;

    static BqsMsprofApiAdapter &GetInstance();
    ProfStatus MsprofInit(uint32_t dataType, void *data, uint32_t dataLen);
    ProfStatus MsprofFinalize();
    ProfStatus MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);
    ProfStatus MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);
    ProfStatus MsprofReportApi(uint32_t agingFlag, const MsprofApi *api);
    ProfStatus MsprofReportEvent(uint32_t agingFlag, const MsprofEvent *event);
    uint64_t MsprofSysCycleTime();

private:
    BqsMsprofApiAdapter(const BqsMsprofApiAdapter &) = delete;
    BqsMsprofApiAdapter &operator=(const BqsMsprofApiAdapter &) = delete;
    BqsMsprofApiAdapter(BqsMsprofApiAdapter &&) = delete;
    BqsMsprofApiAdapter &operator=(BqsMsprofApiAdapter &&) = delete;
};
} // namespace bqs

#endif // QUEUE_SCHEDULE_MSPROF_API_ADAPTER_H
