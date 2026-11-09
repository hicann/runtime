/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_RT_CONFIG_HPP
#define CCE_RUNTIME_API_RT_CONFIG_HPP

#include "base.hpp"

namespace cce {
namespace runtime {

class Stream;

class ApiRtConfig {
public:
    ApiRtConfig() = default;
    virtual ~ApiRtConfig() = default;

    ApiRtConfig(const ApiRtConfig&) = delete;
    ApiRtConfig& operator=(const ApiRtConfig&) = delete;
    ApiRtConfig(ApiRtConfig&&) = delete;
    ApiRtConfig& operator=(ApiRtConfig&&) = delete;

    static ApiRtConfig* Instance();

    virtual rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal) = 0;
    virtual rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t* const configVal) = 0;
    virtual rtError_t SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, const uint32_t value) = 0;
    virtual rtError_t ResetDeviceResLimit(const uint32_t devId) = 0;
    virtual rtError_t GetDeviceResLimit(
        const uint32_t devId, const rtDevResLimitType_t type, uint32_t* const value) = 0;
    virtual rtError_t SetStreamResLimit(Stream* const stm, const rtDevResLimitType_t type, const uint32_t value) = 0;
    virtual rtError_t ResetStreamResLimit(Stream* const stm) = 0;
    virtual rtError_t GetStreamResLimit(
        const Stream* const stm, const rtDevResLimitType_t type, uint32_t* const value) = 0;
    virtual rtError_t UseStreamResInCurrentThread(const Stream* const stm) = 0;
    virtual rtError_t NotUseStreamResInCurrentThread(const Stream* const stm) = 0;
    virtual rtError_t GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t* const value) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_RT_CONFIG_HPP
