/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_CLIENT_ENTITY_H
#define DGW_CLIENT_ENTITY_H

#include "simple_entity.h"

namespace dgw {
class ClientEntity : public SimpleEntity {
public:
    explicit ClientEntity(const EntityMaterial &material, const uint32_t resIndex);
    virtual ~ClientEntity() = default;
    ClientEntity(const ClientEntity &) = delete;
    ClientEntity(const ClientEntity &&) = delete;
    ClientEntity &operator = (const ClientEntity &) = delete;
    ClientEntity &operator = (ClientEntity &&) = delete;

    FsmStatus DoDequeueMbuf(void **mbufPtr) const override;
    FsmStatus ResetSrcState() override;
    void ResetSrcSubState() override;
    bool IsDataPeeked() const override;
protected:
    FsmStatus DoDequeue() override;
    Mbuf* PrepareMbufToPush(DataObjPtr dataObj) const override;
    FsmStatus DoSendData(Mbuf *const mbuf) override;
    void DoClientDequeue();
    FsmStatus FillMbufWithDeque(const uint64_t deqLen, Mbuf *const mbuf) const;
    FsmStatus DoClientEnqueue(Mbuf *const mbuf);
    FsmStatus DoEnqueueMbuf(Mbuf *const mbuf) const;
    void InvokeDequeThread();
    void InvokeEnqueThread(Mbuf *const mbuf);

    AsyncDataState asyncDataState_;
};
}
#endif