/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __OP_ARG_DEF_H__
#define __OP_ARG_DEF_H__

#include <array>
#include <string>
#include <tuple>
#include <vector>
#include <type_traits>
#include "opdev/common_types.h"

namespace op {

enum OpArgDef {
    OP_INPUT_ARG = 0,
    OP_OUTPUT_ARG = 1,
    OP_ATTR_ARG = 2,
    OP_WORKSPACE_ARG = 3,
    OP_OUTSHAPE_ARG = 4,
    OP_OPTION_ARG = 5,
    OP_EXEC_MODE_ARG = 6,
    OP_MEMSET_ARG = 7,
    OP_EMPTY_ARG = 8,
    OP_ARG_DEF_BUTT = 9,
};

enum class OpArgType {
    OPARG_ACLTENSOR,
    OPARG_ACLTENSOR_LIST,
    OPARG_ACLSCALAR,
    OPARG_STRING,  // 所有string, string*，char*都转化为 char*
    OPARG_BOOL,
    OPARG_INT,
    OPARG_UINT,
    OPARG_FLOAT,
    OPARG_DOUBLE,
    OPARG_DATATYPE,
    OPARG_INT_LIST,
    OPARG_UINT_LIST,
    OPARG_FLOAT_LIST,
    OPARG_BOOL_LIST,
    OPARG_IMPLMODE,
    OPARG_MEMSET_WORKSPACE
};

constexpr size_t OP_ARG_TYPE_NUM = OP_EXEC_MODE_ARG + 1;

template<typename>
inline constexpr bool DEPENDENT_FALSE_V = false;

template<size_t I = 0, typename F, typename... Ts>
inline int VisitTupleElem(const F &func, const std::tuple<Ts...> &tp)
{
    if constexpr (I >= sizeof...(Ts)) {
        return 0;
    } else {
        int rc = func(I, std::get<I>(tp));
        if (rc != 0) {
            return rc;
        };
        return VisitTupleElem<I + 1>(func, tp);
    }
}

template<size_t I = 0, typename F, typename... Ts>
inline void VisitTupleElemNoReturn(const F &func, const std::tuple<Ts...> &tp)
{
    if constexpr (I >= sizeof...(Ts)) {
        return;
    } else {
        func(I, std::get<I>(tp));
        VisitTupleElemNoReturn<I + 1>(func, tp);
    }
}

template<size_t I = 0, typename F, typename... Ts>
inline void VisitTupleElemAt(size_t idx, const F &func, const std::tuple<Ts...> &tp)
{
    if constexpr (I >= sizeof...(Ts)) {
        return;
    } else if (I == idx) {
        func(I, std::get<I>(tp));
        return;
    } else {
        VisitTupleElemAt<I + 1>(idx, func, tp);
    }
}

template<typename... T>
struct OpArgBase {
    OpArgBase(const std::tuple<T...> &arg) : arg_(arg) {}
    OpArgBase(std::tuple<T...> &&arg) : arg_(std::forward<std::tuple<T...>>(arg)) {}
    OpArgBase() : arg_() {}

    std::tuple<T...> arg_;

    constexpr size_t Size() const
    {
        return sizeof...(T);
    }

    template<typename F>
    inline int VisitBy(const F &func) const
    {
        return VisitTupleElem(func, arg_);
    }

    template<typename F>
    inline void VisitByNoReturn(const F &func) const
    {
        VisitTupleElemNoReturn(func, arg_);
    }

