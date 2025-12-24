/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_LABEL_HPP__
#define __CCE_RUNTIME_LABEL_HPP__

#include <mutex>
#include <list>
#include "model.hpp"
#include "runtime/rt.h"
#include "base.hpp"

namespace cce {
namespace runtime {
class Stream;
class Context;

struct rtLabelDevInfoOld {
    uint16_t modelId;
    uint16_t streamId;
    uint16_t labelId;
};

class LabelAllocator : public NoCopy {
public:
    enum LabelAllocationStatus {
        LABEL_FREE = 0,
        LABEL_ALLOCATED = 1,
    };
    explicit LabelAllocator(const uint16_t labelMax);
    ~LabelAllocator() override = default;
    // Singleton instance.
    rtError_t LabelIdAlloc(uint16_t &idAlloc);
    rtError_t LabelIdFree(const uint16_t idFree);

private:
    uint16_t labelIds_[MAX_UINT16_NUM] = {0};
    std::list<uint16_t> freeLabelIdsList;
    std::mutex mutex_;
    uint16_t labelMaxNum_;
    uint16_t curInitLabelNum_;
};

class Label : public NoCopy {
public:
    enum rtLabelMgrType_t {
        LABEL_MGR_TYPE_RT    = 0,
        LABEL_MGR_TYPE_MODEL,
        LABEL_MGR_TYPE_END,
    };

    explicit Label(Model * const mdl);
    ~Label() noexcept override;

    rtError_t LabelIdAlloc(uint16_t &idAlloc);
    rtError_t LabelIdFree(const uint16_t idFree);

    rtError_t Setup(Context * const curCtx);

    uint16_t Id_() const
    {
        return labelId_;
    }

    const Context *Context_() const
    {
        return context_;
    }

    const Stream *Stream_() const
    {
        return stream_;
    }

    void ForceSetStream(Stream * const stm)
    {
        stream_ = stm;
    }

    rtLabelMgrType_t MgrType_() const
    {
        return mgrType_;
    }

    const Model *Model_() const
    {
        return model_;
    }

    void SetSetFlag(const bool flag)
    {
        setFlag_ = flag;
    }
    bool SetFlag_() const
    {
        return setFlag_;
    }

    void *DevDstAddr_() const
    {
        return devDstAddr_;
    }

    void ResetLabelDevAddr()
    {
        devDstAddr_ = nullptr;
    }

    rtError_t Set(Stream * const stm);
    rtError_t SetStream(Stream * const stm);
    rtError_t Switch(const void * const ptr, const rtCondition_t condition, const uint32_t val, Stream * const stm);
    rtError_t Goto(Stream * const stm);
    rtError_t StreamGoto(Stream * const stm);
    void UnbindModel()
    {
        model_ = nullptr;
    }
    rtError_t SetLabelDevAddr(void * const addr);
private:
    Model *model_;
    uint16_t labelId_;
    Stream *stream_;
    Context *context_;
    bool setFlag_;
    rtLabelMgrType_t mgrType_;
    void *devDstAddr_;   // save label info device addr
};
}
}

#endif  // __CCE_RUNTIME_LABEL_HPP__
