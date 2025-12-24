/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_infos_def.h"

using std::map;
using std::string;
using namespace std;

namespace fe {

bool PlatFormInfos::GetPlatformRes(const std::string &label, const std::string &key, std::string &val)
{
    return true;
}

uint32_t PlatFormInfos::GetCoreNum() const
{
    return 0;
}

bool PlatFormInfos::GetPlatformResWithLock(const std::string &label, const std::string &key, std::string &val)
{
    return true;
}

bool PlatFormInfos::GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res)
{
    return true;
}

void PlatFormInfos::SetCoreNumByCoreType(const std::string &core_type) {}

uint32_t PlatFormInfos::GetCoreNumByType(const std::string &core_type)
{
    return 0;
}

void PlatFormInfos::SetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {}

std::string PlatFormInfos::SaveToBuffer()
{
    return "";
}
}  // namespace fe
