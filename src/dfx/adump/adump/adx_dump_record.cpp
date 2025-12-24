/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_dump_record.h"
#include <map>
#include <cinttypes>
#include <functional>
#include "mmpa_api.h"
#include "adx_log.h"
#include "file_utils.h"
#include "string_utils.h"
#include "memory_utils.h"
#include "common_utils.h"
#include "adx_dump_process.h"
#include "ide_os_type.h"
namespace Adx {
static const int32_t WAIT_RECORD_FILE_FINISH_TIME   = 500;
static const std::size_t MAX_IP_LENGTH              = 16;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
constexpr char STRING_BIN[] = ".bin";
constexpr char STRING_CSV[] = ".csv";
constexpr char CSV_HEADER[] = "Input/Output,Index,Data Size,Data Type,Format,Shape";

static const std::map<uint64_t, std::string> STATS_ITEM_MAP = {
    {DUMP_STATS_MAX,     ",Max Value"},
    {DUMP_STATS_MIN,     ",Min Value"},
    {DUMP_STATS_AVG,     ",Avg Value"},
    {DUMP_STATS_NAN,     ",Nan Count"},
    {DUMP_STATS_NEG_INF, ",Negative Inf Count"},
    {DUMP_STATS_POS_INF, ",Positive Inf Count"},
    {DUMP_STATS_L2NORM,  ",l2norm"}
};

static const std::map<toolkit::dump::OutputDataType, std::string> DT_STRING_MAP = {
    {toolkit::dump::DT_UNDEFINED,      "DT_UNDEFINED"},
    {toolkit::dump::DT_FLOAT,          "DT_FLOAT"},
    {toolkit::dump::DT_FLOAT16,        "DT_FLOAT16"},
    {toolkit::dump::DT_INT8,           "DT_INT8"},
    {toolkit::dump::DT_UINT8,          "DT_UINT8"},
    {toolkit::dump::DT_INT16,          "DT_INT16"},
    {toolkit::dump::DT_UINT16,         "DT_UINT16"},
    {toolkit::dump::DT_INT32,          "DT_INT32"},
    {toolkit::dump::DT_INT64,          "DT_INT64"},
    {toolkit::dump::DT_UINT32,         "DT_UINT32"},
    {toolkit::dump::DT_UINT64,         "DT_UINT64"},
    {toolkit::dump::DT_BOOL,           "DT_BOOL"},
    {toolkit::dump::DT_DOUBLE,         "DT_DOUBLE"},
    {toolkit::dump::DT_STRING,         "DT_STRING"},
    {toolkit::dump::DT_DUAL_SUB_INT8,  "DT_DUAL_SUB_INT8"},
    {toolkit::dump::DT_DUAL_SUB_UINT8, "DT_DUAL_SUB_UINT8"},
    {toolkit::dump::DT_COMPLEX64,      "DT_COMPLEX64"},
    {toolkit::dump::DT_COMPLEX128,     "DT_COMPLEX128"},
    {toolkit::dump::DT_QINT8,          "DT_QINT8"},
    {toolkit::dump::DT_QINT16,         "DT_QINT16"},
    {toolkit::dump::DT_QINT32,         "DT_QINT32"},
    {toolkit::dump::DT_QUINT8,         "DT_QUINT8"},
    {toolkit::dump::DT_QUINT16,        "DT_QUINT16"},
    {toolkit::dump::DT_RESOURCE,       "DT_RESOURCE"},
    {toolkit::dump::DT_STRING_REF,     "DT_STRING_REF"},
    {toolkit::dump::DT_DUAL,           "DT_DUAL"},
    {toolkit::dump::DT_VARIANT,        "DT_VARIANT"},
    {toolkit::dump::DT_BF16,           "DT_BF16"},
    {toolkit::dump::DT_INT4,           "DT_INT4"},
    {toolkit::dump::DT_UINT1,          "DT_UINT1"},
    {toolkit::dump::DT_INT2,           "DT_INT2"},
    {toolkit::dump::DT_UINT2,          "DT_UINT2"},
    {toolkit::dump::DT_HIFLOAT8,       "DT_HIFLOAT8"},
    {toolkit::dump::DT_FLOAT8_E5M2,    "DT_FLOAT8_E5M2"},
    {toolkit::dump::DT_FLOAT8_E4M3FN,  "DT_FLOAT8_E4M3FN"},
    {toolkit::dump::DT_FLOAT8_E8M0,    "DT_FLOAT8_E8M0"},
    {toolkit::dump::DT_FLOAT6_E3M2,    "DT_FLOAT6_E3M2"},
    {toolkit::dump::DT_FLOAT6_E2M3,    "DT_FLOAT6_E2M3"},
    {toolkit::dump::DT_FLOAT4_E2M1,    "DT_FLOAT4_E2M1"},
    {toolkit::dump::DT_FLOAT4_E1M2,    "DT_FLOAT4_E1M2"},
};
    
static const std::map<toolkit::dump::OutputFormat, std::string> FORMAT_STRING_MAP = {
    {toolkit::dump::FORMAT_NCHW, "NCHW"},
    {toolkit::dump::FORMAT_NHWC, "NHWC"},
    {toolkit::dump::FORMAT_ND, "ND"},
    {toolkit::dump::FORMAT_NC1HWC0, "NC1HWC0"},
    {toolkit::dump::FORMAT_FRACTAL_Z, "FRACTAL_Z"},
    {toolkit::dump::FORMAT_NC1C0HWPAD, "NC1C0HWPAD"},
    {toolkit::dump::FORMAT_NHWC1C0, "NHWC1C0"},
    {toolkit::dump::FORMAT_FSR_NCHW, "FSR_NCHW"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV, "FRACTAL_DECONV"},
    {toolkit::dump::FORMAT_C1HWNC0, "C1HWNC0"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_TRANSPOSE, "FRACTAL_DECONV_TRANSPOSE"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_SP_STRIDE_TRANS, "FRACTAL_DECONV_SP_STRIDE_TRANS"},
    {toolkit::dump::FORMAT_NC1HWC0_C04, "NC1HWC0_C04"},
    {toolkit::dump::FORMAT_FRACTAL_Z_C04, "FRACTAL_Z_C04"},
    {toolkit::dump::FORMAT_CHWN, "CHWN"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_SP_STRIDE8_TRANS, "FRACTAL_DECONV_SP_STRIDE8_TRANS"},
    {toolkit::dump::FORMAT_HWCN, "HWCN"},
    {toolkit::dump::FORMAT_NC1KHKWHWC0, "NC1KHKWHWC0"},
    {toolkit::dump::FORMAT_BN_WEIGHT, "BN_WEIGHT"},
    {toolkit::dump::FORMAT_FILTER_HWCK, "FILTER_HWCK"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_LOOKUPS, "HASHTABLE_LOOKUP_LOOKUPS"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_KEYS, "HASHTABLE_LOOKUP_KEYS"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_VALUE, "HASHTABLE_LOOKUP_VALUE"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_OUTPUT, "HASHTABLE_LOOKUP_OUTPUT"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_HITS, "HASHTABLE_LOOKUP_HITS"},
    {toolkit::dump::FORMAT_C1HWNCoC0, "C1HWNCoC0"},
    {toolkit::dump::FORMAT_MD, "MD"},
    {toolkit::dump::FORMAT_NDHWC, "NDHWC"},
    {toolkit::dump::FORMAT_FRACTAL_ZZ, "FRACTAL_ZZ"},
    {toolkit::dump::FORMAT_FRACTAL_NZ, "FRACTAL_NZ"},
    {toolkit::dump::FORMAT_NCDHW, "NCDHW"},
    {toolkit::dump::FORMAT_DHWCH, "DHWCH"},
    {toolkit::dump::FORMAT_NDC1HWC0, "NDC1HWC0"},
    {toolkit::dump::FORMAT_FRACTAL_Z_3D, "FRACTAL_Z_3D"},
    {toolkit::dump::FORMAT_CN, "CN"},
    {toolkit::dump::FORMAT_NC, "NC"},
    {toolkit::dump::FORMAT_DHWNC, "DHWNC"},
    {toolkit::dump::FORMAT_FRACTAL_Z_3D_TRANSPOSE, "FRACTAL_Z_3D_TRANSPOSE"},
    {toolkit::dump::FORMAT_FRACTAL_ZN_LSTM, "FRACTAL_ZN_LSTM"},
    {toolkit::dump::FORMAT_FRACTAL_Z_G, "FRACTAL_Z_G"},
    {toolkit::dump::FORMAT_RESERVED, "RESERVED"},
    {toolkit::dump::FORMAT_ALL, "ALL"},
    {toolkit::dump::FORMAT_NULL, "NULL"},
    {toolkit::dump::FORMAT_ND_RNN_BIAS, "ND_RNN_BIAS"},
    {toolkit::dump::FORMAT_FRACTAL_ZN_RNN, "FRACTAL_ZN_RNN"},
    {toolkit::dump::FORMAT_NYUV, "NYUV"},
    {toolkit::dump::FORMAT_NYUV_A, "NYUV_A"},
    {toolkit::dump::FORMAT_NCL, "NCL"},
    {toolkit::dump::FORMAT_FRACTAL_Z_WINO, "FRACTAL_Z_WINO"},
    {toolkit::dump::FORMAT_C1HWC0, "C1HWC0"}
};
#endif

AdxDumpRecord::AdxDumpRecord()
    : dumpRecordFlag_(true),
      dumpInitNum_(0)
{
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    fileNameStatus_.reserve(FILENAME_CHECK_SIZE_MAX);
    for (size_t idx = 0; idx < FILENAME_CHECK_SIZE_MAX; ++idx) {
        fileNameStatus_.push_back("");
    }
    funcMap_ = {
        {0, std::bind(&AdxDumpRecord::TypeDataHandle, this, std::placeholders::_1, std::placeholders::_2)}, // max
        {1, std::bind(&AdxDumpRecord::TypeDataHandle, this, std::placeholders::_1, std::placeholders::_2)}, // min
        {2, std::bind(&AdxDumpRecord::FloatDataHandle, this, std::placeholders::_1)}, // avg
        {3, std::bind(&AdxDumpRecord::Int32DataHandle, this, std::placeholders::_1)}, // nan
        {4, std::bind(&AdxDumpRecord::Int32DataHandle, this, std::placeholders::_1)}, // neg inf
        {5, std::bind(&AdxDumpRecord::Int32DataHandle, this, std::placeholders::_1)}, // pos inf
        {6, std::bind(&AdxDumpRecord::FloatDataHandle, this, std::placeholders::_1)}, // l2norm
    };
#endif
}

AdxDumpRecord::~AdxDumpRecord()
{
    UnInit();
}

int32_t AdxDumpRecord::GetDumpInitNum() const
{
    return dumpInitNum_;
}

void AdxDumpRecord::UpdateDumpInitNum(bool isPlus)
{
    if (isPlus) {
        dumpInitNum_++;
    } else {
        dumpInitNum_--;
    }
}

/**
 * @brief initialize record file
 * @param [in] recordPath : record file Path
 * @return
 *      IDE_DAEMON_ERROR : falied
 *      IDE_DAEMON_OK : success
 */
int32_t AdxDumpRecord::Init(const std::string &hostPid)
{
    // non-soc case
    if (hostPid.empty()) {
        char dumpPath[MAX_FILE_PATH_LENGTH] = {0};
        if (mmGetCwd(dumpPath, sizeof(dumpPath)) != EN_OK) {
            IDE_LOGE("get current dir failed ");
            return IDE_DAEMON_ERROR;
        }
        dumpPath_ = dumpPath;
    } else {
#if (OS_TYPE == LINUX)
        // soc case
        std::string appBin = "/proc/" + hostPid + "/exe";
        errno = 0;
        if (!FileUtils::IsFileExist(appBin) && errno != EACCES) {
            appBin = "/local/proc/" + hostPid + "/exe"; // aoscore
        }
        uint32_t pathSize = MMPA_MAX_PATH + 1;
        IdeStringBuffer curPath = reinterpret_cast<IdeStringBuffer>(IdeXmalloc(pathSize));
        IDE_CTRL_VALUE_FAILED(curPath != nullptr, return IDE_DAEMON_ERROR, "malloc failed");
        errno = 0;
        int32_t len = readlink(appBin.c_str(), curPath, MMPA_MAX_PATH); // read self path of store
        if (len < 0 || len > MMPA_MAX_PATH) {
            IDE_LOGE("Can't get app bin directory, strerr: %s, length: %d bytes, path: %s",
                strerror(errno), len, appBin.c_str());
            IDE_XFREE_AND_SET_NULL(curPath);
            return IDE_DAEMON_ERROR;
        }
        IDE_LOGI("get app bin path: %s", curPath);
        curPath[len] = '\0'; // add string end char
        dumpPath_ = curPath;
        std::string::size_type idx = dumpPath_.find_last_of(OS_SPLIT_STR);
        dumpPath_ = dumpPath_.substr(0, idx);
        IDE_XFREE_AND_SET_NULL(curPath);
#endif
    }
    IDE_LOGI("dumpPath prefix is %s", dumpPath_.c_str());
    if (!dumpPath_.empty() && dumpPath_.back() != OS_SPLIT_CHAR) {
        dumpPath_ += OS_SPLIT_CHAR;
    }
    hostDumpDataInfoQueue_.Init();
    IDE_LOGI("record remote dump temp path: %s", dumpPath_.c_str());
    hostDumpDataInfoQueue_.SetPath(dumpPath_);
    dumpRecordFlag_ = true;
    return IDE_DAEMON_OK;
}

/**
 * @brief initialize record file
 * @param [in] recordPath : record file Path
 * @return
 *      IDE_DAEMON_ERROR : falied
 *      IDE_DAEMON_OK : success
 */
int32_t AdxDumpRecord::UnInit()
{
    IDE_LOGI("start to dump uninit");
    dumpRecordFlag_ = false;
#if !defined(__IDE_UT) && !defined(__IDE_ST)
    while (!DumpDataQueueIsEmpty()) {
        mmSleep(WAIT_RECORD_FILE_FINISH_TIME);
    }
#if !defined(ANDROID)
    this->hostDumpDataInfoQueue_.Quit();
#endif
#endif
    IDE_LOGI("dump uninit success");
    return IDE_DAEMON_OK;
}

/**
 * @brief record dump data to disk
 * @param [in] dumpChunk : dump chunk
 * @return
 *      true : record dump data to disk success
 *      false : record dump data to disk failed
 */
bool AdxDumpRecord::RecordDumpDataToDisk(const DumpChunk &dumpChunk) const
{
    // dump file aging
    std::string filePath = dumpChunk.fileName;
    if (filePath.empty()) {
        IDE_LOGE("filepath of received dump chunk is empty");
        return false;
    }
    if (JudgeRemoteFalg(filePath)) {
        auto pos = filePath.find_first_of(":");
        filePath = filePath.substr(pos + 1);
        filePath = dumpPath_ + filePath;
    } else {
        if (!FileUtils::IsAbsolutePath(filePath)) {
            filePath = dumpPath_ + filePath;
        }
    }

#if (OS_TYPE != LINUX)
    filePath = FileUtils::ReplaceAll(filePath, "/", "\\");
#endif

    IDE_LOGI("start to record dump data to disk path: %s", filePath.c_str());

    std::string saveDirName = FileUtils::GetFileDir(filePath);
    if (!FileUtils::IsFileExist(saveDirName)) {
        if (FileUtils::CreateDir(saveDirName) != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("create dir failed path: %s", filePath.c_str());
            return false;
        }
    }

    while (FileUtils::IsDiskFull(saveDirName, dumpChunk.bufLen)) {
        IDE_LOGE("don't have enough free disk %u bytes", dumpChunk.bufLen);
        return false;
    }

    std::string realPath;
    if (FileUtils::FileNameIsReal(filePath, realPath) != IDE_DAEMON_OK) {
        IDE_LOGE("real path: %s", filePath.c_str());
        return false;
    }

    IdeErrorT err = FileUtils::WriteFile(realPath.c_str(),
        dumpChunk.dataBuf, dumpChunk.bufLen, dumpChunk.offset);
    if (err != IDE_DAEMON_NONE_ERROR) {
        (void)remove(realPath.c_str());
        IDE_LOGE("WriteFile failed, fileName: %s, err: %d", realPath.c_str(), err);
        return false;
    }
    IDE_LOGI("record dump data success: %s", realPath.c_str());
    return true;
}

/**
 * @brief judge if is remote case based on flag
 * @param [in] msg : flag msg
 * @return
 *      true : is remote case
 *      false : not remote case
 */
bool AdxDumpRecord::JudgeRemoteFalg(const std::string &msg) const
{
    std::size_t len = msg.find_first_of (":");
    if (len != std::string::npos && len < MAX_IP_LENGTH) {
        std::string ipStr = msg.substr(0, len);
        if (StringUtils::IpValid(ipStr)) {
            IDE_LOGD("remote ip info check pass: %s", ipStr.c_str());
            return true;
        }
    }
    IDE_LOGD("non remote ip case checked.");

    return false;
}

void AdxDumpRecord::SetWorkPath(const std::string &path)
{
    workPath_ = path;
}

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
void AdxDumpRecord::SetOptimizationMode(uint64_t statsItem)
{
    if (dumpStatsItem_ == statsItem) {
        return;
    }
    dumpStatsItem_ = statsItem;
    IDE_LOGI("SetOptimizationMode success with stats items:[0x%llx]", dumpStatsItem_);
    uint16_t statsNum = 0;
    statsHeader_ = CSV_HEADER;
    statsList_.clear();

    if (dumpStatsItem_ == (DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF |
        DUMP_STATS_POS_INF)) {
        compatible_ = true;
    } else {
        statsHeader_ += ",Count";
    }
    for (auto it = STATS_ITEM_MAP.begin(); it != STATS_ITEM_MAP.cend(); ++it) {
        if ((dumpStatsItem_ & it->first) != 0) {
            if (compatible_ && statsNum == COUNT_HEADER_COMPATIBLE) {
                statsHeader_ += ",Count";
            }
            statsHeader_ += it->second;
            statsList_.push_back(statsNum);
        }
        ++statsNum;
    }
    IDE_LOGI("SetOptimizationMode generate table header [%s].", statsHeader_.c_str());
}

std::string AdxDumpRecord::GetShapeString(const uint32_t shape[], int32_t shapeSize, int64_t &count) const
{
    IDE_CTRL_VALUE_FAILED(shapeSize <= MAX_SHAPE_SIZE, return "NA", "Shape size %d is out of range %d",
        shapeSize, MAX_SHAPE_SIZE);
    if (shapeSize == 0) { // 没有shape信息时，保持原有方式用-占位
        return "-";
    }
    std::ostringstream oss;
    for (int32_t idx = 0; idx < shapeSize; ++idx) {
        count *= shape[idx];
        oss << shape[idx];
        if (idx != shapeSize - 1) {
            oss << "x";
        }
    }
    return oss.str();
}

template <typename T>
std::string AdxDumpRecord::GetStringName(T key, const std::map<T, std::string> &stringMap) const
{
    auto it = stringMap.find(key);
    if (it != stringMap.cend()) {
        return it->second;
    }
    IDE_LOGW("Cannot find [%d] type name in string map.", key);
    return "UNKNOW";
}

std::string AdxDumpRecord::Int32DataHandle(const int64_t &data) const
{
    DataTypeUnion dtUnion;
    dtUnion.longIntValue = data;
    return std::to_string(dtUnion.intValue[0]);
}

std::string AdxDumpRecord::FloatDataHandle(const int64_t &data) const
{
    DataTypeUnion dtUnion;
    dtUnion.longIntValue = data;
    std::ostringstream oss;
    oss << dtUnion.floatValue;
    return oss.str();
}

std::string AdxDumpRecord::TypeDataHandle(const int64_t &data, toolkit::dump::OutputDataType dType) const
{
    // 如果dt是int64数据读取为int64；dt是非int64数据读取为int32，dt是float数据读取为float32
    if (dType == toolkit::dump::DT_FLOAT || dType == toolkit::dump::DT_FLOAT16 || dType == toolkit::dump::DT_BF16 ||
        dType == toolkit::dump::DT_HIFLOAT8 || dType == toolkit::dump::DT_FLOAT8_E5M2 ||
        dType == toolkit::dump::DT_FLOAT8_E4M3FN) {
        return FloatDataHandle(data);
    } else if (dType == toolkit::dump::DT_INT64) {
        return std::to_string(data);
    } else {
        return Int32DataHandle(data);
    }
}

std::string AdxDumpRecord::GetStatsString(toolkit::dump::OutputDataType dType, uint16_t pos, const int64_t &data)
{
    auto it = funcMap_.find(pos);
    if (it != funcMap_.cend()) {
        std::string result = it->second(data, dType);
        return result;
    } else {
        IDE_LOGW("Dump stats [%hu] is not supported.", pos);
        return "NA";
    }
}

bool AdxDumpRecord::CheckFileNameExist(const std::string &filename)
{
    auto it = std::find(fileNameStatus_.begin(), fileNameStatus_.end(), filename);
    if (it != fileNameStatus_.end()) {
        return true;
    }
    return false;
}

void AdxDumpRecord::AppendFileName(const std::string &filename)
{
    // Stores the names of processed files.
    fileNameStatus_[filenameIndex_] = filename;
    filenameIndex_ = (filenameIndex_ + 1) % fileNameStatus_.size();
}

void AdxDumpRecord::StatisticsData(std::stringstream &strStream, std::shared_ptr<OpStatsResult> statsResult,
    const int64_t &count, const int32_t &idx)
{
    if (statsResult->stat[idx].result != 0) {
        IDE_LOGW("Stats data is unsupported, index is %d, size is %" PRId64 ", result is %u.",
            statsResult->stat[idx].index, statsResult->stat[idx].size, statsResult->stat[idx].result);
        for (size_t i = 0; i < statsList_.size(); ++i) {
            if (compatible_ && i == COUNT_HEADER_COMPATIBLE) {
                strStream << "," << count;
            }
            strStream << "," << "NA";
        }
    } else {
        size_t statsSize = sizeof(statsResult->stat[idx].stats) / sizeof(statsResult->stat[idx].stats[0]);
        if (!compatible_) {
            strStream << "," << count;
        }
        for (const uint16_t &pos : statsList_) {
            IDE_CTRL_VALUE_FAILED_NODO(pos < statsSize, continue, "Index %hu is out of range %" PRIu64 ".",
                pos, statsSize);
            if (compatible_ && pos == COUNT_HEADER_COMPATIBLE) {
                strStream << "," << count;
            }
            strStream << "," << GetStatsString(
                static_cast<toolkit::dump::OutputDataType>(statsResult->stat[idx].dType), pos,
                statsResult->stat[idx].stats[pos]);
        }
    }
}

bool AdxDumpRecord::GenerateFileData(std::stringstream &strStream, const std::string &filename,
    std::shared_ptr<OpStatsResult> statsResult)
{
    IDE_CTRL_VALUE_FAILED(statsResult->statItem != 0, return false, "Dump stats is empty, nothing need to do.");
    IDE_CTRL_VALUE_FAILED(statsResult->tensorNum <= MAX_STATS_RESULT_NUM, return false,
        "Dump stats number %d is bigger than %d.", statsResult->tensorNum, MAX_STATS_RESULT_NUM);
    SetOptimizationMode(statsResult->statItem);
    // If the file name is processed for the first time, add the table header.
    if (!CheckFileNameExist(filename)) {
        strStream << statsHeader_;
        strStream << "\n";
    }

    for (int32_t idx = 0; idx < statsResult->tensorNum; ++idx) {
        IDE_LOGI("Process the data in file %s for the %d times.", filename.c_str(), idx);
        int64_t count = 1; // 默认count值为1
        std::string ioString = statsResult->stat[idx].io == 0 ? "Input" : "Output";
        strStream << ioString;
        strStream << "," << statsResult->stat[idx].index;
        strStream << "," << statsResult->stat[idx].size;
        strStream << "," << GetStringName(static_cast<toolkit::dump::OutputDataType>(statsResult->stat[idx].dType),
            DT_STRING_MAP);
        strStream << "," << GetStringName(static_cast<toolkit::dump::OutputFormat>(statsResult->stat[idx].format),
            FORMAT_STRING_MAP);
        strStream << "," << GetShapeString(statsResult->stat[idx].shape, statsResult->stat[idx].shapeSize, count);
        IDE_LOGD("Process the data with index[%d], io[%d], statsLen[%u], result[%u], shapeSize[%d], size[%" PRId64 "].",
            statsResult->stat[idx].index, statsResult->stat[idx].io, statsResult->stat[idx].statsLen,
            statsResult->stat[idx].result, statsResult->stat[idx].shapeSize, statsResult->stat[idx].size);

        StatisticsData(strStream, statsResult, count, idx);
        strStream << "\n";
    }
    return true;
}

bool AdxDumpRecord::DumpDataToCallback(const std::string &filename, const std::string &dumpData, int64_t offSet,
    int32_t flag)
{
    IDE_LOGD("Ready to send file %s to mindspore session!", filename.c_str());
    IDE_CTRL_VALUE_FAILED(!dumpData.empty(), return false, "Dump data in DumpDataToCallback is empty.");

    std::function<int32_t(const struct DumpChunk *, int32_t)> messageCallback = AdxDumpProcess::Instance().GetCallbackFun();
    IDE_CTRL_VALUE_FAILED(messageCallback, return false, "Registered messageCallback function is not callable,\
            drop this data packet, filename:%s", filename.c_str());

    auto dumpChunkLen = sizeof(DumpChunk) + dumpData.size() + 1;
    std::unique_ptr<DumpChunk, void(*)(DumpChunk*)> dumpChunk(static_cast<DumpChunk*>(IdeXmalloc(dumpChunkLen)),
        [](DumpChunk *p) { IdeXfree(p); });
    IDE_CTRL_VALUE_FAILED(dumpChunk != nullptr, return IDE_DAEMON_ERROR, "Failed to malloc for dump chunk.");

    errno_t err = strncpy_s(dumpChunk->fileName, MAX_FILE_PATH_LENGTH, filename.c_str(), filename.size());
    IDE_CTRL_VALUE_FAILED(err == EOK, return false, "Filename string copy failed, err: %d", err);
    dumpChunk->bufLen = dumpData.size() + 1;
    dumpChunk->offset = offSet;
    dumpChunk->flag = flag;
    dumpChunk->isLastChunk = 1;

    err = strncpy_s(reinterpret_cast<AdxStringBuffer>(dumpChunk->dataBuf), dumpChunk->bufLen,
        dumpData.c_str(), dumpData.size());
    IDE_CTRL_VALUE_FAILED(err == EOK, return false, "DataBuf string copy failed, err: %d", err);

    int32_t ret = messageCallback(dumpChunk.get(), dumpChunkLen);
    IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_NONE_ERROR, return false,
        "Failed to transmission dump data to mindspore. err = %d", ret);
    IDE_LOGI("Send dump data to mindspore success: %s", filename.c_str());
    AppendFileName(filename);
    return true;
}

