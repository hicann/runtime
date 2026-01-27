/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "data_obj_manager.h"
#include "fsm/state_base.h"
#include "entity_manager.h"

namespace dgw {
DataObj::DataObj(Entity * const sendEntityPtr, const Mbuf * const mbufPtr)
    : sendEntity_(sendEntityPtr),
      mbuf_(mbufPtr)
{
}

void DataObj::AddRecvEntity(Entity *const recvEntityPtr)
{
    recvEntities_.emplace_back(recvEntityPtr);
}

DataObjManager &DataObjManager::Instance()
{
    static DataObjManager ins;
    return ins;
}

bool DataObj::RemoveRecvEntity(const Entity * const recvEntityPtr)
{
    for (auto iter = recvEntities_.begin(); iter != recvEntities_.end(); iter++) {
        if ((*iter)->Equal(recvEntityPtr)) {
            (void) recvEntities_.erase(iter);
            return true;
        }
    }
    return false;
}

bool DataObj::UpdateRecvEntities(const EntityPtr group, const EntityPtr elem)
{
    if (RemoveRecvEntity(group.get())) {
        AddRecvEntity(elem.get());
        return true;
    }
    return false;
}

DataObjPtr DataObjManager::CreateDataObj(Entity * const sendEntityPtr, const Mbuf * const mbufPtr) const
{
    try {
        return std::make_shared<DataObj>(sendEntityPtr, mbufPtr);
    } catch (std::bad_alloc &error) {
        (void) error;
        return nullptr;
    }
    return nullptr;
}
}  // namespace dgw
