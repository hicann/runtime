/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HAL_TS_H
#define HAL_TS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
 
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/time.h>

typedef enum tagDrvError {
    DRV_ERROR_NONE = 0,
    DRV_ERROR_WAIT_TIMEOUT = 16,
    DRV_ERROR_RESERVED
} drvError_t;

typedef struct _dump_mailbox_info {
    uint16_t sid;
    uint16_t rsp : 1;
    uint16_t sat : 1;
    uint16_t om : 1;
    uint16_t res1 : 3;
    uint16_t dump_task : 1;
    uint16_t soft_user : 6;
    uint16_t hid : 1;
    uint16_t pa : 1;
    uint16_t w : 1;

    uint16_t task_id;

    uint16_t mid : 8;
    uint16_t res2 : 8;
    
    uint16_t block_id;
    uint16_t block_dim;
    uint32_t task_pc_addr_l;
    uint32_t task_param_ptr_l;
    // uint32_t ioa_base_addr_l;
    // uint32_t weight_base_addr_l;
    // uint32_t workspace_base_addr_l;
    uint8_t* ioa_base_addr_l;
    uint8_t* weight_base_addr_l;
    uint8_t* workspace_base_addr_l;
    uint8_t task_pc_addr_h;
    uint8_t task_param_ptr_h;
    uint8_t ioa_base_addr_h;
    uint8_t weight_base_addr_h;
    uint32_t workspace_base_addr_h : 8;
    uint32_t res3 : 24;
    uint8_t rec[24];
} dump_mailbox_info_t;
#endif