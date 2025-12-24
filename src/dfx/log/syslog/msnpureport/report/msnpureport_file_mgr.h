/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSNPUREPORT_FILE_MGR_H
#define MSNPUREPORT_FILE_MGR_H

#include "msnpureport_common.h"
#include "log_file_info.h"
#include "log_communication.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t MsnFileMgrInit(const FileAgeingParam *param, const char *rootPath);
int32_t MsnFileMgrWriteDeviceSlog(const void *msg, uint32_t len, uint32_t masterId);
int32_t MsnFileMgrSaveFile(char *filename, uint32_t len, uint32_t masterId);
void MsnFileMgrExit(void);

#ifdef __cplusplus
}
#endif
#endif
