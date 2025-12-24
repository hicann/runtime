/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "select_operation.h"
#include "osal.h"

namespace analysis {
namespace dvvp {
namespace streamio {
namespace common {
SelectOperation::SelectOperation()
    : maxFd_(0)
{
    FD_ZERO(&readfd_);
}

SelectOperation::~SelectOperation()
{
}

void SelectOperation::SelectAdd(OsalSockHandle fd)
{
    if (fd < 0) {
        return;
    }

    if (maxFd_ < fd) {
        maxFd_ = fd;
    }

    FD_SET(fd, &readfd_);
}

void SelectOperation::SelectDel(OsalSockHandle fd)
{
    if (fd < 0) {
        return;
    }

    FD_CLR(fd, &readfd_);
}

bool SelectOperation::SelectIsSet(OsalSockHandle fd)
{
    if (fd < 0) {
        return false;
    }

    if (FD_ISSET(fd, &readfd_)) {
        return true;
    }

    return false;
}

void SelectOperation::SelectClear()
{
    FD_ZERO(&readfd_);
}
}  // namespace common
}  // namespace streamio
}  // namespace dvvp
}  // namespace analysis
