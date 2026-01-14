/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_QUEUE_H
#define ACL_QUEUE_H

#include <vector>
#include "acl/acl_base.h"
#include "acl/acl_tdt_queue.h"
#include "acl_rt_impl.h"

struct acltdtQueueRouteList {
    std::vector<acltdtQueueRoute> routeList;
};

struct acltdtQueueRouteQueryInfo {
    int32_t mode;
    uint32_t srcId;
    uint32_t dstId;
    bool isConfigMode;
    bool isConfigSrc;
    bool isConfigDst;
};

struct acltdtQueueRoute {
    uint32_t srcId;
    uint32_t dstId;
    int32_t status;
};
namespace acl {
    aclError CheckQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *const queryInfo);
}
#endif // ACL_QUEUE_H
