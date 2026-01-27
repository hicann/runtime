/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DATA_DUMP_COMPONENT_H
#define ADX_DATA_DUMP_COMPONENT_H
#include <map>
#include <vector>
#include "adx_component.h"
#include "adx_comm_opt_manager.h"
#include "adx_msg_proto.h"
namespace Adx {
class AdxDumpReceive : public AdxComponent {
public:
    ~AdxDumpReceive() override {}
    int32_t Init() override;
    const std::string GetInfo() override { return "DataDump"; }
    ComponentType GetType() override { return ComponentType::COMPONENT_DUMP; }
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto) override;
    int32_t UnInit() override;
    int32_t Terminate() override;
private:
    int32_t Receive(const CommHandle &handle, const SharedPtr<MsgProto> &proto);
    void StoreSession(uint32_t deviceId, AdxCommHandle handle);
    void ReleaseSession(uint32_t deviceId, AdxCommHandle handle);
    bool init_;
    std::mutex mutex_;
    std::map<uint32_t, std::vector<AdxCommHandle>> handles_;
};
}
#endif