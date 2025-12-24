/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ST_REPORT_STUB_H
#define ST_REPORT_STUB_H

#include "prof_api.h"
#include "prof_report_api.h"

extern "C" void ProfImplSetApiBufPop(const ProfApiBufPopCallback func);
extern "C" void ProfImplSetCompactBufPop(const ProfCompactBufPopCallback func);
extern "C" void ProfImplSetAdditionalBufPop(const ProfAdditionalBufPopCallback func);
extern "C" void ProfImplIfReportBufEmpty(const ProfReportBufEmptyCallback func);

static bool apiTryPop(uint32_t &aging, MsprofApi& data) {return false;}
static bool compactTryPop(uint32_t &aging, MsprofCompactInfo& data) {return false;}
static bool additionalTryPop(uint32_t &aging, MsprofAdditionalInfo& data) {return false;}
static bool ifReportBufEmpty() {return true;}

#endif