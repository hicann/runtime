/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_EPOLL_H
#define ADX_EPOLL_H
#include <cstdint>
#include <memory>
#include <vector>
namespace Adx {
using EpollHandle = uintptr_t;
constexpr EpollHandle ADX_INVALID_HANDLE = -1;
constexpr int32_t DEFAULT_EPOLL_SIZE = 128;
constexpr int32_t DEFAULT_EPOLL_TIMEOUT = 500; // 500ms

constexpr uint32_t ADX_EPOLL_CONN_IN = 1U << 0;
constexpr uint32_t ADX_EPOLL_DATA_IN = 1U << 1;
constexpr uint32_t ADX_EPOLL_HANG_UP = 1U << 2;

struct EpollEvent {
    uint32_t events;
    EpollHandle data;
};

enum class EpollType {
    EPOLL_HDC,
    EPOLL_SOCK,
    NR_EPOLL
};

class AdxEpoll {
public:
    AdxEpoll() : epMaxSize_(DEFAULT_EPOLL_SIZE) {}
    virtual ~AdxEpoll() {}
    virtual int32_t EpollCreate(const int32_t size) = 0;
    virtual int32_t EpollDestroy() = 0;
    virtual int32_t EpollCtl(EpollHandle target, EpollEvent &event, int32_t op) = 0;
    virtual int32_t EpollAdd(EpollHandle target, EpollEvent &event) = 0;
    virtual int32_t EpollDel(EpollHandle target, EpollEvent &event) = 0;
    virtual int32_t EpollWait(std::vector<EpollEvent> &events, int32_t size, int32_t timeout) = 0;
    virtual int32_t EpollErrorHandle() = 0;
    virtual int32_t EpollGetSize() = 0;
protected:
    int32_t epMaxSize_;
};
}
#endif
