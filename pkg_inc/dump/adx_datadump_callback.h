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
 * \file adx_datadump_callback.h
 * \brief
*/

#ifndef ADX_DATADUMP_CALLBACK_H
#define ADX_DATADUMP_CALLBACK_H
#include <cstdint>
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ADX_API __declspec(dllexport)
#else
#define ADX_API __attribute__((visibility("default")))
#endif
namespace Adx {
const uint32_t MAX_FILE_PATH_LENGTH          = 4096;
struct DumpChunk {
    char       fileName[MAX_FILE_PATH_LENGTH];   // file name, absolute path
    uint32_t   bufLen;                           // dataBuf length
    uint32_t   isLastChunk;                      // is last chunk. 0: not 1: yes
    int64_t    offset;                           // Offset in file. -1: append write
    int32_t    flag;                             // flag
    uint8_t    dataBuf[0];                       // data buffer
};

ADX_API int AdxRegDumpProcessCallBack(int (* const messageCallback)(const Adx::DumpChunk *, int));
ADX_API void AdxUnRegDumpProcessCallBack();
}

#endif
