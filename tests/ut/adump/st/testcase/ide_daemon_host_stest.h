/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_DAEMON_HOST_STEST_H
#define __IDE_DAEMON_HOST_STEST_H

#include "securec.h"
#include "hdc_api.h"
#include "ide_daemon_sock.h"
#include "ide_handle.h"

int IdeDaemonTestMain(int argc, char *argv[]);
extern int IdeTransferFile(struct IdeData &pdata, struct IdeSockHandle handle, int fd, uint32_t perSendSize);
extern int IdeSendFrontData(struct IdeData &pdata, int handler,
    struct IdeSockHandle handle, uint32_t perSendSize, long int& len);
extern int IdeSendLastData(struct IdeData &pdata, int handler,
    struct IdeSockHandle handle, uint32_t perSendSize, uint32_t remain);
#endif  //__IDE_DAEMON_HOST_STEST_H

