/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_model_statistic.h"

#include <sstream>
namespace AicpuSchedule {
    std::string AicpuSdModelStatistic::FormatShapeToString(const std::vector<int64_t> &shape) const
    {
        bool first = true;
        std::stringstream ss;
        ss << "[";
        for (const int64_t &x : shape) {
            if (first) {
                first = false;
                ss << x;
            } else {
                ss << ", " << x;
            }
        }
        ss << "]";
        return ss.str();
    }

    std::string AicpuSdModelStatistic::GetRangeString(const std::vector<InAndOutParamStatInfo> &statInfos,
                                                      size_t startIdx, size_t endIdx) const
    {
        std::stringstream minSizeStream;
        std::stringstream maxSizeStream;
        std::stringstream minShapeStream;
        std::stringstream maxShapeStream;
        for (size_t idx = startIdx; idx <= endIdx; ++idx) {
            const auto &curInfo = statInfos[idx];
            if (idx != startIdx) {
                minSizeStream << ", ";
                maxSizeStream << ", ";
                minShapeStream << ", ";
                maxShapeStream << ", ";
            }
            minSizeStream << curInfo.minSize;
            maxSizeStream << curInfo.maxSize;
            minShapeStream << FormatShapeToString(curInfo.minShape);
            maxShapeStream << FormatShapeToString(curInfo.maxShape);
        }
        std::stringstream strStream;
        strStream << "min_size=[" << minSizeStream.str() << "], max_size=[" << maxSizeStream.str() <<
            "], min_shape=[" << minShapeStream.str() << "], max_shape=[" << maxShapeStream.str() << "]";
        return strStream.str();
    }

    AicpuSdModelStatistic::~AicpuSdModelStatistic()
    {
    }

    AicpuSdModelStatistic::AicpuSdModelStatistic()
    {
    }
 
    AicpuSdModelStatistic &AicpuSdModelStatistic::GetInstance()
    {
        static AicpuSdModelStatistic instance;
        return instance;
    }

