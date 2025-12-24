/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_FORMAT_UTILS_H
#define OP_API_OP_API_COMMON_INC_FORMAT_UTILS_H

#include <acl/acl_base.h>
#include "common_types.h"

namespace op {
constexpr uint32_t BIT_NUM_OF_ONE_BYTE = 8U;
constexpr uint32_t BIT_THREE_BYTES = 24U;

bool IsPrivateFormat(Format format);
Format ToFormat(const std::string &formatStr);
ge::AscendString ToString(Format format);

inline int32_t GetPrimaryFormat(int32_t format)
{
    return static_cast<int32_t>(static_cast<uint32_t>(format) & 0xffU);
}

inline Format GetPrimaryFormat(Format format)
{
    return static_cast<Format>(static_cast<uint32_t>(format) & 0xffU);
}

inline int32_t GetSubFormat(int32_t format)
{
    return static_cast<int32_t>((static_cast<uint32_t>(format) & 0xffff00U) >> BIT_NUM_OF_ONE_BYTE);
}

inline int32_t GetSubFormat(Format format)
{
    return static_cast<int32_t>((static_cast<uint32_t>(format) & 0xffff00U) >> BIT_NUM_OF_ONE_BYTE);
}

inline bool HasSubFormat(int32_t format)
{
    return GetSubFormat(format) > 0;
}

inline int64_t GetC0Format(int32_t format)
{
    return static_cast<int64_t>(1
        << (static_cast<int32_t>((static_cast<uint32_t>(format) & 0xf000000U) >> BIT_THREE_BYTES) - 1));
}

inline bool HasC0Format(int32_t format)
{
    return ((static_cast<uint32_t>(format) & 0xf000000U) >> BIT_THREE_BYTES) > 0;
}

inline Format GetFormatFromSub(int32_t primaryFormat, int32_t subFormat)
{
    return static_cast<Format>((static_cast<uint32_t>(primaryFormat) & 0xffU)
        | ((static_cast<uint32_t>(subFormat) & 0xffffU) << 8U));
}

inline Format ToOpFormat(aclFormat format)
{
    if (format != aclFormat::ACL_FORMAT_UNDEFINED) {
        return static_cast<Format>(format);
    }

    return Format::FORMAT_MAX;
}

inline aclFormat ToAclFormat(Format format)
{
    static const std::vector<Format> CAN_CONVERT_TO_ACL_FORMAT_LIST = {Format::FORMAT_NCHW, Format::FORMAT_NHWC,
                                                                       Format::FORMAT_ND, Format::FORMAT_NC1HWC0,
                                                                       Format::FORMAT_FRACTAL_Z,
                                                                       Format::FORMAT_NC1HWC0_C04, Format::FORMAT_HWCN,
                                                                       Format::FORMAT_NDHWC, Format::FORMAT_FRACTAL_NZ,
                                                                       Format::FORMAT_NCDHW, Format::FORMAT_NDC1HWC0,
                                                                       Format::FORMAT_FRACTAL_Z_3D, Format::FORMAT_NC,
                                                                       Format::FORMAT_NCL, Format::FORMAT_FRACTAL_NZ_C0_16,
                                                                       Format::FORMAT_FRACTAL_NZ_C0_32, Format::FORMAT_FRACTAL_NZ_C0_2,
                                                                       Format::FORMAT_FRACTAL_NZ_C0_4, Format::FORMAT_FRACTAL_NZ_C0_8};
    auto iter = std::find(CAN_CONVERT_TO_ACL_FORMAT_LIST.begin(),
                          CAN_CONVERT_TO_ACL_FORMAT_LIST.end(),
                          format);
    if (iter == CAN_CONVERT_TO_ACL_FORMAT_LIST.end()) {
        return aclFormat::ACL_FORMAT_UNDEFINED;
    }

    return static_cast<aclFormat>(format);
}

} // namespace op

#endif // OP_API_OP_API_COMMON_INC_FORMAT_UTILS_H
