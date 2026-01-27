/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_KERNELS_STUB_PLATFORM_INFOS_DEF_H
#define AICPU_KERNELS_STUB_PLATFORM_INFOS_DEF_H
#include <memory>
#include <iostream>

namespace fe {
class PlatFormInfos {
public:
  PlatFormInfos() {
    std::cout << "this is fake stub PlatFormInfos" <<std::endl;;
  }
  ~PlatFormInfos() {}
  bool LoadFromBuffer(const char *input_data, uint64_t data_len) {
    if (data_len >= 10UL) {
      std::cout << "this is fake stub PlatFormInfos return false" << std::endl;
      return false;
    } else {
      std::cout << "this is fake stub PlatFormInfos return true" << std::endl;
      return true;
    }
  }

  bool Init() {
    return true;
  }
};
}

#endif