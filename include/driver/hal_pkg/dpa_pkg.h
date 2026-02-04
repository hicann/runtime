/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DPA_PKG_H
#define DPA_PKG_H

#include "common_pkg.h"

typedef enum {
    BIND_AICPU_CGROUP = 0,
    BIND_DATACPU_CGROUP,
    BIND_COMCPU_CGROUP,
    BIND_CGROUP_MAX_TYPE
} BIND_CGROUP_TYPE;

enum res_map_type {
	RES_AICORE = 0,
	RES_HSCB_AICORE,
	RES_L2BUFF,
	RES_C2C,
	RES_MAP_TYPE_MAX
};

#define RES_MAP_INFO_RSV_LEN 1
struct res_map_info {
    processType_t target_proc_type;
    enum res_map_type res_type;
    unsigned int res_id;                     /* corresponding resource id if res_type is NOTIFY or CNT_NOTIFY */
    unsigned int flag;                       /* default is 0 */
    unsigned int rsv[RES_MAP_INFO_RSV_LEN];  /* default is 0 */
};

enum drv_mem_side {
    MEM_HOST_SIDE = 0,
    MEM_DEV_SIDE,
    MEM_HOST_NUMA_SIDE,
    MEM_MAX_SIDE
};

typedef enum tagAccessMember {
    TS_ACCESSOR = 0x0U,
    ACCESSOR_MAX
} accessMember_t;

#endif