bool AdxDumpRecord::FileNameCheck(const DumpChunk &dumpChunk) const
{
    size_t binSize = strlen(STRING_BIN);
    std::string filename = dumpChunk.fileName;
    size_t nameSize = filename.size();
    if (nameSize > binSize && filename.compare(nameSize - binSize, binSize, STRING_BIN) == 0 &&
        dumpChunk.bufLen == sizeof(OpStatsResult)) {
        IDE_LOGI("Received dump buffer length %u bytes, file name [%s].", dumpChunk.bufLen, dumpChunk.fileName);
        return true;
    }
    IDE_LOGD("File name [%s] of dump chunk is not end with .bin, or data size %u bytes is different from %" PRIu64 ".",
        dumpChunk.fileName, dumpChunk.bufLen, sizeof(OpStatsResult));
    return false;
}

bool AdxDumpRecord::StatsDataParsing(const DumpChunk &dumpChunk)
{
    std::string filename = dumpChunk.fileName;
    filename.replace(filename.size() - strlen(STRING_BIN), strlen(STRING_BIN), STRING_CSV);

    std::shared_ptr<OpStatsResult> statsResult;
    try {
        statsResult = std::make_shared<OpStatsResult>();
    } catch (std::exception &ex) {
        IDE_LOGE("Make shared failed, message: %s", ex.what());
        return false;
    }
    auto err = memcpy_s(statsResult.get(), dumpChunk.bufLen, dumpChunk.dataBuf, dumpChunk.bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return false, "Filename string copy failed, err: %d", err);

    std::stringstream strStream;
    IDE_CTRL_VALUE_FAILED(GenerateFileData(strStream, filename, statsResult), return false, "Failed to export data.");

    if (AdxDumpProcess::Instance().IsRegistered()) { // dump data to mindspore and return
        return DumpDataToCallback(filename, strStream.str(), dumpChunk.offset, dumpChunk.flag);
    }

    if (JudgeRemoteFalg(filename)) {
        auto pos = filename.find_first_of(":");
        filename = filename.substr(pos + 1);
        filename = dumpPath_ + filename;
    } else {
        if (!FileUtils::IsAbsolutePath(filename)) {
            filename = dumpPath_ + filename;
        }
    }

#if (OS_TYPE != LINUX)
    filename = FileUtils::ReplaceAll(filename, "/", "\\");
#endif

    std::string dirName = FileUtils::GetFileDir(filename);
    if (!FileUtils::IsFileExist(dirName)) {
        IDE_CTRL_VALUE_FAILED(FileUtils::CreateDir(dirName) == IDE_DAEMON_NONE_ERROR, return false,
            "Create dir failed path: %s", dirName.c_str());
    }
    while (FileUtils::IsDiskFull(dirName, dumpChunk.bufLen)) {
        IDE_LOGE("Don't have enough free disk %u bytes", dumpChunk.bufLen);
        return false;
    }

    std::string realPath;
    IDE_CTRL_VALUE_FAILED(FileUtils::FileNameIsReal(filename, realPath) == IDE_DAEMON_OK, return false,
        "File name is not real: %s", filename.c_str());

    IDE_CTRL_VALUE_FAILED(FileUtils::WriteFile(filename, strStream.str().c_str(), strStream.str().size(),
        dumpChunk.offset) == IDE_DAEMON_NONE_ERROR, return false, "Failed to dump file %s to path %s",
        filename.c_str(), dirName.c_str());
    IDE_LOGI("Record dump stats data success: %s", filename.c_str());
    AppendFileName(filename);
    return true;
}
#endif

