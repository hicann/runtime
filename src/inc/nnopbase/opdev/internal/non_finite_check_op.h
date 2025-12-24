/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __NON_FINITE_CHECK_OP_H__
#define __NON_FINITE_CHECK_OP_H__

#include "acl/acl.h"
#include "opdev/op_def.h"
#include "kernel_utils.h"
#include "kernel_arg.h"
#include "opdev/op_dfx.h"
#include "opdev/internal/kernel_arg.h"
#include "opdev/internal/kernel_mgr.h"
#include "opdev/internal/op_kernel.h"
#include "opdev/internal/bridge/bridge_pool.h"
#include "opdev/op_log.h"
#include "opdev/op_executor.h"
#include "runtime/rts/rts_mem.h"
#include "runtime/rts/rts_stream.h"

#include <unordered_map>
#include <string>

namespace op {
namespace internal {
constexpr uint16_t kModelId = 36; // AICPU

class NonFiniteCheckOpKernel : public OpKernel {
public:
    OpKernelBin *SelectBin(op::DataType dtype)
    {
        if (dtype2KernelBin_.find(dtype) != dtype2KernelBin_.end()) {
            return dtype2KernelBin_[dtype];
        }
        OP_CHECK(bins_.size() != 0, OP_LOGW("no NonFiniteCheck op kernel bin"), return nullptr);
        for (auto &elem : bins_) {
            elem.second->JsonLoad();
            auto &opJson = elem.second->binJson_.GetVar();
            if (!opJson.contains("supportInfo") || !(opJson["supportInfo"].contains("inputs")) ||
                opJson["supportInfo"]["inputs"].size() < 1 || opJson["supportInfo"]["inputs"][0].size() < 1 ||
                !opJson["supportInfo"]["inputs"][0][0].contains("dtype")) {
                OP_LOGW("json parse error. does not contain supportInfo or inputs.");
                continue;
            }
            std::string dtypeStr = opJson["supportInfo"]["inputs"][0][0]["dtype"].get<std::string>();
            auto it = dtypeMap_.find(dtypeStr);
            if (it != dtypeMap_.end() && it->second == dtype) {
                dtype2KernelBin_[dtype] = elem.second.get();
                return elem.second.get();
            }
        }
        return nullptr;
    }

    static std::unordered_map<std::string, op::DataType> dtypeMap_;

private:
    thread_local static std::unordered_map<op::DataType, OpKernelBin *> dtype2KernelBin_;
};

class NonFiniteCheckOpKernelBin : public OpKernelBin {
public:
    aclnnStatus CreateWorkSpace(aclOpExecutor *executor, OpArgList &inputArgList, OpArgList &outputArgList,
                                aclTensor *&workspaceTensor)
    {
        const size_t *workspaceSize = nullptr;
        size_t workspaceNum = 0;
        OpArgList dummyArgList;
        auto ret = GetWorkspace(workspaceSize, workspaceNum, inputArgList, outputArgList, dummyArgList);
        OP_CHECK((ret == ACLNN_SUCCESS && workspaceNum == 1),
                  OP_LOGW("GetWorkspace ret: %d, invalid workspace num %zu", ret, workspaceNum),
                  return ACLNN_ERR_INNER);

        workspaceTensor = executor->AllocTensor({static_cast<int64_t>(workspaceSize[0])},
            op::DataType::DT_INT8, ge::FORMAT_ND);
        if (!workspaceTensor) {
            OP_LOGW("failed to init non finite check workspace tensor");
            return ACLNN_ERR_INNER;
        }
        void *wsAddr = nullptr;
        rtMallocAttrValue moduleIdValue;
        moduleIdValue.moduleId = kModelId;
        rtMallocAttribute_t attrs{.attr = RT_MEM_MALLOC_ATTR_MODULE_ID, .value = moduleIdValue};
        rtMallocConfig_t cfg{.attrs = &attrs, .numAttrs = 1};
        ret = rtsMalloc(&wsAddr, workspaceSize[0], RT_MEM_TYPE_HIGH_BAND_WIDTH, RT_MEM_ADVISE_NONE, &cfg);
        OP_CHECK(ret == ACL_SUCCESS, OP_LOGW("failed to call rtsMalloc, ret %d", ret), return ACLNN_ERR_INNER);

        workspaceTensor->SetStorageAddr(wsAddr);
        OP_LOGD("create non finite check op workspace size %zu", workspaceSize[0]);
        return ACLNN_SUCCESS;
    }

