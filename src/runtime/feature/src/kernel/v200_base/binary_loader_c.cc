/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "binary_loader_c.hpp"
#include "binary_loader.hpp"

namespace cce {
namespace runtime {
rtError_t XpuBinaryLoadFromFile(const BinaryLoader * const loader, Program **handle)
{
    rtError_t ret = loader->XpuLoad(handle);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "xpu binary load from file failed, path=[%s]", loader->GetBinPath().c_str());
    }
    return ret;
}

}
}