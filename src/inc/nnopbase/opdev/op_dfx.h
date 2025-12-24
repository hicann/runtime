/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_DFX_H__
#define OP_DFX_H__

#include <string>
#include <string_view>
#include <vector>
#include <tuple>
#include <map>

#include "graph/ascend_string.h"
#include "opdev/op_arg_def.h"
#include "opdev/format_utils.h"

namespace op {

ge::AscendString ToString(const std::string &str);

constexpr bool ValidDfxName([[maybe_unused]]char const *a, [[maybe_unused]]char const *b)
{
#ifdef CFG_BUILD_DEBUG
    return true;
#else
    return std::string_view(a) == b;
#endif
}

namespace internal {
uint64_t OpGetLogSequence();
uint64_t GenSummaryItemId(const char *l2Name, const char *l0Name);
uint64_t GenSummaryItemId(const char *l2Name, const char *l0Name, const char *opType);
uint64_t GenKernelLauncherId(const char *l0Name);

struct OpProfilingSwitch {
    OpProfilingSwitch();
    bool reportFlag;
    bool kernelLaunchFlag;
    bool additionInfoFlag;
    bool recordOpArgFlag;
    bool level2ProfilingFlag;
    bool timeStampFlag;
};

extern OpProfilingSwitch opProfilingSwitch;

struct OpLogInfo {
    OpLogInfo()
    {
        Init();
    }
    OpLogInfo(const OpLogInfo &rhs)
    {
        l2ApiName = rhs.l2ApiName;
        l0Name = rhs.l0Name;
        l2SequenceCounter = rhs.l2SequenceCounter;
    }
    OpLogInfo &operator=(const OpLogInfo &rhs)
    {
        if (this != &rhs) {
            l2ApiName = rhs.l2ApiName;
            l0Name = rhs.l0Name;
            l2SequenceCounter = rhs.l2SequenceCounter;
        }
        return *this;
    }
    inline void Init()
    {
        l2ApiName = nullptr;
        l0Name = nullptr;
        l2SequenceCounter = 0;
    }
    inline void InitLevelZero()
    {
        l0Name = nullptr;
    }
    inline void InitLevelTwo()
    {
        Init();
    }
    const char *l2ApiName;
    const char *l0Name;
    uint64_t l2SequenceCounter;
};
template<typename To, typename From>
inline To *PtrCastTo(From *ptr)
{
    return reinterpret_cast<To*>(ptr);
}

template<typename To, typename From>
inline const To *PtrCastTo(const From *ptr)
{
    return reinterpret_cast<const To*>(ptr);
}
}  // namespace internal

uint32_t GenOpTypeId(const char *opName);
constexpr int32_t kInvalidHugeMemIndexId = -1;

bool IsDumpEnabled();
void InitThreadLocalContext();
aclnnStatus CheckPhase1Params(aclOpExecutor **executor, uint64_t *workspaceSize);

void AddInputTensorToThreadLocalCtx(const aclTensor *const t);
void AddInputTensorToThreadLocalCtx(aclTensor *const t);
void AddInputTensorToThreadLocalCtx(const aclTensorList *const t);
void AddInputTensorToThreadLocalCtx(aclTensorList *const t);
void AddOutputTensorToThreadLocalCtx(const aclTensor *const t);
void AddOutputTensorToThreadLocalCtx(aclTensor *const t);
void AddOutputTensorToThreadLocalCtx(const aclTensorList *const t);
void AddOutputTensorToThreadLocalCtx(aclTensorList *const t);
template <typename T>
 static void AddInputTensorToThreadLocalCtx([[maybe_unused]] T &t)
{}
template <typename T>
static void AddOutputTensorToThreadLocalCtx([[maybe_unused]] T &t)
{}

template<typename... Args>
static void AddInputTensorsToThreadLocalCtx(const std::tuple<Args...> &t)
{
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensor,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddInputTensorToThreadLocalCtx(args)
              : void()),
         ...);
    },
               t);
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensorList,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddInputTensorToThreadLocalCtx(args)
              : void()),
         ...);
    },
               t);
}

