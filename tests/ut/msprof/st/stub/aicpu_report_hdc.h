/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPU_REPORT_HDC_H
#define AICPU_REPORT_HDC_H
#include "singleton/singleton.h"
#include "data_dumper.h"
#include "receive_data.h"


class AicpuReportHdc : public analysis::dvvp::common::singleton::Singleton<AicpuReportHdc> {
public:
    AicpuReportHdc();
    ~AicpuReportHdc() override;
public:
    int32_t Init(std::string &moduleName);
    int32_t UnInit();
    int32_t Report(Msprof::Engine::CONST_REPORT_DATA_PTR rData) const;
private:
    bool started_{false};
    SHARED_PTR_ALIA<Msprof::Engine::DataDumper> reporter_;
    std::mutex mtx_;
};
#endif