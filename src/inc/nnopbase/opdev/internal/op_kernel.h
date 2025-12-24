/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_H
#define OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_H

#include <vector>
#include <utility>
#include <set>
#include <mutex>

#include "nlohmann/json.hpp"
#include "adump_pub.h"

#include "aclnn/aclnn_base.h"
#include "opdev/op_arg_def.h"
#include "opdev/op_dfx.h"
#include "opdev/op_cache.h"
#include "opdev/op_def.h"
#include "opdev/op_errno.h"
#include "opdev/op_log.h"
#include "opdev/platform.h"
#include "opdev/internal/kernel_utils.h"
#include "opdev/internal/kernel_arg.h"
#include "opdev/internal/kernel_context_holder.h"
#include "opdev/internal/launcher_ctx.h"
#include "opdev/internal/launch_arg_info.h"
#include "opdev/internal/memset_ctx_holder.h"
#include "opdev/internal/memset_op.h"
#include "opdev/internal/op_ctx_def.h"
#include "opdev/internal/op_cache_internal.h"
#include "opdev/internal/op_run_context.h"
#include "opdev/internal/tiling_parse_ctx_holder.h"
#include "opdev/internal/outshape.h"
#include "runtime/context.h"
#include "runtime/dev.h"
#include "runtime/stream.h"
#include "runtime/rts/rts_event.h"
#include "runtime/rts/rts_stream.h"
#include "opdev/internal/tilingctx_builder.h"
#include "opdev/internal/rts_arg.h"
#include "opdev/internal/nnopbase.h"
#include "opdev/internal/bridge/bridge_dfx.h"

namespace op {
namespace internal {

using TupleArrayOut = std::tuple<uint32_t, uint32_t>;

constexpr const char *DYN_KERNEL_CONFIG_PATH = "/kernel/config/";
constexpr const char *DYN_BIN_AND_JSON_PATH = "/kernel/";
constexpr const char *DYN_DEBUG_KERNEL_CONFIG_PATH = "/debug_kernel/config/";
constexpr const char *DYN_DEBUG_BIN_AND_JSON_PATH = "/debug_kernel/";
constexpr size_t REDUNDANT_LEN = 32;
constexpr size_t OP_KERNEL_BLOCK_SIZE = 32;
constexpr char DETERMINISTIC_VALUE = '1';
constexpr char NON_DETERMINISTIC_VALUE = '0';
constexpr size_t DEFAULT_CONTEXT_LEN = 5;
constexpr uint64_t DIM_NUM_ONE = 1;
constexpr uint64_t DIM_SIZE_ONE = 1;
constexpr size_t OOM_ALIGN_COEF = 8;

extern const std::map<std::string, TensorType> STR_2_TENSOR_TYPE;

extern const std::map<std::string, ge::DataType> STR_2_DATA_TYPE;

extern const std::map<ge::DataType, std::string> DATA_TYPE_2_STR;

extern const std::map<std::string, ge::Format> STR_2_FORMAT;

extern const std::map<ge::Format, std::string> FORMAT_2_STR;

enum class BinType {
    STATIC_BIN = 0,
    DYNAMIC_BIN = 1,
    KEY_TYPE_BOTTOM
};

enum class OpDebugConfig : uint32_t {
    NO_DEBUG = 0,
    OOM = 1,
    DUMP_BIN = 2,
    DUMP_CCE = 4,
    DUMP_LOC = 8,
    CCEC_O0 = 16,
    CCEC_G = 32
};

enum class KernelDfxType : uint32_t {
    NO_DFX = 0,
    ASSERT = 1,
    PRINTF = 2
};

struct KeyLength {
    size_t ctxLen = 0;
    size_t tensorLen = 0;
    size_t ctxAndtensorLen = 0; // simply equals to ctxLen + tensorLen
    size_t totalBufferLength = 0;
};

struct KeyAndDetail {
    std::string key;
    bool deterministicFlag = false;
    std::string implMode;
};

struct KeyParams {
    std::vector<KeyAndDetail> keys;
    /* If one op cannot find binary with attributes, that is
     * probably because that op does not provide enough attributes,
     * so we use the following key to find a binary without
     * attributes. */
    std::vector<std::string> keysWithoutAttr;
    KeyLength len;
    BinType binType = BinType::DYNAMIC_BIN;
    bool genPlaceholder = false;
    bool hasDevPtrArg = false;
};

inline void CacheTensorForDfx(const aclTensor *tensor, FVector<const aclTensor*> &res)
{
    OP_LOGD("CacheTensorForDfx, tensor=%p, res.size = %lu", tensor, res.size());
    res.push_back(tensor);
}

inline void CacheTensorForDfx(const aclTensorList *tensor, FVector<const aclTensor*> &res)
{
    if (tensor != nullptr) {
        for (uint64_t i = 0; i < tensor->Size(); i++) {
            CacheTensorForDfx((*tensor)[i], res);
        }
    }
}

inline void CacheTensorForDfx(OpArg &tensor, FVector<const aclTensor*> &res)
{
    if (tensor.type == OpArgType::OPARG_ACLTENSOR) {
        CacheTensorForDfx(reinterpret_cast<aclTensor *>(tensor->pointer), res);
    } else if (tensor.type == OpArgType::OPARG_ACLTENSOR_LIST) {
        CacheTensorForDfx(reinterpret_cast<aclTensorList *>(tensor->pointer), res);
    }
}

void ParseImplModeByJson(const nlohmann::json &singleBinJson, const std::string &jsonPath,
                         FVector<OpImplMode> &implModes);

class OpKernelBin {
public:
    using TilingKey = uint64_t;
    OpKernelBin(const OpKernelBin &) = delete;
    OpKernelBin &operator=(const OpKernelBin &) = delete;
    OpKernelBin(const OpKernelBin &&) = delete;
    OpKernelBin &operator=(const OpKernelBin &&) = delete;

    void SetJsonPath(const std::string &jsonPath);
    void SetBinPath(const std::string &binPath);

    OpKernelBin(uint32_t optype,
                const std::string &jsonpath, const std::string &relativeJsonPath, const std::string &binpath,
                const KeyAndDetail &keyAndDetail, size_t hash, BinType binType, bool genPlaceholder, bool hasDevPtrArg,
                void *opKernel = nullptr)
        : opType_(optype), binPath_(binpath), jsonPath_(jsonpath), relativeJsonPath_(relativeJsonPath),
          keyAndDetail_(keyAndDetail), hashKey_(hash),
          binType_(binType), genPlaceholder_(genPlaceholder), hasDevPtrArg_(hasDevPtrArg), opKernel_(opKernel)
    {
        for (auto i = 0; i < MAX_DEV_NUM; i++) {
            stubFunc_[i] = nullptr;
        }
    }

    void SetExceptionDumpInfo(uint32_t blockDim, uint64_t tilingKey, void *tilingData, size_t tilingSize);

    template<typename RTS_ARG>
    aclnnStatus DoLaunch(const TilingCtxOutput *res, aclrtStream stream, bool isMemSet, OpArgContext *args,
                         std::vector<int32_t>& tensorOffset)
    {
        OP_CHECK(res != nullptr, OP_LOGE(ACLNN_ERR_INNER, "DoLaunch failed. TilingCtxOutput can't be nullptr."),
                 return ACLNN_ERR_INNER);
        LaunchArgInfo argInfo(res->tilingData_->data_, res->tilingData_->data_size_, genPlaceholder_, hasDevPtrArg_,
                              args);
        OP_CHECK_NO_RETURN(AppendAICErrorDFXInfo(argInfo, res->tilingData_) == ACLNN_SUCCESS,
                           OP_LOGW("Append AIC Error DFX info failed!"));
        OP_LOGD("tilingDataWrap %p, tilingData %p, size %zu, capacity %zu", res->tilingData_, res->tilingData_->data_,
                res->tilingData_->data_size_, res->tilingData_->capacity_);
        uint64_t tilingkey = *(res->tilingKey_);
        uint32_t blockdim = *(res->blockDim_);
        uint32_t localMemorySize = *(res->localMemorySize_);
        ADD_TRY_CATCH(
            bool hasFftsAddr = ((interCoreSync_ || (mixKernel.find(tilingkey) != mixKernel.end())) &&
                            GetCurrentPlatformInfo().GetFftsPlusMode());
            RTS_ARG rtsArg(hasFftsAddr, argInfo, res->tilingData_->capacity_);
            OP_CHECK(rtsArg.FillArgs(IsAssertEnable()) == ACLNN_SUCCESS,
                OP_LOGE(ACLNN_ERR_INNER, "Fill rts arg fail"),
                return ACLNN_ERR_INNER);
            tensorOffset = rtsArg.GetTensorOffset();
            uint8_t scheduleMode = *(res->scheduleMode_);
            if (!isMemSet) {
                SetExceptionDumpInfo(blockdim, tilingkey, res->tilingData_->data_, res->tilingData_->data_size_);
            }
            GetThreadLocalContext().blockDim_ = blockdim;
            LaunchArgCache::RtsLaunchType launchType;
            void *handle = nullptr;
            aclnnStatus ret;
            if (isFatbin_) {
                handle = handle_[currDevId_].GetVar();
                launchType = LaunchArgCache::LAUNCH_WITH_HANDLE;
                ret = rtsArg.KernelLaunchWithHandle(handle, stream, tilingkey, blockdim, scheduleMode, localMemorySize);
            } else {
                handle = stubFunc_[currDevId_];
                launchType = LaunchArgCache::LAUNCH_WITH_FLAG;
                ret = rtsArg.KernelLaunchWithFlag(handle, stream, blockdim, scheduleMode, localMemorySize);
            }
            LaunchArgCache *cache = rtsArg.DumpToCache();
            if (cache != nullptr) {
                cache->SetRunParam(handle, launchType, blockdim, tilingkey, scheduleMode, localMemorySize);
                FVector<const aclTensor*> in;
                FVector<const aclTensor*> out;
                if (args->ContainsOpArgType(op::OP_INPUT_ARG)) {
                    args->GetOpArg(op::OP_INPUT_ARG)->VisitByNoReturn(
                        [&in]([[maybe_unused]] size_t idx, OpArg &elem) {
                            CacheTensorForDfx(elem, in);
                        });
                }
                if (args->ContainsOpArgType(op::OP_OUTPUT_ARG)) {
                    args->GetOpArg(op::OP_OUTPUT_ARG)->VisitByNoReturn(
                        [&out]([[maybe_unused]] size_t idx, OpArg &elem) {
                            CacheTensorForDfx(elem, out);
                        });
                }
                CacheTensorInfo(in, out);
                if (isMemSet == false) {
                    GetThreadLocalContext().profilingInfoId_.kernelLauncherId_ =
                        GenKernelLauncherId(op::OpTypeDict::ToString(opType_).GetString());
                    GetThreadLocalContext().profilingInfoId_.summaryItemId_ =
                        GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                            GetThreadLocalContext().logInfo_.l0Name,
                            op::OpTypeDict::ToString(opType_).GetString());
                    CacheDfxInfo(blockdim, GetThreadLocalContext().profilingInfoId_, GetTaskInfo(tilingkey, args), false);
                } else {
                    GetThreadLocalContext().memSetProfilingInfoId_.summaryItemId_ =
                        GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                            GetThreadLocalContext().logInfo_.l0Name,
                            op::OpTypeDict::ToString(opType_).GetString());
                    CacheDfxInfo(
                        blockdim, GetThreadLocalContext().memSetProfilingInfoId_, GetTaskInfo(tilingkey, args), true);
                }
            }