    aclnnStatus Launch(aclrtStream stream, OpArgContext *args,
                       OpArgList &tilingInputArgList, OpArgContext *nonFiniteCheckOpArgs)
    {
        aclnnStatus ret = BinLoad();
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("BinLoad failed, ret: %d", ret), return ret);

        const TilingCtxOutput *res = nullptr;
        ret = InitTilingParseCtx();
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("InitTilingParseCtx failed, ret: %d", ret), return ret);
        {
            uint32_t tilingProfilingId = 0;
            if (op::internal::opProfilingSwitch.reportFlag) {
                std::string tilingFuncName = std::string(op::OpTypeDict::ToString(opType_).GetString()) + "_Tiling";
                tilingProfilingId = CollectProfilingStr(tilingFuncName.c_str());
            }
            OpDfxGuard tilingGuard(tilingProfilingId, DFXProfilingTiling);
            const TilingResCache *tilingCache = nullptr;
            if ((tilingCache = GetLauncherCtx().GetTilingResCache()) != nullptr) {
                OP_LOGD("Get cached tiling result");
                res = OpRunContextMgr::GetCachedTilingRes(*tilingCache);
            } else {
                OpArgList dummyArgList;
                res = OpRunContextMgr::Tiling(opType_,
                    tilingParseCtxHolder_[ThreadCoreNum(GetThreadLocalContext().opConfigInfo_.aicNum_,
                                              GetThreadLocalContext().opConfigInfo_.aivNum_)]
                        .get(),
                    tilingInputArgList,
                    *nonFiniteCheckOpArgs->GetOpArg(op::OP_OUTPUT_ARG),
                    dummyArgList);
            }
            OP_CHECK(res != nullptr, OP_LOGW("Tiling Failed."), return ACLNN_ERR_INNER_NULLPTR);
        }

        uint64_t summaryId = 0;
        if (opProfilingSwitch.kernelLaunchFlag) {
            summaryId = GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                                         GetThreadLocalContext().logInfo_.l0Name,
                                         op::OpTypeDict::ToString(opType_).GetString());
        }
        {
            OpDfxGuard kernelLaunchGuard(summaryId, DfxProfilingKernelLaunch);
            std::vector<int32_t> tensorOffset;
            auto rc = DoLaunch<RtsArg>(res, stream, false, nonFiniteCheckOpArgs, tensorOffset);
            OP_CHECK(rc == ACLNN_SUCCESS, OP_LOGW("launch non finite check op failed, ret %d", rc), return rc);
        }
        if (IsPrintFEnable()) {
            DumpWorkspaceData(stream, args);
        }
        static uint64_t kernelLaunchId = GenKernelLauncherId("NonFiniteCheck");
        if (opProfilingSwitch.kernelLaunchFlag && opProfilingSwitch.additionInfoFlag) {
            ReportAdditionInfo(GetTaskInfo(*(res->tilingKey_)), kernelLaunchId, summaryId);
        }
        return ACLNN_SUCCESS;
    }
};

struct NonFiniteCheckTensorList {
    NonFiniteCheckTensorList() = default;

    ~NonFiniteCheckTensorList()
    {
        if (buf_) {
            op::internal::DeAllocate(buf_);
        }
    }

    aclTensor *ToTensor(aclOpExecutor *executor)
    {
        uint64_t wordCnt = size_ / sizeof(int64_t);
        return executor->AllocHostTensor(reinterpret_cast<int64_t *>(buf_), wordCnt, op::DataType::DT_INT64);
    }

    void CalSize(std::vector<aclTensor *> &checkTensors)
    {
        ptrOffset_ = sizeof(int64_t);
        size_ = sizeof(int64_t); // ptr_offset;
        for (auto &tensor : checkTensors) {
            const op::Shape &viewShape = tensor->GetViewShape();
            size_t dimNum = viewShape.GetDimNum();
            size_ += sizeof(int64_t) * (dimNum + 1); // dim_cnt + each_dim
            ptrOffset_ += sizeof(int64_t) * (dimNum + 1);
            OP_LOGD("tensor dimNum %zu", dimNum);
            size_ += sizeof(int64_t); // ptr
        }
        OP_LOGD("size %zu ptrOffset %zu", size_, ptrOffset_);
    }

