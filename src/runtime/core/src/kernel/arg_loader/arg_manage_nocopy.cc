/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device.hpp"
#include "stream.hpp"
#include "stars_arg_manager.hpp"

namespace cce {
namespace runtime {
uint32_t StarsArgManager::GetDevId() const { return stream_->Device_()->Id_(); }

int32_t StarsArgManager::GetStmId() const { return stream_->Id_(); }

bool StarsArgManager::CreateArgRes() { return false; }

void StarsArgManager::ReleaseArgRes() {}

bool StarsArgManager::RecycleStmArgPos(const uint32_t taskId, const uint32_t stmArgPos)
{
    UNUSED(taskId);
    UNUSED(stmArgPos);
    return false;
}

bool StarsArgManager::AllocStmArgPos(const uint32_t argsSize, uint32_t& startPos, uint32_t& endPos)
{
    UNUSED(argsSize);
    UNUSED(startPos);
    UNUSED(endPos);
    return false;
}

void StarsArgManager::FreeFail(StarsArgLoaderResult* const result)
{
    if (result->handle != nullptr) {
        RecycleDevLoader(result->handle);
    }
    result->kerArgs = nullptr;
    result->hostAddr = nullptr;
    result->handle = nullptr;
    result->stmArgPos = UINT32_MAX;
}

rtError_t StarsArgManager::LoadInputOutputArgs(
    const StarsArgLoaderResult* const result, const rtArgsEx_t* const argsInfo)
{
    UNUSED(result);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t StarsArgManager::LoadInputOutputArgs(
    const StarsArgLoaderResult* const result, const rtAicpuArgsEx_t* const argsInfo)
{
    UNUSED(result);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

uint32_t StarsArgManager::GetStmArgPos() { return UINT32_MAX; }

rtError_t PcieArgManage::MallocArgMem(void*& devAddr, void*& hostAddr)
{
    UNUSED(devAddr);
    UNUSED(hostAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void PcieArgManage::FreeArgMem() {}

bool PcieArgManage::AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result)
{
    UNUSED(size);
    UNUSED(result);
    return false;
}

rtError_t PcieArgManage::AllocCopyPtr(
    const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result)
{
    UNUSED(size);
    UNUSED(useArgPool);
    UNUSED(policy);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t PcieArgManage::AllocNoCopyPtr(StarsArgLoaderResult* const result)
{
    ArgLoaderResult res = {};
    rtError_t error = RT_ERROR_NONE;
    error = stream_->Device_()->ArgLoader_()->AllocNoCopyPtr(result->kerArgs, &res);
    if (error == RT_ERROR_NONE) {
        result->kerArgs = res.kerArgs;
        result->handle = res.handle;
        result->allocatedEntrySize = 0U;
    }
    return error;
}

rtError_t PcieArgManage::H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size)
{
    UNUSED(result);
    UNUSED(args);
    UNUSED(size);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void PcieArgManage::RecycleDevLoader(void* const handle) { (void)stream_->Device_()->ArgLoader_()->Release(handle); }

rtError_t PcieArgManage::LoadArgsFromArray(
    const bool useArgPool, const Kernel* kernel, void** argsArray, StarsArgLoaderResult* result)
{
    UNUSED(useArgPool);
    UNUSED(kernel);
    UNUSED(argsArray);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t PcieArgManage::LoadSimtArgsFromArray(
    const bool useArgPool, const Kernel* kernel, SimtArgsArray* simtArgsArray, StarsArgLoaderResult* result)
{
    UNUSED(useArgPool);
    UNUSED(kernel);
    UNUSED(simtArgsArray);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t PcieArgManage::LoadSimtHostArgs(
    const bool useArgPool, SimtArgsHost* simtArgsHost, StarsArgLoaderResult* result)
{
    UNUSED(useArgPool);
    UNUSED(simtArgsHost);
    UNUSED(result);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
