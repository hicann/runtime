/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ARG_MANAGE_DAVID_HPP__
#define __CCE_RUNTIME_ARG_MANAGE_DAVID_HPP__
#include <mutex>
#include "task_info.hpp"
#include "arg_loader.hpp"
#include "arg_loader_ub.hpp"

namespace cce {
namespace runtime {

class Stream;
class Device;

constexpr uint8_t DAVID_ARG_STREAM_NUM_MAX = 8U;
constexpr uint32_t DAVID_ARG_POOL_SQ_SIZE = 1024U;
constexpr uint32_t UB_ARG_MAX_COPY_SIZE = 256U * 1024U * 1024U;

#ifdef __x86_64__
constexpr uint32_t STM_ARG_POOL_COPY_SIZE = 1024U;
#else
constexpr uint32_t STM_ARG_POOL_COPY_SIZE = 4096U;
#endif

class DavidArgManage {
public:
    explicit DavidArgManage(Stream * const stm) : stream_(stm) {}

    virtual ~DavidArgManage()
    {
        stream_ = nullptr;
    }

    virtual rtError_t MallocArgMem(void *&devAddr, void *&hostAddr) = 0;
    virtual void FreeArgMem() = 0;
    virtual bool CreateArgRes();
    virtual void ReleaseArgRes();

    template<typename T>
    rtError_t LoadArgs(const T *argsInfo, const bool useArgPool, DavidArgLoaderResult * const result)
    {
        rtError_t error = RT_ERROR_NONE;
        const uint32_t devId = stream_->Device_()->Id_();
        const int32_t stmId = stream_->Id_();
        result->kerArgs = argsInfo->args;
        COND_RETURN_WITH_NOLOG((argsInfo->isNoNeedH2DCopy != 0U), RT_ERROR_NONE);

        error = AllocCopyPtr(argsInfo->argsSize, useArgPool, result);
        if (error != RT_ERROR_NONE) {
            FreeFail(result);
            RT_LOG(RT_LOG_ERROR, "Alloc args copy ptr failed, device_id=%u, stream_id=%d.", devId, stmId);
            return error;
        }
        RT_LOG(RT_LOG_DEBUG, "Alloc args copy ptr success, device_id=%u, stream_id=%d.", devId, stmId);

        error = LoadInputOutputArgs(result, argsInfo);
        if (error != RT_ERROR_NONE) {
            FreeFail(result);
            RT_LOG(RT_LOG_ERROR, "Load args failed, device_id=%u, stream_id=%d.", devId, stmId);
            return error;
        }
        RT_LOG(RT_LOG_INFO, "Load args success, device_id=%u, stream_id=%d.", devId, stmId);
        return RT_ERROR_NONE;
    }

    virtual bool AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result) = 0;
    bool AllocStmArgPos(const uint32_t argsSize, uint32_t &startPos, uint32_t &endPos);
    bool RecycleStmArgPos(const uint32_t taskId, const uint32_t stmArgPos);
    virtual void RecycleDevLoader(void * const handle) = 0;
    virtual rtError_t AllocCopyPtr(const uint32_t size, const bool useArgPool,
                                   DavidArgLoaderResult * const result) = 0;

    uint32_t GetStmArgPos();

    void UpdateAddrField(const void * const kerArgs, void * const argsHostAddr, const uint16_t hostInputInfoNum,
                         const rtHostInputInfo * const hostInputInfoPtr);
    virtual rtError_t H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size) = 0;

    uint32_t argPoolSize_{0U};
    void *devArgResBaseAddr_{nullptr};
    void *hostArgResBaseAddr_{nullptr};

protected:
    Stream *stream_;

private:
    void FreeFail(DavidArgLoaderResult * const result);

    rtError_t LoadInputOutputArgs(const DavidArgLoaderResult * const result, const rtArgsEx_t * const argsInfo);
    rtError_t LoadInputOutputArgs(const DavidArgLoaderResult * const result, const rtAicpuArgsEx_t * const argsInfo);
    rtError_t LoadInputOutputArgs(const DavidArgLoaderResult * const result, const rtFusionArgsEx_t * const argsInfo);

    Atomic<uint32_t> stmArgHead_{0U}; // recycle
    Atomic<uint32_t> stmArgTail_{0U}; // alloc
    std::mutex stmArgHeadMutex_;
    std::mutex stmArgTailMutex_;
};

class UbArgManage : public DavidArgManage {
public: 
    using DavidArgManage::DavidArgManage;
    ~UbArgManage() override = default;
    rtError_t MallocArgMem(void *&devAddr, void *&hostAddr) override;
    void FreeArgMem() override;
    bool AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result) override;
    rtError_t AllocCopyPtr(const uint32_t size, const bool useArgPool, DavidArgLoaderResult * const result) override;
    rtError_t H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size) override;
    void RecycleDevLoader(void * const handle) override;
private:
    struct memTsegInfo memTsegInfo_;
    rtError_t ParseArgsCpyWqe(const DavidArgLoaderResult * const result, const uint32_t size) const;
};

class PcieArgManage : public DavidArgManage {
public:
    using DavidArgManage::DavidArgManage;
    ~PcieArgManage() override = default;
    rtError_t MallocArgMem(void *&devAddr, void *&hostAddr) override;
    void FreeArgMem() override;
    bool AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result) override;
    rtError_t AllocCopyPtr(const uint32_t size, const bool useArgPool, DavidArgLoaderResult * const result) override;
    rtError_t H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size) override;
    void RecycleDevLoader(void * const handle) override;
private:
};

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_ARG_MANAGE_DAVID_HPP__
