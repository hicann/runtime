/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_APP_APPLICATION_H
#define ANALYSIS_DVVP_APP_APPLICATION_H

#include <memory>
#include <sstream>
#include <string>
#include <vector>
#include "message/prof_params.h"
#include "transport.h"

namespace analysis {
namespace dvvp {
namespace app {
class Application {
public:
    static int32_t LaunchApp(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                         OsalProcess &appProcess);

private:
    static int32_t PrepareAppEnvs(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
        std::vector<std::string> &envsV);
    static int32_t PrepareLaunchAppCmd(std::stringstream &ssCmdApp,
                                   SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);

    static void PrepareAppArgs(const std::vector<std::string> &params, std::vector<std::string> &argsV);

    static int32_t PrepareAclEnvs(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                        std::vector<std::string> &envsV);

    static void SetAppEnv(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
        std::vector<std::string> &envsV);
    static void SourceEnv(std::vector<std::string> &argsVec);
    static std::string GetAppPath(std::vector<std::string> paramsCmd);
    static std::string GetCmdString(const std::string paramsName);
};
}  // namespace app
}  // namespace dvvp
}  // namespace analysis

#endif
