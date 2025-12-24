/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __OP_RUN_CONTEXT_H__
#define __OP_RUN_CONTEXT_H__

#include <array>
#include <iostream>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

#include "aclnn/acl_meta.h"
#include "exe_graph/runtime/tiling_context.h"
#include "opdev/internal/infershape_context_holder.h"
#include "opdev/internal/kernel_context_holder.h"
#include "opdev/internal/kernel_utils.h"
#include "opdev/internal/memset_ctx_holder.h"
#include "opdev/internal/memset_op.h"
#include "opdev/internal/tilingctx_builder.h"
#include "opdev/op_errno.h"
#include "runtime/context.h"
#include "runtime/rts/rts_context.h"

namespace op::internal {
class OpRunContext {
public:
    gert::InferShapeContext *UpdateInferShapeCtx(uint32_t opType,
                                                 OpArgList &inputs,
                                                 OpArgList &outputs,
                                                 OpArgList &attrs)
    {
        const char *opTypeStr = OpTypeDict::ToString(opType).GetString();
        OP_CHECK(kernelCtx_.UpdateComputeNodeInfo(opTypeStr, inputs, outputs, attrs) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateComputeNodeInfo failed."), return nullptr);
        kernelCtx_.UpdateKernelExtendInfo(opTypeStr, opTypeStr);
        OP_CHECK(inferShapeCtx_.UpdateInferShapeContext(&kernelCtx_) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateInferShapeContext failed."), return nullptr);
        return inferShapeCtx_.GetInferShapeContext();
    }

    gert::TilingContext *UpdateTilingCtx(uint32_t opType, const TilingParseCtxHolder *tilingParseCtx,
                                         OpArgList &inputs,
                                         OpArgList &outputs,
                                         OpArgList &attrs)
    {
        const char *opTypeStr = OpTypeDict::ToString(opType).GetString();
        OP_CHECK(kernelCtx_.UpdateComputeNodeInfo(opTypeStr, inputs, outputs, attrs) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateComputeNodeInfo failed"), return nullptr);
        kernelCtx_.UpdateKernelExtendInfo(opTypeStr, opTypeStr);
        OP_CHECK(tilingCtx_.UpdateTilingCtx(&kernelCtx_, tilingParseCtx) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateTilingCtx failed"), return nullptr);
        return tilingCtx_.GetTilingCtx(tilingParseCtx);
    }

    gert::TilingContext *UpdateTilingCtx(uint32_t opType,
                                         OpArgList &inputs,
                                         OpArgList &outputs,
                                         OpArgList &attrs)
    {
        const char *opTypeStr = OpTypeDict::ToString(opType).GetString();
        OP_CHECK(kernelCtx_.UpdateComputeNodeInfo(opTypeStr, inputs, outputs, attrs) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateComputeNodeInfo failed"), return nullptr);
        kernelCtx_.UpdateKernelExtendInfo(opTypeStr, opTypeStr);
        OP_CHECK(tilingCtx_.UpdateTilingCtx(&kernelCtx_) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "UpdateTilingCtx failed"), return nullptr);
        return tilingCtx_.GetTilingCtx();
    }

    gert::TilingContext *UpdateTilingCtx4MemSetV2(const TilingParseCtxHolder *tilingParseCtx,
        OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
    {
        OP_CHECK(memSetV2kernelCtx_.UpdateComputeNodeInfo(MEMSET_V2_NAME.c_str(), inputs, outputs, attrs) == ACLNN_SUCCESS,
            OP_LOGE(ACLNN_ERR_INNER, "UpdateComputeNodeInfo failed"),
            return nullptr);
        memSetV2kernelCtx_.UpdateKernelExtendInfo(MEMSET_V2_NAME.c_str(), MEMSET_V2_NAME.c_str());
        OP_CHECK(memSetTilingCtx_.UpdateTilingCtx(&memSetV2kernelCtx_, tilingParseCtx) == ACLNN_SUCCESS,
            OP_LOGE(ACLNN_ERR_INNER, "UpdateTilingCtx failed"),
            return nullptr);
        return memSetTilingCtx_.GetTilingCtx(tilingParseCtx);
    }

    KernelContextHolder kernelCtx_;
    KernelContextHolder memSetV2kernelCtx_;
    InferShapeContextHolder inferShapeCtx_;
    TilingCtxHolder tilingCtx_;
    TilingCtxHolder memSetTilingCtx_;
};

class OpRunContextMgr {
public:
    static aclnnStatus InitOpFunctions(uint32_t opType);

    static aclnnStatus InferShape(uint32_t opType, OpArgList &inputs, OpArgList &outputs,
                                  OpArgList &attrs)
    {
        CHECK_COND(InitOpFunctions(opType) == ACLNN_SUCCESS, ACLNN_SUCCESS, "InitOpFunctions failed");
        if (opInferShapeFuncs_[opType] == nullptr || opInferShapeFuncs_[opType]->infer_shape == nullptr) {
            OP_LOGE(
                ACLNN_ERR_INNER, "Op has no infershape func, opType: %s", op::OpTypeDict::ToString(opType).GetString());
            return ACLNN_ERR_INNER;
        }
        gert::InferShapeContext *ctx = opRunCtx_.UpdateInferShapeCtx(opType, inputs, outputs, attrs);
        auto ret = opInferShapeFuncs_[opType]->infer_shape(ctx);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGE(ACLNN_ERR_INNER, "infer shape fail, [%u]", ret);
            return ACLNN_ERR_INNER;
        }
        return ACLNN_SUCCESS;
    }

    static aclnnStatus GenSimplifiedKey(uint32_t opType, char *simplifiedKey, OpArgList &inputs,
                                        OpArgList &outputs, OpArgList &attrs)
    {
        InitOpFunctions(opType);
        if (opTilingFuncs_[opType] == nullptr || opTilingFuncs_[opType]->gen_simplifiedkey == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Op has no gen_simplifiedkey func, opType: %s",
                op::OpTypeDict::ToString(opType).GetString());
            return ACLNN_ERR_INNER;
        }
        auto ctx = opRunCtx_.UpdateTilingCtx(opType, inputs, outputs, attrs);
        auto ret = opTilingFuncs_[opType]->gen_simplifiedkey(ctx, simplifiedKey);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGE(ACLNN_ERR_INNER, "gen simplified key failed");
            return ACLNN_ERR_INNER;
        }
        return ACLNN_SUCCESS;
    }

    static const TilingCtxOutput *Tiling(uint32_t opType, const TilingParseCtxHolder *tilingParseCtx,
                                         OpArgList &inputs,
                                         OpArgList &outputs,
                                         OpArgList &attrs)
    {
        OP_CHECK(tilingParseCtx != nullptr, OP_LOGE(ACLNN_ERR_INNER, "Tiling parse ctx is NULL"), return nullptr);
        InitOpFunctions(opType);
        if (opTilingFuncs_[opType] == nullptr || opTilingFuncs_[opType]->tiling == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Op has no Tiling func, opType: %s", op::OpTypeDict::ToString(opType).GetString());
            return nullptr;
        }
        auto ctx = opRunCtx_.UpdateTilingCtx(opType, tilingParseCtx, inputs, outputs, attrs);
        OP_CHECK(ctx != nullptr, OP_LOGE(ACLNN_ERR_INNER, "opRunCtx_.UpdateTilingCtx failed."), return nullptr);
        auto ret = opTilingFuncs_[opType]->tiling(ctx);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGE(ACLNN_ERR_INNER, "Tiling failed");
            return nullptr;
        }
        return opRunCtx_.tilingCtx_.GetTilingResult();
    }

    static const TilingCtxOutput *GetCachedTilingRes(const TilingResCache &res)
    {
        return opRunCtx_.tilingCtx_.GetTilingResFromCache(res);
    }

    static const TilingCtxOutput *Tiling4MemSet(const TilingParseCtxHolder *tilingParseCtx,
                                                const std::vector<MemSetTensorInfo> &memsetTensorInfo)
    {
        static uint32_t opType = OpTypeDict::ToOpType("MemSet");
        OP_CHECK(InitOpFunctions(opType) == ACLNN_SUCCESS,
                 OP_LOGE(ACLNN_ERR_INNER, "InitOpFunctions failed"),
                 return nullptr);
        if (opTilingFuncs_[opType] == nullptr || opTilingFuncs_[opType]->tiling == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Memset Op has no Tiling func");
            return nullptr;
        }

        aclnnStatus rc = memSetCtx_.UpdateComputeNodeInfo(memsetTensorInfo);
        OP_CHECK(rc == OK, OP_LOGE(ACLNN_ERR_INNER, "MemSet op UpdateComputeNodeInfo failed"), return nullptr);
        rc = opRunCtx_.memSetTilingCtx_.UpdateTilingCtx(static_cast<KernelContextHolder *>(&memSetCtx_),
                                                        tilingParseCtx);
        OP_CHECK(rc == OK, OP_LOGE(ACLNN_ERR_INNER, "MemSet op UpdateTilingCtx failed"), return nullptr);
        auto ctx = opRunCtx_.memSetTilingCtx_.GetTilingCtx(tilingParseCtx);
        auto ret = opTilingFuncs_[opType]->tiling(ctx);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGE(ACLNN_ERR_INNER, "MemSet Tiling failed, opType: %s", op::OpTypeDict::ToString(opType).GetString());
            return nullptr;
        }
        return opRunCtx_.memSetTilingCtx_.GetTilingResult();
    }