/**
 * @brief record dump info to the file
 * @param [in] data : record data
 * @return
 *      IDE_DAEMON_ERROR : falied
 *      IDE_DAEMON_OK : success
 */
void AdxDumpRecord::RecordDumpInfo()
{
    IDE_RUN_LOGI("start dump thread, remote dump record temp path : %s.", dumpPath_.c_str());
    while (dumpRecordFlag_ || !DumpDataQueueIsEmpty()) {
        HostDumpDataInfo data = {nullptr, 0};
        if (!hostDumpDataInfoQueue_.Pop(data)) {
            continue;
        }

        if (data.msg == nullptr) {
            continue;
        }
        IDE_LOGD("record new file");
        SharedPtr<MsgProto> dataInfo = data.msg;
        DumpChunk *dumpChunk = reinterpret_cast<DumpChunk*>(dataInfo->data);
        if (dumpChunk == nullptr) {
            IDE_LOGW("transfered dumpChunk is nullptr");
            continue;
        }

        IDE_LOGI("Queue pop data success! filename: %s, offset: %" PRId64 ", bufLen: %u bytes, isLast: %u, flag: %d.",
            dumpChunk->fileName, dumpChunk->offset, dumpChunk->bufLen, dumpChunk->isLastChunk, dumpChunk->flag);
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
        if (FileNameCheck(*dumpChunk)) {
            IDE_CTRL_VALUE_FAILED_NODO(StatsDataParsing(*dumpChunk), continue,
                "Failed to parse dump data with file name %s", dumpChunk->fileName);
            IDE_LOGD("New popped data process success");
            continue;
        }
#endif
        if (AdxDumpProcess::Instance().IsRegistered()) {
            IDE_LOGI("mindspore session!");
            std::function<int32_t(const struct DumpChunk *, int32_t)> messageCallback =
            AdxDumpProcess::Instance().GetCallbackFun();
            if (!messageCallback) {
                IDE_LOGE("Registered messageCallback function is not callable,\
                    drop this data packet, fileName:%s", dumpChunk->fileName);
                continue;
            }
            int32_t dumpChunkLen = sizeof(struct DumpChunk) + dumpChunk->bufLen;
            int32_t ret = messageCallback(dumpChunk, dumpChunkLen);
            if (ret != IDE_DAEMON_NONE_ERROR) {
                IDE_LOGE("failed to transmission dump data to mindspore. err = %d", ret);
            }
        } else if (!RecordDumpDataToDisk(*dumpChunk)) {
            IDE_LOGE("failed to record dump data to disk.");
        }
        IDE_LOGD("new popped data process success");
    }
    IDE_LOGI("exit record file thread");
}

