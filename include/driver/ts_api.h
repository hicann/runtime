/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TS_API_H
#define TS_API_H

#ifdef __cplusplus
extern "C" {
#endif

#define TS_INNER_SUCCESS 0
#define TS_INNER_ERR (-1)
#define TS_PARA_ERR (-2)
#define TS_COPY_USER_ERR (-3)

int tsDevSendMsgAsync(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen,
    unsigned int handleId);

#ifdef __cplusplus
}
#endif
#endif

