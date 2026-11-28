/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "arg_loader_utils.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
namespace {
rtError_t CheckHostInputAddressFields(
    const uint32_t argsSize, const uint16_t count, const rtHostInputInfo* const fields)
{
    for (uint16_t i = 0U; i < count; ++i) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
            static_cast<uint64_t>(fields[i].addrOffset) + sizeof(uint64_t) > argsSize, RT_ERROR_INVALID_VALUE,
            "Checking kernel argument address fields", fields[i].addrOffset, "addrOffset",
            RtFmtMsg("addrOffset + %zu <= argsSize (%u bytes)", sizeof(uint64_t), argsSize));
    }
    return RT_ERROR_NONE;
}
} // namespace

rtError_t CheckArgsAddressFields(const rtArgsEx_t* const argsInfo)
{
    if (argsInfo->hasTiling != 0U) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
            static_cast<uint64_t>(argsInfo->tilingAddrOffset) + sizeof(uint64_t) > argsInfo->argsSize,
            RT_ERROR_INVALID_VALUE, "Checking kernel argument address fields", argsInfo->tilingAddrOffset,
            "tilingAddrOffset",
            RtFmtMsg("tilingAddrOffset + %zu <= argsSize (%u bytes)", sizeof(uint64_t), argsInfo->argsSize));
    }
    COND_RETURN_AND_MSG_OUTER(
        argsInfo->hostInputInfoNum != 0U && argsInfo->hostInputInfoPtr == nullptr, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1004, "Checking kernel argument address fields", "hostInputInfoPtr");
    return CheckHostInputAddressFields(argsInfo->argsSize, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
}

rtError_t CheckArgsAddressFields(const rtAicpuArgsEx_t* const argsInfo)
{
    COND_RETURN_AND_MSG_OUTER(
        argsInfo->hostInputInfoNum != 0U && argsInfo->hostInputInfoPtr == nullptr, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1004, "Checking kernel argument address fields", "hostInputInfoPtr");
    const rtError_t error =
        CheckHostInputAddressFields(argsInfo->argsSize, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    COND_RETURN_AND_MSG_OUTER(
        argsInfo->kernelOffsetInfoNum != 0U && argsInfo->kernelOffsetInfoPtr == nullptr, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1004, "Checking kernel argument address fields", "kernelOffsetInfoPtr");
    return CheckHostInputAddressFields(
        argsInfo->argsSize, argsInfo->kernelOffsetInfoNum, argsInfo->kernelOffsetInfoPtr);
}

rtError_t CheckArgsAddressFields(const rtFusionArgsEx_t* const argsInfo)
{
    COND_RETURN_AND_MSG_OUTER(
        argsInfo->hostInputInfoNum != 0U && argsInfo->hostInputInfoPtr == nullptr, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1004, "Checking kernel argument address fields", "hostInputInfoPtr");
    return CheckHostInputAddressFields(argsInfo->argsSize, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
}
} // namespace runtime
} // namespace cce
