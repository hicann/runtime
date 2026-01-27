/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "easy_comm.h"
#include "iam.h"

int EzcomRPCSync(int fd, struct EzcomRequest *req, struct EzcomResponse *resp) {
    return 0;
}

int IAMInitProc(const AppConfig &config) {
    return 0;
}

int EzcomRegisterServiceHandler(int fd, void (*handler)(int, struct EzcomRequest *)) {
    return 0;
}
int EzcomCreateServer(const struct EzcomServerAttr *attr)
{
    return 0;
}
int EzcomCreateClient(const struct EzcomAttr *attr)
{
    return 0;
}

int EzcomOpenPipe(const char *targetProcName, int procNameLen) {
    return 0;
}

int32_t EzcomOpen(const struct EzcomAttr *attr){
    return 1;
}

int EzcomOpenPipeAsync(const char *targetProcName, int procNameLen,
                       void (*callback)(const char *targetProcName, int procNameLen, int fd)) {
    return 0;
}

int EzcomClosePipe(int fd) {
    return 0;
}

int EzcomTimedRPCSync(int fd, struct EzcomRequest *req, struct EzcomResponse *resp, int timeOut) {
    return 0;
}

int EzcomSendResponse(int fd, const struct EzcomResponse *resp) {
    return 0;
}
