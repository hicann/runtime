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
#include <sys/stat.h>

namespace memory {
void WriteFile(const char* filePath, const char* doneFile, void* data, size_t size) {
    INFO_LOG("Start writing to %s", filePath);

    int fd = open(filePath, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        ERROR_LOG("Open file %s failed", filePath);
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

    // Create a file to indicate that data writing is complete
    int fdDone = open(doneFile, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fdDone == -1) {
        ERROR_LOG("Open file %s failed", doneFile);
        (void)close(fdDone);
        return;
    }
    (void)close(fdDone);
    return;
}
} // namespace memory

namespace memory {
void ReadFile(const char* filePath, const char* doneFile, void* data) {
    INFO_LOG("Start reading from %s", filePath);
    constexpr uint32_t waitTime = 1000000;
    int attempts = 0;
    const int attemptsMax = 1000000000;

    // Wait for data writing to complete
    while (attempts < attemptsMax) {
        int fdDone = open(doneFile, O_RDONLY);
        if (fdDone != -1) {
            (void)close(fdDone);
            break;
        } else {
            attempts++;
            WARN_LOG("Data writing not yet complete");
            if (attempts >= attemptsMax) {
                ERROR_LOG("Open file %s failed", doneFile); 
                return;
            }
            (void)usleep(waitTime);
        }
    }

    // Read data from the target file
    int fd = open(filePath, O_RDONLY);
    if (fd == -1){
        ERROR_LOG("Open file %s failed", filePath);
        (void)close(fd);
        return;
    }

    struct stat fileStat;
    if (fstat(fd, &fileStat) == -1) {
        ERROR_LOG("Run fstat failed");
        (void)close(fd);
        return;
    }
    size_t fileSize = static_cast<size_t>(fileStat.st_size);
    ssize_t readSize = read(fd, data, fileSize);
    if (readSize != static_cast<ssize_t>(fileSize)){
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