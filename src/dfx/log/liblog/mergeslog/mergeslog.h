/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MERGESLOG_H
#define MERGESLOG_H

#include <limits.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MERGE_SUCCESS             0
#define MERGE_NOT_FOUND         (-1)      /* file not found */
#define MERGE_ERROR             (-2)
#define MERGE_INVALID_ARGV      (-3)      /* input argv is null */
#define MERGE_NO_PERMISSION     (-4)      /* input path no permission */

struct DlogPattern {
    char active[NAME_MAX];      // current logging file name, for example: DRV*.log
    char rotate[NAME_MAX];      // rotate log file name pattern, for example: DRV*.gz
    char path[PATH_MAX];        // realpath to collect.
};

struct DlogNamePatterns {
    uint32_t logNum;                // num of logs name pattern.
    struct DlogPattern *patterns;   // patterns info, dynamic buffer.
};

#define DLL_EXPORT __attribute__((visibility("default")))

/**
 * @brief       : collect new log and compress to dir
 * @param [in]  : dir       directory to save log file
 * @param [in]  : len       length of dir
 * @return      : 0: success; -2: error; -3: input invalid; -4: path no permission
 */
DLL_EXPORT int32_t DlogCollectLog(char *dir, uint32_t len);

/**
 * @brief       : check if new log file exist
 * @param [in]  : dir       directory to save log file
 * @param [in]  : len       length of dir
 * @return      : 0: success; -1: not found; -2: error; -3: input invalid; -4: path no permission
 */
DLL_EXPORT int32_t DlogCheckCollectStatus(char *dir, uint32_t len);

/**
 * @brief       : get hisi log configuration log name patterns, free patterns dynamic buffer by caller is required
 * @param [out] : logs      log name patterns
 * @return      : 0: success; others:   failed
 */
DLL_EXPORT int32_t DlogGetLogPatterns(struct DlogNamePatterns *logs);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif