/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_COMMON_INC_OPDEV_INTERNAL_RTS_LAUNCHER_H
#define OP_API_COMMON_INC_OPDEV_INTERNAL_RTS_LAUNCHER_H

#include <memory>
#include <vector>

#include "securec.h"
#include "aclnn/acl_meta.h"
#include "opdev/internal/kernel_utils.h"
#include "opdev/op_errno.h"
#include "opdev/op_dfx.h"
#include "opdev/op_cache.h"
#include "runtime/kernel.h"
#include "runtime/rt_ffts.h"
#include "runtime/context.h"
#include "runtime/rts/rts_context.h"
#include "kernel_arg.h"

namespace op::internal {

class RtsApiFlag {
public:
    static RtsApiFlag &GetRtsApiFlag()
    {
        static RtsApiFlag flag;
        return flag;
    }

    RtsApiFlag() = default;

    void UseNewApi(bool flag)
    {
        useNewFlag_ = flag;
    }

    bool IfNewApi() const
    {
        return useNewFlag_;
    }

private:
    bool useNewFlag_{false};
};

class LaunchArgCache {
public:
    enum ArgType : uint32_t {
        FFTS_ADDR = 1,
        DEV_ADDR = 2,
        HOST_DATA = 3,
        TILING_DATA = 4,
        OVERFLOW_ADDR = 5,
        DEV_PTR_ADDR = 6
    };

    enum RtsApiType : uint16_t {
        RTS_OLD = 1,
        RTS_NEW = 2
    };

    enum RtsLaunchType : uint16_t {
        LAUNCH_WITH_HANDLE = 1,
        LAUNCH_WITH_FLAG = 2
    };
    struct ArgInfo {
        ArgType type;      // ffts/device addr/host data/overflow/device ptr addr
        uint32_t dataLen;  // only data on host has a length. dataLen of device data is zero
    };

    ArgInfo *GetArgInfo()
    {
        return PtrCastTo<ArgInfo>(argData_);
    }

    void SetArgNum(size_t num)
    {
        argNum_ = num;
    }

    size_t GetArgInfoNum() const
    {
        return argNum_;
    }

    void SetExceptionArgNum(size_t num)
    {
        exceptionArgNum_ = num;
    }

    size_t GetExceptionArgNum() const
    {
        return exceptionArgNum_;
    }

    void SetLaunchArgNum(size_t num)
    {
        launchArgNum_ = num;
    }

    size_t GetLaunchArgNum() const
    {
        return launchArgNum_;
    }

    void SetDFXInfoCacheSize(size_t size)
    {
        dfxInfoCacheSize_ = size;
    }

    size_t GetDFXInfoCacheSize() const
    {
        return dfxInfoCacheSize_;
    }

    void SetDFXInfoOffsetInTilingData(size_t offset)
    {
        dfxInfoOffsetInTilingData_ = offset;
    }

    size_t GetDFXInfoOffsetInTilingData() const
    {
        return dfxInfoOffsetInTilingData_;
    }

    void SetRtsApiType(RtsApiType type)
    {
        rtsType_ = type;
    }

    RtsApiType GetRtsApiType() const
    {
        return rtsType_;
    }

    RtsLaunchType GetRtsLaunchType() const
    {
        return launchType_;
    }

    void SetRunParam(void *handle, RtsLaunchType type, uint32_t blockDim, uint64_t tilingKey,
        uint8_t scheduleMode, uint32_t localMemorySize)
    {
        handle_ = handle;
        launchType_ = type;
        blockDim_ = blockDim;
        tilingKey_ = tilingKey;
        localMemorySize_ = localMemorySize;
        memset_s(&cfgInfo_, sizeof(cfgInfo_), 0, sizeof(cfgInfo_));
        cfgInfo_.schemMode = scheduleMode;
        cfgInfo_.localMemorySize = localMemorySize;
        OP_LOGD("Cache scheduleMode: %u", cfgInfo_.schemMode);
    }

    void *GetRawRtsArg()
    {
        return PtrShift(argData_, argNum_ * sizeof(ArgInfo));
    }

    void *GetRawHostData()
    {
        return PtrShift(argData_, argNum_ * sizeof(ArgInfo) + argNum_ * sizeof(void *));
    }

    void *GetLaunchHandle() const
    {
        return handle_;
    }

    uint32_t GetBlockDim() const
    {
        return blockDim_;
    }

    uint32_t GetLocalMemorySize() const
    {
        return localMemorySize_;
    }

    uint64_t GetTilingKey() const
    {
        return tilingKey_;
    }

    const rtTaskCfgInfo_t *GetCfgInfo()
    {
        return &cfgInfo_;
    }

