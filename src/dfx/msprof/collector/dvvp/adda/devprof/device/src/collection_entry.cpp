/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "collection_entry.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "msprof_dlog.h"
#include "param_validation.h"
#include "prof_channel_manager.h"
#include "prof_msg_handler.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "task_relationship_mgr.h"
#include "platform/platform.h"

namespace analysis {
namespace dvvp {
namespace device {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;

CollectionEntry::CollectionEntry()
    : isInited_(false)
{
}

CollectionEntry::~CollectionEntry()
{
}

int32_t CollectionEntry::Init()
{
    MSPROF_EVENT("Begin to init Collection Entry");
    std::string deviceAppDir = analysis::dvvp::common::utils::Utils::IdeReplaceWaveWithHomedir(DEVICE_APP_DIR);
    analysis::dvvp::common::utils::Utils::RemoveDir(deviceAppDir, false);

    int32_t ret = Platform::instance()->PlatformInitByDriver();
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    isInited_ = true;
    return PROFILING_SUCCESS;
}

int32_t CollectionEntry::Uinit()
{
    MSPROF_LOGI("uinit Collection Entry.");
    if (isInited_) {
        for (auto iterJobId = receiverMap_.begin(); iterJobId != receiverMap_.end(); iterJobId++) {
            for (auto iterDevId = iterJobId->second.begin(); iterDevId != iterJobId->second.end(); iterDevId++) {
                iterDevId->second->Stop();
            }
            iterJobId->second.clear();
        }
        receiverMap_.clear();
        hostIdMap_.clear();

        (void)UploaderMgr::instance()->Uninit();

        isInited_ = false;
    }

    return PROFILING_SUCCESS;
}

int32_t CollectionEntry::Handle(SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> transport,
                            const std::string &req, int32_t devIndexId)
{
    if (!isInited_ || transport == nullptr) {
        MSPROF_LOGE("Collection Entry was not inited.");
        return PROFILING_FAILED;
    }

    analysis::dvvp::message::StatusInfo statusInfo;

    int32_t ret = PROFILING_FAILED;

    do {
        statusInfo.status = analysis::dvvp::message::ERR;

        auto message = analysis::dvvp::message::DecodeMessage(req);
        if (message == nullptr) {
            MSPROF_LOGW("Unable to decode message");
            statusInfo.info = "Failed to decode message";
            break;
        }

        auto ctrlHandshake = std::dynamic_pointer_cast<analysis::dvvp::proto::CtrlChannelHandshake>(message);
        if (ctrlHandshake != nullptr) {
            SHARED_PTR_ALIA<Receiver> receiver = nullptr;
            MSVP_MAKE_SHARED1_NODO(receiver, Receiver, transport, break);
            ret = HandleCtrlSession(receiver, ctrlHandshake, statusInfo, devIndexId);
        } else {
            auto dataHandshake = std::dynamic_pointer_cast<analysis::dvvp::proto::DataChannelHandshake>(message);
            if (dataHandshake != nullptr) {
                SHARED_PTR_ALIA<Uploader> uploader = nullptr;
                MSVP_MAKE_SHARED1_NODO(uploader, Uploader, transport, break);
                ret = HandleDataSession(uploader, dataHandshake, devIndexId);
            } else {
                statusInfo.info = "unknown message";
            }
        }
    } while (0);

    if (ret != PROFILING_SUCCESS) {
        std::string resp = analysis::dvvp::message::EncodeMessage(CreateResponse(statusInfo));

        int32_t sent = transport->SendBuffer(resp.c_str(), resp.size());
        MSPROF_LOGW("The reply handle is abnormal, dev_id=%d, statusInfo=%s, response sent size:%d, resp size:%zu",
            devIndexId, statusInfo.ToString().c_str(), sent, static_cast<int32_t>(resp.size()));
    }

    return ret;
}

int32_t CollectionEntry::HandleCtrlSession(SHARED_PTR_ALIA<Receiver> receiver,
                                       SHARED_PTR_ALIA<analysis::dvvp::proto::CtrlChannelHandshake> handshake,
                                       analysis::dvvp::message::StatusInfo &statusInfo,
                                       int32_t devIndexId)
{
    int32_t ret = PROFILING_SUCCESS;

    do {
        MSPROF_LOGI("Device %d Received ctrl handshake, devIdOnHost: %d", devIndexId, handshake->devid());
        // check last job
        std::string lastJobId = GetModeJobIdRelation(devIndexId, handshake->mode());
        if (!lastJobId.empty()) {
            auto lastReceiver = GetReceiver(lastJobId, devIndexId);
            if (lastReceiver != nullptr && !lastReceiver->IsQuit()) {
                MSPROF_LOGE("Last profiling job %s on device %u has not exited, please try again later",
                            lastJobId.c_str(), devIndexId);
                return PROFILING_FAILED;
            }
        }

        int32_t hostId = handshake->devid();
        if (!ParamValidation::instance()->CheckDeviceIdIsValid(std::to_string(hostId))) {
            MSPROF_LOGE("[HandleCtrlSession]hostId: %d is not valid!", hostId);
            return PROFILING_FAILED;
        }
        receiver->SetDevIdOnHost(hostId);
        Analysis::Dvvp::TaskHandle::TaskRelationshipMgr::instance()->AddHostIdDevIdRelationship(hostId, devIndexId);

        ret = receiver->Init(devIndexId);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to init receiver");
            statusInfo.info = "Failed to init receiver";
            break;
        }

        // ack handshake
        statusInfo.status = analysis::dvvp::message::SUCCESS;
        std::string resp = analysis::dvvp::message::EncodeMessage(CreateResponse(statusInfo));
        int32_t sent = receiver->GetTransport()->SendBuffer(resp.c_str(), resp.size());
        MSPROF_LOGI("Reply ctrl handshake, statusInfo=%s, response sent size:%d, resp size:%zu",
            statusInfo.ToString().c_str(), sent, static_cast<int32_t>(resp.size()));
        AddReceiver(handshake->mode(), handshake->jobid(), devIndexId, receiver);
        // start ctrl receiver
        receiver->SetThreadName(MSVP_CTRL_RECEIVER_THREAD_NAME);
        int32_t retCode = receiver->Start();
        if (retCode != PROFILING_SUCCESS) {
            MSPROF_LOGE("[HandleCtrlSession]Failed to start receiver thread, ret=%d", retCode);
            return retCode;
        }
        MSPROF_LOGI("Ctrl session finished, devId:%d, devIdOnHost:%d", devIndexId, hostId);
    } while (0);

