/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_AICPU_ERR_MSG_HPP__
#define __CCE_RUNTIME_AICPU_ERR_MSG_HPP__

#include "base.hpp"
#include "kernel.h"
#include "device.hpp"
#include "task.hpp"
#include "aicpu/common/aicpu_task_struct.h"

namespace cce {
namespace runtime {

class Stream;
class Device;

class AicpuErrMsg : public NoCopy {
public:
    explicit AicpuErrMsg(Device * const dev);
    ~AicpuErrMsg() noexcept override;
    void SetErrMsgBufAddr(void);

private:
    void *errMsgBuf_{nullptr};
    std::mutex errMsgBufMutex_;
    Device *device_;

    void ErrMsgBufLock(void);
    void ErrMsgBufUnLock(void);
    rtError_t AllocResource(void);
    void FreeResource(void) noexcept;
    rtError_t SendConfigMsgToAicpu(const aicpu::AicpuConfigMsg * const configMsg) const;
    rtError_t SendTaskToAicpu(const rtKernelLaunchNames_t &launchNames, const uint32_t coreDim,
                              const void * const args, const uint32_t argsSize, const uint32_t flag) const;
    rtError_t FillKernelLaunchPara(const rtKernelLaunchNames_t &launchNames,
                                   TaskInfo * const kernTask) const;
};
}
}

#endif  // __CCE_RUNTIME_AICPU_ERR_MSG_HPP__
