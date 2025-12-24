/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_INFOS_UTILS_H__
#define __PLATFORM_INFOS_UTILS_H__

#include <mutex>
#include "platform/platform_infos_def.h"

namespace fe {
extern std::mutex plt_mutex;

class PlatformInfosUtils {
  public:
    PlatformInfosUtils(const PlatformInfosUtils &) = delete;
    PlatformInfosUtils &operator=(const PlatformInfosUtils &) = delete;

    static PlatformInfosUtils &GetInstance();
    void Clone(PlatFormInfos &dest_platform_infos, const PlatFormInfos &platform_infos) const;

    static void Trim(std::string &str);
    static void Split(const std::string &str, char pattern, std::vector<std::string> &res_vec);

  private:
    PlatformInfosUtils();
    ~PlatformInfosUtils();
};
}  // namespace fe

#endif // __PLATFORM_INFOS_UTILS_H__
