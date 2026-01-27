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
#include <sys/time.h>

#include "aicpusd_drv_manager.h"
#include "aicpusd_status.h"
#include "common/aicpusd_util.h"
#include "securec.h"
#include "external/graph/types.h"

namespace AicpuSchedule {
// slice size for dump file, 128MByes
const uint64_t DUMP_SLICE_SIZE = 128UL << 20U;
const size_t INTERNAL_STEP_SIZE = 2U;

static inline uint64_t GetCurrentTime()
{
    uint64_t ret = 0U;
    struct timeval tv;
    if (gettimeofday(&tv, nullptr) == 0) {
        ret = (static_cast<uint64_t>(tv.tv_sec) * 1000000UL) + static_cast<uint64_t>(tv.tv_usec);
    }

    return ret;
}

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
      deviceId_(deviceId) { }

static inline void ReplaceStringElem(std::string &str)
{
    (void)for_each(str.begin(), str.end(),
        [](char_t &ch) {
            if ((ch == ' ') ||
                (ch == '.') ||
                (ch == '/') ||
                (ch == '\\')) { ch = '_'; }
        });
}

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
    for (int32_t index = 0; index < outputsFromMapInfo.size(); ++index) {
        const auto &item = outputsFromMapInfo.at(index);
        ::toolkit::dumpdata::OpOutput * const opOutput = dumpData.add_output();
        if (opOutput == nullptr) {
            aicpusd_err("op name[%s], call protobuf function to add output elem failed", opName_.c_str());
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        opOutput->set_data_type(static_cast<::toolkit::dumpdata::OutputDataType>(item.data_type()));
        const auto format = item.format();
        opOutput->set_format(static_cast<::toolkit::dumpdata::OutputFormat>(ge::GetPrimaryFormat(format)));
        opOutput->set_sub_format(ge::GetSubFormat(format));
        const auto dims = item.shape().dim();
        ::toolkit::dumpdata::Shape * const outShape = opOutput->mutable_shape();
        for (const auto dim : dims) {
            outShape->add_dim(dim);
        }
        const auto originalDims = item.origin_shape().dim();
        ::toolkit::dumpdata::Shape * const outOriginalShape = opOutput->mutable_original_shape();
        for (const auto dim : originalDims) {
            outOriginalShape->add_dim(dim);
        }
        if (!item.original_name().empty()) {
            ::toolkit::dumpdata::OriginalOp * const orgOp = opOutput->mutable_original_op();
            orgOp->set_name(item.original_name());
            orgOp->set_output_index(static_cast<uint32_t>(item.original_output_index()));
            orgOp->set_data_type(static_cast<::toolkit::dumpdata::OutputDataType>(item.original_output_data_type()));
            orgOp->set_format(static_cast<::toolkit::dumpdata::OutputFormat>(item.original_output_format()));
        }
        const auto &dim_rangeFromOutput = item.dim_range();
        for (int32_t i = 0; i < dim_rangeFromOutput.size(); ++i) {
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
        opOutput->set_size(item.size());
        outputTotalSize_ += item.size();
        outputsBaseAddr_.push_back(item.address());
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessInput(const aicpu::dump::Task &task,
                                       ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &inputsFromMapInfo = task.input();
    for (int32_t i = 0; i < inputsFromMapInfo.size(); ++i) {
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
        const auto dims = item.shape().dim();
        ::toolkit::dumpdata::Shape * const inShape = opInput->mutable_shape();
        for (const auto dim : dims) {
            inShape->add_dim(dim);
        }
        const auto originalDims = item.origin_shape().dim();
        ::toolkit::dumpdata::Shape * const inOriginalShape = opInput->mutable_original_shape();
        for (const auto dim : originalDims) {
            inOriginalShape->add_dim(dim);
        }

        opInput->set_size(item.size());
        inputTotalSize_ += item.size();
        inputsBaseAddr_.push_back(item.address());
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessOpBuffer(const aicpu::dump::Task &task,
                                          ::toolkit::dumpdata::DumpData &dumpData)
{
    const auto &opsBufferFromMapInfo = task.buffer();
    for (int32_t i = 0; i < opsBufferFromMapInfo.size(); ++i) {
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
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::PreProcessOpMappingInfo(const aicpu::dump::Task &task,
                                               const std::string &basePath,
                                               const MappingInfoOptionalParam &param,
                                               const DumpStep &dumpStep,
                                               const bool isSingleOrUnknowShapeOp)
{
    aicpusd_info("Base path[%s], has model name[%d], model name[%s], has model id[%d], model id[%u].",
                 basePath.c_str(), static_cast<int32_t>(param.hasModelName), param.modelName.c_str(),
                 static_cast<int32_t>(param.hasModelId), param.modelId);
    aicpusd_debug("task info[%s].", task.DebugString().c_str());
    const std::lock_guard<std::mutex> queLock(dumpMtx_);
    baseDumpPath_ = basePath;
    optionalParam_ = param;
    dumpStep_ = dumpStep;
    isSingleOrUnknowShapeOp_ = isSingleOrUnknowShapeOp;
    // single op no task id and stream id
    taskInfo_.taskId_ = (isSingleOrUnknowShapeOp_ && optionalParam_.hasStepId)? 0U : task.task_id();
    taskInfo_.streamId_ = (isSingleOrUnknowShapeOp_ && optionalParam_.hasStepId)? 0U : task.stream_id();
    endGraph_ = task.end_graph();

    ::toolkit::dumpdata::DumpData dumpData;
    // version 2.0
    dumpData.set_version("2.0");
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
    opName_ = task.op().op_name();
    opType_ = task.op().op_type();
    dumpData.set_op_name(opName_);
    aicpusd_info("[stream id:%u, task id:%u], op name[%s], op type[%s]",
        taskInfo_.streamId_, taskInfo_.taskId_, opName_.c_str(), opType_.c_str());
    baseDumpData_ = std::move(dumpData);
    taskDumpNum_ = 0U;

    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::ProcessInputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                        const std::string &path,
                                        const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int32_t i = 0; i < dumpData.input_size(); ++i) {
        auto &input = dumpData.input(i);
        const uint64_t len = input.size();
        if (len == 0U) {
            aicpusd_info("op name[%s], input[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        const uint64_t baseAddr = inputsBaseAddr_.at(static_cast<size_t>(i));
        uint64_t dataAddr = baseAddr;
        if (!isSingleOrUnknowShapeOp_) {
            if (baseAddr == 0U) {
                aicpusd_info("op name[%s], input[%d] base addr is null", opName_.c_str(), i);
                continue;
            }
            // baseAddr is a pointer point to data addr
            dataAddr = *(PtrToPtr<void ,uint64_t>(ValueToPtr(baseAddr)));
        }
        aicpusd_info("op name[%s], input[%d] size[%llu]", opName_.c_str(), i, len);
        if (dataAddr == 0U) {
            aicpusd_info("op name[%s], input[%d] addr is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < len) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, len - innerOffset);
            const uint64_t srcAddr = dataAddr + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for input[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          ValueToPtr(srcAddr),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], input[%d] memcpy failed, desSize[%llu], srcSize[%llu]", opName_.c_str(), i,
                            emptyBufferSize, actSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for input[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            const bool isLastSilce = (dumpedSize == inputTotalSize_) && (outputTotalSize_ == 0U) &&
                (opBufferTotalSize_ == 0U)  && (opWorkspaceTotalSize_ == 0U);
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

StatusCode OpDumpTask::ProcessOutputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                         const std::string &path,
                                         const IDE_SESSION ideSession)
{
    uint64_t dumpedSize = 0U;
    for (int32_t i = 0; i < dumpData.output_size(); ++i) {
        auto &output = dumpData.output(i);
        const uint64_t len = output.size();
        if (len == 0U) {
            aicpusd_info("op name[%s], output[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        const uint64_t baseAddr = outputsBaseAddr_.at(static_cast<size_t>(i));
        uint64_t dataAddr = baseAddr;
        if (!isSingleOrUnknowShapeOp_) {
            if (baseAddr == 0U) {
                aicpusd_info("op name[%s], output[%d] base addr is null.", opName_.c_str(), i);
                continue;
            }
            // baseAddr is a pointer point to data addr
            dataAddr = *(PtrToPtr<void, uint64_t>(ValueToPtr(baseAddr)));
            aicpusd_info("op name[%s], output[%d].", opName_.c_str(), i);
        }
        aicpusd_info("op name[%s], output[%d] size[%llu].", opName_.c_str(), i, len);

        if (dataAddr == 0U) {
            aicpusd_info("op name[%s], output[%d] addr is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < len) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, len - innerOffset);
            const uint64_t srcAddr = dataAddr + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for output[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          ValueToPtr(srcAddr),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], output[%d] memcpy failed, des[%llu], src[%llu]", opName_.c_str(), i,
                    PtrToValue(buff_.get() + offset_), srcAddr);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for output[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            const bool isLastSilce = (offset_ >= buffSize_) ||
                ((dumpedSize == outputTotalSize_) && (opBufferTotalSize_ == 0U) && (opWorkspaceTotalSize_ == 0U));
            if (isLastSilce) {
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
    for (int32_t i = 0; i < dumpData.buffer_size(); ++i) {
        auto &buffer = dumpData.buffer(i);
        if (buffer.size() == 0U) {
            aicpusd_info("op name[%s], op buffer[%d] data size is zero", opName_.c_str(), i);
            continue;
        }
        const size_t opBufferAddrIndex = static_cast<size_t>(i);
        if (opBufferAddr_[opBufferAddrIndex] == 0U) {
            aicpusd_info("op name[%s], op buffer[%d] addr is null", opName_.c_str(), i);
            continue;
        }
        uint64_t innerOffset = 0U;
        while (innerOffset < buffer.size()) {
            const uint64_t emptyBufferSize = buffSize_ - offset_;
            const uint64_t actSize = std::min(emptyBufferSize, buffer.size() - innerOffset);
            const uint64_t srcAddr = opBufferAddr_[opBufferAddrIndex] + innerOffset;
            aicpusd_info("op name[%s], begin to copy data from HBM to DDR for op buffer[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            const errno_t eRet = memcpy_s(buff_.get() + offset_,
                                          emptyBufferSize,
                                          ValueToPtr(srcAddr),
                                          actSize);
            if (eRet != EOK) {
                aicpusd_err("op name[%s], op buffer[%d] memcpy failed, desSize[%llu], srcSize[%llu]",
                            opName_.c_str(), i, emptyBufferSize, actSize);
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_info("op name[%s], end of copy data from HBM to DDR for op buffer[%d], size[%llu]",
                         opName_.c_str(), i, actSize);
            offset_ += actSize;
            innerOffset += actSize;
            dumpedSize += actSize;
            const bool isLastSilce = (offset_ >= buffSize_) ||
                ((dumpedSize == opBufferTotalSize_) && (opWorkspaceTotalSize_ == 0U));
            if (isLastSilce) {
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
            if (!((offset_ >= buffSize_) || isLastSilce)) {
                continue;
            }
            const StatusCode ret = Dump(path, buff_.get(), offset_, ideSession, isLastSilce);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("op name[%s], dump op space failed", opName_.c_str());
                return ret;
            }
            offset_ = 0U;
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
        IdeDumpChunk ideDumpChunk = {nullptr};
        ideDumpChunk.fileName = const_cast<char_t *>(path.c_str());
        ideDumpChunk.dataBuf = reinterpret_cast<uint8_t *>(data);
        ideDumpChunk.bufLen = static_cast<uint32_t>(len);
        ideDumpChunk.isLastChunk = isLastSlice ? 1U : 0U;
        ideDumpChunk.offset = -1;  // append
        ideDumpChunk.flag = IDE_DUMP_NONE_FLAG;
        aicpusd_info("op name[%s], start to call IdeDumpData, size[%u], isLastChunk[%u]",
                     opName_.c_str(), len, ideDumpChunk.isLastChunk);
        const IdeErrorT ideState = IdeDumpData(ideSession, &ideDumpChunk);
        if (ideState != IDE_DAEMON_NONE_ERROR) {
            aicpusd_err("op name[%s], call IdeDumpData failed, size[%u].", opName_.c_str(), len);
            return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }
        aicpusd_info("op name[%s], end of call IdeDumpData, size[%u]", opName_.c_str(), len);
    } else {
        aicpusd_err("op name[%s], ide session is null, size[%u].", opName_.c_str(), len);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode OpDumpTask::DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                                  const std::string &dumpDebugInfo)
{
    const std::lock_guard<std::mutex> queLock(dumpMtx_);
    uint64_t dumpNumber = 0U;
    if (GetDumpNumber(dumpNumber) != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (!NeedDump(dumpNumber)) {
        return AICPU_SCHEDULE_OK;
    }

    const uint64_t nowTime = GetCurrentTime();
    baseDumpData_.set_dump_time(nowTime);

    if ((baseDumpData_.ByteSizeLong() > static_cast<uint64_t>(INT_MAX)) || (baseDumpData_.ByteSizeLong() == 0U)) {
        aicpusd_err("op name[%s], dump data size[%zuB] should be in [1B, 2GB)].",
            opName_.c_str(), baseDumpData_.ByteSizeLong());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpusd_info("op name[%s], proto buffer total bytes[%llu]", opName_.c_str(), baseDumpData_.ByteSizeLong());
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
    // dump file path name
    const std::string dumpFilePath = DumpPath(nowTime, dumpNumber, streamId, taskId);
    std::string dumpDebugFilePath;
    if (!(dumpDebugInfo.empty())) {
        dumpDebugFilePath = DumpPath(nowTime, dumpNumber, streamId, taskId, true);
    }
    return DoDump(dumpFilePath, dumpDebugFilePath, dumpDebugInfo);
}

StatusCode OpDumpTask::DoDump(const std::string &dumpFilePath, const std::string &dumpDebugFilePath,
                              const std::string &dumpDebugInfo)
{
    aicpusd_info("op name[%s], start to dump data, path[%s]", opName_.c_str(), dumpFilePath.c_str());
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
    // release buffer
    buff_.reset(nullptr);

    if (!(dumpDebugInfo.empty())) {
        ret = Dump(dumpDebugFilePath, const_cast<char_t *>(dumpDebugInfo.c_str()),
                   dumpDebugInfo.size(), ideSession, true);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("op name[%s], dump debug info failed, path[%s].", opName_.c_str(),
                        dumpDebugFilePath.c_str());
            return ret;
        }
    }
    aicpusd_info("op name[%s], dump data success, path[%s]", opName_.c_str(), dumpFilePath.c_str());
    return AICPU_SCHEDULE_OK;
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

bool OpDumpTask::NeedDump(const uint64_t step)
{
    if (endGraph_) {
        aicpusd_run_info("op name[%s], end graph dump task.", opName_.c_str());
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
                                 const uint32_t streamId, const uint32_t taskId, const bool debugFlag)
{
    std::ostringstream oss;
    oss << baseDumpPath_;
    if (optionalParam_.hasModelName) {
        oss << "/" << optionalParam_.modelName;
    }
    if (optionalParam_.hasModelId) {
        oss << "/" << optionalParam_.modelId;
    }
    // single op dump
    if (!((isSingleOrUnknowShapeOp_) && (!optionalParam_.hasStepId))) {
        oss << "/" << dumpNumber;
    }

    std::string opName = opName_;
    std::string opType = opType_;
    ReplaceStringElem(opName);
    ReplaceStringElem(opType);
    if (debugFlag) {
        opName += "Debug";
    }
    if ((streamId != INVALID_VAL) && (taskId != INVALID_VAL)) {
        oss << "/" << opType << "." << opName << "." << taskId << "." << streamId << "." << nowTime;
    } else {
        oss << "/" << opType << "." << opName << "." << taskInfo_.taskId_ << "."
            << taskInfo_.streamId_ << "." << nowTime;
    }
    return oss.str();
}

void OpDumpTask::ClearBaseDumpData()
{
    baseDumpData_.Clear();
    return;
}

std::string DumpStep::DebugString()
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

OpDumpTaskManager &OpDumpTaskManager::GetInstance()
{
    static OpDumpTaskManager instance;
    return instance;
}

void OpDumpTaskManager::GetOptionalParam(const aicpu::dump::OpMappingInfo &opMappingInfo,
                                         MappingInfoOptionalParam &optionalParam) const
{
    if (opMappingInfo.model_name_param_case() == aicpu::dump::OpMappingInfo::kModelName) {
        optionalParam.modelName = opMappingInfo.model_name();
        ReplaceStringElem(optionalParam.modelName);
        optionalParam.hasModelName = true;
    }
    if (opMappingInfo.model_id_param_case() == aicpu::dump::OpMappingInfo::kModelId) {
        optionalParam.modelId = opMappingInfo.model_id();
        optionalParam.hasModelId = true;
    }
    if (opMappingInfo.step_id_case() == aicpu::dump::OpMappingInfo::kStepIdAddr) {
        optionalParam.stepIdAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.step_id_addr()));
        optionalParam.hasStepId = true;
    }
    if (opMappingInfo.iterations_per_loop_case() == aicpu::dump::OpMappingInfo::kIterationsPerLoopAddr) {
        optionalParam.iterationsPerLoopAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.iterations_per_loop_addr()));
        optionalParam.hasIterationsPerLoop = true;
    }
    if (opMappingInfo.loop_cond_case() == aicpu::dump::OpMappingInfo::kLoopCondAddr) {
        optionalParam.loopCondAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.loop_cond_addr()));
        optionalParam.hasLoopCond = true;
    }
}

int32_t OpDumpTaskManager::Load(const aicpu::dump::OpMappingInfo &opMappingInfo)
{
    const std::string dumpPath = opMappingInfo.dump_path();
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    const std::string dumpStepStr = opMappingInfo.dump_step();
    DumpStep dumpStep;
    if (!GetDumpStepFromString(dumpStepStr, dumpStep)) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t hostPid = static_cast<int32_t>(AicpuSchedule::AicpuDrvManager::GetInstance().GetHostPid());
    const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
    std::set<TaskInfo> tasksInfo;
    {
        const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
        for (int32_t i = 0; i < opMappingInfo.task_size(); ++i) {
            const aicpu::dump::Task task = opMappingInfo.task(i);
            const uint32_t taskId = task.task_id() & 0xFFFF;
            const uint32_t streamId = task.stream_id();
            std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
            try {
                opDumpTaskPtr = std::make_shared<OpDumpTask>(hostPid, deviceId);
            } catch (...) {
                aicpusd_err("make shared for OpDumpTask failed.");
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            aicpusd_memory_log("MallocMemory, func=new, size=%zu, purpose=data dumper", sizeof(OpDumpTask));
            if (opDumpTaskPtr == nullptr) {
                aicpusd_err("malloc memory for OpDumpTask object failed");
                return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
            }
            const int32_t ret = opDumpTaskPtr->PreProcessOpMappingInfo(task, dumpPath, optionalParam, dumpStep);
            if (ret != AICPU_SCHEDULE_OK) {
                // when error occur, ge call unload op mapping info
                aicpusd_err("pre process op mapping info failed");
                return ret;
            }
            TaskInfo taskInfo(streamId, taskId);
            (void)dumpTaskMap_.insert(std::make_pair(taskInfo, std::move(opDumpTaskPtr)));
            (void)tasksInfo.insert(taskInfo);
        }
        if (optionalParam.hasModelId) {
            const auto iter = modelIdToTask_.find(optionalParam.modelId);
            if (iter == modelIdToTask_.end()) {
                (void)modelIdToTask_.insert(std::make_pair(optionalParam.modelId, std::move(tasksInfo)));
            } else {
                for (const auto item : tasksInfo) {
                    (void)iter->second.insert(item);
                }
            }
        }
    }
    return AICPU_SCHEDULE_OK;
}

void OpDumpTaskManager::UnloadClearTaskInfo(const TaskInfo &taskInfo)
{
    const auto range = dumpTaskMap_.equal_range(taskInfo);
    if (range.first != range.second) {
        for (auto item = range.first; item != range.second; ++item) {
            item->second->ClearBaseDumpData();
        }
    }
    (void)dumpTaskMap_.erase(taskInfo);
    return;
}

int32_t OpDumpTaskManager::Unload(const aicpu::dump::OpMappingInfo &opMappingInfo)
{
    const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
    for (int32_t i = 0; i < opMappingInfo.task_size(); ++i) {
        const aicpu::dump::Task task = opMappingInfo.task(i);
        const uint32_t taskId = task.task_id();
        const uint32_t streamId = task.stream_id();
        const TaskInfo taskInfo(streamId, taskId);
        UnloadClearTaskInfo(taskInfo);
        aicpusd_info("Unload op mapping info, stream id[%u], task id[%u].",
            streamId, taskId);
    }
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    if (optionalParam.hasModelId) {
        const auto iter = modelIdToTask_.find(optionalParam.modelId);
        if (iter == modelIdToTask_.end()) {
            aicpusd_warn("no model id[%u], unload dump model failed", optionalParam.modelId);
            return AICPU_SCHEDULE_OK;
        }
        for (const auto taskInfo : iter->second) {
            UnloadClearTaskInfo(taskInfo);
            aicpusd_info("Check and clean data dump task resource, stream id[%u], task id[%u].",
                taskInfo.streamId_, taskInfo.taskId_);
        }
        (void)modelIdToTask_.erase(iter);
        aicpusd_info("unload model id[%u] success", optionalParam.modelId);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len)
{
    aicpusd_info("Load op mapping info, size[%u].", len);
    if (infoAddr == nullptr) {
        aicpusd_err("op mapping info addr is null");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpu::dump::OpMappingInfo opMappingInfo;
    const std::string protoInfo(infoAddr, static_cast<unsigned long>(len));
    const bool parseRet = opMappingInfo.ParseFromString(protoInfo);
    if (!parseRet) {
        aicpusd_err("parse op mapping info failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (opMappingInfo.flag() == 0x01U) {
        return Load(opMappingInfo);
    } else if (opMappingInfo.flag() == 0x00U) {
        return Unload(opMappingInfo);
    } else {
        aicpusd_info("Flag [%d] invalid, allow [0x00, 0x01]", opMappingInfo.flag());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t streamId1, const uint32_t taskId1,
                                      const std::string &dumpDebugInfo)
{
    const TaskInfo taskInfo(streamId, taskId);
    dumpTaskMapMtx_.lock();
    const auto range = dumpTaskMap_.equal_range(taskInfo);
    if (range.first == range.second) {
        dumpTaskMapMtx_.unlock();
        aicpusd_run_info("task required to dump does not exist, stream id[%u], task id[%u].", streamId, taskId);
        return AICPU_SCHEDULE_OK;
    } else {
        std::vector<std::shared_ptr<OpDumpTask>> opDumptasks;
        for (auto item = range.first; item != range.second; ++item) {
            std::shared_ptr<OpDumpTask> opDumpTask = item->second;
            opDumptasks.push_back(std::move(opDumpTask));
        }
        int32_t ret = AICPU_SCHEDULE_OK;
        dumpTaskMapMtx_.unlock();
        aicpusd_run_info("require to dump op info, stream id=%u, task id=%u, task number=%zu",
            streamId, taskId, opDumptasks.size());
        for (auto item : opDumptasks) {
            aicpusd_run_info("start to dump op info, stream id=%u, task id=%u, op name=%s",
                streamId, taskId, item->GetOpName().c_str());
            ret = item->DumpOpInfo(streamId1, taskId1, dumpDebugInfo);
            aicpusd_run_info("end of dump op info, result=%d, stream id=%u, task id=%u, op name=%s",
                ret, streamId, taskId, item->GetOpName().c_str());
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        }
        // process if task is end graph
        ProcessEndGraph(opDumptasks);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::DumpOpInfoForUnknowShape(const uint64_t opMappingInfoAddr,
                                                    const uint64_t opMappingInfoLen) const
{
    aicpusd_info("load op mapping info for single op or unknown shape op, size[%llu]", opMappingInfoLen);
    if (opMappingInfoAddr == 0U) {
        aicpusd_err("op mapping info addr is null");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpu::dump::OpMappingInfo opMappingInfo;
    const std::string protoInfo(PtrToPtr<const void, const char_t>(ValueToPtr(opMappingInfoAddr)),
        opMappingInfoLen);
    const bool parseRet = opMappingInfo.ParseFromString(protoInfo);
    if (!parseRet) {
        aicpusd_err("parse op mapping info failed, size[%u]", opMappingInfoLen);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t taskSize = opMappingInfo.task_size();
    if (taskSize != 1) {
        aicpusd_err("task number[%d] should be only one, op mapping info: %s",
            opMappingInfo.task_size(), opMappingInfo.DebugString().c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return DoDump(opMappingInfo);
}

int32_t OpDumpTaskManager::DoDump(const aicpu::dump::OpMappingInfo &opMappingInfo) const
{
    const std::string dumpPath = opMappingInfo.dump_path();
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    const std::string dumpStepStr = opMappingInfo.dump_step();

    DumpStep dumpStep;
    if (!GetDumpStepFromString(dumpStepStr, dumpStep)) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t hostPid = static_cast<int32_t>(AicpuSchedule::AicpuDrvManager::GetInstance().GetHostPid());
    const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
    std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
    try {
        opDumpTaskPtr = std::make_shared<OpDumpTask>(hostPid, deviceId);
    } catch (const std::bad_alloc &err) {
        aicpusd_err("malloc memory for OpDumpTask object failed, reason is [%s]", err.what());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    } catch (...) {
        aicpusd_err("malloc memory for OpDumpTask object failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpusd_memory_log("MallocMemory, func=new, size=%zu, purpose=data dumper", sizeof(OpDumpTask));
    if (opDumpTaskPtr == nullptr) {
        aicpusd_err("malloc memory for OpDumpTask object failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    int32_t ret = AICPU_SCHEDULE_OK;
    const aicpu::dump::Task task = opMappingInfo.task(0);
    ret = opDumpTaskPtr->PreProcessOpMappingInfo(task,
                                                 dumpPath,
                                                 optionalParam,
                                                 dumpStep,
                                                 true);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("pre process op mapping info failed, op mapping info: %s",
            opMappingInfo.DebugString().c_str());
        return ret;
    }
    auto startTime = std::chrono::steady_clock::now();
    aicpusd_run_info("start to dump op info, op name=%s", opDumpTaskPtr->GetOpName().c_str());
    ret = opDumpTaskPtr->DumpOpInfo();
    auto endTime = std::chrono::steady_clock::now();
    double drUs = std::chrono::duration<double, std::micro>(endTime - startTime).count();
    aicpusd_run_info("end of dump op info, result=%d, op name=%s, cost time is [%.2lf]us",
        ret, opDumpTaskPtr->GetOpName().c_str(), drUs);
    UNUSED(drUs);
    return ret;
}

void OpDumpTaskManager::ProcessEndGraph(const std::vector<std::shared_ptr<OpDumpTask>> &opDumptasks)
{
    for (const auto &item  : opDumptasks) {
        if (item->IsEndGraph()) {
            uint32_t modelId;
            if (item->GetModelId(modelId)) {
                UpdateDumpNumByModelId(modelId);
            } else {
                item->UpdateDumpNum();
            }
        }
    }
}

void OpDumpTaskManager::UpdateDumpNumByModelId(const uint32_t modelId)
{
    std::vector<std::shared_ptr<OpDumpTask>> opDumptasks;
    {
        const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
        const auto iter = modelIdToTask_.find(modelId);
        if (iter != modelIdToTask_.end()) {
            for (auto &taskInfo : iter->second) {
                const auto range = dumpTaskMap_.equal_range(taskInfo);
                for (auto item = range.first; item != range.second; ++item) {
                    std::shared_ptr<OpDumpTask> opDumpTask = item->second;
                    opDumptasks.push_back(std::move(opDumpTask));
                }
            }
        }
    }

    for (auto &dumpTask : opDumptasks) {
        dumpTask->UpdateDumpNum();
    }
}

static void DoSplit(const std::string &externStr, std::vector<std::string> &ret, const std::string &delim)
{
    size_t i = 0UL;
    while (i < externStr.size()) {
        const size_t pos = externStr.find(delim, i);
        if (pos != std::string::npos) {
            std::string s = externStr.substr(i, pos - i);
            if (!s.empty()) {
                ret.push_back(std::move(s));
            }
            i = pos + delim.size() - 1UL;
        }
        ++i;
    }
}

static std::vector<std::string> Split(const std::string &str, const std::string &delim)
{
    std::vector<std::string> ret;
    if (!str.empty()) {
        const std::string externStr = str + delim;
        DoSplit(externStr, ret, delim);
    }
    return ret;
}

bool OpDumpTaskManager::MatchAndInsert(const std::string &step, DumpStep &tmpDumpStep) const
{
    // smatch result
    const std::regex singleStepPatten("(\\s*)(\\d+)(\\s*)");
    const std::regex intervalStepPatten("((\\s*)(\\d+)(\\s*)){1}(-(\\s*)(\\d+)(\\s*))");
    if (std::regex_match(step, singleStepPatten)) {
        (void)tmpDumpStep.singleStep.insert(static_cast<uint64_t>(std::stoull(step)));
    } else if (std::regex_match(step, intervalStepPatten)) {
        const std::vector<std::string> intervalStepStr = Split(step, "-");
        if (intervalStepStr.size() == INTERNAL_STEP_SIZE) {
            IntervalStep intervalStep;
            intervalStep.start = static_cast<uint64_t>(std::stoull(intervalStepStr[0U]));
            intervalStep.end = static_cast<uint64_t>(std::stoull(intervalStepStr[1U]));
            if (intervalStep.start > intervalStep.end) {
                std::swap(intervalStep.start, intervalStep.end);
            }
            tmpDumpStep.intervalStep.push_back(std::move(intervalStep));
        }
    } else {
        aicpusd_err("invalid step[%s], please check.", step.c_str());
        return false;
    }
    return true;
}

bool OpDumpTaskManager::GetDumpStepFromString(const std::string &str, DumpStep &dumpStep) const
{
    // split by |, such as "0|5-10"
    aicpusd_info("Step need to dump[%s].", str.c_str());
    const std::vector<std::string> steps = Split(str, "|");
    DumpStep tmpDumpStep;
    for (const auto &step : steps) {
        try {
            if (!MatchAndInsert(step, tmpDumpStep)) {
                return false;
            }
        } catch (std::out_of_range &e) {
            aicpusd_err("out of range of uint64_max[%llu], invalid step[%s], msg[%s], please check.",
                        UINT64_MAX, step.c_str(), e.what());
            return false;
        } catch (...) {
            aicpusd_err("invalid step[%s], please check.", step.c_str());
            return false;
        }
    }
    dumpStep = std::move(tmpDumpStep);
    return true;
}

void OpDumpTaskManager::ClearResource()
{
    const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
    aicpusd_run_info("clear all resource of data dump");
    dumpTaskMap_.clear();
    modelIdToTask_.clear();
}
}  // namespace aicpu
