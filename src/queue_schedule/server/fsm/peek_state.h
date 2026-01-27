/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_PEEK_STATE_H
#define DGW_PEEK_STATE_H

#include "fsm/state_base.h"

namespace dgw {
class PeekState : public StateBase {
public:
    explicit PeekState() noexcept = default;
    ~PeekState() override = default;

public:
    FsmStatus PreProcess(Entity &entity) override;
    FsmStatus ProcessMessage(Entity &entity, const InnerMessage &msg) override;
    FsmStatus PostProcess(Entity &entity) override;

protected:
    FsmStatus DeQueue(Entity &entity) const;

private:
    PeekState(const PeekState &) = delete;
    PeekState(const PeekState &&) = delete;
    PeekState &operator = (const PeekState &) = delete;
    PeekState &operator = (PeekState &&) = delete;
};

class GroupPeekState : public PeekState {
public:
    explicit GroupPeekState() noexcept = default;
    ~GroupPeekState() override = default;

    FsmStatus PostProcess(Entity &entity) override;
};
}
#endif
