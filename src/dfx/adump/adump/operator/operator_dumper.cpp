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
// Dump开关的device内存
void *g_devMemDumpSwitch{nullptr};
// 静态图下发Dump算子proto的device内存
std::vector<void *> g_devMemProtoInfo;
constexpr uint32_t DUMP_SWITCH_DUMP_TENSOR = 0x1U;
constexpr uint32_t DUMP_SWITCH_DUMP_STATS = 0x2U;
constexpr uint32_t DUMP_SWITCH_DUMP_OVERFLOW = 0x4U;
} // namespace

OperatorDumper::OperatorDumper(const std::string &opType, const std::string &opName)
    : opType_(opType), opName_(opName), stream_(nullptr)
{
}

OperatorDumper::OperatorDumper(const DumpSetting &setting)
    : setting_(setting)
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

int32_t OperatorDumper::InitDevMemDumpSwitch()
{
    if (g_devMemDumpSwitch == nullptr) {
        uint64_t dumpSwitchSize = static_cast<uint64_t>(sizeof(uint64_t));
        uint16_t moduleId = static_cast<uint16_t>(IDEDD);
        rtError_t rtRet = rtMalloc(&g_devMemDumpSwitch, dumpSwitchSize, RT_MEMORY_HBM, moduleId);
        IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED,
            "rtMalloc for dump switch on device failed! ret: 0x%X", rtRet);
        IDE_LOGI("rtMalloc for dump switch on device success. addr: %p, size: %lu",
            g_devMemDumpSwitch, dumpSwitchSize);

        if (SetDevMemDumpSwitch() != ADUMP_SUCCESS) {
            IDE_LOGE("Init to set dump switch on device failed!");
            DumpMemory::FreeDevice(g_devMemDumpSwitch);
            return ADUMP_FAILED;
        }
    }
    return ADUMP_SUCCESS;
}

int32_t OperatorDumper::SetDevMemDumpSwitch()
{
    if (g_devMemDumpSwitch != nullptr) {
        uint64_t dumpSwitch = GetDevMemDumpSwitch();
        uint64_t dumpSwitchSize = static_cast<uint64_t>(sizeof(uint64_t));
        rtError_t rtRet = rtMemcpy(
            g_devMemDumpSwitch, dumpSwitchSize, &dumpSwitch, dumpSwitchSize, RT_MEMCPY_HOST_TO_DEVICE);
        IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED,
            "rtMemcpy for dump switch on device failed! ret: 0x%X", rtRet);
        IDE_LOGI("Set dump switch on device success. addr: %p, dump switch: %lu", g_devMemDumpSwitch, dumpSwitch);
    }
    return ADUMP_SUCCESS;
}

uint64_t OperatorDumper::GetDevMemDumpSwitch()
{
    uint64_t dumpSwitch = 0;
    if (setting_.GetDumpStatusEx()) {
        dumpSwitch |= (setting_.IsDumpDataStats()) ? DUMP_SWITCH_DUMP_STATS : DUMP_SWITCH_DUMP_TENSOR;
    }
    if (setting_.GetDumpDebugStatus()) {
        dumpSwitch |= DUMP_SWITCH_DUMP_OVERFLOW;
        if (!setting_.GetDumpStatusEx()) {
            // 默认tensor的溢出检测
            dumpSwitch |= DUMP_SWITCH_DUMP_TENSOR;
        }
    }
    return dumpSwitch;
}

void OperatorDumper::FreeDevMemProtoCache()
{
    for (void* devMemPtr : g_devMemProtoInfo) {
        DumpMemory::FreeDevice(devMemPtr);
    }
    g_devMemProtoInfo.clear();
    IDE_LOGI("Free all proto messages on device success.");
}

int32_t OperatorDumper::UpdateDevMemCache()
{
    FreeDevMemProtoCache();
    return SetDevMemDumpSwitch();
}

void OperatorDumper::FreeDevMemCache()
{
    if (g_devMemDumpSwitch != nullptr) {
        DumpMemory::FreeDevice(g_devMemDumpSwitch);
        IDE_LOGI("Free the dump switch on device success.");
    }
    FreeDevMemProtoCache();
}

OperatorDumper &OperatorDumper::RuntimeStream(aclrtStream stream)
{
    stream_ = stream;
    return *this;
}

int32_t OperatorDumper::Launch()
{
    IDE_LOGI("Start to launch dump with cfg for op %s[%s], inputSize(%zu), outputSize(%zu).",
        opName_.c_str(), opType_.c_str(), inputTensors_.size(), outputTensors_.size());

    IDE_CTRL_VALUE_FAILED(FillOpMappingInfo() == ADUMP_SUCCESS, return ADUMP_FAILED,
    "Fill op mapping info failed!");

    IDE_CTRL_VALUE_FAILED(LaunchDumpKernel() == ADUMP_SUCCESS,
        return ADUMP_FAILED, "Launch dump kernal failed!");
    return ADUMP_SUCCESS;
}

