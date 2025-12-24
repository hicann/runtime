/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPU_CONTEXT_INC_REGISTAR_H
#define AICPU_CONTEXT_INC_REGISTAR_H

#include <map>
#include <string>

#include "cpu_context.h"
#include "cpu_kernel.h"

namespace aicpu {
class AICPU_VISIBILITY CpuKernelRegister {
 public:
  /*
   * get instance.
   * @return CpuKernelRegister &: CpuKernelRegister instance
   */
  static CpuKernelRegister &Instance();

  /*
   * get cpu kernel.
   * param op_type: the op type of kernel
   * @return shared_ptr<CpuKernel>: cpu kernel ptr
   */
  std::shared_ptr<CpuKernel> GetCpuKernel(const std::string &op_type);

  /*
   * get all cpu kernel registered op types.
   * @return std::vector<string>: all cpu kernel registered op type
   */
  std::vector<std::string> GetAllRegisteredOpTypes() const;

  /*
   * run cpu kernel.
   * param ctx: context of kernel
   * @return uint32_t: 0->success other->failed
   */
  uint32_t RunCpuKernel(CpuKernelContext &ctx);

  /*
   * run async cpu kernel.
   * @param ctx: context of kernel
   * @param wait_type : event wait type
   * @param wait_id : event wait id
   * @param cb : callback function
   * @return uint32_t: 0->success other->failed
   */
  uint32_t RunCpuKernelAsync(CpuKernelContext &ctx,
                             const uint8_t wait_type,
                             const uint32_t wait_id,
                             std::function<uint32_t()> cb);

  // CpuKernel registration function to register different types of kernel to
  // the factory
  class Registerar {
   public:
    Registerar(const std::string &type, const KERNEL_CREATOR_FUN &fun);
    ~Registerar() = default;

    Registerar(const Registerar &) = delete;
    Registerar(Registerar &&) = delete;
    Registerar &operator=(const Registerar &) = delete;
    Registerar &operator=(Registerar &&) = delete;
  };

 protected:
  CpuKernelRegister() = default;
  ~CpuKernelRegister() = default;

  CpuKernelRegister(const CpuKernelRegister &) = delete;
  CpuKernelRegister(CpuKernelRegister &&) = delete;
  CpuKernelRegister &operator=(const CpuKernelRegister &) = delete;
  CpuKernelRegister &operator=(CpuKernelRegister &&) = delete;

  // register creator, this function will call in the constructor
  void Register(const std::string &type, const KERNEL_CREATOR_FUN &fun);

 private:
  std::map<std::string, KERNEL_CREATOR_FUN> creatorMap_;  // kernel map
};
}  // namespace aicpu
#endif  // AICPU_CONTEXT_INC_REGISTAR_H_
