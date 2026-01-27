/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_COND_C_HPP__
#define __CCE_RUNTIME_COND_C_HPP__

#include "stream.hpp"
#include "label.hpp"

namespace cce {
namespace runtime {

    rtError_t CondStreamActive(const Stream * const activeStream, Stream * const stm);
    rtError_t CondLabelSwitchByIndex(void * const ptr, const uint32_t maxIndex, void * const labelInfoPtr,
        Stream * const stm);
    rtError_t CondStreamSwitchEx(const void * const ptr, const rtCondition_t condition, const void * const valuePtr,
        const Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType);
    rtError_t CondLabelSet(Label * const lbl, Stream * const stm);
    rtError_t CondMemWaitValue(const void * const devAddr, const uint64_t value,
        const uint32_t flag, Stream * const stm);
}  // namespace runtime
}  // namespace cce

#endif