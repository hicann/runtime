/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hash_state.h"

#include <mutex>
#include <unordered_map>
#include <utility>
#include <vector>

#include "hash_data.h"
#include "msprofiler_adaptor.h"

namespace AclprofStr2IdTest {
using analysis::dvvp::transport::HashData;

// Uninit does not clear the registration vector. Snapshot the three caches in
// this provider DSO so every case starts empty and restores its original state.
class HashState {
public:
    void SwapWith(HashData& data)
    {
        std::lock_guard<std::mutex> lock(data.hashMutex_);
        hashInfoMap_.swap(data.hashInfoMap_);
        hashIdMap_.swap(data.hashIdMap_);
        hashVector_.swap(data.hashVector_);
        std::swap(readIndex_, data.readIndex_);
    }

private:
    std::unordered_map<std::string, uint64_t> hashInfoMap_;
    std::unordered_map<uint64_t, std::string> hashIdMap_;
    std::vector<std::pair<uint64_t, std::string>> hashVector_;
    size_t readIndex_ = 0U;
};

HashState* SaveHashState()
{
    auto* state = new HashState;
    state->SwapWith(*HashData::instance());
    return state;
}

void RestoreHashState(HashState* state)
{
    if (state != nullptr) {
        state->SwapWith(*HashData::instance());
        delete state;
    }
}

int32_t ReadRegisteredHashKeys(std::string& keys) { return HashData::instance()->GetHashKeys(keys); }

std::string ReadHashInfo(uint64_t id) { return ProfImplReportGetHashInfo(id); }
} // namespace AclprofStr2IdTest
