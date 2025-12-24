/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "adump_error_manager.h"

namespace Adx {
void ReportInvalidArgumentError(const std::string param, const std::string value, const std::string reason)
{
    (void)param;
    (void)value;
    IDE_LOGE("%s", reason.c_str());
    ADUMP_INPUT_ERROR(INVALID_ARGUMENT, std::vector<std::string>({"param", "value", "reason"}),
        std::vector<std::string>({param, value, reason}));
}

void ReportFileOperationError(const std::string &path, const std::string &reason)
{
    (void)path;
    IDE_LOGE("%s", reason.c_str());
    ADUMP_INPUT_ERROR(FILE_OPERATION_ERROR, std::vector<std::string>({"path", "reason"}),
        std::vector<std::string>({path, reason}));
}

void ReportConfigParseError(const std::string &reason)
{
    ADUMP_INPUT_ERROR(MEMORY_JSON_PARSE_FAILED, std::vector<std::string>({"reason"}),
        std::vector<std::string>({reason}));
    (void)reason;
}
}