template<typename... Args>
static void AddOutputTensorsToThreadLocalCtx(const std::tuple<Args...> &t)
{
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensor,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddOutputTensorToThreadLocalCtx(args)
              : void()),
         ...);
    },
               t);
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensorList,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddOutputTensorToThreadLocalCtx(args)
              : void()),
         ...);
    },
               t);
}

enum OpLevel { LevelZero, LevelOne, LevelTwo };
enum DfxProfilingType { DfxProfilingDefault, DfxProfilingInferShape, DFXProfilingTiling, DfxProfilingKernelLaunch };

constexpr int kInvalidProfilingId = 0;
class OpDfxProfiler;

OpDfxProfiler *CreateDfxProfiler(const char *funcName);
OpDfxProfiler *CreateDfxProfiler(uint32_t id);
class OpDfxGuard {
public:
    // L2_DFX PHASE_ONE
    template<typename INPUT_TUPLE = void *, typename OUTPUT_TUPLE = void *>
    OpDfxGuard(const char *file,
               int line,
               OpLevel level,
               const char *funcName,
               const char *paramNamesIn,
               const char *paramNamesOut,
               const INPUT_TUPLE &&in,
               const OUTPUT_TUPLE &&out) : funcName_(funcName),
                                           file_(file),
                                           printLog_(true),
                                           line_(line),
                                           level_(level),
                                           profilingType_(DfxProfilingDefault)
    {
        OP_DFX_LOGI(file, line, funcName_, "Entering function %s.", funcName);
        OP_LOGI("Entering function in params end. %d", BuildParamStringWithBrackets(paramNamesIn, in));
        OP_LOGI("Entering function out params end. %d", BuildParamStringWithBrackets(paramNamesOut, out));

        if (op::internal::opProfilingSwitch.reportFlag) {
            opDfxProfiler_ = CreateDfxProfiler(funcName);
        }
        if (IsDumpEnabled()) {
            InitThreadLocalContext();
            AddInputTensorsToThreadLocalCtx(in);
            AddOutputTensorsToThreadLocalCtx(out);
        }
    }

    // L2_DFX PHASE_TWO
    OpDfxGuard(const char *file, int line, OpLevel level, const char *funcName);

    // L0_DFX
    template<typename... Args>
    OpDfxGuard(uint32_t id,
               const char *file,
               int line,
               OpLevel level,
               const char *funcName,
               const char *paramNames,
               const std::tuple<Args...> &t) : funcName_(funcName),
                                               file_(file),
                                               printLog_(true),
                                               line_(line),
                                               level_(level),
                                               profilingType_(DfxProfilingDefault)
    {
        OP_DFX_LOGI(file, line, funcName_, "Entering function %s.", funcName);
        OP_LOGI("Entering function end. %d", BuildParamString(paramNames, t));

        if (op::internal::opProfilingSwitch.reportFlag && (id != kInvalidProfilingId)) {
            opDfxProfiler_ = CreateDfxProfiler(id);
        }
    }

    // infershape, tiling, kernel_launch
    OpDfxGuard(uint64_t id, DfxProfilingType type);

    ~OpDfxGuard();

private:
    OpDfxGuard() {}

    template<typename T>
    void ToStr(const T &t, std::string &res, std::vector<std::string> &v, size_t &index)
    {
        size_t argNum = v.size();
        std::string splitStr = (index < (argNum - 1)) ? ", " : "";
        if constexpr (std::is_fundamental<
                          std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<T>>>>::value) {
            if constexpr (std::is_same_v<T, char *> || std::is_same_v<T, const char *>) {
                if (t == nullptr) {
                    res += v[index++] + ": nullptr" + splitStr;
                } else {
                    res += v[index++] + ": " + std::string(t) + splitStr;
                }
            } else if constexpr (std::is_pointer_v<T>) {
                if (t == nullptr) {
                    res += v[index++] + ": nullptr" + splitStr;
                } else {
                    res += v[index++] + ": " + std::to_string(*t) + splitStr;
                }
            } else {
                res += v[index++] + ": " + std::to_string(t) + splitStr;
            }
        } else {
            res += v[index++] + ": " + ToString(t).GetString() + splitStr;
        }
    }
    // paramNames: "aa, bb, cc"
    void StringToVec(const char *paramNames, std::vector<std::string> &v);

