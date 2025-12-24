/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_TENSOR_PLUGIN_H
#define DUMP_TENSOR_PLUGIN_H

#include <cstdint>
#include <vector>
#include <map>
#include <mutex>
#include "common/singleton.h"
#include "adx_exception_callback.h"

namespace Adx {
using AdumpPluginInitFunc = int32_t (*)();
using AdumpPluginInit = int32_t ();

class DumpTensorPlugin : public Adx::Common::Singleton::Singleton<DumpTensorPlugin> {
public:
    DumpTensorPlugin() {}
    ~DumpTensorPlugin() override;
    int32_t InitPluginLib();
    void HeadCallbackRegister(DfxTensorType tensorType, HeadProcess headProcess);
    void TensorCallbackRegister(DfxTensorType tensorType, TensorProcess tensorProcess);
    int32_t NotifyHeadCallback(DfxTensorType tensorType, uint32_t devId, const void *addr, uint64_t headerSize,
        uint64_t &newHeaderSize);
    int32_t NotifyTensorCallback(DfxTensorType tensorType, uint32_t devId, const void *addr, uint64_t size, int32_t fd);
    bool IsTensorTypeRegistered(DfxTensorType tensorType);

private:
    void ReceiveInitialFunc(void *handle) const;
    std::mutex dlopenMtx_;
    std::mutex regMtx_;
    std::vector<void *> pluginLibHandles_;
    std::map<DfxTensorType, HeadProcess> headProcessMap_;
    std::map<DfxTensorType, TensorProcess> tensorProcessMap_;
};

} // namespace Adx
#endif