/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_KERNEL_WORKSPACE_H
#define OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_KERNEL_WORKSPACE_H
#include "kernel_arg.h"
#include "kernel_mgr.h"
#include "opdev/shape_utils.h"

namespace op {
namespace internal {
aclnnStatus UpdateWorkspace(aclOpExecutor *executor,
                            const size_t *workspaceSize,
                            size_t workspaceNum,
                            aclTensorList **workspace);

aclnnStatus GetWorkspace(uint32_t optype,
                         aclTensorList **workspace,
                         aclOpExecutor *executor,
                         OpArgList &inputs,
                         OpArgList &outputs,
                         OpArgList &attrs);
}
}
#endif
