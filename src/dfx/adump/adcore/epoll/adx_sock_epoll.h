/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_SOCK_EPOLL_H
#define ADX_SOCK_EPOLL_H
#include "adx_epoll.h"
namespace Adx {
#define SOCK_EPOLL_EVENT_MASK (HDC_EPOLL_DATA_IN | HDC_EPOLL_CONN_IN | HDC_EPOLL_SESSION_CLOSE)
class AdxSockEpoll : public AdxEpoll {
public:
    AdxSockEpoll() : ep_(-1)
    {
        epMaxSize_ = DEFAULT_EPOLL_SIZE;
    }
    ~AdxSockEpoll() override {}
    int32_t EpollCreate(const int32_t size) override;
    int32_t EpollAdd(EpollHandle target, EpollEvent &event) override;
    int32_t EpollDel(EpollHandle target, EpollEvent &event) override;
    int32_t EpollCtl(EpollHandle handle, EpollEvent &event, int32_t op) override;
    int32_t EpollWait(std::vector<EpollEvent> &events, int32_t size, int32_t timeout) override;
    int32_t EpollGetSize() override;
    int32_t EpollErrorHandle() override;
    int32_t EpollDestroy() override;
private:
    uint32_t HdcEventToEpollEvent(uint32_t events) const;
    uint32_t EpollEventToHdcEvent(uint32_t events) const;
private:
    int32_t ep_;
};
}
#endif