    return ret;
}

int32_t CollectionEntry::HandleDataSession(SHARED_PTR_ALIA<Uploader> uploader,
                                       SHARED_PTR_ALIA<analysis::dvvp::proto::DataChannelHandshake> handshake,
                                       int32_t devIndexId)
{
    MSPROF_LOGI("Device %d Received data handshake", devIndexId);
    std::string jobID = handshake->jobid();
    if (!ParamValidation::instance()->CheckParamsJobIdRegexMatch(jobID)) {
        MSPROF_LOGE("[HandleDataSession]jobID is invalid!");
        return PROFILING_FAILED;
    }
    std::string mode = handshake->mode();
    if (!ParamValidation::instance()->CheckParamsModeRegexMatch(mode)) {
        MSPROF_LOGE("[HandleDataSession]profilingMode is invalid!");
        return PROFILING_FAILED;
    }

    if (uploader == nullptr) {
        return PROFILING_FAILED;
    }

    int32_t initRet = uploader->Init();
    if (initRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("[HandleDataSession]Failed to init uploader thread, initRet=%d", initRet);
        return initRet;
    }
    std::string uploaderName = MSVP_UPLOADER_THREAD_NAME;
    uploaderName.append("_").append(jobID);
    uploader->SetThreadName(uploaderName);
    int32_t ret = uploader->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[HandleDataSession]Failed to start uploader thread, ret=%d", ret);
        return ret;
    }
    // ack handshake
    analysis::dvvp::message::StatusInfo statusInfo;
    statusInfo.status = analysis::dvvp::message::SUCCESS;
    std::string resp = analysis::dvvp::message::EncodeMessage(CreateResponse(statusInfo));
    int32_t sent = uploader->UploadData(resp.c_str(), resp.size());

    MSPROF_LOGI("Reply data handshake, statusInfo=%s, response sent size:%d, resp size:%zu",
        statusInfo.ToString().c_str(), sent, static_cast<int32_t>(resp.size()));

    UploaderMgr::instance()->AddMapByDevIdMode(devIndexId, mode, jobID);
    UploaderMgr::instance()->AddUploader(jobID, uploader);

    return PROFILING_SUCCESS;
}

int32_t CollectionEntry::FinishCollection(uint32_t devIdFlush, const std::string &jobId)
{
    MSPROF_LOGI("Entering device(%d) FinishCollection...jobId:%s", devIdFlush, jobId.c_str());
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(jobId, uploader);

    if (uploader != nullptr) {
        MSPROF_LOGI("Release device(%d) uploader.", devIdFlush);

        // send data channel finish message
        SHARED_PTR_ALIA<analysis::dvvp::proto::DataChannelFinish> message = nullptr;
        MSVP_MAKE_SHARED0(message, analysis::dvvp::proto::DataChannelFinish, return PROFILING_FAILED);
        analysis::dvvp::message::JobContext jobCtx;
        jobCtx.dev_id = std::to_string(devIdFlush);
        jobCtx.job_id = jobId;
        message->mutable_hdr()->set_job_ctx(jobCtx.ToString());
        std::string encoded = analysis::dvvp::message::EncodeMessage(message);
        int32_t ret = uploader->UploadData(encoded.c_str(), encoded.size());
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGI("Upload data failed when collection finished");
            return ret;
        }
        uploader->Flush();

        MSPROF_LOGI("Device(%d) data session finished", devIdFlush);
    }

    MSPROF_LOGI("reset device(%d) uploader.", devIdFlush);
    UploaderMgr::instance()->DelUploader(jobId);

    MSPROF_LOGI("Device(%d) leaving finish_collection...", devIdFlush);

    return PROFILING_SUCCESS;
}

