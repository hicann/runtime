/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_DFX_INTERNAL_UTIL_H_
#define OP_DFX_INTERNAL_UTIL_H_

#include "toolchain/aprof_pub.h"
#include "runtime/base.h"
#include "runtime/context.h"
#include "runtime/mem.h"
#include "adump_pub.h"
#include "runtime/rts/rts_context.h"
#include "runtime/rts/rts_mem.h"
#include "adump_api.h"
#include "opdev/format_utils.h"
#include "opdev/internal/acl_tensor_traits.h"
#include "opdev/internal/thread_local_context.h"
#include "opdev/op_arg_def.h"
#include "opdev/op_log.h"
#include "securec.h"
#include "mmpa/mmpa_api.h"

namespace op {
namespace internal {
constexpr const char *BLOCK_DIM_STR = "block_dim";
constexpr const char *DEV_FUNC = "dev_func";
constexpr const char *TVM_MAGIC = "tvm_magic";
constexpr const char *TILING_KEY_STR = "tiling_key";
constexpr const char *TILING_DATA_STR = "tiling_data";
constexpr const char *ARGS_BEFORE_EXEC = "args before execute";


class SystemConfig {
public:
    SystemConfig()
    {
        const char *enableDebugKernelEnv = nullptr;
        MM_SYS_GET_ENV(MM_ENV_NPU_COLLECT_PATH, enableDebugKernelEnv);
        if (enableDebugKernelEnv != nullptr) {
            enableDebugKernelFlag = true;
        } else {
            enableDebugKernelFlag = false;
        }
        OP_LOGI("enable debug kernel flag %d.", enableDebugKernelFlag);
    }

    aclnnStatus SetEnableDebugKernelFlag(bool flag)
    {
        enableDebugKernelFlag = flag;
        OP_LOGI("set enable debug kernel flag %d.", flag);
        return ACLNN_SUCCESS;
    }

    aclnnStatus GetEnableDebugKernelFlag(bool &flag)
    {
        int64_t debugFlag = 0;
        rtError_t ret = rtsCtxGetSysParamOpt(SYS_OPT_ENABLE_DEBUG_KERNEL, &debugFlag);
        if (ret != ACL_ERROR_NONE) {
            if (ret != ACL_ERROR_RT_SYSPARAMOPT_NOT_SET) {
                OP_LOGW("failed to call rtsCtxGetSysParamOpt, ret %d", ret);
            }
            debugFlag = 0;
        }
        flag = enableDebugKernelFlag || debugFlag == 1;
        return ACLNN_SUCCESS;
    }

private:
    bool enableDebugKernelFlag = false;
};

class RecordOpArgCallbacker {
public:
    RecordOpArgCallbacker(){};
    ~RecordOpArgCallbacker(){};

    static int32_t RecordOpArgCallback(
        uint64_t dumpSwitch, [[maybe_unused]] char *dumpConfig, [[maybe_unused]] int32_t size);
    static int32_t RecordOpArgDump(uint64_t dumpSwitch, [[maybe_unused]] char *dumpConfig, [[maybe_unused]] int32_t size);
};

class DevPtrGuard {
public:
    DevPtrGuard(void *ptr) : ptr_(ptr) {}
    ~DevPtrGuard()
    {
        if (ptr_) {
            rtsFree(ptr_);
        }
    }

private:
    void *ptr_{nullptr};
};

inline Adx::DeviceInfo BuildDeviceInfo(const std::string &name, void *addr, uint64_t length)
{
    Adx::DeviceInfo di;
    di.name = name;
    di.addr = addr;
    di.length = length;
    return di;
}

class OperatorInfoBuilder {
public:
    OperatorInfoBuilder(const std::string &opType, const std::string &opName, bool aging = true)
    {
        info_.opType = opType;
        info_.opName = opName;
        info_.agingFlag = aging;
    }

    OperatorInfoBuilder &Task(uint32_t deviceId, uint32_t taskId, uint32_t streamId, uint32_t contextId = UINT32_MAX)
    {
        info_.deviceId = deviceId;
        info_.taskId = taskId;
        info_.streamId = streamId;
        info_.contextId = contextId;
        return *this;
    }

    OperatorInfoBuilder &TensorInfo(const std::vector<Adx::TensorInfo> &tensors)
    {
        for (auto &it : tensors) {
            info_.tensorInfos.emplace_back(it);
        }
        return *this;
    }

