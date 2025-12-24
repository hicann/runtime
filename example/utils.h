/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef UTILS_H
#define UTILS_H
#define INFO_LOG(fmt, args...) fprintf(stdout, "[INFO]  " fmt "\n", ##args)
#define WARN_LOG(fmt, args...) fprintf(stdout, "[WARN]  " fmt "\n", ##args)
#define ERROR_LOG(fmt, args...) fprintf(stdout, "[ERROR]  " fmt "\n", ##args)

#define CHECK_ERROR(call) \
    do { \
        aclError __ret = (call); \
        if (__ret != ACL_SUCCESS) { \
            ERROR_LOG("Operation failed: %s returned error code %d", #call, static_cast<int32_t>(__ret)); \
            return -1; \
        } \
    } while (0)
    
#define CHECK_ERROR_WITHOUT_RETURN(call) \
    do { \
        aclError __ret = (call); \
        if (__ret != ACL_SUCCESS) { \
            ERROR_LOG("Operation failed: %s returned error code %d", #call, static_cast<int32_t>(__ret)); \
        } \
    } while (0)

#endif