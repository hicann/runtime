/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROFILER_MSPROFTXREPORTER_H
#define PROFILER_MSPROFTXREPORTER_H

#include "prof_api.h"
#include "prof_report_api.h"

namespace Msprof {
namespace MsprofTx {
class MsprofTxReporter {
public:
    MsprofTxReporter();
    virtual ~MsprofTxReporter();
    int32_t Init();
    int32_t UnInit();
    void SetReporterCallback(const ProfAdditionalBufPushCallback func);
    int32_t Report(MsprofTxInfo &data) const;

private:
    bool isInit_;
    ProfAdditionalBufPushCallback reporterCallback_;
};
}
}

#endif // PROFILER_MSPROFTXREPORTER_H
