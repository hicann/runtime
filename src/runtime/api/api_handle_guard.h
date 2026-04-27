/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef API_HANDLE_GUARD_H
#define API_HANDLE_GUARD_H

#include <vector>

#include "runtime_handle_guard.h"

namespace cce {
namespace runtime {

rtError_t ValidateModelHandleForApi(rtModel_t handle, Model *&outRealObj, const char_t *callerFuncName);
rtError_t ValidateLabelHandleForApi(rtLabel_t handle, Label *&outRealObj, const char_t *callerFuncName);
rtError_t ValidateLabelHandleArrayForApi(rtLabel_t *handles, size_t count, std::vector<Label *> &outRealObjs,
    const char_t *callerFuncName);
rtError_t ValidateStreamHandleForApi(rtStream_t handle, Stream *&outRealObj, const char_t *callerFuncName);
rtError_t ValidateEventHandleForApi(rtEvent_t handle, Event *&outRealObj, const char_t *callerFuncName);
rtError_t ValidateNotifyHandleForApi(rtNotify_t handle, Notify *&outRealObj, const char_t *callerFuncName);
rtError_t ValidateCountNotifyHandleForApi(rtCntNotify_t handle, CountNotify *&outRealObj, const char_t *callerFuncName); 

template <typename HandleT, typename ObjectT>
HandleT ExportEmbeddedHandle(ObjectT *realObj)
{
    if (realObj == nullptr) {
        return nullptr;
    } else {
        return RtPtrToPtr<HandleT>(realObj->GetInnerHandle());
    }
}

template <typename HandleT, typename ObjectT>
void StoreOptionalEmbeddedHandle(ObjectT *realObj, HandleT *handleOut)
{
    if (handleOut != nullptr) {
        *handleOut = ExportEmbeddedHandle<HandleT>(realObj);
    }
}

#define RT_VALIDATE_AND_UNWRAP_OBJECT(_handle, _Type, _outPtr, ...)                                  \
    _Type *_outPtr = nullptr;                                                                         \
    do {                                                                                              \
        const rtError_t _ret = cce::runtime::Validate##_Type##HandleForApi((_handle), (_outPtr), __func__); \
        if (_ret != RT_ERROR_NONE) {                                                                  \
            return _ret;                                                                              \
        }                                                                                             \
    } while (false)

#define RT_VALIDATE_AND_UNWRAP_OBJECT_ARRAY(_handles, _count, _Type, _outVec)                               \
    std::vector<_Type *> _outVec;                                                                            \
    do {                                                                                                     \
        const rtError_t _ret =                                                                               \
            cce::runtime::Validate##_Type##HandleArrayForApi((_handles), (_count), (_outVec), __func__); \
        if (_ret != RT_ERROR_NONE) {                                                                         \
            return _ret;                                                                                     \
        }                                                                                                    \
    } while (false)

} // namespace runtime
} // namespace cce

#endif // API_HANDLE_GUARD_H
