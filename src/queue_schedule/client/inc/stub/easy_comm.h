/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef EASY_COMM_H
#define EASY_COMM_H

#include <stdint.h>

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

struct EzcomRequest {
    uint32_t id;
    uint8_t *data;
    uint32_t size;
    uint8_t *desc;
    uint32_t descSize;
};

struct EzcomResponse {
    uint32_t id;
    uint8_t *data;
    uint32_t size;
};

struct EzcomPipeServerAttr {
    void *callback;
    uint32_t gid;
};

enum EzcomMode {
  EZCOM_CLIENT,
  EZCOM_SERVER
};

enum EzcomPriority {
  EZCOM_LOW,
  EZCOM_MID,
  EZCOM_HIGH
};

const uint32_t DEFAULT_TIMEOUT = 2000;

struct EzcomAttr {
    const char *targetName;
    void (*handler)(int32_t, struct EzcomRequest *);
    int32_t timeout;
    enum EzcomMode mode;
    gid_t gid;
    enum EzcomPriority priority;
    const char *selfName;
    uint8_t isConcur; // 0 means sequential, 1 means concurrency. default 0.
#ifdef __cplusplus
    EzcomAttr() : targetName(nullptr), handler(nullptr), timeout(DEFAULT_TIMEOUT), mode(EZCOM_CLIENT), gid(-1),
        priority(EZCOM_MID), selfName(nullptr), isConcur(0) {};
#endif
};

EXTERN_C int32_t EzcomOpen(const struct EzcomAttr *attr);

struct EzcomServerAttr {
    void (*openCallback)(int32_t fd, const char *clientName, int32_t nameLen);
    void (*handler)(int32_t, struct EzcomRequest *);
    gid_t gid;
    enum EzcomPriority priority;
    const char *selfName;
#ifdef __cplusplus
    EzcomServerAttr() : openCallback(nullptr), handler(nullptr), gid(-1), priority(EZCOM_MID), selfName(nullptr) {};
#endif
};

EXTERN_C void DestroyResponse(struct EzcomResponse *resp);

// This useful macro defins a scoped EzcomResponse variable.
// When it reaches its scope, the data buffer pointer will be freed automatically.
#define DEFINE_EZCOM_RESPONSE(resp) \
    struct EzcomResponse resp __attribute__((cleanup(DestroyResponse))) = {0};

#define PROC_NAME_LEN_MAX  101
#define MAX_PIPE_NUM  64U
#define DEFAULT_FIFO_PREFIX  "/tmp/"

EXTERN_C int EzcomInitServer(void (*callback)(int fd, const char *clientName, int nameLen));
EXTERN_C int EzcomCfgInitServer(EzcomPipeServerAttr *attr);
EXTERN_C void EzcomCloseServer(void);
EXTERN_C int EzcomTimedConnectServer(const char *serverName, int serverNameLen, int timeOut);

EXTERN_C int EzcomOpenPipe(const char *targetProcName, int procNameLen);
EXTERN_C int EzcomOpenPipeAsync(const char *targetProcName, int procNameLen, void(*callback)(const char *targetProcName, int procNameLen, int fd));
EXTERN_C int EzcomClosePipe(int fd);
EXTERN_C int EzcomSendRequest(int fd, struct EzcomRequest *req);
EXTERN_C int EzcomSendResponse(int fd, struct EzcomResponse *resp);
EXTERN_C int EzcomFetchRequest(int fd, struct EzcomRequest *req);
EXTERN_C int EzcomRPCSync(int fd, struct EzcomRequest *req, struct EzcomResponse *resp);
EXTERN_C int EzcomRPCAsync(int fd, struct EzcomRequest *req,
                           void(*callback)(struct EzcomRequest *req, struct EzcomResponse *resp));
EXTERN_C int EzcomRegisterServiceHandler(int fd, void(*handler)(int, struct EzcomRequest *));

EXTERN_C int EzcomOpen(const struct EzcomAttr *attr);
EXTERN_C int EzcomCreateServer(const struct EzcomServerAttr *attr);
EXTERN_C int EzcomCreateClient(const struct EzcomAttr *attr);

#ifdef __cplusplus

#include <string>
#include <functional>
using namespace std;
void EzcomOpenPipeAsync(const string& targetProcName, function<void(int)> callback);

#endif

#endif //EASY_COMM_H
