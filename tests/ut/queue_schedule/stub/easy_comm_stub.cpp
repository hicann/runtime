/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include<iostream>

#include "easy_comm.h"

void DestroyResponse(struct EzcomResponse *resp)
{
    std::cout << "default DestroyResponse stub" << std::endl;
    return;
}

int EzcomInitServer(void (*callback)(int fd, const char *clientName, int nameLen))
{
    std::cout << "default EzcomInitServer stub" << std::endl;
    return 0;
}

int EzcomCfgInitServer(EzcomPipeServerAttr *attr)
{
    std::cout << "default EzcomCfgInitServer stub" << std::endl;
    return 0;
}

// client
int EzcomTimedConnectServer(const char *serverName, int serverNameLen, int timeOut)
{
    std::cout << "default EzcomTimedConnectServer stub" << std::endl;
    return 1;
}

int EzcomClosePipe(int fd)
{
    std::cout << "default EzcomClosePipe stub" << std::endl;
    return 0;
}

int EzcomRegisterServiceHandler(int fd, void(*handler)(int, struct EzcomRequest *))
{
    std::cout << "default EzcomRegisterServiceHandler stub" << std::endl;
    return 0;
}
int EzcomCreateServer(const struct EzcomServerAttr *attr)
{
    std::cout << "default EzcomCreateServer stub" << std::endl;
    return 0;
}
int EzcomCreateClient(const struct EzcomAttr *attr)
{
    std::cout << "default EzcomCreateClient stub" << std::endl;
    return 1;
}

int EzcomRPCSync(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
{
    std::cout << "default EzcomRPCSync stub" << std::endl;
    return 0;
}

int EzcomSendResponse(int fd, struct EzcomResponse *resp)
{
    std::cout << "default EzcomSendResponse stub" << std::endl;
    return 0;
}