    template<typename F>
    inline void VisitAt(size_t idx, const F &func) const
    {
        VisitTupleElemAt(idx, func, arg_);
    }
};

template <template <typename...> class Template, typename T>
struct is_instance_of_template : std::false_type {};

template <typename... T>
struct is_instance_of_template<OpArgBase, OpArgBase<T...>> : std::true_type {};

#define DEFINE_OP_ARG(op_arg, op_type)                                                               \
    template<typename... T>                                                                          \
    struct op_arg : public OpArgBase<T...> {                                                         \
        static constexpr int value = op_type;                                                        \
        using type = op_arg;                                                                         \
                                                                                                     \
        op_arg(std::tuple<T...> &&arg) : OpArgBase<T...>(std::forward<std::tuple<T...>>(arg)) {}     \
        op_arg(const std::tuple<T...> &arg) : OpArgBase<T...>(arg) {}                                \
        op_arg() {}                                                                                  \
        constexpr int Type() const { return value;}                                                  \
    };                                                                                               \
    template <typename... T>                                                                         \
    struct is_instance_of_template<OpArgBase, op_arg<T...>> : std::true_type {};
    // macro end........................................................................//

DEFINE_OP_ARG(OpInput, OP_INPUT_ARG)
DEFINE_OP_ARG(OpOutput, OP_OUTPUT_ARG)
DEFINE_OP_ARG(OpAttr, OP_ATTR_ARG)
DEFINE_OP_ARG(OpWorkspace, OP_WORKSPACE_ARG)
DEFINE_OP_ARG(OpOutshape, OP_OUTSHAPE_ARG)
DEFINE_OP_ARG(OpOption, OP_OPTION_ARG)
DEFINE_OP_ARG(OpMode, OP_EXEC_MODE_ARG)
DEFINE_OP_ARG(OpEmpty, OP_EMPTY_ARG)

inline const auto EMPTY_OP_ARG = OpEmpty<>();

const std::string &OpArgTypeStr(int argType);

template<int V, typename T, typename... Ts>
constexpr const auto &ExtractOpArgType(const T &t, const Ts &...ts)
{
    if constexpr (T::value == V) {
        return t;
    } else if constexpr (sizeof...(Ts) > 0) {
        return ExtractOpArgType<V>(ts...);
    } else {
        return EMPTY_OP_ARG;
    }
}

template<int V, typename Tuple, size_t I = 0>
constexpr const auto &ExtractOpArgTypeTuple(const Tuple &t)
{
    constexpr auto size = std::tuple_size<Tuple>::value;
    if constexpr (size <= I) {
        return EMPTY_OP_ARG;
    } else if constexpr (std::tuple_element_t<I, Tuple>::value == V) {
        return std::get<I>(t);
    } else {
        return ExtractOpArgTypeTuple<V, Tuple, I + 1>(t);
    }
}

struct OpArgValue {
    using FreeFunc = void (*)(void *);
    OpArgValue() = default;
    union ValueData {
        uint64_t value;
        int64_t ivalue;
        double dvalue;
        float fvalue;
        void *pointer;
    } data;
    FreeFunc deleter = nullptr;

    OpArgValue(const aclTensor *value)
    {
        data.pointer = const_cast<aclTensor *>(value);
    }

    OpArgValue(aclTensor *value)
    {
        data.pointer = value;
    }

    OpArgValue(const aclTensorList *value)
    {
        data.pointer = const_cast<aclTensorList *>(value);
    }

    OpArgValue(aclTensorList *value)
    {
        data.pointer = value;
    }

    OpArgValue(std::string *value) : OpArgValue(const_cast<const std::string *>(value))
    {}

    OpArgValue(const std::string *value);
    OpArgValue(std::string &value) : OpArgValue(const_cast<const std::string &>(value))
    {}

    OpArgValue(const std::string &value);
    OpArgValue(const char *value);
    OpArgValue(char *value) : OpArgValue(const_cast<const char *>(value))
    {}

    OpArgValue(std::vector<std::tuple<void *, const aclTensor *>> *value)
    {
        data.pointer = value;
    }

    OpArgValue(const std::vector<std::tuple<void*, const aclTensor*>> *value)
    {
        data.pointer = const_cast<std::vector<std::tuple<void*, const aclTensor*>> *>(value);
    }

    OpArgValue(double value)
    {
        data.dvalue = value;
    }

    OpArgValue(uint32_t value)
    {
        data.value = static_cast<uint64_t>(value);
    }

    OpArgValue(int32_t value)
    {
        data.ivalue = static_cast<int64_t>(value);
    }

    OpArgValue(float value)
    {
        data.fvalue = value;
    }

    OpArgValue(const bool value)
    {
        data.value = static_cast<uint64_t>(value);
    }

    OpArgValue(const DataType value)
    {
        data.value = static_cast<uint64_t>(value);
    }

    OpArgValue(aclScalar *value)
    {
        data.pointer = value;
    }

    OpArgValue(const aclScalar *value)
    {
        data.pointer = const_cast<aclScalar *>(value);
    }

    OpArgValue(aclIntArray *value)
    {
        data.pointer = value;
    }

