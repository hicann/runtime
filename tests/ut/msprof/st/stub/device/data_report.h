/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DATA_REPORT_STUB_H
#define DATA_REPORT_STUB_H
#include <iostream>
#include <cstdint>
#include <map>
#include "prof_api.h"

namespace Cann {
namespace Dvvp {
namespace Test {
const int32_t REPORT_SUCCESS = 0;
const int32_t REPORT_FAILED = -1;

using ReportDataTest = struct ReporterData;
using HashDataTest = struct MsprofHashData;

class DataReport {
public:
    explicit DataReport(MsprofReporterModuleId moduleId) : moduleId_(moduleId) {}
    ~DataReport() {}
    bool CheckPoint(int32_t value);
    int32_t InitReport();
    int32_t StartReport();
    int32_t HashReport();
    int32_t MaxLenReport();
    int32_t StopReport();
private:
    MsprofReporterModuleId moduleId_;
};

}
}
}
#endif