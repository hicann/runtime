/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PROFILING_H_
#define ACL_PROFILING_H_

#include "acl/acl_base.h"
#include "aprof_pub.h"
#include <string>
#include "common/log_inner.h"

namespace acl {
    class AclProfiling {
    public:
        static aclError HandleProfilingConfig(const char_t *const configPath);

    private:
        static aclError HandleProfilingCommand(const std::string &config, const bool configFileFlag,
            const bool noValidConfig);

        static bool GetProfilingConfigFile(std::string &fileName);
    };


aclError AclProfCtrlHandle(uint32_t dataType, void* data, uint32_t dataLen);

}

#endif // ACL_PROFILING_H_

