/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_PLATFORM_STUB_H
#define __IDE_PLATFORM_STUB_H

#include "ascend_hal.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netdb.h>
#include "hdc_api.h"
#include "mmpa_api.h"
#include "ide_common_util.h"
#include <sys/syscall.h>

#ifdef __cplusplus
extern "C" {
#endif
extern int ide_daemon_cmd_process_stub(HDC_SESSION session, IdeTlvConReq req);
#ifdef __cplusplus
}
#endif

#endif