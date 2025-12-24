/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_DUMP_H_
#define ACL_DUMP_H_

#include <string>
#include <vector>
#include "acl/acl_base.h"
#include "common/log_inner.h"

namespace acl {
    class AclDump {
    public:
        static aclError HandleDumpConfig(const char_t *const configPath);
        static AclDump &GetInstance();
        void SetAdxInitFromAclInitFlag(const bool flag)
        {
          adxInitFromAclInitFlag_ = flag;
        }
        bool GetAdxInitFromAclInitFlag() const
        {
          return adxInitFromAclInitFlag_;
        }

    private:
        static aclError HandleDumpCommand(const char *configStr, size_t size);
        bool adxInitFromAclInitFlag_ = false;
        ~AclDump() = default;
        AclDump() = default;
    };
}

#endif // ACL_DUMP_H_
