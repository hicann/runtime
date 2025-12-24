/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_printf.h"

#include <iostream>
#include <unordered_set>
#include <sstream>
#include <functional>
#include <map>
#include <mutex>
#include "runtime/mem.h"
#include "runtime/base.h"
#include "runtime/dev.h"
#include "log/hdc_log.h"
#include "fp16_t.h"
#include "bfloat16.h"
#include "hifloat.h"
#include "dump_memory.h"
#include "sys_utils.h"
#include "dump_printf_platform.h"

namespace {
constexpr size_t ADX_SIMT_BLOCK_NUM = 72U;
constexpr size_t ADX_PRINT_ARG_LEN = 8U;
constexpr size_t ADX_ASSERT_LEN = 1024U;
constexpr size_t ADX_MAX_STR_LEN = 1024U * 1024U;
constexpr size_t ADX_SIMT_PRINT_LEN = 2U * 1024U;
constexpr size_t ADX_MAX_LOG_LENGTH = 256U;
constexpr uint32_t ADX_OFF_LIMIT_RSV = 7U;
constexpr uint32_t ADX_SIMT_MAX_THREAD_NUM = 2048U;
constexpr size_t ADX_ONE_LINE_NUM = 30U;
constexpr uint16_t ADX_INT16_SIZE = 2U;
constexpr uint16_t ADX_INT32_SIZE = 4U;
constexpr uint16_t ADX_INT64_SIZE = 8U;
constexpr uint64_t ADX_INPUT_NUM_MASK = 0x00000000ffffffff;
constexpr uint64_t ADX_SIZE_MASK = 0x00ffffffffffffff;
constexpr uint64_t ADX_FFTS_ADDR_OFFSET = 32U;
constexpr uint64_t ADX_SIZE_BITS_OFFSET = 56U;
constexpr uint64_t ADX_WORKSPACE_SIZE_FLAG = 4U;
constexpr uint64_t ADX_DYNAMIC_INPUT_FLAG = 2U;
constexpr uint32_t ADX_DUMP_AND_PRINT_MAGIC_NUM = 0x5AA5BCCDU;
static bool g_adxPrintConfigFlag = false;
static std::mutex g_adxPrintConfigMtx;
constexpr uint32_t TIMEOUT_THRESHOLD = 500U;
} // namespace

template<typename T>
std::string AdxToHex(T num)
{
    std::stringstream stream;
    stream << std::hex << num;
    return stream.str();
}

template<typename T>
std::string AdxToStr(T num)
{
    std::stringstream stream;
    stream << num;
    return stream.str();
}

template<typename T>
inline T AdxParseParam(const uint8_t *beginAddr, const size_t paramIndex)
{
    const T *paramAddr = (const T *)(beginAddr + paramIndex * ADX_PRINT_ARG_LEN);
    return *paramAddr;
}

inline int32_t AdxConvertToStd(uint8_t data)
{
    return static_cast<int32_t>(data);
}

inline int32_t AdxConvertToStd(int8_t data)
{
    return static_cast<int32_t>(data);
}

template<typename T>
inline T AdxConvertToStd(const T &data)
{
    return data;
}

inline float AdxConvertToStd(Adx::fp16_t data)
{
    return data.toFloat();
}

inline float AdxConvertToStd(Adx::BFloat16 data)
{
    return data.GetValue();
}

inline float AdxConvertToStd(Adx::HiFloat8 data)
{
    return data.GetValue();
}

inline float AdxConvertToStd(Adx::Fp8E5M2 data)
{
    return data.GetValue();
}

inline float AdxConvertToStd(Adx::Fp8E4M3 data)
{
    return data.GetValue();
}

inline float AdxConvertToStd(Adx::Fp8E8M0 data)
{
    return data.GetValue();
}


static void AdxPrintBoolTensor(const void *data, const size_t dataNum)
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
            IDE_LOGI("DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ADX_ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                IDE_LOGI("DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}

template<typename T>
void AdxPrintTensor(const void *data, const size_t dataNum)
{
    const T *nums = (const T *)data;
    std::cout << "[";
    std::string tensorData = "[";
    for (size_t i = 0U; i < dataNum; ++i) {
        const auto num = AdxConvertToStd(nums[i]);
        std::cout << std::to_string(num);
        tensorData += std::to_string(num);
        if (i == dataNum - 1U) { // dataNum一定满足>=1
            std::cout << "]" << std::endl;
            tensorData += "]";
            IDE_LOGI("DumpTensor: %s", tensorData.c_str());
        } else {
            std::cout << ", ";
            tensorData += ", ";
            if ((i != 0U) && (i % ADX_ONE_LINE_NUM == 0U)) {
                std::cout << std::endl;
                IDE_LOGI("DumpTensor: %s", tensorData.c_str());
                tensorData.clear();
            }
        }
    }
}

template<typename T>
static size_t AdumpPrintValidElems(const void *data, const size_t dataNum, const std::vector<size_t> &tmpShape,
                                   std::string &tensorContent, const bool flag)
{
    const T *dumpTensor = static_cast<const T *>(data);
    size_t cnt = 0U;
    for (size_t i = 0; i < dataNum; i++) {
        cnt = 0U;
        for (size_t s : tmpShape) {
            if ((i + 1) % s == 0) {
                cnt++;
            }
        }
        tensorContent += std::to_string(AdxConvertToStd(dumpTensor[i]));
        if (cnt > 0U) {
            tensorContent += std::string(cnt, ']');
            if (flag) {
                tensorContent += ",\n";
            }
            if (i != dataNum - 1) {
                if (!flag) {
                    tensorContent += ",\n";
                }
                tensorContent += std::string(cnt, '[');
            }
        } else if (i != dataNum - 1) {
            tensorContent += ",";
        }
    }
    return cnt;
}

static void AdxPrintExtraElems(const size_t totalEleNum, const size_t dataNum, size_t &cnt,
                               const std::vector<size_t> &tmpShape, std::string &tensorContent)
{
    if (dataNum % tmpShape.back() == 0) {
        tensorContent += std::string(cnt, '[');
    } else {
        tensorContent += ",";
    }
    for (size_t i = dataNum; i < totalEleNum; i++) {
        cnt = 0U;
        for (size_t s : tmpShape) {
            if ((i + 1) % s == 0) {
                cnt++;
            }
        }
        tensorContent += "-";
        if (cnt > 0U) {
            tensorContent += std::string(cnt, ']');
            if (i != totalEleNum - 1) {
                tensorContent += ",\n";
                tensorContent += std::string(cnt, '[');
            }
        } else if (i != totalEleNum - 1) {
            tensorContent += ",";
        }
    }
}

