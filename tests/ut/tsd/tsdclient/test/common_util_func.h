/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_UT_COMMON_UTIL_FUNC_H
#define TSD_UT_COMMON_UTIL_FUNC_H
#include <string>
namespace tsd {
class CommonUtilFunc {
public:
    CommonUtilFunc() = default;
    
    virtual ~CommonUtilFunc() = default;
    
    CommonUtilFunc(const CommonUtilFunc&) = delete;

    CommonUtilFunc(CommonUtilFunc&&) = delete;

    CommonUtilFunc& operator=(const CommonUtilFunc&) = delete;
    
    CommonUtilFunc& operator=(CommonUtilFunc&) = delete;

    CommonUtilFunc& operator=(CommonUtilFunc&&) = delete;

    static bool WriteTmpFile(const std::string &filePath, const std::string &fileName);
};
}
#endif