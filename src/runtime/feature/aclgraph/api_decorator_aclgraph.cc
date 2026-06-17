/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_decorator.hpp"
#include "dvpp_grp.hpp"

namespace cce {
namespace runtime {

rtError_t ApiDecorator::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode, Model * const mdl)
{
    return impl_->StreamBeginCapture(stm, mode, mdl);
}

rtError_t ApiDecorator::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    return impl_->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiDecorator::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                             Model ** const captureMdl)
{
    return impl_->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiDecorator::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    return impl_->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiDecorator::StreamEndTaskUpdate(Stream * const stm)
{
    return impl_->StreamEndTaskUpdate(stm);
}

rtError_t ApiDecorator::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    return impl_->ModelGetNodes(mdl, num);
}

rtError_t ApiDecorator::ModelDebugDotPrint(const Model * const mdl)
{
    return impl_->ModelDebugDotPrint(mdl);
}

rtError_t ApiDecorator::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    return impl_->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiDecorator::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    return impl_->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiDecorator::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    return impl_->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiDecorator::StreamBeginTaskGrp(Stream * const stm)
{
    return impl_->StreamBeginTaskGrp(stm);
}

rtError_t ApiDecorator::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    return impl_->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiDecorator::ModelCondHandleCreate(Model * const mdl, uint32_t defaultValue,
    rtCondHandleFlag_t flag, CondHandle ** const handle)
{
    return impl_->ModelCondHandleCreate(mdl, defaultValue, flag, handle);
}

rtError_t ApiDecorator::ModelCondHandleGetCondPtr(CondHandle * const handle, uint64_t ** const devPtr)
{
    return impl_->ModelCondHandleGetCondPtr(handle, devPtr);
}

rtError_t ApiDecorator::StreamAddCondTask(rtCondTaskParams params, Stream * const stm, uint32_t flags)
{
    return impl_->StreamAddCondTask(params, stm, flags);
}

} // namespace runtime
} // namespace cce
