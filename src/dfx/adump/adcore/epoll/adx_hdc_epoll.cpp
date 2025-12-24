/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_hdc_epoll.h"
#include "log/hdc_log.h"
#include "mmpa_api.h"
#include "extra_config.h"
namespace Adx {
/**
 * @brief       create epoll object with the size
 * @param [in]  size:  epoll event size
 * @return      epoll handle
 */
int32_t AdxHdcEpoll::EpollCreate(const int32_t size)
{
    if (size <= 0) {
        IDE_LOGE("hdc epoll create size(%d bytes) input error", size);
        return IDE_DAEMON_ERROR;
    }

    if (epEvent_ == nullptr) {
        epEvent_ = (struct drvHdcEvent *)ADX_SAFE_CALLOC(size, sizeof(struct drvHdcEvent));
        if (epEvent_ == nullptr) {
            IDE_LOGE("hdc epoll calloc error.");
            return IDE_DAEMON_ERROR;
        }
    } else {
        IDE_LOGW("hdc epoll has been created.");
        return IDE_DAEMON_OK;
    }

    epMaxSize_ = size;
    drvError_t ret = drvHdcEpollCreate(size, &ep_);
    if (ret != DRV_ERROR_NONE || ep_ == nullptr) {
        IDE_LOGE("hdc epoll create error(%d).", ret);
        ADX_SAFE_FREE(epEvent_);
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief       destroy epoll object
 * @param [in]  ep:     epoll handle
 * @return      !=0: failure ==0: success
 */
int32_t AdxHdcEpoll::EpollDestroy()
{
    ADX_SAFE_FREE(epEvent_);
    if (ep_ != nullptr) {
        IDE_LOGI("start to close hdc epoll");
        drvError_t ret = drvHdcEpollClose(ep_);
        if (ret != DRV_ERROR_NONE) {
            IDE_LOGE("hdc epoll close error(%d)", ret);
            return IDE_DAEMON_ERROR;
        }
        ep_ = nullptr;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief       add epoll event
 * @param [in]  ep:     epoll handle
 * @param [in]  op:     operate
 * @param [in]  handle: target handle, server handle or session handle
 * @param [in]  event:  epoll event
 * @return      !=0: failure ==0: success
 */
int32_t AdxHdcEpoll::EpollCtl(EpollHandle handle, EpollEvent &event, int32_t op)
{
    int32_t ret;
    if (ep_ == nullptr || handle == ADX_INVALID_HANDLE) {
        IDE_LOGE("hdc epoll ctl input error");
        return IDE_DAEMON_ERROR;
    }

    HDC_SESSION target = (HDC_SESSION)handle;
    if (target == nullptr) {
        IDE_LOGE("hdc epoll ctl handle error");
        return IDE_DAEMON_ERROR;
    }

    struct drvHdcEvent epEvent;
    epEvent.events = EpollEventToHdcEvent(event.events);
    epEvent.data = (uintptr_t)event.data;

    ret = drvHdcEpollCtl(ep_, op, target, &epEvent);
    if (ret != DRV_ERROR_NONE) {
        IDE_LOGE("hdc epoll ctl process error %d", ret);
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief       add epoll event
 * @param [in]  ep:     epoll handle
 * @param [in]  target: target handle, server handle or session handle
 * @param [in]  event:  epoll event
 * @return      !=0: failure ==0: success
 */
int32_t AdxHdcEpoll::EpollAdd(EpollHandle target, EpollEvent &event)
{
    return EpollCtl(target, event, HDC_EPOLL_CTL_ADD);
}

/**
 * @brief       del epoll event
 * @param [in]  ep:     epoll handle
 * @param [in]  target: target handle, server handle or session handle
 * @param [in]  event:  epoll event
 * @return      !=0: failure ==0: success
 */
int32_t AdxHdcEpoll::EpollDel(EpollHandle target, EpollEvent &event)
{
    return EpollCtl(target, event, HDC_EPOLL_CTL_DEL);
}

/**
 * @brief       hdc epoll wait
 * @param [in]  ep:         epoll handle
 * @param [in]  event:      epoll event
 * @param [in]  maxEvents:  max events num, which epoll wait
 * @param [in]  timeout:    timeout
 * @return      event num
 */
int32_t AdxHdcEpoll::EpollWait(std::vector<EpollEvent> &events, int32_t size, int32_t timeout)
{
    int32_t ret;
    if (ep_ == nullptr || size < epMaxSize_) {
        IDE_LOGW("hdc epoll wait init");
        return IDE_DAEMON_ERROR;
    }

    int32_t eventNum = 0;
    ret = drvHdcEpollWait(ep_, epEvent_, epMaxSize_, timeout, &eventNum);
    if (ret != DRV_ERROR_NONE) {
        IDE_LOGE("hdc epoll wait process error");
        return IDE_DAEMON_ERROR;
    }

    for (int32_t i = 0; i < eventNum && i < epMaxSize_; i++) {
        events[i].events = HdcEventToEpollEvent(epEvent_[i].events);
        events[i].data = epEvent_[i].data;
    }
    return eventNum;
}

int32_t AdxHdcEpoll::EpollErrorHandle()
{
    IDE_LOGW("process epoll other state");
    mmSleep(DEFAULT_EPOLL_TIMEOUT);
    return IDE_DAEMON_OK;
}

int32_t AdxHdcEpoll::EpollGetSize()
{
    return epMaxSize_;
}

uint32_t AdxHdcEpoll::EpollEventToHdcEvent(uint32_t events) const
{
    uint32_t transed = ((events & ADX_EPOLL_DATA_IN) != 0) ? HDC_EPOLL_DATA_IN : 0;
    transed |= ((events & ADX_EPOLL_CONN_IN) != 0) ? HDC_EPOLL_CONN_IN : 0;
    transed |= ((events & ADX_EPOLL_HANG_UP) != 0) ? HDC_EPOLL_SESSION_CLOSE : 0;
    return transed;
}

uint32_t AdxHdcEpoll::HdcEventToEpollEvent(uint32_t events) const
{
    uint32_t transed = ((events & HDC_EPOLL_DATA_IN) != 0) ? ADX_EPOLL_DATA_IN : 0;
    transed |= ((events & HDC_EPOLL_CONN_IN) != 0) ? ADX_EPOLL_CONN_IN : 0;
    transed |= ((events & HDC_EPOLL_SESSION_CLOSE) != 0) ? ADX_EPOLL_HANG_UP : 0;

    if ((events & ~HDC_EPOLL_EVENT_MASK) != 0) {
        IDE_LOGW("hdc epoll get unrecognised events %u.", events);
    }
    return transed;
}
}