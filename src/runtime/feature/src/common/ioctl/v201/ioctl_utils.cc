/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ioctl_utils.hpp"
#include "mmpa/mmpa_api.h"
#include "internal_error_define.hpp"
#include "base_info.hpp"
#include "base.hpp"

namespace cce {
namespace runtime {

IoctlUtil::IoctlUtil()
{
    (void)OpenFd();
}

IoctlUtil::~IoctlUtil()
{
    try {
        (void)CloseFd();
    } catch (...) {
        RT_LOG(RT_LOG_ERROR, "close fd failed.");
    }
}

rtError_t IoctlUtil::OpenFd()
{
    std::lock_guard<std::mutex> lock(mutex_);
    const int32_t fd = mmOpen2(starsFile_.c_str(), O_RDWR, M_UMASK_USRREAD | M_UMASK_USRWRITE);
    COND_RETURN_ERROR((fd < 0), RT_ERROR_DRV_IOCTRL,
        "runtime open stars file failed, fd[%d], reason[%s], errno[%d].",
        fd, strerror(errno), errno);

    starsFd_ = fd; // starsFd_ is global variable
    RT_LOG(RT_LOG_INFO, "runtime open stars file success, fd[%d], path=[%s]", fd, starsFile_.c_str());

    return RT_ERROR_NONE;
}

rtError_t IoctlUtil::CloseFd()
{
    std::lock_guard<std::mutex> lock(mutex_);
    COND_RETURN_WARN((starsFd_ < 0), RT_ERROR_NONE, "No need to close file descriptor, fd_ is invalid.");

    const int32_t ret = mmClose(starsFd_);
    COND_RETURN_ERROR((ret != 0), RT_ERROR_DRV_IOCTRL, "Close file descriptor failed, ret=%d.", ret);
    starsFd_ = IOCTL_INVALID_FD;

    return RT_ERROR_NONE;
}

rtError_t IoctlUtil::IoctlByCmd(const stars_ioctl_cmd_t cmd, const stars_ioctl_cmd_args_t *args)
{
    std::lock_guard<std::mutex> lock(mutex_);
    COND_RETURN_ERROR((starsFd_ < 0), RT_ERROR_DRV_IOCTRL, "fd_[%d] is invalid", starsFd_);

    const int32_t ret = ioctl(starsFd_, cmd, args);
    COND_RETURN_ERROR((ret != 0), RT_ERROR_DRV_IOCTRL, "ioctl failed, ret=%d", ret);

    return RT_ERROR_NONE;
}

IoctlUtil& IoctlUtil::GetInstance()
{
    static IoctlUtil instance;
    return instance;
}

}  // namespace runtime
}  // namespace cce