    size_t GetRawArgSize()
    {
        size_t hostLen = 0;
        ArgInfo *argInfo = GetArgInfo();

        for (size_t i = 0; i < argNum_; i++) {
            if (argInfo[i].type == HOST_DATA || argInfo[i].type == TILING_DATA || argInfo[i].type == DEV_PTR_ADDR) {
                hostLen += argInfo[i].dataLen;
            }
        }
        return sizeof(void *) * argNum_ + hostLen;
    }

    void SetOpType(const char *opType)
    {
        strcpy_s(opType_, sizeof(opType_), opType);
    }

    const char *GetOpType()
    {
        return opType_;
    }

    void SetHostArgInfo(size_t size, size_t num)
    {
        hostArgSize_ = size;
        hostArgNum_ = num;
    }

    size_t GetHostArgSize() const
    {
        return hostArgSize_;
    }

    size_t GetHostArgNum() const
    {
        return hostArgNum_;
    }

    static aclnnStatus RunFromCache(aclrtStream stream, void *cache);
    static aclnnStatus RunFromCacheNew(aclrtStream stream, void *cache);

private:
    char opType_[16];
    void *handle_{nullptr};
    RtsApiType rtsType_{0};
    RtsLaunchType launchType_{0};
    uint32_t blockDim_{0};
    uint64_t tilingKey_{0};
    uint32_t localMemorySize_{0};

    size_t hostArgSize_{0};
    size_t hostArgNum_{0};
    rtTaskCfgInfo_t cfgInfo_;

    size_t argNum_{0};
    size_t exceptionArgNum_{0};
    size_t launchArgNum_{0};
    size_t dfxInfoCacheSize_{0};
    size_t dfxInfoOffsetInTilingData_{0};
    uint8_t argData_[0];  // ArgInfo array + dev_addr + host data
};

// There's how launch args are composed:
// ffts_addr, input_addrs, output_addrs, outshape_addrs, workspace_addrs, tiling_addr, overflow_addr, host_data...
class RtsArg {
public:
    explicit RtsArg(bool hasFftsAddr, const LaunchArgInfo &argInfo, size_t hostDataCap);
    aclnnStatus FillArgs(bool assertFlag = false);
    LaunchArgCache *DumpToCache();

    aclnnStatus KernelLaunchWithHandle(void *handle, rtStream_t stream, const uint64_t tilingkey,
        uint32_t blockDim, uint8_t scheduleMode, [[maybe_unused]] uint32_t localMemorySize);
    aclnnStatus VectorCoreKernelLaunchWithHandle(void *handle, rtStream_t stream, const uint64_t tilingkey,
        uint32_t blockDim, uint32_t blockDimOffset, uint8_t scheduleMode, [[maybe_unused]] uint32_t localMemorySize);
    aclnnStatus KernelLaunchWithFlag(const void *stubFunc, rtStream_t stream, uint32_t blockDim,
        uint8_t scheduleMode, [[maybe_unused]] uint32_t localMemorySize);
    aclnnStatus VectorCoreKernelLaunchWithFlag(const void *stubFunc, rtStream_t stream, uint32_t blockDim,
        uint32_t blockDimOffset, uint8_t scheduleMode, [[maybe_unused]] uint32_t localMemorySize);

    const rtArgsEx_t &GetRtsArg() const
    {
        return rtArg_;
    }

    std::vector<int32_t> GetTensorOffset() const
    {
        return tensorOffset_;
    }
    static constexpr size_t HOST_VALUE_ALIGNMENT = 32;
    static constexpr uint32_t DEV_PTR_DIM_SHIFT_BIT = 32;

private:
    aclnnStatus AppendFftsAddr();
    aclnnStatus FinalizeArg();
    void AppendExceptionDumpAddr(bool assertFlag = false);
    void AppendArg(void *arg)
    {
        *hostAddr_ = arg;
        tensorOffset_.push_back(PtrOffset(rtArg_.args, hostAddr_) / PTR_SIZE);
        hostAddr_++;
    }

    aclnnStatus AppendHostArg(void *hostData, size_t hostDataSize);
    aclnnStatus AppendDevicePtrArg(const aclTensorList *tensors, size_t dataSize);
    void AppendOverflowStatusAddr()
    {
        static void *overflowAddr = nullptr;
        if (overflowAddr == nullptr) {
            rtError_t rc = rtsCtxGetFloatOverflowAddr(&overflowAddr);
            OP_CHECK(rc == RT_ERROR_NONE,
                    OP_LOGW("rtsCtxGetFloatOverflowAddr failed. %d", rc),
                    return);
        }
        *hostAddr_ = overflowAddr;
        hostAddr_++;
    }

