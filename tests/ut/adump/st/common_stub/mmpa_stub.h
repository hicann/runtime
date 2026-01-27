/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_MMPA_STUB_H
#define __IDE_MMPA_STUB_H

extern int g_mmSemwait_time;
extern int g_ide_create_task_time;
extern int g_mmCreateTaskWitchDeatchFlag;
extern int g_mmCreateTaskFlag;
extern int g_mmCreateTaskWithDetachTime;
extern int g_mmCreateTaskWithDetachThreahHold;
extern int g_ide_create_task_time_threadhold;

#ifdef __cplusplus
extern "C" {
#endif

extern INT32 mmMutexDestroy(mmMutex_t* mutex);
extern INT32 mmSemWait_stub(mmSem_t *sem);
extern INT32 mmCreateTaskWithDetach_stub(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock);
extern INT32 mmCreateTask_stub(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock);
extern INT32 mmCreateTask_stub1( mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock);
extern INT32 mmSetThreadName(mmThread *threadHandle, const CHAR* name);
extern INT32 mmCreateTaskWithThreadAttr_stub(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr);
extern INT32 mmCreateTaskWithThreadAttr_stub2(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr);
extern INT32 mmCreateTaskWithThreadAttr_stub3(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr);
extern INT32 mmCreateTaskWithThreadAttr_stub4(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr);
extern CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size);
#ifdef __cplusplus
}
#endif

#endif//__IDE_MMPA_STUB_H
