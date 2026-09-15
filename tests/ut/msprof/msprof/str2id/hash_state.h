/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TESTS_MSPROF_STR2ID_HASH_STATE_H
#define TESTS_MSPROF_STR2ID_HASH_STATE_H

#include <cstdint>
#include <string>

namespace AclprofStr2IdTest {
class HashState;

HashState* SaveHashState();
void RestoreHashState(HashState* state);
int32_t ReadRegisteredHashKeys(std::string& keys);
std::string ReadHashInfo(uint64_t id);
} // namespace AclprofStr2IdTest

#endif // TESTS_MSPROF_STR2ID_HASH_STATE_H
