/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_DSMI_H
#define ADX_DSMI_H
#include <cstdint>
#include <vector>
#include "extra_config.h"
namespace Adx {
const int32_t MAX_LOCAL_DEVICE_NUM = 64; // 0~31 device phyid; 32~63  device vfid
bool CheckVfId(uint32_t devId);
int32_t IdeGetDevList(IdeU32Pt devNum, std::vector<uint32_t> &devs, uint32_t len);
int32_t IdeGetPhyDevList(IdeU32Pt devNum, std::vector<uint32_t> &devs, uint32_t len);
int32_t IdeGetLogIdByPhyId(uint32_t desPhyId, IdeU32Pt logId);
int32_t AdxGetLogIdByPhyId(uint32_t desPhyId, IdeU32Pt logId);
}
#endif