static size_t AdumpPrintValidBoolElems(const void *data, const size_t dataNum, const std::vector<size_t> &tmpShape,
                                   std::string &tensorContent, const bool flag)
{
    const uint8_t *dumpTensor = static_cast<const uint8_t *>(data);
    size_t cnt = 0U;
    for (size_t i = 0; i < dataNum; i++) {
        cnt = 0U;
        for (size_t s : tmpShape) {
            if ((i + 1) % s == 0) {
                cnt++;
            }
        }
        tensorContent += (static_cast<bool>(dumpTensor[i])) ? "1" : "0";
        if (cnt > 0U) {
            tensorContent += std::string(cnt, ']');
            tensorContent += (flag) ? ",\n" : "";
            if (i != dataNum - 1) {
                tensorContent += (!flag) ? ",\n" : "";
                tensorContent += std::string(cnt, '[');
            }
        } else if (i != dataNum - 1) {
            tensorContent += ",";
        }
    }
    return cnt;
}

static std::string AdumpToString(aclDataType dataType)
{
    static std::map<aclDataType, std::string> dtype = {
        {ACL_DT_UNDEFINED, "undefined"},
        {ACL_FLOAT, "float32"},
        {ACL_FLOAT16, "float16"},
        {ACL_INT8, "int8"},
        {ACL_INT32, "int32"},
        {ACL_UINT8, "uint8"},
        {ACL_INT16, "int16"},
        {ACL_UINT16, "uint16"},
        {ACL_UINT32, "uint32"},
        {ACL_INT64, "int64"},
        {ACL_UINT64, "uint64"},
        {ACL_DOUBLE, "double"},
        {ACL_BOOL, "bool"},
        {ACL_STRING, "string"},
        {ACL_COMPLEX64, "complex64"},
        {ACL_COMPLEX128, "complex128"},
        {ACL_BF16, "bfloat16"},
        {ACL_HIFLOAT8, "hifloat8"},
        {ACL_FLOAT8_E5M2, "float8_e5m2"},
        {ACL_FLOAT8_E4M3FN, "float8_e4m3fn"},
        {ACL_FLOAT8_E8M0, "float8_e8m0"}};
    auto iter = dtype.find(dataType);
    if (iter != dtype.end()) {
        return (iter->second).c_str();
    } else {
        return "Unknown aclDataType";
    }
}

