/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_IDLE_STATE_H
#define DGW_IDLE_STATE_H

#include "fsm/state_base.h"

namespace dgw {
class IdleState : public StateBase {
public:
    explicit IdleState() noexcept = default;
    virtual ~IdleState() override = default;

    FsmStatus PreProcess(Entity &entity) override;
    FsmStatus ProcessMessage(Entity &entity, const InnerMessage &msg) override;
    FsmStatus PostProcess(Entity &entity) override;
    FsmStatus ProcessWaitingData(Entity &entity) const;

private:
    IdleState(const IdleState &) = delete;
    IdleState(const IdleState &&) = delete;
    IdleState &operator = (const IdleState &) = delete;
    IdleState &operator = (IdleState &&) = delete;
};

class GroupIdleState : public IdleState {
public:
    explicit GroupIdleState() noexcept = default;
    ~GroupIdleState() override = default;

    FsmStatus ProcessMessage(Entity &entity, const InnerMessage &msg) override;
};
}
#endif