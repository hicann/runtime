/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef DOMAIN_COLLECT_CHANNEL_CHANNEL_READER_H
#define DOMAIN_COLLECT_CHANNEL_CHANNEL_READER_H

#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint32_t dispatchCount;
    uint32_t deviceId;
    uint32_t channelId;
    uint32_t quit;             // if channel stopped
    uint8_t* buffer;
    uint32_t spaceSize;        // free Space Size
    uint32_t dataSize;         // 缓冲区以存放的空间大小
    uint32_t bufferSize;       // 缓冲区空间大小
    uint32_t flushSize;        // 待清空缓冲区大小
    uint64_t totalSize;        // channel读取的总数据，用于统计通道是否有丢失数据。
    OsalMutex readMtx;
    OsalMutex flushMtx;
    OsalCond readCond;
} ChannelReader;

int32_t ChannelReaderInitialize(uint32_t deviceId, uint32_t deviceNum);
ChannelReader* GetChannelReader(uint32_t deviceId, uint32_t channelId);
int32_t AddChannelReader(uint32_t deviceId, uint32_t channelId);
uint32_t GetChannelNum(uint32_t deviceId);
uint32_t GetChannelIdByIndex(uint32_t deviceId, uint32_t channelIndex);
int32_t ChannelReaderFinalize(void);

#ifdef __cplusplus
}
#endif
#endif
