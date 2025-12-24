/**
  * Copyright (c) 2025 Huawei Technologies Co., Ltd.
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
  * CANN Open Software License Agreement Version 2.0 (the "License").
  * Please refer to the License for details. You may not use this file except in compliance with the License.
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
  * See LICENSE in the root of the software repository for the full text of the License.
  */

/*!
 * \file adcore_api.h
 * \brief
*/

#ifndef ADCORE_API_H
#define ADCORE_API_H
#include "ascend_hal.h"
#include "ide_tlv.h"
#include "extra_config.h"
#include "adx_service_config.h"
#define ADX_API __attribute__((visibility("default")))
#ifdef __cplusplus
extern "C" {
#endif
typedef enum drvHdcServiceType AdxHdcServiceType;
typedef enum {
    SEND_FILE_TYPE_REAL_FILE,
    SEND_FILE_TYPE_TMP_FILE
} SendFileType;

typedef struct {
    ComponentType type; // 数据包组件类型
    int32_t devId;      // 设备 ID
    int32_t len;        // 数据包数据长度
    char value[0];      // 数据包数据
} TlvReq;
typedef TlvReq*            AdxTlvReq;
typedef const TlvReq*      AdxTlvConReq;

ADX_API AdxCommHandle AdxCreateCommHandle(AdxHdcServiceType type, int32_t devId, ComponentType compType);
ADX_API int32_t AdxIsCommHandleValid(AdxCommConHandle handle);
ADX_API void AdxDestroyCommHandle(AdxCommHandle handle);
ADX_API int32_t AdxSendMsg(AdxCommConHandle handle, AdxString data, uint32_t len);
ADX_API int32_t AdxRecvMsg(AdxCommHandle handle, IdeStrBufAddrT data, uint32_t *len, uint32_t timeout);
ADX_API int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value);
ADX_API int32_t AdxRecvDevFileTimeout(AdxCommHandle handle, AdxString desPath, uint32_t timeout,
    AdxStringBuffer fileName, uint32_t fileNameLen);

ADX_API int32_t AdxSendMsgAndGetResultByType(AdxHdcServiceType type, IdeTlvConReq req, const AdxStringBuffer result,
    uint32_t resultLen);
ADX_API int32_t AdxSendMsgAndNoResultByType(AdxHdcServiceType type, IdeTlvConReq req);
ADX_API int32_t AdxSendMsgByHandle(AdxCommConHandle handle, CmdClassT type, AdxString data, uint32_t len);
ADX_API int32_t AdxSendFileByHandle(AdxCommConHandle handle, CmdClassT type, AdxString srcPath, AdxString desPath,
    SendFileType flag);
ADX_API int32_t AdxDevCommShortLink(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result, uint32_t length,
    uint32_t timeout);

#ifdef __cplusplus
}
#endif
#endif // ADCORE_API_H