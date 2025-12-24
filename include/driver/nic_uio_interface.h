/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __NIC_UIO_INTERFACE_H__
#define __NIC_UIO_INTERFACE_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

// Export Interfaces
int uio_open_device(const char *uio_device_name);
int uio_close_device(const char *uio_device_name);

#ifdef __cplusplus
}
#endif

#endif // __NIC_UIO_INTERFACE_H__
