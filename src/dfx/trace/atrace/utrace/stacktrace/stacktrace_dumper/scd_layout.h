/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_LAYOUT_H
#define SCD_LAYOUT_H

#include <stddef.h>
#include "atrace_types.h"
#include "scd_process.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_SECTION_PROCESS                     "[process]"
#define SCD_SECTION_STACK                       "[stack]"
#define SCD_SECTION_MAPS                        "[maps]"
#define SCD_SECTION_MEMORY                      "[system memory]"
#define SCD_SECTION_STATUS                      "[process status]"
#define SCD_SECTION_LIMITS                      "[process limits]"

#define SCD_THDS_NUM(pro)     ((ScdProcess *)(pro)->thds.thdArray.num)
#define SCD_THDS_SIZE(pro)    ((ScdProcess *)(pro)->thds.thdArray.entSize)
#define SCD_THDS_ADDR(pro, n) ((ScdProcess *)(pro) + (ScdProcess *)(pro)->thds.thdArray.offset + (ScdProcess *)(pro)->thds.thdArray.entSize * (n))

#define SCD_MAPS_NUM(pro)     ((ScdProcess *)(pro)->maps.mapArray.num)
#define SCD_MAPS_SIZE(pro)    ((ScdProcess *)(pro)->maps.mapArray.entSize)
#define SCD_MAPS_ADDR(pro, n) ((ScdProcess *)(pro) + (ScdProcess *)(pro)->maps.mapArray.offset + (ScdProcess *)(pro)->maps.mapArray.entSize * (n))

#define SCD_THDS_LIST_NUM(pro) ((ScdProcess *)(pro)->thds.thdList.cnt)
#define SCD_THDS_LIST_ADDR(pro) (&(ScdProcess *)(pro)->thds.thdList)
#define SCD_MAPS_LIST_NUM(pro) ((ScdProcess *)(pro)->maps.mapList.cnt)
#define SCD_MAPS_LIST_ADDR(pro) (&(ScdProcess *)(pro)->maps.mapList)

#define SCD_SHDR_INVALID_FD                     (0xFFFFFFFFU)

TraStatus ScdLayoutWrite(int32_t fd, ScdProcess *pro);
TraStatus ScdLayoutRead(ScdProcess **pro, const char *filePath);
TraStatus ScdSectionRecord(int32_t fd, const ScdProcess *pro, const char *name);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif