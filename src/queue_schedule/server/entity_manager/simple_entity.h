/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_SIMPLE_ENTITY_H
#define DGW_SIMPLE_ENTITY_H

#include "entity.h"
#include "subscribe_manager.h"

namespace dgw {

class SimpleEntity : public Entity {
public:
    explicit SimpleEntity(const EntityMaterial &material, const uint32_t resIndex);
    virtual ~SimpleEntity() = default;
    SimpleEntity(const SimpleEntity &) = delete;
    SimpleEntity(const SimpleEntity &&) = delete;
    SimpleEntity &operator = (const SimpleEntity &) = delete;
    SimpleEntity &operator = (SimpleEntity &&) = delete;
    virtual FsmStatus DoDequeueMbuf(void **mbufPtr) const;

    FsmStatus Dequeue() override;
    FsmStatus ResetSrcState() override;
    void SelectDstEntities(const uint64_t key, std::vector<Entity*> &toPushDstEntities,
        std::vector<Entity*> &reprocessDstEntities, std::vector<Entity*> &abnormalDstEntities) override;
    FsmStatus SendData(const DataObjPtr dataObj) override;
    FsmStatus PauseSubscribe(const Entity &fullEntity) override;
    FsmStatus ResumeSubscribe(const Entity &notFullEntity) override;
    FsmStatus ClearQueue() override;
    bool IsDataPeeked() const override;
    FsmStatus Uninit() override;
protected:
    virtual FsmStatus DoDequeue();
    virtual void PostDeque();
    virtual FsmStatus RefreshWithData();
    virtual Mbuf* PrepareMbufToPush(DataObjPtr dataObj) const;
    virtual FsmStatus DoSendData(Mbuf *const mbuf);
    Mbuf* SdmaCopy(Mbuf * const mbuf) const;
    bqs::SubscribeManager *GetSubscriber() const;
    Mbuf* AllocateMbuf(const uint64_t desBufLen) const;
    FsmStatus SdmaCopyData(void *const srcDataBuf, const uint64_t desBufLen, Mbuf *const mbufPtr) const;
    FsmStatus SdmaCopyHead(void *const srcHeadBuf, const uint32_t srcHeadBufSize, Mbuf *const mbufPtr) const;
};
}
#endif