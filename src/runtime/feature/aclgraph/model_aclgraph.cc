/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "model.hpp"
#include <fstream>
#include "context.hpp"
#include "stream.hpp"
#include "capture_model.hpp"
#include "utils.h"

namespace cce {
namespace runtime {

uint32_t Model::ModelGetNodes(void) const
{
    uint32_t nodeNum = 0U;
    for (Stream * const stm : streams_) {
        nodeNum += stm->GetDelayRecycleTaskSqeNum();
    }

    return nodeNum;
}

rtError_t Model::ModelDebugDotPrint(void) const
{
    const uint32_t deviceId = context_->Device_()->Id_();
    RT_LOG(RT_LOG_EVENT, "model dot print begin, device_id=%u, model_id=%d.", deviceId, id_);

    for (Stream * const stm : streams_) {
        stm->DebugDotPrintForModelStm();
    }

    if (modelType_ == RT_MODEL_CAPTURE_MODEL) {
        const CaptureModel * const captureMdl = dynamic_cast<CaptureModel const *>(this);
        captureMdl->DebugDotPrintTaskGroups(deviceId);
    }

    RT_LOG(RT_LOG_EVENT, "model dot print end, device_id=%u, model_id=%d.", deviceId, id_);

    return RT_ERROR_NONE;
}

rtError_t Model::ModelDebugJsonPrint(const char* path, const unsigned int flags) const
{
    const uint32_t deviceId = context_->Device_()->Id_();
    RT_LOG(RT_LOG_EVENT, "model json print begin, device_id=%u, model_id=%d.", deviceId, id_);

    std::string realFilePath = RealPathForFileNotExists(path);
    std::ofstream outputFile(realFilePath);
    COND_RETURN_OUT_ERROR_MSG_CALL((!outputFile.is_open()), RT_ERROR_INVALID_VALUE,
        "Invalid JSON file path or failed to open %s", path);
    outputFile << "[\n";
    uint32_t streamCnt = 0;
    bool isLastStream = false;
    for (Stream * const stm : streams_) {
        streamCnt++;
        isLastStream = (streamCnt == streams_.size()) ? true : false;
        stm->DebugDotPrintForModelStm();
        stm->DebugJsonPrintForModelStm(outputFile, Id_(), isLastStream, flags);
    }
    outputFile << "]";
    outputFile.close();

    if (modelType_ == RT_MODEL_CAPTURE_MODEL) {
        const CaptureModel * const captureMdl = dynamic_cast<CaptureModel const *>(this);
        captureMdl->DebugDotPrintTaskGroups(deviceId);
    }

    RT_LOG(RT_LOG_EVENT, "model json print end, device_id=%u, model_id=%d.", deviceId, id_);

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
