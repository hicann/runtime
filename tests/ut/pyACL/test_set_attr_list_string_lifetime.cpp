/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software; you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cassert>
#include <cstring>
#include <string>
#include <vector>

static int SetAttrListStringStub(int count, const char* const values[])
{
    assert(count == 2);
    assert(std::strcmp(values[0], "a") == 0);
    assert(std::strcmp(values[1], "b") == 0);
    return 0;
}

int main()
{
    const std::vector<std::string> input = {"a", "b"};
    std::vector<std::string> storage;
    storage.assign(input.size(), std::string());
    std::vector<const char*> values(input.size() + 1, nullptr);

    for (size_t i = 0; i < input.size(); ++i) {
        storage[i] = input[i];
        values[i] = storage[i].data();
    }

    return SetAttrListStringStub(static_cast<int>(input.size()), values.data());
}
