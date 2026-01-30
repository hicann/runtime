/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "printf.hpp"
#include "prof_ctrl_callback_manager.hpp"

#include <sstream>
#include <string>
#include <unordered_map>

#include "context.hpp"
#include "runtime.hpp"
#include "fp16_t.h"
#include "bfloat16.h"
#include "hifloat.h"
#include "external/graph/types.h"
namespace cce {
namespace runtime {
namespace {
constexpr uint16_t MAGIC_NUM = 0xAE86U;
constexpr uint32_t PRINT_ARG_LEN = 8U;
constexpr uint32_t RESV_LEN = 8U;
constexpr uint32_t RESV_LEN_SIMT = 40U;
constexpr uint32_t PRINT_MSG_LEN_OFFSET = 12U;
constexpr uint32_t SIMT_PRINT_MSG_LEN_OFFSET = 44U;
constexpr size_t MAX_LOG_LENGTH = 256U;
constexpr uint16_t INT16_SIZE = 2U;
constexpr uint16_t INT32_SIZE = 4U;
constexpr uint16_t INT64_SIZE = 8U;
constexpr size_t ONE_LINE_NUM = 30U;

template<typename T>
std::string ToHex(T num)
{
    std::stringstream stream;
    stream << std::hex << num;
    return stream.str();
}

inline int32_t ConvertToStd(uint8_t data)
{
    return static_cast<int32_t>(data);
}
 
inline int32_t ConvertToStd(int8_t data)
{
    return static_cast<int32_t>(data);
}
 
template<typename T>
inline T ConvertToStd(const T &data)
{
    return data;
}

inline float ConvertToStd(const cce::runtime::fp16_t &data)
{
    return data.toFloat();
}

inline float ConvertToStd(cce::runtime::BFloat16 data)
{
    return data.GetValue();
}
 
inline float ConvertToStd(cce::runtime::HiFloat8 data)
{
    return data.GetValue();
}
 
inline float ConvertToStd(cce::runtime::Fp8E5M2 data)
{
    return data.GetValue();
}
 
inline float ConvertToStd(cce::runtime::Fp8E4M3 data)
{
    return data.GetValue();
}
 
inline float ConvertToStd(cce::runtime::Fp8E8M0 data)
{
    return data.GetValue();
}

enum class DumpTensorPosition : uint16_t {
    GM = 0,
    UB,
    L1,
    L0A,
    L0B,
    L0C,
    BIAS,
    FIXBUF,
    MAX
};

const std::unordered_map<uint16_t, std::string> POSITION_MAP = {
    {static_cast<uint16_t>(DumpTensorPosition::GM), "GM"},
    {static_cast<uint16_t>(DumpTensorPosition::UB), "UB"},
    {static_cast<uint16_t>(DumpTensorPosition::L1), "L1"},
    {static_cast<uint16_t>(DumpTensorPosition::L0A), "L0A"},
    {static_cast<uint16_t>(DumpTensorPosition::L0B), "L0B"},
    {static_cast<uint16_t>(DumpTensorPosition::L0C), "L0C"},
    {static_cast<uint16_t>(DumpTensorPosition::BIAS), "BIAS"},
    {static_cast<uint16_t>(DumpTensorPosition::FIXBUF), "FIXBUF"},
};

template<typename T>
std::string ToUpperHex(T num)
{
    std::stringstream stream;
    stream << std::uppercase << std::hex << num;
    return stream.str();
}

template<typename T>
inline T ParseParam(const uint8_t *beginAddr, const uint32_t paramIndex)
{
    const T *paramAddr = RtPtrToPtr<const T *>(beginAddr + paramIndex * PRINT_ARG_LEN);
    return *paramAddr;
}

static void PrintFormatD(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatI(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatF(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const float paramInfo = ParseParam<float>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatFUpper(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const float paramInfo = ParseParam<float>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatU(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const uint64_t paramInfo = ParseParam<uint64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatP(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const void *paramInfo = ParseParam<void *>(paramBegin, paramIndex);
    std::stringstream stream;
    stream << paramInfo;
    printInfo += stream.str();
}

static void PrintFormatX(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += ToHex(paramInfo);
}

static void PrintFormatXUpper(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += ToUpperHex(paramInfo);
}

static void PrintFormatS(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const uint64_t *offsetAddr = RtPtrToPtr<const uint64_t *>(paramBegin + paramIndex * PRINT_ARG_LEN);
    const char *data = (RtPtrToPtr<const char *>(offsetAddr)) + (*offsetAddr);
    // DumpInfoHead 中infoMsg前面就是当前dump块的Len，占4字节,infoMsg前面是8字节的预留字段
    const size_t maxLen = static_cast<size_t>(*(RtPtrToPtr<const uint32_t *>(paramBegin - PRINT_MSG_LEN_OFFSET)));
    const size_t dataLen = strnlen(data, maxLen);
    RT_LOG(RT_LOG_DEBUG, "Get string param length[%zu bytes], max length[%zu bytes].", dataLen, maxLen);
    COND_RETURN_VOID(dataLen == maxLen, "String param length is greater than max length[%zu bytes]", maxLen);

    std::stringstream stream;
    stream << data;
    printInfo += stream.str();
}

static void SimtPrintFormatS(const uint8_t *paramBegin, std::string &printInfo, const uint32_t paramIndex)
{
    const uint64_t *offsetAddr = RtPtrToPtr<const uint64_t *>(paramBegin + paramIndex * PRINT_ARG_LEN);
    const char *data = (RtPtrToPtr<const char *>(offsetAddr)) + (*offsetAddr);
    // DumpInfoHead 中infoMsg前面就是当前dump块的Len，占4字节,infoMsg前面是40字节的预留字段
    const size_t maxLen = static_cast<size_t>(*(RtPtrToPtr<const uint32_t *>(paramBegin - SIMT_PRINT_MSG_LEN_OFFSET)));
    const size_t dataLen = strnlen(data, maxLen);
    RT_LOG(RT_LOG_DEBUG, "Get string param length[%zu bytes], max length[%zu bytes].", dataLen, maxLen);
    COND_RETURN_VOID(dataLen == maxLen, "String param length is greater than max length[%zu bytes]", maxLen);

    std::stringstream stream;
    stream << data;
    printInfo += stream.str();
}

const std::unordered_map<std::string,
    std::function<void(const uint8_t *,std::string &, const uint32_t)>> SIMT_PRINT_FORMAT_CALLS {
    {"d", &PrintFormatD},
    {"ld", &PrintFormatD},
    {"lld", &PrintFormatD},
    {"i", &PrintFormatI},
    {"li", &PrintFormatI},
    {"lli", &PrintFormatI},
    {"f", &PrintFormatF},
    {"F", &PrintFormatFUpper},
    {"u", &PrintFormatU},
    {"lu", &PrintFormatU},
    {"llu", &PrintFormatU},
    {"p", &PrintFormatP},
    {"x", &PrintFormatX},
    {"lx", &PrintFormatX},
    {"llx", &PrintFormatX},
    {"X", &PrintFormatXUpper},
    {"lX", &PrintFormatXUpper},
    {"llX", &PrintFormatXUpper},
    {"s", &SimtPrintFormatS}
};

const std::unordered_map<std::string,
    std::function<void(const uint8_t *,std::string &, const uint32_t)>> SIMD_PRINT_FORMAT_CALLS {
    {"d", &PrintFormatD},
    {"ld", &PrintFormatD},
    {"lld", &PrintFormatD},
    {"i", &PrintFormatI},
    {"li", &PrintFormatI},
    {"lli", &PrintFormatI},
    {"f", &PrintFormatF},
    {"F", &PrintFormatFUpper},
    {"u", &PrintFormatU},
    {"lu", &PrintFormatU},
    {"llu", &PrintFormatU},
    {"p", &PrintFormatP},
    {"x", &PrintFormatX},
    {"lx", &PrintFormatX},
    {"llx", &PrintFormatX},
    {"X", &PrintFormatXUpper},
    {"lX", &PrintFormatXUpper},
    {"llX", &PrintFormatXUpper},
    {"s", &PrintFormatS}
};

std::string ParseFormat(const char *format)
{
    std::string temp;
    if ((*format) == 'l') {
        temp += std::string(format, 1);
        format++;
        if (((*format) != '\0') && ((*format) == 'l')) {
            temp += std::string(format, 1);
            format++;
            if ((*format) != '\0') {
                temp += std::string(format, 1);
                return temp;
            }
        } else if ((*format) != '\0') {
            temp += std::string(format, 1);
            return temp;
        } else {
            // no op
        }
    }
    temp += std::string(format, 1);
    return temp;
}

void ParsePrintToLog(const char *format, const uint8_t *paramBegin, const uint32_t paramNum, const bool isAssert, uint32_t flag)
{
    const auto& formatMap = (flag == PRINT_SIMT) ? SIMT_PRINT_FORMAT_CALLS : SIMD_PRINT_FORMAT_CALLS;
    uint32_t paramIndex = 0U;
    std::string printInfo = "";
    while ((*format) != '\0') {
        if ((*format) != '%') {
            printInfo += *format;
            format++;
            continue;
        }

        format++;
        const std::string &tempFormat = ParseFormat(format);
        const auto &iter = formatMap.find(tempFormat);
        if (iter == formatMap.end()) {
            printInfo += "%";
            if (tempFormat[0] == '%') {  // 支持 %% 打印
                format++;
                continue;
            }
            RT_LOG(RT_LOG_ERROR, "Print fomat [%%%s] is illegal.", tempFormat.c_str());
            if (tempFormat[0] != '\0') {  // 正文末尾不是%的处理
                printInfo += tempFormat;
                format += tempFormat.size();
            }
            break;
        }

        paramIndex++;
        if (paramIndex > paramNum) {
            RT_LOG(RT_LOG_ERROR, "Illegal dump print fomatting num[>=%u], which expected[%u].", paramIndex, paramNum);
            break;
        }
        (iter->second)(paramBegin, printInfo, paramIndex);
        format += tempFormat.size();
    }

    const size_t infoLen = printInfo.size();
    for (size_t curIdx = 0; curIdx < infoLen; curIdx += MAX_LOG_LENGTH) {
        const size_t curLen = (curIdx + MAX_LOG_LENGTH) > infoLen ? (infoLen - curIdx) : MAX_LOG_LENGTH;
        (void)printf("%s", printInfo.substr(curIdx, curLen).c_str());
        if (isAssert) {
            RT_LOG(RT_LOG_ERROR, "%s", printInfo.substr(curIdx, curLen).c_str());
        } else {
            RT_LOG(RT_LOG_INFO, "PrintInfo: %s", printInfo.substr(curIdx, curLen).c_str());
        }
    }
}

void PrintDumpBase(const DumpInfoHead *dumpHead, uint32_t flag)
{
    uint32_t resvOffset = (flag == PRINT_SIMT) ? RESV_LEN_SIMT : RESV_LEN;
    RT_LOG(RT_LOG_DEBUG, "Get dump print dataLen[%u bytes].", dumpHead->infoLen);
    // 预留8字节, strOffset占位8字节
    COND_RETURN_VOID(dumpHead->infoLen < (PRINT_ARG_LEN + resvOffset),
                     "dumpHead infoLen(%u) is too small", dumpHead->infoLen);

    const uint64_t strOffset = *(RtPtrToPtr<const uint64_t *>(dumpHead->infoMsg + resvOffset));
    // 第一个位置填的是offset，所以通过-1得到的实际参数个数
    const uint32_t argsNum = static_cast<uint32_t>(strOffset) / PRINT_ARG_LEN - 1U;
    const char *str = RtPtrToPtr<const char *>(dumpHead->infoMsg + strOffset + resvOffset);
    const size_t strLen = strnlen(str, static_cast<size_t>(dumpHead->infoLen));
    RT_LOG(RT_LOG_DEBUG, "Get print str len[%zu bytes]", strLen);
    COND_RETURN_VOID(strLen == static_cast<size_t>(dumpHead->infoLen), "Print str len is greater than infoLen");

    const bool isAssert = (dumpHead->type == DumpType::DUMP_ASSERT || dumpHead->type == DumpType::DUMP_SIMT_ASSERT);
    ParsePrintToLog(str, RtPtrToPtr<const uint8_t *>(dumpHead->infoMsg + resvOffset), argsNum, isAssert, flag);
}

void PrintDump(const DumpInfoHead *dumpHead)
{
    PrintDumpBase(dumpHead, PRINT_SIMD);
}

void PrintSimtDump(const DumpInfoHead *dumpHead)
{
    PrintDumpBase(dumpHead, PRINT_SIMT);
}

void PrintDumpTimestamp(const DumpInfoHead *dumpHead, std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    COND_RETURN_VOID((dumpHead->infoLen < sizeof(DumpTimeStampInfoMsg)),
        "dumpHead infoLen(%u) is less than %u", dumpHead->infoLen, sizeof(MsprofAicTimeStampInfo));
    
    MsprofAicTimeStampInfo timeInfo;

    const DumpTimeStampInfoMsg *dumpInfoMsg = RtPtrToPtr<const DumpTimeStampInfoMsg *>(dumpHead->infoMsg);
    timeInfo.blockId = dumpInfoMsg->blockIdx;
    timeInfo.descId = dumpInfoMsg->descId;
    const uint32_t rsv = dumpInfoMsg->rsv;
    timeInfo.syscyc = dumpInfoMsg->syscyc;
    timeInfo.curPc = dumpInfoMsg->curPc;
    timeStampInfo.push_back(timeInfo);

    const bool timeStampFlag = static_cast<bool>(ProfCtrlCallbackManager::Instance().GetSwitchData() & PROF_OP_TIMESTAMP_MASK);
    if (!timeStampFlag) {
        (void)printf("descId is %u, rsv is %u, timeStamp is %lu, pcPtr is %lu, entry is %lu.\n",
            timeInfo.descId,
            rsv,
            timeInfo.syscyc,
            timeInfo.curPc,
            dumpInfoMsg->entry);
    }
    RT_LOG(RT_LOG_INFO, "descId is %u, rsv is %u, timeStamp is %lu, pcPtr is %lu, entry is %lu.",
        timeInfo.descId,
        rsv,
        timeInfo.syscyc,
        timeInfo.curPc,
        dumpInfoMsg->entry);
}

void ReportTimeStampInfo(const std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    const bool timeStampFlag = static_cast<bool>(ProfCtrlCallbackManager::Instance().GetSwitchData() & PROF_OP_TIMESTAMP_MASK);
    if (!timeStampFlag || timeStampInfo.empty()) {
        return;
    }
    constexpr size_t batchSize = static_cast<size_t>MSPROF_ADDTIONAL_INFO_DATA_LENGTH / sizeof(MsprofAicTimeStampInfo);
    const size_t timeStampInfoLen = timeStampInfo.size();
    for (size_t i = 0U; i < timeStampInfoLen; i += batchSize) {
        const size_t batchEnd = std::min(i + batchSize, timeStampInfo.size()); // 防止越界
        const size_t sizeToCopy = (batchEnd - i) * sizeof(MsprofAicTimeStampInfo); // 计算每次拷贝的字节数
        MsprofAdditionalInfo additionInfo{};
        const uint64_t timeStamp = MsprofSysCycleTime();
        additionInfo.level = MSPROF_REPORT_AIC_LEVEL;
        additionInfo.type = MSPROF_REPORT_AIC_TIMESTAMP_TYPE;
        additionInfo.threadId = static_cast<uint32_t>(mmGetTid());
        additionInfo.timeStamp = timeStamp;
        additionInfo.dataLen = static_cast<uint32_t>(sizeToCopy);
        const errno_t err = memcpy_s(additionInfo.data, static_cast<size_t>MSPROF_ADDTIONAL_INFO_DATA_LENGTH,
            &timeStampInfo[i], sizeToCopy);
        if (err != EOK) {
            RT_LOG(RT_LOG_ERROR, "Failed to memcpy timestamp additional info, data is %p, timeStampInfo is %p, dataLen is %u",
                additionInfo.data, &timeStampInfo[i], additionInfo.dataLen);
            return;
        }
        RT_LOG(RT_LOG_INFO, "Report dataLen is %u.", additionInfo.dataLen);
        (void)MsprofReportAdditionalInfo(
            static_cast<uint32_t>(true), &additionInfo, static_cast<uint32_t>(sizeof(MsprofAdditionalInfo)));
    }
}

void PrintBoolTensor(const void *data, const size_t dataNum)
{
    const uint8_t *nums = static_cast<const uint8_t *>(data);
    std::cout << "[";
    std::string tensorData = "[";
    for (size_t i = 0U; i < dataNum; ++i) {
        if(bool(nums[i])) {
            std::cout << 1;
            tensorData += "1";
        } else {
            std::cout << 0;
            tensorData += "0";            
        }
        if (i == dataNum - 1U) { // dataNum一定满足>=1
            std::cout << "]" << std::endl;
            tensorData += "]";
            RT_LOG(RT_LOG_INFO, "DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                RT_LOG(RT_LOG_INFO, "DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}
 
template<typename T>
void PrintTensor(const void *data, const size_t dataNum)
{
    const T *nums = RtPtrToPtr<const T *>(data);
    std::cout << "[";
    std::string tensorData = "[";
    for (size_t i = 0U; i < dataNum; ++i) {
        const auto num = ConvertToStd(nums[i]);
        std::cout << std::to_string(num);
        tensorData += std::to_string(num);
        if (i == dataNum - 1U) { // dataNum一定满足>=1
            std::cout << "]" << std::endl;
            tensorData += "]";
            RT_LOG(RT_LOG_INFO, "DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                RT_LOG(RT_LOG_INFO, "DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}

const std::unordered_map<uint32_t, std::function<void(const void *, const size_t)>> PRINT_TENSOR_CALLS{
    {ge::DT_UINT8, &PrintTensor<uint8_t>},
    {ge::DT_INT8, &PrintTensor<int8_t>},
    {ge::DT_INT16, &PrintTensor<int16_t>},
    {ge::DT_UINT16, &PrintTensor<uint16_t>},
    {ge::DT_INT32, &PrintTensor<int32_t>},
    {ge::DT_UINT32, &PrintTensor<uint32_t>},
    {ge::DT_INT64, &PrintTensor<int64_t>},
    {ge::DT_UINT64, &PrintTensor<uint64_t>},
    {ge::DT_FLOAT, &PrintTensor<float>},
    {ge::DT_FLOAT16, &PrintTensor<cce::runtime::fp16_t>},
    {ge::DT_BF16, &PrintTensor<cce::runtime::BFloat16>},
    {ge::DT_HIFLOAT8, &PrintTensor<cce::runtime::HiFloat8>},
    {ge::DT_FLOAT8_E5M2, &PrintTensor<cce::runtime::Fp8E5M2>},
    {ge::DT_FLOAT8_E4M3FN, &PrintTensor<cce::runtime::Fp8E4M3>},
    {ge::DT_FLOAT8_E8M0, &PrintTensor<cce::runtime::Fp8E8M0>},
    {ge::DT_BOOL, &PrintBoolTensor},
};

static void AppendBracketsAndNewlines(
    std::string &tensorContent, const size_t cnt, const bool flag, const size_t index, const size_t dataNum)
{
    tensorContent += std::string(cnt, ']');
    if (flag) {
        tensorContent += ",\n";
    }
    if (index != dataNum - 1U) {
        if (!flag) {
            tensorContent += ",\n";
        }
        tensorContent += std::string(cnt, '[');
    }
}

static void FormatTensorContent(
    std::string &tensorContent, const size_t cnt, const bool flag, const size_t index, const size_t dataNum)
{
    if (cnt > 0U) {
        AppendBracketsAndNewlines(tensorContent, cnt, flag, index, dataNum);
        return;
    }
    if (index != dataNum - 1U) {
        tensorContent += ",";
    }
}

template <typename T>
static size_t PrintValidTensorData(const void *data, const size_t dataNum, const std::vector<size_t> &tmpShape,
    std::string &tensorContent, const bool flag)
{
    const T *dumpTensor = static_cast<const T *>(data);
    size_t cnt = 0U;
    for (size_t i = 0; i < dataNum; i++) {
        cnt = 0U;
        for (const size_t s : tmpShape) {
            if ((i + 1U) % s == 0) {
                cnt++;
            }
        }
        tensorContent += std::to_string(ConvertToStd(dumpTensor[i]));
        FormatTensorContent(tensorContent, cnt, flag, i, dataNum);
    }
    return cnt;
}

size_t PrintValidTensorBoolData(const void *data, const size_t dataNum, const std::vector<size_t> &tmpShape,
                                   std::string &tensorContent, const bool flag)
{
    const uint8_t *dumpTensor = static_cast<const uint8_t *>(data);
    size_t cnt = 0U;
    for (size_t i = 0; i < dataNum; i++) {
        cnt = 0U;
        for (const size_t s : tmpShape) {
            if ((i + 1U) % s == 0) {
                cnt++;
            }
        }
        std::string value = (static_cast<bool>(dumpTensor[i])) ? "1" : "0";
        tensorContent += value;
        FormatTensorContent(tensorContent, cnt, flag, i, dataNum);
    }
    return cnt;
}
 
const std::unordered_map<uint32_t, uint16_t> SUPPORT_DATA_TYPE_SIZE {
    {ge::DT_UINT8, 1U},
    {ge::DT_INT8, 1U},
    {ge::DT_BOOL, 1U},
    {ge::DT_INT16, INT16_SIZE},
    {ge::DT_UINT16, INT16_SIZE},
    {ge::DT_INT32, INT32_SIZE},
    {ge::DT_UINT32, INT32_SIZE},
    {ge::DT_INT64, INT64_SIZE},
    {ge::DT_UINT64, INT64_SIZE},
    {ge::DT_FLOAT, INT32_SIZE},
    {ge::DT_FLOAT16, INT16_SIZE},
    {ge::DT_BF16, INT16_SIZE},
    {ge::DT_HIFLOAT8, 1U},
    {ge::DT_FLOAT8_E5M2, 1U},
    {ge::DT_FLOAT8_E4M3FN, 1U},
    {ge::DT_FLOAT8_E8M0, 1U}
};
 
bool GetDataTypeSize(uint32_t dataType, uint16_t &size)
{
    const auto &iter = SUPPORT_DATA_TYPE_SIZE.find(dataType);
    if (iter != SUPPORT_DATA_TYPE_SIZE.end()) {
        size = iter->second;
        return true;
    }
    return false;
}
 
static std::string DataTypeToString(uint32_t dataType)
{
    static std::map<uint32_t, std::string> dtype = {
        {ge::DT_FLOAT, "float32"},
        {ge::DT_FLOAT16, "float16"},
        {ge::DT_INT8, "int8"},
        {ge::DT_INT32, "int32"},
        {ge::DT_UINT8, "uint8"},
        {ge::DT_INT16, "int16"},
        {ge::DT_UINT16, "uint16"},
        {ge::DT_UINT32, "uint32"},
        {ge::DT_INT64, "int64"},
        {ge::DT_UINT64, "uint64"},
        {ge::DT_DOUBLE, "double"},
        {ge::DT_BOOL, "bool"},
        {ge::DT_STRING, "string"},
        {ge::DT_COMPLEX64, "complex64"},
        {ge::DT_COMPLEX128, "complex128"},
        {ge::DT_BF16, "bfloat16"},
        {ge::DT_HIFLOAT8, "hifloat8"},
        {ge::DT_FLOAT8_E5M2, "float8_e5m2"},
        {ge::DT_FLOAT8_E4M3FN, "float8_e4m3fn"},
        {ge::DT_FLOAT8_E8M0, "float8_e8m0"}};
    auto iter = dtype.find(dataType);
    if (iter != dtype.end()) {
        return (iter->second).c_str();
    } else {
        return "Unknown dumpDataType";
    }
}

const std::unordered_map<uint32_t,
    std::function<size_t(const void *, const size_t, const std::vector<size_t> &, std::string &, const size_t)>>
    PRINT_BY_SHAPE_CALLS{{ge::DT_UINT8, &PrintValidTensorData<uint8_t>},
        {ge::DT_INT8, &PrintValidTensorData<int8_t>},
        {ge::DT_INT16, &PrintValidTensorData<int16_t>},
        {ge::DT_UINT16, &PrintValidTensorData<uint16_t>},
        {ge::DT_INT32, &PrintValidTensorData<int32_t>},
        {ge::DT_UINT32, &PrintValidTensorData<uint32_t>},
        {ge::DT_INT64, &PrintValidTensorData<int64_t>},
        {ge::DT_UINT64, &PrintValidTensorData<uint64_t>},
        {ge::DT_FLOAT, &PrintValidTensorData<float>},
        {ge::DT_FLOAT16, &PrintValidTensorData<cce::runtime::fp16_t>},
        {ge::DT_BOOL, &PrintValidTensorBoolData},
        {ge::DT_BF16, &PrintValidTensorData<cce::runtime::BFloat16>},
        {ge::DT_HIFLOAT8, &PrintValidTensorData<cce::runtime::HiFloat8>},
        {ge::DT_FLOAT8_E5M2, &PrintValidTensorData<cce::runtime::Fp8E5M2>},
        {ge::DT_FLOAT8_E4M3FN, &PrintValidTensorData<cce::runtime::Fp8E4M3>},
        {ge::DT_FLOAT8_E8M0, &PrintValidTensorData<cce::runtime::Fp8E8M0>}};

void GetDumpShape(const DumpInfoHead *dumpHead, std::vector<size_t> &shape)
{
    if (static_cast<size_t>(dumpHead->infoLen) < sizeof(DumpShapeInfo)) {
        RT_LOG(RT_LOG_ERROR,
            "dump info length %u bytes is less than required of DumpShapeInfo (%zu bytes).",
            dumpHead->infoLen, sizeof(DumpShapeInfo));
        return;
    }
    const DumpShapeInfo *const shapeHead = RtPtrToPtr<const DumpShapeInfo *>(dumpHead->infoMsg);
    for (size_t i = 0U; i < shapeHead->dim; i++) {
        shape.push_back(shapeHead->shape[i]);
    }
}

void PrintExtraElems(const size_t totalEleNum, const size_t dataNum, size_t &cnt, const std::vector<size_t> &tmpShape,
    std::string &tensorContent)
{
    if (dataNum % tmpShape.back() == 0) {
        tensorContent += std::string(cnt, '[');
    } else {
        tensorContent += ",";
    }
    for (size_t i = dataNum; i < totalEleNum; i++) {
        cnt = 0U;
        for (const size_t s : tmpShape) {
            if ((i + 1U) % s == 0) {
                cnt++;
            }
        }
        tensorContent += "-";
        if (cnt > 0U) {
            tensorContent += std::string(cnt, ']');
            if (i != totalEleNum - 1U) {
                tensorContent += ",\n";
                tensorContent += std::string(cnt, '[');
            }
            continue;
        }
        if (i != totalEleNum - 1U) {
            tensorContent += ",";
        }
    }
}
 
void PrintTensorContent(const std::string& tensorContent) {
    constexpr size_t maxLogLength = 800U;
    const size_t contentLength = tensorContent.length();
    if (contentLength <= maxLogLength) {
        RT_LOG(RT_LOG_INFO, "DumpTensor: %s", tensorContent.c_str());
        return;
    }
 
    const size_t numChunks = (contentLength + maxLogLength - 1U) / maxLogLength;
    for (size_t i = 0; i < numChunks; ++i) {
        const size_t pos = i * maxLogLength;
        const size_t length = std::min(maxLogLength, contentLength - pos);
        const std::string chunk = tensorContent.substr(pos, length);
        RT_LOG(RT_LOG_INFO, "DumpTensor (Part%u):%s", i + 1U, chunk.c_str());
    }
}

void PrintTensorByShape(const DumpTensorInfo *const tensorHead, const std::vector<size_t> &shape,
    const size_t totalNum, const size_t elementsNum)
{
    RT_LOG(RT_LOG_INFO, "print tensor by shape, totalNum is %zu, elementsNum is %zu.", totalNum, elementsNum);
    const auto &iter = PRINT_BY_SHAPE_CALLS.find(tensorHead->dataType);
    if (iter != PRINT_BY_SHAPE_CALLS.end()) {
        if (totalNum != 0) {
            std::vector<size_t> tmpShape = shape;
            for (int32_t i = static_cast<int32_t>(tmpShape.size() - 2U); i >= 0 && shape.size() >= 2U; i--) {
                tmpShape[i] *= tmpShape[i + 1];
            }
            std::string tensorContent = std::string(tmpShape.size(), '[');
            size_t cnt = 0U;
            const uint8_t *const data = RtPtrToPtr<const uint8_t *>(tensorHead) + sizeof(DumpTensorInfo);
            if (totalNum == elementsNum) {
                cnt = (iter->second)(static_cast<const void *>(data), elementsNum, tmpShape, tensorContent, false);
            } else {
                cnt = (iter->second)(static_cast<const void *>(data), elementsNum, tmpShape, tensorContent, true);
                PrintExtraElems(totalNum, elementsNum, cnt, tmpShape, tensorContent);
            }
            std::cout << tensorContent << std::endl;
            PrintTensorContent(tensorContent);
        }
    }
}

void PrintTensorWithShape(
    const std::vector<size_t> &shape, const size_t actualDataNum, const DumpTensorInfo *const tensorHead)
{
    size_t totalNum = 1U;
    std::string shapeStr = "[";
    for (size_t i = 0U; i < shape.size(); i++) {
        if (shape[i] == 0) {
            RT_LOG(RT_LOG_ERROR, "Dump tensor error: shape[%zu] is zero", i);
            return;
        }
        if (totalNum > (std::numeric_limits<size_t>::max() / shape[i])) {
            RT_LOG(RT_LOG_ERROR,
                "Dump tensor error: Multiply all numbers in shape exceeds max size_t=%zu",
                std::numeric_limits<size_t>::max());
            return;
        }
        totalNum *= shape[i];
        shapeStr += std::to_string(shape[i]);
        if (i + 1U < shape.size()) {
            shapeStr += ", ";
        } else {
            shapeStr += "]";
        }
    }
    if (totalNum < actualDataNum) {
        (void)printf(
            "shape is %s, dumpSize is %zu, dumpSize is greater than shapeSize.\n", shapeStr.c_str(), actualDataNum);
        PrintTensorByShape(tensorHead, shape, totalNum, totalNum);
    } else if (totalNum > actualDataNum) {
        (void)printf("shape is %s, dumpSize is %zu, data is not enough.\n", shapeStr.c_str(), actualDataNum);
        PrintTensorByShape(tensorHead, shape, totalNum, actualDataNum);
    } else {
        PrintTensorByShape(tensorHead, shape, totalNum, actualDataNum);
    }
    return;
}

void PrintTensorWithoutShape(const DumpTensorInfo *const tensorHead, const size_t dataNum)
{
    const auto &iter = PRINT_TENSOR_CALLS.find(tensorHead->dataType);
    if (iter != PRINT_TENSOR_CALLS.end()) {
        const uint8_t *const data = RtPtrToPtr<const uint8_t *>(tensorHead) + sizeof(DumpTensorInfo);
        (iter->second)(static_cast<const void *>(data), dataNum);
    }
}

void PrintDumpTensor(const DumpInfoHead *dumpHead, std::vector<size_t> &shape)
{
    RT_LOG(RT_LOG_INFO, "Dump tensor length %u bytes.", dumpHead->infoLen);
    if (static_cast<size_t>(dumpHead->infoLen) < sizeof(DumpTensorInfo)) {
        RT_LOG(RT_LOG_ERROR,
            "Dump tensor length %u bytes is less than the size of DumpTensorInfo (%zu bytes).",
            dumpHead->infoLen, sizeof(DumpTensorInfo));
        return;
    }
    const DumpTensorInfo *const tensorHead = RtPtrToPtr<const DumpTensorInfo *>(dumpHead->infoMsg);
    uint16_t dataTypeSize = 0U;
    const uint32_t dataType = tensorHead->dataType;
    const std::string dtype = DataTypeToString(dataType);
    if (!GetDataTypeSize(dataType, dataTypeSize)) {
        RT_LOG(RT_LOG_ERROR, "Dump tensor doesn't support dtype of %s.", dtype.c_str());
        return;
    }
 
    const std::string addrToHex = ToHex(tensorHead->addr);
    const auto &positionIter = POSITION_MAP.find(tensorHead->position);
    const std::string position =
        (positionIter != POSITION_MAP.end()) ? positionIter->second : std::to_string(tensorHead->position);
    const uint32_t dumpDataSize = tensorHead->dumpSize;
    const size_t actualDataNum = (dumpDataSize == 0U)
                                     ? (static_cast<size_t>(dumpHead->infoLen) - sizeof(DumpTensorInfo)) / dataTypeSize
                                     : static_cast<size_t>(dumpDataSize) / dataTypeSize;
    std::cout << "DumpTensor: desc=" << std::dec << tensorHead->desc << ", addr=0x" << addrToHex;
    std::cout << ", data_type=" << dtype << ", position=" << position << ", dump_size=" << actualDataNum << std::endl;
    RT_LOG(RT_LOG_INFO, "DumpTensor: desc=%u, addr=0x%s, data_type=%s, position=%s, dump_size=%zu.",
        tensorHead->desc, addrToHex.c_str(), dtype.c_str(), position.c_str(), actualDataNum);

    if (!shape.empty()) {
        PrintTensorWithShape(shape, actualDataNum, tensorHead);
        shape = {};
    } else {
        PrintTensorWithoutShape(tensorHead, actualDataNum);
    }
}

void PrintDumpInfo(const DumpInfoHead *dumpHead, std::vector<size_t> &shapeInfo, std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    switch (dumpHead->type) {
        case DumpType::DUMP_SCALAR:
        case DumpType::DUMP_ASSERT:
            PrintDump(dumpHead);
            break;
        case DumpType::DUMP_SHAPE:
            GetDumpShape(dumpHead, shapeInfo);
            break;
        case DumpType::DUMP_TENSOR:
            PrintDumpTensor(dumpHead, shapeInfo);
            break;
        case DumpType::DUMP_TIMESTAMP:
            PrintDumpTimestamp(dumpHead, timeStampInfo);
            break;
        case DumpType::DUMP_SKIP:
            RT_LOG(RT_LOG_INFO, "Skip this dump info for the type.");
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Invalid dump type %u.", static_cast<uint32_t>(dumpHead->type));
            break;
    }
}

void PrintSimtDumpInfo(const DumpInfoHead *dumpHead)
{
    switch (dumpHead->type) {
        case DumpType::DUMP_SIMT_ASSERT:
        case DumpType::DUMP_SIMT_PRINTF:
            PrintSimtDump(dumpHead);
            break;
        case DumpType::DUMP_WAIT:
            RT_LOG(RT_LOG_INFO, "Wait this dump info for the type.");
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Invalid dump type %u.", static_cast<uint32_t>(dumpHead->type));
            break;
    }
}

// 回绕场景
// | blockInfo | readInfo | tlv3 | ... ... | tlv1 | tlv2 | writeInfo |
//                               |         |                         
//                           writeIdx   readIdx
// 普通场景
// | blockInfo | readInfo | ... | tlv1 | tlv2  tlv3 | ... | writeInfo |
//                              |                   |                         
//                           readIdx             writeIdx   
void PrintBlockInfo(const uint8_t *blockData, uint64_t readIdx, const uint64_t writeIdx,
    std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    std::vector<size_t> shape;
    const BlockInfo *blockInfo = RtPtrToPtr<const BlockInfo *>(blockData);
    const uint8_t *addrAddr = blockData + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    uint64_t totalLen = 0U;
    if (writeIdx > readIdx) {
        totalLen = writeIdx - readIdx;
    } else {
        totalLen = blockInfo->remainLen - readIdx + writeIdx;
    }
    uint64_t dataLen = 0U;
    while (dataLen < totalLen) {
        const DumpInfoHead *dumpHead = RtPtrToPtr<const DumpInfoHead *>(addrAddr + readIdx);
        PrintDumpInfo(dumpHead, shape, timeStampInfo);

        readIdx += sizeof(DumpInfoHead) + static_cast<uint64_t>(dumpHead->infoLen); // 不可能出现溢出的情况
        dataLen += sizeof(DumpInfoHead) + static_cast<uint64_t>(dumpHead->infoLen);
        if (readIdx > blockInfo->remainLen - sizeof(DumpInfoHead)) {
            dataLen += blockInfo->remainLen - readIdx;
            readIdx = 0U;
        }
    }
}
} // namespace

rtError_t InitPrintf(void *addr, const size_t blockSize, Driver *curDrv)
{
    NULL_PTR_RETURN(curDrv, RT_ERROR_DRV_NULL);
    auto props = curDrv->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    for (size_t i = 0U; i < totalCoreNum; i++) {
        uint8_t *blockAddr = hostData.data() + blockSize * i;
        BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
        blockInfo->length = static_cast<uint32_t>(blockSize);
        blockInfo->coreId = i;
        blockInfo->blockNum = totalCoreNum;
        blockInfo->remainLen = static_cast<uint32_t>(blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo));
        blockInfo->magic = MAGIC_NUM;
        blockInfo->dumpAddr = RtPtrToValue(addr) + blockSize * i + sizeof(BlockInfo) + sizeof(BlockReadInfo);

        BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
        readInfo->dumpType = DumpType::DUMP_BUFO;
        readInfo->length = 16; // readIdx 和 resv 的大小相加
        readInfo->readIdx = 0U;

        BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
        writeInfo->dumpType = DumpType::DUMP_BUFI;
        writeInfo->length = 16; // writeIdx 和 packIdx 的大小相加
        writeInfo->writeIdx = readInfo->readIdx; // 初始化和readIdx一致
    }

    const rtError_t ret = curDrv->MemCopySync(addr, totalLen, hostData.data(), totalLen, RT_MEMCPY_HOST_TO_DEVICE, false);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync h2d failed, ret=%u", ret);
    return RT_ERROR_NONE;
}

rtError_t InitSimtPrintf(void *addr, const size_t blockSize, Driver *curDrv)
{
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);

    uint8_t *blockAddr = hostData.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = static_cast<uint32_t>(blockSize);
    blockInfo->remainLen =static_cast<uint32_t>(blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo));
    blockInfo->magic = MAGIC_NUM;
    blockInfo->flag = PRINT_SIMT;
    blockInfo->dumpAddr = RtPtrToValue(addr) + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->dumpType = DumpType::DUMP_BUFO;
    readInfo->length = 16; // readIdx 和 resv 的大小相加
    readInfo->readIdx = 0U;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->dumpType = DumpType::DUMP_BUFI;
    writeInfo->length = 16;                  // writeIdx 和 packIdx 的大小相加
    writeInfo->writeIdx = readInfo->readIdx; // 初始化和readIdx一致
    
    NULL_PTR_RETURN(curDrv, RT_ERROR_DRV_NULL);
    const rtError_t ret = curDrv->MemCopySync(addr, totalLen, hostData.data(), totalLen, RT_MEMCPY_HOST_TO_DEVICE, false);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync h2d failed, ret=%u", ret);
    return RT_ERROR_NONE;
}

rtError_t ParsePrintf(void *addr, const size_t blockSize, Driver *curDrv)
{
    NULL_PTR_RETURN(curDrv, RT_ERROR_DRV_NULL);
    auto props = curDrv->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);
    rtError_t ret = curDrv->MemCopySync(hostData.data(), totalLen, addr, totalLen, RT_MEMCPY_DEVICE_TO_HOST, false);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync d2h failed, ret=%u", ret);

    std::vector<MsprofAicTimeStampInfo> timeStampInfo;

    for (size_t i = 0U; i < totalCoreNum; i++) {
        uint8_t *blockAddr = hostData.data() + blockSize * i;
        BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
        const BlockWriteInfo *writeInfo =
            RtPtrToPtr<const BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));

        // 校验readIdx和writeIdx在合法的范围内
        const BlockInfo *blockInfo = RtPtrToPtr<const BlockInfo *>(blockAddr);
        COND_RETURN_ERROR((readInfo->readIdx > blockInfo->remainLen), RT_ERROR_INVALID_VALUE,
            "Read idx %llu is invalid, cannot be greater than %u.", readInfo->readIdx, blockInfo->remainLen);
        COND_RETURN_ERROR((writeInfo->writeIdx > blockInfo->remainLen), RT_ERROR_INVALID_VALUE,
            "Write idx %llu is invalid, cannot be greater than %u.", writeInfo->writeIdx, blockInfo->remainLen);
        if (readInfo->readIdx == writeInfo->writeIdx) { // 表示没有信息更新
            RT_LOG(RT_LOG_DEBUG, "Block info[%zu] writeIdx %llu has no info updates.", i, writeInfo->writeIdx);
            continue;
        }

        // 更新读指针
        const uint64_t readIdx = readInfo->readIdx;
        readInfo->readIdx = writeInfo->writeIdx;
        void *deviceAddr = RtValueToPtr<void *>(RtPtrToValue(addr) + blockSize * i + sizeof(BlockInfo));
        ret = curDrv->MemCopySync(
            deviceAddr, sizeof(BlockReadInfo), readInfo, sizeof(BlockReadInfo), RT_MEMCPY_HOST_TO_DEVICE, false);
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync h2d failed, ret=%u", ret);

        PrintBlockInfo(blockAddr, readIdx, writeInfo->writeIdx, timeStampInfo);
    }
    ReportTimeStampInfo(timeStampInfo);
    return RT_ERROR_NONE;
}

static rtError_t CollectDumpInfoFromBuffer(const uint8_t* dumpReadStartAddr, 
                                       uint64_t totalReadBufLen,
                                       std::vector<const DumpInfoHead*>& dumpInfoHolds,
                                       uint64_t& processedLen, const uint64_t packIdx, const Device * const device) {
    processedLen = 0U;
    uint64_t dumpInfoLen = 0U;

    while (processedLen < totalReadBufLen) {
        const DumpInfoHead *dumpHead = RtPtrToPtr<const DumpInfoHead *>(dumpReadStartAddr + processedLen);
        // packIdx和tlvCnt相等表示数据已经处理结束，只处理 asset 和 print 类型，其他均视为无效类型
        if ((packIdx == device->GetSimtPrintTlvCnt()) || 
            (dumpHead->type != DumpType::DUMP_SIMT_ASSERT && dumpHead->type != DumpType::DUMP_SIMT_PRINTF)) {
            RT_LOG(RT_LOG_DEBUG, "collect dump info break, packIdx=%llu, tlvCnt=%llu, type %u", packIdx,
                device->GetSimtPrintTlvCnt(), dumpHead->type);
            break;
        }

        dumpInfoLen = sizeof(DumpInfoHead) + static_cast<uint64_t>(dumpHead->infoLen);
        dumpInfoHolds.emplace_back(dumpHead);
        processedLen += dumpInfoLen;
        device->AddSimtPrintTlvCnt(1U);
    }
    return RT_ERROR_NONE;
}

rtError_t GetReadLenAndAddr(uint8_t *blockAddr, const size_t blockSize, uint64_t &totalReadBufLen,
                            const uint8_t *&dumpReadStartAddr, std::vector<uint8_t> &dumpInfoVec) {
    const BlockInfo *blockInfo = RtPtrToPtr<const BlockInfo *>(blockAddr);
    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    const BlockWriteInfo *writeInfo =
    RtPtrToPtr<const BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    const uint8_t *dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    const uint64_t readIdx = readInfo->readIdx % blockInfo->remainLen;
    const uint64_t writeIdx = writeInfo->writeIdx % blockInfo->remainLen;

    if (writeInfo->writeIdx - readInfo->readIdx > blockInfo->remainLen) {
        totalReadBufLen = blockInfo->remainLen;
        dumpInfoVec.resize(totalReadBufLen, 0);
        (void)memcpy_s(dumpInfoVec.data(), blockInfo->remainLen - readIdx, dumpStartAddr + readIdx, blockInfo->remainLen - readIdx);
        (void)memcpy_s(dumpInfoVec.data() + blockInfo->remainLen - readIdx, readIdx, dumpStartAddr, readIdx);
        dumpReadStartAddr = dumpInfoVec.data();
    } else {
        if (readIdx > writeIdx) {
            totalReadBufLen = blockInfo->remainLen - readIdx + writeIdx;
            dumpInfoVec.resize(totalReadBufLen, 0);
            (void)memcpy_s(dumpInfoVec.data(), blockInfo->remainLen - readIdx, dumpStartAddr + readIdx, blockInfo->remainLen - readIdx);
            (void)memcpy_s(dumpInfoVec.data() + blockInfo->remainLen - readIdx, writeIdx, dumpStartAddr, writeIdx);
            dumpReadStartAddr = dumpInfoVec.data();
        } else {
            totalReadBufLen = writeIdx - readIdx;
            dumpReadStartAddr = dumpStartAddr + readIdx;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ParseSimtPrintf(void *addr, const size_t blockSize, Driver *curDrv, const Device * const dev)
{
    NULL_PTR_RETURN(curDrv, RT_ERROR_DRV_NULL);
    // D2H拷贝
    std::vector<uint8_t> hostData(blockSize, 0);
    rtError_t ret = curDrv->MemCopySync(hostData.data(), blockSize, addr, blockSize, RT_MEMCPY_DEVICE_TO_HOST, false);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync d2h failed, ret=%u", ret);

    // 解析头部信息
    uint8_t *blockAddr = hostData.data();
    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    const BlockWriteInfo *writeInfo =
    RtPtrToPtr<const BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    // 校验readIdx和writeIdx在合法的范围内
    COND_RETURN_ERROR((readInfo->readIdx > writeInfo->writeIdx), RT_ERROR_INVALID_VALUE,
        "Read idx %llu cannot be greater than write idx %llu.", readInfo->readIdx, writeInfo->writeIdx);
    // 表示没有信息更新
    if (readInfo->readIdx == writeInfo->writeIdx) {
        RT_LOG(RT_LOG_DEBUG, "Block info writeIdx %llu has no info updates.", writeInfo->writeIdx);
        return RT_ERROR_NONE;
    }

    uint64_t totalReadBufLen = 0U;
    const uint8_t *dumpReadStartAddr;
    std::vector<uint8_t> dumpInfoVec;
    // 如果涉及回绕，直接申请成连续的内存;
    ret = GetReadLenAndAddr(blockAddr, blockSize, totalReadBufLen, dumpReadStartAddr, dumpInfoVec);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "Get read buffer len and addr failed, ret=%u", ret);
    
    uint64_t processedLen = 0U;
    std::vector<const DumpInfoHead *> dumpInfoHolds;
    ret = CollectDumpInfoFromBuffer(dumpReadStartAddr, totalReadBufLen, dumpInfoHolds, processedLen, writeInfo->packIdx, dev);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "collect dump info failed, ret=%u", ret);

    // 更新读指针
    readInfo->readIdx = readInfo->readIdx + processedLen;
    void *deviceAddr = RtValueToPtr<void *>(RtPtrToValue(addr) + sizeof(BlockInfo));
    ret = curDrv->MemCopySync(
        deviceAddr, sizeof(BlockReadInfo), readInfo, sizeof(BlockReadInfo), RT_MEMCPY_HOST_TO_DEVICE, false);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "MemCopySync h2d failed, ret=%u", ret);

    for (const DumpInfoHead *dumpHead : dumpInfoHolds) {
        PrintSimtDumpInfo(dumpHead);
    }

    return RT_ERROR_NONE;
}
} // runtime
} // cce
