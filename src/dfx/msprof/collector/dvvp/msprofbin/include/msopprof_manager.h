/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MSPROFBIN_MSOPPROF_MANAGER_H_
#define ANALYSIS_DVVP_MSPROFBIN_MSOPPROF_MANAGER_H_

#include <vector>
#include <string>
#include "utils/utils.h"
#include "config/config.h"
#include "singleton/singleton.h"

namespace Analysis {
namespace Dvvp {
namespace Msopprof {
using CONST_CHAR_PTR = const char *;
using namespace analysis::dvvp::common::config;

class MsopprofManager : public analysis::dvvp::common::singleton::Singleton<MsopprofManager> {
public:
    MsopprofManager();
    ~MsopprofManager() {}
    int MsopprofProcess(int argc, CONST_CHAR_PTR argv[]);
    OsalProcess GetMsopprofPid() { return msopprofPid_; }

 private:
    bool CheckMsopprofIfExist(int argc, CONST_CHAR_PTR argv[], std::vector<std::string> &opArgv) const;
    void ExecuteMsopprof(const std::vector<std::string> &opArgv);
private:
    std::string msopprofPath_;
    OsalProcess msopprofPid_;
};

} // namespace Msopprof
} // namespace Dvvp
} // namespace Analysis

#endif  // ANALYSIS_DVVP_MSPROFBIN_MSOPPROF_MANAGER_H_