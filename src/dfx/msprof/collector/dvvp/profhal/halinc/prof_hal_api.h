/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_HAL_API_H
#define PROF_HAL_API_H

#include <cstdint>
#include "utils.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

// version: 1.0.0
const uint32_t ASCEND_PROF_MAJOR_VERSION = 0x1;  // range: 0~0xFFFF FFFF
const uint32_t ASCEND_PROF_MINOR_VERSION = 0x0;  // range: 0~0xFFFF
const uint32_t ASCEND_PROF_PATCH_VERSION = 0x0;  // range: 0~0xFFFF
const uint32_t HAL_HELPER_TLV_HEAD = 0x5a5a5a5a;
const uint32_t HAL_TLV_VERSION = 0x00000100;     // version of tlv
const uint32_t HAL_TLV_VALUE_MAX_LEN = 1024;
const uint32_t HAL_CHUNK_MAX_LEN = 855;
const uint32_t HAL_FILENAME_MAX_LEN = 63;
const uint32_t HAL_EXTRAINFO_MAX_LEN = 63;
const uint32_t HAL_ID_MAX_LEN = 9;
const std::string DEVICE_PID = "helper_device_pid";

struct ProfHalModuleConfig {
    uint32_t *devIdList;
    uint32_t devIdListNums;
};

enum ProfHalServerType {
    PROF_HAL_AICPU,
    PROF_HAL_HELPER,
};

enum ProfTlvType {
    HELPER_TLV_TYPE,
    HELPER_DEVICE_PID_TYPE,
    MAX_TLV_TYPE,
};

struct ProfHalTlv {
    uint32_t head;
    uint32_t version;
    uint32_t type;
    uint32_t len;
    uint8_t value[HAL_TLV_VALUE_MAX_LEN];
};

struct ProfHalStruct {
    bool isLastChunk;
    int32_t chunkModule;
    size_t chunkSize;
    int64_t offset;
    char chunk[HAL_CHUNK_MAX_LEN + 1];
    char fileName[HAL_FILENAME_MAX_LEN + 1];
    char extraInfo[HAL_EXTRAINFO_MAX_LEN + 1];
    char id[HAL_ID_MAX_LEN + 1];
};
// register fuction dependence for HDC Server
typedef void (*ProfHalFlushModuleCallback)();
typedef int32_t (*ProfHalSendAicpuDataCallback)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk);
typedef int32_t (*ProfHalHelperDirCallback)(const std::string helperDir);
typedef int32_t (*ProfHalSendHelperDataCallback)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk);

extern "C" int32_t ProfHalGetVersion(uint32_t *version);
extern "C" int32_t ProfHalModuleInitialize(uint32_t moduleType, const void *moduleConfig, uint32_t length);
extern "C" int32_t ProfHalModuleFinalize();
extern "C" void ProfHalSetFlushModuleCallback(const ProfHalFlushModuleCallback func);
extern "C" void ProfHalSetSendDataCallback(const ProfHalSendAicpuDataCallback func);
extern "C" void ProfHalSetHelperDirCallback(const ProfHalHelperDirCallback func);
extern "C" void ProfHalSetSendHelperDataCallback(const ProfHalSendHelperDataCallback func);

#ifdef __cplusplus
}
#endif
#endif