/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_creator_c.hpp"

#include "runtime.hpp"
#include "coprocessor_stream.hpp"
#include "stream_with_dqs.hpp"

namespace cce {
namespace runtime {

Stream *CreateStreamAndGet(Device *const dev, const uint32_t prio, const uint32_t stmFlags, DvppGrp *const dvppGrp)
{
    if ((stmFlags & RT_STREAM_CP_PROCESS_USE) != 0U) {
        return new (std::nothrow) CoprocessorStream(dev, prio, stmFlags);
    }
    
    return new (std::nothrow) StreamWithDqs(dev, prio, stmFlags, dvppGrp);
}
}  // namespace runtime
}  // namespace cce