#ifdef __cplusplus
extern "C" {
#endif

static std::string AdxGetCoreTypeId(const uint32_t core, const uint8_t coreType)
{
    if (coreType == 1U) { // AIC场景
        return  "AIC-" + std::to_string(core - AdxGetCoreTypeIDOffset());
    }
    return "AIV-" + std::to_string(core);  // AIV+MIX场景
}

static const std::unordered_map<uint32_t, std::function<void(const void *, const size_t)>> ADX_PRINT_CALLS {
    {ge::DT_UINT8, AdxPrintTensor<uint8_t>},
    {ge::DT_INT8, AdxPrintTensor<int8_t>},
    {ge::DT_INT16, AdxPrintTensor<int16_t>},
    {ge::DT_UINT16, AdxPrintTensor<uint16_t>},
    {ge::DT_INT32, AdxPrintTensor<int32_t>},
    {ge::DT_UINT32, AdxPrintTensor<uint32_t>},
    {ge::DT_INT64, AdxPrintTensor<int64_t>},
    {ge::DT_UINT64, AdxPrintTensor<uint64_t>},
    {ge::DT_FLOAT, AdxPrintTensor<float>},
    {ge::DT_FLOAT16, AdxPrintTensor<Adx::fp16_t>},
    {ge::DT_BF16, AdxPrintTensor<Adx::BFloat16>},
    {ge::DT_HIFLOAT8, AdxPrintTensor<Adx::HiFloat8>},
    {ge::DT_FLOAT8_E5M2, AdxPrintTensor<Adx::Fp8E5M2>},
    {ge::DT_FLOAT8_E4M3FN, AdxPrintTensor<Adx::Fp8E4M3>},
    {ge::DT_FLOAT8_E8M0, AdxPrintTensor<Adx::Fp8E8M0>},
    {ge::DT_BOOL, AdxPrintBoolTensor},
};


static const std::unordered_map<uint32_t,
    std::function<size_t(const void *, const size_t, const std::vector<size_t> &, std::string &, const size_t)>>
    ADX_PRINT_BY_SHAPE_CALLS{{ge::DT_UINT8, AdumpPrintValidElems<uint8_t>},
        {ge::DT_INT8, AdumpPrintValidElems<int8_t>},
        {ge::DT_INT16, AdumpPrintValidElems<int16_t>},
        {ge::DT_UINT16, AdumpPrintValidElems<uint16_t>},
        {ge::DT_INT32, AdumpPrintValidElems<int32_t>},
        {ge::DT_UINT32, AdumpPrintValidElems<uint32_t>},
        {ge::DT_INT64, AdumpPrintValidElems<int64_t>},
        {ge::DT_UINT64, AdumpPrintValidElems<uint64_t>},
        {ge::DT_FLOAT, AdumpPrintValidElems<float>},
        {ge::DT_FLOAT16, AdumpPrintValidElems<Adx::fp16_t>},
        {ge::DT_BOOL, AdumpPrintValidBoolElems},
        {ge::DT_BF16, AdumpPrintValidElems<Adx::BFloat16>},
        {ge::DT_HIFLOAT8, AdumpPrintValidElems<Adx::HiFloat8>},
        {ge::DT_FLOAT8_E5M2, AdumpPrintValidElems<Adx::Fp8E5M2>},
        {ge::DT_FLOAT8_E4M3FN, AdumpPrintValidElems<Adx::Fp8E4M3>},
        {ge::DT_FLOAT8_E8M0, AdumpPrintValidElems<Adx::Fp8E8M0>}};

static void AdxPrintFormatD(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const int64_t paramInfo = AdxParseParam<int64_t>(paramBegin, paramIndex);
    (void)printf("%lld", (long long)paramInfo);
    printInfo += std::to_string(paramInfo);
}

static void AdxPrintFormatI(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const int64_t paramInfo = AdxParseParam<int64_t>(paramBegin, paramIndex);
    (void)printf("%lli", (long long)paramInfo);
    printInfo += std::to_string(paramInfo);
}

static void AdxPrintFormatF(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const float paramInfo = AdxParseParam<float>(paramBegin, paramIndex);
    (void)printf("%f", paramInfo);
    printInfo += std::to_string(paramInfo);
}

static void AdxPrintFormatFUpper(const uint8_t *paramBegin, std::string &printInfo,
                          const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const float paramInfo = AdxParseParam<float>(paramBegin, paramIndex);
    (void)printf("%F", paramInfo);
    printInfo += std::to_string(paramInfo);
}

static void AdxPrintFormatU(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const uint64_t paramInfo = AdxParseParam<uint64_t>(paramBegin, paramIndex);
    (void)printf("%llu", (long long unsigned)paramInfo);
    printInfo += std::to_string(paramInfo);
}

static void AdxPrintFormatP(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const void *paramInfo = AdxParseParam<void *>(paramBegin, paramIndex);
    (void)printf("%p", paramInfo);
    printInfo += AdxToStr(paramInfo);
}

static void AdxPrintFormatX(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const int64_t paramInfo = AdxParseParam<int64_t>(paramBegin, paramIndex);
    (void)printf("%llx", (long long unsigned)paramInfo);
    printInfo += AdxToHex(paramInfo);
}

static void AdxPrintFormatXUpper(const uint8_t *paramBegin, std::string &printInfo,
                          const size_t paramIndex, const size_t maxLen)
{
    (void)maxLen;
    const int64_t paramInfo = AdxParseParam<int64_t>(paramBegin, paramIndex);
    (void)printf("%llX", (long long unsigned)paramInfo);
    printInfo += AdxToHex(paramInfo);
}

static void AdxPrintFormatS(const uint8_t *paramBegin, std::string &printInfo,
                     const size_t paramIndex, const size_t maxLen)
{
    const uint64_t *offsetAddr = (const uint64_t *)(paramBegin + paramIndex * ADX_PRINT_ARG_LEN);
    const char *data = ((const char *)offsetAddr) + (*offsetAddr);
    const size_t dataLen = strnlen(data, ADX_MAX_STR_LEN);
    IDE_LOGD("Get string param length %zu bytes, max length is %zu bytes.", dataLen, maxLen);
    if (dataLen > maxLen) {
        return;
    }
    (void)printf("%s", data);
    printInfo += AdxToStr(data);
}

static const std::unordered_map<std::string, std::function<void(const uint8_t *,
    std::string &, const size_t, const size_t)>> ADX_PRINT_FORMAT_CALLS {
        {"d", AdxPrintFormatD},
        {"ld", AdxPrintFormatD},
        {"lld", AdxPrintFormatD},
        {"i", AdxPrintFormatI},
        {"li", AdxPrintFormatI},
        {"lli", AdxPrintFormatI},
        {"f", AdxPrintFormatF},
        {"F", AdxPrintFormatFUpper},
        {"u", AdxPrintFormatU},
        {"lu", AdxPrintFormatU},
        {"llu", AdxPrintFormatU},
        {"p", AdxPrintFormatP},
        {"x", AdxPrintFormatX},
        {"lx", AdxPrintFormatX},
        {"llx", AdxPrintFormatX},
        {"X", AdxPrintFormatXUpper},
        {"lX", AdxPrintFormatXUpper},
        {"llX", AdxPrintFormatXUpper},
        {"s", AdxPrintFormatS}
};
 
static const std::unordered_map<uint32_t, uint16_t> ADX_DATA_TYPE_SIZE {
    {ge::DT_UINT8, 1U},
    {ge::DT_INT8, 1U},
    {ge::DT_BOOL, 1U},
    {ge::DT_INT16, ADX_INT16_SIZE},
    {ge::DT_UINT16, ADX_INT16_SIZE},
    {ge::DT_INT32, ADX_INT32_SIZE},
    {ge::DT_UINT32, ADX_INT32_SIZE},
    {ge::DT_INT64, ADX_INT64_SIZE},
    {ge::DT_UINT64, ADX_INT64_SIZE},
    {ge::DT_FLOAT, ADX_INT32_SIZE},
    {ge::DT_FLOAT16, ADX_INT16_SIZE},
    {ge::DT_BF16, ADX_INT16_SIZE},
    {ge::DT_HIFLOAT8, 1U},
    {ge::DT_FLOAT8_E5M2, 1U},
    {ge::DT_FLOAT8_E4M3FN, 1U},
    {ge::DT_FLOAT8_E8M0, 1U}
};
 
static void GetDataTypeSize(uint32_t dataType, uint16_t &size)
{
    const auto &iter = ADX_DATA_TYPE_SIZE.find(dataType);
    if (iter != ADX_DATA_TYPE_SIZE.end()) {
        size = iter->second;
    } else {
        const std::string dtype = AdumpToString((aclDataType)dataType);
        IDE_LOGW("Dump tensor doesn't support dtype of %s.", dtype.c_str());
    }
}

static void AdxDumpPrintTensorWithShape(const AdxDumpMessageHead *const tensorHead,
                                        const std::vector<size_t> &shape, const size_t totalNum, const size_t elementsNum)
{
    IDE_LOGI("print tensor by shape, totalNum is %zu, elementsNum is %zu.", totalNum, elementsNum);
    const auto &iter = ADX_PRINT_BY_SHAPE_CALLS.find(tensorHead->dataType);
    if (iter != ADX_PRINT_BY_SHAPE_CALLS.end()) {
        const uint8_t *const data = (const uint8_t *)(tensorHead) + sizeof(AdxDumpMessageHead);
        if (totalNum != 0) {
            std::vector<size_t> tmpShape = shape;
            for (int i = tmpShape.size() - 2; i >= 0 && shape.size() >= 2U; i--) {
                tmpShape[i] *= tmpShape[i + 1];
            }
            std::string tensorContent = std::string(tmpShape.size(), '[');
            size_t cnt = 0U;
            if (totalNum == elementsNum) {
                cnt = (iter->second)(static_cast<const void *>(data), elementsNum, tmpShape, tensorContent, false);
            } else {
                cnt = (iter->second)(static_cast<const void *>(data), elementsNum, tmpShape, tensorContent, true);
                AdxPrintExtraElems(totalNum, elementsNum, cnt, tmpShape, tensorContent);
            }
            std::cout << tensorContent << std::endl;
            IDE_LOGI("DumpTensor: %s", tensorContent.c_str());
        }
    } else {
        const std::string dtype = AdumpToString(static_cast<aclDataType>(tensorHead->dataType));
        IDE_LOGW("Dump tensor doesn't support dtype of %s.", dtype.c_str());
    }
}

static void AdxDumpJugdeShape(const std::vector<size_t> &shape, const size_t actualDataNum,
                              const AdxDumpMessageHead *const tensorHead)
{
    size_t totalNum = 1U;
    std::string shapeStr = "[";
    for (size_t i = 0U; i < shape.size(); i++) {
        totalNum *= shape[i];
        shapeStr += std::to_string(shape[i]);
        if (i + 1 < shape.size()) {
            shapeStr += ", ";
        } else {
            shapeStr += "]";
        }
    }
    if (totalNum < actualDataNum) {
        printf("shape is %s, dumpSize is %zu, dumpSize is greater than shapeSize.\n", shapeStr.c_str(), actualDataNum);
        AdxDumpPrintTensorWithShape(tensorHead, shape, totalNum, totalNum);
    } else if (totalNum > actualDataNum) {
        printf("shape is %s, dumpSize is %zu, data is not enough.\n", shapeStr.c_str(), actualDataNum);
        AdxDumpPrintTensorWithShape(tensorHead, shape, totalNum, actualDataNum);
    } else {
        AdxDumpPrintTensorWithShape(tensorHead, shape, totalNum, actualDataNum);
    }
    return;
}

static void AdxDumpPrintTensorWithoutShape(const AdxDumpMessageHead *const tensorHead, const size_t dataNum)
{
    const auto &iter = ADX_PRINT_CALLS.find(tensorHead->dataType);
    if (iter != ADX_PRINT_CALLS.end()) {
        const uint8_t *const data = (const uint8_t *)(tensorHead) + sizeof(AdxDumpMessageHead);
        (iter->second)(static_cast<const void *>(data), dataNum);
    } else {
        const std::string dtype = AdumpToString((aclDataType)tensorHead->dataType);
        IDE_LOGW("Dump tensor doesn't support dtype of %s.", dtype.c_str());
    }
}

static void AdxPrintTensorInfo(const AdxDumpInfoHead *dumpHead, std::vector<size_t> &shape)
{
    IDE_LOGI("Dump tensor length %u bytes.", dumpHead->infoLen);
    if (static_cast<size_t>(dumpHead->infoLen) < sizeof(AdxDumpMessageHead)) {
        return;
    }

    const AdxDumpMessageHead *const tensorHead = (const AdxDumpMessageHead *)dumpHead->infoMsg;
    const std::string dtype = AdumpToString((aclDataType)tensorHead->dataType);
    const uint32_t actualDumpNum = tensorHead->rsv;
    uint16_t dtypeSize = 0U;
    const uint32_t dataType = tensorHead->dataType;
    GetDataTypeSize(dataType, dtypeSize);
    if (dtypeSize == 0U) {
        IDE_LOGW("Dump tensor doesn't support dtype of %s.", dtype.c_str());
        return;
    }
    const size_t actualDataNum = (actualDumpNum == 0U) ? 
        (static_cast<size_t>(dumpHead->infoLen) - sizeof(AdxDumpMessageHead)) / dtypeSize : static_cast<size_t>(actualDumpNum);
    const auto &positionIter = POSITION_MAP.find(tensorHead->position);
    const std::string position =
        (positionIter != POSITION_MAP.end()) ? positionIter->second : std::to_string(tensorHead->position);
    const std::string addrToHex = AdxToHex(tensorHead->addr);
    std::cout << "DumpTensor: desc=" << std::dec << tensorHead->desc << ", addr=" << addrToHex;
    std::cout << ", data_type=" << dtype << ", position=" << position << ", dump_size=" << actualDataNum << std::endl;
    IDE_LOGI("DumpTensor: desc=%u, addr=%s, data_type=%s, position=%s, dump_size=%zu.",
        tensorHead->desc, addrToHex.c_str(), dtype.c_str(), position.c_str(), actualDataNum);

    if (!shape.empty()) {
        AdxDumpJugdeShape(shape, actualDataNum, tensorHead);
        shape = {};
    } else {
        AdxDumpPrintTensorWithoutShape(tensorHead, actualDataNum);
    }
}

static void AdxPrintToLog(std::string &printInfo, const bool isAssert)
{
    const size_t strLength = printInfo.size();
    for (size_t i = 0; i < strLength; i += ADX_MAX_LOG_LENGTH) {
        const size_t subInfoLen =
            (i + ADX_MAX_LOG_LENGTH) > strLength ? (strLength - i) : ADX_MAX_LOG_LENGTH;
        if (isAssert) {
            IDE_LOGE("%s", printInfo.substr(i, subInfoLen).c_str());
        } else {
            IDE_LOGI("PrintInfo: %s", printInfo.substr(i, subInfoLen).c_str());
        }
    }
}

static std::string AdxGetFormat(const char *format)
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
        }
    }
    temp += std::string(format, 1);
    return temp;
}