/**
 * @brief record dump info to the file
 * @param [in] data : record data
 * @return
 *      IDE_DAEMON_ERROR : falied
 *      IDE_DAEMON_OK : success
 */
bool AdxDumpRecord::RecordDumpDataToQueue(HostDumpDataInfo &info)
{
    if (hostDumpDataInfoQueue_.IsFull()) {
        const std::string tipFull = "Memory usage exceeds 85%, the dump data queue is full";
        const std::string tipReduce = "Please reduce model batches, images or dump layers";
        const std::string tipMemory = "Or clear the used memory or increase the maximum memory";
        IDE_LOGW("%s. %s. %s.", tipFull.c_str(), tipReduce.c_str(), tipMemory.c_str());
        return false;
    } else {
        hostDumpDataInfoQueue_.Push(info);
        IDE_LOGD("Insert dump data to queue success.");
    }

    return true;
}

/**
 * @brief get dump size from the record lists
 * @param [in] tag : tag of record lists
 * @return
 *      true : success
 *     false : false
 */
bool AdxDumpRecord::DumpDataQueueIsEmpty() const
{
    return hostDumpDataInfoQueue_.IsEmpty();
}

void AdxDumpRecord::SetDumpPath(const std::string &dumpPath)
{
    dumpPath_ = dumpPath;
}
}
