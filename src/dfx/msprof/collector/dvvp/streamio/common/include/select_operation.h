/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_STREAMIO_EPOLL_OPERATION_H
#define ANALYSIS_DVVP_STREAMIO_EPOLL_OPERATION_H

#include <stdint.h>
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#include <winsock2.h>
#else
#include <sys/select.h>
#include <sys/time.h>
#endif
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace streamio {
namespace common {
class SelectOperation {
public:
    SelectOperation();
    ~SelectOperation();
    void SelectAdd(OsalSockHandle fd);
    void SelectDel(OsalSockHandle fd);
    bool SelectIsSet(OsalSockHandle fd);
    void SelectClear();

private:
    OsalSockHandle maxFd_;
    fd_set readfd_;

    SelectOperation &operator=(const SelectOperation &op);
    SelectOperation(const SelectOperation &op);
};
}  // namespace common
}  // namespace streamio
}  // namespace dvvp
}  // namespace analysis

#endif
