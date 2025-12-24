/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_error_manager.h"

namespace Analysis {
namespace Dvvp {
namespace MsprofErrMgr {
error_message::Context MsprofErrorManager::errorContext_ = {0UL, "", "", ""};

error_message::Context &MsprofErrorManager::GetErrorManagerContext() const
{
    return errorContext_;
}

void MsprofErrorManager::SetErrorContext(const error_message::Context /* errorContext */) const
{
}

void MsprofErrorManager::ReportErrorMessage(const std::string errorCode, const std::vector<std::string> &keys,
    const std::vector<std::string> &values) const
{
    char **argList = new(std::nothrow) char* [keys.size()]();
    if (argList == nullptr) {
        return;
    }
    for (size_t i = 0; i < keys.size(); i++) {
        argList[i] = const_cast<char*>(keys[i].c_str());
    }

    char **argVals = new(std::nothrow) char* [values.size()]();
    if (argVals == nullptr) {
        delete[] argList;
        return;
    }
    for (size_t i = 0; i < values.size(); i++) {
        argVals[i] = const_cast<char*>(values[i].c_str());
    }

    ReportErrMessage(errorCode.c_str(), argList, argVals, keys.size());
    delete[] argList;
    delete[] argVals;
}
}  // ErrorManager
}  // Dvvp
}  // namespace Analysis