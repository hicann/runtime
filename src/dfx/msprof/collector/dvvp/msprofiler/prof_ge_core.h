/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_ENGINE_GE_CORE_H
#define MSPROF_ENGINE_GE_CORE_H

#include "ge/ge_prof.h"
#include "prof_api_common.h"

namespace ge {
using namespace analysis::dvvp::common::utils;
size_t aclprofGetGraphId(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
bool IsProfConfigValid(CONST_UINT32_T_PTR deviceidList, uint32_t deviceNums);
}

#endif  // MSPROF_ENGINE_GE_CORE_H
