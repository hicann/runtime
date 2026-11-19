/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software: you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_CRYPTO_PLUGIN_H
#define CCE_RUNTIME_CC_CRYPTO_PLUGIN_H

#include <atomic>
#include <cstdint>
#include <cstddef>
#include <new>

#include "task_queue/host_task_queue.h"
#include "base.hpp"
#include "cc_task_queue.h"
#include "crypto/cc_crypto.h"

namespace cce {
namespace runtime {

class CCStreamResManage;
class Stream;

struct CCCryptoSliceCtx {
    AiccSliceDescBase* desc; ///< 算法 desc（公共字段已填，算法专有字段由插件补）
    void* hostBuf;           ///< worker 的 pinned host 缓冲
    const void* src;         ///< 本分片源地址（task.src + offset）
    void* dst;               ///< 本分片目的地址（task.dst + offset）
    size_t sliceSize;        ///< 本分片明文字节数
    uint32_t sliceIdx;       ///< 分片序号
    uint32_t deviceId;       ///< 设备 id
    void* pluginTaskCtx;     ///< 插件 per-task 状态（OnTaskBegin 产出，OnTaskEnd 销毁）
};

// 每设备一个插件；Begin 创建任务状态，End 在成功/失败路径均须调用。
class CCCryptoPlugin : public NoCopy {
public:
    virtual ~CCCryptoPlugin();

    CC_CRYPTO_ALG_TYPE AlgType() const;
    CC_CRYPTO_CIPHER Cipher() const;
    const char_t* KernelName() const;
    uint32_t SliceDescSize() const;
    virtual rtError_t OnTaskBegin(
        const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void** pluginTaskCtx);
    virtual rtError_t PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen);
    virtual rtError_t OnH2DSliceDone(CCCryptoSliceCtx& ctx);
    virtual rtError_t PrepareD2HSlice(CCCryptoSliceCtx& ctx);
    virtual rtError_t FinishD2HSlice(CCCryptoSliceCtx& ctx);
    virtual void OnTaskEnd(const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void* pluginTaskCtx);
    virtual rtError_t LaunchTransfer(Stream* stm, uint64_t taskQueueAddr, const CCMemcpyTask& task) = 0;

    static rtError_t LaunchDeviceKernel(Stream* stm, const char_t* kernelName, void* args, uint32_t argsSize);

protected:
    CCCryptoPlugin(
        CC_CRYPTO_ALG_TYPE algType, std::atomic<CC_CRYPTO_CIPHER>& cipher, const char_t* kernelName,
        uint32_t sliceDescSize);

private:
    const CC_CRYPTO_ALG_TYPE algType_{CC_CRYPTO_ALG_TYPE::GCM}; ///< 构造时注入（AlgType 返回）
    std::atomic<CC_CRYPTO_CIPHER>& cipher_; ///< 生效加密算法的原子引用（运行期可切换，Cipher 返回当前值）
    const char_t* kernelName_{nullptr}; ///< 构造时注入（KernelName 返回）
    const uint32_t sliceDescSize_{0U};  ///< 构造时注入（SliceDescSize 返回）
};

using CCCryptoPluginFactory = CCCryptoPlugin* (*)(CCrypto* crypto);

// 静态初始化期登记工厂；Create 返回的新对象由调用方释放。
rtError_t RegisterCryptoPlugin(CC_CRYPTO_ALG_TYPE algType, CCCryptoPluginFactory factory);

rtError_t CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE algType, CCrypto* crypto, CCCryptoPlugin** plugin);

// 模式首次读取后缓存；cipher 切换立即对已建插件生效，未实现项由加解密路径拒绝。
CC_CRYPTO_ALG_TYPE GetActiveCryptoAlg();

CC_CRYPTO_CIPHER GetActiveCryptoCipher();

rtError_t SetActiveCryptoCipher(CC_CRYPTO_CIPHER cipher);

std::atomic<CC_CRYPTO_CIPHER>& ActiveCryptoCipherRef();

#define CC_REGISTER_CRYPTO_PLUGIN(algType, Cls)                                                 \
    static ::cce::runtime::CCCryptoPlugin* CcCreatePlugin##Cls(::cce::runtime::CCrypto* crypto) \
    {                                                                                           \
        return new (std::nothrow) Cls(crypto);                                                  \
    }                                                                                           \
    [[maybe_unused]] static const rtError_t g_ccCryptoPluginRegistered_##Cls =                  \
        ::cce::runtime::RegisterCryptoPlugin((algType), CcCreatePlugin##Cls)

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_CRYPTO_PLUGIN_H
