/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STREAM_STATE_CALLBACK_HPP
#define CCE_RUNTIME_STREAM_STATE_CALLBACK_HPP

#include <unordered_map>
#include "base.hpp"
#include "stream.hpp"
namespace cce {
namespace runtime {

struct StreamStateCallbackInfo{
    StreamStateCallback     type;
    rtStreamStateCallback   callback;
    rtsStreamStateCallback  callbackV2;
    void                    *args;
};

class StreamStateCallbackManager {
public:
    static StreamStateCallbackManager &Instance();

    rtError_t RegStreamStateCallback(const char_t *regName, void *callback, void *args,
        StreamStateCallback type);

    void Notify(Stream * const stm, const bool isCreate);

private:
    StreamStateCallbackManager() = default;

    ~StreamStateCallbackManager() = default;

    StreamStateCallbackManager(const StreamStateCallbackManager &other) = delete;

    StreamStateCallbackManager &operator=(const StreamStateCallbackManager &other) = delete;

    StreamStateCallbackManager(StreamStateCallbackManager &&other) = delete;

    StreamStateCallbackManager &operator=(StreamStateCallbackManager &&other) = delete;

private:
    std::unordered_map<std::string, StreamStateCallbackInfo> callbackMap_;
    std::mutex mapMutex_;
};
}
}

#endif  // CCE_RUNTIME_STREAM_STATE_CALLBACK_HPP