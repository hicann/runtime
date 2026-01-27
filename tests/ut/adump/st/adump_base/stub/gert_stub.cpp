/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "graph/types.h"
#include "graph/utils/type_utils.h"
#include "external/exe_graph/runtime/tiling_context.h"
#include "graph/operator_factory.h"
#include "graph/utils/op_desc_utils.h"
#include "external/register/op_impl_registry.h"
#include "register/op_impl_registry_base.h"
#include "graph/utils/type_utils.h"
#include "base/registry/op_impl_space_registry_v2.h"

namespace gert {

size_t RuntimeAttrs::GetAttrNum() const
{
    return 0;
}

const void *RuntimeAttrs::GetPointerByIndex(size_t index) const
{
    return nullptr;
}

const OpImplKernelRegistry::OpImplFunctionsV2 *OpImplRegistry::GetOpImpl(const ge::char_t *op_type) const
{
    static OpImplKernelRegistry::OpImplFunctionsV2 func;
    return &func;
}

const OpImplKernelRegistry::PrivateAttrList &OpImplRegistry::GetPrivateAttrs(const ge::char_t *op_type) const
{
    static OpImplKernelRegistry::PrivateAttrList list;
    return list;
}

OpImplRegistry &OpImplRegistry::GetInstance() {
    static OpImplRegistry instance;
    return instance;
}

OpImplSpaceRegistryV2::OpImplSpaceRegistryV2() {}

const OpImplKernelRegistry::OpImplFunctionsV2 *OpImplSpaceRegistryV2::GetOpImpl(const char_t *op_type) const
{
    static OpImplKernelRegistry::OpImplFunctionsV2 func;
    return &func;
}

DefaultOpImplSpaceRegistryV2::DefaultOpImplSpaceRegistryV2() {}

const std::shared_ptr<OpImplSpaceRegistryV2> DefaultOpImplSpaceRegistryV2::GetSpaceRegistry(
    gert::OppImplVersionTag opp_impl_version) const
{
    static std::shared_ptr<OpImplSpaceRegistryV2> space_registry = std::make_shared<OpImplSpaceRegistryV2>();
    return space_registry;
}

DefaultOpImplSpaceRegistryV2 &DefaultOpImplSpaceRegistryV2::GetInstance() {
    static DefaultOpImplSpaceRegistryV2 instance;
    return instance;
}

} // namespace ge
