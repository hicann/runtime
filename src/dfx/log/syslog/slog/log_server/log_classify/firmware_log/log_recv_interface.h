/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_RECV_INTERFACE_H
#define LOG_RECV_INTERFACE_H
#include "log_common.h"
#include "log_system_api.h"
#include "log_common.h"
#include "securec.h"

#define PACKAGE_END 1
#define TWO_SECOND 2000
#define ALLSOURCE_RESERVE 20
#define CHILDSOURCE_RESERVE 16
#define IDE_DAEMON_OK 0

#ifdef __cplusplus
extern "C" {
#endif

// log transfer struct
typedef struct {
    uint16_t  version;
    unsigned int dataCompressed : 1;
    unsigned int frameBegin : 1;
    unsigned int frameEnd : 1;
    unsigned int smpFlag : 1;
    unsigned int slogFlag : 1; // flag to divide device and os log, 1 for device-os and 0 for device
    unsigned int moduleId : 6;
    unsigned int reservedBits : 5;
    unsigned int reserved;
    unsigned int dataLen;
    unsigned char data[0];
}LogMsgHead;

/**
* @brief            : recv log data by safe mode
* @param [in]       : deviceId          device id
* @param [out]      : recvBuf           pointer to receive buf
* @param [in]       : maxLen            recv buffer max length
* @return           : LogRt, SUCCESS/OTHER
*/
LogRt LogRecvSafeRead(int32_t deviceId, LogMsgHead **recvBuf, uint32_t maxLen);

#ifdef __cplusplus
}
#endif
#endif