/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_MSPROF_ERROR_MANAGER_H
#define C_BASE_MSPROF_ERROR_MANAGER_H
#include <vector>
#include <string>
#include "error_manager.h"
#include "common/singleton/singleton.h"

namespace error_message {
struct Context {
    uint64_t workStreamId;
    std::string firstStage;
    std::string secondStage;
    std::string logHeader;
};
}
namespace Analysis {
namespace Dvvp {
namespace MsprofErrMgr {

class MsprofErrorManager : public analysis::dvvp::common::singleton::Singleton<MsprofErrorManager> {
public:
    error_message::Context &GetErrorManagerContext() const;
    void SetErrorContext(const error_message::Context errorContext) const;
    MsprofErrorManager() {}
    ~MsprofErrorManager() override {}
    void ReportErrorMessage(const std::string errorCode, const std::vector<std::string> &keys = {},
        const std::vector<std::string> &values = {}) const;

private:
    static error_message::Context errorContext_;
};

#define MSPROF_INPUT_ERROR(errorCode, key, value) \
    Analysis::Dvvp::MsprofErrMgr::MsprofErrorManager::instance()->ReportErrorMessage(errorCode, key, value)

#define MSPROF_ENV_ERROR MSPROF_INPUT_ERROR
#define MSPROF_INNER_ERROR REPORT_INNER_ERROR
#define MSPROF_CALL_ERROR MSPROF_INNER_ERROR
}  // ErrorManager
}  // Dvvp
}  // namespace Analysis
#endif