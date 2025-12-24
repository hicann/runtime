/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DUMP_PROCESS_H
#define ADX_DUMP_PROCESS_H
#include <string>
#include <functional>
#include <atomic>
#include "common/singleton.h"
#include "adx_datadump_callback.h"
namespace Adx {
using MessageCallback = int32_t (*)(const struct DumpChunk *, int32_t);

class AdxDumpProcess : public Adx::Common::Singleton::Singleton<AdxDumpProcess> {
public:
    AdxDumpProcess() : messageCallback_(nullptr), init_(false) {}
    ~AdxDumpProcess() override {};
    ADX_API void MessageCallbackRegister(const MessageCallback callbackFun);
    ADX_API void MessageCallbackUnRegister();
    const std::function<int32_t(const struct DumpChunk *, int32_t)>& GetCallbackFun() const;
    bool IsRegistered() const;

private:
    std::function<int32_t(const struct DumpChunk *, int32_t)> messageCallback_;
    std::atomic<bool> init_;
};
}
#endif
