/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_ERROR_MANAGER_H
#define MSPROF_ERROR_MANAGER_H

#include <string>
#include <vector>
#include "base/err_mgr.h"
#include "common/singleton/singleton.h"

namespace Analysis {
namespace Dvvp {
namespace MsprofErrMgr {
// REPORT_PREDEFINED_ERR_MSG takes std::vector<const char *>, while every business call site passes
// std::vector<std::string>. Converting here keeps all call sites unchanged.
inline std::vector<const char*> ToCStrVec(const std::vector<std::string>& in)
{
    std::vector<const char*> out;
    out.reserve(in.size());
    for (const auto& s : in) {
        out.emplace_back(s.c_str());
    }
    return out;
}
} // namespace MsprofErrMgr
} // namespace Dvvp
} // namespace Analysis

// Materialise the arguments into named locals before taking c_str(): call sites routinely build the
// vectors inline as temporaries. Such temporaries would live to the end of the full expression
// anyway, but binding them to the do/while block makes the lifetime explicit, so a later rewrite of
// this macro into separate statements cannot silently introduce a dangling pointer.
#define MSPROF_INPUT_ERROR(errorCode, key, value)                                  \
    do {                                                                           \
        const std::vector<std::string> msprofErrKeys__ = (key);                    \
        const std::vector<std::string> msprofErrVals__ = (value);                  \
        REPORT_PREDEFINED_ERR_MSG(                                                 \
            (errorCode), Analysis::Dvvp::MsprofErrMgr::ToCStrVec(msprofErrKeys__), \
            Analysis::Dvvp::MsprofErrMgr::ToCStrVec(msprofErrVals__));             \
    } while (false)

#define MSPROF_ENV_ERROR MSPROF_INPUT_ERROR
#define MSPROF_INNER_ERROR REPORT_INNER_ERR_MSG
#define MSPROF_CALL_ERROR REPORT_INNER_ERR_MSG

namespace Analysis {
namespace Dvvp {
namespace MsprofErrMgr {

class MsprofErrorManager : public analysis::dvvp::common::singleton::Singleton<MsprofErrorManager> {
public:
    error_message::ErrorManagerContext& GetErrorManagerContext() const;
    void SetErrorContext(const error_message::ErrorManagerContext errorContext) const;
    MsprofErrorManager() {}
    ~MsprofErrorManager() override {}

private:
    static error_message::ErrorManagerContext errorContext_;
};

} // namespace MsprofErrMgr
} // namespace Dvvp
} // namespace Analysis
#endif