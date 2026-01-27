/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_HWTS_ENGINE_HPP
#define CCE_RUNTIME_HWTS_ENGINE_HPP

#include "engine.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "package_rebuilder.hpp"

namespace cce {
namespace runtime {
class HwtsEngine : public Engine {
public:
    using Engine::Engine;
    virtual ~HwtsEngine() = default;

protected:
    // handle overflow cqe
    void ProcessOverFlowReport(const rtTaskReport_t * const errorReport, const uint32_t tsRetCode) const;
    void ProcessNullTaskOverFlowReport(const uint32_t streamId, const uint32_t taskId,
        const uint32_t retCode) const;

    void ReportReceive(const rtTaskReport_t * const report, TaskInfo * const reportTask);
    void ReportExceptProc(const TaskInfo * const reportTask, const uint32_t errCode, const uint32_t errorDesc = 0xFFFFFFFFU);
    Kernel* SearchErrorKernel(const uint16_t devId, const Program* const prog) const;

private:
    PackageRebuilder rebuilder_;
}; // class HwtsEngine
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_HWTS_ENGINE_HPP