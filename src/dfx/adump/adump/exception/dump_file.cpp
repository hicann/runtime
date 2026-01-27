/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_file.h"
#include <sstream>
#include "runtime/mem.h"
#include "sys_utils.h"
#include "dump_datatype.h"
#include "dump_memory.h"
#include "log/hdc_log.h"
#include "log/adx_log.h"
#include "adump_dsmi.h"
#include "dump_tensor_plugin.h"
#include "hccl_mc2_define.h"
#include "proto/dump_task.pb.h"

namespace Adx {
namespace {
constexpr char DUMP_FILE_VERSION[] = "2.0";
constexpr uint32_t MAX_DEV_NUM = 64;
}  // namespace

void DumpFile::SetHeader(const std::string &opName)
{
    header_.set_version(DUMP_FILE_VERSION);
    header_.set_dump_time(SysUtils::GetTimestamp());
    header_.set_op_name(opName);
}

void DumpFile::SetInputTensors(const std::vector<DumpTensor> &inputTensors)
{
    for (size_t i = 0U; i < inputTensors.size(); ++i) {
        const DumpTensor &tensor = inputTensors[i];
        if (tensor.GetAddress() == nullptr) {
            continue;
        }
        toolkit::dump::OpInput input;
        auto ir_data_type = DumpDataType::GetIrDataType(static_cast<GeDataType>(tensor.GetDataType()));
        input.set_data_type(static_cast<toolkit::dump::OutputDataType>(ir_data_type));
        input.set_format(static_cast<toolkit::dump::OutputFormat>(tensor.GetFormat()));
        std::vector<int64_t> shape = tensor.GetShape();
        for (auto dim : shape)
        {
            input.mutable_shape()->add_dim(static_cast<uint64_t>(dim));
        }
        uint64_t size = static_cast<uint64_t>(tensor.GetSize());
        input.set_size(size);
        input.set_arg_index(tensor.GetArgsOffSet());
        input.set_input_type(static_cast<uint32_t>(DfxTensorType::INPUT_TENSOR));
        IDE_LOGI("[Set][DumpData] The input size exception is %llu bytes.", size);
        header_.mutable_input()->Add(std::move(input));

        inputs_.emplace_back(tensor.GetAddress(), size);
    }
}

void DumpFile::SetOutputTensors(const std::vector<DumpTensor> &outputTensors)
{
    for (size_t i = 0U; i < outputTensors.size(); ++i) {
        const DumpTensor &tensor = outputTensors[i];
        if (tensor.GetAddress() == nullptr) {
            continue;
        }
        toolkit::dump::OpOutput output;
        auto ir_data_type = DumpDataType::GetIrDataType(static_cast<GeDataType>(tensor.GetDataType()));
        output.set_data_type(static_cast<toolkit::dump::OutputDataType>(ir_data_type));
        output.set_format(static_cast<toolkit::dump::OutputFormat>(tensor.GetFormat()));
        std::vector<int64_t> shape = tensor.GetShape();
        for (auto dim : shape) {
            output.mutable_shape()->add_dim(static_cast<uint64_t>(dim));
        }
        uint64_t size = static_cast<uint64_t>(tensor.GetSize());
        output.set_size(size);
        output.set_arg_index(tensor.GetArgsOffSet());
        IDE_LOGI("[Set][DumpData] The output size exception is %llu bytes.", size);
        header_.mutable_output()->Add(std::move(output));

        outputs_.emplace_back(tensor.GetAddress(), size);
    }
}

void DumpFile::SetWorkspaces(const std::vector<DumpWorkspace> &workspaces)
{
    IDE_LOGI("[Set][DumpData] Workspace size is %zu bytes", workspaces.size());
    for (size_t i = 0U; i < workspaces.size(); ++i) {
        if (workspaces[i].addr == nullptr) {
            continue;
        }
        toolkit::dump::Workspace workspace;
        workspace.set_size(workspaces[i].bytes);
        workspace.set_arg_index(workspaces[i].argsOffset);
        IDE_LOGI("[Set][DumpData] The workspace size exception is %llu bytes.", workspaces[i].bytes);
        workspace.set_type(toolkit::dump::Workspace::LOG);
        header_.mutable_space()->Add(std::move(workspace));

        workspaces_.emplace_back(workspaces[i].addr, workspaces[i].bytes);
    }
}

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
void DumpFile::SetMc2spaces(const std::vector<DumpWorkspace> &mc2Spaces)
{
    IDE_LOGI("[Set][DumpData] mc2 space size is %zu", mc2Spaces.size());
    for (size_t i = 0U; i < mc2Spaces.size(); ++i) {
        if (mc2Spaces[i].addr == nullptr) {
            continue;
        }
        uint64_t opParamSize = 0;
        uint64_t newSize = GetMc2DataSize(mc2Spaces[i].addr, i, opParamSize);
        if (opParamSize == 0 || newSize == 0) {
            continue;
        }
        toolkit::dump::Workspace workspace;
        workspace.set_size(newSize);
        workspace.set_arg_index(mc2Spaces[i].argsOffset);
        workspace.set_type(toolkit::dump::Workspace::LOG);
        header_.mutable_space()->Add(std::move(workspace));
        IDE_LOGI("[Set][DumpData] The mc2 space size exception is %llu bytes.", newSize);

        mc2Spaces_.emplace_back(mc2Spaces[i].addr, opParamSize);
    }
}
#endif

void DumpFile::SetInputBuffer(const std::vector<InputBuffer> input)
{
    IDE_LOGI("[Set][DumpData] input buffer size is %zu", input.size());
    for (size_t i = 0U; i < input.size(); ++i) {
        if (input[i].addr == nullptr) {
            if (input[i].length != 0) {
                std::ostringstream oss;
                oss << "[Dump][Exception] the address maybe invalid, addr info: " << input[i].addr << ";"
                    << input[i].length << ".";
                IDE_LOGE("%s", oss.str().c_str());
                logRecord_.emplace_back(oss.str() + "\n");
            }
            continue;
        }
        toolkit::dump::OpInput opInput;
        opInput.set_data_type(toolkit::dump::OutputDataType::DT_UNDEFINED);
        opInput.set_size(input[i].length);
        opInput.set_arg_index(input[i].argIndex);
        opInput.set_input_type(static_cast<uint32_t>(DfxTensorType::GENERAL_TENSOR));
        IDE_LOGI("[Set][DumpData] The input size exception is %llu", input[i].length);
        header_.mutable_input()->Add(std::move(opInput));

        inputBuffer_.emplace_back(input[i].addr, input[i].length);
    }
}

void DumpFile::SetTensorBuffer(const std::vector<TensorBuffer> &tensorBuffer)
{
    for (size_t i = 0U; i < tensorBuffer.size(); ++i) {
        if (tensorBuffer[i].addr == nullptr) {
            if (tensorBuffer[i].size != 0) {
                std::ostringstream oss;
                oss << "[Dump][Exception] the address maybe invalid, addr info: " << tensorBuffer[i].addr << ";"
                    << tensorBuffer[i].size << ".";
                IDE_LOGE("%s", oss.str().c_str());
                logRecord_.emplace_back(oss.str() + "\n");
            }
            continue;
        }
        if (tensorBuffer[i].tensorType <= DfxTensorType::INPUT_TENSOR) {
            toolkit::dump::OpInput input;
            input.set_data_type(toolkit::dump::OutputDataType::DT_UNDEFINED);
            uint64_t dimension = tensorBuffer[i].dimension;
            IDE_LOGI("[Set][DumpData] The input dim is %llu", dimension);
            for (uint64_t j = 0; j < dimension; ++j) {
                input.mutable_shape()->add_dim(tensorBuffer[i].shape[j]);
                IDE_LOGI("[Set][DumpData] The input shape is %llu", tensorBuffer[i].shape[j]);
            }
            uint64_t size = tensorBuffer[i].GetTotalByteSize();
            input.set_size(size);
            input.set_arg_index(tensorBuffer[i].argIndex);
            input.set_input_type(static_cast<uint32_t>(tensorBuffer[i].tensorType));
            IDE_LOGI("[Set][DumpData] The input size exception is %llu", size);
            header_.mutable_input()->Add(std::move(input));

            inputs_.emplace_back(tensorBuffer[i].addr, size);
        } else if (tensorBuffer[i].tensorType == DfxTensorType::OUTPUT_TENSOR ||
                   tensorBuffer[i].tensorType == DfxTensorType::SHAPE_TENSOR) {
            toolkit::dump::OpOutput output;
            output.set_data_type(toolkit::dump::OutputDataType::DT_UNDEFINED);
            uint64_t dimension = tensorBuffer[i].dimension;
            IDE_LOGI("[Set][DumpData] The output dim is %llu", dimension);
            for (uint64_t j = 0; j < dimension; ++j) {
                output.mutable_shape()->add_dim(tensorBuffer[i].shape[j]);
                IDE_LOGI("[Set][DumpData] The output shape is %llu", tensorBuffer[i].shape[j]);
            }
            uint64_t size = tensorBuffer[i].GetTotalByteSize();
            output.set_size(size);
            output.set_arg_index(tensorBuffer[i].argIndex);
            IDE_LOGI("[Set][DumpData] The output size exception is %llu", size);
            header_.mutable_output()->Add(std::move(output));

            outputs_.emplace_back(tensorBuffer[i].addr, size);
        } else if (tensorBuffer[i].tensorType == DfxTensorType::TILING_DATA) {
            toolkit::dump::OpInput input;
            input.set_data_type(toolkit::dump::OutputDataType::DT_UNDEFINED);
            uint64_t size = tensorBuffer[i].GetTotalByteSize();
            input.set_size(size);
            input.set_arg_index(tensorBuffer[i].argIndex);
            input.set_input_type(static_cast<uint32_t>(tensorBuffer[i].tensorType));
            IDE_LOGI("[Set][DumpData] The tiling size exception is %llu", size);
            header_.mutable_input()->Add(std::move(input));

            inputs_.emplace_back(tensorBuffer[i].addr, size);
        }
    }
}

int32_t DumpFile::Dump(std::vector<std::string> &record)
{
    int32_t ret = file_.IsFileOpen();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    SetAicInfo(record);

    ret = WriteHeader();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    ret = WriteInputTensors();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    ret = WriteOutputTensors();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    ret = WriteWorkspace();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    ret = WriteMc2Space();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    ret = WriteInputBuffer();
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }
    return ADUMP_SUCCESS;
}

