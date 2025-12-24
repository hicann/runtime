/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPU_CONTEXT_INC_UTILS_H
#define AICPU_CONTEXT_INC_UTILS_H
#include <functional>
#include <memory>

#include "cpu_attr_value.h"
#include "cpu_context.h"
#include "cpu_node_def.h"
#include "cpu_tensor.h"

namespace aicpu {
class AICPU_VISIBILITY CpuKernelUtils {
 public:
  /*
   * create Tensor.
   * @return std::shared_ptr<Tensor>: Tensor ptr
   */
  static std::shared_ptr<Tensor> CreateTensor();

  /*
   * create Tensor.
   * @param tensor: Tensor impl
   * @return std::shared_ptr<Tensor>: Tensor ptr
   */
  static std::shared_ptr<Tensor> CreateTensor(TensorImpl *tensor);

  /*
   * get tensor impl.
   */
  static std::shared_ptr<TensorImpl> GetImpl(const Tensor *tensor);

  /*
   * get tensor name.
   */
  static std::string GetTensorName(const Tensor *tensor);

  /*
   * set tensor name.
   */
  static void SetTensorName(const std::string &name, std::shared_ptr<Tensor> &tensor);

  /*
   * create Tensor shape.
   * @return std::shared_ptr<TensorShape>: TensorShape ptr
   */
  static std::shared_ptr<TensorShape> CreateTensorShape();

  /*
   * create Tensor Shape.
   * @param tensorShape: Tensor shape impl
   * @return std::shared_ptr<TensorShape>: TensorShape ptr
   */
  static std::shared_ptr<TensorShape> CreateTensorShape(
      TensorShapeImpl *tensor_shape);

  /*
   * get tensor shape impl.
   */
  static std::shared_ptr<TensorShapeImpl> GetImpl(
      const TensorShape *tensor_shape);

  /*
   * create attr value.
   * @return std::shared_ptr<AttrValue>: attr value ptr
   */
  static std::shared_ptr<AttrValue> CreateAttrValue();

  /*
   * create attr value.
   * @param attr_value: attr value impl
   * @return std::shared_ptr<AttrValue>: attr value ptr
   */
  static std::shared_ptr<AttrValue> CreateAttrValue(AttrValueImpl *impl);

  /*
   * get attr value impl.
   */
  static std::shared_ptr<AttrValueImpl> GetImpl(const AttrValue *attr_value);

  /*
   * create node def.
   * @return std::shared_ptr<NodeDef>: node def ptr
   */
  static std::shared_ptr<NodeDef> CreateNodeDef();

  /*
   * ParallelFor shards the "total" units of work.
   * @param ctx: context info of kernel
   * @param total: size of total work
   * @param per_unit_size: expect size of per unit work
   * @param work: process of per unit work
   * @return uint32_t: 0->sucess other->failed
   */
  static uint32_t ParallelFor(
      const CpuKernelContext &ctx, int64_t total, int64_t per_unit_size,
      const std::function<void(int64_t, int64_t)> &work);

  /*
   * Get CPU number
   * @param ctx: context info of kernel
   * @return CPU number
   */
  static uint32_t GetCPUNum(const CpuKernelContext &ctx);

  /*
   * UpdateCustWorkSpaceInfo
   * @param ctx: context info of kernel
   * @param workspace_size: size of  workspace
   * @param workspace_addr: addr of workspce
   */
  static void UpdateCustWorkSpaceInfo(CpuKernelContext *ctx, uint64_t workspace_size,
                                      uint64_t workspace_addr);
};
}  // namespace aicpu
#endif  // AICPU_CONTEXT_INC_UTILS_H_
