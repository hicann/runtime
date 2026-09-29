/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "data_dump_writer.hpp"

#include <algorithm>
#include <cerrno>
#include <cmath>
#include <cstdio>
#include <fstream>
#include <limits>
#include <new>
#include <sstream>
#include <string>
#include <sys/stat.h>
#include <sys/time.h>
#include <vector>

#include "securec.h"
#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"
#include "aicpu_sched/common/type_def.h"
#include "aicpu_sched/extern_include/metadef_types.h"
#include "data_dump_tlv.hpp"

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {
namespace {

constexpr mode_t DUMP_DIRECTORY_MODE = static_cast<mode_t>(0750);
constexpr size_t MAX_DUMP_FILE_NAME_LENGTH = 220U;
constexpr uint64_t MICROSECONDS_PER_SECOND = 1000000U;
constexpr uint16_t FLOAT16_SIGN_MASK = 0x8000U;
constexpr uint16_t FLOAT16_EXPONENT_MASK = 0x7C00U;
constexpr uint16_t FLOAT16_MANTISSA_MASK = 0x03FFU;
constexpr uint32_t FLOAT16_HIDDEN_BIT = 0x400U;
constexpr uint32_t FLOAT16_TO_FLOAT_SIGN_SHIFT = 16U;
constexpr uint32_t FLOAT16_TO_FLOAT_VALUE_SHIFT = 13U;
constexpr uint32_t FLOAT16_TO_FLOAT_INF_NAN_EXPONENT = 0x3FC00U;
constexpr uint32_t FLOAT16_TO_FLOAT_EXPONENT_BIAS = 0x1C000U;
constexpr uint32_t FLOAT16_TO_FLOAT_SUBNORMAL_EXPONENT = 0x1C400U;
constexpr char STATS_FILE_SUFFIX[] = ".csv";
constexpr char STATS_HEADER[] =
    "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,"
    "Negative Inf Count,Positive Inf Count\n";
constexpr char EMPTY_STATISTICS[] = ",,,,,,";

const char* const DATA_TYPE_NAMES[] = {
    "DT_FLOAT",         "DT_FLOAT16",        "DT_INT8",      "DT_INT32",      "DT_UINT8",  "-",         "DT_INT16",
    "DT_UINT16",        "DT_UINT32",         "DT_INT64",     "DT_UINT64",     "DT_DOUBLE", "DT_BOOL",   "DT_STRING",
    "DT_DUAL_SUB_INT8", "DT_DUAL_SUB_UINT8", "DT_COMPLEX64", "DT_COMPLEX128", "DT_QINT8",  "DT_QINT16", "DT_QINT32",
    "DT_QUINT8",        "DT_QUINT16",        "DT_RESOURCE",  "DT_STRING_REF",
};

const char* const FORMAT_NAMES[] = {
    "NCHW",
    "NHWC",
    "ND",
    "NC1HWC0",
    "FRACTAL_Z",
    "NC1C0HWPAD",
    "NHWC1C0",
    "FSR_NCHW",
    "FRACTAL_DECONV",
    "C1HWNC0",
    "FRACTAL_DECONV_TRANSPOSE",
    "FRACTAL_DECONV_SP_STRIDE_TRANS",
    "NC1HWC0_C04",
    "FRACTAL_Z_C04",
    "CHWN",
    "FRACTAL_DECONV_SP_STRIDE8_TRANS",
    "HWCN",
    "NC1KHKWHWC0",
    "BN_WEIGHT",
    "FILTER_HWCK",
    "HASHTABLE_LOOKUP_LOOKUPS",
    "HASHTABLE_LOOKUP_KEYS",
    "HASHTABLE_LOOKUP_VALUE",
    "HASHTABLE_LOOKUP_OUTPUT",
    "HASHTABLE_LOOKUP_HITS",
    "C1HWNCoC0",
    "MD",
    "NDHWC",
    "FRACTAL_ZZ",
    "FRACTAL_NZ",
    "NCDHW",
    "DHWCN",
    "NDC1HWC0",
    "FRACTAL_Z_3D",
    "CN",
    "NC",
    "DHWNC",
    "FRACTAL_Z_3D_TRANSPOSE",
    "FRACTAL_ZN_LSTM",
    "FRACTAL_Z_G",
    "RESERVED",
};

struct OpDataView {
    std::vector<const uint8_t*> inputBaseAddrList;
    std::vector<const uint8_t*> outputBaseAddrList;
};

bool NeedInput(const DumpMode mode) { return mode != DumpMode::OUTPUT; }

bool NeedOutput(const DumpMode mode) { return mode != DumpMode::INPUT; }

std::string JoinPath(const std::string& base, const std::string& component)
{
    if (base.empty()) {
        return component;
    }
    return (base.back() == '/') ? (base + component) : (base + "/" + component);
}

RuntimeThreadAicpuStatus EnsureOneDirectory(const std::string& path)
{
    if (mkdir(path.c_str(), DUMP_DIRECTORY_MODE) != 0) {
        const int32_t mkdirError = errno;
        if (mkdirError != EEXIST) {
            aicpusd_err(
                "Create DataDump directory failed, path=%s, mode=%o, errno=%d.", path.c_str(),
                static_cast<uint32_t>(DUMP_DIRECTORY_MODE), mkdirError);
            return RuntimeThreadAicpuStatus::DATADUMP_CREATE_DIR_FAILED;
        }
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus CreateDirectories(const std::string& path)
{
    if (path.empty()) {
        aicpusd_err("Create DataDump directory failed because path is empty.");
        return RuntimeThreadAicpuStatus::DATADUMP_CREATE_DIR_FAILED;
    }
    std::string current = (path.front() == '/') ? "/" : "";
    size_t begin = (path.front() == '/') ? 1U : 0U;
    while (begin <= path.size()) {
        const size_t end = path.find('/', begin);
        const std::string component = path.substr(begin, end - begin);
        if (!component.empty()) {
            current = JoinPath(current, component);
            const RuntimeThreadAicpuStatus status = EnsureOneDirectory(current);
            if (status != RuntimeThreadAicpuStatus::OK) {
                return status;
            }
        }
        if (end == std::string::npos) {
            break;
        }
        begin = end + 1U;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus CreateDumpPath(const ModelDumpConfig& config, std::string& dumpDirectory)
{
    dumpDirectory = config.dumpPath;
    if (config.stepIdAddress != 0U) {
        const auto* const stepIdAddress = PtrToPtr<void, const volatile uint64_t>(ValueToPtr(config.stepIdAddress));
        const uint64_t stepId = *stepIdAddress;
        dumpDirectory = JoinPath(dumpDirectory, std::to_string(config.modelId));
        dumpDirectory = JoinPath(dumpDirectory, config.modelName);
        dumpDirectory = JoinPath(dumpDirectory, std::to_string(stepId));
    }
    return CreateDirectories(dumpDirectory);
}

void SanitizeFileNamePart(std::string& value)
{
    std::replace_if(
        value.begin(), value.end(),
        [](const char character) {
            return (character == ' ') || (character == '.') || (character == '/') || (character == '\\');
        },
        '_');
}

std::string ComposeDumpFileName(
    const std::string& opType, const std::string& opName, const TaskKey& taskKey, const uint64_t timestamp)
{
    return opType + "." + opName + "." + std::to_string(taskKey.taskId) + "." + std::to_string(taskKey.streamId) + "." +
           std::to_string(timestamp);
}

RuntimeThreadAicpuStatus GetDumpFileName(const OpDumpInfo& op, std::string& fileName)
{
    struct timeval currentTime = {};
    if (gettimeofday(&currentTime, nullptr) != 0) {
        const int32_t timeError = errno;
        aicpusd_err(
            "Get DataDump timestamp failed, stream_id=%u, task_id=%u, errno=%d.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), timeError);
        return RuntimeThreadAicpuStatus::INTERNAL_ERROR;
    }
    const uint64_t timestamp = static_cast<uint64_t>(currentTime.tv_sec) * MICROSECONDS_PER_SECOND +
                               static_cast<uint64_t>(currentTime.tv_usec);
    std::string opType = op.opType;
    std::string opName = op.opName;
    fileName = ComposeDumpFileName(opType, opName, op.taskKey, timestamp);
    if (fileName.size() >= MAX_DUMP_FILE_NAME_LENGTH) {
        const size_t separator = opName.find_last_of('/');
        if (separator != std::string::npos) {
            opName = opName.substr(separator + 1U);
            fileName = ComposeDumpFileName(opType, opName, op.taskKey, timestamp);
        }
    }
    if (fileName.size() >= MAX_DUMP_FILE_NAME_LENGTH) {
        const size_t fixedLength = fileName.size() - opName.size();
        if (fixedLength >= MAX_DUMP_FILE_NAME_LENGTH) {
            aicpusd_err(
                "Generate DataDump file name failed because fixed fields are too long, stream_id=%u, task_id=%u, "
                "fixed_length=%zu.",
                static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), fixedLength);
            return RuntimeThreadAicpuStatus::INVALID_PARAM;
        }
        opName.resize((MAX_DUMP_FILE_NAME_LENGTH - 1U) - fixedLength);
    }
    SanitizeFileNamePart(opType);
    SanitizeFileNamePart(opName);
    fileName = ComposeDumpFileName(opType, opName, op.taskKey, timestamp);
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus ResolveMemoryRegion(
    const MemoryRegion& memory, const uint8_t*& baseAddress, const char* const side, const size_t index,
    const OpDumpInfo& op)
{
    if (memory.addressType != AddressType::RAW_ADDR) {
        aicpusd_err(
            "Resolve DataDump tensor address failed because address type is unsupported, stream_id=%u, task_id=%u, "
            "side=%s, index=%zu, address_type=%d.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), side, index,
            static_cast<int32_t>(memory.addressType));
        return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
    }
    const uint64_t maxAddress = static_cast<uint64_t>(std::numeric_limits<uintptr_t>::max());
    if ((memory.address == 0U) || (memory.address > maxAddress) || (memory.size > (maxAddress - memory.address))) {
        aicpusd_err(
            "Resolve DataDump tensor address failed, stream_id=%u, task_id=%u, side=%s, index=%zu, size=%llu.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), side, index,
            static_cast<unsigned long long>(memory.size));
        return RuntimeThreadAicpuStatus::DATADUMP_ADDRESS_INVALID;
    }
    baseAddress = PtrToPtr<void, const uint8_t>(ValueToPtr(memory.address));
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus UpdateOpDataAddr(const OpDumpInfo& op, OpDataView& dataView)
{
    dataView.inputBaseAddrList.reserve(op.inputList.size());
    for (size_t index = 0U; index < op.inputList.size(); ++index) {
        const uint8_t* baseAddress = nullptr;
        const RuntimeThreadAicpuStatus status =
            ResolveMemoryRegion(op.inputList[index].memory, baseAddress, "input", index, op);
        if (status != RuntimeThreadAicpuStatus::OK) {
            return status;
        }
        dataView.inputBaseAddrList.emplace_back(baseAddress);
    }
    dataView.outputBaseAddrList.reserve(op.outputList.size());
    for (size_t index = 0U; index < op.outputList.size(); ++index) {
        const uint8_t* baseAddress = nullptr;
        const RuntimeThreadAicpuStatus status =
            ResolveMemoryRegion(op.outputList[index].memory, baseAddress, "output", index, op);
        if (status != RuntimeThreadAicpuStatus::OK) {
            return status;
        }
        dataView.outputBaseAddrList.emplace_back(baseAddress);
    }
    return RuntimeThreadAicpuStatus::OK;
}

const char* GetDataTypeStr(const int32_t dataType)
{
    const size_t count = sizeof(DATA_TYPE_NAMES) / sizeof(DATA_TYPE_NAMES[0]);
    return ((dataType < 0) || (static_cast<size_t>(dataType) >= count)) ? "-" : DATA_TYPE_NAMES[dataType];
}

const char* GetFormatStr(const int32_t format)
{
    const size_t count = sizeof(FORMAT_NAMES) / sizeof(FORMAT_NAMES[0]);
    return ((format < 0) || (static_cast<size_t>(format) >= count)) ? "-" : FORMAT_NAMES[format];
}

std::string GenerateDimsStr(const std::vector<int64_t>& shape)
{
    std::ostringstream output;
    for (size_t index = 0U; index < shape.size(); ++index) {
        if (index != 0U) {
            output << 'x';
        }
        output << shape[index];
    }
    return output.str();
}

template <typename T>
bool ReadValue(const uint8_t* const data, const size_t index, T& value)
{
    return memcpy_s(&value, sizeof(T), data + (index * sizeof(T)), sizeof(T)) == EOK;
}

template <typename T>
void AppendIntegralValue(std::ostringstream& output, const T value)
{
    output << value;
}

void AppendIntegralValue(std::ostringstream& output, const int8_t value) { output << static_cast<int32_t>(value); }

void AppendIntegralValue(std::ostringstream& output, const uint8_t value) { output << static_cast<uint32_t>(value); }

template <typename T>
RuntimeThreadAicpuStatus GenerateIntegralStatistics(
    const uint8_t* const data, const uint64_t size, std::string& statistics)
{
    if ((size == 0U) || ((size % sizeof(T)) != 0U)) {
        return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
    }
    const size_t count = static_cast<size_t>(size / sizeof(T));
    T minimum = {};
    if (!ReadValue(data, 0U, minimum)) {
        return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
    }
    T maximum = minimum;
    double average = 0.0;
    for (size_t index = 0U; index < count; ++index) {
        T value = {};
        if (!ReadValue(data, index, value)) {
            return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
        }
        minimum = std::min(minimum, value);
        maximum = std::max(maximum, value);
        average += (static_cast<double>(value) - average) / static_cast<double>(index + 1U);
    }
    std::ostringstream output;
    AppendIntegralValue(output, maximum);
    output << ',';
    AppendIntegralValue(output, minimum);
    output << ',' << average << ',' << count << ",0,0,0";
    statistics = output.str();
    return RuntimeThreadAicpuStatus::OK;
}

class FloatingStatistics final {
public:
    void Add(const double value)
    {
        ++count_;
        if (std::isnan(value)) {
            ++nanCount_;
            return;
        }
        if (!hasExtrema_) {
            minimum_ = value;
            maximum_ = value;
            hasExtrema_ = true;
        } else {
            minimum_ = std::min(minimum_, value);
            maximum_ = std::max(maximum_, value);
        }
        if (std::isinf(value)) {
            if (value < 0.0) {
                ++negativeInfCount_;
            } else {
                ++positiveInfCount_;
            }
            return;
        }
        ++finiteCount_;
        average_ += (value - average_) / static_cast<double>(finiteCount_);
    }

    std::string ToString() const
    {
        const double notANumber = std::numeric_limits<double>::quiet_NaN();
        const double maximum = hasExtrema_ ? maximum_ : notANumber;
        const double minimum = hasExtrema_ ? minimum_ : notANumber;
        double average = average_;
        if ((nanCount_ != 0U) || ((positiveInfCount_ != 0U) && (negativeInfCount_ != 0U))) {
            average = notANumber;
        } else if (positiveInfCount_ != 0U) {
            average = std::numeric_limits<double>::infinity();
        } else if (negativeInfCount_ != 0U) {
            average = -std::numeric_limits<double>::infinity();
        }
        std::ostringstream output;
        output << maximum << ',' << minimum << ',' << average << ',' << count_ << ',' << nanCount_ << ','
               << negativeInfCount_ << ',' << positiveInfCount_;
        return output.str();
    }

private:
    bool hasExtrema_ = false;
    double minimum_ = 0.0;
    double maximum_ = 0.0;
    double average_ = 0.0;
    uint64_t count_ = 0U;
    uint64_t finiteCount_ = 0U;
    uint64_t nanCount_ = 0U;
    uint64_t negativeInfCount_ = 0U;
    uint64_t positiveInfCount_ = 0U;
};

bool Float16ToFloat(const uint16_t value, float& result)
{
    const uint32_t sign = static_cast<uint32_t>(value & FLOAT16_SIGN_MASK) << FLOAT16_TO_FLOAT_SIGN_SHIFT;
    uint32_t exponent = static_cast<uint32_t>(value & FLOAT16_EXPONENT_MASK);
    uint32_t mantissa = static_cast<uint32_t>(value & FLOAT16_MANTISSA_MASK);
    if (exponent == FLOAT16_EXPONENT_MASK) {
        exponent = FLOAT16_TO_FLOAT_INF_NAN_EXPONENT;
    } else if (exponent != 0U) {
        exponent += FLOAT16_TO_FLOAT_EXPONENT_BIAS;
    } else if (mantissa != 0U) {
        exponent = FLOAT16_TO_FLOAT_SUBNORMAL_EXPONENT;
        do {
            mantissa <<= 1U;
            exponent -= FLOAT16_HIDDEN_BIT;
        } while ((mantissa & FLOAT16_HIDDEN_BIT) == 0U);
        mantissa &= FLOAT16_MANTISSA_MASK;
    }
    const uint32_t floatBits = sign | ((exponent | mantissa) << FLOAT16_TO_FLOAT_VALUE_SHIFT);
    return memcpy_s(&result, sizeof(result), &floatBits, sizeof(floatBits)) == EOK;
}

template <typename T>
RuntimeThreadAicpuStatus GenerateFloatingStatistics(
    const uint8_t* const data, const uint64_t size, std::string& statistics)
{
    if ((size == 0U) || ((size % sizeof(T)) != 0U)) {
        return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
    }
    FloatingStatistics result;
    const size_t count = static_cast<size_t>(size / sizeof(T));
    for (size_t index = 0U; index < count; ++index) {
        T value = {};
        if (!ReadValue(data, index, value)) {
            return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
        }
        result.Add(static_cast<double>(value));
    }
    statistics = result.ToString();
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus GenerateFloat16Statistics(
    const uint8_t* const data, const uint64_t size, std::string& statistics)
{
    if ((size == 0U) || ((size % sizeof(uint16_t)) != 0U)) {
        return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
    }
    FloatingStatistics result;
    const size_t count = static_cast<size_t>(size / sizeof(uint16_t));
    for (size_t index = 0U; index < count; ++index) {
        uint16_t float16Value = 0U;
        float floatValue = 0.0F;
        if (!ReadValue(data, index, float16Value) || !Float16ToFloat(float16Value, floatValue)) {
            return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
        }
        result.Add(static_cast<double>(floatValue));
    }
    statistics = result.ToString();
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus GenerateStatistics(
    const uint8_t* const data, const uint64_t size, const int32_t dataType, std::string& statistics)
{
    switch (dataType) {
        case ge::DT_FLOAT:
            return GenerateFloatingStatistics<float>(data, size, statistics);
        case ge::DT_FLOAT16:
            return GenerateFloat16Statistics(data, size, statistics);
        case ge::DT_INT8:
            return GenerateIntegralStatistics<int8_t>(data, size, statistics);
        case ge::DT_UINT8:
        case ge::DT_BOOL:
            return GenerateIntegralStatistics<uint8_t>(data, size, statistics);
        case ge::DT_INT16:
            return GenerateIntegralStatistics<int16_t>(data, size, statistics);
        case ge::DT_UINT16:
            return GenerateIntegralStatistics<uint16_t>(data, size, statistics);
        case ge::DT_INT32:
            return GenerateIntegralStatistics<int32_t>(data, size, statistics);
        case ge::DT_UINT32:
            return GenerateIntegralStatistics<uint32_t>(data, size, statistics);
        case ge::DT_INT64:
            return GenerateIntegralStatistics<int64_t>(data, size, statistics);
        case ge::DT_UINT64:
            return GenerateIntegralStatistics<uint64_t>(data, size, statistics);
        case ge::DT_DOUBLE:
            return GenerateFloatingStatistics<double>(data, size, statistics);
        default:
            statistics = EMPTY_STATISTICS;
            return RuntimeThreadAicpuStatus::OK;
    }
}

bool WriteBytes(std::ofstream& file, const uint8_t* data, uint64_t size)
{
    const uint64_t maxChunk = static_cast<uint64_t>(std::numeric_limits<std::streamsize>::max());
    while (size != 0U) {
        const uint64_t chunk = std::min(size, maxChunk);
        file.write(PtrToPtr<uint8_t, const char>(data), static_cast<std::streamsize>(chunk));
        if (!file.good()) {
            return false;
        }
        data += static_cast<size_t>(chunk);
        size -= chunk;
    }
    return true;
}

void RemoveIncompleteFile(const std::string& filePath)
{
    if ((std::remove(filePath.c_str()) != 0) && (errno != ENOENT)) {
        aicpusd_warn("Remove incomplete DataDump file failed, path=%s, errno=%d.", filePath.c_str(), errno);
    }
}

RuntimeThreadAicpuStatus OpenDumpFile(
    const std::string& filePath, const std::ios_base::openmode mode, std::ofstream& file)
{
    errno = 0;
    file.open(filePath.c_str(), mode);
    if (!file.is_open()) {
        const int32_t openError = errno;
        aicpusd_err("Open DataDump file failed, path=%s, errno=%d.", filePath.c_str(), openError);
        return RuntimeThreadAicpuStatus::DATADUMP_OPEN_FILE_FAILED;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus FinishDumpFile(std::ofstream& file, const std::string& filePath)
{
    errno = 0;
    file.flush();
    if (!file.good()) {
        const int32_t writeError = errno;
        file.close();
        RemoveIncompleteFile(filePath);
        aicpusd_err("Flush DataDump file failed, path=%s, errno=%d.", filePath.c_str(), writeError);
        return RuntimeThreadAicpuStatus::DATADUMP_WRITE_FILE_FAILED;
    }
    file.close();
    if (file.fail()) {
        const int32_t closeError = errno;
        RemoveIncompleteFile(filePath);
        aicpusd_err("Close DataDump file failed, path=%s, errno=%d.", filePath.c_str(), closeError);
        return RuntimeThreadAicpuStatus::DATADUMP_WRITE_FILE_FAILED;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus ValidateTensor(
    const TensorDumpInfo& tensor, const uint8_t* const baseAddress, const OpDumpInfo& op, const char* const side,
    const size_t index)
{
    if ((baseAddress != nullptr) && (tensor.memory.size != 0U)) {
        return RuntimeThreadAicpuStatus::OK;
    }
    aicpusd_err(
        "Invalid DataDump tensor, stream_id=%u, task_id=%u, side=%s, index=%zu, address_valid=%u, size=%llu.",
        static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), side, index,
        static_cast<uint32_t>(baseAddress != nullptr), static_cast<unsigned long long>(tensor.memory.size));
    return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
}

RuntimeThreadAicpuStatus AppendStatsRows(const OpDumpInfo& op, const OpDataView& dataView, std::ostringstream& output)
{
    if (NeedInput(op.config->dumpMode)) {
        for (size_t index = 0U; index < op.inputList.size(); ++index) {
            const InputDumpInfo& input = op.inputList[index];
            RuntimeThreadAicpuStatus status =
                ValidateTensor(input, dataView.inputBaseAddrList[index], op, "input", index);
            std::string statistics;
            if (status == RuntimeThreadAicpuStatus::OK) {
                status = GenerateStatistics(
                    dataView.inputBaseAddrList[index], input.memory.size, input.dataType, statistics);
            }
            if (status != RuntimeThreadAicpuStatus::OK) {
                aicpusd_err(
                    "Generate input DataDump statistics failed, stream_id=%u, task_id=%u, index=%zu, data_type=%d, "
                    "size=%llu, status=%u.",
                    static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), index,
                    input.dataType, static_cast<unsigned long long>(input.memory.size), static_cast<uint32_t>(status));
                return status;
            }
            output << "Input," << index << ',' << input.memory.size << ',' << GetDataTypeStr(input.dataType) << ','
                   << GetFormatStr(input.format) << ',' << GenerateDimsStr(input.shape) << ',' << statistics << '\n';
        }
    }
    if (NeedOutput(op.config->dumpMode)) {
        for (size_t index = 0U; index < op.outputList.size(); ++index) {
            const OutputDumpInfo& tensorOutput = op.outputList[index];
            RuntimeThreadAicpuStatus status =
                ValidateTensor(tensorOutput, dataView.outputBaseAddrList[index], op, "output", index);
            std::string statistics;
            if (status == RuntimeThreadAicpuStatus::OK) {
                status = GenerateStatistics(
                    dataView.outputBaseAddrList[index], tensorOutput.memory.size, tensorOutput.dataType, statistics);
            }
            if (status != RuntimeThreadAicpuStatus::OK) {
                aicpusd_err(
                    "Generate output DataDump statistics failed, stream_id=%u, task_id=%u, index=%zu, data_type=%d, "
                    "size=%llu, status=%u.",
                    static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), index,
                    tensorOutput.dataType, static_cast<unsigned long long>(tensorOutput.memory.size),
                    static_cast<uint32_t>(status));
                return status;
            }
            output << "Output," << index << ',' << tensorOutput.memory.size << ','
                   << GetDataTypeStr(tensorOutput.dataType) << ',' << GetFormatStr(tensorOutput.format) << ','
                   << GenerateDimsStr(tensorOutput.shape) << ',' << statistics << '\n';
        }
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus DumpStats(const OpDumpInfo& op, const OpDataView& dataView, const std::string& filePath)
{
    std::ostringstream output;
    output << STATS_HEADER;
    RuntimeThreadAicpuStatus status = AppendStatsRows(op, dataView, output);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }
    const std::string contents = output.str();
    std::ofstream file;
    status = OpenDumpFile(filePath, std::ios::out | std::ios::trunc, file);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }
    if (!WriteBytes(file, PtrToPtr<char, const uint8_t>(contents.data()), contents.size())) {
        const int32_t writeError = errno;
        file.close();
        RemoveIncompleteFile(filePath);
        aicpusd_err(
            "Write DataDump statistics file failed, path=%s, size=%zu, errno=%d.", filePath.c_str(), contents.size(),
            writeError);
        return RuntimeThreadAicpuStatus::DATADUMP_WRITE_FILE_FAILED;
    }
    return FinishDumpFile(file, filePath);
}

RuntimeThreadAicpuStatus ValidateTensorListForWrite(const OpDumpInfo& op, const OpDataView& dataView)
{
    if (NeedInput(op.config->dumpMode)) {
        if (!op.inputList.empty() && op.inputDescTlv.empty()) {
            aicpusd_err(
                "Write DataDump tensor file failed because input descriptor TLV is missing, stream_id=%u, task_id=%u.",
                static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId));
            return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
        }
        for (size_t index = 0U; index < op.inputList.size(); ++index) {
            const RuntimeThreadAicpuStatus status =
                ValidateTensor(op.inputList[index], dataView.inputBaseAddrList[index], op, "input", index);
            if (status != RuntimeThreadAicpuStatus::OK) {
                return status;
            }
        }
    }
    if (NeedOutput(op.config->dumpMode)) {
        if (!op.outputList.empty() && op.outputDescTlv.empty()) {
            aicpusd_err(
                "Write DataDump tensor file failed because output descriptor TLV is missing, stream_id=%u, task_id=%u.",
                static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId));
            return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
        }
        for (size_t index = 0U; index < op.outputList.size(); ++index) {
            const RuntimeThreadAicpuStatus status =
                ValidateTensor(op.outputList[index], dataView.outputBaseAddrList[index], op, "output", index);
            if (status != RuntimeThreadAicpuStatus::OK) {
                return status;
            }
        }
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus AbortTensorWrite(
    std::ofstream& file, const std::string& filePath, const char* const part, const size_t index, const uint64_t size)
{
    const int32_t writeError = errno;
    file.close();
    RemoveIncompleteFile(filePath);
    aicpusd_err(
        "Write DataDump tensor file failed, path=%s, part=%s, index=%zu, size=%llu, errno=%d.", filePath.c_str(), part,
        index, static_cast<unsigned long long>(size), writeError);
    return RuntimeThreadAicpuStatus::DATADUMP_WRITE_FILE_FAILED;
}

RuntimeThreadAicpuStatus DumpTensor(const OpDumpInfo& op, const OpDataView& dataView, const std::string& filePath)
{
    RuntimeThreadAicpuStatus status = ValidateTensorListForWrite(op, dataView);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }
    const uint64_t inputHeadLength = NeedInput(op.config->dumpMode) ? op.inputDescTlv.size() : 0U;
    const uint64_t outputHeadLength = NeedOutput(op.config->dumpMode) ? op.outputDescTlv.size() : 0U;
    if ((inputHeadLength > (std::numeric_limits<uint64_t>::max() - outputHeadLength)) ||
        ((inputHeadLength + outputHeadLength) >
         (std::numeric_limits<uint64_t>::max() - sizeof(uint32_t) - sizeof(uint32_t)))) {
        aicpusd_err(
            "Write DataDump tensor file failed because descriptor length overflows, stream_id=%u, task_id=%u, "
            "input_head_length=%llu, output_head_length=%llu.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId),
            static_cast<unsigned long long>(inputHeadLength), static_cast<unsigned long long>(outputHeadLength));
        return RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID;
    }
    const uint64_t dataHeadLength = inputHeadLength + outputHeadLength + sizeof(uint32_t) + sizeof(uint32_t);
    const uint32_t magic = tlv::DATA_MAGIC;
    const uint32_t version = tlv::DATA_VERSION;
    std::ofstream file;
    status = OpenDumpFile(filePath, std::ios::out | std::ios::binary | std::ios::trunc, file);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }
    if (!WriteBytes(file, PtrToPtr<uint64_t, const uint8_t>(&dataHeadLength), sizeof(dataHeadLength)) ||
        !WriteBytes(file, PtrToPtr<uint32_t, const uint8_t>(&magic), sizeof(magic)) ||
        !WriteBytes(file, PtrToPtr<uint32_t, const uint8_t>(&version), sizeof(version))) {
        return AbortTensorWrite(
            file, filePath, "file_header", 0U, sizeof(dataHeadLength) + sizeof(magic) + sizeof(version));
    }
    if ((inputHeadLength != 0U) && !WriteBytes(file, op.inputDescTlv.data(), inputHeadLength)) {
        return AbortTensorWrite(file, filePath, "input_descriptor", 0U, inputHeadLength);
    }
    if ((outputHeadLength != 0U) && !WriteBytes(file, op.outputDescTlv.data(), outputHeadLength)) {
        return AbortTensorWrite(file, filePath, "output_descriptor", 0U, outputHeadLength);
    }
    if (NeedInput(op.config->dumpMode)) {
        for (size_t index = 0U; index < op.inputList.size(); ++index) {
            const uint64_t size = op.inputList[index].memory.size;
            if (!WriteBytes(file, dataView.inputBaseAddrList[index], size)) {
                return AbortTensorWrite(file, filePath, "input_data", index, size);
            }
        }
    }
    if (NeedOutput(op.config->dumpMode)) {
        for (size_t index = 0U; index < op.outputList.size(); ++index) {
            const uint64_t size = op.outputList[index].memory.size;
            if (!WriteBytes(file, dataView.outputBaseAddrList[index], size)) {
                return AbortTensorWrite(file, filePath, "output_data", index, size);
            }
        }
    }
    return FinishDumpFile(file, filePath);
}

} // namespace

RuntimeThreadAicpuStatus DataDumpWriter::DumpOp(const OpDumpInfo& op) const
{
    if ((op.config == nullptr) || op.config->dumpPath.empty() || op.opName.empty() || op.opType.empty()) {
        aicpusd_err(
            "Dump DataDump op failed because metadata is invalid, stream_id=%u, task_id=%u, config_valid=%u, "
            "op_name_valid=%u, op_type_valid=%u.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId),
            static_cast<uint32_t>(op.config != nullptr), static_cast<uint32_t>(!op.opName.empty()),
            static_cast<uint32_t>(!op.opType.empty()));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    aicpusd_debug(
        "Dump DataDump op start, model_id=%u, stream_id=%u, task_id=%u, op_name=%s, dump_mode=%u, "
        "dump_output_type=%llu.",
        op.config->modelId, static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId),
        op.opName.c_str(), static_cast<uint32_t>(op.config->dumpMode),
        static_cast<unsigned long long>(op.config->dumpOutputType));
    try {
        OpDataView dataView;
        RuntimeThreadAicpuStatus status = UpdateOpDataAddr(op, dataView);
        if (status != RuntimeThreadAicpuStatus::OK) {
            return status;
        }
        std::string dumpDirectory;
        status = CreateDumpPath(*op.config, dumpDirectory);
        if (status != RuntimeThreadAicpuStatus::OK) {
            return status;
        }
        std::string fileName;
        status = GetDumpFileName(op, fileName);
        if (status != RuntimeThreadAicpuStatus::OK) {
            return status;
        }
        std::string filePath = JoinPath(dumpDirectory, fileName);
        switch (op.config->dumpOutputType) {
            case DumpOutputType::STATS:
                filePath += STATS_FILE_SUFFIX;
                status = DumpStats(op, dataView, filePath);
                break;
            case DumpOutputType::TENSOR:
                status = DumpTensor(op, dataView, filePath);
                break;
            default:
                aicpusd_err(
                    "Dump DataDump op failed because output type is invalid, stream_id=%u, task_id=%u, "
                    "dump_output_type=%llu.",
                    static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId),
                    static_cast<unsigned long long>(op.config->dumpOutputType));
                return RuntimeThreadAicpuStatus::INVALID_PARAM;
        }
        if (status == RuntimeThreadAicpuStatus::OK) {
            aicpusd_debug(
                "Dump DataDump op success, model_id=%u, stream_id=%u, task_id=%u, path=%s.", op.config->modelId,
                static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId), filePath.c_str());
        }
        return status;
    } catch (const std::bad_alloc&) {
        aicpusd_err(
            "Dump DataDump op failed because memory allocation failed, stream_id=%u, task_id=%u.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId));
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    } catch (...) {
        aicpusd_err(
            "Dump DataDump op failed because an unexpected exception was thrown, stream_id=%u, task_id=%u.",
            static_cast<uint32_t>(op.taskKey.streamId), static_cast<uint32_t>(op.taskKey.taskId));
        return RuntimeThreadAicpuStatus::INTERNAL_ERROR;
    }
}

} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce
