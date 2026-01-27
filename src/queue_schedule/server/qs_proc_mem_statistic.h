/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STATISTIC_QS_PROC_MEM_STATISTIC_H
#define STATISTIC_QS_PROC_MEM_STATISTIC_H

#include <string>

#include "common/type_def.h"
#include "common/bqs_log.h"

namespace bqs {
    struct ProcMemStatInfo {
        uint64_t memAvg;
        uint64_t memHwm;
        uint64_t statCnt;
        uint64_t memTotal;
        ProcMemStatInfo() : memAvg(0UL), memHwm(0UL), statCnt(0UL), memTotal(0UL) {}
    };

    class QsProcMemStatistic {
    public:
        QsProcMemStatistic();
        virtual ~QsProcMemStatistic();
        void StatisticProcMemInfo();
        bool InitProcMemStatistic();
        void PrintOutProcMemInfo(const uint32_t hostPid);
    private:
        void StatisticProcSvmMemInfo();
        void StatisticProcXsMemInfo();
        void StatisticProcOsMemInfo();
        bool GetXsMemInfoFromFile(uint64_t &xsMemValue);
        bool GetOsMemInfoFromFile(uint64_t &rssValue, uint64_t &hwmValue);
        bool GetSvmInfoFromFile(uint64_t &svmValue);
        ProcMemStatInfo rssMem_;
        ProcMemStatInfo svmMem_;
        ProcMemStatInfo xsMem_;
        std::string rssMemCfgFile_;
        std::string svmMemCfgFile_;
        std::string xsMemCfgFile_;
        bool runDevice_;
        pid_t curPid_;
    };
}
#endif