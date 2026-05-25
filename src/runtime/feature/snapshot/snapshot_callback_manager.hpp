 /**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_SNAPSHOT_CALLBACK_MANAGER_HPP
#define RUNTIME_SNAPSHOT_CALLBACK_MANAGER_HPP

#include <mutex>
#include <map>
#include <list>
#include "base.h"
#include "rts_snapshot.h"

namespace cce {
namespace runtime {

struct SnapShotCallBackInfo {
    rtSnapShotCallBack callback;
    void *args;
};

class SnapshotCallbackManager {
public:
    SnapshotCallbackManager() = default;
    ~SnapshotCallbackManager() = default;

    rtError_t RegisterCallback(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args);
    rtError_t UnregisterCallback(rtSnapShotStage stage, rtSnapShotCallBack callback);
    rtError_t InvokeCallbacks(rtSnapShotStage stage);

private:
    static const char_t* GetStageString(rtSnapShotStage stage);

    std::mutex mutex_;
    std::map<rtSnapShotStage, std::list<SnapShotCallBackInfo>> callbackMap_;
};

}
}

#endif