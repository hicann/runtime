/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_PLATFORM_UTIL_H
#define IDE_PLATFORM_UTIL_H

#include <string>
#include "hdc_api.h"
#include "impl_utils.h"
#include "extra_config.h"
#include <fcntl.h>
namespace Adx {
enum class IdeChannel {
    IDE_CHANNEL_SOCK,
    IDE_CHANNEL_HDC,
    IDE_CHANNEL_LOCAL,
};

struct IdeTransChannel {
    IdeChannel type;
    IdeSession session;
};

int32_t IdeRead(const struct IdeTransChannel &handle, IdeRecvBuffT readBuf, IdeI32Pt readLen, int32_t flag);
int32_t IdeGetWorkspace(IdeStringBuffer path, uint32_t len);
int32_t IdeRealFileRemove(IdeString file);
std::string IdeGetHomeDir();

pid_t IdeFork(void);
int32_t IdeFcntl(int32_t fd, int32_t cmd, long arg);
int32_t IdeLockFcntl(int32_t fd, int32_t cmd, const struct flock &lock);
}
#endif

