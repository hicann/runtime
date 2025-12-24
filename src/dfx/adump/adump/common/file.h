/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_FILE_H
#define ADUMP_COMMON_FILE_H

#include <string>
#include "mmpa_api.h"

namespace Adx {
class File {
public:
    explicit File(const std::string &path, int32_t flag, mmMode_t mode = M_IRUSR | M_IWUSR);
    ~File();
    int32_t IsFileOpen() const;
    int64_t Write(const char * const buffer, int64_t length) const;
    int64_t Read(char *buffer, int64_t length) const;
    static int32_t Copy(const std::string &srcPath, const std::string &dstPath);
    int32_t GetFileDiscriptor() const;
private:
    int32_t Open(int32_t flag, mmMode_t mode = M_IRUSR | M_IWUSR);
    int32_t Close();
    int32_t AddMapping(const std::string &filePath, const std::string &fileName, const std::string &hashName);
    std::string filePath_;
    int32_t fd_;
};
} // namespace Adx
#endif // ADUMP_COMMON_FILE_H