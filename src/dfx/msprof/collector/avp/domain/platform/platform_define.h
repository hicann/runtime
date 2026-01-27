/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_PLARFORM_PLARFORM_DEFINE_H
#define DOMAIN_PLARFORM_PLARFORM_DEFINE_H
#ifdef LITE_OS
#define MAX_READER_BUFFER_SIZE 16384U // 16k for nano channel reader
#define MIN_UPLOAD_BUFFER_SIZE 8192U // 8k
#define MAX_CHANNEL_READ_BUFFER_SIZE 131072 // 128k
#else
#define MAX_READER_BUFFER_SIZE 4194304U // 4m for channel reader
#define MIN_UPLOAD_BUFFER_SIZE 1048576U
#define MAX_CHANNEL_READ_BUFFER_SIZE 33554432 // 32m
#endif
#endif