/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ENV_MANAGER_H
#define ANALYSIS_DVVP_ENV_MANAGER_H
#include <vector>
#include <string>
#include "singleton/singleton.h"
namespace Analysis {
namespace Dvvp {
namespace App {
class EnvManager : public analysis::dvvp::common::singleton::Singleton<EnvManager> {
public:
    void SetGlobalEnv(std::vector<std::string> &envList);
    const std::vector<std::string> GetGlobalEnv();
    void SetParamEnv(std::string paramEnv);
    std::string GetParamEnv();
private:
    std::vector<std::string> envList_;
    std::string paramEnv_;
};
}
}
}
#endif