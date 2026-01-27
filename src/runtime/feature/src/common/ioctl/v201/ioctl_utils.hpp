/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_IOCTL_UTILS_HPP
#define CCE_RUNTIME_IOCTL_UTILS_HPP

#include "base.h"
#include "tsch_cmd.h"
#include <mutex>
#include <string>

namespace cce {
namespace runtime {

constexpr int32_t IOCTL_INVALID_FD = -1;

class IoctlUtil {
public:
    static IoctlUtil& GetInstance();
    rtError_t IoctlByCmd(const stars_ioctl_cmd_t cmd, const stars_ioctl_cmd_args_t *args);
private:
    IoctlUtil();
    ~IoctlUtil();

    std::mutex mutex_;
    int32_t starsFd_{IOCTL_INVALID_FD};
    const std::string starsFile_ = "/dev/stars";

    // open fd
    rtError_t OpenFd();
    // close fd
    rtError_t CloseFd();
};
}  // namespace runtime
}  // namespace cce
#endif  // CCE_RUNTIME_IOCTL_UTILS_HPP