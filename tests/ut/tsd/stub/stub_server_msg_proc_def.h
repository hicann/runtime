/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_STUB_SERVER_MSG_PROC_DEF_H
#define TSD_STUB_SERVER_MSG_PROC_DEF_H
namespace tsd {
class StubServerMsgProcDef {
public:
    StubServerMsgProcDef() = default;
    
    virtual ~StubServerMsgProcDef() = default;
    
    StubServerMsgProcDef(const StubServerMsgProcDef&) = delete;

    StubServerMsgProcDef(StubServerMsgProcDef&&) = delete;

    StubServerMsgProcDef& operator=(const StubServerMsgProcDef&) = delete;
    
    StubServerMsgProcDef& operator=(StubServerMsgProcDef&) = delete;

    StubServerMsgProcDef& operator=(StubServerMsgProcDef&&) = delete;

    static void RegisterTsdOpenMsgDefaultCallBack();

    static void RegisterUpdateProfilingModeMsgDefaultCallBack();

    static void RegisterTsdInitQsMsgDefaultCallBack();

    static void RegisterGetPidQosMsgDefaultCallBack();

    static void RegisterGetOmInnerDecMsgDefaultCallBack();

    static void RegisterGetCapabilityLevelMsgDefaultCallBack();

    static void RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();

    static void RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();

    static void RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
};
}
#endif