void DumpFile::SetAicInfo(std::vector<std::string> &record)
{
    IDE_LOGI("[Set][DumpData] Start to set aic info");
    std::ostringstream oss;
    for (const auto &str : record) {
        oss << str;
    }
    for (const auto &str : logRecord_) {
        oss << str;
    }
    header_.set_dfx_message(oss.str());
    record.clear();
    logRecord_.clear();
}

int32_t DumpFile::WriteHeader() const
{
    std::string protoHeader;
    uint64_t protoHeaderSize = header_.ByteSizeLong();
    const bool pbRet = header_.SerializeToString(&protoHeader);
    if ((!pbRet) || (protoHeaderSize == 0U)) {
        IDE_LOGE("Serialize dump header proto msg failed, size is %lu", protoHeaderSize);
        return ADUMP_FAILED;
    }

    int64_t ret = file_.Write(reinterpret_cast<char *>(&protoHeaderSize), sizeof(protoHeaderSize));
    if (ret == EN_ERROR || ret == EN_INVALID_PARAM) {
        IDE_LOGE("Write header proto msg size to dump file failed, ret: %ld", ret);
        return ADUMP_FAILED;
    }

    ret = file_.Write(protoHeader.c_str(), protoHeaderSize);
    if (ret == EN_ERROR || ret == EN_INVALID_PARAM) {
        IDE_LOGE("Write header proto msg to dump file failed, ret: %ld", ret);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteInputTensors()
{
    IDE_LOGI("[Dump][ExceptionInput] Start to dump exception input");
    for (size_t i = 0U; i < inputs_.size(); ++i) {
        const auto ret = WriteDeviceDataToFile(inputs_[i]);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("[Dump][ExceptionInput] Dump %zu input device data failed.", i);
            return ADUMP_FAILED;
        }
    }
    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteOutputTensors()
{
    IDE_LOGI("[Dump][ExceptionOutput] Start to dump exception output");
    for (size_t i = 0U; i < outputs_.size(); ++i) {
        const auto ret = WriteDeviceDataToFile(outputs_[i]);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("[Dump][ExceptionOutput] Dump %zu output device data failed.", i);
            return ADUMP_FAILED;
        }
    }
    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteWorkspace()
{
    IDE_LOGI("[Dump][ExceptionWorkspace] Start to dump exception workspace");
    for (size_t i = 0U; i < workspaces_.size(); ++i) {
        const auto ret = WriteDeviceDataToFile(workspaces_[i]);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("[Dump][ExceptionWorkspace] Dump %zu workspace failed.", i);
            return ADUMP_FAILED;
        }
    }
    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteMc2Space() const
{
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    IDE_LOGI("[Dump][ExceptionMc2Space] Start to dump exception mc2 space on device %u.", deviceId_);
    for (size_t idx = 0U; idx < mc2Spaces_.size(); ++idx) {
        auto ret = WriteDeviceDataToFile(mc2Spaces_[idx]);
        IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
            "[Dump][ExceptionWorkspace] Dump %zu workspace failed.", idx);

        auto it = mc2Ctx_.find(idx);
        if (it != mc2Ctx_.end()) {
            for (const DeviceData &devData : it->second) {
                ret = WriteDeviceDataToFile(devData);
            }
        }
    }
#endif
    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteInputBuffer()
{
    IDE_LOGI("[Dump][ExceptionWorkspace] Start to dump exception args");
    for (size_t i = 0U; i < inputBuffer_.size(); ++i) {
        const auto ret = WriteDeviceDataToFile(inputBuffer_[i]);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("[Dump][ExceptionOutput] Dump %zu input args failed.", i);
            return ADUMP_FAILED;
        }
    }
    return ADUMP_SUCCESS;
}

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
uint64_t DumpFile::ComputeStructSize() const
{
    constexpr uint32_t socVersionLength = 128U;
    char socVersion[socVersionLength] = {0};
    rtError_t ret = rtGetSocVersion(socVersion, socVersionLength);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("[Dump][ExceptionWorkspace] Get soc version failed, ret = %d", ret);
        return 0;
    }
    IDE_LOGI("Get socVersion: %s", socVersion);
    if (std::string(socVersion).find("Ascend910_93") != std::string::npos) {
        return sizeof(HcclOpResParam);
    } else {
        return sizeof(HcclCombinOpParam);
    }
}

