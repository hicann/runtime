/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef QS_TEST_DLOPEN_STUB_H
#define QS_TEST_DLOPEN_STUB_H

#include <map>
#include <string>
#include <dlfcn.h>
#include "mockcpp/mockcpp.hpp"

#define MOCKER_DLFCN()                                                   \
    do {                                                                 \
        MOCKER(dlopen).stubs().will(invoke(qstest::DlopenQsTestStub));   \
        MOCKER(dlsym).stubs().will(invoke(qstest::DlsymQsTestStub));     \
        MOCKER(dlclose).stubs().will(invoke(qstest::DlcloseQsTestStub)); \
    } while(0)

namespace qstest {
using FuncNamePtrMap = std::map<std::string, void *>;

class DlopenStub {
public:
    DlopenStub() : ptrManageMap_({}) {};
    ~DlopenStub() {
        ptrManageMap_.clear();
    };

    static DlopenStub &GetInstance();

    bool RegDlopenFuncPtr(const std::string &fileName, const FuncNamePtrMap &funcMaps);
    void *dlopen(const char *fileName, int32_t mode);
    void *dlsym(void *handle, const char *name);
    int32_t dlclose(void *handle);

private:
    DlopenStub(const DlopenStub &) = delete;
    DlopenStub &operator=(const DlopenStub &) = delete;
    DlopenStub(DlopenStub &&) = delete;
    DlopenStub &operator=(DlopenStub &&) = delete;

    std::map<std::string, FuncNamePtrMap> ptrManageMap_;
};

void *DlopenQsTestStub(const char *fileName, int32_t mode);
int32_t DlcloseQsTestStub(void *handle);
void *DlsymQsTestStub(void *handle, const char *name);
}  // namespace qstest

#endif // QS_TEST_DLOPEN_SUB_H
