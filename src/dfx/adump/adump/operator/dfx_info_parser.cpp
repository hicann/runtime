/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dfx_info_parser.h"

#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>
#include <cstring>
#include <iostream>
#include <set>
#include <atomic>

#include "log/hdc_log.h"
#include "fp16_t.h"
#include "bfloat16.h"
#include "hifloat.h"
#include "rt_inner_dfx.h"
#include "runtime/base.h"
#include "dfx_struct.h"
#include "dump_printf.h"
#include "kernel_dfx_dumper.h"

namespace Adx {
namespace {

constexpr uint32_t MODULE_ID_ADUMP = 200U;

std::atomic<uint64_t> g_profSwitch{0U};

rtError_t ProfCtrlCallback(uint32_t dataType, void* data, uint32_t dataLen)
{
    if ((dataType == RT_PROF_CTRL_SWITCH) && (data != nullptr) && (dataLen == sizeof(rtProfCommandHandle_t))) {
        const auto* cmd = static_cast<const rtProfCommandHandle_t*>(data);
        g_profSwitch.store(cmd->profSwitch, std::memory_order_relaxed);
        IDE_LOGI("Prof switch updated, profSwitch=%#llx.", static_cast<unsigned long long>(cmd->profSwitch));
    }
    return RT_ERROR_NONE;
}

uint64_t GetProfSwitchData() { return g_profSwitch.load(std::memory_order_relaxed); }

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
constexpr uint32_t PRINT_SIMD = 0U;
constexpr uint32_t PRINT_SIMT = 2U;

constexpr uint32_t GE_DT_FLOAT = 0U;
constexpr uint32_t GE_DT_FLOAT16 = 1U;
constexpr uint32_t GE_DT_INT8 = 2U;
constexpr uint32_t GE_DT_INT32 = 3U;
constexpr uint32_t GE_DT_UINT8 = 4U;
constexpr uint32_t GE_DT_INT16 = 6U;
constexpr uint32_t GE_DT_UINT16 = 7U;
constexpr uint32_t GE_DT_UINT32 = 8U;
constexpr uint32_t GE_DT_INT64 = 9U;
constexpr uint32_t GE_DT_UINT64 = 10U;
constexpr uint32_t GE_DT_DOUBLE = 11U;
constexpr uint32_t GE_DT_BOOL = 12U;
constexpr uint32_t GE_DT_STRING = 13U;
constexpr uint32_t GE_DT_COMPLEX64 = 16U;
constexpr uint32_t GE_DT_COMPLEX128 = 17U;
constexpr uint32_t GE_DT_BF16 = 27U;
constexpr uint32_t GE_DT_HIFLOAT8 = 34U;
constexpr uint32_t GE_DT_FLOAT8_E5M2 = 35U;
constexpr uint32_t GE_DT_FLOAT8_E4M3FN = 36U;
constexpr uint32_t GE_DT_FLOAT8_E8M0 = 37U;

using BlockInfo = cce::runtime::BlockInfo;
using BlockReadInfo = cce::runtime::BlockReadInfo;
using BlockWriteInfo = cce::runtime::BlockWriteInfo;
using DumpInfoHead = cce::runtime::DumpInfoHead;
using DumpTensorInfo = cce::runtime::DumpTensorInfo;
using DumpShapeInfo = cce::runtime::DumpShapeInfo;
using DumpTimeStampInfoMsg = cce::runtime::DumpTimeStampInfoMsg;
using DumpTensorPosition = cce::runtime::DumpTensorPosition;
using cce::runtime::RT_DUMP_SHAPE_MAX_SIZE;
using cce::runtime::RT_KERNEL_DFX_INFO_CORE_TYPE_AICPU;
using cce::runtime::RT_KERNEL_DFX_INFO_CORE_TYPE_SIMT;
using DfxDumpType = cce::runtime::DumpType;

constexpr uint64_t BLOCK_METADATA_LEN = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(BlockWriteInfo);

template <typename T>
std::string ToHex(T num)
{
    std::stringstream stream;
    stream << std::hex << num;
    return stream.str();
}

template <typename T>
std::string ToUpperHex(T num)
{
    std::stringstream stream;
    stream << std::uppercase << std::hex << num;
    return stream.str();
}

inline int32_t ConvertToStd(uint8_t data) { return static_cast<int32_t>(data); }
inline int32_t ConvertToStd(int8_t data) { return static_cast<int32_t>(data); }

template <typename T>
inline T ConvertToStd(const T& data)
{
    return data;
}

inline float ConvertToStd(fp16_t data) { return data.toFloat(); }
inline float ConvertToStd(BFloat16 data) { return data.GetValue(); }
inline float ConvertToStd(HiFloat8 data) { return data.GetValue(); }
inline float ConvertToStd(Fp8E5M2 data) { return data.GetValue(); }
inline float ConvertToStd(Fp8E4M3 data) { return data.GetValue(); }
inline float ConvertToStd(Fp8E8M0 data) { return data.GetValue(); }

const std::unordered_map<uint16_t, std::string> POSITION_MAP = {
    {static_cast<uint16_t>(DumpTensorPosition::GM), "GM"},
    {static_cast<uint16_t>(DumpTensorPosition::UB), "UB"},
    {static_cast<uint16_t>(DumpTensorPosition::L1), "L1"},
    {static_cast<uint16_t>(DumpTensorPosition::L0A), "L0A"},
    {static_cast<uint16_t>(DumpTensorPosition::L0B), "L0B"},
    {static_cast<uint16_t>(DumpTensorPosition::L0C), "L0C"},
    {static_cast<uint16_t>(DumpTensorPosition::BIAS), "BIAS"},
    {static_cast<uint16_t>(DumpTensorPosition::FIXBUF), "FIXBUF"},
    {static_cast<uint16_t>(DumpTensorPosition::REG), "REG"},
};

template <typename T>
inline T ParseParam(const uint8_t* beginAddr, const uint32_t paramIndex)
{
    const T* paramAddr = reinterpret_cast<const T*>(beginAddr + paramIndex * PRINT_ARG_LEN);
    return *paramAddr;
}

static void PrintFormatD(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatI(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatF(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const float paramInfo = ParseParam<float>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatFUpper(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const float paramInfo = ParseParam<float>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatU(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const uint64_t paramInfo = ParseParam<uint64_t>(paramBegin, paramIndex);
    printInfo += std::to_string(paramInfo);
}

static void PrintFormatP(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const void* paramInfo = ParseParam<void*>(paramBegin, paramIndex);
    std::stringstream stream;
    stream << paramInfo;
    printInfo += stream.str();
}

static void PrintFormatX(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += ToHex(paramInfo);
}

static void PrintFormatXUpper(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    const int64_t paramInfo = ParseParam<int64_t>(paramBegin, paramIndex);
    printInfo += ToUpperHex(paramInfo);
}

static void PrintFormatS(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    // DumpInfoHead 中infoMsg前面就是当前dump块的Len，占4字节,infoMsg前面是8字节的预留字段
    const uint64_t infoLen = *reinterpret_cast<const uint32_t*>(paramBegin - PRINT_MSG_LEN_OFFSET);
    const uint64_t paramOffset = RESV_LEN + static_cast<uint64_t>(paramIndex) * PRINT_ARG_LEN;
    if ((paramOffset > infoLen) || ((infoLen - paramOffset) < PRINT_ARG_LEN)) {
        IDE_LOGW(
            "String param index[%u] is outside info length[%llu bytes].", paramIndex,
            static_cast<unsigned long long>(infoLen));
        return;
    }
    const uint64_t* offsetAddr = reinterpret_cast<const uint64_t*>(paramBegin + paramIndex * PRINT_ARG_LEN);
    const uint64_t strOffset = *offsetAddr;
    const uint64_t maxStrOffset = infoLen - paramOffset;
    if ((strOffset < PRINT_ARG_LEN) || (strOffset > maxStrOffset)) {
        IDE_LOGW(
            "Invalid string param offset[%llu]. Expected range is [%u, %llu].",
            static_cast<unsigned long long>(strOffset), PRINT_ARG_LEN, static_cast<unsigned long long>(maxStrOffset));
        return;
    }
    const char* data = reinterpret_cast<const char*>(offsetAddr) + strOffset;
    const size_t maxLen = static_cast<size_t>(maxStrOffset - strOffset);
    const size_t dataLen = strnlen(data, maxLen);
    IDE_LOGD("Get string param length[%zu bytes], max length[%zu bytes].", dataLen, maxLen);
    if (dataLen == maxLen) {
        IDE_LOGW("String param length is greater than max length[%zu bytes]", maxLen);
        return;
    }
    std::stringstream stream;
    stream << data;
    printInfo += stream.str();
}

static void SimtPrintFormatS(const uint8_t* paramBegin, std::string& printInfo, const uint32_t paramIndex)
{
    // DumpInfoHead 中infoMsg前面就是当前dump块的Len，占4字节,infoMsg前面是40字节的预留字段
    const uint64_t infoLen = *reinterpret_cast<const uint32_t*>(paramBegin - SIMT_PRINT_MSG_LEN_OFFSET);
    const uint64_t paramOffset = RESV_LEN_SIMT + static_cast<uint64_t>(paramIndex) * PRINT_ARG_LEN;
    if ((paramOffset > infoLen) || ((infoLen - paramOffset) < PRINT_ARG_LEN)) {
        IDE_LOGW(
            "String param index[%u] is outside info length[%llu bytes].", paramIndex,
            static_cast<unsigned long long>(infoLen));
        return;
    }
    const uint64_t* offsetAddr = reinterpret_cast<const uint64_t*>(paramBegin + paramIndex * PRINT_ARG_LEN);
    const uint64_t strOffset = *offsetAddr;
    const uint64_t maxStrOffset = infoLen - paramOffset;
    if ((strOffset < PRINT_ARG_LEN) || (strOffset > maxStrOffset)) {
        IDE_LOGW(
            "Invalid string param offset[%llu]. Expected range is [%u, %llu].",
            static_cast<unsigned long long>(strOffset), PRINT_ARG_LEN, static_cast<unsigned long long>(maxStrOffset));
        return;
    }
    const char* data = reinterpret_cast<const char*>(offsetAddr) + strOffset;
    const size_t maxLen = static_cast<size_t>(maxStrOffset - strOffset);
    const size_t dataLen = strnlen(data, maxLen);
    IDE_LOGD("Get string param length[%zu bytes], max length[%zu bytes].", dataLen, maxLen);
    if (dataLen == maxLen) {
        IDE_LOGW("String param length is greater than max length[%zu bytes]", maxLen);
        return;
    }
    std::stringstream stream;
    stream << data;
    printInfo += stream.str();
}

const std::unordered_map<std::string, std::function<void(const uint8_t*, std::string&, const uint32_t)>>
    SIMT_PRINT_FORMAT_CALLS{
        {"d", &PrintFormatD},       {"ld", &PrintFormatD},       {"lld", &PrintFormatD},  {"i", &PrintFormatI},
        {"li", &PrintFormatI},      {"lli", &PrintFormatI},      {"f", &PrintFormatF},    {"F", &PrintFormatFUpper},
        {"u", &PrintFormatU},       {"lu", &PrintFormatU},       {"llu", &PrintFormatU},  {"p", &PrintFormatP},
        {"x", &PrintFormatX},       {"lx", &PrintFormatX},       {"llx", &PrintFormatX},  {"X", &PrintFormatXUpper},
        {"lX", &PrintFormatXUpper}, {"llX", &PrintFormatXUpper}, {"s", &SimtPrintFormatS}};

const std::unordered_map<std::string, std::function<void(const uint8_t*, std::string&, const uint32_t)>>
    SIMD_PRINT_FORMAT_CALLS{
        {"d", &PrintFormatD},       {"ld", &PrintFormatD},       {"lld", &PrintFormatD}, {"i", &PrintFormatI},
        {"li", &PrintFormatI},      {"lli", &PrintFormatI},      {"f", &PrintFormatF},   {"F", &PrintFormatFUpper},
        {"u", &PrintFormatU},       {"lu", &PrintFormatU},       {"llu", &PrintFormatU}, {"p", &PrintFormatP},
        {"x", &PrintFormatX},       {"lx", &PrintFormatX},       {"llx", &PrintFormatX}, {"X", &PrintFormatXUpper},
        {"lX", &PrintFormatXUpper}, {"llX", &PrintFormatXUpper}, {"s", &PrintFormatS}};

std::string ParseFormat(const char* format)
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

void ParsePrintToLog(
    const char* format, const uint8_t* paramBegin, const uint32_t paramNum, const bool isAssert, uint32_t flag)
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
        const std::string& tempFormat = ParseFormat(format);
        const auto& iter = formatMap.find(tempFormat);
        if (iter == formatMap.end()) {
            printInfo += "%";
            if (tempFormat[0] == '%') { // 支持 %% 打印
                format++;
                continue;
            }
            IDE_LOGW("The print format [%%%s] is illegal.", tempFormat.c_str());
            if (tempFormat[0] != '\0') { // 正文末尾不是%的处理
                printInfo += tempFormat;
                format += tempFormat.size();
            }
            break;
        }
        paramIndex++;
        if (paramIndex > paramNum) {
            IDE_LOGW(
                "There are too many placeholders (>=%u). The actual number of parameters is %u.", paramIndex, paramNum);
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
            IDE_LOGE("%s", printInfo.substr(curIdx, curLen).c_str());
        } else {
            IDE_LOGI("PrintInfo: %s", printInfo.substr(curIdx, curLen).c_str());
        }
    }
}

void PrintDumpBase(const DumpInfoHead* dumpHead, uint32_t flag)
{
    const uint32_t resvOffset = (flag == PRINT_SIMT) ? RESV_LEN_SIMT : RESV_LEN;
    IDE_LOGD("Get dump print dataLen[%u bytes].", dumpHead->infoLen);
    // 预留8字节, strOffset占位8字节
    if (dumpHead->infoLen < (PRINT_ARG_LEN + resvOffset)) {
        IDE_LOGW("dumpHead infoLen(%u) is too small", dumpHead->infoLen);
        return;
    }

    const uint64_t strOffset = *(reinterpret_cast<const uint64_t*>(dumpHead->infoMsg + resvOffset));
    const uint64_t maxStrOffset = static_cast<uint64_t>(dumpHead->infoLen - resvOffset);
    if ((strOffset < PRINT_ARG_LEN) || (strOffset > maxStrOffset)) {
        IDE_LOGW(
            "Invalid print strOffset[%llu]. Expected range is [%u, %llu].", static_cast<unsigned long long>(strOffset),
            PRINT_ARG_LEN, static_cast<unsigned long long>(maxStrOffset));
        return;
    }
    // 第一个位置填的是offset，所以通过-1得到的实际参数个数
    const uint32_t argsNum = static_cast<uint32_t>(strOffset / PRINT_ARG_LEN - 1U);
    const char* str = reinterpret_cast<const char*>(dumpHead->infoMsg + strOffset + resvOffset);
    const size_t maxStrLen = static_cast<size_t>(maxStrOffset - strOffset);
    const size_t strLen = strnlen(str, maxStrLen);
    IDE_LOGD("Get print str len[%zu bytes]", strLen);
    if (strLen == maxStrLen) {
        IDE_LOGW("Print str len is greater than or equal to max length[%zu bytes].", maxStrLen);
        return;
    }

    const bool isAssert =
        (dumpHead->type == DfxDumpType::DUMP_ASSERT || dumpHead->type == DfxDumpType::DUMP_SIMT_ASSERT);
    ParsePrintToLog(str, reinterpret_cast<const uint8_t*>(dumpHead->infoMsg + resvOffset), argsNum, isAssert, flag);
}

void PrintDump(const DumpInfoHead* dumpHead) { PrintDumpBase(dumpHead, PRINT_SIMD); }

void PrintAicpuDump(const DumpInfoHead* dumpHead)
{
    constexpr uint64_t minInfoLen = static_cast<uint64_t>(RESV_LEN) + PRINT_ARG_LEN + 1U;
    IDE_LOGD("Get aicpu dump print dataLen[%u bytes].", dumpHead->infoLen);
    if (static_cast<uint64_t>(dumpHead->infoLen) < minInfoLen) {
        IDE_LOGW("Aicpu dumpHead infoLen(%u) is too small", dumpHead->infoLen);
        return;
    }

    const uint64_t strOffset = *(reinterpret_cast<const uint64_t*>(dumpHead->infoMsg + RESV_LEN));
    if (strOffset != PRINT_ARG_LEN) {
        IDE_LOGW("Aicpu dumpHead strOffset(%llu) is invalid", static_cast<unsigned long long>(strOffset));
        return;
    }

    const uint64_t stringOffset = static_cast<uint64_t>(RESV_LEN) + strOffset;
    const size_t maxStrLen = static_cast<size_t>(static_cast<uint64_t>(dumpHead->infoLen) - stringOffset);
    const char* str = reinterpret_cast<const char*>(dumpHead->infoMsg + stringOffset);
    const size_t strLen = strnlen(str, maxStrLen);
    if (strLen == maxStrLen) {
        IDE_LOGW("Aicpu print string is not terminated within infoLen(%u)", dumpHead->infoLen);
        return;
    }

    const std::string printInfo(str, strLen);
    for (size_t curIdx = 0; curIdx < printInfo.size(); curIdx += MAX_LOG_LENGTH) {
        const size_t curLen =
            (curIdx + MAX_LOG_LENGTH > printInfo.size()) ? (printInfo.size() - curIdx) : MAX_LOG_LENGTH;
        const std::string chunk = printInfo.substr(curIdx, curLen);
        (void)printf("%s", chunk.c_str());
        IDE_LOGI("PrintInfo: %s", chunk.c_str());
    }
}
void PrintSimtDump(const DumpInfoHead* dumpHead) { PrintDumpBase(dumpHead, PRINT_SIMT); }

void PrintBoolTensor(const void* data, const size_t dataNum)
{
    if (dataNum == 0U) {
        std::cout << "[]" << std::endl;
        IDE_LOGI("DumpTensor: []");
        return;
    }
    const uint8_t* nums = static_cast<const uint8_t*>(data);
    std::cout << "[";
    std::string tensorData = "[";
    for (size_t i = 0U; i < dataNum; ++i) {
        if (bool(nums[i])) {
            std::cout << 1;
            tensorData += "1";
        } else {
            std::cout << 0;
            tensorData += "0";
        }
        if (i == dataNum - 1U) {
            std::cout << "]" << std::endl;
            tensorData += "]";
            IDE_LOGI("DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                IDE_LOGI("DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}

template <typename T>
void PrintTensor(const void* data, const size_t dataNum)
{
    if (dataNum == 0U) {
        std::cout << "[]" << std::endl;
        IDE_LOGI("DumpTensor: []");
        return;
    }
    const T* nums = reinterpret_cast<const T*>(data);
    std::cout << "[";
    std::string tensorData = "[";
    for (size_t i = 0U; i < dataNum; ++i) {
        const auto num = ConvertToStd(nums[i]);
        std::cout << std::to_string(num);
        tensorData += std::to_string(num);
        if (i == dataNum - 1U) {
            std::cout << "]" << std::endl;
            tensorData += "]";
            IDE_LOGI("DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                IDE_LOGI("DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}

const std::unordered_map<uint32_t, std::function<void(const void*, const size_t)>> PRINT_TENSOR_CALLS{
    {GE_DT_UINT8, &PrintTensor<uint8_t>},       {GE_DT_INT8, &PrintTensor<int8_t>},
    {GE_DT_INT16, &PrintTensor<int16_t>},       {GE_DT_UINT16, &PrintTensor<uint16_t>},
    {GE_DT_INT32, &PrintTensor<int32_t>},       {GE_DT_UINT32, &PrintTensor<uint32_t>},
    {GE_DT_INT64, &PrintTensor<int64_t>},       {GE_DT_UINT64, &PrintTensor<uint64_t>},
    {GE_DT_FLOAT, &PrintTensor<float>},         {GE_DT_FLOAT16, &PrintTensor<fp16_t>},
    {GE_DT_BF16, &PrintTensor<BFloat16>},       {GE_DT_HIFLOAT8, &PrintTensor<HiFloat8>},
    {GE_DT_FLOAT8_E5M2, &PrintTensor<Fp8E5M2>}, {GE_DT_FLOAT8_E4M3FN, &PrintTensor<Fp8E4M3>},
    {GE_DT_FLOAT8_E8M0, &PrintTensor<Fp8E8M0>}, {GE_DT_BOOL, &PrintBoolTensor},
};

static void AppendBracketsAndNewlines(
    std::string& tensorContent, const size_t cnt, const bool flag, const size_t index, const size_t dataNum)
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
    std::string& tensorContent, const size_t cnt, const bool flag, const size_t index, const size_t dataNum)
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
static size_t PrintValidTensorData(
    const void* data, const size_t dataNum, const std::vector<size_t>& tmpShape, std::string& tensorContent,
    const bool flag)
{
    const T* dumpTensor = static_cast<const T*>(data);
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

size_t PrintValidTensorBoolData(
    const void* data, const size_t dataNum, const std::vector<size_t>& tmpShape, std::string& tensorContent,
    const bool flag)
{
    const uint8_t* dumpTensor = static_cast<const uint8_t*>(data);
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

const std::unordered_map<uint32_t, uint16_t> SUPPORT_DATA_TYPE_SIZE{
    {GE_DT_UINT8, 1U},
    {GE_DT_INT8, 1U},
    {GE_DT_BOOL, 1U},
    {GE_DT_INT16, INT16_SIZE},
    {GE_DT_UINT16, INT16_SIZE},
    {GE_DT_INT32, INT32_SIZE},
    {GE_DT_UINT32, INT32_SIZE},
    {GE_DT_INT64, INT64_SIZE},
    {GE_DT_UINT64, INT64_SIZE},
    {GE_DT_FLOAT, INT32_SIZE},
    {GE_DT_FLOAT16, INT16_SIZE},
    {GE_DT_BF16, INT16_SIZE},
    {GE_DT_HIFLOAT8, 1U},
    {GE_DT_FLOAT8_E5M2, 1U},
    {GE_DT_FLOAT8_E4M3FN, 1U},
    {GE_DT_FLOAT8_E8M0, 1U}};

bool GetDataTypeSize(uint32_t dataType, uint16_t& size)
{
    const auto& iter = SUPPORT_DATA_TYPE_SIZE.find(dataType);
    if (iter != SUPPORT_DATA_TYPE_SIZE.end()) {
        size = iter->second;
        return true;
    }
    return false;
}

static std::string DataTypeToString(uint32_t dataType)
{
    static std::map<uint32_t, std::string> dtype = {
        {GE_DT_FLOAT, "float32"},
        {GE_DT_FLOAT16, "float16"},
        {GE_DT_INT8, "int8"},
        {GE_DT_INT32, "int32"},
        {GE_DT_UINT8, "uint8"},
        {GE_DT_INT16, "int16"},
        {GE_DT_UINT16, "uint16"},
        {GE_DT_UINT32, "uint32"},
        {GE_DT_INT64, "int64"},
        {GE_DT_UINT64, "uint64"},
        {GE_DT_DOUBLE, "double"},
        {GE_DT_BOOL, "bool"},
        {GE_DT_STRING, "string"},
        {GE_DT_COMPLEX64, "complex64"},
        {GE_DT_COMPLEX128, "complex128"},
        {GE_DT_BF16, "bfloat16"},
        {GE_DT_HIFLOAT8, "hifloat8"},
        {GE_DT_FLOAT8_E5M2, "float8_e5m2"},
        {GE_DT_FLOAT8_E4M3FN, "float8_e4m3fn"},
        {GE_DT_FLOAT8_E8M0, "float8_e8m0"}};
    auto iter = dtype.find(dataType);
    if (iter != dtype.end()) {
        return (iter->second).c_str();
    }
    return "Unknown dumpDataType";
}

const std::unordered_map<
    uint32_t, std::function<size_t(const void*, const size_t, const std::vector<size_t>&, std::string&, const size_t)>>
    PRINT_BY_SHAPE_CALLS{
        {GE_DT_UINT8, &PrintValidTensorData<uint8_t>},
        {GE_DT_INT8, &PrintValidTensorData<int8_t>},
        {GE_DT_INT16, &PrintValidTensorData<int16_t>},
        {GE_DT_UINT16, &PrintValidTensorData<uint16_t>},
        {GE_DT_INT32, &PrintValidTensorData<int32_t>},
        {GE_DT_UINT32, &PrintValidTensorData<uint32_t>},
        {GE_DT_INT64, &PrintValidTensorData<int64_t>},
        {GE_DT_UINT64, &PrintValidTensorData<uint64_t>},
        {GE_DT_FLOAT, &PrintValidTensorData<float>},
        {GE_DT_FLOAT16, &PrintValidTensorData<fp16_t>},
        {GE_DT_BOOL, &PrintValidTensorBoolData},
        {GE_DT_BF16, &PrintValidTensorData<BFloat16>},
        {GE_DT_HIFLOAT8, &PrintValidTensorData<HiFloat8>},
        {GE_DT_FLOAT8_E5M2, &PrintValidTensorData<Fp8E5M2>},
        {GE_DT_FLOAT8_E4M3FN, &PrintValidTensorData<Fp8E4M3>},
        {GE_DT_FLOAT8_E8M0, &PrintValidTensorData<Fp8E8M0>}};

void GetDumpShape(const DumpInfoHead* dumpHead, std::vector<size_t>& shape)
{
    shape = {};
    if (static_cast<size_t>(dumpHead->infoLen) < sizeof(DumpShapeInfo)) {
        IDE_LOGW(
            "The value of dumpHead->infoLen %u must be greater than or equal to that of DumpShapeInfo %zu.",
            dumpHead->infoLen, sizeof(DumpShapeInfo));
        return;
    }
    const DumpShapeInfo* const shapeHead = reinterpret_cast<const DumpShapeInfo*>(dumpHead->infoMsg);
    if (shapeHead->dim > cce::runtime::RT_DUMP_SHAPE_MAX_SIZE) {
        IDE_LOGW(
            "The dim of DumpShape is %u, which exceeds the maximum limit of %u.", shapeHead->dim,
            cce::runtime::RT_DUMP_SHAPE_MAX_SIZE);
        (void)printf(
            "The dim of DumpShape is %u, which exceeds the maximum limit of %u.\n", shapeHead->dim,
            cce::runtime::RT_DUMP_SHAPE_MAX_SIZE);
        return;
    }
    for (uint32_t i = 0U; i < shapeHead->dim; i++) {
        shape.push_back(shapeHead->shape[i]);
    }
}
void GetDumpTensorShape(const DumpTensorInfo* tensorHead, std::vector<size_t>& shape)
{
    // if DumpTensor's shape dim exceeds the maximum limit of shape, discard shape info.
    if (tensorHead->dim > cce::runtime::RT_DUMP_SHAPE_MAX_SIZE) {
        IDE_LOGW(
            "The dim of DumpTensor is %u, which exceeds the maximum limit of %u.", tensorHead->dim,
            cce::runtime::RT_DUMP_SHAPE_MAX_SIZE);
        (void)printf(
            "The dim of DumpTensor is %u, which exceeds the maximum limit of %u.\n", tensorHead->dim,
            cce::runtime::RT_DUMP_SHAPE_MAX_SIZE);
        shape = {};
        return;
    }

    // if DumpTensor's shape dim is zero, use DumpShape to print.
    if (tensorHead->dim == 0U) {
        IDE_LOGD("The dim of DumpTensor is %u.", tensorHead->dim);
        return;
    }
    shape = {};
    for (uint32_t i = 0U; i < tensorHead->dim; i++) {
        shape.push_back(tensorHead->shape[i]);
    }
}

void PrintExtraElems(
    const size_t totalEleNum, const size_t dataNum, size_t& cnt, const std::vector<size_t>& tmpShape,
    std::string& tensorContent)
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

void PrintTensorContent(const std::string& tensorContent)
{
    constexpr size_t maxLogLength = 800U;
    const size_t contentLength = tensorContent.length();
    if (contentLength <= maxLogLength) {
        IDE_LOGI("DumpTensor: %s", tensorContent.c_str());
        return;
    }
    const size_t numChunks = (contentLength + maxLogLength - 1U) / maxLogLength;
    for (size_t i = 0; i < numChunks; ++i) {
        const size_t pos = i * maxLogLength;
        const size_t length = std::min(maxLogLength, contentLength - pos);
        const std::string chunk = tensorContent.substr(pos, length);
        IDE_LOGI("DumpTensor (Part%zu):%s", i + 1U, chunk.c_str());
    }
}

void PrintTensorByShape(
    const DumpTensorInfo* const tensorHead, const std::vector<size_t>& shape, const size_t totalNum,
    const size_t elementsNum)
{
    IDE_LOGI("print tensor by shape, totalNum is %zu, elementsNum is %zu.", totalNum, elementsNum);
    const auto& iter = PRINT_BY_SHAPE_CALLS.find(tensorHead->dataType);
    if (iter != PRINT_BY_SHAPE_CALLS.end()) {
        if (totalNum != 0) {
            std::vector<size_t> tmpShape = shape;
            for (int32_t i = static_cast<int32_t>(tmpShape.size() - 2U); i >= 0 && shape.size() >= 2U; i--) {
                tmpShape[i] *= tmpShape[i + 1];
            }
            std::string tensorContent = std::string(tmpShape.size(), '[');
            size_t cnt = 0U;
            const uint8_t* const data = reinterpret_cast<const uint8_t*>(tensorHead) + sizeof(DumpTensorInfo);
            if (totalNum == elementsNum) {
                cnt = (iter->second)(static_cast<const void*>(data), elementsNum, tmpShape, tensorContent, false);
            } else {
                cnt = (iter->second)(static_cast<const void*>(data), elementsNum, tmpShape, tensorContent, true);
                PrintExtraElems(totalNum, elementsNum, cnt, tmpShape, tensorContent);
            }
            std::cout << tensorContent << std::endl;
            PrintTensorContent(tensorContent);
        }
    }
}

void PrintTensorWithShape(
    const std::vector<size_t>& shape, const size_t actualDataNum, const DumpTensorInfo* const tensorHead)
{
    size_t totalNum = 1U;
    std::string shapeStr = "[";
    for (size_t i = 0U; i < shape.size(); i++) {
        if (shape[i] == 0) {
            IDE_LOGW("Value 0 for parameter shape[%zu] is invalid. Expected value: not equal to 0.", i);
            return;
        }
        if (totalNum > (std::numeric_limits<size_t>::max() / shape[i])) {
            IDE_LOGW(
                "The accumulated product of dimensions in the shape exceeds the maximum value %zu of size_t.",
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

void PrintTensorWithoutShape(const DumpTensorInfo* const tensorHead, const size_t dataNum)
{
    const auto& iter = PRINT_TENSOR_CALLS.find(tensorHead->dataType);
    if (iter != PRINT_TENSOR_CALLS.end()) {
        const uint8_t* const data = reinterpret_cast<const uint8_t*>(tensorHead) + sizeof(DumpTensorInfo);
        (iter->second)(static_cast<const void*>(data), dataNum);
    }
}

void PrintDumpTensor(const DumpInfoHead* dumpHead, const uint32_t coreType, std::vector<size_t>& shape)
{
    IDE_LOGI("Dump tensor length %u bytes.", dumpHead->infoLen);
    if (static_cast<size_t>(dumpHead->infoLen) < sizeof(DumpTensorInfo)) {
        IDE_LOGW(
            "The value of dumpHead->infoLen %u must be greater than or equal to that of DumpTensorInfo %zu.",
            dumpHead->infoLen, sizeof(DumpTensorInfo));
        return;
    }
    const DumpTensorInfo* const tensorHead = reinterpret_cast<const DumpTensorInfo*>(dumpHead->infoMsg);
    uint16_t dataTypeSize = 0U;
    const uint32_t dataType = tensorHead->dataType;
    const std::string dtype = DataTypeToString(dataType);
    if (!GetDataTypeSize(dataType, dataTypeSize)) {
        IDE_LOGW("The %s data type does not support the dump tensor.", dtype.c_str());
        return;
    }

    const std::string addrToHex = ToHex(tensorHead->addr);
    const auto& positionIter = POSITION_MAP.find(tensorHead->position);
    const std::string position = (positionIter != POSITION_MAP.end()) ?
                                     positionIter->second :
                                     std::to_string(static_cast<uint32_t>(tensorHead->position));
    const uint32_t dumpDataSize = tensorHead->dumpSize;
    const size_t availableDataSize = static_cast<size_t>(dumpHead->infoLen) - sizeof(DumpTensorInfo);
    if (static_cast<size_t>(dumpDataSize) > availableDataSize) {
        IDE_LOGW(
            "Dump tensor data size[%u bytes] exceeds available data size[%zu bytes]; print available data only.",
            dumpDataSize, availableDataSize);
    }
    const size_t actualDataSize =
        (dumpDataSize == 0U) ? availableDataSize : std::min(static_cast<size_t>(dumpDataSize), availableDataSize);
    const size_t actualDataNum = actualDataSize / dataTypeSize;

    // shape priority: tensorShape > dumpShape
    GetDumpTensorShape(tensorHead, shape);

    std::string blockInfo = "[";
    blockInfo += (coreType == 0U) ? "AIC " : "AIV ";
    blockInfo += "Block " + std::to_string(tensorHead->blockIdx) + "]";
    std::cout << blockInfo.c_str() << " DumpTensor: desc=" << std::dec << tensorHead->desc << ", addr=0x" << addrToHex;
    std::cout << ", data_type=" << dtype << ", position=" << position << ", dump_size=" << actualDataNum << std::endl;
    IDE_LOGI(
        "%s DumpTensor: desc=%u, addr=0x%s, data_type=%s, position=%s, dump_size=%zu.", blockInfo.c_str(),
        tensorHead->desc, addrToHex.c_str(), dtype.c_str(), position.c_str(), actualDataNum);

    if (!shape.empty()) {
        PrintTensorWithShape(shape, actualDataNum, tensorHead);
        shape = {};
    } else {
        PrintTensorWithoutShape(tensorHead, actualDataNum);
    }
}

void PrintDumpTimestamp(
    const DumpInfoHead* dumpHead, const uint32_t blockId, std::vector<MsprofAicTimeStampInfo>& timeStampInfo)
{
    if (dumpHead->infoLen < sizeof(DumpTimeStampInfoMsg)) {
        IDE_LOGW(
            "The value of dumpHead->infoLen %u must be greater than or equal to that of DumpTimeStampInfoMsg %zu.",
            dumpHead->infoLen, sizeof(DumpTimeStampInfoMsg));
        return;
    }

    MsprofAicTimeStampInfo timeInfo;
    const DumpTimeStampInfoMsg* dumpInfoMsg = reinterpret_cast<const DumpTimeStampInfoMsg*>(dumpHead->infoMsg);
    timeInfo.blockId = dumpInfoMsg->blockIdx;
    timeInfo.blockId &= 0xFFFFU;                          // 低16位记录逻辑block dim
    timeInfo.blockId |= ((blockId << 16U) & 0xFFFF0000U); // 高16位记录物理block dim
    timeInfo.descId = dumpInfoMsg->descId;
    const uint32_t rsv = dumpInfoMsg->rsv;
    timeInfo.syscyc = dumpInfoMsg->syscyc;
    timeInfo.curPc = dumpInfoMsg->curPc;
    timeStampInfo.push_back(timeInfo);

    const uint64_t switchData = GetProfSwitchData();
    const bool timeStampFlag = static_cast<bool>(switchData & PROF_OP_TIMESTAMP_MASK);
    if (!timeStampFlag) {
        (void)printf(
            "descId is %u, rsv is %u, timeStamp is %llu, pcPtr is %llu, entry is %llu.\n", timeInfo.descId, rsv,
            static_cast<unsigned long long>(timeInfo.syscyc), static_cast<unsigned long long>(timeInfo.curPc),
            static_cast<unsigned long long>(dumpInfoMsg->entry));
    }
    IDE_LOGI(
        "descId is %u, rsv is %u, timeStamp is %llu, pcPtr is %llu, entry is %llu.", timeInfo.descId, rsv,
        static_cast<unsigned long long>(timeInfo.syscyc), static_cast<unsigned long long>(timeInfo.curPc),
        static_cast<unsigned long long>(dumpInfoMsg->entry));
}

void ReportTimeStampInfo(const std::vector<MsprofAicTimeStampInfo>& timeStampInfo)
{
    const uint64_t switchData = GetProfSwitchData();
    const bool timeStampFlag = static_cast<bool>(switchData & PROF_OP_TIMESTAMP_MASK);
    if (!timeStampFlag || timeStampInfo.empty()) {
        return;
    }
    constexpr size_t batchSize =
        static_cast<size_t>(MSPROF_ADDTIONAL_INFO_DATA_LENGTH) / sizeof(MsprofAicTimeStampInfo);
    const size_t timeStampInfoLen = timeStampInfo.size();
    for (size_t i = 0U; i < timeStampInfoLen; i += batchSize) {
        const size_t batchEnd = std::min(i + batchSize, timeStampInfo.size());     // 防止越界
        const size_t sizeToCopy = (batchEnd - i) * sizeof(MsprofAicTimeStampInfo); // 计算每次拷贝的字节数
        MsprofAdditionalInfo additionInfo{};
        const uint64_t timeStamp = MsprofSysCycleTime();
        additionInfo.level = MSPROF_REPORT_AIC_LEVEL;
        additionInfo.type = MSPROF_REPORT_AIC_TIMESTAMP_TYPE;
        additionInfo.threadId = static_cast<uint32_t>(mmGetTid());
        additionInfo.timeStamp = timeStamp;
        additionInfo.dataLen = static_cast<uint32_t>(sizeToCopy);
        const errno_t err = memcpy_s(
            additionInfo.data, static_cast<size_t>(MSPROF_ADDTIONAL_INFO_DATA_LENGTH), &timeStampInfo[i], sizeToCopy);
        if (err != EOK) {
            IDE_LOGE(
                "Failed to call memcpy_s to copy timeStampInfo[%zu],"
                " src=%p, dest=%p, dest_max=%d, count=%u, retCode=%#x.",
                i, &timeStampInfo[i], additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, additionInfo.dataLen, err);
            return;
        }
        IDE_LOGI("Report dataLen is %u.", additionInfo.dataLen);
        (void)MsprofReportAdditionalInfo(
            static_cast<uint32_t>(true), &additionInfo, static_cast<uint32_t>(sizeof(MsprofAdditionalInfo)));
    }
}

void PrintDumpInfo(
    const DumpInfoHead* dumpHead, const uint32_t blockId, const uint32_t coreType, std::vector<size_t>& shapeInfo,
    std::vector<MsprofAicTimeStampInfo>& timeStampInfo)
{
    switch (dumpHead->type) {
        case DfxDumpType::DUMP_SCALAR:
        case DfxDumpType::DUMP_ASSERT:
            PrintDump(dumpHead);
            break;
        case DfxDumpType::DUMP_AICPU:
            PrintAicpuDump(dumpHead);
            break;
        case DfxDumpType::DUMP_SHAPE:
            GetDumpShape(dumpHead, shapeInfo);
            break;
        case DfxDumpType::DUMP_TENSOR:
            PrintDumpTensor(dumpHead, coreType, shapeInfo);
            break;
        case DfxDumpType::DUMP_TIMESTAMP:
            PrintDumpTimestamp(dumpHead, blockId, timeStampInfo);
            break;
        case DfxDumpType::DUMP_SKIP:
            IDE_LOGI("Skip this dump info for the type.");
            break;
        default:
            IDE_LOGW("Invalid dump type %u.", static_cast<uint32_t>(dumpHead->type));
            break;
    }
}

bool PrintSimtDumpInfo(const DumpInfoHead* dumpHead)
{
    switch (dumpHead->type) {
        case DfxDumpType::DUMP_SIMT_ASSERT:
        case DfxDumpType::DUMP_SIMT_PRINTF:
            PrintSimtDump(dumpHead);
            return true;
        case DfxDumpType::DUMP_WAIT:
            IDE_LOGI("Wait this dump info for the type.");
            return false;
        default:
            IDE_LOGW("Invalid dump type %u.", static_cast<uint32_t>(dumpHead->type));
            return true;
    }
}

bool ValidateDumpBlockSnapshot(const rtDfxParseParam* param, const BlockInfo*& blockInfo, const uint8_t*& dumpStartAddr)
{
    if (param->datalen < BLOCK_METADATA_LEN) {
        IDE_LOGW(
            "Invalid dfx block snapshot: datalen=%llu is less than metadata length=%llu, readIdx=%llu, "
            "writeIdx=%llu, coreType=%u, coreId=%u, deviceId=%u.",
            static_cast<unsigned long long>(param->datalen), static_cast<unsigned long long>(BLOCK_METADATA_LEN),
            static_cast<unsigned long long>(param->readIdx), static_cast<unsigned long long>(param->writeIdx),
            param->coreType, param->coreId, param->deviceId);
        return false;
    }

    const uint8_t* blockAddr = static_cast<const uint8_t*>(param->data);
    blockInfo = reinterpret_cast<const BlockInfo*>(blockAddr);
    dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);
    const uint64_t dataAreaCapacity = param->datalen - BLOCK_METADATA_LEN;
    if (blockInfo->remainLen == 0U || blockInfo->remainLen > dataAreaCapacity) {
        IDE_LOGW(
            "Invalid dfx block snapshot: remainLen=%u, dataAreaCapacity=%llu, datalen=%llu, readIdx=%llu, "
            "writeIdx=%llu, coreType=%u, coreId=%u, deviceId=%u.",
            blockInfo->remainLen, static_cast<unsigned long long>(dataAreaCapacity),
            static_cast<unsigned long long>(param->datalen), static_cast<unsigned long long>(param->readIdx),
            static_cast<unsigned long long>(param->writeIdx), param->coreType, param->coreId, param->deviceId);
        return false;
    }
    if (param->readIdx > param->writeIdx) {
        IDE_LOGW(
            "Invalid dfx block snapshot: readIdx=%llu is greater than writeIdx=%llu, remainLen=%u, "
            "datalen=%llu, coreType=%u, coreId=%u, deviceId=%u.",
            static_cast<unsigned long long>(param->readIdx), static_cast<unsigned long long>(param->writeIdx),
            blockInfo->remainLen, static_cast<unsigned long long>(param->datalen), param->coreType, param->coreId,
            param->deviceId);
        return false;
    }

    return true;
}

bool PrepareDumpReadBuffer(
    const rtDfxParseParam* param, std::vector<uint8_t>& dumpInfoVec, const uint8_t*& dumpReadStartAddr,
    uint64_t& totalReadBufLen)
{
    const BlockInfo* blockInfo = nullptr;
    const uint8_t* dumpStartAddr = nullptr;
    if (!ValidateDumpBlockSnapshot(param, blockInfo, dumpStartAddr)) {
        return false;
    }

    const uint64_t readIdx = param->readIdx % blockInfo->remainLen;
    const uint64_t writeIdx = param->writeIdx % blockInfo->remainLen;
    if (param->writeIdx - param->readIdx >= blockInfo->remainLen) {
        totalReadBufLen = blockInfo->remainLen;
        dumpInfoVec.resize(totalReadBufLen, 0U);
        const uint64_t validStartIdx = writeIdx;
        (void)memcpy_s(
            dumpInfoVec.data(), blockInfo->remainLen - validStartIdx, dumpStartAddr + validStartIdx,
            blockInfo->remainLen - validStartIdx);
        if (validStartIdx > 0U) {
            (void)memcpy_s(
                dumpInfoVec.data() + blockInfo->remainLen - validStartIdx, validStartIdx, dumpStartAddr, validStartIdx);
        }
        dumpReadStartAddr = dumpInfoVec.data();
        return true;
    }

    if (readIdx > writeIdx) {
        totalReadBufLen = blockInfo->remainLen - readIdx + writeIdx;
        dumpInfoVec.resize(totalReadBufLen, 0U);
        (void)memcpy_s(
            dumpInfoVec.data(), blockInfo->remainLen - readIdx, dumpStartAddr + readIdx,
            blockInfo->remainLen - readIdx);
        (void)memcpy_s(dumpInfoVec.data() + blockInfo->remainLen - readIdx, writeIdx, dumpStartAddr, writeIdx);
        dumpReadStartAddr = dumpInfoVec.data();
    } else {
        totalReadBufLen = writeIdx - readIdx;
        dumpReadStartAddr = dumpStartAddr + readIdx;
    }
    return totalReadBufLen > 0U;
}

uint64_t ParseDumpReadBuffer(
    const rtDfxParseParam* param, const uint8_t* dumpReadStartAddr, const uint64_t totalReadBufLen)
{
    std::vector<size_t> shape;
    std::vector<MsprofAicTimeStampInfo> timeStampInfo;
    uint64_t dataLen = 0U;
    while (dataLen < totalReadBufLen) {
        const uint64_t remainingLen = totalReadBufLen - dataLen;
        if (remainingLen < sizeof(DumpInfoHead)) {
            break;
        }
        const DumpInfoHead* dumpHead = reinterpret_cast<const DumpInfoHead*>(dumpReadStartAddr + dataLen);
        const uint64_t step = sizeof(DumpInfoHead) + static_cast<uint64_t>(dumpHead->infoLen);
        if (step > remainingLen) {
            break;
        }
        if (param->coreType == RT_KERNEL_DFX_INFO_CORE_TYPE_SIMT) {
            if (!PrintSimtDumpInfo(dumpHead)) {
                break;
            }
        } else {
            PrintDumpInfo(dumpHead, param->coreId, param->coreType, shape, timeStampInfo);
        }
        dataLen += step;
    }
    ReportTimeStampInfo(timeStampInfo);
    return dataLen;
}

} // namespace

void ParseDfxInfoCallback(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    DfxInfoParser::Instance().ParseDfxInfo(param, consumedLen);
}

DfxInfoParser::DfxInfoParser() : registered_(false), profRegistered_(false) {}

DfxInfoParser::~DfxInfoParser() { UnInit(); }

int32_t DfxInfoParser::Init()
{
    if (registered_) {
        IDE_LOGI("DfxInfoParser already registered.");
        return ADUMP_SUCCESS;
    }
    if (!profRegistered_) {
        const rtError_t profRet = rtProfRegisterCtrlCallback(MODULE_ID_ADUMP, ProfCtrlCallback);
        if (profRet != RT_ERROR_NONE) {
            IDE_LOGW("Register prof ctrl callback failed, ret=%u.", profRet);
        } else {
            profRegistered_ = true;
        }
    }
    const rtError_t ret = rtRegisterParseDfxInfoFunc(ParseDfxInfoCallback);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("Register parse dfx info callback failed, ret=%u.", ret);
        UnInit();
        return ADUMP_FAILED;
    }
    registered_ = true;
    IDE_LOGI("DfxInfoParser initialized successfully.");
    return ADUMP_SUCCESS;
}

void DfxInfoParser::UnInit()
{
    if (registered_) {
        const rtError_t ret = rtRegisterParseDfxInfoFunc(nullptr);
        if (ret != RT_ERROR_NONE) {
            IDE_LOGE("Unregister parse dfx info callback failed, ret=%u.", ret);
        } else {
            registered_ = false;
        }
    }
    if (profRegistered_) {
        const rtError_t ret = rtProfRegisterCtrlCallback(MODULE_ID_ADUMP, nullptr);
        if (ret != RT_ERROR_NONE) {
            IDE_LOGE("Unregister prof ctrl callback failed, ret=%u.", ret);
        } else {
            profRegistered_ = false;
        }
    }
}

void DfxInfoParser::ParseDfxInfo(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    if (consumedLen == nullptr) {
        return;
    }
    *consumedLen = 0U;
    if (param == nullptr || param->data == nullptr || param->datalen == 0U) {
        return;
    }
    uint64_t totalReadBufLen = 0U;
    const uint8_t* dumpReadStartAddr = nullptr;
    std::vector<uint8_t> dumpInfoVec;
    if (!PrepareDumpReadBuffer(param, dumpInfoVec, dumpReadStartAddr, totalReadBufLen)) {
        return;
    }
    const uint64_t dataLen = ParseDumpReadBuffer(param, dumpReadStartAddr, totalReadBufLen);
    if ((param->coreType == RT_KERNEL_DFX_INFO_CORE_TYPE_SIMT) ||
        (param->coreType == RT_KERNEL_DFX_INFO_CORE_TYPE_AICPU)) {
        *consumedLen = dataLen;
    } else {
        *consumedLen = (param->writeIdx - param->readIdx);
    }

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(param, dumpReadStartAddr, totalReadBufLen);
}

} // namespace Adx
