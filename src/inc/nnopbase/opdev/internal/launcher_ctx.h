/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_LAUNCHER_CTX_H
#define OP_API_OP_API_COMMON_INC_OPDEV_LAUNCHER_CTX_H

#include "opdev/op_def.h"
#include "opdev/internal/tilingctx_builder.h"

namespace op::internal {

class LauncherContext {
public:
    const TilingResCache *GetTilingResCache()
    {
        return tilingRes_.get();
    }

    void SaveTilingResCache(const TilingCtxOutput *res)
    {
        tilingRes_ = std::make_unique<TilingResCache>(res);
    }

    void ClearTilingCache()
    {
        tilingRes_ = nullptr;
    }

    void SetImplMode(OpImplMode mode)
    {
        implMode_ = mode;
    }

    OpImplMode GetImplMode() const
    {
        return implMode_;
    }

    void SetLauncherRepeatable(bool val)
    {
        isLauncherRepeatable_ = val;
    }

    bool GetLauncherRepeatable() const
    {
        return isLauncherRepeatable_;
    }

    void Reset()
    {
        implMode_ = OpImplMode::IMPL_MODE_DEFAULT;
        ClearTilingCache();
    }

private:
    OpImplMode implMode_{OpImplMode::IMPL_MODE_DEFAULT};
    std::unique_ptr<TilingResCache> tilingRes_;
    bool isLauncherRepeatable_{false};
};

LauncherContext &GetLauncherCtx();

inline void SetOpImplModeCtx(OpArgList &optionArg)
{
    internal::GetLauncherCtx().SetImplMode(OpImplMode::IMPL_MODE_DEFAULT);
    optionArg.VisitByNoReturn([]([[maybe_unused]] size_t idx, OpArg &arg) {
        if (arg.type == OpArgType::OPARG_IMPLMODE) {
            internal::GetLauncherCtx().SetImplMode(static_cast<OpImplMode>(arg->value));
        }
    });
}
} // namespace op::internal

#endif
