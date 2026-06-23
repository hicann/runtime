/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_COND_HANDLE_HPP__
#define __CCE_RUNTIME_COND_HANDLE_HPP__

#include "base.hpp"
#include "runtime_handle_guard.h"
#include "rt_inner_model.h"

namespace cce {
namespace runtime {
class Model;
class Context;

class CondHandle : public NoCopy {
public:
    explicit CondHandle(Model *mdl, uint32_t defaultValue, rtCondHandleFlag_t flag);
    ~CondHandle() noexcept override;

    rtError_t Setup(Context *ctx);
    rtError_t Destroy();
    rtError_t InitCondTaskByDefValue();
    void SubModelDestroy();

    uint32_t GetDefaultValue() const { return defaultValue_; }
    rtCondHandleFlag_t GetFlag() const { return flag_; }
    Model *GetParentModel() const { return model_; }
    uint64_t *GetDevAddr() const { return devAddr_; }

    rtInnerObject *GetInnerHandle()
    {
        return &handle_;
    }

    std::vector<Model *> &GetSubCaptureModels()
    {
        return subCaptureModels_;
    }

    void EraseSubModel(Model * subModel)
    {
 	    auto it = std::find(subCaptureModels_.begin(), subCaptureModels_.end(), subModel);
 	    if (it != subCaptureModels_.end()) {
 	        subCaptureModels_.erase(it);
 	    }
 	}

    void PushBackSubModel(Model * const subModel)
    {
        subCaptureModels_.push_back(subModel);
    }

    void SetSubModelNotify(Notify *notify)
    {
        subModelNotify_ = notify;
    }

    Notify *GetSubModelNotify() const
    {
        return subModelNotify_;
    }

    void SetCondType(rtCondTaskType_t type)
    {
        condType_ = type;
    }

    rtCondTaskType_t GetCondType() const
    {
        return condType_;
    }

    void SetCondSize(uint32_t condSize)
    {
        condSize_ = condSize;
    }

    uint32_t GetCondSize() const
    {
        return condSize_;
    }

private:
    Model *model_{nullptr}; // 归属的父模型
    uint32_t defaultValue_{0U}; // 父模型执行时的默认条件值
    rtCondHandleFlag_t flag_; // RT_COND_HANDLE_ASSIGN_DEFAULT表示模型执行时，条件值初始化为defaultValue_
    rtCondTaskType_t condType_{RT_COND_TASK_TYPE_MAX}; // condition type
    uint32_t condSize_{0U}; // 子模型个数
    uint64_t *devAddr_{nullptr}; // device ptr，用于存储条件值
    Context *context_{nullptr};
    rtInnerObject handle_{};
    std::vector<Model *> subCaptureModels_; // 当前condHandle的model列表
    Notify *subModelNotify_{nullptr}; // 所有submodel共用同一个notify，避免重复申请
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_COND_HANDLE_HPP__