/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "binary_loader.hpp"
#include "program.hpp"

namespace cce {
namespace runtime {

BinaryLoader::BinaryLoader(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg) :
                           loadOptions_(optionalCfg)
{
    UNUSED(binPath);
}

BinaryLoader::BinaryLoader(const void * const data, const uint64_t length,
                           const rtLoadBinaryConfig_t * const optionalCfg) :
                           loadOptions_(optionalCfg)
{
    UNUSED(data);
    UNUSED(length);
}

rtError_t BinaryLoader::Load(Program ** prog)
{
    UNUSED(prog);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t BinaryLoader::XpuLoad(Program **prog) const
{
    UNUSED(prog);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
} // runtime
} // cce