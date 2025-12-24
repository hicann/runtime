/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ASCEND_RUNTIME_ACL_RT_IMPL_BASE_H_
#define ASCEND_RUNTIME_ACL_RT_IMPL_BASE_H_

#include <mutex>
#include <string>
#include "acl/acl_base.h"

struct aclrtUtilizationExtendInfo {
    bool isUtilizationExtend = false;
};
namespace acl {
    aclError UpdatePlatformInfoWithDevice(int32_t deviceId);
    const std::string &GetSocVersion();
    ACL_FUNC_VISIBILITY bool GetAclInitFlag();
    ACL_FUNC_VISIBILITY uint64_t &GetAclInitRefCount();
    ACL_FUNC_VISIBILITY std::recursive_mutex &GetAclInitMutex();
    ACL_FUNC_VISIBILITY std::string &GetConfigPathStr();
    ACL_FUNC_VISIBILITY void SetConfigPathStr(std::string &configStr);
    ACL_FUNC_VISIBILITY aclError GetStrFromConfigPath(const char *configPath, std::string &configStr);
}

#endif // ASCEND_RUNTIME_ACL_RT_IMPL_BASE_H_
