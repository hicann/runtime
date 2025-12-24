/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DEVPROF_DRV_ADPROF_H
#define DEVPROF_DRV_ADPROF_H

#include <stdint.h>
#include "singleton/singleton.h"
#include "report_buffer.h"
#include "utils.h"

using AdprofStartFunc = int32_t (*)();

struct AdprofCallBack {
    int32_t (*start)();
    int32_t (*stop)();
    void (*exit)();
};

const uint32_t TLV_VERSION = 0x00000100;
const uint32_t TLV_TYPE = 1;

int32_t AdprofStartRegister(struct AdprofCallBack &adprofCallBack, uint32_t devId, int32_t hostPid);
int32_t ReportAdprofFileChunk(const void *data);

class DevprofDrvAdprof : public analysis::dvvp::common::singleton::Singleton<DevprofDrvAdprof> {
public:
    struct AdprofCallBack adprofCallBack_;
    analysis::dvvp::common::queue::ReportBuffer<analysis::dvvp::ProfileFileChunk> adprofFileChunkBuffer{
        analysis::dvvp::ProfileFileChunk{}};
};

#endif