void DumpFile::HandleMc2CtxV1(const void *hostData, uint64_t &totalSize, std::vector<DeviceData> &dataList) const
{
    const HcclCombinOpParam *param = static_cast<const HcclCombinOpParam *>(hostData);
    dataList.emplace_back(reinterpret_cast<const void*>(param->mc2WorkSpace.workSpace),
                          param->mc2WorkSpace.workSpaceSize);
    totalSize += param->mc2WorkSpace.workSpaceSize;
    IDE_LOGI("[Dump][Exception] MC2 workspace addr 0x%llx and size %llu bytes, rankId %u",
        param->mc2WorkSpace.workSpace, param->mc2WorkSpace.workSpaceSize, param->rankId);

    if (param->rankId < RANK_NUM) {
        dataList.emplace_back(reinterpret_cast<const void*>(param->windowsIn[param->rankId]), param->winSize);
        dataList.emplace_back(reinterpret_cast<const void*>(param->windowsOut[param->rankId]), param->winSize);
        IDE_LOGI("[Dump][Exception] MC2 winSize %llu bytes, windowsIn addr 0x%llx, windowsOut addr 0x%llx",
            param->winSize, param->windowsIn[param->rankId], param->windowsOut[param->rankId]);
    } else {
        dataList.emplace_back(nullptr, param->winSize);     // windowsIn 占位
        dataList.emplace_back(nullptr, param->winSize);     // windowsOut 占位
        IDE_LOGW("[Dump][Exception] MC2 winSize %llu bytes, rankId is invalid, max rankId %u", RANK_NUM);
    }
    totalSize += param->winSize + param->winSize;

    const void *deviceDataPtr = reinterpret_cast<const void*>(param->ibverbsData);
    dataList.emplace_back(deviceDataPtr, param->ibverbsDataSize);
    totalSize += param->ibverbsDataSize;

    if (param->rankId >= param->ibverbsDataSize / sizeof(IbVerbsData)) {
        IDE_LOGW("[Dump][Exception] MC2 ibverbsData size %llu bytes, rankId out of range", param->ibverbsDataSize);
        return;
    }

    int32_t ret = DumpMemory::CheckDeviceMemory(deviceId_, deviceDataPtr);
    if (ret == ADUMP_SUCCESS) {
        void *hostDataPtr = DumpMemory::CopyDeviceToHost(deviceDataPtr, param->ibverbsDataSize);
        if (hostDataPtr != nullptr) {
            IbVerbsData *ibverbsData = static_cast<IbVerbsData *>(hostDataPtr);
            dataList.emplace_back(reinterpret_cast<const void*>(ibverbsData[param->rankId].localInput.addr),
                ibverbsData[param->rankId].localInput.size);
            dataList.emplace_back(reinterpret_cast<const void*>(ibverbsData[param->rankId].localOutput.addr),
                ibverbsData[param->rankId].localOutput.size);
            totalSize += ibverbsData[param->rankId].localInput.size + ibverbsData[param->rankId].localOutput.size;
            IDE_LOGI("[Dump][Exception] MC2 ibverbsData localInput addr 0x%llx and size %llu bytes, "
                        "localOutput addr 0x%llx and size %llu bytes",
                ibverbsData[param->rankId].localInput.addr, ibverbsData[param->rankId].localInput.size,
                ibverbsData[param->rankId].localOutput.addr, ibverbsData[param->rankId].localOutput.size);
            DumpMemory::FreeHost(hostDataPtr);
        }
    }
}

