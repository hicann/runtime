/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_DATA_OBJ_MANAGER_H
#define DGW_DATA_OBJ_MANAGER_H

#include <unistd.h>
#include <list>
#include <memory>
#include <vector>

#include "fsm/state_define.h"
#include "driver/ascend_hal.h"

namespace dgw {
using EntityWeakPtr = std::weak_ptr<Entity>;

class DataObj {
public:
    explicit DataObj(Entity * const sendEntityPtr, const Mbuf * const mbufPtr);

    ~DataObj() = default;

    DataObj(const DataObj &) = delete;
    DataObj(const DataObj &&) = delete;
    DataObj &operator = (const DataObj &) = delete;
    DataObj &operator = (DataObj &&) = delete;

    inline const bool CopRef() const
    {
        return copyRef_;
    }

    inline const Mbuf *GetMbuf() const
    {
        return mbuf_;
    }

    inline Entity *GetSendEntity() const
    {
        return sendEntity_;
    }

    void AddRecvEntity(Entity *const recvEntityPtr);

    inline size_t GetRecvEntitySize()
    {
        return recvEntities_.size();
    }

    inline std::vector<Entity*>& GetRecvEntities()
    {
        return recvEntities_;
    }

    bool RemoveRecvEntity(const Entity * const recvEntityPtr);

    bool UpdateRecvEntities(const EntityPtr group, const EntityPtr elem);

    inline void MaintainMbuf()
    {
        maintainMbuf_ = true;
    }

    inline bool ShouldMaintainMbuf() const
    {
        return maintainMbuf_;
    }

private:
    Entity *sendEntity_;
    std::vector<Entity*> recvEntities_;
    const bool copyRef_ = false;
    const Mbuf *mbuf_ = nullptr;
    bool maintainMbuf_ = false;
};

using DataObjPtr = std::shared_ptr<DataObj>;
using DataObjList = std::list<DataObjPtr>;

class DataObjManager {
public:
    explicit DataObjManager() = default;

    ~DataObjManager() = default;

    DataObjManager(const DataObjManager &) = delete;
    DataObjManager(const DataObjManager &&) = delete;
    DataObjManager &operator = (const DataObjManager &) = delete;
    DataObjManager &operator = (DataObjManager &&) = delete;

    static DataObjManager &Instance();
    DataObjPtr CreateDataObj(Entity * const sendEntityPtr, const Mbuf * const mbufPtr) const;
};
}

#endif
