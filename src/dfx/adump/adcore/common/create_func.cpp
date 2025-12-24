/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "epoll/adx_hdc_epoll.h"
#include "commopts/hdc_comm_opt.h"
#include "create_func.h"
namespace Adx {
std::unique_ptr<AdxEpoll> CreateAdxEpoll(EpollType epollType)
{
    if (epollType == EpollType::EPOLL_HDC) {
        return std::unique_ptr<AdxEpoll>(new(std::nothrow)AdxHdcEpoll);
    }
    return nullptr;
}

std::unique_ptr<AdxCommOpt> CreateAdxCommOpt(OptType optType)
{
    if (optType == OptType::COMM_HDC) {
        return std::unique_ptr<AdxCommOpt>(new(std::nothrow)HdcCommOpt);
    }
    return nullptr;
}
}
