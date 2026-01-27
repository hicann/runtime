/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_task.h"

#include <algorithm>
#include <regex>
#include <sstream>
#include <vector>
#include <dlfcn.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_model_execute.h"
#include "common/aicpusd_util.h"
#include "securec.h"
#include "external/graph/types.h"

namespace AicpuSchedule {

// slice size for dump file, 128MByes
const uint64_t DUMP_SLICE_SIZE = 128UL << 20U;
const std::string KFC_DUMP_KERNEL_NAME = "AicpuKfcDumpSrvLaunch";

OpDumpTask::OpDumpTask(const int32_t hostPid, const uint32_t deviceId)
    : taskDumpNum_(0U),
      endGraph_(false),
      inputTotalSize_(0U),
      outputTotalSize_(0U),
      opBufferTotalSize_(0U),
      opWorkspaceTotalSize_(0U),
      buff_(nullptr),
      buffSize_(0U),
      offset_(0U),
      isSingleOrUnknowShapeOp_(false),
      hostPid_(hostPid),
      deviceId_(deviceId),
      dumpMode_(DumpMode::TENSOR_DUMP_DATA) {}

StatusCode OpDumpTask::GetDumpNumber(uint64_t &dumpNum)
{
    if (optionalParam_.hasStepId) {
        if (optionalParam_.stepIdAddr == nullptr) {
            aicpusd_err("op name[%s], step id addr is null", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        const uint64_t stepId = *(optionalParam_.stepIdAddr);
        aicpusd_info("op name[%s], step id is[%llu]", opName_.c_str(), stepId);
        uint64_t iterationsPerLoop = 0U;
        uint64_t loopCond = 0U;
        if (optionalParam_.hasIterationsPerLoop) {
            if (optionalParam_.iterationsPerLoopAddr == nullptr) {
                aicpusd_err("op name[%s], iterations per loop addr is null", opName_.c_str());
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            iterationsPerLoop = *(optionalParam_.iterationsPerLoopAddr);
            aicpusd_info("op name[%s], iterations per loop is[%llu]", opName_.c_str(), iterationsPerLoop);
        }
        if (optionalParam_.hasLoopCond) {
            if (optionalParam_.loopCondAddr == nullptr) {
                aicpusd_err("op name[%s], loop cond addr is null", opName_.c_str());
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            loopCond = *(optionalParam_.loopCondAddr);
            aicpusd_info("op name[%s], loop cond is[%llu]", opName_.c_str(), loopCond);
        }
        aicpusd_info("op name[%s], step id[%llu], iterations per loop[%llu], loop cond[%llu]",
            opName_.c_str(), stepId, iterationsPerLoop, loopCond);
        // overflow does not matter
        dumpNum = (stepId * (iterationsPerLoop + 1U)) + loopCond;
    } else {
        dumpNum = taskDumpNum_;
    }

    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessOutput(const aicpu::dump::Task &task,
                                        ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &outputsFromMapInfo = task.output();
    for (int64_t i = 0; i < outputsFromMapInfo.size(); ++i) {
        const auto &item = outputsFromMapInfo.at(i);
        ::toolkit::dumpdata::OpOutput * const opOutput = dumpData.add_output();
        if (opOutput == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add output elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        opOutput->set_data_type(static_cast<::toolkit::dumpdata::OutputDataType>(item.data_type()));
        const auto format = item.format();
        opOutput->set_format(static_cast<::toolkit::dumpdata::OutputFormat>(ge::GetPrimaryFormat(format)));
        opOutput->set_sub_format(ge::GetSubFormat(format));
        opOutput->set_offset(static_cast<::toolkit::dumpdata::OutputDataType>(item.offset()));

        const int32_t addrType = item.addr_type();
        std::vector<uint64_t> outputShape;
        std::vector<uint64_t> outputOriginshape;
        if (addrType != aicpu::dump::NOTILING_ADDR) {
            const auto dims = item.shape().dim();
            ::toolkit::dumpdata::Shape * const outShape = opOutput->mutable_shape();
            for (const auto dim : dims) {
                outShape->add_dim(dim);
                outputShape.push_back(dim);
            }
            const auto originalDims = item.origin_shape().dim();
            ::toolkit::dumpdata::Shape * const outOriginalShape = opOutput->mutable_original_shape();
            for (const auto dim : originalDims) {
                outOriginalShape->add_dim(dim);
                outputOriginshape.push_back(dim);
            }
            opOutput->set_size(item.size());
            outputTotalSize_ += item.size();
        }

        if (!item.original_name().empty()) {
            ::toolkit::dumpdata::OriginalOp * const orgOp = opOutput->mutable_original_op();
            orgOp->set_name(item.original_name());
            orgOp->set_output_index(static_cast<uint32_t>(item.original_output_index()));
            orgOp->set_data_type(static_cast<::toolkit::dumpdata::OutputDataType>(item.original_output_data_type()));
            orgOp->set_format(static_cast<::toolkit::dumpdata::OutputFormat>(item.original_output_format()));
        }

        const auto &dim_rangeFromOutput = item.dim_range();
        for (int64_t i = 0; i < dim_rangeFromOutput.size(); ++i) {
            const auto &item = dim_rangeFromOutput.at(i);
            ::toolkit::dumpdata::DimRange * const dimRange = opOutput->add_dim_range();
            if (dimRange == nullptr) {
                aicpusd_err("op name[%s], call protobuf function to add dim_range elem failed, i[%d],"
                            " dim_range_size[%u]", opName_.c_str(), i, dim_rangeFromOutput.size());
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            dimRange->set_dim_start(item.dim_start());
            dimRange->set_dim_end(item.dim_end());
        }
        outputsBaseAddr_.push_back(item.address());
        outputsAddrType_.push_back(item.addr_type());
        outputSize_.push_back(item.size());
        outputOffset_.push_back(item.offset());
        outputsDataType_.push_back(item.data_type());
        outputsFormat_.push_back(ge::GetPrimaryFormat(format));
        outputsShape_.push_back(outputShape);
        outputsOriginShape_.push_back(outputOriginshape);
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessInput(const aicpu::dump::Task &task,
                                       ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &inputsFromMapInfo = task.input();
    for (int64_t i = 0; i < inputsFromMapInfo.size(); ++i) {
        const auto &item = inputsFromMapInfo.at(i);
        ::toolkit::dumpdata::OpInput * const opInput = dumpData.add_input();
        if (opInput == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add input elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        opInput->set_data_type(static_cast<::toolkit::dumpdata::OutputDataType>(item.data_type()));
        const auto format = item.format();
        opInput->set_format(static_cast<::toolkit::dumpdata::OutputFormat>(ge::GetPrimaryFormat(format)));
        opInput->set_sub_format(ge::GetSubFormat(format));
        opInput->set_offset(static_cast<::toolkit::dumpdata::OutputDataType>(item.offset()));

        const int32_t addrType = item.addr_type();
        std::vector<uint64_t> inputshape;
        std::vector<uint64_t> inputOriginShape;
        if (addrType != aicpu::dump::NOTILING_ADDR) {
            const auto dims = item.shape().dim();
            ::toolkit::dumpdata::Shape * const inShape = opInput->mutable_shape();
            for (const auto dim : dims) {
                inShape->add_dim(dim);
                inputshape.push_back(dim);
            }
            const auto originalDims = item.origin_shape().dim();
            ::toolkit::dumpdata::Shape * const inOriginalShape = opInput->mutable_original_shape();
            for (const auto dim : originalDims) {
                inOriginalShape->add_dim(dim);
                inputOriginShape.push_back(dim);
            }
            opInput->set_size(item.size());
            inputTotalSize_ += item.size();
        }
        inputsBaseAddr_.push_back(item.address());
        inputsAddrType_.push_back(item.addr_type());
        inputsSize_.push_back(item.size());
        inputsOffset_.push_back(item.offset());
        inputsDataType_.push_back(item.data_type());
        inputsFormat_.push_back(ge::GetPrimaryFormat(format));
        inputsShape_.push_back(inputshape);
        inputsOriginShape_.push_back(inputOriginShape);
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessOpBuffer(const aicpu::dump::Task &task,
                                          ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &opsBufferFromMapInfo = task.buffer();
    for (int64_t i = 0; i < opsBufferFromMapInfo.size(); ++i) {
        const auto &item = opsBufferFromMapInfo.at(i);
        ::toolkit::dumpdata::OpBuffer * const opBuffer = dumpData.add_buffer();
        if (opBuffer == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add op buffer elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }

        opBuffer->set_buffer_type(static_cast<::toolkit::dumpdata::BufferType>(item.buffer_type()));
        opBuffer->set_size(item.size());
        opBufferTotalSize_ += item.size();
        opBufferAddr_.push_back(item.address());
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessWorkspace(const aicpu::dump::Task &task,
                                           ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &opsWorkspaceFromMapInfo = task.space();
    for (int64_t i = 0; i < opsWorkspaceFromMapInfo.size(); ++i) {
        const auto &item = opsWorkspaceFromMapInfo.at(i);
        ::toolkit::dumpdata::Workspace * const opWorkspace = dumpData.add_space();
        if (opWorkspace == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add op Workspace elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }

        opWorkspace->set_type(static_cast<::toolkit::dumpdata::Workspace::SpaceType>(item.type()));
        opWorkspace->set_size(item.size());
        opWorkspaceTotalSize_ += item.size();
        opWorkspaceAddr_.push_back(item.data_addr());
        opWorkspaceSize_.push_back(item.size());
    }
    return AICPU_SCHEDULE_OK;
}


StatusCode OpDumpTask::UpdatePreProcessFftsPlusInputAndOutput(const aicpu::dump::Context &item)
{
    const auto &inputFromContext = item.input();
    uint32_t inputFromContextSize = static_cast<uint32_t>(inputFromContext.size());
    if (inputFromContextSize != static_cast<uint32_t>(baseDumpData_.input_size())) {
        aicpusd_err("inputFromContextSize[%u], baseDumpData_.input_size[%u]",
            inputFromContextSize, baseDumpData_.input_size());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    inputTotalSize_ = 0;
    for (uint32_t j = 0U; j < inputFromContextSize; ++j) {
        const auto &itemInput = inputFromContext.at(j);
        uint64_t dataAddr = itemInput.address();
        uint64_t size = itemInput.size();
        baseDumpData_.mutable_input(j)->set_address(dataAddr);
        baseDumpData_.mutable_input(j)->set_size(size);
        inputsBaseAddr_[j] = dataAddr;
        inputsSize_[j] = size;
        inputTotalSize_ += size;
        aicpusd_info("size[%llu]", size);
    }
    const auto &outputFromContext = item.output();
    uint32_t outputFromContextSize = static_cast<uint32_t>(outputFromContext.size());
    if (outputFromContextSize != static_cast<uint32_t>(baseDumpData_.output_size())) {
        aicpusd_err("outputFromContextSize[%u], baseDumpData_.output_size[%u]",
            outputFromContextSize, baseDumpData_.output_size());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    outputTotalSize_ = 0;
    for (uint32_t j = 0U; j < outputFromContextSize; ++j) {
        const auto &itemOutput = outputFromContext.at(j);
        uint64_t dataAddr = itemOutput.address();
        uint64_t size = itemOutput.size();
        baseDumpData_.mutable_output(j)->set_address(dataAddr);
        baseDumpData_.mutable_output(j)->set_size(size);
        outputsBaseAddr_[j] = dataAddr;
        outputSize_[j] = size;
        outputTotalSize_ += size;
        aicpusd_info("size[%llu]", size);
    }
    aicpusd_info("PreProcessFFTSPLUSInputAndOutput inputTotalSize[%llu], outputTotalSize[%llu]",
        inputTotalSize_, outputTotalSize_);
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessOpMappingInfo(const aicpu::dump::Task &task,
                                               const std::string &basePath,
                                               const MappingInfoOptionalParam &param,
                                               const DumpStep &dumpStep,
                                               const DumpMode dumpMode,
                                               const bool isSingleOrUnknowShapeOp)
{
    aicpusd_info("Base path[%s], has model name[%d], model name[%s], has model id[%d], model id[%u].",
        basePath.c_str(), param.hasModelName, param.modelName.c_str(), param.hasModelId, param.modelId);
    const std::lock_guard<std::mutex> queLock(dumpMtx_);
    baseDumpPath_ = basePath;
    optionalParam_ = param;
    dumpStep_ = dumpStep;
    isSingleOrUnknowShapeOp_ = isSingleOrUnknowShapeOp;
    // single op no task id and stream id
    taskInfo_.taskId_ = task.task_id();
    taskInfo_.streamId_ = task.stream_id();
    taskInfo_.contextId_ = task.context_id();
    taskType_  =  task.tasktype();
    endGraph_ = task.end_graph();

    ::toolkit::dumpdata::DumpData dumpData;
    // version 2.0
    dumpData.set_version("2.0");

    const auto &attrsFromMapInfo = task.attr();
    for (int64_t i = 0; i < attrsFromMapInfo.size(); ++i) {
        const auto &item = attrsFromMapInfo.at(i);
        ::toolkit::dumpdata::OpAttr * const OpAttr = dumpData.add_attr();
        if (OpAttr == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add attr elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        OpAttr->set_name(item.name());
        OpAttr->set_value(item.value());
    }
    StatusCode ret = PreProcessInput(task, dumpData);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = PreProcessOutput(task, dumpData);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = PreProcessOpBuffer(task, dumpData);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = PreProcessWorkspace(task, dumpData);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    dumpMode_ = dumpMode;
    opName_ = task.op().op_name();
    opType_ = task.op().op_type();
    dumpData.set_op_name(opName_);
    aicpusd_info("[stream id:%u, task id:%u, context id:%u] op name[%s], op type[%s]",
        taskInfo_.streamId_, taskInfo_.taskId_, taskInfo_.contextId_, opName_.c_str(), opType_.c_str());
    baseDumpData_ = std::move(dumpData);
    taskDumpNum_ = 0U;
    return AICPU_SCHEDULE_OK;
}

void OpDumpTask::GetInputDataAddr(uint64_t &dataAddr, const int32_t i)
{
    const uint64_t baseAddr = inputsBaseAddr_.at(static_cast<size_t>(i));
    dataAddr = baseAddr;
    if (!isSingleOrUnknowShapeOp_) {
        if (baseAddr == 0U) {
            aicpusd_info("op name[%s], input[%d] base addr is null", opName_.c_str(), i);
            return;
        }
        const int32_t addrType = inputsAddrType_.at(static_cast<size_t>(i));
        aicpusd_info("op name[%s], input[%d], Type[%u]", opName_.c_str(), i, addrType);
        // baseAddr is a pointer point to data addr
        if (addrType != aicpu::dump::RAW_ADDR) {
            dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(baseAddr)));
            if (addrType == aicpu::dump::NOTILING_ADDR) {
                aicpusd_info("op name[%s], dump in notiling mode, input[%d]", opName_.c_str(), i);
                dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(dataAddr)));
            }
        }
    }
    aicpusd_info("op name[%s], input[%d], Type[%u]", opName_.c_str(), i, inputsAddrType_.at(static_cast<size_t>(i)));

    return;
}
StatusCode OpDumpTask::ProcessInputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                        const std::string &path,
                                        const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int64_t i = 0; i < dumpData.input_size(); ++i) {
        auto &input = dumpData.input(i);
        uint64_t len = input.size();
        if (len == 0U) {
            aicpusd_warn("op name[%s], input[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        uint64_t dataAddr = input.address();
        aicpusd_info("op name[%s], input[%d], size[%llu]", opName_.c_str(), i, len);
        if (dataAddr == 0U) {
            aicpusd_warn("op name[%s], input[%d] src is zero", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;

        while (innerOffset < len) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, len - innerOffset);
            const uint64_t srcAddr = dataAddr + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for input[%d]," \
                         " srcSize[%llu], innerOffset[%llu], offset[%llu], dstSize[%llu]",
                         opName_.c_str(), i, actSize, innerOffset, offset_, emptyBufferSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          ValueToPtr(srcAddr),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], input[%d] memcpy failed, dstSize[%llu], srcSize[%llu]",
                            opName_.c_str(), i, emptyBufferSize, actSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for input[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            bool isLastSilce = (dumpedSize == inputTotalSize_) &&
                (outputTotalSize_ == 0U) &&
                (opBufferTotalSize_ == 0U) && (opWorkspaceTotalSize_ == 0U);
            if ((offset_ >= buffSize_) || isLastSilce) {
                const StatusCode ret = Dump(path, buff_.get(), offset_, ideSession, isLastSilce);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("op name[%s], dump input failed", opName_.c_str());
                    return ret;
                }
                offset_ = 0U;
            }
        }
        aicpusd_info("op name[%s], process input[%d] data dump success.", opName_.c_str(), i);
    }
    return AICPU_SCHEDULE_OK;
}

void OpDumpTask::GetOutputDataAddr(uint64_t &dataAddr, const int32_t i)
{
    const uint64_t baseAddr = outputsBaseAddr_.at(static_cast<size_t>(i));
    dataAddr = baseAddr;
    if (!isSingleOrUnknowShapeOp_) {
        if (baseAddr == 0U) {
            aicpusd_info("op name[%s], output[%d] base addr is null.", opName_.c_str(), i);
            return;
        }
        const int32_t addrType = outputsAddrType_.at(static_cast<size_t>(i));
        aicpusd_info("op name[%s], output[%d], Type[%u]", opName_.c_str(), i, addrType);
        // baseAddr is a pointer point to data addr
        if (addrType != aicpu::dump::RAW_ADDR) {
            dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(baseAddr)));
            if (addrType == aicpu::dump::NOTILING_ADDR) {
                aicpusd_info("op name[%s], dump in notiling mode, output[%d]", opName_.c_str(), i);
                dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(dataAddr)));
            }
        }
    }
    aicpusd_info("op name[%s], output[%d], Type[%u]", opName_.c_str(), i, outputsAddrType_.at(static_cast<size_t>(i)));
    return;
}

StatusCode OpDumpTask::ProcessOutputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                         const std::string &path,
                                         const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int64_t i = 0; i < dumpData.output_size(); ++i) {
        auto &output = dumpData.output(i);
        uint64_t len = output.size();
        if (len == 0U) {
            aicpusd_warn("op name[%s], output[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        uint64_t dataAddr = output.address();
        aicpusd_info("op name[%s], output[%d] size[%llu].", opName_.c_str(), i, len);
        if (dataAddr == 0U) {
            aicpusd_warn("op name[%s], output[%d] addr is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < len) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, len - innerOffset);
            const uint64_t srcAddr = dataAddr + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for output[%d]," \
                         " srcSize[%llu], innerOffset[%llu], offset[%llu], dstSize[%llu]",
                         opName_.c_str(), i, actSize, innerOffset, offset_, emptyBufferSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          PtrToPtr<const void, const char_t>(ValueToPtr(srcAddr)),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], output[%d] memcpy failed, dstSize[%llu], srcSize[%llu]",
                            opName_.c_str(), i, emptyBufferSize, actSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for output[%d],"
                         " srcSize[%llu], dstSize[%llu]", opName_.c_str(), i, actSize, emptyBufferSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            bool isLastSilce = (dumpedSize == outputTotalSize_) &&
                (opBufferTotalSize_ == 0U) && (opWorkspaceTotalSize_ == 0U);
            if ((offset_ >= buffSize_) || isLastSilce) {
                const StatusCode ret = Dump(path, buff_.get(), offset_, ideSession, isLastSilce);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("op name[%s], dump output failed", opName_.c_str());
                    return ret;
                }
                offset_ = 0U;
            }
        }

        aicpusd_info("op name[%s], process output[%d] data dump success.", opName_.c_str(), i);
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::ProcessOpBufferDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                           const std::string &path,
                                           const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int64_t i = 0; i < dumpData.buffer_size(); ++i) {
        auto &buffer = dumpData.buffer(i);
        if (buffer.size() == 0U) {
            aicpusd_warn("op name[%s], op buffer[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        const size_t opBufferAddrIndex = static_cast<size_t>(i);
        if (opBufferAddr_[opBufferAddrIndex] == 0U) {
            aicpusd_warn("op name[%s], op buffer[%d] addr is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < buffer.size()) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, buffer.size() - innerOffset);
            const uint64_t srcAddr = opBufferAddr_[opBufferAddrIndex] + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for op buffer[%d],"
                         " srcSize[%llu], dstSize[%llu]", opName_.c_str(), i, actSize, emptyBufferSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          ValueToPtr(srcAddr),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], op buffer[%d] memcpy failed, srcSize[%llu], dstSize[%llu]",
                            opName_.c_str(), i, actSize, emptyBufferSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for op buffer[%d],"
                         " srcSize[%llu], dstSize[%llu]", opName_.c_str(), i, actSize, emptyBufferSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            const bool isLastSilce = (dumpedSize == opBufferTotalSize_) && (opWorkspaceTotalSize_ == 0U);
            if ((offset_ >= buffSize_) || isLastSilce) {
                const StatusCode ret = Dump(path, buff_.get(), offset_, ideSession, isLastSilce);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("op name[%s], dump op buffer failed", opName_.c_str());
                    return ret;
                }
                offset_ = 0U;
            }
        }
        aicpusd_info("op name[%s], process op buffer[%d] data success.", opName_.c_str(), i);
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::ProcessOpWorkspaceDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                              const std::string &path,
                                              const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int64_t i = 0; i < dumpData.space_size(); ++i) {
        auto &space = dumpData.space(i);
        if (space.size() == 0U) {
            aicpusd_err("op name[%s], op space[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        const size_t opWorkspaceAddrIndex = static_cast<size_t>(i);
        if (opWorkspaceAddr_[opWorkspaceAddrIndex] == 0U) {
            aicpusd_err("op name[%s], op space[%d] workspace is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < space.size()) {
            const uint64_t emptyWorkspaceSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyWorkspaceSize, space.size() - innerOffset);
            const uint64_t srcAddr = opWorkspaceAddr_[opWorkspaceAddrIndex] + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for spaceIndex[%d]," \
                         " srcSize[%llu], innerOffset[%llu], offset[%llu], dstSize[%llu]",
                         opName_.c_str(), i, actSize, innerOffset, offset_, emptyWorkspaceSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyWorkspaceSize,
                                          PtrToPtr<void, char_t>(ValueToPtr(srcAddr)),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], op spaceIndex[%d] memcpy failed, dstSize[%llu], srcSize[%llu]",
                            opName_.c_str(), i, emptyWorkspaceSize, actSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], op spaceIndex[%d] end copy, dstSize[%llu], srcSize[%llu]",
                         opName_.c_str(), i, emptyWorkspaceSize, actSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            const bool isLastSilce = (dumpedSize == opWorkspaceTotalSize_);
            if ((offset_ >= buffSize_) || isLastSilce) {
                const StatusCode ret = Dump(path, buff_.get(), offset_, ideSession, isLastSilce);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("op name[%s], dump op space failed", opName_.c_str());
                    return ret;
                }
                offset_ = 0U;
            }
        }
        aicpusd_info("op name[%s], process op space[%d] data success.", opName_.c_str(), i);
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::Dump(const std::string &path,
                            char_t * const data,
                            const uint64_t len,
                            const IDE_SESSION ideSession,
                            const bool isLastSlice) const
{
    if (ideSession != nullptr) {
        IdeDumpChunk ideDumpChunk = {};
        ideDumpChunk.fileName = const_cast<char_t *>(path.c_str());
        ideDumpChunk.dataBuf = reinterpret_cast<uint8_t *>(data);
        ideDumpChunk.bufLen = static_cast<uint32_t>(len);
        ideDumpChunk.isLastChunk = isLastSlice ? 1U : 0U;
        ideDumpChunk.offset = -1;  // append
        ideDumpChunk.flag = IDE_DUMP_NONE_FLAG;
        auto startTime = std::chrono::steady_clock::now();
        aicpusd_info("op name[%s], start to call IdeDumpData, size[%u], isLastChunk[%u]",
                     opName_.c_str(), len, ideDumpChunk.isLastChunk);
        const IdeErrorT ideState = IdeDumpData(ideSession, &ideDumpChunk);
        if (ideState != IDE_DAEMON_NONE_ERROR) {
            aicpusd_err("op name[%s], call IdeDumpData failed, size[%u].", opName_.c_str(), len);
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        auto endTime = std::chrono::steady_clock::now();
        double drUs = std::chrono::duration<double, std::micro>(endTime - startTime).count();
        double transmissionRate = ((len == 0LU) ? 0.0 : (drUs / len));
        aicpusd_info("op name[%s], end of call IdeDumpData, size[%lu], cost time is [%.2lf]us,"
            " transmission rate is [%.2lf]byte/us", opName_.c_str(), len, drUs, transmissionRate);
        UNUSED(transmissionRate);
    } else {
        aicpusd_err("op name[%s], ide session is null, size[%u].", opName_.c_str(), len);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::ProcessngNoTiliInput()
{
    if (isSingleOrUnknowShapeOp_) {
        return AICPU_SCHEDULE_OK;
    }

    for (int64_t inputDim = 0; inputDim < baseDumpData_.input_size(); ++inputDim) {
        auto input = baseDumpData_.mutable_input(inputDim);
        const uint64_t baseAddr = inputsBaseAddr_.at(static_cast<size_t>(inputDim));
        if (baseAddr == 0U) {
            aicpusd_info("op name[%s], input[%d] base addr is null", opName_.c_str(), inputDim);
            continue;
        }
        aicpusd_info("op name[%s], input[%d]", opName_.c_str(), inputDim);
        const int32_t addrType = inputsAddrType_.at(static_cast<size_t>(inputDim));
        if (addrType == aicpu::dump::NOTILING_ADDR) {
            // baseAddr is a pointer point to data addr
            const uint64_t dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(baseAddr)));
            aicpusd_info("op name[%s], dump in notiling mode, input[%d]", opName_.c_str(), inputDim);
            const RuntimeTensorDesc *tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(ValueToPtr(dataAddr));
            uint64_t dataNum = 1UL;
            const size_t dimSize = static_cast<size_t>(tensorDesc->shape[0]);
            if (dimSize > static_cast<size_t>(MAX_DIM_SIZE)) {
                aicpusd_err("op name[%s], tensor desc shape dim size[%zu] must be < %lld",
                    opName_.c_str(), dimSize, MAX_DIM_SIZE);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            std::vector<uint64_t> inputshape;
            std::vector<uint64_t> inputOriginShape;
            auto inputShape = input->mutable_shape();
            for (size_t i = 0UL; i < dimSize; ++i) {
                inputShape->add_dim(static_cast<uint64_t>(tensorDesc->shape[i + 1UL]));
                dataNum *= static_cast<uint64_t>(tensorDesc->shape[i + 1UL]);
                inputshape.push_back(static_cast<uint64_t>(tensorDesc->shape[i + 1UL]));
                aicpusd_info("op name[%s], dump input shape[%zu] value[%lld]",
                    opName_.c_str(), i, tensorDesc->shape[i + 1UL]);
            }
            auto inputOriginalShape = input->mutable_original_shape();
            const size_t originalDimSize = static_cast<size_t>(tensorDesc->originalShape[0]);
            for (size_t i = 0UL; i < originalDimSize; ++i) {
                inputOriginalShape->add_dim(static_cast<uint64_t>(tensorDesc->originalShape[i + 1UL]));
                inputOriginShape.push_back(static_cast<uint64_t>(tensorDesc->originalShape[i + 1UL]));
            }
            const int32_t dataType = ge::GetSizeByDataType(static_cast<ge::DataType>(tensorDesc->dtype));
            if (dataType < 0) {
                aicpusd_err("op name[%s], tensor data dataType[%d] must be > 0", opName_.c_str(), dataType);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            if (static_cast<uint64_t>(dataType) > (UINT64_MAX / dataNum)) {
                aicpusd_err("op name[%s], tensor data dataType[%d] * dataNum[%u] is overflow",
                    opName_.c_str(), dataType, dataNum);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            const uint64_t size = static_cast<uint64_t>(dataType) * dataNum;
            input->set_size(size);
            inputTotalSize_ += size;
            inputsShape_.push_back(inputshape);
            inputsOriginShape_.push_back(inputOriginShape);
            aicpusd_info("op name[%s], dump input size[%llu], type[%lld]", opName_.c_str(), size, tensorDesc->dtype);
        }
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::ProcessngNoTiliOutput()
{
    if (isSingleOrUnknowShapeOp_) {
        return AICPU_SCHEDULE_OK;
    }
    for (int64_t outputDim = 0; outputDim < baseDumpData_.output_size(); ++outputDim) {
        auto output = baseDumpData_.mutable_output(outputDim);
        const uint64_t baseAddr = outputsBaseAddr_.at(static_cast<size_t>(outputDim));
        if (baseAddr == 0U) {
            aicpusd_info("op name[%s], output[%d] base addr is null.", opName_.c_str(), outputDim);
            continue;
        }
        aicpusd_info("op name[%s], output[%d] base is %llu.", opName_.c_str(), outputDim, baseAddr);
        const int32_t addrType = outputsAddrType_.at(static_cast<size_t>(outputDim));
        if (addrType == aicpu::dump::NOTILING_ADDR) {
            // baseAddr is a pointer point to data addr
            const uint64_t dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(baseAddr)));
            aicpusd_info("op name[%s], dump in notiling mode, output[%d]", opName_.c_str(), outputDim);
            const RuntimeTensorDesc *tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(ValueToPtr(dataAddr));
            uint64_t dataNum = 1UL;
            const size_t dimSize = static_cast<size_t>(tensorDesc->shape[0]);
            if (dimSize > static_cast<size_t>(MAX_DIM_SIZE)) {
                aicpusd_err("op name[%s], tensor desc shape dim size[%zu] must be < %lld",
                    opName_.c_str(), dimSize, MAX_DIM_SIZE);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            auto outShape = output->mutable_shape();
            outShape->Clear();
            std::vector<uint64_t> outputShape;
            std::vector<uint64_t> outputOriginShape;
            for (size_t i = 0UL; i < dimSize; ++i) {
                outShape->add_dim(static_cast<uint64_t>(tensorDesc->shape[i + 1UL]));
                dataNum *= static_cast<uint64_t>(tensorDesc->shape[i + 1UL]);
                outputShape.push_back(static_cast<uint64_t>(tensorDesc->shape[i + 1UL]));
                aicpusd_info("op name[%s], dump output shape[%zu] value[%lld]",
                    opName_.c_str(), i, tensorDesc->shape[i + 1UL]);
            }
            auto outOriginalShape = output->mutable_original_shape();
            outOriginalShape->Clear();
            const size_t originalDimSize = static_cast<size_t>(tensorDesc->originalShape[0]);
            for (size_t i = 0UL; i < originalDimSize; ++i) {
                outOriginalShape->add_dim(static_cast<uint64_t>(tensorDesc->originalShape[i + 1UL]));
                outputOriginShape.push_back(static_cast<uint64_t>(tensorDesc->originalShape[i + 1UL]));
            }
            const int32_t dataType = ge::GetSizeByDataType(static_cast<ge::DataType>(tensorDesc->dtype));
            if (dataType < 0) {
                aicpusd_err("op name[%s], tensor data type[%d] must be > 0", opName_.c_str(), dataType);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            if (static_cast<uint64_t>(dataType) > (UINT64_MAX / dataNum)) {
                aicpusd_err("op name[%s], tensor data dataType[%d] * dataNum[%lu] is overflow",
                    opName_.c_str(), dataType, dataNum);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            const auto size = static_cast<uint64_t>(dataType) * dataNum;
            output->set_size(size);
            outputTotalSize_ += size;
            outputsShape_.push_back(outputShape);
            outputsOriginShape_.push_back(outputOriginShape);
            aicpusd_info("op name[%s], dump output size[%llu], type[%lld]", opName_.c_str(), size, tensorDesc->dtype);
        }
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::DumpOpInfo(const uint32_t streamId, const uint32_t taskId)
{
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = INVALID_VAL;
    dumpTaskInfo.taskId_ = INVALID_VAL;
    dumpTaskInfo.contextId_ = INVALID_VAL;
    dumpTaskInfo.threadId_ = INVALID_VAL;
    DumpFileName dumpFileName(streamId, taskId);
    return DumpOpInfo(dumpTaskInfo, dumpFileName);
}

StatusCode OpDumpTask::ProcessDumpOpInfo(const TaskInfoExt &dumpTaskInfo, const std::string &dumpFilePath)
{
    aicpusd_info("Begin to process op dump task. dumpMode=%d, threadId=%u", static_cast<int32_t>(dumpMode_), dumpTaskInfo.threadId_);

    auto dumpRet = AICPU_SCHEDULE_OK;
    switch (dumpMode_) {
        case DumpMode::TENSOR_DUMP_DATA:
            dumpRet = ProcessDumpTensor(dumpFilePath);
            break;
        case DumpMode::STATS_DUMP_DATA:
            dumpRet = ProcessDumpStatistic(dumpTaskInfo, dumpFilePath);
            break;
        default:
            aicpusd_err("Fail to dump for dump mode is unknown, DumpMode=%d", static_cast<int32_t>(dumpMode_));
            dumpRet = AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            break;
    }

    if (dumpRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("Dump failed. ret=%d, dumpMode=%d, threadId=%u, dumpFilePath=%s",
                    static_cast<int32_t>(dumpRet), static_cast<int32_t>(dumpMode_), dumpTaskInfo.threadId_, dumpFilePath.c_str());
    }

    return dumpRet;
}

StatusCode OpDumpTask::DumpOpInfo(const TaskInfoExt &dumpTaskInfo, const DumpFileName &dumpFileName)
{
    const std::lock_guard<std::mutex> queLock(dumpMtx_);
    uint64_t dumpNumber = 0U;
    if (GetDumpNumber(dumpNumber) != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }

    if (ProcessngNoTiliInput() != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }

    if (ProcessngNoTiliOutput() != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }

    if (!NeedDump(dumpNumber)) {
        return AICPU_SCHEDULE_OK;
    }
    // if need dump, set MODEL_TIMEOUT to false
    AicpuMonitor::GetInstance().DisableModelTimeout();

    const uint64_t nowTime = GetCurrentTime();
    baseDumpData_.set_dump_time(nowTime);
    UpdateDumpData();

    if ((baseDumpData_.ByteSizeLong() > static_cast<uint64_t>(INT_MAX)) || (baseDumpData_.ByteSizeLong() == 0U)) {
        aicpusd_err("op name[%s], dump data size[%zuB] should be in [1B, 2GB)].",
            opName_.c_str(), baseDumpData_.ByteSizeLong());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpusd_info("op name[%s], proto buffer total bytes[%llu]", opName_.c_str(), baseDumpData_.ByteSizeLong());

    // dump file path name
    const std::string dumpFilePath = DumpPath(nowTime, dumpNumber, dumpFileName);

    return ProcessDumpOpInfo(dumpTaskInfo, dumpFilePath);
}

void OpDumpTask::UpdateDumpData()
{
    for (int64_t i = 0; i < baseDumpData_.input_size(); ++i) {
        uint64_t dataAddr = 0U;
        GetInputDataAddr(dataAddr, i);
        baseDumpData_.mutable_input(i)->set_address(dataAddr);
    }
    for (int64_t i = 0; i < baseDumpData_.output_size(); ++i) {
        uint64_t dataAddr = 0U;
        GetOutputDataAddr(dataAddr, i);
        baseDumpData_.mutable_output(i)->set_address(dataAddr);
    }
}

StatusCode OpDumpTask::ProcessDumpTensor(const std::string &dumpFilePath)
{
    buffSize_ = baseDumpData_.ByteSizeLong() + sizeof(uint64_t) +
                inputTotalSize_ + outputTotalSize_ + opBufferTotalSize_ + opWorkspaceTotalSize_;

    buffSize_ = std::min(buffSize_, DUMP_SLICE_SIZE);
    buffSize_ = std::max(buffSize_, baseDumpData_.ByteSizeLong() + sizeof(uint64_t));
    buff_.reset(new (std::nothrow) char_t[buffSize_]);
    if (buff_ == nullptr) {
        aicpusd_err("op name[%s], malloc buffer for data dump failed, size[%llu]", opName_.c_str(), buffSize_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    // for memory statistic
    aicpusd_memory_log("op name[%s], MallocMemory, func=new, size=%llu, purpose=data dump buffer",
                       opName_.c_str(), buffSize_);
    uint64_t * const sizePtr = PtrToPtr<char_t, uint64_t>(buff_.get());
    *sizePtr = baseDumpData_.ByteSizeLong();
    offset_ = sizeof(uint64_t);
    if (!baseDumpData_.SerializeToArray(buff_.get() + sizeof(uint64_t),
        static_cast<int32_t>(baseDumpData_.ByteSizeLong()))) {
        aicpusd_err("op name[%s], serialize dump data to string failed, data size[%zuB].",
            opName_.c_str(), baseDumpData_.ByteSizeLong());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    offset_ += baseDumpData_.ByteSizeLong();

    return DoDumpTensor(dumpFilePath);
}

StatusCode OpDumpTask::DoDumpTensor(const std::string &dumpFilePath)
{
    // the port is not used in ide module, just for privateInfo format check
    const std::string privateInfo = "127.0.0.1:22118;" + std::to_string(deviceId_) + ";" + std::to_string(hostPid_);
    aicpusd_info("op name[%s], ide dump start private info[%s]", opName_.c_str(), privateInfo.c_str());
    const IDE_SESSION ideSession = IdeDumpStart(privateInfo.c_str());
    if (ideSession == nullptr) {
        aicpusd_err("op name[%s], call IdeDumpStart failed, path[%s].", opName_.c_str(), dumpFilePath.c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const ScopeGuard ideSessGuard([&ideSession]() {
            IdeDumpEnd(ideSession);
        });
    StatusCode ret = AICPU_SCHEDULE_OK;
    if (offset_ == buffSize_) {
        ret = Dump(dumpFilePath, buff_.get(), buffSize_, ideSession, false);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("op name[%s], dump proto failed, path[%s].", opName_.c_str(), dumpFilePath.c_str());
            return ret;
        }
        offset_ = 0U;
    }
    ret = ProcessInputDump(baseDumpData_, dumpFilePath, ideSession);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = ProcessOutputDump(baseDumpData_, dumpFilePath, ideSession);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = ProcessOpBufferDump(baseDumpData_, dumpFilePath, ideSession);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = ProcessOpWorkspaceDump(baseDumpData_, dumpFilePath, ideSession);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    // in case of nothting has been dumped, we should dump dump_data's head
    if (offset_ != 0U) {
        const StatusCode ret = Dump(dumpFilePath, buff_.get(), offset_, ideSession, true);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("op name[%s], dump output failed", opName_.c_str());
            return ret;
        }
        offset_ = 0U;
    }
    // release buffer
    buff_.reset(nullptr);

    uint64_t fileSize = baseDumpData_.ByteSizeLong() + sizeof(uint64_t) +
        inputTotalSize_ + outputTotalSize_ + opBufferTotalSize_ + opWorkspaceTotalSize_;
    aicpusd_info("op name[%s], dump data success, path[%s], data size[%llu]",
        opName_.c_str(), dumpFilePath.c_str(), fileSize);
    UNUSED(fileSize);
    return AICPU_SCHEDULE_OK;
}

std::string OpDumpTask::GetDataFormatStr(::toolkit::dumpdata::OutputFormat dataFormat) const
{
    static const std::map<::toolkit::dumpdata::OutputFormat, std::string> dataFormatMap = {
        {::toolkit::dumpdata::OutputFormat::FORMAT_NCHW, "NCHW"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NHWC, "NHWC"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_ND, "ND"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NC1HWC0, "NC1HWC0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_Z, "FRACTAL_Z"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NC1C0HWPAD, "NC1C0HWPAD"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NHWC1C0, "NHWC1C0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FSR_NCHW, "FSR_NCHW"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_DECONV, "FRACTAL_DECONV"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_C1HWNC0, "C1HWNC0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_DECONV_TRANSPOSE, "FRACTAL_DECONV_TRANSPOSE"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_DECONV_SP_STRIDE_TRANS, "FRACTAL_DECONV_SP_STRIDE_TRANS"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NC1HWC0_C04, "NC1HWC0_C04"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_Z_C04, "FRACTAL_Z_C04"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_CHWN, "CHWN"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_DECONV_SP_STRIDE8_TRANS, "FRACTAL_DECONV_SP_STRIDE8_TRANS"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HWCN, "HWCN"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NC1KHKWHWC0, "NC1KHKWHWC0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_BN_WEIGHT, "BN_WEIGHT"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FILTER_HWCK, "FILTER_HWCK"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HASHTABLE_LOOKUP_LOOKUPS, "HASHTABLE_LOOKUP_LOOKUPS"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HASHTABLE_LOOKUP_KEYS, "HASHTABLE_LOOKUP_KEYS"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HASHTABLE_LOOKUP_VALUE, "HASHTABLE_LOOKUP_VALUE"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HASHTABLE_LOOKUP_OUTPUT, "HASHTABLE_LOOKUP_OUTPUT"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_HASHTABLE_LOOKUP_HITS, "HASHTABLE_LOOKUP_HITS"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_C1HWNCoC0, "C1HWNCoC0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_MD, "MD"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NDHWC, "NDHWC"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_ZZ, "FRACTAL_ZZ"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_NZ, "FRACTAL_NZ"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NCDHW, "NCDHW"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_DHWCN, "DHWCN"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NDC1HWC0, "NDC1HWC0"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_Z_3D, "FRACTAL_Z_3D"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_CN, "CN"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_NC, "NC"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_DHWNC, "DHWNC"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_Z_3D_TRANSPOSE, "FRACTAL_Z_3D_TRANSPOSE"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_ZN_LSTM, "FRACTAL_ZN_LSTM"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_FRACTAL_Z_G, "FRACTAL_Z_G"},
        {::toolkit::dumpdata::OutputFormat::FORMAT_RESERVED, "RESERVED"}
    };

    const auto iter = dataFormatMap.find(dataFormat);
    if (iter == dataFormatMap.end()) {
        return "-";
    }

    return iter->second;
}

std::string OpDumpTask::GetDataTypeStr(::toolkit::dumpdata::OutputDataType dataType) const
{
    static const std::map<::toolkit::dumpdata::OutputDataType, std::string> dataTypeMap = {
        {::toolkit::dumpdata::OutputDataType::DT_UNDEFINED, "DT_UNDEFINED"},
        {::toolkit::dumpdata::OutputDataType::DT_FLOAT, "DT_FLOAT"},
        {::toolkit::dumpdata::OutputDataType::DT_FLOAT16, "DT_FLOAT16"},
        {::toolkit::dumpdata::OutputDataType::DT_INT8, "DT_INT8"},
        {::toolkit::dumpdata::OutputDataType::DT_UINT8, "DT_UINT8"},
        {::toolkit::dumpdata::OutputDataType::DT_INT16, "DT_INT16"},
        {::toolkit::dumpdata::OutputDataType::DT_UINT16, "DT_UINT16"},
        {::toolkit::dumpdata::OutputDataType::DT_INT32, "DT_INT32"},
        {::toolkit::dumpdata::OutputDataType::DT_INT64, "DT_INT64"},
        {::toolkit::dumpdata::OutputDataType::DT_UINT32, "DT_UINT32"},
        {::toolkit::dumpdata::OutputDataType::DT_UINT64, "DT_UINT64"},
        {::toolkit::dumpdata::OutputDataType::DT_BOOL, "DT_BOOL"},
        {::toolkit::dumpdata::OutputDataType::DT_DOUBLE, "DT_DOUBLE"},
        {::toolkit::dumpdata::OutputDataType::DT_STRING, "DT_STRING"},
        {::toolkit::dumpdata::OutputDataType::DT_DUAL_SUB_INT8, "DT_DUAL_SUB_INT8"},
        {::toolkit::dumpdata::OutputDataType::DT_DUAL_SUB_UINT8, "DT_DUAL_SUB_UINT8"},
        {::toolkit::dumpdata::OutputDataType::DT_COMPLEX64, "DT_COMPLEX64"},
        {::toolkit::dumpdata::OutputDataType::DT_COMPLEX128, "DT_COMPLEX128"},
        {::toolkit::dumpdata::OutputDataType::DT_QINT8, "DT_QINT8"},
        {::toolkit::dumpdata::OutputDataType::DT_QINT16, "DT_QINT16"},
        {::toolkit::dumpdata::OutputDataType::DT_QINT32, "DT_QINT32"},
        {::toolkit::dumpdata::OutputDataType::DT_QUINT8, "DT_QUINT8"},
        {::toolkit::dumpdata::OutputDataType::DT_QUINT16, "DT_QUINT16"},
        {::toolkit::dumpdata::OutputDataType::DT_RESOURCE, "DT_RESOURCE"},
        {::toolkit::dumpdata::OutputDataType::DT_STRING_REF, "DT_STRING_REF"},
        {::toolkit::dumpdata::OutputDataType::DT_DUAL, "DT_DUAL"}
    };

    const auto iter = dataTypeMap.find(dataType);
    if (iter == dataTypeMap.end()) {
        return "-";
    }

    return iter->second;
}

std::string OpDumpTask::GenerateDataStatsInfo(uint64_t dataAddr, uint64_t dataSize,
                                              ::toolkit::dumpdata::OutputDataType dataType) const
{
    if (dataAddr == 0LU) {
        aicpusd_warn("dataSize[%lu], dataAddr is zero", dataSize);
        return ",,,,,,";
    }
    switch (dataType) {
        case ::toolkit::dumpdata::OutputDataType::DT_FLOAT: {
            NormalDataStats<float> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_FLOAT16: {
            EigenDataStats dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_UINT8: {
            Uint8DataStats dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_INT8: {
            Int8DataStats dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_INT16: {
            NormalDataStats<int16_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_UINT16: {
            NormalDataStats<uint16_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_INT32: {
            NormalDataStats<int32_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_INT64: {
            NormalDataStats<int64_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_UINT32: {
            NormalDataStats<uint32_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_UINT64: {
            NormalDataStats<uint64_t> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_BOOL: {
            NormalDataStats<bool> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        case ::toolkit::dumpdata::OutputDataType::DT_DOUBLE: {
            NormalDataStats<double> dumpStats(dataAddr, dataSize);
            return dumpStats.GetDataStatsStr();
        }
        default: {
            aicpusd_warn("Try to dump unsupported data type. dataType=%s[%d]", GetDataTypeStr(dataType).c_str(),
                static_cast<int32_t>(dataType));
            break;
        }
    }

    // If the data type is unsupported type, set all stats val to none
    return ",,,,,,";
}

std::string OpDumpTask::GenerateDataDimInfo(::toolkit::dumpdata::Shape dataShape) const
{
    const int32_t dimSize = dataShape.dim_size();
    if (dimSize <= 0) {
        return "-";
    }

    std::ostringstream oss;
    for (int32_t i = 0; i < dimSize - 1; ++i) {
        oss << dataShape.dim(i) << "x";
    }
    oss << dataShape.dim(dimSize - 1);

    return oss.str();
}

std::string OpDumpTask::ShapeDebugString(std::vector<uint64_t> shapeInfo) const
{
    const int32_t dimSize = shapeInfo.size();
    if (dimSize <= 0) {
        return "-";
    }

    std::ostringstream oss;
    for (int32_t i = 0; i < dimSize - 1; ++i) {
        oss << shapeInfo[i] << "x";
    }
    oss << shapeInfo[dimSize - 1];
    return oss.str();
}

bool OpDumpTask::CheckAndGetKfcDumpStatsAPI()
{
    // 假设当前该符号so已经打开，需要确认该符号已经打开
    if (kfcDumpFunc_ != nullptr) {
        return true;
    }
    kfcDumpFunc_ = PtrToFunctionPtr<void, AicpuKfcDumpFuncPtr>(dlsym(RTLD_DEFAULT, KFC_DUMP_KERNEL_NAME.c_str()));
    if (kfcDumpFunc_ == nullptr) {
        aicpusd_info("Kfc dump API not get.");
        return false;
    }
    aicpusd_info("Kfc dump API has get, no need get again.");
    return true;
}

bool OpDumpTask::IsSupportKfcDump()
{
    if (dumpMode_ != DumpMode::STATS_DUMP_DATA) {
        return false;
    }
    if (taskType_ == aicpu::dump::Task::FFTSPLUS) {
        aicpusd_info("Task is ffts plus, not support kfc statistical dump.");
        return false;
    }
    bool isHasKfcDumpFun = CheckAndGetKfcDumpStatsAPI();
    if (!isHasKfcDumpFun) {
        aicpusd_info("Not find kfc statistical dump api [%s] from kfc op.", KFC_DUMP_KERNEL_NAME.c_str());
        return false;
    }
    aicpusd_info("Get kfc dump statistical api.");
    return true;
}

StatusCode OpDumpTask::ProcessKfcDumpStats(KfcDumpTask &taskInfo, const std::string &dumpFilePath)
{
    dumpPath_ = dumpFilePath;
    if (kfcDumpFunc_ == nullptr) {
        aicpusd_err("Not get kfc statistical dump api [%s].", KFC_DUMP_KERNEL_NAME.c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    void *param = PtrToPtr<KfcDumpTask, void>(&taskInfo);
    static std::mutex mutexForKfcDumpFunc;
    const std::lock_guard<std::mutex> lk(mutexForKfcDumpFunc);
    int32_t ret = kfcDumpFunc_(param);
    if (ret != 0) {
        aicpusd_err("Kfc statistical dump [%s] ret = %d.", KFC_DUMP_KERNEL_NAME.c_str(), ret);
    }
    return ret;
}

StatusCode OpDumpTask::ProcessDumpStatistic(const TaskInfoExt &dumpTaskInfo, const std::string &dumpFilePath)
{
    if (!IsSupportKfcDump()) {
        return ProcessDumpStats(dumpFilePath);
    }
    KfcDumpTask taskInfo(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, dumpTaskInfo.indexId_);
    return ProcessKfcDumpStats(taskInfo, dumpFilePath);
}

StatusCode OpDumpTask::ProcessDumpStats(const std::string &dumpFilePath)
{
    std::ostringstream oss;
    oss << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,"
        << "Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n";

    for (int64_t i = 0; i < baseDumpData_.input_size(); ++i) {
        const auto input = baseDumpData_.input(i);
        aicpusd_info("Input[%u], data_type[%llu], size[%llu]", i, input.data_type(), input.size());
        oss << "Input," << i << "," << input.size() << ","<< GetDataTypeStr(input.data_type()) << ","
            << GetDataFormatStr(input.format()) << "," << GenerateDataDimInfo(input.shape())
            << "," << GenerateDataStatsInfo(input.address(), input.size(), input.data_type()) << "\n";
    }

    for (int64_t i = 0; i <  baseDumpData_.output_size(); ++i) {
        const auto output = baseDumpData_.output(i);
        aicpusd_info("output[%u], data_type[%llu], size[%llu]", i, output.data_type(), output.size());
        oss << "Output," << i << "," << output.size() << ","  << GetDataTypeStr(output.data_type()) << ","
            << GetDataFormatStr(output.format()) << "," << GenerateDataDimInfo(output.shape())
            << "," << GenerateDataStatsInfo(output.address(), output.size(), output.data_type()) << "\n";
    }

    const std::string statsFilePath = dumpFilePath + ".csv";
    return DoDumpStats(statsFilePath, oss.str());
}

StatusCode OpDumpTask::DoDumpStats(const std::string &dumpFilePath, const std::string &content)
{
    const std::string privateInfo = "127.0.0.1:22118;" + std::to_string(deviceId_) + ";" + std::to_string(hostPid_);
    aicpusd_info("op name[%s], ide dump start private info[%s]", opName_.c_str(), privateInfo.c_str());
    const IDE_SESSION ideSession = IdeDumpStart(privateInfo.c_str());
    if (ideSession == nullptr) {
        aicpusd_err("op name[%s], call IdeDumpStart failed, path[%s].", opName_.c_str(), dumpFilePath.c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const ScopeGuard ideSessGuard([&ideSession]() {
            IdeDumpEnd(ideSession);
    });

    return Dump(dumpFilePath, const_cast<char_t *>(content.c_str()), content.size(), ideSession, true);
}

void OpDumpTask::UpdateDumpNum()
{
    const std::lock_guard<std::mutex> queLock(dumpMtx_);
    taskDumpNum_++;
    aicpusd_info("op name[%s], dump number is updated, dump number[%llu].", opName_.c_str(), taskDumpNum_);
}

bool OpDumpTask::IsEndGraph() const
{
    return endGraph_;
}

bool OpDumpTask::GetModelId(uint32_t &modelId) const
{
    if (optionalParam_.hasModelId) {
        modelId = optionalParam_.modelId;
        return true;
    }
    return false;
}

std::string OpDumpTask::GetOpName() const
{
    return opName_;
}

bool OpDumpTask::NeedDump(const uint64_t step) const
{
    if (endGraph_) {
        aicpusd_run_info("op name[%s], end graph dump task.", opName_.c_str());
        return false;
    }
    if ((!optionalParam_.hasStepId) && (!dumpStep_.singleStep.empty() || !dumpStep_.intervalStep.empty())) {
        aicpusd_run_info("op name[%s], the stepid needs to be filtered, but no stepid addr.", opName_.c_str());
        return false;
    }
    bool stepNeedDump = false;
    if (dumpStep_.singleStep.empty() && dumpStep_.intervalStep.empty()) {
        stepNeedDump = true;
    }
    if (dumpStep_.singleStep.find(step) != dumpStep_.singleStep.end()) {
        stepNeedDump = true;
    }
    for (const auto item : dumpStep_.intervalStep) {
        if ((step >= item.start) && (step <= item.end)) {
            stepNeedDump = true;
            break;
        }
    }
    if (!stepNeedDump) {
        aicpusd_run_info("op name[%s], the step[%llu] is not in dump list %s.",
            opName_.c_str(), step, dumpStep_.DebugString().c_str());
        return false;
    }

    if ((inputTotalSize_ == 0U) &&
        (outputTotalSize_ == 0U) &&
        (opBufferTotalSize_ == 0U) && (opWorkspaceTotalSize_ == 0U)) {
        aicpusd_run_info("op name[%s], no data need to dump.", opName_.c_str());
        return false;
    }

    return true;
}

std::string OpDumpTask::DumpPath(const uint64_t nowTime, const uint64_t dumpNumber,
                                 const DumpFileName &dumpFileName,
                                 const bool debugFlag)
{
    const uint32_t streamId = dumpFileName.streamId_;
    const uint32_t taskId = dumpFileName.taskId_;
    const uint32_t contextId = dumpFileName.contextId_;
    const uint32_t threadId = dumpFileName.threadId_;
    std::ostringstream oss;
    const uint32_t deviceId = deviceId_;
    oss << baseDumpPath_;
    if (optionalParam_.hasModelName) {
        oss << "/" << optionalParam_.modelName;
    }
    if (optionalParam_.hasModelId) {
        oss << "/" << optionalParam_.modelId;
    }
    // single op dump
    if (optionalParam_.hasStepId) {
        oss << "/" << dumpNumber;
    }

    std::string opName = opName_;
    std::string opType = opType_;
    ReplaceStringElem(opName);
    ReplaceStringElem(opType);
    if (debugFlag) {
        opName += "Debug";
    }
    oss << "/" << opType << "." << opName << "." << taskId << "." << streamId << "." << nowTime;
    if ((contextId != INVALID_VAL) && (threadId != INVALID_VAL)) {
        oss << "." << aicpu::dump::Task::FFTSPLUS << "." << contextId << "." << threadId << "." << deviceId;
    }

    return oss.str();
}

void OpDumpTask::ClearBaseDumpData()
{
    baseDumpData_.Clear();
    return;
}

std::string DumpStep::DebugString() const
{
    std::ostringstream oss;
    for (const auto step : singleStep) {
        oss << "[" << step << "] ";
    }
    for (const auto step : intervalStep) {
        oss << "[" << step.start << ", " << step.end << "] ";
    }

    return oss.str();
}

template <typename T>
DataStats<T>::~DataStats() {}

template <typename T>
void DataStats<T>::Stats()
{
    ResetStats();
    maxValue_ = minValue_ = data_[0];
    for (uint64_t i = 0UL; i < count_; ++i) {
        T ele = data_[i];
        if (IsNan(ele)) {
            ++nanCount_;
        }

        if (ele > maxValue_) {
            maxValue_ = ele;
        }
        if (ele < minValue_) {
            minValue_ = ele;
        }

        if (IsInf(ele)) {
            if (ele > static_cast<T>(0)) {
                ++posInfCount_;
            } else {
                ++negInfCount_;
            }
        }

        UpdateAvgValue(ele, i);
    }
    AdjustAvgValue();

    return;
}
/*
 * 组装kfc需要的dump信息
 */
void OpDumpTask::GetKfcDumpInfo(std::shared_ptr<KfcDumpInfo> dumpInfo)
{
    // dumpInfo指针为空校验在调用者保证
    dumpInfo->opName = opName_;
    dumpInfo->opType = opType_;
    aicpusd_info("Dump op info for kfc op : opName[%s], opType[%s].", dumpInfo->opName.c_str(), dumpInfo->opType.c_str());
    for (size_t i = 0; i < opWorkspaceAddr_.size(); i++) {
        dumpInfo->workspace.push_back({LOG, opWorkspaceAddr_[i], opWorkspaceSize_[i]});
        aicpusd_info("Dump op info for kfc op: opWorkspaceAddr[%lu] size[%lu].", dumpInfo->workspace[i].data_addr, dumpInfo->workspace[i].size);
    }
    for (size_t i = 0; i < inputsBaseAddr_.size(); i++) {
        InputOutputKfcDumpInfo inputKfcDumpInfo;
        inputKfcDumpInfo.index = i;
        inputKfcDumpInfo.data_type = inputsDataType_[i];
        inputKfcDumpInfo.format = inputsFormat_[i];
        inputKfcDumpInfo.address = baseDumpData_.mutable_input(i)->address();
        inputKfcDumpInfo.size = inputsSize_[i];
        inputKfcDumpInfo.shape = inputsShape_[i];
        inputKfcDumpInfo.origin_shape = inputsOriginShape_[i];
        dumpInfo->inputDumpInfo.push_back(inputKfcDumpInfo);
        aicpusd_info("Dump input info for kfc op: index[%d], data_type[%d], format[%d], address[%ld], size[%ld], shape[%s], origin_shape[%s]",
                     dumpInfo->inputDumpInfo[i].index,
                     dumpInfo->inputDumpInfo[i].data_type,
                     dumpInfo->inputDumpInfo[i].format,
                     dumpInfo->inputDumpInfo[i].address,
                     dumpInfo->inputDumpInfo[i].size,
                     ShapeDebugString(dumpInfo->inputDumpInfo[i].shape).c_str(), ShapeDebugString(dumpInfo->inputDumpInfo[i].origin_shape).c_str());
    }
    for (size_t i = 0; i < outputsBaseAddr_.size(); i++) {
        InputOutputKfcDumpInfo outputKfcDumpInfo;
        outputKfcDumpInfo.index = i;
        outputKfcDumpInfo.data_type = outputsDataType_[i];
        outputKfcDumpInfo.format = outputsFormat_[i];
        outputKfcDumpInfo.address = baseDumpData_.mutable_output(i)->address();
        outputKfcDumpInfo.size = outputSize_[i];
        outputKfcDumpInfo.shape = outputsShape_[i];
        outputKfcDumpInfo.origin_shape = outputsOriginShape_[i];
        dumpInfo->outputDumpInfo.push_back(outputKfcDumpInfo);
        aicpusd_info("Dump output info for kfc op: index[%d], data_type[%d], format[%d], address[%ld], size[%ld], shape[%s], origin_shape[%s].",
                     dumpInfo->outputDumpInfo[i].index,
                     dumpInfo->outputDumpInfo[i].data_type,
                     dumpInfo->outputDumpInfo[i].format,
                     dumpInfo->outputDumpInfo[i].address,
                     dumpInfo->outputDumpInfo[i].size,
                     ShapeDebugString(dumpInfo->outputDumpInfo[i].shape).c_str(), ShapeDebugString(dumpInfo->outputDumpInfo[i].origin_shape).c_str());
    }
    return;
}
void OpDumpTask::UpdateUdfDumpDataTotalSize()
{
    for (int64_t i = 0; i < baseDumpData_.input_size(); ++i) {
        auto &input = baseDumpData_.input(i);
        uint64_t len = input.size();
        if (len == 0U) {
            aicpusd_warn("input[%ld] data size is zero", i);
            continue;
        }
        inputTotalSize_ += len;
    }
    for (int64_t i = 0; i < baseDumpData_.output_size(); ++i) {
        auto &output = baseDumpData_.output(i);
        uint64_t len = output.size();
        if (len == 0U) {
            aicpusd_warn("output[%ld] data size is zero", i);
            continue;
        }
        outputTotalSize_ += len;
    }
    return;
}
StatusCode OpDumpTask::PreProcessUdfOpMappingInfo(uint8_t *dumpInfo, uint64_t length)
{
    if (dumpInfo == nullptr || length == 0) {
        aicpusd_err("dump info is nullptr or length is [%lu]", length);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpusd_info("PreProcessUdfOpMappingInfo begin length is %lu", length);
    char_t *addr = PtrToPtr<void, char_t>(ValueToPtr(PtrToValue(dumpInfo) + sizeof(uint64_t *)));
    uint64_t addrLength = *(PtrToPtr<uint8_t, uint64_t>(dumpInfo));
    char_t *path = PtrToPtr<void, char_t>(ValueToPtr(PtrToValue(addr) + addrLength + sizeof(uint64_t *)));
    uint64_t pathLength = *(PtrToPtr<char_t, uint64_t>(addr + addrLength));
    if ((addrLength + pathLength) > length) {
        aicpusd_err("addrLength[%lu] + pathLength[%lu] > length[%lu]", addrLength, pathLength, length);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const bool parseRet = baseDumpData_.ParseFromArray(addr, addrLength);
    if (!parseRet) {
        aicpusd_err("parse op udf info failed, addrLength[%lu]", addrLength);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpusd_info("dump info is %s", baseDumpData_.DebugString().c_str());
    opName_ = baseDumpData_.op_name();
    UpdateUdfDumpDataTotalSize();
    std::string pathStr(path, pathLength);
    aicpusd_info("pathStr is %s", pathStr.c_str());
    auto dumpRet = ProcessDumpTensor(pathStr);
    if (dumpRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("Dump failed. ret=%d, pathStr=%s, dump info is %s",
                    static_cast<int32_t>(dumpRet), pathStr.c_str(), baseDumpData_.DebugString().c_str());
        return dumpRet;
    }
    return AICPU_SCHEDULE_OK;
}
}  // namespace aicpu