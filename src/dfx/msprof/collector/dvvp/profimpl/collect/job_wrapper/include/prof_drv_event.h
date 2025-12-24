/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_EVENT_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_EVENT_H
#include "collection_register.h"
#include "ai_drv_prof_api.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {

struct TaskEventAttr {
    uint32_t deviceId;
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId;
    enum ProfCollectionJobE jobTag;
    bool isChannelValid;
    bool isProcessRun;
    bool isExit;
    bool isThreadStart;
    OsalThread handle;
    bool isAttachDevice;
    bool isWaitDevPid;
    const char *grpName;
};

class ProfDrvEvent {
public:
    ProfDrvEvent();
    ~ProfDrvEvent();
    int32_t SubscribeEventThreadInit(struct TaskEventAttr *eventAttr) const;
    void SubscribeEventThreadUninit(uint32_t devId) const;
private:
    static void *EventThreadHandle(void *attr);
    static int32_t QueryDevPid(const struct TaskEventAttr *eventAttr);
    static int32_t QueryGroupId(uint32_t devId, uint32_t &grpId, const char *grpName);
    static void WaitEvent(struct TaskEventAttr *eventAttr, uint32_t grpId);
};

}
}
}
#endif