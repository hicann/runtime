/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_PUSH_STATE_H
#define DGW_PUSH_STATE_H

#include "fsm/state_base.h"


namespace dgw {
class PushState : public StateBase {
public:
    explicit PushState() noexcept = default;
    ~PushState() override = default;

    FsmStatus PreProcess(Entity &entity) override;
    // not keep this state, so no need ProcessMessage API
    FsmStatus PostProcess(Entity &entity) override;
private:
    PushState(const PushState &) = delete;
    PushState(const PushState &&) = delete;
    PushState &operator = (const PushState &) = delete;
    PushState &operator = (PushState &&) = delete;
};
}
#endif