int32_t OperatorDumper::LaunchWithCfg(const DumpCfg &dumpCfg)
{
    IDE_LOGI("Start to launch dump with cfg for op %s[%s], inputSize(%zu), outputSize(%zu).",
        opName_.c_str(), opType_.c_str(), inputTensors_.size(), outputTensors_.size());

    IDE_CTRL_VALUE_FAILED(InitDevMemDumpSwitch() == ADUMP_SUCCESS, return ADUMP_FAILED,
        "Init dump switch on device failed!");

    IDE_CTRL_VALUE_FAILED(FillOpMappingInfo() == ADUMP_SUCCESS, return ADUMP_FAILED,
        "Fill op mapping info failed!");

    // 默认按静态图处理，下发算子后不执行同步流操作
    bool synchronize = false;
    FillOpMappingInfoWithCfg(dumpCfg, synchronize);

    IDE_CTRL_VALUE_FAILED(LaunchDumpKernel(synchronize) == ADUMP_SUCCESS, return ADUMP_FAILED,
        "Launch dump kernal with cfg failed!");
    return ADUMP_SUCCESS;
}

void OperatorDumper::FillOpMappingInfoWithCfg(const DumpCfg &dumpCfg, bool &synchronize)
{
    for (size_t i = 0; i < dumpCfg.numAttrs; ++i) {
        DumpAttr* attr = &(dumpCfg.attrs[i]);
        switch (attr->id) {
            case DUMP_ATTR_MODEL_NAME:
                if (attr->value.modelName != nullptr) {
                    opMappingInfo_.set_model_name(std::string(attr->value.modelName));
                    IDE_LOGD("Fill opMapping model_name: %s", attr->value.modelName);
                }
                break;
            case DUMP_ATTR_MODEL_ID:
                opMappingInfo_.set_model_id(attr->value.modelId);
                IDE_LOGD("Fill opMapping model_id: %u", attr->value.modelId);
                break;
            case DUMP_ATTR_STEP_ID_ADDR:
                if (attr->value.stepIdAddr != 0U) {
                    opMappingInfo_.set_step_id_addr(attr->value.stepIdAddr);
                    IDE_LOGD("Fill opMapping step_id_add: 0x%llx", attr->value.stepIdAddr);
                }
                break;
            case DUMP_ATTR_ITER_PER_LOOP_ADDR:
                if (attr->value.iterPerLoopAddr != 0U) {
                    opMappingInfo_.set_iterations_per_loop_addr(attr->value.iterPerLoopAddr);
                    IDE_LOGD("Fill opMapping iterations_per_loop_addr: 0x%llx", attr->value.iterPerLoopAddr);
                }
                break;
            case DUMP_ATTR_LOOP_COND_ADDR:
                if (attr->value.loopCondAddr != 0U) {
                    opMappingInfo_.set_loop_cond_addr(attr->value.loopCondAddr);
                    IDE_LOGD("Fill opMapping loop_cond_addr: 0x%llx", attr->value.loopCondAddr);
                }
                break;
            case DUMP_ATTR_DUMP_STEP:
                if (attr->value.dumpStep != nullptr) {
                    opMappingInfo_.set_dump_step(std::string(attr->value.dumpStep));
                    IDE_LOGD("Fill opMapping dump_step: %s", attr->value.dumpStep);
                }
                break;
            case DUMP_ATTR_STREAM_MODEL:
                // 0：静态图，不执行同步流
                synchronize = attr->value.streamModel == 0U ? false : true;
                IDE_LOGD("to synchronize stream: %d", synchronize);
                break;
            default:
                IDE_LOGD("not support attr id: %d", attr->id);
                break;
        }
    }
    IDE_LOGD("dump_switch_addr: 0x%llx", static_cast<uint64_t>(reinterpret_cast<uintptr_t>(g_devMemDumpSwitch)));
    opMappingInfo_.set_dump_switch_addr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(g_devMemDumpSwitch)));
}

