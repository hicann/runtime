/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_DETECT_H
#define CPU_DETECT_H
#include "cpu_detect_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/*
 * @brief       start cpu detect
 * @param [in]  timeout:   timeout to exit
 * @return      CpudStatus
 */
CPUD_EXPORT CpudStatus CpuDetectStart(uint32_t timeout);

/*
 * @brief       stop cpu detect
 * @return      NA
 */
CPUD_EXPORT void CpuDetectStop(void);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif