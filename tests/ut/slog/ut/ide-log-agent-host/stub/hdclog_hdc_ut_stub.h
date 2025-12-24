/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __HDCLOG_HDC_UT_STUB_H__
#define __HDCLOG_HDC_UT_STUB_H__

#include <stdio.h>
#include "adcore_api.h"

void IdeDeviceStartupRegister(int(*devStartupNotifier)(uint32_t num, uint32_t *dev));
void IdeDeviceStateNotifierRegister(int(*ideDevStateNotifier)(devdrv_state_info_t *stateInfo));
int32_t IdeSockWriteData(void *sockDesc, const void *buf, int32_t len);
#endif