void CollectionEntry::DeleteReceiver(const std::string &jobId, uint32_t devIndexId)
{
    MSPROF_LOGI("Delete receiver jobId %s, devIndexId %d", jobId.c_str(), devIndexId);
    if (jobId.empty()) {
        return;
    }
    std::lock_guard<std::mutex> lock(receiverMtx_);
    auto mapIter = receiverMap_.find(jobId);
    if (mapIter != receiverMap_.end()) {
        auto iter = mapIter->second.find(devIndexId);
        if (iter != mapIter->second.end()) {
            mapIter->second.erase(iter);
        }
        if (mapIter->second.empty()) {
            receiverMap_.erase(mapIter);
        }
    }
}

void CollectionEntry::AddReceiver(const std::string &mode, const std::string &jobId,
                                  uint32_t devIndexId, SHARED_PTR_ALIA<Receiver> receiver)
{
    MSPROF_LOGI("mode: %s, devIndexId: %u, jobId: %s Entering AddReceiver...",
        mode.c_str(), devIndexId, jobId.c_str());
    // first remove origin receiver
    std::string lastJobId = DeleteModeJobIdRelation(devIndexId, mode);
    DeleteReceiver(lastJobId, devIndexId);

    if (receiver != nullptr) {
        std::lock_guard<std::mutex> lock(receiverMtx_);
        auto mapIter = receiverMap_.find(jobId);
        if (mapIter == receiverMap_.end()) {
            std::map<int32_t, SHARED_PTR_ALIA<Receiver>> map;
            map[devIndexId] = receiver;
            receiverMap_[jobId] = map;
        } else {
            mapIter->second[devIndexId] = receiver;
        }
        AddModeJobIdRelation(devIndexId, mode, jobId);
    }
}

SHARED_PTR_ALIA<Receiver> CollectionEntry::GetReceiver(const std::string &jobId, uint32_t devIndexId)
{
    MSPROF_LOGI("devIndexId: %u, jobId: %s Entering GetReceiver...", devIndexId, jobId.c_str());

    SHARED_PTR_ALIA<Receiver> receiver = nullptr;
    do {
        std::lock_guard<std::mutex> lock(receiverMtx_);
        auto mapIter = receiverMap_.find(jobId);
        if (mapIter == receiverMap_.end()) {
            MSPROF_LOGE("Can't find jobId: %s receiver", jobId.c_str());
            break;
        }

        auto map = mapIter->second;
        auto iter = map.find(devIndexId);
        if (iter == map.end()) {
            MSPROF_LOGE("Can't find jobId %s, devIndexId: %d receiver", jobId.c_str(), devIndexId);
            break;
        }
        receiver = iter->second;
    } while (0);

    return receiver;
}

int32_t CollectionEntry::SendMsgByDevId(const std::string &jobId, uint32_t devIndexId,
    SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    if (message == nullptr) {
        MSPROF_LOGE("[SendMsgByDevId] message is nullptr.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Send devIndexId %u Message...", devIndexId);

    SHARED_PTR_ALIA<Receiver> receiver = GetReceiver(jobId, devIndexId);

    if (receiver != nullptr) {
        return receiver->SendMessage(message);
    }

    return PROFILING_FAILED;
}

void CollectionEntry::AddModeJobIdRelation(uint32_t devId, const std::string &mode, const std::string &jobId)
{
    std::string devModeKey = std::to_string(devId) + "_" + mode;
    if (mode.empty()) {
        devModeKey += analysis::dvvp::message::PROFILING_MODE_DEF;
    }
    MSPROF_LOGI("devModeKey:%s, jobId:%s Entering AddModeJobIdRelation...", devModeKey.c_str(), jobId.c_str());
    std::lock_guard<std::mutex> lock(relatiionMtx_);
    modeJobIdRelations_[devModeKey] = jobId;
}

std::string CollectionEntry::GetModeJobIdRelation(uint32_t devId, const std::string &mode)
{
    std::string devModeKey = std::to_string(devId) + "_" + mode;
    if (mode.empty()) {
        devModeKey += analysis::dvvp::message::PROFILING_MODE_DEF;
    }
    std::lock_guard<std::mutex> lock(relatiionMtx_);
    auto iter = modeJobIdRelations_.find(devModeKey);
    if (iter != modeJobIdRelations_.end()) {
        return iter->second;
    }
    return std::string("");
}

std::string CollectionEntry::DeleteModeJobIdRelation(uint32_t devId, const std::string &mode)
{
    std::string devModeKey = std::to_string(devId) + "_" + mode;
    if (mode.empty()) {
        devModeKey += analysis::dvvp::message::PROFILING_MODE_DEF;
    }
    std::string result;
    MSPROF_LOGI("devModeKey:%s, Entering DeleteModeJobIdRelation...", devModeKey.c_str());
    std::lock_guard<std::mutex> lock(relatiionMtx_);
    auto iter = modeJobIdRelations_.find(devModeKey);
    if (iter != modeJobIdRelations_.end()) {
        result = iter->second;
        modeJobIdRelations_.erase(iter);
    }
    return result;
}
}  // namespace device
}  // namespace dvvp
}  // namespace analysis
