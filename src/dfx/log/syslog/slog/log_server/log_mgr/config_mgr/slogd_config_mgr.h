/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_CONFIG_MGR_H
#define SLOGD_CONFIG_MGR_H

#include "log_error_code.h"
#include "log_to_file.h"

#define STORAGE_RULE_COMMON                 1
#define STORAGE_RULE_FILTER_MODULEID        2
#define STORAGE_RULE_FILTER_PID             3


#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void SlogdConfigMgrInit(void);
void SlogdConfigMgrExit(void);

int32_t SlogdConfigMgrGetList(StLogFileList *logList);
uint32_t SlogdConfigMgrGetBufSize(int32_t buffType);
int32_t SlogdConfigMgrGetDeviceAppDirNums(void);

int32_t SlogdConfigMgrGetStorageMode(int32_t buffType);
bool SlogdConfigMgrGetWriteFileLimit(void);
uint32_t SlogdConfigMgrGetTypeSpace(int32_t type);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif