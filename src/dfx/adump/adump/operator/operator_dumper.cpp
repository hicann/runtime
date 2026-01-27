/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_dumper.h"
#include "runtime/rt.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "dump_datatype.h"
#include "dump_memory.h"
#include "log/adx_log.h"

namespace Adx {
namespace {
constexpr uint32_t AI_CPU_LOAD_FLAG = 1U;
constexpr uint32_t TASK_ID_BITS_MASK = 0x0000FFFFU; // 16 bits, 1111,1111,1111,1111
constexpr int32_t TASK_ID_LEN_16 = 16;
constexpr char DUMP_KERNAL_OP_NAME[] = "DumpDataInfo";
} // namespace

OperatorDumper::OperatorDumper(const std::string &opType, const std::string &opName)
    : opType_(opType), opName_(opName), stream_(nullptr)
{
}

OperatorDumper &OperatorDumper::SetDumpSetting(const DumpSetting &setting)
{
    setting_ = setting;
    return *this;
}

OperatorDumper &OperatorDumper::InputDumpTensor(const std::vector<DumpTensor> &inputTensors)
{
    inputTensors_ = inputTensors;
    return *this;
}
OperatorDumper &OperatorDumper::OutputDumpTensor(const std::vector<DumpTensor> &outputTensors)
{
    outputTensors_ = outputTensors;
    return *this;
}

OperatorDumper &OperatorDumper::RuntimeStream(aclrtStream stream)
{
    stream_ = stream;
    return *this;
}

int32_t OperatorDumper::Launch()
{
    IDE_LOGI("Start to launch dump op %s[%s], input(%zu), output(%zu).", opName_.c_str(), opType_.c_str(),
        inputTensors_.size(), outputTensors_.size());

    int32_t ret = FillOpMappinfInfo();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Fill op mapping info failed.");
        return ret;
    }

    ret = LaunchDumpKernal();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Launch dump kernal failed.");
        return ret;
    }
    return ADUMP_SUCCESS;
}

int32_t OperatorDumper::FillOpMappinfInfo()
{
    // Set defualt
    opMappingInfo_.clear_task();
    opMappingInfo_.set_flag(AI_CPU_LOAD_FLAG);
    if (setting_.GetDumpData().compare(DUMP_STATS_DATA) == 0) {
        opMappingInfo_.set_dump_data(toolkit::aicpu::dump::DumpData::STATS_DUMP_DATA);
    } else {
        opMappingInfo_.set_dump_data(toolkit::aicpu::dump::DumpData::TENSOR_DUMP_DATA);
    }

    int32_t deviceId = 0;
    rtError_t rtRet = rtGetDevice(&deviceId);
    if (rtRet != RT_ERROR_NONE || deviceId < 0) {
        IDE_LOGE("rtGetDevice failed, ret 0x%X, devId: %d", rtRet, deviceId);
        return ADUMP_FAILED;
    }

    int32_t ret = FillDumpPath(deviceId);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Fill dump path failed.");
        return ret;
    }

    ret = FillDumpTask(deviceId);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Fill dump path failed.");
        return ret;
    }
    return ADUMP_SUCCESS;
}

int32_t OperatorDumper::FillDumpPath(int32_t deviceId)
{
    Path dumpPathWithDevId(setting_.GetDumpPath());
    dumpPathWithDevId.Append(std::to_string(deviceId));
    opMappingInfo_.set_dump_path(dumpPathWithDevId.GetString());
    IDE_LOGI("Dump op to path %s.", dumpPathWithDevId.GetCString());
    return ADUMP_SUCCESS;
}

