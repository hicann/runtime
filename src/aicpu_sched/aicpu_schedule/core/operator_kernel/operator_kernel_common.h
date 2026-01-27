/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_COMMON_H
#define OPERATOR_KERNEL_COMMON_H

#include <memory>

#include "operator_kernel_context.h"

namespace AicpuSchedule {
class OperatorKernelCommon {
public:
    static int32_t SendAICPUSubEvent(char_t * const msg, const uint32_t msgLen, const uint32_t subEventId);
    static void TraceQueueData(const RunContext &taskContext, void * const headBuf, const uint32_t headSize,
                               const char_t* const marker);
    static int32_t CopyMbufHeadInfo(const void * const srcHeaderBuf, const uint32_t srcHeadSize, Mbuf *destMbuf);
    static int32_t GetMbufDataPtr(const uint64_t srcAddr, void **dataAddrPtr);
    static int32_t UpdateDataPtr(const uint64_t mbufAddr, const int32_t fusionOffset, void *&dataPtr,
                                 uint64_t &totalOffset);
    static int32_t DoUpdateDataPtr(FusionInfo &info, const int32_t fusionOffset, void *&dataPtr);
    static int32_t GetMbufDataSize(const uint64_t srcAddr, uint64_t &dataSize);
    static int32_t ParseTensorDescAndCalcDataSize(const RuntimeTensorDesc * const srcTensorDesc, uint32_t &dataSize);
    static int32_t GetMbufAddrAndSize(Mbuf *mbuf, void **dataPptr, uint64_t *dataLenPtr, uint32_t modelId,
                                      bool allowOnlyDesc);
    static std::shared_ptr<MbufHeadMsg> BackupHeadMsg(void * const headBuf, const uint32_t headSize,
                                                      const char_t* const marker);
    static void DoTraceQueueData(const RunContext &taskContext, const MbufHeadMsg *const msg,
                                 const char_t *const marker);

private:
    OperatorKernelCommon() = default;
    ~OperatorKernelCommon() = default;

    OperatorKernelCommon(OperatorKernelCommon const&) = delete;
    OperatorKernelCommon& operator=(OperatorKernelCommon const&) = delete;
    OperatorKernelCommon(OperatorKernelCommon&&) = delete;
    OperatorKernelCommon& operator=(OperatorKernelCommon&&) = delete;

    static MbufHeadMsg *GetHeadMsgForTrace(void * const headBuf, const size_t headSize, const char_t *const marker);
};
}  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_COMMON_H