/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HCCL_SO_MANAGER_H
#define HCCL_SO_MANAGER_H

#include <unordered_map>
#include <mutex>
#include <vector>
#include "hccl/hccl_ex.h"
#include "common/bqs_log.h"

namespace dgw {
using HcclInitCommFunc = HcclResult (*)(const char_t *, uint32_t, const CommAttr *, HcclComm *);
using HcclFinalizeCommFunc = HcclResult (*)(HcclComm);

// MPI API
using HcclIsendFunc = int32_t(*)(void *, int32_t, HcclDataType, int32_t, int32_t, HcclComm, HcclRequest *);
using HcclImrecvFunc = int32_t(*)(void *, int32_t, HcclDataType, HcclMessage *, HcclRequest *);
using HcclImprobeFunc = int32_t(*)(int32_t, int32_t, HcclComm, int32_t *, HcclMessage *, HcclStatus *);
using HcclGetCountFunc = int32_t(*)(const HcclStatus *, HcclDataType, int32_t *);
using HcclTestSomeFunc = int32_t(*)(int32_t, HcclRequest[], int32_t *, int32_t[], HcclStatus[]);

using HcclRegisterMemoryFunc = HcclResult (*)(HcclComm, void*, uint64_t);
using HcclUnregisterMemoryFunc = HcclResult (*)(HcclComm, void*);
using HcclSetGrpIdCallback = HcclResult (*)(int32_t(*)(int32_t, int32_t*, int32_t*));


class HcclSoManager {
public:
    static HcclSoManager *GetInstance();

    virtual ~HcclSoManager();

    /**
     * load hccl so
     */
    void LoadSo();

    /**
     * unload hccl so
     */
    void UnloadSo();

    /**
     * get function
     * @param name hccl function name
     * @return void *
     */
    void *GetFunc(const std::string &name) const;

private:
    HcclSoManager() = default;

    std::unordered_map<std::string, void *> funcMap_;
    void *soHandle_ = nullptr;
};
}
#endif // HCCL_SO_MANAGER_H
