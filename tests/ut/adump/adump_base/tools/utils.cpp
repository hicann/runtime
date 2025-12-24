/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include <sstream>
#include <string>
#include <iostream>
#include <filesystem>
#include <iterator>
#include "utils.h"

namespace Adx {
std::string ReadFileToString(const std::string &filePath)
{
    std::error_code ec;
    auto fileSize = std::filesystem::file_size(filePath, ec);
    if (ec) {
        std::cerr << "Can get file size: " << filePath << " - " << ec.message() << std::endl;
        return "";
    }

    const size_t MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    if (fileSize > MAX_FILE_SIZE) {
        std::cerr << "file size is larger: " << filePath << " (" << fileSize << " bytes)" << std::endl;
        return "";
    }

    std::ifstream file(filePath, std::ios::binary);
    if (!file.is_open()) {
        std::cerr << "Can not open file: " << filePath << std::endl;
        return "";
    }
    // 预分配内存
    std::string content;
    content.reserve(fileSize);

    // 更高效的读取方式
    content.assign(std::istreambuf_iterator<char>(file),
                   std::istreambuf_iterator<char>());
    return content;
}
} // namespace Adx