uint64_t DumpFile::HandleMc2Ctx(const void *hostData, uint64_t opParamSize, size_t index)
{
    std::vector<DeviceData> dataList;
    uint64_t totalSize = opParamSize;
    if (opParamSize == sizeof(HcclOpResParam)) {
        const HcclOpResParam *param = static_cast<const HcclOpResParam *>(hostData);
        dataList.emplace_back(reinterpret_cast<const void*>(param->mc2WorkSpace.workSpace),
            param->mc2WorkSpace.workSpaceSize);
        dataList.emplace_back(reinterpret_cast<const void*>(param->localWindowsExp), param->winExpSize);
        totalSize += param->mc2WorkSpace.workSpaceSize + param->winExpSize;
        IDE_LOGI("[Dump][Exception] MC2 workspace addr 0x%llx and size %llu bytes, windowsExp addr 0x%llx and "
                 "size %llu bytes",
            param->mc2WorkSpace.workSpace, param->mc2WorkSpace.workSpaceSize,
            param->localWindowsExp, param->winExpSize);
    } else {
        HandleMc2CtxV1(hostData, totalSize, dataList);
    }
    mc2Ctx_.emplace(index, dataList);
    return totalSize;
}

uint64_t DumpFile::GetMc2DataSize(const void *addr, size_t index, uint64_t &opParamSize)
{
    if (addr == nullptr) {
        IDE_LOGW("The addr from index %zu is nullptr, nothing need to do.", index);
        return 0;
    }
    void *hostData = nullptr;
    opParamSize = ComputeStructSize();
    if (opParamSize == 0) {
        IDE_LOGE("[Dump][Exception] Get struct size failed, size is 0.");
        return 0;
    }

    int32_t ret = DumpMemory::CheckDeviceMemory(deviceId_, addr);
    if (ret != ADUMP_SUCCESS) {
        return 0;
    } else {
        hostData = DumpMemory::CopyDeviceToHost(addr, opParamSize);
        if (hostData == nullptr) {
            IDE_LOGE("[Dump][Exception] the address maybe invalid, D2H failed, addr info: %p;%llu.", addr, opParamSize);
            return 0;
        }
    }
    HOST_RT_MEMORY_GUARD(hostData);

    uint64_t totalSize = HandleMc2Ctx(hostData, opParamSize, index);

    return totalSize;
}
#endif