            CHECK_RET_CODE(ret, "#### KernelLaunch failed: %s", binPath_.c_str());
            if (args->ContainsOpArgType(op::OP_OUTSHAPE_ARG)) {
                CHECK_RET_CODE(rtsStreamSynchronize(stream, -1), "rtsStreamSynchronize failed. stream: %p", stream);
                return RefreshOutputShape(0, *args->GetOpArg(op::OP_OUTSHAPE_ARG), *args->GetOpArg(op::OP_OUTPUT_ARG));
            }
        ,
            OP_LOGE(ACLNN_ERR_INNER, "doLaunch rtsArg construct error");
            return ACLNN_ERR_INNER;
        );
        return ACLNN_SUCCESS;
    }

    aclnnStatus DoLaunchWithDfx(const TilingCtxOutput *res, aclrtStream stream, OpArgContext *args)
    {
        aclnnStatus rc = ACLNN_ERR_INNER;
        if (op::internal::opProfilingSwitch.kernelLaunchFlag) {
            GetThreadLocalContext().profilingInfoId_.summaryItemId_ =
                    GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                                     GetThreadLocalContext().logInfo_.l0Name,
                                     op::OpTypeDict::ToString(opType_).GetString());
        }
        // disabling the Cache
        OpExecCache *cache = GetOpCacheContext().GetOpCache();
        if (cache != nullptr && IsPrintFEnable()) {
            cache->MarkOpCacheInvalid();
        }
        std::vector<int32_t> tensorOffset;
        {
            OpDfxGuard
                kernelLaunchGuard(GetThreadLocalContext().profilingInfoId_.summaryItemId_, DfxProfilingKernelLaunch);
            if (isFatbin_ && RtsApiFlag::GetRtsApiFlag().IfNewApi()) {
                rc = DoLaunch<RtsArgNew>(res, stream, false, args, tensorOffset);
            } else {
                rc = DoLaunch<RtsArg>(res, stream, false, args, tensorOffset);
            }
        }
        if (IsPrintFEnable()) {
            DumpWorkspaceData(stream, args);
        }
        if (op::internal::IsExceptionDumpEnable()) {
            op::internal::PrepareExceptionDumpInfo(
                args, GetThreadLocalContext().logInfo_, genPlaceholder_, hasDevPtrArg_, interCoreSync_, tensorOffset);
        }
        if (op::internal::opProfilingSwitch.kernelLaunchFlag) {
            auto taskInfo = GetTaskInfo(*(res->tilingKey_), args);
            if (taskInfo.type == MSPROF_GE_TASK_TYPE_MIX_AIV || taskInfo.type == MSPROF_GE_TASK_TYPE_MIX_AIC) {
                op::internal::ReportNodeContextIdInfo(GetThreadLocalContext().profilingInfoId_.summaryItemId_);
            }
            // only level1 profiling need to report addition info
            op::internal::GetThreadLocalContext().profilingInfoId_.kernelLauncherId_ =
                GenKernelLauncherId(op::OpTypeDict::ToString(opType_).GetString());
            if (op::internal::opProfilingSwitch.additionInfoFlag) {
                op::internal::ReportAdditionInfo(*args->GetOpArg(op::OP_INPUT_ARG),
                                                 *args->GetOpArg(op::OP_OUTPUT_ARG), taskInfo,
                                                 GetThreadLocalContext().profilingInfoId_.summaryItemId_);
            }
            ReportOpAttrInfo(args, GetThreadLocalContext().profilingInfoId_.summaryItemId_);
        }
        return rc;
    }

    aclnnStatus AppendTilingOOMInfo(TilingData *tilingData, OpArgContext *args) const
    {
        if (oriOpParaSize_ > 0 && tilingData->data_size_ < oriOpParaSize_) {
            tilingData->data_size_ = oriOpParaSize_;
        }
        constexpr size_t oomAlignCoef = 8;
        tilingData->data_size_ = AlignSize(tilingData->data_size_, oomAlignCoef);
        OP_CHECK(tilingData->capacity_ >= tilingData->data_size_,
                 OP_LOGW("tiling data capacity not enough, capacity: %zu, data size %zu",
                         tilingData->capacity_, tilingData->data_size_),
                 return ACLNN_ERR_INNER);

        CHECK_RET_CODE(args->GetOpArg(op::OP_INPUT_ARG)->VisitBy(
            [this, tilingData](size_t idx, OpArg &elem) {
                return AppendTensorShapeInfo(idx, elem, tilingData, op::OP_INPUT_ARG);
            }), "Append input tensor shape info failed.");
        CHECK_RET_CODE(args->GetOpArg(op::OP_OUTPUT_ARG)->VisitBy(
            [this, tilingData](size_t idx, OpArg &elem) {
                return AppendTensorShapeInfo(idx, elem, tilingData, op::OP_OUTPUT_ARG);
            }), "Append output tensor shape info failed.");

        if (args->ContainsOpArgType(op::OP_OUTSHAPE_ARG)) {
            CHECK_RET_CODE(
                AppendTensorShapeInfo(
                    0, PtrCastTo<aclTensor>((*args->GetOpArg(op::OP_OUTSHAPE_ARG))[0]->pointer),
                    tilingData, false),
                "Append outshape info failed.");
        }

        if (args->ContainsOpArgType(op::OP_WORKSPACE_ARG)) {
            CHECK_RET_CODE(args->GetOpArg(op::OP_WORKSPACE_ARG)->VisitBy(
                [this, tilingData](size_t idx, OpArg &elem) {
                    return AppendTensorShapeInfo(idx, elem, tilingData, op::OP_WORKSPACE_ARG);
                }), "Append workspace shape info failed.");
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendAICErrorDFXInfo(LaunchArgInfo &argInfo, TilingData *tilingData) const
    {
        if (!IsArgExceptionDumpEnable()) {
            return ACLNN_SUCCESS;
        }
        auto &allArg = argInfo.GetAllArgInfo();
        size_t argNum = allArg.size();
        if (argNum == 0) {
            OP_LOGI("arg num is 0, no need dump.");
            return ACLNN_SUCCESS;
        }

        size_t dumpSize = argInfo.GetDFXInfoDumpSize();
        uint64_t dfxInfoDumpIndex = 0;
        void *dfxInfoDumpAddr = Adx::AdumpGetDFXInfoAddrForDynamic(dumpSize, dfxInfoDumpIndex);
        OP_CHECK(dfxInfoDumpAddr != nullptr,
            OP_LOGW("AdumpGetDFXInfoAddrForDynamic get address failed, request space: %zu", dumpSize),
            return ACLNN_ERR_INNER_NULLPTR);
        aclnnStatus ret = AppendAICErrorDFXInfoToDump(allArg, dfxInfoDumpAddr, dumpSize);
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("Append AIC Error DFX info to dump failed!"), return ret);
        argInfo.SetDFXInfoDumpAddr(dfxInfoDumpAddr);

        ret = AppendAICErrorDFXInfoToTilingData(tilingData, dfxInfoDumpIndex);
        OP_CHECK(ret == ACLNN_SUCCESS, OP_LOGW("Append AIC Error DFX info to tiling data failed!"), return ret);
        argInfo.SetDFXInfoOffsetInTilingData(tilingData->data_size_ - UINT64_BYTES);
        argInfo.UpdateTilingDataLen(tilingData->data_size_);

        uint32_t *atomicIndexU32Type = PtrCastTo<uint32_t>(&dfxInfoDumpIndex);
        OP_LOGI("Dump addr: %p, space: %zu, atomic index: %lu(hex: 0x%lX, uint32_t: %u %u), print dfx info dump: %d",
            dfxInfoDumpAddr, dumpSize, dfxInfoDumpIndex, dfxInfoDumpIndex, atomicIndexU32Type[0], atomicIndexU32Type[1],
            op::internal::PrintAICErrorDFXInfo(dfxInfoDumpAddr, argNum, dumpSize));
        return ACLNN_SUCCESS;
    }

    bool IsNeedSplitAicAndAiv(const TilingCtxOutput *res, const op::PlatformInfo &platformInfo)
    {
        SocVersion version = platformInfo.GetSocVersion();
        uint32_t cubeCoreNum = GetThreadLocalContext().opConfigInfo_.aicNum_;
        uint32_t vectorCoreNum = GetThreadLocalContext().opConfigInfo_.aivNum_;
        uint32_t needCoreNum = *(res->blockDim_);
        if ((cubeCoreNum + vectorCoreNum) == 0) {
            OP_LOGW("The number of cubeCore is %u, The number of vectorCore is %u. Calculation failed.",
                cubeCoreNum,
                vectorCoreNum);
            return false;
        }
        uint32_t needCubeCoreNum =
            static_cast<uint32_t>(std::ceil(float(needCoreNum) / (cubeCoreNum + vectorCoreNum))) * cubeCoreNum;
        return version == SocVersion::ASCEND310P && needCoreNum > needCubeCoreNum;
    }

    TupleArrayOut NeedAicAndAivCoreNum(const TilingCtxOutput *res) const
    {
        uint32_t cubeCoreNum = GetThreadLocalContext().opConfigInfo_.aicNum_;
        uint32_t vectorCoreNum = GetThreadLocalContext().opConfigInfo_.aivNum_;
        uint32_t totalNeedNum = *(res->blockDim_);

        if ((cubeCoreNum + vectorCoreNum) == 0) {
            OP_LOGW("The number of cubeCore is %u, The number of vectorCore is %u. Calculation failed.",
                cubeCoreNum,
                vectorCoreNum);
            return std::make_tuple(0, totalNeedNum);
        }
        uint32_t cubeNeedCoreNum = std::ceil(float(totalNeedNum) / (vectorCoreNum + cubeCoreNum)) * cubeCoreNum;
        uint32_t vectorNeedCoreNum = totalNeedNum - cubeNeedCoreNum;
        return std::make_tuple(cubeNeedCoreNum, vectorNeedCoreNum);
    }

    aclnnStatus DoLaunchWithSplitAicAndAiv(const TilingCtxOutput *res, aclrtStream stream, OpArgContext *args)
    {
        rtStream_t secondStream;
        rtEvent_t eventA;
        rtEvent_t eventB;

        // disabling the Cache
        OpExecCache *cache = GetOpCacheContext().GetOpCache();
        if (cache != nullptr) {
            cache->MarkOpCacheInvalid();
        }

        // get secondStream, eventA and eventB.
        std::shared_ptr<std::mutex> streamLckPtr;
        auto getStreamAndEventStatus = NnopbaseGetStreamAndEvent(stream, &secondStream,
            &eventA, &eventB, streamLckPtr);
        if (getStreamAndEventStatus != OK) {
            OP_LOGW("getting secondStream, eventA and eventB fail.");
            return getStreamAndEventStatus;
        }
        OP_LOGW("getting secondStream, eventA and eventB Succeed.");
        std::lock_guard<std::mutex> lock(*streamLckPtr);
        if (op::internal::opProfilingSwitch.kernelLaunchFlag) {
            GetThreadLocalContext().profilingInfoId_.summaryItemId_ =
                    GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                                     GetThreadLocalContext().logInfo_.l0Name,
                                     op::OpTypeDict::ToString(opType_).GetString());
        }

        LaunchArgInfo argInfo(res->tilingData_->data_, res->tilingData_->data_size_, genPlaceholder_, hasDevPtrArg_,
                              args);
        OP_CHECK_NO_RETURN(AppendAICErrorDFXInfo(argInfo, res->tilingData_) == ACLNN_SUCCESS,
            OP_LOGW("Append AIC Error DFX info failed!"));
        uint64_t tilingkey = *(res->tilingKey_);
        // get the coreNums of the AIC and AIV.
        auto needCoreNumTupleOut = NeedAicAndAivCoreNum(res);
        uint32_t blockdimAic = std::get<0>(needCoreNumTupleOut);
        uint32_t blockdimAiv = std::get<1>(needCoreNumTupleOut);

        RtsArg rtsArg(interCoreSync_ || (mixKernel.find(tilingkey) != mixKernel.end()),
                    argInfo, res->tilingData_->capacity_);
        uint8_t scheduleMode = *(res->scheduleMode_);
        void *handle = nullptr;
        int32_t ret;
        std::vector<int32_t> tensorOffset;

        {
            OpDfxGuard
                kernelLaunchGuard(GetThreadLocalContext().profilingInfoId_.summaryItemId_, DfxProfilingKernelLaunch);
            OP_CHECK(rtsArg.FillArgs(IsAssertEnable()) == ACLNN_SUCCESS,
                OP_LOGE(ACLNN_ERR_INNER, "Fill rts arg fail"),
                return ACLNN_ERR_INNER);
            tensorOffset = rtsArg.GetTensorOffset();
            SetExceptionDumpInfo(blockdimAic, tilingkey, res->tilingData_->data_, res->tilingData_->data_size_);
            GetThreadLocalContext().blockDim_ = blockdimAic;

            ret = rtsEventRecord(eventA, stream);
            if (ret != RT_ERROR_NONE) {
                OP_LOGW("main record eventA fail.");
                return ret;
            }
            uint32_t timeout = 0xFFFFFFFFU;
            ret = rtsEventWait(secondStream, eventA, timeout);
            if (ret != RT_ERROR_NONE) {
                OP_LOGW("second wait eventA fail.");
                return ret;
            }

            // mainStream kernel launch
            if (isFatbin_) {
                handle = handle_[currDevId_].GetVar();
                ret = rtsArg.KernelLaunchWithHandle(handle, stream, tilingkey, blockdimAic, scheduleMode, 0);
                if (ret != RT_ERROR_NONE) {
                    OP_LOGW("main kernel launch with handle fail.");
                    return ret;
                }
            } else {
                handle = stubFunc_[currDevId_];
                ret = rtsArg.KernelLaunchWithFlag(handle, stream, blockdimAic, scheduleMode, 0);
                if (ret != RT_ERROR_NONE) {
                    OP_LOGW("main kernel launch with flag fail.");
                    return ret;
                }
            }
            OP_LOGW("mainStream kernel launch succeed.");
        }
        if (IsPrintFEnable()) {
            DumpWorkspaceData(stream, args);
        }
        if (op::internal::IsExceptionDumpEnable()) {
            op::internal::PrepareExceptionDumpInfo(
                args, GetThreadLocalContext().logInfo_, genPlaceholder_, hasDevPtrArg_, interCoreSync_, tensorOffset);
        }
        if (op::internal::opProfilingSwitch.kernelLaunchFlag) {
            MsprofGeTaskType taskType = MSPROF_GE_TASK_TYPE_AI_CORE;
            // only level1 profiling need to report addition info
            if (op::internal::opProfilingSwitch.additionInfoFlag) {
                op::internal::GetThreadLocalContext().profilingInfoId_.kernelLauncherId_ =
                    GenKernelLauncherId(op::OpTypeDict::ToString(opType_).GetString());
                op::internal::ReportAdditionInfo(*args->GetOpArg(op::OP_INPUT_ARG),
                                                 *args->GetOpArg(op::OP_OUTPUT_ARG), taskType,
                                                 GetThreadLocalContext().profilingInfoId_.summaryItemId_);
            }
            ReportOpAttrInfo(args, GetThreadLocalContext().profilingInfoId_.summaryItemId_);
        }
        {
            OpDfxGuard
                kernelLaunchGuard(GetThreadLocalContext().profilingInfoId_.summaryItemId_, DfxProfilingKernelLaunch);
            SetExceptionDumpInfo(blockdimAiv, tilingkey, res->tilingData_->data_, res->tilingData_->data_size_);
            GetThreadLocalContext().blockDim_ = blockdimAiv;

            // secondStream kernel launch
            if (isFatbin_) {
                handle = handle_[currDevId_].GetVar();
                ret = rtsArg.VectorCoreKernelLaunchWithHandle(handle, secondStream, tilingkey, blockdimAiv, blockdimAic,
                                                              scheduleMode, 0);
                if (ret != RT_ERROR_NONE) {
                    OP_LOGW("second kernel launch with handle fail.");
                    return ret;
                }
            } else {
                handle = stubFunc_[currDevId_];
                ret = rtsArg.VectorCoreKernelLaunchWithFlag(handle, secondStream, blockdimAiv, blockdimAic,
                                                            scheduleMode, 0);
                if (ret != RT_ERROR_NONE) {
                    OP_LOGW("second kernel launch with flag fail.");
                    return ret;
                }
            }

            if (op::internal::IsExceptionDumpEnable()) {
                op::internal::PrepareExceptionDumpInfo(args, GetThreadLocalContext().logInfo_, genPlaceholder_,
                                                       hasDevPtrArg_, interCoreSync_, tensorOffset);
            }

            ret = rtsEventRecord(eventB, secondStream);
            if (ret != RT_ERROR_NONE) {
                OP_LOGW("second record eventB fail.");
                return ret;
            }
            uint32_t timeout = 0xFFFFFFFFU;
            ret = rtsEventWait(stream, eventB, timeout);
            if (ret != RT_ERROR_NONE) {
                OP_LOGW("main wait eventB fail.");
                return ret;
            }
            OP_LOGW("secondStream kernel launch succeed.");
        }
        if (op::internal::opProfilingSwitch.kernelLaunchFlag) {
            MsprofGeTaskType taskType = MSPROF_GE_TASK_TYPE_AIV;
            // only level1 profiling need to report addition info
            if (op::internal::opProfilingSwitch.additionInfoFlag) {
                op::internal::GetThreadLocalContext().profilingInfoId_.kernelLauncherId_ =
                    GenKernelLauncherId(op::OpTypeDict::ToString(opType_).GetString());
                op::internal::ReportAdditionInfo(*args->GetOpArg(op::OP_INPUT_ARG),
                                                 *args->GetOpArg(op::OP_OUTPUT_ARG), taskType,
                                                 GetThreadLocalContext().profilingInfoId_.summaryItemId_);
            }
            ReportOpAttrInfo(args, GetThreadLocalContext().profilingInfoId_.summaryItemId_);
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus Launch(aclrtStream stream, OpArgContext *args)
    {
        CHECK_RET_CODE(BinLoad(), "BinLoad failed");
        const TilingCtxOutput *res = nullptr;
        if (binType_ == BinType::DYNAMIC_BIN) {
            CHECK_RET_CODE(InitTilingParseCtx(), "InitTilingParseCtx failed");
            {
                if (op::internal::opProfilingSwitch.reportFlag) {
                    std::string tilingFuncName = op::OpTypeDict::ToString(opType_).GetString() + std::string("_Tiling");
                    GetThreadLocalContext().profilingInfoId_.tilingProfilingId_ =
                        CollectProfilingStr(tilingFuncName.c_str());
                }
                OpDfxGuard tilingGuard(GetThreadLocalContext().profilingInfoId_.tilingProfilingId_, DFXProfilingTiling);
                const TilingResCache *tilingCache = nullptr;
                if ((tilingCache = GetLauncherCtx().GetTilingResCache()) != nullptr) {
                    OP_LOGD("Get cached tiling result");
                    res = OpRunContextMgr::GetCachedTilingRes(*tilingCache);
                } else {
                    res = OpRunContextMgr::Tiling(opType_,
                        tilingParseCtxHolder_[ThreadCoreNum(GetThreadLocalContext().opConfigInfo_.aicNum_,
                                                  GetThreadLocalContext().opConfigInfo_.aivNum_)]
                            .get(),
                        *args->GetOpArg(op::OP_INPUT_ARG),
                        *args->GetOpArg(op::OP_OUTPUT_ARG),
                        *args->GetOpArg(op::OP_ATTR_ARG));
                    if (GetLauncherCtx().GetLauncherRepeatable()) {
                        GetLauncherCtx().SaveTilingResCache(res);
                    }
                }
                CHECK_COND(res != nullptr, ACLNN_ERR_INNER_NULLPTR, "Tiling Failed.");

                if ((debugConfig_ & static_cast<uint32_t>(OpDebugConfig::OOM)) != 0) {
                    AppendTilingOOMInfo(res->tilingData_, args);
                }

                auto ws = PtrCastTo<gert::TypedContinuousVector<size_t>>(res->workspaceSize_);
                OP_LOGD("Tiling Key: %lu, len: %lu, BlockDim: %ld, Workspace Num: %zu.",
                        *(res->tilingKey_),
                        res->tilingData_->data_size_,
                        *(res->blockDim_),
                        ws->GetSize());
#ifdef DEBUG
                for (size_t i = 0; i < ws->GetSize(); i++) {
                    OP_LOGD("Workspace [%zu] size: %zu", i, (ws->GetData())[i]);
                }
#endif
            }
        } else {
            OpRunContextMgr::RecordOpInfo(opType_,
                                          aclnnOpInfoRecord::OpKernelInfo(binPath_, static_cast<int8_t>(binType_)),
                                          staticImplMode_,
                                          *args->GetOpArg(op::OP_INPUT_ARG),
                                          *args->GetOpArg(op::OP_OUTPUT_ARG),
                                          *args->GetOpArg(op::OP_ATTR_ARG));
            res = OpRunContextMgr::GetStaticTilingCtxOutput(opType_, staticBlockDim_, !memSetValue_.empty(),
                                                            scheduleMode_,
                                                            staticWorkspaceSize_,
                                                            *args->GetOpArg(op::OP_INPUT_ARG),
                                                            *args->GetOpArg(op::OP_OUTPUT_ARG),
                                                            *args->GetOpArg(op::OP_ATTR_ARG));
            CHECK_COND(res != nullptr, ACLNN_ERR_INNER_NULLPTR, "Get static tiling context output failed.");
        }

        if (!memSetValue_.empty()) {
            CHECK_RET_CODE(MemsetOutputTensor(stream, args), "Memset Output Tensor failed");
        }
        OP_LOGW("Core type: %s.", coreType_.c_str());
        if (coreType_ != "MIX_AIV" && coreType_ != "MIX_AIC" && coreType_ != "MIX_AICORE"
            && coreType_ != "MIX_VECTOR_CORE") {
            return DoLaunchWithDfx(res, stream, args);
        }
        auto& platformInfo = GetCurrentPlatformInfo();
        bool needSplitAicAndAiv = IsNeedSplitAicAndAiv(res, platformInfo);
        if (!needSplitAicAndAiv) {
            return DoLaunchWithDfx(res, stream, args);
        } else {
            OP_LOGW("Entering two Kernel Launchs with AIC and AIV.");
            return DoLaunchWithSplitAicAndAiv(res, stream, args);
        }
    }

    aclnnStatus MemSet(aclrtStream stream, const std::vector<MemSetTensorInfo> &memsetTensorInfo)
    {
        CHECK_RET_CODE(BinLoad(), "BinLoad failed");
        CHECK_RET_CODE(InitTilingParseCtx(), "InitTilingParseCtx failed");
        auto res = OpRunContextMgr::Tiling4MemSet(
            tilingParseCtxHolder_[ThreadCoreNum(GetThreadLocalContext().opConfigInfo_.aicNum_,
                                      GetThreadLocalContext().opConfigInfo_.aivNum_)]
                .get(),
            memsetTensorInfo);
        CHECK_COND(res != nullptr, ACLNN_ERR_INNER_NULLPTR, "Tiling4MemSet Failed.");
        OP_LOGD("Tiling Key: %lu, len: %lu, BlockDim: %ld",
                *(res->tilingKey_), res->tilingData_->data_size_, *(res->blockDim_));
        std::vector<std::tuple<void*, const aclTensor*>> tensor;
        for (const auto &elem : memsetTensorInfo) {
            OP_CHECK_NO_RETURN(elem.tensor_ != nullptr, OP_LOGW("elem idx [%zu] is nullptr.", elem.argIdx_));
            tensor.emplace_back(elem.tensorData_, elem.tensor_);
        }
        auto workspace = OP_WORKSPACE(std::move(tensor));
        static uint64_t kernelLaunchId = GenKernelLauncherId("MemSet");
        GetThreadLocalContext().memSetProfilingInfoId_.kernelLauncherId_ = kernelLaunchId;
        uint64_t summaryId = 0;
        if (opProfilingSwitch.kernelLaunchFlag) {
            summaryId = GenSummaryItemId(GetThreadLocalContext().logInfo_.l2ApiName,
                                         GetThreadLocalContext().logInfo_.l0Name,
                                         "MemSet");
        }
        aclnnStatus rc = ACLNN_ERR_INNER;
        OpArgContext tempCtx;
        OpArg opArg;
        OpArg *tempArg = &opArg;
        std::vector<int32_t> tensorOffset;
        OpArgContextInit(tempCtx, tempArg, workspace, OP_EMPTY_ARG);
        {
            OpDfxGuard kernelLaunchGuard(summaryId, DfxProfilingKernelLaunch);
            rc = DoLaunch<RtsArg>(res, stream, true, &tempCtx, tensorOffset);
        }
        if (opProfilingSwitch.kernelLaunchFlag && opProfilingSwitch.additionInfoFlag) {
            ReportAdditionInfo(GetTaskInfo(*(res->tilingKey_)), kernelLaunchId, summaryId);
        }
        return rc;
    }

    aclnnStatus MemSetV2(aclrtStream stream, const std::vector<MemSetTensorInfo> &memsetTensorInfo)
    {
        CHECK_RET_CODE(BinLoad(), "BinLoad failed");
        CHECK_RET_CODE(InitTilingParseCtx(), "InitTilingParseCtx failed");
        MemsetV2ArgContext memsetV2ArgCtx;
        aclnnStatus rc = memsetV2ArgCtx.Init(memsetTensorInfo);
        CHECK_COND(rc == ACLNN_SUCCESS, ACLNN_ERR_INNER_NULLPTR, "Get memsetV2 arg context failed.");
        OpArgContext *memsetV2OpArgCtx = memsetV2ArgCtx.GetMemsetV2OpArgContext();
        OP_CHECK(!(rc == ACLNN_SUCCESS && memsetV2OpArgCtx == nullptr),
            OP_LOGW("There is no tensor to memset"), return ACLNN_SUCCESS);
        auto &opTlsCtx = GetThreadLocalContext();
        // tiling
        if (op::internal::opProfilingSwitch.reportFlag) {
            std::string tilingFuncName = op::OpTypeDict::ToString(opType_).GetString() + std::string("_Tiling");
            opTlsCtx.profilingInfoId_.tilingProfilingId_ = CollectProfilingStr(tilingFuncName.c_str());
        }
        const TilingCtxOutput *res = nullptr;
        {
            OpDfxGuard tilingGuard(opTlsCtx.profilingInfoId_.tilingProfilingId_, DFXProfilingTiling);
            res = OpRunContextMgr::Tiling4MemSetV2(opType_,
                tilingParseCtxHolder_[ThreadCoreNum(GetThreadLocalContext().opConfigInfo_.aicNum_,
                                          GetThreadLocalContext().opConfigInfo_.aivNum_)]
                    .get(),
                *memsetV2OpArgCtx->GetOpArg(op::OP_INPUT_ARG),
                *memsetV2OpArgCtx->GetOpArg(op::OP_OUTPUT_ARG),
                *memsetV2OpArgCtx->GetOpArg(op::OP_ATTR_ARG));
            CHECK_COND(res != nullptr, ACLNN_ERR_INNER_NULLPTR, "MemSetV2 Tiling Failed.");
            OP_LOGD("Tiling Key: %lu, len: %zu, BlockDim: %ld",
                *(res->tilingKey_), res->tilingData_->data_size_, *(res->blockDim_));
        }
        // kernel launch
        static uint64_t kernelLaunchId = GenKernelLauncherId(MEMSET_V2_NAME.c_str());
        opTlsCtx.memSetProfilingInfoId_.kernelLauncherId_ = kernelLaunchId;
        uint64_t summaryId = 0;
        if (opProfilingSwitch.kernelLaunchFlag) {
            summaryId = GenSummaryItemId(opTlsCtx.logInfo_.l2ApiName, opTlsCtx.logInfo_.l0Name, MEMSET_V2_NAME.c_str());
        }
        std::vector<int32_t> tensorOffset;
        {
            OpDfxGuard kernelLaunchGuard(summaryId, DfxProfilingKernelLaunch);
            rc = DoLaunch<RtsArg>(res, stream, true, memsetV2OpArgCtx, tensorOffset);
        }
        if (opProfilingSwitch.kernelLaunchFlag && opProfilingSwitch.additionInfoFlag) {
            ReportAdditionInfo(GetTaskInfo(*(res->tilingKey_)), kernelLaunchId, summaryId);
        }
        return rc;
    }

    aclnnStatus GetWorkspace(size_t const *&size, size_t &num,
                             OpArgList &inputs,
                             OpArgList &outputs,
                             OpArgList &attrs)
    {
        if (!hasWorkspace_) {
            num = 0;
            return ACLNN_SUCCESS;
        }

        if (binType_ == BinType::STATIC_BIN) {
            size = staticWorkspaceSize_.data();
            num = staticWorkspaceSize_.size();
            return ACLNN_SUCCESS;
        }
        CHECK_RET_CODE(InitTilingParseCtx(), "InitTilingParseCtx failed");
        if (op::internal::opProfilingSwitch.reportFlag) {
            std::string tilingFuncName = op::OpTypeDict::ToString(opType_).GetString() + std::string("_Tiling");
            GetThreadLocalContext().profilingInfoId_.tilingProfilingId_ =
                CollectProfilingStr(tilingFuncName.c_str());
        }
        OpDfxGuard tilingGuard(GetThreadLocalContext().profilingInfoId_.tilingProfilingId_, DFXProfilingTiling);
        auto res = OpRunContextMgr::Tiling(
            opType_,
            tilingParseCtxHolder_[ThreadCoreNum(GetThreadLocalContext().opConfigInfo_.aicNum_,
                                       GetThreadLocalContext().opConfigInfo_.aivNum_)]
                .get(),
            inputs,
            outputs,
            attrs);
        CHECK_COND(res != nullptr, ACLNN_ERR_INNER_NULLPTR, "Tiling Failed.");
        num = res->workspaceSize_->GetSize();
        size = res->workspaceSize_->GetData();
        // add debug buf size
        if (kernelDfxType_ != static_cast<uint32_t>(KernelDfxType::NO_DFX)) {
            CHECK_COND(num > 0, ACLNN_ERR_INNER, "Enable kernel dfx, but dont have workspace.");
            size_t *sizeMutable = const_cast<size_t *>(size);
            sizeMutable[0] += kernelDfxBufSize_;
        }

        GetLauncherCtx().SaveTilingResCache(res);
        return ACLNN_SUCCESS;
    }

    aclnnStatus MemsetOutputTensor(aclrtStream stream, OpArgContext *args)
    {
        OpKernelBin *memsetBin = nullptr;
#if defined(NNOPBASE_UT) || defined(NNOPBASE_ST)
        SocVersion socVersion = GetCurrentPlatformInfo().GetSocVersion();
#else
        static SocVersion socVersion = GetCurrentPlatformInfo().GetSocVersion();
#endif
        bool needAlign =
            (socVersion == SocVersion::ASCEND910B || socVersion == SocVersion::ASCEND910_95) ? false : true;
        MemsetVersion memsetVersion =
            (socVersion == SocVersion::ASCEND910_95) ? MemsetVersion::MEMSET_V2 : MemsetVersion::MEMSET_V1;
        CHECK_RET_CODE(SelectMemsetOpBin(memsetVersion, memSetValue_.size(), memsetBin), "Select MemSet op failed");

        // for multi thread
        memSetValueCtx_ = memSetValue_;
        if (memsetVersion == MemsetVersion::MEMSET_V2) {
            size_t inputNum = 0;
            if (hasDevPtrArg_) {
                inputNum = GetArgCount4DevPtrArg(*args->GetOpArg(op::OP_INPUT_ARG));
            } else {
                inputNum = GetAclTensorCount(*args->GetOpArg(op::OP_INPUT_ARG));
            }
            CollectMemSetTensor(args, inputNum, needAlign, memsetVersion);
#if !defined(NNOPBASE_UT) && !defined(NNOPBASE_ST)
            return memsetBin->MemSetV2(stream, memSetValueCtx_);
#endif
        } else {
            size_t inputNum = GetAclTensorCount(*args->GetOpArg(op::OP_INPUT_ARG));
            CollectMemSetTensor(args, inputNum, needAlign, memsetVersion);
#if !defined(NNOPBASE_UT) && !defined(NNOPBASE_ST)
            return memsetBin->MemSet(stream, memSetValueCtx_);
#endif
        }
        return ACLNN_SUCCESS;
    }

    void SetMemSetFlagFromJson();

    aclnnStatus GetBinJson(nlohmann::json &jsonObj);

    aclnnStatus GetBinData();

    aclnnStatus BinLoad(); // lazy load kernel bin to device
    size_t GetHashKey() const
    {
        return hashKey_;
    }

    const KeyAndDetail &GetKeyAndDetail()
    {
        return keyAndDetail_;
    }

    bool GetHasDevPtrArg() const
    {
        return hasDevPtrArg_;
    }

    friend class OpKernel;
    aclnnStatus JsonLoad();
    bool IsAssertEnable() const;
    bool IsPrintFEnable() const;
    uint64_t GetKernelDfxBufSize() const;
    void DumpWorkspaceData(aclrtStream stream, OpArgContext *args) const;

    InitOnceVar<nlohmann::json> binJson_;
protected:
    aclnnStatus InitTilingParseCtx();
    TaskInfo GetTaskInfo(uint64_t tilingkey, OpArgContext *args = nullptr);
    void GetTaskRationForSingleBinMutilKernel(
        TaskInfo &info, const nlohmann::json &opJson, uint64_t tilingkey, MsprofGeTaskType taskType);

    uint32_t opType_;
    std::unordered_map<ThreadCoreNum, std::unique_ptr<TilingParseCtxHolder>, ThreadCoreNum::Hash> tilingParseCtxHolder_;

private:
    void ReportOpAttrInfo(OpArgContext *args, uint64_t summaryId);
    aclnnStatus BinLoadImpl(void *&hdl);
    aclnnStatus JsonLoadImpl(nlohmann::json &jsonObj);

    void CollectMemSetTensor(OpArgContext *args, size_t inputNum, bool needAlign, MemsetVersion memsetVersion)
    {
        args->GetOpArg(op::OP_OUTPUT_ARG)
            ->VisitByNoReturn([this, &inputNum, needAlign, memsetVersion](size_t idx, OpArg &elem) {
                CollectMemSetTensor(idx, elem, inputNum, needAlign, memsetVersion);
            });
        args->GetOpArg(op::OP_WORKSPACE_ARG)
            ->VisitByNoReturn([this, &inputNum, needAlign, memsetVersion](size_t idx, OpArg &elem) {
                CollectMemSetTensor(idx, elem, inputNum, needAlign, memsetVersion);
            });

        if (args->ContainsOpArgType(op::OP_OUTSHAPE_ARG)) {
            CollectMemSetTensor(0,
                PtrCastTo<aclTensor>((*args->GetOpArg(op::OP_OUTSHAPE_ARG))[0]->pointer),
                inputNum,
                needAlign);
        }
    }

    void CollectMemSetTensor(size_t idx, const aclTensor *tensor, size_t &allIdx, bool needAlign)
    {
        if (tensor == nullptr) {
            OP_LOGW("MemSet Update Input Arg Tensor is NULL, index in arg list is: %zu", idx);
            return;
        }
        if (tensor->GetPlacement() == gert::kOnHost) {
            OP_LOGW("MemSet Update Input Arg Tensor is onHost, index in arg list is: %zu, %p", idx, tensor);
            allIdx++;
            return;
        }
        OP_LOGD("index in arglist: %zu, allIdx: %zu, tensor: %p", idx, allIdx, tensor);
        for (auto &elem : memSetValueCtx_) {
            if (allIdx == elem.argIdx_) {
                if (needAlign) {
                    elem.tensorDataSize_ = OP_KERNEL_BLOCK_SIZE +
                        AlignSize(tensor->Size() * ge::GetSizeByDataType(tensor->GetDataType()), OP_KERNEL_BLOCK_SIZE);
                } else {
                    elem.tensorDataSize_ = tensor->Size() * ge::GetSizeByDataType(tensor->GetDataType());
                }
                elem.argType_ = OpArgType::OPARG_ACLTENSOR;
                elem.tensorSize_ = tensor->Size();
                elem.tensorData_ = tensor->GetData();
                elem.tensor_ = tensor;
                OP_LOGD("#### MemsetArg %zu, shape size: %zu, data size: %zu, data type: %s, dev addr: %p, tensor: %p",
                    allIdx,
                    elem.tensorSize_,
                    elem.tensorDataSize_,
                    op::ToString(elem.dtype_).GetString(),
                    elem.tensorData_,
                    elem.tensor_);
                break;
            }
        }
        allIdx++;
    }

    void CollectMemSetTensor4DevPtr(const size_t idx, const aclTensorList *const tensorList, size_t &allIdx) const
    {
        if (tensorList == nullptr) {
            OP_LOGW("MemSet Update Input Arg Tensor List is NULL: [%zu]", idx);
            return;
        }
        for (auto &elem : memSetValueCtx_) {
            if (allIdx == elem.argIdx_) {
                elem.argType_ = OpArgType::OPARG_ACLTENSOR_LIST;
                elem.tensorList_ = tensorList;
                OP_LOGD("#### MemsetArg %zu, data type: %s, tensor list: %p",
                    allIdx,
                    op::ToString(elem.dtype_).GetString(),
                    elem.tensorList_);
                break;
            }
        }
        allIdx++;
    }

    void CollectMemSetTensor(size_t idx, const aclTensorList *tensor, size_t &allIdx, bool needAlign)
    {
        if (tensor == nullptr) {
            return;
        }
        for (uint64_t i = 0; i < tensor->Size(); i++) {
            CollectMemSetTensor(idx, (*tensor)[i], allIdx, needAlign);
        }
    }

    void CollectMemSetTensor(size_t idx, OpArg &tensor, size_t &allIdx, bool needAlign, MemsetVersion memsetVersion)
    {
        if (tensor.type == OpArgType::OPARG_ACLTENSOR) {
            CollectMemSetTensor(idx, PtrCastTo<aclTensor>(tensor->pointer), allIdx, needAlign);
        } else if (tensor.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            if (memsetVersion == MemsetVersion::MEMSET_V2 && hasDevPtrArg_ == true) {
                CollectMemSetTensor4DevPtr(idx, PtrCastTo<aclTensorList>(tensor->pointer), allIdx);
            } else {
                CollectMemSetTensor(idx, PtrCastTo<aclTensorList>(tensor->pointer), allIdx, needAlign);
            }
        }
    }

    aclnnStatus AppendTensorShapeInfo(
        size_t idx, const aclTensor *tensor, TilingData *tilingData, bool genPlaceholder) const
    {
        if (tensor == nullptr && !genPlaceholder) {
            OP_LOGW("Append tiling tensor shape, tensor is NULL: [%zu].", idx);
            return ACLNN_SUCCESS;
        }
        if (tilingData->capacity_ <= tilingData->data_size_ ||
            (tilingData->capacity_ - tilingData->data_size_) < sizeof(uint64_t)) {
            OP_LOGW("tiling data remain size not enough, capacity %zu, data size %zu",
                    tilingData->capacity_, tilingData->data_size_);
            return ACLNN_ERR_INNER;
        }
        uint64_t tensorSize = 0;
        if (tensor) {
            tensorSize = AlignSize(CalcShapeBytes(tensor->Size(), tensor->GetDataType()), OP_KERNEL_BLOCK_SIZE);
        }
        *PtrCastTo<uint64_t>(PtrShift(tilingData->data_, tilingData->data_size_)) = tensorSize;
        tilingData->data_size_ += sizeof(uint64_t);
        OP_LOGD("Append tiling tensor shape size %lu: [%zu].", tensorSize, idx);
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendTensorShapeInfo(
        size_t idx, const aclTensorList *tensor, TilingData *tilingData, bool genPlaceholder, bool hasDevPtrArg) const
    {
        if (tensor == nullptr) {
            OP_LOGW("Append tiling tensor shape, tensorlist is NULL: [%zu].", idx);
            return ACLNN_SUCCESS;
        }
        if (hasDevPtrArg) {
            if (tilingData->capacity_ <= tilingData->data_size_ ||
                (tilingData->capacity_ - tilingData->data_size_) < sizeof(uint64_t)) {
                OP_LOGW("tiling data remain size not enough, capacity %zu, data size %zu",
                        tilingData->capacity_, tilingData->data_size_);
                return ACLNN_ERR_INNER;
            }
            size_t dataSize = PTR_OFFSET_SIZE;
            for (uint64_t i = 0; i < tensor->Size(); i++) {
                dataSize += PRT_DIM_SIZE;
                if ((*tensor)[i] != nullptr) {
                    dataSize += (*tensor)[i]->GetStorageShape().GetDimNum() * sizeof(int64_t);
                }
            }
            *PtrCastTo<uint64_t>(PtrShift(tilingData->data_, tilingData->data_size_)) = dataSize;
            tilingData->data_size_ += sizeof(uint64_t);
            OP_LOGD("Append tiling tensor(device ptr) shape size %lu: [%zu].", dataSize, idx);
            return ACLNN_SUCCESS;
        }
        for (uint64_t i = 0; i < tensor->Size(); i++) {
            aclnnStatus ret = AppendTensorShapeInfo(idx, (*tensor)[i], tilingData, genPlaceholder);
            if (ret != ACLNN_SUCCESS) {
                return ret;
            }
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendTensorShapeInfo(
        size_t idx, const std::vector<std::tuple<void *, const aclTensor *>> &arg, TilingData *tilingData) const
    {
        for (const auto &elem : arg) {
            aclnnStatus ret = AppendTensorShapeInfo(idx, std::get<1>(elem), tilingData, false);
            if (ret != ACLNN_SUCCESS) {
                return ret;
            }
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendTensorShapeInfo(size_t idx, OpArg &arg, TilingData *tilingData, OpArgDef opArgDef) const
    {
        if (arg.type == OpArgType::OPARG_ACLTENSOR) {
            bool genPlaceholder = (opArgDef == op::OP_INPUT_ARG) ? genPlaceholder_ : false;
            return AppendTensorShapeInfo(idx, PtrCastTo<aclTensor>(arg->pointer), tilingData, genPlaceholder);
        } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            bool genPlaceholder = (opArgDef == op::OP_INPUT_ARG) ? genPlaceholder_ : false;
            bool hasDevPtrArg = (opArgDef == op::OP_INPUT_ARG || opArgDef == op::OP_OUTPUT_ARG) ? hasDevPtrArg_ : false;
            return AppendTensorShapeInfo(idx, PtrCastTo<aclTensorList>(arg->pointer), tilingData,
                                         genPlaceholder, hasDevPtrArg);
        } else if (arg.type == OpArgType::OPARG_MEMSET_WORKSPACE) {
            return AppendTensorShapeInfo(idx,
                *reinterpret_cast<std::vector<std::tuple<void *, const aclTensor *>> *>(arg->pointer), tilingData);
        }
        return ACLNN_SUCCESS;
    }

    inline aclnnStatus CheckDataRemainCapacity(size_t capaticy, size_t usedSize, size_t addSize) const
    {
        if ((capaticy < usedSize) || ((capaticy - usedSize) < addSize)) {
            OP_LOGW("data remain size not enough, capacity: %zu, used size %zu, add size: %zu",
                capaticy, usedSize, addSize);
            return ACLNN_ERR_INNER;
        }
        return ACLNN_SUCCESS;
    }

    // | tensor1 size | tensor2 size | ... | tensor1 dim num | each dim size | tensor2 dim | each dim size | ... |
    aclnnStatus AppendTensorDfxInfo(void *dfxInfoDumpAddr, size_t &sizeInfoOffset, size_t &shapeInfoOffset,
        bool isOutShapeTensor, const aclTensor *tensor) const
    {
        if ((tensor == nullptr && genPlaceholder_)) {
            *PtrCastTo<uint64_t>(PtrShift(dfxInfoDumpAddr, sizeInfoOffset)) = 0;
            sizeInfoOffset += UINT64_BYTES;
            return ACLNN_SUCCESS;
        }
        OP_CHECK(tensor != nullptr, OP_LOGW("tensor is nullptr"), return ACLNN_ERR_INNER_NULLPTR);
        // append tensor size info
        size_t tensorSize = AlignSize(tensor->GetTensor()->GetSize(), OP_KERNEL_BLOCK_SIZE);
        *PtrCastTo<uint64_t>(PtrShift(dfxInfoDumpAddr, sizeInfoOffset)) = tensorSize;
        sizeInfoOffset += UINT64_BYTES;
        if (isOutShapeTensor) {
            return ACLNN_SUCCESS;
        }
        // append tensor shape info
        auto &shape = tensor->GetStorageShape();
        size_t dimNum = shape.GetDimNum();
        uint64_t *shapeInfoPtr = PtrCastTo<uint64_t>(PtrShift(dfxInfoDumpAddr, shapeInfoOffset));
        if (dimNum == 0) {
            *shapeInfoPtr++ = DIM_NUM_ONE;
            *shapeInfoPtr = DIM_SIZE_ONE;
            shapeInfoOffset += UINT64_BYTES + UINT64_BYTES;
        } else {
            *shapeInfoPtr++ = dimNum;
            const int64_t *dims = &shape[0];
            OP_CHECK(memcpy_s(shapeInfoPtr, dimNum * sizeof(int64_t), dims, dimNum * sizeof(int64_t)) == EOK,
                OP_LOGW("fill dim info failed, tensor size: %zu, dim num: %zu", tensor->GetTensor()->GetSize(), dimNum),
                return ACLNN_ERR_INNER);
            shapeInfoOffset += (1 + dimNum) * UINT64_BYTES;
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendTensorDfxInfo(void *dfxInfoDumpAddr, size_t &sizeInfoOffset, size_t ptrListLen) const
    {
        *PtrCastTo<uint64_t>(PtrShift(dfxInfoDumpAddr, sizeInfoOffset)) = ptrListLen;
        sizeInfoOffset += UINT64_BYTES;
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendAICErrorDFXInfoToDump(
        const std::vector<LaunchArgInfo::ArgAddr> &allArg, void *const dfxInfoDumpAddr, const size_t dumpSize) const
    {
        size_t sizeInfoOffset = 0;
        size_t shapeInfoOffset = allArg.size() * UINT64_BYTES;
        for (size_t i = 0; i < allArg.size(); i++) {
            aclnnStatus ret = ACLNN_SUCCESS;
            if (allArg[i].tag_ == LaunchArgInfo::ArgAddr::ArgTag::DEVICE_ARG) {
                ret = AppendTensorDfxInfo(dfxInfoDumpAddr,
                    sizeInfoOffset,
                    shapeInfoOffset,
                    allArg[i].isOutShapeTensor_,
                    allArg[i].devAddr_.tensor);
            } else if (allArg[i].tag_ == LaunchArgInfo::ArgAddr::ArgTag::HOST_ARG) {
                ret = AppendTensorDfxInfo(dfxInfoDumpAddr,
                    sizeInfoOffset,
                    shapeInfoOffset,
                    allArg[i].isOutShapeTensor_,
                    allArg[i].hostTensor_);
            } else if (allArg[i].tag_ == LaunchArgInfo::ArgAddr::ArgTag::DEVICE_PTR_ARG) {
                ret = AppendTensorDfxInfo(dfxInfoDumpAddr, sizeInfoOffset, allArg[i].devPtrAddr_.ptrListLen);
            } else {
                OP_LOGW("Append AIC Error DFX info: unknown ArgAddr tag [%u], index: %zu.",
                    static_cast<uint32_t>(allArg[i].tag_), i);
            }
            OP_CHECK(ret == ACLNN_SUCCESS,
                OP_LOGW("Append AIC Error DFX info failed, index: %zu, tensor tag: %u.",
                    i, static_cast<uint32_t>(allArg[i].tag_)),
                return ret);
        }
        OP_CHECK(shapeInfoOffset == dumpSize,
            OP_LOGW("The data size filled dump [%zu] is not equal to the requested size [%zu]",
                shapeInfoOffset, dumpSize),
            return ACLNN_ERR_INNER);
        return ACLNN_SUCCESS;
    }

    aclnnStatus AppendAICErrorDFXInfoToTilingData(TilingData *tilingData, const uint64_t dfxInfoDumpIndex) const
    {
        CHECK_RET_CODE(CheckDataRemainCapacity(tilingData->capacity_, tilingData->data_size_, UINT64_BYTES),
            "Tiling data capacity not enough");
        *PtrCastTo<uint64_t>(PtrShift(tilingData->data_, tilingData->data_size_)) = dfxInfoDumpIndex;
        tilingData->data_size_ += UINT64_BYTES;
        return ACLNN_SUCCESS;
    }

    aclnnStatus ParseStaticWorkSpace(const nlohmann::json &workspaceJson);
    aclnnStatus ParseStaticBlockdim(const nlohmann::json &objJson);
    void ParseStaticImplMode(const nlohmann::json &objJson);
    void ParseStaticDevPtrMode(const nlohmann::json &objJson);
    void ParseOpDebugConfig(const nlohmann::json &objJson);
    void ParseOriOpParaSize(const nlohmann::json &objJson);
    void ParseKernelDfxConfig(const nlohmann::json &objJson);

    std::unordered_map<ThreadCoreNum, std::once_flag, ThreadCoreNum::Hash> tilingParseCtxInitFlag_;
    std::mutex mapMutex_;
    std::once_flag &getFlagForKey(const ThreadCoreNum& key)
    {
        std::lock_guard<std::mutex> lock(mapMutex_);
        return tilingParseCtxInitFlag_[key];
    }

    InitOnceVar<void *> handle_[MAX_DEV_NUM];
    thread_local static int currDevId_;
    std::vector<MemSetTensorInfo> memSetValue_;
    thread_local static std::vector<MemSetTensorInfo> memSetValueCtx_;
    bool hasWorkspace_{false};
    FVector<size_t> staticWorkspaceSize_;
    int64_t staticBlockDim_;
    bool interCoreSync_{false};
    uint8_t scheduleMode_{0};
    std::string staticImplMode_;
    uint32_t debugConfig_ = static_cast<uint32_t>(OpDebugConfig::NO_DEBUG);
    uint32_t oriOpParaSize_ = 0;
    uint32_t kernelDfxType_ = static_cast<uint32_t>(KernelDfxType::NO_DFX);
    uint64_t kernelDfxBufSize_ = 0;
    std::set<uint64_t> mixKernel;  // tilingKey of MIX kernel
    std::string binPath_;
    InitOnceVar<std::string> binData_;
    std::string jsonPath_;
    std::string relativeJsonPath_;
    bool isFatbin_{false};
    void *stubFunc_[MAX_DEV_NUM];
    static constexpr size_t maxHostInfoNum_ = 16;
    static constexpr size_t overflowPayloadSize_ = 32;
    KeyAndDetail keyAndDetail_;
    size_t hashKey_;
    BinType binType_;
    bool genPlaceholder_{false};
    bool hasDevPtrArg_{false};
    std::string coreType_;
    void *opKernel_{nullptr};
};

class OpKernel {
    friend class OpKernelBin;
public:
    const std::string &GetOpTypeStr() const;

    void SetOpType(const std::string &opTypeStr);

    uint32_t GetOpType() const;

    void SetOpType(uint32_t opType);

    aclnnStatus Run(aclrtStream stream, OpArgContext *args)
    {
        if (bins_.empty()) {
            OP_LOGE(ACLNN_ERR_INNER, "Op %s does not has any binary.", op::OpTypeDict::ToString(opType_).GetString());
            return ACLNN_ERR_INNER;
        }
        CHECK_RET(args != nullptr, ACLNN_ERR_PARAM_NULLPTR);
        auto bin = SelectBin(*args->GetOpArg(op::OP_INPUT_ARG),
                             *args->GetOpArg(op::OP_OUTPUT_ARG),
                             *args->GetOpArg(op::OP_ATTR_ARG));
        if (bin == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Cannot find binary for op %s.", op::OpTypeDict::ToString(opType_).GetString());
            return ACLNN_ERR_INNER;
        }
        bin->JsonLoad();
        return bin->Launch(stream, args);
    }

    aclnnStatus GetWorkspace(size_t const *&size, size_t &num,
                             OpArgList &inputs,
                             OpArgList &outputs,
                             OpArgList &attrs)
    {
        if (bins_.empty()) {
            OP_LOGE(ACLNN_ERR_INNER_OPP_KERNEL_PKG_NOT_FOUND,
                    "Op %s does not has any binary.", op::OpTypeDict::ToString(opType_).GetString());
            return ACLNN_ERR_INNER_OPP_KERNEL_PKG_NOT_FOUND;
        }

        auto bin = SelectBin(inputs, outputs, attrs);
        if (bin == nullptr) {
            OP_LOGE(ACLNN_ERR_INNER, "Cannot find binary for op %s.", op::OpTypeDict::ToString(opType_).GetString());
            return ACLNN_ERR_INNER;
        }
        auto ret = bin->JsonLoad();
        if (ret != ACLNN_SUCCESS) {
            return ret;
        }
        return bin->GetWorkspace(size, num, inputs, outputs, attrs);
    }

    template <typename CONTAINER>
    static std::string IntegerVecToString(const CONTAINER &integer_vec)
    {
        std::string result = "{";
        for (auto ele : integer_vec) {
            std::string ele_str;
            using DT = typename std::remove_cv<decltype(ele)>::type;
            if (std::is_enum<DT>::value) {
                ele_str = std::to_string(ele);
            } else {
                ele_str = std::to_string(ele);
            }
            result += ele_str;
            result += ",";
        }
        if (result.empty()) {
            return "";
        }
        /* Get rid of the last comma. */
        if (result.back() == ',') {
            result = result.substr(0, result.length() - 1);
        }
        result += "}";
        return result;
    }

    aclnnStatus GenerateStaticParam(OpArgList &inputs, OpArgList &outputs, OpArgList &attrs,
                                    const char*& simpKey)
    {
        FVector<const aclTensor*> tensors;
        FVector<int64_t> dynamicIndex;
        FVector<int64_t> dynamicCount;
        FVector<NnopbaseAttrAddr *> attrsVec;
        CHECK_RET_CODE(inputs.VisitBy([&, this]([[maybe_unused]]size_t idx, OpArg &elem) {
                           return AppendTensor(elem, tensors, dynamicIndex, dynamicCount);
                       }), "Append input tensor failed.");

        for (size_t i = tensors.size(); i < inputNum_; ++i) {
            tensors.emplace_back(nullptr);
        }
        OP_LOGD("After append inputs %zu", tensors.size());
        CHECK_RET_CODE(outputs.VisitBy([&, this]([[maybe_unused]]size_t idx, OpArg &elem) {
                           return AppendTensor(elem, tensors, dynamicIndex, dynamicCount);
                       }), "Append output tensor failed.");

        OP_LOGD("After append outputs %zu", tensors.size());
        auto attrInfoSize = (opTypeStr_ == "LayerNormBetaGammaBackpropV2") ? attrInfos_.size() - 1 : attrInfos_.size();
        CHECK_RET_CODE(attrs.VisitBy([&, this](size_t idx, OpArg &elem) {
                           return AppendAttr(attrInfoSize, idx, elem, attrsVec);
                       }), "Append attr failed.");

        int64_t implMode = ToIndex(GetCurrentImplMode());
        OP_LOGD("tensor size %zu; dynamic index %s, dynamic count %s. Attr size %zu.", tensors.size(),
                IntegerVecToString(dynamicIndex).c_str(), IntegerVecToString(dynamicCount).c_str(), attrsVec.size());
        OP_LOGD("implMode %ld, determin %ld. tensor size %zu, dynamic size %zu, attr size %zu, value depend size %zu.",
                implMode, determinConfig_,
                tensors.size(), dynamicCount.size(), attrsVec.size(), valueDependIndex_.size());
        simpKey = NnopbaseFindStaticKernel(opTypeStr_.c_str(), (tensors.data()),
            static_cast<int64_t>(tensors.size()),
            dynamicIndex.data(),
            dynamicCount.data(),
            static_cast<int64_t>(dynamicCount.size()),
            const_cast<const NnopbaseAttrAddr **>(attrsVec.data()),
            static_cast<int64_t>(attrsVec.size()),
            implMode, determinConfig_,
            valueDependIndex_.data(), valueDependIndex_.size());
        if (simpKey != nullptr) {
            OP_LOGD("Simp key is %s", simpKey);
        } else {
            OP_LOGD("Simp key is nullptr");
        }

        for (auto &attr : attrsVec) {
            op::internal::BlockPool::Free(attr);
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus GetOpDescJson(bool debug);

    aclnnStatus AppendStaticBin(const nlohmann::json &opJson, const string &binAndJsonDir);

    /* Generate mapping of {simplified_key -> the path of json and bin} */
    aclnnStatus AppendDynBin(const std::string &jsonPath, const std::string &binAndJsonDir, bool debug);

    OpKernelBin *SelectStaticBin(OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
    {
        const std::lock_guard<std::mutex> lock(staticKernelsMutex_);
        if (staticBins_.empty()) {
            return nullptr;
        }
        const char* simpKey = nullptr;
        auto ret = GenerateStaticParam(inputs, outputs, attrs, simpKey);
        if (ret != ACLNN_SUCCESS || simpKey == nullptr) {
            return nullptr;
        }
        size_t hash = HashBinary(simpKey, strlen(simpKey));
        auto iter = staticBins_.find(hash);
        if (iter == staticBins_.end()) {
            OP_LOGI("Cannot find static bin of op %s, simplified key %s.",
                    op::OpTypeDict::ToString(opType_).GetString(), simpKey);
            return nullptr;
        }

        OP_LOGI("Available static bin for op %s is %s. Key is %s",
                op::OpTypeDict::ToString(opType_).GetString(), iter->second->binPath_.c_str(), simpKey);
        return iter->second.get();
    }

    OpKernelBin *SelectBin(OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
    {
        auto staticBin = SelectStaticBin(inputs, outputs, attrs);
        if (staticBin != nullptr) {
            return staticBin;
        }

        if (maxKeyLength_ == 0) {
            OP_LOGE(ACLNN_ERR_INNER, "Cannot find and bin for op %s.", op::OpTypeDict::ToString(opType_).GetString());
            return nullptr;
        }

        KeyLength len{0, 0, 0, maxKeyLength_};
        char *integralKey = (char *) op::internal::BlockPool::Malloc(len.totalBufferLength);
        OP_CHECK(integralKey != nullptr, 
                 OP_LOGE(ACLNN_ERR_PARAM_NULLPTR, "malloc failed, integralKey is nullptr."),
                 return nullptr);
        char *initAddr = integralKey;
        OP_CHECK((GenerateKey(integralKey, len, inputs, outputs, attrs) == ACLNN_SUCCESS),
                 OP_LOGW("generateKey is not success when selecBin."),
                 ;);
        //  *integralKey = '\0'; // Add a '\0' at the end of integral key.

        size_t hash = HashBinary(initAddr, (integralKey - initAddr));
        auto iter = bins_.find(hash);
        if (iter == bins_.end()) {
            OP_LOGE(ACLNN_ERR_INNER,
                    "Cannot find bin of op %s, integral key %s.",
                    op::OpTypeDict::ToString(opType_).GetString(),
                    GetReadableKey(std::string(initAddr, integralKey - initAddr), len).c_str());
            op::internal::BlockPool::Free(initAddr);
            return nullptr;
        }

        OP_LOGI("Available bin for op %s is %s. Key is %s",
                op::OpTypeDict::ToString(opType_).GetString(),
                iter->second->binPath_.c_str(),
                GetReadableKey(std::string(initAddr, integralKey - initAddr), len).c_str());
        op::internal::BlockPool::Free(initAddr);
        return iter->second.get();
    }

    void ClearStaticBins()
    {
        const std::lock_guard<std::mutex> lock(staticKernelsMutex_);
        if (!staticBins_.empty()) {
            for (auto &pair : staticBins_) {
                abandonedStaticBins_.push_back(std::move(pair.second));
            }
            staticBins_.clear();
        }
    }

    void ReleaseTilingParse()
    {
        auto f = [](std::map<size_t, std::unique_ptr<OpKernelBin>> &bins) {
            for (const auto &element : bins) {
                OpKernelBin *kernelBin = element.second.get();
                if (kernelBin) {
                    for(auto &[key, value] : kernelBin->tilingParseCtxHolder_) {
                        TilingParseCtxHolder *tilingParse = value.get();
                        if (tilingParse) {
                            tilingParse->ReleaseTilingParse();
                        }
                    }
                }
            }
        };
        f(bins_);
        const std::lock_guard<std::mutex> lock(staticKernelsMutex_);
        f(staticBins_);
    }

private:
    aclnnStatus AppendTensor(const aclTensor *tensor,
                             FVector<const aclTensor*> &tensors,
                             FVector<int64_t> &dynamicIndex, FVector<int64_t> &dynamicCount) const;

    aclnnStatus AppendTensor(const aclTensorList *tensorList,
                             FVector<const aclTensor*> &tensors,
                             FVector<int64_t> &dynamicIndex, FVector<int64_t> &dynamicCount) const;

    aclnnStatus AppendTensor(OpArg &opArg,
                             FVector<const aclTensor*> &tensors,
                             FVector<int64_t> &dynamicIndex, FVector<int64_t> &dynamicCount) const;

    aclnnStatus AppendAttr(size_t attrSizeInProto, size_t idx, OpArg &value, FVector<NnopbaseAttrAddr*> &attrs)
    {
        if (idx >= attrSizeInProto) {
            OP_LOGD("Index is larger than %zu", attrSizeInProto);
            return ACLNN_SUCCESS;
        }
        NnopbaseAttrAddr *attr =
            PtrCastTo<NnopbaseAttrAddr>(op::internal::BlockPool::Malloc(sizeof(NnopbaseAttrAddr)));
        attrs.emplace_back(attr);
        attr->isOptional = false;
        attr->isVector = false;
        attr->elementSize = 0;
        if (value.type == OpArgType::OPARG_DATATYPE) {
            OP_LOGD("Append Attr DataType: [%zu], %lu", idx, value->value);
            attr->addr = &(value->value);
            attr->size = sizeof(value->value);
        } else if (value.type == OpArgType::OPARG_BOOL ||
            value.type == OpArgType::OPARG_INT ||
            value.type == OpArgType::OPARG_UINT) {
#ifdef DEBUG
            std::stringstream ss;
            ss << value->value;
            OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
            OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
            attr->addr = &(value->value);
            attr->size = sizeof(value->value);
        } else if (value.type == OpArgType::OPARG_DOUBLE) {
#ifdef DEBUG
            std::stringstream ss;
            ss << value->dvalue;
            OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
            OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
            attr->addr = &(value->dvalue);
            attr->size = sizeof(value->dvalue);
        } else if (value.type == OpArgType::OPARG_FLOAT) {
#ifdef DEBUG
            std::stringstream ss;
            ss << value->fvalue;
            OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
            OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
            attr->addr = &(value->fvalue);
            attr->size = sizeof(value->fvalue);
        } else if (value.type == OpArgType::OPARG_STRING) {
            if (value->pointer == nullptr) {
                OP_LOGD("Append Attr char*/string*: [%zu]. nullptr", idx);
                attr->addr = nullptr;
                attr->size = 0;
            } else {
                char *str = reinterpret_cast<char *>(value->pointer);
                OP_LOGD("Append Attr char*/string*: [%zu]. %s", idx, str);
                attr->size = strlen(str);
                attr->addr = value->pointer;
            }
        } else if (value.type == OpArgType::OPARG_ACLSCALAR) {
            if (value->pointer == nullptr) {
                OP_LOGW("Update Attr NULL aclScalar*: [%zu]", idx);
                attr->addr = nullptr;
                attr->size = 0;
            } else {
                OP_LOGD("Update Attr aclScalar*: [%zu]", idx);
                aclScalar *saclarValue = reinterpret_cast<aclScalar *>(value->pointer);
                attr->addr = const_cast<void *>(saclarValue->GetData());
                attr->size = saclarValue->Size();
            }
        } else if (value.type == OpArgType::OPARG_INT_LIST
                   || value.type == OpArgType::OPARG_FLOAT_LIST) {
            attr->isVector = true;
            if (value->pointer == nullptr) {
                OP_LOGW("Update Attr NULL aclIntArray/aclFloatArray*: [%zu]", idx);
                attr->addr = value->pointer;
                attr->size = 0;
            } else {
                if (value.type == OpArgType::OPARG_INT_LIST) {
                    aclIntArray *intArrayValue = reinterpret_cast<aclIntArray *>(value->pointer);
                    attr->addr = const_cast<int64_t *>(intArrayValue->GetData());
                    attr->elementSize = sizeof(*intArrayValue->GetData());
                    attr-> size = attr->elementSize * intArrayValue->Size();
                } else {
                    aclFloatArray *floatArrayValue = reinterpret_cast<aclFloatArray *>(value->pointer);
                    attr->addr = const_cast<float *>(floatArrayValue->GetData());
                    attr->elementSize = sizeof(*floatArrayValue->GetData());
                    attr-> size = attr->elementSize * floatArrayValue->Size();
                }
                OP_LOGD("Update array attr*: [%zu] byte size %zu elementsize %zu", idx, attr->size,
                        attr->elementSize);
            }
        } else {
            OP_LOGW("Attr Type NOT SUPPORTED. supported type[ge::DataType, aclScalar, std::string, aclIntArray, "
                    "aclFloatArray, arithmetic type]");
        }
        return ACLNN_SUCCESS;
    }

    size_t HashBinary(const char *addr, uint32_t len) const;

    aclnnStatus InitTensorInfo(const nlohmann::json &binListJson);

    void JudgeCustomizedSimpliedKeyMode(const nlohmann::json &binListJson);

    aclnnStatus ParseAttributes(const nlohmann::json &singleBinJson, std::string &key);

    aclnnStatus AssembleKeyForSingleTensor(const nlohmann::json &tensor, std::string &key,
                                           TensorInfo &tensorInfo);

    aclnnStatus AssembleKeyByTensor(const nlohmann::json &inOrOuts,
                                    std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                                    std::string &key, KeyParams &keyParams);

    aclnnStatus GenKeyByArgs(char *&integralKey, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                             OpArgList &args) const
    {
        // Your implementation here
        // Return 0 on success, otherwise return a non-zero error code
        return GenKeyByOneArg(integralKey, tensorInfos, genPlaceholder_, args);
    }

    aclnnStatus GenerateKeyCustomizedSimplifiedKey(
        char *&integralKey, KeyLength &len, OpArgList &inputs, OpArgList &outputs, OpArgList &attrs) const
    {
        AssignAndIncrement(integralKey, len.totalBufferLength, PtrCastTo<uint8_t>("d="), sizeof("d=") - 1);
        if (determinConfig_ == 1) {
            AssignAndIncrement(integralKey, DETERMINISTIC_VALUE);
        } else {
            AssignAndIncrement(integralKey, NON_DETERMINISTIC_VALUE);
        }
        AssignAndIncrement(integralKey, len.totalBufferLength - sizeof("d=1") - 1,
                           PtrCastTo<uint8_t>(",p="), sizeof(",p=") - 1);
        AssignAndIncrement(integralKey, ToIndexChar(GetCurrentImplMode()));
        AssignAndIncrement(integralKey, SLASH);
        *integralKey = '\0';

        if (OpRunContextMgr::GenSimplifiedKey(opType_, integralKey, inputs, outputs, attrs)) {
            OP_LOGE(ACLNN_ERR_INNER, "failed to generate simplified key.");
            return ACLNN_ERR_INNER;
        }
        integralKey += std::strlen(integralKey);
        return ACLNN_SUCCESS;
    }

    aclnnStatus GenerateKey(char *&integralKey, KeyLength &len, OpArgList &inputs,
                            OpArgList &outputs, OpArgList &attrs)
    {
        if (customizedSimplifiedKeyMode_) {
            return GenerateKeyCustomizedSimplifiedKey(integralKey, len, inputs, outputs, attrs);
        }

        /* 1. Generate key for context. */
        // simp_key: "deterministic/overflow/precision_mode"
        // deterministic:
        // overflow: default as 1
        //  "high_performance" :1;
        //  "high_precision" : 2
        //  "super_performance" : 3,
        //  "support_out_of_bound_index": 4
        //  "enable_float_32_execution": 5
        //  "enable_hi_float_32_execution": 6
        //  "keep_fp16": 7
        char *originalKey = integralKey;
        if (determinConfig_ == 1) {
            AssignAndIncrement(integralKey, DETERMINISTIC_VALUE);
        } else {
            AssignAndIncrement(integralKey, NON_DETERMINISTIC_VALUE);
        }

        AssignAndIncrement(integralKey, SLASH); // delimiter
        AssignAndIncrement(integralKey, ToIndexChar(GetCurrentImplMode()));
        AssignAndIncrement(integralKey, SLASH); // delimiter

        len.ctxLen = integralKey - originalKey;

        /* 2. Generate key for inputs. */
        auto ret = GenKeyByArgs(integralKey, inputInfos_, inputs);
        if (ret != ACLNN_SUCCESS) {
            return ret;
        }
        /* 3. Generate key for outputs. */
        ret = GenKeyByArgs(integralKey, outputInfos_, outputs);
        if (ret != ACLNN_SUCCESS) {
            OP_LOGW("genKeyByArgs about outputs is not success when generateKey.");
        }
        len.ctxAndtensorLen = integralKey - originalKey;
        OP_LOGD("ctxAndtensorLen %zu addr[%p, %p] [%s].", len.ctxAndtensorLen, integralKey, originalKey,
                GetReadableKey(std::string(originalKey, len.ctxAndtensorLen), len).c_str());
        if (len.ctxAndtensorLen >= len.totalBufferLength) {
            OP_LOGE(ACLNN_ERR_INNER, "tensorLen %zu is >= total_size %zu", len.ctxAndtensorLen, len.totalBufferLength);
            return ACLNN_ERR_INNER;
        }

        /* 4. Generate key for attrs. */
        if (attrInfos_.empty()) {
            return ret;
        }
        if (ingnoreAttrSimplifiedKeyMode_) {
            return ret;
        }
        auto remainingLen = len.totalBufferLength - len.ctxAndtensorLen;
        ret = GenKeyByAttrs(integralKey, remainingLen, attrInfos_, attrs);
        return ret;
    }

    OpImplMode GetCurrentImplMode() const
    {
        OpImplMode mode = GetLauncherCtx().GetImplMode();
        OP_LOGD("User defined op impl mode %u", static_cast<uint32_t>(mode));
        if (mode != OpImplMode::IMPL_MODE_DEFAULT && IsSupportImplMode(mode)) {
            return mode;
        } else {
            if (IsSupportImplMode(OpImplMode::IMPL_MODE_HIGH_PRECISION)) {
                OP_LOGD("Precision mode is high precision.");
                return OpImplMode::IMPL_MODE_HIGH_PRECISION;
            } else {
                OP_LOGD("Precision mode is high performance.");
                return OpImplMode::IMPL_MODE_HIGH_PERFORMANCE;
            }
        }
    }

    aclnnStatus ParseContext(const nlohmann::json &singleBinJson, const std::string &jsonPath, KeyParams &keyParams);

    void UpdateFormatType(std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos, size_t validTensorNum) const;

    aclnnStatus HashAndInsert(const std::string &binAndJsonDir, const std::string &binOrJsonPath,
                              const size_t &pos, KeyParams &keyParams);

    aclnnStatus GenerateKeyBySimplifiedKey(const nlohmann::json &singleBinJson, KeyParams &keyParams);

    aclnnStatus GenerateKeyByJson(const nlohmann::json &singleBinJson, const std::string &jsonPath,
                                  KeyParams &keyParams);

    bool IsGenInputPlaceholder(const nlohmann::json &singleBinJson);
    bool HasDevPtrArg(const nlohmann::json &singleBinJson) const;

    void GetReadableFmtDtypeKey(wchar_t ele, int32_t &cnt, std::string &debug_str) const;
    std::string GetReadableKey(const std::string &key, KeyLength &len) const;

    /* If the shape dimensions of a tensor are different among all
     * kernels, for example non_zero.json, we will take shape dimension
     * into the bianry matching key. */
    aclnnStatus JudgeInputSupportAll(const nlohmann::json &binListJson);

    aclnnStatus JudgeAttrSupportAll(const nlohmann::json &binListJson);

    inline void AppendImplModeBm(OpImplMode implMode)
    {
        implModeBm_ |= static_cast<uint32_t>(implMode);
    }

    inline bool IsSupportImplMode(OpImplMode implMode) const
    {
        return implModeBm_ & static_cast<uint32_t>(implMode);
    }

    std::array<TensorInfo, MAX_TENSOR_SIZE> inputInfos_;
    std::array<TensorInfo, MAX_TENSOR_SIZE> outputInfos_;
    std::vector<AttrInfo> attrInfos_;

    FVector<int64_t> valueDependIndex_;
    size_t inputNum_ = 0;
    size_t outputNum_ = 0;
    size_t maxAttrLen_ = 0;
    uint64_t implModeBm_ = 0; // Use bitmap to show how many op impl types this kernel supports
    size_t maxKeyLength_ = 0;
    bool needMatchAttrDimNum_ = false;
    int64_t determinConfig_ = 0;
    nlohmann::json configJson_;
    std::string configJsonPath_;
    uint32_t opType_;
    std::string opTypeStr_;
    bool genPlaceholder_{false};
    bool customizedSimplifiedKeyMode_{false};
    bool ingnoreAttrSimplifiedKeyMode_{false};
    /* key is an integer generated by a binary of:
   * deterministic/op_precision_mode/overflow_status/input0_format,input0_dtype..../output0_format,output0_dtype...
   */
protected:
    std::map<size_t, std::unique_ptr<OpKernelBin>> bins_;
    std::map<size_t, std::unique_ptr<OpKernelBin>> staticBins_;
    std::vector<std::unique_ptr<OpKernelBin>> abandonedStaticBins_;

private:
    std::mutex staticKernelsMutex_;
};

} // namespace internal
} // namespace op
#endif // OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_H
