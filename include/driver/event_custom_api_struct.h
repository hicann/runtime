/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUFW_CUSTOM_API_STRUCT_H
#define AICPUFW_CUSTOM_API_STRUCT_H

#ifdef __cplusplus
extern "C" {
#endif

struct event_ack {
    unsigned int device_id;
    unsigned int event_id;
    unsigned int subevent_id;
    char* msg;
    unsigned int msg_len;
};

#ifdef __cplusplus
}
#endif
#endif