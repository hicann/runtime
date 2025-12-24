/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_ERROR_CODES_INNER_H_
#define ACL_ERROR_CODES_INNER_H_

#include "acl/acl_base.h"

namespace acl {
constexpr const int32_t MIN_GE_ERROR_CODE = 145000;
constexpr const int32_t MAX_GE_ERROR_CODE = 545999;
constexpr const int32_t MIN_RTS_ERROR_CODE = 107000;
constexpr const int32_t MAX_RTS_ERROR_CODE = 507999;
}

#define ACL_GET_ERRCODE_RTS(innerErrCode)   (innerErrCode)
#define ACL_GET_ERRCODE_GE(innerErrCode) \
    (((((innerErrCode) >= acl::MIN_GE_ERROR_CODE) && ((innerErrCode) <= acl::MAX_GE_ERROR_CODE)) || \
    (((innerErrCode) >= acl::MIN_RTS_ERROR_CODE) && ((innerErrCode) <= acl::MAX_RTS_ERROR_CODE))) ? \
    (innerErrCode) : ACL_ERROR_GE_FAILURE)

#endif // ACL_ERROR_CODES_INNER_H_