    aclnnStatus Init(std::vector<aclTensor *> &checkTensors)
    {
        CalSize(checkTensors);
        buf_ = static_cast<uint8_t *>(op::internal::Allocate(size_));
        OP_CHECK(buf_ != nullptr, OP_LOGW("failed to allocate memory"), return ACLNN_ERR_INNER);

        pos_ = buf_;
        AppendWord(ptrOffset_);
        for (auto &tensor : checkTensors) {
            AppendTensor(tensor);
        }
        return ACLNN_SUCCESS;
    }

    void AppendWord(int64_t value)
    {
        *reinterpret_cast<int64_t *>(pos_) = value;
        pos_ += sizeof(int64_t);
    }

    void AppendTensor(aclTensor *tensor)
    {
        const op::Shape &viewShape = tensor->GetViewShape();
        size_t dimNum = viewShape.GetDimNum();
        AppendWord(dimNum);
        for (size_t i = 0; i < dimNum; i++) {
            AppendWord(viewShape.GetDim(i));
        }
        *reinterpret_cast<int64_t *>(buf_ + ptrOffset_) = PtrToValue(tensor->GetData());
        ptrOffset_ += sizeof(int64_t);
    }

    aclTensor *tensor_ = nullptr;
    uint8_t *pos_ = nullptr;
    uint8_t *buf_ = nullptr;
    size_t ptrOffset_ = 0;
    size_t size_ = 0;
};

struct NonFiniteCheckOpContext {
    NonFiniteCheckOpContext(aclOpExecutor *executor, aclrtStream stream, OpArgContext *opArgCtx)
        : executor_(executor), stream_(stream), opArgCtx_(opArgCtx), bin_(nullptr) {};

    aclOpExecutor *executor_;
    aclrtStream stream_;
    OpArgContext *opArgCtx_;
    NonFiniteCheckOpKernelBin *bin_;
};

class NonFiniteCheckOp {
public:
#if defined(NNOPBASE_UT) || defined(NNOPBASE_ST)
    static aclnnStatus RunNonfiniteCheckOp([[maybe_unused]]NonFiniteCheckOpContext &nonFiniteCheckOpCtx, bool &dump);
#else
    static aclnnStatus RunNonfiniteCheckOp(NonFiniteCheckOpContext &nonFiniteCheckOpCtx, bool &dump)
    {
        static uint32_t opid = OpTypeDict::ToOpType("NonFiniteCheck");
        (void)gKernelMgr.AclOpKernelInit(opid);

        std::unordered_map<op::DataType, std::vector<aclTensor *>> dtype2Tensors;
        CollectNonFiniteCheckTensor(dtype2Tensors, nonFiniteCheckOpCtx.opArgCtx_);
        for (auto &dtypeTensorPair : dtype2Tensors) {
            OP_LOGI("there are %zu tensors with type %s to be checked", dtypeTensorPair.second.size(),
                    op::ToString(dtypeTensorPair.first).GetString());
            if (dtypeTensorPair.second.size() == 0) {
                OP_LOGW("Tensor number is zero!!!");
                continue;
            }
            // select bin
            OpKernelBin *bin = nullptr;
            aclnnStatus ret = SelectNonFiniteCheckOpBin(bin, opid, dtypeTensorPair.first);
            if (ret != ACLNN_SUCCESS || bin == nullptr) {
                OP_LOGW("failed to select non finite check op bin");
                continue;
            }
            // launch
            void *outputAddr = nullptr;
            void *wsAddr = nullptr;
            nonFiniteCheckOpCtx.bin_ = static_cast<NonFiniteCheckOpKernelBin *>(bin);
            ret = LaunchNonFiniteCheckOp(nonFiniteCheckOpCtx, dtypeTensorPair.second, outputAddr, wsAddr);
            DevPtrGuard outputGuard(outputAddr);
            DevPtrGuard wsGuard(wsAddr);
            OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("failed to launch non finite check op bin, ret: %d", ret), return ret);

            auto rc = rtsStreamSynchronize(nonFiniteCheckOpCtx.stream_, -1);
            OP_CHECK(rc == RT_ERROR_NONE, OP_LOGW("rtsStreamSynchronize failed, ret %d", ret), return ACLNN_ERR_INNER);

            float status = 0;
            rc = rtMemcpy(&status, sizeof(float), outputAddr, sizeof(float), RT_MEMCPY_DEVICE_TO_HOST);
            OP_CHECK(rc == RT_ERROR_NONE, OP_LOGW("artMemcpy failed, ret %d", ret), return ACLNN_ERR_INNER);
            OP_LOGD("non finete check status %f", status);
            if (static_cast<int>(status) == 1) {
                dump = true;
                return ACLNN_SUCCESS;
            }
        }
        dump = false;
        return ACLNN_SUCCESS;
    }
