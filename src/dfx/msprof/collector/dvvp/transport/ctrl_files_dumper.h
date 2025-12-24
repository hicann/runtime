/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CTRL_FILES_DUMPER_H
#define CTRL_FILES_DUMPER_H
#include <string>
#include <cstring>
#include "singleton/singleton.h"

namespace analysis {
namespace dvvp {
namespace transport {
class CtrlFilesDumper : public analysis::dvvp::common::singleton::Singleton<CtrlFilesDumper> {
public:
    CtrlFilesDumper() {}
    virtual ~CtrlFilesDumper() {}
    
    int DumpCollectionTimeInfo(uint32_t deviceId, bool isHostProfiling, bool isStart);
private:
    void GeneratorCollectionTimeInfoName(std::string &fileName, const std::string &deviceId,
                                         bool isHostProfiling, bool isStart);
};

} // namespace transport
} // namespace dvvp
} // namespace analysis

#endif // CTRL_FILES_DUMPER_H