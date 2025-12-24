/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __ACL_KERNEL_LAUNCHER_H__
#define __ACL_KERNEL_LAUNCHER_H__

#include "opdev/internal/launch_arg_info.h"
#include "opdev/op_dfx.h"

namespace op {
namespace internal {
inline void AssignAndIncrement(char *&key, char arg)
{
    *key = arg;
    ++key;
}

inline aclnnStatus AssignAndIncrement(char *&key, size_t maxSize, const uint8_t *arg, size_t size)
{
    auto ret = memcpy_s(key, maxSize, arg, size);
    if (ret != EOK) {
        return ACLNN_ERR_INNER_ATTR_LEN_NOT_ENOUGH;
    }
    key += size;
    return ACLNN_SUCCESS;
}

inline void GenTransDataKey(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                            size_t idx, const aclTensor *tensor)
{
    if (tensorInfos[idx].opType == op::BinConfigJsonDict::transDataId_ &&
        static_cast<ge::Format>(GetPrimaryFormat(tensor->GetStorageFormat())) == ge::FORMAT_FRACTAL_Z) {
        auto &shape = tensor->GetStorageShape();
        if (shape.GetDimNum() == FRACTAL_Z_SIZE) {
            AssignAndIncrement(key,
                MAX_VALID_DTYPE_FORMAT_KEY + static_cast<wchar_t>(shape.GetDim(FRACTAL_Z_SIZE - 1)));
        }
    }
}

inline void GenDimension(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                         size_t idx, const aclTensor *tensor)
{
    if (tensorInfos[idx].shapeSupportType == ShapeSupportType::NOT_SUPPORT_ALL) {
        auto &shape = tensor->GetStorageShape();
        AssignAndIncrement(key,
            MAX_VALID_DTYPE_FORMAT_KEY + static_cast<wchar_t>(shape.GetDimNum()));
    }
}

const std::string &OpArgTypeStr(int argType);

aclnnStatus GenKeyByArgImpl(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                            bool ignoreOptional, size_t idx, const aclTensor *tensor, int argType);
aclnnStatus GenKeyByArgImpl(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                            bool ignoreOptional, size_t idx, const aclTensorList *tensorList, int argType);
aclnnStatus GenKeyByArgImpl(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                            bool ignoreOptional, size_t idx, OpArg &opArg, int argType);

inline aclnnStatus GenKeyByOneArg(char *&key, const std::array<TensorInfo, MAX_TENSOR_SIZE> &tensorInfos,
                                  bool ignoreOptional, OpArgList &args)
{
    return args.VisitBy([&key, &tensorInfos, &args, ignoreOptional](size_t idx, OpArg &arg) {
        return GenKeyByArgImpl(key, tensorInfos, ignoreOptional, idx, arg, args.argType);
    });
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const DataType value)
{
    AssignAndIncrement(key, static_cast<char>(value));
    return ACLNN_SUCCESS;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const aclScalar *value)
{
    auto ret = AssignAndIncrement(key, remainLen, PtrCastTo<uint8_t>(value->GetData()), value->Size());
    return ret;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const aclIntArray *value)
{
    AssignAndIncrement(key, LEFT_BRACKET);
    AssignAndIncrement(key, static_cast<char>(value->Size()));
    AssignAndIncrement(key, RIGHT_BRACKET);
    return ACLNN_SUCCESS;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const aclFloatArray *value)
{
    AssignAndIncrement(key, LEFT_BRACKET);
    AssignAndIncrement(key, static_cast<char>(value->Size()));
    AssignAndIncrement(key, RIGHT_BRACKET);
    return ACLNN_SUCCESS;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const char *value)
{
    size_t maxLen = static_cast<size_t>(std::min(32, (int32_t) strlen(value)));
    auto ret = AssignAndIncrement(key, remainLen, PtrCastTo<uint8_t>(value), maxLen);
    return ret;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       [[maybe_unused]] const AttrInfo &attrInfo, const bool value)
{
    AssignAndIncrement(key, static_cast<char>(value));
    return ACLNN_SUCCESS;
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       const AttrInfo &attrInfo, double value)
{
    float valueFloat = value;
    return AssignAndIncrement(key, remainLen, PtrCastTo<uint8_t>(&valueFloat), attrInfo.realSize);
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       const AttrInfo &attrInfo, float value)
{
    return AssignAndIncrement(key, remainLen, PtrCastTo<uint8_t>(&value), attrInfo.realSize);
}

inline aclnnStatus GenKeyByOneAttrImpl(char *&key, [[maybe_unused]] size_t &remainLen, [[maybe_unused]] size_t idx,
                                       const AttrInfo &attrInfo, uint64_t value)
{
    int64_t valueInt64 = value;
    return AssignAndIncrement(key, remainLen, PtrCastTo<uint8_t>(&valueInt64), attrInfo.realSize);
}

aclnnStatus GenKeyByOneAttrImplWrapper(char *&key,
                                       size_t &remainLen,
                                       std::vector<AttrInfo> &attrInfos,
                                       OpArg &arg,
                                       size_t idx);

inline aclnnStatus GenKeyByAttrs(char *&key, size_t &remainLen, std::vector<AttrInfo> &attrInfos, OpArgList &t)
{
    return t.VisitBy([&key, &remainLen, &attrInfos]([[maybe_unused]] size_t idx, OpArg &elem) {
        return GenKeyByOneAttrImplWrapper(key, remainLen, attrInfos, elem, idx);
    });
}

void CalcAclTensorNum(size_t idx, const aclTensor *tensor, size_t &num);
void CalcAclTensorNum(size_t idx, const aclTensorList *tensor, size_t &num);
void CalcAclTensorNum(size_t idx, OpArg &arg, size_t &num);

inline size_t GetAclTensorCount(OpArgList &args)
{
    size_t num = 0;
    args.VisitByNoReturn([&num](size_t idx, OpArg &elem) { CalcAclTensorNum(idx, elem, num); });
    return num;
}

inline size_t GetArgCount4DevPtrArg(OpArgList &args)
{
    size_t num = 0;
    args.VisitByNoReturn([&num]([[maybe_unused]] size_t idx, OpArg &elem) {
        if (elem.type == OpArgType::OPARG_ACLTENSOR || elem.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            num++;
        }
    });
    return num;
}

} // namespace internal
} // namespace op

#endif
