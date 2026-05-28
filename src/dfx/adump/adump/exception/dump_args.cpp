/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <set>
#include <cmath>
#include "dump_args.h"
#include "dfx_args_parser.h"
#include <cinttypes>
#include "path.h"
#include "dump_file.h"
#include "sys_utils.h"
#include "dump_memory.h"
#include "log/hdc_log.h"
#include "exception_info_common.h"
#include "dump_tensor_plugin.h"
#include "adump_dsmi.h"
#include "log/adx_log.h"

namespace Adx {
namespace {
constexpr uint32_t ATOMIC_AND_INPUT_NUM_OFFSET = 2;     // 2 - atomic index | input num(or total context size num)
constexpr uint32_t CONTEXTID_AND_INPUT_NUM_OFFSET = 2;  // 2 - context id | input num
constexpr uint32_t SKIP_NUM_SHIFT_BITS = 32;
constexpr uint64_t SKIP_NUM_MASK = 0x0FFFFFFFF00000000;   // high 32 bits
constexpr uint64_t INPUT_NUM_MASK = 0x0FFFFFFFF;          // low 32 bits
constexpr uint64_t SIZE_TYPE_MASK = 0x0FF00000000000000;  // high 8 bits
constexpr uint64_t SIZE_MASK = 0x0FFFFFFFFFFFFFF;         // low 56 bits
constexpr uint32_t SIZE_TYPE_SHIFT_BITS = 56;
constexpr uint8_t NORMAL_TENSOR = 0;
constexpr uint8_t NORMAL_PTR_TENSOR = 1;
constexpr uint8_t SHAPE_PTR_TENSOR = 2;
constexpr uint8_t TILING_DATA_PTR = 3;
constexpr uint8_t WORKSPACE_TENSOR = 4;
constexpr uint32_t ARGS_PER_STRING_MAX_LEN = 20;
}  // namespace

template <typename T>
int32_t DumpArgs::GetPointerValueByBigEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                             uint16_t totalDfxSize) const
{
    uint16_t bitOfByte = 8;
    for (size_t i = 0; i < sizeof(T); ++i) {
        if (currentDfxSize >= totalDfxSize) {
            IDE_LOGE("The dfx data size[%" PRIu64 "] is larger than the total dfx size[%" PRIu16 "].", currentDfxSize,
                     totalDfxSize);
            return ADUMP_FAILED;
        }
        value = (value) | (static_cast<uint64_t>(**ptr) << ((sizeof(T) - i - 1) * bitOfByte));
        currentDfxSize++;
        (*ptr)++;
    }

    return ADUMP_SUCCESS;
}

