/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_IAM_PUB_H
#define LOG_IAM_PUB_H

#define IAM_RETRY_TIMES 3
#define IAM_SERVICE_NAME_MAX_LENGTH 32U
#define IAM_CMD_FLUSH_LOG           0x01U
#define IAM_CMD_GET_LEVEL           0x03U
#define IAM_CMD_COLLECT_LOG         0x05U
#define IAM_CMD_COLLECT_LOG_PATTERN 0x07U

#ifndef LOGOUT_IAM_SERVICE_PATH
#define LOGOUT_IAM_SERVICE_PATH "dp:/res/logmgr/logout"
#endif

#ifndef KMS_IAM_SERVICE_PATH
#define KMS_IAM_SERVICE_PATH       "dp:/res/secmgr/kms"
#endif

#endif

