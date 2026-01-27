/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlopen_stub.h"
#include <iostream>

namespace qstest {

DlopenStub &DlopenStub::GetInstance()
{
    static DlopenStub instance;
    return instance;
}

bool DlopenStub::RegDlopenFuncPtr(const std::string &fileName, const FuncNamePtrMap &funcMaps)
{
    const auto iter = ptrManageMap_.find(fileName);
    if (iter != ptrManageMap_.end()) {
        return false;
    }

    for (const auto &iter: funcMaps) {
        std::cout << iter.first << "  " << iter.second << std::endl;
    }

    ptrManageMap_.emplace(fileName, funcMaps);
    return true;
}

void *DlopenStub::dlopen(const char *fileName, int32_t mode)
{
    const auto iter = ptrManageMap_.find(fileName);
    if (iter == ptrManageMap_.end()) {
        return nullptr;
    }

    printf("fileName=%s, ptr=%p\n", fileName, &(iter->second));

    return &(iter->second);
}

void *DlopenStub::dlsym(void *handle, const char *name)
{
    printf("handle=%p, name=%s\n", handle, name);

    bool isFindHandle = false;
    for (const auto &iter : ptrManageMap_) {
        if (handle == &(iter.second)) {
            isFindHandle = true;
            break;
        }
    }

    if (!isFindHandle) {
        return nullptr;
    }

    FuncNamePtrMap *funcNamePtrMap = (reinterpret_cast<FuncNamePtrMap *>(handle));
    const auto iter = funcNamePtrMap->find(name);
    if (iter == funcNamePtrMap->end()) {
        return nullptr;
    }

    printf("dlsym get func ptr is %p\n", iter->second);

    return iter->second;
}

int32_t DlopenStub::dlclose(void *handle)
{
    std::string soName;
    for (const auto &iter : ptrManageMap_) {
        if (handle == &(iter.second)) {
            soName = iter.first;
        }
    }

    if (soName.empty()) {
        return 1;
    }

    ptrManageMap_.erase(soName);

    return 0;
}

void *DlopenQsTestStub(const char *fileName, int32_t mode)
{
    return DlopenStub::GetInstance().dlopen(fileName, mode);
}

int32_t DlcloseQsTestStub(void *handle)
{
    return DlopenStub::GetInstance().dlclose(handle);
}

void *DlsymQsTestStub(void *handle, const char *name)
{
    return DlopenStub::GetInstance().dlsym(handle, name);
}

}  // namespace qstest

int dlclose(void *__handle)
{
    return 0;
}
