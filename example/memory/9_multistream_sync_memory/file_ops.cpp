/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "utils.h"
#include "mem_utils.h"
#include <cstdio>
#include <cstdint>
#include <fcntl.h>
#include <unistd.h>

namespace memory {
void WriteFileEx(const char* file, void* data, size_t size) {
    INFO_LOG("Start writing to %s", file);

    int fd = open(file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        ERROR_LOG("Open file %s failed", file);
        (void)close(fd);
        return;
    }

    // Write data to the target file
    ssize_t writeSize = write(fd, data, size);
    if (writeSize != static_cast<ssize_t>(size)) {
        ERROR_LOG("Partial write");
        (void)close(fd);
        return;
    }
    (void)close(fd);
    return;
}
} // namespace memory

namespace memory {
void ReadFileEx(const char* file, void* data, size_t size) {
    INFO_LOG("Start reading from %s", file);

    // Read data from the target file
    int fd = open(file, O_RDONLY);
    if (fd == -1){
        ERROR_LOG("Open file %s failed", file);
        (void)close(fd);
        return;
    }

    ssize_t readSize = read(fd, data, size);
    if (readSize != static_cast<ssize_t>(size)){
        ERROR_LOG("Partial read");
        (void)close(fd);
        return;
    } else {
        INFO_LOG("Read data successfully");
    }
    (void)close(fd);
    return;
}
} // namespace memory