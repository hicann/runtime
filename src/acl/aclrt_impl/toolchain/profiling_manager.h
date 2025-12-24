/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PROFILING_MANAGER_H_
#define ACL_PROFILING_MANAGER_H_

#include <mutex>
#include <unordered_set>
#include <map>
#include "common/log_inner.h"

namespace acl {
    class AclProfilingManager final {
    public:
        static AclProfilingManager &GetInstance();
        // init acl prof module
        aclError Init();
        // uninit acl prof module
        aclError UnInit();
        // acl profiling module is running or not
        bool AclProfilingIsRun() const
        {
            return isProfiling_;
        }

        // return flag of device list that needs report prof data is empty or not
        bool IsDeviceListEmpty() const;
        aclError AddDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums);
        aclError RemoveDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums);
        aclError RegisterProfilingType() const;

    private:
        ~AclProfilingManager() = default;
        AclProfilingManager() = default;
        bool isProfiling_ = false;
        std::mutex mutex_;
        std::unordered_set<uint32_t> deviceList_;
    };

} // namespace acl/ ACL_PROFILING_MANAGER_H_
#endif // ACL_PROFILING_MANAGER_H_