static void AdxPrint(const char *format, const uint8_t *paramBegin, const size_t maxLen,
                     const size_t paramNum, const bool isAssert)
{
    size_t paramIndex = 0U;
    std::string printInfo = "";
    while ((*format) != '\0') {
        if ((*format) == '%') {
            format++;
            const std::string &tempFormat = AdxGetFormat(format);
            const auto &iter = ADX_PRINT_FORMAT_CALLS.find(tempFormat);
            if (iter != ADX_PRINT_FORMAT_CALLS.end()) {
                paramIndex++;
                if (paramIndex >= paramNum) {
                    IDE_LOGW("Dump print formatting num %zu too much, must be smaller than %zu", paramIndex + 1U,
                        paramNum);
                    break;
                }
                (iter->second)(paramBegin, printInfo, paramIndex, maxLen);
                // if条件进来，ADX_PRINT_FORMAT_CALLS中存在tempFormat，size必不为0
                format += tempFormat.size() - 1;
            } else {
                IDE_LOGW("Dump print fomat %s is illegal.", tempFormat.c_str());
                (void)printf("%%");
                (void)printf("%s", tempFormat.c_str());
                printInfo += "%" + tempFormat;
            }
        } else {
            std::cout << *format;
            printInfo += *format;
        }
        format++;
    }
    AdxPrintToLog(printInfo, isAssert);
}

static void AdxPrintPrintInfo(const AdxDumpInfoHead *dumpHead, const bool isAssert)
{
    IDE_LOGD("Get dump print data length[%u bytes].", dumpHead->infoLen);
    if (static_cast<size_t>(dumpHead->infoLen) < ADX_PRINT_ARG_LEN) {
        return;
    }
    const size_t strOffset = *((const size_t *)dumpHead->infoMsg);
    const size_t argsNum = strOffset / ADX_PRINT_ARG_LEN;
    const char *str = (const char *)(dumpHead->infoMsg + strOffset);
    const size_t strLen = strnlen(str, ADX_MAX_STR_LEN);

    IDE_LOGD("Get print str len[%zu bytes]", strLen);
    if (strLen > static_cast<size_t>(dumpHead->infoLen)) {
        return;
    }
    AdxPrint(str, (const uint8_t *)dumpHead->infoMsg,
        static_cast<size_t>(dumpHead->infoLen), argsNum, isAssert);
}


