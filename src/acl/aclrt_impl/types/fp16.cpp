/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl_base.h"
#include "acl_rt_impl.h"
#include "fp16_impl.h"

#ifdef __cplusplus
extern "C" {
#endif

// 不保留NaN/Inf语义，+Inf转65536.0，-Inf转-65536.0，NaN转98304.0，适用于所有形态
float aclFloat16ToFloatImpl(aclFloat16 value) { return acl::Fp16ToFloat(value); }

// 按饱和模式处理，NaN和Inf转65504.0(0x7BFF)，负Inf转-65504.0(0xFBFF)，适用于所有形态
aclFloat16 aclFloatToFloat16Impl(float value) { return acl::FloatToFp16(value); }
#ifdef __cplusplus
}
#endif
