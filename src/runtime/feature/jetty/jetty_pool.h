/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_JETTY_POOL_H__
#define __CCE_RUNTIME_JETTY_POOL_H__

#include <cstdint>
#include <memory>
#include <vector>
#include <mutex>
#include "base.hpp"
#include "drv/driver.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t JETTY_POOL_H2D_MAX_SIZE = 1024U;
constexpr uint32_t JETTY_POOL_D2D_MAX_SIZE = 1024U;
constexpr uint32_t JETTY_DEPTH_STANDARD = 2048U;

enum class JettyType : uint8_t { JETTY_TYPE_H2D = 0, JETTY_TYPE_D2D = 1, JETTY_TYPE_MAX };

enum class JettyState : uint8_t { FREE = 0, BOUND };

struct JettyInfo {
    uint64_t handle = 0;
    uint32_t dieId = 0;
    uint32_t functionId = 0;
    uint32_t jettyId = 0;
    uint32_t depth = JETTY_DEPTH_STANDARD;
    JettyType type = JettyType::JETTY_TYPE_MAX;
    JettyState state = JettyState::FREE;
};

class JettyPool {
public:
    explicit JettyPool(uint32_t deviceId);
    ~JettyPool();

    /**
     * @brief 创建 jetty 并放入 pool（状态为 FREE）
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t ReserveJetty(JettyType type);

    /**
     * @brief 释放 Jetty, 适用于非large jetty
     * @param handle Jetty 句柄
     * @param type Jetty 类型
     * @return rtError_t 错误码
     */
    rtError_t ReleaseJetty(uint64_t handle, JettyType type);

    /**
     * @brief 获取 FREE jetty 并标记为 BOUND（用于 Graph Reply 阶段绑定）
     * @param type Jetty 类型
     * @param jettyInfo 输出参数，返回 Jetty 信息
     * @return rtError_t 错误码
     */
    rtError_t AcquireJetty(JettyType type, JettyInfo& jettyInfo);

    /**
     * @brief 标记 Jetty 为空闲
     * @param handle Jetty 句柄
     * @return rtError_t 错误码
     */
    rtError_t MarkFree(uint64_t handle);

    /**
     * @brief 创建大深度 Jetty(深度 > 2k，不走标准池)
     * @param type Jetty 类型
     * @param depth Jetty 深度(必须是 2^n)
     * @param jettyInfo 输出参数，返回创建的 Jetty 信息
     * @return rtError_t 错误码
     */
    rtError_t CreateLargeDepthJetty(JettyType type, uint32_t depth, JettyInfo& jettyInfo);

    /**
     * @brief 销毁大深度 Jetty
     * @param handle Jetty 句柄
     * @return rtError_t 错误码
     */
    rtError_t DestroyLargeDepthJetty(uint64_t handle);

    /**
     * @brief 查询 Jetty 信息
     * @param handle Jetty 句柄
     * @param dieId 输出参数，返回 DIE ID
     * @param functionId 输出参数，返回函数 ID
     * @param jettyId 输出参数，返回 Jetty ID
     * @return rtError_t 错误码
     */
    rtError_t QueryJettyInfo(uint64_t handle, uint32_t& dieId, uint32_t& functionId, uint32_t& jettyId) const;

    /**
     * @brief 根据句柄查找 Jetty 信息(适用于全部类型)
     * @param handle Jetty 句柄
     * @param jettyInfo 输出参数，返回 Jetty 信息指针
     * @return bool 是否找到
     */
    bool FindJettyByHandle(uint64_t handle, JettyInfo*& jettyInfo);

    /**
     * @brief 根据句柄查找 Jetty 信息并拷贝(线程安全，内部持有 poolLock_)
     * @param handle Jetty 句柄
     * @param jettyInfo 输出参数，返回 Jetty 信息副本
     * @return rtError_t 错误码
     */
    rtError_t GetJettyInfoByHandle(uint64_t handle, JettyInfo& jettyInfo);

    /**
     * @brief 清空 JettyPool
     */
    void Clear();

private:
    rtError_t CreateJetty(JettyType type, uint32_t depth, JettyInfo& jettyInfo) const;
    bool FindJettyByState(JettyType type, JettyState state, JettyInfo *&jettyInfo);

    uint32_t deviceId_{0};
    std::vector<JettyInfo> h2dJettyPool_;
    std::vector<JettyInfo> d2dJettyPool_;
    std::vector<JettyInfo> largeJettyPool_;
    std::mutex poolLock_;
};
} // namespace runtime
} // namespace cce

#endif