int32_t OperatorDumper::FillOpMappingInfo()
{
    // Set default
    opMappingInfo_.clear_task();
    opMappingInfo_.set_flag(AI_CPU_LOAD_FLAG);
    if (setting_.IsDumpDataStats()) {
        opMappingInfo_.set_dump_data(toolkitV2::aicpu::dump::DumpData::STATS_DUMP_DATA);
    } else {
        opMappingInfo_.set_dump_data(toolkitV2::aicpu::dump::DumpData::TENSOR_DUMP_DATA);
    }

    int32_t deviceId = 0;
    rtError_t rtRet = rtGetDevice(&deviceId);
    if (rtRet != RT_ERROR_NONE || deviceId < 0) {
        IDE_LOGE("rtGetDevice failed, ret 0x%X, devId: %d", rtRet, deviceId);
        return ADUMP_FAILED;
    }

    IDE_CTRL_VALUE_FAILED(FillDumpPath(deviceId) == ADUMP_SUCCESS, return ADUMP_FAILED, "Fill dump path failed!");

    IDE_CTRL_VALUE_FAILED(FillDumpTask(deviceId) == ADUMP_SUCCESS, return ADUMP_FAILED, "Fill dump task failed!");
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
    toolkitV2::aicpu::dump::Task task;
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

toolkitV2::aicpu::dump::AddressType OperatorDumper::ConvertAddressType(const DumpTensor &dumpTensor)
{
    AddressType addressType = dumpTensor.GetAddressType();
    if (addressType == AddressType::NOTILING) {
        return toolkitV2::aicpu::dump::AddressType::NOTILING_ADDR;
    } else if (addressType == AddressType::RAW) {
        return toolkitV2::aicpu::dump::AddressType::RAW_ADDR;
    } else {
        return toolkitV2::aicpu::dump::AddressType::TRADITIONAL_ADDR;
    }
}

void OperatorDumper::DumpInput(toolkitV2::aicpu::dump::Task &task)
{
    for (const auto &dumpTensor : inputTensors_) {
        toolkitV2::aicpu::dump::Input input;
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
        input.set_addr_type(ConvertAddressType(dumpTensor));
        task.mutable_input()->Add(std::move(input));
    }
}

void OperatorDumper::DumpOutput(toolkitV2::aicpu::dump::Task &task)
{
    for (const auto &dumpTensor : outputTensors_) {
        toolkitV2::aicpu::dump::Output output;
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
        output.set_addr_type(ConvertAddressType(dumpTensor));
        task.mutable_output()->Add(std::move(output));
    }
}

int32_t OperatorDumper::LaunchDumpKernel(bool synchronize) const
{
    std::string protoMsg;
    const size_t protoSize = opMappingInfo_.ByteSizeLong();
    const bool bRet = opMappingInfo_.SerializeToString(&protoMsg);
    if ((!bRet) || (protoSize == 0U)) {
        IDE_LOGE("Serialize proto msg failed, size is %zu", protoSize);
        return ADUMP_FAILED;
    }

    void *protoMsgDevMem = DumpMemory::CopyHostToDevice(protoMsg.c_str(), static_cast<uint64_t>(protoSize));
    IDE_CTRL_VALUE_FAILED(protoMsgDevMem != nullptr, return ADUMP_FAILED,
        "Copy proto msg to device failed! size: %zu", protoSize);

    void *protoMsgSizeDevMem = DumpMemory::CopyHostToDevice(&protoSize, static_cast<uint64_t>(sizeof(size_t)));
    if (protoMsgSizeDevMem == nullptr) {
        DumpMemory::FreeDevice(protoMsgDevMem);
        IDE_LOGE("Copy proto msg size to device failed! size: %zu", protoSize);
        return ADUMP_FAILED;
    }
    int32_t ret = LaunchDumpKernel(protoMsgDevMem, protoMsgSizeDevMem, synchronize);
    if (synchronize) {
        DumpMemory::FreeDevice(protoMsgDevMem);
        DumpMemory::FreeDevice(protoMsgSizeDevMem);
    } else {
        g_devMemProtoInfo.push_back(protoMsgDevMem);
        g_devMemProtoInfo.push_back(protoMsgSizeDevMem);
    }
    return ret;
}

int32_t OperatorDumper::LaunchDumpKernel(const void *const protoMsgDevMem,
    const void *const protoMsgSizeDevMem, bool synchronize) const
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
    if (cpyMsg != EOK) {
        IDE_LOGE("Copy addr to args failed");
        return ADUMP_FAILED;
    }
    const auto cpySize = memcpy_s(&args[protoMsgSizeOffset], sizeof(uint64_t), &protoMsgSizeDevAddr, sizeof(uint64_t));
    if (cpySize != EOK) {
        IDE_LOGE("Copy addr to args failed");
        return ADUMP_FAILED;
    }

    rtArgsEx_t argsInfo = {};
    argsInfo.args = reinterpret_cast<void *>(args);
    argsInfo.argsSize = argSize;
    // launch dump op
    rtError_t rtRet = rtCpuKernelLaunchWithFlag(nullptr, DUMP_KERNAL_OP_NAME, 1U, &argsInfo, nullptr, stream_, 0U);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtCpuKernelLaunchWithFlag failed, ret: 0x%X", rtRet);
        return ADUMP_FAILED;
    }

    if (synchronize) {
        rtRet = rtStreamSynchronize(stream_);
        IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED,
            "rtStreamSynchronize failed, ret: 0x%X", rtRet);
    }

    IDE_LOGI("Kernel launch dump op %s success", opName_.c_str());
    return ADUMP_SUCCESS;
}
} // namespace Adx
