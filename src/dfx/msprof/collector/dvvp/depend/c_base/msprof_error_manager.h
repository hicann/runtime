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
#include "base/err_mgr.h"
#include "common/singleton/singleton.h"

// The locally defined error_message::Context is gone: err_mgr.h now supplies the official
// ErrorManagerContext in the same namespace, and keeping a same-named struct with a different field
// naming style (workStreamId vs work_stream_id) would be actively confusing.

// C entry point this variant reports through. It used to come in transitively via error_manager.h;
// declared explicitly now that the wrapper only includes base/err_mgr.h.
#ifdef __cplusplus
extern "C" {
#endif
void ReportErrMessage(const char* errorCode, char* args[], char* argValues[], int32_t argsNum);
#ifdef __cplusplus
}
#endif

namespace Analysis {
namespace Dvvp {
namespace MsprofErrMgr {

class MsprofErrorManager : public analysis::dvvp::common::singleton::Singleton<MsprofErrorManager> {
public:
    error_message::ErrorManagerContext& GetErrorManagerContext() const;
    void SetErrorContext(const error_message::ErrorManagerContext errorContext) const;
    MsprofErrorManager() {}
    ~MsprofErrorManager() override {}
    void ReportErrorMessage(
        const std::string errorCode, const std::vector<std::string>& keys = {},
        const std::vector<std::string>& values = {}) const;

private:
    static error_message::ErrorManagerContext errorContext_;
};

#define MSPROF_INPUT_ERROR(errorCode, key, value) \
    Analysis::Dvvp::MsprofErrMgr::MsprofErrorManager::instance()->ReportErrorMessage(errorCode, key, value)

#define MSPROF_ENV_ERROR MSPROF_INPUT_ERROR
#define MSPROF_INNER_ERROR REPORT_INNER_ERR_MSG
#define MSPROF_CALL_ERROR MSPROF_INNER_ERROR
} // namespace MsprofErrMgr
} // namespace Dvvp
} // namespace Analysis
#endif