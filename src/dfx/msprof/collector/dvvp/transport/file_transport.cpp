/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_transport.h"
#include "hash_data.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "osal.h"
#include "msprof_dlog.h"
#include "securec.h"
#include "aprof_pub.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;

FILETransport::FILETransport(const std::string &storageDir, const std::string &storageLimit)
    : fileSlice_(nullptr), storageDir_(storageDir), storageLimit_(storageLimit), needSlice_(true), stopped_(false),
    parseStr2IdStart_(false), hashDataGenIdFuncPtr_(nullptr)
{
}

FILETransport::~FILETransport()
{
}

int32_t FILETransport::Init()
{
    const int32_t sliceFileMaxKbyte = 2048; // size is about 2MB per file
    MSVP_MAKE_SHARED3(fileSlice_, FileSlice, sliceFileMaxKbyte, storageDir_, storageLimit_, return PROFILING_FAILED);
    if (fileSlice_->Init(needSlice_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("file slice init failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void FILETransport::SetAbility(bool needSlice)
{
    needSlice_ = needSlice;
}

void FILETransport::WriteDone()
{
    fileSlice_->FileSliceFlush();
}

int32_t FILETransport::SendBuffer(CONST_VOID_PTR /* buffer */, int32_t /* length */)
{
    MSPROF_LOGW("No need to send buffer");
    return 0;
}

int32_t FILETransport::SendBuffer(
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGW("Unable to parse fileChunkReq");
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGD("FileChunk filename:%s, module:%d",
        fileChunkReq->fileName.c_str(), fileChunkReq->chunkModule);
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_DEVICE ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST) {
        if (fileChunkReq->extraInfo.empty()) {
            MSPROF_LOGE("FileChunk info is empty in SendBuffer.");
            return PROFILING_FAILED;
        }
        if (fileChunkReq->fileName.find("adprof.data") != std::string::npos) {
            return ParseTlvChunk(fileChunkReq);
        }
        if (stopped_ && fileChunkReq->fileName.find("aicpu.data") != std::string::npos) {
            if (ParseStr2IdChunk(fileChunkReq) == PROFILING_SUCCESS) {
                return PROFILING_SUCCESS;
            }
        }
        std::string devId = Utils::GetInfoSuffix(fileChunkReq->extraInfo);
        std::string jobId = Utils::GetInfoPrefix(fileChunkReq->extraInfo);
        if (UpdateFileName(fileChunkReq, devId) != PROFILING_SUCCESS) {
            if (jobId.compare("64") == 0) {
                return PROFILING_SUCCESS;
            }
            MSPROF_LOGE("Failed to update file name");
            return PROFILING_FAILED;
        }
    }
    int32_t ret = fileSlice_->SaveDataToLocalFiles(fileChunkReq, storageDir_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("write data to local files failed, fileName: %s", fileChunkReq->fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t FILETransport::CloseSession()
{
    return PROFILING_SUCCESS;
}

int32_t FILETransport::UpdateFileName(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
    const std::string &devId) const
{
    std::string fileName = fileChunkReq->fileName;
    const size_t pos = fileName.find_last_of("/\\");
    if (pos != std::string::npos && pos + 1 < fileName.length()) {
        fileName = fileName.substr(pos + 1, fileName.length());
    }

    std::string tag = Utils::GetInfoSuffix(fileName);
    std::string fileNameOri = Utils::GetInfoPrefix(fileName);
    if (fileChunkReq->chunkModule != FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST) {
        uint32_t deviceId = 0;
        if (!Utils::StrToUint32(deviceId, devId) || deviceId >= DEFAULT_HOST_ID) {
            MSPROF_LOGW("dev_id is not valid: %s.", devId.c_str());
            return PROFILING_FAILED;
        }
        if (tag.length() == 0 || tag == "null") {
            fileName = fileNameOri.append(".").append(devId);
        } else {
            fileName = fileName.append(".").append(devId);
        }
    } else {
        if (tag.length() == 0 || tag == "null") {
            fileName = fileNameOri;
        }
    }
    fileChunkReq->fileName = "data" + std::string(MSVP_SLASH) + fileName;
    return PROFILING_SUCCESS;
}

/**
 * @brief parse data block that contains multiple tlv chunk for adprof, and save to target file
 * @param [in] fileChunkReq: ProfileFileChunk type shared_ptr
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t FILETransport::ParseTlvChunk(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunk->extraInfo = fileChunkReq->extraInfo;

    const uint32_t structSize = sizeof(ProfTlv);
    const char *data = fileChunkReq->chunk.data();
    std::string &fileName = fileChunkReq->fileName;

    // If there is cached data, some data in front of the chunk belongs to the previous chunk.
    if (channelBuffer_.find(fileName) != channelBuffer_.end() && channelBuffer_[fileName].size() != 0 &&
        channelBuffer_[fileName].size() < structSize) {
        const uint32_t prevDataSize = channelBuffer_[fileName].size();
        const uint32_t leftDataSize = structSize - prevDataSize;
        if (fileChunkReq->chunkSize < leftDataSize) {
            MSPROF_LOGE("fileChunk size smaller than expected, expected minimum size %u, received size %zu",
                leftDataSize, fileChunkReq->chunkSize);
            return PROFILING_FAILED;
        }
        channelBuffer_[fileName].append(data, leftDataSize);
        if (SaveChunk(channelBuffer_[fileName].data(), fileChunk) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        channelBuffer_[fileName].clear();
        data += leftDataSize;
        fileChunkReq->chunkSize -= leftDataSize;
    }

    // Store complete struct
    const uint32_t structNum = fileChunkReq->chunkSize / structSize;
    for (uint32_t i = 0; i < structNum; ++i) {
        if (SaveChunk(data, fileChunk) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        data += structSize;
    }

    // Cache last truncated struct data
    const uint32_t dataLeft = fileChunkReq->chunkSize - structNum * structSize;
    if (dataLeft != 0) {
        MSPROF_LOGI("Cache truncated data, fileName: %s, cache size: %u", fileName.c_str(), dataLeft);
        channelBuffer_[fileName].reserve(structSize + 1);
        channelBuffer_[fileName].append(data, dataLeft);
    }

    return PROFILING_SUCCESS;
}

void FILETransport::AddHashData(const std::string& input) const{
    if (hashDataGenIdFuncPtr_ == nullptr) {
        MSPROF_LOGE("hashDataGenIdFuncPtr_ is null");
        return;
    }
    std::stringstream ss(input);
    std::string item;
    uint32_t cnt = 0;
    uint32_t totalSize = 0;
    while (std::getline(ss, item, STR2ID_DELIMITER[0])) {
        size_t pos = item.find_last_not_of('\0');
        if (pos != std::string::npos) {
            item.erase(pos + 1);
        }
        uint64_t uid = hashDataGenIdFuncPtr_(item);
        MSPROF_LOGD("Add str2id:%s(size:%zuB) uid:%llu from adprof into hash data ",
            item.c_str(), item.size(), uid);
        cnt += 1;
        totalSize += item.size();
    }
    MSPROF_LOGD("Total add str2id keys:%d size:%dB", cnt, totalSize);
}

// 取一条 MsprofAdditionalInfo.data[] 中的有效 ASCII payload (clamp 到 dataLen，剔尾部 NUL)
std::string ExtractStructPayload(const MsprofAdditionalInfo &info)
{
    uint32_t len = std::min<uint32_t>(info.dataLen, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    return std::string(reinterpret_cast<const char *>(info.data), len);
}

// 在 infos[0..count) 里按 struct 顺序找首条含 mark 的 struct。
// 返回 struct 索引；命中时 offAfterMark 出参被设为 mark 末尾在该 struct data[] 内的偏移
// (用于剥掉 mark 自身)。未命中返回 count。
size_t LocateStr2IdMark(const MsprofAdditionalInfo *infos, size_t count, const std::string &mark,
    size_t &offAfterMark)
{
    for (size_t i = 0; i < count; ++i) {
        std::string payload = ExtractStructPayload(infos[i]);
        size_t pos = payload.find(mark);
        if (pos != std::string::npos) {
            offAfterMark = pos + mark.size();
            return i;
        }
    }
    return count;
}

// 判断 [data, data+len) 是否全部是可打印 ASCII (0x20-0x7E)。aicpu data 残留通常含 NUL/0x5A5A
// magic/任意高位字节，不会通过此校验，由此把误混入 hash 流的 aicpu 二进制段筛掉。
bool IsPrintableAsciiPayload(const char *data, size_t len)
{
    for (size_t i = 0; i < len; ++i) {
        auto uc = static_cast<unsigned char>(data[i]);
        if (uc < 0x20 || uc > 0x7E) {
            return false;
        }
    }
    return true;
}

// 从 infos[startIdx].data[startOff] 起按 struct 边界拼出 hash payload；其余 struct 从 data[0]
// 起。每条 struct 取出的 payload 必须非空且全可打印 ASCII，否则告警并跳过 (防御 producer 侧并发
// 把 aicpu data 混进 hash 流的场景)。跨 struct 边界补 STR2ID_DELIMITER：producer 切新 struct
// 时不写 ','，consumer 补回来，否则下游按 ',' 切分会把前后 struct 的 key 粘成一个。
std::string ConcatHashPayload(const MsprofAdditionalInfo *infos, size_t startIdx, size_t count,
    size_t startOff)
{
    std::string after;
    after.reserve((count - startIdx) * MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    for (size_t i = startIdx; i < count; ++i) {
        std::string payload = ExtractStructPayload(infos[i]);
        size_t off = (i == startIdx) ? startOff : 0;
        if (off >= payload.size()) {
            MSPROF_LOGW("Str2id struct[%zu] payload empty after off=%zu, skip", i, off);
            break;
        }
        const char *segData = payload.data() + off;
        size_t segLen = payload.size() - off;
        if (!IsPrintableAsciiPayload(segData, segLen)) {
            MSPROF_LOGW("Str2id struct[%zu] payload non-ascii (len=%zuB), skip", i, segLen);
            continue;
        }
        if (!after.empty()) {
            after.append(STR2ID_DELIMITER);
        }
        after.append(segData, segLen);
    }
    return after;
}

/**
 * @brief 解析 aicpu 通道回传的 chunk，从中抽取 device 侧 hash payload 注册到 HashData。
 *
 * 输入 chunk 必为 MsprofAdditionalInfo[N] (256B/struct) 紧密拼接的二进制流。首次匹配到
 * "###drv_hashdata###" mark 后将 parseStr2IdStart_ 置位；mark 之前的 struct 视为 aicpu data
 * 残留留在 chunk 里供上游落盘，mark 之后的 struct 用 ConcatHashPayload 拼出 ASCII 喂给
 * AddHashData。续段 chunk (parseStr2IdStart_ 已为 true) 整段都是 hash payload，从 struct 0 起拼。
 *
 * @return SUCCESS: chunk 已被完整消费 (无 aicpu 残留)；FAILED: 含 aicpu 残留或异常输入
 */
int32_t FILETransport::ParseStr2IdChunk(const SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    constexpr size_t infoSize = sizeof(MsprofAdditionalInfo);

    if (fileChunkReq == nullptr) {
        MSPROF_LOGW("Unable to parse fileChunkReq");
        return parseStr2IdStart_ ? PROFILING_SUCCESS : PROFILING_FAILED;
    }
    auto &chunk = fileChunkReq->chunk;
    if (chunk.empty() || chunk.size() % infoSize != 0) {
        MSPROF_LOGW("Str2id chunk size:%zuB invalid (must be non-zero multiple of %zuB)",
            chunk.size(), infoSize);
        return parseStr2IdStart_ ? PROFILING_SUCCESS : PROFILING_FAILED;
    }

    const auto *infos = reinterpret_cast<const MsprofAdditionalInfo *>(chunk.data());
    const size_t structCount = chunk.size() / infoSize;

    // 定位 hash payload 起点 (struct idx + struct 内 data[] off)：
    //   - 续段 (parseStr2IdStart_=true)：整段 chunk 都是 hash，从 (0, 0) 起。
    //   - 首次：扫 mark；未命中说明整段都是 aicpu data，交上游落盘。
    size_t hashStartIdx = 0;
    size_t hashStartOff = 0;
    if (!parseStr2IdStart_) {
        hashStartIdx = LocateStr2IdMark(infos, structCount, STR2ID_MARK, hashStartOff);
        if (hashStartIdx == structCount) {
            MSPROF_LOGD("Not found drv str2id mark, total chunk size:%zuB struct count:%zu",
                chunk.size(), structCount);
            return PROFILING_FAILED;
        }
        parseStr2IdStart_ = true;
        MSPROF_LOGI("Found drv str2id mark at struct[%zu](total:%zu) off[%zu]",
            hashStartIdx, structCount, hashStartOff);
    }

    AddHashData(ConcatHashPayload(infos, hashStartIdx, structCount, hashStartOff));

    // 截短 chunk 为 mark 前的 aicpu 残留：纯 hash chunk → 空 → SUCCESS；含残留 → FAILED 走 fileSlice_。
    size_t totalSize = chunk.size();
    chunk.resize(hashStartIdx * infoSize);
    fileChunkReq->chunkSize = chunk.size();
    MSPROF_LOGD("Str2id chunk consumed, total size:%zuB, aicpu residue size:%zuB", totalSize, chunk.size());
    return chunk.empty() ? PROFILING_SUCCESS : PROFILING_FAILED;
}

/**
 * @brief save ProfileFileChunk to local file
 * @param [in] data: struct data pointer
 * @param [in] fileChunk: ProfileFileChunk type shared_ptr
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t FILETransport::SaveChunk(const char *data, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const
{
    FUNRET_CHECK_EXPR_ACTION_LOGW(data == nullptr, return PROFILING_SUCCESS,
        "Unable to parse struct data, pointer is null");

    const ProfTlv *packet = reinterpret_cast<const ProfTlv *>(data);
    if (packet->head != TLV_HEAD) {
        MSPROF_LOGE("Check tlv head failed");
        return PROFILING_FAILED;
    }

    if (packet->len > TLV_VALUE_MAX_LEN) {
        MSPROF_LOGE("Invalid packet len: %u, max: %u", packet->len, TLV_VALUE_MAX_LEN);
        return PROFILING_FAILED;
    }

    const ProfTlvValue *tlvValue = reinterpret_cast<const ProfTlvValue *>(packet->value);

    if (tlvValue->chunkSize > TLV_VALUE_CHUNK_MAX_LEN) {
        MSPROF_LOGE("Invalid chunkSize: %zu, max: %u", tlvValue->chunkSize, TLV_VALUE_CHUNK_MAX_LEN);
        return PROFILING_FAILED;
    }

    fileChunk->isLastChunk = tlvValue->isLastChunk;
    fileChunk->chunkModule = tlvValue->chunkModule;
    fileChunk->chunkSize = tlvValue->chunkSize;
    fileChunk->offset = tlvValue->offset;
    fileChunk->chunk = std::string(tlvValue->chunk, tlvValue->chunkSize);
    fileChunk->fileName = std::string(tlvValue->fileName, strnlen(tlvValue->fileName, TLV_VALUE_FILENAME_MAX_LEN));

    std::string jobId = Utils::GetInfoPrefix(fileChunk->extraInfo);
    std::string devId = Utils::GetInfoSuffix(fileChunk->extraInfo);
    if (UpdateFileName(fileChunk, devId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to update file name");
        return PROFILING_FAILED;
    }

    if (fileSlice_->SaveDataToLocalFiles(fileChunk, storageDir_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("write data to local files failed, fileName: %s", fileChunk->fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<ITransport> FileTransportFactory::CreateFileTransport(
    const std::string &storageDir, const std::string &storageLimit, bool needSlice) const
{
    SHARED_PTR_ALIA<FILETransport> fileTransport;
    MSVP_MAKE_SHARED2(fileTransport, FILETransport, storageDir, storageLimit, return fileTransport);
    MSVP_MAKE_SHARED2(fileTransport->perfCount_, PerfCount, FILE_PERFCOUNT_MODULE_NAME,
        TRANSPORT_PRI_FREQ, return nullptr);
    fileTransport->SetAbility(needSlice);

    if (fileTransport->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("fileTransport init failed");
        MSPROF_INNER_ERROR("EK9999", "fileTransport init failed");
        return nullptr;
    }
    return fileTransport;
}

void FILETransport::SetStopped()
{
    stopped_ = true;
}

void FILETransport::RegisterHashDataGenIdFuncPtr(HashDataGenIdFuncPtr *ptr)
{
    hashDataGenIdFuncPtr_ = ptr;
}

} // namespace transport
} // namespace dvvp
} // namespace analysis
