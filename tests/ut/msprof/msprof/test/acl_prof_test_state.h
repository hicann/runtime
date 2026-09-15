/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TESTS_MSPROF_ACL_PROF_TEST_STATE_H
#define TESTS_MSPROF_ACL_PROF_TEST_STATE_H

#include <string>

#include "prof_stamp_pool.h"

// Internal state saved and restored by the public API test fixtures.
namespace Analysis {
namespace Dvvp {
namespace Analyze {
extern std::string g_aclprofSubscribeOpAttriValue;
} // namespace Analyze
} // namespace Dvvp
} // namespace Analysis

namespace Msprof {
namespace MsprofTx {
extern MsprofStampCtrlHandle* g_stampPoolHandle;
extern MsprofStampInstance* g_stampInstanceAddr[CURRENT_STAMP_SIZE];
} // namespace MsprofTx
} // namespace Msprof

#endif // TESTS_MSPROF_ACL_PROF_TEST_STATE_H