static void AdxGetShapeInfo(const AdxDumpInfoHead *dumpHead, std::vector<size_t> &shape)
{
    const AdxDumpShapeMessageHead *const shapeHead = (const AdxDumpShapeMessageHead *)dumpHead->infoMsg;
    for (size_t i = 0U; i < shapeHead->dim; i++) {
        shape.push_back(shapeHead->shape[i]);
    }
}

static void AdxPrintPrint(const AdxDumpInfoHead *dumpHead, const bool isAssert, std::vector<size_t> &shapeInfo)
{
    if (!isAssert) {
        if (dumpHead->type == AdxDumpType::DUMP_SCALAR) {
            AdxPrintPrintInfo(dumpHead, isAssert);
        } else if (dumpHead->type == AdxDumpType::DUMP_TENSOR) {
            AdxPrintTensorInfo(dumpHead, shapeInfo);
        } else if (dumpHead->type == AdxDumpType::DUMP_SHAPE) {
            AdxGetShapeInfo(dumpHead, shapeInfo);
        }
    } else {
        if (dumpHead->type == AdxDumpType::DUMP_ASSERT) {
            AdxPrintPrintInfo(dumpHead, isAssert);
        }
    }
}

static std::string AdxGetCoreType(const uint8_t coreType, const uint8_t mixFlag)
{
    IDE_LOGD("DumpMeta: coreType is %u, mixFlag is %u.", coreType, mixFlag);
    static const std::map<uint8_t, std::string> CORE_TYPE_MAP{{1, "AIC"}, {2, "AIV"}};
    std::string strCoreType;
    if (mixFlag == 0U) {
        const auto &iter = CORE_TYPE_MAP.find(coreType);
        if (iter != CORE_TYPE_MAP.end()) {
            strCoreType =  iter->second;
        }
    } else {
        strCoreType = "MIX";
    }
    return strCoreType;
}

static void AdxPrintTimeStampInfo(const AdxDumpInfoHead *dumpHead, MsprofAicTimeStampInfo *timeStampInfo)
{
    const uint8_t *info = (const uint8_t *)(dumpHead->infoMsg);
    timeStampInfo->descId = *(reinterpret_cast<const uint32_t*>(info));
    info += sizeof(uint32_t);
    uint32_t rsv = *(reinterpret_cast<const uint32_t*>(info));
    info += sizeof(uint32_t);
    timeStampInfo->syscyc = *(reinterpret_cast<const uint64_t*>(info));
    info += sizeof(uint64_t);
    timeStampInfo->curPc = *(reinterpret_cast<const uint64_t*>(info));

    if (!g_adxPrintConfigFlag) {
        (void)printf("descId is %u, rsv is %u, timeStamp is %lu, pcPtr is %lu.\n",
            timeStampInfo->descId,
            rsv,
            timeStampInfo->syscyc,
            timeStampInfo->curPc);
    }
    IDE_LOGI("descId is %u, rsv is %u, timeStamp is %lu, pcPtr is %lu.",
        timeStampInfo->descId,
        rsv,
        timeStampInfo->syscyc,
        timeStampInfo->curPc);
}

static void AdxPrintHeadInfo(const uint8_t *blockData, const char *opType, const bool isAssert)
{
    const AdxBlockInfo *blockInfo = (const AdxBlockInfo *)(blockData);
    const std::string magicToHex = AdxToHex(blockInfo->magic);
    const AdxDumpMeta *dumpMeta = (const AdxDumpMeta *)(blockData + sizeof(AdxBlockInfo));
    const std::string coreTypeId = AdxGetCoreTypeId(blockInfo->core, dumpMeta->coreType);
    const std::string coreType = AdxGetCoreType(dumpMeta->coreType, dumpMeta->mixFlag);
    if (!isAssert) {
        std::cout << "opType=" << opType << ", ";
        IDE_LOGI("PrintInfo: opType=%s", opType);
    }
    if (blockInfo->rsv == ADX_OFF_LIMIT_RSV) {
        std::cout << "Remain block space is not enough, printing information may be incomplete!" << std::endl;
        IDE_LOGI("PrintInfo: Remain block space is not enough, printing information may be incomplete!");
    }
    std::cout << "DumpHead: " << coreTypeId << ", CoreType=" << coreType << ", block dim=" << dumpMeta->blockDim;
    std::cout << ", total_block_num=" << blockInfo->blockNum;
    std::cout << ", block_remain_len=" << blockInfo->remainLen << ", block_initial_space=" << blockInfo->len;
    std::cout << ", rsv=" << blockInfo->rsv << ", magic=" << magicToHex;
    std::cout << std::endl;
    IDE_LOGI("PrintInfo: DumpHead: %s, CoreType=%s, block dim=%d, "
             "total_block_num=%u, block_remain_len=%u, block_initial_space=%u, rsv=%u, magic=%s",
             coreTypeId.c_str(), coreType.c_str(), dumpMeta->blockDim,
             blockInfo->blockNum, blockInfo->remainLen, blockInfo->len, blockInfo->rsv, magicToHex.c_str());
}

static void AdxPrintSimtHeadInfo(const uint8_t *blockData, const char *opType)
{
    const AdxBlockInfo *blockInfo = Adx::SysUtils::ReinterpretCast<const AdxBlockInfo, const uint8_t>(blockData);
    const std::string magicToHex = AdxToHex(blockInfo->magic);
    const AdxSimtDumpMeta *dumpMeta = Adx::SysUtils::ReinterpretCast<const AdxSimtDumpMeta, const uint8_t>(blockData + sizeof(AdxBlockInfo));
    const uint32_t threadId = dumpMeta->threadId;

    std::cout << "opType=" << opType << ", blockId=" << blockInfo->core << ", threadId=" << threadId << std::endl;
    if (threadId == 0) {
        IDE_LOGD("Simt print info: opType=%s, blockId: %d, threadId=%d, "
                 "total_block_num=%u, block_remain_len=%u, block_initial_space=%u, rsv=%u, magic=%s",
                 opType, blockInfo->core, threadId,
                 blockInfo->blockNum, blockInfo->remainLen, blockInfo->len, blockInfo->rsv, magicToHex.c_str());
    }

    if (blockInfo->rsv == ADX_OFF_LIMIT_RSV) {
        std::cout << "Remain block space is not enough, printing information may be incomplete!" << std::endl;
        IDE_LOGI("Simt print info: Remain block space is not enough, printing information may be incomplete!");
    }
}

