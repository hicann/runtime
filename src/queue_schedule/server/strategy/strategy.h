/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_STRATEGY_H
#define DGW_STRATEGY_H

#include <vector>
#include "fsm/state_define.h"

namespace dgw {
class Strategy {
public:
    explicit Strategy() = default;
    virtual ~Strategy() = default;

public:
    /**
     * search strategy
     * @param groupId group id
     * @param transId transaction id
     * @param selEntities selected entities from group
     * @return FSM_SUCCESS: success, other: failed
     */
    virtual FsmStatus Search(const uint32_t groupId, const uint64_t transId,
                             std::vector<EntityPtr> &selEntities, const uint32_t resIndex) = 0;

private:
    Strategy(const Strategy &) = delete;
    Strategy(const Strategy &&) = delete;
    Strategy &operator = (const Strategy &) = delete;
    Strategy &operator = (Strategy &&) = delete;
};
}

#endif