    OpArgValue(const aclIntArray *value)
    {
        data.pointer = const_cast<aclIntArray *>(value);
    }

    OpArgValue(aclFloatArray *value)
    {
        data.pointer = value;
    }

    OpArgValue(const aclFloatArray *value)
    {
        data.pointer = const_cast<aclFloatArray *>(value);
    }

    OpArgValue(aclBoolArray *value)
    {
        data.pointer = value;
    }

    OpArgValue(const aclBoolArray *value)
    {
        data.pointer = const_cast<aclBoolArray *>(value);
    }

    OpArgValue(op::OpImplMode value)
    {
        data.value = static_cast<uint64_t>(value);
    }
    template<typename T>
    OpArgValue(const T &value)
    {
        data.value = static_cast<uint64_t>(value);
    }
};

struct OpArg {
    OpArgType type;
    OpArgValue value;

    OpArg() = default;

    inline OpArgValue::ValueData *operator->()
    {
        return &value.data;
    }
};

struct OpArgList {
    OpArg *args = nullptr;
    size_t count = 0;
    int argType;

    OpArgList() = default;

    OpArgList(OpArg *args_, size_t count_)
        : args(args_), count(count_) {}

    inline OpArg &operator[](uint64_t i)
    {
        return args[i];
    }

    template<typename F>
    inline int VisitBy(const F &func) const
    {
        for (size_t i = 0; i < count; i++) {
            int rc = func(i, args[i]);
            if (rc != 0) {
                return rc;
            }
        }
        return 0;
    }

    template<typename F>
    inline void VisitByNoReturn(const F &func) const
    {
        for (size_t i = 0; i < count; i++) {
            func(i, args[i]);
        }
    }

    template<typename F>
    inline void VisitAt(size_t idx, const F &func) const
    {
        if (idx >= OP_INPUT_ARG && idx <= OP_EXEC_MODE_ARG) {
            func(idx, args[idx]);
        }
    }
};

struct OpArgContext {
    OpArgContext()
    {
        for (auto &opArgList : argLists) {
            opArgList.args = nullptr;
            opArgList.count = 0;
        }
    }

    inline OpArgList *GetOpArg(OpArgDef type)
    {
        if (type >= OP_INPUT_ARG && type <= OP_EXEC_MODE_ARG) {
            return &argLists[type];
        }
        return nullptr;
    }

    inline bool ContainsOpArgType(OpArgDef type)
    {
        if (type >= OP_INPUT_ARG && type <= OP_EXEC_MODE_ARG) {
            return argLists[type].args && argLists[type].count;
        }
        return false;
    }

    void AppendOpWorkspaceArg(aclTensorList *tensorList);

