/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STARS_ARG_MANAGER_HPP__
#define __CCE_RUNTIME_STARS_ARG_MANAGER_HPP__
#include <mutex>
#include "task_info.hpp"
#include "arg_loader.hpp"
#include "arg_loader_ub.hpp"

namespace cce {
namespace runtime {

class Stream;
class Device;
class Kernel;

constexpr uint8_t STARS_ARG_STREAM_NUM_MAX = 8U;
constexpr uint32_t STARS_ARG_POOL_SQ_SIZE = 1024U;
constexpr uint32_t UB_ARG_MAX_COPY_SIZE = 256U * 1024U * 1024U;

#ifdef __x86_64__
constexpr uint32_t STM_ARG_POOL_COPY_SIZE = 1024U;
#else
constexpr uint32_t STM_ARG_POOL_COPY_SIZE = 4096U;
#endif

class StarsArgManager {
public:
    explicit StarsArgManager(Stream* const stm) : stream_(stm) {}

    virtual ~StarsArgManager() { stream_ = nullptr; }

    virtual rtError_t MallocArgMem(void*& devAddr, void*& hostAddr) = 0;
    virtual void FreeArgMem() = 0;
    virtual bool CreateArgRes();
    virtual void ReleaseArgRes();

    // Non-inline helpers to avoid circular dependency with stream.hpp
    uint32_t GetDevId() const;
    int32_t GetStmId() const;

    template <typename T>
    rtError_t LoadArgs(
        const T* argsInfo, const bool useArgPool, StarsArgLoaderResult* const result,
        const LoadPolicy policy = LoadPolicy::LP_GENERIC)
    {
        result->kerArgs = argsInfo->args;
        if (policy == LoadPolicy::LP_GENERIC) {
            return LoadArgsWithGenericPolicy(argsInfo, useArgPool, result);
        }
        return LoadArgsWithSpecificPolicy(argsInfo, useArgPool, policy, result);
    }

    virtual bool AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result) = 0;
    bool AllocStmArgPos(const uint32_t argsSize, uint32_t& startPos, uint32_t& endPos);
    bool RecycleStmArgPos(const uint32_t taskId, const uint32_t stmArgPos);
    virtual void RecycleDevLoader(void* const handle) = 0;
    virtual rtError_t AllocCopyPtr(
        const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result) = 0;

    virtual rtError_t AllocNoCopyPtr(StarsArgLoaderResult* const result)
    {
        UNUSED(result);
        return RT_ERROR_NONE;
    }

    uint32_t GetStmArgPos();

    virtual rtError_t H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size) = 0;
    virtual rtError_t LoadArgsFromArray(
        const bool useArgPool, const Kernel* kernel, void** argsArray, StarsArgLoaderResult* result) = 0;
    virtual rtError_t LoadSimtArgsFromArray(
        const bool useArgPool, const Kernel* kernel, SimtArgsArray* simtArgsArray, StarsArgLoaderResult* result) = 0;
    virtual rtError_t LoadSimtHostArgs(
        const bool useArgPool, SimtArgsHost* simtArgsHost, StarsArgLoaderResult* result) = 0;

    uint32_t argPoolSize_{0U};
    void* devArgResBaseAddr_{nullptr};
    void* hostArgResBaseAddr_{nullptr};

protected:
    Stream* stream_;
    void FreeFail(StarsArgLoaderResult* const result);

private:
    template <typename T>
    rtError_t LoadArgsWithGenericPolicy(const T* argsInfo, bool useArgPool, StarsArgLoaderResult* result)
    {
        if (argsInfo->isNoNeedH2DCopy != 0U) {
            return RT_ERROR_NONE;
        }
        return LoadArgsWithCopy(argsInfo, useArgPool, LoadPolicy::LP_GENERIC, result);
    }

    template <typename T>
    rtError_t LoadArgsWithSpecificPolicy(
        const T* argsInfo, bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* result)
    {
        const bool shouldCopy = ShouldCopyByPolicy(*stream_, argsInfo->isNoNeedH2DCopy, policy);
        if (shouldCopy) {
            return LoadArgsWithCopy(argsInfo, useArgPool, policy, result);
        }

        rtError_t error{RT_ERROR_NONE};
        // 无需执行copy但是需要创建handle，非LP_GENERIC策略才会有的行为，对齐stars历史接口
        if (policy == LoadPolicy::LP_NO_MIX || policy == LoadPolicy::LP_CPU_KRN ||
            policy == LoadPolicy::LP_CPU_KRN_EX) {
            error = AllocNoCopyPtr(result);
        }
        if (policy == LoadPolicy::LP_MIX) {
            // 其中LP_MIX在isNoNeedH2DCopy=false时依然需要创建dev侧handle，所以此处和isNoNeedH2DCopy=true时走同样的handle创建流程
            error = AllocCopyPtr(argsInfo->argsSize, useArgPool, policy, result);
        }

        if (error != RT_ERROR_NONE) {
            FreeFail(result);
            return error;
        }
        result->kerArgs = argsInfo->args;
        return RT_ERROR_NONE;
    }

