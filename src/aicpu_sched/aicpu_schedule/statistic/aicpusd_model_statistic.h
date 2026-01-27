/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STATISTIC_AICPUSD_MODEL_STATISTIC_H
#define STATISTIC_AICPUSD_MODEL_STATISTIC_H
#include <map>
#include <vector>
#include <chrono>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"
#include "aicpusd_util.h"
namespace AicpuSchedule {

    struct ParamStatInfo {
        uint64_t curSize;
        uint64_t curShape;
        ParamStatInfo() : curSize(0UL), curShape(0UL) {}
    };
    struct InAndOutParamStatInfo {
        uint64_t minSize;
        uint64_t maxSize;
        std::vector<int64_t> minShape;
        std::vector<int64_t> maxShape;
        InAndOutParamStatInfo() : minSize(0UL), maxSize(0UL) {}
    };
    struct ModelStatInfo {
        bool useFlag;
        uint64_t minExecTime;
        uint64_t maxExecTime;
        uint64_t subMaxExecTime;
        uint64_t totalTime;
        uint64_t totalCnt;
        std::vector<InAndOutParamStatInfo> inputStatVec;
        std::vector<InAndOutParamStatInfo> outputStatVec;
        std::chrono::steady_clock::time_point modelStartTime;
    };
    class AicpuSdModelStatistic {
    public:
        static AicpuSdModelStatistic &GetInstance();
        void StatNNModelExecTime(const uint32_t modelId);
        void StatNNModelInput(const uint32_t modelId, const std::vector<uint64_t> &totalSizeList,
                              std::vector<ModelConfigTensorDesc> &curStatVec);
        void InitModelStatInfo();
        void MarNNModelStartTime(const uint32_t modelId);
        void PrintOutModelStatInfo();
        void StatNNModelOutput(const uint32_t modelId, const RuntimeTensorDesc * const tensorDesc,
                               const int32_t nextIndex);
    private:
        void DumpOutModelMetrics(const uint32_t modelId);
        void AddNewDataToStatVec(std::vector<InAndOutParamStatInfo> &delVec, const uint64_t totalSize,
                                 const int64_t *shapes) const;
        void UpdateStatVecInfo(InAndOutParamStatInfo &dstStat, const uint64_t totalSize,
                               const int64_t *shapes) const;
        std::string FormatShapeToString(const std::vector<int64_t> &shape) const;
        std::string GetRangeString(const std::vector<InAndOutParamStatInfo> &statInfos,
                                   size_t startIdx, size_t endIdx) const;
        AicpuSdModelStatistic();
        virtual ~AicpuSdModelStatistic();
        ModelStatInfo modelStatArray_[MAX_MODEL_COUNT];
    };
}
#endif