int32_t OperatorDumper::FillDumpTask(int32_t deviceId)
{
    toolkit::aicpu::dump::Task task;
    task.mutable_op()->set_op_name(opName_);
    task.mutable_op()->set_op_type(opType_);

    uint32_t taskId = 0U;
    rtError_t rtRet = rtsGetThreadLastTaskId(&taskId);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtsGetThreadLastTaskId failed, ret 0x%X", rtRet);
        return ADUMP_FAILED;
    }

    int32_t streamId = 0U;
    rtRet = rtsStreamGetId(stream_, &streamId);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtsStreamGetId failed, ret 0x%X", rtRet);
        return ADUMP_FAILED;
    }

    int32_t taskIdLen = 0;
    rtRet = rtsDeviceGetCapability(deviceId, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &taskIdLen);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtsDeviceGetCapability failed, ret 0x%X", rtRet);
        return ADUMP_FAILED;
    }
    if (taskIdLen == TASK_ID_LEN_16) {
        taskId = taskId & TASK_ID_BITS_MASK;
    }

    task.set_task_id(taskId);
    task.set_stream_id(static_cast<uint32_t>(streamId));
    IDE_LOGI("Task id is %u, stream id is %d", taskId, streamId);

    uint32_t dumpMode = setting_.GetDumpMode();
    if ((dumpMode & DUMP_MODE_OUTPUT) != 0) {
        DumpOutput(task);
    }

    if ((dumpMode & DUMP_MODE_INPUT) != 0) {
        DumpInput(task);
    }

    opMappingInfo_.mutable_task()->Add(std::move(task));
    return ADUMP_SUCCESS;
}

void OperatorDumper::DumpInput(toolkit::aicpu::dump::Task &task)
{
    for (const auto &dumpTensor : inputTensors_) {
        toolkit::aicpu::dump::Input input;
        auto ir_data_type = DumpDataType::GetIrDataType(static_cast<GeDataType>(dumpTensor.GetDataType()));
        input.set_data_type(static_cast<int32_t>(ir_data_type));
        input.set_format(static_cast<int32_t>(dumpTensor.GetFormat()));

        std::vector<int64_t> shape = dumpTensor.GetShape();
        for (auto dim : shape) {
            input.mutable_shape()->add_dim(static_cast<uint64_t>(dim));
        }
        std::vector<int64_t> originShape = dumpTensor.GetOriginShape();
        for (auto dim : originShape) {
            input.mutable_origin_shape()->add_dim(static_cast<uint64_t>(dim));
        }

        size_t dumpSize = dumpTensor.GetSize();
        const void *dumpAddr = dumpTensor.GetAddress();
        input.set_size(static_cast<uint64_t>(dumpSize));
        input.set_address(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(dumpAddr)));
        IDE_LOGI("Dump op(%s) input addr(%p), size(%zu).", opName_.c_str(), dumpAddr, dumpSize);
        input.set_addr_type(dumpTensor.GetAddressType() == AddressType::NOTILING ?
            toolkit::aicpu::dump::AddressType::NOTILING_ADDR :
            toolkit::aicpu::dump::AddressType::TRADITIONAL_ADDR);
        task.mutable_input()->Add(std::move(input));
    }
}

void OperatorDumper::DumpOutput(toolkit::aicpu::dump::Task &task)
{
    for (const auto &dumpTensor : outputTensors_) {
        toolkit::aicpu::dump::Output output;
        auto ir_data_type = DumpDataType::GetIrDataType(static_cast<GeDataType>(dumpTensor.GetDataType()));
        output.set_data_type(static_cast<int32_t>(ir_data_type));
        output.set_format(static_cast<int32_t>(dumpTensor.GetFormat()));
        std::vector<int64_t> shape = dumpTensor.GetShape();
        for (auto dim : shape) {
            output.mutable_shape()->add_dim(static_cast<uint64_t>(dim));
        }
        std::vector<int64_t> originShape = dumpTensor.GetOriginShape();
        for (auto dim : originShape) {
            output.mutable_origin_shape()->add_dim(static_cast<uint64_t>(dim));
        }

        size_t dumpSize = dumpTensor.GetSize();
        const void *dumpAddr = dumpTensor.GetAddress();
        output.set_size(static_cast<uint64_t>(dumpSize));
        output.set_address(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(dumpAddr)));
        IDE_LOGI("Dump op(%s) output addr(%p), size(%zu).", opName_.c_str(), dumpAddr, dumpSize);

        output.set_addr_type(dumpTensor.GetAddressType() == AddressType::NOTILING ?
            toolkit::aicpu::dump::AddressType::NOTILING_ADDR :
            toolkit::aicpu::dump::AddressType::TRADITIONAL_ADDR);
        task.mutable_output()->Add(std::move(output));
    }
}

