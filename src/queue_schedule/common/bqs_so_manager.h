/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_SO_MANAGER_H
#define QUEUE_SCHEDULE_SO_MANAGER_H

#include <map>
#include <string>
#include <vector>

namespace bqs {
class SoManager {
public:
    SoManager(const std::string &soName) : soName_(soName), soHandle_(nullptr), funcHandleMap_({})
    {
        OpenSo();
    };

    SoManager(const std::string &soName, const std::vector<std::string> &funcNames) : soName_(soName),
                                                                                      soHandle_(nullptr),
                                                                                      funcHandleMap_({})
    {
        OpenSo();
        if (soHandle_ != nullptr) {
            BatchLoadFunc(funcNames);
        }
    };

    ~SoManager()
    {
        CloseSo();
    }

    void *GetFuncHandle(const std::string &funcName);

    bool IsSoLoad() const;

private:
    SoManager(const SoManager &) = delete;
    SoManager &operator=(const SoManager &) = delete;
    SoManager(SoManager &&) = delete;
    SoManager &operator=(SoManager &&) = delete;

    void OpenSo();
    void CloseSo();
    void BatchLoadFunc(const std::vector<std::string> &funcNames);
    void *GetFuncHandleFromSo(const std::string &funcName) const;

    std::string soName_;
    void *soHandle_;
    std::map<std::string, void*> funcHandleMap_;
};
} // namespace bqs

#endif // QUEUE_SCHEDULE_SO_MANAGER_H
