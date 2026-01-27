/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_PROF_DEVICE_CORE_H
#define ANALYSIS_DVVP_DEVICE_PROF_DEVICE_CORE_H

#include "transport/hdc/hdc_transport.h"

#ifdef __cplusplus
extern "C" {
#endif
using namespace analysis::dvvp::transport;
int32_t IdeDeviceProfileInit();

int32_t IdeDeviceProfileProcess(HDC_SESSION session, CONST_TLV_REQ_PTR req);

int32_t IdeDeviceProfileCleanup();

#ifdef __cplusplus
}
#endif

#endif