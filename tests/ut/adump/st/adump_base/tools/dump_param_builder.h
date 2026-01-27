/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TOOLS_DUMP_PARAMS_BUILDER_H
#define TOOLS_DUMP_PARAMS_BUILDER_H
#include "adump_pub.h"
#include "runtime/rt.h"

namespace Adx {

inline TensorInfo BuildTensorInfo(gert::Tensor *tensor, TensorType tensorType,
                                  AddressType addrType = AddressType::TRADITIONAL, uint32_t argsOffSet = 0)
{
    TensorInfo ti;
    ti.tensor = tensor;
    ti.type = tensorType;
    ti.addrType = addrType;
    ti.argsOffSet = argsOffSet;
    return ti;
}

inline DeviceInfo BuildDeviceInfo(const std::string &name, void *addr, uint64_t length)
{
    DeviceInfo di;
    di.name = name;
    di.addr = addr;
    di.length = length;
    return di;
}

inline rtExceptionInfo BuildRtException(uint32_t deviceId, uint32_t taskId, uint32_t streamId, uint32_t retCode = 0,
                                        uint32_t contextId = UINT32_MAX, uint32_t threadId = UINT32_MAX)
{
    rtExceptionInfo exception;
    exception.deviceid = deviceId;
    exception.taskid = taskId;
    exception.streamid = streamId;
    exception.retcode = retCode;
    if (contextId == UINT32_MAX) {
        exception.expandInfo.type = RT_EXCEPTION_AICORE;
        exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
        exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    } else {
        exception.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
        exception.expandInfo.u.fftsPlusInfo.contextId = contextId;
        exception.expandInfo.u.fftsPlusInfo.threadId = threadId;
        exception.expandInfo.u.fftsPlusInfo.exceptionArgs.argAddr = nullptr;
        exception.expandInfo.u.fftsPlusInfo.exceptionArgs.argsize = 0;
    }

    return exception;
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

    OperatorInfoBuilder &TensorInfo(gert::Tensor *tensor, TensorType type,
                                    AddressType addrType = AddressType::TRADITIONAL, uint32_t argsOffSet = 0)
    {
        info_.tensorInfos.emplace_back(BuildTensorInfo(tensor, type, addrType, argsOffSet));
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

    OperatorInfo Build()
    {
        return info_;
    }

private:
    OperatorInfo info_;
};

}  // namespace Adx
#endif  // TOOLS_DUMP_PARAMS_BUILDER_H