    template <typename T>
    rtError_t LoadArgsWithCopy(const T* argsInfo, bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* result)
    {
        const uint32_t devId = GetDevId();
        const int32_t stmId = GetStmId();
        const uint32_t size = argsInfo->argsSize;
        rtError_t error = AllocCopyPtr(size, useArgPool, policy, result);
        if (error != RT_ERROR_NONE) {
            FreeFail(result);
            RT_LOG(
                RT_LOG_ERROR, "Alloc args copy ptr failed, size=%u, device_id=%u, stream_id=%d.", size, devId, stmId);
            return error;
        }
        RT_LOG(RT_LOG_DEBUG, "Alloc args copy ptr success, size=%u, device_id=%u, stream_id=%d.", size, devId, stmId);
        error = LoadInputOutputArgs(result, argsInfo);
        if (error != RT_ERROR_NONE) {
            FreeFail(result);
            RT_LOG(RT_LOG_ERROR, "Load args failed, size=%u, device_id=%u, stream_id=%d.", size, devId, stmId);
            return error;
        }
        RT_LOG(RT_LOG_INFO, "Load args success, size=%u, device_id=%u, stream_id=%d.", size, devId, stmId);
        return RT_ERROR_NONE;
    }

    rtError_t LoadInputOutputArgs(const StarsArgLoaderResult* const result, const rtArgsEx_t* const argsInfo);
    rtError_t LoadInputOutputArgs(const StarsArgLoaderResult* const result, const rtAicpuArgsEx_t* const argsInfo);
    rtError_t LoadInputOutputArgs(const StarsArgLoaderResult* const result, const rtFusionArgsEx_t* const argsInfo);

    Atomic<uint32_t> stmArgHead_{0U}; // recycle
    Atomic<uint32_t> stmArgTail_{0U}; // alloc
    std::mutex stmArgHeadMutex_;
    std::mutex stmArgTailMutex_;
};

class UbArgManage : public StarsArgManager {
public:
    using StarsArgManager::StarsArgManager;
    ~UbArgManage() override = default;
    rtError_t MallocArgMem(void*& devAddr, void*& hostAddr) override;
    void FreeArgMem() override;
    bool AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result) override;
    rtError_t AllocCopyPtr(
        const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result) override;
    rtError_t H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size) override;
    void RecycleDevLoader(void * const handle) override;
    rtError_t LoadArgsFromArray(
        const bool useArgPool, const Kernel* kernel, void** argsArray, StarsArgLoaderResult* result) override;
    rtError_t LoadSimtArgsFromArray(
        const bool useArgPool, const Kernel* kernel, SimtArgsArray* simtArgsArray, StarsArgLoaderResult* result) override;
    rtError_t LoadSimtHostArgs(
        const bool useArgPool, SimtArgsHost* simtArgsHost, StarsArgLoaderResult* result) override;
private:
    struct memTsegInfo memTsegInfo_;
    rtError_t ParseArgsCpyWqe(const StarsArgLoaderResult* const result, const uint32_t size) const;
};

class PcieArgManage : public StarsArgManager {
public:
    using StarsArgManager::StarsArgManager;
    ~PcieArgManage() override = default;
    rtError_t MallocArgMem(void*& devAddr, void*& hostAddr) override;
    void FreeArgMem() override;
    bool AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result) override;
    rtError_t AllocCopyPtr(
        const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result) override;
    rtError_t AllocNoCopyPtr(StarsArgLoaderResult* const result) override;
    rtError_t H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size) override;
    void RecycleDevLoader(void * const handle) override;
    rtError_t LoadArgsFromArray(
        const bool useArgPool, const Kernel* kernel, void** argsArray, StarsArgLoaderResult* result) override;
    rtError_t LoadSimtArgsFromArray(
        const bool useArgPool, const Kernel* kernel, SimtArgsArray* simtArgsArray, StarsArgLoaderResult* result) override;
    rtError_t LoadSimtHostArgs(
        const bool useArgPool, SimtArgsHost* simtArgsHost, StarsArgLoaderResult* result) override;

private:
    rtError_t PrepareSimtArgsBuffer(
        const uint32_t totalArgsSize, const bool useArgPool, const rtDim3& gridDim,
        const rtDim3& blockDim, StarsArgLoaderResult* result, void** argsBuffer);
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_STARS_ARG_MANAGER_HPP__
