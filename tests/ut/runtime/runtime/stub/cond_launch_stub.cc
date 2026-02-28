/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cond_c.hpp"
#include "label_c.hpp"
#include "label.hpp"

namespace cce {
namespace runtime {

#define UT_WEAK __attribute__((weak))

UT_WEAK rtError_t CondStreamActive(const Stream* const activeStream, Stream* const stm, Context* const ctx)
{
    UNUSED(activeStream);
    UNUSED(stm);
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondStreamSwitchEx(
    const void* const ptr, const rtCondition_t condition, const void* const valuePtr, const Stream* const trueStream,
    Stream* const stm, const rtSwitchDataType_t dataType, Context* const ctx)
{
    UNUSED(ptr);
    UNUSED(condition);
    UNUSED(valuePtr);
    UNUSED(trueStream);
    UNUSED(stm);
    UNUSED(dataType);
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondStreamSwitchN(
    const void* const ptr, const uint32_t size, const void* const valuePtr, Stream** const trueStreamPtr,
    const uint32_t elementSize, Stream* const stm, const rtSwitchDataType_t dataType, Context* const ctx)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(valuePtr);
    UNUSED(trueStreamPtr);
    UNUSED(elementSize);
    UNUSED(stm);
    UNUSED(dataType);
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondLabelSet(Label* const lbl, Stream* const stm)
{
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t
CondLabelSwitchByIndex(void* const ptr, const uint32_t maxVal, void* const labelInfoPtr, Stream* const stm)
{
    UNUSED(ptr);
    UNUSED(maxVal);
    UNUSED(labelInfoPtr);
    UNUSED(stm);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t
CondMemWaitValue(const void* const ptr, const uint64_t value, const uint32_t opCode, Stream* const stm)
{
    UNUSED(ptr);
    UNUSED(value);
    UNUSED(opCode);
    UNUSED(stm);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondLabelCreate(Label** const result, Model* const mdl, Context* const ctx)
{
    UNUSED(result);
    UNUSED(mdl);
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondLabelDestroy(const Label* delLabel)
{
    UNUSED(delLabel);
    return RT_ERROR_NONE;
}

UT_WEAK rtError_t CondLabelListCpy(
    Label** const labelList, const uint32_t labelNumber, void* const dst, const uint32_t dstMax, Device* const device)
{
    UNUSED(labelList);
    UNUSED(labelNumber);
    UNUSED(dst);
    UNUSED(dstMax);
    UNUSED(device);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce

#undef UT_WEAK
