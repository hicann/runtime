/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DATADUMP_KFC_INTERFACE_H
#define DATADUMP_KFC_INTERFACE_H

namespace KfcDump {
    constexpr uint32_t INVALID = 65535U;
}

struct KfcDumpTask {
    KfcDumpTask() : KfcDumpTask(KfcDump::INVALID, KfcDump::INVALID, KfcDump::INVALID) {};
    KfcDumpTask(const uint32_t streamId, const uint32_t taskId, const uint32_t index)
                : streamId_(streamId), taskId_(taskId), index_(index) {};
    uint32_t streamId_ = KfcDump::INVALID;
    uint32_t taskId_ = KfcDump::INVALID;
    uint32_t index_ = KfcDump::INVALID;
    friend bool operator < (const KfcDumpTask &item1, const KfcDumpTask &item2);
};

inline bool operator < (const KfcDumpTask &item1, const KfcDumpTask &item2)
{
    if (item1.streamId_ != item2.streamId_) {
        return item1.streamId_ < item2.streamId_;
    }
    if (item1.taskId_ != item2.taskId_) {
        return item1.taskId_ < item2.taskId_;
    }
    return item1.index_ < item2.index_;
}
enum SpaceType {
    LOG = 0,
};

struct Workspace {
    SpaceType type;
    uint64_t data_addr;
    uint64_t size;
};

struct InputOutputKfcDumpInfo {
    int32_t index;                     // input or output index info of op 
    int32_t data_type;                 // input or output type info of op
    int32_t format;                    // input or output format info of op
    uint64_t address;                  // input or output address info of op
    uint64_t size;                     // input or output size info of op
    std::vector<uint64_t> shape;       // input or output shape info of op
    std::vector<uint64_t> origin_shape;// input or output origin_shape info of op
    void *reserve;
};

struct KfcDumpInfo {
    std::string opName;
    std::string opType;
    std::vector<Workspace> workspace;
    std::vector<struct InputOutputKfcDumpInfo> inputDumpInfo;  // op input info
    std::vector<struct InputOutputKfcDumpInfo> outputDumpInfo; // op output info
    void *reserve;
};

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

__attribute__((weak)) __attribute__((visibility("default"))) int32_t AicpuGetOpTaskInfo(const KfcDumpTask &taskKey, KfcDumpInfo **ptr);

__attribute__((weak)) __attribute__((visibility("default"))) int32_t AicpuDumpOpTaskData(const KfcDumpTask &taskKey, void *dumpPtr, uint32_t length);

#ifdef __cplusplus
}
#endif
#endif // DATADUMP_KFC_INTERFACE_H
