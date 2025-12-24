/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_CLOUD_V2_ANALYZER_H
#define DVVP_COLLECT_PLATFORM_CLOUD_V2_ANALYZER_H
#include "base_analyzer.h"

namespace Dvvp {
namespace Collect {
namespace Platform {

class CloudV2Analyzer : public BaseAnalyzer {
public:
    CloudV2Analyzer()
    {
        AdaptCloudV2PmuMap();
    }
    ~CloudV2Analyzer() {}

private:
    void AdaptCloudV2PmuMap() const
    {
        BaseAnalyzer::aicPmuMap_["PipeUtilization"] = {
            "0x416","0x417","0x9","0x302","0xc","0x303","0x54","0x55"
        };
        BaseAnalyzer::aivPmuMap_["PipeUtilization"] = {
            "0x8","0xa","0x9","0xb","0xc","0xd","0x54","0x55"
        };
    }
};
}
}
}
#endif