/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADPROF_COLLECTOR_PROXY_H
#define ADPROF_COLLECTOR_PROXY_H
#include <functional>
#include "singleton/singleton.h"
#include "utils/utils.h"

class AdprofCollectorProxy : public analysis::dvvp::common::singleton::Singleton<AdprofCollectorProxy> {
public:
    AdprofCollectorProxy();
    ~AdprofCollectorProxy() override;

public:
    int32_t BindFunction(
        std::function<int32_t(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>)> reportFunc,
        std::function<bool()> adprofStartedFunc
    );
    int32_t Report(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk);
    bool AdprofStarted();

private:
    std::function<int32_t(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>)> reportFunctionPointer{nullptr};
    std::function<bool()> adprofStartedFunctionPointer{nullptr};
};
#endif