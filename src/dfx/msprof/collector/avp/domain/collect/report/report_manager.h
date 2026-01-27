/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_REPORT_REPORT_MANAGER_H
#define DOMAIN_COLLECT_REPORT_REPORT_MANAGER_H
#include "toolchain/prof_api.h"
#include "osal/osal.h"
// ACL、ACLNN、ASCENDC、GE、TFA、HCCL、AICPU、RUNTIME、PROFTX
#ifdef __cplusplus
extern "C" {
#endif
#define MAX_REPORT_MODULE     20U // max supported report module num
#define PROF_INVALID_MODE_ID 0xFFFFFFFFUL

typedef struct MsprofCommandHandle ProfCommand;
typedef struct {
    enum MsprofReporterModuleId moduleId;
} MsprofReporter;

typedef struct {
    uint8_t reporterNum;
    MsprofReporter *reporters;
} MsprofReporterList;

typedef struct {
    uint32_t regModuleCount;
    enum MsprofCommandHandleType handleType;
    uint32_t moduleId[MAX_REPORT_MODULE];
    ProfCommandHandle handle[MAX_REPORT_MODULE];
    MsprofReporterList hostReporters;                            // reporter for api data
    MsprofReporterList deviceReporters;                          // reporter for aicpu and ctrl cpu data
} ReportAttribute;

typedef struct TypeInfoTagNode {
    uint16_t level;
    uint32_t typeId;
    const CHAR *typeName;
    struct TypeInfoTagNode *next;
} TypeInfoNode;

typedef struct {
    uint64_t size;
    TypeInfoNode *head;
} TypeInfoList;

typedef struct {
    bool infoInit;
    bool infoStop;
    uint64_t typeCursors;
    OsalMutex typeInfoMtx;
    OsalMutex regMtx;
} TypeInfoFlag;

int32_t ReportManagerInitialize(ReportAttribute *reportAttr);
int32_t ReportManagerRegisterModule(ReportAttribute *reportAttr, uint32_t moduleId, ProfCommandHandle handle);
int32_t ReportManagerCollectStart(const uint32_t *deviceList, const size_t deviceNum,
    ReportAttribute *reportAttr, uint64_t dataTypeConfig);
int32_t ReportManagerCollectStop(const uint32_t *deviceList, const size_t deviceNum,
    ReportAttribute *reportAttr, uint64_t dataTypeConfig);
int32_t ReportManagerCollectFinalize(ReportAttribute *reportAttr);
int32_t ReportManagerStartDeviceReporters(ReportAttribute *reportAttr);
int32_t ReportManagerStopDeviceReporters(ReportAttribute *reportAttr);
int32_t ReportManagerFinalize(ReportAttribute *reportAttr);
void HostReportFinalize(void);
int32_t TypeInfoInit(void);
int32_t RegReportTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);
void SaveTypeInfoData(TypeInfoFlag *flag, bool isLastChunk);
const CHAR *GetTypeName(uint16_t level, uint32_t typeId);
void TypeInfoStop(void);
void TypeInfoUninit(void);

#ifdef __cplusplus
}
#endif
#endif
