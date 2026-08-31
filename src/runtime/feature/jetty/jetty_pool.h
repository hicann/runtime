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

enum class JettyType : uint8_t {
    JETTY_TYPE_H2D = 0,
    JETTY_TYPE_D2D_IN_BOARD = 1,
    JETTY_TYPE_D2D_CROSS_BOARD = 2,
    JETTY_TYPE_MAX
};

static inline const char* JettyTypeName(const JettyType type)
{
    switch (type) {
        case JettyType::JETTY_TYPE_H2D:
            return "JETTY_TYPE_H2D";
        case JettyType::JETTY_TYPE_D2D_IN_BOARD:
            return "JETTY_TYPE_D2D_IN_BOARD";
        case JettyType::JETTY_TYPE_D2D_CROSS_BOARD:
            return "JETTY_TYPE_D2D_CROSS_BOARD";
        case JettyType::JETTY_TYPE_MAX:
            return "JETTY_TYPE_MAX";
        default:
            return "UNKNOWN";
    }
}

enum class JettyState : uint8_t { FREE = 0, BOUND };

enum class JettyAllocMode : uint8_t { POOLED = 0, DIRECT };

struct JettyInfo {
    uint64_t handle = 0ULL;
    uint32_t dieId = 0U;
    uint32_t functionId = 0U;
    uint32_t jettyId = 0U;
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
    rtError_t PreAllocJetty(JettyType type);

    /**
     * @brief 释放 Jetty（销毁并移除）
     * @param handle Jetty 句柄
     * @param mode 分配模式：POOLED 从 h2d/d2d pool 中查找，DIRECT 从 directJettyList 中查找
     * @param type Jetty 类型（仅 POOLED 模式使用）
     * @return rtError_t 错误码
     */
    rtError_t FreeJetty(uint64_t handle, JettyAllocMode mode, JettyType type);

    /**
     * @brief 获取 FREE jetty 并标记为 BOUND（用于 Graph Reply 阶段绑定）
     * @param type Jetty 类型
     * @param jettyInfo 输出参数，返回 Jetty 信息
     * @return rtError_t 错误码
     */
    rtError_t AllocJetty(JettyType type, JettyInfo& jettyInfo);

    /**
     * @brief 标记 Jetty 为空闲
     * @param handle Jetty 句柄
     * @return rtError_t 错误码
     */
    rtError_t FreeJettyLazy(uint64_t handle);

    /**
     * @brief 直接创建 Jetty，不参与标准池复用
     * @param type Jetty 类型
     * @param depth Jetty 深度(必须是 2^n)
     * @param jettyInfo 输出参数，返回创建的 Jetty 信息
     * @return rtError_t 错误码
     */
    rtError_t AllocDirectJetty(JettyType type, uint32_t depth, JettyInfo& jettyInfo);

    /**
     * @brief 查询 Jetty 信息
     * @param handle Jetty 句柄
     * @param dieId 输出参数，返回 DIE ID
     * @param functionId 输出参数，返回函数 ID
     * @param jettyId 输出参数，返回 Jetty ID
     * @return rtError_t 错误码
     */
    rtError_t GetJettyInfo(uint64_t handle, uint32_t& dieId, uint32_t& functionId, uint32_t& jettyId) const;

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
     * @brief 创建wqe之前需要先创建jetty
     */
    void CreateCrossBoardJetty();

    /**
     * @brief 清空 JettyPool
     */
    void Clear();

private:
    rtError_t CreateJetty(JettyType type, uint32_t depth, JettyInfo& jettyInfo) const;
    bool FindJettyByState(JettyType type, JettyState state, JettyInfo*& jettyInfo);

    uint32_t deviceId_{0U};
    std::vector<JettyInfo> h2dJettyPool_;
    std::vector<JettyInfo> d2dInBoardJettyPool_;
    std::vector<JettyInfo> d2dCrossBoardJettyPool_;
    std::vector<JettyInfo> directJettyList_;
    std::mutex poolLock_;
    bool ifHasCrossBoardJetty_{false};
};
} // namespace runtime
} // namespace cce

#endif
