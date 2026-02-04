/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BUFF_PKG_H
#define BUFF_PKG_H

typedef struct {
    unsigned int admin : 1;     /* admin permission, can add other proc to grp */
    unsigned int read : 1;     /* rsv, not support */
    unsigned int write : 1;    /* read and write permission */
    unsigned int alloc : 1;    /* alloc permission (have read and write permission) */
    unsigned int rsv : 28;
}GroupShareAttr;

typedef struct {
    unsigned long long addr; /* cache memory addr */
    unsigned long long size; /* cache memory size */
} GrpQueryGroupAddrInfo; /* cmd: GRP_QUERY_GROUP_ADDR_INFO */

#endif
