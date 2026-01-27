/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROCMGR_SYS_OPERATOR_AGENT_H
#define PROCMGR_SYS_OPERATOR_AGENT_H
#include <vector>
#include <cstdint>
#include <pthread.h>

namespace AicpuSchedule {
    /**
    * @brief      : bind thread api
    * @param [in] : thread id
    * @param [in] : core affinity
    * @param [out]: void
    * @return     : 0: success, > 0 : failed
    */
    uint32_t ProcMgrBindThread(pid_t threadId, const std::vector<uint32_t>& coreAffinity);
}
#endif