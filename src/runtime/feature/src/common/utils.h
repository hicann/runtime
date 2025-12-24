/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_UTILS_H
#define CCE_RUNTIME_UTILS_H
#include <cstdint>
#include <string>
#include <iostream>
namespace cce {
namespace runtime {
bool GetConfigIniValueInt32(const std::string &userFileName, const std::string &key, int32_t &val);
const std::string RealPath(const std::string &path);
bool IsStringNumeric(const std::string& str);
bool GetDriverPath(std::string &driverPath);
std::string GetFileName(const std::string &path);
std::string GetFilePathByExtension(const std::string &binPath, std::string extension);
const std::string RealPathForFileNotExists(const std::string &inputPath);
}
}
#endif
