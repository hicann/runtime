/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BBOX_SHARED_H
#define BBOX_SHARED_H

typedef devdrv_state_info_t DrvDevStatT;

/**
 * @brief register device startup notify callback function to driver
 * @param [in]  devStartupNotifier:    callback function
 * @return NA
 */
void BboxDevStartupRegister(int (*devStartupNotifier)(unsigned int num, unsigned int *devId));

/**
 * @brief register device state change notify callback function to driver
 * @param [in]  devStateNotifier:    callback function
 * @return NA
 */
void BboxDevStateNotifierRegister(int (*devStateNotifier)(DrvDevStatT *stat));

#endif