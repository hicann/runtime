/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_check_input_tensor_desc.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_model_statistic.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_CHECK_INPUT_TENSOR_DESC = "checkInputTensorDesc";
}  // namespace

int32_t OperatorKernelCheckInputTensorDesc::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    // check whether the data is empty.
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if ((model != nullptr) && (model->GetNullDataFlag())) {
        aicpusd_info("null data, no need check static shape");
        return AICPU_SCHEDULE_OK;
    }
    ShapeValidationInfo *allTensorDesc = PtrToPtr<void, ShapeValidationInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (allTensorDesc == nullptr) {
        aicpusd_err("Model check input tensor para is nullptr, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    aicpusd_info("tensor nums[%u], modelId[%u], streamId[%u], taskId[%u]",
        allTensorDesc->inputNums, taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);

    const uint64_t tensorDescNums = allTensorDesc->inputNums;
    std::vector<ModelConfigTensorDesc> tensorDescArr;
    const int32_t result =
        AicpuModelManager::GetInstance().GetModelConfigShape(taskContext.modelId, tensorDescArr);
    if ((result != AICPU_SCHEDULE_OK) || tensorDescArr.empty()) {
        // check aicpu model has tensor info
        aicpusd_warn("aicpumodel task has not tensordesc, no need check");
        return AICPU_SCHEDULE_OK;
    }

    // check tensor desc nums
    if (tensorDescArr.size() != tensorDescNums) {
        aicpusd_err("tensorDesc number is not as expected. the expected number is[%zu], but is[%u]",
            tensorDescArr.size(), tensorDescNums);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    std::vector<uint64_t> inputSizeList;
    for (uint64_t i = 0UL; i < tensorDescNums; i++) {
        uint64_t curSize = 0UL;
        const int32_t ret = CheckInputTensorDesc(allTensorDesc->shapeValidationAddr, i, tensorDescArr[i], curSize);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err(
                "check static shape failed, modelId[%u], streamId[%u], taskId[%u], i = %llu, tensorDescNums = %llu",
                taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID, i, tensorDescNums);
            return ret;
        }
        inputSizeList.emplace_back(curSize);
    }
    AicpuSdModelStatistic::GetInstance().StatNNModelInput(taskContext.modelId, inputSizeList, tensorDescArr);
    aicpusd_info("check static shape success");
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCheckInputTensorDesc::CheckInputTensorDesc(const uint64_t shapeValidationAddr,
                                                                 const uint64_t index,
                                                                 const ModelConfigTensorDesc &modelTensorDesc,
                                                                 uint64_t &curSize) const
{
    ShapeValidation *const shapeInfo =
        PtrToPtr<void, ShapeValidation>(ValueToPtr(shapeValidationAddr + sizeof(ShapeValidation) * index));
    if (shapeInfo == nullptr) {
        aicpusd_err("input shape info is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    aicpusd_info("shapeInfo offset = %u", shapeInfo->offset);
    const auto msgTypeCheckRet = CheckMsgType(PtrToPtr<void, Mbuf*>(ValueToPtr(shapeInfo->mbufAddrs)));
    if (msgTypeCheckRet != AICPU_SCHEDULE_OK) {
        return msgTypeCheckRet;
    }

    uint64_t dataSize = 0UL;
    int32_t ret = OperatorKernelCommon::GetMbufDataSize(shapeInfo->mbufAddrs, dataSize);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data size, ret = %d.", ret);
        return ret;
    }

    void *dataPtr = nullptr;
    ret = OperatorKernelCommon::GetMbufDataPtr(shapeInfo->mbufAddrs, &dataPtr);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data addr. srcAddr is [%lu].", shapeInfo->mbufAddrs);
        return ret;
    }

    if (shapeInfo->offset > 0) {
        uint64_t totalOffset = 0UL;
        ret = OperatorKernelCommon::UpdateDataPtr(shapeInfo->mbufAddrs, static_cast<int32_t>(shapeInfo->offset),
                                                  dataPtr, totalOffset);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to update data addr. fusion offset[%llu], totalOffset[%llu]",
                shapeInfo->offset, totalOffset);
            return ret;
        }
    }

    RuntimeTensorDesc *const tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(dataPtr);
    if (tensorDesc == nullptr) {
        aicpusd_err("tensorDesc is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    aicpusd_info("index[%llu], dtype[%u], shape[0] = %u, datasize:%llu",
                 index, tensorDesc->dtype, tensorDesc->shape[0], tensorDesc->dataSize);
    ret = CheckShapeInfo(modelTensorDesc, *tensorDesc);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("check tensor info failed, tensor index = %llu", index);
        return ret;
    }
    curSize = tensorDesc->dataSize;
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCheckInputTensorDesc::CheckMsgType(Mbuf **const mbufPtr) const
{
    if ((mbufPtr == nullptr) || (*mbufPtr == nullptr)) {
        aicpusd_err("Invalid mbuf.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    uint32_t headSize = 0U;
    void *headBuf = nullptr;
    const auto drvRet = halMbufGetPrivInfo(*mbufPtr, &headBuf, &headSize);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (headBuf == nullptr) ||
        (static_cast<size_t>(headSize) < sizeof(MbufHeadMsg))) {
        aicpusd_err("Failed to get mbuf head, ret[%d], headSize[%u].", drvRet, headSize);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    const MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
        static_cast<size_t>(headSize), static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));
    if ((msg->msgType == static_cast<uint16_t>(MsgType::MSG_TYPE_RAW_MSG)) ||
        (msg->msgType >= static_cast<uint16_t>(MsgType::MSG_TYPE_USER_DEFINE_START))) {
        aicpusd_err("Invalid msg_type[%d].", msg->msgType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCheckInputTensorDesc::CheckShapeInfo(const ModelConfigTensorDesc &modelTensorDesc,
                                                           const RuntimeTensorDesc &tensorDesc) const
{
    if (modelTensorDesc.dtype != tensorDesc.dtype) {
        aicpusd_err("Failed to check modelTensorDesc dtype. modelTensorDesc.dtype[%lld], tensorDesc.dtype[%lld]",
            modelTensorDesc.dtype, tensorDesc.dtype);
        PrintErrShapeInfo(modelTensorDesc, tensorDesc);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (modelTensorDesc.shape[0] > MAX_DIM_SIZE + 1) {
        aicpusd_err("Failed to check modelTensorDesc shape. shape size[%d] should less than %d",
            modelTensorDesc.shape[0], MAX_DIM_SIZE + 1);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    for (int64_t index = 0; index <= modelTensorDesc.shape[0]; index++) {
        if (modelTensorDesc.shape[index] != tensorDesc.shape[index]) {
            aicpusd_err("Failed to check shape. expect shape[%lld] = [%lld], but is [%lld]",
                index, modelTensorDesc.shape[index], tensorDesc.shape[index]);
            PrintErrShapeInfo(modelTensorDesc, tensorDesc);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
    }
    return AICPU_SCHEDULE_OK;
}

void OperatorKernelCheckInputTensorDesc::PrintErrShapeInfo(const ModelConfigTensorDesc &modelTensorDesc,
                                                           const RuntimeTensorDesc &tensorDesc) const
{
    if ((modelTensorDesc.shape[0] > MAX_DIM_SIZE + 1) || (tensorDesc.shape[0] > MAX_DIM_SIZE + 1)) {
        aicpusd_err("Failed to check modelTensorDesc shape. shape size[%d] should less than %d",
            modelTensorDesc.shape[0], MAX_DIM_SIZE + 1);
        return;
    }
    std::ostringstream oss;
    oss << "expect dtype = " << AicpuUtil::GetDTypeString(static_cast<ge::DataType>(modelTensorDesc.dtype));
    oss << ", actual dtype = " << AicpuUtil::GetDTypeString(static_cast<ge::DataType>(tensorDesc.dtype));
    oss << ", expect dims = " << modelTensorDesc.shape[0] << ", actual dims = " << tensorDesc.shape[0];
    oss << ", and expect shape = [ ";
    if (modelTensorDesc.shape[0] > 0) {
        for (int64_t index = 1; index <= modelTensorDesc.shape[0]; index++) {
            oss << modelTensorDesc.shape[index] << " ";
        }
    }

    oss << "], actual shape = [ ";
    if (tensorDesc.shape[0] > 0) {
        for (int64_t index = 1; index <= tensorDesc.shape[0]; index++) {
            oss << tensorDesc.shape[index] << " ";
        }
    }
    oss << "]";
    aicpusd_err("%s", oss.str().c_str());
}


REGISTER_OPERATOR_KERNEL(KERNEL_CHECK_INPUT_TENSOR_DESC, OperatorKernelCheckInputTensorDesc);
}  // namespace AicpuSchedule