    static const TilingCtxOutput *Tiling4MemSetV2(uint32_t opType, const TilingParseCtxHolder *tilingParseCtx,
        OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
    {
        OP_CHECK(tilingParseCtx != nullptr, OP_LOGE(ACLNN_ERR_INNER, "Tiling parse ctx is NULL"), return nullptr);
        OP_CHECK(InitOpFunctions(opType) == ACLNN_SUCCESS,
            OP_LOGE(ACLNN_ERR_INNER, "InitOpFunctions failed"),
            return nullptr);
        if (opTilingFuncs_[opType] == nullptr || opTilingFuncs_[opType]->tiling == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Op has no Tiling func");
            return nullptr;
        }
        auto ctx = opRunCtx_.UpdateTilingCtx4MemSetV2(tilingParseCtx, inputs, outputs, attrs);
        OP_CHECK(ctx != nullptr, OP_LOGE(ACLNN_ERR_INNER, "UpdateTilingCtx4MemSetV2 failed."), return nullptr);
        auto ret = opTilingFuncs_[opType]->tiling(ctx);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGE(ACLNN_ERR_INNER, "Tiling failed");
            return nullptr;
        }
        return opRunCtx_.memSetTilingCtx_.GetTilingResult();
    }

    static const gert::OpImplKernelRegistry::OpImplFunctions *GetOpTilingFuncs(uint32_t opType)
    {
        return opTilingFuncs_[opType];
    };