static void AdxPrintBlockInfo(const uint8_t *blockData, size_t blockDataLen, const char *opType, const bool isAssert,
    std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    const AdxBlockInfo *blockInfo = (const AdxBlockInfo *)(blockData);
    const size_t maxDataLen = blockDataLen - sizeof(AdxBlockInfo) - sizeof(AdxDumpMeta);
    if (static_cast<size_t>(blockInfo->remainLen) > maxDataLen) {
        IDE_LOGW("Block info remain length %u bytes illegal, must small than %zu bytes.",
            blockInfo->remainLen, maxDataLen);
        return;
    }

    bool flag = false;
    const uint8_t *beginAddr = blockData + sizeof(AdxBlockInfo) + sizeof(AdxDumpMeta);
    const size_t dataLen = maxDataLen - static_cast<size_t>(blockInfo->remainLen);
    size_t offset = 0UL;
    std::vector<size_t> shape;
    while ((offset + sizeof(AdxDumpInfoHead)) <= dataLen) {
        auto dumpHead = (const AdxDumpInfoHead *)(beginAddr + offset);
        if ((!flag) && ((dumpHead->type != AdxDumpType::DUMP_TIMESTAMP) ||
                           ((dumpHead->type == AdxDumpType::DUMP_TIMESTAMP) && (!g_adxPrintConfigFlag)))) {
            AdxPrintHeadInfo(blockData, opType, isAssert);
            flag = true;
        }
        offset += sizeof(AdxDumpInfoHead);
        offset += static_cast<size_t>(dumpHead->infoLen); // uint32转为size_t的，大小范围一定不会发生反转
        if (offset > dataLen) {
            IDE_LOGW("Dump data info length %u bytes illegal.", dumpHead->infoLen);
            return;
        }

        if ((dumpHead->type == AdxDumpType::DUMP_TIMESTAMP) && !isAssert) {
            MsprofAicTimeStampInfo timeInfo;
            timeInfo.blockId = blockInfo->core;
            AdxPrintTimeStampInfo(dumpHead, &timeInfo);
            timeStampInfo.push_back(timeInfo);
        } else {
            // 获取到shape信息时, 按照shape打印tensor
            AdxPrintPrint(dumpHead, isAssert, shape);
        }
    }
    return;
}

static void AdxPrintSimtBlockInfo(const uint8_t *blockData, size_t blockDataLen, const char *opType)
{
    const AdxBlockInfo *blockInfo = Adx::SysUtils::ReinterpretCast<const AdxBlockInfo, const uint8_t>(blockData);
    const size_t maxDataLen = blockDataLen - sizeof(AdxBlockInfo) - sizeof(AdxSimtDumpMeta);
    if (static_cast<size_t>(blockInfo->remainLen) > maxDataLen) {
        IDE_LOGW("Block info remainLen(%u) is illegal, must be small than %zu.", blockInfo->remainLen, maxDataLen);
        return;
    }

    const uint8_t *beginAddr = blockData + sizeof(AdxBlockInfo) + sizeof(AdxSimtDumpMeta);
    const size_t dataLen = maxDataLen - static_cast<size_t>(blockInfo->remainLen);
    size_t offset = 0UL;

    if ((offset + sizeof(AdxDumpInfoHead)) <= dataLen) {
        AdxPrintSimtHeadInfo(blockData, opType);
    }

    while ((offset + sizeof(AdxDumpInfoHead)) <= dataLen) {
        auto dumpHead = Adx::SysUtils::ReinterpretCast<const AdxDumpInfoHead, const uint8_t>(beginAddr + offset);

        offset += sizeof(AdxDumpInfoHead);
        offset += static_cast<size_t>(dumpHead->infoLen);
        if (offset > dataLen) {
            IDE_LOGW("Dump data info len(%u) is illegal.", dumpHead->infoLen);
            return;
        }

        if (dumpHead->type != AdxDumpType::DUMP_SIMT) {
            IDE_LOGW("Dump type(%u) is not DUMP_SIMT, just skip", dumpHead->type);
            continue;
        }

        AdxPrintPrintInfo(dumpHead, false);
    }
}

static void AdxPrintDumpdata(const std::vector<uint8_t> &printData, size_t dumpWorkSpaceSize, const char *opType,
    const bool isAssert, std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    const uint8_t *const addr = printData.data();
    const AdxBlockInfo *blockInfo = (const AdxBlockInfo *)(addr);

    size_t blockDataLen = blockInfo->len;
    IDE_LOGI("dumpWorkSpaceSize is %zu bytes, blockDataLen is %zu bytes.", dumpWorkSpaceSize, blockDataLen);
    if ((blockDataLen == 0U) || ((blockDataLen != ADX_MAX_STR_LEN) && (blockDataLen != ADX_ASSERT_LEN))) {
        const uint32_t *dataAddr = (const uint32_t *)printData.data();
        for (size_t i = 0U; (i + 4) < dumpWorkSpaceSize / sizeof(uint32_t); i++) { // magic和len隔了4个uint32_t
            if (*(dataAddr + i + 4) == ADX_DUMP_AND_PRINT_MAGIC_NUM) { // magic和len隔了4个uint32_t
                blockDataLen = *(dataAddr + i);
                break;
            }
        }
    }

    IDE_LOGD("printType is %d, 1 is assert, 0 is printf, blockDataLen is %zu.", isAssert, blockDataLen);

    if ((blockDataLen != ADX_MAX_STR_LEN) && (blockDataLen != ADX_ASSERT_LEN)) {
        IDE_LOGE("blockDataLen %zu bytes is illegal.", blockDataLen);
        return;
    }

    size_t blockNum = AdxGetBlockNum();
    for (size_t i = 0U; i < blockNum; i++) {
        const AdxBlockInfo *info = (const AdxBlockInfo *)(addr + blockDataLen * i);
        if (info->magic != ADX_DUMP_AND_PRINT_MAGIC_NUM) {
            IDE_LOGW("Block info[%zu] is illegal, magic is %u.", i, info->magic);
            continue;
        }
        AdxPrintBlockInfo(addr + blockDataLen * i, blockDataLen, opType, isAssert, timeStampInfo);
    }

    if (!AdxEnableSimtDump(dumpWorkSpaceSize)) {
        return;
    }

    const uint8_t *const simtAddr = addr + blockNum * blockDataLen;
    const AdxBlockInfo *simtBlockInfo = Adx::SysUtils::ReinterpretCast<const AdxBlockInfo, const uint8_t>(simtAddr);
    size_t simtBlockDataLen = simtBlockInfo->len;
    if (simtBlockDataLen != ADX_SIMT_PRINT_LEN) {
        IDE_LOGW("Simt block info length %zu is illegal.", simtBlockDataLen);
        return;
    }

    for (size_t i = 0U; i < ADX_SIMT_BLOCK_NUM; i++) {
        for (uint32_t j = 0U; j < ADX_SIMT_MAX_THREAD_NUM; j++) {
            uint32_t threadOffset = i * ADX_SIMT_MAX_THREAD_NUM + j;
            const AdxBlockInfo *info = Adx::SysUtils::ReinterpretCast<const AdxBlockInfo, const uint8_t>(simtAddr + simtBlockDataLen * threadOffset);

            if (info->magic != ADX_DUMP_AND_PRINT_MAGIC_NUM) {
                continue;
            }

            AdxPrintSimtBlockInfo(simtAddr + simtBlockDataLen * threadOffset, simtBlockDataLen, opType);
        }
    }
}

