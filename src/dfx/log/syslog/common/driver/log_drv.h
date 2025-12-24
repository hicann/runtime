/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_DRV_H
#define LOG_DRV_H

#include "ascend_hal.h"
#include "log_error_code.h"

#define DRV_SESSION_RUN_ENV_UNKNOW                      0
#define DRV_SESSION_RUN_ENV_PHYSICAL                    1 // physical
#define DRV_SESSION_RUN_ENV_PHYSICAL_CONTAINER          2 // normal container
#define DRV_SESSION_RUN_ENV_VIRTUAL                     3 // computer-group physical
#define DRV_SESSION_RUN_ENV_VIRTUAL_CONTAINER           4

#define HDC_START_BUF "###[HDC_MSG]_DEVICE_FRAMEWORK_START_###"
#define HDC_END_BUF "###[HDC_MSG]_DEVICE_FRAMEWORK_END_###"

#ifdef __cplusplus
extern "C" {
#endif
typedef struct {
    unsigned short headInfo;    // head magic data, judge to little
    unsigned char headVer;      // head version
    unsigned char order;        // packet order (reserved)
    unsigned short reqType;     // request type of proto
    unsigned short devId;       // request device Id
    unsigned int totalLen;      // whole message length, only all data[0] length
    unsigned int sliceLen;      // one slice length, only data[0] length
    unsigned int offset;        // offset
    unsigned short msgType;     // message type
    unsigned short status;      // message status data
    unsigned char data[0];      // message data
} LogDataMsg;

/**
* @brief DrvSessionRelease: release session
* @param [in]session: hdc session
* @return: 0: success; -1: failed
*/
int DrvSessionRelease(HDC_SESSION session);

/**
* @brief DrvDevIdGetBySession: get session attr by session
* @param [in]session: connection session
* @param [in]attr: session attr enum drvHdcSessionAttr
* @param [out]value: session attr value
* @return: 0: success, -1: failed
*/
int DrvDevIdGetBySession(HDC_SESSION session, int attr, int *value);

/**
* @brief DrvBufWrite: write data by hdc
* @param [in]session: connection session
* @param [in]buf: write data buffer
* @param [in]bufLen: data length
* @return: 0: success; -1: failed
*/
int DrvBufWrite(HDC_SESSION session, const char *buf, size_t bufLen);

#ifdef __cplusplus
}
#endif
#endif