    OperatorInfoBuilder &AdditionInfo(const std::string &key, const std::string &value)
    {
        info_.additionalInfo[key] = value;
        return *this;
    }

    OperatorInfoBuilder &DeviceInfo(const std::string &name, void *addr, uint64_t length)
    {
        for (auto &devInfo : info_.deviceInfos) {
            if (devInfo.name == name) {
                devInfo.addr = addr;
                devInfo.length = length;
                return *this;
            }
        }
        info_.deviceInfos.emplace_back(BuildDeviceInfo(name, addr, length));
        return *this;
    }

    Adx::OperatorInfo Build()
    {
        return info_;
    }

private:
    Adx::OperatorInfo info_;
};

template<typename... Args>
static void TraitsAclTensor(std::vector<const aclTensor *> &result, const std::tuple<Args...> &t)
{
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensor,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensorList,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
}

template<typename... Args>
static void TraitsAclTensor(FVector<const aclTensor *> &result, const std::tuple<Args...> &t)
{
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensor,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
    std::apply([&](auto &...args) {
        ((std::is_same_v<aclTensorList,
                         std::remove_const_t<std::remove_pointer_t<std::remove_reference_t<decltype(args)>>>>
              ? AddToList(result, args)
              : void()),
         ...);
    },
               t);
}

[[maybe_unused]] static void TraitsAclTensor(std::vector<const aclTensor *> &result, OpArgList &opArgList)
{
    opArgList.VisitByNoReturn([&result]([[maybe_unused]] size_t idx, OpArg &arg) {
        if (arg.type == OpArgType::OPARG_ACLTENSOR) {
            AddToList(result, reinterpret_cast<aclTensor *>(arg->pointer));
        } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            AddToList(result, reinterpret_cast<aclTensorList *>(arg->pointer));
        }
    });
}

[[maybe_unused]] static void TraitsAclTensor(FVector<const aclTensor *> &result, OpArgList &opArgList)
{
    opArgList.VisitByNoReturn([&result]([[maybe_unused]] size_t idx, OpArg &arg) {
        if (arg.type == OpArgType::OPARG_ACLTENSOR) {
            AddToList(result, reinterpret_cast<aclTensor *>(arg->pointer));
        } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            AddToList(result, reinterpret_cast<aclTensorList *>(arg->pointer));
        }
    });
}

[[maybe_unused]] static void TraitsAclTensorAndIdx(std::vector<const aclTensor *> &result, std::vector<uint32_t> &idxs,
    OpArgList &opArgList, bool genPlaceholder, int32_t &currentIdx)
{
    opArgList.VisitByNoReturn([&result, &idxs, genPlaceholder, &currentIdx]([[maybe_unused]] size_t idx, OpArg &arg) {
        if (arg.type == OpArgType::OPARG_ACLTENSOR) {
            AddToListAndIdx(result, idxs, genPlaceholder, reinterpret_cast<aclTensor *>(arg->pointer), currentIdx);
        } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            AddToListAndIdx(result, idxs, genPlaceholder, reinterpret_cast<aclTensorList *>(arg->pointer), currentIdx);
        }
    });
}

[[maybe_unused]] static void TraitsAclTensorAndIdx(std::vector<const aclTensor *> &result, std::vector<uint32_t> &idxs,
    OpArgList &opArgList, bool genPlaceholder, bool hasDevPtrArg, int32_t &currentIdx,
    std::vector<int32_t> &tensorOffset)
{
    opArgList.VisitByNoReturn(
        [&result, &idxs, genPlaceholder, hasDevPtrArg, &currentIdx, &tensorOffset]([[maybe_unused]] size_t idx,
                                                                                    OpArg &arg) {
            if (arg.type == OpArgType::OPARG_ACLTENSOR) {
                AddToListAndIdx(result, idxs, genPlaceholder, reinterpret_cast<aclTensor *>(arg->pointer), currentIdx);
            } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
                if (hasDevPtrArg) {
                    AddToListAndIdx(result, idxs, genPlaceholder, reinterpret_cast<aclTensorList *>(arg->pointer),
                                    currentIdx, tensorOffset);
                } else {
                    AddToListAndIdx(result, idxs, genPlaceholder, reinterpret_cast<aclTensorList *>(arg->pointer),
                                    currentIdx);
                }
            }
    });
}

}  // namespace internal
}  // namespace op

#endif
