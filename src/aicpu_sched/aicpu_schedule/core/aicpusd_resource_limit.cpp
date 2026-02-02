/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_resource_limit.h"

#include <string>
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_context.h"

namespace AicpuSchedule {
static constexpr const uint32_t SLEEP_100_MSECS = 100000U;
static constexpr const uint32_t MAX_EXECUTE_TRY_TIMES = 3U;
bool AddToCgroup(const uint32_t deviceId, const uint32_t vfId)
{
    DeployContext deployCtx = DeployContext::DEVICE;
    (void)GetAicpuDeployContext(deployCtx);
    if ((FeatureCtrl::IsAosCore()) || (!FeatureCtrl::ShouldAddtocGroup()) || (AicpuUtil::IsFpga())) {
        aicpusd_run_info("No need to add cgroup");
        return true;
    }

    const uint32_t pid = static_cast<uint32_t>(drvDeviceGetBareTgid());
    std::string command = "cd /var/ && sudo ./tsdaemon_add_to_usermemory.sh";
    std::string pathStr = "/var/tsdaemon_add_to_usermemory.sh";
    if (access(pathStr.c_str(), F_OK) != 0) {
        pathStr = "/usr/local/Ascend/driver/tools/add_aicpu_tid_to_tasks.sh";
        if (access(pathStr.c_str(), F_OK) != 0) {
            aicpusd_info("Not find add_aicpu_tid_to_tasks.sh.");
            return true;
        }
        command = "cd /usr/local/Ascend/driver/tools/ && sudo ./tsdaemon_add_to_usermemory.sh";
    }
    command.append(" memory ")
           .append(std::to_string(pid))
           .append(" ")
           .append(std::to_string(deviceId))
           .append(" ")
           .append(std::to_string(vfId));

    int32_t status = -1;
    uint32_t tryTimes = 0;
    while (tryTimes <= MAX_EXECUTE_TRY_TIMES) {
        status = AicpuUtil::ExecuteCmd(command);
        if (status != 0) {
            aicpusd_run_warn("Add to cgroup not success, ret:[%d], cmd:[%s]", status, command.c_str());
            (void)usleep(SLEEP_100_MSECS);
        } else {
            aicpusd_info("Add to cgroup successfully, cmd:[%s].", command.c_str());
            break;
        }
        tryTimes++;
    }
    aicpusd_run_info("Add to cgroup finished, cmd:[%s].", command.c_str());
    return true;
}
}