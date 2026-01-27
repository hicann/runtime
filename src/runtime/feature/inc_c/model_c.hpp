/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_MODEL_C_HPP__
#define __CCE_RUNTIME_MODEL_C_HPP__

#include "model.hpp"

namespace cce {
namespace runtime {
    rtError_t ModelDebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId, Stream * const dftStm);
    rtError_t ModelDebugUnRegister(Model * const mdl, Stream * const dftStm);
    rtError_t MdlTaskUpdate(const Stream * const desStm, uint32_t desTaskId, Stream *sinkStm,
        rtMdlTaskUpdateInfo_t *para);
    rtError_t ModelLoadCompleteByStream(Model * const mdl);
    rtError_t AicpuMdlDestroy(Model * const mdl);
    rtError_t ModelSubmitExecuteTask(Model * const mdl, Stream * const streamIn);
    rtError_t MdlAbort(Model * const mdl);
    rtError_t MdlAddEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags);
    rtError_t MdlBindTaskSubmit(Model * const mdl, Stream * const streamIn,
        const uint32_t flag);
    rtError_t MdlUnBindTaskSubmit(Model * const mdl, Stream * const streamIn,
        const bool force);
}  // namespace runtime
}  // namespace cce
#endif