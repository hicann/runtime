/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TRANSPORT_UPLOADER_MGR_H
#define ANALYSIS_DVVP_TRANSPORT_UPLOADER_MGR_H

#include <atomic>
#include "config/config.h"
#include "message/prof_params.h"
#include "singleton/singleton.h"
#include "uploader.h"
#include "prof_common.h"

namespace analysis {
namespace dvvp {
namespace transport {
constexpr uint32_t WAIT_CLEAR_UPLOADER_TIME = 20000; // 20ms
struct FileDataParams {
    std::string fileName;
    bool isLastChunk;
    analysis::dvvp::common::config::FileChunkDataModule mode;
    FileDataParams(const std::string &fileNameStr,
                   bool isLastChunkB,
                   analysis::dvvp::common::config::FileChunkDataModule modeE)
        : fileName(fileNameStr), isLastChunk(isLastChunkB), mode(modeE)
    {
    }
};
class UploaderMgr : public analysis::dvvp::common::singleton::Singleton<UploaderMgr> {
public:
    UploaderMgr();
    ~UploaderMgr() override;

    int32_t Init() const;
    int32_t Uninit();

    int32_t CreateUploader(const std::string &id, SHARED_PTR_ALIA<ITransport> transport,
        size_t queueSize = analysis::dvvp::common::config::UPLOADER_QUEUE_CAPACITY);
    void AddUploader(const std::string &id, SHARED_PTR_ALIA<Uploader> uploader);
    void GetUploader(const std::string &id, SHARED_PTR_ALIA<Uploader> &uploader);
    void DelUploader(const std::string &id);
    void DelAllUploader();
    void SetAllUploaderTransportStopped();
    int32_t SetAllUploaderRegisterPipeTransportCallback(MsprofRawDataCallback callback);
    int32_t SetAllUploaderUnRegisterPipeTransportCallback();
    void RegisterAllUploaderTransportGenHashIdFuncPtr(HashDataGenIdFuncPtr* ptr);

    int32_t UploadData(const std::string &id, CONST_VOID_PTR data, uint32_t dataLen);
    int32_t UploadData(const std::string &id, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    int32_t UploadCtrlFileData(const std::string &id,
                       const std::string &data,
                       const struct FileDataParams &fileDataParams,
                       SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx) const;
    void AddMapByDevIdMode(int32_t devId, const std::string &mode, const std::string &jobId);
    std::string GetJobId(int32_t devId, const std::string &mode);
    void SetUploadDataIfStart(bool ifStart);

private:
    bool IsUploadDataStart(const std::string &dataDeviceId, const std::string &dataFileName);

private:
    std::map<std::string, SHARED_PTR_ALIA<Uploader>> uploaderMap_;
    std::mutex uploaderMutex_;
    std::map<std::string, std::string> devModeJobMap_;
    std::atomic<bool> isUploadStart_{true};
};
}
}
}
#endif