static rtError_t AdxGetWorkspaceData(void *printData, const void *workSpaceAddr,
    const size_t dumpWorkSpaceSize, aclrtStream stream, bool enableSync = true)
{
    int32_t timeout = GetStreamSynchronizeTimeout();
    if (enableSync) {
        auto rtRet = rtStreamSynchronizeWithTimeout(stream, timeout);
        if (rtRet != RT_ERROR_NONE) {
            IDE_LOGE("Synchronize stream failed, error code is %d.\n", rtRet);
            printf("ERROR: Synchronize stream failed, error code is %d, please check plog for more information.\n", rtRet);
        }
    }
    auto rtRet = rtMemcpy(printData, dumpWorkSpaceSize, workSpaceAddr,
        dumpWorkSpaceSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpy failed, ret: 0x%X, ori[%p], dts[%p], size[%lu bytes]. ",
            rtRet, workSpaceAddr, printData, dumpWorkSpaceSize);
    }
    return rtRet;
}

void AdxPrintWorkSpace(
    const void *workSpaceAddr,
    const size_t dumpWorkSpaceSize,
    aclrtStream stream,
    const char *opType, bool enableSync = true)
{
    std::vector<uint8_t> printData(dumpWorkSpaceSize);
    if (AdxGetWorkspaceData(printData.data(), workSpaceAddr,
        dumpWorkSpaceSize, stream, enableSync) == RT_ERROR_NONE) {
        std::vector<MsprofAicTimeStampInfo> timeStampInfo;
        AdxPrintDumpdata(printData, dumpWorkSpaceSize, opType, false, timeStampInfo);
    }
}

void AdxPrintSetConfig(const Adx::AdumpPrintConfig &config)
{
    const std::lock_guard<std::mutex> lock(g_adxPrintConfigMtx);
    g_adxPrintConfigFlag = config.printEnable;
}

void AdxPrintTimeStamp(
    const void *workSpaceAddr,
    const size_t dumpWorkSpaceSize,
    aclrtStream stream,
    const char *opType,
    std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    std::vector<uint8_t> printData(dumpWorkSpaceSize);
    if (AdxGetWorkspaceData(printData.data(), workSpaceAddr, dumpWorkSpaceSize, stream,
        true) == RT_ERROR_NONE) {
        AdxPrintDumpdata(printData, dumpWorkSpaceSize, opType, false, timeStampInfo);
    }
}

static bool AdxGetWorkspaceInfoForAssert(rtExceptionArgsInfo_t &argsInfo, rtArgsSizeInfo &sizeInfo,
                                         void **workSpaceAddr, uint64_t &workSpaceSize)
{
    uint64_t *infoAddr = reinterpret_cast<uint64_t *>(sizeInfo.infoAddr); // atomic
    IDE_LOGD("rtArgsSizeInfo is %p.", infoAddr);
    if (infoAddr == nullptr) {
        IDE_LOGW("Get sizeInfo addr is nullptr, unable to resolve assert info.");
        return false;
    }
    infoAddr++;
    uint64_t addrNum = *infoAddr;
    bool hasFftsAddr = false;
    hasFftsAddr = (((*infoAddr) >> ADX_FFTS_ADDR_OFFSET) == 1ULL) ? true : false;
    // 标记ffts地址
    if (hasFftsAddr) {
        addrNum &= ADX_INPUT_NUM_MASK;
    }
    infoAddr++;
    uint64_t offset = 0U;
    bool hasWorkSpaceSizeFlag = false;
    for (size_t i = 0; i < addrNum; i++) {
        // 标记workspace
        if (((*infoAddr) >> ADX_SIZE_BITS_OFFSET) == ADX_WORKSPACE_SIZE_FLAG) {
            workSpaceSize = (*infoAddr) & ADX_SIZE_MASK;
            hasWorkSpaceSizeFlag = true;
            break;
        }
        // 标记动态输入个数
        if (((*infoAddr) >> ADX_SIZE_BITS_OFFSET) == ADX_DYNAMIC_INPUT_FLAG) {
            uint64_t dynamicTensorNum = (*infoAddr) & ADX_SIZE_MASK;
            IDE_LOGD("[Assert] Get dynamicTensorNum is %lu.", dynamicTensorNum);
            infoAddr += dynamicTensorNum;
        }
        offset += 1;
        ++infoAddr;
    }
    if (!hasWorkSpaceSizeFlag) {
        return false;
    }
    // 获取workspace地址  argsInfo.argAddr args的首地址
    uint64_t *argsAddr = hasFftsAddr ? ((uint64_t *)argsInfo.argAddr + offset + 1U) :
        ((uint64_t *)argsInfo.argAddr + offset);

    auto rtRet = rtMemcpy(workSpaceAddr, sizeof(uint64_t), argsAddr,
        sizeof(uint64_t), RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpy failed, ret: 0x%X, ori[%p], dts[%p], size[%lu bytes].",
            rtRet, argsAddr, workSpaceAddr, sizeof(uint64_t));
        return false;
    }
    return true;
}

static void AdxPrintAssert(const void *workSpaceAddr, const size_t dumpWorkSpaceSize)
{
    IDE_LOGD("[Assert] workSpaceAddr[%p], dumpWorkSpaceSize[%llu].", workSpaceAddr, dumpWorkSpaceSize);
    std::vector<uint8_t> printData(dumpWorkSpaceSize);
    auto rtRet = rtMemcpy(printData.data(), dumpWorkSpaceSize, workSpaceAddr,
        dumpWorkSpaceSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGW("Call rtMemcpy failed, ret: 0x%X", rtRet);
        return;
    }
    std::vector<MsprofAicTimeStampInfo> timeStampInfo;
    AdxPrintDumpdata(printData, dumpWorkSpaceSize, "", true, timeStampInfo);
}