void DumpFile::LogIsOtherDeviceAddress(const DeviceData &devData, rtMemInfo_t &memInfo) const
{
    uint32_t devNum = AdumpDsmi::DrvGetDevNum();
    if (devNum == 0) {
        IDE_LOGE("[Dump][Exception] DrvGetDevNum failed");
        return;
    }

    uint32_t length = MAX_DEV_NUM;
    std::vector<uint32_t> deviceIds(length, 0);
    if (!AdumpDsmi::DrvGetDevIds(length, deviceIds)) {
        IDE_LOGE("[Dump][Exception] DrvGetDevIds failed, length: %u", length);
        return;
    }

    for (size_t i = 0; i < devNum; ++i) {
        if (deviceIds[i] == deviceId_) {
            continue;
        }
        rtError_t ret = rtMemGetInfoByType(deviceIds[i], RT_MEM_INFO_TYPE_ADDR_CHECK, &memInfo);
        if ((ret == RT_ERROR_NONE) && (memInfo.addrInfo.flag == true)) {
            IDE_LOGE("[Dump][Exception] the address[%p] is the valid address of device[%d]", devData.addr,
                     deviceIds[i]);
            return;
        }
    }
}

int32_t DumpFile::AllocDefaultMemory(void **hostPtr, uint64_t size) const
{
    rtError_t rtRet = rtMallocHost(hostPtr, size, static_cast<uint16_t>(IDEDD));
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMallocHost failed, size: %lu, ret: 0x%X", size, rtRet);
        return ADUMP_FAILED;
    }
    errno_t ret = memset_s(*hostPtr, size, 0, size);
    if (ret != EOK) {
        IDE_LOGE("Call memset_s failed, ret: %d", ret);
        DumpMemory::FreeHost(*hostPtr);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpFile::WriteDeviceDataToFile(const DeviceData &devData) const
{
    if (devData.bytes == 0) {
        IDE_LOGW("Skip dump addr %p because size is 0", devData.addr);
        return ADUMP_SUCCESS;
    }

    void *hostData = nullptr;

    rtMemInfo_t memInfo{};
    uint64_t *deviceAddr[1] = {static_cast<uint64_t *>(const_cast<void *>(devData.addr))};
    memInfo.addrInfo.addr = static_cast<uint64_t **>(deviceAddr);
    memInfo.addrInfo.cnt = 1;
    memInfo.addrInfo.memType = RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_RSVD_TYPE;
    memInfo.addrInfo.flag = true;
    rtError_t err = rtMemGetInfoByType(deviceId_, RT_MEM_INFO_TYPE_ADDR_CHECK, &memInfo);
    if ((err != RT_ERROR_NONE) || (memInfo.addrInfo.flag == false)) {
        IDE_LOGE("[Dump][Exception] the address maybe invalid, check addr info failed, error code: %d, check flag: %u, "
                 "addr info: %p;%llu.",
                 static_cast<int32_t>(err), memInfo.addrInfo.flag, devData.addr, devData.bytes);
        LogIsOtherDeviceAddress(devData, memInfo);
        if (AllocDefaultMemory(&hostData, devData.bytes) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
    } else {
        hostData = DumpMemory::CopyDeviceToHost(devData.addr, devData.bytes);
        if (hostData == nullptr) {
            IDE_LOGE("[Dump][Exception] the address maybe invalid, D2H failed, addr info: %p;%llu.", devData.addr,
                     devData.bytes);
            if (AllocDefaultMemory(&hostData, devData.bytes) != ADUMP_SUCCESS) {
                return ADUMP_FAILED;
            }
        }
    }

    HOST_RT_MEMORY_GUARD(hostData);

    const int64_t ret = file_.Write(reinterpret_cast<char *>(hostData), devData.bytes);
    if (ret == EN_ERROR || ret == EN_INVALID_PARAM) {
        IDE_LOGE("Write data to dump file failed, ret: %ld", ret);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}
}  // namespace Adx