    void AicpuSdModelStatistic::StatNNModelExecTime(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("invalid modelId:%u, max:%u", modelId, MAX_MODEL_COUNT);
            return;
        }
        aicpusd_info("enter curMax:%llu, curMin:%llu", modelStatArray_[modelId].maxExecTime,
                     modelStatArray_[modelId].minExecTime);
        if (!modelStatArray_[modelId].useFlag) {
            aicpusd_info("only stat static model, dynamic model no need stat");
            return;
        }
        modelStatArray_[modelId].totalCnt++;
        auto curTime = std::chrono::steady_clock::now();
        auto timeGap = curTime - modelStatArray_[modelId].modelStartTime;
        const uint64_t curExecTime =
            static_cast<uint64_t>(std::chrono::duration_cast<std::chrono::microseconds>(timeGap).count());
        modelStatArray_[modelId].totalTime += curExecTime;
        AicpuUtil::UpdateMaxAndSubMaxData(modelStatArray_[modelId].maxExecTime,
                                          modelStatArray_[modelId].subMaxExecTime,
                                          curExecTime);
        AicpuUtil::UpdateMinData(modelStatArray_[modelId].minExecTime, curExecTime);
        aicpusd_info("after update curMax:%llu, curMin:%llu, curStat:%llu", modelStatArray_[modelId].maxExecTime,
                     modelStatArray_[modelId].minExecTime, curExecTime);
    }

    void AicpuSdModelStatistic::UpdateStatVecInfo(InAndOutParamStatInfo &dstStat, const uint64_t totalSize,
                                                  const int64_t *shapes) const
    {
        if ((dstStat.minSize == 0) || (totalSize < dstStat.minSize)) {
            dstStat.minSize = totalSize;
            dstStat.minShape.assign(&(shapes[1]), &(shapes[1]) + shapes[0]);
        }

        if (totalSize > dstStat.maxSize) {
            dstStat.maxSize = totalSize;
            dstStat.maxShape.assign(&(shapes[1]), &(shapes[1]) + shapes[0]);
        }
    }

    void AicpuSdModelStatistic::AddNewDataToStatVec(std::vector<InAndOutParamStatInfo> &delVec,
                                                    const uint64_t totalSize,
                                                    const int64_t *shapes) const
    {
        InAndOutParamStatInfo tempNode;
        tempNode.minSize = totalSize;
        tempNode.minShape.assign(&(shapes[1]), &(shapes[1]) + shapes[0]);
        tempNode.maxSize = totalSize;
        tempNode.maxShape.assign(&(shapes[1]), &(shapes[1]) + shapes[0]);
        aicpusd_info("max size:%llu, min size:%llu, min shape size:%zu, max shape size:%zu",
                     tempNode.maxSize, tempNode.minSize, tempNode.minShape.size(), tempNode.maxShape.size());
        delVec.emplace_back(tempNode);
    }

    void AicpuSdModelStatistic::StatNNModelInput(const uint32_t modelId,
                                                 const std::vector<uint64_t> &totalSizeList,
                                                 std::vector<ModelConfigTensorDesc> &curStatVec)
    {
        if ((modelId >= MAX_MODEL_COUNT) || (totalSizeList.size() != curStatVec.size())) {
            aicpusd_err("invalid modelId:%u, max:%u, size list:%zu, stat list:%zu", modelId, MAX_MODEL_COUNT,
                        totalSizeList.size(), curStatVec.size());
            return;
        }
        std::vector<InAndOutParamStatInfo> &delVec = modelStatArray_[modelId].inputStatVec;
        const size_t delVecSize = delVec.size();
        const size_t curVecSize = curStatVec.size();
        const size_t curMinSize = delVecSize < curVecSize ? delVecSize : curVecSize;
        for (size_t index = 0; index < curMinSize; index++) {
            UpdateStatVecInfo(delVec[index], totalSizeList[index], &(curStatVec[index].shape[0]));
            aicpusd_info("index:%zu max size:%llu, min size:%llu, min shape size:%zu, max shape size:%zu", index,
                         delVec[index].maxSize, delVec[index].minSize,
                         delVec[index].minShape.size(), delVec[index].maxShape.size());
        }

        if (delVecSize < curVecSize) {
            for (size_t i = curMinSize; i < curVecSize; i++) {
                AddNewDataToStatVec(delVec, totalSizeList[i], &(curStatVec[i].shape[0]));
            }
        }
    }

    void AicpuSdModelStatistic::InitModelStatInfo()
    {
        for (uint32_t index = 0; index < MAX_MODEL_COUNT; index++) {
            modelStatArray_[index].useFlag     = false;
            modelStatArray_[index].maxExecTime = 0UL;
            modelStatArray_[index].minExecTime = 0UL;
            modelStatArray_[index].subMaxExecTime = 0UL;
            modelStatArray_[index].totalTime = 0UL;
            modelStatArray_[index].totalCnt = 0UL;
            modelStatArray_[index].inputStatVec.clear();
            modelStatArray_[index].outputStatVec.clear();
        }
    }

    void AicpuSdModelStatistic::MarNNModelStartTime(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("invalid modelId:%u, max:%u", modelId, MAX_MODEL_COUNT);
            return;
        }
        modelStatArray_[modelId].modelStartTime = std::chrono::steady_clock::now();
        modelStatArray_[modelId].useFlag = true;
        aicpusd_info("mark mode:%u started", modelId);
    }

    void AicpuSdModelStatistic::StatNNModelOutput(const uint32_t modelId, const RuntimeTensorDesc * const tensorDesc,
                                                  const int32_t nextIndex)
    {
        if ((modelId >= MAX_MODEL_COUNT) || (nextIndex <= 0) || (tensorDesc == nullptr)) {
            aicpusd_err("invalid modelId:%u, max:%u, nextIndex:%d", modelId, MAX_MODEL_COUNT, nextIndex);
            return;
        }
        const uint32_t curIndex = static_cast<uint32_t>(nextIndex) - 1U;
        std::vector<InAndOutParamStatInfo> &delVec = modelStatArray_[modelId].outputStatVec;
        const size_t curDelSize = delVec.size();
        int64_t curTotalSize = 0;
        const int32_t ret = AicpuUtil::CalcDataSizeByShape(&(tensorDesc->shape[1]), tensorDesc->shape[0],
                                                           tensorDesc->dtype, curTotalSize);
        if ((ret != AICPU_SCHEDULE_OK) || (curTotalSize < 0)) {
            aicpusd_warn("cannot get size from tensordesc, ret[%d], size[%lld]", ret, curTotalSize);
            return;
        }
        const uint64_t dataSize = static_cast<uint64_t>(curTotalSize);
        if (curIndex < curDelSize) {
            UpdateStatVecInfo(delVec[curIndex], dataSize, &(tensorDesc->shape[0]));
            aicpusd_info("max size:%llu, min size:%llu, min shape size:%zu, max shape size:%zu",
                         delVec[curIndex].maxSize, delVec[curIndex].minSize,
                         delVec[curIndex].minShape.size(), delVec[curIndex].maxShape.size());
        } else if (curIndex == curDelSize) {
            AddNewDataToStatVec(delVec, dataSize, &(tensorDesc->shape[0]));
        } else {
            delVec.resize(curIndex);
            AddNewDataToStatVec(delVec, dataSize, &(tensorDesc->shape[0]));
        }
    }

    void AicpuSdModelStatistic::PrintOutModelStatInfo()
    {
        for (uint32_t modelId = 0U; modelId < MAX_MODEL_COUNT; modelId++) {
            if (modelStatArray_[modelId].useFlag) {
                DumpOutModelMetrics(modelId);
            }
        }
    }
    void AicpuSdModelStatistic::DumpOutModelMetrics(const uint32_t modelId)
    {
        ModelStatInfo &curModeInfo = modelStatArray_[modelId];
        aicpusd_run_info("model_metrics:name=%s, min_exec_time=%llu us, max_exec_time=%llu us, "
                         "sub_max_exec_time=%llu us, total_exec_time=%llu us, total_exec_num=%llu.",
                         std::to_string(modelId).c_str(), curModeInfo.minExecTime, curModeInfo.maxExecTime,
                         curModeInfo.subMaxExecTime, curModeInfo.totalTime, curModeInfo.totalCnt);
        constexpr size_t maxCntPrintPreLine = 10;
        const size_t inputSize = curModeInfo.inputStatVec.size();
        const size_t outputSize = curModeInfo.outputStatVec.size();
        for (size_t inputIdx = 0; inputIdx < inputSize; inputIdx += maxCntPrintPreLine) {
            const size_t startIdx = inputIdx;
            const size_t endIdx = (inputIdx + maxCntPrintPreLine) > inputSize ?
                                  (inputSize - 1) : (inputIdx + maxCntPrintPreLine - 1);
            aicpusd_run_info("model_metrics:name=%s, input[%zu-%zu], %s.", std::to_string(modelId).c_str(),
                             startIdx, endIdx, GetRangeString(curModeInfo.inputStatVec, startIdx, endIdx).c_str());
        }

        for (size_t outputIdx = 0; outputIdx < outputSize; outputIdx += maxCntPrintPreLine) {
            const size_t startIdx = outputIdx;
            const size_t endIdx = (outputIdx + maxCntPrintPreLine) > outputSize ?
                                  (outputSize - 1) : (outputIdx + maxCntPrintPreLine - 1);
            aicpusd_run_info("model_metrics:name=%s, output[%zu-%zu], %s.", std::to_string(modelId).c_str(),
                             startIdx, endIdx, GetRangeString(curModeInfo.outputStatVec, startIdx, endIdx).c_str());
        }
    }
}