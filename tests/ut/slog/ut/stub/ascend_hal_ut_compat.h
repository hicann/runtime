/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TESTS_UT_SLOG_UT_STUB_ASCEND_HAL_UT_COMPAT_H_
#define TESTS_UT_SLOG_UT_STUB_ASCEND_HAL_UT_COMPAT_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int log_read(int device_id, char* buf, unsigned int* size, int timeout);
int log_set_level(int device_id, int channel_type, unsigned int log_level);
int log_get_channel_type(int device_id, int* channel_type_set, int* channel_type_num, int set_size);
int32_t log_get_device_id(int32_t* devices, int32_t* devNum, int32_t len);

#ifdef __cplusplus
}
#endif

#endif // TESTS_UT_SLOG_UT_STUB_ASCEND_HAL_UT_COMPAT_H_
