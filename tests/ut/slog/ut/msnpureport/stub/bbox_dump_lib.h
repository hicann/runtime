/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BBOX_DUMP_LIB_H
#define BBOX_DUMP_LIB_H
#include <stdbool.h>
#include <stdint.h>

typedef signed int          s32;
typedef uint32_t            u32;
#define BboxStatus          s32

struct BboxDumpOpt {
    bool all;
    bool force;
    bool vmcore;
    bool heartBeatLost;
    u32 printMode;
    u32 logLevel;
};

#define BBOX_DISALLOW_REENTRANT 1   // exception report value
#define BBOX_SUCCESS            0
#define BBOX_FAILURE            (-1)

BboxStatus BboxStartDump(s32 devId, const char *path, s32 pSize, const struct BboxDumpOpt *opt);
void BboxStopDump(void);

#endif // BBOX_DUMP_LIB_H