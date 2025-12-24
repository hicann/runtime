/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_INFO_STRUCT_COND_HPP
#define CCE_RUNTIME_TASK_INFO_STRUCT_COND_HPP
 
#include "dev.h"
#include "task_info_base.hpp"
 
#define THREAD_FOR_PRE_LOAD (30U)
 
namespace cce {
namespace runtime {
class Event;
// StreamLabelSwitchByIndexTask
struct StmLabelSwitchByIdxTaskInfo {
    void *indexPtr;
    void *labelInfoPtr;
    void *funcCallSvmMem;
    void *dfxPtr;
    void *baseFuncCallSvmMem;
    uint64_t phyIndexPtr;
    uint64_t phyLabelInfoPtr;
    uint32_t max;
    uint32_t funCallMemSize;
};
 
struct StreamSwitchTaskInfo {
    Stream *trueStream;
    void *funcCallSvmMem;
    void *baseFuncCallSvmMem;
    void *dfxPtr;
    uint64_t ptr;
    uint64_t phyPtr;   // ptr_ physic addr
    uint64_t funCallMemSize;
    int64_t value; // only used when isCondEx_=false
    uint64_t valuePtr; // only used when isCondEx_=true
    uint64_t phyValuePtr; // only used when isCondEx_=true
    uint32_t trueStreamId;
    rtSwitchDataType_t dataType;  // only used when isCondEx_=true
    rtCondition_t condition;
    bool isCondEx;
};
 
struct StreamActiveTaskInfo {
    Stream *activeStream;
    void *funcCallSvmMem;
    void *baseFuncCallSvmMem;
    void *dfxPtr;
    uint64_t funCallMemSize;
    uint32_t activeStreamId;
    uint32_t activeStreamSqId;
};
 
struct MemWaitValueTaskInfo {
    uint64_t devAddr;
    uint64_t value;
    uint64_t funCallMemSize2;
    uint32_t flag;
    uint16_t curIndex;
    uint16_t awSize;
    void *baseFuncCallSvmMem;
    void *funcCallSvmMem2;
    void *writeValueAddr;
    Event *event;
};
 
struct DqsCommonTaskInfo {
    void *funcCallSvmMem;
    void *baseFuncCallSvmMem;
    void *dfxPtr;
    uint64_t funCallMemSize;
    uint64_t sqId;
};
 
struct RdmaSendTaskInfo {
    uint32_t sqIndex;
    uint32_t wqeIndex;
};
 
struct RdmaDbSendTaskInfo {
    rtRdmaDbIndex_t taskDbIndex;
    rtRdmaDbInfo_t taskDbInfo;
    uint32_t taskSeq; // for stars model task
};
 
struct RdmaPiValueModifyInfo {
    void* funCallMemAddr; // 只需要释放funCallMemAddr
    void* funCallMemAddrAlign;
    void* dfxAddr;
    uint32_t rdmaSubContextCount;
    size_t funCallMemSize;
};
 
struct DqsZeroCopyTaskInfo {
    DqsCommonTaskInfo commonTaskInfo;
 
    void *destPtr;
    void *offsetPtr;
    uint64_t allocSize;
};
 
struct DqsSchedEndTaskInfo {
    Stream *stream;
};
 
struct DqsInterChipProcTaskInfo {
    DqsCommonTaskInfo commonTaskInfo;
 
    uint32_t groupIdx;
};
 
struct DqsAdspcTaskInfo {
    DqsCommonTaskInfo commonTaskInfo;
 
    uint64_t qmngrEnqRegAddr;
    uint64_t qmngrOwRegAddr;
    uint64_t mbufFreeRegAddr;
    uint8_t  cqeHeadTailMask;
};
 
struct StreamSwitchNTaskInfo {
    uint64_t ptr;
    uint64_t phyPtr; // ptr_ physic addr
    uint64_t trueStreamPtr;
    uint64_t phyTrueStreamPtr;
    uint64_t valuePtr;
    uint64_t phyValuePtr;
    uint32_t size;
    uint32_t elementSize;
    rtSwitchDataType_t dataType;
    bool isTransAddr;
};
 
}
}
#endif  // CCE_RUNTIME_TASK_INFO_STRUCT_COND_HPP