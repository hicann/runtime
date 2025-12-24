/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSNPUREPORT_FILEDUMP_H
#define MSNPUREPORT_FILEDUMP_H
#include <stdint.h>

#define TYPE_0 (1U << 0U)
#define TYPE_1 (1U << 1U)
#define TYPE_2 (1U << 2U)
#define TYPE_3 (1U << 3U)
#define TYPE_4 (1U << 4U)
#define TYPE_5 (1U << 5U)

typedef struct {
    const char *label;             // component-specific label
    const char *hostFilePath;      // path of file storage at host
    const char *deviceScriptPath;  // path of file move script at device
    uint32_t timeout;              // max script execution time; unit: ms
    uint32_t type;                 // bitmap
} MsnpureportFileDumpTable;

// prohibit repeat label
const MsnpureportFileDumpTable MSNPUREPORT_FILE_DUMP_INFO[] = {
    {"dvpp", "module_info", "/var/dvpp_proc_collect.sh", 10000, (TYPE_1 | TYPE_5)},
    {"hal",  "module_info", "/var/hal_proc_collect.sh",  40000, (TYPE_1 | TYPE_5)},
    {"tee",  "module_info", "/var/tee_log_collect.sh",   12000, (TYPE_1 | TYPE_5)}
};
#endif
