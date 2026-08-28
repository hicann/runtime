/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_LOGIC_SQ_UTILS_HPP__
#define __CCE_RUNTIME_LOGIC_SQ_UTILS_HPP__

#include "capture_model.hpp"
#include "stream.hpp"
#include <cstdint>
#include <vector>

namespace cce {
namespace runtime {

uint32_t CalcLogicSqRemainNum(const LogicSq* const logicSq, const uint32_t curHwPos);
rtError_t AssembleHostSqe(
    LogicSq* const logicSq, const uint32_t hwPos, Stream* const srcStm, const uint32_t streamPosStart,
    const uint32_t copyNum);
void FillHwPosMapping(
    LogicSq* const logicSq, Stream* const stm, const uint32_t hwPosStart, const uint32_t streamPosStart,
    const uint32_t sqeNum);
rtError_t CopySqeSegment(
    LogicSq* const logicSq, const uint32_t hwPos, Stream* const stm, const uint32_t streamPosStart,
    const uint32_t copyNum);
void BuildOneLogicSqEndProc(LogicSq* const logicSq, const uint32_t sqeNum, CaptureModel* const targetModel);
uint32_t AdjustCopyNumForMultiSqe(Stream* const stm, const uint32_t streamPosStart, const uint32_t copyNum);
rtError_t HandleDepthOverflow(
    LogicSq* const curLogicSq, const uint32_t hwPosTail, CaptureModel* const targetModel, Stream* const nextStream,
    LogicSq*& newLogicSq);
rtError_t BuildOneLogicSq(
    const std::vector<StreamRange>& streamRanges, CaptureModel* const targetModel, Device* const dev);

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_LOGIC_SQ_UTILS_HPP__