    // paramNames: "DFX_IN(aa, bb, cc)" or "DFX_OUT(aa, bb)"
    void StringToVecWithBrackets(const char *paramNames, std::vector<std::string> &v);

    void SplitStringAndPrint(std::string &res)
    {
        int splitLogLen = 768;
        int n = res.length() / splitLogLen; // 子串个数
        for (int i = 0; i < n; i++) {
            std::string sub = res.substr(i * splitLogLen, splitLogLen);
            OP_LOGI("Entering function params: %s.", sub.c_str());
        }
        if (res.length() % splitLogLen != 0) {
            std::string sub = res.substr(n * splitLogLen);
            OP_LOGI("Entering function params: %s.", sub.c_str());
        }
    }

    template<typename... Args>
    int BuildParamString(const char *paramNames, const std::tuple<Args...> &t)
    {
        std::vector<std::string> v;
        StringToVec(paramNames, v);
        std::string res;
        size_t index = 0;
        std::apply([&](auto &...args) { ((ToStr(args, res, v, index), ...)); }, t);
        SplitStringAndPrint(res);
        return 0;
    }

    template<typename... Args>
    int BuildParamStringWithBrackets(const char *paramNames, const std::tuple<Args...> &t)
    {
        std::vector<std::string> v;
        StringToVecWithBrackets(paramNames, v);
        std::string res;
        size_t index = 0;
        std::apply([&](auto &...args) { ((ToStr(args, res, v, index), ...)); }, t);
        SplitStringAndPrint(res);
        return 0;
    }

private:
    const char *funcName_{nullptr};  // func name
    const char *file_{nullptr};  // file name
    bool printLog_{false};  // Whether to print logs
    int line_{0};  // Current Line
    OpLevel level_{LevelZero};  // level
    DfxProfilingType profilingType_{DfxProfilingDefault};  // profiling type
    OpDfxProfiler *opDfxProfiler_{nullptr};
    uint8_t reserved_field_[8]; // Reserved field
};

static constexpr uint32_t INVALID_OP_TYPE = 0;

using OP_HOST_FUNC_HANDLE = std::vector<void *>; // infershape/optiling/... func ptr
using OP_RES = std::tuple<const uint8_t *, const uint8_t *>; // op.json or op_1.json or op_1.o
using OP_BINARY_RES = std::vector<OP_RES>; // op_info.json, op_1.json, op_1.o
using OP_RUNTIME_KB_RES = std::vector<OP_RES>; // op_runtime_kb.json

using OP_RESOURCES = std::map<ge::AscendString,
    std::tuple<OP_HOST_FUNC_HANDLE, OP_BINARY_RES, OP_RUNTIME_KB_RES>>;

/**op_binary with binary_info_config, indexed by short soc version**/
using OP_SOC_RESOURCES = std::map<ge::AscendString,
    std::tuple<OP_HOST_FUNC_HANDLE, std::map<ge::AscendString, OP_BINARY_RES>, OP_RUNTIME_KB_RES>>;

#ifdef ACLNN_WITH_BINARY
uint32_t GenOpTypeId(const char *opName, const OP_RESOURCES &opResources);
uint32_t GenOpTypeId(const char *opName, const OP_SOC_RESOURCES &opResources);

#define OP_TYPE_REGISTER(kernelName)                                            \
    [[maybe_unused]] uint32_t kernelName##_kernelName_Be_Defined_Multi_Times__; \
    [[maybe_unused]] inline uint32_t kernelName##OpTypeId()                     \
    {                                                                           \
        kernelName##_kernelName_Be_Defined_Multi_Times__ = 0;                   \
        static uint32_t kernelName##OpTypeId = op::GenOpTypeId(#kernelName, kernelName##_RESOURCES); \
        return kernelName##OpTypeId;                                            \
    }
