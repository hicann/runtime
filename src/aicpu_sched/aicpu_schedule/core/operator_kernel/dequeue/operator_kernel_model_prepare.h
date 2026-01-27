/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_MODEL_PREPARE_H
#define OPERATOR_KERNEL_MODEL_PREPARE_H

#include <vector>
#include "operator_kernel.h"
#include "operator_kernel_dequeue_base.h"


namespace AicpuSchedule {
class OperatorKernelModelPrepare : public OperatorKernel, public OperatorKernelDequeueBase {
public:
    OperatorKernelModelPrepare() = default;
    ~OperatorKernelModelPrepare() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t ChecPrepareNullptr(const AicpuPrepareInfo &prepareInfo) const;
    int32_t CheckPrepareMaxSize(const AicpuPrepareInfo &prepareInfo) const;
    bool CheckPointListNullptr(const uint64_t * const pointList, const uint32_t pointSize) const;
    int32_t DoCompute(AicpuPrepareInfo &msgInfo, const RunContext &taskContext) const;
    int32_t DequeueMbufList(const AicpuPrepareInfo &msgInfo, ModelPrepareData &prepareData,
                            std::vector<void *> &inputsData, const RunContext &taskContext) const;
    int32_t CopyDequeueDataPtrToInputAddr(AicpuPrepareInfo &msgInfo, const std::vector<void *> &inputsData) const;
    int32_t AllocOutputMbufList(AicpuPrepareInfo &msgInfo, Mbuf **lastInputMbuflistPptr,
                                Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM], const RunContext &taskContext) const;
    int32_t GetDataPtrsFromMbufs(const AicpuPrepareInfo &msgInfo, Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM],
                                 void *(&dataPtrStore)[MAX_SIZE_NUM]) const;
    int32_t CopyOutputDataPtrToOutputAddr(AicpuPrepareInfo &msgInfo, void * const (&dataPtrStore)[MAX_SIZE_NUM]) const;
    int32_t BuildEnqueueMbufPtrList(AicpuPrepareInfo &msgInfo, Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM]) const;
    int32_t GetMbufListDataPtr(void *mbufPtr, void **dataAddrPtr, const uint32_t mbufIndex) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_MODEL_PREPARE_H
