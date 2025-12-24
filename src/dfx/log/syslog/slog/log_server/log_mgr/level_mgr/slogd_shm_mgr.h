/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_SHM_MGR_H
#define SLOGD_SHM_MGR_H

#include "log_error_code.h"

LogStatus SlogdShmInit(int32_t devId);
void SlogdShmExit(void);

LogStatus SlogdShmWriteLevelAttr(const char* levelStr, uint32_t length);
LogStatus SlogdShmWriteModuleAttr(const char* moduleStr, uint32_t length);

#endif /* SLOGD_SHM_MGR_H */