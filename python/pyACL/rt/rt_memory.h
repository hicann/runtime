/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_RT_MEMORY_FUNCS_H
#define WORD_RT_MEMORY_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtMalloc(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocAlign32(PyObject* self, PyObject* args);
PyObject* WrapAclRtFree(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocHost(PyObject* self, PyObject* args);
PyObject* WrapAclRtFreeHost(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemset(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemsetAsync(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpy(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpyAsync(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocCached(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemFlush(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemInvalidate(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceCanAccessPeer(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceEnablePeerAccess(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceDisablePeerAccess(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetMemInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpy2d(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpy2dAsync(PyObject* self, PyObject* args);
PyObject* WrapAclRtReserveMemAddress(PyObject* self, PyObject* args);
PyObject* WrapAclRtReleaseMemAddress(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocPhysical(PyObject* self, PyObject* args);
PyObject* WrapAclRtFreePhysical(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocWithCfg(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocForTaskScheduler(PyObject* self, PyObject* args);
PyObject* WrapAclRtMallocHostWithCfg(PyObject* self, PyObject* args);
PyObject* WrapAclRtMapMem(PyObject* self, PyObject* args);
PyObject* WrapAclRtUnmapMem(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemExportToShareableHandle(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceGetBareTgid(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemSetPidToShareableHandle(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemImportFromShareableHandle(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemGetAllocationGranularity(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetMemUceInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemUceRepair(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpyAsyncWithCondition(PyObject* self, PyObject* args);
PyObject* WrapAclRtPointerGetAttributes(PyObject* self, PyObject* args);
PyObject* WrapAclRtHostRegister(PyObject* self, PyObject* args);
PyObject* WrapAclRtHostUnregister(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetMemcpyDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetMemcpyDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclRtMemcpyAsyncWithDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtIpcMemGetExportKey(PyObject* self, PyObject* args);
PyObject* WrapAclRtIpcMemSetImportPid(PyObject* self, PyObject* args);
PyObject* WrapAclRtIpcMemImportByKey(PyObject* self, PyObject* args);
PyObject* WrapAclRtIpcMemClose(PyObject* self, PyObject* args);
PyObject* WrapAclRtValueWrite(PyObject* self, PyObject* args);
PyObject* WrapAclRtValueWait(PyObject* self, PyObject* args);
PyObject* WrapAclRtHostRegisterV2(PyObject* self, PyObject* args);
PyObject* WrapAclRtHostGetDevicePointer(PyObject* self, PyObject* args);
#endif // WORD_RT_MEMORY_FUNCS_H