    static const TilingCtxOutput *GetStaticTilingCtxOutput(uint32_t opType, int64_t staticBlockDim,
                                                           bool atomicCleanFlag, uint8_t scheduleMode,
                                                           FVector<size_t> &staticWorkspaceSize,
                                                           OpArgList &inputs, OpArgList &outputs,
                                                           OpArgList &attrs)
    {
        const char *opTypeStr = OpTypeDict::ToString(opType).GetString();
        OP_CHECK(opRunCtx_.kernelCtx_.UpdateComputeNodeInfo(opTypeStr, inputs, outputs, attrs) == ACLNN_SUCCESS,
                OP_LOGE(ACLNN_ERR_INNER, "failed to UpdateComputeNodeInfo"),
                return nullptr);
        auto ret = const_cast<TilingCtxOutput *>(opRunCtx_.tilingCtx_.GetTilingResult());
        *ret->blockDim_ = staticBlockDim;
        OP_LOGD("Block dim is %ld", *ret->blockDim_);
        *ret->atomicCleanFlag_ = atomicCleanFlag;
        ret->workspaceSize_->SetSize(staticWorkspaceSize.size());
        for (size_t i = 0; i < staticWorkspaceSize.size(); ++i) {
            ret->workspaceSize_->MutableData()[i] = staticWorkspaceSize[i];
        }

        *ret->scheduleMode_ = scheduleMode;
        OP_LOGD("scheduleMode_ dim is %u", *ret->scheduleMode_);
        *ret->tilingKey_ = 0;
        ret->tilingData_->data_size_ = 0;
        *ret->tilingCond_ = 0;
        ret->inputNum_ = opRunCtx_.kernelCtx_.inputNum_;
        ret->outputNum_ = opRunCtx_.kernelCtx_.outputNum_;
        return ret;
    }

    static void RecordOpInfo(uint32_t opType, const aclnnOpInfoRecord::OpKernelInfo &kernelInfo, const std::string &implMode,
                             OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
    {
        if (opProfilingSwitch.recordOpArgFlag) {
            gert::TilingContext *ctx = opRunCtx_.UpdateTilingCtx(opType, inputs, outputs, attrs);
            int64_t determinConfig = 0;
            const rtError_t rtErr = rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &determinConfig);
            if (rtErr != RT_ERROR_NONE) {
                OP_LOGW("rtsCtxGetSysParamOpt error, errorCode is %d", static_cast<int32_t>(rtErr));
                return;
            }
            auto opts = aclnnOpInfoRecord::OpCompilerOption(implMode, static_cast<bool>(determinConfig));
            OP_LOGI("Call ExeOptInfoStat, option %d %s. kernel info %d %s.", opts.deterministic,
                    opts.impl_mode.c_str(), kernelInfo.bin_type, kernelInfo.bin_info.c_str());
            aclnnOpInfoRecord::OpInfoSerialize(ctx, opts, &kernelInfo);
        }
    }

private:
    static thread_local MemSetKernelContextHolder memSetCtx_;
    static thread_local OpRunContext opRunCtx_; // tiling may be run in different thread
    static std::array<const gert::OpImplKernelRegistry::OpImplFunctions *, MAX_OP_TYPE_COUNT> opInferShapeFuncs_;
    static std::array<const gert::OpImplKernelRegistry::OpImplFunctions *, MAX_OP_TYPE_COUNT> opTilingFuncs_;
};

class SocContext {
public:
    static aclnnStatus SetupPlatformInfo();
    static fe::PlatFormInfos *GetPlatformInfo() { return &platformInfo_; }

private:
    static thread_local fe::PlatFormInfos platformInfo_;
};

} // namespace op::internal

#endif //__OP_RUN_CONTEXT_H__
