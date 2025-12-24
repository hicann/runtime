/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_DFX_INTERNAL_H_
#define OP_DFX_INTERNAL_H_
#include "toolchain/aprof_pub.h"
#include "opdev/internal/op_dfx_util.h"
#include "opdev/internal/op_cache_internal.h"
#include "opdev/op_dfx.h"
#include "opdev/internal/launch_arg_info.h"

namespace op {
namespace internal {
using AddrRestorer = std::tuple<const aclTensor *, void *>;
int OpGetTid();

uint32_t CollectProfilingStr(const char *s);

void PrepareBasicInfo(MsprofCompactInfo &compactInfo, MsprofGeTaskType taskType, uint64_t id, uint64_t summaryId);
void PrepareBasicInfo(MsprofCompactInfo &compactInfo, const TaskInfo &taskInfo, uint64_t id, uint64_t summaryId);

void PrepareAdditionInfo(MsprofAdditionalInfo &additionInfo);

void PrepareTensorInfo(const FVector<const aclTensor *> &tensors,
                       MsprofTensorInfo &tensorInfo,
                       uint64_t summaryId,
                       MsprofGeTensorType type,
                       uint32_t tensorNum,
                       uint32_t baseIndex);

void ReportAdditionInfo(const TaskInfo &taskInfo, uint64_t id, uint64_t summaryId);

void ReportNodeContextIdInfo(uint64_t summaryId);

uint64_t GenKernelLauncherId(const char *);

void ChangeAclTenorAddrWithOffset(const aclTensor *tensor, std::vector<AddrRestorer> &record);
void RecoverAclTensorAddr(std::vector<AddrRestorer> &record);

void PrepareDumpTensor(std::vector<Adx::TensorInfo> &dumpTensors,
                       const std::vector<const aclTensor *> &aclTensors,
                       OpIOType ioType, std::vector<AddrRestorer> &record);

void PrepareDumpTensor(std::vector<Adx::TensorInfo> &dumpTensors,
                       const std::vector<op::Tensor *> &opTensors,
                       OpIOType ioType);

void PrepareDumpTensor(std::vector<Adx::TensorInfo> &dumpTensors, const std::vector<const aclTensor *> &aclTensors,
    const std::vector<uint32_t> &tensorsIdxList, OpIOType ioType, std::vector<AddrRestorer> &record);

void DumpL2(const std::vector<const aclTensor *> &tensors,
            const OpLogInfo &opLogInfo,
            OpIOType ioType,
            aclrtStream stream);

void CacheTensorInfo(const FVector<const aclTensor*> &inTensors, const FVector<const aclTensor*> &outTensors);

void CacheDfxInfo(uint32_t blockDim, const ProfilingInfoId &id, const TaskInfo &taskInfo, bool isMemSet);

int32_t RestoreTensorInfo(void *cacheTensorInfoLists,
                          FVector<const aclTensor *> &inTensors,
                          FVector<const aclTensor *> &outTensors);

void DestoryTensorsCached(void *cacheTensorInfoLists);

constexpr int kMaxDurationInfoLen = 256;

extern SystemConfig systemConfig;

inline void GetProfilingTensors(OpArgList &argList, FVector<const aclTensor *> &tensors)
{
    TraitsAclTensor(tensors, argList);
}

void ReportAdditionInfo(FVector<const aclTensor *> &inTensors, FVector<const aclTensor *> &outTensors,
                        MsprofGeTaskType taskType, uint64_t summaryId);

void ReportAdditionInfo(FVector<const aclTensor *> &inTensors, FVector<const aclTensor *> &outTensors,
                        const TaskInfo &taskInfo, uint64_t summaryId);

inline void ReportAdditionInfo(OpArgList &inputs, OpArgList &outputs, MsprofGeTaskType taskType, uint64_t summaryId)
{
    FVector<const aclTensor *> inTensors;
    FVector<const aclTensor *> outTensors;
    GetProfilingTensors(inputs, inTensors);
    GetProfilingTensors(outputs, outTensors);
    ReportAdditionInfo(inTensors, outTensors, taskType, summaryId);
}
inline void ReportAdditionInfo(OpArgList &inputs, OpArgList &outputs, const TaskInfo &taskInfo, uint64_t summaryId)
{
    FVector<const aclTensor *> inTensors;
    FVector<const aclTensor *> outTensors;
    GetProfilingTensors(inputs, inTensors);
    GetProfilingTensors(outputs, outTensors);
    ReportAdditionInfo(inTensors, outTensors, taskInfo, summaryId);
}

void SummaryAttrArg([[maybe_unused]]size_t idx, OpArg &value, std::vector<AttrInfo> &attrInfos, std::string &attrStr);
void SummaryAttrArg([[maybe_unused]]size_t idx, OpArg &value, std::string &attrStr);

void ReportAttrInfo(std::string &attrStr, uint64_t summaryId);

inline void ReportAttrInfo(OpArgList &attrs, std::string &attrStr, std::vector<AttrInfo> &attrInfos)
{
    attrs.VisitByNoReturn(
        [&attrInfos, &attrStr](size_t idx, OpArg &elem) { SummaryAttrArg(idx, elem, attrInfos, attrStr); });
}

inline void PrepareL0DumpTensor(std::vector<Adx::TensorInfo> &dumpTensors, OpArgList &tensors, OpIOType ioType,
                                std::vector<AddrRestorer> &record)
{
    std::vector<const aclTensor *> aclTensors;
    TraitsAclTensor(aclTensors, tensors);
    PrepareDumpTensor(dumpTensors, aclTensors, ioType, record);
}

void AddExceptionDumpOperatorInfo(const std::vector<Adx::TensorInfo> &dumpInTensors,
    const std::vector<Adx::TensorInfo> &dumpOutTensors, const std::vector<Adx::TensorInfo> &dumpWorkSpaceTensors,
    const OpLogInfo &opLogInfo);

void PrepareExceptionDumpInfo(OpArgContext *args, const OpLogInfo &opLogInfo, bool genPlaceholder, bool hasDevPtrArg_,
                              bool interCoreSync, std::vector<int32_t> &tensorOffset);

void PrepareExceptionDumpInfo(const std::vector<op::Tensor *> &in, const std::vector<op::Tensor *> &out,
    const OpLogInfo &opLogInfo, const ExceptionDumpInfo &exceptionDumpInfo);

aclnnStatus OverflowDumpProcess(OpArgContext *args, aclOpExecutor *executor,
                                aclrtStream stream, op::internal::OpLogInfo &logInfo);

void DumpL0(OpArgList &tensors, const OpLogInfo &opLogInfo, OpIOType ioType, aclrtStream stream);

void DumpL0(OpArgList &inputTensors, OpArgList &outputTensors, const OpLogInfo &opLogInfo, aclrtStream stream);

} // namespace internal
} // namespace op

#endif
