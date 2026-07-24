/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_RESPONSE_MSG_DISPATCHER_H
#define INNER_INC_RESPONSE_MSG_DISPATCHER_H

#include "inc/process_shared_context.h"
#include "capability_manager.h"
#include "package_manager.h"
#include "proto/tsd_message.pb.h"

namespace tsd {

class ResponseMsgDispatcher {
public:
    ResponseMsgDispatcher(ProcessSharedContext& ctx, PackageManager& pkgMgr, CapabilityManager& capMgr);

    void DeviceMsgProcess(const HDCMessage& msg);
    void PidQosMsgProc(const HDCMessage& msg);
    void StoreProcListStatus(const HDCMessage& msg);
    void SaveDeviceCheckCode(const HDCMessage& msg);

private:
    ProcessSharedContext& sharedCtx_;
    PackageManager& packageMgr_;
    CapabilityManager& capabilityMgr_;
};

} // namespace tsd

#endif // INNER_INC_RESPONSE_MSG_DISPATCHER_H
