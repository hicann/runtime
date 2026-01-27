/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COLLECTOR_DVVP_ACP_COMMAND_H
#define COLLECTOR_DVVP_ACP_COMMAND_H
#include "argparser.h"
#include "message/prof_params.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
using namespace analysis::dvvp::common::argparse;
Argparser AcpCommandBuild(const std::string commandName);
int32_t ProfileCommandRun(Argparser &profCommand);
int32_t WaitRunningProcess(std::string processUsage, int32_t &taskPid);
int32_t PreCheckPlatform();
int32_t CheckOutputValid(std::string &output);
int32_t CheckAcpMetricsIsValid(std::string &metrics);
int32_t CheckCustomEventIsValid(std::string::size_type pos, std::string &metrics, std::vector<std::string> &metricsVec);
int32_t CheckGroupMetricsIsValid(std::string &metrics, std::vector<std::string> &metricsVec);
void DeduplicateAcpMetrics(std::string::size_type pos, std::string &metrics, std::vector<std::string> &metricsVec);
}
}
}
#endif