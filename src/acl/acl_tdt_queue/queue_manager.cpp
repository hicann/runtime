/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue_manager.h"
#include "log_inner.h"
#include "queue.h"
#include "queue_process.h"
#include "queue_process_host.h"
#include "queue_process_sp.h"
#include "queue_process_ccpu.h"

namespace acl {
    QueueManager& QueueManager::GetInstance()
    {
        static QueueManager instance;
        (void)GetRunningEnv(instance.env_);
        return instance;
    }

    aclError QueueManager::GetRunningEnv(RunEnv &runningEnv)
    {
        // get acl run mode
        if (runningEnv != ACL_ACL_ENV_UNKNOWN) {
            return ACL_SUCCESS;
        }
        aclrtRunMode aclRunMode;
        const aclError getRunModeRet = aclrtGetRunMode(&aclRunMode);
        if (getRunModeRet != ACL_SUCCESS) {
            ACL_LOG_CALL_ERROR("[Get][RunMode]get run mode failed, result = %d.", getRunModeRet);
            return getRunModeRet;
        }
        if (aclRunMode == ACL_HOST) {
            runningEnv = ACL_ENV_HOST;
        } else if (aclRunMode == ACL_DEVICE) {
            // get env config
            const char_t *sharePoolPreConfig = nullptr;
            MM_SYS_GET_ENV(MM_ENV_SHAREGROUP_PRECONFIG, sharePoolPreConfig);
            if (sharePoolPreConfig == nullptr) {
                ACL_LOG_INFO("This is not share group preconfig");
                runningEnv = ACL_ENV_DEVICE_CCPU;
            } else {
                ACL_LOG_INFO("This is share group preconfig");
                runningEnv = ACL_ENV_DEVICE_SP;
            }
        } else {
            ACL_LOG_INNER_ERROR("[Get][RunMode]get run mode failed, result = %d.", getRunModeRet);
            return ACL_ERROR_FAILURE;
        }
        return ACL_SUCCESS;
    }

    QueueProcessor *QueueManager::GetQueueProcessor()
    {
        if (queueProcessProc_ != nullptr) {
            return queueProcessProc_.get();
        }
        const std::lock_guard<std::mutex> groupLock(muCreateProcessProc_);
        if (queueProcessProc_ != nullptr) {
            return queueProcessProc_.get();
        }
        try {
            switch (env_) {
                case ACL_ENV_HOST:
                    queueProcessProc_ = std::unique_ptr<QueueProcessorHost>(new (std::nothrow)QueueProcessorHost());
                    break;
                case ACL_ENV_DEVICE_SP:
                    queueProcessProc_ = std::unique_ptr<QueueProcessorSp>(new (std::nothrow)QueueProcessorSp());
                    break;
                case ACL_ENV_DEVICE_CCPU:
                    queueProcessProc_ = std::unique_ptr<QueueProcessorCcpu>(new (std::nothrow)QueueProcessorCcpu());
                    break;
                default:
                    ACL_LOG_INNER_ERROR("[Check][Runenv]check runenv failed.");
                    return nullptr;
            }
        } catch (...) {
            ACL_LOG_INNER_ERROR("[Define][Object]define object queue processor with unique_ptr failed.");
            return nullptr;
        }
        return queueProcessProc_.get();
    }
}
