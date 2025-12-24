/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_RUNTIME_INTF_HPP
#define CCE_RUNTIME_RUNTIME_INTF_HPP

#include "base.hpp"
#include "errcode_manage.hpp"
#include "dev.h"
#include "toolchain/prof_api.h"
#include "stream.hpp"

namespace cce {
namespace runtime {

class Api;
class ApiMbuf;
class Context;

struct RtTimeoutConfig {
    std::mutex mtx;
    bool isCfgOpWaitTaskTimeout;
    uint64_t opWaitTaskTimeout; // unit: s
    bool isCfgOpExcTaskTimeout;
    uint64_t opExcTaskTimeout;  // unit: us
    bool isInit{false};
    bool isOpTimeoutMs{false};
    float64_t interval{0.0F}; // unit: us
};

// 抽象类，被API调用的接口需要声明为纯虚函数
class RuntimeIntf {
public:
    RuntimeIntf() = default;
    virtual ~RuntimeIntf() = default;

    RuntimeIntf(const RuntimeIntf &) = delete;
    RuntimeIntf &operator=(const RuntimeIntf &) = delete;
    RuntimeIntf(RuntimeIntf &&) = delete;
    RuntimeIntf &operator=(RuntimeIntf &&) = delete;
    virtual rtError_t Init() = 0;
    // Get api implement.
    virtual Api *Api_() const = 0;
    // Get apiMbuf implement.
    virtual ApiMbuf *ApiMbuf_() const = 0;
    virtual Api *ApiImpl_() const = 0;
    virtual rtError_t ProfilerStop(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
        const uint64_t profSwitchHi = 0) = 0;
    virtual rtError_t ProfilerStart(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
        const uint32_t cacheFlag, const uint64_t profSwitchHi = 0) = 0;
    virtual rtError_t SetExceptCallback(const rtErrorCallback callback) = 0;
    virtual rtError_t SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
        TaskAbortCallbackType type) = 0;
    virtual rtError_t SetAicpuAttr(const char_t * const key, const char_t * const value) const = 0;
    virtual rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm, void *evtNotify) = 0;
    virtual rtError_t UnSubscribeReport(Stream * const stm) = 0;
    virtual Context *GetPriCtxByDeviceId(const uint32_t deviceId, uint32_t tsId) = 0;
    virtual rtError_t GetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset) const = 0;
    virtual rtError_t GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length) const = 0;
    virtual rtError_t FreeKernelBin(char_t * const buffer) const = 0;
    virtual bool ChipIsHaveStars() const = 0;
    virtual rtSocType_t GetSocType() const = 0;
    virtual rtArchType_t GetArchType() const = 0;
    virtual int64_t GetAicpuCnt() const = 0;
    virtual bool GetDisableThread() const = 0;
    virtual rtMemType_t GetTsMemType(rtMemRequestFeature_t featureType, uint64_t memSize) = 0;
    virtual void SetBiuperfProfFlag(bool flag) = 0;
    virtual void SetL2CacheProfFlag(bool flag) = 0;
    virtual uint32_t GetWaitTimeout() = 0;
    virtual rtError_t ChgUserDevIdToDeviceId(const uint32_t userDevId, uint32_t * const deviceId,
        bool isDeviceSetResetOp = false) const = 0;
    virtual void MacroInit(const rtChipType_t chipTypeValue) = 0;
    virtual rtError_t RegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback) = 0;
    virtual rtError_t UnRegKernelLaunchFillFunc(const char* symbol) = 0;
    virtual Context *CurrentContext() const = 0;
    virtual void SetGlobalErr(const rtError_t errcode) const  = 0;
    virtual rtError_t GetNpuDeviceCnt(int32_t &cnt) = 0;

private:
};
}
}
#endif