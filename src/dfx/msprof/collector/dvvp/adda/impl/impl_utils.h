/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_COMMON_UTILS_H
#define IDE_DAEMON_COMMON_UTILS_H

#include <string>
#include <vector>
#include "mmpa_api.h"
#include "hdc_api.h"
#include "ide_daemon_api.h"

#ifndef M_TRUNC
#define M_TRUNC O_TRUNC
#endif
namespace IdeDaemon {
namespace Common {
namespace Utils {
std::string ReplaceWaveToHomeDir(const std::string &filePath);
bool IsValidDirChar(const std::string &path);
std::vector<std::string> Split(const std::string &inputStr, bool filterOutEnabled = false,
    const std::string &filterOut = "", const std::string &pattern = " ");
std::string LeftTrim(const std::string &str, const std::string &trims);
}
}
}
#endif // __IDE_DAEMON_COMMON_UTILS_H__