static bool AdxGetFftsWorkspaceInfoForAssert(uint16_t contextId, rtExceptionArgsInfo_t &argsInfo,
                                             rtArgsSizeInfo &sizeInfos, void **workSpaceAddr,
                                             uint64_t &workSpaceSize)
{
    constexpr uint32_t contextBeginIndex = 2u; // 2 is atomic + totalSize
    uint64_t *sizeInfo = reinterpret_cast<uint64_t *>(sizeInfos.infoAddr);
    IDE_LOGD("rtArgsSizeInfo is %p.", sizeInfo);
    if (sizeInfo == nullptr) {
        IDE_LOGW("Get sizeInfo addr is nullptr, unable to resolve assert info.");
        return false;
    }
    const uint64_t totalContextSizeNum = sizeInfo[1];
    uint32_t sizeBeginIndex = 0U;
    for (uint64_t sizeInfoIdx = contextBeginIndex; sizeInfoIdx < (totalContextSizeNum + contextBeginIndex);
        ++sizeInfoIdx) {
        if (sizeInfo[sizeInfoIdx] == contextId) {
            sizeBeginIndex = sizeInfoIdx + 3; // 3 - context id | args size | input num
            break;
        }
    }
 
    uint64_t offset = 0U;
    uint64_t *infoAddr = sizeInfo + sizeBeginIndex;
    bool hasWorkSpaceSizeFlag = false;
    for (size_t i = sizeBeginIndex; i < totalContextSizeNum; i++) {
        // 标记workspace
        if (((*infoAddr) >> ADX_SIZE_BITS_OFFSET) == ADX_WORKSPACE_SIZE_FLAG) {
            workSpaceSize = (*infoAddr) & ADX_SIZE_MASK;
            hasWorkSpaceSizeFlag = true;
            break;
        }
        // 标记动态输入个数
        if (((*infoAddr) >> ADX_SIZE_BITS_OFFSET) == ADX_DYNAMIC_INPUT_FLAG) {
            uint64_t dynamicTensorNum = (*infoAddr) & ADX_SIZE_MASK;
            IDE_LOGD("[Assert] Get dynamicTensorNum is %lu.", dynamicTensorNum);
            infoAddr += dynamicTensorNum;
        }
        offset += 1;
        ++infoAddr;
    }
    IDE_LOGD("[Assert] sizeBeginIndex is %lu, offset is %lu, totalContextSizeNum is %lu.",
        sizeBeginIndex, offset, totalContextSizeNum);
    if (!hasWorkSpaceSizeFlag) {
        IDE_LOGE("[Assert] not find workSpaceSize.");
        return false;
    }

    // 获取workspace地址  argsInfo.argAddr args的首地址
    uint64_t *argsAddr = (uint64_t *)argsInfo.argAddr + offset;
    auto rtRet = rtMemcpy(workSpaceAddr, sizeof(uint64_t), argsAddr,
        sizeof(uint64_t), RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpy failed, ret: 0x%X, ori[%p], dts[%p], size[%lu].",
            rtRet, argsAddr, workSpaceAddr, sizeof(uint64_t));
        return false;
    }
    return true;
}

bool AdxCheckAtomicIndex(const rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    if (exceptionArgsInfo.sizeInfo.infoAddr == nullptr) {
        IDE_LOGE("infoAddr is null");
        return false;
    }

    uint64_t *sizeInfo = static_cast<uint64_t *>(exceptionArgsInfo.sizeInfo.infoAddr);
    if (sizeInfo < Adx::g_chunk || sizeInfo > (Adx::g_chunk + Adx::RING_CHUNK_SIZE - 1)) {
        IDE_LOGE("[Assert] the size info[%p] address may out of the chunk[%p] address range.",
            sizeInfo, Adx::g_chunk);
        return false;
    }
    if (sizeInfo[0] != exceptionArgsInfo.sizeInfo.atomicIndex) {
        IDE_LOGE("[Dump][Exception] args exception atomic index between %llu and %llu is different.",
                sizeInfo[0], exceptionArgsInfo.sizeInfo.atomicIndex);
        return false;
    }
    return true;
}

void AdxAssertCallBack(rtExceptionInfo_t *exceptionInfo)
{
    uint32_t timeout = 0U;
    rtError_t ret = rtGetOpExecuteTimeoutV2(&timeout);
    if (ret != ACL_RT_SUCCESS) {
        IDE_LOGE("Get operator timeout failed, ret: %d", ret);
    } else {
        IDE_LOGI("Get operator timeout %ums", timeout);
        if (timeout < TIMEOUT_THRESHOLD) {
            IDE_LOGI("Operator timeout %ums, enable fast recovery, skip parsing printf/assert/DumpTensor content.",
                timeout);
            return;
        }
    }
    void *workSpaceAddr = nullptr;
    uint64_t dumpWorkSpaceSize = 0U;
    bool res = false;
    if (exceptionInfo != nullptr) {
        rtExceptionExpandType_t exceptionTaskType = exceptionInfo->expandInfo.type;
        rtExceptionArgsInfo_t exceptionArgsInfo{};
        if (exceptionTaskType == RT_EXCEPTION_AICORE) {
            exceptionArgsInfo = exceptionInfo->expandInfo.u.aicoreInfo.exceptionArgs;
        } else if (exceptionTaskType == RT_EXCEPTION_FFTS_PLUS) {
            exceptionArgsInfo = exceptionInfo->expandInfo.u.fftsPlusInfo.exceptionArgs;
        } else if (exceptionTaskType == RT_EXCEPTION_FUSION) {
            exceptionArgsInfo = exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs;
        } else {
            IDE_LOGW("Exception type[%d] is not supported.", static_cast<int32_t>(exceptionTaskType));
            return;
        }

        if (!AdxCheckAtomicIndex(exceptionArgsInfo)) {
            return;
        }

        if (exceptionTaskType == RT_EXCEPTION_FFTS_PLUS) {
            IDE_LOGD("[Assert] opType is mix fftsplus.");
            res = AdxGetFftsWorkspaceInfoForAssert(exceptionInfo->expandInfo.u.fftsPlusInfo.contextId,
                exceptionArgsInfo,
                exceptionArgsInfo.sizeInfo,
                &workSpaceAddr,
                dumpWorkSpaceSize);
        } else {
            res = AdxGetWorkspaceInfoForAssert(
                exceptionArgsInfo, exceptionArgsInfo.sizeInfo, &workSpaceAddr, dumpWorkSpaceSize);
        }
        if (res) {
            AdxPrintAssert(workSpaceAddr, dumpWorkSpaceSize);
            return;
        }
    }
}
#ifdef __cplusplus
}
#endif