    std::array<OpArgList, OP_ARG_TYPE_NUM> argLists;
    uint8_t reserved[32];
};

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclTensor *tensor,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLTENSOR;
    currArg->value = OpArgValue(tensor);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclTensor *tensor,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLTENSOR;
    currArg->value = OpArgValue(tensor);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclTensorList *tensorList,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLTENSOR_LIST;
    currArg->value = OpArgValue(tensorList);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclTensorList *tensorList,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLTENSOR_LIST;
    currArg->value = OpArgValue(tensorList);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx,
                        [[maybe_unused]] const std::nullptr_t tensor,
                        OpArg *&currArg)
{
    aclTensor *value = nullptr;
    currArg->type = OpArgType::OPARG_ACLTENSOR;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const bool value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_BOOL;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const DataType value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_DATATYPE;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclScalar *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLSCALAR;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclScalar *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_ACLSCALAR;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclIntArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_INT_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclIntArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_INT_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclFloatArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_FLOAT_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclFloatArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_FLOAT_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, aclBoolArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_BOOL_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const aclBoolArray *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_BOOL_LIST;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, std::string *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const std::string *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, std::string &value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const std::string &value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const char *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, char *value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_STRING;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, double value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_DOUBLE;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, float value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_FLOAT;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, int32_t value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_INT;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, uint32_t value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_UINT;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, op::OpImplMode value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_IMPLMODE;
    currArg->value = OpArgValue(value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, std::vector<std::tuple<void*, const aclTensor*>> &value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_MEMSET_WORKSPACE;
    currArg->value = OpArgValue(&value);
    currArg++;
}

inline void AppendOpArg([[maybe_unused]] size_t idx, const std::vector<std::tuple<void*, const aclTensor*>> &value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_MEMSET_WORKSPACE;
    currArg->value = OpArgValue(&value);
    currArg++;
}

template<typename T>
inline void AppendOpArg([[maybe_unused]] size_t idx, T value,
                        OpArg *&currArg)
{
    currArg->type = OpArgType::OPARG_INT;
    currArg->value = OpArgValue(value);
    currArg++;
}

template<typename T, typename... Ts>
size_t OpArgContextSize(const T &t, const Ts &...ts)
{
    if constexpr (!is_instance_of_template<OpArgBase, T>::value) {
        if constexpr (sizeof...(Ts) > 0) {
            return OpArgContextSize(ts...);
        }
        return 0;
    } else {
        size_t size = t.Size();
        if constexpr (sizeof...(Ts) > 0) {
            return size + OpArgContextSize(ts...);
        }
        return size;
    }
}

template<typename T, typename... Ts>
int OpArgContextInit(OpArgContext &ctx, OpArg *&currArg,
                     const T &t, const Ts &...ts)
{
    if constexpr (!is_instance_of_template<OpArgBase, T>::value) {
        if constexpr (sizeof...(Ts) > 0) {
            return OpArgContextInit(ctx, currArg, ts...);
        }
        return ACLNN_SUCCESS;
    } else {
        int opArgType = t.value;
        if (opArgType < OP_INPUT_ARG || opArgType > OP_EXEC_MODE_ARG) {
            if constexpr (sizeof...(Ts) > 0) {
                return OpArgContextInit(ctx, currArg, ts...);
            }
            return ACLNN_SUCCESS;
        }

        OpArg *begin = currArg;
        t.VisitByNoReturn(
            [&currArg](size_t idx, const auto &elem) {
                AppendOpArg(idx, elem, currArg);
            });
        ctx.argLists[opArgType].args = begin;
        ctx.argLists[opArgType].count = static_cast<size_t>(currArg - begin);
        ctx.argLists[opArgType].argType = opArgType;

        if constexpr (sizeof...(Ts) > 0) {
            return OpArgContextInit(ctx, currArg, ts...);
        }
        return ACLNN_SUCCESS;
    }
}

void *Allocated(size_t size);
void DeAllocated(void *addr);

template<typename... Ts>
OpArgContext *MakeOpArgContext(const Ts &...ts)
{
    // add 1 for append workspace
    size_t size = sizeof(OpArgContext) + (OpArgContextSize(ts...) + 1) * sizeof(OpArg);
    void *addr = Allocated(size);
    if (!addr) {
        OP_LOGE(ACLNN_ERR_INNER, "failed to allocate OpArgContext.");
        return nullptr;
    }
    OpArgContext *ctx = new (addr) OpArgContext();
    // reserve first OpArg for append workspace
    OpArg *currArg = reinterpret_cast<OpArg *>(ctx + 1) + 1;
    if (OpArgContextInit(*ctx, currArg, ts...)) {
        OP_LOGE(ACLNN_ERR_INNER, "failed to init OpArgContext.");
        DeAllocated(ctx);
        return nullptr;
    }
    return ctx;
}

template<typename... Ts>
inline OpArgContext *GetOpArgContext(const Ts &...ts)
{
    OpArgContext *opArgContext = MakeOpArgContext(ts...);
    return opArgContext;
}

[[maybe_unused]] void DestroyOpArgContext(OpArgContext *ctx);
} // namespace op

#define OP_INPUT(x...) op::OpInput(std::make_tuple(x))
#define OP_OUTPUT(x...) op::OpOutput(std::make_tuple(x))
#define OP_ATTR(x...) op::OpAttr(std::make_tuple(x))
#define OP_WORKSPACE(x...) op::OpWorkspace(std::make_tuple(x))
#define OP_OUTSHAPE(x...) op::OpOutshape(std::tuple<aclTensor *, uint64_t>(x))
#define OP_OPTION(x...) op::OpOption(std::make_tuple(x))
#define OP_EMPTY_ARG op::EMPTY_OP_ARG
#define OP_MODE(x...) op::OpMode(std::make_tuple(x))

#endif