#else
inline void GenInternalOpTypeId()
{
    [[maybe_unused]] static uint32_t memsetOpTypeId = op::GenOpTypeId("MemSet");
    [[maybe_unused]] static uint32_t memsetV2OpTypeId = op::GenOpTypeId("MemSetV2");
    [[maybe_unused]] static uint32_t nonFiniteCheckOpTypeId = op::GenOpTypeId("NonFiniteCheck");
}

#define OP_TYPE_REGISTER(kernelName)                                            \
    [[maybe_unused]] uint32_t kernelName##_kernelName_Be_Defined_Multi_Times__; \
    [[maybe_unused]] inline uint32_t kernelName##OpTypeId()                     \
    {                                                                           \
        kernelName##_kernelName_Be_Defined_Multi_Times__ = 0;                   \
        op::GenInternalOpTypeId();                                              \
        static uint32_t kernelName##OpTypeId = op::GenOpTypeId(#kernelName);    \
        return kernelName##OpTypeId;                                            \
    }
#endif

#define DFX_IN(...) std::make_tuple(__VA_ARGS__)
#define DFX_OUT(...) std::make_tuple(__VA_ARGS__)

#define L2_OP_PROF_PHASE_1(paramNamesIn, paramNamesOut, IN, OUT)                                                     \
    op::OpDfxGuard opDfxGuard(__FILE__, __LINE__, op::LevelTwo,     \
                                                       __func__, paramNamesIn, paramNamesOut, IN, OUT)

#define L2_OP_PROF_PHASE_2()                                                                                          \
    op::OpDfxGuard opDfxGuard(__FILE__, __LINE__, op::LevelTwo, __func__);

#define L0_OP_PROF(paramNames, t)                                                                                     \
    op::OpDfxGuard opDfxGuard(op::kInvalidProfilingId, __FILE__, __LINE__, op::LevelZero, __func__, paramNames, t)

#define L2_DFX_PHASE_1_WITHOUT_CACHE(APIName, IN, OUT)                                                                 \
    static_assert(op::ValidDfxName(#APIName "GetWorkspaceSize", __func__), "Invalid DFX:" #APIName"GetWorkspaceSize"); \
    InitL2Phase1Context(#APIName, executor);                                                                           \
    L2_OP_PROF_PHASE_1(#IN, #OUT, IN, OUT)

#define L2_DFX_PHASE_1(APIName, IN, OUT)                                                                               \
    static_assert(op::ValidDfxName(#APIName "GetWorkspaceSize", __func__), "Invalid DFX:" #APIName"GetWorkspaceSize"); \
    if (CheckPhase1Params(executor, workspaceSize) != ACLNN_SUCCESS) {                                                 \
        return ACLNN_ERR_PARAM_NULLPTR;                                                                                \
    }                                                                                                                  \
    InitL2Phase1Context(#APIName, executor);                                                                           \
    L2_OP_PROF_PHASE_1(#IN, #OUT, IN, OUT);                                                                            \
    do {                                                                                                               \
        if (op::internal::GetFromCache(executor, workspaceSize, #APIName, IN, OUT)) {                                  \
            return ACLNN_SUCCESS;                                                                                      \
        }                                                                                                              \
    } while (false)

#define L2_DFX_PHASE_2(APIName)                                                                                       \
    static_assert(op::ValidDfxName(#APIName, __func__), "Invalid L2 DFX name: " #APIName);                            \
    InitL2Phase2Context(#APIName, executor);                                                                          \
    L2_OP_PROF_PHASE_2()

#define L0_DFX(profilingName, ...)                                                                                    \
    static_assert(op::ValidDfxName(#profilingName, __func__), "Invalid L0 DFX name: " #profilingName);                \
    InitL0Context(#profilingName, executor);                                                                          \
    L0_OP_PROF(#__VA_ARGS__, std::make_tuple(__VA_ARGS__));

} // namespace op

#endif
