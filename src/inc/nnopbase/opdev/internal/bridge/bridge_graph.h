/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_BRIDGE_H_
#define OP_API_OP_API_COMMON_INC_OPDEV_BRIDGE_H_

#include "opdev/internal/acl_tensor_traits.h"
#include "opdev/op_log.h"
#include "opdev/op_arg_def.h"
#include <tuple>

namespace op {
namespace internal {

void *BuildKernelNodeImpl(uint32_t opType,
                          FVector<aclTensor *> &aclInputs,
                          FVector<aclTensor *> &aclOutputs,
                          FVector<aclTensor *> &aclWorkspace);

void *CreateGraphImpl();

void FreeGraphImpl(void *graph);

void FreeExtendTensorImpl(void *extendTensor);

aclnnStatus AddKernelNodeToGraph(void *kn, void *graph);

template<typename... Args>
static void TraitsAclTensor(FVector<aclTensor *> &result, const std::tuple<Args...> &t)
{
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensor,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensorList,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
}
 
template<typename INPUT, typename OUTPUT, typename WORKSPACE>
aclnnStatus BuildGraph(void *graph,
                       uint32_t opType,
                       const INPUT &inputs,
                       const OUTPUT &outputs,
                       const WORKSPACE &workspace)
{
    FVector<aclTensor *> acl_inputs;
    FVector<aclTensor *> acl_outputs;
    FVector<aclTensor *> acl_workspace;
 
    TraitsAclTensor(acl_inputs, inputs);
    TraitsAclTensor(acl_outputs, outputs);
    TraitsAclTensor(acl_workspace, workspace);
 
    void *kn = BuildKernelNodeImpl(opType, acl_inputs, acl_outputs, acl_workspace);
    if (kn != nullptr) {
        AddKernelNodeToGraph(kn, graph);
    }
    return ACL_SUCCESS;
}

aclnnStatus BuildGraph(void *graph,
                       uint32_t opType,
                       OpArgList &inputs,
                       OpArgList &outputs,
                       OpArgList &workspace);

aclnnStatus BuildGraph(void *graph,
                       uint32_t opType,
                       OpArgList &inputs,
                       OpArgList &outputs,
                       OpArgList &workspace,
                       OpArgList &outputshape);

} // namespace internal
} // namespace op
#endif
