/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_JETTY_MANAGER_H__
#define __CCE_RUNTIME_JETTY_MANAGER_H__

#include <map>
#include <utility>
#include <mutex>
#include <memory>
#include "jetty_pool.h"
#include "stream_jetty_context.h"
#include "capture_model.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t JETTY_POOL_ACQUIRE_RETRY_MAX_COUNT = 10U;

class JettyManager {
public:
    explicit JettyManager(uint32_t deviceId);
    ~JettyManager()
    {
        Clear();
    }

    /**
     * @brief 为流预留 Jetty(Capture 阶段使用)
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t ReserveJetty(JettyType type);

    /**
     * @brief 绑定 Jetty 到流(Graph Reply 阶段使用)
     * @param streamId 流 ID
     * @param excludeMdl model
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t BindJettyForStream(int32_t streamId, const CaptureModel * const excludeMdl, JettyType type);

    /**
     * @brief 解绑 Jetty 从流
     * @param streamId 流 ID
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t UnbindJettyForStream(int32_t streamId, JettyType type);

    /**
     * @brief 根据 handle 直接释放 Jetty（不依赖 context）
     * @param handle Jetty 句柄
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t ReleaseJettyByHandle(uint64_t handle, JettyType type);

    /**
     * @brief 获取流的 Jetty 信息
     * @param streamId 流 ID
     * @param type Jetty 类型
     * @param jettyInfo 输出参数，返回 Jetty 信息
     * @return rtError_t 错误码
     */
    rtError_t GetJettyInfoForStream(int32_t streamId, JettyType type, JettyInfo& jettyInfo);

    /**
     * @brief 获取或创建流的 Capture Jetty 上下文
     * @param stream 流
     * @param type Jetty 类型
     * @return StreamJettyContext* 上下文指针
     */
    StreamJettyContext* GetOrCreateStreamJettyContext(const Stream *stream, JettyType type);

    /**
     * @brief 获取流的 Capture Jetty 上下文(只读，不创建)
     * @param streamId 流 ID
     * @param type Jetty 类型
     * @return StreamJettyContext* 上下文指针，不存在返回 nullptr
     */
    StreamJettyContext* GetStreamJettyContext(int32_t streamId, JettyType type) const;

    /**
     * @brief 销毁流的 Capture Jetty 上下文
     * @param streamId 流 ID
     * @param type Jetty 类型
     */
    void DestroyStreamJettyContext(int32_t streamId, JettyType type);

    /**
     * @brief 清空所有 Jetty
     */
    void Clear();

private:
    std::unique_ptr<JettyPool> jettyPool_;
    std::map<std::pair<uint32_t, JettyType>, std::unique_ptr<StreamJettyContext>> streamCaptureContexts_;
    mutable std::recursive_mutex managerLock_;
    
    rtError_t AcquireJettyWithRetry(JettyType type, int32_t streamId,
        const CaptureModel * const excludeMdl, JettyInfo& jettyInfo);
};

} // namespace runtime
} // namespace cce

#endif
