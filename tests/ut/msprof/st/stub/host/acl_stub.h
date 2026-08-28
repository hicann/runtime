/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ACL_STUB_H
#define ACL_STUB_H

#include "acl/acl.h"
#include "acl/acl_prof.h"

// simulate aclmdlDataset from ge
struct aclmdlDataset {
    uint32_t seq;
    uint32_t modelId;
    uint32_t timeStamp;
    uint32_t timeout;
    uint64_t requestId;
};

aclError aclmdlLoadFromFile(const char* /* modelPath */, uint32_t* modelId);
aclError aclmdlUnload(uint32_t modelId);
aclError aclmdlExecute(uint32_t modelId, const aclmdlDataset* /* input */, aclmdlDataset* /* output */);

#endif