#endif

private:
    static aclnnStatus SelectNonFiniteCheckOpBin(OpKernelBin *&opBin, const uint32_t opid, op::DataType dtype)
    {
        NonFiniteCheckOpKernel *kernel = static_cast<NonFiniteCheckOpKernel *>(gKernelMgr.GetKernel(opid));
        OP_CHECK(kernel != nullptr, OP_LOGW("failed to get non finite check kernel"), return ACLNN_ERR_INNER);
        opBin = kernel->SelectBin(dtype);
        OP_CHECK(opBin != nullptr, OP_LOGW("failed to select non finite check kernel bin"), return ACLNN_ERR_INNER);
        return ACLNN_SUCCESS;
    }

    static bool IsNeedNonFiniteCheck(const aclTensor *tensor)
    {
        op::DataType dtype = tensor->GetDataType();
        return dtype == op::DataType::DT_FLOAT ||
               dtype == op::DataType::DT_BF16 ||
               dtype == op::DataType::DT_FLOAT16;
    }

    static void CollectNonFiniteCheckTensor(
        std::unordered_map<op::DataType, std::vector<aclTensor *>> &dtype2Tensors, aclTensor *tensor)
    {
        if (tensor && !tensor->IsEmpty() && IsNeedNonFiniteCheck(tensor)) {
            dtype2Tensors[tensor->GetDataType()].emplace_back(tensor);
        }
    }

    static void CollectNonFiniteCheckTensor(
        std::unordered_map<op::DataType, std::vector<aclTensor *>> &dtype2Tensors, aclTensorList *tensorList)
    {
        if (tensorList) {
            for (uint64_t i = 0; i < tensorList->Size(); i++) {
                if ((*tensorList)[i] && !(*tensorList)[i]->IsEmpty() && IsNeedNonFiniteCheck((*tensorList)[i])) {
                    dtype2Tensors[(*tensorList)[i]->GetDataType()].emplace_back((*tensorList)[i]);
                }
            }
        }
    }

    static void CollectNonFiniteCheckTensor(
        std::unordered_map<op::DataType, std::vector<aclTensor *>> &dtype2Tensors, OpArgContext *args)
    {
        if (args->ContainsOpArgType(op::OP_OUTPUT_ARG)) {
            OpArgList *outputs = args->GetOpArg(op::OP_OUTPUT_ARG);
            outputs->VisitByNoReturn([&dtype2Tensors]([[maybe_unused]] size_t idx, OpArg &arg) {
                if (arg.type == OpArgType::OPARG_ACLTENSOR) {
                    aclTensor *tensor = reinterpret_cast<aclTensor *>(arg->pointer);
                    CollectNonFiniteCheckTensor(dtype2Tensors, tensor);
                } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
                    aclTensorList *tensorList = reinterpret_cast<aclTensorList *>(arg->pointer);
                    CollectNonFiniteCheckTensor(dtype2Tensors, tensorList);
                } else {
                    OP_LOGW("invalid output type %d for NonFiniteCheck kernel", static_cast<int>(arg.type));
                }
            });
        }
    }

    static aclnnStatus PrepareNonFiniteCheckOpArgs(
        NonFiniteCheckOpContext &nonFiniteCheckOpCtx, std::vector<aclTensor *> &checkTensors,
        OpArgList &tilingInputArgList, OpArgContext &nonFiniteCheckOpArgCtx, OpArg *&nonFiniteCheckOpArg)
    {
        NonFiniteCheckTensorList tensorList;
        aclnnStatus ret = tensorList.Init(checkTensors);
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("failed to init non finite check tensorlist, ret: %d", ret), return ret);

        aclTensor *inputTensor = tensorList.ToTensor(nonFiniteCheckOpCtx.executor_);
        OP_CHECK(inputTensor != nullptr,
                 OP_LOGW("failed to init non finite check input tensor"), return ACLNN_ERR_INNER);

        aclTensor *outputTensor =
            nonFiniteCheckOpCtx.executor_->AllocTensor({1}, op::DataType::DT_FLOAT, ge::FORMAT_ND);
        OP_CHECK(outputTensor != nullptr,
                 OP_LOGW("failed to init non finite check output tensor"), return ACLNN_ERR_INNER);
        void *outputAddr = nullptr;
        rtMallocAttrValue moduleIdValue;
        moduleIdValue.moduleId = kModelId;
        rtMallocAttribute_t attrs{.attr = RT_MEM_MALLOC_ATTR_MODULE_ID, .value = moduleIdValue};
        rtMallocConfig_t cfg{.attrs = &attrs, .numAttrs = 1};
        ret = rtsMalloc(&outputAddr, sizeof(float), RT_MEM_TYPE_HIGH_BAND_WIDTH, RT_MEM_ADVISE_NONE, &cfg);
        OP_CHECK(ret == ACL_SUCCESS, OP_LOGW("failed to call rtsMalloc, ret %d", ret), return ACLNN_ERR_INNER);
        outputTensor->SetStorageAddr(outputAddr);

        OpArg outputArg;
        outputArg.type = OpArgType::OPARG_ACLTENSOR;
        outputArg->pointer = outputTensor;
        OpArgList outputArgList(&outputArg, 1);

        aclTensor *workspaceTensor = nullptr;
        ret = nonFiniteCheckOpCtx.bin_->CreateWorkSpace(
            nonFiniteCheckOpCtx.executor_, tilingInputArgList, outputArgList, workspaceTensor);
        if (ret != ACLNN_SUCCESS || !workspaceTensor) {
            OP_LOGW("failed to init non finite check workspace tensor");
            rtsFree(outputAddr);
            return ACLNN_ERR_INNER;
        }

        OpArgContextInit(nonFiniteCheckOpArgCtx, nonFiniteCheckOpArg,
                         OP_INPUT(inputTensor), OP_OUTPUT(outputTensor), OP_WORKSPACE(workspaceTensor));
        return ACLNN_SUCCESS;
    }

    static aclnnStatus LaunchNonFiniteCheckOp(NonFiniteCheckOpContext &nonFiniteCheckOpCtx,
                                              std::vector<aclTensor *> &checkTensors, void *&outputAddr, void *&wsAddr)
    {
        OpArgContext nonFiniteCheckOpArgCtx;
        OpArg tempOpArg[3];
        OpArg *nonFiniteCheckOpArg = tempOpArg;

        aclTensorList *tilingInputTensor =
            nonFiniteCheckOpCtx.executor_->AllocTensorList(checkTensors.data(), checkTensors.size());
        OP_CHECK(tilingInputTensor != nullptr,
                 OP_LOGW("failed to init non finite check tiling input tensorlist"), return ACLNN_ERR_INNER);
        OpArg tilingInputArg;
        tilingInputArg.type = OpArgType::OPARG_ACLTENSOR_LIST;
        tilingInputArg->pointer = tilingInputTensor;
        OpArgList tilingInputArgList(&tilingInputArg, 1);

        auto ret = PrepareNonFiniteCheckOpArgs(
            nonFiniteCheckOpCtx, checkTensors, tilingInputArgList, nonFiniteCheckOpArgCtx, nonFiniteCheckOpArg);
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("failed to prepare non finite check op args, ret: %d", ret), return ret);

        OpArgList &output = *nonFiniteCheckOpArgCtx.GetOpArg(OpArgDef::OP_OUTPUT_ARG);
        aclTensor *outputTensor = reinterpret_cast<aclTensor *>(output[0]->pointer);
        outputAddr = outputTensor->GetStorageAddr();

        OpArgList &workspace = *nonFiniteCheckOpArgCtx.GetOpArg(OpArgDef::OP_WORKSPACE_ARG);
        aclTensor *wsTensor = reinterpret_cast<aclTensor *>(workspace[0]->pointer);
        wsAddr = wsTensor->GetStorageAddr();
        return nonFiniteCheckOpCtx.bin_->Launch(
            nonFiniteCheckOpCtx.stream_, nonFiniteCheckOpCtx.opArgCtx_, tilingInputArgList, &nonFiniteCheckOpArgCtx);
    }
};

} // namespace internal
} // namespace op

#endif
