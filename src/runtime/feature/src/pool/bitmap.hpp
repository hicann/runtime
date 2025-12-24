/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_BITMAP_HPP
#define CCE_RUNTIME_BITMAP_HPP

#include <mutex>
#include "base.hpp"

namespace cce {
namespace runtime {
class Bitmap : public NoCopy {
public:
    explicit Bitmap(const uint32_t maxIdCnt);
    ~Bitmap() override
    {
        if (freeBitmap_ != nullptr) {
            delete[] freeBitmap_;
        }
    }
    rtError_t AllocBitmap(void);
    int32_t AllocId(uint32_t maxAllocCount = 0);
    void FreeId(const int32_t id);
    bool IsIdOccupied(const int32_t id) const;
    void OccupyId(const int32_t id) const;

private:
    volatile uint64_t *freeBitmap_;
    uint32_t maxIdCount_;
    std::mutex mutex_;
    uint32_t allocedCnt_;
    uint32_t lastAllocIdx_;
};
}
}

#endif  // CCE_RUNTIME_BITMAP_HPP