    void AddExceptionDumpDataToCache(
        const LaunchArgInfo &argInfo, OpExecCache *cache, LaunchArgCache *launchCache) const;
    void AddDFXInfoDumpDataToCache(const LaunchArgInfo &argInfo, OpExecCache *cache, LaunchArgCache *launchCache) const;

    bool hasFftsAddr_{false};
    const LaunchArgInfo &argInfo_;
    rtArgsEx_t rtArg_;
    size_t argNum_;

    void **hostAddr_{nullptr};
    void *hostValue_{nullptr};
    std::vector<int32_t> tensorOffset_;

    const void *tilingData_{nullptr};
    void *hostValueEnd_{nullptr};
    void *exceptionDumpAddr_{nullptr};
    uint32_t exceptionDumpIndex_{0};

    static constexpr size_t MAX_HOST_INFO_NUM = 16;
    static constexpr size_t PTR_SIZE = 8;

public:
    thread_local static std::vector<rtHostInputInfo_t> hostInputInfo_;
};

class RtsArgNew {
public:
    explicit RtsArgNew(bool hasFftsAddr, const LaunchArgInfo &argInfo, size_t hostDataCap);
    ~RtsArgNew()
    {
        if (argHandle_ != nullptr) {
            (void)rtDestroyLaunchArgs(argHandle_);
        }
    }

    aclnnStatus FillArgs(bool assertFlag = false);
    std::vector<int32_t> GetTensorOffset() const
    {
        return std::vector<int32_t>();
    }
    LaunchArgCache *DumpToCache();
    aclnnStatus KernelLaunchWithHandle(void *binHandle, rtStream_t stream, uint64_t tilingKey, uint32_t blockDim,
        [[maybe_unused]] uint8_t scheduleMode, [[maybe_unused]] uint32_t localMemorySize)
    {
        rtFuncHandle funcHdl = nullptr;
        CHECK_RET(rtBinaryGetFunction(binHandle, tilingKey, &funcHdl) == RT_ERROR_NONE, ACLNN_ERR_INNER);
        CHECK_RET(rtLaunchKernelByFuncHandle(funcHdl, blockDim, argHandle_, stream) == RT_ERROR_NONE,
            ACLNN_ERR_INNER);
        return ACLNN_SUCCESS;
    }

    aclnnStatus KernelLaunchWithFlag([[maybe_unused]] const void *stubFunc, [[maybe_unused]] rtStream_t stream,
        [[maybe_unused]] uint32_t blockDim, [[maybe_unused]] uint8_t scheduleMode,
        [[maybe_unused]] uint32_t localMemorySize)
    {
        return ACLNN_SUCCESS;
    }

    const rtArgsEx_t &GetRtsArg() const
    {
        static rtArgsEx_t dummy{};
        return dummy;
    }

    static size_t GetTilingAddrOffset(size_t deviceArgNum, size_t hostDataLen)
    {
        // Adjust kernel arg offset to avoid tilingdata copy when kernel launching.
        // WARNING: This is tightly coupled with RTS kernel launch implementation.
        return deviceArgNum * sizeof(void *) + hostDataLen;
    }
private:
    bool hasFftsAddr_{false};
    const LaunchArgInfo &argInfo_;
    size_t launchArgSize_{0};
    rtLaunchArgsHandle argHandle_{nullptr};

    aclnnStatus AppendFftsAddr();
    aclnnStatus AppendArg(void *arg)
    {
        rtError_t rc = rtAppendLaunchAddrInfo(argHandle_, arg);
        if (rc != RT_ERROR_NONE) {
            OP_LOGE(rc, "rtAppendLaunchAddrInfo. argHandle_: %p, arg: %p", argHandle_, arg);
            return ACLNN_ERR_INNER;
        }

        return ACLNN_SUCCESS;
    }
    aclnnStatus AppendHostArg(void *hostData, size_t hostDataSize, bool needCopy);

    void AppendOverflowStatusAddr()
    {
        void *overflowAddr = nullptr;
        rtError_t rc = rtsCtxGetFloatOverflowAddr(&overflowAddr);
        OP_CHECK(rc == RT_ERROR_NONE,
                OP_LOGW("rtsCtxGetFloatOverflowAddr failed. %d", rc),
                return);
        AppendArg(overflowAddr);
    }

    static size_t GetAlignHostArgSize(const LaunchArgInfo &argInfo);
    static constexpr size_t HOST_VALUE_ALIGNMENT = 32;
};

int PrintRtArg(const rtArgsEx_t &rtArg);
int PrintExceptionDumpInfo(void *dump, size_t num);
int PrintAICErrorDFXInfo(const void *dfxInfoAddr, const size_t argNum, const size_t dataSize);
}  // namespace op::internal

#endif