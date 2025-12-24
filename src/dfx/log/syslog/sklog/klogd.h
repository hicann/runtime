/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SKLOGD_H
#define SKLOGD_H

// syslog levels highest to lowest priority
#define SKLOG_EMERG 0 // system is unusable
#define SKLOG_ALERT 1 // action must be taken immediately
#define SKLOG_CRIT 2 // critical conditions
#define SKLOG_ERROR 3 // error conditions
#define SKLOG_WARNING 4 // warning conditions
#define SKLOG_NOTICE 5 // normal but significant condition
#define SKLOG_INFO 6 // informational
#define SKLOG_DEBUG 7 // debug-level messages
#define SKLOG_PRIMASK 0x07  // mask to extract priority part (internal)
#define UNIT_US_TO_S 1000000

#endif