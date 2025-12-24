/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_LIB_H_
#define OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_LIB_H_
#include <map>
#include <string>
#include <vector>
#include "nlohmann/json.hpp"
#include "opdev/internal/kernel_arg.h"
#include "opdev/internal/op_ctx_def.h"
#include "opdev/internal/kernel_utils.h"
#include "mmpa/mmpa_api.h"

namespace op {
namespace internal {
template<typename T>
aclnnStatus GetJsonValue(const nlohmann::json &json, const std::string &key1,
                         const std::string &key2, T &value);

class AttrLibInfo {
public:
    AttrLibInfo() {}
    ~AttrLibInfo() {}
    bool IsRequired() const
    {
        return isRequired_;
    }

private:
    bool isRequired_;
};

class TensorLibInfo {
public:
    TensorType GetTensorType() const
    {
        return tensorType_;
    }

    bool IsInput() const
    {
        return isInput_;
    }

    uint32_t GetIndex() const
    {
        return index_;
    }

private:
    bool isInput_;
    uint32_t index_;
    std::string reshapeType_;
    TensorType tensorType_;
};

class KernelLibInfo {
public:
    KernelLibInfo() = default;
    KernelLibInfo(uint32_t opTypeId, const std::string &opType);
    aclnnStatus Initialize(nlohmann::json &singleKernelJson);
    const std::string &GetOpFile() const;

private:
    uint32_t opTypeId_;
    std::string opType_;
    std::string opFile_;
    std::vector<TensorLibInfo> inputInfos_;
    std::vector<TensorLibInfo> outputInfos_;
    std::vector<AttrLibInfo> attrInfos_;
};

class OpKernelLib {
public:
    static OpKernelLib &GetInstance()
    {
        // Warning: not thread-safe, use muxtex in multitheading environment
        static OpKernelLib instance;
        return instance;
    }

    aclnnStatus Initialize();
    const std::string &GetSocPath();
    const std::string &GetAiCoreImplPath();
    const std::vector<std::string> &GetCustomImplPath();
    const std::vector<std::string> &GetConfigImplPath();
    const KernelLibInfo &GetKernelLibInfo(uint32_t opTypeId) const;
    aclnnStatus ParseKernelLibInfos(uint32_t opType);

private:
    OpKernelLib();

    ~OpKernelLib();

    bool initFlag_ = false;
    std::string aiCoreImplPath_;
    std::vector<std::string> customImplPath_;
    std::vector<std::string> configImplPath_;
    std::string socPath_;
    nlohmann::json allKernelsJson_;
    std::array<KernelLibInfo, MAX_OP_TYPE_COUNT> kernelLibInfos_; // op_type_id to KernelLib
};
} // namespace internal
} // namespace op

#endif // OP_API_COMMON_INC_OPDEV_INTERNAL_OP_KERNEL_STORE_H_
