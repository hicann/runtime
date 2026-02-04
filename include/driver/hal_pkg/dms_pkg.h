/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DMS_PKG_H
#define DMS_PKG_H

#define MAX_RECORD_PA_NUM_PER_DEV    20U

struct va_info {
    unsigned short size;
    unsigned char reserved[6];
    unsigned long long va_addr;
};

struct hbm_pa_va_info {
    unsigned int dev_id;
    unsigned int host_pid;
    unsigned int va_num;
    struct va_info va_info[MAX_RECORD_PA_NUM_PER_DEV];
};

struct memory_fault_timestamp {
    unsigned int dev_id;
    unsigned int host_pid;
    unsigned int event_id;
    unsigned int reserved; /* for byte alignment */
    unsigned long long syscnt; /* event occur syscnt*/
};

#endif