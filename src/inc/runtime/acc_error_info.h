/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACC_ERROR_INFO_H
#define ACC_ERROR_INFO_H

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum ErrRegInfoIdxV200 {
    RT_V200_SU_ERR_INFO_T0_0 = 0,
    RT_V200_SU_ERR_INFO_T0_1,
    RT_V200_SU_ERR_INFO_T0_2,
    RT_V200_SU_ERR_INFO_T0_3,
    RT_V200_MTE_ERR_INFO_T0_0,
    RT_V200_MTE_ERR_INFO_T0_1,
    RT_V200_MTE_ERR_INFO_T0_2,
    RT_V200_MTE_ERR_INFO_T1_0,
    RT_V200_MTE_ERR_INFO_T1_1,
    RT_V200_MTE_ERR_INFO_T1_2,
    RT_V200_VEC_ERR_INFO_T0_0,
    RT_V200_VEC_ERR_INFO_T0_1,
    RT_V200_VEC_ERR_INFO_T0_2,
    RT_V200_VEC_ERR_INFO_T0_3,
    RT_V200_VEC_ERR_INFO_T0_4,
    RT_V200_VEC_ERR_INFO_T0_5,
    RT_V200_CUBE_ERR_INFO_T0_0,
    RT_V200_CUBE_ERR_INFO_T0_1,
    RT_V200_L1_ERR_INFO_T0_0,
    RT_V200_L1_ERR_INFO_T0_1,
    RT_V200_SC_ERROR_T0_0,
    RT_V200_SU_ERROR_T0_0,
    RT_V200_MTE_ERROR_T0_0,
    RT_V200_MTE_ERROR_T1_0,
    RT_V200_VEC_ERROR_T0_0,
    RT_V200_VEC_ERROR_T0_2,
    RT_V200_CUBE_ERROR_T0_0,
    RT_V200_CUBE_ERROR_T0_1,
    RT_V200_L1_ERROR_T0_0,
    RT_V200_L1_ERROR_T0_1,
} rtErrRegInfoIdxV200_t;

#if defined(__cplusplus)
}
#endif

#endif  // ACC_ERROR_INFO_H
