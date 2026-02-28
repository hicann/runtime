/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_FEATURE_INC_C_LABEL_C_HPP
#define RUNTIME_FEATURE_INC_C_LABEL_C_HPP

#include "runtime/base.h"
#include "label.hpp"
#include "model.hpp"
#include "context.hpp"
#include "device.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

rtError_t CondLabelCreate(Label** const result, Model* const mdl, Context* const ctx);

rtError_t CondLabelDestroy(const Label* delLabel);

rtError_t CondLabelSet(Label* const lbl, Stream* const stm);

rtError_t CondLabelListCpy(
    Label** const labelList, const uint32_t labelNumber, void* const dst, const uint32_t dstMax, Device* const device);

rtError_t CondLabelSwitchByIndex(void* const ptr, const uint32_t maxIndex, void* const labelInfoPtr, Stream* const stm);

} // namespace runtime
} // namespace cce

#endif // RUNTIME_FEATURE_INC_C_LABEL_C_HPP