template <typename T>
int32_t DumpArgs::GetPointerValueByLittleEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                                uint16_t totalDfxSize) const
{
    uint16_t bitOfByte = 8;
    for (size_t i = 0; i < sizeof(T); ++i) {
        if (currentDfxSize >= totalDfxSize) {
            IDE_LOGE("The dfx data size[%" PRIu64 "] is larger than the total dfx size[%" PRIu16 "].", currentDfxSize,
                     totalDfxSize);
            return ADUMP_FAILED;
        }
        value = (value) | (static_cast<uint64_t>(**ptr) << (i * bitOfByte));
        currentDfxSize++;
        (*ptr)++;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::FindExceptionDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    const uint8_t *metaDfxPtr = static_cast<const uint8_t *>(exceptionArgsInfo.exceptionKernelInfo.dfxAddr);
    uint16_t metaDfxSize = exceptionArgsInfo.exceptionKernelInfo.dfxSize;
    std::stringstream metaDfxStr;
    for (uint16_t i = 0; i < metaDfxSize; ++i) {
        metaDfxStr << int32_t(*(metaDfxPtr + i)) << ", ";
    }
    IDE_LOGI("The meta dfx raw data:%s ", metaDfxStr.str().c_str());

    uint64_t currDfxSize = 0;
    while (currDfxSize < metaDfxSize) {
        uint16_t dfxType = 0;
        uint16_t dfxLength = 0;
        int32_t ret = ADUMP_SUCCESS;
        if (exceptionArgsInfo.exceptionKernelInfo.elfDataFlag == ELF_DATA2MSB) {
            ret = GetPointerValueByBigEndian(&metaDfxPtr, dfxType, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            ret = GetPointerValueByBigEndian(&metaDfxPtr, dfxLength, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else {
            ret = GetPointerValueByLittleEndian(&metaDfxPtr, dfxType, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            ret = GetPointerValueByLittleEndian(&metaDfxPtr, dfxLength, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        }
        IDE_LOGI("The dfx type[%" PRIu16 "], dfx length[%" PRIu16 "]", dfxType, dfxLength);
        if (dfxType == TYPE_L0_EXCEPTION_DFX) {
            exceptionDfxPtr_ = metaDfxPtr;
            exceptionDfxSize_ = dfxLength;
        }

        if (dfxType == TYPE_L0_EXCEPTION_DFX_IS_TIK) {
            uint32_t isTik = 0;
            if (exceptionArgsInfo.exceptionKernelInfo.elfDataFlag == ELF_DATA2MSB) {
                ret = GetPointerValueByBigEndian(&metaDfxPtr, isTik, currDfxSize, metaDfxSize);
            } else {
                ret = GetPointerValueByLittleEndian(&metaDfxPtr, isTik, currDfxSize, metaDfxSize);
            }
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            isTik_ = (isTik == 1U) ? true : false;
        } else {
            metaDfxPtr += dfxLength;
            currDfxSize += dfxLength;
        }
    }

    if (exceptionDfxPtr_ == nullptr || exceptionDfxSize_ == 0) {
        IDE_LOGE("No exception dfx info, dfxAddr[%p]|dfxSize[%" PRIu16 "].", exceptionDfxPtr_, exceptionDfxSize_);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsInfoWithDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    if (exceptionArgsInfo.argAddr == nullptr || exceptionArgsInfo.argsize == 0 ||
        exceptionArgsInfo.exceptionKernelInfo.dfxAddr == nullptr ||
        exceptionArgsInfo.exceptionKernelInfo.dfxSize == 0) {
        IDE_LOGE("In argAddr[%p]|argSize[%u]|dfxAddr[%p]|dfxSize[%u] has invalid attribute.",
                 exceptionArgsInfo.argAddr, exceptionArgsInfo.argsize, exceptionArgsInfo.exceptionKernelInfo.dfxAddr,
                 exceptionArgsInfo.exceptionKernelInfo.dfxSize);
        return ADUMP_FAILED;
    }

    argAddr_ = exceptionArgsInfo.argAddr;
    argSize_ = exceptionArgsInfo.argsize;

    // FindExceptionDfx 保留在 DumpArgs（从 meta dfx 定位 exception dfx）
    int32_t ret = FindExceptionDfx(exceptionArgsInfo);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The dfx address[%p] and dfx size[%u].", exceptionDfxPtr_, exceptionDfxSize_);

    // 使用 DfxArgsParser
    DfxArgsParser parser;
    ret = parser.Init(argAddr_, argSize_, exceptionDfxPtr_, exceptionDfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    parser.SetIsTik(isTik_);
    ret = parser.InitTensorModeInfo();
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    ret = parser.ParseAll();
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    // 获取解析结果
    tensorBuffer_ = parser.GetTensors();
    workspace_ = parser.GetWorkspaces();
    mc2Space_ = parser.GetMc2Space();
    logRecord_ = parser.GetLogRecords();

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsInfoWithSizeInfo(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                                           const rtExceptionExpandInfo_t &exceptionExpandInfo)
{
    if (CheckParam(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    if (InitAttributes(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    uint32_t maxArgNum = argSize_ / sizeof(uint64_t);
    if (static_cast<uint64_t>(skipNum_) + inputNum_ > maxArgNum) {
        IDE_LOGE("[Dump][Exception] skip num[%" PRIu32 "] plus input num[%" PRIu32 "] is over the max arg num[%" PRIu32
                 "], load failed.",
                 skipNum_, inputNum_, maxArgNum);
        return ADUMP_FAILED;
    }

    auto data = DumpMemory::CopyDeviceToHostEx(argAddr_, argSize_);
    if (data == nullptr) {
        IDE_LOGE("Copy device args to host failed.");
        return ADUMP_FAILED;
    }
    const void **argOnHost = static_cast<const void **>(data);
    if (exceptionExpandInfo.type == RT_EXCEPTION_FFTS_PLUS) {
        LogArgsInfo(argOnHost, maxArgNum);
    }

    uint32_t argIndex = skipNum_;
    IDE_LOGE("[Dump][Exception] the begin tensor's index of args is:%" PRIu32 ", args dump count[%" PRIu32 "]",
             argIndex, inputNum_);
    for (uint64_t sizeInfoIdx = sizeBeginIndex_; sizeInfoIdx < inputNum_ + sizeBeginIndex_; ++sizeInfoIdx) {
        int64_t size = *(reinterpret_cast<int64_t *>(&sizeInfo_[sizeInfoIdx]));
        // the size of the level-2 pointer is a negative number in earlier versions.
        if (size < 0) {
            size = std::abs(size);
            if (size > maxArgNum) {
                IDE_LOGE("[Dump][Exception] size[%" PRId64 "] over arg max[%" PRIu32 "] is invalid, load failed.", size,
                         maxArgNum);
                HOST_RT_MEMORY_GUARD(data);
                return ADUMP_FAILED;
            }
            sizeInfoIdx += size;
        } else {
            int32_t ret = LoadInputBuffer(argOnHost, argIndex, sizeInfoIdx);
            if (ret != ADUMP_SUCCESS) {
                HOST_RT_MEMORY_GUARD(data);
                return ADUMP_FAILED;
            }
        }
        argIndex++;
    }
    LoadTilingData();
    HOST_RT_MEMORY_GUARD(data);

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsExceptionInfo(const rtExceptionInfo &exception)
{
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    rtExceptionExpandInfo_t exceptionExpandInfo = exception.expandInfo;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGE("Get exception args info failed.");
        return ADUMP_FAILED;
    }
    kernelCollector_->LoadKernelInfo(exceptionArgsInfo);

    if (LoadArgsInfoWithDfx(exceptionArgsInfo) == ADUMP_SUCCESS) {
        dumpWithDfxFlag_ = true;
    } else {
        IDE_LOGI("Can not load args info with dfx, use load args info with size info instead of it.");
        if (LoadArgsInfoWithSizeInfo(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
    }

    streamId_ = std::to_string(exception.streamid);
    taskId_ = std::to_string(exception.taskid);

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::CheckParam(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                             const rtExceptionExpandInfo_t &exceptionExpandInfo) const
{
    // Except the aic/aiv error, other exceptions are also called back. Therefore, warning logs are generated here.
    if (exceptionArgsInfo.sizeInfo.infoAddr == nullptr || exceptionArgsInfo.sizeInfo.atomicIndex == 0 ||
        exceptionArgsInfo.argAddr == nullptr) {
        IDE_LOGW("[Dump][Exception] in infoAddr[%p]|atomicIndex[%" PRIu32 "]|argAddr[%p] has invalid attribute.",
                 exceptionArgsInfo.sizeInfo.infoAddr, exceptionArgsInfo.sizeInfo.atomicIndex,
                 exceptionArgsInfo.argAddr);
        return ADUMP_FAILED;
    }
    // RT_EXCEPTION_AICORE indicates the normal mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_AICORE && exceptionArgsInfo.argsize == 0) {
        IDE_LOGW("[Dump][Exception] the arg size[%" PRIu32 "] is invalid.", exceptionArgsInfo.argsize);
        return ADUMP_FAILED;
    }

    uint64_t *sizeInfo = static_cast<uint64_t *>(exceptionArgsInfo.sizeInfo.infoAddr);
    if (sizeInfo < g_chunk || sizeInfo > (g_chunk + RING_CHUNK_SIZE - 1)) {
        IDE_LOGE("[Dump][Exception] the size info[%p] address may out of the chunk[%p] address range.", sizeInfo,
                 g_chunk);
        return ADUMP_FAILED;
    }
    if (sizeInfo[0] != exceptionArgsInfo.sizeInfo.atomicIndex) {
        IDE_LOGE("[Dump][Exception] args exception atomic index between %" PRIu64 " and %" PRIu32 " is different.",
                 sizeInfo[0], exceptionArgsInfo.sizeInfo.atomicIndex);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::InitAttributes(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                                 const rtExceptionExpandInfo_t &exceptionExpandInfo)
{
    sizeInfo_ = static_cast<uint64_t *>(exceptionArgsInfo.sizeInfo.infoAddr);
    argAddr_ = exceptionArgsInfo.argAddr;

    // RT_EXCEPTION_AICORE indicates the normal mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_AICORE) {
        sizeBeginIndex_ = ATOMIC_AND_INPUT_NUM_OFFSET;
        skipNum_ = (sizeInfo_[1] & SKIP_NUM_MASK) >> SKIP_NUM_SHIFT_BITS;
        inputNum_ = sizeInfo_[1] & INPUT_NUM_MASK;
        if (sizeInfo_ + inputNum_ + ATOMIC_AND_INPUT_NUM_OFFSET > g_chunk + RING_CHUNK_SIZE + MAX_TENSOR_NUM) {
            IDE_LOGE("[Dump][Exception] the value of size info[%p] plus input num[%" PRIu32
                     "] may exceed the chunk[%p] address range.",
                     sizeInfo_, inputNum_, g_chunk);
            return ADUMP_FAILED;
        }
        argSize_ = exceptionArgsInfo.argsize;
        return ADUMP_SUCCESS;
    }

    // RT_EXCEPTION_FFTS_PLUS indicates the ffts+ mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_FFTS_PLUS) {
        uint64_t totalContextSizeNum = sizeInfo_[1];
        if (sizeInfo_ + totalContextSizeNum + ATOMIC_AND_INPUT_NUM_OFFSET >
            g_chunk + RING_CHUNK_SIZE + MAX_TENSOR_NUM) {
            IDE_LOGE("[Dump][Exception] the value of size info[%p] plus total num[%" PRIu64
                     "] may exceed the chunk[%p] address range.",
                     sizeInfo_, totalContextSizeNum, g_chunk);
            return ADUMP_FAILED;
        }
        uint32_t contextBeginIndex = ATOMIC_AND_INPUT_NUM_OFFSET;
        for (uint64_t sizeInfoIdx = contextBeginIndex; sizeInfoIdx < totalContextSizeNum + contextBeginIndex;
             ++sizeInfoIdx) {
            uint32_t inputNumBeginIndex = sizeInfoIdx + CONTEXTID_AND_INPUT_NUM_OFFSET;
            skipNum_ = (sizeInfo_[inputNumBeginIndex] & SKIP_NUM_MASK) >> SKIP_NUM_SHIFT_BITS;
            inputNum_ = sizeInfo_[inputNumBeginIndex] & INPUT_NUM_MASK;
            IDE_LOGI("[Dump][Exception] the context id[%" PRIu64 "] of size info and context id[%" PRIu16
                     "] of exception info",
                     sizeInfo_[sizeInfoIdx], exceptionExpandInfo.u.fftsPlusInfo.contextId);
            if (sizeInfo_[sizeInfoIdx] == exceptionExpandInfo.u.fftsPlusInfo.contextId) {
                argSize_ = sizeInfo_[sizeInfoIdx + 1];
                sizeBeginIndex_ = sizeInfoIdx + 3;  // 3 - context id | args size | input num
                return ADUMP_SUCCESS;
            }
            sizeInfoIdx += inputNum_ + CONTEXTID_AND_INPUT_NUM_OFFSET;
        }
    }

    // log warning - the arg data in ffts+ mode may be in others contextid
    IDE_LOGW("Data mismatch, some attribute values cannot be obtained.");
    return ADUMP_FAILED;
}

void DumpArgs::LogArgsInfo(const void **argOnHost, uint32_t maxArgNum)
{
    const uint32_t argsLogTimes = (maxArgNum % ARGS_PER_STRING_MAX_LEN > 0) ?
                                      ((maxArgNum / ARGS_PER_STRING_MAX_LEN) + 1) :
                                      (maxArgNum / ARGS_PER_STRING_MAX_LEN);
    for (uint32_t i = 1; i <= argsLogTimes; ++i) {
        std::stringstream ss;
        uint32_t endIndex = maxArgNum > (i * ARGS_PER_STRING_MAX_LEN) ? (i * ARGS_PER_STRING_MAX_LEN) : maxArgNum;
        for (uint32_t j = (i - 1) * ARGS_PER_STRING_MAX_LEN; j < endIndex; ++j) {
            ss << *(argOnHost + j) << ", ";
        }
        oss_ << "[AIC_INFO] args(" << (i - 1) * ARGS_PER_STRING_MAX_LEN << " to " << endIndex
             << ") after execute:" << ss.str().c_str();
        RecordCurrentLog();
    }
    IDE_LOGE("[AIC_INFO] after execute:args print end");
}

int32_t DumpArgs::LoadInputBuffer(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx)
{
    uint8_t sizeType = (sizeInfo_[sizeInfoIdx] & SIZE_TYPE_MASK) >> SIZE_TYPE_SHIFT_BITS;
    if (sizeType == NORMAL_TENSOR || sizeType == WORKSPACE_TENSOR) {
        oss_ << "[Dump][Exception] begin to load normal tensor, index:" << argIndex;
        RecordCurrentLog();
        uint64_t tensorSize = sizeInfo_[sizeInfoIdx] & SIZE_MASK;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << argOnHost[argIndex]
             << "; size:" << tensorSize << " bytes";
        RecordCurrentLog();
        inputBuffer_.emplace_back(argOnHost[argIndex], tensorSize, argIndex);
        oss_ << "[Dump][Exception] end to load normal tensor, index:" << argIndex;
        RecordCurrentLog();
    } else if (sizeType == NORMAL_PTR_TENSOR || sizeType == SHAPE_PTR_TENSOR) {
        if (LoadPointerTensor(argOnHost, argIndex, sizeInfoIdx) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
    } else if (sizeType == TILING_DATA_PTR) {
        IDE_LOGE("[Dump][Exception] save tiling data, index:%" PRIu32, argIndex);
        tilingData_.emplace_back(argOnHost[argIndex], (sizeInfo_[sizeInfoIdx] & SIZE_MASK), argIndex);
    } else {
        IDE_LOGE("[Dump][Exception] args exception size type[%" PRIu8 "] is error.", sizeType);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadPointerTensor(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx)
{
    uint64_t addrBias = reinterpret_cast<uint64_t>(argOnHost[argIndex]) - reinterpret_cast<uint64_t>(argAddr_);
    if (addrBias >= argSize_) {
        IDE_LOGE("[Dump][Exception]address bias[%p - %p] is over args size[%" PRIu64 "], invalid.", argOnHost[argIndex],
                 argAddr_, argSize_);
        return ADUMP_FAILED;
    }

    uint64_t inputPtrAddr = addrBias + reinterpret_cast<uint64_t>(argOnHost);
    void *inputPtr = nullptr;
    std::string pointerType = "";
    uint8_t sizeType = (sizeInfo_[sizeInfoIdx] & SIZE_TYPE_MASK) >> SIZE_TYPE_SHIFT_BITS;
    if (sizeType == NORMAL_PTR_TENSOR) {
        inputPtr = reinterpret_cast<void *>(inputPtrAddr);
        pointerType = "normal pointer tensor";
    } else if (sizeType == SHAPE_PTR_TENSOR) {
        uint64_t offset = *(reinterpret_cast<uint64_t *>(inputPtrAddr));
        inputPtr = reinterpret_cast<void *>(inputPtrAddr + offset);
        pointerType = "shape pointer tensor";
    } else {
        IDE_LOGE("[Dump][Exception] args exception size type[%" PRIu8 "] is error.", sizeType);
        return ADUMP_FAILED;
    }

    IDE_LOGE("[Dump][Exception] begin to load %s, index:%" PRIu32 ", addr:%p", pointerType.c_str(), argIndex,
             argOnHost[argIndex]);

    const void **endArgAddr = argOnHost + argSize_ / sizeof(uint64_t);
    uint64_t inputPtrNum = sizeInfo_[sizeInfoIdx] & SIZE_MASK;
    for (uint64_t i = 0; i < inputPtrNum; ++i) {
        uint64_t inputPtrSize = sizeInfo_[sizeInfoIdx + 1 + i];
        void **tensorPtr = static_cast<void **>(inputPtr) + i;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << *(tensorPtr) << "; size:" << inputPtrSize
             << " bytes";
        RecordCurrentLog();
        if (tensorPtr > endArgAddr) {
            IDE_LOGE("[Dump][Exception] args address[%p] is over args end address[%p].", tensorPtr, endArgAddr);
            return ADUMP_FAILED;
        }
        inputBuffer_.emplace_back(*(tensorPtr), inputPtrSize, argIndex);
    }
    sizeInfoIdx += inputPtrNum;

    IDE_LOGE("[Dump][Exception] end to load %s, index:%" PRIu32 ", addr:%p", pointerType.c_str(), argIndex,
             argOnHost[argIndex]);

    return ADUMP_SUCCESS;
}

void DumpArgs::LoadTilingData()
{
    if (tilingData_.size() == 0) {
        return;
    }
    IDE_LOGE("[Dump][Exception] begin to load tiling data.");
    for (const auto &it : tilingData_) {
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << it.addr << "; size:" << it.length
             << " bytes";
        RecordCurrentLog();
        inputBuffer_.emplace_back(it.addr, it.length, it.argIndex);
    }
    IDE_LOGE("[Dump][Exception] end to load tiling data.");
}

int32_t DumpArgs::DumpArgsExceptionFile(const uint32_t deviceId, const std::string &dumpPath)
{
    std::string dumpFilePath = GetDumpFilePath(dumpPath);
    IDE_LOGI("[Dump][Exception] The exception dump file path is %s", dumpFilePath.c_str());

    DumpFile dumpFile(deviceId, dumpFilePath);
    dumpFile.SetHeader("");
    if (dumpWithDfxFlag_) {
        dumpFile.SetTensorBuffer(tensorBuffer_);
        dumpFile.SetWorkspaces(workspace_);
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
        dumpFile.SetMc2spaces(mc2Space_);
#endif
    } else {
        dumpFile.SetInputBuffer(inputBuffer_);
    }
    AdxLogFlush();
    int32_t ret = dumpFile.Dump(logRecord_);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("[Dump][Exception] write exception to file failed, file: %s", dumpFilePath.c_str());
        return ADUMP_FAILED;
    }

    (void)mmChmod(dumpFilePath.c_str(), M_IRUSR);  // readonly, 400
    IDE_LOGE("[Dump][Exception] dump exception to file, file: %s", dumpFilePath.c_str());

    IDE_LOGI("[Dump][Exception] Dump exception info success.");
    return ADUMP_SUCCESS;
}

int32_t DumpArgs::DumpArgsExceptionInfo(const uint32_t deviceId, const std::string &dumpPath)
{
    int32_t ret = ADUMP_SUCCESS;
    if (DumpArgsExceptionFile(deviceId, dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    if (StartCollectKernelAsync(kernelCollector_, dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    return ret;
}

std::string DumpArgs::GetDumpFilePath(const std::string &dumpPath) const
{
    std::string opType = "exception_info";
    std::string dumpFileName =
        opType + "." + streamId_ + "." + taskId_ + "." + SysUtils::GetCurrentTimeWithMillisecond();
    Path dumpFilePath(dumpPath);
    dumpFilePath.Concat(dumpFileName);
    dumpFilePath.RealPath();
    return dumpFilePath.GetString();
}

void DumpArgs::RecordCurrentLog()
{
    IDE_LOGE("%s", oss_.str().c_str());
    logRecord_.emplace_back(oss_.str() + "\n");
    oss_.str("");
}

bool DumpArgs::DumpArgsDumpWithDfxFlag() const
{
    return dumpWithDfxFlag_;
}

const std::vector<InputBuffer> &DumpArgs::DumpArgsGetInputBuffer() const
{
    return inputBuffer_;
}

const std::vector<TensorBuffer> &DumpArgs::DumpArgsGetTensorBuffer() const
{
    return tensorBuffer_;
}

const std::vector<DumpWorkspace> &DumpArgs::DumpArgsGetWorkSpace() const
{
    return workspace_;
}

}  // namespace Adx