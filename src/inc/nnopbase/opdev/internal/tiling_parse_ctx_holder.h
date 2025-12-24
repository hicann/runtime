/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __TILING_PARSE_CTX_HOLDER_H__
#define __TILING_PARSE_CTX_HOLDER_H__

#include <array>
#include <iostream>
#include <string>
#include <vector>

#include "nlohmann/json.hpp"
#include "exe_graph/runtime/tiling_context.h"
#include "op_info_serialize.h"
#include "register/op_impl_space_registry.h"

#include "opdev/op_def.h"
#include "opdev/internal/kernel_context_holder.h"

namespace op::internal {

void UpdateThradLocalPlatformInfo(fe::PlatFormInfos *platformInfo, const uint32_t &coreNum, const uint32_t &cubeCoreNum,
    const uint32_t &vectorCoreNum);

class TilingParseCtxHolder {
public:
    AsyncAnyValue *GetCompiledInfoStruct() const
    {
        return &tilingParseCtxValue_[kCompileInfoStruct];
    }

    AsyncAnyValue *GetDeterministic() const
    {
        return const_cast<AsyncAnyValue *>(&Deterministic_);
    }

    uint32_t GetCoreNum() const
    {
        return coreNum_;
    }

    ~TilingParseCtxHolder();

    aclnnStatus BuildTilingParseCtx(uint32_t opType, const gert::OpImplKernelRegistry::OpImplFunctions *tilingFuncs,
                                    const nlohmann::json &opJson, fe::PlatFormInfos *platformInfo,
                                    const aclnnOpInfoRecord::OpCompilerOption &compileOptions,
                                    const aclnnOpInfoRecord::OpKernelInfo &opKernelInfo);

    const aclnnOpInfoRecord::OpCompilerOption& GetCompileOptions() const;

    const aclnnOpInfoRecord::OpKernelInfo* GetOpKernelInfo() const;

    void ReleaseTilingParse()
    {
        if (tilingParseInfoDeleter && tilingParseInfo_.compileInfoStruct_) {
            tilingParseInfoDeleter(tilingParseInfo_.compileInfoStruct_);
        }
        tilingParseInfo_.compileInfoStruct_ = nullptr;
    }
private:
    enum TilingParserIndex {
        // inputs
        kCompileInfo,
        kPlatformInfo,
        kOpType,
        // outputs
        kCompileInfoStruct,
        // add new output definitions here
        kParseOutputNum
    };

    struct TilingParseInfo {
        const char *compileInfo_;
        fe::PlatFormInfos *platformInfo_;
        const char *opType_;
        void *compileInfoStruct_;
        std::string compileInfoStr_;
    };
    TilingParseInfo tilingParseInfo_{};
    gert::OpImplRegisterV2::CompileInfoDeleterFunc tilingParseInfoDeleter{nullptr};

    KernelRunContext *tilingParseCtx_{nullptr};
    AsyncAnyValue *tilingParseCtxValue_{nullptr};

    std::string kernelName_;
    std::string opTypeStr_;
    aclnnOpInfoRecord::OpCompilerOption compileOptions_{"", false};
    ComputeNodeInfo dummyComputeNodeInfo_;
    KernelExtendInfo dummyKernelInfo_;
    static constexpr size_t MAX_COMPILE_INFO_STRUCT_SIZE = 32 * 1024;
    aclnnOpInfoRecord::OpKernelInfo opKernelInfo_{"", 0};
    uint32_t coreNum_{0};
    AsyncAnyValue Deterministic_;
};

} // namespace op::internal

#endif // __TILING_PARSE_CTX_HOLDER_H__