int32_t OperatorDumper::LaunchDumpKernal() const
{
    std::string protoMsg;
    const size_t protoSize = opMappingInfo_.ByteSizeLong();
    const bool ret = opMappingInfo_.SerializeToString(&protoMsg);
    if ((!ret) || (protoSize == 0U)) {
        IDE_LOGE("Serialize proto msg failed, size is %zu", protoSize);
        return ADUMP_FAILED;
    }

    void *protoMsgDevMem = DumpMemory::CopyHostToDevice(protoMsg.c_str(), static_cast<uint64_t>(protoSize));
    if (protoMsgDevMem == nullptr) {
        IDE_LOGE("Copy proto msg to device failed.");
        return ADUMP_FAILED;
    }
    DEVICE_RT_MEMORY_GUARD(protoMsgDevMem);

    void *protoMsgSizeDevMem = DumpMemory::CopyHostToDevice(&protoSize, static_cast<uint64_t>(sizeof(size_t)));
    if (protoMsgSizeDevMem == nullptr) {
        IDE_LOGE("Copy proto msg size to device failed.");
        return ADUMP_FAILED;
    }
    DEVICE_RT_MEMORY_GUARD(protoMsgSizeDevMem);

    return LaunchDumpKernal(protoMsgDevMem, protoMsgSizeDevMem);
}

int32_t OperatorDumper::LaunchDumpKernal(const void *const protoMsgDevMem, const void *const protoMsgSizeDevMem) const
{
    constexpr uint32_t ioAddrNum = 2U;
    constexpr uint32_t argSize = sizeof(aicpu::AicpuParamHead) + (ioAddrNum * sizeof(uint64_t));
    uint8_t args[argSize] = {};

    // fill head
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = argSize;
    paramHead->ioAddrNum = ioAddrNum;

    // fill body
    constexpr size_t protoMsgOffset = sizeof(aicpu::AicpuParamHead);
    constexpr size_t protoMsgSizeOffset = sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t);
    uint64_t protoMsgDevAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(protoMsgDevMem));
    uint64_t protoMsgSizeDevAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(protoMsgSizeDevMem));

    // use memcpy to avoid 'uint64_t type 8 byte alignment requires'
    const auto cpyMsg = memcpy_s(&args[protoMsgOffset], sizeof(uint64_t), &protoMsgDevAddr, sizeof(uint64_t));
    const auto cpySize = memcpy_s(&args[protoMsgSizeOffset], sizeof(uint64_t), &protoMsgSizeDevAddr, sizeof(uint64_t));
    IDE_CTRL_VALUE_FAILED(cpyMsg == EOK && cpySize == EOK, return ADUMP_FAILED, "Copy addr to args failed.");

    rtArgsEx_t argsInfo = {};
    argsInfo.args = reinterpret_cast<void *>(args);
    argsInfo.argsSize = argSize;
    // launch dump op
    rtError_t rtRet = rtCpuKernelLaunchWithFlag(nullptr, DUMP_KERNAL_OP_NAME, 1U, &argsInfo, nullptr, stream_, 0U);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtCpuKernelLaunchWithFlag failed, ret: 0x%X", rtRet);
        return ADUMP_FAILED;
    }

    rtRet = rtStreamSynchronize(stream_);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED, "rtStreamSynchronize failed, ret: 0x%X", rtRet);

    IDE_LOGI("Kernel launch dump op %s success", opName_.c_str());
    return ADUMP_SUCCESS;
}
} // namespace Adx
